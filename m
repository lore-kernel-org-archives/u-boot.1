Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C6BC47074
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 22:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC61E878A4;
	Mon,  1 Jan 2024 23:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c3dwI6Fu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C3A386FF4; Mon,  1 Jan 2024 23:41:45 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E62E877EC
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 23:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67f9ace0006so41510866d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 14:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704148902; x=1704753702; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6bA1p2Far7Rj48+oE9LcI61ueLR71wXVmfXYfy2pd8=;
 b=c3dwI6FunYdp6dzukruO57EzZylGp4tBCxnvwzDwQeXJUXu0VInsaWh3utmualC8fg
 ud/F+ZyzRPmAqtS3+9o2EpgL7st2+w8NqRgK+vkEb0DjmKAb5BzcqJDU7/NE3HCwlu0J
 7OKpLQLL32GruQkmu1sIs+H/bDppqNzuTaFI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704148902; x=1704753702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6bA1p2Far7Rj48+oE9LcI61ueLR71wXVmfXYfy2pd8=;
 b=CuAUIbjPjXrZRV1w3qZPRoZO8DE19B8UgCU5L49X+7EJ2JfUZtFsB5jgL3QawO1mlT
 atWMZAleFzHr/xvVKn2sEde/jnyhz037p8ygU7HqNOnRxudjMo7SLUnX5qyun1F3+GNY
 fpbXKz8XEo87G31bdkcoeu6lLH6qHsO5KuF6NJekeT17X6KjDP5mWBPAByh0Q0pXEqOG
 Oy9kYP7Wtque+yw1aWdDWG5ullUwjvH0tmY1soBMbSE6Fu/ns24E/DVdAmRLgLy1PES9
 s7xrYgR93Diejr88jiMkymPnoDZh+j6Uc91qL8mbFuRGBCaVJSb/P0hENXDeovsh54Oe
 bamA==
X-Gm-Message-State: AOJu0YzTePF/TLgrBOAZdDD7NUWCVpUBPA0QQuVbC2h9jAdrW4aSsFZB
 Uf9yVRZIgSZIM4ImJHm4HKJ/S2bdSOwCVfWBvUPaP69vj8UjQ/4QYoL47sg=
X-Google-Smtp-Source: AGHT+IHwuvMakxo5IIH3dqJgvNvBLpEF8xMUYI3jam2lteqbHy/MoTLDzhoQCI/5KzHtCqLP7tLsw99FC9sX9PFdnlI=
X-Received: by 2002:ad4:5b8b:0:b0:67f:89da:aa63 with SMTP id
 11-20020ad45b8b000000b0067f89daaa63mr16859113qvp.12.1704148902225; Mon, 01
 Jan 2024 14:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20231221000011.297145-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjLOp8hJqPgCEVa+PDs-TGr6dtO+apMb0+WmopYZVpRbQ@mail.gmail.com>
 <61a172c4-6fe7-4631-a92d-2b9fefdd998c@canonical.com>
In-Reply-To: <61a172c4-6fe7-4631-a92d-2b9fefdd998c@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jan 2024 15:41:31 -0700
Message-ID: <CAFLszThDD5+FfYWSkaiG-kERg1brF6vhqX-LoVRwXaqE094kXg@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: fdt: check fdt address
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

Hi Heinrich,

On Sun, Dec 31, 2023 at 9:31=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12/31/23 15:22, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Wed, Dec 20, 2023 at 5:00=E2=80=AFPM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Trying to read a device-tree from an illegal address leads to a crash.
> >>
> >> Check that the parameter passed to 'fdt addr' is within the RAM area a=
nd
> >> non-zero.
> >
> > What is the motivation for this patch? Is something crashing? We don't
> > do this with the 'md' command, for example.
>
> QEMU with too little memory was crashing. But maybe we should write an
> explicit warning about too little memory instead.

Probably.

[..]

Regards,
Simon
