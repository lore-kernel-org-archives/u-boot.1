Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C2FD2AB33
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 12:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F00FE88EE1;
	Tue, 29 Oct 2024 13:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aLR1MLmX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD158912E; Tue, 29 Oct 2024 13:13:49 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A9BD88EE1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 13:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ede6803585so1715278a12.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730204026; x=1730808826; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxWxU+uApUyy9Bnu/xvwZ8m9judisYqcEtpj+pE9rzQ=;
 b=aLR1MLmXsiXFuIRHyh3KgOkTN27x7IIQIyqqP2tEnejgXaHxGijlMRB10xwMEcKSX3
 botc1LmVt8kpzj25pu7V+eDFDrwiApA7OEe8FzmCEMk11o8xUevhCgSaq9gfP1G0A72/
 wODwnpnzK3aESMQsGsUhqXRrd04m5givzTUxzu3erW01vsr+srf+VeGkSHIYAowyoPRC
 ue7tFl65+Dk+xy+77pcLz50Ctc0JbCYMpba6wp99xjajtQtZktjNehiILLyAqZ5jFxXR
 25UMCnAdNFwvAwl7yo+YfChkI8fR+z5H0QwlaqXovcwpuTX2vAJxu7spgMEVufVVYP4L
 VRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730204026; x=1730808826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xxWxU+uApUyy9Bnu/xvwZ8m9judisYqcEtpj+pE9rzQ=;
 b=KY2/V46sPMzJ7a72CMKEjG3KkXqOIafE/a5N+tKF3xyrQifgfiG9nv3j/SLDIotS25
 GRk/6vMaiCiHX9UbeFbmhkgp5BgDghRW9+Whzz+UcvK0JzJq+8+/sjBbI5xB5te7QhFV
 T+20IYzPLO9VaReTf3Bz2OrvyBu53yA4wHkAwgN1dW8TvlmpBjUzMQQvKE0FrbaLDlYw
 4cFZ36myu5VwL5G97Hrh2WHgmSWyc3+tvVSl3Zdsfv7A5dnAsCQI1Isi1HDaz1pR45iy
 JqgagmFE1IIlu6cz23HRiUHbLyWJ8PeRVedvxpeF56FQx6jWAAhE6L5bccqUhgK/jUn5
 i9JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXwCOaz8O+o1O4GuRE12IED6lsGpl35fcJpzKCO8A0aeLujaLVp3fOJ2SaBXG56wRoPTJkfUo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4LLHp7YqJnRnx3CUbj5bVXSF9/ZsUeuw9IiTMZHnZooC6R4dR
 FDFU6/HmGkHExMgaMGI/sw9gsj5PYv8oPUqXdDZhoKXfaGqEJTcggzCVMU7On9qBvAqGP5qaxCJ
 KulpNzIZZd4+vrscqo2SHCqWsKUev+A==
X-Google-Smtp-Source: AGHT+IGJpr3COH6tnFQSFd6B2y8KphlcPuvOpb+vtLHfl3CCukBauS2YhP9CuL8ld0QGzG1rXelGVd3jHpLvOUXWSNo=
X-Received: by 2002:a17:90b:164f:b0:2e2:b719:d582 with SMTP id
 98e67ed59e1d1-2e9224b5737mr2803950a91.14.1730204025821; Tue, 29 Oct 2024
 05:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241027020504.354623-1-marek.vasut+renesas@mailbox.org>
 <20241027020504.354623-2-marek.vasut+renesas@mailbox.org>
 <b64ae1f7-c5fc-4751-b8d4-06737308debd@bp.renesas.com>
In-Reply-To: <b64ae1f7-c5fc-4751-b8d4-06737308debd@bp.renesas.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 29 Oct 2024 07:13:33 -0500
Message-ID: <CAHCN7x+W65cqxRqKZ2LsNjPHzPi3Mm1g4RmZuuLnfAUSenHm_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: renesas: Drop old unused power DT headers
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

On Sun, Oct 27, 2024 at 5:58=E2=80=AFAM Paul Barker
<paul.barker.ct@bp.renesas.com> wrote:
>
> On 27/10/2024 02:04, Marek Vasut wrote:
> > Renesas R-Car systems use mainline Linux DTs for U-Boot via OF_UPSTREAM=
,
> > which also includes headers from dts/upstream/include/dt-bindings/power=
 .
> > Remove unused legacy DT header files from include/dt-bindings/power .
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

LGTM, Thanks for doing this.

Reviewed-by:  Adam Ford <aford173@gmail.com>
> > ---
> > Cc: "Cogent Embedded, Inc." <source@cogentembedded.com>
> > Cc: Adam Ford <aford173@gmail.com>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Hai Pham <hai.pham.ud@renesas.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
> > Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: u-boot@lists.denx.de
>
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>
> Thanks!
>
> --
> Paul Barker
