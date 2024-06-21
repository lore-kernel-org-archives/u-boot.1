Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4629C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 15:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26EF088027;
	Fri, 21 Jun 2024 17:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="c7Kpo1aT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76FA3880F1; Fri, 21 Jun 2024 17:42:52 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0700987DD3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 17:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52c9034860dso2793448e87.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1718984569; x=1719589369; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UkPAmydzYUb/qLpJ+aH6mg9rN2crmvPFX5YOZ4OS+I=;
 b=c7Kpo1aTikHVD08leJ0ouXsrgVSYUbidVh/pweXmpyY4RJcuLGULaJ/cwJp9YySzSI
 ALXfsRW45c6eGvC8VE7BdLNhIuU3cDOMHWWraolbWVJhrZKo+/bytiDn20gwdtCw1hm4
 wPEhUciGjC62DteH6HiY/wBlmHsvEME3Ix4aVZCdQ0J5/2Sp5zvAY1+2F2OW0K4ZHWXx
 PQkPq/OYOiRPZBIuQSHdPhUYy+aLwgQsPEEoOP/134kM0mEFYwUAqqjp29b8NCvkVF8z
 QfO/MKE8zwYOvOJ2w+4aHT5rFE9GxwtirFsJJZUWIt+QuZCRPrEqxnD8wgveyj+s6CCG
 klOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718984569; x=1719589369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9UkPAmydzYUb/qLpJ+aH6mg9rN2crmvPFX5YOZ4OS+I=;
 b=oxjyBnrgyaQwFoQPCK+xRxcku6Cyvnf7bRQqozBFlStWu7pRmb2/t/RD1IDap0Sc9Z
 9JgBB2F5tkOqm9Cq5ZsO48xFVmnXfyYi+kS2i/WH9ua185rKQSO02yxUdM7jBXuZ0zF7
 //HqoLizcTD8hKTW/91W6aeXu7o63BvjXZa9JK+4pyOMab+yXHm0m9TDwl6B7IOLr/3B
 AMudLPxpRv+bVonVtP+hfkxsiVvUqTlE0iBvwDwx/4/fFcvLoYBi72cbUPdVY5zvD4h3
 oTdAwbGwlSHlcqd8tyAdZ+auSL/O0Hsr27or0CbDHGa2nsiEr1HFKsYNvNWOdZ8DdXiE
 XCOw==
X-Gm-Message-State: AOJu0YzNMJdykde2jX1warEqlOE+MwzjtawyZA2Ohd8E9oLWL7OLFM4W
 /69U/eStdCMSFAO/Q5/DLJ7JteUCdOKv92QDsdEshZc3E0veCj4XlNIhz5kiVKoPf11l3Fwg3D1
 PQvMsajyVJ0G+JQwAgMFr797xWRHht9sKB/gxdg==
X-Google-Smtp-Source: AGHT+IHRe5r+FH80OuUSfkXFdvHVVeSDd/xg9s+2be5SmMmHKvW1cKfkuuaO7nxxZJCeVltVPizbkPaOKUBZI1uTnTk=
X-Received: by 2002:ac2:5636:0:b0:52c:d5ac:d42 with SMTP id
 2adb3069b0e04-52cd5ac0e04mr1835192e87.9.1718984568616; Fri, 21 Jun 2024
 08:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240620013018.2283965-1-tharvey@gateworks.com>
 <CAOMZO5DESaposvEEH8suJm6cGA-qqUQ=_5bvZY=L03bT09zk+A@mail.gmail.com>
In-Reply-To: <CAOMZO5DESaposvEEH8suJm6cGA-qqUQ=_5bvZY=L03bT09zk+A@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 21 Jun 2024 08:42:36 -0700
Message-ID: <CAJ+vNU2mmxivSRK_Q-d2Lbjk=41BZjdNm_=jd098oBkpqCUVhw@mail.gmail.com>
Subject: Re: [PATCH] imx8mp-venice-gw702x: Drop EQos clock workaround
To: Fabio Estevam <festevam@gmail.com>
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

On Fri, Jun 21, 2024 at 7:24=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tim,
>
> On Wed, Jun 19, 2024 at 10:30=E2=80=AFPM Tim Harvey <tharvey@gateworks.co=
m> wrote:
> >
> > The assigned-clock no longer have to be dropped, the clock are now
> > defined in clk-imx8mp.c and used by DWMAC driver to configure the
> > DWMAC clock. Drop the workarounds from U-Boot specific DT extras.
> >
> > Having the clocks dropped causes the EQoS to be non-functional.
> >
> > See commit c7ea9612df0f ("arm64: dts: imx8mp: Drop EQoS clock
> > workaround").
> >
> > Fixes: 48c6f9777cee ("board: gateworks: venice: add imx8mp-gw7905-2x su=
pport")
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> Is this targetted for master or next?

Hi Fabio,

It doesn't make much difference to me. This is a fix for a board model
that was renamed from gw7905 to gw7500 anyway which is a change in
dts/upstream I'm going to have to wait for anyway so you can leave it
for next if you want. I actually have about 8 patches in my repo to
dts/upstream from linux 6.9 and upcoming linux 6.10 as dts/upstream
was last merged from v6.8.

The set of 5 or so patches I sent in the last few days are all fixes
of sorts and they are all isolated to board/gateworks/venice so don't
affect anyone else.

Best Regards,

Tim
