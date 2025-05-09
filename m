Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B11C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 16:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA3638295C;
	Fri,  9 May 2025 18:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="e0NQiGHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C0882998; Fri,  9 May 2025 17:43:54 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D232282162
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 17:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-309d2e8c20cso2895889a91.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1746805430; x=1747410230;
 darn=lists.denx.de; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5w5SgmdvSXf92X0zfYUpNdEtW4FD1B55QtJ3Xr68Vc8=;
 b=e0NQiGHRekK16KfbAJXKk9B7dbuvrhaTdgnJmGIG83I+Ww+uvtOGSy0T5SGsuYFtLc
 qIaTJ5iYmHn675RaZRbYXLy1NiOYAn9KPu6LUuZf00Y7jWV2KS4RbOWJlkAo7yuEpmBc
 zao2Zgp5GJ0tFGskf9Ka57BTYDSxLwNKb9cTJHO06eFulnQwXruVQ8wCUfhLEeJ7q+le
 lbmDo9doFm30/X9SPH8RVfEafR/yQZel47ibYLK8B3DM05y4/6onrocNNCN4PlYqRlcu
 jktIhUUh4TFQ2vgR0Z3UiodtF1F2qdVa3yc5NzVpCIPeYRhFvulIosOnf2NogoI7xo1v
 Famg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746805430; x=1747410230;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5w5SgmdvSXf92X0zfYUpNdEtW4FD1B55QtJ3Xr68Vc8=;
 b=kEdeIyUxSRHf56h+Q/Nra1N2XUSNWo8TnnJVaIuEKTFjyeQ2RFt0nzuCr2KHZotEyO
 q9EzSTXfRACiDEpuAKipM84dDdw3cVnaOEkNXZRMPlsoDPWexZBdOFwt/Kmne0tX/HG5
 DGy5cjHy18F3ldwT04XGGud/MqXJd7qNFbxubyLFyQQ2VcoUa+kqnzPtpiBNqPTMDwQ/
 vs/xwIDOjbEZ8YuSrSFZKJgRq8fjkoYcFmgPMlAleTTleDu1ZYkVrktyxphEzFr3QOFO
 iqVmEUoc3K4hxmq+k0nPfck1KTn9FGK48pEprrG5TJh9mpYdSEfu02rtyzvKLBGGreHz
 8nng==
X-Gm-Message-State: AOJu0YxbPqckVt7FUhOovior87yoEMUbzffQlr/taI/um/LjSCumSV1s
 NorkmNL+dHr9XrVA12tfUYqs1qnNbWubLwJPB9apbIq4Vq1tXpH5MVTGNYPVSzM=
X-Gm-Gg: ASbGncuv4y1FG93bEVM4AkCx7fk5WTPhMA5u0Y586k0ZkNKe5Xh4A30Agyf04B3Qjdc
 519H/lSrPYQeW75d95kfIgRrNH+YaL6McU0yjINY9S/2NfwcdVUfbjI9MADSD4/7ofFUiPW5b98
 G6ZpESb59KtEDw7dMZHVGcpnJJddiv18vgwjVMvJuYvoyNjI9JzGbauKjnyfiq1h3wGGJ+0xMBF
 CDyfunfDe2r6I+fwM7Ya6k1m780Q9i0nO4QRI2VgYeMcAxduwDwDI0zBjc7iNGgqu5udjH/7i0N
 9MZBvI/CPqV4rx/V4fA5AqayWI12Rl6M9kLv+R5pDUBChYmDfN/Ay5DlMj8PGcIF
X-Google-Smtp-Source: AGHT+IEetzMOvqKJMm2FkODbdd+CepWHznpCPn3zmzo9ziURwlUPpIcxx4nOGaOrDIeZU/Ob/L1mQw==
X-Received: by 2002:a17:90b:2fc8:b0:2fe:b907:562f with SMTP id
 98e67ed59e1d1-30c3cff2ba0mr7685770a91.14.1746805430164; 
 Fri, 09 May 2025 08:43:50 -0700 (PDT)
