Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1D6C54E71
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 17:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9569A82E28;
	Wed, 21 May 2025 19:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="qRteC6vm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5678682E2D; Wed, 21 May 2025 19:12:52 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A61682E26
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 19:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-231f6af929eso55057055ad.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1747847568; x=1748452368;
 darn=lists.denx.de; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HarKvlMa08XKllwJcNa4ZBiT5LHh3XoLOtTvd8JtIng=;
 b=qRteC6vm+l1BAPZV2B9OhrHhAqJ5ZdOlxaV4E84SaV7eenMmgbGJkh4VlFqowgmPcv
 +MtWYa66vOGSw/+Y6EvvCyg/lZ8ZKBM+ry9Z6HbDDTIf+U112bg8SZoYOiC/5dx/Ansb
 3NpOOG8fk0vmdJH4Fq++yOMZ7bpzhDWoaGXqNcRyU5P8KB3h04HcV45awc2MYjSACFGB
 zDuozqZJrDaSdDj5WG29LSWwOpKC/HKwRUkRD8a/Jr6J4dpY1ToziH+86sDIT7E57gpb
 Oa3OxKB21eGwrDro5UU2Ii9226VM+XdFHe2LVcPz3uaeE94lcQBeL505eqERVHx5TIiE
 /3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747847568; x=1748452368;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HarKvlMa08XKllwJcNa4ZBiT5LHh3XoLOtTvd8JtIng=;
 b=UujTPtYFKRwetF35cmPw9Rxtgtgz0VIf/0BYM5GfwQ1DT2Jqx2mDPmvrG4Iwal0EHX
 tZ8LqwGb5STQsJsFFCtrdJdFvx+38KVuniz/sJC5gKvhSPMmp7Srb/kyM6OGM1rdyS2m
 LZtJQPbemZA1aCcStg5QMLX884Mlv3jwaZYgXm7H1UlDArg8QLVGZKYDOIBRuC3MpivW
 FqZ2Y0xlKJo4x6JB8jwkSZSX6CwufNIWkF7UrpLXmpq9pB3uQQQkOrc2kHTcC+HKJtms
 e2I2ftMHBc4MibwPK31KORnlZcpay4MwRF4EUJvWYoda0RgvYSQrVZr1PmQ4IAj5PO8O
 iN1w==
X-Gm-Message-State: AOJu0YxdvO+SbYdPscXcGepvZ48brBEH0zCYzLAFCbZFhgDZdnC7dq9/
 mFr7en1wMaVbOGUrXafD5bEnqGvNDYPfrSRUtWWLe3DNcObYVVBc0TxNbuJBQLCEHd0=
X-Gm-Gg: ASbGnctDOqH8qAYfKcO5Zb6aqkcTna5ZsBoEnO9J2fTOaKQcSPrPhmgcuNUWCJftn+W
 CzfsMbFAZwSExYjqV5JfFEpcJhAyaC+QOPRqwoPHkFD/NeblLUyGkUKmcFoPAp4kfM/SJ/7mOyy
 EpRkP60Xbn3Kw4yNL7pcZ917QzEQNZ9QcATeIqCdMb5NapyOk5zy74ytfvmlFOtzZj/toBf2BGA
 USthjMJNsQz19rAZ+YoK5tiYJikWdVYRioPqDqyfxalmsbdAo4K/7OkpplsBdzXrGJH5ErPnxFY
 /6vBviNTrTzffkNz3plNQlcL8iumCALwPL2V6QNKLe2NnipXzX/0WHO/hN+hGCTQhGino8hvWlW
 +BB3X
X-Google-Smtp-Source: AGHT+IE/O7OheMxbFYE04mbwUAPQWfvfBA7SrbTHe26aMdpzBJlLJIPFc2aYhOwoBYb2u1CtLr7gsQ==
X-Received: by 2002:a17:902:f691:b0:224:24d5:f20a with SMTP id
 d9443c01a7336-231d455df81mr339600045ad.48.1747847567811; 
 Wed, 21 May 2025 10:12:47 -0700 (PDT)
Received: from smtpclient.apple ([2607:fb91:1d06:4b8:4dde:2d3a:56cd:1ac2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ed1946sm95475785ad.217.2025.05.21.10.12.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 May 2025 10:12:47 -0700 (PDT)
From: David Garske <david@wolfssl.com>
Message-Id: <D73260F8-6334-4F8A-A8DD-FF70B8EF313E@wolfssl.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
Date: Wed, 21 May 2025 10:12:35 -0700
In-Reply-To: <CAC_iWj+mH2jywAYA_cBOqBnk+pvH-+r4nwL7SD8HGDbdmu284g@mail.gmail.com>
Cc: u-boot@lists.denx.de, Todd Ouska <todd@wolfssl.com>,
 Larry Stefonic <larry@wolfssl.com>, Wolfram Kusterer <wolfram@wolfssl.com>,
 Aidan Garske <aidan@wolfssl.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <D9RMK91R8Q2I.3BA39TM77AYZA@linaro.org>
 <AB2FA403-CBB0-44F6-AC75-4A70B3E9242B@wolfssl.com>
 <CAC_iWj+mH2jywAYA_cBOqBnk+pvH-+r4nwL7SD8HGDbdmu284g@mail.gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Mailman-Approved-At: Wed, 21 May 2025 19:20:42 +0200
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

Thank you! It=E2=80=99s a pleasure to meet you! I=E2=80=99m the author =
and maintainer or wolfTPM.=20

Perhaps it would be useful to meet and chat for a bit? Are you free next =
week May 28th at 7:30 AM PT?

I loved the feedback from Simon Glass and we will be implementing those =
and suggesting a new patch soon.

Thanks,
David Garske
Software Engineer, wolfSSL
+1 (530) 409-2990
https://www.wolfssl.com <https://www.wolfssl.com/>
https://github.com/wolfssl

> On May 19, 2025, at 1:52=E2=80=AFAM, Ilias Apalodimas =
<ilias.apalodimas@linaro.org> wrote:
>=20
> On Fri, 9 May 2025 at 18:43, David Garske <david@wolfssl.com> wrote:
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
>=20
> it's in MAINTAINERS. I am responsible for TPM
>=20
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

