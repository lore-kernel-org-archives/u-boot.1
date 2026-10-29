Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AE606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XTYO0YIc;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=j+la6H+g
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3FDB40556;
	Thu, 29 Oct 2026 12:56:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xglWH63339D6; Thu, 29 Oct 2026 12:56:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC8464061B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793278605;
	b=SEo9/rZFrfI3fe2Do/N7tsO70t1HgRGKiQWPXRrEZ8u0cvaVEgoTIADa4ighE6pBMLvu
	 tUbYFeaPiX7oHUcB+FlS2ydpF7xz+SKUNkqerSZbfWgmF8SgNgSPyXzdddW4CcTBJ6A7H
	 H2suWvKyRhHRLro6ZOstg1sOmi2/XuIWRO6ZB5FB8YCq7w+YyJpZK5OFqF2a+Xe2WTpM7
	 Y036Bj+3TmNVv6VaNOrAeVJae9d+9Fli2fNt3k0UeG5z7khVY1X+QNLwsAMZ0wAgPC0wA
	 A350qT5YS5WcoRsHkxKUoQk69FP9t8yvolPKNyHaoQpCw6A88Nc/5CU6gUiL8zCeyLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793278605;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Virus-Scanned:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kMYtAcl9ypy0PZxQ/teQFOjoG6cT46M/tU2LD2rgPAU=;
	b=PECmqJNEoze4WCmJuS54lvBkIteiMlIyi7gd6tUwoPAZNuZofzounj4hTQY4h8rESlwC
	 bbjkxmGQmMxo3WvEF6jnHNVG68fpyOhg9VXAsRpUYion2+k4PDmuFA40Jo6l0l/qsIzOS
	 5IxqjCXdSzZWTXuBevM30eRCdIEhRIaM/ECsvsEibL8ZVcAkwI+VrIJ/Uf/NReFIOw+PX
	 M30PHyhdH4wSiHl85sKSIAvx/JMbyKOsYOuz8KY8FruxBzkkcuwsMTSBNyxjcnlet9Kqa
	 YRMvicJU6mvDwFTjQ9vcTBwzO21ifMCf9O4e8koxV2lxKN/TdHyTQFQVmIkl+cKxPhg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793278605;
	bh=kMYtAcl9ypy0PZxQ/teQFOjoG6cT46M/tU2LD2rgPAU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XTYO0YIc5H+IjSNJ4ZrqloAwExw0ok/fWC+aeOkroh7vLvnlmSopG2AJmvRlImH58
	 Pm548C0dJ/Abe0TG1E/C52jELsOwdJMJ3R/lO9SG1R509H3grFsYNMGeQCvCMcMzLE
	 CgtAT2jgSuved+pOP9LB8mm0TsdsuVVo/9pqpf39+RtgwVrg4RZtzCobFJXBaepklU
	 NePFwZIlIlsH/ixQm2Y6Ok49GD+WfoHuZTc2OVDctjv3zkIcnlTNZSGIN7eMxYs7kP
	 uKvervW+iIJzsc23jnJ991psdT04vZyDzprlhl7YjUIXpuOANMtGq/aZ+b1gtfLp+D
	 kQ/GtKl6PgLVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC8464061B;
	Thu, 29 Oct 2026 12:56:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ACC0B362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 12:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F7466069F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 12:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mcdPHfN80qh8 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 12:56:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D3D0060633
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793278602;
 b=DH9BkWRwQ8Wvmu7n6SXuZldYsSzlO7AKYotw2dAgIhl0wHhVh+jJE0QOSzOIiwL1TYUy
 tRsMZmtZLIRvqGGPt5cqyXUd78XOPr3FrhEbvoxTMoPQnMdApmjdmgpj7mj/qxq4zQe7o
 FNG4LSNduBjwf+AguGxImO+1v6lrYzuIw6K/ESZaHntppsJjh46vcUfCfOcKRxmWpFPVB
 MKTQ88tVyuxbT7IU4VAK5olJV/xzgQSDltNd8v2hZgw6P1Pt93GIK9isHeUuY8yLOT57E
 +EuUkTXCwq3ADW+d+cxEPgEUDZj+j+OIeOZyrAcpVpCtj3uv/8WUOvRMuD5kFsZ82kA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793278602;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Virus-Scanned;
 bh=kMYtAcl9ypy0PZxQ/teQFOjoG6cT46M/tU2LD2rgPAU=;
 b=o+z+tNZjVhdB9aDCCBYS8nBnyaSjMB3d9JUT/YtnBEfvnwq4yjZD/0g+w1rlud4pa9vX
 YdnjgkPeRwT0v1VVc9G9LmuaIp7LrKGgCLKNGLp58HKPV8W13ECIsh3scA6Y7Fk4wA3VZ
 kc7w7oH6HxEqGc3ZHy9HcZxDsw2OjLGE5IcQV7jGQa/BdJwYme943I6OYvz95ehBhLVsS
 9kLjnTgrLnWsLfwY014E6+zyapyTaqngYC67NYoEnqNRaCgaOan/XbzToNHbY3ubT+vBJ
 pwe4oLG65iY1cG5mH+kB72gQKfzm9xI3XVf7FVAF4m8IhnjcX7pdwl2/Z2BJG+p1HgQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=j+la6H+g; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=j+la6H+g
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3D0060633
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=kMYtAcl9ypy0PZxQ/teQFOjoG6cT46M/tU2LD2rgPAU=; b=j+la6H+g6fMphIjN6DNZokhsVw
 bYlD0vGvftxK8zQd71ZYBYeayhacUowmcl+MMY38UGkmbt1Q+ut0jFERx21hqQpuaqBIHuCwLI2BW
 snRPzwASP2xuhIWCGIJShdcCrUenoeAu4hWirdQF8ptJi5p6WYR+PB8ynMWewrFJ6qQ/gp3dpz9kL
 6FP+BgEVN1ocfuHk0BT61Jidl15M20cn2GuDZNOLJ8HRBvwzh3PoAL/6wQmI3geqDCsHwF51KKwjW
 Nm6OUGFF3uyAKGJTprYJZd6FhF29XPZdngo5Atlybe16M8rjxneIAzbadnvNdXrQaDoMoiQMAvPpa
 a5n5Zkxg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xMPgH-000K66-2X; Thu, 29 Oct 2026 13:56:33 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xMPgH-0009YX-0x; Thu, 29 Oct 2026 13:56:33 +0100
