Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A02E95A61
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 17:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D043186936;
	Sat,  7 Oct 2023 19:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HC7Hf/Y/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C62BA86AB9; Sat,  7 Oct 2023 19:46:53 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF9686552
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 19:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-277317a0528so683830a91.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696700806; x=1697305606; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHgMstv1HiZHaMVdEre7Y//HyvdtVe6wbsp6QXm/bkg=;
 b=HC7Hf/Y/xM33F6OVLB0tbR6YrE0pcuvhi4r3o4Yrd/ILGNuUVByQME6tecjaFFr19T
 2KqRxepKfZVeLVltUHsdZDSj3ZiQefzFREgpvbAXBerdaClVTA46hKiFm+eCiy082I49
 1U1ede/mp0kjnX9qemyzkrOhfa7I8sKFCeWcwjf8S6YrzkpKnYZAnlLlz1ptV03AdNWI
 mIVfHeFU4s1/dew4mlwWOfT2n6dXRbWozFdMr8lfemBirkD4jgYzGqIpevvfMx0RA5sv
 tRBl8Xv9bo85t2rEJ9Z2aJ65d+TSgm5Da17WECx205AbGKGdlrVpYLsr0emIC2nNOIZb
 uPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696700806; x=1697305606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHgMstv1HiZHaMVdEre7Y//HyvdtVe6wbsp6QXm/bkg=;
 b=YkJGTbYYaWcA+ROO5nPqf6aUaR1bHBqWVSCPZ+2tirY7r9Xvqzx+bn3iTT4YHJ2JeV
 5iWcPOkFXyErKv5X0Dfj/WMa/mEcwV2cu9fdyOZEIYEt4/ThdzJvem+gUaRVDXY3Wrd1
 TqsH+PdCETk5pyn5ZlhWoBTUojOMuNBZ3/M6vZP0ofpHS7igqiiXchl6vtP1Ifexy0Dw
 G0Ti5ZrlWdE2MjcjlXBxJC805l892kl3CH2D2HsjSwKRxQIgbDnKJ79vbAE3TpJWr0uL
 /D9cuLqH+MtAJDWj3DHNiRtkVRicg5WKSi3kDawTcZrLD/wVQA5dprYihcH0V3CQJGID
 Hy0g==
X-Gm-Message-State: AOJu0Yz74Y8Xo6tZ7bshQI2y++d4TUd67jXT60462PjZFdBoxOe9A1/C
 zvdcBZs1ObBBOW0HafigNPP7p3svyUMLDB7HwevW2VdBtJ0=
X-Google-Smtp-Source: AGHT+IEEMj+uNlLo0pSCQ9RgCJzK1sJL16Y2aHukmtRt9coFl488liXFmUtLVrEzlRcbRTBWi+zKq9xM9eCbSLB+ZHw=
X-Received: by 2002:a17:902:e885:b0:1c0:bf60:ba82 with SMTP id
 w5-20020a170902e88500b001c0bf60ba82mr12730878plg.5.1696700806433; Sat, 07 Oct
 2023 10:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220830174932.96360-1-alan@londelec.com>
In-Reply-To: <20220830174932.96360-1-alan@londelec.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Oct 2023 14:46:34 -0300
Message-ID: <CAOMZO5BJyoxUTBuygdL7tOyzJfRGJT1BQHJ_r0qAD8jYfC+CbQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mxs: Don't enable 4P2 reg if mx28 is powered only
 from DCDC_BATT without 5V
To: Alan Kay <alan@londelec.com>, cody@londelec.com,
 Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, Marek Vasut <marex@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
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

Hi Alan,

[Adding Lukasz and Cody]

On Tue, Aug 30, 2022 at 2:49=E2=80=AFPM Alan Kay <alan@londelec.com> wrote:
>
> mxs_power_enable_4p2() was added to mxs_batt_boot() in
> 'commit a0f97610757d ("ARM: mxs: Enable DCDC converter for battery boot")=
'
> to enable DCDC converter when board is powered from 5V and has
> detected sufficient battery voltage.
> This involves enabling 4P2 regulator and there is a code
> in mxs_power_enable_4p2() that disables VDDIO, VDDA, VDDD outputs of
> the DCDC converter and enables BO for each power rail e.g.
>
>         setbits_le32(&power_regs->hw_power_vddioctrl,
>                 POWER_VDDIOCTRL_DISABLE_FET | POWER_VDDIOCTRL_PWDN_BRNOUT=
);
>
> In case the mx28 is powered by the 5V source and linear regulators are
> supplying power to the VDDIO, VDDA, VDDD rails there is no issue.
>
> However if the mx28 is powered by the DCDC_BATT source only without 5V,
> disabling the DCDC converter outputs causes brownout power down.
>
> The proposed solution is not to call mxs_power_enable_4p2() at all
> if the mx28 is powered by the DCDC_BATT source only. There is no
> reason to enable 4P2 regulator in this case and setup of all registers
> is done in mxs_batt_boot().
>
> Also there is no need to enable 5V brownout in
> mxs_power_init() in this case.
>
> Please consider if this is acceptable and I will submit a proper patch.
>
> Signed-off-by: Alan Kay <alan@londelec.com>

Cody also sent a fix for this issue:

https://patchwork.ozlabs.org/project/uboot/patch/20230703163340.101490-2-co=
dy@londelec.com/
