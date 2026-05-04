Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B5EFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6988466D;
	Mon,  4 May 2026 14:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O+DZW5c+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0788394E; Mon,  4 May 2026 14:27:36 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F9D84664
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ba8472c1613so728324066b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897654; cv=none;
 d=google.com; s=arc-20240605;
 b=NK4fcnvlOHwQ23bs5tSJzosfbILa0q0Alcpl35KvehksjUuDRkc0XRcnfSposeUqYE
 TJ86FY97ihqxSCI1yfZhR/BFkr8kuVJYiArKKCdYvvUlVYFzzrgoTDG7U6LSjcz1ef+n
 fB4rNEJlIoGxRvAUVk+1YtUk2e94e4syrAT8q20YPWiFzXAqMAnWJYaH6U4WiiYN4yn5
 Ra/o5T7mTO+fKPCwHUr7/Cu5YvetlMXIzsqFbwKWgzAgOqYcg+I8n0KlhvTRX1gC4J3N
 bV0jxYwMXYnm085QA07Hfw9wq90hnPRFOheGBJRm1Y7zMVJYDa+FtKOwgkSfVsxLPNi0
 jQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zI8Pw6btTVABCB3HotUdYlZxWPiQvoVHOBGxARmjI9c=;
 fh=PKU69MAUC1Uf4OYW7rlT1pB/QcRI58pIXTPjOErnGJo=;
 b=hxnVRKRq6uIbwz12T8L9RSOS4nyPMgnLshspAXEhiR7rDoeYqhPWXqJ6u6Peng5LXc
 Z63JaR8XLKqg9BBuDyl6sTIb0jANWzJxeYXNQ39lLKAi3+HBiNqBiOMZ586p75iEec6r
 LlDrZmK0z4ug7XoA5gg0JWMiDZTLo8sCmrqR+fEn1km1mP+JGmxX3FVFlRcxs6Ve0+ac
 ev0VwI/zUraSAUowekvBvW/M2DMRJj1VWFJEgbw7uTOnfpuPqIXmkwSR3RgDwlb04QDA
 MhbBx76XHf1aR5p8HUNcGJB9XBcVSLA0q3hdKOgWwUhIoKbNryOqFppiDMKPY1q8orRH
 mOqg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897654; x=1778502454; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zI8Pw6btTVABCB3HotUdYlZxWPiQvoVHOBGxARmjI9c=;
 b=O+DZW5c+y6ISegn9i4B8c3P9/x+8713rMjQsLN4QvYfrYNvkQRT9TJl3zHO+66xLNG
 kN2H82fle84PowRq84opm2WmBZuTeML59PtBgroz/9SssqiBRwd6d7o2IAVWRxW+luPb
 qffXdEfVku0Sh3+DcqYzRQlxzRWH65AVUiHfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897654; x=1778502454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zI8Pw6btTVABCB3HotUdYlZxWPiQvoVHOBGxARmjI9c=;
 b=eMu3dWuoBpBSSN5+pi3+xNb1H4nPHMQtOmtpAW9zaoA42WgyjCZJ8VjKU9ZoysRWG9
 8i5nHDHSU/4D1HqyZACT0XdYpHk0T5EhwWhVkd9tbvXTxXGgABsMoY46fSo/CL5yvtN9
 qzLfwdxWS8bbbARnBRRYdRg3ktmnRYY0azL71kTp+w8OtcOkHSsPHzJ7ho+Asl09mQ6K
 O0ZuBf31o4FBVURgnUTSdAvaGDx9M7QrlpH0YkhRk7fy7zDBrFBpW5LqDnc9kh1X9hrR
 r/M99cM5zyy3kIBAM1Rn13DIukITvNF/7kh0xn34rcvLAJ5ygDABHCZJw+GG7mClRIgM
 HxbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/teul3WPBxYx+Dhlc/wkzyEAlJTRbbHnh+AH69d2N9j7MMXDxPfbrX1LzvGimE4512c03e2ss=@lists.denx.de
X-Gm-Message-State: AOJu0YxjYfgNSvAolhkHsrwpP3DwyHBjPuDlnuJw2fAMtDKd+oVroSfL
 GX6YUH1Tk/755fWK9GO93cu8UvQTx4yL09M7VlPjueHQlQp3Jk+kOCDRfeN+2Bl0dRAVizo9LGu
 OifB9VxNryYT7DsRPniU9OkMnmE0pUQWbK0fax3vN
X-Gm-Gg: AeBDietvv1rNO4GHkUCwihyxZIuEaQH1b2XMWmaIApQzQSXxT0xEtTdlTN0YJZkyjJt
 TH20/UBfTe4cQCS2uwxSj7z+iS8Bnna+1FbriLOcODy9xcDaVuZipKNCnBQ6UUBPvoeeonYRrDu
 3sKgj9GeMteUzuZin0l52hUaqLjHhNW6C2Vm2MGBjPZilNyuMeN5FBcwQ5P6is34aQdlvJ0haYG
 y7IYpDeKRC0MPGJiyxspNTlUPSJMhYXuoZh/O54keU/J0N1N/HbkChQQwYx9DNDHOfiy1wvPZ/b
 qCqY8W2NZ9QmDjo8
X-Received: by 2002:a17:907:9491:b0:bc2:ac1d:2a9a with SMTP id
 a640c23a62f3a-bc2ac1d4427mr140915766b.8.1777897654118; Mon, 04 May 2026
 05:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260429154000.71351-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260429154000.71351-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:27:19 -0600
X-Gm-Features: AVHnY4KERBwsm2sfHJOU7cNFUe5GWozHasU0wJghHOW3YziNedmSbZszFUhAjSw
Message-ID: <CAFLszThsVbNmH1j7Hx9Rf9QqxjqyVFv_zt1JOsPU4oB_L2NwFw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: initialize variables in efi_dp_from_http()
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On 2026-04-29T15:40:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: initialize variables in efi_dp_from_http()
>
> When using lwIP, efi_dp_from_http() may fail to initialize ip or mask.
> Initialize the variables before the call.
>
> Addresses-Coverity-ID: 645840 - Uninitialized variables (UNINIT)
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/efi_loader/efi_device_path.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
