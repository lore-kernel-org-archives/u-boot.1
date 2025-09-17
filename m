Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6065CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 13:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28BC83544;
	Wed, 17 Sep 2025 15:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uZEd/H+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 953358354B; Wed, 17 Sep 2025 15:31:43 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80CE9833D0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 15:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58HDVaXs259178;
 Wed, 17 Sep 2025 08:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758115896;
 bh=DSRo7TzE3NemZ5GkWOhclw7tHdQgQHgdgjcpuat3nkk=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=uZEd/H+rTuJYgBFK0ZrfQa/NYytzpaU6jH7cI/hEm5dw0p2VjfiSs1ZFd50xfdtjH
 ptfnDROjbDtPXWNu+ualTHxWbP72Eiw0fJMwE8dx8VJ8tpjeiuvadm8vdWp4yveF9a
 cmkMvwpqExGWxw6kza3u8ScEmxskkXiQd1v/5N/Y=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58HDVaRv1354251
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 17 Sep 2025 08:31:36 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 08:31:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 08:31:36 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58HDVYvi3116359;
 Wed, 17 Sep 2025 08:31:35 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Sep 2025 19:01:34 +0530
Message-ID: <DCV42JWWU5XP.13BSXGNOYAGXE@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>,
 <bb@ti.com>, <kever.yang@rock-chips.com>, <hl@rock-chips.com>,
 <tim@feathertop.org>, <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v1 3/8] spl: mmc: split spl_mmc_do_fs_boot into
 regular/os_boot
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250916105857.163951-1-anshuld@ti.com>
 <20250916105857.163951-4-anshuld@ti.com>
 <20250916183253.GC124814@bill-the-cat>
In-Reply-To: <20250916183253.GC124814@bill-the-cat>
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

Hello Tom,

On Wed Sep 17, 2025 at 12:02 AM IST, Tom Rini wrote:
> On Tue, Sep 16, 2025 at 04:28:51PM +0530, Anshul Dalal wrote:
>
>> Currently the logic to handle falcon mode as well as the regular boot is
>> inside spl_mmc_do_fs_boot, this prevents us from cleanly extending
>> falcon mode functionality like toggleable fallback to U-Boot proper.
>>=20
>> Therefore this patch splits the logic into spl_mmc_fs_load and
>> spl_mmc_fs_load_os to handle the regular boot and falcon mode use case.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> [snip]
>> +		printf("%s, Failed to load falcon payload: %d\n", __func__,
>> +		       ret);
>> +		printf("Fallback to U-Boot\n");
>
> These are new. Do we really need to be adding them?

I think there should be some indication to the user that the intended
boot mode (falcon in this case) has failed and they are relying on a
fallback.

Perhaps we can switch to a debug instead of printf here?

Regards,
Anshul
