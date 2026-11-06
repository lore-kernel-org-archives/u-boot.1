Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C0606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qjCMkn05;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rTMXJ2QK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24E06606ED;
	Fri,  6 Nov 2026 07:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TCoghxNVj9CI; Fri,  6 Nov 2026 07:53:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CD6BE60640
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793951597;
	b=ecUqaQ93F3/QCTa5Fui/7VQKKDsOw0QA5vdIAI6LcQZRZkaIuoNnfsVVSGuA6Drgwil/
	 iv67wXy421vy363Nmm44LHB8B55MXT1KDg63jR/eZaBH395Xo4cp7EhKTSh0bBP5aPhEi
	 RxBFpfu6+iEXTZrjgwqrI36uEwrclxPAFVSukIMkJ2UJWMe6u8TXI1cxG0IOe3sUNIrVx
	 sqEFVFptMmeG0p5YTYCPoDsXKn0tgt2CYz4A0WT0Wgmpqwh5H3AB+8GTHI629Q6D3ayD6
	 IOb+TEo0pkmkv7lqLtBaizRfKClkFWTpeTuFPcoxThYQvjhITif9QdkzyA7HWIVbPLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793951597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UFVbnnQE57WMwq0niIPoZ3wjb81VWsREvc+XsDBvtV8=;
	b=d5HkXEvEx6jxMEoPoa4UlhAdO4NpwsaUAbT5scoSw8XnrtzyHWSah94cPHsId+ftvHH/
	 WbQZ0LqC0yI92lc4LxIh5VYt0En/hOjkk3SCPHfy3mIefNoobj0m/uO7ig3SXfFPoX0Mj
	 1P5hP4tI+elZnF9TMBxcRNqFDFC0jVjeqFax3tNec5h/0dLpKryR5L9jSO6HM26lhVSSp
	 NlcWd2xbIFx3sGJ0RQYfrqhY3kJYmFasqurF7TPRWgGlSNWF/7jAUgkgxHb82fjI+w0Rr
	 6Z57ZsxcMSS6/TYISMotiSRvMr7IVY8apmoSF42gWwLd1e38N/ZUGWBHD8cV3gdMC8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793951597;
	bh=UFVbnnQE57WMwq0niIPoZ3wjb81VWsREvc+XsDBvtV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qjCMkn05doDlTM4seMP6iESrY5oMwOmQlO9L85SiwTt/tz+9okigB29QQveGg9h9n
	 vghYf6K15cLfP8vZmAVIHrJeZvBciENrCDF/Bs0zr9SeIYB7vA8uQM+I9WlAOZDlGx
	 fafSz86xmbqMd7CGMX9e2nNTijK/96kWLua7EnyAtwawzAQetkCPjVOGlZaE+ENeAF
	 LxEt+dVUOdTPXCps53IM1UZxxUqntlxdw2WbDL8VMGJNnncXA1T41wBt5GKDUaErgO
	 LNE8PL0dwCWKp7PkrRN9J74lpuo2PEcS0ne969vCvzT7Olz1ouDnBB599MwpgN6tEM
	 7t7MvbcliUbEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD6BE60640;
	Fri,  6 Nov 2026 07:53:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22E202E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FF2C40802
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:53:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1XZF2msR56mv for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:53:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A651E407A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=rTMXJ2QK
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A651E407A4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:53:14 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c4697404c2bso37496366b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 23:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793951592; x=1794556392;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UFVbnnQE57WMwq0niIPoZ3wjb81VWsREvc+XsDBvtV8=;
 b=rTMXJ2QKbN6hCj7/2k/aeFRugpxpjLsoloaCnJ0GfUm0wdCjWoE5Gwx9WeRhAxzLAI
 SfLtppyKMqGRrA0hwjPwrVcym+Nf+Os9Be0VU8VPecNvLbeZB4yUtTbCm0fuDG2Bq9Mi
 4V+OESRO7z6mX3RWpeaJ9vGznD5E9oEv4RYVEiEbj5dwHozfXRuowMdBwGz+aSfd28CP
 POHRScFIeB1sCQ4lNNlz2MFlzjSGrQyNsbQ3AnxREmkjhbRZsibXhQHfuttrxivChWLl
 J9uoKzsMCnPl6wwtwjMMscdW4S/vUs1VVH1xLL9fgDG6scYmAUSVdSpymnWP8kkSaM/6
 U0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793951592; x=1794556392;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UFVbnnQE57WMwq0niIPoZ3wjb81VWsREvc+XsDBvtV8=;
 b=XFqORM5dmNscUNNOn9FiDqXUpheQGaq4WCe01J8+wXPJdbDUs06HFb8bSSrDBfcJgi
 E9LShm7rAjolEXHIpJvfhtAIjvo7CwAqJZ+SnjQ17NpdKE/qqyA/t5tuMIyrljlLz32X
 vG99oWnaIRED11odEg56Hd0o0MQRrAxABoBzXS6QifVWM2VinU3Aqt18zR2X3ubMkHWc
 KHtju9vy6CR9xarv0T3CdxiNcLtI8BllwobwEjwjpmUi8WxgDw1hyOse4YrmRNC+6r52
 uJNTdFcVIVaBCb03BfzmukXOfauwsEfWn3ASLc4SfGKBJqCW1XMtYjweS8dweHtkxSIp
 Z10Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBylOm4SC4TqWgIKwXro7R6NgrVWAknodfPxxgX3LOkWW/NMMg5cBb6V4mDJiFVeSaPssD84w2I=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/xi9Qn/pWb/h5Z/Mc+NQNQE+tLe9YnAFmZd7Jgqs0OJ10O4JHa
 xgGZV2NqoSlK5V2ZETsrYAQqnJQLPF0+ZujGdUcKAtWXhFkk/SZ9XyYRZR3+b7u20dh+Y17P5GN
 C28w/Nqcp5eatuz3gsTR22Ny9YweF+yk=
