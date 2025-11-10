Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0575CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 13:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B9B83A24;
	Mon, 10 Nov 2025 14:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MXSu40YO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0EBE83A28; Mon, 10 Nov 2025 14:38:06 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39228839D6
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 14:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7a4c202a30aso2333082b3a.2
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 05:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762781882; x=1763386682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HMMT+XpZcR/2OF/S4IkQcV0Hrx1iYfeFosdwEODKJ2I=;
 b=MXSu40YO+2CStqrCBRUtWcnuma42FBTFhRTRqBd2z5Gm9/QfLu6MAZvP6gW6VHvp/X
 xG2yrH1w5jTlAqoVOnHigAzr1YbvIDcgYAUj8UPMvIJcLkrr80CbqbbDie8f9Z3K7Cdw
 baFrYwtRstAKz6drJr6yj1kkpt8dFziHE56IM7q8COjY58LhqcaIG70j4TwPTpvOXYU8
 hJnEffXwBtnNciKDivsu3uCGGGHPwytdtfzuSBZvoQRxHT9xXwZetNWxEcEBUb6R2Vbi
 g0e9yALgdIRO+IkSH0gaf1Mgdd8WQXSyiNScGIjR9NLpa9/afFtnOFn4U/2wUvtp7ksO
 uINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762781882; x=1763386682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HMMT+XpZcR/2OF/S4IkQcV0Hrx1iYfeFosdwEODKJ2I=;
 b=mamBK8OOjyEfYy+VXi48+A/KlyBWO/XTWFlQM+/6yLrh6UpVV6+ikOu23ul+x1USIC
 G403dLZs2G6l2/a60UvSDA314dnefeU66pFe10XX+AyIAKqqadfKknihm+vLwoXqAZBE
 a0+FI5FNNNySfRKdUU5tTM3anT/Y2KOKwZUN5EnS+Zp6OwPImEJY0yLVUkgnQSxrPBkk
 /kXp4YN8GI51af5zxSX7S/yeC0Q27vfntTjOESINXkd16kOP1FL26YPYPmZjGzqEe0QT
 yOdjCv4M0bl3igzlhJGI36xJBrC9H9zZ/UEZwxdpKiqRIdj8ms5YMdtB2vW5QbvaO3K7
 O/uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt3rckd7tl14VBb+2HY7v056Wsz9ydbTtU6sEIogfcZ+z7p5hEmbfuJ6is0p2+UsNDC673TBw=@lists.denx.de
X-Gm-Message-State: AOJu0YwIwfZu0a2vO45KkbWSv6YZizvz59QekckXtmfBA2Qk0vgGXkWy
 pwO5FAh8OQLmjlJe12aFXPzMUgw+ap1pPKWzdQl90KTyyrN34xR/o+IPzhhL/A==
X-Gm-Gg: ASbGnctMXVmmKxQxzZ9lndvNShgn7gzflkfr1j0L/OXwPz0ax7yPKftApyj2j7+XJk1
 pYxmJ0TR6XYdKNwKOkXjGFvngedpmqkufMOJUFWE0kdyI04v4d4SemXKDlH6XeaodDtWZ6Bptwh
 uGdKnmUdod3SiKgR2sRZhHlmHmGd+usdSBY4R0QVC6T6tsx22gAw/J5EyFS53KBBWxVFaziwMer
 MfwZecNEglqB9Kn8uNCDpDMfkf+HHWwAm1pNsFEqbkJ9PSY14iHTuffwvsgi2xF1QrRcmJQjlEC
 Zxl7/TNXvpDLoNSs/TsHNuuJXtJXbv2x0ZEutuiyF5BovHD5/bPeR6qHmjDfj0LL5nTMnf0bGaD
 JwtVbAkoKVlY5iPRr6M9kk0BXuqNQcu6BYhqinyvfR/+WM4pD1pNIRG2Efuh8kmZghbsX/1A=
X-Google-Smtp-Source: AGHT+IHcCjQVxcnP5xWhvNcp7ZFZkbfWMMLqCxeV8gD6uQjpGTZP+E83DRJpgijache+9Do+MFQW8w==
X-Received: by 2002:a17:90b:4f8b:b0:32e:d599:1f66 with SMTP id
 98e67ed59e1d1-3436ccfef31mr9193421a91.30.1762781882474; 
 Mon, 10 Nov 2025 05:38:02 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341d0daabd1sm6037072a91.8.2025.11.10.05.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 05:38:02 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH] docker: Use GitHub-mirrored TF-A repository to avoid clone
 failures
Date: Mon, 10 Nov 2025 21:37:58 +0800
Message-Id: <20251110133758.1644822-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
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

GitHub Actions consistently fails to clone the upstream TF-A repo,
returning the error: "The requested URL returned error: 403".

To improve compatibility in building the docker image with GitHub
Actions, switch to the GitHub-mirrored TF-A repository instead.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index d2384219c06..201a1cdbac1 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -243,7 +243,7 @@ RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
 
 # Build fiptool, bl1 and fip for fvp and qemu_arm64
 RUN git clone --depth=1 -b mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
-RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a \
+RUN git clone --depth=1 https://github.com/ARM-software/arm-trusted-firmware.git /tmp/tf-a \
 	-b v2.13.0 && \
 	cd /tmp/tf-a/ && \
 	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
-- 
2.34.1

