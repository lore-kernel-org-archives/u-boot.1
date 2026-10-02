Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96802CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C0AF40E44;
	Fri,  2 Oct 2026 12:26:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AlIBQGvl1TrP; Fri,  2 Oct 2026 12:26:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4DB7840E3C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790944014;
	b=p8tRQU/PhNQzicFP3ZxMGBgmGLj3Kr8bpxIN6E5EVTgv8tpwJTPs+kjFKrH6V8MWkWXX
	 5IyeJh0Cm06MRMMp913RG9r+bNjfYsU8qZgGGvU10yYnxu1HflYzBtYAinc3qqlsWeEfE
	 vtReyGIuDL7KhiUEMZz+U5jlQY9oG095x1pQyGNfvHpt5af3mYYm2d9MA2wi3to2wrabY
	 DS3BRza2HtdVR9CcviTlE4xWeQIRrFn0UoudaeykEbYE2+6f5w1+PKQCseaAHAOCFC501
	 lvZ8Mn5VbRZTt8ra/kXz+1XxZNMvOz0jYscPQ7yJb5eg7DG1mX7/5nMni4syI4SCXQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790944014;
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
	bh=pqne0tlE0J2y3Gl/qAn4v3SwYnNuUj+npIC6ClE1QJM=;
	b=PKu2kIHlg7Bn6hRkf/MAtwL8p5JfMJRXuMJ9Fupp+S2C48MJ0MLM4xAlNc69TEKhr1jR
	 XwGN0yaX1yL2t/J4r4Xz3XjSWjw26vWsItwWtZWnn+2wjjhSSlImtgeIOcfQIKQ5LO5KN
	 y0QOe0MH40ihJ2njYOJHCT9GGJcesVqXAVljuK6de7xFfCmPv40WczOJR5jRbiLNjlwVS
	 c3vccc1zhkXnZ7gysZ4NqBsSe7EIT/GOnnm/NwbaTVv1uyjbDidk1yuh7hQlwv+AdtFnH
	 pEu/xK5abEN3M31peV+yehXvy2Q9JjjBfK96QnQaXel1vVtxyXF1M0CH60CNAPL1jOw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=infineon.com;
	dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=lLhdViWx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790944014;
	bh=pqne0tlE0J2y3Gl/qAn4v3SwYnNuUj+npIC6ClE1QJM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=chxXcR4OpXRF2xQUEHq1DXeIyrOIDHPfeukqbb6PGpJVQuNuP/KWKd8wa6nJdnR3a
	 By7OMiDK3Q4ibSlKUrgESZV4BjkchzreQPT50buKMDhuwrEGnuzv3hliYoSX7Q1NgV
	 ZDjX8DzJaH3atKBLZ+D1feuVW2G7MJ/84WfP2C85YHY4IkV2ws8IUm0T09hb/dRzFT
	 76+cM3F6uDfBnBLAzKQ8E/eMf3CR1BoGbztX2k+fAvCbAO63JHuzQitYiPaPLPzfpl
	 Pnb/pCi3T2YrFjgHElG5qogDm/+Ljcu3b9rng2NWHAS4VyqTtRSVhh4qvY46zOf2J7
	 9lX/1R9kclUNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DB7840E3C;
	Fri,  2 Oct 2026 12:26:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 824C61A6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8022E40CC4
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:04:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FTbup7srjjw for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 08:04:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DF5CB40CBC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790928292;
 b=oXgIWviO5jimiPK9guQ9S3jJnMDmGMkLJu1hV4tPSl3sFvjl7jsD8pmGIfGEBgGcgTe3
 Zoe4GM3ERPLgQpgMwhDthQaOGLLfdewBhEERinIhgb+W0Qv0RmCFJK3yeOaYDEwTxz7tJ
 3uk4JviXp4PC1ZHSJ1JOFh92TCE+JhAvcIHQtY/qJCa30MVc1sjrUfOdZtPkSxfB3QNrn
 6GeC/pM9KxVVlbYjTU7Gz2S66IuOhKCDth6kJ2555leBc3oCz9Pt5A0dzWjO9dNX+9EWf
 mlWHM9LvcLdILlj5AQJmv26O61BMJNHy2e/4zBiplE3XcscSoDVTFaJxX51J1vyP4vw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790928292;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=pqne0tlE0J2y3Gl/qAn4v3SwYnNuUj+npIC6ClE1QJM=;
 b=J6phu0QHAPD/1r4h6Mp/qG2zUMBF4psUyQz22jgk3BElvmqvUdw4GGTFg4D9d8dvaBqn
 Tx1OXFTgPXm/2EULeXAU9ZQXuJeA3C/IoyJVoIEZAMxr4A5WpehA5E3hMXbT9e0rRhupe
 UqOB1Wx30rKQCFVw5VKTbcjJ/ezlUGhNs3NWZ+3wOAJpZ5X4dRCLbG4c+XrnSqZSLdY2W
 BMX2jBGuVu0SOYiOI6E+NsnSxASPxPVsu/DhRR5jEZa5TFTo8H9/e2TTy0dKcANEyis1u
 aozO8UuS998w/s7RZ5h8dE96kr+9svVjCYc2cploh4+q+onxkX6Ba3Jl04ql1wq3mOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=infineon.com; 
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=lLhdViWx; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=lLhdViWx
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF5CB40CBC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1790928292; x=1822464292;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pqne0tlE0J2y3Gl/qAn4v3SwYnNuUj+npIC6ClE1QJM=;
 b=lLhdViWxt2Mcl0aZUb7hLJBWYlRVwe39eOXOc/TZYwHRa2tOwh7JOEj4
 Y+XLuNzC5eYvyd+DqUR1PBwbQ5GhAK7mLbsB5ZptLCq7diRGFsmmUDsHh
 hxJKJZOArn9C3bIZdPPIz2fnR1sEE9lHRHoA7ghBvK2oyPnU+HS1tDa2n o=;
