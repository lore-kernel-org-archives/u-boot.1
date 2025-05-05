Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D91C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCD5A80BAE;
	Mon,  5 May 2025 14:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WkMvbyTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB7C801BE; Mon,  5 May 2025 14:28:34 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C8CE8212F
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 14:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-54e8e5d2cf0so5073822e87.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746448111; x=1747052911; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0lTab6YCAd48wfdbjxQheM0/g0AIbF74NaQqfwRjPc=;
 b=WkMvbyTrbUgS5niKQW3fLspl4adOc1koXeiqESGQW8sSHLe3o7BUPR5BmuV1KyTq2/
 ENlPi+zwudTkAKb0oaUOWvf0zuS13fids/71VFukNuReQ+wOf5t6JSgktE2AwHJWHIQL
 nN0n6qhPEfRrshkIZUCpRrNXzLSrdOC1M3ekC1GpNr/SlUDp/tZK3YcxH1IQxiC5zNUD
 ZmY1Pgz2E569OpGqhyjurmdd6q54efCq6EU+XEE1fK7teIz3JtyAFpYSjyQbSz3RDOur
 ygn0IdgybKZ6+8P9pyDY1sglX0PqlmYMlTLutO9ZLridlVI7k0NMNXXhNTKQmJ2vj2I9
 fiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746448111; x=1747052911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s0lTab6YCAd48wfdbjxQheM0/g0AIbF74NaQqfwRjPc=;
 b=eaJ9U9gsz7ksIJjKOj1lrrRYCS36YgJl7IP3/paDisu00Bfhi8Dx56dylSav9IVWym
 dezxeR8Oyrdw4p07FRH+JiFEPq2PeYyni4PsX4MnPDz2zVT6EOIvlVLq8mgLibz3Cwko
 lKMc7p67kEOrgr9+ntfUFJi0bK0SQbHzRTHKWjJr6d/D/wFRelUxAYVwV3JSLOg4qmrX
 GDmW1RAaxecw4b8/JPI0Dol6Nf5eP/1mXz0dpKitt5iYS7AfEkPhKdO7vTnst+tr/kr5
 NO2Ldq7gpi/3xRT1qqOI03k9vdeZTrwcB4HJSeTslfVnppmTLUrJtt7SJfnK9ACkcruQ
 PdMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpTrhPogUxa30z5SIVbKLr6gw8oNarix9wd+d050WJ3JGrFJvZv+i1AU9ey3YFYTZJf4J/u84=@lists.denx.de
X-Gm-Message-State: AOJu0YwYtSGcNFuEp6N/WGUn3pMrv/qqg5a8xoCMts9zxyYsXa3lmgCW
 26SqS5kapxFODOU2Zn0zaNywQvO8Xm/wKO6sFeauNnsVV+jDTnOBLFOkc3TnIMOW6F016cE0csK
 I1fzPRP+Lx8WHZeJJgsQ8EFNUl0w=
X-Gm-Gg: ASbGncsy1/+/KTZD++JPQg2rLLKb8GVrkpYkY230A04Y7yrcHjiU7DH72gOLHj5oJlx
 7LRA7XlV0NILN6InHkTUTu/Zm/kfr1V3i2/hhxPaWbWlqUSjHl5VqRHEiSO+/7BUmn6a1SuNzk7
 wJL2fuzd+ExbrrR2VsTFgAknmoyUBntT409pZbqwsd4wb5W4MQ0PA8Bg==
X-Google-Smtp-Source: AGHT+IHjla54owrfbYnxIwwwWmfZTeQJoH8cigna4hm5y2TSKvc2ib+9XP4RbDkXyq6JX0A/CXUOuiI83SfLxrkKuso=
X-Received: by 2002:a05:6512:3d0d:b0:54a:cc25:dbe9 with SMTP id
 2adb3069b0e04-54f9f8732c1mr1707158e87.26.1746448110924; Mon, 05 May 2025
 05:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTgF+g2OXz=L=r7rOQcNkk19GfdCrwixG8ZAsR=1rh9Fqw@mail.gmail.com>
 <f1e4014e-658b-4a47-af8d-72ef76c1b134@denx.de>
 <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
 <f71762e5-ba15-43ec-91a3-dbdc8f8e1437@denx.de>
 <CAFLszTj69OUZj9ZBcmnsiLLvxCB+Y-rJYEW_Ep8V6WFtvXP2Nw@mail.gmail.com>
 <5bec35cc-99b9-468e-bc01-1de5dc39825c@denx.de>
 <CAFLszTh3weO+4bFuaRGR9-1zMU57R+Xcn2UVOMY9=JAtpfZgnA@mail.gmail.com>
 <CAOMZO5ARze74UsOqUbMLfsyjfFcpBQ38hgqTZnrP4ZkqNOZiTQ@mail.gmail.com>
 <0261fb66f34d30c6fc3ea1995bf23d4a055dfb6b.camel@phytec.de>
 <CAOMZO5BtELcioQPygHGx6rsRmFvxeStn-PFf3B22BeXkgUbepw@mail.gmail.com>
 <20250331183118.GL93000@bill-the-cat>
