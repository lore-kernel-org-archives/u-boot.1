Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D94C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 15:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A1D87E71;
	Fri,  9 Feb 2024 16:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gk429lX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB7C87E80; Fri,  9 Feb 2024 16:51:39 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13A6487E70
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 16:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 05B7640A2F
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707493897;
 bh=TcVj/WEgFswytzk8HIvShz74iuP2u/dXptaCoBfwXus=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gk429lX1grF3wlonReXAgGM7ztsytSydJri3XVTJGRMPwE4my07amBmhgMJdbBcYB
 HPu8U8rmLSW2Fw4AAfhksh4V1X9sufZKOIDRFd2h5KoqtLHcpK4Fm2cA2HRrShUZzO
 6wGmFT4pq25eIY1Urff1REEEKCyVTgzCVORlQn2bwfEeod21/77A1Y7jdXznE2G8pr
 u8jUxL7gjLRX8HIrRowl9bSoVbwPUYx1d8VayUWfs9hMtqpwu63NfkIkeFtLaP5lUo
 7id/DcEkSaFg266OxvtoxlkLzXPLftQsByTiXKyxvGAYP12tkyaUmy8zO7lXpPq8xa
 cIfBHnhqR8pAQ==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a382663cfa1so59673166b.3
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 07:51:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707493892; x=1708098692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcVj/WEgFswytzk8HIvShz74iuP2u/dXptaCoBfwXus=;
 b=Veu0MIkLzhrBfSa/J32C5agKqLKhVPl1+EPchma1hyNI4dvme2CU3fijvXx/s97+ze
 u/4/o8q+IU2W3YY9ap6TVH73aU7YCurdZEbMVRq49EwOUwtsnc0zPfjnVOIXr2ORhh1U
 o6gZ3c3liNmNA6vPu19NY7y39pBVB5ZPn6/curOELLooPAiXy4RusF+ymklnFKdkhnNZ
 Ipu1MBB/UQAVez2+VAuFYZR0re/3QBI8XWPKCKymM8Ri+ehvHEQ2dCR6GqJK6MTl254E
 q5xN3+zowX+kRbgy9IjQjo13zf/OrpI2eMHYifD3F3c0yIFGnv3oJeoLvKqWN65zMdDb
 vr5g==
X-Gm-Message-State: AOJu0YzS+oMLGnuFm67l5qEBLOqmDy2xsvAEQj1Y8tBXpxNuZ4GB48MB
 r814HNeFH1hDy92LMu9Pe77AxEY+GIY7lDoFBRwr5eKlSBNaErat2xAcxShEvEMSNXF15qFFjPf
 DwN2nbfSnWc5RRbR2HOeiuq4qEIaHAq25qcmBGOs5TmDr2q9kUL2/dqLhNg0XuGrcJW3WVDIt3n
 M=
X-Received: by 2002:a17:907:10da:b0:a38:1ba8:4609 with SMTP id
 rv26-20020a17090710da00b00a381ba84609mr1315620ejb.13.1707493892285; 
 Fri, 09 Feb 2024 07:51:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe7GmgTU/d75G5nBkcaEiHj53fVjysXBrzbrvoLbsvk7kJRIWF//wDKhhlJ2U477ny5v3aPQ==
X-Received: by 2002:a17:907:10da:b0:a38:1ba8:4609 with SMTP id
 rv26-20020a17090710da00b00a381ba84609mr1315613ejb.13.1707493892061; 
 Fri, 09 Feb 2024 07:51:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUI4zr2BweVA1HYaHcArNGsZO0batdyh2V80rDf2HHvylYzlDvcr/IRchZyxcq8YdRX9Xgq+5JNd5Tc/0140nL5kLCjXH7gbEA2uOkcrJIz3jaKm3cpfBv+IqU2NHi/d9XqJodh/BElRYL6iKr26ggfICFxqU8a1Z2pkPEi838vy7frTh+kpk+2uXGP09htqAAQDtBycVUSyx3/ixvB
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a17090655ca00b00a38620c3b3dsm866944ejp.198.2024.02.09.07.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 07:51:31 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] smbios: fill wake-up type
Date: Fri,  9 Feb 2024 16:51:15 +0100
Message-ID: <20240209155115.102957-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209155115.102957-1-heinrich.schuchardt@canonical.com>
References: <20240209155115.102957-1-heinrich.schuchardt@canonical.com>
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

We should not use the reserved value 0x00 for the wake up type but
use 0x02 (Unknown).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	use wake-up type 'Unknown' as our default
	add more SMBIOS wake-up type constants
---
 include/smbios.h | 10 ++++++++++
 lib/smbios.c     |  1 +
 2 files changed, 11 insertions(+)

diff --git a/include/smbios.h b/include/smbios.h
index 3df8827b60d..990e37b4d2b 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -108,6 +108,16 @@ struct __packed smbios_type0 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
+#define SMBIOS_WAKEUP_TYPE_RESERVED		0x00
+#define SMBIOS_WAKEUP_TYPE_OTHER		0x01
+#define SMBIOS_WAKEUP_TYPE_UNKNOWN		0x02
+#define SMBIOS_WAKEUP_TYPE_APM_TIME		0x03
+#define SMBIOS_WAKEUP_TYPE_MODEM_RING		0x04
+#define SMBIOS_WAKEUP_TYPE_LAN_REMOTE		0x05
+#define SMBIOS_WAKEUP_TYPE_POWER_SWITCH		0x06
+#define SMBIOS_WAKEUP_TYPE_PCI_PME		0x07
+#define SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED	0x08
+
 struct __packed smbios_type1 {
 	u8 type;
 	u8 length;
diff --git a/lib/smbios.c b/lib/smbios.c
index c83af730a91..b190b010f30 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -394,6 +394,7 @@ static int smbios_write_type1(ulong *current, int handle,
 	} else {
 		t->serial_number = smbios_add_prop(ctx, "serial", NULL);
 	}
+	t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
 	t->sku_number = smbios_add_prop(ctx, "sku", NULL);
 	t->family = smbios_add_prop(ctx, "family", NULL);
 
-- 
2.43.0

