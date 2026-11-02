Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F86072C69
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WEvYfnjQ;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=qHaBxxeJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDF2540703;
	Mon,  2 Nov 2026 15:10:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHPih2cB0t1n; Mon,  2 Nov 2026 15:10:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DCF5A40633
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793632225;
	b=AGLOH97Dr3XGGlr8PEnNyffXVur8dk/yfYO7uaw4Vuhu0nKkZLsvkpelJLhzZU3Smtpq
	 jEM7tm0FRPoSKBMuY8olsz8Cy25H5cNjOG11Tpdgnv1SfvsZDTkZe+xN8tr0IavpThAC1
	 s7QV+RcniidGR3THcvPF0ggGlubcgBY91xJF7MaoRCqjWvWzCs+vbQH7jmuudUfNPeEud
	 ZOyIke0aIgs1pWiOr00PGqpnyGmleDvMyj3V8nTb4mnDlJgZhhzhi4u21v3jNHaQperdP
	 dqZ+Hws1JD2BPAvN4CvyCxDH7ZXrqXqMLUCsutAQhl00mFjVFo5MlMFx2aW28s3NBnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793632225;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Virus-Scanned:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uMiOjxiYByKtI9jlCe8jlefx3esgZ/wK5AvX4wQejnM=;
	b=oCGf4q0Q0shN5/gE4wYGKR0jzVu1ynA9sAiqRAUHWiOqAD6/vcC66s4COaFusiQ/ZEIU
	 rURoPzrNfdWVTmraHPOwZrtsQhei1sCuNsLRf7yjGYXzJ2b9ffm2lO+iFa/bOAcJwJNoJ
	 Q4HzEn5jL76eskJgtgHD2MfQbZdAQakOv5f2T58rHwNOkSjsg2QPZkWd8AesQGxgmGts/
	 XNDDsBqL2e5Avsf2VrIFZdIpUFCfWDtxOFe0wgof0XpHMeHfa8UwcMhQcYk/QJCLaLBiZ
	 GS0Y620J4w656UuyouwABnz7rhOwlNNVcZrCp4S4dspSx3aGFRPA9s3j25+Ecfl8oeA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793632225;
	bh=uMiOjxiYByKtI9jlCe8jlefx3esgZ/wK5AvX4wQejnM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WEvYfnjQ4IscBHkFojdqv5Xw4gt+plAoAIs8NBwKrKUSxtZ4wElBX9dFCeUF9Ld7S
	 PVIZt//s7akB6QkvV+1i244sizNq/qsx5sO4c0I95VY25zzrNYdCP0ZHItIQKPGKo7
	 gBe7hTDV9s1t2sf+dYIqIm7Gm2pyk/6eTvPh3052YrYJkAotHFvBLjeZmT95W1/DVd
	 5S89yp55o9LCFDWR6WkOPgOU74i5sgFtzLtiBL0sH5+fiyqfHy3TtsizsNhgaKgJvR
	 C97azAsPUbNzCiaFjXLfLP45zhwVHoHgMrxZIQXIyf1KUdKIk3tVM9k86B6spzIAE/
	 n+7Ys6TrP621Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCF5A40633;
	Mon,  2 Nov 2026 15:10:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F306D3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:10:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 712B16060B
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:10:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BAZe2Flzv05T for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:10:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F78A60806
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793632222;
 b=lP2FuWcqT1Inl4ZCcNoI8qXmtFh6/64fwmWgH5FjSgaHKcmRHGJOg1UYxahL9q9j9lUC
 lc3jjst8vnAPZRJB8sqcb5OA8e8K8sw0LlzmovMtmkSPPmOJAkDdhUz6YAPhz++rmihQH
 FQpspaEjhLkAJdsTg8rK6nOkRqmf9n2HXTGVdfJRQdLh37nKD9ILdm1W61L7vU2yw42uF
 3oxDmUo0YIh9MWTa4UlxAoS3jtgRj2AfsP5SqltGvvvhONHiM8UUfnZrFJZs8YLuB4YXE
 8AMq+YuuQJqmPzF8qZrCIlujs4p9enWlaFHTXXfHWCEw+PXejSGOeLbFFQ7dyGTEMcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793632222;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Virus-Scanned;
 bh=uMiOjxiYByKtI9jlCe8jlefx3esgZ/wK5AvX4wQejnM=;
 b=S09y4BoXDdoTXMUtEWJneQlhXctiAJuPNUEHmBCew5gN63isG6HUyZsw1pNVnLxZ99Xw
 Otpck9+dBiMnl1fSVESIPm0Ig+OR/6MG3tWKYAfHc8d7omgHgHMSWWm7zInZsvlq+CTL6
 cwHigcgOMApOqC2d2wQ7i0DoK3mxUvXH7yorCuW/bSYKg4OEQZyJuft0XbqXeFXSCojvy
 r3Z1Kozlq6fAolQ8P3/81mVyt77fB0r1Jv6Dt35aBSjEG7XJNMMb0ifpCXe7BVLBK4Ad6
 4ylXItio+1BQrO6lg36Q5TbPmBkxpR452iQjzHzU0BjgLAip+75diZpJQExfm83Ql/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=qHaBxxeJ; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=qHaBxxeJ
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F78A60806
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=uMiOjxiYByKtI9jlCe8jlefx3esgZ/wK5AvX4wQejnM=; b=qHaBxxeJeYGr/A2cSA65VTiGaN
 UCQkzpfOHWA6vWlJDBk7ibLEd/uRN/Emx4sfYEfHbUqhmH4HirgX2HOOS69YwCS4e+4jYl2I8WWUD
 VLBxeRRGme2AAs6BNcq8x9vevCpOxr+Y4nvb996k9MCW8BMNAoo0df54OhUQCXALdrIF5eHJcDpUn
 3FHSTTokS2YPkvdNpZKLF5KWDAQHX5kr+WO5GXBGljiupbsUGnNwLyNnb84Ut/GRv8x+h40HH0oYn
 7HZuQeTKJXHECc+NI2tGwySLuzrUSR8ME5WEywOnyKEbqjyV2viDB/5vjb3yM1+7i2xtu8xlD6eHv
 j2le2pyg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xNtfq-0007Qj-1s; Mon, 02 Nov 2026 16:10:14 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xNtfq-000FI1-2U; Mon, 02 Nov 2026 16:10:14 +0100
