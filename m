Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B63CFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 06:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61DA83DF2;
	Tue,  2 Dec 2025 07:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="KYI2uumP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7AE783DFA; Tue,  2 Dec 2025 07:57:26 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F7283DE0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 07:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20251202065713epoutp0326f1e7492077d265db6a5aa6d09289c8~9U61yLSgn2053820538epoutp03K
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 06:57:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20251202065713epoutp0326f1e7492077d265db6a5aa6d09289c8~9U61yLSgn2053820538epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1764658633;
 bh=YJUoWr9RU5MFB8jrV7Pm6/ho/gVbl4fpBi92XT1IuLI=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=KYI2uumPUipka2+WRUXrTyBwSW1NYIUy+7OPieOfGCupv9PG+hq2Kwgyh20ot9g1w
 coSqZPvxSsViXuZKPRQJTgWPEDzWNTTdpl+gw1+Li+Yox8ykENqiOCKSuDpaFQ0SrL
 6AS2rX2bSVSIKipG+W19mLJu7XYJ9cNabpHoqKE4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
 20251202065712epcas1p460be7096daeec6ed2ebdbd03fa0ba705~9U61ZuRT02471124711epcas1p4V;
 Tue,  2 Dec 2025 06:57:12 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.195]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4dLBQw3xhZz6B9mL; Tue,  2 Dec
 2025 06:57:12 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20251202065712epcas1p4fa789417b72b24396e63fd8b38b7955b~9U60jurXT2715527155epcas1p4e;
 Tue,  2 Dec 2025 06:57:12 +0000 (GMT)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20251202065712epsmtip25e628ec245944c81a633c0b362e92cb2~9U60fMCwA1620216202epsmtip24;
 Tue,  2 Dec 2025 06:57:12 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: "'Kaustabh Chakraborty'" <kauschluss@disroot.org>, <u-boot@lists.denx.de>
Cc: "'Tom Rini'" <trini@konsulko.com>, "'Peter	Robinson'"
 <pbrobinson@gmail.com>, "'Henrik Grimler'" <henrik@grimler.se>, "'Quentin
 Schulz'" <quentin.schulz@cherry.de>, "'Svyatoslav Ryhel'"
 <clamor95@gmail.com>, "'Ion Agorria'" <ion@agorria.com>
In-Reply-To: <20251024-board-exynos-mobile-v2-0-e6fce69e60c3@disroot.org>
Subject: RE: [PATCH v2 0/3] Support for a generic platform for all Exynos
 mobile devices
Date: Tue, 2 Dec 2025 15:57:11 +0900
Message-ID: <0cdc01dc6358$e254c370$a6fe4a50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLWBy80qpCmhUkFvwBKiEuwYLcqvAH06h/yswr4zJA=
Content-Language: ko
X-CMS-MailID: 20251202065712epcas1p4fa789417b72b24396e63fd8b38b7955b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251024172902epcas1p27865e3270256e1b24beb6e1f27798351
References: <CGME20251024172902epcas1p27865e3270256e1b24beb6e1f27798351@epcas1p2.samsung.com>
 <20251024-board-exynos-mobile-v2-0-e6fce69e60c3@disroot.org>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

> Kaustabh Chakraborty (3):
>       board: samsung: add support for Samsung Exynos mobile device boards
>       board: samsung: exynos-mobile: add exynos7870 support and three dev=
ices
>       doc: samsung: exynos-mobile: add documentation for exynos7870
>
>  arch/arm/mach-exynos/Kconfig                       =7C  11 +-
>  board/samsung/exynos-mobile/Kconfig                =7C  18 +
>  board/samsung/exynos-mobile/MAINTAINERS            =7C   6 +
>  board/samsung/exynos-mobile/Makefile               =7C   5 +
>  .../samsung/exynos-mobile/debug-exynos7870.config  =7C   7 +
>  board/samsung/exynos-mobile/exynos-mobile.c        =7C 403 +++++++++++++=
++++++++
>  board/samsung/exynos-mobile/exynos-mobile.env      =7C  18 +
>  configs/exynos-mobile_defconfig                    =7C  72 ++++
>  doc/board/samsung/exynos-mobile.rst                =7C  45 +++
>  doc/board/samsung/exynos-mobile/exynos7870.rst     =7C  85 +++++
>  doc/board/samsung/index.rst                        =7C   1 +
>  include/configs/exynos-mobile.h                    =7C  14 +
>  12 files changed, 684 insertions(+), 1 deletion(-)
> ---
> base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
> change-id: 20251017-board-exynos-mobile-7c7d43832693
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss=40disroot.org>

Applied to u-boot-samsung.

Thanks,
Minkyu Kang.

