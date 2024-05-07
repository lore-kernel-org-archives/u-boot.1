Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1B9C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 14:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5BE488798;
	Tue,  7 May 2024 16:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715092027;
	bh=Ofi5JIehCo4Y3rFQhRS32rf84zVpH7SKsM37tFmiplQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d2vqxLiIv5xG52NL0dX7keWdQ9ptF/pIFK0Ket1R5N2X0WEUTDgWEs8+vqADzGJqa
	 VK3RWr5fs017H5Xl/oU5fLNZyAYaZPDVxMSELx6PYnVeVrpiCyzuZqHud+cQ6BXwdK
	 t3ImGkC4yF7+0oJVTzhSgp15CsjIobUFFr9DHFVz+I2EhjbneCJaq6FzaBfTdgK85v
	 iT2GhTnAop4G6kDdZlCvXPr282/jkR7GuJVaf3wS9AUOCDZGOI+qpLMrz5+4qCJ1Gn
	 XO5ijohdx5IRsMyKoN7d21RucRE2lYjfxGZ8NEs8F6CdQYBV5VzhwRopwSN5xxWxQn
	 wdIjlA3nJX3Ig==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9A98188742;
 Tue,  7 May 2024 16:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715092027;
 bh=Ofi5JIehCo4Y3rFQhRS32rf84zVpH7SKsM37tFmiplQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=X8/AZSuEIDeBY2eC3JToWj6YwmXC1jQttz8BxHVjipPcYDdXxBBvnhaHQJi2/IyaW
 hnqLfvgStT7yDyY1hrXIACvNVdu7dlMB8pbmRa4U2xBFn256CfJZa8NkkfhJABy/rt
 J7+p2d/QO354pC+bH1xfPHSH87Hmw38KGozpwc3+tiwr2tTLwLj9r1G5tmKtnW6pNy
 MbJGaZV7ylCvYlfFHaz8aAygvnrX3N3tUMDz6nZO/FKGS5pEXw+OpQVdyAWDNWE15g
 /43Nh87tRLnMKFqUAExJZfZZVrtY/nnJH0goCPu7KFX29KdMeMuYB4UpnnkG5a8yiF
 aWd3iITbAIqNw==
Message-ID: <54f3cc5c-1f2d-4a7c-ab46-45aa5c40d3e4@denx.de>
Date: Tue, 7 May 2024 15:41:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] net: dwc_eth_qos: mdio: Implement clause 45
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@linaro.org,
 sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 patrick.delaunay@foss.st.com, patrice.chotard@foss.st.com, jonas@kwiboo.se,
 leyfoon.tan@starfivetech.com, epsi@gmx.de, xypron.glpk@gmx.de,
 seanga2@gmail.com, sebastien.szymanski@armadeus.com, festevam@gmail.com,
 sebastian.reichel@collabora.com, yanhong.wang@starfivetech.com,
 christophe.roullier@st.com
References: <20240507094237.168238-1-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240507094237.168238-1-pro@denx.de>
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

On 5/7/24 11:42 AM, Philip Oberfichtner wrote:
> Bevor this commit, only clause 22 access was possible. After this commit,
> clause 45 direct access will available as well.
> 
> Note that there is a slight change of behavior: Before this commit, the
> C45E bit was set to whatever value was left in the register from the
> previous access. After this commit, we adopt the common practice of
> discerning C45 from C22 using the devad argument.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
> 
> Notes:
>      Attention: There is a slight change of behavior introduced by this
>      commit (see commit message). Please test and review if this works for
>      everybody.
>      
>      My implementation is tested on an Intel Elkhart lake SOC, patch
>      submitted here:
>      
>      https://patchwork.ozlabs.org/project/uboot/list/?series=405358
>      
>      Changes in V2:
>      	- Use FIELD_PREP() instead of manual '<<' shifting
>      	- Fix whitespace errors

Reviewed-by: Marek Vasut <marex@denx.de>