Message-ID: <a496d364a10bcfbc980fde69f9980ed31de5ae0d.camel@ew.tq-group.com>
Subject: Re: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Marek Vasut <marex@nabladev.com>, Mehmet Fide <mehmet.fide@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>,  Tom Rini <trini@konsulko.com>,
 mehmet.fide@screeningeagle.com
Date: Mon, 02 Nov 2026 16:10:13 +0100
In-Reply-To: <d1df69aaffcf8d0d61009018f63370d7724e2773.camel@ew.tq-group.com>
References: <20261029113657.2303346-1-mehmet.fide@gmail.com>
 <3e9e6ed967dfd1634fe001531bc63f52df823381.camel@ew.tq-group.com>
 <4c7e7a9a-dbeb-4fc0-a43f-60562aa22249@nabladev.com>
 <d1df69aaffcf8d0d61009018f63370d7724e2773.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.6/28172/Mon Nov  2 07:24:10 2026)
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-02 at 10:50 +0100, Nora Schiffer wrote:
> On Thu, 2026-10-29 at 16:01 +0100, Marek Vasut wrote:
> > On 10/29/26 1:56 PM, Nora Schiffer wrote:
> > > On Thu, 2026-10-29 at 12:36 +0100, Mehmet Fide wrote:
> > > > Marek Vasut wrote:
> > > > > I assume that usbmisc driver could also be reused by VF610 , pagi=
ng
> > > > > Mehmet on this topic.
> > > >=20
> > > > Yes, it could. On Vybrid each controller has its own usbmisc
> > > > ("fsl,vf610-usbmisc", usbmisc0 at 0x40034800, usbmisc1 at 0x400b480=
0,
> > > > index always 0). USBCx_CTRL has PWR_POL, OVER_CUR_POL and OVER_CUR_=
DIS
> > > > at bits 9, 8 and 7, the same as UCTRL on i.MX6, so the over-current=
 and
> > > > power polarity code can be shared. ehci-vf sets OVER_CUR_POL and
> > > > OVER_CUR_DIS in that register directly today.
> > > >=20
> > > > On the !DM_USB question: patch 3/9 of the ehci-vf v9 series removes=
 the
> > > > !DM_USB path, so VF610 would only need the DM driver.
> > > >=20
> > > > Once the driver is in, I can switch ehci-vf over to it and test it =
on
> > > > the Colibri VF50 and VF61.
> > >=20
> > > It would be nice if we could get rid of !DM_USB in ehci-mx6 as well. =
I may have
> > > missed a few, but I think the following are all defconfigs with
> > > 'CONFIG_USB_EHCI_MX[67]=3Dy' and 'CONFIG_SPL_DM_USB is not set':
> > >=20
> > > imx6dl_mamoj_defconfig
> > > imx8mp_data_modul_edm_sbc_defconfig
> > > imx8mn_ddr4_evk_defconfig
> > > imx8mp_dhcom_drc02_defconfig
> > > imx8mp_dhcom_pdk2_defconfig
> > > imx8mp_dhcom_pdk3_defconfig
> > > imx8mp_dhcom_picoitx_defconfig
> > > imxrt1050-evk_defconfig
> > > imxrt1050-evk_fspi_defconfig
> > > kontron-osm-s-mx8mp_defconfig
> > > kp_imx6q_tpc_defconfig
> > >=20
> > > I can propose a patch to drop the !DM_USB code, but out of these the
> > > imx8mn_ddr4_evk is the only one I have here for testing.
> > I have 7 of those. Keep in mind that MX8MP is DWC3 controller and is no=
t=20
> > affected, MX8M{Q,M,N} is the chipidea EHCI.
>=20
> Ah, right - I only checked which configs enable CONFIG_USB_EHCI_MX[67], n=
ot if
> it actually makes sense for the configs to enable it...
>=20
> What would SPL USB support even be used for on the 8NM boards? These SoCs=
 don't
> support USB Host boot, and SDP is handled via BOOTROM, so what should I t=
est if
> I try SPL with DM_USB? On 6Q/DL and 7D where SDP is handled by U-Boot its=
elf, I
> could at least test that with some of our TQ-Systems boards.

On i.MX7D SPL is limited to 56KiB, and with CONFIG_SPL_DM enabled the build=
 will
exceed that limit. So unfortunately it doesn't look like we can drop the !D=
M_USB
code entirely...

>=20
> Unlike 8MN, 8MM defconfigs enable CONFIG_SPL_USB_SDP_SUPPORT instead of
> CONFIG_SPL_BOOTROM_SUPPORT too, but I don't know if this has historical r=
easons
> or the 8MN and 8MM actually differ here (but in any case, none of the 8MM
> defconfigs build a !DM_USB SPL, so nothing that is working at the moment =
should
> break on those).
>=20
> We can scratch the IMXRT platforms from the list - those don't even enabl=
e USB
> in the SPL.
>=20
> Best,
> Nora
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
