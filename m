Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D70C25B7E
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 09:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D617E88538;
	Wed, 29 May 2024 11:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FOqzSOgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84034885E8; Wed, 29 May 2024 11:00:37 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280FF884B4
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 11:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-421208c97a2so12613205e9.1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716973234; x=1717578034;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+wOqS6tj23U83VauQ680SDtCFrTMD28wibsWiB3yROQ=;
 b=FOqzSOgE3LwIfOFcTjvVFY8CT3TMGtAuX/4LgdmSLI6Ym+1lgEnKVeNrdM5YSgTlYm
 RDsxp98yuzCAdI4nBavyXIeyOdCaI0NLQ8P8GnF/8Be+9L7fDTpvGsZ1xZXVSVEgMHye
 gRWU8/RbGtAmurr3t8z4SXWE0mWD93wkoyCpd/rWnA83wt+7qV7RtelK3GKWTUlVcESA
 jPNjgJaLPItQ9phB84E4NXi9oiuDlRrYA2QUylU1UKMDj+tEt50Ta3Xu2sOziHABvcvF
 LbYX1a7W1aogmfv+/mziBHjVPsz89JnkqhSbZASUSHImK5RCOCPcAwY6YWc0UWQH4bw1
 b3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716973234; x=1717578034;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wOqS6tj23U83VauQ680SDtCFrTMD28wibsWiB3yROQ=;
 b=bF8wv7vd2/o612t+BahrkTvCZN6PT5JoYbdS5DVy7if8hlzo5nE1y9zlFYFKC6yxEV
 AaWuZH8J7QzymwY3LXBxRpetOcrUnbjWz1rF+extiij7ZsV2NaHAd1sKmOmtxGUxhryp
 f+f29hDSKzJkoBL+aKcUhbFb0rzOsS47KpQpbxk+ggM3DjXQ3NYJ318V1K7M96fPXdSZ
 /evTVk0hc3xxtp/GHVsLoilghmJF208yylMDwByOboxpKRdowAv1/kA13Xc8kly/qYQb
 K0wpGmiQnDdqiQP8bI1ZDPvG99zgHGdAyvWDi7yQG1svH2+QhBT4H/8/NdhHSXikITkd
 0Gtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5yYL2c5eghof+WNs56uDvwOBDLf2tZBQgBvxKsLN46dp7SZ4bqTGXGHg5GWT11FzEdVCGFUyRvO1QhBT4nwOqGUqWMA==
X-Gm-Message-State: AOJu0Yy6i2jjsrS60lnYjuIp53zfKnSfhqtnKa7Mly4OGeq7Ak95wk6v
 WMXDjsWCqeUWZmZ9UG+Bby4XBkh1Bg38wfYHBy5GDWFaNPdGSwdQ9cgMA600t8I=
X-Google-Smtp-Source: AGHT+IGRUYXQLA8XqWTf0Rxj2owBXEYVLr91YO3tfv9kVMow+OuDUB2A17idHh0mnce7GLmKABlLPw==
X-Received: by 2002:adf:a447:0:b0:34d:990a:e4cb with SMTP id
 ffacd0b85a97d-35526c5b692mr10243125f8f.36.1716973234482; 
 Wed, 29 May 2024 02:00:34 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08a88esm14151039f8f.41.2024.05.29.02.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 02:00:33 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dhruva Gole <d-gole@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "nm@ti.com" <nm@ti.com>,
 "sjoerd@collabora.com" <sjoerd@collabora.com>, "a-govindraju@ti.com"
 <a-govindraju@ti.com>, "d-gerlach@ti.com" <d-gerlach@ti.com>,
 "jpanis@baylibre.com" <jpanis@baylibre.com>, "g-tammana@ti.com"
 <g-tammana@ti.com>, "kamlesh@ti.com" <kamlesh@ti.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "marex@denx.de" <marex@denx.de>,
 "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "angus@akkea.ca"
 <angus@akkea.ca>, "g-vlaev@ti.com" <g-vlaev@ti.com>, "s-anna@ti.com"
 <s-anna@ti.com>, "sjg@chromium.org" <sjg@chromium.org>, Martyn Welch
 <martyn.welch@collabora.com>
Subject: Re: [PATCH v2 0/8] Add DFU, emmc and usb boot for TI am62x
In-Reply-To: <20240529060908.l6vy6rnefpei5lqs@dhruva>
References: <20230406185542.1179073-1-sjoerd@collabora.com>
 <20230531211403.GA980359@bill-the-cat>
 <3f8f03e9736aa93b87a26e8056037d53bb50db56.camel@collabora.com>
 <df470ed11d3c7f748a171cf221102b0bcd2ead23.camel@toradex.com>
 <20230821182026.GH3953269@bill-the-cat>
 <20240529060908.l6vy6rnefpei5lqs@dhruva>
Date: Wed, 29 May 2024 11:00:32 +0200
Message-ID: <87wmndxaa7.fsf@baylibre.com>
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

Hi Dhruva,

On mer., mai 29, 2024 at 11:39, Dhruva Gole <d-gole@ti.com> wrote:

> Hi Sjoerd,
>
> On Aug 21, 2023 at 14:20:26 -0400, Tom Rini wrote:
>> On Mon, Aug 21, 2023 at 04:13:32PM +0000, Marcel Ziswiler wrote:
>> > Hi Sjoerd
>> >=20
>> > On Thu, 2023-06-01 at 08:37 +0200, Sjoerd Simons wrote:
>> > > On Wed, 2023-05-31 at 17:14 -0400, Tom Rini wrote:
>> > > > On Thu, Apr 06, 2023 at 08:55:34PM +0200, Sjoerd Simons wrote:
>> > > >=20
>> > > > > This series adds more boot sources for the TI am62x. For that the
>> > > > > dts'
>> > > > > are synced from the upstream ti-next git tree (to add usb nodes),
>> > > > > some
>> > > > > dwc3 glue is and finally the default configuration is tuned to a=
dd
>> > > > > support for DFU and USB (host and gadget)
>> > > >=20
>> > > > This seems, conceptually, fine.=C2=A0 But as we're getting the TI =
dts
>> > > > files
>> > > > in sync with the kernel, I'm deferring this version and you'll want
>> > > > to
>> > > > rebase and re-post once everything has settled.
>> > >=20
>> > > Thanks for the update/hint ;) I also got a few review comments so the
>> > > plan is to include those and repost.. Just my may has been stupidly
>> > > busy causing me to not get around it in the first place, so maybe th=
at
>> > > turned into good timing in the end.
>> >=20
>> > Any progress on this?
>> >=20
>> > I still carry your re-based series on top of latest master [1] and USB=
 DFU is working very well on Verdin AM62.
>> >=20
>> > Thanks!
>> >=20
>> > [1] https://github.com/ziswiler/u-boot/tree/verdin-am62-usb-support
>>=20
>> As the am62 files have been re-synced, re-basing this and re-posting for
>> next would be appropriate at this point.
>
> Any updates on this? Do you have plans to rebase and resend this series?

A part of this (USB DFU) has been taken over by Martyn and has been merged:

https://lore.kernel.org/all/171581573300.812585.12291710364879103682.b4-ty@=
konsulko.com/

>
>
>
> --=20
> Best regards,
> Dhruva Gole <d-gole@ti.com>
