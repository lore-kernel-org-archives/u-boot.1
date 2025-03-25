Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4255C36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 13:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC1281DB4;
	Tue, 25 Mar 2025 14:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AU440krG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F8F81D4F; Tue, 25 Mar 2025 14:03:02 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF51C80EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 14:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so4418685f8f.1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 06:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742907780; x=1743512580; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qDDf4E2uyNrrtvf4WYsXEMCAV/TBdsnWGIJ5gvaCHG4=;
 b=AU440krGh680OrlVge1fYwmTA2btoEG8ucXZFFILmbHEkxdn+QbTBRLxKGugQLqMo4
 ji/pu/ftHmLGaV7tZPfFy58GayWZ0SAmNdUmapV/4nBVVc2B1jASOEuMsg9Zv2UrdKAj
 /Q9lVcD9DqjQfn1ukDY1Ue5ALmjsGhhgLhsnRBthg+75zILs3gdowAK8r8L494tT6GRx
 F4TH1YnpV1PmjADnxMYuqtyDYb/qfA+oA2gthY25h+ra28osmqoFnXkK8kKlBk2/3nrr
 0xxYLPwnzwXEZdWFgASucM1VFtrBppRfxP3yUs8Oaaw2XG/g9AtwNy/jDIQVr+pmWTo2
 DRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907780; x=1743512580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDDf4E2uyNrrtvf4WYsXEMCAV/TBdsnWGIJ5gvaCHG4=;
 b=HgWx6+XO4bTMwwlTk2H6rRXV3hVz/DkYkOdm1biTSbJ49Qo/w3nGupvPTcpxlmBNwF
 2NRsYWFe4UoermGbJM75Uz9BiA6SN/54w5Aw5//hLh1pFSmrLq2i3E31NrlPmh3LwLxA
 7nPJYJxZv8oUe1P/Xa9c+SD54atzyisQtPmdrBfUs7LXH2wBXONR8rspQuLcvIxLoUNM
 JNsngg3yWbd/bUfVR1Qw9UTwiKpkFjTRXzXp3mBk4vgI5cbA8nZqsyubKkDrMUQyVXW0
 ZUlPkqLlImQMA7bn0PmU9rdlN1vovyJ2amN2jkOehH2qFfN2KK7f+YdjYp86EqnPtVyS
 5HZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF3X9rCpy2QzLggUeSJOSS9qImXzLg+FyB2DmVFQDqHk2+NrNVLcuidwbCEpvkOuL4MlxHStE=@lists.denx.de
X-Gm-Message-State: AOJu0YwBALX2WnVBIzfmubSSBiveu/EGA/JvOZWyVag1uLgaIzp1Q7Pf
 oOPSDdJ8bqIRSKdFus7ZWbjM7kQphiAtF630x/RNTlyMRNPVgoJUyjx+mqSqGzI=
X-Gm-Gg: ASbGnctfRIjoGkLmAjx1mfguu2qLjEmqtbhssvXwao4poCoK5ADUHaNRL7Yd+wau4lT
 RDUOVaeSpssY57m3lkXmPpyfOpsq2yhguEs6USPJfaH18bgpsEIMuNesJ6lzl3PbNTUts0G+lD+
 9fH6By0Pkw7f3dH+FttTYU8MCAVpxTibeKqZHgbknrtoxoN7g0OJytgKUZ5cvMx6kdNisvRMxr6
 z7/7eunmZdLLLj8nBVIRnFpeuA8RgD7bjs+EMnws4/vBsOHxWixtp49q66R3m/hnQdyYyNrr4DG
 50lOb8BrmAih6QW/dqWgSIWg6kBR/4FrtBs1tYevSKXUCoOCvpb7fX0MK0QDH6C1itH6vCdj5CY
 fDbsGeeiUOSxr
X-Google-Smtp-Source: AGHT+IHz8dtWvjotJSais+XmXhVg36Tn+sUdJvml7V361PHm+QwkkJlVY+U1XewJ1tqAIKoCLBPKwg==
X-Received: by 2002:a05:6000:2cd:b0:391:412b:e22b with SMTP id
 ffacd0b85a97d-3997f903a95mr14713719f8f.18.1742907779577; 
 Tue, 25 Mar 2025 06:02:59 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed793sm204706095e9.39.2025.03.25.06.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 06:02:58 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 25 Mar 2025 14:02:53 +0100
