Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C444606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k66vUC6K;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gwsyCQZ9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3B5260855;
	Tue,  3 Nov 2026 15:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Un_5rpoXUvI; Tue,  3 Nov 2026 15:44:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE086606E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720659;
	b=QMotLChul/DL9Xuegfo6xMOJRMu9G/qVe227nK9y6+kyETm1b+5o/5pDHYjQAU6c9uEi
	 fchIXdCmcF8owk/ynunS/wach2ZN5Y+Ktc9SrR63MgeomZ3GLpLmv9TNuTW3397lxIvN8
	 77jVbf0txQ1e05hD3jP977N3yaTDINraZmf4KfTE8vW0Jac0QxFOHvI99o/okHQGFvjXr
	 jzqFDju/T/KbhsMHw9sVmTFzvoBRJK5CwJ+qOeD+dxMreURGM7PSvi6UDlLUiSVss61qz
	 dnhN00czS547Ic5e7636bxatQun/k8ihc8VLwCvRqHMnikd3Wm0OIsebiFghf8vgpPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720659;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v/AL6byCb7FkkGoWh52mjrMc1gP9YvlLMzp+vcxfFsU=;
	b=nC+lBJ8g738mQr9t0Kcv68h/jygYWSWEKgcitd6vR9iaCI+LyZP6UyW6Bwt6bQe/RAnI
	 PpOmbbp15zZikXraLCntr+jq5LHGrRpmhhudKx4VIRidYT0C6orTC7G+rbgTJ+rDahtpZ
	 l90vChMh35qWsWBhHyjitTJoo+puOL3Uv/xGSR4BJlDOwGS4b8K7QaH+B1CZ9qPEA76jn
	 TvXLKGJnF7xBD6cGPw8N60m3Ug8yOxvKuszpnOLobSP4qUcSmZBbxO/vGZdmsJKN5ZNRg
	 xsB7swOoYnVIMLNEFNoly1hkV8nYJSZNxdgSXaKxvGbioguhtur75cjsguAo88kOl+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gwsyCQZ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720659;
	bh=v/AL6byCb7FkkGoWh52mjrMc1gP9YvlLMzp+vcxfFsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k66vUC6KTWeevo1xGbo1ZgKdb3nuJKy/z3d2L3utwQMb7GdNMiSs4Uj+apPvukd3w
	 RwEgY6eYqp+mC586GGApYdbOOxDIYYSR5hYDYReWIHbESmZue/k+e9JyaoDt55qI2/
	 dAICCuezXb7BxU4bQrAjIH8viKzdZ9b/lZ0dhhEl6p8ZSUO/tBiVg4hl4JIHX4AXVd
	 NxM44xJ1VtVqZjdWnPb6i2SQTt44izkk3EA1g+ixVeZOgkx/ctNOPqbJQBurlOwRez
	 goT82syDxf3Ny2YCqM3MdjpssOwh6gXQCLZbeZXEuZBUreWHQPI1hLSURA3cHCm7Yi
	 ks5+sKqMHZjcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE086606E1;
	Tue,  3 Nov 2026 15:44:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE21F235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3F29606E1
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:44:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZMbeLZF6eRY0 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:44:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B8B4606C1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793720656;
 b=RfVAgDc9yE2jUXcBJ+IHZ4QK0sfVxI6fRBFTMeXnGoap0cuM4imUaAxDavuLqjIQ3CAl
 ZmZ3oPFGfZpfzvHo2zdqYPlIMCt4FnqLZC72vUwfBMVBCfGpyLxe+QLgAr0ifCau+SDnd
 XzEv2OPgDzw2GMYREzHMdG4nwBjqbtVe50NAMp0OS7MXUtet6FAktYCDy4qIpq41egCl5
 abiG8Gm+1IbqixQ4HrK7WWZtawdHApFpoz9oxCWAqQ6a1OZLhalFNpM74un4dSAPcN0DR
 6R0MKZkVBEFDIrqhPr5x4itgsdItDU59VpYp6cD53vywDIPiSOVbbEWD2qPiv+nRGIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720656;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=v/AL6byCb7FkkGoWh52mjrMc1gP9YvlLMzp+vcxfFsU=;
 b=BmrmEFa/dPg1t85aH/EXaEmkeRuDVOsIcJzgQTRslW6qP0KWjdBZSnp4/i79aCB43aTE
 Mj7yxXzxFiorrpg7skf0WZAzxX4gOHKozLZ3Fm8OvUcZKcLlY4Abn6CCfD01AEPRLJMBZ
 KnHQAV9vE6urf1GLyVfuloAJ/E4KoEcPqQr/srcuncjPocvup/bqgduLEbuUUUtze5LT2
 1QvV5sm+SHp76KiUWI6K110e5YCRY0928Rclw3MCaDDbmYWcxxBqC0nrYjZgmKNRuMNbT
 CxnqcbIKPlrpuBNlxqerFImf0FBRSdn6ghg4SAeVZUBVvA8Dj5NhnRul00Ui10yTUyA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gwsyCQZ9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gwsyCQZ9
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B8B4606C1
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:44:15 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-53a448f86e0so2395404b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793720655; x=1794325455;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v/AL6byCb7FkkGoWh52mjrMc1gP9YvlLMzp+vcxfFsU=;
 b=gwsyCQZ9HALM204I7vj+DxjJPaatbjLA611NNfF/qLxTnxrVgYyvMdM25zfxq7ZvrX
 m94OdGGsfrq6oI55Mg5qGmshlWpYvjgSAmun/OBQPmrKoGtJrweGzUH0EBfXjukHMDkf
 zrLzlBsTAPMTSoLdMdsddSNc3DTIVI+yAFu4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720655; x=1794325455;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v/AL6byCb7FkkGoWh52mjrMc1gP9YvlLMzp+vcxfFsU=;
 b=no5mhDszTIHagikIcUWbkHRJyrlhYPZ8/T1DqcdtgnSX7299fYr/eDw3pkShatQi6A
 DthX3vQgcJi2uXWnFswNR3sIRjvAehQdCHmkTiD+fnTlSpPwwo2BxOxA3mz/1IkG3HE2
 c9OyGiUa+CXXHvR40wZIAO5Yn0JN7lBGIZgsG63oOQ2vXlllglfSiFjCk9fEHzHTO4Hy
 EM2I7L4uq8P0//qK/LFsmaXQKL+rd2gC0oueN6EgKBi/aelQ6qwnp61f2Yp7Hh7c2N0t
 VLHWEq3AIlmTik1U9kDwFcEY9M6Dk0XM4U6eUJv0Gi5UzGNkB24fWNASbsqmy0kHYS96
 4LgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLYcwv5af2+UZJrRITk+pkqplXGwcJv7oQXOm76S++0HVYZS5iMVs0ROo2LZgrfV6Dl4Ae0tU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z90gpUhlDJTC2zUcnGuth4uwOw3tg/xAtJxYTE3dghWzqrUdV75
 Jutu+YyM3mbKytUNQpiszuuEtSD3sJnp4EiwWb2BkFpBxoHxfu3rS+w2ywChI07wVIk=
