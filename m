Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD708606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 04:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V8Ptc1B4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=atgQeDwd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C10D4069F;
	Thu, 22 Oct 2026 04:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uqHZhc8IN6Q9; Thu, 22 Oct 2026 04:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E0D864052C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792644524;
	b=Y35D44O7IxxlaYDYAz0CAdMiVzTwgQlVqzYM7NRZE4K24sacPjmAi6veekp8w9Rps5cK
	 wvrrBNQXFqiRZz7QZYKtoRH5DAo/jqsxCQ8fPinEF5EXQyZ2PjEaB1IB26Bk2PphT8G5K
	 qSWOZfrRcVQK3Lca/px9Xrm1Feu8IFaWfqZ0axc/hK19HpdOi/0oH6Mm7n5bfWK4jK+Zy
	 fwjDVd1MmlQ/FeLGQBqPrM3HwOzbjgOuUCKnp8iNRYeVRcI0mg1OZ/x1jbtIr/vgtJgyZ
	 zb3yQ9bTSPdKw0SG/DBV9WWxrjgV3ueayK58KQZY+RrZoU1PI+HgCVK7I7Tn1tiGHpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792644524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IFkMuP2wmb5xsts6YwLMtbsQEbd9mz3F/vRJXtm1Zco=;
	b=m6Retc4S0DQSdKMdXDMyTwnJSnF58WPGbgtmBQgpLGWKcbCqWkw4Oi661R8KcW6CeLG3
	 vROu88H3rqTqHuevmREJ0a+dReC9D1MsItHj4d3IOw88XSQihSsUNnjj89NdJDqli52iR
	 lMj0FDF9ZvYTyfXc/sNXvhUcF4rrjJEzWRSvhCWA7zRdRh08ZSjd+Sbqx66Lv4hLLM4pg
	 UR0B7BIC8wWOxvJPleEPdIQOL0TRrNOFEgT+Ix+HTUNZcmPeBdrab4r5hCDn4FnK0HaGv
	 95PurZyKGHpHbsat9UvyTjOMTxhnV6C8eL8xO+CTx0dWMgyrbA5YvWWcOgGDWdvbRVQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792644524;
	bh=IFkMuP2wmb5xsts6YwLMtbsQEbd9mz3F/vRJXtm1Zco=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V8Ptc1B43f8h5obWSQYaASVpGIgpqOozrSTrwEaIp4vOh48vAh5jvtDsEcXgq+C8Y
	 vHwM2f3vUqr735C+gZU7BgM7kQ5qQQAr0Qx8jnIYAaQvXTDEsRf2CnV+6wRp18D6Nb
	 ByAuLRPAFDUrspvxuzAf6ZgCmcSA8jEE2pka+vt4F/HyCEul3fGeMRwl8maPliYj+3
	 znFaw+f8kxcUeyaegqPrINWdGNP0aXImydDB3e71TsnTq7Ou9/r+4w7W+VuWKA3bHz
	 rxJrslmlIR+bxtqdRO9vovsXW7VrSdExa3GD4a2ssXDEtx2FJhNwWYax3bUCCMdbcU
	 F3ptbfVWCL+LA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0D864052C;
	Thu, 22 Oct 2026 04:48:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A8753A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 02:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30411605FD
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 02:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GsFi9LWlbKBe for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 02:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69928605CE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::5"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792637902;
 b=knMMMiwxp1viyZAavyVcoB+bmbCX28Yzxgzm6R/akLmLFnjOcOCPK5uYTKngxwo+xWIv
 QGaiR39wVNq1oUhIKXa+IjcvLlnUL8ORJTGFaG1/mMYFYMdipacNBCj1hw1Lo+6PTcTHT
 GjiYrznzUbJ4Ry9RXlRg3afZG1I1TyVM59DgQegctekB9XvQ0FW/rgTGe7gOHfj6Lq4yn
 HLivZrr3T+Lf/5WHgZgbF564NzYeSOs1woG2aqJFjx2j1oDCpQgJrSuBVBJchLksbLhhG
 mhZkrmoHFdQd85cpnSPZUgYIVvQ1v+WVMVvH3drR/3kE8bjRLx3fOQEuoC+D/Ou2fWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792637902;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=IFkMuP2wmb5xsts6YwLMtbsQEbd9mz3F/vRJXtm1Zco=;
 b=JWvI0JWX0xS87h3l4spXQI/ZOiLiT0QWFyAvKKJtE2yNSt9v/N2SpAW7WsfHQdsFYEEl
 pdO7GY/1Mglewxys+6k7vQQgjgxZ1xRWYy9qK4UGtY7gxom/NNeHXlJPpODmJa7PlE76v
 dpE8zsK6UVKku18+4CwsUjggxxaivzD8lIb4Bdjk4XoyU8IxaiSVC+/aa7d/MBfMU1CDv
 r87H8F00u2gm+f35xYpSC9U22xwnSKepCd3wUhKCRAFRUBcUPEFQ/X2ZJwKK6dpIlpPvI
 F8VPVpe5eDB8Ua6L6GkNbPfYBOC3XXTgWzBkIed16s3WxLcLCPHlltNTwe5kZksdGig==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=infineon.com;
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=atgQeDwd; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::5;
 helo=smtp11.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=atgQeDwd
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69928605CE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 02:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1792637903; x=1824173903;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DOgSYN0aPe9X7tBOLDpSWTXeTuRc46F8e/PdUeSxQWM=;
 b=atgQeDwdqKkXt9JXKRUVePCn0/V3AqR3RSN1Hg/63kodS1l3Sbntq2+Z
 KMuEFyjl65c387hhCkAOlqGcvjh4bJqb887MPa4z8VLSC/lUWapLcphtI
 NpHv0u16vl5bIVHeTKtF16d5M+2dTzrJNB+2nyTjaaC9XG2AyB67ObJ6F 4=;
