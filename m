Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FC8CDB483
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 15:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8015B86E65;
	Fri, 13 Oct 2023 17:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=lessconfused.com header.i=@lessconfused.com header.b="i1HZApO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73CCF86E65; Fri, 13 Oct 2023 17:11:30 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0A586E7E
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 17:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=lessconfused.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=da@lessconfused.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-27d0acd0903so1574819a91.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lessconfused.com; s=lessconfused; t=1697209876; x=1697814676;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6mTvtk+2ipUj4KKSvEv/tNOV6C0AnSirPNEJYWQ9No=;
 b=i1HZApO+/6qkcNA2CraR6WJe5G3r+MrYtHgVQYrz/GT/a2+0z7kOBxL54Q9OrY7jeK
 f7hKZk9VlkdK3DK6rYOwVZTXWMTlIuCWJRpK/jawI2hYwPesvtQJ7rxgneAftt+MFnbr
 CPJvx8JVrG/MQd4xCxxrlhLVl0p/8RcYfGt7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697209876; x=1697814676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6mTvtk+2ipUj4KKSvEv/tNOV6C0AnSirPNEJYWQ9No=;
 b=dyPA1KVqz5z5YTq3uwdRZnHFCtyXbvEZxgqPaJ2MPNS29KjkM2SHbs/ZI7uggAzRnZ
 cfvRRoUrlHSqWPTaxfJAzLEofryBfm9aN6ZxHOGrJebXIe1VyIJ3157IWTJsrejpT0I/
 LyU8TTDPGyeIIXspi8OWQW3euLaf0MWAWqUj6e3tM+y5wReiY2ekkby/1q8LzsaA6e3E
 5H2msTsFJv9U8R4xZHjDwJ4Wm+S4vpCNUfxadnakojartkTlT5iBQGrPd6dTSYuJ9CZy
 QZAoiBi8rvGxdpe9qqyUXfwADS7igadd98xL1CpTSKpk3IzcosiTjg/lXaiomXsFjEI8
 FKzQ==
X-Gm-Message-State: AOJu0Yyka5HkZmj9ST73N6qM7Pdgqn5qFnLC3RpalohZhNWzUmL7i85f
 9U3owTK8jFXuBbgGLvplh06sflJxZCznQ7+y32x2ew==
X-Google-Smtp-Source: AGHT+IFC78Sjha8LUByGMnwXwA8lAw8/lg/ETOq9VPj31H0+B7WAj1qqG7qIznmyym76D5xMv5JyMZsa1SoqMBnbPho=
X-Received: by 2002:a17:90a:a018:b0:27d:c2d:94e8 with SMTP id
 q24-20020a17090aa01800b0027d0c2d94e8mr7709095pjp.28.1697209876409; Fri, 13
 Oct 2023 08:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231013045356.25789-1-venkatesh.abbarapu@amd.com>
 <2016c1bc-dfe0-416e-a910-75e6cf25036c@denx.de>
In-Reply-To: <2016c1bc-dfe0-416e-a910-75e6cf25036c@denx.de>
From: Da Xue <da@lessconfused.com>
Date: Fri, 13 Oct 2023 11:11:04 -0400
Message-ID: <CACdvmAju3wDL0yCJtVdEf47u+L5R3AvRpcuJ+ruKFXDTcQ-TBw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: xhci: Workaround to fix the USB halted endpoint
 issues
To: Marek Vasut <marex@denx.de>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com, git@xilinx.com, Tom Rini <trini@konsulko.com>
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

On Fri, Oct 13, 2023 at 7:47=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 10/13/23 06:53, Venkatesh Yadav Abbarapu wrote:
> > The xhci host controller driver trying to queue the URB's and it is
> > getting halted at the endpoint, thereby hitting the BUG_ON's.
> > Mostly these kind of random issues are seen on faulty boards.
> > Removing these BUG_ON's from the U-Boot xhci code, as in Linux kernel
> > xhci code BUG_ON/BUG's are removed entirely.
> > Please also note, that BUG_ON() is not recommended any more in the Linu=
x
> > kernel.
> > Similar issue has been observed on TI AM437x board and they created a p=
atch
> > in Linux kernel as below
> > https://patches.linaro.org/project/linux-usb/patch/1390250711-25840-1-g=
it-send-email-balbi@ti.com/
> >
> > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>
> I already explained to Xilinx how to sync the driver with Linux and why
> this is needed to move forward, multiple times, and even provided a
> script which does most of the work automatically, since it is basically
> automated process. Xilinx did not even bother to test the script and
> provide any feedback.
>
> Until that happens, this patch is rejected.

This patch also causes all of the USB devices on certain platforms to
not be detected:

scanning bus usb@c9000000 for devices... Device not responding to set addre=
ss.

      USB device not accepting new address (error=3D80000000)
