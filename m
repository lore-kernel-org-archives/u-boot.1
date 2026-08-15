Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD25C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8AEE409AA;
	Sat, 15 Aug 2026 13:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GQZI_HcaBTyq; Sat, 15 Aug 2026 13:08:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CA194096F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786799328;
	bh=uUNZ8/1MOJjpBeGg/tiYlDwP2v49fOLSbEYpy7x2yAk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bsjnho6CDiW2Rn8L/u2mEI3V6iaVeGpOHAcg9Ebmc2ZnA1pCECYEKCCDIG4srEkX1
	 camU7nsg55WyTwhDbWWdGcEOlAdIMNd1c/MLr4LKXwTCWBKkz1O8PH0xiQjvnGkpjJ
	 tBDhR1boNNMJPMqjkhsJoJyPUZIdvnmuXy14RA1D9ZsBXPWjSb3sm+NaD4Wzg5Fmuw
	 l6IKr+IMcunPDwftP21s24Bqmemxs4b5DpdRrvyUKcT2meIbTWP3f1VE2XICo78ULB
	 mJu67pSsANDSEaE0JJvIVxgj6e1NhDs8BzSb1FdAqmrpXM3NrpSo7KTnWCcN18zTNW
	 A2I75+K7yKvCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CA194096F;
	Sat, 15 Aug 2026 13:08:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 636FF109
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55A8C60661
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:08:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ZU8J1tV8rYV for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 13:08:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 28E926065E
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28E926065E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WcZB5dhI
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28E926065E
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:08:45 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69fdfd98eb8so267431a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786799323; x=1787404123;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uUNZ8/1MOJjpBeGg/tiYlDwP2v49fOLSbEYpy7x2yAk=;
 b=WcZB5dhIH1cfAyg9s6hOe6aISH/gr5LfQxUsnG5+AOoUp7r+oQ8kUA0s5pCVfZ4rVk
 miqjGw4zhquJUsEniFhLZv5FxMC8rO3NspQibhEXdh5o/ZMA3exDonYghgiMVNg32lFt
 WndLn1wLRUhJVfMud9q9Jwi27WigjvRlABA7SXsSwRdgwsXQwxKjz5tGxjI4H8Yyo5h0
 AgCx1ErUst6hn0RbsksghglObdw35JHE/a+sOxqD9Zr1OCBDTkE10mUK51DHT9iIOyAV
 JM0VJNUvzaT/NGelhPaZxEcM+K/DykRWJkzlf1LJNxaqJMycfzCwomdp4woFhlsekOOV
 tvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786799323; x=1787404123;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uUNZ8/1MOJjpBeGg/tiYlDwP2v49fOLSbEYpy7x2yAk=;
 b=hn5gDzVD57B2w/n/ozXdkmciuMIEgHJHOdkc1kUg6nwsJ3ExYUijAJz474DlKheNbB
 ZvexZKyXpCnMQBBWwdJwJ9QVScG9SFp3uHlNIDeE2AisqR9V6zmSzJqHFaTz3E1oE4Tk
 qUPvDHSZdzi3kioGigCbptOort1tM3Xf+AJX09hCnOF3WjRYu0jXuUY5/vZngS945i0Q
 +UvGTUcD6nstdWHC+Gj/fFF1VUJkg/ZYIowQYkX27l9uVLHTaaDyzBcZEwmlwVUxxOlF
 fw5b4bSDNhLH3Q0tJha+tkAOWtSVanHSFQTgviVuTVgEfn4r3pxOnQLXSIVpfkg3IcnY
 EkQw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqleb9JHexcApCOIxEUP0R0yX6BnuJ9cXcL7m2/4u7Mv1bHl3Bkdk9K3lPGgArpkMG6iWcGOsM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyfdoY7NIiJBVjIGBsGX5agQMpPcdzGsDYFqVsmIeem1IO1ShS6
 mbyKu30GIFJdR6auyGqixrkWAp6sdhBpSMwpbvyh/SsTCvAwR3tEDE1t
