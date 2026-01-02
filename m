Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B45FC6171
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 07:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38CA183B4E;
	Sat,  3 Jan 2026 08:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m7UlWFsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EAA483AEE; Sat,  3 Jan 2026 00:14:38 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB34B83A7A
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 00:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so114504475ad.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 15:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767395674; x=1768000474; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WUui8VIdPH1bllaYCPlhjSSByEn4EEJDdHf6VtbwYpg=;
 b=m7UlWFsZQFVb60cvlLn7NOJFfXiArkBcJWoi3pIX8C1YfXahmujD0upBZQRYKFf3N5
 IB/HNl3MgxmmxvV+uS8xTY6qzGYPi/TJa9glRD9w3AVYs60n1IzSoFbg8HUzvqImatz9
 bcpHMaQ2fRaYH+sle4Vrp+k1BnQJXl10i8Lrx63u98CfYH1kwxZV+aIky5RH45O3Qo68
 dZtprDU6rkW5qKHbx8ypKJsxb7xL1+UImWlbqN7OrZtn32ogta3cBTHe/vIJwLGDxKwJ
 MY9XO5j8WFjhchNZpYBTAGBTm/8cC8JtnC/olQrJSOyvfy27s1mBu152Jc+BKuAUcAn4
 pkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767395674; x=1768000474;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WUui8VIdPH1bllaYCPlhjSSByEn4EEJDdHf6VtbwYpg=;
 b=LFsZukV6s2gMEdMfQEh0XoKtBskrIxCyNYbKL8zT9Yn03xtvJJzCraU+VyVg1lqfCc
 4Pyl7UcQCZOhBiIuHB5HcmDIkj41YtLwNy6LECGPCQ+/2V+90bgru8Q4+B591+zpNLVI
 ZvQKtBPrz8B1mObLeJDA5gNBumHjms6zHxSyaKCbnwjEUY5XdIZ60tGiF3jYK1lOIuyz
 1iYtQko+9+o2BrZlIZJAHKNN1Ak1WscdiaEsV/gmlMAxWdQTm+ea8VdAEjGRk7HE0VDs
 sydtHYblbq6FeY27PjiL+JIqa5B9uMUlsZINkTTTmrz7YeHTRAjMRilCmkgY2kAo6iIb
 XLag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4cPT2TRg9zuIx+In1MBdC2Jyh0zNAjmAficmlnvc/E0t2b/ZnBnbqy8Uc3op0NVwspy1txYk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+hXwN9do00CbpPhXkMOiS0mOHsZtmXuvEeXpxeIwHWkww80xm
 uyRyfckNkztukSIOxe1IRbwNQfNXaYCbQpAwgDteIeDZv1oIi8OQtQJl
X-Gm-Gg: AY/fxX5a9WzwWjpmjvh6rpPrs+BTbuaeoid4eFVCw14PeZvpxtl7QmOhK+U43np2+6d
 WROjWyWGi2q6GRfr9d1BgJrqFOlik9xB/rs20oUPIVrNfdWDKUyEFEm/n3/xwOiiRpvU6YBjSMT
 wm4RJLLmgMYYTWdvu1pVQZFNtyGpYTrBkuJx9qY3H+gOsnWZLSsUAD+R95b5rhzJF2KIZHAwSM+
 mozJ7I9pahFDsLjYQjzduiOInHcshg5CmkUoeHpXoy/gYSeSUg6T/sdY+W+NN0ZewBc981AinWa
 g3HOJLG3/8wMZUbRqyVyzVnEyntBiUQYeDcr0rN+f+sgjooOeESAKeOXkf5vOXk2/rgY6JNqn01
 //U4OYwg/17k8XgjOvZkRgRcwPNDQVblWnAfRt2yyLBG6O+KfvC7fAgIyV5tO9Bfku0uD48Iyh5
 PJokiwHsttqeX+44q15J+iLY6n74JeRPZv/tmT5JvNbpwIe+o2ln4JvjQT1g==
X-Google-Smtp-Source: AGHT+IFQjGMEkqVvQf+mdXXQ/leLS7V/jmAw29T4uVorb7LvkTtc1hzwu+vOavejB4obifvF95aiqg==
X-Received: by 2002:a17:903:2a85:b0:2a0:c1f5:c695 with SMTP id
 d9443c01a7336-2a2f2223709mr459400155ad.16.1767395673947; 
 Fri, 02 Jan 2026 15:14:33 -0800 (PST)
