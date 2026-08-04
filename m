Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731BFC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D77E5607BC;
	Tue,  4 Aug 2026 13:11:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2nP7NNKYrWTM; Tue,  4 Aug 2026 13:11:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D34F607B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785849078;
	bh=uV9zOeNHK13e12rGkPiDI/aL0+lCZtxjYQdbZWslYts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LkYdkMKd2OxGQXGJHyTPOxO/MbOfXdUqNHkggrcTIizxrPXfqDCD7z2gdEDio2dQI
	 YyB1Bk3PcsgIjNd/hl9QIEchm5pQIqjIs1PzyTjYNzThLxteOf9fOUlUDtntsSb7Bi
	 48CjNxonhjRLSRFSdBOJIGV+KMEYnecLW293LLmU6/VN0k/xPgwQxaX6OXhdNlrOT2
	 chDyDCmMqt0ebMGQhuh7DPOC9BZwnAOAluCe2JRbyHUJ+8jXL014ud3Hv7uBDJbO0S
	 UHeUy+bvolixo0L9BBswfs5DVFRdEjdtyeVW7QXVDF5/HoRe9LqJzdnRUAXhXqLmaQ
	 7Z1+D67BToW5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D34F607B3;
	Tue,  4 Aug 2026 13:11:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F4712AA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9B3B4053E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BSW4HCoMZ6d6 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:03:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BAC8940189
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAC8940189
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BAC8940189
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:35 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso5494897a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848614; cv=none;
 d=google.com; s=arc-20260327;
 b=ko7q3a/KLaWPonXdUphNAZ4H2WpFL5l1+k+Y8UHtUnlmboCrnvmKVz83TpXSeuukPn
 GQ8oE/2DWbUWLxKRLSyGSgH92eYauwhtP0x3fyn1BNiy/BGaSmL7NnmX8bAi1F/wiQON
 gGjR0zy0L2i8mkePKjKwpv9Q/blX9L/iex69xILg7qhCPKqNatO8srxdMXEPD29oLY45
 MKtCdCZHPeVZFtK5HeswVANBXiHz54VbG3Up3EFZgDex6P6WdMxUvJwg3ILYcplk5WOy
 WOa5K9lH9OO5IC4qXEFrBUfljW3qhMwgYstot0kxhXK8iKvqHHsGGxLBC9qZDYsElmin
 gYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uV9zOeNHK13e12rGkPiDI/aL0+lCZtxjYQdbZWslYts=;
 fh=hsQzq9IYCmZwK0E7cVW3p7RZJMnlUShWANxf+Zzt34k=;
 b=I73FNE2aB1D5+QltQNnGZ/2Z9yGXQCtu61eJNCOPFaI5KPCcTyYeuyEJdd5SDPvSqs
 O5LbeU8Z1ZMhFW03zUQwXTLxomDyVnh+NPp97l7Woa6kxfFFGczInrtztD33XbKl6syV
 1wQ133OZTHgnokMW4onjHA+cnnjx3aFWCEY1jQzuOT+bq+iHUA7jj7CPqCsj4vw32H6C
 CGxD1jhavx9TblrEG1d0tXLLKmgRwpBY+RHrGNkq+GzoDYR3r+1A6lYppS0ObuAO44i2
 rMWuD17TsfDsEkeBdlaLs/CTFHDOtlISub6TaLAGqHkD9KMcBWubsWdfcF3L3D6vvG6C
 G4NA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848614; x=1786453414;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uV9zOeNHK13e12rGkPiDI/aL0+lCZtxjYQdbZWslYts=;
 b=q43cYMukkVih9IuTgl+uCsZoBP3V2kYg1w2mIj8hxdK6cp/pEnUlYYqlNDNMHI8ak5
 wo9USAC9YulJ5IQy/l7MLetYzft4sKwTAJayP8dkMnyfPYYqwaXsSHsXrfDrvZbbHnRe
 z2/RopVU6vwYQUw0dwl9eiNIiSlMPPtvKNt87IErtOKgSUbNADwgPfWXi6g7ieQGdCE4
 jRMol3lHuA9WjhNRmLCpolvF8iugj8iHeuXp+X/7dJKlmG9jz/j3izfrhu2hd7Hwj0Bv
 DhM3pC+r8vcUUEaWC5Mq9LNT3mLi8c8xFexw/GSR08GM5dsDnAx5NBYQ3Qeju6nbH1Fb
 1d+Q==
