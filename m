Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B3BD1D493
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AD6B842F2;
	Thu,  8 Jan 2026 21:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lqf3D7/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743308415E; Thu,  8 Jan 2026 20:25:25 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B460683B49
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64fabaf9133so6242596a12.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767900322; x=1768505122;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NIEtibt/qtj3uwK8DiYy26ijtYa7m/uboyTk7CiNVL0=;
 b=lqf3D7/+lLtWQSLd61fXWTkisqumntHc4NwYdsZtRYZomIJdcf2MyrQa6+ly8WeYb1
 HMYXHfheS/RVFELNRVAsjyhlb3Rd58QFZCFqq0yBjymCNg6vScF4Or6fiNsTnICGW/f+
 lw4UL8NjmigEIxJ+ZLWR5jo6DHR82ulEuick3OBz3skB7Zq5N+Wst8E78KunFI5nXRLZ
 LfOr4fhzMGgGyY3xjkGXNOLNKJ/eUqhhid12fxyYuEt/yffuSEwURj8VklyReACTk4jH
 VOiMLDgVszwEvm4yz5tzttgwG7Z2bZvXYs4yJaZ3WDXaNZMy260FdeNw5cbZMahRDxxM
 5LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767900322; x=1768505122;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NIEtibt/qtj3uwK8DiYy26ijtYa7m/uboyTk7CiNVL0=;
 b=EJZhR64I+j7yLHJA4MVVoGwHjgA0cn0JMWE9b7abOvyiTgE37I85x7Y3IIHMQN2ipc
 7HiRyPYgHZ4WxRCI3/b2ld/IR/F3c49BjZxSntXmX1TMyozj1sNfmv2En9tJxEuzzsE6
 QECDgHSD8a+sDc3+AlVJYscvead4Evg42/oila81D0ijsdjSB5fNo2Xkz36YvfERgbx1
 ESS+NQapS6rDYLTk+Bx3UIGWv1qLLyr8rMxOC3vGmA7CYRu+MRogPCcfyEc9sYJLPDvW
 c2xV/usjxeHH6jzphQ6ZmjGL0dADCNT8aQhk8RbraguH/F0DqwrDHur+FSHwyQQo+6SV
 LTuA==
X-Gm-Message-State: AOJu0YyxLAD0cBrQRCWUEs5xuNIjFa+aWpq5s1hLYAFDDhxZ1ex/4xfa
 3qvuOiGMiHRRK1rkQv5KrQq++ZnpVimJaOsITWcjv4e3ztPbSobt/Unu74/gS31m6jA=
X-Gm-Gg: AY/fxX6Q4+bsU3tRNZDBRKruC5u/qAHg8r06c5Lb0ASKZZ3M3d7n6/FXlBOwkbdU+/5
 l3atWOqs3q0Ztx1z933SCkUBRiZCKEOq4U+oGgDYVkXOeHxKCTffQ1zWXlowtvr1WgZQ/CrZSTX
 gJshllQFSBrPb5U+KxEeQ1tLtL9fhMX+6y62/PN1DzOq260YjEfhNPBGslO1AlMBVIsajZPBo2a
 ynM6r9f/ruYUGFKfIV1SceLX4H/rgzuiW3Tn7eDONK6kkEZamJo/Hnh3YduekSdfnZ3eEBL8LJ5
 o6cfWaC7eQvEQ1kgmVhfOc/eiPmEVKXx3FbN3nJzzrofjmf3tRGspVMHlGYtYW3tVhLsWONY/qI
 PIeVx2mhWw9u9+MKOovHfJbZd7jHcKBrc4/zEZzK7UzL0WfvJeqFsHvp6gQjIQzvPnuWHEo5iTa
 K9SeCDGeD4rDjYSw==
X-Google-Smtp-Source: AGHT+IH905Vm3AJMNR1uTWS1yZjLYxWe33wAywprlWGWqPUMTnPePcnXaqbc8M0qxdURIBq9iWmkZw==
X-Received: by 2002:a05:6402:278c:b0:64b:7ab2:9f83 with SMTP id
 4fb4d7f45d1cf-65097e6b614mr5709914a12.31.1767900322038; 
 Thu, 08 Jan 2026 11:25:22 -0800 (PST)
