Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93254C79FA1
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 16:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D67C605D7;
	Mon,  7 Sep 2026 16:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id flj_ZiU_NoGW; Mon,  7 Sep 2026 16:13:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3634C605F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788797627;
	b=MbZTomBsZPJet+wWYMUcNRwDCrzMCsI9dd0oA+ug0eDSae5nBNrThbsBhZG0Tcjjrfyx
	 SuZ29UxoHXHXZt5kq7EcYS62RRcayOO/5WFx0UTpfxexMKn4ZVzR64F6PYfrRoK6rUQLT
	 EE9EmxOQunQhFm3I4DYZMw/NfqlrOSWoROOGF1KzZBH9R/pAFU1RulzdCl/SR9alkneNb
	 OLNNBMoHG6peUk1yHTlfczCDtXI3mNQKPZREdEmyfk1ufCGi8AAhxL3scz5imoDusr+kN
	 D73+pcMuAy+oE7aXqA9cOaUp0unc+A19+aeNhTzsT2PoOeYB0D1p4dlqqI4orIyKBgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788797627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ekP/WEo/7EwBFfwqvSFEI2N4hVIzK/8398yqK5lO3AE=;
	b=lL4vSo052b3pteCpg+pwdwAdYyI3B2p7VYnoDM1akfq0l9LGTEc4qQsnCTRR0rhpO0xJ
	 yS8fU8WKQZMpUq8anqUIYVzi4WEhZevSMkvSayYxYvRiAL17PHdbgE1+qmOQ4e7I085Ym
	 PSBj8uK8AJbF9DIK/iCgOIDcJe3ZmrIJ5d5q0JX0lRLXet9sIJE/Naoqx3eX9c6yV/2Ro
	 BC+XHHPK1nsExb26MTPRT6XCcCd6l4nPBQiEBSONH/h5iH/9YKlt0Xz+hLpSBE14DKgxV
	 Azgg+k1zv1Eet0CEOTWd3gRlJeRHz13Q4TY+BBNmMqY1g0K/m/EZIG+0sQrZiOkGMlg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788797627;
	bh=ekP/WEo/7EwBFfwqvSFEI2N4hVIzK/8398yqK5lO3AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fSPwb5pZQk+AcKFBgobVy6RVsaPeQPrKyrHKe6rjrc7lpcYlCo1+FuUsTR2qPXJV8
	 DpDrWCB/AkkwFGuf3YlKYXFyN5sUtev5g+g1Q9zDHjpGep+2jcF1DIrqarn2kI9llE
	 FnBO3JtkvsQ67JrCE0hsjkkxNemZoPUFFITN2xMFVE5p/6N6VHa6Cgc9eyMwUHNosk
	 1pk0CJYk/p7BltugL4c5Y8A7AjEh6wCDlj9Wz626DqJu9SikNapzefFJFOl0hXWLiM
	 llU/+8Io8KCOxeKctPyLOIJVPVtXK12YJhjUuGuAfDJhUrOq+aRysz5Wk/5jTVMBcY
	 58uPG6ifjFoWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3634C605F5;
	Mon,  7 Sep 2026 16:13:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C24CF49D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 16:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7FEB80A80
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 16:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TDMpdTgqxz-4 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 16:13:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 815A980A58
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788797624;
 b=lzmL0RclQYGhjn8hz1K2R3h5XPf5tYnWL6ar12qX0WZ4MLYlfwO4Yxk9CCAIQAn4tYDx
 yY/M4WRnlRXNLYmOffZtqHDWaPhFk9jypQpsL9U2M0y3rPnE/KkZvtjfLdxhmhthVxIlb
 OHS5DEvj+z4RqSiP/CSy1ha2CYfXXIzunbmCW0usWYX7LyZZQM2mktQZb5uP0Xwq4OORN
 oxbU38D9gVCA2g6J6fbs4jxUkM4vsnJMX7XdwZYxKfz/CcW2MdI5HwVuPzoZUayfq4Jmx
 BQ7LBPbEP/64Z5ViaYXL2peb8dJng1x01cssKWka5n2FqHh6fHYfvESvE6MDWUd8Stw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788797624;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=ekP/WEo/7EwBFfwqvSFEI2N4hVIzK/8398yqK5lO3AE=;
 b=FAqFc61WrvZLSOfRo2/hLcuJHGfDTKv67B+FCV01sEzCoFCZ62tkAwFU/yjqk0djfEns
 TasaDjdgtvMYLOGl/i8vXcqidTa5oSfjzAMt3gxIhYVsB+yaQaY3wnYbgeUGlyBFryCWA
 dpdPn69CHKh3K1tNOW/7rshSWT5SNtSYFVB4QQw6cyWGI3DzSgnK8e2pKh2X2y+ZJwZwr
 EZ/bzkaMZgpwLsnwaP9qGI3hrAfPgzy0sK9qq71Q1UDdUFJfoMYpWSO1S0fprFflcBOcS
 z5KY324RM3/DQ0jvx8FTa0Lwh0uW5jSYTB9HV/t3Pa1jN+2YIsjzq2DVetJapoWf7ng==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eTSreyfM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eTSreyfM
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 815A980A58
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 16:13:43 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 006d021491bc7-6b148096e48so810820eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788797623; x=1789402423;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ekP/WEo/7EwBFfwqvSFEI2N4hVIzK/8398yqK5lO3AE=;
 b=eTSreyfMeWWAXToc3T/5+Grfo4p/BF/bBGUlfgGpCEfiUhf+j5ZTHUDURYVIGN0WhE
 YIkv/Z0OyzRh+HTj7XJB6dIJQfR0msA5ky29BHBkzRVh58W3FnyvqmEzgjRe6tBxO/cv
 oOAnA56J/uyBqfQqgXFsKp3I98peIcN8ce14A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788797623; x=1789402423;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ekP/WEo/7EwBFfwqvSFEI2N4hVIzK/8398yqK5lO3AE=;
 b=KnNJ98Rd949xWMe33lB1XlvWnc27RfmJlGlFKup8at5eg1g1aqNRKS+IDlCXtiKA3O
 2jAIMfIKWcawXqZeUzi0z6nv0V9TdGpjhoZdt4FQBHM+7IZ/1fikSex+sPvR4cUsyxtK
 Rryg2ZO/Xkmr8suznKZNuws5cLMfabp8fq5Qq3ykoCCeH6EU45l0WbtbBSFpJKXE+L6z
 Jfc+/DPHmhgndkmR7y2zj5wMPi5y/PjcpxCkDFJj/3TLc+O8Y0YM2Z6zgGJ3LIZ2plFS
 N2nUL7Vsx7+s2hczEyonDVUCqTg+dtgdIUATkexq6Ih4UscmYWg/YikyLsG51agnPLlW
 /qCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiWUAio+mDjN0dIkLSlaQ2q5gKSnf1U9mk4ZenrshI74BjPz7Gtbem8Pbj2h9vwwuZ4XcL5O0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nw+1daYsUMJz9V3RT8Hrq/D/luiOs+OuchS6jvcVUsNm3uE3bV
 vmKJ8hpiVy4Dgkn1ie07MoZsVD3kA37bHQzMBjFbbFfa0NvNOZPSh8mReqz59AGtbbI=
