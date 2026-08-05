Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187D3C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 19:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E098402F8;
	Wed,  5 Aug 2026 19:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhbqEnB2iV-8; Wed,  5 Aug 2026 19:43:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5220040340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785959038;
	bh=0otAZrVqJvpdeWn1u+CnVAqEwnSzldI27VgcePSLHOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7mVpj2PqWD56WA8YkLjd+Dxp3uYxEVzN9psAbzwukj8fn/VTkygRGBzmU1jeJLkl
	 q/9Pg1JAVsilqH1AH7tL05X2y9E5EHNuMm35bMIyF5WQG2j62KclXuCdXLtOVkjCqy
	 Ex4lFwbkY4W1sI0v9LlWQH0whfVar/pq/wHGuduo019411ENPMZ33gl7lRa4JMLcUF
	 K2nbOMRJK1akQBp6nTxpJpUQwvomrx5vW+GX2PnTySFmjPYb9gKLyhRWLvLyqRvBiM
	 /786oSddfKtBVMEtf3hXXGOfen1UXgEAwnB9yAibtfwRSHLk+Iw2MoOo7x7JNkiPUt
	 Q+vT7le6RV9Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5220040340;
	Wed,  5 Aug 2026 19:43:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 56053397
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 479F980DAC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j9OBAB1e8qWy for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 19:43:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 18A5980DA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18A5980DA9
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18A5980DA9
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:43:55 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4a416619cb2so940563b6e.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 12:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785959035; x=1786563835;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0otAZrVqJvpdeWn1u+CnVAqEwnSzldI27VgcePSLHOg=;
 b=HqqfCxzUfKukVzjH18+X9Q2CVr4s0mdX8h7KhD5PQSTrcFOfDP3lx/y4RMCmp908Rh
 qbsX2FYvIUAE1B6e6PSBhZIKQn+BuZEC4kIwJ11FZlrJdeOISBV31J4gvABQeIslf2ym
 9XAubz+LYPluz64guxBWGXcQTwETMSLMgLSDi1OOLh72e36UA22skDG3RYSXYowjOHsk
 yHmNKtgqSE6hTR4zp6enAfrUmqWULhuHgBWZIw6KIFPvNt5TTiIRzzYuwEPPgL3q6bZh
 DWrmUittMjsEAO7h6ldaXC45RxXxyn5XLar+/hvlRUuJ/hGtTKytxZtRs/accBWfnlpn
 vY6w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3XDSuoEQoKT1X9NQJfai+G98DJiXXwd53d8tueE8W8SMWP1Rc1V8sU6OU7pb4XijQMYhRVYY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyulCghUuj0+QevgCpI0ToNLw4iGwiIuLY3jni7hZOBr6ZnFFJV
 +a85XC4pxkBeys0/cvEW1gvTXu7iaANstPPJB9mTL0f60MTL2fIw0hfujzdATgEUIwo=
X-Gm-Gg: AR+sD12z+FIujmNnNC3/8Vz2djSxkvW1dOXIBsdWhA9LMj9sorpkLgTIWdBGB+mZzzx
 11+ZQK58TxE1rpo3vNzw8IBjwuP4TAcpOqsAhtToINLyhoYhhAjyLpJWS/XJy9ZpNlpM53Al7yv
 LCZeGI7xgtqO0fDlWrXBywGAevwdfgM2D1YSz3J+r2oU3Hl74t2xNuPcIUBIHzh4ft972w8kiqM
 Fo7VybnC93NZPIoT9f+lkrKq5iYtEF2L5J2XtIrg3DhNE0nIABW2d0mRdQLGBAyvrRT6696PdKh
 1JweUFbtlRy3y7JKsAU+sTDDASYvPNTrmdcM+aYkv1VN2MvDTYBvGU2DPITxpNgBHOA2ljC8Cir
 vDVqbiZI7P3eZc7wCVc9xa4pBJgVqghx0Bp1xhqRnMns+brrQIm4IuxwT++uITRQbXRzp2f+V/E
 Eb0JmYsfANu4JkbkfZS43F9mPzrqt5EIBnbngrcHoSf0da2HUi5qiciozAN+D8DGUrug==
X-Received: by 2002:a05:6808:179c:b0:4ab:3210:b31a with SMTP id
 5614622812f47-4afae11f1e5mr4895420b6e.14.1785959034727; 
 Wed, 05 Aug 2026 12:43:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ebef:9550:d591:36ac])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae706cd5sm2793124b6e.11.2026.08.05.12.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:43:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20260724-ccaione-upstream-mt8188-spl-reset-v1-1-08da6554ecd8@baylibre.com>
References: <20260724-ccaione-upstream-mt8188-spl-reset-v1-1-08da6554ecd8@baylibre.com>
Subject: Re: [PATCH] arm: mediatek: use phase-aware PSCI reset on MT8188
Message-Id: <178595902214.2270888.2623879042128520054.b4-ty@b4>
Date: Wed, 05 Aug 2026 14:43:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=331; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=RG9YFDTbsAd4qnT9+4AItSHFkpOKLrueA2BREmyj1+E=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqc5JwqN8JM8bZKQYX8R1pHSkuCyfnNF6P0WHi9
 CTFSROT+DaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanOScBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArOMIAJix+2sAxD19lAoWoHVkA3T2ANqR0OaqDUgDa7n
 JK5LBIJ6LR+VDAMRt2Nn+XlZcr3PPTqs3Tm12JoNXrn5mECWXJyFNbEcE8Hn7zqlVuyAJCC38B2
 hE/YrfYxET1BNW86TMcNmG5AUWnX7qKvtSw8XSTDVABd7rifIcIlo7lK+FL/XjQ8Gs+SUfpeI/B
 ykzci/9DS6Tkdt1QjQfk6/2ItlD+iSS+t/tFfa1DnqaYbTYUVVbcSR3FvcavYSK5Fyc8mAkBnNA
 ENonvCUz+mL9cC/AsXoTd6Virz+sqvsjlGCj2n6GreWOWPhg3g+XG8nMVvjpY0hEjBUiK7AbkCe
 Qq0w=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785959035; x=1786563835;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0otAZrVqJvpdeWn1u+CnVAqEwnSzldI27VgcePSLHOg=;
 b=loSQMyq4jCABfcFXHVAQrUsDVFMx1kNl+wKaag2bW5W2Stbtddh2wVY2NitNWOp00r
 rZsFV1NcLHvyI1YNj3c0FJ3xS4rr//bNpj5eR6wFnHJVlWAvo96+g/iod6CCuDzn0S8h
 5OHisuGK9UW/IUOgCU3+naJd0pZi8S8iqdlP1upFNCvzJOwxeiS1EaORjL0D2Zr5xHDC
 rjKnkHQXNnic6//reWnKQ9cq1sHQAqqYqoMv3acR/th6e+6yMITFHiXyyC4i/g+VJw8I
 DfNM615ufn9DkBmHbERNPrdxjrKK5E93NXHXD8cdxgjBDKVzQmrHcGi2c+jGbAjXFypb
 YSzw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=loSQMyq4
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 24 Jul 2026 10:45:09 +0200, Carlo Caione wrote:
> arm: mediatek: use phase-aware PSCI reset on MT8188

Applied to mediatek-for-main, thanks!

[1/1] arm: mediatek: use phase-aware PSCI reset on MT8188
      commit: 6f10b3a1a0ed47c061155add5b03e4cc044332e5

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