X-Gm-Message-State: AOJu0YyyNiGn/U77zRReasUr63DiTcCXgCsD7h1nHhHXzCW6eAj3ZL+A
 bPtIlbV18egs0hl7H/p3PjVwBXVIeaR6S6k/JNVTMLHR0f5I++bJz6V9m/8ytEAP9IphNJQyGyd
 v5vB+zgscow83xpdMlyV7eNaEfb9VNKRRJWH5hPY8
X-Gm-Gg: AR+sD12NqjQCFaOwxSizVfNdw/nXsJDok9XDmA7WDBveK88nJoiQTszdpF7L93xrDCY
 pbyVL3AJ+fV1D+bkpGOv4e/r2DQ5P1iKelMouQkk1KDm7s8CqJuNKj0EUmTbV6d6hAGgRQnIEbY
 1+fusxFicw7TGZGvTEcQE7/hf/q/uspuFydMuporGFGTpboSSCOKCNLvVoiVlPptg7hkw8kCfuE
 7wIeUnFkAGRwRQ2YXIkOw20H3S5Bossdp24poPhT8SrM88GcJdVgRhzKdARJLJzw+R4ljtB4Yyg
 XkZwZWB1TMVvTOt5nDPxFgHpCiHqF0XAyUfJklngI3I=
X-Received: by 2002:a05:6402:44dc:b0:69f:4c65:86c2 with SMTP id
 4fb4d7f45d1cf-6a0a7c61187mr10429630a12.2.1785848613774; Tue, 04 Aug 2026
 06:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-7-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-7-acb97c172993@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:03:20 -0600
X-Gm-Features: AUfX_mx7L00lfA7GHJdHVhttv-x6virqoYQvzOJXxnosZe7s0Bvd2YBcZFoa4dc
Message-ID: <CAFLszTgMXoB-X7i=s9uhX8nFkCvEeMvzDZ9vxPFEBAnquhVm4w@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] binman: tests: Add test coverage for a FIT with
 embedded Linux+initrd and /chosen
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 04 Aug 2026 13:11:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848614; x=1786453414;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uV9zOeNHK13e12rGkPiDI/aL0+lCZtxjYQdbZWslYts=;
 b=KDo7gSXFSuDfNCptt7nCEtYsEO3GaqP5bCw2B9Dss7dhkbJEXrNiMTwXfj1NWQnpgK
 Yaep+EY1QB8AVj5YdG2Ebhvn58SYI5Gbl8sSjy9Lc664NSzeFCCWshSSbnIIw7x5T4Io
 x5k00KOFX395CsBI/LsD4h/mrGOANmX4uayAk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=KDo7gSXF
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> binman: tests: Add test coverage for a FIT with embedded Linux+initrd and /chosen
>
> Add a test for a FIT image with a fake Linux kernel and initrd, and a
> valid device tree into which a /chosen node is added (containing a
> bootargs property, as is relevant for Falcon mode boot).
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> tools/binman/ftest.py                          | 107 +++++++++++++++++++++++++
>  tools/binman/test/fit/fit_chosen.dts           |  62 ++++++++++++++
>  tools/binman/test/fit/fit_chosen_no_initrd.dts |  60 ++++++++++++++
>  tools/binman/test/fit/fit_chosen_no_load.dts   |  57 +++++++++++++
>  4 files changed, 286 insertions(+)

> +    def testFitChosen(self):
> +        """Test patching /chosen (bootargs + initrd) into generated FIT FDTs"""

The alternate-DTs (model1/model2) have no /chosen node, so all three
tests only exercise the add_subnode() branch in _patch_fdt_chosen().
Please add a case where the input FDT already carries a /chosen (with
e.g. a pre-existing bootargs) to cover the path_offset() branch and
confirm the overwrite behaviour that the docs promise.

> +    def testFitChosenNoInitrd(self):
> +        """Test a Falcon-mode FIT where the optional initramfs is not supplied"""

There is no coverage for a config that sets only fit,bootargs or only
fit,initrd (both DTS files set both). Since _patch_fdt_chosen() has
independent None-branches for each, a small case exercising each on
its own would be worth adding.

Regards,
Simon
