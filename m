Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FF606A325
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PsKgRcxg;
	dkim=pass (2048-bit key, unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=R4PmzQRr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6612809CF;
	Mon,  9 Nov 2026 11:05:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2e91-TjcpKdk; Mon,  9 Nov 2026 11:05:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D67EC80A87
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794222312;
	b=mPMJvz5Vx7GisSEpC6YO6nciVbzBgAZYZwYCy5jxiJiz5bNZ76qIJnKd3GqULAeMid1a
	 JUuPXjXZYE5uHw3BxjXmlu1Fg9I+AhdQE8T0EY97bWAPdrUrjN5gWoCT3Y2VMPVor4hO2
	 knnOtr1tJ+5Vl2jdT56OQKYSQYAN9SyLMu4XjH9XsCRuzm/6XetUCT7V0CcmRX71KtXGs
	 028UaPC7qgxQd/s5VGkilo1bV2ZMk0XbbH7xjvXPSKr5Oxlkp3FE1nZ4A7Yks+oHG5rZT
	 Zarg8JPlo29Qb5D5NMVPYiGTNEpVTeSy8UA3kafokLXql6buEy0lqGW2vKlDWiZXQIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794222312;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:References:
	 In-Reply-To:Mime-Version:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qRbjN+FabDXRiUdqQWidV87fE14CTC20N8bDVXHy8To=;
	b=tCAFn8kO4WO0Glu88tdkIWt1zFDvSCq3SX4NT43uKvV3TvDcMl5xjLHv1AyCOYipEXZK
	 DZtDspE9apatxAORZlJE3GnBJ0Ya924f0yfJ1pY/t23okHdgxwi5yyoxbSzPgteeFJXZy
	 lZ36htqmO9vAwYxxA7fhp8mOCEVlkgDKFdHl162JdnCMzyl4DSYXLo/qiZM2uyFVvFPGw
	 DxmvzMpb33zgHyiopG94V5o1XV9lxYn8sffqjATZ5jmiMX7ts9YHzbWgJhuajnb3g+nfd
	 u1q1Hs2kNJEGKDYtaYn9lKsX3yvjILR6LJkiTAG02Yq5Cvd5baoJ71ev1xBJZEnCNSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794222312;
	bh=qRbjN+FabDXRiUdqQWidV87fE14CTC20N8bDVXHy8To=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PsKgRcxg0WsxkiQjeYtRhlcQH/C1jANpZqW32vvUFUsT0F7JxOy9wiPYHpke8Q7YJ
	 JE+uA8OJEiHjrHmLSJ8fkvsqYzVRiZ3gCsaD1Smp12EkOUFVryerHXCCWPCKOJV/D1
	 wBy8+OsG2Aze7xuFvfCwOhZ/IzVMOto2ArvmjfclQcI8KQtFM50dS/gJrs7KpN5FcH
	 YTE1Z+N2n/ThOfC3uzHKMiVjEolWR8zfTzY6fpiVUd6scLYBx/eIHb2dBZONJP4JZi
	 mvEWS7CdJ1thPP2aQ8wIvEHNyfv13CEylh1M2smchnMADLozbeX9V6HiPkTfcq+fD2
	 8Tp0ZVq+dBrFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D67EC80A87;
	Mon,  9 Nov 2026 11:05:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CC06361
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 11:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29F4940095
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 11:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DLH1kwA8GGhm for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 11:05:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 463364022E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a02:598:96:8a00::1200:7b5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:598:96:8a00::1200:7b5; helo=mxe-3-7b5.seznam.cz;
 envelope-from=tomaspaukrt@email.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256
 header.s=szn1 header.b=R4PmzQRr
Received: from mxe-3-7b5.seznam.cz (mxe-3-7b5.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:7b5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 463364022E
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 11:05:05 +0000 (UTC)
Received: from email.seznam.cz by smtpc-mxe-5d66cf888-pks27
 (smtpc-mxe-5d66cf888-pks27 [2a02:598:96:8a00::1200:7b5])
 id 67982bde996c99746716a5c6; Mon, 09 Nov 2026 12:05:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
 t=1794222300; bh=qRbjN+FabDXRiUdqQWidV87fE14CTC20N8bDVXHy8To=;
 h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:
 Content-Transfer-Encoding;
 b=R4PmzQRr1MH5ZR3ouEGKK5FiD/4NeIRth3wE8tWcfpJrcp0yG4+K4D/BWa9QLZjND
 z4LHyivc/aOQKDCg7X4bcCV7VTMnd/mfE6EOjj4XP9J4avjpDlUcSrguwBS82pwlUw
 j/KiNP5HjeXIbODkLih0SbmlVK5NGjgQ03ISFLXpYOR/le0q2Ujf52dn6mNfYBIUPo
 Pt4FQKr2PUJSkh8hdZqXTGijCZyxKGHf2dzkio203N7JNjPZeEA7SymYT6KOEUcfpJ
 xFmfctdYWdpQ8pw08QyNq8Atmi1YhliZ+kuCRwnVTrSlJWAQK2fdX7uDzoSKuUZnNJ
 WnH8A5/aDRVsQ==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
 by email.seznam.cz (szn-email-ebox-5.1.30) with HTTP;
 Mon, 09 Nov 2026 12:04:59 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Peng Fan" <peng.fan@oss.nxp.com>
Cc: <u-boot@lists.u-boot-project.org>, <jerome.forissier@arm.com>,
 <sbabic@nabladev.com>, <festevam@gmail.com>, <uboot-imx@nxp.com>,
 <ye.li@nxp.com>, <peng.fan@nxp.com>, <trini@konsulko.com>
Subject: Re: [PATCH] net: fec_mxc: fix double free of shared MDIO bus
Date: Mon, 09 Nov 2026 12:04:59 +0100 (CET)
Message-Id: <1rm.ZqMo.7uNiQ1Ow2Cc.1gyQZR@seznam.cz>
References: <54G.ZqHm.6kfJQ4BsLim.1gwlr2@seznam.cz>
 <avGSHtr95FZ11U1E@nxa18884-linux-1.ap.freescale.net>
In-Reply-To: <avGSHtr95FZ11U1E@nxa18884-linux-1.ap.freescale.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (szn-mime-2.2.19)
X-Mailer: szn-email-ebox-5.1.30
Content-Type: text/plain;
	charset=utf-8
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Hi Tomas,
>
> Could you explain a bit more about non-DM_MDIO being used here?
> I think DM MDIO should be adopted for a new board enablement.
>
> Thanks
> Peng

Hi Peng,

the non-DM_MDIO configuration is inherited from an older defconfig where D=
M_MDIO was not enabled. The board can use DM_MDIO, but the legacy non-DM_M=
DIO code path is still present and currently has a double-free issue when =
both FEC instances share the same MDIO bus.

I agree that DM_MDIO should be preferred for new board enablement. However=
, I think the existing non-DM_MDIO path should also handle resource owners=
hip correctly, rather than leaving a known issue in the legacy implementat=
ion.

Best regards

Tomas
