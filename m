Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E7CAC596
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 19:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDA588D31;
	Tue, 17 Sep 2024 21:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LcWaxTX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3E5188D27; Tue, 17 Sep 2024 21:08:06 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8FA88DAE
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 21:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f74b6e1810so53471351fa.2
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726600082; x=1727204882; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IV5QNcVAhvLAYFHOCETofcC/G29PIP/rs9paWN9HMCc=;
 b=LcWaxTX/lF9utAVhqrx2J1xCE9U8ybtyM/qCYqMbtJAz5dpmg4h4L7yOOaqQ0z4wlv
 GwS8kY3vREg4wIJVsYCmNrmZ9WvlF9Fum6xk41WroZzkpo6FtJRi29iaCqCGP4STPYaw
 7VYjvpAZQc/v8NcTB45P0i9I17XoOucdPbPIqK3KJr1NTUajhthcT+hYubQT3aXzPVZU
 0Kxj6floMnycZOtCDLWFH7c7EFi7nD8hoHvAqKHaDNdaHBAYXbahTxQHKRznoU5Eelnd
 ZbataPrAuhgceM8++ZypHax7MISBKLfgU4G3KIsU7Ksw7hm0ivi0rcxryMqB4KMySKXS
 SYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726600082; x=1727204882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IV5QNcVAhvLAYFHOCETofcC/G29PIP/rs9paWN9HMCc=;
 b=H2YaY8zpC7Uq9PatxQQec3WZH0wEeVce0YG2IntAfUt7EiQDlRqqxqZnCEKKo0Yk/p
 BALZLV2dFqVFTGr0r5Tchd/CxXPvlw0tTWAcKbiy28YsH2eisUslRa/hHZOpy1B5b40R
 S6OLseiLbNxJLCMkefgp/ifQuX41ApuO8MxMsL6K9TyuN28rfO8Wb+bKimEt5D2WendG
 9nkiLhj8trrroO5bzorO9oPsyXQlu7glI0yAN9oGlZBAukVxd06HsZc1+2Oha6qw7h8L
 NnpVQxdmxx2H0Vcu77/JaoGVOMQZL3uVoSq6sHqvetLRjk01adAbd4njLw6+SfXnCCdC
 ZkFw==
X-Gm-Message-State: AOJu0YxNaqG4cqm4PWYE3tsFKikMJHuE2FymWwkF6OZz4xRbXD0RmfAO
 BUGFLO29T6DhWOfSq1+ib3pe0y/6/vYDEBEIRnaUkXok9x3b41pPbeCzOP7apN7D8uijmtA0h96
 Xf5DLrsujCDCcpBtQ4XVE4huHzr7DhoraEWjzFw==
X-Google-Smtp-Source: AGHT+IGVFMnIGzpaDIEtZiQZ2grfG12eFvjm2EEGhqe2DagX2Km7x5+kqDNpuhqe0tuh1WqkCXMznTTBfQ1WewhRA/E=
X-Received: by 2002:a2e:be08:0:b0:2f7:5cf9:46dd with SMTP id
 38308e7fff4ca-2f787f4ca04mr93102781fa.45.1726600081423; Tue, 17 Sep 2024
 12:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
 <d27e92a5ccecc302a1b2ca7ff55b8c3b@mail.gmail.com>
 <CACRpkdYxecZsgoUipPR8DgcNPKp-3o-h=Qseq71W8vceV4eXsQ@mail.gmail.com>
 <4aa2c921dddb69a5a4964d5446f37695@mail.gmail.com>
 <CACRpkdYBFAhNaMVSQDCiMsVpBA3tZOu7nJd2kaTSPHKX8bTTbw@mail.gmail.com>
 <bdbc43d3c66eb3c7bbf45ab95294ddf1@mail.gmail.com>
In-Reply-To: <bdbc43d3c66eb3c7bbf45ab95294ddf1@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Sep 2024 21:07:49 +0200
Message-ID: <CACRpkdavn1GC6Y2TY_xJuM59kDF13-8-jRs=LPJG+ZHtHvMZEw@mail.gmail.com>
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

On Tue, Sep 17, 2024 at 2:19=E2=80=AFAM William Zhang
<william.zhang@broadcom.com> wrote:

> > > What SoC do you use?
> >
> > This is on BCM6846.
> >
> 6846 will work.  Let me know if it still does not work after dts fix.

Yes it work just fine! I dropped
CONFIG_SYS_NAND_ONFI_DETECTION and then it detects
and works fine on Genexis XG6846B, see here for a full
session where I do some ubifs inspection:
https://dflund.se/~triad/krad/genexis-xg6846b/ubi-info.txt

Yours,
Linus Walleij
