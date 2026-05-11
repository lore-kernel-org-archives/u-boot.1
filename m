Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7883CD3427
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 01:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D194C846C3;
	Mon, 11 May 2026 03:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="GSXAM2fK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D9F846D1; Mon, 11 May 2026 03:16:41 +0200 (CEST)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 498BC846CA
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 03:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail; t=1778462198; x=1778721398;
 bh=gsQn2ZMysvyCIMKJc/qIUES/mDba5LXcNySgeCMi9AA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=GSXAM2fK2uYLYCvBg6HuPj2W38RruiuluudsFViCu7ffhM4Pb+mZsi/YIIFuC8uML
 ufYmNPRxMbYiTVG3YiGdKstq/t/1TbrmIui4s93YdR2nDSoaT6EjpFeOK1ZRctOf4G
 HP7XWgqUZ/k4PfOgN3MVGuzNRQxKjcdyXCkX+MvzMLsVWA2movXpZZEST5yOsAM/Ra
 7/lo5xFBlvjOwIGki+qerAz66shVJsLb7/Ug75dMsBrcUlB1bnkAgVJOZ3mbWRyquM
 mrrNMQjQskQMUH4e82D1Sc07sW46QN1stwf928yG4sToG6vdMCYOnP6hsgcvUgH1Oe
 6KWICst1xityw==
Date: Mon, 11 May 2026 01:16:33 +0000
To: Tony Dinh <mibodhi@gmail.com>
From: Ben Schneider <ben@bens.haus>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: v2026.04 crashing on Marvell Armada 3720
Message-ID: <so1abs7pAg9MrPZOVyW7dGcSFp2m4Tf47UW6T_QYYtgqkQ8DqrHNCfPLytOKux86LMpRM9t3fcv_I1uIYIOkdKGFkH5OZ8cEpueoLEK7iwU=@bens.haus>
In-Reply-To: <CAJaLiFzyOUV1r0gUAFpgGcQUGzmz_zneiC=AVbAnxKDcOMCvqg@mail.gmail.com>
References: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
 <9b0f2989-5c78-4e74-a691-b873b9bb2649@cherry.de>
 <ZJ8GNZXD-fYDaXZ4MCGrxvVAtJfaDjWWHRt6LlXWpQJpg3evBb4F-T9KO5yGvmFM3j643wz9PQa4ROK62TL6kKSnBW65XJmBep6yuxh2qUo=@bens.haus>
 <CAJaLiFzyOUV1r0gUAFpgGcQUGzmz_zneiC=AVbAnxKDcOMCvqg@mail.gmail.com>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 517d990862dc4d3b539b101c4b97a91ff0b3467e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 11 May 2026 03:57:38 +0200
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

Hi Tony,

On Saturday, May 9th, 2026 at 4:06 PM, Tony Dinh <mibodhi@gmail.com> wrote:
>=20
> But indeed, it's strange that commit 284e1a0 would affect ARCH_MVEBU.

That's because I wasn't being careful. The first commit to cause
problems is actually 217cf65 dm: core: Default to using DEVRES outside of x=
PL. That change sets DEVRES=3Dy via
many other options including PINCTRL_ARMADA_37XX=3Dy which makes
much more sense given my device. With the previous commit, DEVRES was n.

Thank you for your help. Let me know what else I can provide.

Ben


