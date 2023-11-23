Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9008BC5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 11:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D31A4875F2;
	Thu, 23 Nov 2023 12:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="VTkVAehP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD608760C; Thu, 23 Nov 2023 12:24:55 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A1D86FB2
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 12:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-548a2c20f50so1015485a12.1
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 03:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700738692; x=1701343492;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPw+bMY4E7Dpj/4cMaGBweh9u4HbozSb7cMBLhRBdo0=;
 b=VTkVAehPC/56rZeGYuKZ7mrO5HVJ4CVC3Gogry7STJ3ureocf1WAuAfI+0xrkBXzAX
 fDU3qreNZ0lLWZO9BUOigOJrmd+7+5SgvHavUxEMp6e709a4eD+Hty2h5jde+tSqDAOQ
 tkb+QzwdfbpwUXnUBW+D3VnG2+KUFVLT+zuVo3DJ1pNEc/ePtCeMJ+C7Hgb1WF6MvRII
 tTz7rSldbfhGYhzW6oG5ZNys9oDjxgCv2kX3NytBl2lcC/HgHSintPlkpU+96l9JTYll
 c9rBFzxxjEiDDTSnI2gKaP3VWFtnzdrzD0YEsR6EDdDJO30yi0ikyfvSzznSPHgGV1Aj
 BxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700738692; x=1701343492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPw+bMY4E7Dpj/4cMaGBweh9u4HbozSb7cMBLhRBdo0=;
 b=UbK9hVwu6EV89Uv0zI2kGlAq62mz6NSIouHLU5qCsqWXtawt718KBE8UjfOAhKPqpk
 bO7jm3y649NgmrrIyu5OKYi6TUFg9v4de4lsY4ACkS/O2Ob2/JcHTY/rpKaCvLM9Rjs7
 mR+exvxoswsmxBrS3jenGFuehA54Y6fitP7aL9EX3A4/nF/Uw5jFs2bLfNFg2S07bX7d
 x1a0BGXB0rO3eOIbCmDjAypa2c7Y1lvC0B0VWiQg0MZC3xHUDsd1HL+zov6GRHHBTa8J
 +v9MH+alUjSzIlZvsxm5ezVphvDtHqZI5X3n02jvmZZ8UkLLGy/pJpafvp7Z95qewIPn
 ouTw==
X-Gm-Message-State: AOJu0Yxwhg2usqm/3SMjA8VfNPI7I4EbASJI1pu4b8i/F9Dz7ahekWnH
 Vpe+Kk69htIZk+o70S73KhxZAyshNylo/M0n5yU=
X-Google-Smtp-Source: AGHT+IGJ2JG++/xt4Dj3Kxsh1KiqbkwjKVVjWRGDR5SxEnvZ5HTgAffawSLx7jgoExKFqY5c1su12g==
X-Received: by 2002:aa7:d8cb:0:b0:543:52be:e6ad with SMTP id
 k11-20020aa7d8cb000000b0054352bee6admr4591545eds.5.1700738692293; 
 Thu, 23 Nov 2023 03:24:52 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com.
 [209.85.208.43]) by smtp.gmail.com with ESMTPSA id
 e12-20020a50fb8c000000b0053e88c4d004sm521256edq.66.2023.11.23.03.24.51
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:24:51 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-548a2c20f50so1015449a12.1
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 03:24:51 -0800 (PST)
X-Received: by 2002:a17:907:371:b0:a02:9700:bf53 with SMTP id
 rs17-20020a170907037100b00a029700bf53mr3518855ejb.46.1700738691036; Thu, 23
 Nov 2023 03:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20231110141311.512334-1-i@shantur.com>
 <a911092c-78e7-469b-abd8-2aeb9f7e28b7@denx.de>
 <CAHc5_t3ddCnKMBNbe8Cc=dZBXvxyke2p5ydU2dbt8Gt8RH43_w@mail.gmail.com>
 <14da0009-8819-4355-8a38-c9fe926ab3f7@denx.de>
In-Reply-To: <14da0009-8819-4355-8a38-c9fe926ab3f7@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 23 Nov 2023 11:24:39 +0000
X-Gmail-Original-Message-ID: <CAHc5_t0-Mt+-9aBXnD0457YKRyJXHj3oYunq2c35ZaMbmQnqAw@mail.gmail.com>
Message-ID: <CAHc5_t0-Mt+-9aBXnD0457YKRyJXHj3oYunq2c35ZaMbmQnqAw@mail.gmail.com>
Subject: Re: [PATCH] common: usb-hub: Reset hub port before scanning
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
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

Hi Marek,

On Thu, Nov 23, 2023 at 12:06=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 11/20/23 00:03, Shantur Rathore wrote:
> > Hi Marek,
>
> Hi,
>
> > On Sun, Nov 19, 2023 at 8:53=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 11/10/23 15:13, Shantur Rathore wrote:
> >>> Currently when a hub is turned on, all the ports are powered on.
> >>> This works well for hubs which have individual power control.
> >>>
> >>> For the hubs without individual power control this has no effect.
> >>
> >> OK
> >>
> >>> Mostly in these scenarios the hub port is powered before the USB
> >>> controller is enabled, this can lead to some devices in unexpected
> >>> state.
> >>
> >> This ^ part needs clarification.
> >>
> >> Which devices are in incorrect state, the ones connected to the hub
> >> downstream facing ports ?
> >>
> >
> > In my case RockPro64, the power to usb ports onboard is controlled by
> > a regulator.
> > This regulator is enabled as part of init  as here
> > https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3399-rockpr=
o64.dtsi#L177
> >
> > On init, the usb devices connected to the port are powered up, in my
> > case AM8180 (a RTL9210 based ) NVMe to USB enclosure with UAS.
> > But the usb controller is only enabled at 'usb start' and by this time
> > the device is in some state that it doesn't get detected.
> >
> > One way to make sure the devices connected to the ports are in an
> > initialising state is by issuing a port reset before scanning the
> > port.
>
> Why not remove this regulator-always-on and let the PHY driver turn the
> VBUS ON only when it is needed ?
>
> Wouldn't that solve the problem too AND remove unnecessarily enabled
> regulator ?
>
> [...]

Removing the regulator-always-on does make it work but there are few issues

1. regulator is used to control power to multiple ports ( USB3.0 and
USB2.0 in RockPro64 ),
so this could lead to all ports turning off if a phy resets / turns off pow=
er
2. Even with regulator-always-on and without this reset port patch,
linux was always
able to detect the drive on the port, so there is something missing in u-bo=
ot.
3. Looking at usb hub code in Linux, I found that for USB3.0 it tries
to reset the port before
scanning. The comment says

/* Is a USB 3.0 port in the Inactive or Compliance Mode state?
 * Port warm reset is required to recover
 */

i. https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L57=
36
ii. https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L2=
836

I believe this isn't implemented in u-boot and hence explicit reset of
a port fixes the issue.

Kind regards,
Shantur
