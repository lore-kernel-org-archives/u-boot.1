Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE8AC8303F
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 10:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1C68328F;
	Thu, 28 Aug 2025 12:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D1g/Wcue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 118E5832C8; Thu, 28 Aug 2025 12:42:43 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 566CE8323A
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 12:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57SAgb041505901;
 Thu, 28 Aug 2025 05:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756377757;
 bh=foeuC6Veu7trRy/9COshubCEycJHbXQzS80yWb+v5oc=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=D1g/WcuekHsTjc4bv7AK+q+Xe4yLlRm4FcY6YZraomXiS9MZKlOrerWi3DWNJYD8O
 APUNTae37blsjHm0SwMQeHry/SN5kwAarVbtw3Ge1WNPJipVYyYDmrXrmtq3Pmk7wd
 r8CsDxJhSq0fax2yqTh9WYVZRQuhscox2ihk6f6M=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57SAgbsC3405874
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 28 Aug 2025 05:42:37 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 05:42:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 05:42:36 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57SAgZRY206481;
 Thu, 28 Aug 2025 05:42:36 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Aug 2025 16:11:21 +0530
Message-ID: <DCDZXBPHC0F2.1ZW2GO55LT7X9@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>
Subject: Re: [PATCH v1 1/2] dma: ti: k3-udma: fix dma_addr_t typecasts
From: Anshul Dalal <anshuld@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250825133233.2475300-1-anshuld@ti.com>
 <20250825133233.2475300-2-anshuld@ti.com>
 <a20eaf48-6ff9-4b83-bd10-a8a99c9ace14@ti.com>
In-Reply-To: <a20eaf48-6ff9-4b83-bd10-a8a99c9ace14@ti.com>
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

On Thu Aug 28, 2025 at 2:20 PM IST, Udit Kumar wrote:
>
> On 8/25/2025 7:02 PM, Anshul Dalal wrote:
>> With the change to dma_addr_t from u32 to u64 for the R5 SPL, the
>> existing typecasts from void* to int or vice-versa cause the compiler to
>> throw a "cast from pointer to integer of different size".
>
> is this some compiler specific ?. Please mention that
>
> I don't see this warning=20
> https://gist.github.com/uditkumarti/1c4238a7101d97cdc57b7a40d10147d2
>
> I am on=C2=A0 gcc version 11.3.1 20220712 (Arm GNU Toolchain 11.3.Rel1)
>

Sorry for the confusing language in the commit description, this was a
preventative fix, it fixes the warnings that would've been emitted if
you had applied the second patch of the series by itself.

GCC 11 would still emit the warning if you apply only the second patch.

Regards,
Anshul
