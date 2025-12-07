Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C995ED2CE17
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 11:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A97D3839D5;
	Sun,  7 Dec 2025 12:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SKQDXFRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED87839DD; Sun,  7 Dec 2025 12:19:14 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76417839B1
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 12:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 605083F181
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765106351;
 bh=B4lwTdF4vzeCF76/BBbZOi77KUVHY9xkg1qopPPVkNQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SKQDXFRAWq12aXsJchaxrICOYMzXA3gtfpSVt7DQp9OHayTtPDLRPW+UxLQu626UL
 EiHxtGtXaTY/uaYr9ztjm8evzZO6w2hlii/lIurWPKGWw1iSbSdZTxtctaL837V4h2
 1MU1N5PW4FZNtDu7W05ivc+xTs5ZOmz+DZW1Wr1+BIfIrvAvqLUGHqkwGT01TuqVkv
 VWJQlC/Me5RYHdSegVtxhZh+xHjiqq4ylbto5l+BwI9HPKgx/hKvJoQCyGgJcRgKYG
 BKNyGh1LxhWVzHgwXUJYFG/AcMhLUOBCEl7KFHB7FaMPWDVjDcU8PMdQQkMQFTIp+G
 ayVWxHnU5irc5JpSGWMIhG9cHVG3NFR6qT5X9K/2GHwuFkoWWEYRUdmpaftLbWx7US
 fPPEiU6Uv1PR9D9wDnLuPt7l0BdkIEI/MeRIrJlwiZF8hL/CQ6Pb2d443IvUJTjq/X
 aojwTYpen9YYFjsdKEYfVOFTTjhvzQVuHcAd3Bl/ROapFfN66GIqOGqarXcWpRKL3n
 NDCdcR1GaLt9+FVNN4NXIm0JllsYOCUk61+WuCGMegn1UHnkWeoOCLMf3pNffa5NBh
 FbEI8EjTOnIKP4KSjFss0Bzoz3pNOv2642stD7KJoh6sHzV4pEsfPoXEd2bVYI60qY
 w/A50Te8qdiB648vvZUjoSx4=
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b79fddf8e75so300874866b.3
 for <u-boot@lists.denx.de>; Sun, 07 Dec 2025 03:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765106351; x=1765711151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4lwTdF4vzeCF76/BBbZOi77KUVHY9xkg1qopPPVkNQ=;
 b=CqDg1LLjvFzqeLvIbQNgqXMxJwABy82+rYsyXEpyhiOCz1RN1EWkxREpV+heWm1Hhs
 THbMeesAIFe8DTXRBvB9irj5X6C1N4VZhGUAqPvPnELNJzxF1wY45PJtUzwtgkw3AxlR
 +MAWr+aeQozXkkGxmJkybyetMj+JwLY9YFv76jDwx0KL2I9hOc30+/pXxBpRuzjq3Kxv
 0KmZWQF3gUv0dP4zA+nAoeiSQdI54eEDeISoBNHvoz07BV4BHKlzuOnuKEfupdQRCuR+
 Z+bNYCwPchFOgEKL5pLgIkxOPRpOi2Pmv/FQY0GsQqBDeV5xZCK7debtmVBtFEJpzfeV
 Yr5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFPl8sJzTUsJU8Bgnr7YAXy0Nd6a4QkHbsvsafS4w87Izt/VPazVWjuhk74OjJOdROl/R29R0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3th21jgAZQ8ix1yL3z2LisrJwyDmLbTzuY6MGy+upz8VT//AU
 EW+mo1Ta4O392nvKihIMfASpJ0VS8ffhQytBQqWEuG2NHk5VgRIIe3VRmEpQ7yeAsk7sNONwGms
 9hzbr+Qd5Fvtel34Vmm2O+XcE/Zjt2cWtErLlGhdVRl4P59eFPI85I1Pz0gGMGXz/VpmItfw=
X-Gm-Gg: ASbGncvhSkVbbdCzYuvSkfHF4vCXYfZTtQ96aoL7EBstK0begr2BREq5MB7lw4Wwym6
 6gVN5zqPc1K3mO1UPnAh0tk/x2locgm/e+t2c8gHVqbflqu3KNiFaGRki8GEmZ2lCwPKlfrRzQg
 AXP7bpE9ETqpBZLDJGCAZ2Cb3t5du232uTWMRaQz7Ont7TA/nxuMSc4AqL3zg7/LUgfghYni+My
 JKlYTSG1NNRes3LuMByP5h54CKb70g60jFHkh7Vcb5WHC1eAOIjjIzNTRLi65ZaBC/q4GGrgOKN
 lD923CkZMbu0FtxhtHxKzDOoOXOwURT3B7Q1pxv7RP3KXJZZXbRTBGJaAttpeI3iDJvxMmXUVWJ
 dRjA87wodgxZKiYL8eolTmWVxwNFKX7+YctPixudfb3D1HcqugVLXMYqI3F8jDf9EfOJjHwo2PN
 Bd
X-Received: by 2002:a17:907:3c96:b0:b72:6143:60c2 with SMTP id
 a640c23a62f3a-b7a2455ea89mr487330866b.51.1765106350805; 
 Sun, 07 Dec 2025 03:19:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm4lTrW0hH7FzCxhpneWr/HNep+n1546m9QrS9Hq+jAlniBKG4VCVaRNLj78aaML7/WIzIFw==
X-Received: by 2002:a17:907:3c96:b0:b72:6143:60c2 with SMTP id
 a640c23a62f3a-b7a2455ea89mr487329166b.51.1765106350418; 
 Sun, 07 Dec 2025 03:19:10 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f44595ecsm851349366b.2.2025.12.07.03.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 03:19:09 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lib: uuid: add EFI_PARTITION_INFO_PROTOCOL_GUID
 translation
Date: Sun,  7 Dec 2025 12:18:45 +0100
Message-ID: <20251207111845.172933-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Add support for translating the EFI_PARTITION_INFO_PROTOCOL_GUID
to a text.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/uuid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index e0f8d55438b..0a166320e07 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -139,6 +139,10 @@ static const struct {
 		NULL, "Disk IO",
 		EFI_DISK_IO_PROTOCOL_GUID,
 	},
+	{
+		NULL, "Partition Info",
+		EFI_PARTITION_INFO_PROTOCOL_GUID,
+	},
 	{
 		NULL, "Simple File System",
 		EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID,
-- 
2.51.0

