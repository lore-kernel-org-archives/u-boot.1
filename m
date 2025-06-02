Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FDBC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 18:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55EF811AC;
	Mon,  2 Jun 2025 20:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f9/mra54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A1081D6A; Mon,  2 Jun 2025 20:43:15 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51C1980584
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 20:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552IhA0H3300783;
 Mon, 2 Jun 2025 13:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748889790;
 bh=kcQ9du/l3twAnmaAvJbQmCrV+qsTnrPJVheQMKnVMvY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=f9/mra54CTPtc6EpdhScBH/XkVsc0uyXthYQr8oYjU8tRLPs2VCRaN+CdvxlmYSAn
 zL7Wd1YLk94CwV6F7cBnFe4QYxI4Ni7x0B1TGt5yQHIhPahmV2Jwbv6fWjeAGaWdI1
 2AaCgA3OFx5jcK4suT7adp69BrqIo+TPboj+kt3g=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552IhAEZ788996
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 2 Jun 2025 13:43:10 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 13:43:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 13:43:10 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552IhAxa3461673;
 Mon, 2 Jun 2025 13:43:10 -0500
Date: Mon, 2 Jun 2025 13:43:10 -0500
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH tiU2025.01 1/2] binman: openssl: remove unused encryption
 extension
Message-ID: <20250602184310.tklzlberdzgb7ovo@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250602-am62xsip-v1-0-ae8aa62b4b6e@ti.com>
 <20250602-am62xsip-v1-1-ae8aa62b4b6e@ti.com>
 <4b3e2d64-c2ed-4837-b89d-bbafea3dd034@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <4b3e2d64-c2ed-4837-b89d-bbafea3dd034@ti.com>
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

On June  2, 2025 thus sayeth Andrew Davis:
> On 6/2/25 11:56 AM, Bryan Brattlof wrote:
> > We currently do not have a way for binman to encrypt any component it
> > packages. Remove this to avoid any confusion.
> > 
> 
> From the subject tag, was this meant to be sent to our internal list for
> inclusion in our evil vendor tree only? I think these patches would apply
> upstream too so just checking.
> 

Oops. I have no idea how I got my scripting to do this but yeah I 
intended this to go externally before we back-ported it internally.

> For this patch, what is missing now to get binman to start encrypting
> these components? I'm thinking it wouldn't take that much extra and
> so leaving the comments here would be good to remind us of what we
> still need to do.
>

Ah OK. I haven't looked into how this could work but while I'm here I 
can take a look :)

~Bryan
