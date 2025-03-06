Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07323C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 19:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1657280E94;
	Thu,  6 Mar 2025 20:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NoGMpV2B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BEF080F4C; Thu,  6 Mar 2025 20:00:31 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D9E808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 20:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e56b229d60so4097389a12.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 11:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741287627; x=1741892427; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GvsQPsxTCWMUgeMIlVlJ/ZTRmPIsmu+A+92cKhOqQGQ=;
 b=NoGMpV2BvAvpe1r1GkdCd1nnxKVY+8GdYgLI/NmwNWAjYz5EK+exk1/pGYToEq+5ws
 UewNKsjF99B0EmL/w1oHup6zuOoIvuZ58zNoFChYw4ga3Ci+n7DTyeeny/TREhRg/sfg
 bTyF62F8w4D8XIRcc51jmKmqJEBRQZ8S3ADLOrERhV/TayZQ/G1ZNG7E0+4Kv53wlqAs
 dDoIjySN9ZC875L6pgL1UhXemd/ZgmYtcJ2wnnt/PIMTlefwvsrChBfB2u7ZxFsZr556
 fhzyuAuC7rdJgwC+zFF84ZwljWOJjdBYFA287y6OnFyxZMJdRcffZTbuD1eYIkJF3EXN
 gqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741287627; x=1741892427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GvsQPsxTCWMUgeMIlVlJ/ZTRmPIsmu+A+92cKhOqQGQ=;
 b=bD7/GaAdkjOTJJSnuJ+MwsPv6UkBxb2/PnHm7dfKOflc9k20z9VpLxyW7zaXXUIOkF
 bK+om73Aw1EYfaX44hAitiaaBh9/BFvs+PLG2aJkoEPRvpFoVEJC1ipBofb1J8Ds/0KX
 hE3SDsSfTXPbwdXY7LL9HJOTkY3UKZYH1imzckxgzVqDdwIvbCbDpygV33/goOL12FBp
 U4CkNLoNcPhC42eRtlvJEdi596H8RWtkNPY0ZqV8/tzIzt+jBFxvDwvNHzjZzk3JPiJt
 pyUthnhr7nT2zhpJf2uAU5DkReO2/1Ogr187XmtLt993UmrIHmb+JtN72onnLwTvKznW
 XrLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0jODytMI75u5dZJGHaGm9qZ9uUteQLE0CtS9b0qQ6W4QocoDHdfFmI1tu7w3UT58NGpszYqo=@lists.denx.de
X-Gm-Message-State: AOJu0YxXSP8ZMuth806W9f7PqWT0gFHYe0RFs3XQFza+RCM66ano8kA+
 m4MPFjouXib7z5FJGn8OWg68uNXDp/TNBAC6q/H3kCDOJctRhd+/NDwmJXow5qBHuWvqu60s08u
 +2AGwP582h4j1OvEx5aJj4mZBAsA=
X-Gm-Gg: ASbGnct7F/WsVJS9Q0FmeEwUgMYbEqdbFtV6exG7lHdr9Y3c9vpkqAdLrJT8DOcuXp7
 gnmXkMPdeB5amSezQDMmbL/+V9SoG5vCVPn58a37Sj/7K5Wp3vBiPJu68/i6PKoMJkjWl1LzPlv
 QwqscNpVADwe80RKKVXTMWsTUBZg==
