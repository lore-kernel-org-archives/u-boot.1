Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FCCD5E37F
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 20:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8EBF892FB;
	Sat,  9 Nov 2024 21:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MkXoZ1x2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A7E89313; Sat,  9 Nov 2024 21:07:49 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E2EC892E8
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 21:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2b9480617so2650396a91.1
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 12:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731182865; x=1731787665; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVeQEnmIY7HsVpkBD/LrsGd2y+wT5gADxEsx4HnoQKY=;
 b=MkXoZ1x2v1GFykZXv36TcxERrxb0Pl7w6VQxV+dHZKggRuETQ0jJAPoz9L99F4CgFc
 o/tbn1v6rnLirtjR54RUhashdV6ByzVQnU+1InWFltigC9kFbSGkt4aKAEC9LVezSnoR
 R97JwqRClJM2r6dkn9iiVuMJUpnNAYJFUWVVPg+qocf3dIq4gm84h6x0LWW1snedPhQT
 Oe8Q4VFZQtKsfBEez81eTY7U1epnYcHo//4ZjO/Et0z8hAr+S7sFwZM/eaBHJXrFQ8iw
 JQh9Qw5YF092hWXigJ3er0GKzKaZ0KovawWL39cn/4cy9ukRNSleUN+AVza56txzzCAb
 KJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731182865; x=1731787665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVeQEnmIY7HsVpkBD/LrsGd2y+wT5gADxEsx4HnoQKY=;
 b=IPXWNKrP1N4dOAWCDxeBzimq6+mY/U/7weVsCOq8XpSdZhu0fUAHOr8WUB+QBTZTkC
 UQjrP5ZSEgZRgWqWwa7nZfPx6xX9zp15Y6IFaD33clv/+wQxiTtzjiQ1h6e4WpLdudM8
 2iPTBHfbpPGqcuTPUpeAWgB+QhhdJlERA7ZDAO6d+QBDwGRACRVX77tmAFSuudDFRH6h
 L5PUPU6DFWPRIf374ADn9AuutbzJi0Jzln67dxXB+Uq5tqwMf1d2yH/3xGg3v+KOWIen
 IuziTbysQcIvLKHEkCZUkIVrtu2BCe/3FAX2etTgZtE5QU4BgOSfqj797YUsrJq07sD1
 pOOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEZ65ahGswC5ItV/xLWPnAAEd+O/dlmD1qgNnSCtYMs2F4CMbVgvoETB+viUPv54sUoZZnUas=@lists.denx.de
X-Gm-Message-State: AOJu0YzEY804NdIhFbV7FbDmtrI70iPXljGGYsJH6l34ffRlYenPovgI
 QujqdmBmy4afywdu/f/ttorMDwpmqqDCHDF/iKQvMRr8v/AbfLZY5WeKHYo2rP4kSCkvbIhnSkr
 /mzEK89FdrQKo0D+rZ5lD/OYr5dM=
X-Google-Smtp-Source: AGHT+IHSouIP+NqICxj26pTjX9b3YiKoXT5c6sdcj/0Q31M7Bio925gGQ2cKUdkU1pMHK5X17L+KD/Vot1PhSQ4L+sw=
X-Received: by 2002:a17:90b:1d88:b0:2e0:d1fa:fdd7 with SMTP id
 98e67ed59e1d1-2e9b172af9cmr10094139a91.27.1731182865392; Sat, 09 Nov 2024
 12:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
 <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
 <20240905155402.486a7110@wsk>
 <CAHCN7x+jLfzMGFUcbAfHr9u_2s3Z=LxN-TNCtbzUUop66p4Rpw@mail.gmail.com>
 <CAHCN7xK3-iUUGf20-JxAWfK05-te=sskbdpU4kU8ahy8sfROFg@mail.gmail.com>
 <20241104091418.74acd1f1@wsk>
 <CAHCN7xKGW2+_8P0nnMM6gyJVPQOw15S2pFUhwwuv13JVqY3qNA@mail.gmail.com>
 <CAHCN7x+K14RkvbDdCHPq+YaH7bXSBH-6Sdwnb1+TULCE-H5puw@mail.gmail.com>
 <CAOMZO5CNfgBaEu+eiqq8vnOe5ro+a_fQpJigauV0vcPjdODHrw@mail.gmail.com>
In-Reply-To: <CAOMZO5CNfgBaEu+eiqq8vnOe5ro+a_fQpJigauV0vcPjdODHrw@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 9 Nov 2024 14:07:34 -0600
Message-ID: <CAHCN7x+ga0E13Lhtw9z_eTVRyB7jzBjxR1XYnHRZzw+JP4v-Bw@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>
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

On Fri, Nov 8, 2024 at 8:16=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> On Fri, Nov 8, 2024 at 11:12=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
>
> > I think I have a fix for the Nano.  I want to get my hands on a Mini
> > again to test it.  My solution creates two files, a flash.bin for
> > booting SD/eMMC and a second file which adds the FSPI header at 0x400
> > with the whole standard image starting at 0x1000.  I have been able to
> > boot both the SD and eMMC's with one config option which can allow me
> > to remove the FSPI config file and consolidate both configs into one.
> > Once I can verify it works on Mini, I'll post my proposed fix.
>
> Thanks, Adam. Appreciate your effort!

No problem. I managed to get my hands on a Mini, and I just sent a
patch series which restored FSPI booting on both the im8mn-beacon and
imx8mm-beacon boards.

If/when I get some more time, I might try to port the stuff I did for
Nano to the Plus since I think the boot ROM is similar between them.

adam
