Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BAEC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 11:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD5D88738;
	Fri, 19 Apr 2024 13:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fTmRyp25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8D088873B; Fri, 19 Apr 2024 13:29:34 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0C9888735
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 13:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-418c0d83e61so20298665e9.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713526172; x=1714130972; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9ipMV/1g0JvuVaGIGCKH1RfILI7bAYuRCmB0cH0rcU=;
 b=fTmRyp25+W4DACvSfzVivt58DlvxP72bC/ldMLMj5cuIK5ZeJN4oBIYMu+hSEDcvR2
 n/RDniFYovVNpcAB3EUslD9vKufNA+yibPUtHIMMzBm1xIikH6geWjYsoFIxKwalyzyA
 teZcMK0/11YBRmRNr7KOuxlifJsXwjdXoypldt2DeA0hKSYSPkrrococz2D4ASbdwoV8
 O73BvIZ6KmR8L0gUXxg4JxYEsbMizQ1b6MbU8klX6P+GKrWxOpB2/GecKlAogyvfh6OC
 tAdv+NJdH1WDWJSpkorXNXI5/n1JUtkhPz7JZU+e4lAYy2jjR7sJWZpEnHyanMuGhOr2
 zWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713526172; x=1714130972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9ipMV/1g0JvuVaGIGCKH1RfILI7bAYuRCmB0cH0rcU=;
 b=e6a6JL77NPx5CwmzbdBncFFst/GmyFRslQ/I+5MZACZeVg10/61Ws2Ghf4wGqtc1ox
 r8TbViV2bj8ryXdQIHCxs+MwuRg2Ep0AfxcsFd/YwTkQqRxvv3f2MTmQiRnxI98tNwkB
 vg4cpaSQwd9oEy6ygUH1pJBT1+d7Vt5S0/DYSi0NJ4lmtrmcRnWS6VAqYjwUR/IXgEuc
 6Yg5z5tlrBIPBoSOa5kdxKcvcUnmrMek0t/sW5J3iohDqa7LcvPt2bUwiJWzZgev9rkH
 vRECFNehfnIQG0w9CQzw3a60yqhCaTJi4GZifFTQYnUK3SqCJFcOdcM2vkQygQXAUAi1
 engg==
X-Gm-Message-State: AOJu0YyrLxq1S6aprFvN2hAYOz9kn8FS3Y3NCkQjHMvyXQuXg+JKkjEQ
 r6aj1iwi3hqF4L04Mf+y4RxnED2yK7PqFbVRWSvoCHIGkWDhfUGQtNWkWbx9rxv1KkZD9XaJitW
 TIBDy/mgtta98J00Y+EEIFbcIwUQ=
X-Google-Smtp-Source: AGHT+IEdZnkIAENnrteIvYWg3E8EHHWtNpCiRU3+C4g+YYJ7ON9nQSzrk5jJR40AiqwRYiLLfSS6PPbMijl545PcA24=
X-Received: by 2002:a05:600c:19cc:b0:417:e60b:91f6 with SMTP id
 u12-20020a05600c19cc00b00417e60b91f6mr1668401wmq.4.1713526172004; Fri, 19 Apr
 2024 04:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240131065721.4245-1-clamor95@gmail.com>
In-Reply-To: <20240131065721.4245-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 19 Apr 2024 14:29:20 +0300
Message-ID: <CAPVz0n10Fb4H-Haj+s-Jjt_UgpWXSSWOFdJVeJATwTr22Do5_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Tegra panel improvements
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
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

Hello Tom! This patch set is hanging in patchwork for 3 month
without any comments. If no one has anything to say, may you
pick it into master?

Best regards,
Svyatoslav R.

=D1=81=D1=80, 31 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 08:57 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The current patch set improves the logic of existing panels and
> bridge used by Tegra 3 devices and brings support for additional
> DSI panels used by Tegra 4 devices.
>
> New and existing drivers are fully reusable, contain no device
> specific parts, and are written according to existing datasheets.
>
> ---
> Changes from v1:
> - improved ssd2825 code style
> - added TC358768 RGB to DSI bridge bringup commit (used by TF700T)
> - added Parade DP501 transmitter bringup (used by Lenovo Ideapad Yoga 11)
> ---
>
> Anton Bambura (1):
>   video: panel: add Samsung LTL106HL02 MIPI DSI panel driver
>
> Jonas Schw=C3=B6bel (1):
>   video: bridge: add basic support for the Parade DP501 transmitter
>
> Svyatoslav Ryhel (5):
>   video: panel: add LG LG070WX3 MIPI DSI panel driver
>   video: bridge: add Toshiba TC358768 RGB to DSI bridge support
>   video: endeavoru-panel: shift the init sequence by one step earlier
>   video: bridge: ssd2825: shift the init sequence by one step earlier
>   video: renesas: shift the init sequence by one step earlier
>
>  drivers/video/Kconfig              |  17 +
>  drivers/video/Makefile             |   2 +
>  drivers/video/bridge/Kconfig       |  19 +
>  drivers/video/bridge/Makefile      |   2 +
>  drivers/video/bridge/dp501.c       | 579 +++++++++++++++++
>  drivers/video/bridge/ssd2825.c     |  86 +--
>  drivers/video/bridge/tc358768.c    | 985 +++++++++++++++++++++++++++++
>  drivers/video/endeavoru-panel.c    | 128 ++--
>  drivers/video/lg-ld070wx3.c        | 186 ++++++
>  drivers/video/renesas-r61307.c     |  93 +--
>  drivers/video/renesas-r69328.c     |  81 +--
>  drivers/video/samsung-ltl106hl02.c | 157 +++++
>  12 files changed, 2155 insertions(+), 180 deletions(-)
>  create mode 100644 drivers/video/bridge/dp501.c
>  create mode 100644 drivers/video/bridge/tc358768.c
>  create mode 100644 drivers/video/lg-ld070wx3.c
>  create mode 100644 drivers/video/samsung-ltl106hl02.c
>
> --
> 2.40.1
>
