Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01344C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 14:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682C988719;
	Tue,  7 May 2024 16:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715092024;
	bh=gq1VnEWU03rBWLYRGtF0SRzr2sAS8EcVHlQwvCxCZzE=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pFf9BvGV6G55ABjzin/9nOQz4ZNOGITCoeNzHw6kobbSSIIUs/ZFmqLfZjUMnGE1u
	 Wu/q4uRkhA30zlzx/yR5GF7yjawpB2uVV5Sp1ojPu7Z0F9h02CrnR1/ZWjoMPLd8gt
	 +VmwaatLYBvYypZxEvOYin7UXr327I8tct5RvHj+qHHpHV1SJDd8HRtkXs6SlNrFbT
	 awY4dwXFPjVG0jnvTfF1Cm3Phuzlvvf8/FcFBafHxaPQlJVqv1YbP8recNilAbXJQb
	 cnuvuOBaOlNY2qOLdXjc9yjM1Xj5Ilh7CnflHAnhB1UDnsIE/eLblCvUCLjIA0wkTz
	 E09MkN0Mm3/5A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5A1328834B;
 Tue,  7 May 2024 16:27:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715092023;
 bh=gq1VnEWU03rBWLYRGtF0SRzr2sAS8EcVHlQwvCxCZzE=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
 b=qGj7et5bR7o3R6tIbrlBecD9aPDmAXqVxYc1a8Y4bOKCb+k8tTdxvLgyiQF/2M3Oq
 je5cSVWCQmxD9angVwSu4pDzW0swzBvnUhWzLzbevtB8zwdl+Pe3uHBbSL6EWfEa8U
 A5k4Wy/tx1tnYsk6XbIQK+LCw4hRNM3/hVlbv+GuiC6xSNbBBrF2tGEFqIouG5K/pW
 jjtGh58qGbklmb1ln8lQ/nxR8O8Prrk0eeV8VPFGyY93CFpnmiZfJ8EmrVQwYdYE0j
 1MQKakZPeEFdXnf2ytY/YaWYC/8DpAQXxzAXG/AX4ZrEb+SWcsq+D50NuXO+NUiqAX
 zUJyb2tiBNKVA==
Message-ID: <28173ffa-209b-498f-a2c3-99ec2f898e7c@denx.de>
Date: Tue, 7 May 2024 15:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: add documentation about the required keys/certs
To: Claudius Heine <ch@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Fabio Estevam <festevam@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 open list <u-boot@lists.denx.de>
References: <20240503010518.263458-1-marex@denx.de>
 <20240507130650.713801-1-ch@denx.de>
Content-Language: en-US
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240507130650.713801-1-ch@denx.de>
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

On 5/7/24 3:06 PM, Claudius Heine wrote:
> For CST to find the certificates and keys for signing, some keys and
> certs need to be copied into the u-boot build directory.

Make sure to CC "NXP i.MX U-Boot Team" , else NXP is not informed. Use 
scripts/get_maintainer to get the full list or just reuse the CC list 
from patches in this thread.

> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> index ce1de659d8..42214df21a 100644
> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> @@ -144,6 +144,22 @@ The signing is activated by wrapping SPL and fitImage sections into nxp-imx8mcst
>   etype, which is done automatically in arch/arm/dts/imx8m{m,n,p,q}-u-boot.dtsi
>   in case CONFIG_IMX_HAB Kconfig symbol is enabled.
>   
> +Per default the HAB keys and certificates need to be located in the build
> +directory, this means copying the following files from the HAB keys directory
> +flat (e.g. removing the `keys` and `cert` subdirectory) into the u-boot build
> +directory for the CST Code Signing Tool to locate them:

Do symlink(s) work too ?

> +- `crts/SRK_1_2_3_4_table.bin`
> +- `crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem`
> +- `keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem`
> +- `crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem`
> +- `keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem`
> +- `keys/key_pass.txt`
> +
> +The paths to the SRK table and the certificates can be modified via changes to
> +the nxp_imx8mcst device tree node

"nodes", plural, there are two, one for SPL and one for fitImage.

It would be good to mention the DT properties which govern the crypto 
material paths -- nxp,srk-table, nxp,csf-crt, nxp,img-crt -- somewhere 
around this sentence.