X-CSE-ConnectionGUID: Z3gQLuhITliipdPMEOZnNw==
X-CSE-MsgGUID: N06Wg+S5QXap1uMx0VNcQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="166364170"
X-IronPort-AV: E=Sophos;i="6.27,171,1787004000"; d="scan'208";a="166364170"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 04:58:18 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 04:58:17 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE815.infineon.com
 (172.23.29.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 04:58:16 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.053; Thu, 22 Oct 2026 04:58:16 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, <vigneshr@ti.com>,
 <raymond.mao@riscstar.com>, <vjardin@free.fr>, <festevam@nabladev.com>,
 <ehristev@kernel.org>
Subject: RE: [PATCH v3 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Thread-Topic: [PATCH v3 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Thread-Index: AQHdXQ/YDM7Zopx7P0qcltYEI3YLibcAXC8AgAbgizCAALr2gIAA7xAw
Date: Thu, 22 Oct 2026 02:58:16 +0000
Message-ID: <27c32cf404704191a2d77fb491d79fbf@infineon.com>
References: <20261016-split-sfdp-id-v3-v3-0-4a47b8fc945a@infineon.com>
 <20261016182654.GA4035800@bill-the-cat>
 <b879d1b7c63242c6aa28599bc6b6e59c@infineon.com>
 <20261021143717.GL720525@bill-the-cat>
In-Reply-To: <20261021143717.GL720525@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 22 Oct 2026 04:48:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> On Wed, Oct 21, 2026 at 01:42:00AM +0000, Takahiro.Kuwano@infineon.com wr=
ote:
> > Hi Tom,
> >
> > > On Fri, Oct 16, 2026 at 10:43:41AM +0900, Takahiro Kuwano wrote:
> > >
> > > > The spi-nor-core.c contains optional logics like SFDP and manufcatu=
rer
> > > > specific fixups. The spi-nor-ids.c has single large ID database. Th=
ere
> > > > are many #ifdef directives in those files and that negatively affec=
ts
> > > > readability and maintainability.
> > > >
> > > > This series, as the first step of cleanup, move SFDP logic, IDs, an=
d
> > > > fixups to newly source files. Reworking, renaming, and reformating
> > > > existing code is not a scope of this series and further cleanup wil=
l be
> > > > taken place in follow-up patches.
> > > >
> > > > Here is the code size impact when applying this series.
> > > > Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
> > > > manufcaturers are enabled.
> > > >
> > > > SPI-NOR:
> > > >             text    data     bss     dec     hex filename
> > > > BEFORE    720685   14084       0  734769   b3631 u-boot
> > > > AFTER     721827   14156       0  735983   b3aef u-boot
> > > > DELTA      +1142     +72
> > > >
> > > > TINY:
> > > >             text    data     bss     dec     hex filename
> > > > BEFORE     77399    3128     248   80775   13b87 spl/u-boot-spl
> > > > AFTER      77589    3200     248   81037   13c8d spl/u-boot-spl
> > > > DELTA       +190     +72
> > >
> > > So this leads to imx28_btt3 and imx28_xea overflowing in CI on link.
> >
> > I don't see any errors in my local. Something different from CI config.
> >
> > imx28_btt3_defconfig:
> >           text	   data	    bss	    dec	    hex	filename
> > BEFORE  37947	   2896	      0	  40843	   9f8b	spl/u-boot-spl
> > AFTER   38003	   2912	      0	  40915	   9fd3	spl/u-boot-spl
> >            +56       +16
> >
> > imx28_xea_defconfig:
> >             text	   data	    bss	    dec	    hex	filename
> > BEFORE    38004	   2816	      0	  40820	   9f74	spl/u-boot-spl
> > AFTER     38060	   2832	      0	  40892	   9fbc	spl/u-boot-spl
> >              +56     +16
> >
> > Could you share the exact CI error or size report?
>=20
> What toolchain are you using? CI uses the 14.2.0 ones from kernel.org:
> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/
> and the CI run is:
> https://git.u-boot-project.org/u-boot/u-boot/-/jobs/115650#L3163

Thanks for the links. I was using arm-none-eabi 14.2.1.
I need a little more time to reduce the size. Maybe we can optimize the
flash_info structure by dropping unused parameters.

Takahiro

