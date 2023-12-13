Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241B9C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 09:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CDC87015;
	Wed, 13 Dec 2023 10:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BdDiNUM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7625086FB0; Wed, 13 Dec 2023 10:42:52 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D6C087508
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 10:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ca1e6a94a4so87143371fa.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 01:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702460567; x=1703065367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=L/JR9qKNk9W6KYrAY51X+hgio2/ug9n1SoO0Gu4aRrc=;
 b=BdDiNUM34iLr8YaAKKLumqyzwya0y5QcGCK42eBKTbobT999RZ4LRB3yzBQk7fmmyE
 FTMYmXulwSyAU3+/botk1DLSX+MV/mRpfUuEsBDiUIPHDW5JFTv+9fMOq0AnL/z8+bDi
 BLJW+wXfgxmtFly3Prx6bd2w1/Vwbv24Gr1dSncrEDzGd9rZ6gAdpn+qE47I6UgWZG0L
 O+HGlKPt5q3epw4SYdRpD89W9SO1H4ky+bNtStfYUNN4rFgADbMYMl/5JtAnIk3ToC5v
 xHgCzLNxaHXa8Z7I6rAGx8fVRuJiQ0WeQ/LyMxjgf1MA3Utd09xCat51XJCuf4rpox/6
 tN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702460567; x=1703065367;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L/JR9qKNk9W6KYrAY51X+hgio2/ug9n1SoO0Gu4aRrc=;
 b=SLGX44ZPybtqhJkY7/Cq4n3fKtKP5SFzKnCJWQJRO4h4TAuExESxoRuP0L2ggBYWk6
 06elQI1uY4oDkcQUlGzPdAc+1Kd+HvjIDEMhXmts4v/Qh01fcy3RuvBv2roPJA6z19aI
 +HT4sXCn7mB/yFRzQXbTK1icsGt1m8rmvTX+Si8YATvT7IxgXTOSNBWrdzAuB/eae3zH
 ns6O+oChqZbSXVleXtxJNTHqImsUStMA6zyq26L4RydMLgvCSdq4i8ovult+lFFAUIIC
 kFSYm+zoWbF+jXqWJZ7kt6TvX4binDgBrpAUQjlRkaWYr8l52i98fl2i8APv4u4STMEy
 TPXQ==
X-Gm-Message-State: AOJu0YzkwK6h8dckcpNm9NDjYai9HxfybQ8ZeRymlJ5Av+EHIXISslKL
 X3Q34aL6B4nuBBA5eoo3APc=
X-Google-Smtp-Source: AGHT+IEINiT5M2CJdzn5Df3SWb8EQNC2Sy41nuyzWENZ2pgXXWUA42I8+0FTTzCtUyqkNyJ9avt0zg==
X-Received: by 2002:a05:651c:b1e:b0:2cc:1d91:87ff with SMTP id
 b30-20020a05651c0b1e00b002cc1d9187ffmr2642999ljr.11.1702460567189; 
 Wed, 13 Dec 2023 01:42:47 -0800 (PST)
Received: from [127.0.0.1] ([91.204.85.69]) by smtp.gmail.com with ESMTPSA id
 p13-20020a50c94d000000b0054dc979e31fsm5461326edh.2.2023.12.13.01.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 01:42:46 -0800 (PST)
Date: Wed, 13 Dec 2023 11:42:45 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>
CC: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
User-Agent: K-9 Mail for Android
In-Reply-To: <20231115191149.GI6601@bill-the-cat>
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
 <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
 <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
 <20231106210407.GK496310@bill-the-cat> <ZVTo7BKHmwzns_G-@orome.fritz.box>
 <20231115191149.GI6601@bill-the-cat>
Message-ID: <C9328ED4-05E7-4060-BF5A-9CB1BCEE5B00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



15 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=BF=D0=B0=D0=B4=D0=B0 2023 =D1=80=2E 2=
1:11:49 GMT+02:00, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Wed, Nov 15, 2023 at 04:51:08PM +0100, Thierry Reding wrote:
>> On Mon, Nov 06, 2023 at 04:04:07PM -0500, Tom Rini wrote:
>> > On Mon, Nov 06, 2023 at 02:11:16PM +0000, Peter Robinson wrote:
>> > > On Mon, Nov 6, 2023 at 1:28=E2=80=AFPM Svyatoslav Ryhel <clamor95@g=
mail=2Ecom> wrote:
>> > > >
>> > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82=2E 2023=E2=80=AF=D1=80=
=2E =D0=BE 15:13 Peter Robinson <pbrobinson@gmail=2Ecom> =D0=BF=D0=B8=D1=88=
=D0=B5:
>> > > > >
>> > > > > On Mon, Nov 6, 2023 at 11:58=E2=80=AFAM Svyatoslav Ryhel <clamo=
r95@gmail=2Ecom> wrote:
>> > > > > >
>> > > > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82=2E 2023=E2=80=AF=D1=
=80=2E =D0=BE 13:46 Peter Robinson <pbrobinson@gmail=2Ecom> =D0=BF=D0=B8=D1=
=88=D0=B5:
>> > > > > > >
>> > > > > > > Hi Svyatoslav,
>> > > > > > >
>> > > > > > > > Since the proposed PMIC patches have been accepted, I see=
 the need
