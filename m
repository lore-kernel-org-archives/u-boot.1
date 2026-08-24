Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789C7C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 20:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A122C80C43;
	Mon, 24 Aug 2026 20:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iBpm0J_zg6T8; Mon, 24 Aug 2026 20:05:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787601913;
	bh=HcHFC7iZZ091pAVdIi10m4RnN07JmfSErbgPuLIf4L4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eW/qyM43kam1LzGf+3C+oKOfe4qXaE2H7lYuAuyYVG4uQUPdzh0PK9VTFvDKIX/u9
	 FI+XI4IQ5BbBEe6o36ZAIr4qEdUFNLpna3wMNgyw94uWNiNNnG3Gs55KvcK1BIINee
	 PKoLoQK7/Avm4jjvvcPvgOqGOXaRdnUbu1JR2T2HKT6Ig3dSbl+BmPc8D4nBl3OdV/
	 5KdKOtOA/4eEqpD1vPxjZveAgaBv2BOb84pSbW0HLqYeYD6aUOv6SpH+73HlpBaDak
	 Ozl1agERZNtCMKcxMC2PvzbPuforle3NJsdCYl41x0AcvDrO2P/NFYEYzbB3H/krKg
	 499z5BDRxyFPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D51880AD0;
	Mon, 24 Aug 2026 20:05:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00B324B8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E131F60672
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:05:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fux-U64f9aVf for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 20:05:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=D/Lb+2/x
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45FD960667
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:05:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D30C60120
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90E41F00A3D
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787601909;
 bh=HcHFC7iZZ091pAVdIi10m4RnN07JmfSErbgPuLIf4L4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=D/Lb+2/xY5I8qMbsYlQbSM9NQXwv4WzQBJF5of9Dw1VHqsVA/gogJ+VGsK7fSRU3e
 3tn73Y6pmVkV7Ev8172NgM35037VQT8NqAVl6oR3MsfTHztkbJvO/eUHz6dNkwam7t
 l6cOQh3sqTsY0CBXgV709FsBblDmiPtcXh+6kQR6kbcZzYdxpHHFEDGkq1JTYD2SRj
 XfV4AL59c8F6QCuf5uHDsh1XRORyir4wUn83A5NsAbW/4ctrlsJNw+/i8aAWhzh1RW
 3Vm46iLBiNWpvq0+SSSanMI/t8Pi7bQriQgOlvJefgfFOkls2qrK/9xFH/9Ygv3Y1Z
 pDCPvjvdJqSYg==
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7f0167e59a3so2983724a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:05:09 -0700 (PDT)
X-Gm-Message-State: AFuF++kpYIUVvlR8kvXVTwUlpfNWUGQDxu67GxsKrSG4wCGgH9iXynBY
 nqybrVrxiQifHb5RhoZWHfQY9IubmIgk2LhnUDd+WmRajJ0PBhqxd0DjkcZg2SV1LtqNc4hR0ox
 Cm2/1zOuBnwXgdopNwy0BJzaAPiZHXnU=
X-Received: by 2002:a05:6820:e027:b0:6b1:4e37:41c0 with SMTP id
 006d021491bc7-6b16b399d5dmr11699324eaf.19.1787601909147; Mon, 24 Aug 2026
 13:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-7-07ca794e2b94@kernel.org>
 <aoxK8lN6OIkBgipH@linaro.org>
In-Reply-To: <aoxK8lN6OIkBgipH@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 24 Aug 2026 22:04:55 +0200
X-Gmail-Original-Message-ID: <CAD++jL=X9OuBKST+-3EnirUHKh+NndV_7CN5TngaawpSmMu_0A@mail.gmail.com>
X-Gm-Features: AcwNN1UE1aj3zGIahSFNdjmc8gs6dc3wemt_qO6BC5b1-witB2aG762CuFU-oeU
Message-ID: <CAD++jL=X9OuBKST+-3EnirUHKh+NndV_7CN5TngaawpSmMu_0A@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] power: regulator: Add AB8500 AUX3 support
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

On Mon, Aug 24, 2026 at 3:45=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:

> > +#define AB8500_VAUX3_REGU    AB8500_REGU_CTRL2(0x0a)
> > +#define AB8500_VAUX3_SEL     AB8500_REGU_CTRL2(0x21)
> > +#define AB8500_VAUX3_EN_MASK GENMASK(1, 0)
> > +#define AB8500_VAUX3_REGU_EN BIT(0)
> > +#define AB8500_VAUX3_SEL_MASK        GENMASK(2, 0)
> > +#define AB8505_VAUX3_SEL3    AB8500_REGU_CTRL2(0x01)
> > +#define AB8505_VAUX3_SEL3_MASK       BIT(4)
> > +#define AB8505_VAUX3_SEL3_UV 3050000
>
> I'm a bit confused by this list now, please either have all register
> addresses (AB8500_REGU_CTRL2(...)) at the top, followed by the bitmasks
> or make it interleaved (probably better for readability), i.e.

OK I fix!

> Am I blind or do we have no support for the AB8505 3.05V in the Linux
> regulator driver?

We do not.

I have a pending patch series fixing this and a few other issues in the
Linux driver, that I will send after the Linux merge window is over.

Yours,
Linus Walleij