In-Reply-To: <20250331183118.GL93000@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 May 2025 09:28:19 -0300
X-Gm-Features: ATxdqUGcLXhI2VafIv2TByJ3gVHL-AvBAPogUE-GsrRn-EdzVlRz9VU_AeS6vg8
Message-ID: <CAOMZO5ARjb5g4q6xATR8snQ8OJQnQBWfPQsUqUFEX=62=F3-pw@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Tom Rini <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>
Cc: "sjg@chromium.org" <sjg@chromium.org>, 
 "brian.ruley@gehealthcare.com" <brian.ruley@gehealthcare.com>,
 "ravi@prevas.dk" <ravi@prevas.dk>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "paul.henrys_ext@softathome.com" <paul.henrys_ext@softathome.com>, 
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Leonard Anderweit <l.anderweit@phytec.de>
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

Hi Marek and Tom,

On Mon, Mar 31, 2025 at 3:31=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> And make similar changes to .azure-pipelines.yml as well please.

I made another attempt and still get CI errors when applying this
patch. zstd is not found in CI:

Starting build...


    0    0    0 /1       -1      (starting)


    1    0    0 /1              tools-only
Completed: 1 total built, 1 newly), duration 0:00:15, rate 0.07
Fetching tools:      bootgen bzip2 cbfstool cst fdt_add_pubkey fdtgrep
fiptool futility gzip ifwitool lz4 lzma_alone lzop mkeficapsule
mkimage openssl xz zstd
Fetch: cst
- trying method: binary download
- trying method: build from source
- clone git repo
'https://gitlab.apertis.org/pkg/imx-code-signing-tool' to
'/tmp/binmanf.rgn_6enh'
- build target 'all'
- writing to '/home/uboot/.binman-tools/cst'
Fetch: zstd
- trying method: binary download
- sudo apt install -y zstd
Exception: Error 100 running 'sudo apt install -y zstd':
WARNING: apt does not have a stable CLI interface. Use with caution in scri=
pts.

E: Unable to locate package zstd

- trying method: build from source
- failed to fetch with all methods
Already present: 16: bootgen bzip2 cbfstool fdt_add_pubkey fdtgrep
fiptool futility gzip ifwitool lz4 lzma_alone lzop mkeficapsule
mkimage openssl xz
Tools fetched:    1: cst
Failures:         1: zstd
/usr/lib/python3.10/os.py:1030: RuntimeWarning: line buffering
(buffering=3D1) isn't supported in binary mode, the default buffer size
will be used
  return io.open(fd, mode, buffering, encoding, *args, **kwargs)
/usr/lib/python3.10/os.py:1030: RuntimeWarning: line buffering
(buffering=3D1) isn't supported in binary mode, the default buffer size
will be used
  return io.open(fd, mode, buffering, encoding, *args, **kwargs)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Ru=
nning binman tests =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
.....................................................s....s................=
...........................................................................=
........................................................E..................=
.........Image
'file2' has missing bintools and is non-functional: openssl

...Some images are invalid
...............E....................................E......................=
...........................................................................=
...........................................................................=
...........................................................................=
..............................................
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: binman.ftest.TestFunctional.testNxpImx8MCSTFIT (subunit.RemotedTestC=
ase)
binman.ftest.TestFunctional.testNxpImx8MCSTFIT
----------------------------------------------------------------------
testtools.testresult.real._StringException: ValueError: Error 1
running 'cst -i /tmp/binman.ykmpnh27/nxp.csf-config-txt.nxp-imx8mcst
-o /tmp/binman.ykmpnh27/nxp.csf-output-blob.nxp-imx8mcst': File not
present SRK_1_2_3_4_table.bin


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: binman.ftest.TestFunctional.testNxpImx8MCSTMkimageMissing
(subunit.RemotedTestCase)
binman.ftest.TestFunctional.testNxpImx8MCSTMkimageMissing
----------------------------------------------------------------------
testtools.testresult.real._StringException: struct.error: unpack
requires a buffer of 4 bytes


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: binman.ftest.TestFunctional.testNxpImx8MCSTSPL (subunit.RemotedTestC=
ase)
binman.ftest.TestFunctional.testNxpImx8MCSTSPL
----------------------------------------------------------------------
testtools.testresult.real._StringException: ValueError: Error 1
running 'cst -i /tmp/binman.nv01cfcu/nxp.csf-config-txt.nxp-imx8mcst
-o /tmp/binman.nv01cfcu/nxp.csf-output-blob.nxp-imx8mcst': File not
present SRK_1_2_3_4_table.bin


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: binman.ftest.TestFunctional.testCompUtilVersions (subunit.RemotedTest=
Case)
binman.ftest.TestFunctional.testCompUtilVersions
----------------------------------------------------------------------
zstd not available

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: binman.ftest.TestFunctional.testCompUtilCompressions
(subunit.RemotedTestCase)
binman.ftest.TestFunctional.testCompUtilCompressions
----------------------------------------------------------------------
zstd not available

----------------------------------------------------------------------
Ran 583 tests in 11.931s

FAILED (errors=3D3, skipped=3D2)

Full log: https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/112677=
2/raw
