Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82036D1D47D
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 16:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06B0C84158;
	Thu,  8 Jan 2026 17:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b3xrB12p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 241E684181; Thu,  8 Jan 2026 17:16:12 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A29E84150
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 17:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so394847666b.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 08:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767888970; x=1768493770; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mhLNUAtS0RhnwQEHOv4yBPtPVxgThzVHKtKXAA9eNDw=;
 b=b3xrB12pe/z94x1KQe3NtsiE3olxbC2D4q7JXyqDEVewBBOlSDui/PCL8HJPvLCi4W
 ySMYIfV8kimI3uJifq4ovA5VchEN2br5w/03K/msLk83jM4C0ucJhBNAp3PhMAtymGBr
 eUbJsqWuFl4jfPvGsz6Bu0o2ZcOs2F1JEV/IDesHpYJNnldugjkZXQbm/I1cy4yWzEtO
 66uKHcIPXHhg2tWWkRR4/uNd+8RJ/Ir/HskPJfo2/vJY5wfv65uIkxpxmHmgz6HJDcgi
 Nwt/pHMmgx/GiJrgWxxTShUTO5T3C5TrqBnhh66ke34CRG0/Hi1YjDXfW2JkryiXog/b
 dKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888970; x=1768493770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mhLNUAtS0RhnwQEHOv4yBPtPVxgThzVHKtKXAA9eNDw=;
 b=sCkvyU0y5jkilZghzWBaSveMv2GOkCeN4prO9IUNg8zBanDBwN69ShvUtlVq43X6fm
 bwB1fLyATI6KTDlfOUkB+BaA75UzOxjH5wXFite2fd6Pp8dBSiQHEfDe+7yqbzHI9NIQ
 6kR0cOSq+1tVGXvE4Pe/1sLjq+5ZTRukyXPmQxhDIVjIR+jcVoyhFaOGILIq7fjw8jRx
 0bYMhI/sLeSMP4rDI79CTvY70yLuukox/SAjPRmRii8QKsfQ3JZDYFCfXjd90wY+cOOs
 MO+LMbi54L2rZiLl8ToUTu7Mogygs+43OieHdzeP2ssj9JIR/UmcW7ZLvkjWyu7d3/lR
 dKPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSt6+9tufxCD4b414lMORy9Fb9+lzuGikLq5nF+Kxf50UHx+dF70fsHB0Kc5900RiQfKFqfNc=@lists.denx.de
X-Gm-Message-State: AOJu0YwRjzXvAHXbDDzalqIKmZ6c91oPeNjShMFJHVUGITJElooTACjq
 IgLCPsBxK1mf9F76uZAQeZI42CWEa/DBac+8GjoWPP/CrHSOK1a2EAoqliULAdq8zzw=
X-Gm-Gg: AY/fxX6T1wiKz5rVn7t80CrQuNvUtyV7Wsx4wCs0+bAwXmrM9SCFLP6pSxNvA4BgxA1
 ioRrOQ3pfhpObWO1RoHde7VZDo+qaN5aQOjSr30cL3yAUtAg3OUR9ym5bEJ47956DhQr/DSVfCa
 6bx2teX1yMOVgMP20/lDyp3tbUXtHPDSWljUQ3nqfkIDtSfDmqYho5dWbuEMvl1KNzITfVpwRXb
 5ElijysEbnggIYbMXc+wIgbHzklvwN63hApyFE5l75j/BYI70R+L70lGvL1gCwNx+2tfXmT/8Cv
 yOIHbB0+S/Wy+4Pvrjt2v2YzmHtnYkCq+1jEpY1pPnpaz3rhAKzQHwGmQnln1I/673v1LoBPbYq
 O1QHuO9P/hwiH+lZLwDR8n2c50ugBa1X3iWlNqXHPCE6ebUtIWeXLa8Z7lz6OxHIyiFSjv1UFBC
 i9iScGBVQkQEYPkOvFHruqtiByPmMzicdjKAFKsL2w3z6B0A+HQpY=
X-Google-Smtp-Source: AGHT+IGiK7KhBOb1KkPTR1Rp+DTXsgnemuEjOCmzn3hNYx1944ssDp8hAr4VpNqT6x+0t46c/O+HAQ==
X-Received: by 2002:a17:907:3e1d:b0:b76:3d56:f666 with SMTP id
 a640c23a62f3a-b8429b129dbmr1061084166b.26.1767888969381; 
 Thu, 08 Jan 2026 08:16:09 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a5118e1sm841712266b.54.2026.01.08.08.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 08:16:08 -0800 (PST)
Message-ID: <6098b93e-698d-4bd4-9114-a554f21c0bbd@linaro.org>
Date: Thu, 8 Jan 2026 17:16:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] configs: Add google-pixel fragment config for
 Pixel 3, 3 XL, 5
Content-Language: en-US
To: david@ixit.cz, Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Petr Vorel <petr.vorel@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>,
 Matthew Croughan <matt@croughan.sh>, phone-devel@vger.kernel.org
References: <20260107-pixel-config-v3-0-02a25e3fdcfa@ixit.cz>
 <20260107-pixel-config-v3-2-02a25e3fdcfa@ixit.cz>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260107-pixel-config-v3-2-02a25e3fdcfa@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 07/01/2026 21:28, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Introduce a fragment config for the Pixel 3, Pixel 3 XL, Pixel 5.
> 
> On these devices, U-Boot is chainloaded via fastboot. However, due to
> additional requirements added by google, the image header must have
> a specific value for the text offset.
> This is solved by setting CONFIG_TEXT_OFFSET to 0x80000 in U-Boot.

But the patch itself sets TEXT_BASE?

Please update the description/patch as appropriate.

Kind regardss,>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  board/qualcomm/google-pixel.config | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/board/qualcomm/google-pixel.config b/board/qualcomm/google-pixel.config
> new file mode 100644
> index 00000000000..999d4e45268
> --- /dev/null
> +++ b/board/qualcomm/google-pixel.config
> @@ -0,0 +1,5 @@
> +# Enables chainloading of U-Boot on Google Pixel phones using
> +# newer bootloaders (Android Q/R)
> +# Use for following devices: Pixel 3 (blueline), Pixel 3 XL (crosshatch),
> +# Pixel 5 (redfin)...
> +CONFIG_TEXT_BASE=0x80080000
> 

-- 
// Casey (she/her)

