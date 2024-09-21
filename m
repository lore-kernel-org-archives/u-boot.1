Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2901ACF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 14:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E6A88BF9;
	Sat, 21 Sep 2024 16:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726927526;
	bh=X4nzv2VkGVc1Ft/P/E5NqNCcuVX2Gvn4H2y/YSvmBRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B15f7NifYm69VVi9iu2FFfcr6Tx8gJu1uyX91b8v/3/IjLbLcPKAahtzHxDi7u9wU
	 AseKUl4qDRwXkz1gX/wm3bKZoT1PARWD5gz9i/tQQkvzpLoTihafM9SGt+uIUZkLZZ
	 CaMJeDA4VpHXF6b0SDIUHYoPabO1/byrjtDje3eXKhtGDz8DeDJ+X0kdPWIyCB3pLk
	 IiQ2X4vpo4La6D7a9MilWqoCql18Ow2+EfpI9NSqFUNmPmQwTh6ZtLupsx6/+SOJb7
	 XdouWxO83453H/585SsrgY+UnadXqzfam7oRZd7KTDsHldUceKfTI6Z2Fn9dfjOtUV
	 EtsiYKzjv9BhQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 890E888ADC;
 Sat, 21 Sep 2024 16:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726927521;
 bh=X4nzv2VkGVc1Ft/P/E5NqNCcuVX2Gvn4H2y/YSvmBRI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tBMrfg09ydqc8UUHFge6B/YQ8S0B2mcRH7OyUlweKQzMYgnG64OaABFamBstrwLSF
 y9Co5xW/9hX8ALAiS9FDsl3r+LyfjN8+41OL092SNhEcUtaE7bzuPdwYxB/f/K71lZ
 qgFcth8yWko8xql+b8ZkdZTLAoGJq4ZKGTnSaJl3UhOyCyaKgUaZqSp3HlX/yRrJnZ
 JUX5O1jHXblJdBc6ihtJPN5SQAxEMDlJZI2n3+RKOcB9suROgaKjsIyrAmcppyOGsD
 xV2xC5ZqSsOl17zZx7n5L8wk7+4ZvtDFQwA9moOEf/X1t/DvCwUnWwGG99vloe/c9v
 f3VZBvu6FTPCA==
Message-ID: <c867eca9-0b9a-49be-8779-8af711c0276e@denx.de>
Date: Sat, 21 Sep 2024 15:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/20] arm: socfpga: agilex5: Update CPU info
To: tien.fong.chee@intel.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-13-tien.fong.chee@intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240920070242.20884-13-tien.fong.chee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/20/24 9:02 AM, tien.fong.chee@intel.com wrote:
> From: Tien Fong Chee <tien.fong.chee@intel.com>
> 
> Update the print info per Agilex 5.
> 
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> ---
>   arch/arm/mach-socfpga/misc_soc64.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
> index a6cc78454da..95e1c07e39f 100644
> --- a/arch/arm/mach-socfpga/misc_soc64.c
> +++ b/arch/arm/mach-socfpga/misc_soc64.c
> @@ -45,7 +45,12 @@ static Altera_desc altera_fpga[] = {
>   #if defined(CONFIG_DISPLAY_CPUINFO)
>   int print_cpuinfo(void)
>   {
> -	puts("CPU:   Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-A53)\n");
> +	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
> +		puts("CPU: Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-A55/A76)");
> +		puts("\n");
> +	} else {
> +		

printf("CPU: Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-%s)\n",
        IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) ? "A55/A76" : "A53");
