Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A7EC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 14:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEDB44051A;
	Wed, 26 Aug 2026 14:34:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bzNfb8oyXAfQ; Wed, 26 Aug 2026 14:34:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787754854;
	bh=MDcUAXoVrHqibQhE69jYSnstdVzmA3DKadiRS14cpnk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rEwgh1PXOK05rDo+THmeMzfX4pck1OTi/ChzludlX/RW+jUPdlH6wLcwvxNH/cJvp
	 pAu2Vn3AbKa3M6sVyUNjlm7q1I2R+jvOGEkoGrIYOejDSyb5NgGXpkH62k4I7YpRIq
	 i8OIQ2eHMALefdgqO/I6PeA6sFtqH6PZciqr325vyL0+S2D5QE1kNMxvlmAHlGvMlC
	 rvIxKD3s9pxsLf1faGkKntQV8H9IvvkdH9jUFwcxVXEb/Mzy2FKgoXDaxV/LGrUw/Y
	 V35S0o8sHgxdZMhfT2V8CwvRpXjYUQ25JP9rubVuKvQLh8qnKL+XIOWXY5Skd+Be0h
	 HjR8oTSRMaqnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAC2640435;
	Wed, 26 Aug 2026 14:34:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E510396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:34:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 802326069D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:34:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JcywcrFKhpDc for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 14:34:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UUIUL6MM
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC4EC605F0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:34:10 +0000 (UTC)
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66ceaade3f1so1005977d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787754849; cv=none;
 d=google.com; s=arc-20260327;
 b=h9kT5i/6Q1R1Ugc70DevOXWNRus0Isn2uLTU1YFLaP42gvLi025F2IzPAkpYBmW0hQ
 i6XSw9QRc4Ew109jCV6OGBq1uunBSlnmzOS/EyPdjarx9lb67yeLkiLejuzFiEi4hQ9S
 /5zwA4etnYxgFEXpgXfbyUeEZbgqIQ3XbvzkKSC5SaZDANwutVSkFZtc4EA1YcnbcLXO
 C4fSgz0KWRNlQ4o0b/sK4ehV4F90wKPjSMWbV5WSPUoq3bMZruok0JJvBcEHs2B/dmuJ
 np/YzxzNo/UjQWkNc4W69tUnm3W+HgbVFTo7TDGn+IfnVvXXBPM4kEibElZuydPh8lQp
 IuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MDcUAXoVrHqibQhE69jYSnstdVzmA3DKadiRS14cpnk=;
 fh=bTGrAUloMYnT2MSEYasO85rVC0SZCH6Mav5rgWDqfSw=;
 b=U4s51+axfEsy8q5zYEGNZWIzaoKXmF+v1rd0+IzxI3dlAZGXJVlEIlvuE3Agr7islD
 aG+O1wXBf0MvxMOKX9RfgnT5d+JtjwqDUCnXaiOHg3WWeLoPTtOKMSZ9WnCf++KLefv0
 qjQDj+l6O38tVUdrCcpy3KxcXkP3PnwXlrABskJTbjQFx7Hw/tMpr+jbCOWRhwO5Fe9D
 ENNiL8qU04F3ZFe4TSk6TzS1D9lBnSk4LmSNBzC8J4VWkQ8d6K2pt5pSBSsnNCAakKEn
 aqdM+8k8MtwsGif8q095vRiFLa00If+2NnBbzb/ST1tLcDzY7++gutKTTPrCDoZF5A6E
 89tQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787754849; x=1788359649;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MDcUAXoVrHqibQhE69jYSnstdVzmA3DKadiRS14cpnk=;
 b=UUIUL6MMIzAQY1kpCJlKJCHjsGvIfWYvI1SGNHBasw/bY8OyomaeW+MjUn5MmiNHDn
 JHZkwnrN6lADgC4KLgQELbkaTJItDu16jYh4ZTMFPfxncIKjIwlLKXX04yTDFZWK/Oxi
 FYsrCxpdK6M7/yH7FwqJrPnaQVSza4WM1EWu8ZdsF/qWCyOaT5xrn/58dHFwLcUbZWTu
 91UofI4vkM93fJP9VRCpSTw+TwD+GZ2pWuRLrW2LXt9mnhvfI6sRBteu7HyMZxo1VHKK
 vbcncEuO16+DLOjSd488k9j4AU/IIWdHeYWIKDfPULFNWQIM5lq88TWogPJ8EMowwoYK
 K/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787754849; x=1788359649;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MDcUAXoVrHqibQhE69jYSnstdVzmA3DKadiRS14cpnk=;
 b=R+XOvaSFRvgxUp5WHrZCR57un0xR0QTTqdl7lH3xE0H5SqGqFEVd//bCY5q3EDy0fh
 uSn0CqJtvbACmSxPMmJ976e2mFR5wIToQUsVP2429tfLDf+1gbSizWCW7fcbYwS909o4
 oXeTHC9PY8nctzPKsME2S7Ljs7T6eOnJsld874ZXyRKvT+DRCg/rUqxswPPQjzGLX8Yc
 OufSgn6U+bImo5RZ+el/CCCR6TnOdasvFPdN4XlYQA64zrwpWDK86zh46tfBS2eaR+bT
 rqJ1QnIR3KYCMRFJcA8Q6NI+gs+eUKMSWl1dzrvxtoAO/OldmMjOsHpXIvtCVdNxztgf
 VtMg==