X-Gm-Gg: AYBFou2HhuXFSK3lg6fVqx4pos4uA00hf4d8qPRrm4M5AW/JpP4XTV6TZ1eXExJRTON
 mC54IBRNWDj7xM/wiPGRWQEQj+y/ZVpzP2FcTR4APKs8LMQimQBx8IcSEaj0RKaiBZ5kIbussGb
 cO2WcBuS8LAVM9iVvhRfYOazHqt/fYV7vNMo3yjUBfRXE5ftFMVoO1XIVklzuq8LVgwo1KzmUxS
 sL5ox0i2ZaiNERy1akgvnI0ObMS5P89JSKFRAjotIK7LC6uYbcZcy/pk/mG+QC9BRu+sXZ4Pbc5
 tHP7zx58QVFxloLegI4+S+gV1Uwpi8PXjEXTZGoUXPcZzfLVuyLGAVDVTwVialqph3PshA/qsnw
 lgUurvDAGnpNLFq1o6cACaLV2G8ElUKkdNwUq8Q==
X-Received: by 2002:a17:907:1b0a:b0:c49:cf3a:a324 with SMTP id
 a640c23a62f3a-c4d34b9dccbmr145038866b.22.1793951591899; Thu, 05 Nov 2026
 23:53:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
 <20261105144209.GL1164024@bill-the-cat>
 <CAC928HbGeoLQuHjiDN+qBU7A=wLa=EgM7xQMppv9LvFh5kV_xg@mail.gmail.com>
 <e6f06550-772f-426f-8b43-da13b58b0202@mailbox.org>
