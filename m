Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0656ACCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A47F835FE;
	Tue,  4 Nov 2025 16:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Nefd9j7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC15838CE; Tue,  4 Nov 2025 16:12:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2D678004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762269170; x=1762873970; i=xypron.glpk@gmx.de;
 bh=GOUW336PJ4OqaH4Arji/ew0OUMZgQ6UDJYhR4lLNqFE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Nefd9j7VvNXmPzPtQ/aoeePt9iH1rEHBLictV/7bJaN6ExT5dMEldpCdTCRa+cv1
 ysYzm8ZLrQQxinZjl83SfdUKbI1ve/289EPOFhYKnmG7EIe+osszHAL5VWi5TAZ+f
 kI++AeBiZSZs3Xsw2EolPL3kxPDTn0VZ/2ST0Eesmt7CzrhcBAsNaMxGc3SWledPX
 B0M+hqaI64m6Prpu7hmwVr3u6MBuxoEqvcHehjZBAr5x9KMAq3n9KdKhV6kLVV0zN
 IC6uYZUMosaFJZer/lwRKRbINg9fBw+KC5nftOlapN9v/xpBovq+xVnFuHAhZIR5v
 W3iRZ4BBBCScD9wtBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.183.149] ([93.94.208.154]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9yS-1vXPrH30Hy-00MDlW; Tue, 04
 Nov 2025 16:12:50 +0100
Message-ID: <69b2a2aa-419b-4376-b22e-d96b36d53456@gmx.de>
Date: Tue, 4 Nov 2025 16:12:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: bootstd: Remove extension support from TODO list
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.denx.de
References: <20251104100639.1031962-1-kory.maincent@bootlin.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251104100639.1031962-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SJsAFL8YtASCLoqPoUVQN72H4yimyjX6fgDn7/vs6vFFwbigcWM
 59KlC0cfSF89PTCiZqtddxlRFaRfvMJXyksCtitER3ag00tkPvVw8sWzZU4/UMktALmLvfv
 AwjCchy2sN/YJeTzCm1C8A6szeZaAOHI6s1weWOCByEl5T0MWm4/cGLuv/Il/WqxP7QgdS5
 bWiAR4xZm+gAGWl/obrFQ==
UI-OutboundReport: notjunk:1;M01:P0:KqTHNtjW8fc=;itKXRW/Nbd1j8wx2THDkX5+8P47
 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
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

On 11/4/25 11:06, Kory Maincent wrote:
> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
>=20
> Now that extension support has been added to extlinux and efi bootmeths
> we can remove this line from the TODO list.

Related commit:
e9dc6c12958f ("boot: bootmeth_efi: Add extension board devicetree=20
overlay support")

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>=20
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>   doc/develop/bootstd/overview.rst | 1 -
>   1 file changed, 1 deletion(-)
>=20
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/over=
view.rst
> index 0a237359575..6cf3b48efca 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -836,7 +836,6 @@ To do
>  =20
>   Some things that need to be done to completely replace the distro-boot=
 scripts:
>  =20
> -- implement extensions (devicetree overlays with add-on boards)
>   - implement legacy (boot image v2) android boot flow
>  =20
>   Other ideas:

