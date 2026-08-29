Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6A0C61DDE
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 22:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 771EC80E7E;
	Sat, 29 Aug 2026 22:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QFKS4gLkRiM8; Sat, 29 Aug 2026 22:44:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788043497;
	bh=dubwSAIg6evCWezvvNmZH72UglCArNGFJ9FStrrFIHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=09AVCqp5s7y3A4Q88Nr64SMC+3u8ZdwyGtBgVEIpVjNYPGxQlz13ZAeGfUl7OA7Ds
	 rDIlgSWnZJofTirwrojpUZ+d13yOyzIkd5RQMQCF5DAdKySruEiS1JlfYUT391G286
	 5+93H+VPr/0O8YLArKJSW8kDy6WWejDeIqtzcfFBEx1PPssvuRwSx7c1ki9yP7bTJE
	 gzeMDRAaSkywCxtZ2/dIBhObdHNnXubLzLGW8LEbDnz3/CbwbitiPAVNiN6H94Zwj9
	 IPJJ190g9dQL0xwSu3YGaa80zqgj2XOV2cbiPsfgEI7XYaTgB/rWA0F+5pMmdxznbK
	 eQ1loCmeTSnpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C913D80E78;
	Sat, 29 Aug 2026 22:44:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D4638118
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 17:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA95F4009A
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 17:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0acT1ZZ7liY0 for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 17:03:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BZksFcIK
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C926440068
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 17:03:32 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48436251906so133584f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 10:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788023010; x=1788627810;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dubwSAIg6evCWezvvNmZH72UglCArNGFJ9FStrrFIHo=;
 b=BZksFcIK+DUnBhLSfUDDoi8M3m4mB+r9CzNOWUD9KswDAyUzR379Vjf/oYh5MsPufQ
 cfbd4yueg6o3e4oEyRsJVXWhwlzeELkqRd79U1xHZHsBG5Eo92zwAj5RcD3clpv2gIq9
 F6a6hxBiPG3Qhm5mkwHR+nUUvywDb/2zPYAhw8pgiP/KcsmmknpO2Hg/2uEqPC0ZEyzL
 r8N4wTTAZZudZKnneQI4qNIP80jDcj5NTnaO5KYd2MAY8p7E+L4KBOz3oVIqp1WLcnT1
 KfVDu4twEBALrb4O1cnZAM8dC9kvTufh4Y2k7dTCKiOXyb9SMpakaeUteSVfkZ+ezFyO
 Sa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788023010; x=1788627810;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dubwSAIg6evCWezvvNmZH72UglCArNGFJ9FStrrFIHo=;
 b=suvwbnaaA44vj1uKvYMd1zfPwr02astYsrNvH0STF1zItAqClcHs0TwUyWP+15PeKv
 noxNu1esaKPomVSjFz80HMrrRnIRMBrAqDVMKPDhrIr2nW58O0RnDx9BVBUR8B90wRQ6
 hjQWVca6Ml3ER0GKAVbb+eez9hUug25yugzNrUKDHkxxq3RfZHC8tHb8MJbGjiwiEusG
 Q5LycXOzLiFrdxZsWJQnNPrfm/cmsgtErFVohWH3dd0sPAKzrmBb/Kn7NzldtK1LMKFQ
 7I1Wx9l+TBzG/iZOQ+9+osiREf83y5sFx68SPMVYJjkglgRQ7o3LUKkGbjj7ER09yMgZ
 g+6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxC4zxFBQng/TwVmLtoHdqbRYcOjIHj8I9l3uar0by9mKfxCBmz1HsVOc240wbPBkZoNFStUsU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lB1IuHE7+KesK/AoiToHGDzO4quFNtvwkh9bRbMA1XhnA7m0Rf
 FjKj+CQta8WSSnIUHVzDlipzPZBG67V3RyjN4ptu3txuKHZqJg8Bn0iv
