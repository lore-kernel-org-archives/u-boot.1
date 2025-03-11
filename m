Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC49C2BA1B
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 07:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C47814B6;
	Tue, 11 Mar 2025 08:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G3Q+E3+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31DF8164E; Tue, 11 Mar 2025 08:35:00 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 912848144F
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 08:34:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5499d2134e8so2696643e87.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741678498; x=1742283298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2odm2ZMkgsqgfCXNjk4YJZ4/5cmJuFmc7W3JLfwvcMQ=;
 b=G3Q+E3+AQm5bkj+MU8XNP2ESDFxjIcUV2iuAYon8TtUdMgY8a1eq76v7kSdqMuAPxx
 9Z3oVk8dQYztwb2hBrzBBRUB191+w/65skUQ/02+LK/hH0XfZSZ/YmIKNk69JzwYDS8m
 BcSGZq1Wl+2O+Oc8uVnVPl1Zi+VfvV+Sowy9vWAEE0finIi3ALM1HwrrjROau0qJva+r
 As3EzF7xkUmuQXXrZseKCB6vGHmGz5wamXSgA5mOODogJo7JwHeTPKrWFwCTHSw+zxRE
 ZiznfIzTYXxtaWW4c5crKoyEKxDRmprr9iCThfyzvaLxKwbNvQfYepq2jUQ4xEO+vm4z
 wtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741678498; x=1742283298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2odm2ZMkgsqgfCXNjk4YJZ4/5cmJuFmc7W3JLfwvcMQ=;
 b=stQBhQqJigmlr+7Fu0rQ6bmSRV3ceJzPVPUf8i8YRe/utknea7xlTkaliHk4HlbNHb
 OboG76hgfdFF8gyoIeamVuRYoJbRv8RBGOlbreV34VKYxpbbdznjT3Ixzxj0mwACD1Aa
 AYuwlLaR4hLqvWNr3L9U3XsoHDgb2bKr3TIgqnsr3+h+9BO4tgYHtSwQzpyQd36wQz/8
 dOf8t+TJO/Rei+arTB42xb1TpYXSEfVmuYMPcInrhrfrWF+xJ9uxjKIsx/Ff0ut+xzZX
 m6AxeTEq8PSF+WwnzAGFAblIs5Fpzm2s9FhwkSADjtgCXpEcykoZH6UAtoA7NHpiMaiO
 lPAg==
X-Gm-Message-State: AOJu0Yx5EnjmUS2/JnfL4EUus8PPd43sS/icOSYoY5ZwLKVldqjQ5fTv
 1ACxZUgdpPg+VX5rdItv6HQMLl4KWXXlYiQsZdp5YeYV9hTM5Y00
X-Gm-Gg: ASbGnctuobV/iqdFPl+zt0C2V42Pz1FOnJE9cnY/p8fBskWhSm7/Tl8dvNm6+F/YOF+
 f+HLnuWfKDrAgKf7wNbP8upeVNyUA+5tAzVRuNErBfpRxkidGJGZAUqAOKCxUn72BCgDZXqTJhu
 YzAeZaPooRaWGeDyEZneA2lURU+uAvoLZtoaAfEXIIa7vb7iX1mJK/WC0y2iPO+dnG04dsIJrg0
 8xqrsYY3l367b3HkXimFQYpsGHYKvn2ZvUp9Nq+SqUnkRdhAaNUWYd55oinGMmnTs1gUKRsb0bZ
 brYoG7xaGoU2dRpp/+XlV0c07pa6iz4xAnHu
X-Google-Smtp-Source: AGHT+IGErGbRANoafT/pRjwMsn0lCmzZ0721YC/KaTCn5DMaoBHtwO0dlc7IsIVdonjTWTIIS/nfoA==
X-Received: by 2002:a05:6512:2342:b0:545:8a1:5377 with SMTP id
 2adb3069b0e04-54990e2bce6mr5100262e87.2.1741678497477; 
 Tue, 11 Mar 2025 00:34:57 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5498b0bd196sm1676430e87.113.2025.03.11.00.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 00:34:57 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] common: edid: update timing selection logic
Date: Tue, 11 Mar 2025 09:34:37 +0200
Message-ID: <20250311073438.13428-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Older EDID timing algorithms relied solely on detailed timings, typically
optimized for a display's native resolution. This caused issues with newer
4K panels on older hardware, which couldn't handle those high resolutions.
To address this, the algorithm now also considers standard timings, offering
lower, compatible resolutions. Future improvements may include checking
established timings for even broader compatibility.

---
Changes in v2:
- shuffle code to improve readability and avoid duplicates
---

Jonas Schwöbel (1):
  common: edid: update timing selection logic

 common/edid.c | 308 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 273 insertions(+), 35 deletions(-)

-- 
2.43.0

