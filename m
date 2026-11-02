Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAB606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SBj6Xz1o;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=q3eGyysh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78A7B60600;
	Mon,  2 Nov 2026 09:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EPfTiqRLb8Hz; Mon,  2 Nov 2026 09:50:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60C646075A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613053;
	b=E/8n8ryvtcRKrciBm9O6JaiNbcbbFsjzxDTTlz6iJNE211DA5R0jh6ZfR1kXQK8HIlZ5
	 lqV3Om4ypGADQ64oc5N1W5jSxUcpT18TMmck19Lyt8XM8IPm0xjWs8t3d2vniK5ets53v
	 lUFg51Aiymtv6dLndS+Cq6+P550OD0a2kKwUj9ev7y531Tx39/J1qvW/Y8CaD4JxNBd4R
	 XKakocpZ5r+l6aUm8TtJ+bny78zJVI9F+dEirGWHcI7qzC/azB71l5P/RrhoDXyPSnGSz
	 VX2mxr+LFeoFQn6ICmTRTRyg2fVFho54iWxRA1AExy5cURa/WoEyrtNizM2B/43vwiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613053;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Virus-Scanned:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XByFggtq7i5SGGQnb+Fv++S/FHtlg88KQuGGJlOzIxI=;
	b=WJba+TtJF51xyJz3wL0Ge1w10GRWbZ+nbrNSBrCGzilasCMPENYi3bUQZAHwN3qpyHKl
	 NB6fu7qslE043OAS5T7PThd7sZp/ubaGHt32MCiBcRZE0fJ4FuOLX4eZTRFQC8lBbh3uL
	 Qfw5t2hqoflKXZURKBVCGyWAIjDQGKVVPJ63iItowau11tiii804HPudSgt4u6zlPaKpi
	 3HZcgLQVaPtIqZbMz3a5lPay0pBqcaUTmoMPVMAltWEtx0GkLlEirlWg1i/WEXlc7+mk9
	 b6NSwvaX4rpD+e5MGlFHpljXgRC23QQwpWypdpqPAC8r8CjlJViSoYSZ3H+CpilreSw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613053;
	bh=XByFggtq7i5SGGQnb+Fv++S/FHtlg88KQuGGJlOzIxI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SBj6Xz1oTGYLrilZFBZtIDn3QOsuy2D+PkoTdqxYlvakRTz0GE96ZUuqjXVy/ansq
	 0McJ1DRPRpVwKYmfpRpWSTjRKqZW7m4aztDhqAqlce4Q8E6PhpJ9aPhaC4tisJDIf8
	 QpVcq/IrWkSRNe88IYVHVanXCjdSe15JcO3mioygLe7lGCqfMsR0iSMKMMsNlP1UP2
	 hC9zXPFd6w2ceGS8Hni64dUD3DObz1hro/P6YZctIkLn0dsZiXPVPXj7lov6GWqz7a
	 ttda8e2ND6OxYabzZZUIbJXjX7ff+Emkj521/DYfKvYCl4IuciuV1oWQXSfmVY1MsH
	 ufQtX/aBawj3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60C646075A;
	Mon,  2 Nov 2026 09:50:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3000FD3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1594180E47
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:50:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gNK77jIunAsr for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:50:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AE1B980E2D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793613051;
 b=aJARQMg2HXShpZa0V3b86dOs5H3YHVsAfZVqy/h8K6RYVMNVOFZ9aR5l25s61T0jeqVZ
 TpVCnm473ROBYNdg/mCkCfaaJLGhgOLk2rPAqWK/XmtxLniiyfFlANhEjrc+3ARcWLBOx
 Nl6pHlsuPSO5YYv5Wgnt45mDZBK/QOn/Zp5iZc6yH+7OLjaw69/xp8AhRIbwk3/s3KmTH
 yANNwsYPQ8ACqwHAeddog1pTbqylhFj3a/nFv6Mbn33ewNfXNnJL7fKbunEfF+OYctkKi
 UT+fDfvpPFHSFOtKDh8gJpEPEi6heZTltyDqF1n3ZUHBrwOhD9hRdVQck/a2+JIN0KQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613051;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Virus-Scanned;
 bh=XByFggtq7i5SGGQnb+Fv++S/FHtlg88KQuGGJlOzIxI=;
 b=mRw9319bTsfm62uhPk6y1WXbSLUotXQtvVOv79hxtatN1DiY94856BvV8YjHjToKSn8i
 Swcdpng3azwD+iT3Ao8Ge4CRc/8bfSjO9bgNfwJmkWkI7FqVhuTk1Ihgv3tB22lTj++7a
 J9lIimnzrB48jJ+6oKgIG3BWAhKaF6idXk467RPL6omkXdfYaM3EPQangf+wWa7oJI/z9
 lv88J3NWdvLi8gPn7ZFFcerYFs7fo4UMW1+o4WPyIsA7RdS02XeeHfq8Kv3rh1lwKzOxv
 DTT7yS3oOgTmfzLv/fcXWR5EcgTbqo4+bZ1s0uTClWmqfvlYcM1Cd0t3oSmmwBxfV8g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=q3eGyysh; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=q3eGyysh
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE1B980E2D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=XByFggtq7i5SGGQnb+Fv++S/FHtlg88KQuGGJlOzIxI=; b=q3eGyysh2R9IScm+5fRz5iqbPq
 lOqJ+Q+RYK0Zt0SRJQNFl3aSBGLFdKSUOB9kMDGMrGnPSaq+2zdIonS1f1v/CrDY0WBFgY1AEb1cW
 Ina2Y5qTZcPKG7LShcqE6dlBbVTRQHX2W33LhsZickiu81AhwtQfN0oxU9BuHA177m755Y93IBqX1
 4rUPdMiYMiurO4dRvLc8dct8Gty2GXRx0q1DyPogW7A7v1oZDSjiQxsv3VRRrp8z3KH/QnQ7MXKDC
 CW1CvjVThsSCV8Nw7ohANdjrT2E7T/ppqihGnB1LTcTASzcG8CWiCDRJNuIFf1uCNiaRu7GNVVo83
 zdPNexkQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xNogb-000JQO-2u; Mon, 02 Nov 2026 10:50:41 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xNogb-0008dN-0S; Mon, 02 Nov 2026 10:50:41 +0100
