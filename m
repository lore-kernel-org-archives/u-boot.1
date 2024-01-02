Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867BFC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 09:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF51286FF7;
	Tue,  2 Jan 2024 10:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yAtcspdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C667186FF7; Tue,  2 Jan 2024 10:52:41 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED23864F3
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 10:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d8909a6feso11802985e9.2
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 01:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704189157; x=1704793957;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DLQU7NY3NJ7t+TwsX53zsuSdJv9FduPiMqAdm8h/YLQ=;
 b=yAtcspdkUV3TPVUwgboUmeZR0mMfh7FYDdFJooW0M+gQYtLpZaB+OnjB7G3bhMHKxB
 sqTANeUw+S+xcnc3GxS77O7m+YUBBRtkzi8tclxFjJpfK1UBhBwCccG4RKl3cD4Q+wpX
 FqKEdu8imQXu4C2tqkW/Bh9y317uTPf1xJFxwtQ1hwmjBgy5X34RirMhmhXOxT+Ul93S
 psUpzJt7dfV+YWgfPXVGmmqSJ0w02DDVQBNbvmW9cogMae/j0w8PcJToI/AVA7RND+sH
 FdFp//zYYXHYUGCc6AcoxYm0O3CXTLuSlmvMjPgWT2WXJ4lQoJo8ifViXi53BInWDzBz
 47xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704189157; x=1704793957;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLQU7NY3NJ7t+TwsX53zsuSdJv9FduPiMqAdm8h/YLQ=;
 b=NwJW7VQCt4WciWZs4MO51zFaCavCyr+cBXGNoIjkDnrnG5lHB6euBzBbPWPacQZDRL
 W7D1KLtfMwYR0T/RVoEyFDRk68VKSFldiTylAGivFM1/xBlsiAeYPzaDwULRVxIQLSPv
 2ilIhQKd+AEsrkYNkUNAY6myj7E53QAzOH9BShuppbNLcdLB/D13wxvAz8N1iz2/nzla
 Gwwbcm9YDjRngQrFIs0qUzz/8j9B1xR97aq3vPdEFaWzGqSXbrJdkpGcX8lfCp9o/rAa
 VGxUCfwcZhm42xgBRQZX0yq5EwOj7Ijgr2yq+FfPQVKFVc5/1fmOhn6m1x+anejnfriF
 nZAw==
X-Gm-Message-State: AOJu0YygLeFMeOZ2MCRnLgQqlsEldDRAO8YJ1HtAywQaN8OWGmqYc4T1
 4l4YdflYs+rcFjk38sbOi14KSrxz84r+cw==
X-Google-Smtp-Source: AGHT+IGxNlRShJMP7c8TOwXkzl+3MUFP7C7SlEpe4+WLazkgpFR2TS81PvT/l1WoFOHmx2B96gAtyQ==
X-Received: by 2002:a05:600c:524b:b0:40d:8780:d40f with SMTP id
 fc11-20020a05600c524b00b0040d8780d40fmr1078710wmb.17.1704189157234; 
 Tue, 02 Jan 2024 01:52:37 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05600c35cc00b0040d2dfb10e0sm49474567wmq.11.2024.01.02.01.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 01:52:36 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, Sean
 Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>, Dmitrii
 Merkurev <dimorinny@google.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v6 4/6] common: console: record console from the beginning
In-Reply-To: <CAPVz0n3OwhrW41tV9x32UXyL6yZdLr8CU9S7XuTneDiwUQY7AQ@mail.gmail.com>
References: <20231228180154.50473-1-clamor95@gmail.com>
 <20231228180154.50473-5-clamor95@gmail.com>
 <CAFLszThd95iSPMOBr_21_Zckg74BtgA23EVpfXQKqnArFc-UDQ@mail.gmail.com>
 <CAPVz0n3OwhrW41tV9x32UXyL6yZdLr8CU9S7XuTneDiwUQY7AQ@mail.gmail.com>
Date: Tue, 02 Jan 2024 10:52:36 +0100
Message-ID: <8734vg5afv.fsf@baylibre.com>
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

Hi Simon, Svyatoslav,

On Thu, Dec 28, 2023 at 21:52, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D1=87=D1=82, 28 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE 21=
:48 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>>
>> On Thu, Dec 28, 2023 at 6:02=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail=
.com> wrote:
>> >
>> > From: Ion Agorria <ion@agorria.com>
>> >
>> > Set flag to enable console record on console_record_init
>> > and not only on console_record_reset_enable. This fixes
>> > missing start of U-Boot log for fastboot oem console
>> > command.
>> >
>> > Signed-off-by: Ion Agorria <ion@agorria.com>
>> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> > ---
>> >  common/console.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> OK, I can see the use of this...but I wonder if we can now get rid of
>> the same line of code from console_record_reset_enable() ?
>>
>
> Interesting question but let's leave it to a dedicated patch :)

I've looked a little more into to this, and I'm not so sure we can get
rid of the gd->flags |=3D GD_FLG_RECORD; in console_record_reset_enable().

Removing the flag seems to break quite some tests in
test/py/tests/test_ut.py.

The breakage can be explained that various unit tests clear the
GD_FLG_RECORD with:

	gd->flags &=3D ~GD_FLG_RECORD;

Therefore, I would suggest we keep the flag in
console_record_reset_enable().

>
> Best Regards,
> Svyatoslav R.
>
>> >
>> > diff --git a/common/console.c b/common/console.c
>> > index 6f2089caa0..e6d7ebe935 100644
>> > --- a/common/console.c
>> > +++ b/common/console.c
>> > @@ -821,6 +821,9 @@ int console_record_init(void)
>> >         ret =3D membuff_new((struct membuff *)&gd->console_in,
>> >                           CONFIG_CONSOLE_RECORD_IN_SIZE);
>> >
>> > +       /* Start recording from the beginning */
>> > +       gd->flags |=3D GD_FLG_RECORD;
>> > +
>> >         return ret;
>> >  }
>> >
>> > --
>> > 2.40.1
>> >
>>
>> Regards,
>> Simon
