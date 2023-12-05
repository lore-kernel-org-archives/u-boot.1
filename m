Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3A7C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 00:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B5987763;
	Tue,  5 Dec 2023 01:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EGaly1sa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C8B86FB5; Tue,  5 Dec 2023 01:52:15 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E9787763
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 01:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c09ba723eso21793785e9.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 16:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701737531; x=1702342331; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x165/TM3Dp6pElR/9fEYoVid9PhQqg9CIXFORbGjSno=;
 b=EGaly1saQ3ew8T511HrNcq+H7eVq2sQ9jnEUND7VU+edIzFQRQ45xvFynjKo6u/0dB
 LTH+BiQhec2imUdzFuai9c/KbfVVot8kMqspNSkFK4u1J2n34YyM0sHIQH5yRZ1c5lGw
 twQyNFbr1ln9/ts/S0V/0Tj3xBpeBaYH3HhHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701737531; x=1702342331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x165/TM3Dp6pElR/9fEYoVid9PhQqg9CIXFORbGjSno=;
 b=EVSL8wKXHqZTYgDn46W1C8H6N+BRm1HNitNY63puntK3fFQbYqIkplRs6kgIQlBQVM
 yNcP8rYYjauQ/2QTXiIlrLhvyGsVB2yZiaqhaeUU2WTImhW8YQzFUuxzK0K7hC5cBKKo
 IkZ+sn9DXgXCA/IxmTeo47VUaIn8VlH6R60odnJOVFifDWbeAUpZ+n6H4p5eU4GMeZTc
 vUrEandf567e2M9CrDMb4MCgsJNd2vR1Spr5j44Ic2dbXXIhdWgOvzEOmQi6Xu73QQzM
 LZDeJpoNqpZuyccX7Nz938+cHMDt6KFfpqfcwJeAMjSVFZAjoVHpEkRPFWc4ROK15zCv
 AK5Q==
X-Gm-Message-State: AOJu0YyI2x0gQA0phrw+Ubt1+pzRdC2HoldH2KrQ4IZe5y020FQyzh3Y
 CCptMuollzTNkK6j8va1GHMMFsLKsfI68Vp1fnP7ReRv1iHCPhW5VdAikXES
X-Google-Smtp-Source: AGHT+IGo0oZcPYtSw7GlFzZWIEFJEL41LKpucHp2PH9e6hkxbRunHnGXaNUruB3WD7ex9yUiQ5M6IPlTSm7Iw1eXrAQ=
X-Received: by 2002:a05:600c:1f95:b0:40b:5e1f:6fdf with SMTP id
 je21-20020a05600c1f9500b0040b5e1f6fdfmr3530wmb.52.1701737530757; Mon, 04 Dec
 2023 16:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20231119165501.1305136-1-i@shantur.com>
 <CAHc5_t3MwUvFdQQaZGeONxS-JNuB4mYXyU9YSexN8bCbQUTRYQ@mail.gmail.com>
In-Reply-To: <CAHc5_t3MwUvFdQQaZGeONxS-JNuB4mYXyU9YSexN8bCbQUTRYQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Dec 2023 17:51:55 -0700
Message-ID: <CAPnjgZ3umb6g3O7r+bNtCpGihFHoq9Yp3Fnq9Hd-VkQvewX0oQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] bootflow: bootmeth_efi: Fix network efi boot.
To: Shantur Rathore <i@shantur.com>
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

Hi Shantur,

On Mon, 4 Dec 2023 at 05:38, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> On Sun, Nov 19, 2023 at 4:56=E2=80=AFPM Shantur Rathore <i@shantur.com> w=
rote:
> >
> >
> > Currently bootmeth_efi crashes while doing a network (dhcp) boot.
> > This patch series fixes issues and both network and disk boot works.
> >
> How can I help to get this patch series merged in?

You can check patchwork [1] to see who it is assigned to. I don't see
it in my queue though.

Regards,
Simon

[1]
