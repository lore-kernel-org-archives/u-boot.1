Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441B8E7544E
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 11:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7804F871B0;
	Tue,  3 Oct 2023 13:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cKaCGSLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 105FD871E1; Tue,  3 Oct 2023 13:24:57 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 214BA8719F
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 13:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393BOrXZ064525;
 Tue, 3 Oct 2023 06:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696332293;
 bh=4ok4sQSof1RTlClOgAcfzhAI+DhemBHACwnuELfT9r4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=cKaCGSLw2x3TUJMV31CfEdoFqVJakrkVgwUAJ5cnAn/q9vOJBkfabzyFS9A8b91ac
 1zErMZUtluZQz5L2k6hEn+oBS3U/pqWwx9Y22soySr8+pAa35Jmv2kUTcodFiGJ8Az
 45sPu/jhDyOVcqOYNqjZXSP2DDzXAMEm54djOr7w=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393BOrrb012515
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 06:24:53 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 06:24:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 06:24:53 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393BOqjE005624;
 Tue, 3 Oct 2023 06:24:52 -0500
Date: Tue, 3 Oct 2023 06:24:52 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/4] arm: dts: Add support for AM62x LP SK
Message-ID: <20231003112452.pwyvalz62ft4frgl@rockslide>
References: <20230927082105.3729470-1-n-yadav@ti.com>
 <20230927082105.3729470-3-n-yadav@ti.com>
 <20230927115231.i3kg3wvpvqmmexnd@dazzling>
 <d51d4e84-71b8-1282-0007-7b5f1061e012@ti.com>
 <20230928143015.gzofmiqtjyh2ls57@darkening>
 <ba65c9e4-b280-c715-1467-56fbcbbec70b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ba65c9e4-b280-c715-1467-56fbcbbec70b@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 16:11-20231003, Nitin Yadav wrote:
[...]

> >>>
> >>> NAK. should come from board.dts.
> >>
> >> am62sip support is also in the queue where we have only 512M of RAM.
> >> That's why I'm adding this node in r5-sk.dts
> > 
> > NAK.
> > 
> > Do this cleanup in the context of the new platform addition - when you
> > get it in the kernel first.
> 
> I haven't planned to have a kernel dt for am62sip as there is only
> difference is DDR size which will be taken care by U-boot.

We can cross that bridge when we get to it - but overall, that sounds
Assumption is wrong.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
