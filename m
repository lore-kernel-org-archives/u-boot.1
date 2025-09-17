Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AC5CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 13:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D67834E1;
	Wed, 17 Sep 2025 15:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yge3Q+Ya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683DE83544; Wed, 17 Sep 2025 15:11:09 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E4380C93
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 15:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58HDB45c1612182;
 Wed, 17 Sep 2025 08:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758114664;
 bh=oWWcXiZx0cZj6DIvGJaqDkTC3BtYc/Ktt/D53HXxB+Q=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=yge3Q+YaY08tpfIs5ZydzCIuL0KOdY8OaUvtfP5CKfmdoO+ha8h4lCD00TspOSjS4
 3j49pRPGKGQCTjWdO6sus0iQ98mupn+oLt4Bx4qNESsfDEJhGxwOAhqNulHcFKoFpX
 Zu+f0usW2NTo1mYGW8QGezM/fGIrM5qK+XDs6HQg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58HDB4R81341917
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 17 Sep 2025 08:11:04 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 08:11:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 08:11:03 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58HDB2ck3386356;
 Wed, 17 Sep 2025 08:11:03 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Sep 2025 18:41:01 +0530
Message-ID: <DCV3MTQELBJA.1LWFIXMOFBHAC@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Adriano Carvalho
 <adrianocarvalho.pt@gmail.com>
Subject: Re: [PATCH] doc: memory: Restore missing diagram
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250910154039.1942458-1-trini@konsulko.com>
In-Reply-To: <20250910154039.1942458-1-trini@konsulko.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed Sep 10, 2025 at 9:10 PM IST, Tom Rini wrote:
> From: Neha Malcom Francis <n-francis@ti.com>
>
> When applying the patch that became commit a2d881f5bcd3 ("doc: memory:
> Add documentation for system RAM") one of the diagrams was missed.
> Re-add this missing file.
>
> Reported-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> Fixes: a2d881f5bcd3 doc: memory: Add documentation for system RAM
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> [trini: Take Neha's original svg and re-apply it]
> Signed-off-by: Tom Rini <trini@konsulko.com>

Are we sure a2d881f5bcd3, is the correct SHA for the commit? On my local
tree as well as github[1] it is 284ef1bbcefc.

[1]: https://github.com/u-boot/u-boot/commit/284ef1bbcefcf3180592ed48f522c7=
9618099bd6

Regards,
Anshul
