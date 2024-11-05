Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2ADD2C122
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F374891CD;
	Tue,  5 Nov 2024 16:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fO5Aaftz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C2F891C0; Tue,  5 Nov 2024 16:12:58 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AA188F77
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9eb3794a04so133572566b.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730819576; x=1731424376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n8QzA9QkjCBHb04VNsEiRjbHPUJgqDo7VL8DaXgDkCk=;
 b=fO5Aaftz2ghlxzk7NwXYkfn1vhdwmz+mskGrP6mrQfqmorSafnq+TjHtZ6ax4g07+j
 HZkCnCk5mGxzH1HnbVUouCQnlAOrFOAqXyDYx/rwyWo9vJtyjNg9LlR0scV3CszdM2Tv
 V2hzJ7IhbbOcAR6ckxqnxN2iINgXiCMywmxbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819576; x=1731424376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n8QzA9QkjCBHb04VNsEiRjbHPUJgqDo7VL8DaXgDkCk=;
 b=sJu+H6gGJxtmfbTkjq6X/54tPi287EicyO4fzPTibbODk4uVffkYwwgB9AKzbgYNmn
 cmzYslIH3qLwvlTQmS6L8LF5oMzLjH6XstUzygdWbXmWLZD2+A+MwT2l/kdhkSHE4quj
 8dDSvQmwU2EefyVnc0NG8srLclgdvBjdUR6BT3vBPeiGbWbWRvyAsjUDl+YOnBLZaN/Z
 0NqRl5mp/WqBsG6JIEvDtyZsbtMkO+ol0uvcAcD9vMi2p8/o72uAwrtG0RhXcLt05N/U
 DzyODXcvDBai6EAlNefQTqcAOQSwYhR6425dQqhzzajx8abg5sB/AYYS2W1qAGOc5cZE
 E2hg==
X-Gm-Message-State: AOJu0Yx9Kr1X43ESPOImm5oiRh7gVOPaeL8YBTRpp3niYN/IVgc8mgeQ
 KqIhaF5rQn0h1WEmdlcAoR93d5ylx1waZBagWyIAVmAW/yVEmhbwxbLpfcT7R9WpL/vTErBKcgj
 eBOW7AD46flcdFmIlg1bSoFapXpoy/1RJ+NEm
X-Google-Smtp-Source: AGHT+IE7NDMlnpb0uY8DVjTO9kKK+srSfadC4LE6Y64zj3/6dNWAk02gC04odACrUFUzE8reoGSNdN7RKx4ltuEynb4=
X-Received: by 2002:a17:907:74d:b0:a9a:1792:f05 with SMTP id
 a640c23a62f3a-a9e3a620de8mr2396810666b.31.1730819575969; Tue, 05 Nov 2024
 07:12:55 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTi9XE8oHuZCYrj85UVXVEYFDomqK=KrO5E-fTAn9_f=0w@mail.gmail.com>
 <f3b65417-d35d-49c7-95de-b1db7b283e11@linaro.org>
In-Reply-To: <f3b65417-d35d-49c7-95de-b1db7b283e11@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 08:12:43 -0700
Message-ID: <CAFLszTgh1QbrirTi_zG7upVHG7OqHxStRFFAVRCEsPqkQpAMmg@mail.gmail.com>
Subject: Re: wget bug report
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Jerome,

On Tue, 5 Nov 2024 at 05:12, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hello Simon,
>
> On 10/27/24 17:16, Simon Glass wrote:
> > Hi Jerome,
> >
> > Just something I noticed earlier...when running 'ut lib' I see this
> > failure on sandbox:
> >
> > test/cmd/wget.c:215, net_test_wget(): 0 == run_command("wget
> > ${loadaddr} 1.1.2.2:/index.html", 0): Expected 0x0 (0), got 0x1 (1)
>
> The reason is:
>
> $ make sandbox_defconfig
> $ make -j$(nproc)
> $ ./u-boot -c "ut lib"
> [...]
> Net:         eth_initialize() No ethernet found.
>
> I don't know how sandbox is supposed to instantiate ethernet devices?

If you try it before your changes you will see what it is supposed to
do. There is a sandbox network device and it can be used to send and
receive data within U-Boot itself, for testing purposes.

>
>
> > Also, since it is testing a command and is in test/cmd it really
> > should be in the 'cmd' test suite, not 'lib'.
>
> Agreed. I've posted a patch for that:
> https://lore.kernel.org/u-boot/20241105120653.99438-1-jerome.forissier@linaro.org/T/#u

Thanks.

Regards,
Simon
