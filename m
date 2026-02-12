Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8D7EB491F
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 12:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AB4983B9D;
	Thu, 12 Feb 2026 13:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Umt03Mtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F63783015; Thu, 12 Feb 2026 13:59:04 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C0D83B9D
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 13:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7964fb9ae3dso45465087b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 04:58:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770901136; cv=none;
 d=google.com; s=arc-20240605;
 b=ZE+z7gWcLYIhop2h/ltizByRpagLOvn85JulvnP4q6A0mhm/x4ljIx8CVrLRUbsFV8
 Seum9sPACxtxo56AnnBKdLUwUkRhcsM99hURaCloDpP9roWV7EnDB7etMhFpfUEoEWtV
 qB2VaSHMZGz1TO54M6zEsHTT5LtBugHHT9iDHnGACHm4aYu8zpZLdA8+5NzghVbdF0nP
 Sz8IQ0jk+CkJJTTxzN6W6CZ+0+PS7Gq2Zh3caWkDqRYMEKKCO5hVPskvGJniB7gS/bu0
 XpgvWpgpCMbCwO836CtkS7nFcvi21sSNxVAUR7y+x6oaQXCJy/6Lk0BTC3eRfHXaWbul
 tx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5ZiDb3zkmVRFckqj/MnBytQMYArgyrPAq8a8cEXUxyY=;
 fh=dCMpJlVmgQ+iMYIy7tggu7aBjn2NxhaxzB4XkDin7Zw=;
 b=Fqs0CdlqkP5jCSdqe6DwxljcCc5JfUtqee5P4ZSGL8LRrwV8VE4yEa6RNZDRb3Du4j
 YPgLatg8uqiuvFQQelK4B0DIsQAlk1F0CMTDnrQeezsPIaHlauzyBeJv+OSl4ZtkSYQb
 GlR3D7hGAaJycQS/Oh33hAy73jgztNvooFZdmEZfI0fznUUq3iRUw9cvh6HVJVvB3wYL
 nArr6VTh6uQpVvgThotIiAceK55ffDEEOUWXC5vzmYd4X4rMFiZvXSD5RQxE9rCJPmzJ
 aB2sFcyGg54YiJmSYt6KVnOgRilw2Mm5T+2+A33WeaXOjJLSADNSqnTeV6v50G9r+0HX
 MFhA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770901136; x=1771505936; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZiDb3zkmVRFckqj/MnBytQMYArgyrPAq8a8cEXUxyY=;
 b=Umt03Mtcq7m5Fmjo0gkA9BevnsrvtXpZ+ydtDBng+Rq4XR/4f3stmSMGJbkM4xVZUs
 U08hFd/9uMKZzPRHQoAsX4FZ17OJLxg9TMKbVvSYSni3O/4lVB1v+tEh9MhWcppspB7V
 N70JhGx6f6Dof717ecBNDgeS1eMhr1BS0hAuPiL8X0QT1P1jkXd1Q7yUk5MM68aqkood
 KEB9LUoBNIo/J5lR8mNzLcNeRZVWT4umGWIp+H/0GNsbd7xHQBPR5a8ZQogtKaU6nd4f
 SNTb5GSmt3UbegJp+D+gKfZKxtfbBBKHu3GHqBl5I5ZF9wLwkfV6ZuRMe6rxusH0MRcg
 mXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770901136; x=1771505936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ZiDb3zkmVRFckqj/MnBytQMYArgyrPAq8a8cEXUxyY=;
 b=PXVE8Mv7lCVjrcpG6BeNojVFQ77OkOc+1NIKgzll4WAvVgG/D3jehg2IbqaZjK6aTM
 nf2UhzfLrwrK1zpjgaFc47BXkZ7SRzDJPf+IUshJP1upm4gtYd0luCr5mlptvJCDNGLB
 pp3NV/UH748rGBLoljDZwHhU8M5NZqDVKdOxdBDRvwqhMwQ6lzxIrQCSh73zOxi4W08v
 LMwQ/+TCF7142l5mxHziCUYbmCdDhf9UF5kCKn81wqIK57YfkiqdDmOL0d2ErIrXucUd
 oPiMP7Q+j1plsYo1i4r6gUl6ihTHK7xE9Vs5kZ3iU8dlvts/fYNLXkHsES/vpJDL/e7Q
 OIZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu81fP7/zOLAwm6V9XwSKpyWqDzdJb3TGwZ+OfmwQFjv7swjlybon14r+fn2Bjw8O2ll61fs0=@lists.denx.de
X-Gm-Message-State: AOJu0YwpvyLSEWBKceYlfJCaG2HeISG03wp1M+nLk75vYpvAoRu+jKC0
 e/s/6oFfLuA1d8jkPXkggGIIG0BLqZ0Uio7sjAdMOmuJw5Xf8DjQXGe/Ug9a3jl5PshRYPD60rU
 J0CZ1ul688QFbkoVBRHyIjVofe2rq65AceQ+K0nxb2A==