Message-ID: <3e9e6ed967dfd1634fe001531bc63f52df823381.camel@ew.tq-group.com>
Subject: Re: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Mehmet Fide <mehmet.fide@gmail.com>, Marek Vasut <marex@nabladev.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>,  Tom Rini <trini@konsulko.com>,
 mehmet.fide@screeningeagle.com
Date: Thu, 29 Oct 2026 13:56:32 +0100
In-Reply-To: <20261029113657.2303346-1-mehmet.fide@gmail.com>
References: <20261029113657.2303346-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.6/28168/Thu Oct 29 07:24:16 2026)
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

On Thu, 2026-10-29 at 12:36 +0100, Mehmet Fide wrote:
> Marek Vasut wrote:
> > I assume that usbmisc driver could also be reused by VF610 , paging
> > Mehmet on this topic.
>=20
> Yes, it could. On Vybrid each controller has its own usbmisc
> ("fsl,vf610-usbmisc", usbmisc0 at 0x40034800, usbmisc1 at 0x400b4800,
> index always 0). USBCx_CTRL has PWR_POL, OVER_CUR_POL and OVER_CUR_DIS
> at bits 9, 8 and 7, the same as UCTRL on i.MX6, so the over-current and
> power polarity code can be shared. ehci-vf sets OVER_CUR_POL and
> OVER_CUR_DIS in that register directly today.
>=20
> On the !DM_USB question: patch 3/9 of the ehci-vf v9 series removes the
> !DM_USB path, so VF610 would only need the DM driver.
>=20
> Once the driver is in, I can switch ehci-vf over to it and test it on
> the Colibri VF50 and VF61.

It would be nice if we could get rid of !DM_USB in ehci-mx6 as well. I may =
have
missed a few, but I think the following are all defconfigs with
'CONFIG_USB_EHCI_MX[67]=3Dy' and 'CONFIG_SPL_DM_USB is not set':

imx6dl_mamoj_defconfig
imx8mp_data_modul_edm_sbc_defconfig
imx8mn_ddr4_evk_defconfig
imx8mp_dhcom_drc02_defconfig
imx8mp_dhcom_pdk2_defconfig
imx8mp_dhcom_pdk3_defconfig
imx8mp_dhcom_picoitx_defconfig
imxrt1050-evk_defconfig
imxrt1050-evk_fspi_defconfig
kontron-osm-s-mx8mp_defconfig
kp_imx6q_tpc_defconfig

I can propose a patch to drop the !DM_USB code, but out of these the
imx8mn_ddr4_evk is the only one I have here for testing.

Best,
Nora



--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
