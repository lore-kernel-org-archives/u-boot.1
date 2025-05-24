Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E941C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 13:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A8E831C2;
	Sat, 24 May 2025 15:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P0YFrQgz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B67831FE; Sat, 24 May 2025 15:44:08 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63D04830E9
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 15:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85e73562577so83914639f.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748094244; x=1748699044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BhWs1hA3vTCAImvTiOQLtcJkVA7H7X3jrNx7/sUvGg=;
 b=P0YFrQgzidvlYhodEoEinNFLg8vr7oezcyDx6uL/w/4lZCNbewvihh59KPOFyvWuWV
 fw4VJ6q2EqcWvrioQf948aejvui6QDyn7QIpWxJFqUR6ZKKfm6kVi/dG9mQvSJRj5YCx
 7hUmSYjMLsL3Mm12EAd7EHbmnUwbxEoeaNFkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748094244; x=1748699044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6BhWs1hA3vTCAImvTiOQLtcJkVA7H7X3jrNx7/sUvGg=;
 b=oin+7KhZP1bvCPL4iCLGQechNk66qZQREIixwFDejHlq9crw03y/WYBx5GkYlu9Klq
 WsgM+y7q3PeKXoiFAeES6nuC9y3pSYirVd9WwK3Y+eVpo2Ulx8hq9c7YOEl4MJSWC8qg
 DD3F/pjg9/AUy5m8gZ5CUTj6zcx/rNMrwzVA5hyk9SbDXE98Iqcr4aZ1w4PwZKSCV5t8
 VtcBw9IUQvYYG9w8gbzAKZNw2HGLmCy45+ImgIUNlqfwm66WvX1B4PyzpRO3DaQfdsh4
 cDxxEDKJ5sC0GHpUFDLwNBhDBcZ6QPpGFB6HeSNj6XjGhaIdI8ufr5pc/ayJnEOVx5jg
 jZhg==
X-Gm-Message-State: AOJu0YwQ+EZbIXtDoarJwTda5bWIF4f/vmFgS+BinnJWQTQTIfAbWAuu
 IprQM06ejT+nbS+gO9Xp9JcgMjFp1j+lrd3dwhoAdoyZzHGI6yH1Oji15OOo1Pi1EIAXz9/NjJ5
 wTcLoGLlD
X-Gm-Gg: ASbGncukV0wJFhsOjkq344adEQdo7XY+DxhtbZULeqyaEMcU4lCBYalrNhsWvM/mNLi
 dfOZtWew4KvfiMsuiRsicKjpy7kUlcOBISIcYqgAYtqXb9q4KRWxZLSIsYs8htG8g9Sl32dA0ua
 YC3R1rD6Udq8DmA9Mc5fbs2O33qC9kU890Ee9wKPSG2ts5uQsfYKOtYYurMPqDe65kkzjQRUn7N
 YG0xsCQOesZPnKpd59NfWN1VuBXYDaE0ySsmZ8aB+CAAcdT1PicdHZAoCfDPUuEgJSuj6dOAGaJ
 P/Mc6d8EMy8h6omMM/YCRKwQXf6jQYovuwA4IRbpfqcr9E9Um/7wmX1+mGlY8G+DZD5oZ9DpVTx
 khIc+8wUBN/DD
X-Google-Smtp-Source: AGHT+IEBcaQ+m3qqe3Gz+XPNcJfrQx43b4skrxbHcuAaT1vOlHrTN93CoI+enLaWaqyYw5qH6F6htA==
X-Received: by 2002:a05:6e02:2185:b0:3dc:7f17:72cd with SMTP id
 e9e14a558f8ab-3dc9b724814mr23486425ab.19.1748094244115; 
 Sat, 24 May 2025 06:44:04 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc38bf26sm4033091173.19.2025.05.24.06.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 06:44:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] bootstd: Improve parsing on extlinux.conf files
Date: Sat, 24 May 2025 07:43:47 -0600
Message-ID: <20250524134356.939898-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524134356.939898-1-sjg@chromium.org>
References: <20250524134356.939898-1-sjg@chromium.org>
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

These files can have tabs, but they are currently parsed as separate
lines. Fix this.

Also, some files provide a separate 'menu label' which has more
information than the 'label', so use that if available.

Finally, we don't yet have the ability to parse all entries in the
file until the user actually boots the extlinux.conf file. At present,
this means that the last entry is shown. It seems better to use the
first entry, so update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_extlinux.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 71a9009479b..4b9e22b8d7c 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -83,13 +83,28 @@ static int extlinux_fill_info(struct bootflow *bflow)
 	log_debug("parsing bflow file size %x\n", bflow->size);
 	membuf_init(&mb, bflow->buf, bflow->size);
 	membuf_putraw(&mb, bflow->size, true, &data);
-	while (len = membuf_readline(&mb, line, sizeof(line) - 1, ' ', true), len) {
+	while (len = membuf_readline(&mb, line, sizeof(line) - 1, 0, true), len) {
 		char *tok, *p = line;
+		const char *name = NULL;
 
+		if (*p == '#')
+			continue;
+		while (*p == ' ' || *p == '\t')
+			p++;
 		tok = strsep(&p, " ");
 		if (p) {
 			if (!strcmp("label", tok)) {
-				bflow->os_name = strdup(p);
+				name = p;
+				if (bflow->os_name)
+					break;	/* just find the first */
+			} else if (!strcmp("menu", tok)) {
+				tok = strsep(&p, " ");
+				if (!strcmp("label", tok))
+					name = p;
+			}
+			if (name) {
+				free(bflow->os_name);
+				bflow->os_name = strdup(name);
 				if (!bflow->os_name)
 					return log_msg_ret("os", -ENOMEM);
 			}
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: boo