Subject: [PATCH 2/3] scsi: de-dup calls to scsi_setup_write_ext()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-scsi-sync-on-write-v1-2-3575aa1342e0@linaro.org>
References: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
In-Reply-To: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=iP226MTRSqJtOurISKhFsv13XkZmwW2x67BMen9zMJk=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4ql/TRFnbpKNkjvqgUM0U329+iDoZLfxNwSLq
 xgDt43GCJ6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+KpfwAKCRAFgzErGV9k
 tjJiD/sEjlrh1IKjBlAYfZomkL9fCGZvev8Kj9pTwtodFxrPZICKNsOkM8/btkBGhtrGBu3FL8o
 Hsr1OdybvHxce7/KXdAUJvdgZEFGJVc234NA5c2MhVN231+SZvRJcv/dx6cM2gFPr0S4jKPAThv
 hpy25ES9kgbmAAfTOpUu51b9W59J0LVhC3GKrAyEHmt2edikizV2Mi3GIExXnDV1SfrgdDGtkSZ
 ayCRa2YIVe5jeRtnNQDsTK9mSJiq4ct/WckzSGrHuBsRPVopEkr0VyyspXcvAxbaj6pT1R+5ZDQ
 CYWDw4sfd2LOTH7kP6f35ci2uRUiN/QEAPt+HU1pfT0fNwxjDK5s5QVVBfuViScmHeSdzpSARRi
 2WQHxaUlOY+LUNC6TntC+REHdFRyjaFXsMk3NWWT/fcBhKHmMmHAeP2oCg9CmfFxfl8fKm1HWd2
 6D4SPaBvsCeTxTEMDkNG/e2OLm54mNQERcKilI+SJ2X4W2UhwtKIcA6/cpWu4qwYTQCAdDSIgSr
 QbmwsuzxVL8RtLZdnhSUFvP6lkX5B48vey0IGGj8AIvR9nwQ28LQcBjVn69s3u+vHSPNZ7SuO/O
 644sX/tuD/McyIT5O3pLyL3bbhk/GrM2tPoeZfLnQhsfySsvgRHK/1NXSDN1ndgi/o8+dtT+ClP
 ONE5L1uL3R6k5Uw==
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

This gets called with the same parameter in two paths in scsi_write(),
de-dup them to prepare for additional logic after the write.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/scsi/scsi.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 34ac47c03ab397ca999abf130d84ccbd3be4c419..1aa7fbdbb5278e387de72a3c3e73d19ea0342fff 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -220,25 +220,30 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 		pccb->dma_dir = DMA_TO_DEVICE;
 		if (blks > max_blks) {
 			pccb->datalen = block_dev->blksz * max_blks;
 			smallblks = max_blks;
-			scsi_setup_write_ext(pccb, start, smallblks);
-			start += max_blks;
-			blks -= max_blks;
 		} else {
 			pccb->datalen = block_dev->blksz * blks;
 			smallblks = (unsigned short)blks;
-			scsi_setup_write_ext(pccb, start, smallblks);
-			start += blks;
-			blks = 0;
 		}
+
 		debug("%s: startblk " LBAF ", blccnt %x buffer %lx\n",
 		      __func__, start, smallblks, buf_addr);
+		scsi_setup_write_ext(pccb, start, smallblks);
+
 		if (scsi_exec(bdev, pccb)) {
 			scsi_print_error(pccb);
 			blkcnt -= blks;
 			break;
 		}
+
+		if (blks > max_blks) {
+			start += max_blks;
+			blks -= max_blks;
+		} else {
+			start += blks;
+			blks = 0;
+		}
 		buf_addr += pccb->datalen;
 	} while (blks != 0);
 	debug("%s: end startblk " LBAF ", blccnt %x buffer %lX\n",
 	      __func__, start, smallblks, buf_addr);

-- 
2.49.0

