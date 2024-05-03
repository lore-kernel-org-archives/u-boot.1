Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDA2C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 16:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A7F88669;
	Fri,  3 May 2024 18:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hggb2b54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EACB88595; Fri,  3 May 2024 18:03:51 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2616E88302
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 18:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59954c1271so202949266b.3
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714752228; x=1715357028; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nb5YJ2AIEb9iSJbO7JJje8E/g7IsXO2eZkCXRqhx6aI=;
 b=hggb2b54nK7AMk04mbcg2rGZmQUYIb2Mb7n33nIHmqnF6v+nY2pjNb7WdYrZZAO1wa
 xuayJ39nfmhxAEKrsN9vyMi3QLQ8WDo2f08dZ/2NdsOxNehbh5nJsxh2kIrvPaJLF4iS
 5K1FoHLLb3ACztAbPkXuPwYuA04gl1lNqEmso8tXwzzgqtpUSlKNGM++gB4oTV8DTNHr
 opLZzw8cq+WSCcnEX66JwYFlgaMt7dIu0EuFkwIei/a77GtW7dWD+QOWKEL3iaNn52nf
 IEreTuSW4gVeZKBeh5AWJmkaZXN5IoJIvrzfJZTb9OxZeXzP5BIVpJnVG2pgbVkZ6zsX
 ANiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714752228; x=1715357028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nb5YJ2AIEb9iSJbO7JJje8E/g7IsXO2eZkCXRqhx6aI=;
 b=l89UBPIEFy//xcUtKV8yAl4+7eDDFTEVdFzBoF7MBxp0GP+bAEKQAeZYJHycj4zw0K
 R6QpFgnSPxQPdj4jKvpkXSoTncSDM8d/T84F1xrfq8ckfFR9JNS0So+wiM1QPYFN3A0l
 FHQVOpjcZz/TZHn0JE3dql5S3wtENsKsIUCuKH6RlQtq3Xt+/aQMPsrsBnBw6mZYy1zd
 F8aTmAPjbDivAf3PjbPPSVKW3Ev1jKMhv6m1QZNPu1OkoyDT1fsVPsN33AtTT8Hbjcz3
 q5HypjtDcLrD6YVhYAu4qfihs8+B9kLIuMtqK3LjYc9Le5Ot3jAOiAZ+lFq+F7/6aHOS
 2uIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM7TZko+AJH2yX7lxcXIB5dRDgpj34LXVLfNel0S/38yw3Lq6Ayp1n5DhIE4ua73zqE83QmWhf79M/gWS3PMC2sCES9A==
X-Gm-Message-State: AOJu0YwLI00OoVFY8/uMa1KNvoWz+HV9MD+6xNDqdN2OMTnI6NoUZgs9
 /7mhW/tuO3qyg470wf40zM2BLMA/GQCYuZ3Ff9/E2oR/WyJlDb//UmhzLq5MpjF1W4DZG5nQJVZ
 LyAFA1GDoB8+IBdVzZKTOtUAm3EiJQf/a
X-Google-Smtp-Source: AGHT+IGM1HPJ2rxJCr5IezWsaY/JzVJeWaoxI1j3bfukkNlI/sFFP0MtSHYV7yK2RDCrlTrh9K97cz8tDNx/+XlZ4Sc=
X-Received: by 2002:a17:906:52cc:b0:a59:9f11:2b66 with SMTP id
 w12-20020a17090652cc00b00a599f112b66mr372236ejn.36.1714752228335; Fri, 03 May
 2024 09:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240503152000.2819669-1-caleb.connolly@linaro.org>
In-Reply-To: <20240503152000.2819669-1-caleb.connolly@linaro.org>
From: =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <jmcosta944@gmail.com>
Date: Fri, 3 May 2024 16:03:36 +0000
Message-ID: <CABfBAmAK2zh-tgYSqGp8_1V5g6Xjr4xQXm58zb=AiviveBYwkQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: gen_compile_commands: fix invalid escape
 sequence warning
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Brandon Maier <brandon.maier@collins.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,
thanks for this fix!

Em sex., 3 de mai. de 2024 =C3=A0s 15:20, Caleb Connolly <
caleb.connolly@linaro.org> escreveu:

> Since Python 3.12 unrecognised escape sequences trigger a SyntaxWarning.
> Convert the '\#' string to a raw string so the backslash is correctly
> used as a literal.
>
> Ported from Linux commit dae4a0171e25 ("gen_compile_commands: fix invalid
> escape sequence warning").
>
> This updates the script to be in-line with Linux 6.9-rc6.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  scripts/gen_compile_commands.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/gen_compile_commands.py
> b/scripts/gen_compile_commands.py
> index fec513e55474..e746adddd929 100755
> --- a/scripts/gen_compile_commands.py
> +++ b/scripts/gen_compile_commands.py
> @@ -171,9 +171,9 @@ def process_line(root_directory, command_prefix,
> file_path):
>      # The .cmd files are intended to be included directly by Make, so th=
ey
>      # escape the pound sign '#', either as '\#' or '$(pound)' (depending
> on the
>      # kernel version). The compile_commands.json file is not intereprete=
d
>      # by Make, so this code replaces the escaped version with '#'.
> -    prefix =3D command_prefix.replace('\#', '#').replace('$(pound)', '#'=
)
> +    prefix =3D command_prefix.replace(r'\#', '#').replace('$(pound)', '#=
')
>
>      # Return the canonical path, eliminating any symbolic links
> encountered in the path.
>      abs_path =3D os.path.realpath(os.path.join(root_directory, file_path=
))
>      if not os.path.exists(abs_path):
> --
> 2.45.0
>
>
Reviewed-by: Jo=C3=A3o Marcos Costa <jmcosta944@gmail.com>

--=20
Atenciosamente,
Jo=C3=A3o Marcos Costa
