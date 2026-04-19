Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838E1EA71A1
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 20:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D212083693;
	Sun, 19 Apr 2026 22:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ebwQ11Rl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADFE83B99; Sun, 19 Apr 2026 22:05:23 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73EDE82BF2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 22:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-38ccde812ecso22424871fa.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 13:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776629121; cv=none;
 d=google.com; s=arc-20240605;
 b=Y1to5exnMFvyWxWaZ81d3M6pbVGFIi2lVj0xoouEPei08FAFz5TBAcXsm9f84WbbRx
 8tS7JQYfev+k3EwNDo0Lsg8MNtR/bGN24L/KFLvRrS1x8GfY9nWWxh5josgRQ8BuVYyv
 G4bh+ddJsPibyOkPXOeiQMzw8F9ej2GwISJrFHedYYC/tJDv+wpSRrjwjKi3euNI0cP3
 iEXoCsRXWKE9Dpz5DeS29JO7BCCXTBHWk/Fx1sE1nDTfnpmeoR0i1cotfWiSEzztIkns
 Suc75PzOqktPXdrU+gOtCXI7LQcPNw6FOFm6m/MzJBpOHbKgtcnVjA28osu/yTC/RHUB
 JoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e+jC5cHteLXSR1rTgi0+mbgQ4TueWmQj4db8+/zV9Zk=;
 fh=YEaWeRgdE6puHcihl5rGEpHYRMEk/Os4crAf6jxQD2Q=;
 b=K3N0ZmS0OsE2EoErgXS8R7MtWoa6ZsbgwymwS5sEIh2DHtPJtQ/7u/acME6TVXEbJV
 94trZuydxBTB+FYNkZPWmRXeiBLRtVZP4Znq1YVkZSPKJUfzNJc7yRmAyGNoAHXjcVtm
 hMt+JWZCy3psxuwswrxTDFQC5SX6R75CUQSzBNkJD+YyA1d5SVFmYh054zrqyHsNvYLW
 SUBN99siyJxYkgpmfka1dEbpJazQ0WPccgN2YDiGZt3z0g3x1YCsG7mzB7fFnQbTy2f2
 0077bdpr6OyFy+ksdh6HtfWUu4UeOAlXkxiksomiT4pFRqgCI5NrjqfNCQnz+zomuhP1
 jRjA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776629121; x=1777233921; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+jC5cHteLXSR1rTgi0+mbgQ4TueWmQj4db8+/zV9Zk=;
 b=ebwQ11RlDJF4Ei9q7w9HCmkH3mQEahJzZUz6hTnlUUqsmhnMk87zgMKVhLlKw7NjYO
 LhoZbp2H9JLto7VYXHxIyBd142SagNwZ5BtoLCBBJDMUKOVXNJv4T7Bw3Uvjp+/LflH4
 x6nWbXRhM/Vq56XqBkRQWy7Y5HNfEXywsk8iwM4baI6mXWexyPZDvLkm8AK7o/bYdoM1
 sv/FkL+M3E6D2ciOWqCZTukxyCyRI9Vynd0flxi52mwCoOAdcnxwBZyLMDUlhCoHyOfj
 /FHRMTMVqaVyl0J1hx9BsFe7oMIumDgYPJ+jWAH/o6pkQPtIQ0ZmB/Y0ro7EZUAwnjHq
 1vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776629121; x=1777233921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e+jC5cHteLXSR1rTgi0+mbgQ4TueWmQj4db8+/zV9Zk=;
 b=dluFNlUHrNIiwv4tKSHuH39M1pNELUZj7cTDknC+LnrWd4W/Z0v/DDFgu7z8IqRVgL
 r21Zlj9hYFwDxewvC2QZAxmnKIOYICUMLYTH0fbO6UPq0dBuLyibmnqh+WvvUTnLYnyf
 uJe8p+4m1pvB2H05+f7lXPt5DX2ZvAGDd0TQcVESmqCm2EICFourXcnHYtTyzBfHy31A
 IJFDhbWbeyYqEHfrRgJGy0sagwzt7ishxupJzGAAiaBIiIfjyjN6gXJONDtIWj9Ocuh2
 PIyvLGqziTvrF9rRUamLVkJkyO6zMKi6W0989Z839qc0wEV1FV7VqgMQC0rbNRxZLxh1
 Fkow==
X-Forwarded-Encrypted: i=1;
 AFNElJ884yx/Txx0c1wcEcIANfThNAdwaSr91Q38FxRkhArMpD/rBTi9t9yKvobBZd4ulk5TFJI+WMs=@lists.denx.de
X-Gm-Message-State: AOJu0YwFZU/tZdk9n6qaGMrnq/ZOOkwVSgWnqggygZ3U9K38Q1ayBwQo
 vBuYUUJBUwEBroOzGQtGFY8oz1hSyGDrdCMq0QNqSDE7fkqHhqE5pvVec5AfQ3XT3EkJu6KkeUn
 FVZQgi4ziRxnEtAzzoelpapT8fnp0vYI=
X-Gm-Gg: AeBDieuH7cPmvwil5esBxqdd6iP107kOkeA0ypJAq5oFcue3E7lHrkuFjBvyudu6ekL
 gug74zG0xw6M5uY9ZIn/5Cmbdaj8zF0Ca2iBdEitZ4cUWYgLLjZlWVuloTtx+SziI7Kfx3vmV8E
 D//8E0kp7QBrVh7v/0m72iglKbYd1xIVvazlmHpCzBLeX3qLTsrfbJu8juWb17XR5fAMd6WI6tf
 xLKDGYSQIjkFE6Xvlcw2X40z0gwz88ncNCwRN8z+d3cCZD4A8HIRnO/y8wmVnxM5DMgbkZT5qUH
 BmhEqvsaG2Z3J7MZs87QvoIpoS53vOwNd0W1oFvWK9U6bCEOOFGQ7CFUTVKEdqbjA9ucMoxc/W1
 3hgrETjq5TNOMXxKx
X-Received: by 2002:a2e:938c:0:b0:38e:9b7e:edd7 with SMTP id
 38308e7fff4ca-38ec94d7484mr20420821fa.17.1776629120554; Sun, 19 Apr 2026
 13:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260407130654.778838-1-Alexander.Feilke@ew.tq-group.com>
 <20260407130654.778838-7-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260407130654.778838-7-Alexander.Feilke@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 19 Apr 2026 17:05:08 -0300
X-Gm-Features: AQROBzB2Llc0juZPVr7rOzs9IQzjBHlfMwkqb5eGfA4umBEHCMUf_y1h_hJmlb0
Message-ID: <CAOMZO5CneDfsmw5Lt8GnQttz7eOmbFJJ9zKZz-5W383bWNTyYw@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] board: tqma7: add code for u-boot with spl
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
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

On Tue, Apr 7, 2026 at 10:07=E2=80=AFAM Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:

> +choice
> +       prompt "TQMa7x RAM configuration"
> +       default TQMA7_RAM_MULTI
> +       help
> +         Select RAM configuration. Normally use default here but for
> +         specific setup it is possible to use a single RAM size.
> +
> +config TQMA7_RAM_MULTI
> +       bool "TQMa7x with 512/1024/2048 MB RAM - Single image"
> +       select TQMA7_RAM_2G
> +       select TQMA7_RAM_1G
> +       select TQMA7_RAM_512M

Could you detect the RAM size at run time instead?

Take a look at this method, for reference:

https://github.com/u-boot/u-boot/blob/master/board/kontron/sl-mx6ul/spl.c#L=
271-L295

Then you could get rid of all these TQMA7_RAM_ symbols.