X-Gm-Gg: AYBFou08pvttiK6vqKoKEG73uczPplR8Ylzwi1M1y18aUe8ZvBy+crvLIYPArbUzoKF
 YVemHoMuJTmorKo0eU9Tx11Wz5zGp82ZR2cDWVVq6ulvUMNkYDsLVE6aG9Q2WB+GqcCdHh9pMEO
 WmW4Zzvl3lBF/OEN4PHv959qFfxsSrAeC01eJJB3aEIbY71Bvp089hrEDe5HThpf5SS/A0jc8e6
 zGo8jdD5AH95v9/U6V+vz2ESgEOS7KevX/2oWZ4A4O0cfQZpB8gj39NvEDiMU4WKDZXbhyuzvJH
 RBQj3aiBa3S0MDD+09mdsEEZf/sWXn0GDXL8cQVhaGQR73/Uina+UfOByi174PJP/DALov1/o7h
 qM5ps2zq020ekuvOx+9GP7zEJ670NbFZ7nZ8HkgZjpZtHWLK9fvSloGi1w2wLeypIjhhLaYTYcO
 GRFsKtN0W6x6O9UaQssITDqeuFh2gwQE4p34mo7wPXZw09rJ3e88bUN2ugkTxLAFspYwoXvN2fB
 HqV4KAJjfh9rFGiYjP+k9kj8Y6VsVpo9jnblIEq/lO6mHB4mJ4wQ2kYIg094VwP58DHglkwVDB1
 pMmETLVihxAbkK+Qt9EKjf+X9UP9NHnUt4AX4zrRsuvyqKRPnZsI2xoHiejjkbyD3gV9vwocndS
 +6zC45u5QXHaeZafe7yrT
X-Received: by 2002:a05:6808:5390:b0:53c:71bd:e937 with SMTP id
 5614622812f47-5640ddb2d34mr9473683b6e.10.1793720654934; 
 Tue, 03 Nov 2026 07:44:14 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fd95dc0sm11628555b6e.6.2026.11.03.07.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:44:14 -0800 (PST)
Date: Tue, 3 Nov 2026 09:44:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: "Padhi, Beleswar" <b-padhi@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 00/22] Introduce resume for J7xx SoCs
Message-ID: <20261103154411.GA756492@bill-the-cat>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
 <20261008234037.GA1328652@bill-the-cat>
 <d3edafc1-8a7b-41a9-8805-c155ba799d54@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Iy9gqM1IgCC5nnS3"
