Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835C1CD13DE
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 16:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F33D88D8A;
	Sat, 31 Aug 2024 18:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rVea2JnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6301288D83; Sat, 31 Aug 2024 18:49:00 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70ED888D82
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 18:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42bb81e795bso22028145e9.1
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725122938; x=1725727738; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wbclZtwb1rxDRYxAqkLn9bT4IZ8BeBKgjxYwlFmqLO0=;
 b=rVea2JnWQwQhR/fDtIPqs6fSu81EOPf6xDf69WXvSvvdeFzap2loJrpbfnkxUwdiKB
 30TPQOP8aoWC/DUnh29GjfaImUmP9rtICpumQSk2LayfnNmCH3+ABb3dFdnC5sbtpIIC
 jWNEPylz9yHFkWx9Z3LzFzPSAfbkM48dWXMRhyrV0evYt0ZjkgxTFqabehFhlawZatlT
 zQT9Z7DUMGgJR8MHbq+pJmzEULVSKk+fMeJ1gn6OtQPSfhfVQ97CrZLijBZzZIc/VARE
 YcY7HJjNQTWZwZa1l29BHMUAK2YhDUyLkJ+WoFH5SyK7mSb0hjIChFu5SWvHuFihqT2N
 j4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725122938; x=1725727738;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbclZtwb1rxDRYxAqkLn9bT4IZ8BeBKgjxYwlFmqLO0=;
 b=emnPANYx2AKDpftEpwdwQ3yxnaXc1l7mJjlMxSRT5GsFi9xXikhWm+XlaJbO6OjPP9
 T2gwk54tZPvnUbZobIMlFyriz4I763pGYEckcgQ3Ucpb9+Js25JVT6f60JLUmNqfpm4b
 YLoCY/FGmaoApZJoyemUPsUo5Zp027F2TKgJZ2x8ONcdrEf0rH4ulNICq0Xe8pvtH0+V
 kcMvSJPcUJ9kh/uHoHbpY8uhf37NWzLIgDiKYx6UlFClOH4Ire4IVLC7h4jx6UHDRPmi
 ZXrQF4GQrUuuDIWrDV19Ykb13J8Tn4O0BOywSBaVgKOgGliJloyaaU4IoDr/KKz8j3m8
 cXGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUmn4aSU2dEGUSfuxNFfN2PiSBrBR/OXhvdkdbajaIuhjei4OzzZ70bH/vpkxRI1QA1xSkPtA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/mM+FJ0EiDhWp6+aWuEokjRih60V2BLCs+BfBDoFUcF09futn
 Bq7SyhekCjyzMX+pxQH173rTE2p4O9zLW1iYtjGb7fUuPuTIGNfGEhp1umyo+tQFDvkGx8gZ11o
 oIwI=
X-Google-Smtp-Source: AGHT+IE+DfjAtvhf+dEaJjmJ4TSuGEzrk76aycqfZHRZpsDmFAFnVvIYJ57rKRu/9R7oxRX+3sCSHA==
X-Received: by 2002:a05:600c:4683:b0:427:ac40:d4b1 with SMTP id
 5b1f17b1804b1-42bbb436e2emr44396615e9.27.1725122937721; 
 Sat, 31 Aug 2024 09:48:57 -0700 (PDT)
Received: from [172.18.168.79] (ip-185-104-138-67.ptr.icomera.net.
 [185.104.138.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba6425a77sm116699105e9.45.2024.08.31.09.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Aug 2024 09:48:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sat, 31 Aug 2024 17:48:53 +0100
Subject: [PATCH 3/4] bootretry: check for bootretry variable changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240831-qcom-phones-v1-3-08614edd8e35@linaro.org>
References: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
In-Reply-To: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0H8n+0j/GEL2grXCaQaQ4ZqsFCay3wzebXIywJAd20c=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm00l0u+qiQdQVcUA9sKP+sf+p1MM+eDBQVERcJ
 tUcRjv2rZ+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtNJdAAKCRAFgzErGV9k
 tmfvD/9ce2jCClWsvWJ4/7aNWEeHojbVWwhY27mbMaBFceL3XmB6lkCgMn7akwQhuZ0QEP1WeFq
 8GXn2xYcwKPhSRcs6h5yLlLWS8NkKsUduIQv6g4EQKEfYbf3KfQP77vjCQT6p17q0wxerJvOBlC
 0e+e4YLP9cJRMQwL/hr7hOYpEuxIxM18llx3tXwaK6427WWlBfvsDoo6EISWKPTh5vr4zBf3Q4O
 t4meIKY2sjDG0O9dKFzYPVneSqcF8n8u7m68q0HWX9ysd+lVBn2cIr67fPSoxLtUvS3BnIvPT75
 pIEHwQBkI9V97OD66wqNQUyLi8sZgXUt042ob2JFsQ2famX1lkhwKpCw9Xz1yqLkwSisGKsfJj+
 H5cCZvhTrxr1HLWUdlOpOldMLZbiAs51U08ZDWJ05tXBMHcw6PCcFaqm0ZMUV3aLeC+li0svriR
 /p1F8M8yQQxQEKpPkNahcYH5CODWKkHhjjNH9+zGSOztFXoQU8OApX/SVubignNuU7rXOd7O/m7
 LDesp8vCPPdyeIch2te+igliF1jtJWBytTwzG7yhZmwD2yZ6KIX7lg4b2YA43NRxWWHaeLawBFS
 eQ5Owynr3u+5p+bAo2h3S2rJEksjbCQwvrUcpdpve+5mHS0hp+ld9GS4CVW8KbKto+gV66Lt/yD
 +1AFgpVDfJqoLOQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

To enable more complex sequencing of the bootmenu, autoboot, and
bootretry, handle changes to the bootretry variable between tries. This
makes it possible to turn bootretry off (e.g. to drop to a shell) and
then back on again.

This makes it possible to have a persistent bootmenu (the only way to
navigate U-Boot on devices like smartphones which lack a physical
keyboard) by having bootcmd be defined to launch the bootmenu. This
allows for menu options like enabling USB mass storage gadget to return
back to the boot menu once the gadget is shut down.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 boot/bootretry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootretry.c b/boot/bootretry.c
index 587b2de7d6b0..a60767eaa2ee 100644
--- a/boot/bootretry.c
+++ b/boot/bootretry.c
@@ -36,8 +36,10 @@ void bootretry_init_cmd_timeout(void)
  * reset command line timeout to retry_time seconds
  */
 void bootretry_reset_cmd_timeout(void)
 {
+	/* Parse changes to bootretry */
+	bootretry_init_cmd_timeout();
 	endtime = endtick(retry_time);
 }
 
 int bootretry_tstc_timeout(void)

-- 
2.46.0

