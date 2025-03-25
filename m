Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD11EC36002
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 02:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5938180F70;
	Tue, 25 Mar 2025 03:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ck0zbBDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 960E681026; Tue, 25 Mar 2025 03:02:29 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D5980EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 03:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso7698754a91.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742868145; x=1743472945; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0n9VyhYuSLw/DNgE+UucsGIVtRublxF/SKV60RGCIY=;
 b=Ck0zbBDVJSjG5/tXc/5eG9V80xaNwFN3AwYw+/baSPoyynAt7/0gO/MqT2+ny23XKb
 6J8hZUfVm3aTPSD6vvK+t1+CWKVgy01uO4mEU2YH+RLi+PhgeCwJkVnjrFjX+SuTKH+R
 RSrKEsveOW7Czwfh5e2IyI35w/fKMQ2DG1rh0Q6U5/c1clBir+eTlME67wbQDalgSpEH
 PSAVEnkWp5dSCKm/IVCLbUq3wXrHT3BLmjTqmeAlKyFtM0/o6AHitQ7Bme45EskZ0W3D
 W7ClaFlHoc+daLj798lSbwpj5vH8ng2ElMS6K6aVnEHucvgBqMEPvGo3GBgb/bo/SyrW
 H0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742868145; x=1743472945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0n9VyhYuSLw/DNgE+UucsGIVtRublxF/SKV60RGCIY=;
 b=tR9ih7sxBnvOhzlsfZW5bHp4Q2qaAW/om75D+ohSnoqjwFYZGvZ8HDqjd679ODqISr
 98ODD2iINUo6MyipsggTGzmvEH6A4N0QjRmBZffUkJowW4horiNKAZLoWuCTjRVlPojv
 2JhHMYbg+q92Ep0TmbuoApbpnoM2fG/x6gzZRHbHugQ8OZUFIZyCV6fTmefRdeEuvRTs
 YRCbdkl01/EhL7VcbQcLTSdwwhr+GNDZDrgP873XdLPUlOLYttXkzbowGhB1sbrkxsf2
 sJlN+O0trE62l4E4AhemqhIixHxh4mbSXJO0vORQA/JLJR9RUVNS4k+BBK+mQwSEggzD
 4CLg==
X-Gm-Message-State: AOJu0Yy2Zy5m8ItKFjFTwQA053DzbyRs9FRMv1+KqcxhoszJH4wCEIvG
 PsG1C/rq6umL/wZYPxMOkzJU1VM9uVOs8L3vYYf30ZoH4rqX35KWQDhhwUjMsJ14tkRv5l2nd2m
 CcmIIzkpwaCW5wydqiabPe94gzCg=
X-Gm-Gg: ASbGncs9iQWLox1xP15rpjIVEp4an1cZakSmhjPq1OW7cc6cVE2wqvJqHRXuZGiUsKn
 CA/6zlabvkIakwpDlqubpHugjnUUFacm3NYwGHXjBFOvalHfaBxISWOOODsWhht3T/XtYP9PG/b
 v8RQzcxNk437zEPjZFYKVjm1M+eg==
X-Google-Smtp-Source: AGHT+IH0goOsZ6kqs4wd72I+1h6WHEV0E+sm18h2T7+QhErk40EJ73EwuU8mirKVWYb4XOJJKqeeM9fuYKOfizxGBiU=
X-Received: by 2002:a17:90b:3883:b0:2ff:5ed8:83d1 with SMTP id
 98e67ed59e1d1-3030fea76cdmr20742227a91.19.1742868145346; Mon, 24 Mar 2025
 19:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250324232725.859935-1-aford173@gmail.com>
 <CAOMZO5B_TvFw47ZO5qFfQuB9n5E0r8e+nR0CwHPeowV0dT1BYw@mail.gmail.com>
In-Reply-To: <CAOMZO5B_TvFw47ZO5qFfQuB9n5E0r8e+nR0CwHPeowV0dT1BYw@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 24 Mar 2025 21:02:14 -0500
X-Gm-Features: AQ5f1JqqJW43mxkRz_FyucELyWz70D0eW8Mg7OA68xOHd_4huGRxe1HcsZMvOp0
Message-ID: <CAHCN7xJ-fjSEnEY5=h_y1w-SdJayc9-GKeuG5d5oqmqDBH+x3Q@mail.gmail.com>
Subject: Re: [PATCH] board: beacon: imx8mp: Fix GIC clock for Overdrive mode
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
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

On Mon, Mar 24, 2025 at 6:34=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Adam,
>
> On Mon, Mar 24, 2025 at 8:27=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > There is a config option to run the PMIC at nominal voltages
> > which is not enabled on the i.MX8MP Beacon kit, so it the PMIC
> > runs at overdrive voltages.   Unfortuately, the check for this
> > condition to set the GIC clock parent and rate is backwards from
> > what it should be, and accidentally sets the GIC clock to nominal
> > if the PMIC is in overdrive, and sets the GIC clock to overdrive
> > if the PMIC is in nominal.  Fix this by inverting the logic on the
> > check.
> >
> > Fixes: ab53bd43dbde ("arm64: imx: Add support for imx8mp-beacon-kit")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Is this U-Boot 2025.04 material, or can it wait until 2025.07?

It's been wrong since the beginning, and I only ran into it by
accident, so it's not obvious.  It can wait until 2025.07.

thanks

adam