X-Gm-Gg: AYBFou2kLt52qde/tUXeFo0m0rK58zbE8klC8lEKI9kNaByFSd0cPtXn3l4vMRw+kQc
 +GTf8rnrSClC2yBalE9aNgzPjgZMcb6ituN8xlDH+iKqtxpqVG7C9xHMh0XEkDq3HAD/8ZdrSIX
 rEzfYUp6+bZbT1SJ3aVMmh0fz+UrB8SPkrRTO0PGxtcXxwoG7ypu99LTNWh+XqmqhScMdQduczl
 9fjUgnPixIrHJbn0y4kkGjx+/YGfBrPQ7kKGXZQfpw1b2aWgaCXRu7qW38Ug0ZpooRvzYPVofc3
 WWkUmLqbNy6877FkJYXgireF5aKC91bqc/7aP+BjDG9xyuF4OiiKdYulpmgFH3AKbZzpQGvG2XH
 GeDtT9Hu/iIkCQO2TvDCrsFX9cy+YnuiuW5MOj9jjE1qIDOfuvkUofuxqm2jmyX6qKD3C+2ZLiT
 4RmuykYB/z/OcFxWETYJWQnMopvh3LXAK+wVqFUrhJHq9EIjSHzeAknfZASC44RsZO5u8r4taqL
 eg/DapxrkPfveEvzqPYT9WUxVci0vXOTSWB6j72NDty8p+5iH++SytbeHIbp53q2NWavJk2wuvM
 emL3hoN1nw==
