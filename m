Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9413C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 20:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A5186FA5;
	Sun,  5 Nov 2023 21:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nc2e7d92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCD486F1C; Sun,  5 Nov 2023 21:05:22 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2355886EB5
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 21:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7ad501764f4so17723139f.3
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 12:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699214713; x=1699819513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1UY2bjmsU2lv9rbZ9NzomNDYnLHjboXj6Z6bYpXZNc=;
 b=Nc2e7d92gl5wkUaw6uzg8zwHWwL8Tzynz4LYc4HBMnqxNd9f/zBw3H7Rs+LvdtegIU
 uZjbCIQ6KE9KtPTZkZzUYeTko5hU5pFCs1FVXWDGhjRopcU9UmaHhoAa4DPK5aSapcLs
 f7/d72mokTrFJANkToWRKNy5H9oMm031WIXzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699214713; x=1699819513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1UY2bjmsU2lv9rbZ9NzomNDYnLHjboXj6Z6bYpXZNc=;
 b=wf7gbFlrJQPJTCooiwkTaZ1d1vf8nVy19lmqqrPIFAwDjbWOeRYoUT2y4cgGQdqrTW
 qpxBEW+R1fr1WHXLM2V47ij2OjSxVdlvPvpIVlXlKQeoz8DxTKzXS/bpFDRf9x08apo+
 azP0HXM2UUiTTg5JZ+3GV68Pj86lohWRVKPZS/SrI0EQtHRTutD7EZFa74KCYl+vWU9H
 5MTgR+tcRJ9bKzXpkiuIIni6YEJuHEMg7mABVVZ5ZizzYF6UY463KSGdWuf3F7ZUAO0q
 CzyXmdt3ne2Dfu9lzxs3YTnlg1IgBbQbL4KPCh2WLxos+8FO+UnT6ISw2i0s/fob1BnQ
 AbvA==
X-Gm-Message-State: AOJu0YxA1u2b39PHZNvGSOxCjRAMBJHgnhX54A/BwcB1/eUPVFtY5jCF
 PqFXrmpizyJEMvbsU30rw58EAx03VIy3yM/+4Hzz1Q==
X-Google-Smtp-Source: AGHT+IGCAI2LVq1CdsCM0MbUq/3GyxA1VntQIjitmKbCK+hcKClzLiGdxY9QfDYn4mBll9YfbZnjeA==
X-Received: by 2002:a05:6602:160f:b0:7a6:6c00:3893 with SMTP id
 x15-20020a056602160f00b007a66c003893mr36283546iow.4.1699214713782; 
 Sun, 05 Nov 2023 12:05:13 -0800 (PST)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a029693000000b0044d10eda3a8sm1685512jai.158.2023.11.05.12.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:05:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 4/4] image: Correct load_bug typo
Date: Sun,  5 Nov 2023 13:03:54 -0700
Message-ID: <20231105130351.4.I33852d11a04a125d8a4fd7938a8eb989454e7fd3@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231105200453.1887418-1-sjg@chromium.org>
References: <20231105200453.1887418-1-sjg@chromium.org>
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

Correct a typo in the function comment for image_decomp().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/image.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/image.h b/include/image.h
index 2e3cf839ee36..0fe67852c563 100644
--- a/include/image.h
+++ b/include/image.h
@@ -936,7 +936,7 @@ int image_decomp_type(const unsigned char *buf, ulong len);
  * @load:	Destination load address in U-Boot memory
  * @image_start Image start address (where we are decompressing from)
  * @type:	OS type (IH_OS_...)
- * @load_bug:	Place to decompress to
+ * @load_buf:	Place to decompress to
  * @image_buf:	Address to decompress from
  * @image_len:	Number of bytes in @image_buf to decompress
  * @unc_len:	Available space for decompression
-- 
2.42.0.869.gea05f2083d-goog

