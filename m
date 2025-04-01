Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDABDC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 11:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281CA81FFC;
	Tue,  1 Apr 2025 13:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YyNm/7Wj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A62C82040; Tue,  1 Apr 2025 13:13:05 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F7080050
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 13:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-30de488cf81so29847721fa.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743505982; x=1744110782; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQ8AypfbhW8BLi8fO8XcXGRYg+cTRbswLEX0rNPkMpc=;
 b=YyNm/7WjETxlWlO0Fp3Lwfcjkf+riJzwPXzfvc2+IhQy/tmOxl5hoywDGHMGDnFHvr
 5oGp5Fwnojem72V2zoBZAQTsmfAc9Iplp2EAWvNDgDihupIl6fI9GqppdXCP+Tv2ab58
 ahSawJ/p1/OYlW3kUdrzoujQjSKD7VV81WVjnWx6YvRCEPtmx2TNQd79sXksZE4Mytd6
 oglHGqxnjKsdoN2Rshsv80P/MhF1SbWjonhezexqF9VK0ax3FDoXwPxiGrKQXrpf/gkO
 c6QO2Ef2UavJpdA6/dJ2AzfZysCRtvLZ3JQ4ZxBstyKfAEUQamYhCqJufjwktU3wnnPF
 dItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743505982; x=1744110782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQ8AypfbhW8BLi8fO8XcXGRYg+cTRbswLEX0rNPkMpc=;
 b=pAsyuYgC6nbnH3U65vIKE2jOH8GHLkZuHXIqEWs1nBHARtBYC1/E0Slavtd5Y4vxI4
 0kly/plWExNGu2ZIj2c7ez3uFFB8WTd1o/j0z5/odlp4oShpi07zh7qYFGpL+9sgdK/N
 g5FFmPhd2vjoOvog0F5AHeFJM40UOiMC9bAt9rt+/F126nSP5JuJVzmhgpnT5OZUgYKK
 vN2Gj0hUE3d0hXnZnzt+cTS0sU1f98e10mFe1JhshE1rPJhvkCp4/16I0bYteP5TR32f
 THQj59YtdizF/nr6tqJ33bON+Z8xuevRmuqL80Dk1sANWsVRgst+y87YGDAU1toNqsIu
 545A==
X-Gm-Message-State: AOJu0Yy5XLmxU5I3PNv0YrFa0KWTup+TemEGz9T6aw3Nz8dPjdEyREhn
 eryswiJANX8LwzsXQX9jiroUdSiDfghczWVylgq9VZdjBvVqo2briPN8Ilf6EcqMQx+1G27j4Qp
 CPrdnz7VkZSSpEUu09xhNkMfIGjU=
X-Gm-Gg: ASbGncvngsS6Mm9RSIr+J8N4/bcLlb48ewOEhKh1HNF04J6m6/Kk3Am1WU93GBdVpQn
 Db8ld4W9v12jRGip2Sd+BK6UtL+PAhzn/2qLTC7H8jInVDF56gLeA+Pz0nEZ8O9QwXYL7cnQPUN
 KUB8vd/HASLy3ELarzYSTbcZ4xjp/XcIAiR/sAp0NQMX91yekWoYbq1zaP
X-Google-Smtp-Source: AGHT+IFPO4zAgpBncBsKY/yK5EMghaZisryxVf4wcPrsgao0xTjGeM3YG1bd2XO3FGgwSzh5VoQEkkR+J/4usbqbRBU=
X-Received: by 2002:a2e:be13:0:b0:30c:11ef:98ea with SMTP id
 38308e7fff4ca-30de024965fmr35403911fa.15.1743505982003; Tue, 01 Apr 2025
 04:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250401084642.216933-1-l.anderweit@phytec.de>
 <20250401084642.216933-2-l.anderweit@phytec.de>
