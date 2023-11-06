Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C83CC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F028701B;
	Mon,  6 Nov 2023 21:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RQdn+iXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DEB08708B; Mon,  6 Nov 2023 21:43:19 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82AB68701B
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507d1cc0538so6628245e87.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 12:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699303392; x=1699908192; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cvoOMKpRIylYQoKudHwPbM15xksYg3taFhrhbLrpJEM=;
 b=RQdn+iXGEAUSfNbzu4YtlZmFm/bTduH//oe24mV2Jd0V79qQgHXgD6P3pjSWnJEz+C
 /RZLzJ5Sa0NGJ22NIoD6dn40v01o5HOHQpm8j3qkKq3vNu0K0bVdibgb/PcWlxQL35Xc
 KBBW+MMBHFAgrK3xVBjFYUwWbZ97FJCOMZLGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699303392; x=1699908192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cvoOMKpRIylYQoKudHwPbM15xksYg3taFhrhbLrpJEM=;
 b=b9qugny4v94/HR4g1yrIqq6CVYqU4EdcpQXmMNwNKwnm/VLsQlTqQKMPbz+kPElx+Y
 4f/c433CvRP0ZDbZkockNOA1ZXI0rfVsLp/cnDzXVnMGUJ7nlMWE63Drwb0Wa8uTfUcW
 WSlj7p+8HJS+vwWPISH5GyfGgCg9iTdbmSHz3jdEyJ6RUvfwFV/tpfwk7oyraiviQXw1
 CNFTAfBF5XM7hpVn0gTsuPzkXKnWr9w5EE1TsQDBUBnOxHnyleLHTvcdW6RrY+VjucO1
 thfvMOHyWhhfyg+9L/1Irj6r4PmjeB5/RKc2Pk6yps0uDaI113wpxBJzDdjPzrQcUolm
 g3HA==
X-Gm-Message-State: AOJu0Yw3iE+LW8FPrzTbjaeCfB0UrsvnIJ8OJPpL6NpL6SCckkyimXqD
 Iaj0rXWjtt5V1tcZZrunvZHwd1QyJ1/LJZkB0kyPcw==
X-Google-Smtp-Source: AGHT+IEmgYwIYr7mZtghDqDPJYck6vLb3EE/mkMiME5RSm7VH+VnUVoCl4CqTkmCCv307Pt6amuAFMrWDF/VL8iE03M=
X-Received: by 2002:ac2:52b4:0:b0:507:a229:f53e with SMTP id
 r20-20020ac252b4000000b00507a229f53emr19860671lfm.24.1699303391265; Mon, 06
 Nov 2023 12:43:11 -0800 (PST)
MIME-Version: 1.0
References: <bf1e575239af2f0dae872543dbc4f9974c618c95.camel@physik.fu-berlin.de>
 <CAPnjgZ0zjD+vrsyHkRpAzatZvA7Cv5-9Q+96O1mUN0Ei4H70uw@mail.gmail.com>
 <891544b36a1a9a1cd62345f341828c144e7f1ec6.camel@physik.fu-berlin.de>
 <CAPnjgZ35bJSBE_HqVxh_fb42AYm+vYmx-oyaDQzXqcsmqFvHxA@mail.gmail.com>
 <1b27e5f825851f6a3c0c198c0b42e50bc36f67b8.camel@physik.fu-berlin.de>
 <CAPnjgZ1PmHzB1jYRwjDUiUAydSvS=-Q50mzDLdHROr2xA1NYWg@mail.gmail.com>
 <60c58204161b27c044b19a657a3270e77519fafa.camel@physik.fu-berlin.de>
In-Reply-To: <60c58204161b27c044b19a657a3270e77519fafa.camel@physik.fu-berlin.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Nov 2023 13:42:59 -0700
Message-ID: <CAPnjgZ3Xk87GOYXaUZNPE7wjDi4fGim5zZCt0H_QW=THTPJyKQ@mail.gmail.com>
Subject: Re: Need advise with u-boot on SH-7785LCR
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Marek Vasut <marex@denx.de>, Vagrant Cascadian <vagrant@debian.org>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

+Marek Vasut <marex@denx.de>
+Vagrant Cascadian <vagrant@debian.org>


On Mon, 6 Nov 2023 at 10:33, John Paul Adrian Glaubitz <
glaubitz@physik.fu-berlin.de> wrote:

> Hi Simon!
>
> On Mon, 2023-11-06 at 10:24 -0700, Simon Glass wrote:
> > > So, I assume, I should just be able to write u-boot.bin to
> /dev/mtdblock0?
> >
> > Maybe, but you will likely brick the device if you have no other way
> > to write to flash.
>
> The flash memory is actually on a daughter board that can be easily
> replaced
> and I have multiple of these daughter boards. It turns out that just
> writing
> the image to /dev/mtdblock0 works and I can boot the board into the freshly
> flashed u-boot version.
>
> However, the u-boot version 2019.01 built from git won't work while the old
> 2014.01 version that I copied onto disk from /dev/mtdblock0 does work when
> flashing it to a second daughter board.
>
> So, flashing works indeed like this and I can successfully start u-boot
> after
> flashing it into /dev/mtdblock0. Now I just need to figure out what the
> difference
> between 2014.01 and 2019.01 is and why the latter doesn't work.
>
> I have uploaded both versions here:
>
> > https://people.debian.org/~glaubitz/u-boot-sh7785lcr/
>
> Maybe someone with more experience can spot anything obvious like incorrect
> address offsets etc.
>
> PS: I'm actually called Adrian, despite the long name ;-).
>
> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
>
