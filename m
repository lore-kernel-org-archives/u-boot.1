Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDF1F327B4
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A4083FFA;
	Tue, 21 Apr 2026 09:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bfS8bj9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A7484119; Tue, 21 Apr 2026 07:16:55 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0073E83C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-651cfaa21e6so3608451d50.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 22:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776748611; cv=none;
 d=google.com; s=arc-20240605;
 b=jJ7jTkM5aTKejspxUPK4EC9TqSkRXnduJ18+k22yu2tg+LzeId7q+82KXQe1elTRGt
 Th9aE6u2cT9fhIF9l1iF01TuHYm3Lk5s1BU6Qh5ZDuHd6jn14c932k01M2PdKMMoNkDl
 R+zZN84/5Jy9QiF+tNBP3uo4xRCNnjnVfbwcFcxegeQWDACQfkSEBOq+65BQD38KRF74
 PBJco5yKOX0HYHOjYp4dKeMnJNyL0D5b+8DEkjs74F+Q45ZGLy4x0o9pdCyJ85S2aw4/
 i1+CKUJTfg5Uq70J3iyrr85xfzm6AoLtIFdfFq0QrxZwIHx8TEbvfrLnYOQFji4RAKbg
 akaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9YM0lSuDcsTuL/p+iqzLwAtpEQpntOG7+xeTv+n7+V0=;
 fh=vor+8SMF4v7ubiN9P3R6H+Zw0/9OGjgGN5wypefG4Qk=;
 b=aVaehEbX4rnrItmOIdVaA/9mOHJ9vERo5Xww8AzEjYSFwP0s8enOO+yHFY4RBiCCqB
 PMIodAgB5JN7lNNXLqu9mOwFedigyDIyV48YrZZMQ1oMsADCW7cd8GveGTUrhnHTBwtN
 HXc6rYEGkp/6fpFqcVpNEAXx1bQ27lQoPPmqmwChM+KusYq1dIWsU4fB6C4Hmc+khL/h
 KkIXub70rY6Pz1bSebEwn53yB4UhUBsz14vmgxMC1A+exy42kgRsfopY3PfB+U7SWOCb
 i/xyCzMMbTe8BuZy6gJeX0cSACZpxOKZJ3uf2n/0Yk/eogJCspyS7tRF3LRlCToqZs90
 d5CQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748611; x=1777353411; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9YM0lSuDcsTuL/p+iqzLwAtpEQpntOG7+xeTv+n7+V0=;
 b=bfS8bj9RNap8wwYzD8mXD4PjMo7gwlF4sC/0IXwnRg7YgvI6bdHHwhK/w30juzbbsm
 Z6WYzohdXeXmCJJAEn6WOjftLtPT126RYTuUCc71sRAemYmejw8g+XJ4hmYX6hQkUNSW
 Vd7YPbeFlNL9bX3h3+wK8kSGwt9/zrkwB8dl2ZD114nrvPnBM4hTodC2bDUXyCj+X/9k
 6lcdiMKe0dL1pD6eAYNYmfADchjTRkOSdGbA5J8QraQv6/6coaoF7zdrZ25gWKzAYfCn
 AZ4ERtMrCTiRVBJ38c6A7lnSAN6mE91A8nU0QYzziGvIx6O187xtjglI1Ibrsk30pyPI
 UYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748611; x=1777353411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YM0lSuDcsTuL/p+iqzLwAtpEQpntOG7+xeTv+n7+V0=;
 b=IJHqp27lFE9cQH+2cYfYTcepHR166vli0X8eDeldKJla5bNcUTNCNhYt4KmWbw0rQK
 7hxmd4SPpAFdHu6VoaqUQtkFDvikkb1+SzY6cQrrp8m7rpqSil/WucE8BMzB1Mss4nga
 sw6ngTn5MXUCYJB1vU3D6ek5VDTPpclgm0Y+mbZBRZrLcPsjQ8npaq5LfrmSw8dZp9eL
 Hu2VC/JttEqdKbcL4CA+sJQP+pYW8YPihVqHlLFiTT0TjIvjsRHuCmc6MNrD04qiPqS7
 iQXLvrfBg+nUgjpoteC12IVC/kdssGpFu4FGqmdYrLuikYHFccF0rCP6EbNNBlXR44lf
 NwGw==
X-Gm-Message-State: AOJu0Yy/MeHBbn1JGUJtWh2HW9riqHgi6W0gPd19gRlSSuY6VSybJfVW
 a4n3osHkMkRSurnGQ8SnJY3pDapNVpOX2xKyIAha8d6/ayE4vonWw5xW0ITUh2Prt4LsGool2WE
 UG8yoy8KNJynMGJN2tgkoHd6qbAPpDWPN8foYUEU4ug==
