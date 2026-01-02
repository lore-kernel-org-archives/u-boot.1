Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7813EFA3755
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 22:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76750842B7;
	Fri,  2 Jan 2026 23:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gUc9iNas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B1CE8428C; Fri,  2 Jan 2026 22:48:23 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E68BB83B49
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 22:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7aab7623f42so13624234b3a.2
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 13:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767390499; x=1767995299; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dU8IcrI5BvK3lZGnEzC6FecPB1A8xnBAHc8lZDBVqKQ=;
 b=gUc9iNasip3a0iCj2iFmVJGkVtARJFRAyAR4f3jBgHV40LAs2RWfGIXvaj+aXXVsOz
 7NX/sB/gdfCQKUpFFmJMiw+0o0+Xk9kS3R0syGPWMpSIGmXMrA1OR2bGIyIZkUR1WbhH
 ZtC6JeIe9qR7qlEFH1gLbtMnkB7nqzf+Hqkqd4J/XBinynRY01mhruKWM9xVpSQKP3yr
 kM/scSjPkc80uXxnJuaLQv+ezpwi5atzNETrahg5BBPWErN9t0FFtcnlkI4alazEPYGV
 SSZ5lY4UChEPqUCRBzYndlOQGzcr5mjQBbSQSItKopZ4hiMfOna0tGGaPsCb0OxOFlC+
 xoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390499; x=1767995299;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dU8IcrI5BvK3lZGnEzC6FecPB1A8xnBAHc8lZDBVqKQ=;
 b=wmsTF40DmSvqqvp9ATSqra5fqbGUX4aujFuwJYso0qr8FvYZSOFrZhaK0SypFvfPEN
 17FeLqhh2LnL6+5Zpkg5TLFVJLyIfoawtzBsgy5U/njnQtk1fkKbXvUzShzbDmNCN3TQ
 rArLRYRU3fwqmAscOJuwHp2drh5CF2wCRjqr0Xgn/MBWITCRKCNtQwU/jlQRRjcZGJbj
 CI3Tk4GVm9/8KSdBtEb5nuI42lLYLo1InFl811OZGqfdF8C7YaM8NYbECUw0Vbt76gk6
 V5iNJ6WzygLplJSvfPZKhqexSlr6eNVhP634sZvqESkwZVRaHESsoaU5nXY9Bc3bBUiY
 2xRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBk6ztOgT1rB739/YWECz7Slrxpb72xBVGHv2lb6TZ2r230bDE0l4I3/XSQ7MqV2DAokRRr9w=@lists.denx.de
X-Gm-Message-State: AOJu0YxQayqFQkYswBU/mwlvqbs85IEjMqON979Y34jZHvOrywbp0ZrE
 BPaZjcCWVVWBIuIwLldZ6zTHiIknMFdTWS9Re/m2HSDe2GERDHDqVJ80
X-Gm-Gg: AY/fxX7vjKLp3j/F4e3kXhSZXu5/w6XMBQMdFMfapi+w6YAU/DIih08kVqrCEI4WhpX
 T94ZfVWeDGHFLwgHegK4haFhJ5L5YU4yiQnqfnGyDELTmsSPcoEtPWOfHBuOly6oVt8SuTd5F+M
 1WsKhBys+KjfDUtKzOLHQiXhIGGVfd4Vwlbw0WtcgSHfy1whRTizpEfJHavzkoMMdLX/EF5TQPJ
 jgpo8qQY/+gA9G+oio5tu4h1N8X8QlPj2zbK/LTNqF8CJYbqysyF8AyvVMtWVP5y6zdKHGxjsI9
 wNFbDlEZ6eJDEsU1qhPcC3xlfDVpcc5wsUpBzLVLB1HP5l12OiDTWmNbmTt3lS5yRoLSLozfx+H
 xP/DVzsDiKYG+NibPWp7HfvVvCphTnu36j8WEfSMs9/jOain0VoG/YvCcJyb6gWNLoz+B842YQj
 oCgySs9TOz6g4OprSOjMIczumi7FShPNsl2KdRxr8lnUCWQcL65NAzKt1sSkXR8kzrK+iU
