Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B36BC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06632403F0;
	Mon, 24 Aug 2026 19:50:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FLqCJHpUD9Pl; Mon, 24 Aug 2026 19:50:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787601029;
	bh=5MVXKxOhcyKg1sPzbYntKo8yn2DVHmxTzaQ2fCXtGTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HVkPp5aC4s99TtXRMBMEgE4IojuS9nFUB52UOOpyDLlh7RircB4PW13ytwtQI+c0y
	 0pzhFNs+wdja7K6rh813YUYOWz6VM1OU7oRXXC+l3IpMB0HFf7OWXwLp3fsnpybbRV
	 LW8slXeW9DMkAIs2B4VFyAM2V20u+4rgrkFf6Jht5aqC1rID2fs3CN0ZwhhZtyDVdM
	 E4Dm9xUtlpiSqclCem99syJRCFp224pdUIErY9Oam1WhvIK133H0xykTtbxaKtZ5Ez
	 hNPrk2IoldgJh1MOgF6ONnQGihkXxp6yBDz2lftM6/BeqA1qfTwXDs4ZF6czxlC1H0
	 gzdw8AFFmolSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3077B403F1;
	Mon, 24 Aug 2026 19:50:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29532279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1AD7F80B99
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:50:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e4n5dpiHLwap for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 19:50:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nPGflAB7
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 331A180B67
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:50:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 186A66013A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C462E1F00A3E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787601023;
 bh=5MVXKxOhcyKg1sPzbYntKo8yn2DVHmxTzaQ2fCXtGTk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=nPGflAB74dKZnq5XSqx9dNe6mr6OzS5in07DHoL/S/Xb+KgLRZnUGgmHsmIhGOlcA
 2YQSRUXDAeN5m3jXiafrR1/tZwkfCUM4vDu8J6s+82OjaI4NefoHQCWS+lB54yWSNr
 5z1sYuoMh0HcswudtTtT6xotKAwHTYIdSxH0cSY0ORfzJ0yUA/+8OEU4xT5nweDH9C
 hwsSuiK9kCe8rKjB2onBOxG5kbw7elIzyFQlWBuEK7Z8SkfOpG4FaA+wWoVwwr4kej
 ilS4xpRTy3+8xcRXlvE8fbh3ndz2zdx2p/IzZao98HsvaXo6KOeOdoj2XIb5x2ujX7
 dptg/vnJc/pEA==
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-451a49abd8aso3335669fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:50:23 -0700 (PDT)
X-Gm-Message-State: AFuF++klICIj3akmUdLRazuzZQ9Mux8Vb3t+yYzW0X/+BRqTr9Efr7Qx
 f2ASEGEKKEELlxPl2PMmQbuwA2dAQ31/gxlKAosaBSWnHtTOL/ePrIgYNKnP3cnvjMvVFx7p6pE
 KF6gOFuusJ2QIQN47Dl7rwYy+RI2T5Ps=
X-Received: by 2002:a05:6870:82a6:b0:453:9b2b:f3f1 with SMTP id
 586e51a60fabf-46448c77260mr1607963fac.5.1787601023041; Mon, 24 Aug 2026
 12:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-3-07ca794e2b94@kernel.org>
 <aoxGSzMOF1o75XpH@linaro.org>
In-Reply-To: <aoxGSzMOF1o75XpH@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 24 Aug 2026 21:50:08 +0200
X-Gmail-Original-Message-ID: <CAD++jLksH3FAtssPCXu9Z4YEp3UUgKdAjPYiTz1Haku3xh+nEw@mail.gmail.com>
X-Gm-Features: AcwNN1X5MnlGL9yxVcJwb2xz2PBJhs5uYXhsaSwIxvAHuwDHXKe7wen98se-4yk
Message-ID: <CAD++jLksH3FAtssPCXu9Z4YEp3UUgKdAjPYiTz1Haku3xh+nEw@mail.gmail.com>
Subject: Re: [PATCH v5 03/13] mmc: arm_pl180: Gate idle card clocks
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 24, 2026 at 3:25=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:

> I'm not so sure about enabling PWRSAV, given that even Linux keeps that
> disabled. See mmci_set_clkreg():
>
>                 clk |=3D MCI_CLK_ENABLE;
>                 /* This hasn't proven to be worthwhile */
>                 /* clk |=3D MCI_CLK_PWRSAVE; */
>
> Which is BTW your own change from 2009. :-)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?h=3Da6a6464a0ecd20c5f1594a4fe5b24af6181b7366

Yeah I dug in my old mail archive and I remember why this happened
like that actually.

I had a very sensitive Amp=C3=A8remeter connected to the Ux500 prototype
platform and it didn't show any power improvement at all. The actual
clock gating at the clock source however did... it may be a bit dependent
on the interconnect and that's why I left it commented out, but let's
drop it.

Yours,
Linus Walleij