In-Reply-To: <20250401084642.216933-2-l.anderweit@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 1 Apr 2025 08:12:50 -0300
X-Gm-Features: AQ5f1Jq1kF9CZpvqkxkrT7tdopuaB-1bNqZuHZO9S7AppgNOkJLZYl28zN9Z42c
Message-ID: <CAOMZO5AzKUUt3YpVWteiwb-DaqPdBjxXKwhXOo_5aZtacpkXzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] CI: Build missing binman tools before binman tests
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, marex@denx.de, 
 upstream@lists.phytec.de
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

Hi Leonard,

On Tue, Apr 1, 2025 at 5:46=E2=80=AFAM Leonard Anderweit <l.anderweit@phyte=
c.de> wrote:
>
> The CI image does not ship with all tools required for the binman tests.
> Have binman build the missing tools.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>

I applied this series with Marek's patch on top.

I get the following CI error. Please take a look:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1084138/raw

Starting build...


    0    0    0 /1       -1      (starting)


    1    0    0 /1              tools-only
Completed: 1 total built, 1 newly), duration 0:00:20, rate 0.05
Fetching tools:      bootgen bzip2 cbfstool cst fdt_add_pubkey fdtgrep
fiptool futility gzip ifwitool lz4 lzma_alone lzop mkeficapsule
mkimage openssl xz zstd
Fetch: cbfstool
- trying method: binary download
- downloading: https://drive.google.com/uc?export=3Ddownload&id=3D1gxNxRuJg=
D0Iiy9LAPCSB_0959eJCp98g
         0 MiB  [  4%]                                 0 MiB  [
9%]                                 0 MiB  [
14%]                                 0 MiB  [
19%]                                 0 MiB  [
24%]                                 0 MiB  [
29%]                                 0 MiB  [
34%]                                 0 MiB  [
39%]                                 0 MiB  [
44%]                                 0 MiB  [
49%]                                 0 MiB  [
54%]                                 0 MiB  [
58%]                                 0 MiB  [
63%]                                 0 MiB  [
68%]                                 0 MiB  [
73%]                                 1 MiB  [
78%]                                 1 MiB  [
83%]                                 1 MiB  [
88%]                                 1 MiB  [
93%]                                 1 MiB  [
98%]                                 1 MiB
[100%]


- writing to '/home/uboot/.binman-tools/cbfstool'
Fetch: cst
- trying method: binary download
- trying method: build from source
- clone git repo
'https://gitlab.apertis.org/pkg/imx-code-signing-tool' to
'/tmp/binmanf.enbq4kln'
- build target 'all'
Exception: Error 2 running 'make -C
/tmp/binmanf.enbq4kln/code/obj.linux64/ -j 40 all OSTYPE=3Dlinux64
ENCRYPTION=3Dyes': make: byacc: No such file or directory
make: *** [../build/make/rules.mk:47: cst_parser.c] Error 127
make: *** Waiting for unfinished jobs....

- failed to fetch with all methods
Already present: 16: bootgen bzip2 fdt_add_pubkey fdtgrep fiptool
futility gzip ifwitool lz4 lzma_alone lzop mkeficapsule mkimage
openssl xz zstd
Tools fetched:    1: cbfstool
Failures:         1: cst
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
...........................................................................=
...........................................................................=
...........................................................................=
.................E.........................................................=
..............................................................Image
'image' has missing bintools and is non-functional: cst

Some images are invalid
...........................................................................=
...........................................................................=
......................Image
'image' has missing bintools and is non-functional: cst

Some images are invalid
...............................................
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: binman.ftest.TestFunctional.testNxpImx8MCSTMkimageMissing
(subunit.RemotedTestCase)
binman.ftest.TestFunctional.testNxpImx8MCSTMkimageMissing
----------------------------------------------------------------------
testtools.testresult.real._StringException: struct.error: unpack
requires a buffer of 4 bytes


----------------------------------------------------------------------
Ran 581 tests in 8.717s

FAILED (errors=3D1)
