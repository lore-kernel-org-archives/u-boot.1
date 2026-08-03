Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89A1C55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 02:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8447A406AB;
	Tue,  4 Aug 2026 02:15:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZ6ooITOm188; Tue,  4 Aug 2026 02:15:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8221E40670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785809729;
	bh=rh4vGvKDdYSFJDiilkbxOxOy89FKzZHP99/BAW51SSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=csakTTaLdRXRK6SDodqbLECn5VHkgW3ouzHUPhkpE5LOTTWzFya2kQY0aGiIJ/GUD
	 s+BtyncKN5yiI3Kz0ytVLrXjSTf33PxiSSNgRRPzey/ZxCPiSj04XdY7TCtiwLXmQw
	 AIZ1aQ6sqh4Dq1X5ZrJbNoRTJ2c7qcWd3CoC5UQ6TcPLCrmWQwmbt9WDHzS4ItjxU8
	 XLEoKFPBz2CcShbhnGrbmZygo2PosRFn/T1wUxY+wVZQ7dW7X66ASCrgu1kyT9V2U6
	 OXlnpwHE90cco1ik2Mxtpv+ofhzXne3oLs0QbNyophX97Odor5hEYryd/FxvDAH3le
	 ktgaECZLy0uVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8221E40670;
	Tue,  4 Aug 2026 02:15:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E5F5F23F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 21:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBB8E4062F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 21:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hk8SS5c7AWlA for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 21:07:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e29; helo=mail-vs1-xe29.google.com;
 envelope-from=vicencb@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C594440591
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C594440591
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C594440591
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 21:07:05 +0000 (UTC)
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-74ace427b29so1042784137.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 14:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785791224; cv=none;
 d=google.com; s=arc-20260327;
 b=lme9A8ppqFWJRMBZhDrwIkDnyfSsJywlTUWU9lXoG5YGXTtKs0cJUz0P8lhyOPA7Wm
 Z3SN1E1a2rS0ZFX6z4ouy0OspACiP6Myn4xy9bXk2DUi+FVYM1vjB+inCM8wSb31c1t1
 R0OiCDqaPwqA6l3eCzvB5RSWczi/nZ+hwhJKQGQhpS3cBrIgYJytVqVNoPO4N8dQAN3M
 aHVTSzK/4pQnrAngDqB3wCN09qYn59Ol/+zKREuGD+UrA+G+ZLxdzkx/H0rrU9CozR3r
 zRiC3SqZs4JH0NAR/3++uzBkRcsbu9aazpbAng0cFLDz6pVsZi76+XQ+3uywbJAUY21a
 YqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rh4vGvKDdYSFJDiilkbxOxOy89FKzZHP99/BAW51SSk=;
 fh=hZ266pH6B/L51Hvhx9sr1Wd4wQ671gb9JbPdZ+AzQAU=;
 b=GDZdpzIHlD0ke4KovcP56eRgarWsCyaQ5xCGeVyS1TLtSq77b6ANYT9vBFSW6p+aGV
 WZZCNce+E59EpTZO/h27otDp3t+RIPAGHsxpdlA5WnEnrPcxWdEvUKAuZb5WJaPnWzgH
 oZR8PfmfQqNQYMAFk/Vb7WrHVC5tlXex8X1Ud9hldw3sSRsh6t4NLX+6M1OK1eT5tGrF
 ba6p66fC2/n51ohuCvvy6ERXaGDQqpAEMrUml3P3xILBaI6nMjEfKKbyoSqMqd9AJS5D
 Z4sgjvU+X2UTv3gPbZVRWLpgzVcM4pCLkd+VzcD4OmbLHt2B5hDfd6XNdRdkgtKCCIQx
 tp5A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785791224; x=1786396024;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rh4vGvKDdYSFJDiilkbxOxOy89FKzZHP99/BAW51SSk=;
 b=K7P+bStRcJv7aicBxPF8MVG9W4rhOxfdQxXK8uDeu6rSUcdntuQQ78PV+yeHXp6Ayz
 LKmllhTZtoZ5RyFvAk7ANL4zwCiU5bRcrJBndpW7NxXc8FYFtSdkPVU9Q+vdmfuCqPrq
 j7T+bwGkFwKaTXnt8TZ1BsuVC3IxGrgDafmo+vc3ZEGiETknXD8LTfRQ5yEl7sSDoKuN
 IYizDunhaKd51V/dIS+ufm3YTBPGx6ZOyl24gSsYTLEqRMgryqC7gMmQ3DCZWzndgJbM
 Yq2hZhzxOfnE6KMVgTG4OfQhlImqsmMmvCamD4yzctsXoD4PGl6nPaLZ8Ic3lXS4/hLz
 ihGQ==
X-Gm-Message-State: AOJu0YybsDVZ0wSbbRcWafqXyfPVk7r8N7Rx+C2Qjkx3jPq51dXs9BP9
 4oZoD/piI6I2mMMIwWZCpIi6fMDi25pop2pLju9nr+tTx46ISy9tAyomMQI3aIRDe2pAGhVcXe1
 ACNADwlOGhQY6OpFChbiiNo7qdiKg/DY=