>> > > > > > > > to convert boards which I maintain to use DM drivers inst=
ead of board hacks=2E
>> > > > > > > >
>> > > > > > > > Svyatoslav Ryhel (5):
>> > > > > > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM PM=
IC
>> > > > > > > >   board: endeavoru: convert HTC One X to use DM PMIC
>> > > > > > >
>> > > > > > > Is there a reason why the two above devices don't appear to=
 have their
>> > > > > > > =2Edts files in the upstream kernel?
>> > > > > > >
>> > > > > >
>> > > > > > Yes, there is a reason=2E Linux maintainers treat submitters =
as
>> > > > > > existential enemies or as dirt at least=2E I was trying to wo=
rk with
>> > > > > > linux but I have no desire to spend any time to upstream ende=
avoru or
>> > > > > > lg_x3=2E
>> > > > >
>> > > > > The usual policy for acceptance into U-Boot is to have upstream=
 review
>> > > > > in the kernel first=2E
>> > > > >
>> > > >
>> > > > May you point to a policy which clearly and explicitly states thi=
s as
>> > > > a mandatory condition?
>> > >=20
>> > > There have been a number of devices rejected in the past until thei=
r
>> > > DT are upstream but I'll leave Tom, who I've explicitly added on cc=
:,
>> > > to clarify the exact policy=2E
>> >=20
>> > Well, here is where it's tricky=2E I brought this up for one of the
>> > Broadcom MIPS platforms a week or two back, and Linus Walleij's point
>> > (and I'm paraphrasing) is there's not really an upstream for it to go=
=2E
>> >=20
>> > What we cannot have is device tree bindings[1] that aren't upstream o=
r
>> > worse yet conflict with the official bindings=2E
>> >=20
>> > So the general way to resolve that is have device tree file be drop-i=
n
>> > from the linux kernel, and what additions we must have be done via
>> > -u-boot=2Edtsi files=2E And in turn, some SoCs are better about keepi=
ng in
>> > sync with the kernel than other SoCs are=2E
>> >=20
>> > Now, upstream being actively hostile to dts files, especially for old=
er
>> > platforms? That's unfortunate=2E So long as we aren't violating the r=
ules
>> > about bindings, the intention is that we don't have device trees that
>> > are either (a) massively out of sync with the kernel[2] or (b) kept
>> > intentionally mismatched from the kernel=2E
>> >=20
>> > --=20
>> > Tom
>> >=20
>> > [1]: There are both examples like binman that Simon is working on at
>> > least but this is more exception than intentional rule=2E
>> > [2]: Per our other conversions, I know the tegra ones are in this
>> > unfortunate state in general
>>=20
>> On the Tegra side we've been fairly lax about the device trees in
>> U-Boot, I suppose=2E The assumption had always been that U-Boot would l=
oad
>> an external DTB and pass it to the kernel on boot, so keeping them both
>> in sync was never a high priority=2E
>>=20
>> U-Boot does only a very tiny amount of what Linux does, so dropping in
>> the kernel DTB always seemed a bit overkill=2E
>>=20
>> In either case, if this is problematic, it's something that I could tak=
e
>> a look at=2E Again, it's expected that the device trees are different, =
for
>> historical reasons, but I'd be surprised if they actually conflict with
>> one another=2E U-Boot's DTB was always supposed to be a subset of the
>> Linux DTB=2E
>
>So, the issue with U-Boot and kernel device trees being out of sync is
>that we then can't support the model of "just pass the current DT to the
>OS"=2E This in general is good to support because it means that even if a
>given platform isn't formally SystemReady IR certified it's still likely
>to be functional=2E
>
>The most strict rule is that you can't have bindings in U-Boot that
>conflict with the kernel, or should be in the kernel but aren't, and so
>on=2E
>

So you say that U-Boot should support only components which have linux dri=
ver? May you clarify?
