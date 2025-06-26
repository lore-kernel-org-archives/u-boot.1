Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C4AC7EE31
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 16:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4918682DA1;
	Thu, 26 Jun 2025 18:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OlL3KxGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F1A82E08; Thu, 26 Jun 2025 18:39:08 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F6582DA1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 18:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso784963f8f.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750955936; x=1751560736; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ne5yy+TRDq4kcP9b/8l291LC6JwNXc7mhOKuAcuhc4g=;
 b=OlL3KxGODGQ/2TguGAFm7+d4KnS2Br2SFrbSWs52r11c9eTQMpyMYag+CrwNlRBXvJ
 B7J9tl+gAufBhmEjNi6K3QepuqHgthAA4YEieSRLWNS0BV+DBK9r54+xdx9Mgq4FYqzX
 gkeyo7T613IBSEfiCG7HgWznpM4Eg6YSlmQCgY08MLsw95zfyibYJU2PRYl7lulkpJq+
 QB7UeGS2QDodZ5VXYQF7FnDNpcYqkca9iWK1w639rQw6YzdHTavdoHJ4rrYFZ33Fuw3C
 SsSO/LU29mNMUilZoJZTlbs1EUfCplzNyjXmPZ1n1w/iYHW5vwFOsbs0n6KfcwKRIslZ
 /7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750955936; x=1751560736;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ne5yy+TRDq4kcP9b/8l291LC6JwNXc7mhOKuAcuhc4g=;
 b=uhn8mnprEKtsZOpyjH0VAAPxGLUVgpnjLWX1OQwJUTgi9OGc6+MzHVG0NqGpoyLAaT
 xz+TpLdulS37MjyCwOjLPl6sX4HgxDasDliVFrosOxj6S3ApheSGf3umzKcn8+0yWSM+
 i7kiP//aq+pHsbMZxlBi4iN77wYPghywU4MCYsjXg4U2PsTZDeeDtzUFLSLWiXRI0rOf
 0S6SAq34+UpQEL566tc40jbFERRLmZEjWfHBDW2LI7mvwgkEPGGfRWxbvZD4IUU1FDd6
 PU7VWyY7z103cWMo7OYQ4B5Kby0L+VjWG9o5nQmeXUdz0suOuCfykSfu3tV88cqYQO0Q
 oFhQ==
X-Gm-Message-State: AOJu0YynhhHzWiETLvwAZpJIx3SWWoHrHimvgQI//9PCPNoeT2d6LnZg
 Xf5WBtv9PXEs9LnGhrTkEzSitkgI5d5BCcGzFAlP+j2M1hhhCAFgYAbK0NIyEL/C5CBosHHX0/Q
 qM4upiGOs2A==
X-Gm-Gg: ASbGncvCumFfkLPXx3LPid/unCXUGX0XFRRi6VFxvkvUB2t/V253D8IpSIRymPUe1JH
 r4aKO2Uifg8ni0yWitF7dMQe7JaJC/WzQEnVKxzYPXUTc59yfCm4XnamGvJclfGRTxIfjumKYNe
 jPAJDKCXAw9LJDao0ciTO9KqRQk92Rl0GzH578TcZE6Rclv+STCVu4n5m8OrGBl/1S6GwI1c78/
 DH8MtZIkYM7KKvgKM2P6kED6I+32fs4pFEFf25brua5Dt42ADH1+4e/obySEKXORTDyNnfwjtv7
 nsMbHQwlKD60EW4dmoZlH9y8vWobDYDiiqJoYhRZNBYM4wkyqZOB9V3OCBYg69lwKqpMnubxzYJ
 rLXhXn3s5SWLyjA==
X-Google-Smtp-Source: AGHT+IFYanZI0SKfWPD+KbRFDburG4AhcCIzW8Ij/nIEXykZKv5ktz6hJXr5bRGyjmNwB0m/OClUJg==
X-Received: by 2002:a5d:5f92:0:b0:3a5:39d8:57e4 with SMTP id
 ffacd0b85a97d-3a9002968a3mr185284f8f.41.1750955936284; 
 Thu, 26 Jun 2025 09:38:56 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:12b:81c6:a008:45a3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52addsm336091f8f.47.2025.06.26.09.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 09:38:55 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 26 Jun 2025 17:38:54 +0100
Subject: [PATCH v4 1/2] cmd: abootimg: Prevent use of unintialised variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-abootimg_fix-v4-1-df7af00e87b0@linaro.org>
References: <20250625-abootimg_fix-v4-0-df7af00e87b0@linaro.org>
In-Reply-To: <20250625-abootimg_fix-v4-0-df7af00e87b0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Initiaise vhdr to prevent its use when uninitialised.

This issue was found with Smatch.

Fixes: 636da2039aea (android: boot: support boot image header version 3 and 4)
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 cmd/abootimg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index ae7a1a7c83b..9ae87581d2c 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -95,7 +95,7 @@ static int abootimg_get_dtb_load_addr(int argc, char *const argv[])
 		return CMD_RET_USAGE;
 	struct andr_image_data img_data = {0};
 	const struct andr_boot_img_hdr_v0 *hdr;
-	const struct andr_vnd_boot_img_hdr *vhdr;
+	const struct andr_vnd_boot_img_hdr *vhdr = NULL;
 
 	hdr = map_sysmem(abootimg_addr(), sizeof(*hdr));
 	if (get_avendor_bootimg_addr() != -1)

-- 
2.39.5

