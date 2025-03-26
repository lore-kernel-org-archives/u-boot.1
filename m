Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155F9C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 12:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D690181E1C;
	Wed, 26 Mar 2025 13:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FPxNiqqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD3880BAA; Wed, 26 Mar 2025 13:24:19 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC1580756
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 13:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3912c09be7dso4484955f8f.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742991857; x=1743596657; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Or0qLFxndDL56zEI1o0/SJT9c1VYLS1Cd14lH3rYNAw=;
 b=FPxNiqqRNFJtVSlewNUWiGGcEq+AicOf3dgm4gDRLQy4ij/cg/KOwgjrvmOXTT9HIx
 N/G+yLkQBUaF8KLvWpTmX7oR4YhhRVY21JQXG/vngYGttfKw4Q7cMfGCerhhfWO+3JdN
 Jl5/E89JsJN4yJ/PQWt6WfuItl0qCTUo/1JAXPbT62it4Zufm+ha8MBFdK07ZLlAqT4M
 0j8ocdumXg7gPWdBrcdfCdwjSSrUgp9QiBVJtDtma/FIsHNIZQV8z1cXNRXgtwfxGO2g
 NTon3VOe3ziEFz92IUkADkW4gC7YNWi/Hn6AE0fvYlBwyqjAxSI06EfmTtdXNhSVUb4/
 z6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742991857; x=1743596657;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Or0qLFxndDL56zEI1o0/SJT9c1VYLS1Cd14lH3rYNAw=;
 b=ecljGN5gN1wkIHWAE16qnjCuwWb0j7O8JVngcyU9yasyJbYBLRAarA38H9XZDCoIFt
 EK9NvkXh1N/aHDwbYWQ6fWTugZaqZ1/FvnMDutquo33GhMxPUAJAq9bbmJG5mHMKsBDV
 yRgfEbFNVkjtiWs/5blhOn+z/nSamknWjc1s/ZXpPBLWno08cqDbJCrkXdeukbqYflng
 FJJJWKdx+oMPcjq5TtJNvNzHcN5ML8+JYq2uxoyfo4dQ8jjKy7smJP/n5U37H+SoAJ4E
 0iMtjA2WngLjNMQ0fUDcB4C4sqenBEeger6cKF1FXGcPKL/pNFLkgXHRRVzC0SO8W7pB
 7jDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCVNO1rmuhVihn7rmQ48fBnWd7u9RlPjpVw85IhFrb8576gJsi1lOLAO9SKDyih+pyOrJr6Rc=@lists.denx.de
X-Gm-Message-State: AOJu0YzQJJdBEqiZnNM1WG5HCDFoVgkUi8ZRCFEVpLQ1S+UzSOnvUJJq
 /BSEHrH9+UhNOAwNSyx39Q6nnytH0bnIfT6ZceUMesw1D1jSxqxcjQ/5NNLi5iU=
X-Gm-Gg: ASbGnctpGhZGhe0RNGGKwZhJKv404dWDAw4ZFpVzuhMg0p2v+OiLFaTdxZsrAHPl4Xe
 Kr2P5F6yBTT7mSu3of8okh6Xkcu2z2vL7Oq1PHvGAQSE6KRNPIqQBa3g/l+VaGINa7I5Lsb0z6v
 EInTsfQ88X3WqcemNfL42MAa5DHibncY82HFnOA0tY0RKag3XOskGwYfUAHAF7P6xJTJAlfbC3f
 +RGXnFUUwHH9qKKn1jvJuerat5BlBcVI+phzc3IatjzIa7YL0ZO2iaRjrmC/5XI+22LAyjW5JI1
 RpkZ+KHD1knIQG/wswA/AYXmMxzJhZrRHMWZw+eKD5Kq72lydu8Eu4B1KULkQLzgrX8IVNM/XOs
 oxdDTENIzbmSc
X-Google-Smtp-Source: AGHT+IGcs22g1me/gOZfJinoPqD+kFYSIwxVm28drHY4KruM7RObdmY3SggvsHHnYKgoE5k13nlczw==
X-Received: by 2002:a5d:6d81:0:b0:397:8ef9:a143 with SMTP id
 ffacd0b85a97d-3997f90c860mr15785992f8f.23.1742991856871; 
 Wed, 26 Mar 2025 05:24:16 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65casm16923921f8f.69.2025.03.26.05.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 05:24:16 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 26 Mar 2025 13:24:10 +0100
