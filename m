Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46B6C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 09:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC9B482FB8;
	Thu, 17 Apr 2025 11:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N0RGGqs3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F7282FC7; Thu, 17 Apr 2025 11:22:21 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5D882F8C
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53H9MF1o2925293
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 04:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744881735;
 bh=URnjArUDQ/7DSzlRqkBnq9HHJ74bVx+KAvoJ/Z7NwqQ=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=N0RGGqs35AA2w8pUl/4K+DoZyDumXRbIOsjoPsbd+HmivKHUqbWfNWMqX+Namgfqi
 iMoFG+b3KPKpjx2b9LdjDjWqzncvXiEG2wDOPu8/jvSNC0njr0AYLd3dDh6gEAMQdD
 ddYnagjfuV7jzom1NtuPTQ5K7XSNszH1+RljdYxg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53H9MFnS075635
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Apr 2025 04:22:15 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 04:22:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 04:22:14 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53H9MEwk086314;
 Thu, 17 Apr 2025 04:22:14 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Apr 2025 14:51:59 +0530
Message-ID: <D98SY3X7C15U.15HUGCO6FK1T0@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>
Subject: Re: [PATCH v1 0/4] k3: migrate SPL_TEXT_BASE to new address
From: Anshul Dalal <anshuld@ti.com>
To: Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250416073058.1441001-1-anshuld@ti.com>
 <20250416112418.nod2fut4v77qlmfq@hummus>
 <D983ZXCIAF06.2I0POMKUFPF2L@ti.com>
 <20250416150506.ws22odswwkjn2wth@deflected>
 <8146a036-681d-4c45-9285-c58259fec14b@ti.com>
 <20250416195113.mtfdclfvb756vpll@scoreless>
In-Reply-To: <20250416195113.mtfdclfvb756vpll@scoreless>
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

On Thu Apr 17, 2025 at 1:21 AM IST, Nishanth Menon wrote:
> On 11:38-20250416, Andrew Davis wrote:
>> > > > 	How about u-boot documentation?
>> > >=20
>> > > I will update that in the next revision along with any feedback I
>> > > receive on this patch.
>> >=20
>> > IMHO, This change is too intrusive and impacts downstream customers
>> > including inflight production devices.
>> >=20
>>=20
>> Could you elaborate a little?
>>=20
>> They do not even need to update their TF-A version, if they want to
>> use their current version they simply recompile it with a single
>> extra build flag:
>>=20
>> PRELOADED_BL33_BASE=3D0x822000000
>
> For folks who are trying to boot linux from TFA, they could do the same.

This change would allow us to support both standard boot flow and falcon
mode from the same upstream source. With the only downside being the
slight overhead added by the jump-stub (~1.7KiB added to tispl.bin and
two extra instructions to jump to u-boot from older ATF builds).

And we can remove the stub altogether once all the customers have
migrated over to the new address.

In addition to that this also frees up the bottom of DDR which allows us
to more easily support low memory systems (512MiB or less) as we can use
the freed up space for more tightly packing OP-TEE, DM etc.  instead of
having the binaries loaded at scattered addresses like we do now.

>>=20
>> They should have no reason not to be able to do this. But even *if*
>> they cannot do that, the whole point of the jump-stub here is to
>> save them even having to do a simple compile.
>>=20
>> IMHO "downstream customers including inflight production devices"
>> should not be a reason to block good and useful changes here in
>> upstream. But again, this change doesn't break anything for them in
>> the first place, so why bring that up?
>
> I dont see a specific value here. U-boot just works. For folks who want
> direct TFA to kernel jump (which is a niche fast boot usecase), go ahead
> and use TFA with the mentioned build option.

