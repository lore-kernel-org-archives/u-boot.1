Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5B9C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 18:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53EC387254;
	Fri,  5 Jan 2024 19:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BNZGgKat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A23748795E; Fri,  5 Jan 2024 19:57:28 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52A186F42
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 19:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so1026007a12.0
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704481042; x=1705085842; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SyOvhdquR5IbzkfllKi6hZK3Q5O2acbpejlJt+6jfG4=;
 b=BNZGgKatCKRA5HQ2PzLa2JOAg/M1i13PkhPGiciQsOeYM2K8+JMx+dxBKvwpmK8p9H
 bOhFWyMdPaRh63U03CfgsML5Ddniwng47LCgEAWhySwsZtsp5GLJ/rz2rrmif8rwqdFV
 oU7y072r4tOgyrQSq6sgJgHtlreQqO7FidMUbCueke+v0jc1TuTTvYBb8B90wAokcsz8
 X4DX116UK8IHJBHEoirP6MGSfQSoHLtBQ4ScHcaUNGQXf6otfoME4thXBXZfXGNLVY7E
 B7iTPLeJ9s/2IZk/f2CVOpntC8lYU/oZ6EZH/zTXVYKI32S/glfhzWGBG69F8kayVKup
 0IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704481042; x=1705085842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SyOvhdquR5IbzkfllKi6hZK3Q5O2acbpejlJt+6jfG4=;
 b=EoocoMqnFC11x5fgLVEmUcDj9JaY7oGTnwQRaoyJ1J8+K3l7t1UGpbTnasf2rZV0My
 i1qM7eq4JxjIYN/ZXoI/FBabTBM7BTEe51+OX8Kj5/6gdTYrqo9IBL1MNr50FPolvg/4
 lUMWqEUKKaL2eJoW02cqhW6sKuiVPFi16CkAZQEPVKufWhvX9C4ZGADIlhx6I4hubS3T
 KXlwWKM6tDxXnJilq/UU1enF8gkNa7xA/sR+JHHjZ0RlS9y9f/xrPGrqHgkQt4xThua6
 hdNS0+L6o7L8ZJYGKY7+xy6OQvpWWriLqrDBnmPZHwzQX+OO1q2vnk+KY9WJdv4uynao
 pnUQ==
X-Gm-Message-State: AOJu0YyzS6p2viK8Bas4te01/yX0B2mMYsPuoeVogkvFaFcHUMvZ55vo
 QXKqIb3goNIXQlgfVf8VeTm6AggcqXMCRvv86JlQqCMf7GTwqg==
X-Google-Smtp-Source: AGHT+IGgfaIvBqYbRAxbo/yRbqhd5+b1YHK7jzP84Q4M4i9tMloifm4EFLVJuw5y/pCug+lVXcNNHofEQYdqSHmdlD4=
X-Received: by 2002:a05:6a20:244c:b0:18b:e692:8f01 with SMTP id
 t12-20020a056a20244c00b0018be6928f01mr2180440pzc.5.1704481042106; Fri, 05 Jan
 2024 10:57:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
 <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
In-Reply-To: <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
From: Paul Liu <paul.liu@linaro.org>
Date: Sat, 6 Jan 2024 02:57:11 +0800
Message-ID: <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Marek Vasut <marex@denx.de>, u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi Fabio,

I tried to investigate this by U-boot sandbox. But it seems to me that I
cannot reproduce this issue.
I put a file on localhost apache server and tried to download it from
localhost.
I might need a more persistent way to reproduce this bug.

Yours,
Paul


On Sat, 6 Jan 2024 at 00:17, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Paul,
>
> On Thu, Nov 16, 2023 at 6:41=E2=80=AFAM Paul Liu <paul.liu@linaro.org> wr=
ote:
> >
> > Hi Fabio,
> >
> > Yes. I'll look into this problem.
>
> Did you have a chance to investigate this problem?
>
> Thanks
>
