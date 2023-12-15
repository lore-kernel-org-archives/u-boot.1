Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84299C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 01:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3CB987B20;
	Fri, 15 Dec 2023 02:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YzULL/as";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC2687B2E; Fri, 15 Dec 2023 02:17:28 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0846A87B05
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 02:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c67fdbe7d4so50774a12.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702603044; x=1703207844; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRnVgEcJAGg5rCvUSpW7KxCWJ5Do/iJtcHva5JTR2g8=;
 b=YzULL/as3oK/qmCfn8DuLzJPz0p3EzKAxqPMslv86TYfEZSa/DKwwa7l676RxgNMNh
 wdDvb1DpFFTpFaAS7rJAtbvUiUP50rJvRhOXuulh5ubJg6CM7Rpc/jTo9NTHz75gMfNU
 Ea6zA5wuFDJMk3cETyCXPYci1FMKlcnaqFGnHnVgHa5gXDl9Ekwq3ka471wDUauubFWy
 jJdsOcUho5UQIg2cKx3/0KKWIjjngBI2IY0wxKF74QvR04Zutdzk6LLCy1XSEy2e9Gy0
 diaw8uryX8PCO1LAT6wFKpsWIHaC+2ebs/hxGtQQkyGA0zhZ7iAszENLmFesK+Vo3Xtj
 2kHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702603044; x=1703207844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRnVgEcJAGg5rCvUSpW7KxCWJ5Do/iJtcHva5JTR2g8=;
 b=OqQlCygVmgHUcj2tJEreczHvp0uzeVnhia13suynM2NOGb8OvNoqKaAHPRDL1YyO6r
 4Adn9cSmwRo5DZCr/89VYxzQGUzRZGp9cQbUqFMRYK/hR/MRAXZsMAgXy6r0ze6AuNFf
 fRQflt9Nrny2DggmgbxTHknOzHnPrSbV+dip9Q2Ap/9fPetnliF6wds5el1KalFBzrfs
 oUvMIY4YiFcqhFKutDWJOz7eu+al1NRbLkyCXQsIjg8Ga+0OM2WwCSbJhb3xVCpa6Sdj
 vmSTB7k6ffwXGmvTI1OM+TUZHA3DtUxjx+Y3NDRXCh4lT3bN3zQ6DH/uFiCS8KgAU9HC
 CVqQ==
X-Gm-Message-State: AOJu0Yw2H6LuPojgWra9K0FyM/Wieu5VVwbIbdmvt/2jrKd0y3lqYwx3
 0ows00itpdDMKqB5y3YG0eip8MMslzz9VszQGcY=
X-Google-Smtp-Source: AGHT+IERrBvem8VIn6AJ84aX/q/vtptGMFq1aHP5f93eKZfApgYU256W19xCQ6uYUWsuGmqUqBGF1pmxd0b4OLCvXoc=
X-Received: by 2002:a17:90a:4583:b0:28b:c60:8dd0 with SMTP id
 v3-20020a17090a458300b0028b0c608dd0mr3045478pjg.2.1702603044348; Thu, 14 Dec
 2023 17:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20231202014826.212858-1-marex@denx.de>
In-Reply-To: <20231202014826.212858-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 22:17:12 -0300
Message-ID: <CAOMZO5BLNJVGwxEVQ0t0qfVMZK=fAdZZ6=+iEskXWowfxQ7tog@mail.gmail.com>
Subject: Re: [PATCH] ddr: imx: Handle 3734 in addition to 3733 and 3732 MTps
 rates
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic <sbabic@denx.de>,
 Ye Li <ye.li@nxp.com>
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

On Fri, Dec 1, 2023 at 10:48=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The new MX8M DDR tool 3.31 now generates a programming file which uses
> data rate 3734 instead of 3733 or 3732 . Handle another rounding option .
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx master, thanks.
