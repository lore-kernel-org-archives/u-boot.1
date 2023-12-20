Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED170C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FF3886E5E;
	Wed, 20 Dec 2023 05:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i99hbAKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A6C986E05; Wed, 20 Dec 2023 05:11:36 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF9386F1E
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50bf2d9b3fdso7185546e87.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703045492; x=1703650292; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1O0UugzaZXwISRp987nofu714lMKd9Xm/pS6GDYyvI=;
 b=i99hbAKMEAGq7x9S+MB0ZPni1+CK69ZQkDX+7uNucWnSY0wcNr6UGzHykCWuiP56RW
 Q8wHRd9VhmWlzSTu57KOoBfavezkOEidjpytA8DuGSFYJPlumzzk+ffaPQKPHdMM9dhu
 ChbD27L610pRmyexUCpb5GBKnSZgL1qYEwnL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703045492; x=1703650292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1O0UugzaZXwISRp987nofu714lMKd9Xm/pS6GDYyvI=;
 b=hjT59nIxDXPXm7EDo2uWdgi66Hek06xtLqWSKPLB7NKPgtTJUdJLcTrvNN8Vnn/fp1
 yj8pBmhy+ixk4fTVdBFSNQ2P7b4Otr19EhoYAnfH9EBIF0UB6TUyxYE0fy8S+vYf4Uiv
 FsXgMTt43hFDG3gDw/9dvO93vdtVNMuexf8b38wYCR+RZjSlq4oXQS7alLI82ScFzt5+
 xWZfbuliAaBHi5xSeYbWVcO+3O2TnJ7oZkPyylP2yRezhfvbB3+VR/ja7Qmls5ApWx0y
 jrRcqc4TYIrqdDYEMqJKJ1fODbkRxesz/7nbTJzQV219QT7EwISS2Xp7f7A/tGhCjFk0
 EITA==
X-Gm-Message-State: AOJu0YyWuNF6INLiY28i5j5NOpneFXusmmtKOglhXh91vehyxwDmGkyS
 l2DGFtwixk9OOHgVR4rV+OfvX5rv+VblmbiQeFoMgw==
X-Google-Smtp-Source: AGHT+IHIvLOFEDlUKrFbwK6LoNLy4abCNGiZ2wCXKS2bJPm8S4nw6L9VGC4tA/wxzO9xvjvlGpj9TzJMT/Zkn3TUoeE=
X-Received: by 2002:a05:6512:48b:b0:50e:3089:a6b5 with SMTP id
 v11-20020a056512048b00b0050e3089a6b5mr3187376lfq.76.1703045491243; Tue, 19
 Dec 2023 20:11:31 -0800 (PST)
MIME-Version: 1.0
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
In-Reply-To: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:11:14 -0700
Message-ID: <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
Subject: Re: Passing boot logs to Linux?
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <Csokas.Bence@prolan.hu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Cs=C3=B3k=C3=A1s,

On Tue, 19 Dec 2023 at 13:15, Cs=C3=B3k=C3=A1s Bence <Csokas.Bence@prolan.h=
u> wrote:
>
> Hi!
>
> Is passing the U-Boot boot log to Linux supported yet? We are working
> with a third-party solution, which works, but is a bit hacky, so I was
> wondering if an official solution has been merged yet.
>
> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
> everything to a membuff, but I don't know if that can be exported to
> Linux yet. And if not in the tree yet, would such a patch be welcome?

Not yet, but yes I would like to see this.

Regards,
Simon
