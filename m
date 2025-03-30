Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FFBC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 13:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA71980FDA;
	Sun, 30 Mar 2025 15:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YCXSM+qM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4098581879; Sun, 30 Mar 2025 15:35:18 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 303B080F9C
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 15:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so2871457f8f.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743341715; x=1743946515; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PYymYZKmddwvZCQYChFYCp+LCg4xonJZdLtsQQv1xMU=;
 b=YCXSM+qMxTLtnLyEarK5EazvuKRjDnbrPFJejoRJsQD+11C5+MSxRezkj9BErqrKbT
 zsZSHQRJySOB/D6WEWuoUTOcujOQSs5oyZIvunMHCXzUnUy4g4dM8G7CAtE4Sojp6l/w
 X+WTDwLzB1B0yna8D7oaSBpmr4lnAnr2thXtZB4wDEaBOTOTV6GUGz0CgaWDzb6ECH9r
 t29NWdnSBUymNibfGsS96Dwmu4kTvdTg0FypYLCpQVcUgeNUgcZxemRAkqsmf5N9ZBtU
 JgPF2yMi7eaaESS1L8l1mUY8kISujkz0FpQy0d9KuABDk/PeNLgtvHgTnukQxGvHS8qK
 5Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743341715; x=1743946515;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PYymYZKmddwvZCQYChFYCp+LCg4xonJZdLtsQQv1xMU=;
 b=EoDiMM1InLqu5rdYuN+q1Gt7kWexPzax9MVCaOo+PxW1B/YtdQ3D2Bg+t0JqdV69LH
 ajQLXKgG5INI8xfe0Pug4anUgznI82BrGHIpe5czbQjzyQkh1bd/oypvlZYL/Y9j9buE
 JJDjZTeCnZZbSP2KueeSQLox4Op4VCgeN/7MXwNyn0lkX7d8YeDqrkBnwI8shZAGrN/+
 UOZlWnrA1oShWhi0PcZh9EjsmNmWjZVbmdaF6IOi1we7LMs7oNsrFfWvm90/aLLyZcmo
 9/Qp1dY3OryPUOaSmDOTexIm14OYBNHtZWf1H95edr3tv8x/38aw2pK1ou9hEQduyQpl
 MY5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVe0o32mxsJzqE/Upv+SfXXx6yEws+Rb+GIESwcb/ng7J1uMFj8fAZN04on4XS+GoKXQMKWaY=@lists.denx.de
X-Gm-Message-State: AOJu0YzeLpg3pJijAl7xzx9HdeAkKlYkcj2obFqu4tbuU2Z9rMpkAbfz
 qVak09P3SxH5DQpRpEpnWPr7NIhJ4Dna1k/8g6oZOC/Mb5LMUAeul95j3VG7vZ4=
X-Gm-Gg: ASbGncsoURHW7eksSVYiccCp34JKHlXUaJRRZlNny+cfVPQAXLcKz5DqFTgEAaTD9FE
 dcRdeAckxzEL/ce05KlJ6nEYVurBQNVrC5WFUpeeGn+lJl+06+He+cC2gtpBNllGwZvmeRJsP3Q
 UIcUjkH/i95J22rjyyGJfqtZtvekit5QvXWNvimX4mRvXQI9GZZR6IGUeYo77EO4JSMKBFvI3Dz
 fXEvmkQcDKUCwNZif0Cd+/cDcjvgFyN6u4pEM87LTVC9nqMaT1NWNSaQNE2mlSpBHH0vVwxIFWx
 d6vF66cFHHc/nWyZNxJGvv2WRIOOkNG5sA5LoxMVdy7Y/990EcsneKlnB+ozj9zUi4ADtJ5Zb6N
 /ZH7xJfSQhhlHhIMKGJWY9YKwM5Lc
X-Google-Smtp-Source: AGHT+IEe2S/B+9cP87v9zT5v+5XrK0tmKv4KF1BO/1eYUw4uDJIYBY4bcdqVTshJBbKNfuw7FjweMw==
X-Received: by 2002:a5d:6d8d:0:b0:391:4835:d888 with SMTP id
 ffacd0b85a97d-39c12118e1fmr3890678f8f.42.1743341715658; 
 Sun, 30 Mar 2025 06:35:15 -0700 (PDT)
Received: from ?IPv6:2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f?
 ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663617sm8665059f8f.34.2025.03.30.06.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 06:35:15 -0700 (PDT)
Message-ID: <57643701688c322895ff829c28fdca3595704f70.camel@linaro.org>
Subject: Re: [PATCH v4 2/5] rpi: Set bootm_size to 512MB
From: Christopher Obbard <christopher.obbard@linaro.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren
 <swarren@nvidia.com>,  Matthias Brugger	 <mbrugger@suse.com>, Tom Rini
 <trini@konsulko.com>, Peter Robinson	 <pbrobinson@gmail.com>
Date: Sun, 30 Mar 2025 14:35:01 +0100
In-Reply-To: <20241220003447.2913443-3-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-3-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
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

Hi Simon,

On Thu, 2024-12-19 at 17:34 -0700, Simon Glass wrote:
> Set this option so that all boot images stay within the bottom 512MB
> of
> memory. This should allow us to drop the fdt_high and initrd_high
> options.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org> # CM4 1G

> ---
>=20
> (no changes since v3)
>=20
> Changes in v3:
> - Add to the existing comment block
>=20
> Changes in v2:
> - Add new patch to set bootm_size
>=20
> =C2=A0board/raspberrypi/rpi/rpi.env | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/board/raspberrypi/rpi/rpi.env
> b/board/raspberrypi/rpi/rpi.env
> index 30228285edd..a327fccc77f 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -60,7 +60,12 @@ dfu_alt_info+=3DzImage fat 0 1
> =C2=A0 * Even with the smallest possible CPU-GPU memory split of the CPU
> getting
> =C2=A0 * only 64M, the remaining 25M starting at 0x02700000 should allow
> quite
> =C2=A0 * large initrds before they start colliding with U-Boot.
> + *
> + * Limit bootm_size to 512MB so that all boot images stay within the
> bottom
> + * 512MB of memory
> =C2=A0 */
> +bootm_size=3D0x20000000
> +
> =C2=A0#ifdef CONFIG_ARM64
> =C2=A0fdt_high=3Dffffffffffffffff
> =C2=A0initrd_high=3Dffffffffffffffff
