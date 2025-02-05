Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61447C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF70B8033D;
	Wed,  5 Feb 2025 17:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nf50k6NP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD9580711; Wed,  5 Feb 2025 17:26:21 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5492F807E1
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-3061513d353so69364501fa.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 08:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738772776; x=1739377576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o6h5BNFPgAxLkdCCmo5G2n2N3SNhUaU3hTwHGpmMFck=;
 b=Nf50k6NPMURxP/5cPvDYPfEgDN9wKN3zj6KfHH9SObSf9QFg0FIVzrjiq/5LgBpYcE
 FJ1bvxMue39aE2SR696768R9bhVhi1uG9ZhevqrId6uUVRrbk/dZSiEG8gRZQY+F6/fL
 L6IlERvOkMNQO6EEDL78iSRiv8SIz9TzHwZVDqqeR2atvuDWYhukz9VVPd9omfPw+dN/
 BRq3Dp9B7zLxC3Et01Om5dDbRbeIYsKT1BRDkPV7xFw1pklhIu36TEsWdL2HIMX1cgHa
 mIqAA4a0repEa7vDQuuALu6OSMQUZehKPZ81o9CcclcJbLNQOdGHRrnXK6IPhG+30DPa
 uqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772776; x=1739377576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o6h5BNFPgAxLkdCCmo5G2n2N3SNhUaU3hTwHGpmMFck=;
 b=QMEA7/MoxlY+2IQ+jlsUoUoOxtiE+hqnK60PRg1qGY8QxKj2gR8s5SsWO1U6MUoPwt
 Ut9v5qHTdK0HB87X3BnhpHAd65h+TfX1OI9KVzckpN1x9YjMNLrMoHUiduVTlivIpNX/
 NYr4AD2lgFX5pml+PyXNUPpUP8vegr/WnBVel97glxzpFvk+BLmvw44E6PoCUeQn88IX
 WI8OzM22tly8LkSNK48l+lE+9AqxobUF03ixXkM5QmlLyYisRmme+yOQE+5bc/a1mIGt
 aRaopn9DLDcuWYJ9zzv8Xz7yF1BT7INisCcoOwHD7V9Xh/dfgNiGPfNsCy9EO+12/Waa
 5m3w==
X-Gm-Message-State: AOJu0Yw1EAbGfVDriKRvjGshRW3AUBsA+2D/NhxZ9lD8fHutSPnHkVxi
 mClsB3YTkjkpQjjP+9kojTWy/HlgxIk0i7HMZ4kGgwSDW6xILVGn02wJZzU/
X-Gm-Gg: ASbGncvke0/wVJaJvw/HjGge1annNCooCAXCMfq2vsXvx5M+UYtv4wkHTK+FZOIU4oL
 lbXJFWC/hWVrMrEitLnyonOZt4lkJci5PnxU037rFp04/r9j57BJ5iSixtbvayKEoIJqQWPkJXx
 ZdekJoZnB347Mk47w24POGgLuujE7VY1z+RH1Jrb4uQiEgxm9l3gkz/SYWvz8tLSX4RTA6R9rEh
 7eBbjvQcRfFwFpjMwXnCppC8CPntO879R3JegV045BSno0Co2nhynAENdsDVppaMin+P9YTLQwb
 rp+ZuR0pifHkK9tGCyRM0x0=
X-Google-Smtp-Source: AGHT+IFGs8svncIBw2T2tXON1UsLJdekwFM7fttmRLpSaplWiLQeVljwHxqqWTiCflZDbI1WnSR9OA==
X-Received: by 2002:a05:651c:1614:b0:302:264e:29dd with SMTP id
 38308e7fff4ca-307cf370987mr13599581fa.24.1738772776087; 
 Wed, 05 Feb 2025 08:26:16 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-307a3428055sm21457241fa.98.2025.02.05.08.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:26:12 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: proftool: Fix potential memory leaks
Date: Wed,  5 Feb 2025 19:26:07 +0300
Message-Id: <20250205162607.2473994-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 17:53:55 +0100
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

Dynamic memory, referenced by 'line', is allocated by calling 
function 'calloc' and lost when the function terminates with code -1.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/proftool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/proftool.c b/tools/proftool.c
index af2cdb6d58..c7b427f307 100644
--- a/tools/proftool.c
+++ b/tools/proftool.c
@@ -676,6 +676,7 @@ static int read_trace_config(FILE *fin)
 		if (!tok) {
 			error("Invalid trace config data on line %d\n",
 			      linenum);
+			free(line);
 			return -1;
 		}
 		if (0 == strcmp(tok, "include-func")) {
@@ -685,6 +686,7 @@ static int read_trace_config(FILE *fin)
 		} else {
 			error("Unknown command in trace config data line %d\n",
 			      linenum);
+			free(line);
 			return -1;
 		}
 
@@ -692,6 +694,7 @@ static int read_trace_config(FILE *fin)
 		if (!tok) {
 			error("Missing pattern in trace config data line %d\n",
 			      linenum);
+			free(line);
 			return -1;
 		}
 
-- 
2.34.1