X-Google-Smtp-Source: AGHT+IH6uP/4mOKJYXY96/80hSDilypd34560sVbVz8Zx/InOEMgnOVavSfoJWeI30OypvvFJdM2bJ0bms0vHP9Ltwo=
X-Received: by 2002:a17:907:7d8e:b0:abf:6f25:9881 with SMTP id
 a640c23a62f3a-ac22cd71628mr443814566b.25.1741287627018; Thu, 06 Mar 2025
 11:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
 <CANAwSgSur2VawHniSEZBD3AO63YnvUGf9m1_8p-XMNxQF+yziQ@mail.gmail.com>
 <CALeDE9Nq_xbOc3W8hefPQuVBi_Xc_2r18cw6+jeEHeGKyHEa-g@mail.gmail.com>
 <CANAwSgTu3ixjQRLZRqx_+nHNinDJSdphHHELtiHLANs+LF9YCw@mail.gmail.com>
 <fbzod24w4kjhntzcnt36znqtyfykoao7u6g37wvzejtxxyljm4@w44tbipyhfkr>
 <CANAwSgTcDL8o_t90+aL0g0FnvoiJE-risKCJBFrYrp9DukmtVg@mail.gmail.com>
 <oxb7v5iwqjgyhsk2tc76oybmnmfvvnen67g32vpht3fgnagvif@t4enpaooabmv>
 <CANAwSgRL2fMzGWdywdzp2BrkYWE0bw3RHa6K-Xf7ByFgjY=a5g@mail.gmail.com>
In-Reply-To: <CANAwSgRL2fMzGWdywdzp2BrkYWE0bw3RHa6K-Xf7ByFgjY=a5g@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 7 Mar 2025 00:30:09 +0530
X-Gm-Features: AQ5f1JonuG1ByNNzzCpRBUtkA4zHc-f1a_5imMPlQ2H3R3u_kjU_orcfR6hBuTU
Message-ID: <CANAwSgQYPHyiFe9q+=+vWa9+pdrnEqz01L2fG8yXTaRqepubxA@mail.gmail.com>
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

On Tue, 4 Mar 2025 at 20:20, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Sebastian,
>
> On Tue, 4 Mar 2025 at 18:12, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Hi,
> >
> > On Tue, Mar 04, 2025 at 10:35:03AM +0530, Anand Moon wrote:
> > > However, I have a question regarding the Type-C controller's
> > > connection to the PMIC via I2C. I didn't see a corresponding
> > > controller node in the device tree source (dts) file that would
> > > support this function.
> > >
> > > I feel this might be causing issues in maintaining the power state?
> > >
> > > [1] https://github.com/u-boot/u-boot/blob/master/drivers/usb/tcpm/fusb302.c#L1285-L1316
> >
> > There is no direct connection between the PMIC and the fusb302. Not
> > in the driver, not in DT and not on the hardware. The fusb302_get_connector_node()
> > function you are referencing is for the USB-C connector devicetree node.
> > You can find it here:
> >
> > https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi#L35
> >
> Thanks, I completely missed this part. sorry for the noise.
> I was checking the upstream dts dir.

Apologies, I had not applied the whole series of patches

Please add my
Reviewed-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>

After applying enabling debug I am convinced this works on my Rock Pi 5b Board.

U-Boot 2025.04-rc3-00057-g671ac2d744b2 (Mar 06 2025 - 23:51:44 +0530)

Model: Radxa ROCK 5B
SoC:   RK3588
DRAM:  8 GiB
fusb302 usb-typec@22: probing Type-C port manager...fusb302
usb-typec@22: fusb302 device ID: 0x91
fusb302 usb-typec@22: TCPM: set voltage limit = 0 mV
fusb302 usb-typec@22: TCPM: set current limit = 0 mA
fusb302 usb-typec@22: fusb302 start drp toggling
fusb302 usb-typec@22: TCPM: init finished
fusb302 usb-typec@22: TCPM: CC connected in CC2 as UFP
fusb302 usb-typec@22: TCPM: set voltage limit = 5000 mV
fusb302 usb-typec@22: TCPM: set current limit = 3000 mA
fusb302 usb-typec@22: CC activities detected, delay handling
fusb302 usb-typec@22: CC activities detected, delay handling
fusb302 usb-typec@22: Initiating hard-reset, which might result in
machine power-loss.
fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
fusb302 usb-typec@22: TCPM: set voltage limit = 5000 mV
fusb302 usb-typec@22: TCPM: set current limit = 3000 mA
fusb302 usb-typec@22: CC activities detected, delay handling
fusb302 usb-typec@22: CC activities detected, delay handling
fusb302 usb-typec@22: TCPM: PD chip enter low power mode
Core:  362 devices, 34 uclasses, devicetree: separate
MMC:   mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0

Thanks
-Anand
