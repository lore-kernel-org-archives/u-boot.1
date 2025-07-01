Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EB3C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 15:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC9683053;
	Tue,  1 Jul 2025 17:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JImUX2oM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D9083018; Tue,  1 Jul 2025 16:52:11 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA83482FAB
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 16:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 561Eq49o2942351;
 Tue, 1 Jul 2025 09:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751381524;
 bh=lUqiLBESdH1h0dQkpP8oA3Er1sG8y6IvK4fToi9Ewsk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=JImUX2oMs+qkQev6zwlIZqOYoADuIxv7LSv5+6OHgKD5g/XT8Jl/JvextpoczkG7p
 KE/Vi/qVtWfdpH9TUzup7ZHVBXuBtntaaxtswCmpAl93WSE5KzS73e4XfFCGdR+8F2
 QQMs+rFNPeQwk2c7pVDdBZGuRKSl2buCGxsYTBGs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 561Eq4UZ318878
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 1 Jul 2025 09:52:04 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 1
 Jul 2025 09:52:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 1 Jul 2025 09:52:04 -0500
Received: from [172.24.227.249]
 (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 561Eq0j21471131;
 Tue, 1 Jul 2025 09:52:00 -0500
Message-ID: <d0b03213-01e5-4d78-831f-379c87d08a3f@ti.com>
Date: Tue, 1 Jul 2025 20:21:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/22] firmware: ti_sci: Add
 TI_SCI_MSG_MIN_CONTEXT_RESTORE
To: Markus Schneider-Pargmann <msp@baylibre.com>, Sumit Garg
 <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, Bryan Brattlof
 <bb@ti.com>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>,
 <u-boot@lists.denx.de>, Kevin Hilman <khilman@baylibre.com>,
 Vishal Mahaveer <vishalm@ti.com>, Kendall Willis <k-willis@ti.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
 <20250623-topic-am62-ioddr-v2025-04-rc1-v3-4-a4da322c16af@baylibre.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-4-a4da322c16af@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Tue, 01 Jul 2025 17:06:58 +0200
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

On 23/06/25 17:38, Markus Schneider-Pargmann wrote:
> This patch adds code to be able to call TI_SCI_MSG_MIN_CONTEXT_RESTORE.
> The context needs to be restored after booting SPL when resuming from
> IO+DDR.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   drivers/firmware/ti_sci.c              | 38 ++++++++++++++++++++++++++++++++++
>   drivers/firmware/ti_sci.h              | 14 +++++++++++++
>   include/linux/soc/ti/ti_sci_protocol.h |  9 ++++++++
>   3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index ce50bf6800eb1fee70a872d8ae648b1a9582b681..e0e7c229deda20bf638a5e33f0225d8a35a01779 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -45,6 +45,9 @@
>   
> +/**
> + * struct ti_sci_msg_min_restore_context_req - Request to restore context from DDR
> + *
> + * @hdr:		Generic Header

Missing parameter description for ctx_lo and ctx_hi
> + */
> +struct ti_sci_msg_min_restore_context_req {
> +	struct ti_sci_msg_hdr	hdr;
> +	u32			ctx_lo;
> +	u32			ctx_hi;
> +} __packed;
> +

Regards,
Akashdeep Kaur

