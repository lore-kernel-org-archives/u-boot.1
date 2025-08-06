Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFFEC87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D1E383A62;
	Wed,  6 Aug 2025 16:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dAGdUaKn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6187183A62; Wed,  6 Aug 2025 16:55:29 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB47483A7A
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-741a8bb8aa4so2553a34.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492124; x=1755096924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXn01Z8bCscYCNUYxbNEqs5TeVlHFGxhgRZ3fVo6MoQ=;
 b=dAGdUaKnjFwm+XhMcIfddPmdyTJ0ZvcAl3EJG9iNz9guqlwuiZov46Id7SGBo5uKQw
 kqgoudYniXncjoUo3KBWWyDXEtIdZ3SJquHGlXq7X59uNDCUIjRC1ZMYJpYOWTAglygZ
 L7sRajEid7KFuAappeD0HfMTtzhCHy8c/W93Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492124; x=1755096924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mXn01Z8bCscYCNUYxbNEqs5TeVlHFGxhgRZ3fVo6MoQ=;
 b=tOzoipWAAx30qap6VtVotw8iZtEKPgo5sMqSUi5NJxlus96Lg/dLre8p1xyCF8Hk35
 BTwkHGqmYs6zbU6rZQqOguSlf2+R1IaJBQNn/eZFfz3hwHaJ/j6uLdppD5LYzq0NTJYb
 sKCsrK6YKxmm7jxxQiKLbIr9inn81tUL1gx3S5GDz9ln6DrzTvqjiDFY56amUoFV7QqC
 LnWUM9W+bsdCP3VSre9QLWG5/b/JKafbrrAVoEEpZNxE1Dc1NKxnO00bwZW1QRL/be4m
 fOidvlbFwrlUMiK1I0n5x31Ivbcpb2n78BHjh55in/uYgEOHO5cLIr/KHD5o1fIZ032N
 c01w==
X-Gm-Message-State: AOJu0YxWa/hwFCaUhIXPRzu6H/DiODb4d9VJCn7R2EU+/aB0J2+W7gMM
 y0IjzFSb/BdlfPh0MzlSFJMCiiuJF9w6IkfmPYE9sxRhFLtZQYLUGaxHVCdK75yhr6m34V/Gu9T
 69bNWS3s=
X-Gm-Gg: ASbGncu9TonN4pmdx8Rs20YXfmmv2WqtSrjX9Q4ralpexN3wwXHW7LnlTVtgSoDytTa
 zNcoLDbQCo5cNxGK5Qn3rPCVMnp+N+T74zoWLDa32gyQMsB8ICtzf99XXttc/QMj6SIkp6IKSC5
 D+hzgjx+SCa/SBwlPyuv4NM36hZUU0cZN6xDEupgi2WCVlXf4zAZeZoZJH7Dm+i8q710Md3Uc9T
 /WngO9x3UVFPIehM4mtDtmuiLxRQHdEvuthJ+OdJrgGmcGNQ74suUsCByV7245WDYH/MeEcewwK
 icfJniyxikCfUyrZsi2GM5oBCPPxyqf7TTQ5Nrtkoi9WTpNxasw2W5FyVZwh9qq0grXVk9FUocL
 kZP2WxMO31sFDfLr3BYzJNOlFAT4ub94SGCkh1kvny67OceAee0Gay8cKwjGCbUNEJ1FilA==
X-Google-Smtp-Source: AGHT+IFMu7sOiPgyJpUaBsVcC5q9z2WssjR8EeBfy/PuTfhC2/qSzHqMFLUJK+f6zgkr4bMEIuRKeQ==
X-Received: by 2002:a05:6830:2692:b0:741:b500:a412 with SMTP id
 46e09a7af769-74308f15834mr2552314a34.19.1754492123825; 
 Wed, 06 Aug 2025 07:55:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61b4e4ac995sm615670eaf.18.2025.08.06.07.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:55:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 3/3] tpm: tpm_tis_infineon: Make use of 'z' for printing size_t
Date: Wed,  6 Aug 2025 08:55:19 -0600
Message-ID: <20250806145519.1664444-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145519.1664444-1-trini@konsulko.com>
References: <20250806145519.1664444-1-trini@konsulko.com>
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

When printing the contents of an size_t variable we need to use z prefix
to the format character in order to get the correct format type
depending on 32 or 64bit-ness.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/tpm/tpm_tis_infineon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tpm/tpm_tis_infineon.c b/drivers/tpm/tpm_tis_infineon.c
index e2f6238cbc71..de6566fdb9e5 100644
--- a/drivers/tpm/tpm_tis_infineon.c
+++ b/drivers/tpm/tpm_tis_infineon.c
@@ -396,7 +396,7 @@ static int tpm_tis_i2c_recv(struct udevice *dev, u8 *buf, size_t count)
 
 	expected = get_unaligned_be32(buf + TPM_RSP_SIZE_BYTE);
 	if ((size_t)expected > count || (size_t)expected < TPM_HEADER_SIZE) {
-		debug("Error size=%x, expected=%x, count=%x\n", size, expected,
+		debug("Error size=%x, expected=%x, count=%zx\n", size, expected,
 		      count);
 		return -ENOSPC;
 	}
@@ -429,7 +429,7 @@ static int tpm_tis_i2c_send(struct udevice *dev, const u8 *buf, size_t len)
 	int retry = 0;
 	u8 sts = TPM_STS_GO;
 
-	debug("%s: len=%d\n", __func__, len);
+	debug("%s: len=%zd\n", __func__, len);
 	if (len > TPM_DEV_BUFSIZE)
 		return -E2BIG;  /* Command is too long for our tpm, sorry */
 
-- 
2.43.0