In-Reply-To: <e6f06550-772f-426f-8b43-da13b58b0202@mailbox.org>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 6 Nov 2026 08:53:00 +0100
X-Gm-Features: AclHuK_GmCi71xkR5dmTqFY4z7KweQaD5L57jkSPrP0gTmalpPwu1vUPz4iZejE
Message-ID: <CAC928HbrMkzALtAW1uGvP=uyCDWdAaZYw+ajC8CNHxOk8gwdoA@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Il giorno gio 5 nov 2026 alle ore 20:10 Marek Vasut ha scritto:
>
> On 11/5/26 7:51 PM, Massimo Pegorer wrote:
> > Hi,
> >
> > Il giorno gio 5 nov 2026 alle ore 15:42 Tom Rini <trini@konsulko.com>
> > ha scritto:
> >>
> >> On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
> >>> On 11/4/26 3:29 PM, Tom Rini wrote:
> >>>> On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
> >>>>
> >>>>> Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
> >>>>> configurable boolean, and update all defconfigs and Kconfigs which
> >>>>> previously only selected REMOTEPROC driver to also select REMOTEPROC
> >>>>> itself.
> >>>>>
> >>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>>>> ---
> >>>>> Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> >>>>> Cc: MD Danish Anwar <danishanwar@ti.com>
> >>>>> Cc: Tom Rini <trini@konsulko.com>
> >>>>> Cc: u-boot@lists.u-boot-project.org
> >>>>
> >>>> Unfortunately this misses some handful of at least TI K3 platforms. I
> >>>> think using qconfig.py to confirm which configs have REMOTEPROC set
> >>>> before / after, and that they match would make sorting that part of the
> >>>> problem out easier. Do you have time to do that, or should I pick it up
> >>>> and do a v2? Thanks.
> >>> I can respin this, but do you know which platforms got missed ?
> >>
> >> I lost the list, sorry. It was a number of the r5 builds. Perhaps some
> >> fragment got missed? But qconfig.py -f REMOTEPROC, with a db built with
> >> and without the patch will quickly show which oens it is.
> >
> > This is the result of comparing the two qoconfig.py outputs:
>
> u-boot$ git log --oneline HEAD~4..
> 1e29311663e (HEAD -> master) Revert "remoteproc: Hide REMOTEPROC options
> in REMOTEPROC conditional"
> 97162e533ca remoteproc: Hide REMOTEPROC options in REMOTEPROC conditional
> df3b8e16e6d remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC
> d1d45c926a5 (origin/main) Merge branch 'main' of
> https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv
>
> u-boot$ ./tools/qconfig.py -f REMOTEPROC
> 126 matches
> am6254atl_evm_a53 am6254atl_evm_r5 am62_pocketbeagle2_a53
> am62_pocketbeagle2_r5 am62ax_evm_a53 am62ax_evm_a53_ethboot
> am62ax_evm_r5 am62ax_evm_r5_ethboot am62dx_evm_a53 am62dx_evm_r5
> am62px_evm_a53 am62px_evm_a53_ethboot am62px_evm_r5
> am62px_evm_r5_ethboot am62x_beagleplay_a53 am62x_beagleplay_r5
> am62x_evm_a53 am62x_evm_a53_ethboot am62x_evm_r5 am62x_evm_r5_ethboot
> am62x_lpsk_a53 am62x_lpsk_r5 am64x_evm_a53 am64x_evm_r5 am65x_evm_a53
> am65x_evm_r5 am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc
> am67a_beagley_ai_a53 am67a_beagley_ai_r5 am68_sk_a72 am68_sk_a72_ethboot
> am68_sk_r5 am68_sk_r5_ethboot am69_sk_a72 am69_sk_a72_ethboot am69_sk_r5
> am69_sk_r5_ethboot aquila-am69_a72 aquila-am69_r5 aquila-imx95
> imx8mm_evk imx8mm_evk_fspi imx8mn_ddr4_evk imx8mn_evk imx8mp_evk
> imx8mq_evk imx93_11x11_evk imx93_9x9_qsb imx93_9x9_qsb_inline_ecc
> imx93_frdm imx93w_evk imx93w_evk_inline_ecc imx95_15x15_evk
> imx95_15x15_frdm imx95_19x19_evk imx95_19x19_frdm_pro imx95_a0_19x19_evk
> imx95_navq iot2050 j7200_evm_r5 j721e_beagleboneai64_a72
> j721e_beagleboneai64_r5 j721e_evm_a72 j721e_evm_r5 j721e_sk_a72
> j721e_sk_r5 j721s2_evm_a72 j721s2_evm_r5 j722s_evm_a53
> j722s_evm_a53_ethboot j722s_evm_r5 j722s_evm_r5_ethboot j742s2_evm_a72
> j742s2_evm_r5 j784s4_evm_a72 j784s4_evm_r5 k2g_evm k2g_hs_evm
> phycore_am62ax_a53 phycore_am62ax_r5 phycore_am62ax_r5_ethboot
> phycore_am62ax_r5_usbdfu phycore_am62x_a53 phycore_am62x_r5
> phycore_am62x_r5_ethboot phycore_am62x_r5_usbdfu phycore_am64x_a53
> phycore_am64x_r5 phycore_am68x_a72 phycore_am68x_r5 r8a779g0_whitehawk
> r8a779g3_sparrowhawk r8a78000_ironhide_cm33 sandbox64 sandbox64_lwip
> sandbox sandbox_flattree sandbox_nocmdline sandbox_noinst sandbox_spl
> sandbox_vpl sc598-som-ezkit-spl sc598-som-ezlite-spl
> stm32mp15-icore-stm32mp1-ctouch2 stm32mp15-icore-stm32mp1-edimm2.2
> stm32mp15-microgea-stm32mp1-microdev2-of7
> stm32mp15-microgea-stm32mp1-microdev2 stm32mp15-odyssey stm32mp15_basic
> stm32mp15 stm32mp15_dhcom_basic stm32mp15_dhcom_drc02_basic
> stm32mp15_dhcom_pdk2_basic stm32mp15_dhcom_picoitx_basic
> stm32mp15_dhcor_avenger96_basic stm32mp15_dhcor_basic
> stm32mp15_dhcor_drc_compact_basic stm32mp15_dhcor_testbench_basic
> stm32mp15_trusted toradex-smarc-imx95 verdin-am62_a53 verdin-am62_r5
> verdin-am62p_a53 verdin-am62p_r5 verdin-imx95
>
> u-boot$ git reset --hard HEAD~1
> HEAD is now at 97162e533ca remoteproc: Hide REMOTEPROC options in
> REMOTEPROC conditional
>
> u-boot$ ./tools/qconfig.py -f REMOTEPROC
> 126 matches
> am6254atl_evm_a53 am6254atl_evm_r5 am62_pocketbeagle2_a53
> am62_pocketbeagle2_r5 am62ax_evm_a53 am62ax_evm_a53_ethboot
> am62ax_evm_r5 am62ax_evm_r5_ethboot am62dx_evm_a53 am62dx_evm_r5
> am62px_evm_a53 am62px_evm_a53_ethboot am62px_evm_r5
> am62px_evm_r5_ethboot am62x_beagleplay_a53 am62x_beagleplay_r5
> am62x_evm_a53 am62x_evm_a53_ethboot am62x_evm_r5 am62x_evm_r5_ethboot
> am62x_lpsk_a53 am62x_lpsk_r5 am64x_evm_a53 am64x_evm_r5 am65x_evm_a53
> am65x_evm_r5 am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc
> am67a_beagley_ai_a53 am67a_beagley_ai_r5 am68_sk_a72 am68_sk_a72_ethboot
> am68_sk_r5 am68_sk_r5_ethboot am69_sk_a72 am69_sk_a72_ethboot am69_sk_r5
> am69_sk_r5_ethboot aquila-am69_a72 aquila-am69_r5 aquila-imx95
> imx8mm_evk imx8mm_evk_fspi imx8mn_ddr4_evk imx8mn_evk imx8mp_evk
> imx8mq_evk imx93_11x11_evk imx93_9x9_qsb imx93_9x9_qsb_inline_ecc
> imx93_frdm imx93w_evk imx93w_evk_inline_ecc imx95_15x15_evk
> imx95_15x15_frdm imx95_19x19_evk imx95_19x19_frdm_pro imx95_a0_19x19_evk
> imx95_navq iot2050 j7200_evm_r5 j721e_beagleboneai64_a72
> j721e_beagleboneai64_r5 j721e_evm_a72 j721e_evm_r5 j721e_sk_a72
> j721e_sk_r5 j721s2_evm_a72 j721s2_evm_r5 j722s_evm_a53
> j722s_evm_a53_ethboot j722s_evm_r5 j722s_evm_r5_ethboot j742s2_evm_a72
> j742s2_evm_r5 j784s4_evm_a72 j784s4_evm_r5 k2g_evm k2g_hs_evm
> phycore_am62ax_a53 phycore_am62ax_r5 phycore_am62ax_r5_ethboot
> phycore_am62ax_r5_usbdfu phycore_am62x_a53 phycore_am62x_r5
> phycore_am62x_r5_ethboot phycore_am62x_r5_usbdfu phycore_am64x_a53
> phycore_am64x_r5 phycore_am68x_a72 phycore_am68x_r5 r8a779g0_whitehawk
> r8a779g3_sparrowhawk r8a78000_ironhide_cm33 sandbox64 sandbox64_lwip
> sandbox sandbox_flattree sandbox_nocmdline sandbox_noinst sandbox_spl
> sandbox_vpl sc598-som-ezkit-spl sc598-som-ezlite-spl
> stm32mp15-icore-stm32mp1-ctouch2 stm32mp15-icore-stm32mp1-edimm2.2
> stm32mp15-microgea-stm32mp1-microdev2-of7
> stm32mp15-microgea-stm32mp1-microdev2 stm32mp15-odyssey stm32mp15_basic
> stm32mp15 stm32mp15_dhcom_basic stm32mp15_dhcom_drc02_basic
> stm32mp15_dhcom_pdk2_basic stm32mp15_dhcom_picoitx_basic
> stm32mp15_dhcor_avenger96_basic stm32mp15_dhcor_basic
> stm32mp15_dhcor_drc_compact_basic stm32mp15_dhcor_testbench_basic
> stm32mp15_trusted toradex-smarc-imx95 verdin-am62_a53 verdin-am62_r5
> verdin-am62p_a53 verdin-am62p_r5 verdin-imx95

It seems I've something broken in my setup. I will dig. Just to help me to
address my digging: did you rebuild the qconfig db after the second reset?
Thanks for your feedback.

>
> > (I had to drop also the select REMOTEPROC for the new REMOTEPROC_TI_K3_HSM_M4F
> > which landed into main but not yet included in the patch)
> >
> > Could adding an "imply REMOTEPROC" in arch/arm/mach-k3/Kconfig, where other
> > REMOTEPROC sub-options are implied, help to simplify? Avoid need to add it
> > to defconfigs.
> No, imply keyword is not recommended.

I agree, but since K3_REMOTEPROC_R5F has default y if SOC_K3_AM654, and
K3_REMOTEPROC_R5F imply REMOTEPROC_TI_K3_R5F, I do not see how things can work
now that REMOTEPROC_TI_K3_R5F has dropped the select REMOTEPROC for a
configuration like the am65x_evm_a53 that has SOC_K3_AM654 but does not have
REMOTEPROC. But, again, it can be to something broken in my setup.

Thanks. Regards,
Massimo
