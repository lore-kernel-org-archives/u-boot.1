Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CD8C3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 06:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AD418070C;
	Fri,  2 May 2025 08:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NYPJpRXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A5580F03; Fri,  2 May 2025 08:01:37 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A7B803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 08:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54261R2i3793340
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 May 2025 01:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746165687;
 bh=T2waUKDgg1RSCCtMPmGiyR5R9MJAuLqBg6GGCxnf/Nw=;
 h=Date:To:CC:Subject:From:References:In-Reply-To;
 b=NYPJpRXrCipHwXex6DydkYcYLxMN8NjGTejMC9+oYemyzvmQ3QkC0ONPwcxuHiVF6
 VQgohkYGzVJwDO9uCbCHWRy4g1r1FqKV+NMFtJv+C9ve7aDPVEouZqfR1MrR20deIo
 d8BXJH+0P2TlgNY5THy0U8jZ8QaP0AHq1HDrXo+k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54261RYV092399
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 2 May 2025 01:01:27 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 May 2025 01:01:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 May 2025 01:01:26 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54261QPI092542;
 Fri, 2 May 2025 01:01:26 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 2 May 2025 11:31:08 +0530
Message-ID: <D9LG2HPVE6T0.UJAVOT8OLUO4@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, =?utf-8?q?Adriano_C=C3=B3rdova?=
 <adrianox@gmail.com>, Adriano Cordova <adriano.cordova@canonical.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: Pull request efi-2025-07-rc2
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <62949207-e59c-482b-b629-94a0e61c454d@gmx.de>
In-Reply-To: <62949207-e59c-482b-b629-94a0e61c454d@gmx.de>
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

On Thu May 1, 2025 at 9:46 PM IST, Heinrich Schuchardt wrote:
> Dear Tom,
>
> This pull request fixes the "installing EFI_LOAD_FILE2_PROTOCOL failed"=
=20
> issue.
>
> ---
>
> @Anshul,
>
> I had to rebase your series because one line which you tried to change=20
> from ..code-block:: to ..prompt:: did not exist. Please, check after the=
=20
> merge.
>
[snip]

Looks good to me, the removed line was due to a8baac546fd9 ("doc: board:
ti: Add optee rng support"). I hadn't pulled any changes recently so I
was working off an outdated tree.

Regards,
Anshul
