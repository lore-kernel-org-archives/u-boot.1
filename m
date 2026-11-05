Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC87606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SDZuq0ls;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=r4hYvEfH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6CC240802;
	Thu,  5 Nov 2026 07:12:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z1oI1Z1xG6Gy; Thu,  5 Nov 2026 07:12:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A26FD407BA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793862743;
	b=iFDiic3xxBbAu5T3cEG0eVdcKfEhEPfWIN6TFj4ep+idEl5CH8MqA2AtGhGMEpj37Dl8
	 yF+oRnDCuv464ZPRK+a1I45eEe3RDZ08V3cgSXfA/WLFlkRxvbCG83/OJxJZYTwkrsVP+
	 0jKHns/taxKbAO/scd4TU1PVGt/G2sosK9INGBsJXK6fo2wfY5+QAJq684260rtnMf5ub
	 ThQVhrRXEUl0F5xVNJRUcj25kYBCn9jdbAbYorDEiU9/wwTCXSuYLTLj+uUlUuQhDhcX6
	 46BVSVQ1vJVSzqtvay4mthVEZyPYCBafrI2/k7JVGd+VArfb3MtSF4VUx79ggn+1Ajw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793862743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=23IzwHJbKCo8ZtvLC28i47eFADF7LHER2dL4JLKxyms=;
	b=hLpUkdhSbcqlchhAVfEXhyOfNtAzNzIf3ROML40DzeQhnfF6pcZok7KD+/uIseiRw+2B
	 alBe51ePR5NHRrMV+Tv7HXMifh5r77Zg8+/gdn3ElWjXXhnANnhqUq0xFkEPIsKff9eU8
	 XXZiszTCjX4YK3eCueeevIJEgKDZn+W0yl3uKyEKLejuYbpegkrL5cJPMIssK2zJMWhFL
	 IUNv9dmReNIXzTEKDHhFcFxcgVClPspSh0UHNekZza/G3EuMvNi+L5kYUAy9HJtmxPCXz
	 3OPVmIGPEBS2f1/pw9jaErtbLfHsEkwi1BvUUzJkyn1LwUOqWEBx1HMuJvvJDuguQvw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793862743;
	bh=23IzwHJbKCo8ZtvLC28i47eFADF7LHER2dL4JLKxyms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SDZuq0lsMcaAKHVTovaUjygqqSdgwT5owQQCc55p/6GT5RoSBsWzdtf3wvK1DJLpI
	 vKkMEcAYztgF6GO0/RHa3RQH2dcdEa1i/txyQscQzwb/JPqJjYETQiJPFwCdiRhBmQ
	 xn6JgqtX6ii9oZiv3u0nz1lgqT+bJqYUQjECmzNVDnT43F65YQXOEthY4ux5iCwGR3
	 3TftN20CREF8WP8dY691UByWwQh5u8V+WFn7/0d0Ky53kkQZyNYRnsOJdiqZ92YdTW
	 DoCBw464sjq7xP32i6SVPd2mmCWuuMtYQ90ZikWNT58Xxv4tgZ7zcY40sImBo0yVA/
	 nkpGb6FzdNJTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A26FD407BA;
	Thu,  5 Nov 2026 07:12:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 02B36362
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 07:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E812A60728
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 07:12:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rDxbD84AB6It for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 07:12:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92DB7606D3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=r4hYvEfH
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92DB7606D3
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 07:12:19 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-679aeeddc6bso1639604d50.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 23:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793862739; x=1794467539;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=23IzwHJbKCo8ZtvLC28i47eFADF7LHER2dL4JLKxyms=;
 b=r4hYvEfHo2NuzmZOqUUN19RuAM1xL0vO5ZRCHLl1Tb0zcZ3b9CD2Gd4qG6Zq4W7a8A
 NvqOmN+mGnTwluCnNTFYVXbI7je2m+WDt6i73OgW++gfzJg9BNV+p9Ime73OJMx2Kqg8
 WZS6cuZrnMmfnrA2QLZmjQm2GmOkWB2/n0xqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793862739; x=1794467539;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=23IzwHJbKCo8ZtvLC28i47eFADF7LHER2dL4JLKxyms=;
 b=Avp47im795WyUFC9VFO/0I0aBlNqHSIP0Crl8eGM/1WIczY77uAdvXViQXIJaszDLm
 j3eNhv1L376vwPDLuu8b/wo9h+ugAGfvr9oa9QhNWZXRLi6V1nOIlBczgpb8gNsE3GJX
 wzqIOYOpx3Hv4xRLY1xltx7C74iqOW8mqbNwa4g39cuShemas9avkzboFkwfT3iHE5bQ
 9Dl2kGyd9Y8AKJxn19QAsUp69651WWWxshKzbJLariSlWu7QwF9bsJUvVSe1BwumHh62
 rn2SVXouWLWm6ISc7fLk2m70KLlQV81JziE1DYg9hEbV9CcD6QPdkguwe5RgBKxtKzrJ
 i6dA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOQ+O8UUkGJCI7sgb2Lt6Dm62MlqthcwU454FI+iMFFTiOipcg+dQ4m9aHOnIECN24b5qa9Ag=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z84tIilNhNVQ/2qbx/OHfNGqvPGtuQKmIf4dnY0upKTkIF1C6ra
 MgQ67Vxaa4Z2QMTnPXXU+Upv/Mapg794/JJS6+bQ4hMy7VUd7PEKYfU5kIPC8zGVCyuaEJEIv/G
 1/jNA/0g3syCSLWdb4cVJYFNaNYmkB0CR32VNgRbL/Q==
X-Gm-Gg: AYBFou1itP+5jBBFn3SQq8zsPXkai/Zf0WUK3b6iq7uUuXcJADPVCw11mNrMGK2TWIK
 i4KUmVDUopH+POwbpo4h8IzRWU4mavfbwoYo8dEadw51g/MsMM0B37rOR3TReSzqVGU8ZxZPnj9
 qeOvw7Nos0KozeifLHsb3fdca+ZacbKTyMtgg1ba88vwb46QrF9H9hzIwGk4gQr78tWpPcU5kSV
 Baiftqf+euz/H18nmoYXKebfwAIMOFKm9Y5vr9xLlA0WryYqvj0SyY3XFCkv/u1dRsUDf3hbZ4V
 TtGb570akToqqauX9M0i6ncZDAEQFRgYuC2yK+gSdFgqPwfdsZGNVPEsGfKT+pc+EPmnHCFqQOi
 vbMxSxCyNeUkpSHu66OPpjonKEerMlwgDaRJPbX/efvm1ZpYI/vRb/Pg6QTcG3UpzXHEm
X-Received: by 2002:a05:690e:1208:b0:67c:43f:83ad with SMTP id
 956f58d0204a3-67c043f9b87mr864565d50.77.1793862738685; Wed, 04 Nov 2026
 23:12:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
 <20261104192118.GD1164024@bill-the-cat>
In-Reply-To: <20261104192118.GD1164024@bill-the-cat>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 5 Nov 2026 08:12:07 +0100
X-Gm-Features: AclHuK8uHEr-OQTTyYIlpt3PErlx1mWuAbb4dXHvqyrltBKB5UbrypJ75565n3M
Message-ID: <CABGWkvqisJBzV=tRQrhZ87evgF6mTff+dJvO1LVwVQC-YX=DpA@mail.gmail.com>
Subject: Re: [PATCH 00/33] Add Engicam MicroGEA-STM32MP257D-RMM board support
To: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com, 
 michael@amarulasolutions.com, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 David Lechner <dlechner@baylibre.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Lukasz Majewski <lukma@nabladev.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Wed, Nov 4, 2026 at 8:21=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 04, 2026 at 09:49:33AM +0100, Dario Binacchi wrote:
>
> > This series adds support for the Engicam MicroGEA-STM32MP257D-RMM
> > board, with its RGB and LVDS displays and the FWU A/B update.
> >
> > The first patches pick the board devicetrees, merged for Linux v7.4,
> > from devicetree-rebasing. They can be dropped if dts/upstream is synced
> > with v7.4-dts first. Then come the fixes, the refactors moving the
> > STM32MP2 environment and FWU support to the SoC code, and the board
> > support.
>
> What's the status on upstreaming all of the changes you're putting in
> the -u-boot.dtsi files? Thanks.

The -u-boot.dtsi contains:

- U-Boot specific nodes and properties: the environment partition, the
  FWU metadata and the bootph-all properties.

- The RGB and LVDS panels, with the LTDC and LVDS endpoints. These are
  already upstream in Linux, but in two devicetree overlays, one per
  display. Since the display is selected by the "display" environment
  variable, which is stored in the eMMC/SD and is not available yet
  when the U-Boot control devicetree is set up, both displays are
  described here and the board code keeps only the selected one.

- The LTDC "lcd" clock for the RGB output. This is not upstream yet:
  I sent it in an RFC series [1], and Gabriel is reworking the STM32MP25
  SYSCFG pixel clock support, which should cover it. I will drop it once
  it is merged in Linux.

[1] https://lore.kernel.org/all/20261028135915.2665857-2-dario.binacchi@ama=
rulasolutions.com/

Thanks and regards,
Dario
>
> --
> Tom



--=20
Dario Binacchi
Senior Embedded Software Engineer
M. +39 328 0625246
dario.binacchi@amarulasolutions.com
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
Amarula Solutions SRL
 Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
info@amarulasolutions.com
www.amarulasolutions.com
