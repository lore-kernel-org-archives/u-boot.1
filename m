Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D911CC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EFF80A23;
	Thu,  6 Feb 2025 13:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DhMNpOq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A88C080A2A; Thu,  6 Feb 2025 13:38:55 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8835A807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab39f84cbf1so163177766b.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845533; x=1739450333; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vMq8uEeFTwTijlsXk+QR3HNWR4p5cgAVYeDUN0U18iA=;
 b=DhMNpOq/g3lHL1v4fVXrIgj5Rtd1EN7i1a0UCUHPg+YzF3boyesOs/fxFQ0m2n3Sbf
 yAPRvtC1OOiw4tAdyPUHxLnpKQRXJXjw+u56BglHJWGED2UctWZPlR7CGYuoBegyF4Hq
 Zv/RX139yFO1KgHDCdJhQXUB05E3JUDSuV3CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845533; x=1739450333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vMq8uEeFTwTijlsXk+QR3HNWR4p5cgAVYeDUN0U18iA=;
 b=JYWBu588nHYp+9T1DMspUEoTmCp1qgceP0BBuAenOD7JxbZqv/PZ68WM3t4ebCiQAu
 QVVWalK9xbRNgk6AsyMHdDg6zQpvf692MW6NjLv590/IpBBJFbGSwyFVg7swX9yTQtdE
 MdPvg6n+NrItw8734LXJe/WZ78xne6RYArd7sfLi/UbhaHX3waZCe4t/6mCnY0o3f8ea
 OOy3luFbqVuZPMJopHs6hFUIF1otYuooTEgZMoo9QUstZlzbbfz03+H3XlKA3VLvIUNc
 KxIqfa/7Hz1bt/j+Hw8bU8EJb1ZJ/J6d9Lc70yrCs7YMw0mvcVR660p/IHNJj1kshvxN
 Ig/w==
X-Gm-Message-State: AOJu0Yy+frbWCW8pMDqwoYUsL9MLq/Knoh4/MXsGgSqJ8EfioVcp1UKB
 ozixeE2UL+RiOnZ7HWuwiye8FKBAClGntaFbOPUMC2hDNdW9cRMIALdTD1hjWwYaxJkBjHWP2be
 MKjbxYmithD1FO/lH1c090M6PYhdAOfARFWm4
X-Gm-Gg: ASbGncsgk2DCZw+dHy4/HJYncafB9e/b5gayS/p2L3t3lQnRPv9aAXPxnJMna333KnK
 vn+KGCzIdbJEQVzlE4Fm/Q93zsnla8ioudrqeUso2jqaHwzHHm3If1zEe/96GtwYOt3s/mXn5Eg
 ==
X-Google-Smtp-Source: AGHT+IH+eNl0T05p5szJQXP0GbOG5f4xO4W+8q+S5YQvRr8tkTDYa5IjSccPG1OaX3OWKLdcMpjoa7RW34S3ta4sMlY=
X-Received: by 2002:a17:907:7d90:b0:aaf:74d6:6467 with SMTP id
 a640c23a62f3a-ab75e347a2dmr732308466b.42.1738845532985; Thu, 06 Feb 2025
 04:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20250205143641.65430-1-marex@denx.de>
In-Reply-To: <20250205143641.65430-1-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:38:41 -0700
X-Gm-Features: AWEUYZmScBfEOiXIiOU2c-8VZf6x48MO77R2ZugTZydYXzbb6ZViTigkdfZJkuw
Message-ID: <CAFLszTjshfJMxZoj=aZdCmDzTNRz1rRdphHb4UT9uBwKf5vS9g@mail.gmail.com>
Subject: Re: [PATCH] tools: mkenvimage: Add pure shell implementation of
 mkenvimage
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Wed, 5 Feb 2025 at 07:37, Marek Vasut <marex@denx.de> wrote:
>
> Add implementation of mkenvimage written purely in bourne shell.
>
> This is not a replacement for mkenvimage tool, but rather a simple
> implementation which can be used in environments where mkenvimage
> itself cannot be deployed due to various constraints, like hardware
> manufacturing plants, but where bourne shell and basic tool are
> already available.
>
> The external dependencies which are not shell built-ins are gzip
> and grep.
>
> All mkenvimage parameters are implemented and compatible with the
> C implementation of mkenvimage.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  tools/mkenvimage.sh | 126 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100755 tools/mkenvimage.sh

