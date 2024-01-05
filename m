Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B5DC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 19:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BB08795E;
	Fri,  5 Jan 2024 20:49:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jNR3ojX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A22987967; Fri,  5 Jan 2024 20:49:35 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5FD78795E
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 20:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so211178266b.1
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 11:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704484172; x=1705088972;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHtFrsaZUsx4vWpg2YQliRHYMMny/gg8znjzNdFDrx8=;
 b=jNR3ojX0Op5aPcwdNqHgpXITpDwLk2+UuRxxOf4awwAKD3NdX4GKGoIdrHKzbdVqWM
 N0o+f7D/nj8rXemC5CZ6oVUD7F0HYmadm3GwmuQKUgTbvDka9dvlIDwbW7Sr26Sd7PYL
 hsliJgaDGCn9WTkpMdoa89h0m2BquNwME7ipE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704484172; x=1705088972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHtFrsaZUsx4vWpg2YQliRHYMMny/gg8znjzNdFDrx8=;
 b=PGR6tYgzxBMkME7oRm79qb7HvMlsQX9/wYqqCKsitoM9oaX0897pd0dIC7boWXUAzv
 rHIyONA+6tr/zFsWzWP5bOuBhkhQm1qCftc1kJx17Cd5cPMBi9ExOMaozAkldZcMmkr9
 IVkCmq6Pk9kq+1kU4HXzvPkZSM6kuq1YPJAcKaHshFF318RtKbz7fjXeuMqn63Ie+B04
 oKxfYWcrpAbWcJdZdC5mf5pEe+muUyHpR+fXUBx1iZX3ts3c9VwwlLdtH5kEFOscoB3d
 iLckw4UrriC4A+n4/ADpzMrlMwykgIfKjwb/a1GHKqMcPwlBtBqNSlYoNi3xmVK+RKTv
 88UA==
X-Gm-Message-State: AOJu0YwP/6GG4iage7uGbTo8U979MdoDabVE/BVtyq2nW32BwILYkCId
 0WNuMWQlc2N3SMKgElvii+1wqB5rMvusNrsemYx9+ndBrw7HyQ==
X-Google-Smtp-Source: AGHT+IF7iKIuOtVnZhrtCksl8SMEacso3CQMgczwVQqWsAIqB9KfhEJk+xtFr6N5wkvJkX5nnIhSOH9t7gqVySE3tWE=
X-Received: by 2002:a17:906:360d:b0:a27:ee21:58c with SMTP id
 q13-20020a170906360d00b00a27ee21058cmr1304978ejb.155.1704484172094; Fri, 05
 Jan 2024 11:49:32 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
 <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
 <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
 <CAOf5uwmDZ5DtAhe-GauhuyYwSSXQnavVNfzaJkdSG3TWE1N2FA@mail.gmail.com>
 <CAOMZO5DtCDe-VzY1yx2f+LTz0tCqmtiLemrH=xTnPQs7=07aSw@mail.gmail.com>
In-Reply-To: <CAOMZO5DtCDe-VzY1yx2f+LTz0tCqmtiLemrH=xTnPQs7=07aSw@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 5 Jan 2024 20:49:19 +0100
Message-ID: <CAOf5uwn1LuN6uFQe9d7zXWDFnvOAqwb-etQow96fzAR0qim5Hg@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Fabio Estevam <festevam@gmail.com>
Cc: Paul Liu <paul.liu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
 u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi Fabio

On Fri, Jan 5, 2024 at 8:32=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi Michael,
>
> On Fri, Jan 5, 2024 at 4:12=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > Can you reproduce with dcache off?
>
> I haven't tried it.
>
> > Where are the patches to test?
>
> The wget issue can be reproduced with U-Boot master.
>
> No need for extra patches. Please see the first message of this thread
> where Tim explains how to reproduce it.

I was thinking that was lwip integration

Michael

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
