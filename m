Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E579C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 22:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B440782BA7;
	Sat, 31 May 2025 00:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="0X02XqvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762B382C0C; Fri, 30 May 2025 21:46:14 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 842C382BA7
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 21:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-742c9907967so2520545b3a.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1748634370; x=1749239170;
 darn=lists.denx.de; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jxY3GTVTp0UlUpbQyenrk5maHusbncfUwWzPGv19PfI=;
 b=0X02XqvCppwVh5whCmh+VYhYLeEAm1mi+GnduFdupIc6+qMlMnLT2YD4r1TCKSmc3S
 hnhGOjuqAkBi5cnfj+PRG6R5zQtjyk8SOtZiw13k/MvCmkePOzpVUEZYBX21mfRo5sAH
 Nrlh3aEqSgVuRbjMDJJ3npS62DUe57XaU+I8BLwGdLFX28wAaOSWqcvZ+sDcP3mQKrLL
 vJLefsa3CBdi71Aga9z60KGtfpEH1FQxvP1bpqqMEOPtQC1QUN3cO+FFZVJA4iLyAI2p
 LyMRLgggzSjuTAy2h4dI/HoF9+o9HCK90a5Y8IkSp1pPT1lKMskztzRbjxqfLtQUldTC
 Kg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748634370; x=1749239170;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jxY3GTVTp0UlUpbQyenrk5maHusbncfUwWzPGv19PfI=;
 b=bL0Mt5eGlSBBqfAxXnYm8SX2+3VYD4uEt+altKM47UJMP4ubez0ZaDsr1Mf1zZXlrh
 UykeYLuB/DzoT5UdN+UVPH1r/q/reFHsVdNnV7uk6yigkTX4iuycboMijzhDqGpIV/eU
 WNADT1j4Hw/wxdVhjovnjVJhzoixICvsQgu5Sa60TNsyLawQGNn3NKjfvBDwdaSBmLwW
 QZCn80QI2NxMCPYmtsbWU4gHvdjQKMfnHf6gCUp0A+6KfvZDAP71h876ODJTLqjDA9OP
 J12fzLeW/cJmveeFlSeCxjUOP+feQ90LSt756FbvP5reRbz4Gu9Bl5LVKXCn97km//xb
 exGg==
X-Gm-Message-State: AOJu0Yy9PcbYFBzMMbJSJMs6lrFck3vGtcB5LuxULFp7pU6JjFt1jP8K
 BMB9yMU0KrSeC6GWFs2KR0/QhTK5YBKOaesTBZ6ipcw+entcUPDyIJcO7GOAcfNfFQs=
X-Gm-Gg: ASbGncsmkkmZm0WUTS6BBHB0f0ByVLozz28yip8Fg4WAJ8trjKQnGoxxqh+Zf4XFlZO
 e0u14gRJWlOZ5dS+UjN0EA7fBvHcX4b7Wj9bQw1qAwWFrUxm+LngBQJRSVNot/wsOlAxM+F1JcG
 paD7Y1yI0O2di8mScKCbj/h0nGROIjTCzv/W84U9s1Sazn+WSrPbcGy20ArQftPWe5M2pBzcemM
 ApxQ4aRi0RzI0BPBjKenhjNV0GPWVXohtzM+/ApWzuNuuV+qXBCKIqPTrhIn7pbX3fYfzYYCGLO
 pS0dwbqbNS5+bcNsYKOFJcaGxZMWHZuKNOU+ZJ2E7+80U7RHdSs9gGBd/sBhNtccB7twmzYylw=
 =
X-Google-Smtp-Source: AGHT+IHMrEU4IhdjPaGKTUSe/9rPC0bB7wetS84e6Q+tLCuNRPUEQpErJWRcxQqBxlbQgyus4JfG9Q==
X-Received: by 2002:a05:6a20:1605:b0:1f5:8cc8:9cc5 with SMTP id
 adf61e73a8af0-21ad978cfe9mr8387940637.34.1748634369835; 
 Fri, 30 May 2025 12:46:09 -0700 (PDT)