X-Google-Smtp-Source: AGHT+IFA8ILZyxpvalHdcUvrYRXAImMjPsfc06dTh99YAuCay9XB54B+G0itDJ4enSX9sUVF88M3eQ==
X-Received: by 2002:a05:6a00:6009:b0:7ff:9f67:d47b with SMTP id
 d2e1a72fcca58-7ff9f67de96mr24611565b3a.8.1767390499242; 
 Fri, 02 Jan 2026 13:48:19 -0800 (PST)
Received: from google.com (61-230-44-212.dynamic-ip.hinet.net. [61.230.44.212])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7aa32916sm41546009b3a.8.2026.01.02.13.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:48:18 -0800 (PST)
Date: Sat, 3 Jan 2026 05:48:14 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
Subject: Re: [PATCH v4 1/6] serial: Add Goldfish TTY driver
Message-ID: <aVg9HhznRcwPLMeo@google.com>
References: <20260101175420.4118024-1-visitorckw@gmail.com>
 <20260101175420.4118024-2-visitorckw@gmail.com>
 <618be257-d247-4811-9cfd-e58017aba579@canonical.com>
 <855488fb-4ae9-4468-aa2e-68575ce4dc8e@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <855488fb-4ae9-4468-aa2e-68575ce4dc8e@canonical.com>
X-Mailman-Approved-At: Fri, 02 Jan 2026 23:16:51 +0100
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

On Fri, Jan 02, 2026 at 09:40:39AM +0100, Heinrich Schuchardt wrote:
> On 1/2/26 09:29, Heinrich Schuchardt wrote:
> > On 1/1/26 18:54, Kuan-Wei Chiu wrote:
> > > Add support for the Google Goldfish TTY serial device. This virtual
> > > device is commonly used in QEMU virtual machines (such as the m68k
> > > virt machine) and Android emulators.
> > > 
> > > The driver implements basic console output and input polling using the
> > > Goldfish MMIO interface.
> > > 
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > Reviewed-by: Yao Zi <me@ziyao.cc>
> > > Tested-by: Daniel Palmer <daniel@0x0f.com>
> > 
> > Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thanks for the review.

> > 
> > > ---
> > > Changes in v4:
> > > - Support DT probing with platform data as a fallback.
> > > 
> > >   MAINTAINERS                      |   6 ++
> > >   drivers/serial/Kconfig           |   8 +++
> > >   drivers/serial/Makefile          |   1 +
> > >   drivers/serial/serial_goldfish.c | 109 +++++++++++++++++++++++++++++++
> > >   include/goldfish_tty.h           |  18 +++++
> > >   5 files changed, 142 insertions(+)
> > >   create mode 100644 drivers/serial/serial_goldfish.c
> > >   create mode 100644 include/goldfish_tty.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 6ce0bbce13d..da4a6e4d518 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1259,6 +1259,12 @@ S:    Maintained
> > >   F:    drivers/misc/gsc.c
> > >   F:    include/gsc.h
> > > +GOLDFISH SERIAL DRIVER
> > > +M:    Kuan-Wei Chiu <visitorckw@gmail.com>
> > > +S:    Maintained
> > > +F:    drivers/serial/serial_goldfish.c
> > > +F:    include/goldfish_tty.h
> > > +
> 
> Applying: serial: Add Goldfish TTY driver
> Patch failed at 0001 serial: Add Goldfish TTY driver
> error: patch failed: MAINTAINERS:1259
> error: MAINTAINERS: patch does not apply
> 
> Should a respin of the series be needed, please, check that the series
> applies to origin/next before sending.

To make sure I base the next version on the correct tree, should I base
it on the ColdFire tree's next branch:

https://source.denx.de/u-boot/custodians/u-boot-coldfire.git

Or the main U-Boot repository's next branch:

https://source.denx.de/u-boot/u-boot.git

Regards,
Kuan-Wei
