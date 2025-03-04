Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE8BC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 05:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2053807EE;
	Tue,  4 Mar 2025 06:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XCXRqMZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24C2F80805; Tue,  4 Mar 2025 06:05:24 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA52E805C3
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 06:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-abf615d5f31so457293866b.2
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 21:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741064721; x=1741669521; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mHVclBqfM+keZP57lQsepIHHJBn89o3IvfdL73ZgaDg=;
 b=XCXRqMZD0p4n9WGOnAb0BlzzpFK/EWlS65nCbjHXBfr2TXE/8Nn1D8Vbu7YfVdtEse
 H/7HtzMBljH33Qau3XG5oNIlPzWXGz2SCw902bVdzpVSf3zVXQ1/2MfJuscBDxD0RcRo
 ZkDwBn0HM/84E2Ghaji4aQSR+AcobqPSlldX9+hRKaOw2xgIV8ZPhjHfDOTBO9Uas4BV
 gjkKCtov69NbpT1OmMDPFOQ6gGwrNehzffCQsTuocArGBzaTyLBVF/nNXZPbDYTsWN2f
 z2d/9JdMv5Bp8Mq/ZBknoIwzrzaI3wR7fnGFQN54HcsVbm05lqoWBMhq7Y4t6N5iCuWK
 NhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741064721; x=1741669521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mHVclBqfM+keZP57lQsepIHHJBn89o3IvfdL73ZgaDg=;
 b=xP0rNRQJ1xNz/cHbqzoGBueIWmQ5eI9ImkLmV6jBgIjcmwkZHxBSYYjKKbVm6Vs20c
 uCPwoOFJJSwRdypfKtlY78IygNTbtqe32gQ/oPjtHSS4UlibzSxs8kOFaaC+1k5hv3XY
 Z6hJrb5Vq055QaGplkKJUbQLSfz5zuWg17vuOFE9OSdQ9aWlmkAkRd/M+t8Nwk0jkrhM
 HaorE1rR5uOzjN7Paa1qBHQaWBLJUzzlvZJPD8ipCeifZGKu/Gvht9mtiixPNyGIgbE9
 t38knypTWXfQNKNV244ZXF3vZgSmTJW+T2ObV6+8xllpin1wZd7W1pbbWgYFSWZdqO3o
 HclA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZKNDz4U7Xg0Efa6tuCPnxQajyffPcjlbnAGACo2ZtPLCUlWbVC/WtX5CQ6mbRtfmIVYES4ZA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/odC8tksTe6Bdg2EIB00M/jTIWz+k30cTA8KiQGrpunnGAZCY
 NuQ8KXnF3wdCJ6cwBeFyaCzi7jW6Yu82Mji5/xRPoOALSpwP4kIjouytjdHJ2aUcWqkgsIL5Jze
 Y1+gQT+auzNJmNhSZAUnxW5Xb0H4=
X-Gm-Gg: ASbGncvjqBjlVg27bXUUEBVNJXs+2tURlWu/fDojdu2tzysCeydkQH+an7nxJIqejTP
 hkdbBUVr4W8H36vObxYvrsOz5n21X1yTwDDIUBAQfDicHy1lQN6bXBH3uPkBq35nAReevKRCHkX
 UVm+G+mdO1JaKb5QZfA67XEOvoLw==
X-Google-Smtp-Source: AGHT+IGS8mBIKJpiVXG41+xOYkJW8WVI/YiMwriQ8SDl9tAcYYAtEaBSDVt4y450b5KeWc0NU+JXxo5pCipKxldS1T8=
X-Received: by 2002:a17:907:2ce6:b0:abe:c894:5986 with SMTP id
 a640c23a62f3a-abf268228f4mr2084534366b.39.1741064720894; Mon, 03 Mar 2025
 21:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
 <CANAwSgSur2VawHniSEZBD3AO63YnvUGf9m1_8p-XMNxQF+yziQ@mail.gmail.com>
 <CALeDE9Nq_xbOc3W8hefPQuVBi_Xc_2r18cw6+jeEHeGKyHEa-g@mail.gmail.com>
 <CANAwSgTu3ixjQRLZRqx_+nHNinDJSdphHHELtiHLANs+LF9YCw@mail.gmail.com>
 <fbzod24w4kjhntzcnt36znqtyfykoao7u6g37wvzejtxxyljm4@w44tbipyhfkr>
