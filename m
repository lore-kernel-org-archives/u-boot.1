Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DC606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 04:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NDCmeUwL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=QmRLjhW+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2962881163;
	Wed, 21 Oct 2026 04:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tsdb4oXibmsh; Wed, 21 Oct 2026 04:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DDDF081158
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792555708;
	b=C2M3mq78Ai0BdCqlRpEt1HKbGn1gYrgKDHFWC0JS/1zZjQ0L5opqE6biqoBWNio8luHN
	 +GarYa+EuEmDc1OGHxmuVLVhKJqyurahiuel0LM9DfAZYGYWPIlFiDWTCsSXdk5yRnpkz
	 zV/GqaNVHdwgk7e/+QyL9hYjFbkUo3KbLE64zO7xr0D0O1CVL/MjaGIuENjE3llvQJ+QW
	 Sy6SydlN1mpK8EOX5empbixG5/uEXsLXEqav/Z8NZH2c+gUbYvpHItgum0nIfRLAZagy8
	 Am7mdLTUhHdhHplzfrW0N4DiQWzX/esV73miCS7YEDw/DCQwVstWHq2gXiuy5KI8EcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792555708;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dohg3Xxl9TnmadJyTzqmwY7M43rjTWN8TkX6BkxjgLc=;
	b=QCPpdJqtZmNoTQhHhb7yL1hgB2xp8hvsAeT0LxggMuFgVJe2db1mzDf/a7h6lYI7PXHA
	 9paOFvjvdI/wGNqqThMTj+2dGjJVs4+b/FDhQMgQn3GU9hEZqXNIeIyvrj746xToDViuy
	 XXzjkahCf/sOfCoY/aIhF2fIKaPIKPeYOeN8Lp5rvBAx936U87UX4uBPxjGPSKJ1s9TmL
	 LBnrvOakai8ineWSTB8+IUov0oDBBpWYFqPnlP+nZM32tEoBko8dgLOb7lQVLvAyyzUCu
	 gRcO7isKD+q3tqckDyNshwKTRF4zjFED9g+9tKT5nFotHL0ViQ59eaRxLDe8WQRsPNg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792555708;
	bh=dohg3Xxl9TnmadJyTzqmwY7M43rjTWN8TkX6BkxjgLc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDCmeUwL5GEWTlY0nf/SoNgajRrnVBQvzPNvhLWJ7yyjfZ4Y1slmHXBOJE0ytHM4D
	 Qt7t+Axsh51YPbyvvhDrY4jyZK4FWveOKDfT0DS84GMzj+yAUqRi7I0cyCrDsuMLup
	 VBL8nivh7PbyASKROMf78VW2VqEmj0PX0zQ2LjGZVKkGhZtnYQsyHXFOdsRFW0V9DZ
	 MuoYviE9Ie/xBng3+0rML4EqxRaf5bllu65XnNVZGcnbJ+vkV/wWgeNTPtgED+sZox
	 ZfP4u+7JljJQ8+ehcKvPB5v5HF+04dsjXWqlczROq7z+GMA6BpQX8+TyM2sCbLBtVa
	 /OrwUgqr61Tqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDDF081158;
	Wed, 21 Oct 2026 04:08:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7306D1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 01:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 594BA6074D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 01:42:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dCdTYQXhSGke for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 01:42:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D4F8360749
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792546925;
 b=X4Y35Z9z8dhXARCuSrb3i/wyTNaUla0d36/C1NxxuZPdAFkSjx14joy1zlMJ2l86e9vp
 brV/q6C3hX1o9KvybGGq1VneZB6GuYFmbpEA0JTZ6ZgdoblbINuCFsFbXYvkDm28OCo1w
 4eFhgQm2Kde3lSqT/3J7NhotXd26RbZ3z+9mSRQQsX8X/LpkOmq9idZMzlJ4wqiVNiT5V
 ngpB7zhOeZgmSD7d1ptPCPXq+K8EOAUNJcjsVzc6jKndDO/HU2fCJNAeG0Y56NweJbpQQ
 SY+SrdKi0ZeivAdjr+IsCzHV/893Q/q8Y2NEKmUtixAyYR/dYj0X2luPQ2UKzztR09g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792546925;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=dohg3Xxl9TnmadJyTzqmwY7M43rjTWN8TkX6BkxjgLc=;
 b=HBqHzJc2xnScUeeoHwSF2GXiQ0i4WucCY4oDnra4HbYWnOHsNDVoPBL/+JPQTZ5stnJJ
 FAN7NuJ35ehostAV2uujsXnN8z6591Cx6RSQiXdpbsJWzBN6ZuWa6frVS1pvcS2MJbaxA
 Y+OZRF6up1N+puf5YsqixC2mzFQkTP+tN8escu4Kt3MiTD5LQbfL6NaqfC/nPgA7PEB5j
 QJKVvJYoKtn+Ssy7kCNZQXGYoyPrRHqusk6RJGRMJWdHLMdPwWNndnFfNLHrAxyMwdTF4
 2/eYY6LQEWpAkgM5WLUkA9kTpXnCN5fzTJRKQurkJiuSauv6NUlemb8mtW2mtlg/H5g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=infineon.com;
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=QmRLjhW+; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=QmRLjhW+
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4F8360749
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 01:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1792546925; x=1824082925;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lxXfv+6VCknDX0l+k571w1KhCt27xivp+bcbdclqXMA=;
 b=QmRLjhW+j0qITflq8K+kjpcUxUY2ou7dl8B0XsZVfjgn/eb9QEdXO63X
 iwHRH4USSWjGDGI/jot8bCXDVfsBMagfCRn3eLh6yToFTYxkF9l4xJlLT
 L0Z0O9ez5ETRHQ62S1H6EELOR70K3l0Ze4w31szgs3l6LpkhkuC0Jb60i s=;
