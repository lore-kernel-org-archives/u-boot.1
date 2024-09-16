Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3D5C3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 08:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09FC88E99;
	Mon, 16 Sep 2024 10:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rii/jD17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D69388E99; Mon, 16 Sep 2024 10:24:54 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FB3E88E7C
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 10:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=al.kochet@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-536562739baso3250772e87.1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 01:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726475091; x=1727079891; darn=lists.denx.de;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pxs6xUhrDbSygrBlLGxhJiVA2iTTaOzs/o5YNOaFxHk=;
 b=Rii/jD17i60Y+8avOhWn8SBMcvlW+ihDiDEV+sUEn3pXsqGtNZF7W5KvzhwAoo/UIM
 lvLrj5YjMAttdMsLKthjEOdt8Y73B1wQummFXrpH7zW5UEWInP19bgsTgcwA/mghDtoL
 UtjdKYZZ9V7VhqJakWqsTWL8d3QTmvSvnilyES8v85I3S/VLh91dnlFRqrloPvnk0Wbd
 n7zN2VXW/acfktCbYHHE/rvHyOvkUVhCJFPh43S+f9faKfWldiHbCot8HbWeseJdg0NZ
 cQivLiM+NE8i6eHBXbvfhkonu6eySrXRQAM/lOxHlXMNEC9gfLNXKUuPzmfe74LClnlq
 UZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726475091; x=1727079891;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pxs6xUhrDbSygrBlLGxhJiVA2iTTaOzs/o5YNOaFxHk=;
 b=SUSvkYEDxvvucVnAUjy5TCjYNlgZQ3mv26kFPaCpPop8AIUEc3T3m7NfubD/CKy/9M
 WR/94MxYSPl4ASftc13TjCrdmVLz5ph9lUEmxxnq4+kmCDPvmaQ6YVo99OroMGR978aD
 5kIMsLotSt1IgmHVdyuvUtHbK9RgGoAYOBbwPi0VLoEMCfmwGbS+GA5m/m1KOJQ3/KD+
 s/yyO6FwKsr8aVMq9ezLFxMR/7S+rYc67gRU1Xe1YWwk8NLNqLNRG6Ks056bfkLPeh1W
 x3NdLNtmzlS8g0yNTgZRLngHY7Kfj8Aia/NakXZLoQh5VYumzAG7vfNnc4i/Ulu0DAex
 dQFg==
X-Gm-Message-State: AOJu0Yx435VSOvtU39SMcl6oHniYXMjyOY6PIhgckF4qR2GEux/eLfZN
 jgy/ypRYnBmc/65slt/3KQikLIfWHPFCi7I014A3Gy5fwyv+JLFYFEL2ag==
X-Google-Smtp-Source: AGHT+IHaIL583IN+SVrIyaFeBP/nt6FgWNRrwYNzMoWVBBVFqTvjKVNAsgKlkToXEra4nfWQtcDCXg==
X-Received: by 2002:a05:6512:ba0:b0:533:47b5:c023 with SMTP id
 2adb3069b0e04-53678fbfb9emr7338594e87.13.1726475090769; 
 Mon, 16 Sep 2024 01:24:50 -0700 (PDT)
Received: from localhost.localdomain ([80.87.144.137])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5368704dca5sm804367e87.111.2024.09.16.01.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:24:50 -0700 (PDT)
From: al.kochet@gmail.com
To: u-boot@lists.denx.de
Cc: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH 2/3] image-host: fix 'unknown error' error message
Date: Mon, 16 Sep 2024 11:24:45 +0300
Message-Id: <20240916082446.32082-3-al.kochet@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240916082446.32082-1-al.kochet@gmail.com>
References: <20240916082446.32082-1-al.kochet@gmail.com>
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

From: Alexander Kochetkov <al.kochet@gmail.com>

Fix error message like this:
Can't add verification data for node 'fdt-1' (<unknown error>)

We get unknown error because we decode error as fdt error
but actually it is system error.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 tools/image-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 7bfc0cb6b1..ac14d9aa86 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1333,7 +1333,7 @@ int fit_add_verification_data(const char *keydir, const char *keyfile,
 		if (ret) {
 			fprintf(stderr, "Can't add verification data for node '%s' (%s)\n",
 				fdt_get_name(fit, noffset, NULL),
-				fdt_strerror(ret));
+				strerror(-ret));
 			return ret;
 		}
 	}
-- 
2.17.1

