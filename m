Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABCEC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C9E82BF6;
	Fri,  2 May 2025 16:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dt6MdxKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809AC81F7E; Fri,  2 May 2025 16:49:11 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4867A82C49
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8616987c261so73233239f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197347; x=1746802147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41DlzrqZ084uf62OODPjOyaVyUjNEXnaO7iji7Rdxzo=;
 b=dt6MdxKUrjVGwK4VVULbWb2JDxw2b8240APHxeb/NQ5KwUlIm+3Vs+FG2aZ2gfHkkM
 GyGL1Y041CE2BwAxK2nG+liarr+YFDhVT6hS//qRuYTRcVdUaAQZ53DLZdAxMgXSls4K
 Bs40+Cgi2Uqnn5juQH2Vn+t6ktsfDYtNR2ca0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197347; x=1746802147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41DlzrqZ084uf62OODPjOyaVyUjNEXnaO7iji7Rdxzo=;
 b=MwVZAZ4qm/eHUuv3cUC/4pjneLOD9NjMwEURnh3bS6srO7Fya4PaLuHij4E1LkNrLP
 0amxNskEa6lKwLL44+LDgsSaGWkPpCut+c6G+efHoyfYD9LXfJCVxn3ksyjZXar29XCH
 1Me6cSqVSmZ1vJMigOcEi46jCaxwpKWPxOEM0fMJCC9JwRev3T62h2CXEW4nPUb0Lkn6
 AwXBFZTlpisJNF+31mfBjVpwEPx7MLRLNW5bwYRMT8UtfpFS+Mtrnj0U4gVE7DpCSoZT
 RKerJhzcpy8dUNFPtEAwEeFpHF3LTFQz8Ro4dDJkIj7lxJwgjqmu+sRGRJsvT3WJLVes
 3Pyw==
X-Gm-Message-State: AOJu0YwMj2JezfSkehFetK89KmQJDDZYqDDgE7dJEdhepL6rIjxK8WJ5
 uouKqDwyh3O8t/bBHBs47RKgEHjU8/fdO9SLKPRGkmYxbXl8F2sUt1LKTHJJZ31Ja0c9il2Ou0w
 =
X-Gm-Gg: ASbGnctdVThwRYjQS/79oL0bAnEZH1JHO3mL9qRs7tszfhs7Jw7jiLDRzawmvx8f6xf
 LuJuLvxNyVUcxXkkPrmwon6tw36pEedOG1Z2LZu0RUi3l7+zFrRAqdYJDxz+HTcenYGrrIYSHab
 Etpr4GcbFOtrcMxD8KuOaMQAGHhL7ajgpuVCzYLrMbqqRsyADSg8jYoGC5vUpFrsaCU4nVP4+a+
 QzbmYOOBdIuN8JSCr07hpgiHHXLSG2fauA9U/u75B1TF6jp7YO8Wx5Ti0HHrRz0U3AaM391EzCb
 ieRnJftjIbgqQRYocWeL0Ri2N690Uysft2S7bHHgXprtIx7PS766YA7VXHTCKTuwKtqEn6XOADZ
 Mow==
X-Google-Smtp-Source: AGHT+IGicoQ9bHi29zORBu1+TktWJQHJ5rBg4614n90dGjfb3Vr2IP28j0MRAtwD7k3iEpLfW4UNuQ==
X-Received: by 2002:a05:6602:380e:b0:864:4a4e:1c2 with SMTP id
 ca18e2360f4ac-8669f981e51mr471188039f.3.1746197346988; 
 Fri, 02 May 2025 07:49:06 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:49:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 53/60] expo: Adjust expo_poll() to avoid looping forever
Date: Fri,  2 May 2025 08:46:51 -0600
Message-ID: <20250502144718.313633-54-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

If the user does not quickly provide some input, exit so that other
things can be done, such as searching for the next OS.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index 7dbcac78c22..ee8ffaf8920 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -326,12 +326,14 @@ int expo_poll(struct expo *exp, struct expo_action *act)
 
 	ichar = cli_ch_process(&exp->cch, 0);
 	if (!ichar) {
-		while (!ichar && !tstc()) {
+		int i;
+
+		for (i = 0; i < 10 && !ichar && !tstc(); i++) {
 			schedule();
 			mdelay(2);
 			ichar = cli_ch_process(&exp->cch, -ETIMEDOUT);
 		}
-		if (!ichar) {
+		while (!ichar && tstc()) {
 			ichar = getchar();
 			ichar = cli_ch_process(&exp->cch, ichar);
 		}
-- 
2.43.0