X-Received: by 2002:a05:6820:4c09:b0:6b3:5537:8dbe with SMTP id
 006d021491bc7-6b6fade3f17mr13438439eaf.11.1788797622762; 
 Mon, 07 Sep 2026 09:13:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7fc68d5ae2bsm5950247a34.3.2026.09.07.09.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:13:41 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:13:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, neil.armstrong@linaro.org,
 bhupesh.linux@gmail.com, xypron.glpk@gmx.de,
 marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 tuyen.dang.xa@renesas.com, yoshihiro.shimoda.uh@renesas.com,
 padmarao.begari@amd.com, macpaul.lin@mediatek.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com, dlechner@baylibre.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 0/5] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
Message-ID: <20260907161339.GX1764417@bill-the-cat>
References: <20260807140119.324858-1-jorge.ramirez@oss.qualcomm.com>
 <aoMc8FDcE0bYGZch@trex> <aohaajBy5e6A4gFL@trex>
 <ao_89VbNNE1QTX6a@trex> <ap5i9edBJ7sNVmax@trex>
 <61fd743d-c722-42b8-a754-175715a4bcbe@ti.com>
 <ap54m53aTMXhIso3@trux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vj+U6XTW6c4hLAcI"
Content-Disposition: inline
In-Reply-To: <ap54m53aTMXhIso3@trux>
X-Clacks-Overhead: GNU Terry Pratchett
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


--vj+U6XTW6c4hLAcI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 10:40:59AM +0200, Jorge Ramirez wrote:
> On 07/09/26 12:47:39, Neha Malcom Francis wrote:
> > Hi Jorge
> >
> > On 07/09/26 12:38, Jorge Ramirez wrote:
> > > On 27/08/26 11:01:41, Jorge Ramirez wrote:
> > >> On 21/08/26 16:02:18, Jorge Ramirez wrote:
> > >>> On 17/08/26 16:38:40, Jorge Ramirez wrote:
> > >>>> On 07/08/26 16:01:05, Jorge Ramirez-Ortiz wrote:
> > >>>>> OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partition, =
but
> > >>>>> U-Boot's OP-TEE RPMB supplicant only speaks the legacy single-com=
mand
> > >>>>> interface, which is bound to eMMC. SoCs that are UFS-only and hav=
e no
> > >>>>> eMMC (for example the Qualcomm SA8775P) therefore cannot back OP-=
TEE
> > >>>>> secure storage from U-Boot today. This series adds that support.
> > >>>>>
> > >>>>> It introduces the transport-agnostic OP-TEE RPMB "subsystem" inte=
rface
> > >>>>> (PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world enume=
rates
> > >>>>> the RPMB device and reports its kind, size and CID, then carries =
the
> > >>>>> signed frames. The legacy eMMC supplicant is preserved unchanged,=
 only
> > >>>>> renamed to rpmb_emmc.c, with the new UFS backend added as a separ=
ate
> > >>>>> rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPORT_U=
FS_RPMB
> > >>>>> depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant hand=
les a
> > >>>>> single RPMB transport. The subsystem interface is UFS-only for no=
w; eMMC
> > >>>>> can be migrated onto it later as the legacy path is retired.
> > >>>>>
> > >>>>> On top of that it adds a UFS RPMB transport that moves JEDEC RPMB=
 frames
> > >>>>> to and from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL =
IN/OUT.
> > >>>>> The per-region 16-byte CID is derived by BLAKE2b-hashing the exact
> > >>>>> device-id string the Linux kernel builds (ufshcd_create_device_id=
()
> > >>>>> plus a "-R<region>" suffix), so OP-TEE derives an RPMB key that m=
atches
> > >>>>> the one Linux would use.
> > >>>>>
> > >>>>> The first patch is a standalone UFS descriptor fix the RPMB path =
depends
> > >>>>> on (UTF-16BE string decoding); the transport patches also include=
 a
> > >>>>> power-on UNIT ATTENTION retry and a DMA-alignment bounce for the =
RPMB
> > >>>>> WLUN.
> > >>>>>
> > >>>>> Note: reading UFS descriptors reliably also requires the descript=
or
> > >>>>> data-segment cache-invalidation fix, which has already been poste=
d and
> > >>>>> merged separately, so this series is based on top of it.
> > >>>>>
> > >>>>> Tested on the Qualcomm IQ-9075-EVK (SA8775P): OP-TEE with CFG_RPM=
B_FS
> > >>>>> programs the RPMB key through U-Boot and reads/writes secure-stor=
age
> > >>>>> objects, with the derived CID matching the Linux UFS device_id AB=
I.
> > >>>>>
> > >>>>> Dependencies:
> > >>>>> Linux kernel:
> > >>>>>  https://lore.kernel.org/linux-scsi/20260716083728.2226422-1-jorg=
e.ramirez@oss.qualcomm.com/
> > >>>>> Op-tee
> > >>>>>  https://github.com/OP-TEE/optee_os/pull/7881
> > >>>>>
> > >>>>> v4:
> > >>>>>  - ufs: decode string descriptors: dropped the in-place
> > >>>>>    ufshcd_str_desc_to_cpu() byte-swap helper; instead added an en=
dian
> > >>>>>    argument to utf16_to_utf8() (UTF16_HOST/LITTLE/BIG_ENDIAN) and=
 decode
> > >>>>>    with UTF16_BIG_ENDIAN, mirroring the kernel's utf16s_to_utf8s(=
).
> > >>>>>    Existing EFI callers pass UTF16_HOST_ENDIAN.
> > >>>>>  - ufs: RPMB transport: build the SECURITY PROTOCOL CDB with
> > >>>>>    put_unaligned_be16()/put_unaligned_be32(); drop the
> > >>>>>    rpmb_frame_request() helper in favour of get_unaligned_be16();=
 move
