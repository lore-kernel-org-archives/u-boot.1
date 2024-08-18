Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF553C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 09:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44DD86462;
	Sun, 18 Aug 2024 11:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="keMU32fk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D6F580245; Sun, 18 Aug 2024 11:11:46 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BDFC888F0
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 11:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52efdf02d13so4688025e87.2
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1723972304; x=1724577104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQw65AqaPt2gEzxM6av0dFI7EsKzyjDqHU/rqMClQJ0=;
 b=keMU32fkWPjE6MVPRHbGHkmV0fSUPp1WrUYUfpjmuIMK+IyjVrHTpecqtJ1q19vl90
 YWUul/uL0MQKNb1WPv4aQFiSmeu4Wn1A5BS0v7bSpH7SU+ASR5yOwPistOA0pujmLv5x
 zYGd1OhkI8niqapzdCchqpc7szGnxu6ile+s0ZV0YxS/SRQly95UhF8vJYOK/z74/iuf
 AuTCab90KDMLuNN3dXVLcIZdOmSqKTUlc/nbsJK01TqFTsvIhrUIBIqM/G19b9XOMvBU
 /tqbAd8bfRoFev/fIcQQb1Q7PLwzpCiT4adFzyOwiuI8aDaq+3pgHoJrY81aYgGjQkC9
 /UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723972304; x=1724577104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQw65AqaPt2gEzxM6av0dFI7EsKzyjDqHU/rqMClQJ0=;
 b=Mp0y15z4N6U13MIm3haPcsRrHNQ9YFCVaWHFBm03SFNcvWvtb4TE2nIDXk6Ddl1+vj
 XqQlJFQSHZg3EbcinXJ5+qmWnqK6jGaP23I7qluNy9Mp4rsCrCMVQjJvVF1IabuPN9Gr
 6BJb4zfVmwxdG8C/wtX7E/pYQRmuhZDLvpIzVJbZ7D87PQWAdGDtRxQgLezpfDisYegV
 xrat0SrJXcE+HHfsFjJ1KA99d8UqcFafby5vb+G2k+WndSNNzwnGRbZveOaAi0J2JF38
 atwm36yA3hOXPbbdgxwM1xxjRB+mDEX7LbBFy6TH6fok2Hkxj6dOqpXYc5qhBXnArpCS
 aTNg==
X-Gm-Message-State: AOJu0YzavjHhKz8vzJSoPLDil4uJUaOIIAzUCjatFx7iBNGN6D16Yh9Z
 iBvxStiqH+rbg7fGVDKFToxNSMjruxSVndlDD6orbLmSfF+hJDydaLBkPPOzgdPs3N9dhk/7at/
 O
X-Google-Smtp-Source: AGHT+IGK/TuT4GCxAidYkYFtZpgmuMZVk4Kzm6vsWU0HHQ30kwqqDzf1BzLNLhUquSAtJ2qjI8SWGw==
X-Received: by 2002:a05:6512:114e:b0:52e:751a:a172 with SMTP id
 2adb3069b0e04-5331c6e3a7fmr6644697e87.49.1723972303083; 
 Sun, 18 Aug 2024 02:11:43 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383964976sm500698366b.188.2024.08.18.02.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 02:11:42 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Richard Weinberger <richard@nod.at>, upstream+uboot@sigma-star.at,
 francis.laniel@amarulasolutions.com, glaroque@baylibre.com,
 mkorpershoek@baylibre.com, sjg@chromium.org, christian.taedcke@weidmueller.com
Subject: Re: [PATCH 1/3] test_fs: Allow running unprivileged
Date: Sun, 18 Aug 2024 11:11:41 +0200
Message-ID: <1796341.KUTt5R2Mg1@somecomputer>
In-Reply-To: <20240815221418.GA3500277@bill-the-cat>
References: <20240802093322.15240-1-richard@nod.at>
 <20240815221418.GA3500277@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
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

Am Freitag, 16. August 2024, 00:14:18 CEST schrieb Tom Rini:
> This brings two new pylint errors:
> test/py/tests/fs_helper.py:47:12: E0704: The raise statement is not insid=
e an except clause (misplaced-bare-raise)

This raise was on purpose, I wanted the test to fail when an unsupported fi=
lesystem is used.
I have changed it to an assert 0.

> test/py/tests/fs_helper.py:78:4: E1120: No value for argument 'src_dir' i=
n function call (no-value-for-parameter)

=46ixed too.

But I'm still wrestling with the Azure pipeline.
After wasting^wspending a full afternoon, I think I know what is going on.

With my patches applied, it always failed like that:

___________________________ test_ut_dm_init_bootstd _______________________=
_____
test/py/tests/test_ut.py:234: in setup_bootflow_image
    u_boot_utils.run_and_log(cons, 'mkimage -f auto -d %s %s' %
test/py/u_boot_utils.py:181: in run_and_log
    output =3D runner.run(cmd, ignore_errors=3Dignore_errors, stdin=3Dstdin=
, env=3Denv)
test/py/multiplexed_log.py:183: in run
    raise exception
test/py/multiplexed_log.py:141: in run
    p =3D subprocess.Popen(cmd, cwd=3Dcwd,
/usr/lib/python3.10/subprocess.py:971: in __init__
    self._execute_child(args, executable, preexec_fn, close_fds,
/usr/lib/python3.10/subprocess.py:1863: in _execute_child
    raise child_exception_type(errno_num, err_msg, err_filename)
E   FileNotFoundError: [Errno 2] No such file or directory: 'mkimage'

This makes little sense because I'm not touching mkimage nor PATH.

It turned out that without my changes, mount_image() always fails
inside the Azure pipeline.
So, in setup_bootflow_image() the whole try/catch block around
image creating, mounting it, etc.. fails and it always falls back
to the prepared image via copy_prepared_image().
The log print('Falled to create image, failing back to prepared copy: %s', =
str(exc))
is never shown because the test itself succeeds.

My patches change the tests to work without root privileges, so mount_image=
()
is no longer needed and no exception occurs.
As a consequence, mkimage is used the very first time on the Azure pipeline=
 via:
u_boot_utils.run_and_log(cons, 'mkimage -f auto -d %s %s' % (inf, os.path.j=
oin(scratch_dir, vmlinux)))

To my best knowledge, u-boot-tools are not installed in the docker image,
nor does the test framework install mkimage.
So, the failure is expected.  Running test_ut.my manually always worked
within my test bed because I had mkimage installed.

So, can we please have mkimage inside the Docker image?

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