Message-ID: <d1df69aaffcf8d0d61009018f63370d7724e2773.camel@ew.tq-group.com>
Subject: Re: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Marek Vasut <marex@nabladev.com>, Mehmet Fide <mehmet.fide@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>,  Tom Rini <trini@konsulko.com>,
 mehmet.fide@screeningeagle.com
Date: Mon, 02 Nov 2026 10:50:40 +0100
In-Reply-To: <4c7e7a9a-dbeb-4fc0-a43f-60562aa22249@nabladev.com>
References: <20261029113657.2303346-1-mehmet.fide@gmail.com>
 <3e9e6ed967dfd1634fe001531bc63f52df823381.camel@ew.tq-group.com>
 <4c7e7a9a-dbeb-4fc0-a43f-60562aa22249@nabladev.com>
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

On Thu, 2026-10-29 at 16:01 +0100, Marek Vasut wrote:
> On 10/29/26 1:56 PM, Nora Schiffer wrote:
> > On Thu, 2026-10-29 at 12:36 +0100, Mehmet Fide wrote:
> > > Marek Vasut wrote:
> > > > I assume that usbmisc driver could also be reused by VF610 , paging
> > > > Mehmet on this topic.
> > >=20
> > > Yes, it could. On Vybrid each controller has its own usbmisc
> > > ("fsl,vf610-usbmisc", usbmisc0 at 0x40034800, usbmisc1 at 0x400b4800,
> > > index always 0). USBCx_CTRL has PWR_POL, OVER_CUR_POL and OVER_CUR_DI=
S
> > > at bits 9, 8 and 7, the same as UCTRL on i.MX6, so the over-current a=
nd
> > > power polarity code can be shared. ehci-vf sets OVER_CUR_POL and
> > > OVER_CUR_DIS in that register directly today.
> > >=20
> > > On the !DM_USB question: patch 3/9 of the ehci-vf v9 series removes t=
he
> > > !DM_USB path, so VF610 would only need the DM driver.
> > >=20
> > > Once the driver is in, I can switch ehci-vf over to it and test it on
> > > the Colibri VF50 and VF61.
> >=20
> > It would be nice if we could get rid of !DM_USB in ehci-mx6 as well. I =
may have
> > missed a few, but I think the following are all defconfigs with
> > 'CONFIG_USB_EHCI_MX[67]=3Dy' and 'CONFIG_SPL_DM_USB is not set':
> >=20
> > imx6dl_mamoj_defconfig
> > imx8mp_data_modul_edm_sbc_defconfig
> > imx8mn_ddr4_evk_defconfig
> > imx8mp_dhcom_drc02_defconfig
> > imx8mp_dhcom_pdk2_defconfig
> > imx8mp_dhcom_pdk3_defconfig
> > imx8mp_dhcom_picoitx_defconfig
> > imxrt1050-evk_defconfig
> > imxrt1050-evk_fspi_defconfig
> > kontron-osm-s-mx8mp_defconfig
> > kp_imx6q_tpc_defconfig
> >=20
> > I can propose a patch to drop the !DM_USB code, but out of these the
> > imx8mn_ddr4_evk is the only one I have here for testing.
> I have 7 of those. Keep in mind that MX8MP is DWC3 controller and is not=
=20
> affected, MX8M{Q,M,N} is the chipidea EHCI.

Ah, right - I only checked which configs enable CONFIG_USB_EHCI_MX[67], not=
 if
it actually makes sense for the configs to enable it...

What would SPL USB support even be used for on the 8NM boards? These SoCs d=
on't
support USB Host boot, and SDP is handled via BOOTROM, so what should I tes=
t if
I try SPL with DM_USB? On 6Q/DL and 7D where SDP is handled by U-Boot itsel=
f, I
could at least test that with some of our TQ-Systems boards.

Unlike 8MN, 8MM defconfigs enable CONFIG_SPL_USB_SDP_SUPPORT instead of
CONFIG_SPL_BOOTROM_SUPPORT too, but I don't know if this has historical rea=
sons
or the 8MN and 8MM actually differ here (but in any case, none of the 8MM
defconfigs build a !DM_USB SPL, so nothing that is working at the moment sh=
ould
break on those).

We can scratch the IMXRT platforms from the list - those don't even enable =
USB
in the SPL.

Best,
Nora


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
