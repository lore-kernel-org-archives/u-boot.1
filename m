Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4F7E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6BA805EA;
	Tue,  7 Jan 2025 16:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mDbFaZzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8D3803DC; Tue,  7 Jan 2025 16:32:04 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8120D80601
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f13acbe29bso20466593a91.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263920; x=1736868720; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SBhdBnaEmH3xxDCIZ06a+9DhpF3WKzd9PEIUDPJ+/DA=;
 b=mDbFaZzisMHdEaIMBlEnCy1tx8aYAfNCl92EJXU9BGOedvQY92OcQTZKzyyn+peLVc
 9xBtAnp7g9KP4ZbrFaT8Z3KRh6h+O78LaQBp7xLM4SbaU5AN1qaKHBnSo1zjmQDS0iPk
 8gCXu2PaOPRxoRvvDCYfASQuJjBf4I/8nz/1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263920; x=1736868720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SBhdBnaEmH3xxDCIZ06a+9DhpF3WKzd9PEIUDPJ+/DA=;
 b=ZnscHhVhZFHfrdxEi4fcbKxO9QcFm0/9iW09rC5vFhlb/KV5T0UiVRs4IU/PSq1VUT
 gB4J6alenpIy9U9jNK/7vUBw9Zyf0rd5tVQ6u2jlTrct1w2gbxfg+zt3KZgcU5JG+oR2
 +Sdn+bcbihbS9Hoj08/XLCiFQbNIZwq7Q82zzmoy8ZpO/qsq7RSle+iZ2qiaEYbti2k7
 epm8b4NsPyLYJ4jOIlbiIJvorHB7n/bePY8fpthxusrY4zp23g2girpYeinR9cSI9LaD
 9ZbBz0QE2tDn9i4xxwlnlnpfiRtOpXAiO3Fe/MIbM5d3LOd5FLv62b0U/aptszuvi9Ps
 c3Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqHyMMT5Z7rom+8bjpDEg4cqYgRV0MjvfcvnRuSVFCPuJP9WKcff5D6MOt6sZe1/QFkoROXTE=@lists.denx.de
X-Gm-Message-State: AOJu0YxmRrmmF0PnklUJ9vWD1FNwO8UPDMqw/LjULhaktXFveCXtRvJs
 L+fPj46V+1XronojKqV0Ux7MffsHaPdlWcZtqHjwEqD2hSjeH+AH0bV1Mcap8CXrBduvXwn0Jmi
 6HnyolxNI5UY117dOdMOtjKm5LnzUYeYnFkE5
X-Gm-Gg: ASbGncuZpWTTYULBLsBAg7FEA084NvaofGhzUFriXBeXi+ufXdXIw0TrYGt6+AODAiA
 0rrdE1jmjovNrqhWK85skOCsd4JPUYFrI5hnj8zo=
X-Google-Smtp-Source: AGHT+IGWHLxmX39wjylyNgY2fJKQTkAj7Pqfk5or/1IfhG9rPvA0Ep4ZmXRArkuSW6lTsQRhH1rZ+TtiUh4hT7U5jqY=
X-Received: by 2002:a17:90b:528a:b0:2ef:9247:240e with SMTP id
 98e67ed59e1d1-2f53cc90a0fmr4943153a91.18.1736263920525; Tue, 07 Jan 2025
 07:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-4-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-4-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:31:31 -0700
X-Gm-Features: AbW1kvbkEVIfMJ_U-huZOZS8Yvq4YYHIQceGiKZWEitSjh7dAgHEPRD3yWLpNGU
Message-ID: <CAFLszTiM0UBK7zdj2idSaQC+Squt0FHZaD_Ggc70rkirde0AKg@mail.gmail.com>
Subject: Re: [PATCH 04/15] Revert "drivers: smem: sandbox"
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 24 Nov 2024 at 12:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This reverts commit 7fd7e2cf339ea2ec570f6dae1cdfaf8e066eb4af.
> ---
>  arch/sandbox/dts/test.dts   | 4 ----
>  configs/sandbox64_defconfig | 2 --
>  configs/sandbox_defconfig   | 2 --
>  3 files changed, 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