X-CSE-ConnectionGUID: ZL5qDBZxRg+V7tpO0vLA+w==
X-CSE-MsgGUID: cfh9Mho8TkSLKL4JBxjJsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="184906516"
X-IronPort-AV: E=Sophos;i="6.27,169,1787004000"; d="scan'208";a="184906516"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:42:01 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 03:42:00 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.053; Wed, 21 Oct 2026 03:42:00 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, <vigneshr@ti.com>,
 <raymond.mao@riscstar.com>, <vjardin@free.fr>, <festevam@nabladev.com>,
 <ehristev@kernel.org>
Subject: RE: [PATCH v3 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Thread-Topic: [PATCH v3 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Thread-Index: AQHdXQ/YDM7Zopx7P0qcltYEI3YLibcAXC8AgAbgizA=
Date: Wed, 21 Oct 2026 01:42:00 +0000
Message-ID: <b879d1b7c63242c6aa28599bc6b6e59c@infineon.com>
References: <20261016-split-sfdp-id-v3-v3-0-4a47b8fc945a@infineon.com>
 <20261016182654.GA4035800@bill-the-cat>
In-Reply-To: <20261016182654.GA4035800@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 21 Oct 2026 04:08:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

> On Fri, Oct 16, 2026 at 10:43:41AM +0900, Takahiro Kuwano wrote:
>=20
> > The spi-nor-core.c contains optional logics like SFDP and manufcaturer
> > specific fixups. The spi-nor-ids.c has single large ID database. There
> > are many #ifdef directives in those files and that negatively affects
> > readability and maintainability.
> >
> > This series, as the first step of cleanup, move SFDP logic, IDs, and
> > fixups to newly source files. Reworking, renaming, and reformating
> > existing code is not a scope of this series and further cleanup will be
> > taken place in follow-up patches.
> >
> > Here is the code size impact when applying this series.
> > Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
> > manufcaturers are enabled.
> >
> > SPI-NOR:
> >             text    data     bss     dec     hex filename
> > BEFORE    720685   14084       0  734769   b3631 u-boot
> > AFTER     721827   14156       0  735983   b3aef u-boot
> > DELTA      +1142     +72
> >
> > TINY:
> >             text    data     bss     dec     hex filename
> > BEFORE     77399    3128     248   80775   13b87 spl/u-boot-spl
> > AFTER      77589    3200     248   81037   13c8d spl/u-boot-spl
> > DELTA       +190     +72
>=20
> So this leads to imx28_btt3 and imx28_xea overflowing in CI on link.

I don't see any errors in my local. Something different from CI config.

imx28_btt3_defconfig:
          text	   data	    bss	    dec	    hex	filename
BEFORE  37947	   2896	      0	  40843	   9f8b	spl/u-boot-spl
AFTER   38003	   2912	      0	  40915	   9fd3	spl/u-boot-spl
           +56       +16

imx28_xea_defconfig:
            text	   data	    bss	    dec	    hex	filename
BEFORE    38004	   2816	      0	  40820	   9f74	spl/u-boot-spl
AFTER     38060	   2832	      0	  40892	   9fbc	spl/u-boot-spl
             +56     +16

Could you share the exact CI error or size report?

> Maybe it needs the tiny flag set? I think the rest of the growth is
> reasonable enough, and boards can disable part vendors they don't need.

SPI_FLASH_TINY is set by default in SPL build and I confirmed
spi-nor-tiny.o in both builds.

>=20
> --
> Tom

Thanks,
Takahiro

