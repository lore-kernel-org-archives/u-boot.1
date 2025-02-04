Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E63C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 14:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3269D800B3;
	Tue,  4 Feb 2025 15:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gX2oIhhx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88047801DE; Tue,  4 Feb 2025 15:31:26 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 352FD80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 15:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso58075215e9.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 06:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738679483; x=1739284283;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B/aHlxGX+F8PzA+Mih5SQEWgN9IkTZpHldCaIx6ewU4=;
 b=gX2oIhhxxgikTpz5vlz+AeHSbfZvVzeLltSUN+ERlZ9Q066fKgpFsyw8tmcKGVnEB6
 bKR0qR7ddwwOpEF7yWFm5LXDq7Gykkrz9Yi4MISN9wk2v/C3yNGtf3098hxGC3wTyjZd
 JZkizxrz9HJ5YZEvLniSYT0xDRWTBCRSZLkA9cZUBtJEYabDg3FR3+q4gdeonkq8eIZA
 Wbw4Kn3es+uLt/NgGmDl6RERt1IA4JVRQZrCoiiJy7+h4h2E8fzJdL5QRQYvFNYTO10e
 q93Yf7+kdAyoUYKz2nIXkkaWVOzAMFuYfALsyCZ719jTZCDDFGZ44ow5UBLq1rsrAFKA
 glrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738679483; x=1739284283;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/aHlxGX+F8PzA+Mih5SQEWgN9IkTZpHldCaIx6ewU4=;
 b=qQHynmT7lAAC8Jf8nrj0pWKVoDFyXci58cWJI2Zju//MF/XJERQYMT7gWA1OzvJSZb
 Y72i2F0L+veJq/yjdU3XEZl3Tz0rI+Xpfcgefl0VFQq38PZNtRt5qf69KH9f84Fg3m3F
 D3SN2IOZvADaTboKYNOapzp8bRyXTKltckh0hH+2loCBVxbtfBcmDAmJkPXjt0bnftP5
 +xBs5IuFtZNvTYarBFql9B5aI7G/aIe0TQvqzXSvvU+cbEOGfuyB2VJCLa6BN3dsdWDa
 NrvZyd77+MU4itJNmyYddZVESC2q7T6Cnsh31J4F6j54+nOZx93D3+bVyu/uw2GnO+Ic
 R/lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpXW0gmRe+2xO6YgW8dcVoAB4Gmw/xEg3/4QybL8nHHYvpboMtPQo8unCQvTD81/spPMaf3SU=@lists.denx.de
X-Gm-Message-State: AOJu0YyWxwJUCMz3WfNvg2WvzskFh0uuYWff9+lE5kTKrtHyP8ACv4vW
 iquNZRAyiEo1cJKlWroWj5wk3DndIbkrBJj+LksERVMVbTJjyhxQQ7lObvFcXvM=
X-Gm-Gg: ASbGncuzbWOXmHVRCK5xv+J4EtvbgRC2GWZmae4SkntwizePNKZXTK18h6Y0OgMdTUM
 uwWNyKAx3ZtUqfSfbAXeBJhxk3MCp9eP4wVnQBZDWhhM9vlJoxrQwwQahSm+zx8PKJaglo3qjXr
 1qFMiZ0hD3U5IKvEboKYTQDUSF0Rcc4Vw5U4GnZqlNCZk2ZQ7pf8erhrLqzgMyCM+IZP+Zch9ai
 THGBy9EeCqPQmTVWnZKV31/0iVDnGpfsICGeAYmyiaQzX/AnVzYw5raNHueIRTeYWDFX2DB6GbX
 uD4eBQD8ztByKg3Yn28=
X-Google-Smtp-Source: AGHT+IFkcbiF5BM7fpSEQBmp7kqo/XNKmeJOK7Vnl562Q6KAVngy+c0q1UHMyEUxb2eik+FBa00vJA==
X-Received: by 2002:a05:600c:19d2:b0:435:330d:de86 with SMTP id
 5b1f17b1804b1-438dc34b37bmr248796445e9.0.1738679483507; 
 Tue, 04 Feb 2025 06:31:23 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23de016sm195911975e9.9.2025.02.04.06.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:31:23 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jon Humphreys <j-humphreys@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 s-vadapalli@ti.com, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] dfu: Prevent set_dfu_alt_info() from overwriting a
 previous value
In-Reply-To: <864j1apv38.fsf@udb0321960.dhcp.ti.com>
References: <20241217204835.3312765-1-j-humphreys@ti.com>
 <87ed25w4xm.fsf@baylibre.com> <86frmk4mhd.fsf@udb0321960.dhcp.ti.com>
 <87tt9z889e.fsf@baylibre.com>
 <CADg8p94zxnHuFH=hJDkxZm=_DOGOtYusM=twRQLRteYUy-CR3Q@mail.gmail.com>
 <86a5bqpgcs.fsf@udb0321960.dhcp.ti.com>
 <CAC_iWj+94Vi1v3XL2HTtJtj56JiGJkC2BN2T3mxOHG+MS586sQ@mail.gmail.com>
 <864j1apv38.fsf@udb0321960.dhcp.ti.com>
Date: Tue, 04 Feb 2025 15:31:20 +0100
Message-ID: <87r04dkchz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On lun., f=C3=A9vr. 03, 2025 at 15:38, Jon Humphreys <j-humphreys@ti.com> w=
rote:

> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:

[...]

>>
>
> I went with option 1 above.  I started working on option 2 however the
> changes are quite invasive, touching all of the DFU interfaces, and I do =
not
> have the understanding of the different DFU use cases nor access to the
> different hardware using those use cases to test.  I also think that this
> change should be part of a broader DFU cleanup to use only the latest
> dfu_alt_info string format allowing multiple devices, so that we no longer
> need to pass around the interface and devstr parameters.
>
> Please take a look at the patch series titled "EFI Capsule update
> explicitly sets dfu_alt_info" that I will post shortly.

For future reference, this is the mentioned series:

http://lore.kernel.org/r/20250203215351.2840144-1-j-humphreys@ti.com/

>
> thanks
> Jon
>

[...]