Received: from smtpclient.apple ([2607:fb91:1d06:4b8:c8ff:7756:da2:93b2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affcfa0csm3508766b3a.131.2025.05.30.12.46.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 May 2025 12:46:09 -0700 (PDT)
From: David Garske <david@wolfssl.com>
Message-Id: <BE301B14-56AC-44D0-9EA4-84346EEF313F@wolfssl.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
Date: Fri, 30 May 2025 12:45:57 -0700
In-Reply-To: <CAC_iWjJt=Rq2=FzhLpZpiSycXFuUC1Yd-07Ru4NZUMRt+hqKbw@mail.gmail.com>
Cc: u-boot@lists.denx.de, Todd Ouska <todd@wolfssl.com>,
 Larry Stefonic <larry@wolfssl.com>, Wolfram Kusterer <wolfram@wolfssl.com>,
 Aidan Garske <aidan@wolfssl.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <D9RMK91R8Q2I.3BA39TM77AYZA@linaro.org>
 <AB2FA403-CBB0-44F6-AC75-4A70B3E9242B@wolfssl.com>
 <CAC_iWj+mH2jywAYA_cBOqBnk+pvH-+r4nwL7SD8HGDbdmu284g@mail.gmail.com>
 <D73260F8-6334-4F8A-A8DD-FF70B8EF313E@wolfssl.com>
 <CAC_iWjJt=Rq2=FzhLpZpiSycXFuUC1Yd-07Ru4NZUMRt+hqKbw@mail.gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Mailman-Approved-At: Sat, 31 May 2025 00:09:35 +0200
Content-Type: text/plain;
	charset=utf-8
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

Hi Ilias,

Thank you for the reply. I totally understand about being busy! There is =
nothing specific to discuss at this point. I=E2=80=99ll reach out again =
soon with the proposed u-boot wolfTPM patches.

Thanks,
David Garske
Software Engineer, wolfSSL
+1 (530) 409-2990
https://www.wolfssl.com <https://www.wolfssl.com/>
https://github.com/wolfssl

> On May 30, 2025, at 12:32=E2=80=AFAM, Ilias Apalodimas =
<ilias.apalodimas@linaro.org> wrote:
>=20
> Hi David,
>=20
> On Wed, 21 May 2025 at 20:12, David Garske <david@wolfssl.com> wrote:
>>=20
>> Hi Ilias,
>>=20
>> Thank you! It=E2=80=99s a pleasure to meet you! I=E2=80=99m the =
author and maintainer or wolfTPM.
>>=20
>> Perhaps it would be useful to meet and chat for a bit? Are you free =
next week May 28th at 7:30 AM PT?
>>=20
>> I loved the feedback from Simon Glass and we will be implementing =
those and suggesting a new patch soon.
>=20
> I am a bit overloaded. Is there anything specific you would like to =
discuss?
>=20
> Thanks
> /Ilias
>>=20
>> Thanks,
>> David Garske
>> Software Engineer, wolfSSL
>> +1 (530) 409-2990
>> https://www.wolfssl.com
>> https://github.com/wolfssl
>>=20
>> On May 19, 2025, at 1:52=E2=80=AFAM, Ilias Apalodimas =
<ilias.apalodimas@linaro.org> wrote:
>>=20
>> On Fri, 9 May 2025 at 18:43, David Garske <david@wolfssl.com> wrote:
>>=20
>>=20
>> Hi Ilias,
>>=20
>> Thank you for the quick reply. I am happy that you will consider =
wolfTPM as a submodule. We have 100=E2=80=99s of commercial customers =
and it is very actively maintained. In fact we will continue to provide =
direct maintenance for any u-boot issues that come up using wolfTPM. =
Also we=E2=80=99ve done safety critical DO-178 certification on wolfTPM.
>>=20
>> 1) U-Boot subsystem maintainers. Can you point me to that list of =
maintainers?
>>=20
>>=20
>> it's in MAINTAINERS. I am responsible for TPM
>>=20
>> 2) Size: I haven=E2=80=99t run any size comparisons but I expect to =
be inline with existing code. I will make sure we run some comparisons.
>> 3) Releases: Yes we have stable releases done each quarter. I am =
about to do a release v3.9.0 next week that includes the U-boot support, =
so I will update the submodule to use the tagged release when it=E2=80=99s=
 ready.
>> 4) CVE: Yes we track and create CVE=E2=80=99s if we find issues or =
any are reported. We typically have a fix posted within 36 hours of a =
report. Vulnerabilities are published in the release notes and for our =
premium support customers they get early notification.
>> 5) Patch Size: I will work on reducing the changes and splitting them =
into logical commits.
>>=20
>> Enjoy your time away. I=E2=80=99ll have updates to share soon.
>>=20
>>=20
>> Thanks
>> /Ilias
>>=20
>>=20
>> Thanks,
>> David Garske
>> Software Engineer, wolfSSL
>> +1 (530) 409-2990
>> https://www.wolfssl.com
>> https://github.com/wolfssl
>>=20
>> On May 9, 2025, at 5:22=E2=80=AFAM, Ilias Apalodimas =
<ilias.apalodimas@linaro.org> wrote:
>>=20
>> Hi David
>>=20
>> Hi Denx,
>>=20
>> We at wolfSSL have developed a port for wolfTPM in U-Boot. The patch =
allows using the current built-in TPM 2.0 support or switching to =
wolfTPM via CONFIG_TPM_WOLF=3Dy. It also supports TPM 2.0 firmware =
update for the Infineon SLB9672 and SLB9673.
>>=20
>> I think there is probably some more cleanup and testing needed, but I =
wanted to submit this to start the discussion and see your thoughts.
>>=20
>>=20
>> It's easier if you CC the appropriate maintainers for each subsystem =
next
>> time!
>>=20
>>=20
>> The wolfTPM library is GPLv2 and added as a submodule. If the license =
or submodule is an issue let=E2=80=99s discuss! I=E2=80=99m positive we =
can resolve anything.
>>=20
>>=20
>> We recently added a few external libraries. mbedTLS and lwIP. Both of =
these
>> are pulled as subtrees, so I'd like to stick to that.
>>=20
>> I briefly went through the patch and I don't disagree in pulling an
>> external library as long as it's reasonably stable and will continue
>> to be maintained. A few questions since I am not familiar with =
wolfTPM
>>=20
>> - Have you made any size comparisons wrt to the final binary size?
>> - Does wolfTPM have stable releases that we can use?
>> - Is there a CVE policy ?
>>=20
>> The current patch is quite big and I honestly don't have time to go
>> through all of it in detail. I'll be away next week, but I can give =
some
>> general feedback in ~10days. The easiest thing to do is try to split =
it
>> a reasonable amount of patches -- and only include the bare minimum =
of what's
>> required to work.
>>=20
>> Thanks
>> /Ilias
>>=20
>>=20
>> Attached is the patch based on latest master 3b6760ddeb4 to review.
>>=20
>> =EF=BF=BC
>>=20
>> Thanks,
>> David Garske
>> Software Engineer, wolfSSL
>> +1 (530) 409-2990
>> https://www.wolfssl.com <https://www.wolfssl.com/>
>> https://github.com/wolfssl
>>=20
>>=20
>>=20
>>=20

