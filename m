Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0B4C52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0BC788BC7;
	Fri,  9 Aug 2024 11:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q+ZfnqBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C849688BD1; Fri,  9 Aug 2024 11:34:00 +0200 (CEST)
Received: from mail-m127161.xmail.ntesmail.com
 (mail-m127161.xmail.ntesmail.com [115.236.127.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FCEC88B80
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Q+ZfnqBqBMC9qyE8SqZc58of2xHhaaS0Gl3tvs7EDo4pg+pMkmQ35LeGd46FdapPM9q7EZdbppecH9KVnUXhsbNAg8mjqKDG7tf7Ib/qVIA8EumJwjzOZjO/V2PVdhdB1Txj5J9qtzoQ1jmzv23a7wS027TGPs3ijdgBTCm9oCs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=m7VncWY1ueARZ9QzKbZ/2kfbX/wzwgboqTDG1L998mA=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 6FC3390063C;
 Fri,  9 Aug 2024 17:33:44 +0800 (CST)
Message-ID: <f30f3b85-14ac-4ecf-bfe5-352d03736de0@rock-chips.com>
Date: Fri, 9 Aug 2024 17:33:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: rockchip: add gpio-line-names to
 radxa-zero-3
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de,
 Trevor Woerner <twoerner@gmail.com>, Heiko Stuebner <heiko@sntech.de>
References: <20240802221231.2629416-1-jonas@kwiboo.se>
 <20240802221231.2629416-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802221231.2629416-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTxhDVk9CTEgaGh0ZQkgZGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91367caa8103a9kunm6fc3390063c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ok06Nww*MDI4MQ45Lg40MhBJ
 KioaCiJVSlVKTElISkJNS0lNSk5IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU5ITks3Bg++
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


On 2024/8/3 06:12, Jonas Karlman wrote:
> From: Trevor Woerner <twoerner@gmail.com>
>
> Add names to the pins of the general-purpose expansion header as given
> in the Radxa documentation[1] following the conventions in the kernel[2]
> to make it easier for users to correlate pins with functions when using
> utilities such as 'gpioinfo'.
>
> [1] https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interface
> [2] https://www.kernel.org/doc/Documentation/devicetree/bindings/gpio/gpio.txt
>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> Link: https://lore.kernel.org/r/20240620013301.33653-1-twoerner@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: f7c742cbe664ebdedc075945e75443683d1175f7 ]
>
> (cherry picked from commit 8b26cf42ba0c74a9c86cebe591a9195f75151d97)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Add Signed-off-by tag
> ---
>   .../arm64/rockchip/rk3566-radxa-zero-3.dtsi   | 72 +++++++++++++++++++
>   1 file changed, 72 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
> index 081be841b286..9cc7aa3298d0 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
> @@ -105,6 +105,78 @@
>   	cpu-supply = <&vdd_cpu>;
>   };
>   
> +&gpio0 {
> +	gpio-line-names =
> +		/* GPIO0_A0 - A7 */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIO0_B0 - B7 */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIO0_C0 - C7 */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIO0_D0 - D7 */
> +		"pin-10 [GPIO0_D0]", "pin-08 [GPIO0_D1]", "",
> +		"", "", "", "", "";
> +};
> +
> +&gpio1 {
> +	gpio-line-names =
> +		/* GPIO1_A0 - A7 */
> +		"pin-03 [GPIO1_A0]", "pin-05 [GPIO1_A1]", "",
> +		"",                  "pin-37 [GPIO1_A4]", "",
> +		"",                  "",
> +		/* GPIO1_B0 - B7 */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIO1_C0 - C7 */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIO1_D0 - D7 */
> +		"", "", "", "", "", "", "", "";
> +};
> +
> +&gpio2 {
> +	gpio-line-names =
> +		/* GPIO2_A0 - A7 */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIO2_B0 - B7 */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIO2_C0 - C7 */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIO2_D0 - D7 */
> +		"", "", "", "", "", "", "", "";
> +};
> +
> +&gpio3 {
> +	gpio-line-names =
> +		/* GPIO3_A0 - A7 */
> +		"",                  "pin-11 [GPIO3_A1]", "pin-13 [GPIO3_A2]",
> +		"pin-12 [GPIO3_A3]", "pin-35 [GPIO3_A4]", "pin-40 [GPIO3_A5]",
> +		"pin-38 [GPIO3_A6]", "pin-36 [GPIO3_A7]",
> +		/* GPIO3_B0 - B7 */
> +		"pin-15 [GPIO3_B0]", "pin-16 [GPIO3_B1]", "pin-18 [GPIO3_B2]",
> +		"pin-29 [GPIO3_B3]", "pin-31 [GPIO3_B4]", "",
> +		"", "",
> +		/* GPIO3_C0 - C7 */
> +		"",                  "pin-22 [GPIO3_C1]", "pin-32 [GPIO3_C2]",
> +		"pin-33 [GPIO3_C3]", "pin-07 [GPIO3_C4]", "",
> +		"", "",
> +		/* GPIO3_D0 - D7 */
> +		"", "", "", "", "", "", "", "";
> +};
> +
> +&gpio4 {
> +	gpio-line-names =
> +		/* GPIO4_A0 - A7 */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIO4_B0 - B7 */
> +		"",                  "",                  "pin-27 [GPIO4_B2]",
> +		"pin-28 [GPIO4_B3]", "", "", "", "",
> +		/* GPIO4_C0 - C7 */
> +		"",                  "",                  "pin-23 [GPIO4_C2]",
> +		"pin-19 [GPIO4_C3]", "",                  "pin-21 [GPIO4_C5]",
> +		"pin-24 [GPIO4_C6]", "",
> +		/* GPIO4_D0 - D7 */
> +		"", "", "", "", "", "", "", "";
> +};
> +
>   &gpu {
>   	mali-supply = <&vdd_gpu_npu>;
>   	status = "okay";
