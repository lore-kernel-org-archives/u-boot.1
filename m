Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA981C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 09:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6DC87F65;
	Tue, 26 Mar 2024 10:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VxKEhpoO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC6F88013; Tue, 26 Mar 2024 10:48:38 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A35378718A
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 10:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42Q9mVi9034475;
 Tue, 26 Mar 2024 04:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711446511;
 bh=pCDNymM6dGk/2mb4UoDoiXBVA/uH2v3ChuzjXYh8aHQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=VxKEhpoOv1BdgoKCyr2UdCZpNFTlzEA2yZXcW0xbycuKzLyFByuG8WDLjxksEgyAs
 HBv9qBetz5HffI4pFd9RxDZze20naMlquqfoDhcRe2LyU6u2znpCEh3MKjM2fYFSHu
 qPb7WHqQoSGkWeR0Eb1aqngve7w/FsQ2L3tiKdNo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42Q9mVIs038877
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Mar 2024 04:48:31 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 04:48:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 04:48:31 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42Q9mRud060027;
 Tue, 26 Mar 2024 04:48:28 -0500
Message-ID: <e225ae6d-b645-4884-b757-b0c1b4d1107b@ti.com>
Date: Tue, 26 Mar 2024 15:18:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: ti-secure: Enable debug extension for combined
 boot
To: Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
References: <20240326-b4-upstream-jtag-debug-unlock-v1-1-720d8635a4f4@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240326-b4-upstream-jtag-debug-unlock-v1-1-720d8635a4f4@ti.com>
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

Hi Manorit

On 26/03/24 13:37, Manorit Chawdhry wrote:
> To debug using jtag, ROM needs to unlock jtag debugging on HS devices
> and it does that looking at this debug extension.
> 
> Add the debug extension and enable it by default.
> 
> Link: https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/security/sec_cert_format.html?highlight=debug#sysfw-debug-ext
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
> Keeping this enabled by default as this is enabled for non-combined boot
> as well by default.
> ---
>   tools/binman/btool/openssl.py | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> index fe81a1f51b1e..c6df64c5316d 100644
> --- a/tools/binman/btool/openssl.py
> +++ b/tools/binman/btool/openssl.py
> @@ -283,6 +283,7 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
>   basicConstraints = CA:true
>   1.3.6.1.4.1.294.1.3=ASN1:SEQUENCE:swrv
>   1.3.6.1.4.1.294.1.9=ASN1:SEQUENCE:ext_boot_info
> +1.3.6.1.4.1.294.1.8=ASN1:SEQUENCE:debug
>   
>   [swrv]
>   swrv=INTEGER:{sw_rev}
> @@ -323,6 +324,12 @@ compSize = INTEGER:{imagesize_sysfw_data}
>   shaType  = OID:{sha_type}
>   shaValue = FORMAT:HEX,OCT:{hashval_sysfw_data}
>   
> +[ debug ]
> +debugUID = FORMAT:HEX,OCT:0000000000000000000000000000000000000000000000000000000000000000
> +debugType = INTEGER:4
> +coreDbgEn = INTEGER:0
> +coreDbgSecEn = INTEGER:0
> +
>   {sysfw_inner_cert_ext_boot_block}
>   
>   {dm_data_ext_boot_block}
> 
> ---
> base-commit: fb49d6c289d942ff7de309a5c5eaa37a7f4235db
> change-id: 20240326-b4-upstream-jtag-debug-unlock-6fc21e344cfb
> 
> Best regards,

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