In-Reply-To: <fbzod24w4kjhntzcnt36znqtyfykoao7u6g37wvzejtxxyljm4@w44tbipyhfkr>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 4 Mar 2025 10:35:03 +0530
X-Gm-Features: AQ5f1JqtVrQMqhEIHhnCCpbPn9l-6E4SFNA2RX3el3LE-73of8AcIoFj1E1weQs
Message-ID: <CANAwSgTcDL8o_t90+aL0g0FnvoiJE-risKCJBFrYrp9DukmtVg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, 
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>,
 Tim Harvey <tharvey@gateworks.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Maxim Kiselev <bigunclemax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Sebastian,

On Mon, 3 Mar 2025 at 21:36, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi Anand,
>
> On Mon, Mar 03, 2025 at 01:08:24PM +0530, Anand Moon wrote:
> > On Sat, 1 Mar 2025 at 23:41, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > On Thu, 27 Feb 2025 at 06:01, Anand Moon <linux.amoon@gmail.com> wrote:
> > >> On Thu, 27 Feb 2025 at 00:15, Sebastian Reichel
> > >> <sebastian.reichel@collabora.com> wrote:
> > >> >
> > >> > Hi,
> > >> >
> > >> > I have a couple of fixes/improvements for the TCPM code. Three are fixing
> > >> > actual problems I noticed on the Rock 5B, which prevented booting up the
> > >> > system. One of them simply adds an error print before potentially committing
> > >> > hara-kiri by triggering a hard reset, which helps people understanding
> > >> > why their boards reset themself in case there are more problems. I've
> > >> > recently added the same print to the kernel TCPM code.
> > >> >
> > >> I have encountered issues with the Raspberry Pi Type C power
> > >> supply on a few occasions. Thanks for these changes, but it
> > >> dose not resolve the issue completely.
>
> I don't promise fixing all issues with this series. USB-PD is super
> complex. This series improves things and shouldn't have any
> regressions. It also helps with debugging further issues by having
> the extra print.
>
> > > I don't believe the RPi Type-C power supply supports power delivery.
> >
> > RPi 5 Type-C power supply is generally compatible with the Rock 5B
> > for daily use. I also have the Radxa 65W official Type-C power
> > supply for the Radxa Rock 5B board. I was checking the connection
> > messages with different power sources.
> >
> > >> Do you have plans to add a device tree node for this board?
> > >
> > > For which board?
> >
> > Radxa Rock 5B and Rock 5B+ indeed have a versatile USB Type-C port
> > that can be used both as a display port and a power source.
> >
> > During my investigation, I discovered that the Type-C port uses
> > the FCS,FUSB302 the driver instead of the TCPM driver. The
> > FUSB302 driver is specifically designed for USB Power Delivery
> > (USB PD) and supports various power delivery protocols.
>
> The fusb302 driver uses the TCPM framework. TCPM means "Type C Port
> Manager". The chip is not autonomous (like some other USB-PD chips).
> Without a driver telling it, what messages should be exchanged, it
> will stay quiet. TCPM implements the huge USB-PD state machine,
> which knows when a specific messages is expected or needs to be
> send. The remote side (i.e. the power-supply) has a similar state
> machine implemented. Ending up in a bad state in the state machine
> results in the system trying to do a hard reset to go back to the
> start. A hard reset involves removing the supply voltage and thus
> kills boards like the Rock 5B. To avoid this the state machine must
> be tweaked. That's why FUSB302 is not really mentioned here - the
> driver is passing the messages correctly. TCPM is the relevant bit,
> as that contains the state machine.
>
Ok, I agree with your changes,

However, I have a question regarding the Type-C controller's
connection to the PMIC via I2C.
I didn't see a corresponding controller node in the device tree source
(dts) file
that would support this function.

I feel this might be causing issues in maintaining the power state?

[1] https://github.com/u-boot/u-boot/blob/master/drivers/usb/tcpm/fusb302.c#L1285-L1316

> > As of now, I don't have a Type-C power source monitor to test the
> > feature
>
> You can also get debug information from the Rock 5B itself. But
> then you should make sure it has a backup power-supply (e.g. PoE
> or via the GPIO header), so that it does not reset itself when a
> USB-PD hard reset happens. Also this setup has some side-effects
> to the communication itself, since it affects the timings if you
> enable too much debug messages.
Yes, you are correct. I need to have a different setup to test this.
>
> Greetings,
>
> -- Sebastian
Thanks
-Anand
