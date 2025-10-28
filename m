Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF46ECCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CB2838CC;
	Tue, 28 Oct 2025 17:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w0fz40Qg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A593B838AB; Tue, 28 Oct 2025 17:57:36 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF0180422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso689575e9.1
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761670654; x=1762275454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcaZfKenHXyOnmZ8HRypBG/k+e6boWdZ66CNR2SoG9U=;
 b=w0fz40QgPl4aRvi358Km5Ui/k7R/cks8421c9+2ReRFd3z0eBvuy68TVPMvrmRgMeJ
 0JVzACZLbGmQ5WBDO0At2eO1rCnHJWhZwNSBhElRpR1DMRyOT0fXZqWu2UaFZjbb7aCr
 yNdUVcBE7/RqTijI0uXXiLm4liZCwBgJFBpe+hoAvbfaHBnxZ4Bk5zRUmGACwX8t69AX
 6uoNeAn7E/1bc1lSWp8xj4f4lfuFKD/ihQvM1BjNedpi9WSP1DGhl2+vDhSdq/Y0TcUa
 Rqa/MAg6AxfrO6BqclBCi/YsYeMQ/kKSZnyvh4/rPBi3hLhzGbcPpnqMMoioNp0zaprd
 2WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761670654; x=1762275454;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcaZfKenHXyOnmZ8HRypBG/k+e6boWdZ66CNR2SoG9U=;
 b=gvyg6rH7D4khgg1/A5FkCjGpfs7zA/ZMSjiZnMjIWHJYwDWgYGyaU/8do6T3ZBPt3H
 Lp1uMoXWLTuwxDvOFdrKh5G2Lh8kADuFHAV35oHlwo6Dt248DD7fR+9wrK1vq8x0JRrU
 EOFD3eH4if7oiAsjakN7L87TZnMwF0o6TWKPgKDpTELElC+LrN40ln1wL3vAaHkg7czC
 lgQsFY+kOEBMX3Iif3RIBZdqWxRUGmkaCzbxzL2KU2i2SVKzZRNqA2uQ+kKuqHI1SDHk
 fO8dCRHRixb5weBRx6iLBC1BPe5rrXdPPk58MWprMDkLeNWDgR5R6V2QGExQjkHGMmJc
 /qmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvY4qKscVcK+8XXSi5i3bOwoxF4bUJKY5/cl/UeWFFvPZ+cQH9k+x7zbGbhH2EzKjnO9WxfeI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjj5TzlKtU8qmoZALIDc/yWmXKVoLYgqpI2ctGyIz0AUW+BCzR
 OKjxrSg/D1eKb7dXft7uP4KFTPdHF4Wa1+TDL2YX8JDtDZOzjThyvFE4cZSXBHTQmPv/hZdndZq
 Ev+sCwPU=
X-Gm-Gg: ASbGncu0oHJgTr52uiS2enSARr1KB35kNG0cyKDgZQsPrM/xfG7aw+h5VoTR7yLkQmh
 yx+FeXYQ2oJB1qPCoy9VdPWqPr7ctyfpGeUgfJtWE5q7cDSBdIvS0E33+6txdhvEPSfFiOHRQf8
 4aEit3LZ3FGeWMHllPMvSYnM+0Yn4O0SmXOlpraKGwhL62bOv31in/1apPDrw8PctqiU2r3TKk3
 2/06kk0/NEXp+akG4C17id90LkHAUUL5G4kVrFPX5nehjOusJb5LePsMKPEGRHIsN3Jyjbn+VDB
 SQYXXODhQwfjZZF6WgvMFD3Fa0E7PLp06viwNphFAeP0Vjia6dPYnUowUw2wyLrb79IDOFM8Ax+
 3kqUtoIYoVhIzAWlQhERKlNTmbiw4FtGnfMDDi9DTutjInD4DAxz9ZAv9qW9DYW8yCfbSySIyJc
 7WLPpT0YLxrM2yNi1guRanGltzYk3qCmc=
X-Google-Smtp-Source: AGHT+IHfy4nWgU3iFqijeph339lEsxa7J/7d7bEasRq39ENpyms6xXFYdNYgDyC2clPJYbIFc/SGsQ==
X-Received: by 2002:a05:600c:608c:b0:475:f16f:6e10 with SMTP id
 5b1f17b1804b1-47718170f3emr33772985e9.18.1761670653631; 
 Tue, 28 Oct 2025 09:57:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e222ca5sm1971495e9.15.2025.10.28.09.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:57:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 YiFeng Zhao <zyf@rock-chips.com>, u-boot@lists.denx.de, 
 Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <1760948182-128561-1-git-send-email-shawn.lin@rock-chips.com>
References: <1760948182-128561-1-git-send-email-shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 1/2] ufs: core: Add ufshcd_dme_enable() and
 ufshcd_dme_reset()
Message-Id: <176167065304.4104072.15229239139509160351.b4-ty@linaro.org>
Date: Tue, 28 Oct 2025 17:57:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Mon, 20 Oct 2025 16:16:21 +0800, Shawn Lin wrote:
> In order for host drivers to use.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (master)

[1/2] ufs: core: Add ufshcd_dme_enable() and ufshcd_dme_reset()
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/84919722e6a7af63729e2289588f4dfb37b43879
[2/2] ufs: rockchip: Add initial support
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/76465ce21ee4ffe0491125a52a5db19171baad34

-- 
Neil

