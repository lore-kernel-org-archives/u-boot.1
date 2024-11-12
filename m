Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE613D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A57189458;
	Tue, 12 Nov 2024 15:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZkyPm1lj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F63189455; Tue, 12 Nov 2024 15:11:26 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4D958944B
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83aae6aba1aso203836539f.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420682; x=1732025482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZT2CFKII22ohj3AnIFm3MH72P5ppfQ6V+eKscDiEFE=;
 b=ZkyPm1ljToIJvdA7Z3mjY1eNF5zh66ctfDT0woHe6y1I/Yy5U3XgObG4MgF+PZT493
 6xS84XpBvGYDToSOJyt3zmZLR0ZhJq+qEKv5IqMIrelJGZa3f4/vaz2nvn3nBZZK4APQ
 /ZT9sBhah1daAMuITEIqNBHtcQlYa2/A7U0AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420682; x=1732025482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZT2CFKII22ohj3AnIFm3MH72P5ppfQ6V+eKscDiEFE=;
 b=sPg7GTk7WX+zqE/4eLjwiHcVsXV+K0OjgoM4kkd6bzdibW9K2KmTO5CpujJJjzX+/F
 vnmfTKCgIf15xbUKb1qB1VKzYK6mgGhp7aXX/b5DQ34ryOtsGOfr4nnFofNB629rmsMN
 RsFiZC1T4fWueKxM0iu2GF/peDPldpDfKE3OSltn5ED5qag+XF+NM6hREsTmw4gdN+Me
 BCr126kb7ZJ5i0aPCll43lVMedT2XEIXN3qFpemmOTAtz9MmsWVUfVWHs7ERMuhdSHO8
 pLq5soLmz40C9nElO53wqzubt/4gwma9s8jNI0vOqHIBJg30dhZAgIt3DtsIPnnynHJc
 vF6w==
X-Gm-Message-State: AOJu0Yx8zx3iAguonRy2ak2Vrb02mRnSIv/l1fpaTw2BJe/5M/vjSmhF
 m8uO8sQgyudVhV67CmOK25+JNj78XX1ixC+9v9xzkZbRnwNsOtTUM9h3UvlJ3ROG0jF5fzNINPI
 =
X-Google-Smtp-Source: AGHT+IGPQ/krSV+oMoW01OpD5JuEeQL5TiynkuFas0GGp528IqS8W5NJiTXy2mWrEU9sJT4/rn4o9w==
X-Received: by 2002:a05:6e02:1b07:b0:3a0:9cd5:92f7 with SMTP id
 e9e14a558f8ab-3a6f1a6eca3mr190681655ab.17.1731420681868; 
 Tue, 12 Nov 2024 06:11:21 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de783d11f0sm1977776173.0.2024.11.12.06.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:11:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 6/9] docker: Fix LegacyKeyValueFormat warning with
 PYTHONPATH
Date: Tue, 12 Nov 2024 07:11:02 -0700
Message-Id: <20241112141105.640189-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141105.640189-1-sjg@chromium.org>
References: <20241112141105.640189-1-sjg@chromium.org>
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

Fix a warning due to the syntax used for PYTHONPATH:

   LegacyKeyValueFormat: "ENV key=value" should be used instead of
      legacy "ENV key value" format (line 304)

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 048a57c5b16..aa97dadbd64 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -301,4 +301,4 @@ RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
 # Add mkbootimg tool
 RUN git clone https://android.googlesource.com/platform/system/tools/mkbootimg /home/uboot/mkbootimg
-ENV PYTHONPATH "${PYTHONPATH}:/home/uboot/mkbootimg"
+ENV PYTHONPATH="${PYTHONPATH}:/home/uboot/mkbootimg"
-- 
2.34.1