X-Gm-Gg: AR+sD10K101HsgNTvwSrd/kE++whhsCb2OhZDLXYfCIDuuIyVvD5+d8IFtRbkYiiE0A
 joZLxX4haJLHm6xZr8daH6wh1QieYtuP6tFf46BlBp8IEW2W1O8Rrpq5ipiNsblv4ka6RmCk4wx
 /FFf83vLBi2TaZ4icCsp0VjHZfJXm7ClYHzNSii3A7rWq9Op0X9OSaV4936T2KKJZkBAbiJdYcR
 Ne+sBytE0/R17wD/PPuGLOYDTDEDCbh+i/yo/N1gr/DYRE9dUmWoRJdCUMk6YBhfOalhwqDRGSy
 NDCeOgB+KMI2Ds4eFStQnnyuO1Qz4MrtufMbYkvGHM50OT1Au1xupYKHjxI2A70EEongltyDR9T
 7Lw==
X-Received: by 2002:a05:6102:50a8:b0:739:71ef:d772 with SMTP id
 ada2fe7eead31-75b22064adfmr8207656137.4.1785791224380; Mon, 03 Aug 2026
 14:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMcf8A2fkH41UP9jsJZSaPS2PUaoB_CNT5g4E4KXG0thmUvOQ@mail.gmail.com>
 <CAOMZO5BEWJanHUwdzzJ9YL+c-M=8XW43vvD_Lg28=ZU6+cPK6g@mail.gmail.com>
In-Reply-To: <CAOMZO5BEWJanHUwdzzJ9YL+c-M=8XW43vvD_Lg28=ZU6+cPK6g@mail.gmail.com>
From: Vicente Bergas <vicencb@gmail.com>
Date: Mon, 3 Aug 2026 23:06:53 +0200
X-Gm-Features: AUfX_mwrVjcG86TayOre5DH0f79jxaYWmuDS_NK1dOHoT0rKypUxf16D6_FORIg
Message-ID: <CAAMcf8AnZ_YAUo85XME6VPyBM2cqd8OO+viNgZeerbMzasHqFw@mail.gmail.com>
Subject: Re: Issue found when porting to new device.
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, heiko.stuebner@cherry.de, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 02:15:26 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785791224; x=1786396024;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rh4vGvKDdYSFJDiilkbxOxOy89FKzZHP99/BAW51SSk=;
 b=btGiRPxaaGc36BL1bpj9MLohPpsXsxuPoKxLNQJBVbWLRRdrbeKK0PTTD2byirbCw/
 5x4U0Hsk1NnUaz3AsPfqqZ+g7lDh8uiYwkLPFNdW+izrIO0OhoxOgvLOFigvsQtqPGN3
 s7xmr88STWU7dZvA7HN5v/zwkK4c37pGVu6LbxOTo01AzN1Z/AQqH8IcZu88EpTFn5ET
 fo8HsjXTCWrkq8tgPF3RRM2ppCrariFbILU0MlnRHh+uY4IYBX4PN/R6dYqUonOfSsrZ
 f531q4LAihsAyg5djNHvLPjMvWazg0ehuPtEReAkfFG18NDX5pNiqntYi18X8xNGWWP+
 VdXw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=btGiRPxa
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Aug 3, 2026 at 8:52=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi Vicente,
>
> [Copying the U-Boot Odroid GO2 maintainers]
>
> On Sun, Aug 2, 2026 at 1:35=E2=80=AFAM Vicente Bergas <vicencb@gmail.com>=
 wrote:
> >
> > Hi,
> > i am porting u-boot to a new device:
> > https://handhelds.wiki/R36S_Handheld_Wiki
> >
> > Given the similarity with ODROID_GO2, i've based my efforts on it and
> > all goes fine up to the very last step: jumping from u-boot to linux.
> >
> > In the file arch/arm/cpu/armv8/transition.S there is a call to
> > armv8_switch_to_el2_m which is supposed to jump into linux, but it
> > doesn't.
> >
> > I've added some debug prints around it (see patch below) and it prints
> > the first message:
> > "before switch from EL3 to EL2"
> > but it does not print either of the messages after.
> >
> > As another test, i've tried to replace
> > armv8_switch_to_el2_m x4, x5, x6
> > to
> > br x4
> > and then it indeed switches to linux, but then linux crashes, prints a
> > trace and reboots, that is, it doesn't like running from EL3.
> >
> > Please, can somebody help here?
>
> Are you using a recent ARM Trusted Firmware?

Hi Fabio,
the version of ATF is the latest one: 2.15.

Thanks for your attempt for helping, but i already found the issue.
A few configuration options were accidentally dropped : FIT,
SPL_LOAD_FIT and SPL_ATF.
Now it is booting linux correctly and i switched tasks to port linux.

There could still be an issue with the macro armv8_switch_to_el2_m.
The current configuration boots linux through another code path.

Regards,
  Vicente.
