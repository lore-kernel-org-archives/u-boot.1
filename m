Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6D7FF60DC
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 08:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 733BD84011;
	Tue, 31 Mar 2026 10:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XyNvGJfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99B0084073; Tue, 31 Mar 2026 10:01:40 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B858406D
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 10:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486fd3a577eso48849845e9.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774944095; x=1775548895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CeaoR1w/uoH2kKTsfBU7MmAQaua1/dgiLsTbTtFYatY=;
 b=XyNvGJfe91ByIFJs2BLF/YL0h/1RrdWa3Yh9qmE6jwWVY5z21vQCm8TrnQ4msuvwMx
 CMPjRntUTMe13dc9t0HW2GyzaWO3N5JfRmkvYKWuhS8cW4chKOHDawy7TDc8E1lpW3DA
 eb4QvuBRcVGsPPB1ZcptLJBm/U0w8uyugA5BMvq+QFRcIXDty8cSQHMVAH4tM0XBh1bS
 awpdhhzssevdk19uUALI0PDGqP657ZbSd5mfWPeXS/0Sw0MG1mEgbh/ctQDJomnXkIcb
 f9bUqp8kpnh+lgq2SqGg4GPm3bEFSbX4JFdpnk5HMKNTMsVsqiezXYCuTKqXranl2mqv
 0FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774944095; x=1775548895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CeaoR1w/uoH2kKTsfBU7MmAQaua1/dgiLsTbTtFYatY=;
 b=Xb4TvZ9NufAF82EG6eFoSXQ9fx/2yqziYa6yDVa/zwUfBrKYPlVwrwj9IlFl2+NdPb
 VZGfTEEGCqvexvKXKityZpFNuz7XBJHH2Yk9BnkFw5z9CKVLV/ABX1lFoEw+SdyDWyoi
 gPQcxe3w+bhwqypgUsT8I+A66AJk9RrPltzIqTZ1fFQB+szP+S3EP6d6kj2prIvZPisp
 smPkjcMEcKSVyPC1rfhqv7+845I5OKi4YdxvKjcC+Ywv+XK7zR9Q7vtPnClqn7ETfpVB
 votG46UKVJ7E1VBk4LjYjAufry9B1ZyMHFQYs/QNPunBfTwphEQZgpjJJamzuD2Hgj3Y
 iCdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiNTZ6FJ77JJZHRk2yr5MrNLugbtZyj26jILH1u9WbbWLGK+bth7ffY67ZhSSIfc0kOt5h25A=@lists.denx.de
X-Gm-Message-State: AOJu0YyUepcZFS8ofOI4IaYUUtkQqpEMxrUfPc2Ba7S8RxV+DO5t1d89
 Q9kAyN2F6hGWTvkAhm/4WBm/1scle33ol8nDf3RIQ25isIWh9GH7uooNiIPjF59mo5/nBtYQMTh
 wE2V1
X-Gm-Gg: ATEYQzwlOYefQd8oNlbz8Y2CM9QYzlUUpQAoCsmI4I0bWEzBPX8kLEy70JedPNaS6gk
 AqyeY7QPNr7e2WJZXMRkOfXWkgTtwktBdpbBYLqaqpjhw1jervap9dhSuibIxEIrn6mSlL8AeoO
 Pl2uj7seQUGANXHLJKi2RGdIkInE9KTrPgs0cGbMNoUUx25Aq+e6Rxx6lHxXJ6gsbqfftLcbLy4
 QtDASb57efy67xc4FQ8ZRnMGeMZUoa+wL0HW0SDkDxq7dTAx9fk4dm5/K6uXnPdRQOCbvXgxwt+
 tjHzD5OqPaYuNkwhxncTjYNnsx27rCXfAtymYYLigGkwYbLME6WH/je5PBRr/AxbJyJYHmDD3yg
 0Lk+1zPs6MG+f2HNYTH0PGFFioSwe3ybGTGhtM6NYlhnpa22Ng9HGfA5NgPe3lhIg/Irc6yKoF4
 2vWmM2hIov2WIRqq0TFhF1yicgBi7KC/H7F0dGFLmqN/vJta23Ca8aRSiWIrERQaAX3iTevocl7
 7f08Fa1vzvzt9iYQYxBIQ4X0lN4us6+zZxtuPFJwj5FChwiUJ08PQT38pEYFNQ9JvOVMWmHntsO
 xQZCS1gtqIglRYbz6SNDeDbSoygss6yUPlEA5FIuY5CCfWeK81739Y3fW6dB5e2YMxywqOs26p7
 uP2UBIKSrVyr86dqIV2sB9KXbi8xo8PKtQ0/e7moJVAYmyRIXtOKE9J+cu05rnPPWnHN+tzORqS
 nNFPVmjUVLg/gVCx/84E/tIPVy+ffhiPxp/e7Rw5cVa+C7gr/aPy5KOkZLYsd5zp5FDDttoc4=
X-Received: by 2002:a05:600c:810a:b0:487:2e8:69c5 with SMTP id
 5b1f17b1804b1-48727e909b0mr235658915e9.15.1774944095303; 
 Tue, 31 Mar 2026 01:01:35 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c9250afsm10087065e9.36.2026.03.31.01.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 01:01:34 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: marek.vasut+renesas@mailbox.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/4] fdtdec: Introduce fdtdec_setup_mem_ram_top() to
 determine end of topmost DRAM bank
Date: Tue, 31 Mar 2026 11:01:12 +0300
Message-ID: <20260331080117.2370092-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Introduce function fdtdec_setup_mem_ram_top(), which determines the topmost
address in the last DRAM bank, to be assigned into gd->ram_top in order to
relocate U-Boot to the actual end of all DRAM. This makes use of iterator
function fdtdec_setup_mem_for_each_bank() introduced in previous commit.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/fdtdec.h | 16 ++++++++++++++++
 lib/fdtdec.c     | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/fdtdec.h b/include/fdtdec.h
index d9fcd037ed26..26e40c3cdb46 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -933,6 +933,22 @@ int fdtdec_setup_mem_size_base(void);
  */
 int fdtdec_setup_mem_size_base_lowest(void);
 
+/**
+ * fdtdec_setup_mem_ram_top() - decode and setup gd->ram_top to highest address
+ * available in any memory bank
+ *
+ * Decode the /memory 'reg' property to determine the highest end of the memory
+ * bank and populate the global data ram_top with it.
+ *
+ * This function should be called from a boards board_get_usable_ram_top().
+ * This helper function allows for boards to query the device tree for topmost
+ * DRAM address.
+ *
+ * Return: 0 if OK, -EINVAL if the /memory node or reg property is missing or
+ * invalid
+ */
+int fdtdec_setup_mem_ram_top(void);
+
 /**
  * fdtdec_setup_memory_banksize() - decode and populate gd->bd->bi_dram
  *
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index d820f75b031d..bdb26d8fb75b 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1162,6 +1162,24 @@ int fdtdec_setup_mem_size_base_lowest(void)
 	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
 }
 
+static void fdtdec_setup_mem_ram_top_bankfn(struct resource *res, int bank)
+{
+	if ((res->end + 1) > gd->ram_top)
+		gd->ram_top = res->end + 1;
+}
+
+int fdtdec_setup_mem_ram_top(void)
+{
+	phys_addr_t old_top = gd->ram_top;
+	int ret;
+
+	ret = fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_ram_top_bankfn);
+	if (ret)
+		gd->ram_top = old_top;
+
+	return ret;
+}
+
 static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
 {
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT_GZIP) ||\
-- 
2.53.0

