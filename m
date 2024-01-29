Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638E0C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5BE687DB8;
	Mon, 29 Jan 2024 13:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pWHRVYGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC8B87DC2; Mon, 29 Jan 2024 13:22:14 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF7B87C9B
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-602c91a76b1so34163277b3.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706530930; x=1707135730;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTRQgSdur4F6F+bMLblXihAr959Et1m7uAjmr2z4x7A=;
 b=pWHRVYGufhqp4sRHmjtz10+QoQW1KF06VeNSsAlfHRTKY19wmBFrWZYx9HHbD3sVdw
 9LBkVmhSY147YreH1Qz/JbZjY2eBCZthXDKKOlUES0H8eI9AZTeXfBFZ3jzKgOWcuaTn
 6tAbSf5kbzaOl9bBjupsbaCfgQI90h/ZRZpCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530930; x=1707135730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KTRQgSdur4F6F+bMLblXihAr959Et1m7uAjmr2z4x7A=;
 b=rH6REj9VhYot6PmND+NP7DUvYLd5GDnt76kjYQVmrrwEggxtP30gF3LMVb+eUKhFGn
 2hqXRouW9bLgRxwVOhUdo8ahUAvJqQqKZXT84kGGO10n1qxAotBc9fnVi6448IXVm5Zc
 USZYk8FUNMn9+9NQUxhqeRzG/t8XP0oR4aLHYsrEoMvsCmKxeyK2mcPT8uDhKeBXsW3n
 Zv+/khaWMd+0rMq/LG3BtG87nSZ2MXXi9uA9TsYx7CET4wkSm9TW3ZgHjFgnswYxBc0w
 CPmk0HTBe1UFOCfI2EdcZTDWY5JMMOZ2LpBRn+OaAZy6HdFoRo8ELDCcg7fMSzJQFkzd
 9eFw==
X-Gm-Message-State: AOJu0YxHVPSFp12H6ZlH0+if7NkYXbpI1MDiojllp48a73iiDuX+WFSn
 s/j58145h1eHwh0qBRqfYRze+7E4/KwraSuHAxm656ppU5sbJzV5tgGrlqzksHvztC/4Kc4pgMo
 mdxjstR1Pkl/8k0ytDnmOFrPXROKY7sf9T1imMPQiYO6QjH7CHNE=
X-Google-Smtp-Source: AGHT+IHbsQv/rNJWUA+lnT9h7hg8Mmo7f8oe8BcbGHAM11OwQnHSkpkg+HNRDrIjpjNl2vq5mTWlQHIXGGdonpd/JhY=
X-Received: by 2002:a81:e505:0:b0:5ff:9fb4:33fc with SMTP id
 s5-20020a81e505000000b005ff9fb433fcmr5234488ywl.6.1706530930345; Mon, 29 Jan
 2024 04:22:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
 <86732ea5dfb703525e50bfbfbdeea188832611c1.1701853668.git.tejas.arvind.bhumkar@amd.com>
 <CAMty3ZDaZO_QCSx0MNUdtHqfzyDB-uRKc3QN+fRj02TzkCsMAA@mail.gmail.com>
 <BL3PR12MB64506B6013FFB4CFAD2D0746D863A@BL3PR12MB6450.namprd12.prod.outlook.com>
In-Reply-To: <BL3PR12MB64506B6013FFB4CFAD2D0746D863A@BL3PR12MB6450.namprd12.prod.outlook.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:51:59 +0530
Message-ID: <CAMty3ZAnzbY3+ES8KQUWKBSx4vinKZo3rZzZRJPTEmxJfVqOyA@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] mtd: spi-nor: Add config to enable flash DTR
To: "Bhumkar, Tejas Arvind" <tejas.arvind.bhumkar@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, 
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>, "Simek,
 Michal" <michal.simek@amd.com>, 
 "vigneshr@ti.com" <vigneshr@ti.com>, "git@xilinx.com" <git@xilinx.com>, 
 T Karthik Reddy <t.karthik.reddy@amd.com>
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

On Sun, Dec 31, 2023 at 11:27=E2=80=AFPM Bhumkar, Tejas Arvind
<tejas.arvind.bhumkar@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Jagan,
>
> > -----Original Message-----
> > From: Jagan Teki <jagan@amarulasolutions.com>
> > Sent: Wednesday, December 20, 2023 1:00 PM
> > To: Bhumkar, Tejas Arvind <tejas.arvind.bhumkar@amd.com>
> > Cc: u-boot@lists.denx.de; joe.hershberger@ni.com; rfried.dev@gmail.com;
> > Simek, Michal <michal.simek@amd.com>; vigneshr@ti.com; git@xilinx.com; =
T
> > Karthik Reddy <t.karthik.reddy@amd.com>
> > Subject: Re: [PATCH v2 01/30] mtd: spi-nor: Add config to enable flash =
DTR
> >
> > Caution: This message originated from an External Source. Use proper ca=
ution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Wed, Dec 6, 2023 at 3:02=E2=80=AFPM Tejas Bhumkar
> > <tejas.arvind.bhumkar@amd.com> wrote:
> > >
> > > From: T Karthik Reddy <t.karthik.reddy@amd.com>
> > >
> > > The spi-nor framework will set up the flash parameters by reading the
> > > flash id table flags, which include cmd opcodes, address width, dummy
> > > bytes, and bus width. In case, flash supports octal DTR mode and the
> > > controller does not support the DTR. There is no process to switch
> > > back to SDR mode.
> > > To avoid this issue, create a Kconfig option SPI_FLASH_DTR_ENABLE to
> > > explicitly specify to enable/disable flash DTR support.
> > > This config is disabled by default.
> >
> > We cannot control controller fixup in flash, DTR read based on the DTR =
flag I don't
> > think adding extra CONFIG to hack the controller with impact is.
> [Tejas] : By default, this configuration is set to Disabled. It serves as=
 a convenient option for operating the flash
>         between SDR and DDR without requiring any adjustments to the nor-=
id table flags.

This look like controller hack to me, may be a clear negotiation b/w
controller and flag might have proper solution.

Jagan.
