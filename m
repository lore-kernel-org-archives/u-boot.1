Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D51C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 09:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB63E8082D;
	Wed, 29 Jan 2025 10:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J1pgltls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC79280107; Wed, 29 Jan 2025 10:27:34 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC19A80107
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 10:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so72867775e9.2
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 01:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738142850; x=1738747650;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lSOVOyHvXiMzxtJGo+qlCyg9IYRAezdr3qRj/JHJkM8=;
 b=J1pgltlsQ55+Qn5nPkb+6vbxP02vN2q+FuE04wF5gaxQ7Pv+Y+AiRTFPF7Fo9ZX+fW
 1lOdNRWy5bf5YcEpzHgtzkCgvn23cL8Y5hXlLEZx5BFdjn99Z5BgFfONcfNboE7YVc7n
 oazLp/vIEUykl3MnR2O2zYVt/ogXksZLUWTSUBvpQplhNJ+94tPbitNBuHQf19wKPGpZ
 WkBuNmXNymSC7jGWz8mc+DvshrnIqVWPWsrULonzcBfNvmWr+IC3+7YlHrGevwLOvAvs
 aw2l/s805dRPNpy6B8B+FYpw+3yghARXBk2Y+4YhYhsswJTfPeFSnreuC6mIQNTSiaNb
 XhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738142850; x=1738747650;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lSOVOyHvXiMzxtJGo+qlCyg9IYRAezdr3qRj/JHJkM8=;
 b=Z0fyIpC9VuW3h8RbEnCxVFFrfQHwtiyPF0uqyopXr5m3QhP0EfvXF/sSWHels6c5x0
 Jzr3yo7cqDJw3eGB0Xu7R9+fVJ3WrYvnPzJ7GdKUdRKHFAO1vMxJGOr2jIlXJ/mAGulG
 Aw8V0equIzjQp3XwVeb7XcedpLlD7MYQOapGHqJYSotEudwVmtcSwa5vVhB+JYgCg+tI
 H0iN5O7Uaw6oRsnS/w28uIlxPHbQEaq3W8f/xJBbsgQkt4dWMwx4NL/Wh/Zl6rA/khtS
 ybRBx4+afNQzO3Fi7q2q6c/Bx8+J0PRwvIEicjSVxH+1gaoexcDEum3FZBQZQFMmCoDK
 XAGA==
X-Gm-Message-State: AOJu0YweyVyjOD6r1zhG5+DhjqEywfkKKDjgAar5wWD8JsTB+/Syz6OM
 TVg8XqQhhzk+A1YYj2in41+1IdiGpOWImHSL1BD1AZjykf8mueMDqOBf6OrLY64=
X-Gm-Gg: ASbGncsq5lQpwlGQndudg5WyqtIL2xiKEGgjcToAe2lIT7xs9rgoR/YhigOTGXZwJIf
 5cbElOyXzFQeDgz8wjKXHyc5/xntxIecZrhDdIotHOcqoWfCv20xoN4FMv6MxYjtQpy0uiIuey3
 J61nxI2W1gaLyt56p3rlsiHDOPWtuRm33Py+NZ1svT77b6nSRhu/l96RfEer25Lju0zxLwv9seV
 YAj4xX8g2k8sQKG02KQex59gEG+GulyDr/1+2+fILW506uZyGy+p1ftcLk4duvU7avzbYm78KhJ
 iLcO8DDqHxvOnj7hffGQp3WKOSUSHcLzDn4=
X-Google-Smtp-Source: AGHT+IF6VOgnSMcGs4pnmJSzjR1Oy8+cIswBWwncOfBWKd0Uc3lbtwcMJjNwN86JWeAmfMe/LIf7Og==
X-Received: by 2002:a05:600c:b8c:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-438dc34ba8fmr20668985e9.0.1738142850369; 
 Wed, 29 Jan 2025 01:27:30 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc23bf7sm15869045e9.9.2025.01.29.01.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 01:27:29 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Michael <michaelsunn101@gmail.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, Heiko Schocher
 <hs@denx.de>, Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v4] usb: gadget: g_dnl: Fix NULLPTR dereference when
 serial# is unset
In-Reply-To: <CAH40Y2gE1+EJcDgdny_Ed85pycF-0GaFATCXxRHNww9L2DLeFw@mail.gmail.com>
References: <20250128030945.1219589-1-michaelsunn101@gmail.com>
 <87o6zrqns9.fsf@baylibre.com>
 <CAH40Y2gE1+EJcDgdny_Ed85pycF-0GaFATCXxRHNww9L2DLeFw@mail.gmail.com>
Date: Wed, 29 Jan 2025 10:27:29 +0100
Message-ID: <87ikpyq8am.fsf@baylibre.com>
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

Hi Michael,

On mar., janv. 28, 2025 at 23:31, Michael <michaelsunn101@gmail.com> wrote:

> Are there any other action items I should take care of?

TLDR: no.

Details below:
Not at the moment. Usually we give the community some time to review.
This time depends on the custodian(maintainer) responsible for taking in th=
e patch.

Since I'm responsible for fastboot, I usually give between 1 and 2 weeks
before I apply the changes to my tree: https://source.denx.de/u-boot/custod=
ians/u-boot-dfu

When the change is applied, CI will test your patch. If something fails,
I might reach out to you again to help troubleshooting.

If it passes, I will later on send a pull request to Tom with this patch
included.
Once Tom accepts the pull request, this change will be merged into
master.

More details on the process here:
https://docs.u-boot.org/en/latest/develop/process.html#work-flow-of-a-custo=
dian

Hope that clarifies things a bit, and thank you for contributing!
Mattijs

>
>
> On Tue, Jan 28, 2025 at 3:40=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Michael,
>>
>> Thank you for the patch.
>>
>> On lun., janv. 27, 2025 at 21:09, Michael Ferolito <michaelsunn101@gmail=
.com> wrote:
>>
>> > The current behaviour of this function will dereference a null pointer
>> > if the serial# environment variable is unset. This was discovered on a
>> > board where U-Boot did not have access to the first 256MB of ram,
>> > resulting in a board crash.
>> > In the event that U-Boot has full access to memory, it will still read
>> > from address 0, which is probably not optimal.
>> > This simple check is enough to fix it
>> >
>> > Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
>> > Cc: Marek Vasut <marex@denx.de>
>> > Cc: Heiko Schocher <hs@denx.de>
>> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
>> > ---
>> >  drivers/usb/gadget/g_dnl.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
>> > index 631969b340..f2540eb6de 100644
>> > --- a/drivers/usb/gadget/g_dnl.c
>> > +++ b/drivers/usb/gadget/g_dnl.c
>> > @@ -207,7 +207,8 @@ void g_dnl_clear_detach(void)
>> >  static int on_serialno(const char *name, const char *value, enum env_=
op op,
>> >               int flags)
>> >  {
>> > -     g_dnl_set_serialnumber((char *)value);
>> > +     if (value)
>> > +             g_dnl_set_serialnumber((char *)value);
>> >       return 0;
>> >  }
>> >  U_BOOT_ENV_CALLBACK(serialno, on_serialno);
>> > --
>> > 2.48.1
