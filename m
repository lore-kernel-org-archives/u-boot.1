Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B01C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6267181118;
	Thu, 13 Aug 2026 20:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-h-c5BCeQvU; Thu, 13 Aug 2026 20:59:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BCFB80F5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786654792;
	bh=vWU6XfvCDpSHCbOUpO0hnhwaJzNAo9tzLtEGjidO4ak=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nYnFnuiMHiCBdGsxw7FzBVF+eNEPBl5gHGBGYcbf9okuMlyr+dl/Y88jw4U1krug4
	 MFs04faJpGTYjBa7MwYg0eZZylQkafxqibTxs0GLluHTE9Pkc2IDBF+aH+XDurjloV
	 J0uPoTm0azblnEAaTGl/m4m85jLBikuaq7/nQQhyLuMs4ggkbPCTTMiiOa7Dcic2AM
	 7DMSMbDdnCnUXAcXDsARo3IejYDymljPwI52iYPX3cwWFGydGZ43jHpCFcWn1bzgoY
	 59VfW/wMSD0SnGsC+7DzB51uEWJOy7yQha2j3dH5gcMA8Aam9pQHf7FIqcPNMqzlyh
	 Huy5fuDHafroA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BCFB80F5B;
	Thu, 13 Aug 2026 20:59:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E5A57139C
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D76DF40CEC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XKoATA1tppZp for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 20:59:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9E0CD40CEE
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E0CD40CEE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=haRBq1bG
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E0CD40CEE
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:59:49 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c082647cd0dso4021166b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786654787; x=1787259587;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vWU6XfvCDpSHCbOUpO0hnhwaJzNAo9tzLtEGjidO4ak=;
 b=haRBq1bGdmZgoBp1KZj778Ou6GPi4SbpozWpAPl55ybCqfNv1LA0P6S387Kk0Ljn/5
 EpiHBjZS9s68AUMie538LfgZ9XkE7JGivk+dVSkhOQQLisXI1HezHt5JuSsrORnvvrNs
 bAJenOkWCVeUaWOX3cRHEqFoyslExEyFqN83bocsCnA7r/D5igIdzWtJc0O/NbBakzDG
 zkx1XFtmzzMZ6yzgr0wHMdZkuSdj6QU77h4KW93fYZZkPElYo6EFR0gqq9k5IfwpWtrB
 c2Ky20Y77kFL9g+DmB6cBbph191sdwt2GcG/OL9u2jsK+sUeMRo96dl9guCY7Soze77V
 4KTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786654787; x=1787259587;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vWU6XfvCDpSHCbOUpO0hnhwaJzNAo9tzLtEGjidO4ak=;
 b=QT4PKWvXz2UIaWr/TyAb56PXXrJQjztjrJoBTtJdWDnt1dfNJjSaIX/S/3O/DdIvzL
 IeidAP6SkCDv8UkJN0jeiJo1rqEQyJxh+gYdbrd9H6Xq6m7ydHwJoGpO7oghwV9H3vhc
 PyuHJHIBm3mPTRWeyVosBgCM+f5dHQvvoMeo05lBi1fgZ1DIZK7CUI1s5nAQRCR1aPg/
 sa/A/ZK/D0+X44Cv580qqg3sMTyYEFLnz6/RItmZ2jSpKQA2+bv/gNqp2FVcmV9AQy1S
 wMn1hK0HnQCm5hG9unadqMyPF9y1NpuVNPfbse/jUDuaGVNe1eeq7EWRIWB7UDpXKNfc
 vLhw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpvk7oZJKFNZCNZj4v9YhYTAzigPokNa/M2ugQfG/D9OicIdsm+jJvu2DHIZuIpGH2cEM8XW/8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz6i2PBRFvBEfxBaeX740kTApgCtTNsdODAp8HOgqXwT3Rl7Yu8
 pIhfhX/hzZPpsgO91dd6UQMHH9nt5ty3ATExzfw5s7vpcyGS0q2ME3lW
X-Gm-Gg: AR+sD10koJJtaTGfOXRffrW86UhE53tk/NHWd2uZQPa8AjuBwyCG38U4a0mloQRIual
 ly6ulwIrhdtcRAv8yJOe93ttAUJTXDFPZsVXoaz0uZ1XK6CxA8XMe6naf05inXwBKNW0y0rh98S
 4nz3AQS56o0yzmAOSpJ03mTClNfeLAZ62+gA6aRPgN160ZLoq4gnlFXaRdLG2NZVaoYXxJZ/e7r
 6QdKLc2Q2+Hnfxbm/62d43gaLlEmHkdpPWxKLZLJayqgs863kPaAkE/ZixOUQNrtrzEhFNB+s0l
 VhgW1HQJ8gqfINUE7p+I+L5gRhKk6BjPV0D2rGLd/pDeqKUk7VOUlSSjhe8DDifSzH+itA03/1b
 pyIWlEJeci20VU04/AKfrAyB2q7lmNky93zVaR3zwog24O0gjDyV3vbP18MCdirLDlX8Cfdr0bz
 Dwc2tpnvLJ8Vk5VYQIspkqIkjR1SnCFbogB5x1XY91TwQZOjOWdSnFdQip9ondfgdmL/gERNI3D
 9Fc9IWXzFcuf6d3hfePUbNzKpY=
X-Received: by 2002:a17:907:3ea6:b0:c12:6db4:4bf4 with SMTP id
 a640c23a62f3a-c2129849d01mr26466966b.0.1786654787494; 
 Thu, 13 Aug 2026 13:59:47 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21237e7fe2sm30752266b.49.2026.08.13.13.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 13:59:45 -0700 (PDT)
Message-ID: <becb8615-aa14-4dfa-b6eb-958abc535902@gmail.com>
Date: Thu, 13 Aug 2026 22:59:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 5/6] rockchip: doc: add back to ROM section
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
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
---
 arch/arm/mach-rockchip/Kconfig  | 16 ++++++++--------
 doc/board/rockchip/rockchip.rst |  7 +++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e7..cb5983623bdc 100644
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
+	  Some Rockchip SoCs have the ability to load a second loader binary
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
+	  Some Rockchip SoCs have the ability to load a second loader binary
+	  after the TPL phase. If enabled, TPL will return to the boot ROM,
+	  which will then load and execute a SPL binary.
 
 config ROCKCHIP_COMMON_BOARD
 	bool "Rockchip common board file"
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 5e16e860bfd5..7f6570f95cf4 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -218,6 +218,13 @@ For SoCs whose TF-A code is not available as open source, use BL31 binary provid
 
         git clone --depth 1 https://github.com/rockchip-linux/rkbin
 
+Back to ROM
+^^^^^^^^^^^
+
+Some Rockchip SoCs have the ability to load a second loader binary.
+If enabled, the TPL/SPL code will return to the boot ROM, which will then
+load and execute a SPL or U-Boot binary.
+
 TPL
 ^^^
 
-- 
2.39.5