> > >>>>>    ufs_rpmb_read_geometry() to the patch that first uses it so it=
 is not
> > >>>>>    an unused static function during git bisect.
> > >>>>>  - ufs: per-region CID/size: reject an out-of-range device-report=
ed
> > >>>>>    logical block size before shifting and split the size computat=
ion into
> > >>>>>    separate statements for readability; order <u-boot/...> after
> > >>>>>    <linux/...>; note that the serial hex encoding matches the ker=
nel
> > >>>>>    device-id ABI.
> > >>>>>
> > >>>>
> > >>>> any further comments, is it ok to merge?
> > >>>>
> > >>>
> > >>> EOW reminder - this has been pending for a long while
> > >>
> > >>
> > >> anyone care to comment please?
> > >
> > >
> > > kernel changes accepted and op-tee changes merged.
> > > Just this one pending with no comments for nearly a month.
> > >
> > > maybe we can merge?
> > >
> > > thanks
> > > Jorge
> > >
> > >
> > >
> >
> > Looks like you're sending to the old mailing list instead of
> > u-boot@lists.u-boot-project.org
> >
>=20
> hi Neah,
>=20
> ah interesting, maybe that explains it depending on people'w workflows: I=
 see it hasnt landed on u-boot lore's.
>=20
> I just run get_maintainers.pl and the recommended list is
>=20
> jramirez@trex:u-boot (ufs-rpmb.v4 $) $ ./scripts/get_maintainer.pl driver=
s/tee/optee/Makefile
> Jens Wiklander <jens.wiklander@linaro.org> (maintainer:TEE)
> Ilias Apalodimas <ilias.apalodimas@linaro.org> (maintainer:TEE,commit_sig=
ner:2/3=3D67%)
> Tom Rini <trini@konsulko.com> (maintainer:THE REST,authored:1/3=3D33%,add=
ed_lines:1/3=3D33%,removed_lines:1/2=3D50%)
> Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com> (commit_signer:2/3=
=3D67%,authored:2/3=3D67%,added_lines:2/3=3D67%,removed_lines:1/2=3D50%)
> u-boot@lists.denx.de (open list)...
>=20
> still I can see it on patchworks with Neil being the gatekeeper.

Is your tree out of date? That's not what it shows here, we updated that
a while ago.

--=20
Tom

--vj+U6XTW6c4hLAcI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCap7irwAKCRAr4qD1Cr/k
CogxAQD4UustClgu70hbbqS23wuX5QYNXXakQHkB60kb/tui4AEArya9bGrNvIF8
FCLLSTk+GIhVt/LgngLFmq1pKkH1BgE=
=RUce
-----END PGP SIGNATURE-----

--vj+U6XTW6c4hLAcI--