X-Gm-Gg: AYBFou1k/KXxeByXlENHM5Ts3tL9wwaWqwdTPM0Huw6RBWL2YfS+kwF2aJ3fUg6AOst
 eZs4XIJC2K5rTsMVqZq1XlozFgK9epF3hU+aCutE/v+Omc1Om+2JPBbEl+SPV86xmaZf6boQLnN
 fgyMqN9junOprx116EE86l90lwlE3fsjNlGq0Gsi7FawDNhPOHquX4jzXSTXBOhUwcvsjQ6P5jU
 BCBlSM6F5WQ6BUbSq+XKw0KPr8xF5Z771EiX5U1DRWICEukPpm0oElBwc/5lKpCCyAtoApvp1MI
 M95uDUEpzQ9nj0VWkYxVMPNqcLSMZOkbOx75j+DvC0o0LzOpFawyjvl/u2PVua2pBcD5JEVNqDY
 DmCzL4b0QcwcoGoVDtUEe6UYlHwfofDBQPwT1dXOJuNWyaqqc5bCeW2zXZFdcF/uDOGSNL/g/Ru
 wIsanGD1zjyAXNvGXiU8rcy9EkXrNKJ9f35dIEuu4e9d+ZkcHIDxxkJMfFZUTyyEifqzw3v6Q=
X-Received: by 2002:a05:6000:64d:b0:47f:7129:6e2d with SMTP id
 ffacd0b85a97d-482f79baa8dmr22576439f8f.17.1788023010445; 
 Sat, 29 Aug 2026 10:03:30 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.168.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb32ce2sm12163133f8f.33.2026.08.29.10.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 10:03:30 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 29 Aug 2026 19:03:11 +0200
Subject: [PATCH 1/2] ram: rockchip: improve ddr type configs selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-ddr-multi-v1-1-c0c7837aed20@gmail.com>
References: <20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com>
In-Reply-To: <20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 29 Aug 2026 22:44:54 +0000
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

Not all the DDR type config options named in the Kconfig are supported
by each one of the Rockchip SoCs. Moreover, the LPDDR4 option has a
different meaning in the context of the RK3399 SoC than in the RV1126
one. Improve clarity splitting config options, using SoC specific help
sections and adding depends on conditionals.

Involved Rockchip SoCs are: RK3399, PX30, RV1126.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/Kconfig | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index d707d09c1c8..61a3193b3f5 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -26,26 +26,53 @@ config RAM_ROCKCHIP_DEBUG
 
 config RAM_ROCKCHIP_DDR4
 	bool "DDR4 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
 	help
 	  This enables DDR4 sdram support instead of the default DDR3 support
 	  on Rockchip SoCs.
 
+	  Note that even if multiple DDR/LPDDR types are selected, support is
+	  enabled only for the selected one that comes first in the following
+	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
+
 config RAM_ROCKCHIP_LPDDR2
 	bool "LPDDR2 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30
 	help
 	  This enables LPDDR2 sdram support instead of the default DDR3 support
 	  on Rockchip SoCs.
 
+	  Note that even if multiple DDR/LPDDR types are selected, support is
+	  enabled only for the selected one that comes first in the following
+	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
+
 config RAM_ROCKCHIP_LPDDR3
 	bool "LPDDR3 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30
 	help
 	  This enables LPDDR3 sdram support instead of the default DDR3 support
 	  on Rockchip SoCs.
 
+	  Note that even if multiple DDR/LPDDR types are selected, support is
+	  enabled only for the selected one that comes first in the following
+	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
+
 config RAM_ROCKCHIP_LPDDR4
+	depends on ROCKCHIP_RV1126
 	bool "LPDDR4 support for Rockchip SoCs"
 	help
-	  This enables LPDDR4 sdram code support for the platforms based
+	  This enables LPDDR4 sdram support instead of the default DDR3 support
 	  on Rockchip SoCs.
 
+	  Note that even if multiple DDR/LPDDR types are selected, support is
+	  enabled only for the selected one that comes first in the following
+	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
+
+config RAM_ROCKCHIP_LPDDR4
+	bool "LPDDR4 support for Rockchip SoCs"
+	depends on ROCKCHIP_RK3399
+	help
+	  This enables LPDDR4 sdram code support for the platforms based
+	  on Rockchip RK3399 SoC.
+
 endif # RAM_ROCKCHIP

-- 
2.34.1

