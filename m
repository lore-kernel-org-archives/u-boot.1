Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D14C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 11:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3982387016;
	Tue,  7 Nov 2023 12:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hcSwoKJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B0187030; Tue,  7 Nov 2023 12:31:40 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AFAB86996
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 12:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-542d654d03cso9175110a12.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 03:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699356698; x=1699961498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zvE3CNX8cVQQgczU0mbrH+4yqzKuXd3Fi9J02FukOXM=;
 b=hcSwoKJvKGtLy6rkIMMeseQDUTOvAXcuFFCRsLazboijkz2A2AvaUPH4fLHfefMEvl
 Dt3Nx6WSm2p1Wshb59LsA7TSJbeBSnZP65Icfsnqy8JiTQIlkBKNV3Swz56wunduthde
 yH1Pg8IDip+MAd3y55bVumhY038YcJXT+7DZVhuwBhyvBN7QZmssgCAw6yQoUNemkUyC
 xipS2wmY1hBHJIDdNojTbg/akkrpHmrm2el1HfNqAsOoMHRnBASEQORx14mySNvHamuo
 cTtMi+U5Mi1M232FbaPPOO4IPG1F+Wk3I4A8Xx7wwL0sk2qzHoFuFVy++6sOxsWo4XTn
 K41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699356698; x=1699961498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zvE3CNX8cVQQgczU0mbrH+4yqzKuXd3Fi9J02FukOXM=;
 b=VrT4kZgrm8DV+SRe2IYC29DvrRhverZXwOHu07NsfhPEyjo29cgszPb/HNaJFFkXlj
 60p7dKTbWUZRemlMpEDrKgVRDfq29HQNvhZDFm77QWRxj58GlvkWzCBkfodKeZN5Uj12
 MLWqv2ePpMysp0w5TJnXwFuh1GTRkq31FTEaBGoB5mLD1onu6EsripZBQMAwqc2I1WKd
 TmXu/R2zuk2b7V0w1gB9z20vtOStdjUAozRWevPps9DdAz3AIL9aNhHuP+09fQ959dJG
 omfsXMdwa3BCXSIxy66+r8JUpU9WVlCMv5MtbChJr7/tbI/vFMxQLTLG2cBI6wMBmm5J
 j9BA==
X-Gm-Message-State: AOJu0Yx+LGmRRa8O29Sgcw3239lRm0x7N/9an94Be555K0PcBM5GSP4b
 s92uJcB25g+OBDX9Xg5Ic28ARfpZ/CG7xr+yW+Q=
X-Google-Smtp-Source: AGHT+IFJzHXRlb1yQoEkVkxhWXVyEAGXMRlvzmrCyb9rVIQrylcOOfGKfZq4XQ87I1nYui2/vQPNZw==
X-Received: by 2002:aa7:c494:0:b0:53d:e5d7:4148 with SMTP id
 m20-20020aa7c494000000b0053de5d74148mr30109445edq.1.1699356697706; 
 Tue, 07 Nov 2023 03:31:37 -0800 (PST)
Received: from localhost.localdomain (ppp046103219117.access.hol.gr.
 [46.103.219.117]) by smtp.gmail.com with ESMTPSA id
 q22-20020a50aa96000000b0053e3d8f1d9fsm5415675edc.67.2023.11.07.03.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 03:31:37 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de
Cc: eajames@linux.ibm.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] efi_loader: Correctly account the SCRTM event creation
Date: Tue,  7 Nov 2023 13:31:34 +0200
Message-Id: <20231107113134.81029-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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

The result of efi_append_scrtm_version() is overwritten before anyone
checks its result. Check it and exit the function on failures

Addresses-Coverity-ID: 467399 Code maintainability issues (UNUSED_VALUE)
Fixes: commit 97707f12fdab ("tpm: Support boot measurements")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 2eaa12b83b16..463ea4c15416 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -944,8 +944,11 @@ static efi_status_t efi_init_event_log(void)
 	 * Add SCRTM version to the log if previous firmmware
 	 * doesn't pass an eventlog.
 	 */
-	if (!elog.found)
+	if (!elog.found) {
 		ret = efi_append_scrtm_version(dev);
+		if (ret != EFI_SUCCESS)
+			goto free_pool;
+	}
 
 	ret = create_final_event();
 	if (ret != EFI_SUCCESS)
-- 
2.40.1

