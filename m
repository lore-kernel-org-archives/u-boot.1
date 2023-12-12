Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B39AC4167D
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3DC586EF1;
	Tue, 12 Dec 2023 17:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXASAbaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B11FE87495; Tue, 12 Dec 2023 17:12:48 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC54804CE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6cdf3e99621so1342445b3a.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702397565; x=1703002365; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bW66jqN1jKkHswzdxZm4OICYe5jZYotkUHFsbY7ozSk=;
 b=WXASAbaQc76uYeyvMwPxYSpTjzDTKrCBPgJ5RelK2x7U4axdLCxIrZZvYsQY+dBH3H
 buLnHGMX8svKylx5204o5/pimWIA5TH9crsE9BcLDlb9iQ+CDewz9mHu3Zw7bf85IOX3
 Gck7hvGG+f9310dbKgPgtqsNWiSk7hbyIBIYVDQgGmNt/5qxOet4Mf5Slhzl1K+0zm0N
 n8/5MZB1xzaMDY7o7k/xTw1TMv4ifjp5nEYvYh2uPcZ4i09vfqX5Z8d9s0R30AnBwJUg
 eA4bDOZD9N3EJh3/iDABGLenL7EXH/wKt9DzrUggikYLxpGn72Pcr75f+XcX30GaEjGI
 mLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702397565; x=1703002365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bW66jqN1jKkHswzdxZm4OICYe5jZYotkUHFsbY7ozSk=;
 b=Dz9HRVO0bkrCGKrSAk0OcJGz8nK6/bynM1vB3QoUkEVZurB4L0bzwOi6AsYQdXLrfr
 y+TtzGIVsIvi7Y4EFyJf5yoCjNekOB/OXKd3Aja7EYQ3WLZollCwEPQW08x19X39UVWT
 bfeOguyilWY3b26j+uKS0gN9WceEICLYMNh7HuG0OWBGnFtyP58nl+CLzo/0j3UqOFZG
 5IkBSiOsUAIqOeU/r8mdUquaxHXDz/UT7klP9RDNoZ01m4k7gam0p+tZnN2upNNTXwRR
 LoDxYT8UZDO+luz94oE2EmF8DQ3rH4u1ZkILhDLmiaH8gCqQLLVULT8vPtLQICm+Qkr+
 FIoA==
X-Gm-Message-State: AOJu0Yy3WjwjYSAftxM+4+OQnQ9jsJs/TVGKoPat7P42+kVAD91TC4Yg
 CogMy4s4VXqsV8Ivk87K5WvdiBdjZseN61tC3Xo=
X-Google-Smtp-Source: AGHT+IEgBf1MoWB425ML/Xv8A3v2aSF1fVyuhbqxqfURSk2TgXYjdvUsiTNxE0aerftS0zWPXGe7DJDuhAKxwv7/lfw=
X-Received: by 2002:a05:6a00:1783:b0:6ce:355c:67d7 with SMTP id
 s3-20020a056a00178300b006ce355c67d7mr13703672pfg.3.1702397564878; Tue, 12 Dec
 2023 08:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20231212112815.7880-1-hiagofranco@gmail.com>
 <ZXhIj+3mrn95CyNB@francesco-nb.int.toradex.com>
In-Reply-To: <ZXhIj+3mrn95CyNB@francesco-nb.int.toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 13:12:32 -0300
Message-ID: <CAOMZO5CYBxmcp0qd4mRMPuAfpqfVWCf8agct41twsjX42d5ibA@mail.gmail.com>
Subject: Re: [PATCH v1] board: colibri_imx7: fix emmc detection
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de, 
 Hiago De Franco <hiago.franco@toradex.com>,
 Hiago De Franco <hiagofranco@gmail.com>
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

On Tue, Dec 12, 2023 at 8:48=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> Hello Fabio,
>
> On Tue, Dec 12, 2023 at 08:28:15AM -0300, Hiago De Franco wrote:
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> >
> > Later versions of Colibri iMX7D V1.1B modules use a "new" SoC fusing. T=
he
> > difference lies in whether we enable the boot ROM to use the eMMC reset
> > signal. Depending on the SoC fuse, the boot ROM configures this pin as =
a
> > GPIO output to drive the reset signal. Our eMMC vs NAND detection
> > currently only sets that signal to a GPIO without explicitly setting an=
y
> > direction. Previously, by default, it was set as an input. As the boot =
ROM
> > now configures it as an output, we receive a value of zero instead of o=
ne,
> > indicating the absence of the pull-up on eMMC modules.
> ...
> > Fixes: 0c39564d ("toradex: colibri_imx7: Enable nand/emmc detection and=
 set boot variant")
>
> It would be nice to have this fix in for 2024.01, if possible, thanks!

Applied, thanks.
