Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42301C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 07:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6F1E86BA4;
	Tue,  7 Nov 2023 08:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TFHYbCZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3F386689; Tue,  7 Nov 2023 08:09:27 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15568870F2
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 08:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A779IqU095817;
 Tue, 7 Nov 2023 01:09:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699340958;
 bh=BhPBjarg99XigSuYr1kPQL6cvZvXPPdG4XBFxk76fB0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TFHYbCZzAmJl6SdJAt59zHV5uDmAHc4Mpkp9OxTSEUgcL65GQsE66UOEPfENSUddd
 +llFNT8EUP3xIbW1fsCXYZ4Nhx25MEz/y81qdBFq8AdGIX+JQSZt5x2tebVPBlBR7X
 NkpF1ZmRJjVDZzvwNyVtYo22w2BUCKvPEuqW5W44=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A779IFG025095
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Nov 2023 01:09:18 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Nov 2023 01:09:18 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Nov 2023 01:09:18 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A778gcp066318;
 Tue, 7 Nov 2023 01:09:15 -0600
Message-ID: <d0bee887-a5f7-4e36-a9ef-e5af0e16b396@ti.com>
Date: Tue, 7 Nov 2023 12:39:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 04/12] board: ti: j721e: j721e.env: Add explicit
 boot_targets
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>,
 Robert Nelson <robertcnelson@gmail.com>, Jason Kridner
 <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
References: <20231104072150.3339-1-nm@ti.com> <20231104072150.3339-5-nm@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231104072150.3339-5-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Nishanth,

On 04/11/23 12:51, Nishanth Menon wrote:
> Add explicit boot_targets to indicate the specific boot sequence to
> follow.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   board/ti/j721e/j721e.env | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
> index 8cc8232fc131..cb27bf5e2b24 100644
> --- a/board/ti/j721e/j721e.env
> +++ b/board/ti/j721e/j721e.env
> @@ -31,6 +31,7 @@ addr_mcur5f0_0load=0x89000000
>   name_mcur5f0_0fw=/lib/firmware/j7200-mcu-r5f0_0-fw
>   #endif
>   
> +boot_targets=mmc1 mmc0 usb pxe dhcp
>   boot=mmc
>   mmcdev=1
>   bootpart=1:2

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
