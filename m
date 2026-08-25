Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6A8C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D53B8405CF;
	Tue, 25 Aug 2026 19:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKs5u7-1SUI5; Tue, 25 Aug 2026 19:17:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787685468;
	bh=K4bQropEPZvfmOpmlfdbk1H0hlMiXWaBNGKCwBjneJI=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s0Z3MijZyJ4W4BX2U9V32/IIPGRl0FhuX3p2sdDJjXz4cQUpOE3vvIp6JoPNP9KK1
	 +JscCs/3ebSaujko0SQGYV3Z+qIGfvjVUdJ1zZuaT2KbglaZEXE89mksu1K21QyI1J
	 KjYQWVg+YSQkpzLgPyindSxnrsPvKEOz57Pc7wORTSYe+8+9MolntpgTMGh5hlUspR
	 kSdgURXO/9XMQjKHe937+WIk8QPi6YAIR5GmUMzjsU0gGPYuzLwFTRJr99+85+TrM6
	 dC4EIIkpb/5cD5f9kHWH4zUlftmGNSvIYAHfVJjLUHcCH0Cm9feY45lu/F8vnbUo9m
	 kpdsZ5HisP9wA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C04740161;
	Tue, 25 Aug 2026 19:17:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2C1B396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D498F80C49
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TPY4EURk9FR6 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:17:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=SiSxUZC/
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD64980C48
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:17:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 732C96011F
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4791F00A3D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787685463;
 bh=K4bQropEPZvfmOpmlfdbk1H0hlMiXWaBNGKCwBjneJI=;
 h=References:In-Reply-To:From:Date:Subject:To;
 b=SiSxUZC/rY5FFpCSWlc5v7g0otLtqaakM/5bWJzD3EORM2Stu5NAxg4CrCyH7ESW2
 CWGsF4cUnjr5w0HGJbg01DQWkEOB1AfC3ftBUwUA5z0JhvSII4JYuOA/s5bgPv0ew3
 W2jossNaRbRv0M+UXdnO/PCZOQ7nCeRU1f/USaCCJ3l+G/Ox76V3HKl4eS1mV/3wGG
 yBx5IOLayCJ/3o+1ttlVeSuNAofnz53FmuU+VEbI+Dv4auGoHUGXYXhn+es/v3grRX
 q1hXFM9fGqfw8VrWRbcK9qng6YMb9FBuMTySu/M7PJHdWtiemIMA06L80RWnCkWL5V
 GpEyuwSlAZyUA==
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5b2a3166398so107273e87.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:17:43 -0700 (PDT)
X-Gm-Message-State: AFuF++m+Ppoa0UpRrVh03fKsUWxC++zAb6pp5+6WCSpb4piWEKl/GqRZ
 ZTGD6W9njW+rXW3A7HvHIE9dQ1dYWDAG9Oh7nqZy3HFViyyw4+kFEtbSN5QEnH7shtPHd3YvVtP
 r0bv/MeUv9etAP6wlZaq3jfHd3b1x0ao=
X-Received: by 2002:ac2:5b9d:0:b0:5ae:af98:497f with SMTP id
 2adb3069b0e04-5b4a9046a43mr101592e87.7.1787685461905; Tue, 25 Aug 2026
 12:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-6-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-6-61446b6c289e@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:17:28 +0200
X-Gmail-Original-Message-ID: <CAD++jLk7mjUH5oLK_8QrFrTZtAGE-=18zk=aSHK_cVoZRT-Z8g@mail.gmail.com>
X-Gm-Features: AcwNN1XIXAloT-4R7a3RuxUuH-_Jbun8vGIoB2nR9GTNW16RmzyySodFdlrPKE0
Message-ID: <CAD++jLk7mjUH5oLK_8QrFrTZtAGE-=18zk=aSHK_cVoZRT-Z8g@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] mmc: arm_pl180: Power down card supplies at OS
 handoff
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
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

On Tue, Aug 25, 2026 at 9:04=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:

> PL180 card supplies remain enabled after probing and while U-Boot is
> running. They are no longer needed once control is handed to the operatin=
g
> system.
>
> Mark the driver for removal during OS preparation and disable its VMMC an=
d
> VQMMC supplies from the remove callback.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

CC the MMC maintainers too. Will fix for next iteration, sorry :(

Yours,
Linus Walleij
