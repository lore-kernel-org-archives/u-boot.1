Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93189C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03BF181297;
	Mon, 24 Aug 2026 16:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MdJq2jfFTO1U; Mon, 24 Aug 2026 16:47:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589961;
	bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cKYlJ67IIxMc3T8y6iutSLrZM7hENqerMIdtGf0EOz1mZ5ETld9xApUm/34ZLKFLn
	 FpoOlwZRTmPT41kETpp208pa5M2awXO19QGlFp8UBD7n4EAOgnq3JTGmEnAaN7OfE0
	 CT1IeGLj7pg1PdEQiSyHfMah+XFa3rB16cQFDmrfBHwZ7zWnufIKYkj7mBSyFaVQtM
	 QwIrv3o/kGYyofqzd/BsEKAl5ftMBXMBxLdb4mr7aS8gKwnPmdfbZ6x+lR3Mxb82Gd
	 ooJDcCwes1qTqcg5n1DrnQ8CxyxO0oIuvGCl7TM7UM0nz/IT25N5NYEZuNR11MqSf2
	 rKjFs1eF0F9Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 158F580FEF;
	Mon, 24 Aug 2026 16:46:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BDD8F396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3FF980B2C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3lfSNKAOTL1 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=R8DtfiGU
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7370780AE3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:56 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c1676497000so43541966b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586235; x=1788191035;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
 b=R8DtfiGUH0KlN9CFGbNGD6Mdyr9gK7/1o2KpMxdHZvtQfiALE4HTN0LeAhzrEpXZOt
 n5FF7VIFy+3gs2TAgaue1ELasP13ezjGQ7hjpgdrP7K5o6FmjytqaWc0PELc1myARZik
 LWSMdxeOYLdHhiOL/hsSjrJphLQCsFOjbfb08hRg9fC6EL7vP2hWxxIUbTkEEqX9GgSZ
 GdsqXnfviHcCXyyl6vwewgOoLZXwZeQHuOpfoGNQjPBHDf+TvG0ev/7PeynF/R3k7b9f
 BPEgFPAA1kjDafqdqgW/1mMx7eaYIkL39AWxeEx3L/oJzcpSusPrYrb7eMhGyV/6XMnk
 Y5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586235; x=1788191035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
 b=neI/K96PR8anENorckikZGgM6vkm+goDkFw/UrBEQEQLzbNOLFll4E2MmVYm6xnwjk
 1YJzVbO7JAi9cDhBCkhvtnNL3RKOMnagQQCKGcymsnNSB58MorIhAMG6CbOOSZ8Te3b7
 HepgizXbEC0uRHs6MMKk0XknuPdoYzX9WH5rn7tewVmRAFimRPxeXSfhn9O3Gc68IWSy
 VficNBOK2RU0NZ1VbQsQ1B/YB6k4zvGeHScqBJ314B64i5XISxGLG4LbKi5tgKVt0fqZ
 j0VYsMzsPPp5WJcm3BLdyS8tm6pZ0JjdtAqgiVGVB7fwfxZKGR8S+W+UVgauuULOquX2
 9A7A==
X-Gm-Message-State: AFuF++lxk7f607EE1PulWwhwpeHtM9X2kPiCbqehTMcjiGL+lVecGaDw
 2ydRv+E3GBUt3XnIvJ8pLMO0Hhh/B2jGjOz0vj8TUm0dHULb83b+5bBtBcNfDZnjHskCZOID/UN
 fDq7/
X-Gm-Gg: AR+sD10OUu6vKlZw2syz1FmtMr3Zw8TlgKTpZIkddLWC8gayVXZiRv74sPAPb3biQMK
 5lNtxNDIG0sK23d80YvzPC+N0EftaWVlbd9andImJ7wIZBnaTGmz2DYv6aakOaqtE+JmaIaYWM3
 rVI97fLtrmcTsrHmbmjnpys0tWoeBCkhWZfUtN6gCegWyAjzgX2KMJRlQLCKyY/h98M9Ojz7t53
 dpZhKKvmeYp4vIB4cT0twhYQGr2xrf6kcG1aNjoXRv6oE1rULWpJe0LfsG5Fx0EwypEvXMx4Fbp
 6m8pbFpkj7KS2Vlvnrfvfb4oHd2erooO1RJpz64PfGdx+pyUnl2uybgkoJD6S6S770BtxxbU/3m
 liRlXtOqwrh8Q3IviytW/HfsQ1QXNV1DnSceS3B7jNn2SOMAesQj3sn7HnZJ9UrvlaljZCcMhQI
 nSaSzx2s0WWnEZZgxxxyqrou9k7u7d1gpSr5Oz0+p+4wyXHvuDEM/oetEbLZJmGVNr3yqxLvHNp
 aifLAiKq/3vq/UZpAQQBg==
X-Received: by 2002:a17:906:478f:b0:c1f:4754:d87b with SMTP id
 a640c23a62f3a-c246a2efde0mr1612034166b.1.1787586235138; 
 Mon, 24 Aug 2026 08:43:55 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968ba7b6sm1268749166b.62.2026.08.24.08.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:54 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 23/24] usb: host: xhci: fix up after the resync
Date: Mon, 24 Aug 2026 17:41:32 +0200
Message-ID: <20260824154133.217744-24-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Adapt the xhci glue to the re-imported xhci-ext-caps.h.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/host/xhci-dwc3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 3504a7cf42ce..488d39fe72fd 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -51,7 +51,7 @@ static void dwc3_phy_reset(struct dwc3 *dwc3_reg)
 	clrbits_le32(&dwc3_reg->g_usb2phycfg, DWC3_GUSB2PHYCFG_PHYSOFTRST);
 }
 
-void dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
+static void _dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
 {
 	/* Before Resetting PHY, put Core in Reset */
 	setbits_le32(&dwc3_reg->g_ctl, DWC3_GCTL_CORESOFTRESET);
@@ -79,7 +79,7 @@ int dwc3_core_init(struct dwc3 *dwc3_reg)
 		return -1;
 	}
 
-	dwc3_core_soft_reset(dwc3_reg);
+	_dwc3_core_soft_reset(dwc3_reg);
 
 	dwc3_hwparams1 = readl(&dwc3_reg->g_hwparams1);
 
-- 
2.53.0