X-Gm-Gg: AR+sD12TAeiHGJ+2/eMOyDJKkCBwzPiBpMcmZhGD1VWYSROwWYnbw96o8oEku175Arp
 +0F6HQbtbu8Lr790clnlV2j7jND1xFJib29xdG9tYQ03UE1aCeR0e1pOGAplKNQF+UFEi//fvDP
 TdFG+hjnNiYXlfgBoutYvWcB0l1f42hUkxh1UbQAuNS95Gk528vecYc8BV+yaRVjdOOwoXymI+g
 Niu/lvgESGrgXohG2/NEykxtPOKZXsKLslHyYFttbh+HlxOTJzjwA0bJ6XoauADNB/nfgloosj6
 uG4nLpkd1blpiJEmlrJKPonjisKEv2l69RyBSxP8TMKZfgcHBd8z57E/Q6HsWLbo6tg97qymWaa
 IQT/YcGOM9C3UhaYfVRYgHQBRKoXeoQOxgEu+IzK5Xo6dzSWAt054FWMdFCgEv4bjpOKDkhr/My
 mkSEISybgSHrQRlrWr5ePEImy1FXSu+eX7qryxFWGbjTE7p0+fleIx9o++s0DSNih3TqPWGMrwp
 SmWFq4Y4gp1Wq/a209UClSKwo8=
X-Received: by 2002:a05:6402:5305:b0:6a3:6804:9e82 with SMTP id
 4fb4d7f45d1cf-6a38a9a59b2mr3178827a12.4.1786799323134; 
 Sat, 15 Aug 2026 06:08:43 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a38c9e638esm1847771a12.9.2026.08.15.06.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 06:08:42 -0700 (PDT)
Message-ID: <483e93ba-a427-4ed1-b5f6-8d6cd11c5a42@gmail.com>
Date: Sat, 15 Aug 2026 15:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v7 5/6] rockchip: doc: add back to ROM section
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a back to ROM section to rockchip.rst
Correct Kconfig text.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed V7:
Move under a 'Boot flow' heading
Remove "Some"
---
 arch/arm/mach-rockchip/Kconfig  | 16 ++++++++--------
 doc/board/rockchip/rockchip.rst | 11 +++++++++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e7..c1dbcce1e27c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -600,26 +600,26 @@ config ROCKCHIP_USB_UART
 	  SoCs will enable this routing as a debug measure.
 
 config SPL_ROCKCHIP_BACK_TO_BROM
-	bool "SPL returns to bootrom"
+	bool "SPL returns to boot ROM"
 	default y if ROCKCHIP_RK3036
 	select ROCKCHIP_BROM_HELPER
 	select SPL_BOOTROM_SUPPORT
 	depends on SPL
 	help
-	  Rockchip SoCs have ability to load SPL & U-Boot binary. If enabled,
-	  SPL will return to the boot rom, which will then load the U-Boot
-	  binary to keep going on.
+	  Rockchip SoCs have the ability to load a second loader binary
+	  after the SPL phase. If enabled, SPL will return to the boot ROM,
+	  which will then load and execute the U-Boot binary.
 
 config TPL_ROCKCHIP_BACK_TO_BROM
-	bool "TPL returns to bootrom"
+	bool "TPL returns to boot ROM"
 	default y
 	select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
 	select TPL_BOOTROM_SUPPORT
 	depends on TPL
 	help
-	  Rockchip SoCs have ability to load SPL & U-Boot binary. If enabled,
-	  SPL will return to the boot rom, which will then load the U-Boot
-	  binary to keep going on.
+	  Rockchip SoCs have the ability to load a second loader binary
+	  after the TPL phase. If enabled, TPL will return to the boot ROM,
+	  which will then load and execute a SPL binary.
 
 config ROCKCHIP_COMMON_BOARD
 	bool "Rockchip common board file"
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 5e16e860bfd5..d5945e805ba8 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -560,5 +560,16 @@ config-flash.ini:
         PATH=RK30xxLoader_uboot.bin
 
 
+Boot flow
+---------
+
+Back to ROM
+^^^^^^^^^^^
+
+Rockchip SoCs have the ability to load a second loader binary.
+If enabled, the TPL/SPL code will return to the boot ROM, which will then
+load and execute a SPL or U-Boot binary.
+
+
 .. Jagan Teki <jagan@amarulasolutions.com>
 .. Wednesday 28 October 2020 06:47:26 PM IST
-- 
2.39.5