X-Forwarded-Encrypted: i=1;
 AHgh+RokgYfz3YRT6s/L9Fvc0fXhX7qPm4SR5PB3DMlfIPoEZOxIZL8Zf8d5Tz7t6xlMmFnhWC1r05o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nUWZjtQpneYcKVC1KPz5FWVF4eiSnLOq26xiZ222oIrBiYZ4dB
 orjeS21653Eu1QY23aBl0AeKvybwk0+DVzhUTZgg22XZQsGeQNqVwu9XAnQymaDWeI84fHh4x0C
 cDN6mtVeKw+v4NqvzkbaEGQI5E5o6NvE=
X-Gm-Gg: AR+sD11PRqrIrnqkX0DC7B0ELrspE8rnti7254rnXazi+QaRpcyFunVxNmcADK3pvDX
 4lZQtcneuRoSlbKZNUFlKMkk/aYfuM1Ug2ufqVs1rNQ14Bgzwf/qsllfU8m+6cguF1FjSuEcfre
 F0WKskCQItHDvjYR7jSoX3AHwJcDo4MS5akBQsExOEqxI5TQ6N9cNekNOXux64LDDZaJ44/JKax
 TisgV1c0fjDwPQ415LgtNvMBym3dAJHhmE+q9pfB+0qWbL2gzw5uUrKlxZLrG33ok+oVVolotiN
 /k2MM4zXOBmmD5twSCcCQPlbPPECa1KB7NvRByfAqYQVyQ0Y4nYeTVriMWhwL1q5DCXMh2NAhfu
 bycdrvvfta1cXRPrV8MvsPPv0xYs1b60Ikw==
X-Received: by 2002:a53:e037:0:b0:66d:7f5:37b1 with SMTP id
 956f58d0204a3-66d256954d9mr1678661d50.18.1787754849281; Wed, 26 Aug 2026
 07:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260821070958.6997-1-eichest@gmail.com>
 <CAOMZO5AY7nkpdyBckixiBTRLK6f1YTL=H14cLnoMLc+Qh5=MvA@mail.gmail.com>
 <ao1IFKQq7Lni4Kx4@eichest-laptop>
In-Reply-To: <ao1IFKQq7Lni4Kx4@eichest-laptop>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Aug 2026 11:33:56 -0300
X-Gm-Features: AcwNN1VgKx9Y8oBeIRecBOynfkv4FaXYrbfO2jqAcCV5l8ybWMtiY4gwaqeADBg
Message-ID: <CAOMZO5Df=ZoziqoYrAB-3rS+P-giWHjYrhKNBeQE6UKi2a+pBA@mail.gmail.com>
Subject: Re: [PATCH v1] toradex: {aquila, smarc,
 verdin}-imx95: add board_fix_fdt
To: Stefan Eichenberger <eichest@gmail.com>
Cc: francesco.dolcini@toradex.com, sbabic@nabladev.com, uboot-imx@nxp.com, 
 trini@konsulko.com, franz.schnyder@toradex.com, 
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com, 
 sjg@chromium.org, u-boot@lists.u-boot-project.org
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

Hi Stefan,

On Tue, Aug 25, 2026 at 4:45=E2=80=AFAM Stefan Eichenberger <eichest@gmail.=
com> wrote:

> We discussed this internally and decided to implement it in the same way
> as NXP does in board/nxp/imx95_frdm/imx95_frdm.c, but I'm not sure why
> it was necessary to put it in the board file. Perhaps because it can
> only be done in board_fix_fdt, which might be overwritten in the board
> file anyway? If we were to do this for the entire architecture, we would
> need to define a weak board_fix_fdt, which could be overwritten, if I
> understand correctly.

It seems we should handle this similarly to
arch/arm/mach-imx/imx8m/soc.c, where peripherals are disabled
according to the SoC fuses.

Since this is a property of the SoC rather than a particular board, I
would prefer to implement the fuse-based fixup once in the common
i.MX95 SoC code instead of adding the same board_fix_fdt()
implementation to every i.MX95 board.

This would also avoid requiring each new i.MX95 board to duplicate
this code in the future.

Could you please move this to the common i. MX95 SoC code? If there is
a technical reason we can't do that, we can revisit the per-board
approach.

Thanks,

Fabio Estevam
