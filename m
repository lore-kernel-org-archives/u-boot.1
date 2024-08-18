Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5775CC52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 15:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D6C88955;
	Sun, 18 Aug 2024 17:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gqiJa9hm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB41C88931; Sun, 18 Aug 2024 17:25:51 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A616788744
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 17:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6bf9081b650so5318476d6.3
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 08:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723994748; x=1724599548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Iv6v7LsxwTVihpuE/MV+TnQ9XKrVqqHZGINrp2yMlH8=;
 b=gqiJa9hmgQ3KHb35FTNokv0519hJoRaGJBwGV5ksSSrdx/xWHPypWFLzOyyrLXkfjT
 MGdGOgMXP0HSsVTsW1F7khFC6zvSmikWSVy8PLB/uTx3xmRKGQx1ivGkcm3kpwbSNn2c
 /eO9eG9FZhEyJS0nNzD9ShdO6bFETO4uYoFZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723994748; x=1724599548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iv6v7LsxwTVihpuE/MV+TnQ9XKrVqqHZGINrp2yMlH8=;
 b=ugi0ZPx8i5UorDxf1PE1mmIOZkSDkYudCXVE+g4So+lrw1x4mQqAQOJ0ex8xWKHRak
 k3ub4pJNEKAw44MnBVJMCR06DXTE2wA+spllR5PDuRqHskAi94b9GMMPycW51/GNjq8M
 y++3vRmaGGyvEkvYon1TbwNJzW5EBkagdnfXYV7k2bp/pPxEv3zcc+lVPB3SUCHlFnnc
 4uAZPltT+FL8cT8F13vLW1iPoMCVBuoqwW3iiDopryWaA9jzcQz/0Khl4zDbzKjIOVKE
 X8Zs0258xIPu6E/uUZaX786sw2w5tYSE5hzDYwrwrslmfaBLpKFA6NlPb6obfG4cjG2D
 XHVg==
X-Gm-Message-State: AOJu0Yx3osKYgdZ9wfnpDbAQUMFMgQaNkXhnnbLyex0XamiSYqwAf0nr
 zt78YEcacgTN4oh/BQ5yBZ2m2aSl6r/jNP3SNiNvfzILsfc5ys1MQF5bjX0g/iUupSJQUhCFefq
 mIWj0LutJ8Ib+E5d3VVfCgBWT21MaQWlYp2kn
X-Google-Smtp-Source: AGHT+IFyK0hQ2B9pZc8TGLc2f87uBrV3/slpEVdIcgoyMGpHLTS9Zf4VEn9B/46Q7E+JN2ugRWqCZ7WgeHcChfHnJ/8=
X-Received: by 2002:a05:6214:5788:b0:6bf:940d:2875 with SMTP id
 6a1803df08f44-6bf940d2e2emr41965126d6.45.1723994748466; Sun, 18 Aug 2024
 08:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240802093322.15240-1-richard@nod.at>
 <20240815221418.GA3500277@bill-the-cat>
 <1796341.KUTt5R2Mg1@somecomputer>
In-Reply-To: <1796341.KUTt5R2Mg1@somecomputer>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 18 Aug 2024 16:25:37 +0100
Message-ID: <CAFLszThjZKm+=J2oBGeTUYt_fZxbu5KXzGYXXJnnuXaCD2322w@mail.gmail.com>
Subject: Re: [PATCH 1/3] test_fs: Allow running unprivileged
To: Richard Weinberger <richard@sigma-star.at>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Richard Weinberger <richard@nod.at>, upstream+uboot@sigma-star.at, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>
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

Hi Richard,

On Sun, Aug 18, 2024, 03:11 Richard Weinberger <richard@sigma-star.at> wrote:
>
> Am Freitag, 16. August 2024, 00:14:18 CEST schrieb Tom Rini:
> > This brings two new pylint errors:
> > test/py/tests/fs_helper.py:47:12: E0704: The raise statement is not inside an except clause (misplaced-bare-raise)
>
> This raise was on purpose, I wanted the test to fail when an unsupported filesystem is used.
> I have changed it to an assert 0.
>
> > test/py/tests/fs_helper.py:78:4: E1120: No value for argument 'src_dir' in function call (no-value-for-parameter)
>
> Fixed too.
>
> But I'm still wrestling with the Azure pipeline.
> After wasting^wspending a full afternoon, I think I know what is going on.
>
> With my patches applied, it always failed like that:
>
> ___________________________ test_ut_dm_init_bootstd ____________________________
> test/py/tests/test_ut.py:234: in setup_bootflow_image
>     u_boot_utils.run_and_log(cons, 'mkimage -f auto -d %s %s' %
> test/py/u_boot_utils.py:181: in run_and_log
>     output = runner.run(cmd, ignore_errors=ignore_errors, stdin=stdin, env=env)
> test/py/multiplexed_log.py:183: in run
>     raise exception
> test/py/multiplexed_log.py:141: in run
>     p = subprocess.Popen(cmd, cwd=cwd,
> /usr/lib/python3.10/subprocess.py:971: in __init__
>     self._execute_child(args, executable, preexec_fn, close_fds,
> /usr/lib/python3.10/subprocess.py:1863: in _execute_child
>     raise child_exception_type(errno_num, err_msg, err_filename)
> E   FileNotFoundError: [Errno 2] No such file or directory: 'mkimage'
>
> This makes little sense because I'm not touching mkimage nor PATH.
>
> It turned out that without my changes, mount_image() always fails
> inside the Azure pipeline.
> So, in setup_bootflow_image() the whole try/catch block around
> image creating, mounting it, etc.. fails and it always falls back
> to the prepared image via copy_prepared_image().
> The log print('Falled to create image, failing back to prepared copy: %s', str(exc))
> is never shown because the test itself succeeds.


> My patches change the tests to work without root privileges, so mount_image()
> is no longer needed and no exception occurs.
> As a consequence, mkimage is used the very first time on the Azure pipeline via:
> u_boot_utils.run_and_log(cons, 'mkimage -f auto -d %s %s' % (inf, os.path.join(scratch_dir, vmlinux)))
>
> To my best knowledge, u-boot-tools are not installed in the docker image,
> nor does the test framework install mkimage.
> So, the failure is expected.  Running test_ut.my manually always worked
> within my test bed because I had mkimage installed.
>
> So, can we please have mkimage inside the Docker image?

Sorry about all your trouble. Perhaps we should add a comment about
specifically what the code is for. Also, once you get all this in, we
can perhaps remove the fallbacks. I still get errors from qemu-img on
Ubuntu unless I chmod a+r /boot/* but presumably you don't use that
tool.

For mkinage, it would be better to use the version that is built in
CI, for sandbox. That is how the tools tests work.

Regards,
Simon
