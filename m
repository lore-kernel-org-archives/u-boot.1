Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8197AC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B1188413;
	Mon, 16 Sep 2024 11:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xPa05KvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 145A788DEB; Mon, 16 Sep 2024 11:22:57 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA17188356
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f760f7e25bso40040771fa.2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726478571; x=1727083371; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHW5iWR+K6+n3fW5PlYgzXBOHYi9fX1kl5Qhxy52i0g=;
 b=xPa05KvEqpQCnGX0dGZEBBuCkuzTBU18DvUlwDGwpbCQAyZu4Ef30wrdir//lK4BI7
 MaB0NWbMxYnWW9Lp6r8jwJgAZ0uvzcgRUJvbCDfPh2EqU3bdVjWtfBHOl47a4t/4CW3W
 nrH+imGBVqxPA4EDWTKbNqZXlPMFXfWw7J3Omge3RmiCDNlKAcBFTbJ8KoD1M4Jl84dg
 c+S0gl7r/FR7y5V7NrzOVdIpY7B36pwlcOlAMiwZGSQ2I70MTQ2huYDZeJoW8mBqNnKp
 DGKS+RLniMu0igLEH5n7jjzTDJ24avTLppnql20YUvSQ0bbLOn73Ypwi7njDWDVQM7qv
 hPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726478571; x=1727083371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHW5iWR+K6+n3fW5PlYgzXBOHYi9fX1kl5Qhxy52i0g=;
 b=EI6wBh0mq28OG7dsOUBaBqzJlvTcaIAuZxpaaPpfCSqgHsNdlIzJQd0ctDM9ukx3fK
 iPj0PwtxmL3YvTVuDSXU4UdfDOavxkDedK5Y7hoq4XhJIIN/CzyzRWs2A+eCay2ELE73
 hA9eh3WxOWEgA1yBhBKfIjODl5/nXsRT6wUVpqsLAvb3mRrNuyBF0znmGG/h/FE+wu+G
 8I0ZnH4gMZIT6vx3573K4yd3h190cAqqbF3Qs/hJ0GxfsIVj12IzsRKsEehr6xOBLOxM
 g5Oqm7Lw0eFUCa4xclsTpf4SEa8VH6VIqWOBLrSbDBg8A6XMYB8zdvMfSNbqPSBFaPKb
 cw6g==
X-Gm-Message-State: AOJu0YyAP8Vka/WgnWKF3ss8VxkdyEiP2iHQDJ5CryTREFgJ7W0DWhuK
 ho3QViKqDe4gwTfAKabY3GSEryaJP9rXqhiXLNVxEAB+9jQvipxMwipAd4Zex1XdpmZqnwfQyN8
 vymR1Rol6nAEqiqJ+Cpjm8KnP5tULO2eD2Ez1Rw==
X-Google-Smtp-Source: AGHT+IGxE0zG+gFOHYS1/tOKWBZJOVqQ7sTyWkK/2fBvL77j9x+g/cNhp3luNZX7heng15cLaCH39pjVnAvoLgpkwy8=
X-Received: by 2002:a2e:f19:0:b0:2f6:6029:c63e with SMTP id
 38308e7fff4ca-2f787ed4d92mr56873931fa.23.1726478570023; Mon, 16 Sep 2024
 02:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
 <d27e92a5ccecc302a1b2ca7ff55b8c3b@mail.gmail.com>
 <CACRpkdYxecZsgoUipPR8DgcNPKp-3o-h=Qseq71W8vceV4eXsQ@mail.gmail.com>
 <4aa2c921dddb69a5a4964d5446f37695@mail.gmail.com>
In-Reply-To: <4aa2c921dddb69a5a4964d5446f37695@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Sep 2024 11:22:38 +0200
Message-ID: <CACRpkdYBFAhNaMVSQDCiMsVpBA3tZOu7nJd2kaTSPHKX8bTTbw@mail.gmail.com>
Subject: Re: [PATCH 0/7] mtd: nand: brcmnand: Backported fixes from Linux
To: William Zhang <william.zhang@broadcom.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@broadcom.com>
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

On Mon, Sep 16, 2024 at 6:45=E2=80=AFAM William Zhang
<william.zhang@broadcom.com> wrote:

> Yes we have it working.  And your patches works too after fixing two
> Issues that I will comment on the specific patch.

Yay!

>  You will need to
> enable the  NAND related configurations and the nand dts node.

Aha maybe I simply missed the DTS node...

> You can use existing dts node to set the specific ecc level, oob size and
> ecc step size.  Or use the new automatically detection from the strap
> property brcm,nand-ecc-use-strap that I upstreamed to linux.

I was planning to used the strap, which is ... what we should have been
doing all the time. Oh well, no turning back time I guess. Maybe we
can fix a lot of DTS:es to use the strap though?

> What SoC do you use?

This is on BCM6846.

Thanks William!
Linus
