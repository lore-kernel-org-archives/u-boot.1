Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016C1CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 12:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FCC984704;
	Fri, 26 Jun 2026 14:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DLS3ucJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC2C84894; Fri, 26 Jun 2026 14:03:42 +0200 (CEST)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933A68404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 14:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so1506874eec.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 05:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782475413; cv=none;
 d=google.com; s=arc-20260327;
 b=TXgHz/kYvSL8RyzPGifBnn2vIUAyLyJq1fjtGZkQYDOiQx64Aa0dxWR1l9V/Mv8KAe
 Bu/CKCrdnEPiCQAHbocEN/NYiPs31+48LARZ+mfRVR9DFKsYrOXckFmm2kdD9bqrbuwB
 T+en5xL5mO1xDJM8+POtAeaT/QtfTgBkHtmiNKbfpdc+DHVj4lseY81SqmfdNBxw6gnC
 3KDL+Gl5AtohBvb5N9nJ7r0/ktTorOvultTtzdTm2+CwGs9qIMvgqi/UJO6+8+U3Fknf
 7B3byVN8Ea6u/1DcgjVGBFuFHMu2OxhyYYS4q+qxthahVshn2dOwrEZ8E5BVW8oQGy9g
 2R2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bd2JNGnvIjYaJ25GdusWaDpdcJ8TGb3j9bgIynHvwnU=;
 fh=9zifYT3eFxFmXRwMpi8JLyD00eDJBhVv3FGo8TBG4LA=;
 b=AoAr+n63OT4zFclCDBhZy2KJdlCm+eYcbNvJkT+XTQ+G3B1Ec5ODjGa6965s0+/ERB
 rtJVoHEeCZxZ4KVWChW5XS3mI1JbwGrWZfh8pMDSI1D3BG3cvRZtOf8UQy63LHzjFfhx
 7YrZFubjnmGKB44aV5V+kMb3ydBxDsCr/nwkhkZ1+DmQeXJuzJ0pjYh4pGF18uEJltNw
 7bNdTCy8mLexbLg1JDuVOIETQvqgM1YPbfMjCqVxs5IoFM5C6JSJeK40va12DHXvAmnp
 n2nk/mMD4ljNTpO4IkqnS1kSGMwkmF1lp6sH/BvYdayAVUnGN9WAb+UkaDVwrlCiiGfL
 dSiA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1782475413; x=1783080213;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bd2JNGnvIjYaJ25GdusWaDpdcJ8TGb3j9bgIynHvwnU=;
 b=DLS3ucJnbC3f5y2se2b3tx5bG5s/3ET7DWZ5huehmFW2Z7pR6c0ot8+Ew3YuzJTy5t
 INaNBnu2UPJUSf/Sm0PTJCQNcRM2DAmhiwiu9FjgW5gCHiIy73IXlceE5IDBUAkr2Hj1
 bG0tlGgWAoNaQSbfxw97pAvF4MNPPOwwRmBC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782475413; x=1783080213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bd2JNGnvIjYaJ25GdusWaDpdcJ8TGb3j9bgIynHvwnU=;
 b=H+wllm6HzDnh5OGWKAJSRI8mPpOBpJzju+YFn4SAtnkuIGo2Uu1S+bInU0/ilsAcmL
 U3IN7QYmJP1YnE3mxqyoiCEMwl/PSrfoGZB5dgre7a0hMc+0N0CwJLbYlDlwZF4DYOtI
 kTtzyZjINKdOhfcm3F+LW1dSObfsCB54fGHWV4rtwMMX0ukRKZnb9dgotGfY6rRfhBzV
 qcURseaPhrybX9Httxoiin88XplFT2WFv2I4jDBeQj5iMT6NGbcEwoEknvLGw/X1lVHu
 I7qhL73S/LA20VDwsttztHBF06G+Z+RnkEWYdYZUhe59NsddrKpvOj6kjEHfDzCRXVdd
 dLaA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9VWDklTwvypNG/vCYJySmQkKtOYIwis9Rzq9ZkMOYivI5eZ7IR5TNQqQ+z8lP7nJGw4E9ZUQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwnpUtmB0J/AgzBDn4IPYKVCy0h3ygRZdwSa3b0k6PmrMopAwNp
 yOoCZdo7BwbT6wt3CJOLF+U0yN8Z+wcLfvYGByCH3/tRwbbY4VEG9f2eom46tiqibr+z6b60Hsv
 vNoG8l3TU5Sa+GfezAbWwdwZ9dmcLvkaMupI4j9xXhEtxtn8YXYTFKvE=
X-Gm-Gg: AfdE7ckZ7ITkMuPoa1TNEMnQouCTyqn8jNjH7aRdLuygAG6FRTWLKPpd7exZJCA0oOP
 p+Zrt7CR4wMI9LbvCtO+F8ljaiSNs42nqb/rql2JWL65U7ZVsjavUP5dUBofZlPLcPGNniH0IuG
 XGZJ+ruA8xpFvxEXBHmSg6toa9eLIUEg1ske+uDnISNuDtSvF7kGc/+IXGoLOl07RPszDf6msfT
 +IR2m7Z1y2UzGAoXcbF1HrmWbwEXdA1gzp/74l8GlZxLyFth70xakLwsY74407vvtf2dX3ZW0ui
 N+aeC7DM9/D1hpWmGrvY6839flmj
