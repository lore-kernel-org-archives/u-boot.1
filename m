Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A6FD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 15:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0401183B4E;
	Mon,  1 Dec 2025 16:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="o+GOH3sv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C55E83B5B; Mon,  1 Dec 2025 16:18:24 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0AE83B4A
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 16:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E1E63F20C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 15:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764602301;
 bh=i8OM+Srurx8Ka8VZ6kmaVvfUPMp7ZoOdo6Kk06/kxXk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=o+GOH3svsz5DOFQ04GLGFjv0D5DMhXWFKAkuEpuNdy+g/FAfDzckry5QvkPXtEOKy
 r2caERXTM5R7/cPvVuijO/kTgsF532aHRE0rTDqSyV5Z2OphkMD9Fp/8sNQfKb0zGD
 G+3ChWvq7L9322NJ/IcMNpPPzGeJKsEn6cj2KMRYqU1DfQmWjetdkMReHWyLWd+fKm
 +nPG68EeayFHqq1Nhy6O+EoinZPbMDutvyL3stsCQq8T3Fm3/anGzVmooy/83dLhwz
 Vhwvji9EGmueLONzgURBY8T+kWQ9kXV7AVbfeVaisd+PHssAanoNW6u+cRVreRlkVL
 yxp/4jhF+FvKvI1TFnhjRSLZ3hoEVMIHnrww4lf8IZla4cWx5csPEGxPV4tnGWyLHJ
 At7kc14NFmGOYRse48/hx/4uV8VGqa5JzmkVQP+LBcddiRhiMTRxH/iylSFi89F6kY
 n2BlkgIkNrnXvczUAdAXfjRU4Lndva/T8QfddhrYTFH2Sl2zW4YOI2sllX3SFD/vC1
 Q3a47wr9nxeMD0U0K4Z35NR4FcHAztV4vrz1HOPKT8m6V6eJb1yL9fN2CLHu05gG1j
 HAN2Qh+Xz5go+I/Q9TLVwLCaiffpuqQkHLnUj98LWciDXZr7OCINSmw5EcDMVCL4s3
 PI+6v8omndaY+iV5hBqopIHY=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4776b0ada3dso35128725e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 07:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764602300; x=1765207100;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8OM+Srurx8Ka8VZ6kmaVvfUPMp7ZoOdo6Kk06/kxXk=;
 b=azwu1IB7leJN1rvNVaduzEGdnOZz8xd5gyZnbNr+1K8mdY4Js9LF5VQG3kCki0inrI
 9bIciQELD2Nx1GmoPlY6c1b532LQSpLasttDPuis8Pku4oumO40n+mQi1zlS0GJlmQms
 uVxJhGLq4o9BFKx3MSvsnRfcVbV6a8CvGHz5lHch+XqOnGhwUQ+nbL4Tf/IR6DPOBqOL
 5RtNpcsw6iiM8/7WCoEm3omjgWaevvrHZDBpWj6d9Gxr6nxffsS0EVwdammFVCNVyYCz
 WVQw7/6VBgdYKT8mGW32J6IQao4D5Ds/GZwXAc6hJsCkJjXJuyAW7T9GEvq2XazosHmX
 F7+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK1z2miGp6WF6/q5U/GtkA30kd7aOPK6mMYhrXQtSjGM6GF9Fg1uQAr45BKW2+5jPpP0vboUk=@lists.denx.de
X-Gm-Message-State: AOJu0YxuMluRWgYHXJbYJg+J83s49ly3r8/M3rtADZFDReCC1gd2OCEI
 84tZUC2Y3RZds/ob5OTaivZetO4QRFJnGpOGmaeVwWE3SsumPiyjaW6w6tzn6Hn+jOfctfwxQdy
 76FzS5RxjJhXZbQdjcT74jppqPrNkgMxApEfSZDpkf/RmBUL8i96OVSw2uk1FLhGHm/uJTII=
X-Gm-Gg: ASbGncuPCGi3V1CTcOXpsI3l/WTCQnSDA4WcWt9paqcgYk8D813GZqKgikekbDBPmRu
 lZQytWg8BQOgqwkKTZaCqpf9bT85lK/oDEErOmr97lz592+kXRKRuG++DmBw/E+OU7h4TtwqXM4
 b04i9Kgu4+cAZCynPj8ySNVxP3bE1fPs6Eb2S8u0QOU9nsaKlTI6PmA6rCsnXxzUBqAzJo8K7eZ
 hC5txY/6x7sN2LLYCSBT1wxYDmJiNudird382Sv8rJrOxE9yptdDjBjf9Lm+oq9TI7sKbUC/38B
 7oSu4GqdN+3RkHI33Q9cFgFowtTJCFNk3oey6dBSmyjfPdRrJxNScTc5bGrVLGKh/xc7pQbt5Ap
 xO+jJCSlT65oX/D24galilfqiSGNoD0+iD8OFAcaZ5AWgIjEyivQfPcSKFg==
X-Received: by 2002:a05:600c:3784:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-4791348cca8mr123873075e9.9.1764602300079; 
 Mon, 01 Dec 2025 07:18:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcmthSZ+913RrB3W+EbiYk2cwmRb8YCSXDTkxJSNKObb80zDpcw13H2Ly85LdQLgcKc0nj8A==
X-Received: by 2002:a05:600c:3784:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-4791348cca8mr123872555e9.9.1764602299598; 
 Mon, 01 Dec 2025 07:18:19 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4791164d365sm243346135e9.12.2025.12.01.07.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 07:18:19 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <zfsdt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Walle <mwalle@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: lwip/wget: avoid NULL dereference in _set_cacert()
Date: Mon,  1 Dec 2025 16:17:24 +0100
Message-ID: <20251201151724.338924-1-zfsdt@canonical.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Running `wget cacert builtin` leads to a crash in _set_cacert():

    Unhandled exception: Load access fault

Function _set_cacert() dereferences variable wget_info.
We must initialize it before executing the cacert sub-command.

Fixes: d3761a31ef09 ("lwip: split net/lwip/wget.c")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/lwip/wget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/lwip/wget.c b/cmd/lwip/wget.c
index fc9bc11cd83..4883ad61bce 100644
--- a/cmd/lwip/wget.c
+++ b/cmd/lwip/wget.c
@@ -180,6 +180,8 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 	ulong dst_addr;
 	char nurl[1024];
 
+	wget_info = &default_wget_info;
+
 #if CONFIG_IS_ENABLED(WGET_CACERT)
 	if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
 		return set_cacert(argv[2], argv[3]);
@@ -214,7 +216,6 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 	if (parse_legacy_arg(url, nurl, sizeof(nurl)))
 		return CMD_RET_FAILURE;
 
-	wget_info = &default_wget_info;
 	if (wget_do_request(dst_addr, nurl))
 		return CMD_RET_FAILURE;
 
-- 
2.51.0

