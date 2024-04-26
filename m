Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327FFC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 03:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C3E89111;
	Fri, 26 Apr 2024 05:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714102840;
	bh=RfCXsZ0GLMz56Rdo/RiNMIQsL5PBbKM7I60Rvttmuw0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DoljS/yoB+skGswM0ckqFmPY/AKehpIgXE/HISIfM71w/BrWYdgbnI+pdwVSXwoZt
	 0ykQjXEFZzbzMucXsUEe/aK3UHujEQedOANtrPuCpElXWzGAddX1lfSe2Xi5UZh4CE
	 MBiGJwQPnzjDy4B+RSXXCoJedztyjFVEzdJ1ACtDgW1g2wgDVovdM69NSTuZdk/dMC
	 kuv3H+qsFetq6J+OVJJh9MLvsXEVr5NkzVL5Erg1FDy56WfJFQQJUVpxGJUvpNbWUx
	 fek9oDWTiaCga1B88Z0tFfy3S3olODNLATs0gNWln/mRFRJR0+UTzchMfCGtUDwlto
	 oNelMgvbAgeYQ==
Received: from [192.168.1.107] (82-131-156-115.pool.digikabel.hu
 [82.131.156.115])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4E430880F5;
 Fri, 26 Apr 2024 05:40:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714102839;
 bh=RfCXsZ0GLMz56Rdo/RiNMIQsL5PBbKM7I60Rvttmuw0=;
 h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
 b=PT4BYNuXg7sYC2y2qblAihytg2UwtQIcqW9xVYAOuqAy+tjPjPTe5qiVwH5iAp2C+
 nfsspbR3RBmLjyYxKuH59ydkQjbLvBn6rV5d40aBPZe+LovEQeGTd0i9mQ/ivbZtqQ
 SxCrLyoyvHCnM+opLwP81JxKCe74VpndCi1gpzTtenKJ7hH5f4tJEOCw/FAYr3qJhN
 ToQsFGM1BfI3bURS5F8HIXOsWAmJf61J46Pl1LcDwm7htBdGhHLebeTFBO6expRhhk
 libBnVC96JriXQAVnHJDDtN893fVDRo+PdbJpepBbbvmXSIF/sHTxxHQNBQzWTZe2J
 qrmSFf/6hApZg==
Message-ID: <b1733528-3c33-a52c-f239-dbe39c69d586@denx.de>
Date: Fri, 26 Apr 2024 05:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: imx8mn: bootcount does not increment
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, Adam Ford <aford173@gmail.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <CAOMZO5BeK7QyqEZisSVX=fs9jmq98gjnf_n0FrRJrR92pThrGQ@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5BeK7QyqEZisSVX=fs9jmq98gjnf_n0FrRJrR92pThrGQ@mail.gmail.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Fabio,

On 26.04.24 03:55, Fabio Estevam wrote:
> Hi,
> 
> When enabling bootcount on the imx8mm-evk like this:
> 
> --- a/configs/imx8mm_evk_defconfig
> +++ b/configs/imx8mm_evk_defconfig
> @@ -120,3 +120,5 @@ CONFIG_SDP_LOADADDR=0x40400000
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_SPL_USB_SDP_SUPPORT=y
>   CONFIG_IMX_WATCHDOG=y
> +CONFIG_BOOTCOUNT_LIMIT=y
> +CONFIG_BOOTCOUNT_ENV=y

No chance for a bootcounter in a register?

> It works as expected, and the "bootcount" environment variable gets
> incremented after a reset.

Good!

> However, if I try the same on an imx8mn_evk, the "bootcount" variable
> always stays at 1 and never increments.

Uff... environment code should be independent from the board...

> Do you happen to have any idea as to why imx8mn behaves differently in
> this aspect?

saveenv works on the board? Does it use protected Environment?

No more ideas ... sorry...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