X-Gm-Gg: AZuq6aJaWZi6DqEQpj+XO/Kze0eF8R9LRMrOjSJYujaOY7aJ8Ar8XG7WYbvUOjnycmf
 gRd4NdrgXz3t/CL8BwB7Ni+nJV54Rgc8Gm3624cXAOwczchMT6b9n8UcPok2ysDP1S0p5sFBXCT
 t6qeEGS7i0NgrH9SlxG1IjcfmDr+Rt0DJneOgDWK2v4vR1lIooZdloKBGAYSoIj8rnqAE5/ZCLu
 Kv9VobQ0nMRUGexz6yI87jjDtI5W8qT1nc3vuUT78SKnAkRGy+1oQXKFpOQOs9SO5AB6CJhFDpi
 eqkzAJnMknj8qPTkJWSA0WEvGAqj08A0UJSIZUXJOfFanxkoFEnI2U9UdGp8FjjpJcKJiJSgweq
 y0bLBAbpzQIIVi7eYoEEk2jv8L+ulw6aGaZxNTveT3y6iVAWqyjZtP7j1iO5xxcSnWeJV3n/H/x
 Gvf+548/pHqyVKLOi+eGyOa8IxXVbG6qviwbH2aXBE/0y+qrqNWSi69sFHQrOoAOj452rpY4+sS
 2zRrulzDhCpApw9fDXTItZw+D1eUUqoZNhxVAviSKXZAFdp2u8ljDv4naCSff9j3FBV20J3NnxL
 JJJGTYZeb6a6KnLMXRR8qdVsUAPCn+kjeSLaKAJJ0fXo
X-Received: by 2002:a05:690c:e3e8:b0:796:3ac6:7c6c with SMTP id
 00721157ae682-797377c2430mr27442257b3.50.1770901135564; Thu, 12 Feb 2026
 04:58:55 -0800 (PST)
MIME-Version: 1.0
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
 <CANqXHyEShK3bCA-5K4K=zH_b19i9+o9DRPYW8LHo-gFpMB2Hkg@mail.gmail.com>
 <CANqXHyH3OwPEpo=rv6E+uSP01quOQisEJ3_aD2-r=DkNDK4_+g@mail.gmail.com>
 <CAC_iWjLKotX4X9mD1qnJbnkbh9xBHfnyF+b=b--XvMjjbCrU-g@mail.gmail.com>
 <CANqXHyGZSGybzchkqSE0-7s3HgfY=UBjpkjS1wjuRkZzOLDMWQ@mail.gmail.com>
 <430A021B-7511-4C08-B30C-72C153A25A27@wolfssl.com>
 <CALeDE9M7ENPccTD18b3YKrvYEu8yU0cXT1ePXM_tagV4Ou+Z0w@mail.gmail.com>
 <CAC_iWjKnbp_gtHQ6nMZEHEOx92NA2U1OLFKkgDtyqS_aDHO6GQ@mail.gmail.com>
 <48C4A401-E824-46BF-BC93-1EA9A45AC374@wolfssl.com>
In-Reply-To: <48C4A401-E824-46BF-BC93-1EA9A45AC374@wolfssl.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Feb 2026 14:58:19 +0200
X-Gm-Features: AZwV_QgCVxFGmseKoo3lphlGe_XxGF1HPDUD4_LgCQ9VB_rE1ld79Vj19DkcOkI
Message-ID: <CAC_iWjJD+_spstOX5z2tDoyEUZwbV7QXNz_s5ffz7FWK9QopEg@mail.gmail.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
To: David Garske <david@wolfssl.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Todd Ouska <todd@wolfssl.com>, Larry Stefonic <larry@wolfssl.com>, 
 Wolfram Kusterer <wolfram@wolfssl.com>, Aidan Garske <aidan@wolfssl.com>
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

On Thu, 12 Feb 2026 at 04:11, David Garske <david@wolfssl.com> wrote:
>
> Hi Ilias,
>
> Thanks for your reply. I did submit the patch via git send-email on Jan 2=
8 to u-boot@lists.denx.de with subject "[PATCH] tpm: Add wolfTPM library su=
pport for TPM 2.0=E2=80=9D. Can you check if you received it? Copy of the e=
mail is attached.

I haven't and i can't find it on
https://lore.kernel.org/u-boot/?q=3DAdd+wolfTPM+ either. Any chance git
failed to send it?

