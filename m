Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35859CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 07:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BEB683BA1;
	Fri,  7 Nov 2025 08:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HonIsdFJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3432A83C5A; Fri,  7 Nov 2025 08:17:20 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0123083B1A
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 08:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b626a4cd9d6so63234066b.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 23:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762499837; x=1763104637; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VA8xsrP3i4a4nRTpVpQOlKt5muty7hkCycJV3aO7wLI=;
 b=HonIsdFJ3dP3Q3OgBfOgd8n7/iACLHbZKadu556+gnsT+1iB5SzC32AJ31CETWPvaT
 B/Fel8TiTNyYL5wWCP6LlccM/E68zLeO2KmP2A2m429uxdG3xpLogZiwP+/PMkcCUJc2
 yktx/GDa+y2JGxokAU7QVRp+wzzYgDmy0Mcqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762499837; x=1763104637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VA8xsrP3i4a4nRTpVpQOlKt5muty7hkCycJV3aO7wLI=;
 b=nEqF4aK+zphT1sxNxKjE4NR0r7VHCfv6TOwU1WyCJXJtIQScI/YSB1tC/bh+to9aiW
 LUViMIY3W4KYeCF/iaGGlaj2hcQdgN5e1s6IEkHMTzrHPjAZRmrHbDZ6Sqe7Cu1sjXY0
 2gAd2L9W/VVqpZeY3qdn09Qf7isHrlcAs2omAO+Wk6Yu1MS9M70jUy7z2UZR5PnVwPwQ
 elGlPx+rOaR8ia+Rad8EYMhkB7baSbbB/D6lk/QY2bGqNpnKL+CScUVtAKPSkjbWN2x5
 uETmiYp8MoiQrzGokadALFuOD7KBvts8G31G2kzQrWiwJNx/0EZsM//aWqDRZKV1TH0p
 vozA==
X-Gm-Message-State: AOJu0Yz23EA1FSNcC424wA/ITqZPdXdeHd6V6uc944Edx0S3Sfz9KRO1
 Kr3+9553yI3AHeuUlrlAClg1vF1KbjKiSqCbG5+8aZJpbnkuU5opOdvByt3Tl0BdWX5BrhLomAL
 O7kkvKDfcEleOBwBPLyOp8BBLQKLQxsXBeovqvWVdJa5CAjVZON8L1HU4KzA=
X-Gm-Gg: ASbGncsc1yXKuTICdc1PWBAcZc/ZmUyFFFgprWpeUnJkxdpvjcGTW0D2+Frr5CeIHCe
 5t25eFKpLZAsW7/FnOUAp1tPh2y62cihB/D8QajN40tEfEGL00EObPPJQbQHff1B9qlV2m3p4pV
 S0GmL64cGJutY5WZXluZHFFgt8K6MbBZKzN5vkJP9Opaodu1wxzEC3tGA/3yTa6CNWgMGR6qvO+
 GvXVMzExpRMiEluacbksDwz09dK35+s2ahirz6oAEuTxojDy8Dlx5Z9nVw9vdpAx+c0INw=
X-Google-Smtp-Source: AGHT+IH1UFEhQyt8UtyVtQ777V311IhtTI3Ottd3mXdoQ/cDeowv8qnVZPyB2wbC50gUT9cf07aygT7jG2dY58fjtEA=
X-Received: by 2002:a17:907:6090:b0:b6d:7f28:4319 with SMTP id
 a640c23a62f3a-b72c08dc342mr204954366b.3.1762499836730; Thu, 06 Nov 2025
 23:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20251106232833.3243530-1-trini@konsulko.com>
In-Reply-To: <20251106232833.3243530-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Nov 2025 08:17:04 +0100
X-Gm-Features: AWmQ_blgCT4e_MqyuxOOlHVzd3OYxhGDf2tCfnIDxbaBZI2wDO3gnRW1AAhmz_8
Message-ID: <CAFLszTjdNP70SO9dxBFGVOBhkt=32r=QqDZSOEhcmft2kxwiPw@mail.gmail.com>
Subject: Re: [PATCH] Gitlab: Prefix more of the sjg lab with "sjg"
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Fri, 7 Nov 2025 at 00:28, Tom Rini <trini@konsulko.com> wrote:
>
> In preparation for adding more labs to CI, prefix more of the sjg lab
> components with "sjg".
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .gitlab-ci.yml | 54 +++++++++++++++++++++++++-------------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)

Great news!

- Simon
