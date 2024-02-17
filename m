Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9E7C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 13:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9EEA87C80;
	Sat, 17 Feb 2024 14:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="F1jtg/lS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB28687E60; Sat, 17 Feb 2024 14:20:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C05CF878C6
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 14:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ab=J3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1708175991;
 bh=kMMGrNrdumB4jLhpyKVDnlgJuIia4PwoJ7nPWXE4414=;
 b=F1jtg/lSIb1t8wpI873BFsV+aeU95WgkrInFnjwCISixIjz0sAgNIpsum3dvMIxSZepJNNxMa
 LNu20yY66z4YHWqCiLO4wEnOGw7ACOwSVxRMfjE8pHs7YakRnU9BJPx/RUZm3wH98EqwJiz5h8O
 +hiWsiSMmzDOmthEVEyYQx+Y150xMeupTpT6cR8B7YWsLA52vqBm8quGdIV0mtDeMBIoW+1SfGm
 i2BqIEL6smTr4u+At7iD0cR52AcDDVB9TqQeDhiikqTiFrLXLZNGfSjnFrOxFNh8FpZ8GG3+oTu
 qV+CmuneuL65JdcT3Z5UPWNoHXG2Fqihv9erWutcu/6w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] dm: core: Fix address translation in devfdt_get_addr_index()
Date: Sat, 17 Feb 2024 13:19:41 +0000
Message-ID: <20240217131943.2472659-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65d0b275cae393c1e258a577
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

During address translation #address/size-cells props are expected to
apply to child nodes. However, devfdt_get_addr_index() incorrectly use
the parent offset of the udevice parent instead of getting the offset of
the node parent. This will work in most cases when there is only one
udevice tied to a node.

On e.g. an Orange Pi R1 Plus TLS board the dwc3-generic (parent) and
dwc3-generic-host (child) udevice is tied to the same node.

In that case both the offset and parent values end up being the same.
As a result, the #address/size-cells props intended for child nodes
incorrectly gets applied to the node itself resulting in wrong addr
being returned, 0x0 instead of 0xff600000.

The following can be seen on console:

  dwc3-generic-host usb@ff600000: this is not a DesignWare USB3 DRD Core
  dwc3-generic-host usb@ff600000: failed to initialize core

Fix this by using the offset of the parent node and not the offset to
the node the parent udevice is tied to.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
I think the following unit test dts and code should be able to detect
this issue. Not sure on how to add a test with a different dts, most
existing ones seemed to use #address/size-cells = <1>.

Please advide on how following could be turned into a proper unit test.

/dts-v1/;

/ {
	#address-cells = <2>;
	#size-cells = <2>;

	some-bus {
		compatible = "denx,u-boot-test-bus";
		reg = <0x0 0xffff0000 0x0 0x1000>;
		#address-cells = <1>;
		#size-cells = <0>;

		device@0 {
			compatible = "denx,u-boot-fdt-test";
			reg = <0>;
		};
	};
};

struct udevice *bus, *dev;

ut_assertok(uclass_get_device(UCLASS_TEST_BUS, 0, &bus));
ut_asserteq(0xffff0000, devfdt_get_addr(bus));
ut_assertok(device_bind(bus, DM_DRIVER_GET(denx_u_boot_fdt_test),
			"test", NULL, dev_ofnode(bus), &dev));
ut_asserteq(0xffff0000, devfdt_get_addr(dev));
---
 drivers/core/fdtaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/fdtaddr.c b/drivers/core/fdtaddr.c
index 8e774d49ce6e..5f27d2511485 100644
--- a/drivers/core/fdtaddr.c
+++ b/drivers/core/fdtaddr.c
@@ -23,7 +23,7 @@ fdt_addr_t devfdt_get_addr_index(const struct udevice *dev, int index)
 {
 #if CONFIG_IS_ENABLED(OF_REAL)
 	int offset = dev_of_offset(dev);
-	int parent = dev_of_offset(dev->parent);
+	int parent = fdt_parent_offset(gd->fdt_blob, offset);
 	fdt_addr_t addr;
 
 	if (CONFIG_IS_ENABLED(OF_TRANSLATE)) {
-- 
2.43.0

