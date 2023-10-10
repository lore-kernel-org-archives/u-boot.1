Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12540CD98CA
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 22:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B2986B75;
	Wed, 11 Oct 2023 00:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pfkvqVUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DF3886997; Wed, 11 Oct 2023 00:24:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D8E86B79
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 00:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f707=FZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1696976643; bh=JyX4nF/+6gjOLoBrtK8qMQ0SsX/3hXOh+5x9YIRAFhw=;
 b=pfkvqVUCZR309YcgtZzvnvJm092Tmg43+JYQ+8zIPTK+UXmzFmoN/vgTrGMH2kb/w+mJ0yy6S
 loQUctLIC/cfy9v68SZ3kK8zO1IODPirXh1010+LsdLhywhIyfQKnYU5iB5RCjJdJDv5zM0rcl1
 Dvr+jGfr9I4i+tbJAMED6OiBxMHQdsZGTGXMptjq8J4t7RzcJKSzqug17lLl4ItQ73PNO9DGVCL
 UBza1NOUsIZsBIvdImCsdtc82rprpo0k+g95QpLoHxPBHHuVRO6aexM/UtEg3HiranLHH3+HtMQ
 oYc1liDDjWYvIXxPkihfOP0p1UDYGu3EHEcTrqlno1Ng==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/4] usb: dwc3-generic: Use combined glue and ctrl node for
 RK3588
Date: Tue, 10 Oct 2023 22:23:38 +0000
Message-ID: <20231010222344.3436526-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010222344.3436526-1-jonas@kwiboo.se>
References: <20231010222344.3436526-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6525cf03dfb1822b4d6ef320
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

Like Rockchip RK3328 and RK3568, the RK3588 also have single node to
represent the glue and ctrl for USB 3.0.

Use rk_ops as driver data to select correct ctrl node for RK3588 DWC3.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 744fde806948..6fb2de8a5ace 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -610,6 +610,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "rockchip,rk3328-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
+	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "qcom,dwc3" },
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
 	{ .compatible = "fsl,imx8mq-dwc3" },
-- 
2.42.0

