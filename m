Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D22C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 11:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8531882166;
	Fri, 31 Jan 2025 12:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="ec/dcr9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0976E822D7; Fri, 31 Jan 2025 12:04:29 +0100 (CET)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8365782163
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 12:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738321465; x=1738580665;
 bh=2WWAMvRWwTT/5l04LJKitgEHblXO8//PjRqIR8lrRPE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=ec/dcr9TXtqb8WoiQiRmFUJ6jMMm+hkH9KMhW+UmCghgdQ2kgdoOlxu9oOKN9J10p
 ptzf4IMkmghF1q0fFSi+uqSqY0xd9tjJ9l7mq0Rn5l/D6q580BHTHVRR/mgnzPkFiN
 iLn3T28FB1wRxOOcrWPJQt2Y1ieRcumEruJrZf44OH9Bjw+L2oOAroOU1r7O8uSxJv
 8FYi0BqysZuD3U7duiqJA+oC0fP86DOrmj/KmPii1E7+P0rjvzn+gbNj0F91fYCt6E
 6SpJhDYBYBkkA37LdM90bfZIjg5Ld/29byv51ZVXprz1/chcDp3s2D1XxNUR9mJ/VS
 x19eiEwH2kRgA==
Date: Fri, 31 Jan 2025 11:04:21 +0000
To: neil.armstrong@linaro.org
From: Sam Day <me@samcday.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/4] rng: msm: don't enable PRNG if it's already enabled
Message-ID: <Nc7eb6ne1yjnHZwTHdp5SqnqYu3uZEkqx1Qtuuk-Fs54ipo0bfhxzbAM2WksLzDQfdztW1txZLlWxbdvy7kGvYoj3IaOYNXq1tefJQb6qPk=@samcday.com>
In-Reply-To: <67dc34b7-1d5b-4fb4-89de-5fb4085d98bf@linaro.org>
References: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
 <20250127-msm-rng-fixes-v1-2-00f5d2284314@samcday.com>
 <67dc34b7-1d5b-4fb4-89de-5fb4085d98bf@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 7099719c2b1b97320f61a46f98ecfeeba03094c2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Neil,

On Friday, 31 January 2025 at 10:42, Neil Armstrong <neil.armstrong@linaro.=
org> wrote:

>=20
>=20
> On 27/01/2025 08:49, Sam Day wrote:
>=20
> > msm_rng_enable is supposed to skip writing to LFSR_CFG + CONFIG
> > registers in the PRNG_ block if PRNG_CONFIG_HW_ENABLE is already set.
> > The logic to test for this was inverted.
> >=20
> > Without this fix, the driver was causing SError aborts on my MSM8916
> > device. Stephan Gerhold suggested this was probably because TZ has
> > marked this as a protected register, since it would also be using it fo=
r
> > RNG.
> >=20
> > Fixes: 033ec636fcb ("rng: Add Qualcomm MSM PRNG driver")
> > Signed-off-by: Sam Day me@samcday.com
> > ---
> > drivers/rng/msm_rng.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/rng/msm_rng.c b/drivers/rng/msm_rng.c
> > index f790d3b60f99bfc04ecd9acdd21405a8c38c257a..01505509103f28f7c91dd47=
edb83c23359163c82 100644
> > --- a/drivers/rng/msm_rng.c
> > +++ b/drivers/rng/msm_rng.c
> > @@ -76,7 +76,7 @@ static int msm_rng_enable(struct msm_rng_priv priv, i=
nt enable)
> > if (enable) {
> > / Enable PRNG only if it is not already enabled */
> > val =3D readl_relaxed(priv->base + PRNG_CONFIG);
> > - if (val & PRNG_CONFIG_HW_ENABLE) {
> > + if (!(val & PRNG_CONFIG_HW_ENABLE)) {
> > val =3D readl_relaxed(priv->base + PRNG_LFSR_CFG);
> > val &=3D ~PRNG_LFSR_CFG_MASK;
> > val |=3D PRNG_LFSR_CFG_CLOCKS;
>=20
>=20
> Good catch !

I'd love to take credit, but actually it was Stephan Gerhold who spotted
this when we were debugging the issue together :)

Cheers,
-Sam


>=20
> Reviewed-by: Neil Armstrong neil.armstrong@linaro.org