Received: from google.com (61-230-44-212.dynamic-ip.hinet.net. [61.230.44.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c87845sm392670385ad.39.2026.01.02.15.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 15:14:33 -0800 (PST)
Date: Sat, 3 Jan 2026 07:14:30 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, me@ziyao.cc,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, alison.wang@nxp.com, angelo@kernel-space.org
Subject: Re: [PATCH v4 1/6] serial: Add Goldfish TTY driver
Message-ID: <aVhRVhPLF7Sx6vY1@google.com>
References: <20260101175420.4118024-1-visitorckw@gmail.com>
 <20260101175420.4118024-2-visitorckw@gmail.com>
 <618be257-d247-4811-9cfd-e58017aba579@canonical.com>
 <855488fb-4ae9-4468-aa2e-68575ce4dc8e@canonical.com>
 <aVg9HhznRcwPLMeo@google.com> <20260102215125.GH6124@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102215125.GH6124@bill-the-cat>
X-Mailman-Approved-At: Sat, 03 Jan 2026 08:05:36 +0100
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

Hi Tom,

On Fri, Jan 02, 2026 at 03:51:25PM -0600, Tom Rini wrote:
> On Sat, Jan 03, 2026 at 05:48:14AM +0800, Kuan-Wei Chiu wrote:
> > Hi Heinrich,
> > 
> > On Fri, Jan 02, 2026 at 09:40:39AM +0100, Heinrich Schuchardt wrote:
> > > On 1/2/26 09:29, Heinrich Schuchardt wrote:
> > > > On 1/1/26 18:54, Kuan-Wei Chiu wrote:
> > > > > Add support for the Google Goldfish TTY serial device. This virtual
> > > > > device is commonly used in QEMU virtual machines (such as the m68k
> > > > > virt machine) and Android emulators.
> > > > > 
> > > > > The driver implements basic console output and input polling using the
> > > > > Goldfish MMIO interface.
> > > > > 
> > > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > Reviewed-by: Yao Zi <me@ziyao.cc>
> > > > > Tested-by: Daniel Palmer <daniel@0x0f.com>
> > > > 
> > > > Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > 
> > Thanks for the review.
> > 
> > > > 
> > > > > ---
> > > > > Changes in v4:
> > > > > - Support DT probing with platform data as a fallback.
> > > > > 
> > > > >   MAINTAINERS                      |   6 ++
> > > > >   drivers/serial/Kconfig           |   8 +++
> > > > >   drivers/serial/Makefile          |   1 +
> > > > >   drivers/serial/serial_goldfish.c | 109 +++++++++++++++++++++++++++++++
> > > > >   include/goldfish_tty.h           |  18 +++++
> > > > >   5 files changed, 142 insertions(+)
> > > > >   create mode 100644 drivers/serial/serial_goldfish.c
> > > > >   create mode 100644 include/goldfish_tty.h
> > > > > 
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 6ce0bbce13d..da4a6e4d518 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -1259,6 +1259,12 @@ S:    Maintained
> > > > >   F:    drivers/misc/gsc.c
> > > > >   F:    include/gsc.h
> > > > > +GOLDFISH SERIAL DRIVER
> > > > > +M:    Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > +S:    Maintained
> > > > > +F:    drivers/serial/serial_goldfish.c
> > > > > +F:    include/goldfish_tty.h
> > > > > +
> > > 
> > > Applying: serial: Add Goldfish TTY driver
> > > Patch failed at 0001 serial: Add Goldfish TTY driver
> > > error: patch failed: MAINTAINERS:1259
> > > error: MAINTAINERS: patch does not apply
> > > 
> > > Should a respin of the series be needed, please, check that the series
> > > applies to origin/next before sending.
> > 
> > To make sure I base the next version on the correct tree, should I base
> > it on the ColdFire tree's next branch:
> > 
> > https://source.denx.de/u-boot/custodians/u-boot-coldfire.git
> > 
> > Or the main U-Boot repository's next branch:
> > 
> > https://source.denx.de/u-boot/u-boot.git
> 
> The main U-Boot tree. Custodian trees are not always up to date (and

Thanks for the clarification.
I will base v5 on the main U-Boot tree's next branch.

> with the renewed interest in m68k, I was going to ask if someone else
> would like to step up as co-maintainer as part of all of this, Angelo
> might like some help).

TBH, being relatively new to the U-Boot community, I'm not sure if I
have gained enough trust or shown enough knowledge of the m68k code and
development workflow just yet.

However, if help is needed, I'm happy to help review and test
m68k-related patches.

Regards,
Kuan-Wei

