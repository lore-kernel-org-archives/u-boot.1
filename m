Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C272ACF64A6
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C39C88E3A;
	Mon, 30 Sep 2024 14:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="McqfeJ9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A96BC88E24; Mon, 30 Sep 2024 14:54:27 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C71D88E5A
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fabfc06c26so17466431fa.2
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700864; x=1728305664; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUR9MPowGkXBivefKZOAFNg+pquNf/hy/t5o5WZy1T8=;
 b=McqfeJ9w/vaRK8lh+Ib6I+ha9SjHtbvSe42EQJmwLKjsJIWXfbjVDT5/kTrUaZd6jw
 CBW/nd/uC/5il+5gjE/tXVYgPZFCDAMRcYuN89X8lKaJkFKv/zKBXaNgRIBo4jyKunSO
 Bw6t66X3N3U3QbUvCdBde53MKqSseKYtRsJNsm7+KclkkxBhkvo+kTelpwbSQu/OKrDX
 5KoHTSCR7f4UaH6ZYbLQY2+JnxanJudJmLvYsbm3JFtcTZxK82MSy4a8tpZPcpHAL5J5
 2tj5GdUeqrFLFmLrvEjlWk8ymjA6BrfUv1HT42gE7NJ/dUu36jemGN9GFvrWylKl3as0
 M+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700864; x=1728305664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUR9MPowGkXBivefKZOAFNg+pquNf/hy/t5o5WZy1T8=;
 b=ZFIXvAFZ+y4xcg0svCwc257lcl/3awK4stixMg+u+QyBP4M4vSNEmDCNOsdKiRuQFj
 eYR95XVZv4EVNxRIimYcALGNEIHj//pSEB7HY+Z4k6b07ElHRS83kfSwOkj5OML+QAWx
 9Six90yja6C45BnIZxbtKtq83TcRjdRVeHoH0pSPZ+HtGIqVIHaLi57SI1nFmogfgXVZ
 1SDnvKIpkKSzP7gZEaqCserJuSd+qVgmhjRpT5p0rIS+P/wtnwmMiOvyw6AShcIlzDBi
 msKRrBqh/ZNDHrvx66zXvR7yX4Mv2b4xEPCViqvQKro4h2Q9cDMeb70oMigEulKVd06j
 vPBw==
X-Gm-Message-State: AOJu0Ywsxqd8iIgpQJf8Fh0l63IY58hZ95VDYPUPT9daivgcYn5ZF4U/
 71eacarSVll/aqE5WrX/gf6yt0bKRYXhoxmY4zQlzb57W2aA+pzMgqS67naqbLaWxYT6Z7HmDgR
 dTKpSQYQRtoFqgThfU6SuYTvBcj3xBIHyg7poOQ==
X-Google-Smtp-Source: AGHT+IGJh2oqybxMUjjbh4qQ4MWToR64wI2LWgzjsNj7AE+KxB4rYVikCuZeZeddFKyYXvJTpH+jGuoDpkJzpyCJvD8=
X-Received: by 2002:a05:651c:54f:b0:2f9:c278:d7c1 with SMTP id
 38308e7fff4ca-2f9d419a682mr56554471fa.43.1727700863666; Mon, 30 Sep 2024
 05:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
 <CACRpkdaHpgCT28uKerpfoDxMPRhzr862zf7=pgO7CacOEZFUjg@mail.gmail.com>
 <CAOf5uw=hF8f4LKkhvPwOe56L-mMNEaXiQP8eXXcGQ1v+zFSZog@mail.gmail.com>
In-Reply-To: <CAOf5uw=hF8f4LKkhvPwOe56L-mMNEaXiQP8eXXcGQ1v+zFSZog@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Sep 2024 14:54:11 +0200
Message-ID: <CACRpkdZEgCc8KsGUNkdABnebHLUwz49cM9EaaBViSA4NWcQ0dQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] mtd: nand: brcmnand: Backported fixes from Linux
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
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

On Sat, Sep 28, 2024 at 2:51=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> I have already seen all of them and I follow the thread
>
> We will pick them up

Thanks Michael, I will send out the remaining patches adding BCMBCA
support to the NAND driver as well.

Yours,
Linus Walleij