X-CSE-ConnectionGUID: kq2fttDaQzGgi99/17Kx7g==
X-CSE-MsgGUID: c++eZjkDRhaY6Nrm+JsAnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="181910705"
X-IronPort-AV: E=Sophos;i="6.27,136,1787004000"; d="scan'208";a="181910705"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 10:04:50 +0200
Received: from MUCSE813.infineon.com (172.23.29.39) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 10:04:49 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE813.infineon.com
 (172.23.29.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 10:04:48 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.049; Fri, 2 Oct 2026 10:04:48 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <vjardin@free.fr>, <u-boot@lists.u-boot-project.org>
CC: <vigneshr@ti.com>, <trini@konsulko.com>
Subject: RE: [PATCH v2] mtd: spi-nor-ids: gd55lb02gf: add SPI_NOR_DUAL_READ
Thread-Topic: [PATCH v2] mtd: spi-nor-ids: gd55lb02gf: add SPI_NOR_DUAL_READ
Thread-Index: AQHdUkPlKj63W9gYhkWJIvtlWYM1CLbp5Gcg
Date: Fri, 2 Oct 2026 08:04:48 +0000
Message-ID: <37e9f670f37a48cc8c50fcafc6a9dd24@infineon.com>
References: <20261002075854.1828080-1-vjardin@free.fr>
In-Reply-To: <20261002075854.1828080-1-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

> The GD55LB02GF supports Dual Output Fast Read and Dual IO Fast Read
> according to its datasheet, but its entry only declares the single
> and quad reads.
>=20
> From the datasheet below, see:
> - section 4.1 "SPI Mode": Dual SPI cmd are 3Bh, 3Ch, BBh and BCh
> - section 8.16 "Dual Output Fast Read (3Bh/3Ch)"
> - section 8.18 "Dual I/O Fast Read (BBh/BCh)"
>=20
> Link: https://download.gigadevice.com/Datasheet/DS-01015-GD55LB02GF-Rev1.=
3.pdf
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
>=20

Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

Thanks!

