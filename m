Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75D2C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 21:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7500181026;
	Tue, 25 Feb 2025 22:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="inRXz67u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D5D80FF4; Tue, 25 Feb 2025 22:27:27 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B550801CF
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 22:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so1222121466b.1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740518844; x=1741123644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XAKBY0M9XD0k0XDCTWQdYjBiEpu2yNv6KNwgncRSYLo=;
 b=inRXz67uXQgahZgzfpJuGpgKlaL7W5E3JqQX0FmtKukfzpCT2Td5p8lXcftmYMCqyt
 BHOORlIkhY2W6uIgqXYzBNAX3DoCMp7/ofTexdAnh2ICDhIkOPBx2SwjK4Jcu0SANEXE
 3uZj3YdEDE//4srwBEzI9DLD4F8PvRd7Eb1TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740518844; x=1741123644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XAKBY0M9XD0k0XDCTWQdYjBiEpu2yNv6KNwgncRSYLo=;
 b=wL2hVLFqHg9FCz7I3hhSOcfWbivMpyw4myVW4+QLz3HQa1fLBBbUdzCAONjftUWPiN
 O3y8PTPr3gwpaHbj9afn8BNdqFIvJULhevLZzgSv5k9xRpXUTUgcl3EqTcqrrrVIzhy2
 l7sZ+V3Gt9+WX5rMTSv7U1/cug1A+qT96y2LTe6gZW2Aa/c1cyLpsUcKpBpQtNysoAx1
 4QuVsfKh24LeA1yXI3vM+HxvXD3Il0mz+Ihn+kJnUQZ/fTbYmJHmMdGmg08mwuk+mhuJ
 6XZX4zS2xyHws8yFiRdYAoaePHQioSPJnQNYO9+5I+qGyWbrwqyl3ygP4V/4dMbZvOyp
 5Epw==
X-Gm-Message-State: AOJu0YzD+Zz9Q1L0QFkIIWY/Zoam7XR0OUJXVw5q9y4a7yfmfvRdiw1S
 hn+OnNSY9eQMPpm4uP9pfrX3mJ+LwnJgnjvscFLn9WbFjmm18WN1S3MyfDTF4sTIgd8plTVkJ/P
 oaKYNK3+cJjhGCqg3/Iz8dEhZMxGEWvFTpyWw
X-Gm-Gg: ASbGncu3lAQNV+f7axn691iRObjCAqn2aoGR/JJaHmhHVbFyoPFPmdXrWKpavpS7fNd
 RKmZpQwICdsFsFY0uIk92Ei9lbRTEa+4QsCFxXZ2Um62Dgdx8yBxLWia4PYn9Ugx443AVGcf7yp
 XAbLdD/kxY
X-Google-Smtp-Source: AGHT+IFwH8Wq2XvlZ1FwKy/4mklOnTfoIIABktIXBF8n9lfkjt0iRPt5eWrMB7ryR7IEQ7MXE46ecF1tkqw2paB9plI=
X-Received: by 2002:a17:907:7b9e:b0:abb:d820:1073 with SMTP id
 a640c23a62f3a-abed0d60bf9mr542105066b.24.1740518844559; Tue, 25 Feb 2025
 13:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20250225121143.14862-1-l.anderweit@phytec.de>
 <20250225121143.14862-3-l.anderweit@phytec.de>
In-Reply-To: <20250225121143.14862-3-l.anderweit@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Feb 2025 14:27:12 -0700
X-Gm-Features: AQ5f1JpmM5WYfKSgpuLjLwUxzJoXhCpQIr8lGUhLgxQaNFpSCDPAcihS2kyDtP4
Message-ID: <CAFLszTiRWT24gtSe_Hq3pcWpoXm+Exymz2=zUEfD+q_1JuWJog@mail.gmail.com>
Subject: Re: [PATCH 3/3] binman: cst: Build from source
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, upstream@lists.phytec.de
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

Hi Leonard,

On Tue, 25 Feb 2025 at 05:11, Leonard Anderweit <l.anderweit@phytec.de> wrote:
>
> Build the imx code singing tool from source instead of relying on the
> distro to provide the tool.
> Use the debian/unstable branch because the default branch is outdated.
> The binary is supposed to be build with docker, work around that by selecting
> the correct Makefile directly.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
> ---
>  tools/binman/btool/cst.py | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>

Thank you for doing this!

If you have any more info about the tool, please add it to the comment
at the top of Bintoolcst and regenerate the .rst with 'binman
bintool-docs'

> diff --git a/tools/binman/btool/cst.py b/tools/binman/btool/cst.py
> index 30e78bdbbd9d..0a23d12d3e2f 100644
> --- a/tools/binman/btool/cst.py
> +++ b/tools/binman/btool/cst.py
> @@ -29,20 +29,17 @@ class Bintoolcst(bintool.Bintool):
>          return self.run_cmd(*args)
>
>      def fetch(self, method):
> -        """Fetch handler for cst
> -
> -        This installs cst using the apt utility.
> -
> -        Args:
> -            method (FETCH_...): Method to use
> -
> -        Returns:
> -            True if the file was fetched and now installed, None if a method
> -            other than FETCH_BIN was requested
> -
> -        Raises:
> -            Valuerror: Fetching could not be completed
> -        """
> -        if method != bintool.FETCH_BIN:
> +        """Build cst from git"""
> +        if method != bintool.FETCH_BUILD:
>              return None
> -        return self.apt_install('imx-code-signing-tool')
> +
> +        from platform import architecture
> +        arch = 'linux64' if architecture()[0] == '64bit' else 'linux32'
> +        result = self.build_from_git(
> +            'https://gitlab.apertis.org/pkg/imx-code-signing-tool',
> +            ['all'],
> +            f'code/obj.{arch}/cst',
> +            flags=[f'OSTYPE={arch}', 'ENCRYPTION=yes'],
> +            git_branch='debian/unstable',
> +            make_path=f'code/obj.{arch}/')
> +        return result
> --
> 2.34.1
>

Regards,
SImon