Received: from smtpclient.apple ([2607:fb91:1d06:4b8:c020:f716:cc15:ac11])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4d2f1dasm4286201a91.17.2025.05.09.08.43.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 May 2025 08:43:49 -0700 (PDT)
From: David Garske <david@wolfssl.com>
Message-Id: <AB2FA403-CBB0-44F6-AC75-4A70B3E9242B@wolfssl.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
Date: Fri, 9 May 2025 08:43:37 -0700
In-Reply-To: <D9RMK91R8Q2I.3BA39TM77AYZA@linaro.org>
Cc: u-boot@lists.denx.de, Todd Ouska <todd@wolfssl.com>,
 Larry Stefonic <larry@wolfssl.com>, Wolfram Kusterer <wolfram@wolfssl.com>,
 Aidan Garske <aidan@wolfssl.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <D9RMK91R8Q2I.3BA39TM77AYZA@linaro.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Mailman-Approved-At: Fri, 09 May 2025 18:48:29 +0200
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

Thank you for the quick reply. I am happy that you will consider wolfTPM =
as a submodule. We have 100=E2=80=99s of commercial customers and it is =
very actively maintained. In fact we will continue to provide direct =
maintenance for any u-boot issues that come up using wolfTPM. Also =
we=E2=80=99ve done safety critical DO-178 certification on wolfTPM.

1) U-Boot subsystem maintainers. Can you point me to that list of =
maintainers?
2) Size: I haven=E2=80=99t run any size comparisons but I expect to be =
inline with existing code. I will make sure we run some comparisons.
3) Releases: Yes we have stable releases done each quarter. I am about =
to do a release v3.9.0 next week that includes the U-boot support, so I =
will update the submodule to use the tagged release when it=E2=80=99s =
ready.
4) CVE: Yes we track and create CVE=E2=80=99s if we find issues or any =
are reported. We typically have a fix posted within 36 hours of a =
report. Vulnerabilities are published in the release notes and for our =
premium support customers they get early notification.
5) Patch Size: I will work on reducing the changes and splitting them =
into logical commits.

Enjoy your time away. I=E2=80=99ll have updates to share soon.

Thanks,
David Garske
Software Engineer, wolfSSL
+1 (530) 409-2990
https://www.wolfssl.com <https://www.wolfssl.com/>
https://github.com/wolfssl

> On May 9, 2025, at 5:22=E2=80=AFAM, Ilias Apalodimas =
<ilias.apalodimas@linaro.org> wrote:
>=20
> Hi David
>=20
>> Hi Denx,
>>=20
>> We at wolfSSL have developed a port for wolfTPM in U-Boot. The patch =
allows using the current built-in TPM 2.0 support or switching to =
wolfTPM via CONFIG_TPM_WOLF=3Dy. It also supports TPM 2.0 firmware =
update for the Infineon SLB9672 and SLB9673.
>>=20
>> I think there is probably some more cleanup and testing needed, but I =
wanted to submit this to start the discussion and see your thoughts.
>=20
> It's easier if you CC the appropriate maintainers for each subsystem =
next
> time!
>=20
>>=20
>> The wolfTPM library is GPLv2 and added as a submodule. If the license =
or submodule is an issue let=E2=80=99s discuss! I=E2=80=99m positive we =
can resolve anything.
>=20
> We recently added a few external libraries. mbedTLS and lwIP. Both of =
these
> are pulled as subtrees, so I'd like to stick to that.
>=20
> I briefly went through the patch and I don't disagree in pulling an
> external library as long as it's reasonably stable and will continue
> to be maintained. A few questions since I am not familiar with wolfTPM
>=20
> - Have you made any size comparisons wrt to the final binary size?
> - Does wolfTPM have stable releases that we can use?
> - Is there a CVE policy ?
>=20
> The current patch is quite big and I honestly don't have time to go
> through all of it in detail. I'll be away next week, but I can give =
some
> general feedback in ~10days. The easiest thing to do is try to split =
it
> a reasonable amount of patches -- and only include the bare minimum of =
what's
> required to work.
>=20
> Thanks
> /Ilias
>=20
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
>=20

