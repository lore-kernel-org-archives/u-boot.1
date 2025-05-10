Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7DCC3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AA9A826AA;
	Sat, 10 May 2025 13:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CHwxeP91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25DF3826AA; Sat, 10 May 2025 13:25:25 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8B58210D
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5fbdf6973e7so3659248a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876322; x=1747481122; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHjlC8ngZQm3ntiaO8R5Gk3p9EsnNuayrHbzPn1ze3s=;
 b=CHwxeP91BrsJJZmsA07MKlrQt3mU+mxgf2QeLKBQ32XCGmMQ54xEsqb5Ejn0nQ9ct4
 mOP9KRdNj+HfYatTgLZ49VgUZ6e2E7AOVIAsaXCalrowmEmpPkU+wa2TJIc2EdozkHQi
 RnLRYMkNx4tyiNWcIcLJYUMDGCQMK1iHSUrQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876322; x=1747481122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHjlC8ngZQm3ntiaO8R5Gk3p9EsnNuayrHbzPn1ze3s=;
 b=oNewTchBxFPUDTa54qPg5/cjafRMxZgYRIjArg52FCRY1vJwY6X6u4K/GhKMQ9Hw0r
 0XtzH0z353yGaAyNd/+jjXD8gH7bbXy3LNdrDmTrxgPTgK30K/nzGGcVH/Edti7Tr+w9
 +ZU/PhD8UOCKY1PhwwtYObBscS/f8YVlBLp73arRV/l2Y8F8J08vskw/ACzVZkyVmOB0
 OJfQmIXgs7CUwLAzUSdgJKvg0DUcx257dxcgLsaB8Ts4kQrGT4v9VrtHm7XxVEZO24iO
 1vGDjnOeiJCJbsCh8UzugX8TZCgdW6XEKRuQkOK6ptwQFHOlEAZxi6bns4Hcd0wdD0Uc
 GQ3w==
X-Gm-Message-State: AOJu0Yw8WwsQNA09n8WNVEAYX7MtG9v1F71RQBM7fEXmidvGdYt6brPm
 4yyXYu7IJ3TTYykOwUcrYXMGexEmKKpX6vRYQdjhKjyYGAgxI4cg5kMLIMcvIygLx2wNiJ5jN8i
 WyKN7yjhut8SWiX1VvN3SbYa9j8JC0vYcH3BZ53TGTPamkyXjx91cNcVxBw==
X-Gm-Gg: ASbGncvQ97JFI/JEPGzxlca4InZuwTNYQYM6erAoOaRMCzXsQOTscyYKfb4GG5ZUvwo
 y/zNNSjCVdn09ME+fcH4NjETynFP5hVOVJOy/LaP3roTJhn4z6gk/9HPKVqqUDavN7bkFBmsdxo
 dcF7Zqx9yLAXhpNzWM2vpGvIZ1UTNBYBdeLA==
X-Google-Smtp-Source: AGHT+IEZGE/pubpJt/8os1ol3y4D5khOd41jFv79sdAaVV59yrs0hGhYv6GggUIoiGwRXiwBgXyF5gwrTFfJjyxVfUA=
X-Received: by 2002:a05:6402:2111:b0:5f6:c5e3:fa98 with SMTP id
 4fb4d7f45d1cf-5fca07ee2a1mr5891479a12.27.1746876322423; Sat, 10 May 2025
 04:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
In-Reply-To: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:25:10 +0200
X-Gm-Features: AX0GCFtGFTnzoMQNGmt2XUoG59Ueee2kk-KT8sJ1dkF7c37KM_j0dXOlZZAUsYg
Message-ID: <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
To: David Garske <david@wolfssl.com>
Cc: u-boot@lists.denx.de, Todd Ouska <todd@wolfssl.com>, 
 Larry Stefonic <larry@wolfssl.com>, Wolfram Kusterer <wolfram@wolfssl.com>, 
 Aidan Garske <aidan@wolfssl.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi David,

On Thu, 8 May 2025 at 00:41, David Garske <david@wolfssl.com> wrote:
>
> Hi Denx,
>
> We at wolfSSL have developed a port for wolfTPM in U-Boot. The patch allo=
ws using the current built-in TPM 2.0 support or switching to wolfTPM via C=
ONFIG_TPM_WOLF=3Dy. It also supports TPM 2.0 firmware update for the Infine=
on SLB9672 and SLB9673.
>
> I think there is probably some more cleanup and testing needed, but I wan=
ted to submit this to start the discussion and see your thoughts.
>
> The wolfTPM library is GPLv2 and added as a submodule. If the license or =
submodule is an issue let=E2=80=99s discuss! I=E2=80=99m positive we can re=
solve anything.
>
> Attached is the patch based on latest master 3b6760ddeb4 to review.

Thank you for doing this!

Here are a few thoughts:

- Use lower case for function names
- Avoid camel case
- What is XMEMSET()? - Can you use memset() ?
- Convert most prinf() functions to log_debug()
- Can you use subcommands (from command.h) instead of parsing the
subcommand yourself?
- put the FIRMWARE_UPGRADE thing into Kconfig, as well as WOLFTPM_SLB9672/3
- put the driver code into drivers/ with just the command code in cmd/
- add config WOLFTPM, separate from CMD_WOLFTPM
- can you add a test in test/ and docs in doc/usage/cmd/  ?

Regards,
Simon


>
> =EF=BF=BC
>
> Thanks,
> David Garske
> Software Engineer, wolfSSL
> +1 (530) 409-2990
> https://www.wolfssl.com <https://www.wolfssl.com/>
> https://github.com/wolfssl
>
