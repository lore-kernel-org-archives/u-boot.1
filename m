Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D55CC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E810982C30;
	Tue, 10 Jun 2025 18:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IjIgtzQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05B2382B07; Tue, 10 Jun 2025 18:23:42 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E067782B26
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so73641585e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749572619; x=1750177419; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4WFg7zJJpCvbGnKKRpsDG+6612UmbyLcthuXKtXgYGc=;
 b=IjIgtzQd5M+3I8mOlFE0kQDBFaPzLnEgNrrDTwQCAehGKqGH+OgOC09G8YbRalZJov
 UaYEXhCdy1jglyVfaEAD0X9Af2L47qJhD+7gh1pRw1Xg/C1eiZwxnheLi/pzpAeQ7CVy
 I9KcM2EdIqRCdjpTC0KO+/4h2+RUWvrOpPoyvlKU0LTOcAbv8fzHbFdNq0VQinpoXTmg
 4drZKetUzqnUv1Hfmi15FCrzcqsuXXqjQVwOMyRMmh3jdKXWBZ5oW3AEwfTboN+cX9YR
 TNSqUvB7ms9wpn+Tx73Lh6QC/xV1gw5VBJ7PZRPnxJsiOK80VPnWLs8r6meTA2UcgIki
 Z0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749572619; x=1750177419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WFg7zJJpCvbGnKKRpsDG+6612UmbyLcthuXKtXgYGc=;
 b=mzSFpmeEqeTQQenHb45KKYhFDpk7VVayEGZOpNiehMDPB68D4KcBIl3qPeBY7cAaLE
 Zl8HeCozmxlf5gApWjROtBz66+IK8CgD3Hpk3b1a+szZ83g67iY1QJP9trIkfcmcrkN/
 AuKY8bxPSAfI9dc3M4uXIeU9v08kS6aUPE5+KT1BnwOQSIMlY7w4ikOvDc5K4zmWLh7C
 xoAJdtPZTwqwFILf7ldNviZVRxE9YFXbLjys/UqM6RX1/NxLtwYViGWYX+/URLVdkxE+
 Z/eG8RuQYYhO7JcMsanEyFiEKbgsGwomRWOG7QEk3svgdvWFZwW46g++vfMiw7vSvvdi
 s6Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2zPK8GeMAtNnkOIiemxGbUAPyhxBujLjVs6/ua3p1kakYC9H0v7LjJHxfaeFxpKl12/92qCo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxbw4YlwNLbOIca0ln+hlKa3cTFSZlSGJjiz9BSLzCnODpyBl3o
 GsEmcUSdy5k+e+Tc8yG50mPqrKpVJmlGDjip8bMm02Lc50VkDYkhx8GDjBzCFua5/pk=
X-Gm-Gg: ASbGncscDvhlxopZ0T9Dgu0FFi90IMjp65LjQzwyOy9+M7WTAFxD33Dp7k/WyAZB3o6
 H/wrcrujq7cssMJHC6xqEg28TPWEcxd5QAN+vtM7O/2JdU2NJnNivAzGw8ybvZW0Ih6OjWj40pl
 Ng9Tmo1B7E/KecHHOB+fYErebA/JZG0oJ/ppPpPn69KaVDKNhwZFlHrayO42hjhDvea8Ke8hf7Z
 9ZTxoENniJBg0KYa9caNDAuFfHcMlD49JG0OVrBIzoYg0I4MGj8/nkFJThphblNZt6RzBLlaLqD
 MQ8dn4+B0ePk1vPG/Qq1THVwTpZrR2raqB+G3EVFAIirsFJv8LXNamI7LANRbK8+pjI4AA==
X-Google-Smtp-Source: AGHT+IG83hHWJcqgkRGrp+Ud2BjHjE5Qw+sj/0s63FKxF3gdVpyPwOFVJbIeMzPvbn4mUBCbtYK5wQ==
X-Received: by 2002:a05:6000:1ac6:b0:3a5:2f23:377d with SMTP id
 ffacd0b85a97d-3a531cb1037mr14059768f8f.50.1749572619351; 
 Tue, 10 Jun 2025 09:23:39 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:3626:366e:4bd3:97c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5324364c9sm12962890f8f.51.2025.06.10.09.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:23:38 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 10 Jun 2025 18:23:35 +0200
Subject: [PATCH 3/3] mach-snapdragon: skip setting fdtfile if already set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-b4-fdtfile-from-dt-v1-3-aec4df0fa53e@linaro.org>
References: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
In-Reply-To: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=953;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=MEJmHPXpKGBrmrxcv9VjzJXYDuwMT5JM8GVF0Jspj88=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSFwGtHnOBq6bgXsd+q0X2zNnod8Nf5Fqotgh1
 9IRjberXX6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaEhcBgAKCRAFgzErGV9k
 tresD/9N2lT8rrRHcs2uJE6my6Yex93qumAvqlS4HnMXKkAJM/+TK0Wg6hG0r5zxUfc7STKKJKq
 Nvo72DVb0Oa1rqEvoTXQaHArAJNMDZx22XqBkB0Qt+1GWAoIYhfEEXbcZDFFnGBaPUB3FhklHQJ
 GCFNEvpKIv4l3VcMKFbGKhwKttmBvWJCRLIRdrcOJsphMn+jrHF1CHdr+vtYnE8Y9HXrW57EzH1
 L1PawO5e9i64LkCLObqxCFlx7TGpP+cwSZB6TtEip+OfUhPWrp66tnAXys1/ma8jhfdJcCGfHmS
 CFmPLIgA+gdovXgGwPTcIskZjkr/1QMZ4zIs+NMgkpjoD/0G/8M1pQ/aJfPTbAJVAL89P4+g49L
 3sZcEXhFFG4hsGCbOMtVk9oNU5PIiu4l1FrNrPQsghvOKfhFizl588c+gEfLRIsa2DFyk7ro6WP
 K4+AmjFqaFXyl3mSzxluf5+BMMo1cV2w8fuGTUrhhJe4ajT0YtJYJQQWEDF0/52mENrLUIu3PsU
 MFK4xmxIXo1R81cskX1CImgjuG3TyWb2WProHQupYUT2dHIWkbGE31Ov9k09/NPEvibhh2E4KwU
 IWOVS+cPl2AQ7X1T/cOBUIwxEyu7ukkjZIkIVa4r3iw1oY7ZQi2gIk7NmeJEKghr7EmgUwUiEei
 4mXU5deobTUOStQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Since it is now populated from DT, skip setting it. There may still be
cases where we want to keep this old code around so we'll leave it for
now.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 22efd4e0d64365b8fea01931dc2103daec21b3fb..920229f89e36e9c1a8109bc2bf30fe5ba8d5506b 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -414,8 +414,13 @@ static void configure_env(void)
 	char dt_path[64] = { 0 };
 	int compat_count, ret;
 	ofnode root;
 
+	if (env_get("fdtfile")) {
+		log_debug("env: fdtfile is already setup\n");
+		return;
+	}
+
 	root = ofnode_root();
 	/* This is almost always 2, but be explicit that we want the first and last compatibles
 	 * not the first and second.
 	 */

-- 
2.49.0

