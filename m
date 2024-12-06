Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91442E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6818C89641;
	Fri,  6 Dec 2024 03:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Na/XZfsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A32895DE; Fri,  6 Dec 2024 03:37:00 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 944F589645
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-843e9db3e65so61409939f.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452616; x=1734057416; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJSkpd111H9dx5eXhCnd/ejEAIAyryOgeVfjxtaJjmw=;
 b=Na/XZfsyVijpUVGPfhilVYJYX3LYcOUbWCupVREvWS3rTRJi2E6EtCch+hokMctJq7
 dJVpdQqGTjsnsIeHcdJgD/Y8nbOBm7RmiMZqZ1g9PcIZ+VT+82JT8JBiKB0KUlEvuHZY
 Jez3ORU1cZTSuJvKZxiBfIOeqZ3aignAdOMQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452616; x=1734057416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJSkpd111H9dx5eXhCnd/ejEAIAyryOgeVfjxtaJjmw=;
 b=wpf9poquWwOyCj3U+iYrq8JKlLqllhwPG7KLGa9VZOwIozIQ/49fYHtpTI1w6NxSVr
 R37I8CzSeLwzBFiKWDZI56c9sgs+zE0AalJClWOKsB9aQZB29l9Yajtg4AuuYSnLDtgB
 8wdLIbml85Yrmk9u7WizTLm/+ALW/TctU3lIe5Z5b0bsqD7wWqWRACT37dybrLIDLUJ4
 LawqFlkBruOws3/g5o1+4yZGFlhNyi12VtS35f8cn4vUjAsJdN8pTSbs+GM7J93IlvWf
 8q0TsF95SdzqBCnR43boKTC+7FRK6Bl27DRuqZxEpS4J1mpGDbNO7CKzKAJNMkHfJNGy
 SNZQ==
X-Gm-Message-State: AOJu0Ywf/u/OgxCAZJmPogakZfWFAbjENRvqhjHJIbI/XfxbfX6DC416
 llfqcOynF7ulnLMnm4hmsCod81Zoj7jnF0dFZ+bpYjTC7aXAo7+BaH7RreLXfaQURGMChwMtmdw
 =
X-Gm-Gg: ASbGncsEyEvKE0BDW9fiulA0mjSqfaWlATPUTP5PS3kvSl1dGYB6GZNhMVhF4Piyzuq
 7/IzRzX8m8mwyZKC+2J+Yel8961WY9qV6B3pjC/jkHKNpUs/lbHadEruLBKuezIdhOjnOp7Xk65
 xs3jNkt79MhL4G6Bp9ipr0n2oSpBUpqa8aTMBgfE3YVlvDs8+/jU3tVaI0R3eQZhmk7zc0yBTwn
 kh8d6LHLxxmvwxJ7zN276KMhwHyUfRcxsUexTBocQ1P4Pc0u7HTtUWi4axytkKMLBJPgfX5zhO1
 JEYprxFdH5c=
X-Google-Smtp-Source: AGHT+IHgBydP1q23uaYlu2q4xXQF4gyl/Fm6pB5mQ6qIjpib+8i3QtNqbL420Qk/L3VJuxbavPIu2w==
X-Received: by 2002:a5d:948c:0:b0:841:ab27:acac with SMTP id
 ca18e2360f4ac-8447104d95bmr574088639f.2.1733452616305; 
 Thu, 05 Dec 2024 18:36:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:36:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 09/46] boot: Use strlcpy() in label_boot()
Date: Thu,  5 Dec 2024 19:35:48 -0700
Message-Id: <20241206023626.2456858-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

This function is recommended instead of strncpy() since it always
terminates the string.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Split out strlcpy() change into new patch

 boot/pxe_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 82f217aaf86..e96935896a9 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -558,7 +558,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		}
 
 		if (label->append)
-			strncpy(bootargs, label->append, sizeof(bootargs));
+			strlcpy(bootargs, label->append, sizeof(bootargs));
 
 		strcat(bootargs, ip_str);
 		strcat(bootargs, mac_str);
-- 
2.34.1