X-Gm-Gg: AeBDievWscJPRZRX0iNkGaR3MAjAXF9qC3G0WwV9gaBUYbNn7zX0Aee8qd95N0+7EPm
 nYDk2SsDa8DPP157KVbun2x8WEcHZtaiva3G1LEOIxXdmAgFcwzF5eRGKrmqQ/KAakDoCaa/+8C
 fg3BYFr0nHcQ1DVABsBu6LHJ+rdW6qCij8R21i7aKP56fau6lIS2g4pJKV18V6HNaE6WH3u+Qel
 x7Xdy9bPq2CcjwqCsHnKzJlJ1p0TwUH9vqxH+FB2huFWP/j9U5Bhda80ojPGo1fFoQsAAHaEtlQ
 p4Jxsii7KQAofQDJ9znYhLJ32sF5BHBxZTFs/iDKdoTlWgCTforb2dBBCIqpevdrh+hmZDE5UR2
 WlryHNIR33AROk5cS+N6Li5YJRgEjeR8hts5U1bcFC+M0yNdgVU5xnirIBvjvQmdwVTxWBXW5i6
 wy1mo3d5DM60q7Slgmfla50l10rcpYrxuJMeqQM9LHAg2JkFairD+TRHREOJ979mV8aw6b4U7cy
 w0y0C/D25EQqNEc3ql4825VuHKnTP9dvfc13UP5hNjj3oExL5pTvWVBntrMmvGldnMvgcCq6Qui
 4XvvgD9vyof6M7J7NKNjAZkhdwfhva6fBzS69l1f08UdBVEWdXcv73w=
X-Received: by 2002:a05:690e:43db:b0:650:77c7:ae81 with SMTP id
 956f58d0204a3-65311b3180cmr8155989d50.22.1776748610676; Mon, 20 Apr 2026
 22:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-6-9900002d8e72@cherry.de>
In-Reply-To: <20260420-net-kconfig-v1-6-9900002d8e72@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Apr 2026 08:16:14 +0300
X-Gm-Features: AQROBzBFYblociOblAsqbs44QPUtzOksoHvm5GP2Bn_EKJmmo6kbIAU-ZgzJVv4
Message-ID: <CAC_iWjLYYYHRV=1YfXLUL7Tbkms-EjOkv7UBLexQ-4YNPwowpA@mail.gmail.com>
Subject: Re: [PATCH 6/6] boot: remove NO_NET use
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Udit Kumar <u-kumar1@ti.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Adam Ford <aford173@gmail.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, Pramod Kumar <pramod.kumar_1@nxp.com>, 
 Gilles Talis <gilles.talis@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Kongyang Liu <seashell11234455@gmail.com>,
 Stefan Roese <sr@denx.de>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Yao Zi <me@ziyao.cc>, Fabio Estevam <festevam@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Maarten Brock <Maarten.Brock@sttls.nl>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Matthias Brugger <mbrugger@suse.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Anshul Dalal <anshuld@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andreas Dannenberg <dannenberg@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Martin Schwan <m.schwan@phytec.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, David Lechner <dlechner@baylibre.com>, 
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Beiyan Yun <root@infi.wang>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Benjamin ROBIN <dev@benjarobin.fr>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Sean Edmond <seanedmond@microsoft.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shantur Rathore <i@shantur.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 21 Apr 2026 09:28:47 +0200
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

On Mon, 20 Apr 2026 at 14:37, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> NO_NET is now a transitional symbol which may eventually be removed. Its
> meaning is the opposite of the new meaning of NET (that is, any
> networking stack).
>
> Update the symbol dependency by using NET instead of !NO_NET.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  boot/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index be6bb6d4535..ae6f09a6ede 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -431,12 +431,12 @@ config BOOT_DEFAULTS_CMDS
>         select CMD_FAT
>         select CMD_FS_GENERIC
>         select CMD_PART if PARTITIONS
> -       select CMD_DHCP if CMD_NET && !NO_NET
> -       select CMD_PING if CMD_NET && !NO_NET
> -       select CMD_PXE if CMD_NET && !NO_NET
> +       select CMD_DHCP if CMD_NET && NET
> +       select CMD_PING if CMD_NET && NET
> +       select CMD_PXE if CMD_NET && NET
>         select CMD_BOOTI if ARM64 && LMB
>         select CMD_BOOTZ if ARM && !ARM64 && LMB
> -       imply CMD_MII if CMD_NET && !NO_NET
> +       imply CMD_MII if CMD_NET && NET
>
>  config BOOT_DEFAULTS
>         bool  # Common defaults for standard boot and distroboot
>
> --
> 2.53.0
>
