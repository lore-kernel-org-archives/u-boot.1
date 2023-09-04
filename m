Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22DCC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4854A86926;
	Mon,  4 Sep 2023 15:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693835770;
	bh=eYb26EuOA2pUxnpaZ4C32tpRaYeZgeblEK4m/I3XpSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=blYILtIhtHraBMlj4vqcLgO+kPAugh/w80VieBX5D2bHu5xNnWiWkTvtD4vF+bCzb
	 M2PApwwfD69Yy0Gr9ZESeu1x4hsbwmqremHJS7s2Zz2MphsHYNJ7fF0nadQ1eLlO6N
	 Ew4G5lx4EpOZ5OWAqhvr8pGJPM2Ij62O5TWtiK3YNaxu3+7kEpkpMHRgrRBo4id6gU
	 2R7QP1MLLXFYbVL0e1hzQx7udgg3+yKZN+pHBiBTZmRR+rZZ/S8YPLzGuCyJPKrj4i
	 4QNWbDGG0sSx3jTKpOfT8h7u9z07V91IoG6Y1zjkWeb/IicdJkRz/Xw9Wffoxt3Uiz
	 RzTNipfQaIgkg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7253E868D9;
 Mon,  4 Sep 2023 15:56:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693835768;
 bh=eYb26EuOA2pUxnpaZ4C32tpRaYeZgeblEK4m/I3XpSU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ETvnDt71ajSd6cMNiSKz6DWGdppBBTcwaNNCnbX+nu4O7op+mZndBO1Tsvl9cPJgD
 rptSVH28WJooMSuMkr2Mn80+WnShfIgRXFuEDjIcwhwWZOHeLZkEJV98r38HUAOg9d
 Mk8ynzmVqEVoQxAW127EawB8af+xyn6petYqCmwqq7HIJAapC74wxDu5l49knSwL4u
 iRlsW+i9TwxVASiH64N73SaWgoD6/kyeLzNr69y2eJeEV9+7cUa6QBm5NhKVZe+fLi
 GJpavDpf8I65sZacaWEFAF1mg80T1hbGA59gegXcRb030cnmnbBSzMjKV1BAemIyCY
 6TRYjePE9T42A==
Message-ID: <a888c2fb-2d78-d623-3d42-75ff47b8950a@denx.de>
Date: Mon, 4 Sep 2023 15:56:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] usb: host: ohci-generic: Make usage of clock/reset
 bulk() API
Content-Language: en-US
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>
References: <20230904122021.2088429-1-fabrice.gasnier@foss.st.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230904122021.2088429-1-fabrice.gasnier@foss.st.com>
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

On 9/4/23 14:20, Fabrice Gasnier wrote:
> Make usage of clock and reset bulk API in order to simplify the code
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> 
> Changes in v2:
> - fix copy/paste on dev_err message since Marek's review comment
> - add Marek's review tag

Likely still needs RB from Xavier ?
