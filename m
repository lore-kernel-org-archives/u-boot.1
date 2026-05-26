Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48B4CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 17:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 119C384855;
	Tue, 26 May 2026 19:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="DdOpUUxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C1B846B4; Tue, 26 May 2026 18:14:29 +0200 (CEST)
Received: from mail-244117.protonmail.ch (mail-244117.protonmail.ch
 [109.224.244.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3727284659
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail; t=1779812065; x=1780071265;
 bh=7YPGsaPW7JQHJ8BRDAVavpqhlvOofy9JbJ3gWbolY8Q=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=DdOpUUxNc5cV+MwvhUpDIjW7xiE9MUoPIu8mauFrGX7C5y9G4cBW3yg5Slet6VHbI
 Y01Jq14i/7m5Wcr/8hhSbRYOY/J2YI3Wjuwp0lGrRkRGI4asUeKcCAPs8CCkuPlktw
 RFWjKrz/+/bjWH1ATRw5K4P/FazFbcPGhRg1zgD0A90SZWWnIOXGr0AcLwmum14HqJ
 IA6M1FuxerIo5GlmGDtQL7GEmMR8vF0cDPtvema+d9ENEEXb33CwOwjN0q+ECRR7Zd
 AJnONmSMaF5DR+sWKnCzVjixxJhOUMkBZYNXlkIpuOrn4dmt1FFzDBfYWFjaivkRiX
 G0IbCe1VdLDMw==
Date: Tue, 26 May 2026 16:14:20 +0000
To: Quentin Schulz <quentin.schulz@cherry.de>
From: Ben Schneider <ben@bens.haus>
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tony Dinh <mibodhi@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: v2026.04 crashing on Marvell Armada 3720
Message-ID: <kaJS2I2TlB5214mKzY5xXgpgeJRX1riXHuO0FSKHKdxcmBCJrnYmp7s-ebQd7mIbJBd1_yubQEd2bxBUMcUK02KgDudVPXcBIdlIZRMTxF8=@bens.haus>
In-Reply-To: <e86f95c0-c25e-4cd0-bd21-fec13025a557@cherry.de>
References: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
 <9b0f2989-5c78-4e74-a691-b873b9bb2649@cherry.de>
 <ZJ8GNZXD-fYDaXZ4MCGrxvVAtJfaDjWWHRt6LlXWpQJpg3evBb4F-T9KO5yGvmFM3j643wz9PQa4ROK62TL6kKSnBW65XJmBep6yuxh2qUo=@bens.haus>
 <CAJaLiFzyOUV1r0gUAFpgGcQUGzmz_zneiC=AVbAnxKDcOMCvqg@mail.gmail.com>
 <so1abs7pAg9MrPZOVyW7dGcSFp2m4Tf47UW6T_QYYtgqkQ8DqrHNCfPLytOKux86LMpRM9t3fcv_I1uIYIOkdKGFkH5OZ8cEpueoLEK7iwU=@bens.haus>
 <CAJaLiFzGYZ89B7LD7z6Mese0iH3-KqM8TFbn5Vkx11Zjr-7MrQ@mail.gmail.com>
 <aU0JJd40MuUFOULadJri1Poqfq4wrvGMF7zrdOEucjI-loO3N7kZDYa32JIaXoDBcusnMxLPEuRcBTPvSkfnSf3p_0Pn0oZPXHTTZXSn48M=@bens.haus>
 <e86f95c0-c25e-4cd0-bd21-fec13025a557@cherry.de>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 7d367465f32b2a3a5043e879a55831004a019fb8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 26 May 2026 19:47:47 +0200
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

Hi Quentin,

On Tuesday, May 26th, 2026 at 2:09 AM, Quentin Schulz <quentin.schulz@cherr=
y.de> wrote:
>=20
> Can you check the value of info->dev? It's not explicitly set in the
> driver so I'm wondering if this is simply not initialized?
>=20
> If that's the case, then I'm assuming
>=20
> info->dev =3D dev;
>=20
> in armada_37xx_pinctrl_probe before info->funcs =3D devm_kzalloc() would
> probably be the fix?

Yes, info->dev was uninitialized and adding

info->dev =3D dev;

before devm_kzalloc() in armada_37xx_pinctrl_probe makes my device
boot again. Thank you! Unless instructed otherwise, I will leave
it to Stefan to fix in case there is additional work/testing
required. Thank you again for your help!

Sincerely,

Ben
