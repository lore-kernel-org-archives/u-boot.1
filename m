Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7387ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7DF586F9E;
	Sun, 15 Oct 2023 09:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IFwjZaHj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D89B86F1E; Sun, 15 Oct 2023 09:16:10 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA34186F3A
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66d190a8f87so19432696d6.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697354130; x=1697958930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJv8YBoSQtp8nnnCIVzZZkuzYLJGuElzWm0jPnVSgQ4=;
 b=IFwjZaHj1XSQWcIwD5qf9z2K7jCZTkKX8m22L5yds7ZkPNutvRye0GqbGiNUOeqx0F
 sINU79lFbxnGVDu62S8+CNavxYb7cCMB4h3wLixFg/5dZvuWL6hib552xGSk5s7tkvK6
 OTNm0O76BcYzsV/P89BhJRDMtsBN2lfpaTOIj22UYr+zQvQdZKtphav/ZwYjuyuCfM5T
 ZIw8Yt8h2kHrPlIRMe0TsWx2wW+16a41pLQRWq9/zp+Hq6l0/ri9cqfM1PfKjyaOunwg
 gsn5MNGRQbAUo2T1kqAkSxGHIgIibxyRD0SLp4EBe39O6TC2steuJ1l/tAM9Wc25pEib
 gyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354130; x=1697958930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJv8YBoSQtp8nnnCIVzZZkuzYLJGuElzWm0jPnVSgQ4=;
 b=XFUf+kjqGh2czFmJw/VGLj1eQ4hvJwp1+Jz3LX8ROuozX9A90Z9mArf3L6GN+HtxrT
 xAdRpfRWL2osv6K2QbF9iXkOVQQAGM/7yQYrS/77r1stxawVChJYhzOdL59F6psKmroi
 r2v9s3iPqwz/8Q1wH+fSn3QSIY3/KTRO5DJWrfCx36yOpJtPXt81IMKwivsX/fXiDOki
 /FVtdBu6VTf8yNIkhj2VHFu1yTVGCStUhoZyFCldqembdIqf0XwFcLLcgKS3qENRh8uE
 WZnTyVs2xDkMHRc+fbMw8Z5Jna18GHsPFDRshuvcI7RgShTNubAtB4bEN653DsJHLiv5
 znGQ==
X-Gm-Message-State: AOJu0YwqxKDZhqyr7u1SrYvpYWAItR4jCjAWXwY5XS4BBNx/NA53PeQa
 0UxK4QicXmq6wkxcoeJNncLZVr2vu0H3vg==
X-Google-Smtp-Source: AGHT+IEzudiSG/jxu9EqVPvamHD88Lpx5mA9qD7Z4pVHvi+ma59wVVHYaRQfgvMEB4XE99SR8qFThA==
X-Received: by 2002:ac8:5784:0:b0:400:9896:b0fa with SMTP id
 v4-20020ac85784000000b004009896b0famr36788482qta.64.1697316491344; 
 Sat, 14 Oct 2023 13:48:11 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 kk1-20020a05622a2c0100b004181c32dcc3sm1747002qtb.16.2023.10.14.13.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:11 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 03/29] spl: fit: Fix entry point for SPL_LOAD_FIT_FULL
Date: Sat, 14 Oct 2023 16:47:39 -0400
Message-Id: <20231014204805.439009-4-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

The entry point is not always the same as the load address. Use the value
of the entry property if it exists.

Fixes: 8a9dc16e4d0 ("spl: Add full fitImage support")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Remove check for zero entry point in spl_load_fit_image

 common/spl/spl_fit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ce6b8aa370a..4f8b951efe2 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -884,8 +884,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 		return ret;
 
 	spl_image->size = fw_len;
-	spl_image->entry_point = fw_data;
 	spl_image->load_addr = fw_data;
+	if (fit_image_get_entry(header, ret, &spl_image->entry_point))
+		spl_image->entry_point = fw_data;
 	if (fit_image_get_os(header, ret, &spl_image->os))
 		spl_image->os = IH_OS_INVALID;
 	spl_image->name = genimg_get_os_name(spl_image->os);
-- 
2.37.1

