Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0D8C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12F3E6070D;
	Tue, 25 Aug 2026 19:13:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJ8NqfsP0sLQ; Tue, 25 Aug 2026 19:13:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787685229;
	bh=3Eci2ha8nEzQDittqM11QBJ1RBhlyEHiVk8eIv3evlg=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yd+KNhbJC7J/11MXu27kV62u9pEWCziPWNlTO8Xz99/+3cwojtB+/4e3ASzZQI+Hr
	 6NP3dVdGS97LjbqJ/jLZuyrPhRZFQS2YS6AlaLXpnajLHLCYZ+By59Q+Rltnzfyj/R
	 piZLmoO24W3xnprKTT4Bhf/s3BOTKyRqgZNLj1nCUTRKM2wgpv7KF27/PLKh6Z9VJx
	 Ku/uli/wiIXoIPlEvs3eiKFtkPwj1KFAVlH5FVyPMYF0JQdwB3uSFUo7hCEPn/DVjC
	 YvUhIVbCjIkawBJWEdcxut73SiYETa50KBMCU28sKseQyQUEQ2257T4bwqiJ2xSYhW
	 uh7CGmD9sh8RA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99BE9606FA;
	Tue, 25 Aug 2026 19:13:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 325B839E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1917F80C43
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HOBkDMPAZBiC for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:13:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cyOQ6nYm
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77E5880C41
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:13:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE204413B3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A229F1F00A3F
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787685225;
 bh=3Eci2ha8nEzQDittqM11QBJ1RBhlyEHiVk8eIv3evlg=;
 h=References:In-Reply-To:From:Date:Subject:To;
 b=cyOQ6nYmK4NIRy8LD7LVlq8Aftju8N5L8TnqUNw3lhJEtxb7eEhEqC/04nZkEC5b+
 hutXNXq5lDrUegVnFp6TfQ1ipIntoxfqTMSZuAAm8fVGCByhoaK2dYiV/FdxP9NSVi
 id8gs+m4cZFgLmyi7Eo+XYNFHTFxxyE5lhT6bvptCqZ16K2drTIJwB2mcih6637rLG
 DiUEIL0ai9lO0ZTGMxDwaALEskch46EADMK8DiUPkFIGWDJtoJt85uCpGBK1uQ6xpV
 QZ6dTFdTx2neubwfAtp/bXRPKrnjOp01oS7QRfxOxiup+fvIBgTqiwTb12uFn3DhSf
 ub0HkmnYE16HA==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5b0f19bea2fso106429e87.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:13:45 -0700 (PDT)
X-Gm-Message-State: AFuF++n8EofYzpueWrehbPieEeSf7xezIWSfpsv50OOe/amCwpW4ngOk
 xrTyE80blLfV8c2L81Pb4P3qKTmyXQNUoVAX5tXssf/iul7fNkoZY/YgdDuCy7ofwlTZDwTyxJf
 y2ZD+NHblLmPyZPXTqC3xNzdqfTyg6bU=
X-Received: by 2002:a05:6512:63ca:b0:5b0:c96:cc8c with SMTP id
 2adb3069b0e04-5b4a9061a77mr114213e87.12.1787685224427; Tue, 25 Aug 2026
 12:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-7-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-7-61446b6c289e@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:13:32 +0200
X-Gmail-Original-Message-ID: <CAD++jLn1wi7N0qtSfEpVepkHq4PQQKHW2Br=sOvPQxDUCU3Epw@mail.gmail.com>
X-Gm-Features: AcwNN1UM_vjXF8sX73May9yrFjMNZlw5_hDSfpDbx16gVefRn5UayXlvRaM3Mbg
Message-ID: <CAD++jLn1wi7N0qtSfEpVepkHq4PQQKHW2Br=sOvPQxDUCU3Epw@mail.gmail.com>
Subject: Re: [PATCH v6 07/13] power: regulator: Add AB8500 AUX3 support
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

> Add regulator support for LDO AUX3 on AB8500 and AB8505 PMICs.
> AUX3 supplies the removable SD card on the upstream Ux500 Samsung
> device trees.
>
> Support the AB8505-specific 3.05 V selector override and clear it after
> programming an ordinary voltage. Treat both normal and low-power modes
> as enabled and select the supported voltage closest to a requested
> target. AB8500 cut 2.0 or later is assumed.
>
> Imply the regulator core for ARCH_U8500 so the driver can instantiate
> from the upstream device trees.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

As Stephan mentioned, I forgot to actually use get_maintainers.pl :(

CC the power maintainers to bring them in, will fix in next patch
iteration, mea culpa.

Yours,
Linus Walleij