Would it be worth adding a simple test for this?

Regards,
SImon

> +               REDUNDANT=1
> +               ;;
> +       b)
> +               # Swap CRC endianness
> +               BIGENDIAN=1
> +               ;;
> +       p)
> +               BYTEFILL="$(printf "%b" "\0$(printf "%o" $((OPTARG)))")"
> +               ;;
> +       s)
> +               SIZE="$((OPTARG))"
> +               ;;
> +       o)
> +               OUTFILE="${OPTARG}"
> +               ;;
> +       V)
> +               echo "mkenvimage version SHELL"
> +               exit 0
> +               ;;
> +       h|*)
> +               print_help
> +               exit 0
> +               ;;
> +       esac
> +done
> +
> +shift $((OPTIND - 1))
> +if test -n "${1}" ; then
> +       INFILE=${1}
> +fi
> +
> +if test -z "${INFILE}" ; then
> +       echo "Input file not specified"
> +       print_help
> +       exit 1
> +fi
> +
> +if test -z "${OUTFILE}" ; then
> +       echo "Output file not specified"
> +       print_help
> +       exit 1
> +fi
> +
> +if test "${SIZE}" -eq 0 ; then
> +       echo "Size not specified"
> +       print_help
> +       exit 1
> +fi
> +
> +crctmpfile=$(mktemp)
> +outtmpfile=$(mktemp)
> +
> +(
> +# Read input environment file, make sure there is a trailing newline,
> +# sort the result and remove empty and commented out lines.
> +( cat "${INFILE}" ; echo ) | sort -u "${INFILE}" | grep -v '^#' | grep -v '^[ \t]*$' | tr '\n' '\0'
> +# Insert one more trailing zero at the end of environment.
> +printf '\0'
> +# Fill the rest of the environment with BYTEFILL bytes.
> +tr '\0' "${BYTEFILL}" < /dev/zero
> +# Clip the environment block to correct size. Header is 4 bytes CRC32
> +# for regular environment and 5 bytes CRC32 and flags for redundant
> +# environment.
> +) | dd count="$((SIZE - 4 - REDUNDANT))" bs=1 of="${outtmpfile}" 2>/dev/null
> +
> +gzip -ck1 "${outtmpfile}" | tail -c8 | head -c4 > "${crctmpfile}"
> +
> +# Reverse crc32 for big-endian systems
> +if test "$BIGENDIAN" -eq 1 ; then
> +       # Note that 'rev' is from util-linux and may not be available,
> +       # 'xxd' is from vim and may not be available, and 'tac -rs .'
> +       # does not handle unterminated strings and newlines well, so
> +       # use plain 'dd' to reverse the 4 bytes reliably and using
> +       # minimum dependencies:
> +       crcbetmpfile=$(mktemp)
> +       (
> +               dd if="${crctmpfile}" bs=1 count=1 skip=3 ;
> +               dd if="${crctmpfile}" bs=1 count=1 skip=2 ;
> +               dd if="${crctmpfile}" bs=1 count=1 skip=1 ;
> +               dd if="${crctmpfile}" bs=1 count=1 skip=0
> +       ) >> "${crcbetmpfile}" 2>/dev/null
> +       mv "${crcbetmpfile}" "${crctmpfile}"
> +fi
> +
> +# Add 5th byte set to 0x01 to indicate redundant environment image.
> +if test "$REDUNDANT" -eq 1 ; then
> +       printf '\001' >> "${crctmpfile}"
> +fi
> +
> +# Concatenate the CRC32 and environment block into the final output file.
> +cat "${crctmpfile}" "${outtmpfile}" > "${OUTFILE}"
> +
> +# Clean up the temporary files
> +rm -f "${crctmpfile}" "${outtmpfile}"
> --
> 2.47.2
>
