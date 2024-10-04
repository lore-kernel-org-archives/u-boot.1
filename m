Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7954ACFA74B
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED18A88CEB;
	Fri,  4 Oct 2024 08:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="J9UHumur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 282C788F55; Fri,  4 Oct 2024 08:22:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5193888CE5
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a5dc=RA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1728022916;
 bh=QcBP3KxPJB6guzRVkHYDgcYBMPdpo9zsXnWjk2WyRlM=;
 b=J9UHumurBs4jieTdf2aMJuk4GQLpEqXUWeADDQFRDmo/BwAg051UEldoRHUGVMVwl8lVQOPet
 +PVONbJ7QCNqAOXV3YiUNVgqqVgXvZkykvQOH/57OxIR4b4EHDaLY40UrnB28smIAN0SdUKWzxH
 7Wni56oKwv6IIPeGZVpeBMMSWGP2howE32fAc2rEcWp2DqBf7ejXfTV6if7tvEBNIRG4nwXfBMg
 QSDMb2LJq0ispZ+co56KkD23VYnpeyC/43UoYzVAM/T3nU15BtwLo1wl8P4VuTJFtuQzOZh11AW
 R/HdjE61kAf6VDKes6On53oudbodXEdROv7uAjjnN52A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] rockchip: Provid SPL control over otp presence
Date: Fri,  4 Oct 2024 06:21:34 +0000
Message-ID: <20241004062136.491995-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ff898304584f0e26fead7a
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

The series "rockchip: Add efuse and otp support to more SoCs" [1],
merged in v2023.04, refactored and extended the Rockchip efuse and otp
driver to support reading eFUSE/OTP for all supported Rockchip SoCs.

Due to use of different licenses the drivers were never combined into a
single driver, however anything non SoC specific should be applied to
both drivers.

The commit fe38b88453d2 ("rockchip: Provided SPL control over efuse
presence") changed Makefile options for only one of the two drivers,
apply same change to keep these two drivers in sync.

[1] https://lore.kernel.org/r/20230222224436.1570224-1-jonas@kwiboo.se/

Fixes: fe38b88453d2 ("rockchip: Provided SPL control over efuse presence")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
The request to correct this in the original patch was ignored, so here
is a fix to keep both drivers in sync.
---
 drivers/misc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ff984d7b191e..f7fd1d5caeea 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -69,7 +69,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_EFUSE) += rockchip-efuse.o
-obj-$(CONFIG_ROCKCHIP_OTP) += rockchip-otp.o
+obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
 obj-$(CONFIG_SANDBOX) += syscon_sandbox.o misc_sandbox.o
 obj-$(CONFIG_SIFIVE_OTP) += sifive-otp.o
-- 
2.46.2

