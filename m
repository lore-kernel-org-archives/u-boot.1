Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E66FD1BDDE
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 21:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7C8383C98;
	Wed,  3 Dec 2025 22:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c1Zja/cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F2283DA7; Wed,  3 Dec 2025 22:02:49 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5300F83C08
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 22:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6cc366884so111099a34.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 13:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764795764; x=1765400564; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzTUTTWLDjOg+v8sFIhYlOOQ1y5snW+xPSBOcKhovOU=;
 b=c1Zja/cc+4TNuPNHudIDpp+DZEEsi+B1OVRJlZ55VJiAJSdsRlxovn6+M1CAPgHb1A
 McMwaM49JoDB2uEL3PGAjUdftB67pQ+wmDWF5m2odqHtH2kC6nfpjV8N55HkDlPOIGRd
 6Bur1E0m6upRI4ZsE8fAZHvmeQjxTo/phQFPYm26kNI/Tqlc+ZuBK5PF10K4Jv9JLmOf
 iC7BSz/Hwip708wWYx/KtdxKQUcT2OX2YPCh0O85E4tn5PCRfZy4PKaSwO9d5L0665Ae
 Duakqtzb9n7YKa43nqI/jcGKjFcxvxcc82C0eBoiQvhlXWrwJOjH8Z9IrYXb3cK+qz8T
 TtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764795764; x=1765400564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TzTUTTWLDjOg+v8sFIhYlOOQ1y5snW+xPSBOcKhovOU=;
 b=bgTk8l1pa+ITAhOR3DOa4pBQRZgLHaKtmkzeBviw/1G3yxld5DVa1QodXnmlHC8E1V
 Wv5z0T8kDM9dC+ov145O/O2CDWMOA1CsQVUtHMU3USUjMEGP9mDfqZn9cl/RL5pXCkMO
 0lUhmb2NDySOfkAfwl92UZFYBh1gxMD3KRbU8sCJfzRM5b9LkGsUhXglBBfZDYEP+sLH
 edlIEWsVXzvI0PF3xRMm0uXQTtYuWYfSo+B7tW+GiwY1ycW4ob1J8O7hXFZbsp2RVQjJ
 0n9SfvAkeXguMSTBwansTHcDCfemzdFROzlK3Wv1YTDKDe6WJq0piAlbKuRvvMRX3YCy
 G6iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgFKqNs5H1BxmcVawfKySzimY11VSqt1uWg8gz5ge+1lNew7t5d5EHBtxoyImALhY/4gOT1AI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5aspEVfsKEoaggGUZLBZhQ4kXijfrDQxcjwgZhD3QsjuTAhcR
 DHY6lHKosUwVu8zW3Z1+9FaXkSwXedcMobTQCyUeYVYcBBv/QCTeNW/HLQgHL4avv9E+6PAUcS5
 mgIlGbkTcaIdQTXiOjq/4ODVni2W3idU=
X-Gm-Gg: ASbGncv63NqaYa1H6rogworxvWgChwDp000VbxOwPLr7Hd/+S0iaCzZnlP6Gfi1NUbL
 l1EzXxtzSyy5IBM3cKA5Qimdm67xgj2W3UXYoHys27iZ2wAfpe1TPNRRiE7jjBc3CCUE2es3KX+
 o9mq7UGyPFy8Zgt1cqxWQatcjKGS6i48TAl9QdtZxNEpFqVn+td4EkvpBNbxo8nwIGn1jTgcQta
 vtCv2bVXo0odY/n2HW4PO181RuUeqo/R3Y7v/9TC2+zVhkedKQmDqG6ACnG54y1svht9YU=
X-Google-Smtp-Source: AGHT+IHSsXmDSYik2+6RHj9Bx4MqDSwd+SjLR+ydsL02S/JA5SrtiuveQKHuQMXjnVhRTJOSKe4kt+OHai4p2NaEbG8=
X-Received: by 2002:a05:6830:2b0f:b0:7c5:3798:fa44 with SMTP id
 46e09a7af769-7c94db40316mr2353556a34.12.1764795763934; Wed, 03 Dec 2025
 13:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
 <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
 <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
In-Reply-To: <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 4 Dec 2025 05:02:34 +0800
X-Gm-Features: AWmQ_bncFv131qDZqqNd54EiNiyBnDRCQv3IAGzCfM7cgj72Wzfd6iTK8EltNVQ
Message-ID: <CAN7C2SAjdQMUA+7sbeOgVg7stk_mvxVXomu+PO4+ENGbgAviTw@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Ralph Siemsen <ralph.siemsen@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=9C=88=
4=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:52=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi Brian,
>
> On Wed, Dec 3, 2025 at 1:17=E2=80=AFPM Sune Brian <briansune@gmail.com> w=
rote:
>
> > But did you disable also all "CYCLIC" as well?
>
> I have "CONFIG_CYCLIC is not set" which disables all the others.
>
> I also have another patch to disable the watchdog, adapted from [1].
> This didn't seem to make any difference (but my ram calibration
> doesn't take very long).
>
> [1]  https://lore.kernel.org/all/20250603115442.19971-8-nareshkumar.ravul=
apalli@altera.com/
>

Hi Ralph,

I do diff the mainstream and Altera trunk.
I cam repeat the same behavior on altera trunk when all WDT CYCLIC turned o=
ff.

I plan to investigate under another board.
TBH if it is board specific case then there is nothing harm to simply
turn on CYCLIC or WDT.
But the truth is that Altera trunk force using designware WDT by default.
Because under distro I do full "memtester" and "stressapptest".
Nothing really fails on those two.

> > 3) I use socfpga_cyclone5_defconfig and only change minimum settings
> > that I needs.
> > From this issue mentioned to current day.
>
> Then it sounds like it is a recent issue... hmm... I'm currently on
> 2025.10 release version (plus some cherry-picks). I'll give a try on
> master/next once I get some other things stabilised...
>
> Regards,
> Ralph

The major reason is the ECC on mainstream is completely missing.
BTW [1] I do manually inserted and test no luck on that.

Yet still thank you for the help.

Brian
