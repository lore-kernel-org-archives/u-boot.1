Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8019EC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA06281D42;
	Wed, 19 Mar 2025 00:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HDxONSyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 968AB81026; Wed, 19 Mar 2025 00:43:04 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76FBA81C67
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:43:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-47686580529so52264421cf.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742341381; x=1742946181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3tmXZwnySEm3jskmeYedbjBsDBp+mgUH7B/sMFAIAs=;
 b=HDxONSytuGJiCSnWGQmt8Pc9WeYlONVgFQ3aMcSE+mu4Qf3cn8anVA/+ErsIjjo14h
 IiiCj6pUxhdMRklIC+MzOtp1zQ8Kw81wVlOGsqETPO3wKm6VCKYdfiASXfSqYAgkqErs
 0c1mm5f83ZaUHpkuO2WpbTerc7tSCFXRDJySPtyb2BaB06ro17xdHfYhRfi/N33+V51L
 ABgqELoVbBHvlehpz+vcJaluOJimO/2OPMgVwcVsgqtv3NaKjSGgDE1TYErwLyCxUK+8
 2S29DCOQecl33lzQlYub6271A1qPtPQEevw7Kn/btDD+7w73j/FHPxG9f7ESQmPtXEi1
 xFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341381; x=1742946181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3tmXZwnySEm3jskmeYedbjBsDBp+mgUH7B/sMFAIAs=;
 b=l9NNWfVZjdaT05RVDNcI6tSrGsA4Do0OSKvfKBDqfOGmlC1qM9r3mGlcdalajL/sl5
 328qU4ZEvRqx2SGuv1ujM7cLvOi3y+JnCGaziAb2Qa801T9oRuJel//9y8++IKiTM4eJ
 GLEW6Bnk1FYLWVvTpO3w8k4tMQ1n0b9M6wZqr4jhdeTrDanBO0sWOCrKdYKfYnE/pCzm
 HlRP0EVtnhQloSmmVhBCLa0dGCLBuqU+KRTC/hetAzVaOCTdWS6+XSKQCZiv6Ng6D3Rj
 Bo228C+jv5HtPfzpDj0l9+J/DgXtpEbToT4XKxH8daOicI4bsovO3c9RleAaTHc3PE+k
 Uq/w==
X-Gm-Message-State: AOJu0YxYqysp+Cgmec+RL4CyAllAkb6dBATYM58beomrOs0fyoHZcnNB
 I6cjBQJ9BeAsB1J6B+VF24USbouQPPujS0SOockNp4TajgYyV4rNe3gbXg==
X-Gm-Gg: ASbGncsYEwQndDxh3ejCIDJ+4HuqGQ3zKaOjID5Q5migozftMyKebknCzASSP6yNlpb
 v9Z9AG+n3Zv8kBphw6vGJuFdUnDXOeXRAaysXR+4AYuNf7hLpb/XBvNias3iQTBBqBWI/3FufT0
 txn6uaXjowT5YbInjroAsxKXnj+TBly4za+Oe891SEWn3cMrTwyyDVF6BO1DFzBYMc4POKUI/Qo
 8+J57D4kH8OLDRqwF3EBhPjMuFs/LD80Cs0W+cm7biLUDjmtv+70sVop6pLX2yjdTeZyQqYApqV
 5XO/Yw/rxkkxusOknNkCjdJ4hW76Ta1IvAZYANfDgWBv3Iibtsh5RCVjIK8vHNFPwlKFHFpbiw+
 1seY3bpiUM971wpT1/JY=
X-Google-Smtp-Source: AGHT+IHoEb1S0cEgYZaDOg5Pv4ZKGjuJBfceQ/4ZDt4RjdDkC+tpRqB5i71RCdOOk0ULPuxtF3xInw==
X-Received: by 2002:a05:622a:4c85:b0:476:af62:8532 with SMTP id
 d75a77b69052e-477083a525dmr12886521cf.45.1742341381043; 
 Tue, 18 Mar 2025 16:43:01 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm72518261cf.74.2025.03.18.16.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:43:00 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V3 09/10] configs: imx8mp_beacon: Select SPL_CLK_IMX8MP
Date: Tue, 18 Mar 2025 18:38:37 -0500
Message-ID: <20250318233849.587520-10-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250318233849.587520-1-aford173@gmail.com>
References: <20250318233849.587520-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In preparation to remove manual references for enabling some clocks,
enable SPL_CLK_IMX8MP which automatically enables SPL_CCF and
SPL_CLK_COMPOSITE_CCF which permit various drivers to activate
their respective clocks automatically.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 configs/imx8mp_beacon_defconfig | 1 +
 1 file changed, 1 insertion(+)

V3:  No change
V2:  No change

diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index f39e4f5dd28..9709f628f9c 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -86,6 +86,7 @@ CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
 CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
-- 
2.45.2

