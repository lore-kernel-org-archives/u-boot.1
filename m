Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A21E8B386
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C376483EDF;
	Wed,  4 Feb 2026 01:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HoZl4wlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4E283DFF; Wed,  4 Feb 2026 01:23:21 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AE1983BC8
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-65808d08423so9197359a12.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 16:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164599; cv=none;
 d=google.com; s=arc-20240605;
 b=L9CfIaJIaNu6vSShWiX55/NYXc4GI1j4U6qkGTGGduTvD1t0lNWBOEiJNUElT52L3O
 AKq1g0cHWLpFOhyHrUN1VGrmvt3Ishzo/VY4yHjz69TV9LvpkIZLx4ysTr1PwiJgAw+t
 /p2SjLnw4tAYdhkDPqbBltRmFyekX3d8zTGIzBImvvi952ImXCHkEw3Vsa5taLn9iyn0
 LVwNrOWhIBKtHu3XquSK7KPm9pCYxjh/fDTrOIvGShE2z7U2G8MuN4XdeVhJP/NhbmPM
 T0SIXfEko8HCzJjG0tgcUyiDsGN4IytFjeYwcYFSa6nyQpHYXjK0afCDm4qHprq44PND
 goAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pm2EXqRRMnIqgpiMg3yFbYr2w8CzHwOfbsOIZ+2Lemw=;
 fh=PWwjxNZLyLPA5YCzCtO+8SGlX5HpICsemalztPru7EE=;
 b=XwApJSzzp9wAU8LPm2tVJlnmtNh0wFjudQKmksHo9KgmhPbSMvXwwvhtSLsyzd+HZp
 W6p0olBTd9UcK9LB5dn7YXl5Kda13zF6lp49O4hByBf4E6Juic6woHPcCQPtl+I4yCoS
 WvDP4yad/IPIX9oxQYNqMfS3pwOaJgeGouERklSXhPU5ZgFzLe+bTww3oTEkYQxp16ST
 ZR/uGTRNMiiuBqHGT7xXNWuR0RJyjqs75XHMaeWsuW1MqstlTna/4TqpXAlum/9rGSQf
 EjCSKzfZzYu4rvz2/jnSgX4I0+iscZn29/FpdCKclp+9USrs96M1Q+mfl9KYG3JJBkgH
 qHwA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770164599; x=1770769399; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pm2EXqRRMnIqgpiMg3yFbYr2w8CzHwOfbsOIZ+2Lemw=;
 b=HoZl4wlofbXhVKjoDYlNoHsvQFpnIR53iAAbT88Z1ZGUWOVd8b1Dq9slnDNHMY1pjI
 VfQM0FBoWd/UsvCmQrN+2UC0PM03qbDRVhjftRJ9mxzFYnqSQF+IyG32MmBsU70CrYUX
 YVx4d2eCpQSrA9w3fNeUcOWULFIZ0mLd+r7Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770164599; x=1770769399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pm2EXqRRMnIqgpiMg3yFbYr2w8CzHwOfbsOIZ+2Lemw=;
 b=ZCtfxgTco7KI7GQyptMrQr+qbIuo1yRfO60Lqi+o7Lm2J1zsRSDFZ+AwGauNyPh5Ei
 0SJAaKdSyl7UlWEGC8tPb9TziDXfkh3ABvqNGwIzfXZHI28BkbNQVu43ChW7pDI4VX+f
 mTN1mY22i1fQFex5w3bDDk1BhFbSkaDN8YCNOjnoQEXwVlnrdv9C25+AZT+u/+6oRcFs
 nVQS+U6KagC6EgWuEKgHj44Fv+IhoK6Ruvo6RzSLZEkhj+FWVANxHl1vtsCYNtN/QFlv
 HuWVkRs+cSIfCm/70frlDbclKoFfVKXAgqhfwitLqMm5r7x1zm4Ub5a1+Ppfg4M6tswZ
 NhJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1H3aChhoqbXBmbub48qfvmcBBwSLPTRk39V4rS7vyBL1YTguvrdzvfTY7BMC9QArYsn4+feI=@lists.denx.de
X-Gm-Message-State: AOJu0YzsWrpUNdN9xR30kqfqyFrSStV1hwz4zIlfGjbbwD3MlKtxXbuW
 znK19a2aUFZXka3LiUnrEWX5NItxDIEnxVr0C33IX5PUBN9KgzpWzuUKcnnNChl+oLsB71zQIs0
 ms0ntdPMkm5lx6iNViJPv0DXcru81VTyXp1gnh7Rr
X-Gm-Gg: AZuq6aIyKPTAZa/7e73Rtej3NLHr3WhyBPjUcFor1Gpj/JV4obiXN490r5YEdaNJX7f
 qMtYJsaZF3bU7kk5jQRzafeYcekXyBUfCAnq2vTR28NCVk7yOH5N4q+cBwRW/YgwpW6ECxbEGbH
 CHKJKqquvAAmybD80OFDMPG00Tm0r4qbJJ9/ud0yc89AiEOxnXfGlMnxoy5Z9U03QWU71WhPFHv
 VC0FTCpSXuD971jrf6P6sD/vk1017lMHwzGHWcoErjsCA/qEfQ9e6F8h5yXQc6b3WssZlnX
X-Received: by 2002:a17:907:3c96:b0:b8e:7dcb:7f1b with SMTP id
 a640c23a62f3a-b8e9f18518fmr92276566b.21.1770164599518; Tue, 03 Feb 2026
 16:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
 <20260120-clk-reparent-v3-6-0d43d4b362ac@outlook.com>
In-Reply-To: <20260120-clk-reparent-v3-6-0d43d4b362ac@outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 13:23:09 +1300
X-Gm-Features: AZwV_QjvPmt72lY_WTqF55YfKc-5Hqw8WlKB_85uWkrSkd6LFkq4f6J0gKb0tWY
Message-ID: <CAFLszTiawAwf-s0s2m+eLVEvRY8Wrn51fVfMoOiDTnie-YyG6g@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] test: clk: add test for CLK_LAZY_REPARENT
To: forbidden405@outlook.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Tue, 20 Jan 2026 at 08:07, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> From: Yang Xiwen <forbidden405@outlook.com>
>
> Add a test for the newly introduced CLK_LAZY_REPARENT feature.
>
> Modify clk_sandbox_ccf driver to register two clocks(i2s and i2s_root)
> in reversed order.
>
> The test function then try to acquire the clocks and asserts that their
> internal states are maintained correctly.
>
> Ensure clk->parent_name is NULL in all "normal" cases so existing
> drivers are not broken by this feature.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/clk/clk_sandbox_ccf.c | 10 ++++++++++
>  include/sandbox-clk.h         |  2 ++
>  test/dm/clk_ccf.c             | 40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)

Reviewed-by: Simon Glass <simon.glass@canonical.com>
