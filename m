Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01C8C282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 18:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3D68129F;
	Mon,  3 Mar 2025 19:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PYWQF1Ij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5867B811C1; Mon,  3 Mar 2025 19:45:38 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A64281269
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 19:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e60dfd01557so1239056276.2
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741027535; x=1741632335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7TNDkKhx+hLFJuYrsgY9GSonSfqHyRLXY4ZjW/RgnI=;
 b=PYWQF1Ij3co8AC9ZFTnVMtNlIM7FzHPWQ29M7MUIVeLERc/HsycLk8+fl3i7mdvyAr
 khjNEWczVdNOV86rlf8rRThnUSPX/tg29bibcvCGNvldfEJckOw/EYmVKFJfMRenoZSj
 oA9k+klQ4BcRkNhoV4qfHHedMr6gjttAnJ7Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741027535; x=1741632335;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7TNDkKhx+hLFJuYrsgY9GSonSfqHyRLXY4ZjW/RgnI=;
 b=vHauW8NNqE+uzFjL2cftSiNAXd8kEwHkekIiTB/TlGHnBeOipqM6cp9aM/N0tc6tqe
 ZviLvcVLJ9umb1YczIUEhAq3QJSyQy6QrX5QzYaBhy9fgKcJK9Tvrnmg2VqtkEMT8x2+
 1e8gjrmtyrZTdaBRbd9n4gYazYhnYLbnEQu246IR9iG/n1QTDUPoaB0ppRg/uKdBdCDQ
 t2k6cYepZAYCd6mGGvqMCDf15PdxmCCvk7gNvf11PhFEHP6O2RHjGZK5KbEGiA8gwcVa
 JPex30y6edu74Smcd8+J70W+X9gHXNu+dzjeVQcy8HSvNO/u6O/Zx2xa8EMpRjPMAXT+
 cKmw==
X-Gm-Message-State: AOJu0Yzfj1QhoQTz3dwePJ3eM1B23Rig5lX4r/8+yUr92hd4zCN2jwhL
 K6S+CdexCQA5QCZv0FPUjbqjfbvGIKq/KFI+VBkrJAWH832+IU/IDjboZiB/1tM=
X-Gm-Gg: ASbGncuHrHsaNJZqFF10tNkSDVP/TJy7EWpvATKquCtF7/0HtgupOyOnkjXnUhEjO6O
 jT172yrJvOhlJ/5pQIPkH+rWbPC/0+DQNZa5bXxh/o5vD+eX6hjIYP41vRdW/bahY/oJ1JPpGSO
 dWD16dWJw/mLHlM9p46HnDLaZ4/aQFkSoodNXQy5i2JwOtWB2KBqjfyu5zajjIhQiCZv2EnFX+w
 qW9NaH17mYdVFhsrY2URD0nE6Kg+khsHabzjXUIL7fBPLfLk3rzJIbUOa4bGtDfOTeLqMtMgmTn
 sCT8jeNZ9fCMSwGnKQLBXIuJ2GYYzfQgo4gs04gpNg==
X-Google-Smtp-Source: AGHT+IGmZRRVUeTtk+Exf/peMwRgdt4Tk/UtFlOtgHRqHdGdw6f4CLQ3+2Q7jtVX5KMLCSb2dyJISg==
X-Received: by 2002:a05:6902:2182:b0:e60:9cf7:2732 with SMTP id
 3f1490d57ef6-e60b2f38c30mr18014253276.33.1741027535110; 
 Mon, 03 Mar 2025 10:45:35 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3a41ab9sm3192727276.27.2025.03.03.10.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 10:45:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "U-Boot@lists.denx.de" <u-boot@lists.denx.de>
In-Reply-To: <PAXPR04MB8459E662EB7A8A430FE706A788C92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <PAXPR04MB8459E662EB7A8A430FE706A788C92@PAXPR04MB8459.eurprd04.prod.outlook.com>
Subject: Re: [GIT PULL] please pull fsl-qoriq-2025-3-3
Message-Id: <174102753415.1504497.4444262170388339857.b4-ty@konsulko.com>
Date: Mon, 03 Mar 2025 12:45:34 -0600
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

On Mon, 03 Mar 2025 10:34:53 +0000, Peng Fan wrote:

> Please pull fsl-qoriq-2025-3-3.
> 
> ----------------------------------------------------------------
> Re-arm packet buffer in error case in tsec driver
> fix LS1021a build
> fix flush dcache alignment in caam_hash
> ----------------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


