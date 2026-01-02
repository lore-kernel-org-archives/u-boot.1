Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2F6EEB57B
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 01:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C3883CDC;
	Fri,  2 Jan 2026 02:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Xf2BIRkh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BFD483D1A; Fri,  2 Jan 2026 02:02:59 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB43283C6E
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 02:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=manjae.cho@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260102010239epoutp0478e445ebf798293603a2c7c834b20613~GxFHPt82q1819518195epoutp04J
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 01:02:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260102010239epoutp0478e445ebf798293603a2c7c834b20613~GxFHPt82q1819518195epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1767315759;
 bh=4F53XJyVEmt+DRJTdkjJkIAboxG/bwyzczgl0MPCGuQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xf2BIRkhVxEXioDEvZMJAlofrszFlHOKTo0FZQnc5i+MZZrYkC8VifyBAgLtw5SY/
 k0yr/C8N4JK48JvY/+1Tlk1EZPhHTAx6Q81C5vFfNl8wv4fJnLg0gBNPphHSh4tF16
 Kht3fmmiO8jwHydZLLjgSjz7tbYdDYY6O3pJ4eIg=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
 20260102010239epcas1p2c3e10d95f6290af5efc54e7e067ae7ba~GxFHAz37y2189021890epcas1p21;
 Fri,  2 Jan 2026 01:02:39 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.116]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4dj55V6pRPz6B9m9; Fri,  2 Jan
 2026 01:02:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20260102010238epcas1p467cd3ce7ad8d03eaf35e25563da1d8c3~GxFGYEOr_1916919169epcas1p4Y;
 Fri,  2 Jan 2026 01:02:38 +0000 (GMT)
Received: from manjaecho-VirtualBox.. (unknown [10.89.15.251]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260102010238epsmtip2eefaff7accddf194d944c2ace068cb0f~GxFGVnd2I0323903239epsmtip2C;
 Fri,  2 Jan 2026 01:02:38 +0000 (GMT)
From: Manjae Cho <manjae.cho@samsung.com>
To: xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de, trini@konsulko.com, sujin.u@mobis.com, Manjae Cho
 <manjae.cho@samsung.com>
Subject: Re: [PATCH v2 2/2] doc: emulation: Add network testing documentation
Date: Fri,  2 Jan 2026 10:02:36 +0900
Message-ID: <20260102010236.39626-1-manjae.cho@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230154529.29724-3-manjae.cho@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260102010238epcas1p467cd3ce7ad8d03eaf35e25563da1d8c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260102010238epcas1p467cd3ce7ad8d03eaf35e25563da1d8c3
References: <CGME20260102010238epcas1p467cd3ce7ad8d03eaf35e25563da1d8c3@epcas1p4.samsung.com>
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

Hi Heinrich,

Thanks for the pointer - I hadn't seen your patch before sending v2.
Your version covers much more ground (tap/tun, multiple device types, etc.),
so I'll drop the networking part from my series.

I'll send just the typo fix as a standalone patch instead.

Best regards,
Manjae Cho
