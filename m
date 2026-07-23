Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29AFC531FC
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 22:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C0B881156;
	Thu, 23 Jul 2026 22:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id URCq8do1Ol9a; Thu, 23 Jul 2026 22:17:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F1538114B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784845067;
	bh=l20ficG86lubjXv1R3SVGXj0Ppi7bmiK2F6sE/0Gibk=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ekfSZI2NSDBGuwzMitUViWqqksKGuG8kx5vaDwr3EphZT4ivQXry3f5FDeCDiOnbF
	 nbIo8NWKzf6sXNYmio5443Yf+Wo+oapo6dwyAE7QBcpjHkUqWVjGPNWvUaM9++YkZ9
	 SvScaquaVjCMbEdCIjdKB7zFenR01Dey/G8f0UetM9BNKrLMs736cPu4rb7UQsAuN0
	 T5kffwvKYqJqavcJO31M7Poww/fzTPuv5Ld+hpPFRtYDgXkuOHt7/KJTkaQmGoQ+mB
	 Oue58ryNPJsObV/l52Jv4dpUM8HtzY8zwDszi2eBVjliNATWbsMwMn5VNJNQVXkwzJ
	 Jwc4yasDPDGLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F1538114B;
	Thu, 23 Jul 2026 22:17:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7071D347
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 22:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61C54402E7
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 22:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s9LKjG46OnoR for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 22:17:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 47A1240247
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47A1240247
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47A1240247
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 22:17:45 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69f734cd461so191548a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845063; x=1785449863;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l20ficG86lubjXv1R3SVGXj0Ppi7bmiK2F6sE/0Gibk=;
 b=SgtmbccIMLbB4ENQz4xF/Me/S44+Vt7eLAFU/COcW/uj6bobN9gq7fJAu0cHsULReL
 37H3ecMznPRplkULDN9KWmVJSR5NYbGRIOKPXeeps2DnDZqRIrRlQg6rytKLZjRYwGT6
 cieEJkkCP2wWRg07h9uvhztz3Rh4Kh+Wmqqs2R/oa0iG+h6OpRfpN2WHiaScNG75MuDT
 GU9KVFeHxFSXDQyhxowbm6IwCxboaYpQMNyP4G9VoebYmzp/yyzuxNPl5CeK/13IRn6j
 bm+8zSEnI5HlnDPUaTHHzoymFBz3bPzydc0iePpmSAlpDjs70Ck0k8wlXpDAKQk+e4r/
 3K+A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpt9orZzcpQiseyzK08ziH5HPGL7nN4r6YH345Kp7w2nGEs7ijkf7ngm2rPR5Q++9OW7DE3OSk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyMb29wOfooB+YfdHvrsew43iIhqD+cHzNr1CpTPFoW5GBTKZhW
 DOuo5iLtAhum7sZGDJUdXs2uhXyqa3cn3xL2kWj/ccroXLVVR33SykWc
X-Gm-Gg: AR+sD12dLtsukpeIsbx3DQy3YFzDBLV6jTghRkuNetz0xBwDO7+M/JdOWZzkaq/Q/cz
 sVFKNRgVWeCNjG0s4g7OUjUjpIbcvcfX/z3GAJRzUIqbzMox4UkCWKp10/QQIk7l4KgDbohw1+g
 iHz3nd0JYGmeHP1w2SY+n3f5ZFdddshH3BZdKvsmsEXlPbhvctGmRVCUsxKAu2SEYCau+5KPFMv
 FHu79lLg39ZObMPJLejCOVJJWX+hhsBfOHhDYOmwh1Ll/24n7zjDqd3fnyQPD/ud/cSEhQ4KISN
 vqMSN63ObqTOfh28ecfbtlCinmOXbRIymjAk1zf5LcGAH3LdkXVFTX0rK0Qid7bkdeRCEgYA84m
 8LqMzsh42IIpBfEXbWN250Y45VrTRw9XYbRaCp2O6cMrgmmxzXaPGCyng236FL5gWz2P4TzGiRR
 ZgxwqfxQNL3eJWVzygNhF3g3Z8ZXT3nwd2/EpHZ3SywX6xa12YHcs=
X-Received: by 2002:a17:907:d22:b0:c19:5d7c:ae79 with SMTP id
 a640c23a62f3a-c1c6ee09acbmr29386966b.7.1784845062726; 
 Thu, 23 Jul 2026 15:17:42 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32ac6ff3sm280418366b.19.2026.07.23.15.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 15:17:40 -0700 (PDT)
Message-ID: <cded3ae1-b908-49c6-af92-30b931d160c1@gmail.com>
Date: Fri, 24 Jul 2026 00:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] rockchip: spl: replace ifdef by IS_ENABLED for
 timer_init() call condition
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845063; x=1785449863;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l20ficG86lubjXv1R3SVGXj0Ppi7bmiK2F6sE/0Gibk=;
 b=QcQIEKYt1PZQCvaZiAynjpdipwqy4mS5zTlU7m758MqfmBPVWF2Fo8U8wck4LCfBdV
 1VXehZUbd1uegjVej+7L8w2FLaA1EFubI7i48qbkJCvpNoCbdccRnx9zJ+A1nGFOFM3t
 KoQCdvUA85rmZLNFwnaDZrCpIRx9+JWV7zywG+ncEqA7hmzHpAOzbqoJ7ZlGYZ8nEUWJ
 x6qAj9/bgHL4zXUfhY+LixdjOTeItU0viYR1FMhkrOImStQIkTgLGDfwy5D8KzlXAO7I
 idINGj4RFSayiBV3tdGVcUtaFapvDGrb7jQuZtHKyAdT83EIw8R4OC387/uRO2xRsaxk
 DXPg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=QcQIEKYt
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

Not all Rockchip SoC models use the ARM arch timer.
Call the function timer_init() only when
CONFIG_SYS_ARCH_TIMER is available.
Replace the ifdef call condition by IS_ENABLED
to increase build coverage and make the code easier to read.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Previous version not needed for serie, so resend separate.
https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.12039-5-jbx6244@gmail.com/

Changed:
rebase
remove text
---
 arch/arm/mach-rockchip/spl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index e989c148079a..894c24608e64 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -122,10 +122,9 @@ void board_init_f(ulong dummy)

 	rockchip_stimer_init();

-#ifdef CONFIG_SYS_ARCH_TIMER
-	/* Init ARM arch timer in arch/arm/cpu/armv7/arch_timer.c */
-	timer_init();
-#endif
+	if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))
+		timer_init();
+
 #if !defined(CONFIG_TPL) || defined(CONFIG_SPL_RAM)
 	debug("\nspl:init dram\n");
 	ret = dram_init();
--
2.39.5

