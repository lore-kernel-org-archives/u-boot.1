Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26DAC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 16:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0064B879A5;
	Fri,  5 Jan 2024 17:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E+hxZaCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D5B879B3; Fri,  5 Jan 2024 17:17:34 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC619879A5
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 17:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5cdbc42f5efso172574a12.0
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704471450; x=1705076250; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhBsrCBoVC2/bO7suG3n7+nliBC/nrh6gvtPVB19gqM=;
 b=E+hxZaCistwsNvpS+L/vAjmG6xo0VaAB5r+tBETmOUOeLqDbu9EOfwLftRGYWYQy9x
 mGLGWNZr31KxcAd2ck/lmzxkWqG8Q9qH1N1xWB7XrsZrjdlJjZeR0fP9UU1eFcshWxkX
 gxijPekLQbYGHaepJfXOXp4DlcUy50sNYdAR27s3QvqyCMuokyX1krv7amM3Oj3jDk6l
 fYEVrA4YPDIl/aatPwetiJGchGH4GhWrJo9AJBuzSKxCp0tMybpcN/3L+YuejVZaxZvf
 vIOkN5c/4CDvqvW78Zj6ErMCd2+YdU5JwayCIRf0h6n7ekjb2k5nuqHvctLNiTUFJjE8
 A3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704471450; x=1705076250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mhBsrCBoVC2/bO7suG3n7+nliBC/nrh6gvtPVB19gqM=;
 b=TOcuWW4GkZ9GhF6to5nlto0xaw/OJKQOoLNTsRq2gz/Le0JKg7LUGHs8CVNHNDtuh2
 5JXyI5AXyEX6uP+kZJUAKhV64Lbfm/Emv4+oPs7E4KXPWlMzOA6Trv14j3cREvImlZlL
 cSeUs3aYs5Hn7UBll5bOwBxFwc8RytIVBTzugdUQlBo9s72VsoTIFxIjK3oElx46Rme+
 2vuXHYCy06OB8HPj1juxshNj2Jhkq+Dl1rTOigiNrAqaNO8gG7VIaakwuj6wG/uLBM0l
 5fugptRPvP0t3XoLE3U2vwva4V6BVEWacmbT8IsjCw88g8HuLHtQe7W4Ag62I2T8UrH5
 /gsA==
X-Gm-Message-State: AOJu0YxizqxLNL0X6FmUNNxJVLaBQJAp7NIOXLAzjJ7PJve9XhB9hJ0Y
 CRnIcpyMLxsFcktDElBPjV2L9dvYZxBiKlhlDyw=
X-Google-Smtp-Source: AGHT+IHxfco9mZuc80ItjrBgxLzaIWL9wWRiakcYO7cI9itdjX7WJmq6lPu6wPnbE5ydZQn8B74wC6W+0VMygmDbvWk=
X-Received: by 2002:a17:90a:43c1:b0:28c:ee93:7575 with SMTP id
 r59-20020a17090a43c100b0028cee937575mr4074512pjg.1.1704471449920; Fri, 05 Jan
 2024 08:17:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
In-Reply-To: <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Jan 2024 13:17:17 -0300
Message-ID: <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Paul Liu <paul.liu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Marek Vasut <marex@denx.de>, u-boot <u-boot@lists.denx.de>, 
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

Hi Paul,

On Thu, Nov 16, 2023 at 6:41=E2=80=AFAM Paul Liu <paul.liu@linaro.org> wrot=
e:
>
> Hi Fabio,
>
> Yes. I'll look into this problem.

Did you have a chance to investigate this problem?

Thanks
