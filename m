Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F196BC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 23:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17F7807B4;
	Fri, 24 Jan 2025 00:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BKXM6qOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318FA806DC; Fri, 24 Jan 2025 00:14:11 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17B16807E0
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 00:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-46e28597955so14143371cf.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737674048; x=1738278848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Csb46OObFxtZaBSpxE+VPo1Bw6Eh4xy3YFCs/mZyzU=;
 b=BKXM6qOMiGFI6wyd7JqV4KAqrPTXvrBViZyWwP7elNf+MFFXv+srqbXZLfhKCUaEs0
 3CULaVykPyXmq5REaATeCu2e8I5JjJQHuNSdsE/ellyzXg4cgapz2BSCUPI+6xeDt+Xf
 r9nzV4FF2aZ/lqPGWZKKc11EnWjIMyTN/SIGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737674048; x=1738278848;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Csb46OObFxtZaBSpxE+VPo1Bw6Eh4xy3YFCs/mZyzU=;
 b=XGmITVhTHcbhZ6857n6hBO+cy++mNByN1yuFaRakaCiBhwiRJG16dYCA8Nywd3qJk1
 LqyEI3A1Jp4QaYUsZFmV5R2PgY+05S5RXybDt0y0mnM6bI1zC7eN6qJ5ujhDlP6BQbhh
 NED2/GHMosCuLqcaNiRnlIHwAP9CAqtEybbskFtQ3QpTd7J7iCWKUei83p4uCVSBoTif
 M6PREDgrz9+gqOOQaTcqfYaSH3s6D8xg9GBI2vkCu3ka7+ovAVrq1yGKDXX5hEqci/Cd
 W5Grdj3ZN+V/gbLjN7jNu2ICBrTb4AabcSBRCxnKqxgXivC2IWn6vsIlDnfTrsoU4jcl
 oQDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1GAqqgZ6/3b0L1s/cnxKuFK4L5OUB85xXMve/CXTsJdxOPMVOGfnlG6B7N+LtpUT3wBUZ4us=@lists.denx.de
X-Gm-Message-State: AOJu0Yxy4Qn/f3KcXMvwqBtX77LrMAi1FjLwoIDIB2pXHbCch1P2XQZO
 pMUnE+0WO2sv2fx16kMdJ0iEjs3jidiRiA/aXDjrOMYV0rKrqIm8TY3SRmRzbV0=
X-Gm-Gg: ASbGncuFUukAH3GlruT3oiGnM26OudRHwVRAjb1Ef3zOaQz4DMRBBHAHJ2vriUM02yN
 UBRQBPpee69Uk+AcWxuCBg/dWoqsxQGp6wagXXVTOiWm/fGkH6x1I111q7pMZ+8TLpggAz/sRpY
 8E4uXkHCVM3RRUVLu4Vo0zu40dKstg3q4luavm7bPb139fZ/nuRk4BTB232J+ySWaYePzHCYuSa
 d1nKrPIaRgc2Gx5RotGriyQbcfv9iFd78zNYTXmTFGu3CeAYYaxNjd+iG44SGe5NPFWreTCUxMh
 Bkw=
X-Google-Smtp-Source: AGHT+IHMasIsMjuwXx8I81RsQxFQmWPLT31ixNDN7TIhAcX4T3c56NAwtxStov5tbo4Y7MgeRFs1pw==
X-Received: by 2002:a05:622a:87:b0:467:8378:9e8 with SMTP id
 d75a77b69052e-46e12a56501mr369663201cf.17.1737674048018; 
 Thu, 23 Jan 2025 15:14:08 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66b89811sm3753441cf.77.2025.01.23.15.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 15:14:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: w.egorov@phytec.de, u-boot@lists.denx.de, 
 Daniel Schultz <d.schultz@phytec.de>
Cc: upstream@lists.phytec.de
In-Reply-To: <20250115103813.844488-1-d.schultz@phytec.de>
References: <20250115103813.844488-1-d.schultz@phytec.de>
Subject: Re: [PATCH] configs: phycore_am62x_r5_defconfig: Increase SPL
 Malloc Pool
Message-Id: <173767404695.3025404.9306445799675049380.b4-ty@konsulko.com>
Date: Thu, 23 Jan 2025 17:14:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 15 Jan 2025 02:38:13 -0800, Daniel Schultz wrote:

> Increase the malloc pool size for the SPL by additional 4kB from
> 0x7000 to 0x8000.
> 
> This fixes following error message:
>   ...
>   alloc space exhausted ptr 7028 limit 7000
>   DRAM init failed: -12
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


