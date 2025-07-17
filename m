Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504F7C83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 18:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A378C83448;
	Thu, 17 Jul 2025 20:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U4A4hJEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D6A83457; Thu, 17 Jul 2025 20:33:30 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30EE833ED
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 20:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56HIXQWi071106;
 Thu, 17 Jul 2025 13:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752777206;
 bh=I7hHZD+WV8G36OkXM5xmP2fom40Lj+BL7ixw6I03z9M=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=U4A4hJEiTfTfSjS6Me6QQTyiHG/BxKsNxS6++EBXDXgW665SQm4qMnIEEfLWKKJ4s
 fhv8c4uDdrNdn10VI/DZmawN1jigeNkK7CaDkCeg5D97tZhx6LNscv6A+BsGAsMBqH
 ls31nyCAG2ic3ob8DpJd4KMslBlRcu+es4xJlUnk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56HIXQVG419654
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 17 Jul 2025 13:33:26 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 17
 Jul 2025 13:33:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 17 Jul 2025 13:33:26 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56HIXPcs2611319;
 Thu, 17 Jul 2025 13:33:26 -0500
Date: Thu, 17 Jul 2025 13:33:25 -0500
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Garrett Giordano
 <ggiordano@phytec.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: dts: k3: use SPL_TEXT_BASE for R5 SPL load address
Message-ID: <20250717183325.q3fkmitiml4huvzl@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250717-dt-cleanup-v1-1-a911b0bb832b@ti.com>
 <3d30853a-59eb-4907-8810-9daf49209eb6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <3d30853a-59eb-4907-8810-9daf49209eb6@ti.com>
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

On July 17, 2025 thus sayeth Andrew Davis:
> On 7/17/25 7:13 AM, Bryan Brattlof wrote:
> > The load address for the R5's SPL is defined in Kconfig by
> > SPL_TEXT_BASE. Rather than hard coding the load address which could
> > lead to hard to debug issues if this value is changed, just use the
> > SPL_TEXT_BASE value.
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> 
> Seems resonable, but looks like you missed the same in J784s4 and
> J721s2, otherwise,

Oops you're right. I'll add those

> 
> Reviewed-by: Andrew Davis <afd@ti.com>

Thanks for the review
~Bryan
