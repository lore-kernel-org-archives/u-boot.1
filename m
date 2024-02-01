Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF366C47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 02:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4234587613;
	Thu,  1 Feb 2024 03:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IvvJyaD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2804387C3A; Thu,  1 Feb 2024 03:48:21 +0100 (CET)
Received: from m84-178.qiye.163.com (m84-178.qiye.163.com [123.58.178.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B56EF875EB
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 03:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=IvvJyaD05Nzvfa8HGDyetDJzEINvBMUwD7wgD40IyuhO2CA4hf2oL0JO+kXL9j8Qpap3zUvo9ACHQuGp1bURNM+XbntMQz9mII8sA3/0xDrC0CaYtNwoIGZorzgg2h7q1aJGK8/KR0umcEjp8LmP5JcL5WGj8U+Iye+zpkn9qP4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=YPPDoaBI83tyAJ2lkS65Cg4fIhILN31LaRi032QESyI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 7D30A9001D2;
 Thu,  1 Feb 2024 10:48:05 +0800 (CST)
Message-ID: <36121924-2fbb-4a92-b72f-9648f1e9c7e0@rock-chips.com>
Date: Thu, 1 Feb 2024 10:48:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] rockchip: avoid out-of-bounds when computing cpuid
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-3-1eec1c34953c@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240123-jaguar-v1-3-1eec1c34953c@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk8dGlZITENDGE0fHUkfHUtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d629103f403a9kunm7d30a9001d2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzY6MSo6EDMPKk00PggODRAL
 FS1PFChVSlVKTEtNTE5OTUNMQk9CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTEpINwY+
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


On 2024/1/23 22:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> The expected length of the cpuid, as passed with cpuid_length,
> determines the size of cpuid_str string. Therefore, care should be taken
> to make sure nothing is accessing data out-of-bounds.
>
> Instead of using hardcoded values, derive them from cpuid_length.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/misc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/misc.c b/arch/arm/mach-rockchip/misc.c
> index 7d03f0c2b67..15397cff009 100644
> --- a/arch/arm/mach-rockchip/misc.c
> +++ b/arch/arm/mach-rockchip/misc.c
> @@ -102,7 +102,7 @@ int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length)
>   	int i;
>   
>   	memset(cpuid_str, 0, sizeof(cpuid_str));
> -	for (i = 0; i < 16; i++)
> +	for (i = 0; i < cpuid_length; i++)
>   		sprintf(&cpuid_str[i * 2], "%02x", cpuid[i]);
>   
>   	debug("cpuid: %s\n", cpuid_str);
> @@ -111,13 +111,13 @@ int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length)
>   	 * Mix the cpuid bytes using the same rules as in
>   	 *   ${linux}/drivers/soc/rockchip/rockchip-cpuinfo.c
>   	 */
> -	for (i = 0; i < 8; i++) {
> +	for (i = 0; i < cpuid_length / 2; i++) {
>   		low[i] = cpuid[1 + (i << 1)];
>   		high[i] = cpuid[i << 1];
>   	}
>   
> -	serialno = crc32_no_comp(0, low, 8);
> -	serialno |= (u64)crc32_no_comp(serialno, high, 8) << 32;
> +	serialno = crc32_no_comp(0, low, cpuid_length / 2);
> +	serialno |= (u64)crc32_no_comp(serialno, high, cpuid_length / 2) << 32;
>   	snprintf(serialno_str, sizeof(serialno_str), "%016llx", serialno);
>   
>   	oldid = env_get("cpuid#");
>
