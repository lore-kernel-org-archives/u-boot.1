Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F70FD206AB
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE20088DCC;
	Wed, 16 Oct 2024 09:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729064318;
	bh=2Q2xTEH7tEz76KVHUZcAeZG+ok40TtL/BhgLRPxr4L0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=XGZJP856kveVI/EV2cfIXayZpHQuglFkcAQM6uPTAQ2ukUqtS2ajdp8hkxW9dJ/nx
	 9yOt6WdcKoIVCiE0s8Qde7W4jP9BcN18sC+6VxyzQzfHEtJPztdqO8AuQmY7anWQ58
	 fA7UgYC/TDUggmrfOgJDAT/+lbzpmvUNwEwlM2RABae/vGwyD7dJfG2u5mwNtHsAxL
	 GCkgNiMPxUWPr8XBLu04ynEw1acLI+i0sFjeX2xd1Dvax0fHGK9uQ9hZMxnA+En4Pn
	 ZhdUo9vF2Xg2Wbcm4aREDU5CiLBgSsvw+s2+L9U8wTzMmkEIPZ/myqloGuyzDY4BD7
	 5cyuwCNbe9wZg==
Received: from [192.168.1.107] (87-97-107-160.pool.digikabel.hu
 [87.97.107.160])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1313A8865D;
 Wed, 16 Oct 2024 09:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729064317;
 bh=2Q2xTEH7tEz76KVHUZcAeZG+ok40TtL/BhgLRPxr4L0=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=LZo6By0tetpfVhw6Um9k2tOAy5CE2Wvzc6FgjvJfQ4bAZf0OZP7K1dgqlBar2VW2N
 RYtJUr7ieyc1GeJuZT7xy4Ocw6LTloCp8EUPHScFk/wFWj1thPMPLX93ra9M6uD5ck
 6j35HedUePei9wEHoFGrYuJHu1YoNbOrWvQnnikUkdox2x1mZ97Xw08Kuxo5+CLhVT
 E+FjwakLRojKaWFKwgyqUM1E1naoKw9w7a3Ylpa5c/vsKkY05xTfyvJUy8CgaMYXdZ
 0cSIHi9BdedmKmVi1jZTzHbN6DpZgIsJsgnxb6A0JJxwqCaKpSKVP2wePTPP6ldohH
 jT4cUcrX2EzTA==
Message-ID: <f4388c96-2dcc-7ff9-b235-865d82128342@denx.de>
Date: Wed, 16 Oct 2024 09:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] clk: imx8: Add dummy clk
Content-Language: en-US
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, festevam@gmail.com,
 sbabic@denx.de, u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, lukma@denx.de, seanga2@gmail.com,
 Peng Fan <peng.fan@nxp.com>
References: <20241016075029.15469-1-peng.fan@oss.nxp.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241016075029.15469-1-peng.fan@oss.nxp.com>
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

Hello Peng,

On 16.10.24 09:50, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There is a dummy clk entry for i.MX8QM/QXP, so add the dummy clk enable
> and get rate. Otherwise "__imx8_clk_enable(Invalid clk ID #0)".
> 
> Fixes: 76332fae769 ("mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk API")
> Reviewed-by: Heiko Schocher <hs@denx.de>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/clk/imx/clk-imx8qm.c  | 4 ++++
>   drivers/clk/imx/clk-imx8qxp.c | 4 ++++
>   2 files changed, 8 insertions(+)

Tested on the siemens deneb board, so

Tested-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
