Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61738C61DB2
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 07:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C10A682B00;
	Mon,  9 Jun 2025 09:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WcRQkouv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E3D82B00; Mon,  9 Jun 2025 09:36:15 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C832182958
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 09:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5597aBlW708988;
 Mon, 9 Jun 2025 02:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749454571;
 bh=CndZKycFPu7yQ99ouTLtX9KYXKS7l65N1/o9MmgGzl4=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=WcRQkouv7CCtX9Xm26ag/ec+xRFqTFBbE8/vV81j8KPiYrjj4zs87ECzwp1Eo9We1
 NCghOuwYCOGh3fMGTeizu3jn/BS9AKMSxdmLAdKr9Vi9wtKBcmpfLSGKE7XlG2XvjM
 5/DceYz+jUXTaqiCeiSWVi41S8D3R9r713BkuUV4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5597aBXU4101263
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 02:36:11 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 02:36:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 02:36:11 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5597aAtF1046574;
 Mon, 9 Jun 2025 02:36:11 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 9 Jun 2025 13:05:36 +0530
Message-ID: <DAHTVJ8QOH6P.1VUE8A6ES0CRJ@ti.com>
Subject: Re: [PATCH v7 07/10] board: ti: add default dtb for am62 in falcon
 mode
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>,
 <bb@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-8-anshuld@ti.com>
 <20250606190956.GA1382132@bill-the-cat>
In-Reply-To: <20250606190956.GA1382132@bill-the-cat>
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

On Sat Jun 7, 2025 at 12:39 AM IST, Tom Rini wrote:
> On Tue, Jun 03, 2025 at 07:54:47PM +0530, Anshul Dalal wrote:
>
>> The SPL_FS_LOAD_ARGS_NAME config is used for the arguments to the kernel
>> (dtb in our case) in falcon boot.
>>=20
>> Setting it in board specific Kconfig allows us to reuse the same config
>> fragment 'am62x_r5_falcon.config' for all 3 platforms for enabling
>> falcon boot.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  board/ti/am62ax/Kconfig | 3 +++
>>  board/ti/am62px/Kconfig | 3 +++
>>  board/ti/am62x/Kconfig  | 3 +++
>>  3 files changed, 9 insertions(+)
>
> Why can't whatever is using the fragment also set this? Is it because
> you're only using this as part of say:
> make am62ax_evm_r5_defconfig am62x_falcon.config
> ?

Correct, having three different config fragments with only changes to the
dtb path doesn't seem very useful imo.
