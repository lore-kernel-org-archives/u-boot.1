Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9345C369D3
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 08:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17CAD8212B;
	Mon, 28 Apr 2025 10:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="c7VJLJoi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7831E82139; Mon, 28 Apr 2025 10:28:28 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26B7480FDA
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1745828904; x=1746088104;
 bh=7cjWUxIbUavBgxdLqs8H81CYvix1CUjDBK8PXJesv10=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=c7VJLJoi4cdsPDMZK552HBV4VlqeHYB2GdswuJvFHLFHa0XOD5Vur78wLa5RUw8iK
 g2j+3So5ILmNXB3Oykc3Rn59HXjw3yHN+231xqw1O/wz9hNseEQHGCFPsAPslQv9UD
 KPcqYR4HvPtp+fFrlKrLYnheb/cizffGHlCZaPGBRjOgvZOcqKGLejYDXVX2sl6zGW
 BjFlavuD8ViU4moZgwNowyARR+giFvTWJ7DwYoHgWHCvxCLnGVznVOW4qmvyB+hZ9+
 rx1Jz0FiEhrAPgWSBFF8yQboINlnygfSCC1cppkLbbhE3K/L5yrcQNPc1WnqkXwOFz
 g4xXb9a/kDv3w==
Date: Mon, 28 Apr 2025 08:28:18 +0000
To: Sumit Garg <sumit.garg@kernel.org>
From: Sam Day <me@samcday.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org, marex@denx.de,
 robert.marko@sartura.hr, seashell11234455@gmail.com, ycliang@andestech.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/3] mach-snapdragon: Do not define reset_cpu() if
 SYSRESET is enabled
Message-ID: <w1InK9OqkbhNU_HX-GJte1k3hTsdZsfbES8SsHIiNfuR6w3XP1euP6h7TCquwShzsy3vQTevbkX6uC5Ehasaz-HvSmY1OGvF04AN0BXuLhk=@samcday.com>
In-Reply-To: <aA87W3wylwsZbKRr@sumit-X1>
References: <20250410120208.4142087-1-quic_varada@quicinc.com>
 <20250410120208.4142087-2-quic_varada@quicinc.com>
 <aA87W3wylwsZbKRr@sumit-X1>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 9f2c5e1d455eb0f3a064c7ebe31202e7d5b37b9c
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

Hi Sumit, Varadarajan,

On Monday, April 28th, 2025 at 6:25 PM, Sumit Garg <sumit.garg@kernel.org> =
wrote:

>=20
>=20
> On Thu, Apr 10, 2025 at 05:32:06PM +0530, Varadarajan Narayanan wrote:
>=20
> > If CONFIG_SYSRESET is enabled, the reset_cpu() function defined in
> > arch/arm/mach-snapdragon/board.c conflicts with the definition of
> > reset_cpu() in drivers/sysreset/sysreset-uclass.c resulting in duplicat=
e
> > symbol error while compiling. So, do not include it if CONFIG_SYSRESET
> > is enabled.
>=20
>=20
> I would rather like to see all Qcom platforms migrating to SYSRESET but
> this looks reasonable to me as of now, FWIW:
>=20
> Reviewed-by: Sumit Garg sumit.garg@oss.qualcomm.com

reset_cpu was already dropped in commit 61a1a1b

So I think this patch can be dropped from the series?

Cheers,
-Sam

>=20
>=20
> -Sumit
>=20
> > Signed-off-by: Varadarajan Narayanan quic_varada@quicinc.com
> > ---
> > arch/arm/mach-snapdragon/board.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >=20
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdrago=
n/board.c
> > index 2ef936aab75..2254e0b55a1 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -187,10 +187,12 @@ int board_fdt_blob_setup(void **fdtp)
> > return ret;
> > }
> >=20
> > +#if !IS_ENABLED(CONFIG_SYSRESET)
> > void reset_cpu(void)
> > {
> > psci_system_reset();
> > }
> > +#endif
> >=20
> > /*
> > * Some Qualcomm boards require GPIO configuration when switching USB mo=
des.
> > --
> > 2.34.1
