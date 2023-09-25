Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C10DCE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 06:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05D4786B3A;
	Mon, 25 Sep 2023 08:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KaKm2bfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20F786B2D; Mon, 25 Sep 2023 08:56:11 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2391686B42
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 08:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-532aaba8747so6815709a12.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 23:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695624969; x=1696229769; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A+kaEtSk2j/X659WXLUI5+JpiEXzRzuA3Q3Q7XprXd4=;
 b=KaKm2bfEaTc2REZ35ixaqXUnqobETTMLmJAAhlkJB9xWVdVQ1ovvOLnSFzRMegPd7c
 jhJUzvT8dEnsQ7+tqS5vYoVi09PX8YefAXhCjvXwTr7PQm+MDCvQJof5bPKJZQ/9SeYr
 6/ghwEmqkrnNXEAxQfUwWWJc53q9h9amnr5M+TssgbH0ElkPmyLemFEAAv+m3svthV9s
 xOXvaCNpSGqYaf4bakXPf0oMqgs2s1Sh25K0yN3UhWCA0mfmN59MB9Whn3ndNAEv0rk9
 JO0v9bMUFj7IRDjNbmu9QRJPZtKmolz3pGXhsH3XqtJxcntvoM1HEN9MrQshc844QC10
 EWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695624969; x=1696229769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A+kaEtSk2j/X659WXLUI5+JpiEXzRzuA3Q3Q7XprXd4=;
 b=MOYX2CEFZmpHZZHz9Ff4mCi3Yz1L1oMN9ASkPxFjv+GHxkPqlBaOipDRyAGFnNJmVz
 Y1Cuq46SuLosvoG96zM4v1E1fAIoob5VV648WRClYYfAjtgha0x/A5SHKmR/lVZDH8DZ
 R/g+HRMy3kOVtCyXsTNZxxSya64qEwgSI1xR7oAF4opEkqit1ofXBgNr6iaFRFG1/v7h
 +5OBc940iCbq1czPaw02JD96gOHqbiqfdWI114bwam9D7EsyKdmdPF+5z7bWy+qKuK06
 RMXozwU+t0AaRsgKWg4oPl0UtaIKBgQXtoylVPqJraZeXwE3VurHzAeQtG8v8qr52OKd
 1s4A==
X-Gm-Message-State: AOJu0Yx8WiA0RN/3dJFRc73iRwFF8jUzSAj5grIykXzJlNRo2MiNMpKJ
 /AHgP9puEiLnbS2URlVH3aNvBambngUTzqoQicZ8jGV07zNbJjGE
X-Google-Smtp-Source: AGHT+IGJVU+YWxMA6rVDbWu2AHUYNaQgKLQ4uT7AkJNkFpwclJ+nh5DTsvxFlZdDmzz5abXabId+Y5Qs35tmZ5UUdjI=
X-Received: by 2002:a05:6402:150d:b0:530:8801:47aa with SMTP id
 f13-20020a056402150d00b00530880147aamr4833419edw.19.1695624969655; Sun, 24
 Sep 2023 23:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5Lu8PxCp8_vL9cuUPWdMWqDcbnVOpDrTN=1zy=HwSX2=6ofA@mail.gmail.com>
In-Reply-To: <CAE5Lu8PxCp8_vL9cuUPWdMWqDcbnVOpDrTN=1zy=HwSX2=6ofA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 25 Sep 2023 12:25:58 +0530
Message-ID: <CADg8p95ie7HpmXuYNhJJJK0muvwdYZFggaotw=m=aERfQx0o3A@mail.gmail.com>
Subject: Re: bootefi with initramfs
To: Song Sam <samsong8610@gmail.com>
Cc: u-boot@lists.denx.de
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

hi,

On Fri, 22 Sept 2023 at 16:40, Song Sam <samsong8610@gmail.com> wrote:
>
> Hi all,
>
> I am currently in the process of booting the Linux kernel using the U-boot
> 'bootefi' command. However, I am facing an issue with the root file system
> (rootfs) disk, which is not functioning properly. As a solution, I am
> considering providing an initramfs to the kernel.
>
> The problem I encountered is that the 'bootefi' command does not accept an
> argument for the initramfs, unlike the 'bootm' command. Upon further
> investigation, I noticed that the kernel attempts to load the initramfs
> from the EFI tables. However, I have been unable to find any information on
> how to define an initramfs table for EFI.

You can add a boot option using the efidebug or (I think) eficonfig
command. The boot option includes the path to the initrd. You can add
the boot option through the 'efidebug boot add' command. Check the
code in cmd/efidebug.c or 'efidebug -h'. Once the boot option has been
added, you can boot with the 'bootefi bootmgr' command.

-sughosh

>
> I would greatly appreciate any suggestions or guidance regarding this
> matter.
>
> Thank you,
> Sam Song
