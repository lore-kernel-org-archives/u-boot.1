Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F75C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7E6B8319A;
	Wed, 16 Jul 2025 09:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XplX2dtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E2C831BE; Wed, 16 Jul 2025 09:41:13 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B718313B
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56G7f5nS2798706;
 Wed, 16 Jul 2025 02:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752651665;
 bh=tFtR5Coi+Z1I+B+j5VkJBqKwK7+22TFe2BgR+8fyhQs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=XplX2dtPLKXa6oK31u4jGhNsbmVJl14q/TWCxnXBsL93NsRnuRYi12xjmhRf6bHfc
 us7BX+qoGQevwv4WTiog/tfUPdzWmSCR9V9+ZWi/7kuFtr9K0nB5lIfzLDP5vL2pyv
 4YISY5eoY2EKF4qpy0WTYewmMjZ3290QbilWaKHo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56G7f5rG3376901
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 16 Jul 2025 02:41:05 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 02:41:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 02:41:04 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56G7f1io3955391;
 Wed, 16 Jul 2025 02:41:02 -0500
Message-ID: <c6d624d5-76c5-4a64-b4a4-db6e6428df30@ti.com>
Date: Wed, 16 Jul 2025 13:11:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "spi: cadence_qspi: Fix odd byte write issue in
 STIG mode"
To: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>, <michal.simek@amd.com>
CC: <u-boot@lists.denx.de>, <venkatesh.abbarapu@amd.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
References: <20250716070407.2082524-1-p-mantena@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250716070407.2082524-1-p-mantena@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Hi Prasanth

On 16/07/25 12:34, Prasanth Babu Mantena wrote:
> The buffer that is being used to write into the flash needs
> to be handled properly with padding of 0xFF. The place that
> this is done can be at a more generic place like spi-nor core.
> 
> This reverts commit cd9123507003e07b13e61d72e14e493bb338e827.
> 
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>  drivers/spi/cadence_qspi_apb.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index 6f89d3add5d..4696c09f754 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -558,9 +558,6 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
>  	void *reg_base = priv->regbase;
>  	u8 opcode;
>  
> -	if (priv->dtr)
> -		txlen += txlen & 1;
> -
>  	if (priv->dtr)
>  		opcode = op->cmd.opcode >> 8;
>  	else

After reading [0], makes sense.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

[0]
https://lore.kernel.org/u-boot/174963a1-bf6e-4e54-9946-bf3c42a72960@amd.com/

-- 
Thanking You
Neha Malcom Francis