X-Received: by 2002:a05:7300:760a:b0:30c:2d3d:7840 with SMTP id
 5a478bee46e88-30c84e1987cmr6858514eec.35.1782475413243; Fri, 26 Jun 2026
 05:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <6d1d17a4-d914-4136-a90a-0d9073bcf135@syss.de>
 <4428b405-ea06-4af4-a84d-095d4cbf4609@syss.de>
In-Reply-To: <4428b405-ea06-4af4-a84d-095d4cbf4609@syss.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 26 Jun 2026 14:03:21 +0200
X-Gm-Features: AVVi8CeGxnEbAtVmkqEg1NI7cWi0FvYZsS3ahgWDt5EzADgUOT7iIpE5TG77p7I
Message-ID: <CAOf5uw=Ymi_L98crSKdzX12hWGTEohz1MVHchg8mgdoUH+_1=A@mail.gmail.com>
Subject: Re: Fwd: SySS Responsible Disclosure Policy
To: Robin Trost <Robin.Trost@syss.de>
Cc: dario.binacchi@amarulasolutions.com, Tom Rini <trini@konsulko.com>, 
 andrew.goodbody@linaro.org, u-boot@lists.denx.de
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

Hi

I have long queue, I will take care of it, but coming out some down
period. Please I will look in weekend,

I have already other patches to send

Michael

On Fri, Jun 26, 2026 at 12:02=E2=80=AFPM Robin Trost <Robin.Trost@syss.de> =
wrote:
>
> Hi,
>
> any updates regarding the issue?
>
> Kind regards,
> Robin
>
>
> -------- Forwarded Message --------
> Subject: Fwd: SySS Responsible Disclosure Policy
> Date: Fri, 12 Jun 2026 22:47:10 +0200
> From: Robin Trost <Robin.Trost@syss.de>
> To: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
> Tom Rini <trini@konsulko.com>, andrew.goodbody@linaro.org
> CC: u-boot@lists.denx.de
>
> Hi all,
>
> during a recent assessment I identified a vulnerability in the OOB data
> parsing of the NAND chip. As you are the maintainers regarding [1], I've
> sent you the advisory advisory (SYSS-2026-038: Arbitrary OOB Heap Write)
> including a "optional" fix and a reproducer script which illustrates
> that the vulnerability can lead to arbitrary code execution in the sandbo=
x.
>
> If you have further questions, please do not hesitate to contact me.
>
> Kind regards,
> Robin
>
> [1] https://docs.u-boot.org/en/latest/develop/security.html
>
>
> -------- Forwarded Message --------
> Subject: SySS Responsible Disclosure Policy
> Date: Wed, 10 Jun 2026 15:46:26 +0200
> From: Robin Trost <Robin.Trost@syss.de>
> To: u-boot@lists.denx.de <u-boot@lists.denx.de>
> CC: trini@konsulko.com <trini@konsulko.com>, p_mailqueue_disclosure
> <disclosure@syss.de>
>
> Hi all,
>
> The SySS GmbH deals with security issues in a responsible way. In the
> form of a security advisory we report security vulnerabilities which are
> not in products of our customers and which are not excluded from public
> disclosure due to contractual agreements with vendors.
>
> The attached security advisories contain detailed information about the
> found vulnerabilities that allows the vendor to reproduce and further
> investigate the reported security issue. Vulnerabilities will be
> disclosed to the public if a solution was published by the vendor or 45
> days after the initial report by the SySS GmbH, regardless of the
> vulnerability status, for example if there is a patch or workaround from
> the affected vendor. In well-founded exceptional cases, this standard
> procedure may not be followed and an alternative, adjusted publication
> schedule will be negotiated with the vendor.
>
> The goal of our Responsible Disclosure Policy is, to weigh up the need
> of the public to know of security vulnerabilities against the vendor=E2=
=80=99s
> time to remedy all security issues effectively. The final publication
> schedule will be based on the best interests of the community overall,
> considering both positions. Before the responsible disclosure of a
> security vulnerability, the SySS GmbH allows vendors the opportunity to
> analyze reported security issues, to develop effective countermeasures,
> and to test them thoroughly.
>
> If there are any further questions regarding the identified
> vulnerabilities do not hesitate to contact me.
>
> Kind regards,
> --
> Robin Trost
> Senior IT-Security Consultant
> ______________________________________________________________
>
> SySS GmbH
> Schaffhausenstra=C3=9Fe 77, 72072 T=C3=BCbingen, Germany
> Tel: +49 (0)7071 - 40 78 56-6169
> Mobil: +49 (0)151 - 42209330
> E-Mail: Robin.Trost@syss.de
> Conf. Calls: https://syss.zoom.us/my/robin.trost
> Web: https://syss.de
>
> PGP-Fingerprint: 85FE 80E2 04F3 6177 C61A 4618 61DE F14F 698E 6EB3
>
> Gesch=C3=A4ftsf=C3=BChrer: Sebastian Schreiber
> Registergericht: Amtsgericht Stuttgart / HRB 382420
> Steuernummer: 86118 / 55809



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
