Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4246D0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B3989023;
	Fri, 25 Oct 2024 14:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Rzv/Blwr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8115889024; Fri, 25 Oct 2024 14:00:12 +0200 (CEST)
Received: from mail-m12798.qiye.163.com (mail-m12798.qiye.163.com
 [115.236.127.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B2088BB2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe5871;
 Fri, 25 Oct 2024 20:00:04 +0800 (GMT+08:00)
Message-ID: <46da5b3f-39c2-4c78-af82-d087608533f0@rock-chips.com>
Date: Fri, 25 Oct 2024 20:00:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] arm64: dts: rockchip: add 2 pmu_io_domain
 supplies for Qnap-TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-15-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-15-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NDH1ZLHUMdHh0YHUpJQhhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38c4d7809d6kunmebe5871
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kz46Ijo*OjIeAxc8E0pWNhFN
 NxdPCQpVSlVKTElCQ05MTUtOTE5NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSk5ONwY+
DKIM-Signature: a=rsa-sha256;
 b=Rzv/BlwrPEgda1xBorE4HIFEIFfN6Cl4aMnPwUzS6lQ428dIKVnn4Xs2+MtYtt5yeJtlLTqyxUgfQ15fCSbSnGLcbP+s2u+HohRA6rApuhjYP2fEc5xjd5ap0wISyjVj0MXubx8XrpivLLafVqTnU8s3LCE3LuzjnIQDKkzc6kU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=/Ft2UBLyRv8ykaMbq5DlRiPfc1dI37wqlDH2IcLErOw=;
 h=date:mime-version:subject:message-id:from;
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


On 2024/10/14 03:24, Heiko Stuebner wrote:
> Add the two supplies for the pmu-io-domains that are defined in the
> vendor devicetree for the TS433.
>
> Tested-by: Uwe Kleine-König <ukleinek@debian.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240723195538.1133436-15-heiko@sntech.de
>
> [ upstream commit: 64b7f16fb3947e5d08d9e9b860ce966250e45d52 ]
>
> (cherry picked from commit 9b4d4c02b5762196063ab03c5439f96cbbaf2485)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index 9a0cb69c3cf..6c4269b3d95 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -531,6 +531,11 @@
>   	};
>   };
>   
> +&pmu_io_domains {
> +	vccio4-supply = <&vcc_1v8>;
> +	vccio6-supply = <&vcc_1v8>;
> +};
> +
>   &sata1 {
>   	status = "okay";
>   };
