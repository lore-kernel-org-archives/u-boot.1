Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02DDC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 11:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13314807D9;
	Sat,  8 Feb 2025 12:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i3xnI5OK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADD780805; Sat,  8 Feb 2025 12:09:45 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D42980756
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 12:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-54298ec925bso3473853e87.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 03:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739012982; x=1739617782; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrUcpReEU2x8WDBEn/yB9NmGkzIGC7Nt7oqmhP5559I=;
 b=i3xnI5OKr7X+Gfei5nu7+FenP6wT+aoxWamyVhEhpwvNacOjyv3alodoHnb+XbThhf
 orJ7hVMVYgGvAhKLd4Cf3rFd6/zgFZsOFyCjptMx7eoQ0A4ZwYQKGcZFQ+sox0TYbSOS
 YCkmFh0B6cIxefP05ZaWMXxztaEMoN7HR7ChzfHaQjApadZIpFTvnbi8QG1hlhhiZCUk
 6OnFnrHuKvh1d66+b+UUWgHaD1PdXvnkMhioH3o/hfOFZa0J11bIIfIgIl1g8qo5duc3
 rl/KHwK0JRjkcfPhO1ukysa4l4yGuyGj6/C/qtCtZdvyc2DJqqZE5DFTo74n6w6UfqGX
 xe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739012982; x=1739617782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zrUcpReEU2x8WDBEn/yB9NmGkzIGC7Nt7oqmhP5559I=;
 b=tJbF+ein9Y/XmD3PgndQZshRdpB14nrRfidg4EjK46w6rIn6Bssw2NhDpY6uLxcXCE
 aYDGWRStauL/eGEg/KrMQMnNLSqc8j3xGJgiHIdOqLstBgv2C0EuQ1+zarhKizF7hgj5
 up6E7ntCXoUXVPYev2DQ/nHbGKD6iroNV5ytgx8TWnvt3Yj0EfggGB6+xfJTC+qPmjIP
 iHA40iMSku32X161o6BaEQZvinIgMGTkAp0XzQtzVyQts3a88dsCTcWwzeaJbLiI5+sN
 LumkCNDfPsMvZ1HvI93IVZ92N8Cc7iJRXs0VZOVKkoAI0biW7VDYlQ+Wly0S39GCkCZn
 Jj3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcxWsWSWHrZ5z2hRb6k9K+sssCR/lidt+2Uc1kvTDHbPS3lAmaX7ueEWG6LJdBCd5gCq0J0bA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzdbr4Y4FMrKmEmIqcxla99YLg95T4AVg6OJkOewgRJ+BxrNMlS
 fpEkwZkpM6y8brOSGMLB6wzhL2HWQbJL05cKLaXecrJSY5fw3fGtygO87JvH2kHZBtkaS8Qi3sL
 L1VYrYliE0RChNykmgAl2EHrgwUY=
X-Gm-Gg: ASbGnctRHxLw9tvn9SeIQt6JmLdzfhqSEXxcD/hP592npX55YEl5oQGgkOjMOIkUtcf
 foHuAFmdTfSfUWyS0fM4glZz/l7KNVI1QNSGazBu48UDfpShmxn2SuDUEJ1DALnEMtnBPkqd7CC
 fFqBby7OJPGjETLWQP08dgqqzPsGNJ
X-Google-Smtp-Source: AGHT+IGdIzVc7IJ+dFaQrKKYlcrWN1XVtRvMjBuGy6avU6MtPFP3S3CiB8/X/8Bsses/wyE0yVVhqxukIGcV1LSH5ug=
X-Received: by 2002:a05:6512:2019:b0:544:11e4:d53b with SMTP id
 2adb3069b0e04-54414b0bd7fmr1900199e87.48.1739012982198; Sat, 08 Feb 2025
 03:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <20250129-ge-mainline-display-support-v4-5-a43b3657ed7c@bootlin.com>
In-Reply-To: <20250129-ge-mainline-display-support-v4-5-a43b3657ed7c@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 8 Feb 2025 08:09:30 -0300
X-Gm-Features: AWEUYZlvTSQ_B3W0f-fno1dgr5HG7KDylPgBMO3XMrWDTUsi1hCsJwh7uMzZFCE
Message-ID: <CAOMZO5BwB75QnfYKkcnq_kS_7N8yXzLNdpyzcWQ2Jy3zu9V1NQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] power-domain: Add refcounting
To: Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Simon,

On Wed, Jan 29, 2025 at 7:22=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> It is very surprising that such an uclass, specifically designed to
> handle resources that may be shared by different devices, is not keeping
> the count of the number of times a power domain has been
> enabled/disabled to avoid shutting it down unexpectedly or disabling it
> several times.
>
> Doing this causes troubles on eg. i.MX8MP because disabling power
> domains can be done in recursive loops were the same power domain
> disabled up to 4 times in a row. PGCs seem to have tight FSM internal
> timings to respect and it is easy to produce a race condition that puts
> the power domains in an unstable state, leading to ADB400 errors and
> later crashes in Linux.
>
> CI tests using power domains are slightly updated to make sure the count
> of on/off calls is even and the results match what we *now* expect.
>
> As we do not want to break existing users while stile getting
> interesting error codes, the implementation is split between:
> - a low-level helper reporting error codes if the requested transition
>   could not be operated,
> - a higher-level helper ignoring the "non error" codes, like EALREADY and
>   EBUSY.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Are you happy with this version?