Subject: [PATCH v2 3/3] ata: ahci: implement SCSI_SYNC_CACHE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-scsi-sync-on-write-v2-3-12ab05bd464b@linaro.org>
References: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
In-Reply-To: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=V5RueStbr9d92x6h7pIfVh6kG5HW1KQlF0AVP/dL3p0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4/Hq5rxIgZOz8cuU7oBlV1CdlFY5k/yRsvVFC
 zfd2JM1gaGJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+Px6gAKCRAFgzErGV9k
 tgp4EACVb7mayHsonUGBUIKZ6r4bVASnJWmtw8We6kIJooKvn+Z138928SUX6hXo1Q9QIIgVwRq
 tlt+XuVv7H7dSpoW7NnrS7eGapQMw2/JwmSKxa5d+fzBUn/mF0vS/bMQvCAVukADV1bshTzCHbE
 tGYNfSr+60aX5jRsIxv1CtdCw6m8fpWeYLMeeMncVu7vzTLEhweEHxCxk6dsVeZemWO2rIJERJM
 W9X/hkFUh8ODHJwwkPF9B1Jtv4MWye3V9Kq/hQ6kMNmexfOrPBD34R9MqB0rcHL96Vzh9H8/yaT
 2rzB3HCsmcikjr6lkyOmvwyYaMLgZ8AOjUln/jReJh0cXr2O7yqzBkhMeh67XlLpHSc3df6zoq2
 FHr1vcbGppj17sUIgiUMpvYWqCWOS29IJiiOQ/b4Wi2d6uifu/N6dF2lspf0zH/LfWSMz+C/oNL
 ZwT10xuEtiXsc7SDbvvlq1JKRZ2I+nZxZ6yXoTeTMhQMzwycjugVyWMy2aEr4FlEby1h0XW7qvk
 ef2OyvHfVIHYGJlQmw7PSaLav3zBMxNc/u1A+haVyunlBuCu7gm5LmMsdrNAnQoBLygF4iC3jPN
 Kvc/47C+QuoFWkd+aPID8QqYNIH8SLX9CJRUEj317Rjwd+SHWwgDdsvyTF2CDr8Y347xtqiJ4wR
 d5xKXZ2VEjh/TpA==
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

The SCSI layer now issues a SYNC_CACHE command after every write to
ensure there is no data loss due to a board reset after write.

Implement support for this command and remove the same logic from the
ATA write path to be consistent with other SCSI backends.

Ranges are not supported and the whole cache will be flushed in all
cases.

This was done per iteration in ata_scsiop_read_write(), but it's not
clear why this was the case, calling it once for the entire write ought
to achieve the same result.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/ata/ahci.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8058d5ff1c37f92914f250fa9cc78498a3f27331..deb91efd6d2666016f375feabb16ebc8f68fb697 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -735,19 +735,8 @@ static int ata_scsiop_read_write(struct ahci_uc_priv *uc_priv,
 			debug("scsi_ahci: SCSI %s10 command failure.\n",
 			      is_write ? "WRITE" : "READ");
 			return -EIO;
 		}
-
-		/* If this transaction is a write, do a following flush.
-		 * Writes in u-boot are so rare, and the logic to know when is
-		 * the last write and do a flush only there is sufficiently
-		 * difficult. Just do a flush after every write. This incurs,
-		 * usually, one extra flush when the rare writes do happen.
-		 */
-		if (is_write) {
-			if (-EIO == ata_io_flush(uc_priv, pccb->target))
-				return -EIO;
-		}
 		user_buffer += transfer_size;
 		user_buffer_size -= transfer_size;
 		blocks -= now_blocks;
 		lba += now_blocks;
@@ -845,8 +834,11 @@ static int ahci_scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
 		break;
 	case SCSI_INQUIRY:
 		ret = ata_scsiop_inquiry(uc_priv, pccb);
 		break;
+	case SCSI_SYNC_CACHE:
+		ret = ata_io_flush(uc_priv, pccb->target);
+		break;
 	default:
 		printf("Unsupport SCSI command 0x%02x\n", pccb->cmd[0]);
 		return -ENOTSUPP;
 	}

-- 
2.49.0

