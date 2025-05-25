Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D24C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00A4E82BAA;
	Sun, 25 May 2025 12:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OAEFwI4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D221282C13; Sun, 25 May 2025 12:48:13 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02B182B5B
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a36e0d22c1so891731f8f.2
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170091; x=1748774891; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NASoAdTWon9mmszoUqgX/Z2c279RE3AOk4azjT1ffyI=;
 b=OAEFwI4d3Tx0Z0OgZHJvMKyfZW2idFBnbpDq8RAb9nddb0Sw9BknF/6Wc4VHn2Lxgg
 ZLa4HzIlVltojeVwQT2k8mQSkFIIuCoPw16Vzwi2Ck/DqIiRP21hLMwkuCw37hoRp0+8
 wbPVJP4EgwROZ2ttjCeAszWnEMw6J6FgvKG5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170091; x=1748774891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NASoAdTWon9mmszoUqgX/Z2c279RE3AOk4azjT1ffyI=;
 b=YOmP1xxswXmnMYm9DisjefIYEiV6BUWyo+0X9yzHfUCUb/lKLfV+P0tf0H8phBVoOC
 T32cCaM0uK3LnTJf6oOS6aNQ/56DKiCVdMvyHTEENuU+frWAYy3PJn1CYwLYQ1iUQxeG
 H1DeHH0sZyGnX1qqZwA1Lpc/ipdN2+s1Ioyym5BSaMBRO28J+c6dmaoCRNiqbdGgoUQd
 DAL0K/6rubdfus9OdRT2KL/lKiCbgQeZ1bFPFBVlMBT1oErxSz78lpOeZoWsnOZ3PMPn
 PS3GVxVmkbw9X2OVnr1XdXhxzuIzh8dSlWJFaooR5leu2w7zKqiK1iK5UxDVdCtNbGZf
 SjdQ==
X-Gm-Message-State: AOJu0YxSqCZA7VSN3LBH+GaNND4g2ePZ04d7OZbxNSiy/53YibFre2ln
 GNqyht6lXjx0Blti/XNx2lR9OP+1sAVeRWGpQyys+Pdow/qustr2iOlf5Ect9WCNb3+XjfIoifN
 OMxkVWX6i
X-Gm-Gg: ASbGncu7iaRvN8MJUZyhcy3qCrJciLtLdRvT+coUgQOJscO/fcFmYHbMsrFduFyS/fB
 sKU8gzLLX94JItGTRqnYGq36gbL8TOiLxBn/AYJiPV1IGySflA8H9UcOtJfyO7AmlSrE1a3/Xji
 rCZ0k6KTqgIdiJ2nDsgTYvLWAQWK+u6XO5Uz5TIgRXcYeAAkezAMyvh9k1zxmAcnTNG68jD9tMo
 O8WkFKv1b/qFIrVph9J50/ktn8tsi3s2HNe7XRhTJbfJfmut2wR18iuJoCjUFj31Eaur4Ff0sI/
 gH0qIvwqGAzjKPfRFSf6O0fYCS1yjcjpIyeZ3sGdnqbsdwOy3t510lWrH5HICly2N31KQ5FHqQg
 Cl3GODA==
X-Google-Smtp-Source: AGHT+IEw4CRpVcLcLcivkRGaIUDHCDIw4HeVZkbeaOnlusTKd8cpfYbB8sEdYjfCYST84/x+32Kryg==
X-Received: by 2002:a5d:5f8b:0:b0:3a0:bad4:1247 with SMTP id
 ffacd0b85a97d-3a4cb43214amr4275760f8f.15.1748170090785; 
 Sun, 25 May 2025 03:48:10 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 02/25] spl: Allow VBE to handle xPL size
Date: Sun, 25 May 2025 11:47:38 +0100
Message-Id: <20250525104801.1440260-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

When VBE is in use, the size of each phase is obtained by reading it
from a FIT. Avoid using binman symbols unless necessary, i.e. in TPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 76fd56dfe4b..42053b4afa0 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -200,6 +200,8 @@ ulong spl_get_image_size(void)
 #ifdef CONFIG_VPL
 	if (xpl_next_phase() == PHASE_VPL)
 		return binman_sym(ulong, u_boot_vpl_any, size);
+
+	return 0;	/* VBE handles this */
 #endif
 	return xpl_next_phase() == PHASE_SPL ?
 		binman_sym(ulong, u_boot_spl_any, size) :
-- 
2.34.1

