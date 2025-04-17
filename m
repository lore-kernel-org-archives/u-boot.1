Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24017C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726B182D18;
	Thu, 17 Apr 2025 14:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TNKn+bEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4502D82F5A; Thu, 17 Apr 2025 14:33:57 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467F881F45
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5499614d3d2so895560e87.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744893234; x=1745498034; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cPFByOxBN5uMspW+AXY69VLPIZe8HVz9P+PQROueHs=;
 b=TNKn+bEfCsQDbF6P3imE1DJyRUrExLexe1AVO/kHrAANK5JNQ6y98FzI6JOtjqJBIu
 MVY7eO58BtFJ0dn5Ig7blMBIxCYB4hsa0nr2pVf/4Kd3lfgwaGzCwUW7l1CNRJ9a8RQ1
 wh5RVsVJ9gkm5HHwQV68ujg+yNenOX58EftNDqByctpTb27ZUkW+E1VZrxmMYBdSdD00
 4xKH4jCI5Yb3o8ESs6MkUSkd4o9cMftX3+1RqKymm2xqOYroJdq3+FYqe7tppfEj6z4I
 fLNcJ+MJZTd/LA0Ner0masW8/+DU92mziHuI+6g11kdfzxJU6SWoWc9+g28pvyhGVJKB
 cJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744893234; x=1745498034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cPFByOxBN5uMspW+AXY69VLPIZe8HVz9P+PQROueHs=;
 b=FcRA4Kz7uSbNE9NBey21Y3mwEsDcLuIGzOw2CRZ6K9EecjYsqPbvPMtEs3C9HkK+Fp
 zildlWklLm26ECLmi6acw9QdNqJmW5FCqfPfSQAULXl30SeiJu4cs+cUqyHWCs0xS57T
 djTUYcq5IATqxVaG50qjszKYVTrx0FD90y7wGBMEbH74/4R0A0dm042k5UlAO5kRv8fA
 8Z8DL7Hdkk+Axhq4PvSK+PDv0GwoZls2oTrPcvGYPaZRbac4oiIzNi9kG3AjPwXERJ9D
 CSbxm5T9RdHA9qnaa3WG+PE/WW/OCUTV/FO4EJ+USuGkf/CeB68AkVeNwmRMoylb4uKe
 TFog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEHMPchs9tNx+gswJQ2QJX5CWnt/YY9SkPJ2KDlrTeP9I6RG89OHaCrPcXm4Y0erPuZMDWD2w=@lists.denx.de
X-Gm-Message-State: AOJu0YxBUyZ1QKNrfh2J8nu+MfMiLGbt/PEOvYI8MwOeOLtICgYB9C/F
 ZXa78se/6sdnZFPqAXZh91LCyl6wTgBNcbuvW8cNMiDFubxfiv4HfGqfk/OO9Q3A5LtulazpdNL
 3CHZRJj/18HUxxRxAF5aLiBptepA=
X-Gm-Gg: ASbGncsNs6B3J0VIgGslp8tVgl7i+ER2kCMUmxaXQD7LIVGPMi2twBINJ2Y/P1IJcNd
 mhHsuuY6Dy//Y8pY/lGAsokTIrnN6Q7OMQ42UFv7TWJUR4QAoTGO4yW5LZEfw54DyLav3trFXMx
 tEIrueSahwIB+EVFAdxR3fbn80UNz3ObQJiQNbsgRaoKC3MybzqVIOIRhvrmemKBpi
X-Google-Smtp-Source: AGHT+IEHQwNFcGDficf4JYB7TUQ+hoLVuo4AT1fhdzrW+LwLBHFv5NEM7+LjouGqILJVsT/SUhmS1RmKRZB9c5f7/M8=
X-Received: by 2002:a05:6512:234d:b0:54a:c4af:29 with SMTP id
 2adb3069b0e04-54d64af3e8fmr2018032e87.52.1744893234328; Thu, 17 Apr 2025
 05:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
 <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
 <20250416092639.GA24345@francesco-nb>
 <db2d623afd944df2bca6d1e4657d4031@dh-electronics.com>
 <CAHCN7xKyoBQPeXDA90-kcBTw7BhObvn6PVzreoUQ5+GjiCewyg@mail.gmail.com>
 <CAHCN7xLgS7FZ4ajbBa+p-_w_s6oHnfMYcZEMsNBNkqkgAG-7Jw@mail.gmail.com>
 <b35218ca-df17-4423-9932-a2ad0ba14e50@denx.de>
 <CAOMZO5CA0_GUr2uQtQgFHe-9wVDCOQwo5HZzZ4sibXEPMpe8cA@mail.gmail.com>
 <580024ad-b22e-424c-a1a2-84dcdc6d24ff@denx.de>
In-Reply-To: <580024ad-b22e-424c-a1a2-84dcdc6d24ff@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Apr 2025 09:33:37 -0300
X-Gm-Features: ATxdqUFqmac2alziV4tD0bhGTEaffjFjrudlP84CftQvXM_HKHBqVVq2f5uIW9w
Message-ID: <CAOMZO5C68rJLKNgc_1WAJ0T6XY=wwP1XLsWMix2rrD83tUd_Qg@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Marek Vasut <marex@denx.de>
Cc: Adam Ford <aford173@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Francesco Dolcini <francesco@dolcini.it>, 
 Fabio Estevam <festevam@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
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

On Thu, Apr 17, 2025 at 4:24=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:

> It would be good to include the patch inline in this email, not in a
> link to some paste site which will go away.
>
> This also does not work in case 24 MHz or 32 kHz clock are provided by
> something else than an xtal , and it will also lead to instantiation of
> the same clock twice. The clock are already described in DT as
> fixed-clock , there is fixed clock driver which binds to those clock
> based on their DT description , the problem here seems to be related to
> the look up of those 24 MHz or 32 kHz clock, not their (re)registration.

You are right.

I sent a patch that uses a different approach to fix this issue.
