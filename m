Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71782CCA471
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 04:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B0F8386B;
	Thu,  9 Oct 2025 06:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jMU1Suty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BEB78393C; Thu,  9 Oct 2025 06:12:27 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E74E83869
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 06:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5994CMVR4193427;
 Wed, 8 Oct 2025 23:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759983142;
 bh=NuRfnHMy2ZtJE+HQr1BHjlqV1YkrLjnfsV/h8yjqV2s=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=jMU1SutyL0DXF28Aivltgk1iFJf0TLtpJWyVxg1w1wZVvtIbLSjagvAjyHJGSC9RS
 Cm7A6TltYZX1BTbgCn2XesjvWpAQM6wKviMi6naAclFXcV66vP5pQnu5IA6mJzsgb9
 HdyP3uQbcu9UBGjjKroXGBmXiG0rVc5EiK0DU6Bw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5994CMMt1146408
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 8 Oct 2025 23:12:22 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 23:12:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 23:12:22 -0500
Received: from [172.24.218.213] (lt5cd2489kgj.dhcp.ti.com [172.24.218.213])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5994CKws3828425;
 Wed, 8 Oct 2025 23:12:20 -0500
Message-ID: <a3ffbeb6-ac01-41f2-991c-024c52548263@ti.com>
Date: Thu, 9 Oct 2025 09:42:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: ti: Add DDRSS Inline ECC Error Injection command
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>, <s-k6@ti.com>
CC: <u-boot@lists.denx.de>
References: <20251008113435.1437532-1-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251008113435.1437532-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 10/8/2025 5:04 PM, Neha Malcom Francis wrote:
> From: Georgi Vlaev <g-vlaev@ti.com>
>
> Introduce a new version of the Keystone-II "ddr" command for testing the
> inline ECC support in the DDRSS bridge available on K3 devices. The ECC
> hardware support in K3's DDRSS and the test method differ substantially
> from what we support in the K2 variant of the command. This K3 DDRSS
> command currently supports only single controller testing.
>
> The ECC error injection procedure follows these steps:
> 1) Flush and disable the data cache.
> 2) Disable the protected ECC Rx range.
> 3) Flip a bit in the address.
> 4) Restore the range to original.
> 5) Read the modified value (corrected).
> 6) Re-enable the data cache.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> This will cause the 1-bit ECC error count to increase while the read
> will return the corrected value.
>
> The K3 version of the command extends the syntax for the "ecc_err"
> argument by also introducing an argument for range which specifies which
> range (0, 1, 2) the address is located in.
>
> Multi-bit ECC errors are uncorrectable and will lead to a synchronous
> abort.
>
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> [n-francis@ti.com: Add J7 and multiple-region support, simplify logic]
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20251001082045.3547143-1-n-francis@ti.com/
> - instead of terming it as a test, push it as a tool to inject ECC to
>    possibly create an ECC error; as this depends on the user's
>    configuration
> - cmd/ti/ddrss.c --> cmd/ti/ddr4.c, and maintain same command name as K2
>    i.e. "ddr" (Udit)
> - add description for multi-bit error behavior (Udit)
> - s/x/range (Udit)
> - add check for range, ecc_err no check needed (can be any value,
>    synchronous abort / ECC error count / no ECC error are the three
>    possible behaviors depending on the user's configuration) (Udit)
>
> Test logs on J784S4-EVM (after modifying for single controller with ECC enabled)
> https://gist.github.com/nehamalcom/6ed3e835a55530d84a358bacf9095d2e
>
>   cmd/ti/Kconfig  |   8 ++
>   cmd/ti/Makefile |   1 +
>   cmd/ti/ddr4.c   | 251 ++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 260 insertions(+)
>   create mode 100644 cmd/ti/ddr4.c
>
> diff --git a/cmd/ti/Kconfig b/cmd/ti/Kconfig
> index 9442c9993c1..43fe9ef2f08 100644
> --- a/cmd/ti/Kconfig
> +++ b/cmd/ti/Kconfig
> @@ -8,6 +8,14 @@ config CMD_DDR3
>   	   supports memory verification, memory comapre and ecc
> [..]
