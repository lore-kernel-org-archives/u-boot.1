Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E65D26D9B
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 21:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552E5843E3;
	Fri,  9 Jan 2026 22:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hVYXjcWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFBC843D4; Fri,  9 Jan 2026 22:05:10 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 560C7843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 22:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=petr.vorel@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so38560385e9.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 13:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767992705; x=1768597505; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZY7PcYrtAxG4VqNQOc4JV3SfdlaH/jPuUtHmha5rUHg=;
 b=hVYXjcWVnXVCwkY0DSX7XW0BpqQg1RCqV9FsgfgvGiUEN2L7pGpnefCQXPoqO4a6jB
 AgMgKrf3aNx+RYCPq5x7XOx9xmchBvHFKSDw81X81OkaOa+t/inK/pAkYTlY0TDCj62L
 2NYVWIffurXL+6yT00Xlm+4lJmlyxiTgBqlAFuZV7pcEjavFNhPvKc8S09aJ9LepXJ73
 2MiZechNXV/XEYu/c6Ja2RzMZfVeQolhRof0JmUKGDdzpNJENPgtQAM2xTuEOCmO590B
 6VwFN6JI215PaHzCTN577rOBQ9dcsJzsxkfzBfdLzb/HKLlEhE0tZ+mM2SKNhvPpbFI7
 KM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767992705; x=1768597505;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZY7PcYrtAxG4VqNQOc4JV3SfdlaH/jPuUtHmha5rUHg=;
 b=L5me9C3KoOd48qseUmaarT3wG1dZkIaBNBnuHfgPOPB/tlE0V4ZC/oy22RGvouGs8u
 Q5Xi9vq2cELgO3sxGmhncYXO4nB6qjMr9dhSoxRZ4Iobfy3IEU86WfDkWWCm8kOTGzlR
 zdDtCXFG9xuYVfIJlIKiUztZUdb/evRnTyipdoOi0Tx1EX9wjUc7WLzjrPvsUgnafUCp
 pxqqIXz5huDyV7lH7DhKvGmbmGi5U5OWAifFeiO5hwxYZEWUriP73/v13SxQNzqY+NH4
 A8Nlav7oZrISYUxqDTzzHdlg0lBbSmsyGNSq5f40U0tZQEWRMu1Z5zP9zHconnVrrl64
 gI5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvElkm8hM0WJdNfnsf7bYcizpRdtcpGwtlG/EVOfq/9iN9vhdF/bRwgdUF4HunnQHKukjdXEw=@lists.denx.de
X-Gm-Message-State: AOJu0YzJvZGvFhnowHP2cLUV18gwWW02ARYyOXniQ9AsYuB5OKgcmr/R
 0ieMNDXXF7O35zQ2K6s9m4+FeyEfKJmPvZ3SmsfETB8FiEfACnUcJTHA
X-Gm-Gg: AY/fxX5vJ3vRZy+QFFxhGEbR0opCbg+58gnyypSf6kupmTdwas44GyPu2/NTQ13oA0P
 PMI+07hputmzzUcPdXkRZstRFUdxqDwF1N+qQBqyalkBdIVwFLAbzjQFgxrkkpyK0IglQnvM9zD
 V3gX2H9zkOKglnq0RbxgSZGdWKHkmU/4BH1RTkaUD248yhA/yo67/mlV7ISr46O7ptKztxv5hYd
 eG/+cIPBzHr2BzUE6KUTnRaUAc+PIXGHHY4b1gNVxX0aIXmBPmg/p1mxe+LxKa6dugXV8HYKOFz
 5qBBglfe75U+cMyuDqwT1/JsknuL1tyusrNAcB+LMnD2OztDEaFRB3tpfzMXilcJAHDdiOAR/oT
 IC8mzu0vOZPw0hJtHwXpxxXBSPKz8A7gYBFIZGpGtaZSRHgTZQx7GargOe8zF1/o5yAtsD6u4qS
 GS86zRkYMqlA73FkoKEg4GJp4Et3GLrsGb1XF6j8THR5mhPCxW
X-Google-Smtp-Source: AGHT+IHdI7W0Gnaxz5WrYkHIDSlle5KiqkYcIeY+eBK7zSr0o5F53BUSFNiHrXhvpqri2QnP4xitfA==
X-Received: by 2002:a05:600c:474f:b0:475:e067:f23d with SMTP id
 5b1f17b1804b1-47d84b41294mr119773275e9.25.1767992704938; 
 Fri, 09 Jan 2026 13:05:04 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6ef885sm221687775e9.9.2026.01.09.13.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 13:05:04 -0800 (PST)
Date: Fri, 9 Jan 2026 22:05:01 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: david@ixit.cz
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Luca Weiss <luca.weiss@fairphone.com>, Simon Glass <sjg@chromium.org>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Matthew Croughan <matt@croughan.sh>, phone-devel@vger.kernel.org,
 Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH v4 2/2] configs: Add google-pixel fragment config for
 Pixel 3, 3 XL, 5
Message-ID: <20260109210501.GB140231@pevik>
References: <20260108-pixel-config-v4-0-76a2212b69a5@ixit.cz>
 <20260108-pixel-config-v4-2-76a2212b69a5@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-pixel-config-v4-2-76a2212b69a5@ixit.cz>
X-Mailman-Approved-At: Fri, 09 Jan 2026 22:54:16 +0100
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi all,


> Introduce a fragment config for the Pixel 3, Pixel 3 XL, Pixel 5.

> On these devices, U-Boot is chainloaded via fastboot. However, due to
> additional requirements added by Google, the image header must have
> a specific value for the text offset.
> This is solved by setting CONFIG_TEXT_BASE to 0x80080000 in U-Boot.

Yeah, to workaround for kernel change 120dc60d0bdb ("arm64: get rid of
TEXT_OFFSET") because trying to put it back [1] was rejected.

Thanks!
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr

[1] https://lore.kernel.org/all/20251006-arm64-text-offset-v1-1-bf0e8a27383b@oss.qualcomm.com/

> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  board/qualcomm/google-pixel.config | 5 +++++
>  1 file changed, 5 insertions(+)

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