Content-Disposition: inline
In-Reply-To: <d3edafc1-8a7b-41a9-8805-c155ba799d54@bootlin.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Iy9gqM1IgCC5nnS3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 06:52:46PM +0200, Richard GENOUD wrote:
> [add Beleswar]
>=20
> Le 09/10/2026 =E0 01:40, Tom Rini a =E9crit=A0:
> > On Thu, Sep 24, 2026 at 02:35:11PM +0200, Richard Genoud (TI) wrote:
> >=20
> > > This series allows J7200/J721s2/J784s4/J722s to resume from suspend.
> > >=20
> > > On those SoCs, a magic value is set in a PMIC register by the DM
> > > firmware just before suspend, then everything but the PMIC and DDR is
> > > powered off.
> > > At resume/boot time, the magic value has to be read back by U-Boot SP=
L in
> > > order to know if we are indeed in a resume situation.
> > > That's the purpose of j7xx_board_is_resuming() introduced here.
> > >=20
> > > Then, if the SoC is resuming, the DDR has to be brought out of
> > > retention, at full speed and get out of low power mode.
> > > Between those steps, the DDR_RET pin has to be de-asserted. But the
> > > DDR_RET pins of all DDR chips are tied together on a single GPIO, so
> > > it's impossible to resume one DDR chip after the other, they must be =
all
> > > resumed at once.
> > > That's why it's orchestrated from board_init_f() and not in the k3ddr=
ss
> > > driver.
> > >=20
> > > Once the DDR is fully functional, the next steps are:
> > > - retrieve the LPM memory region from DTS
> > > - authenticate certificates from LPM memory region and apply firewalls
> > > - ask TIFS to restore TFA and its own minimal context
> > > - start TFA on remote proc
> > > - load and jump to DM
> > >=20
> > > Disclaimer:
> > > ---------
> > > There's a potential attack vector in this sequence, because OPTEE cou=
ld
> > > be modified before being reloaded.
> > > Also, if the certificate replay is skipped, then TFA can be read from
> > > MSMC.
> > >=20
> > > Patch 1 and 2 are from AM62 LPM series:
> > > https://lore.kernel.org/u-boot/20260105-topic-am62-ioddr-v2025-04-rc1=
-v9-0-7e33f2c77dbf@baylibre.com/
> > > Patch 1 adds support for DDR in self-refresh for am62/j722s
> > > Patch 2 adds capability to call TI_SCI_MSG_MIN_CONTEXT_RESTORE
> > > Patches 3-5 add LPM helpers for all SoCs
> > > Patch 6 adds the resume detection for all SoCs
> > > Patch 7 adds common code for DDR retention pin
> > > Patch 8 enables GTC at resume
> > > Patch 9 detects IO+DDR resume state for j7200/j784s4
> > > Patch 10 stores the wakeup reason in MCU_PSRAM0_RAM for j7200/j784s4
> > > Patch 11 sets the PMIC NSLEEP triggers
> > > Patches 12-14 add the DDR resume sequence for all SoCs
> > > Patches 15-18 add the resume flow for all SoCs
> > > Patch 19 updates the pm-cfg and schema to a new version
> > > Patch 20 removes now unneeded background firewall on DDR for j7200/j7=
84s4
> > > Patch 21 extends the firewall for ATF region to TIFS
> > > Patch 22 add the resume flow documentation
> > >=20
> > > Tested on J722s HS-FS, J7200 GP, J784s4 GP, J721s2 GP
> > >=20
> > > https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#=
tisci-msg-min-context-restore
> > >=20
> > > It needs lpm_memory_regions described in DTS [updated to v4]:
> > > https://lore.kernel.org/lkml/20260921145325.300025-1-richard.genoud@b=
ootlin.com/T/#t
> > >=20
> > > It also needs a bootph-pre-ram property in PMIC-B for j721s2:
> > > https://lore.kernel.org/linux-arm-kernel/20260429-k3-j721s2-som-bootp=
h-pre-ram-pmic-4c-v2-1-31a0e7677216@bootlin.com/
> >=20
> > Given these needs, should it wait to be merged until we can pull in a
> > devicetree-rebasing tag that contains it all? Thanks.
> >=20
> The bootph-ram property has been merged.
> And for the lpm_memory_regions, I've talked with Beleswar during ELCE, he=
'll
> have a look at it.
> That said, I agree that it should be at least fully acked in Linux repo
> before merging it to u-boot

Thanks. I see the am62 series has been posted now, and is only
cherry-picks from devicetree-rebasing (yay), so I'm moving this to
changes requested in patchwork as I will apply (barring comments of
course) the am62 series first, and this will need to be rebased on top
of it. Which should be fine since your cover letter notes you take 2
patches from that series.

--=20
Tom

--Iy9gqM1IgCC5nnS3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauoBSwAKCRAr4qD1Cr/k
CqMiAPsF+dHr1TMqEY8UKNZ4AkQJmUpyrDRgkW87K7spDPRdbwD9FWjBKqezt7JL
TZhUsb9IA2qIhchMcTL+/0jZcXgWjQo=
=v/rc
-----END PGP SIGNATURE-----

--Iy9gqM1IgCC5nnS3--