Received: from localhost ([195.52.31.202]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c3f89sm8598859a12.5.2026.01.08.11.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 11:25:21 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=58c1af36409290b5e6240909e1526ff7a873396c0789114fb3f168b24bb3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 08 Jan 2026 20:25:15 +0100
Message-Id: <DFJGCWVN1KXA.1RO24AUIJQ1VM@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Simon Glass" <sjg@chromium.org>, "Tom Rini"
 <trini@konsulko.com>, "Marek Vasut" <marex@denx.de>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Kory Maincent" <kory.maincent@bootlin.com>,
 "Svyatoslav Ryhel" <clamor95@gmail.com>, "Christian Marangi"
 <ansuelsmth@gmail.com>, "Dinesh Maniyam" <dinesh.maniyam@altera.com>,
 "Heiko Schocher" <hs@nabladev.com>
Subject: Re: [PATCH 0/4] dm: core: Support same compatible in host/gadget
 musb drivers
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Markus
 Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
 <176779448475.214869.16026456579050958123.b4-ty@kernel.org>
 <87pl7lzc5t.fsf@kernel.org> <87ms2oyyxs.fsf@kernel.org>
In-Reply-To: <87ms2oyyxs.fsf@kernel.org>
X-Mailman-Approved-At: Thu, 08 Jan 2026 21:24:28 +0100
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

--58c1af36409290b5e6240909e1526ff7a873396c0789114fb3f168b24bb3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Jan 8, 2026 at 3:13 PM CET, Mattijs Korpershoek wrote:
> On Wed, Jan 07, 2026 at 16:15, Mattijs Korpershoek <mkorpershoek@kernel.o=
rg> wrote:
>
>> Hi Markus,
>>
>> On Wed, Jan 07, 2026 at 15:01, Mattijs Korpershoek <mkorpershoek@kernel.=
org> wrote:
>>
>>> Hi,
>>>
>>> On Wed, 26 Nov 2025 21:31:06 +0100, Markus Schneider-Pargmann (TI.com) =
wrote:
>>>> musb currently uses a wrapper driver that binds on the parent device o=
f
>>>> the actual musb devices to manage the differentiation between gadget a=
nd
>>>> host modes. However in the upstream devicetree this parent devicetree
>>>> node can not be used to match the wrapper driver.
>>>>=20
>>>> To be able to probe the musb devices in host/gadget mode directly, thi=
s
>>>> series introduces support for returning -ENODEV in bind functions
>>>> resulting in iterating the remaining drivers potentially binding to
>>>> other drivers that match the compatible.
>>>>=20
>>>> [...]
>>>
>>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu =
(u-boot-dfu)
>>
>> It seems this series broke the CI when testing sandbox:
>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/1349214
>>
>> Can you have a look please?
>>
>> This can be reproduced locally using:
>>
>> $ ./test/py/test.py --bd sandbox --build -k test_bind
>> [...]
>> FAILED test/py/tests/test_bind.py::test_bind_unbind_with_node - Assertio=
nError: assert 'Unable to bind. err:0' =3D=3D ''
>> FAILED test/py/tests/test_bind.py::test_bind_unbind_with_uclass - Assert=
ionError: assert 2 =3D=3D 1
>
> We have discussed this on IRC (privately) and Markus has posted a v2
> that should address the CI failures here:
>
> https://lore.kernel.org/all/20260108-topic-musb-probing-v2026-01-v2-0-2a4=
7c6e0e73a@baylibre.com/

Yes, thank you Mattijs, sorry for not posting here.

I missed the possible path of the drv argument being set and the driver
not having an of_match being set. I fixed that in v2 and also added a
few cleanups for the function.

Best
Markus

--58c1af36409290b5e6240909e1526ff7a873396c0789114fb3f168b24bb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaWAEmxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOt
RQEAnX2QcKOPmPchpEB+hZpW6KbcMS/R9uI1f0MZo2TvUwQBAJE+6ON0EF6doJgA
gI4Jr+cRbkTMiLt3O0mHCmBKYEIH
=6994
-----END PGP SIGNATURE-----

--58c1af36409290b5e6240909e1526ff7a873396c0789114fb3f168b24bb3--
