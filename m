Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32900D16819
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A548430F;
	Fri,  9 Jan 2026 12:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l6rm2LjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BCE884332; Fri,  9 Jan 2026 12:45:40 +0100 (CET)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A55CF8430F
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-12056277571so4556731c88.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767959136; x=1768563936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DOcqy4Hb+9tL/jaqqGx6XoXfZ8rDhu2JpFt27QrIY0c=;
 b=l6rm2LjGX68q4KQeRKW3EKDaGIUobHoQCv2M8A8eD1VgivvKeBpIuop8C+sk52RMQV
 dsOayGLBN7caSURHZApetPiXisFOiWmlpFjnqstzCOXEL5GPeYj/ai6c7y9q9HTzeseJ
 aqUEt/zdKOV60fiyayymzIg2u7wKrzTJvFMjF6dFKhL793lcSo2R/IQ0hIYGdLfRKNo0
 c8SszW8937LfvBFEJ7swBRf+/TONlysTusWzlBhvT6tIzPN8heVRj1SN2Y09SkotRmxD
 XlvMvQByEtBVQJ9DDbjgQmvXkxbxsrIohD4QMiy5p/oEhkbIvUMoNxNcqFVf0mrUGBu2
 u7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767959136; x=1768563936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOcqy4Hb+9tL/jaqqGx6XoXfZ8rDhu2JpFt27QrIY0c=;
 b=Z1v1fhr5BAJNmaNW1qXQ9xhBSwg8t40a03l3yucFeca7G+BDwLFoSdh5Rstj5PTHQb
 iWj7noRJ6AMRtiMS5YSnI5kylFG01v7dEzJ6soN4I/1gmMz/LzDvWHAsAxEpqpXt3NiT
 vWBxraYNbRsM6CAbQj3dJa+tOMKa70AwwC4+ShZUXoMV4dbvDXOm1p3oox4kYKRAioyF
 bVMHWFZN/90clw/b2k1neFl4nuDiInwMktBPMcyVMMBpMCJT0l3yh8FGEQeF3Wit35Kh
 qonjTMpiTLNExst8qhZtTgXeZix9UtoVGXfoVbFMnfsb/eemoxrjdwWiC3rpA+5JLm08
 wVEw==
X-Gm-Message-State: AOJu0YxbbJlTQ3cvpmaMMs80wm13lM5j0TvppJMKqYNOovhqDzrrCRw8
 xSae5pgjGhzyxv1X1ZK6ioR92cjyfj7gVk9S94YFk7HKTxqU9o97ULRyiVcJdahfrp6Ly/5tNuo
 o4cD4YX+MkmfdxK5omeekccPfJq/4020=
X-Gm-Gg: AY/fxX7yT/6Xz1WjV5K7O61FOAf5p8qV7kK7wbfmEalyHTjRg9vAfGl5Vn7xLP9PaHD
 rrtPxABJezuFs3x4A4uPwz58ax9LEiXdERDHr7PsJZ0CeyOjtJdf93KHkrySf89fcJP2jAckmK6
 Gtr9M5AP+jbnmJEgMQEdw6JAr7H2iu3mE6Xkr9neJtKFPkkzf2LuoJLwcUrqoRLb//GywSoDWvk
 bqc7z0qFuCw5UGJ4C1UHIeQvzRBy/wC55CDdAZ4dhU3SfRsdYEoHuVVMvCH/8/miMLoEmSl2AxX
 79t+qNMOc/z/c9ewAg4897NWDA==
X-Google-Smtp-Source: AGHT+IHspOnNG/J6hE8eHbbS+sFpQQLC20QdatsF8REBhlMPlhkMoCLj7TbdQQaxZrZKqvfbY7vpPWU3PTyBVDcKdcU=
X-Received: by 2002:a05:7022:3c10:b0:119:e56b:98c0 with SMTP id
 a92af1059eb24-121f8b8bd9cmr6114979c88.39.1767959135818; Fri, 09 Jan 2026
 03:45:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJs94EbyBnv=q6Gxp0WAhTRakxKm9xXgnriCVXQiycSem5qpCQ@mail.gmail.com>
 <CAFLszTgEMx7NZpTO0tTx72AMjZr_w=A787hhLT_YzHVTt=h7oA@mail.gmail.com>
In-Reply-To: <CAFLszTgEMx7NZpTO0tTx72AMjZr_w=A787hhLT_YzHVTt=h7oA@mail.gmail.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Fri, 9 Jan 2026 14:45:18 +0300
X-Gm-Features: AQt7F2ribv26rU7HetW1VtD-R1BiWOo1oG6qeL5ilsZlhORRsncfRA_IeHKGsvQ
Message-ID: <CAJs94EYXUdeAyGahUR-BPcnFTeYZvJLVSqxarD9kv-9KuMV87w@mail.gmail.com>
Subject: Re: FDT overlay: lost in the documentation
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

With best regards,
Matwey V. Kornilov

=D0=BF=D1=82, 9 =D1=8F=D0=BD=D0=B2. 2026 =D0=B3., 14:33 Simon Glass <sjg@ch=
romium.org>:

> Hi Matwey,
>
> On Wed, 7 Jan 2026 at 06:00, Matwey V. Kornilov
> <matwey.kornilov@gmail.com> wrote:
> >
> > Hello
> >
> > I have a board with SPI where U-Boot image is located along with
> > environment settings. The image is supplied with correct FDT, so no
> > additional dtb files are required to boot Linux from MMC. I.e. fdtcontr=
ol
> > variable is set up by U-Boot. Then EFI is used to execute Grub2 which
> > handles the rest.
> >
> > I've read
> >
> https://docs.u-boot.org/en/latest/usage/fdt_overlays.html#manually-loadin=
g-and-applying-overlays
> > but it describes mostly how to do the overlay loading manually. What I
> want
> > to achieve is to automatically apply FDT overlay from a specific dtbo
> file
> > located on MMC at each boot. What is the recommended way to do that? Wi=
ll
> > rewriting the bootcmd env with pretended commands work for me?
>
> We should really be using FIT for this. It is designed for this
> purpose and is a better solution than individual files.
>

Ok, I see. I just want to make some experiments on the table. So, my
concern about FIT is that I would need to reflash whole bootloader for
that... and then revert back. Isn't there less destructive way?


> Regards,
> Simon
>