Thanks
/Ilias
>
>
> David Garske
> Software Engineer, wolfSSL
> +1 (530) 409-2990
> https://www.wolfssl.com
> https://github.com/wolfssl
>
> On Feb 11, 2026, at 2:24=E2=80=AFAM, Ilias Apalodimas <ilias.apalodimas@l=
inaro.org> wrote:
>
> Hi,
>
> Thanks for the followup. As Peter suggested, please submit it as a patch.
> Github might be fine for the development, but we do have an email
> based review system. Maintainers are already overloaded, so it's
> easier for us to follow the guidelines
>
> Thanks
> /Ilias
>
> On Wed, 28 Jan 2026 at 06:26, Peter Robinson <pbrobinson@gmail.com> wrote=
:
>
>
> Hi David,
>
> We have made the U-Boot changes requested and attached a patch for upstre=
am. Let me know if you have any issues or questions.
>
>
> Please send the patch using 'git send-emaiil' or a similar tool.
>
> Regards,
> Peter
>
> Fork: https://github.com/aidangarske/u-boot/tree/rpi4-wolftpm-uboot
> Instructions: https://github.com/aidangarske/rpi4-wolftpm-uboot/tree/mast=
er
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
> On Aug 5, 2025, at 8:31=E2=80=AFAM, Aidan Garske <aidan@wolfssl.com> wrot=
e:
>
> Hi Ilias,
>
> Sounds good, I will keep them in cmd/wolftpm.c. I guess Simon can probabl=
y answer the other question the best.
> He had asked if I could "put the driver code into drivers/ with just the =
command code in cmd/" so I am just trying
> to get clarity on what driver code he is specifically referring to.
>
> Thanks for the help,
> Aidan
> -------------------------------------
> Aidan Garske
> Engineering Intern, wolfSSL
> +1 (916) 337-1246
> -------------------------------------
>
>
> On Tue, Aug 5, 2025 at 1:17=E2=80=AFAM Ilias Apalodimas <ilias.apalodimas=
@linaro.org <mailto:ilias.apalodimas@linaro.org>> wrote:
>
> Hi Aidan,
>
>
> On Sat, 2 Aug 2025 at 01:59, Aidan Garske <aidan@wolfssl.com <mailto:aida=
n@wolfssl.com>> wrote:
>
>
> Hi Simon and Ilias,
>
> Thank you for the great feedback. Currently I am working in the refactor =
you suggested and I wanted to ask a question about some of your comments.
>
> 1. What exactly is the "driver code" you are referring to in this case?
> 2. Do you want me to separate out our helper functions into a `cmd/wolftp=
m-common.c` or should I keep them in `cmd/wolftpm.c`?
>
> Looking forward to your response,
> Aidan
> -------------------------------------
> Aidan Garske
> Engineering Intern, wolfSSL
> +1 (916) 337-1246
> -------------------------------------
>
>
> On Wed, Jul 30, 2025 at 8:40=E2=80=AFAM Aidan Garske <aidan@wolfssl.com <=
mailto:aidan@wolfssl.com>> wrote:
>
>
> Hi Simon,
>
> Thank you for the great feedback. Currently I am working in the refactor =
you suggested and I wanted to ask a question about some of your comments.
>
> 1. What exactly is the "driver code" you are referring to in this case?
>
>
> It's been a while and I am not sure I am following on that
>
> 2. Do you want me to separate out our helper functions into a `cmd/wolftp=
m-common.c` or should I keep them in `cmd/wolftpm.c`?
>
>
> Are you expecting it to be reusable by something else? If not just
> keep it to cmd/wolftpm.c
>
> Thanks
> /Ilias
>
>
> Looking forward to your response,
> Aidan
> -------------------------------------
> Aidan Garske
> Engineering Intern, wolfSSL
> +1 (916) 337-1246
> -------------------------------------
>
>
>
> On Sat, May 10, 2025 at 4:25=E2=80=AFAM Simon Glass <sjg@chromium.org <ma=
ilto:sjg@chromium.org>> wrote:
>
>
> Hi David,
>
> On Thu, 8 May 2025 at 00:41, David Garske <david@wolfssl.com <mailto:davi=
d@wolfssl.com>> wrote:
>
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
>
>
> Thank you for doing this!
>
> Here are a few thoughts:
>
> - Use lower case for function names
> - Avoid camel case
> - What is XMEMSET()? - Can you use memset() ?
> - Convert most prinf() functions to log_debug()
> - Can you use subcommands (from command.h) instead of parsing the
> subcommand yourself?
> - put the FIRMWARE_UPGRADE thing into Kconfig, as well as WOLFTPM_SLB9672=
/3
> - put the driver code into drivers/ with just the command code in cmd/
> - add config WOLFTPM, separate from CMD_WOLFTPM
> - can you add a test in test/ and docs in doc/usage/cmd/  ?
>
> Regards,
> Simon
>
>
>
> =EF=BF=BC
>
> Thanks,
> David Garske
> Software Engineer, wolfSSL
> +1 (530) 409-2990
> https://www.wolfssl.com <https://www.wolfssl.com/> <https://www.wolfssl.c=
om/>
> https://github.com/wolfssl
>
>
>
