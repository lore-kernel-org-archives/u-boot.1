Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256D3D729F5
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 18:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D6958946D;
	Fri, 29 Nov 2024 19:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732904775;
	bh=xEzga6axYbmyvQ5L92ZSj47M7FUFHXFt6T3JP/+D1yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oNanR/DU07ys+43/UWm4eCYcDWAlk4MFs+FoTmWpKG5AuwrKsj1nl7WRQYXWwiA/k
	 TRdgB3IDRIeQBbYYT6e8K2i2G/PppX2l9F+xtlZ350WwHH1+SpBGO1S2w1jnDIbJYT
	 hS9PyrhCtr/ls4yimHqwWUPmw7DetVCu6xc7zGVp2SvreOVahdxP37uDA09Nv3MKDg
	 1MK0fineuq/vyyWshuYFGZefoU3jaI38hVV00ryBIiHyfe2NUi+XyMn91psolc9V19
	 kAqW9qICa7Fg5a7Ul3foaAzp6OcKuMayloEdxa+450g/+Y7nFaZedtZFiSrHdyyCMC
	 zKnqAucYeSeKw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2955C89464;
 Fri, 29 Nov 2024 19:26:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732904773;
 bh=xEzga6axYbmyvQ5L92ZSj47M7FUFHXFt6T3JP/+D1yU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jXyJ83Ib4JbzPky6a6M5dg8gRIAasoBBikxLpS9TYDOldQYn0v6gNVmMdIxN4N4L2
 L+AgjZ/IQNQj5MWxs+BE/wRyIdwVUC7ZYs629UihXx80PcSU03uuIw5VzscBc7eu3+
 zPe7tD1pIztelSnb9g84wn6usZ8fhbAzVa2RAHHTfVcf7HKm0fNj3BIspYeOHKoMc0
 AJXaoRKNS1vuyKT3pvQu1qAEg0utDG2amheW5pw023wC2SKoGmdX0IB9rZurrawmho
 hIU+6XdhfSXwBkfB5/DxXeYHV/12rEvHBqjInsw9abJGN6Cvx2KDDaElh3W2aStAgr
 RuCPC0WVQr1og==
Message-ID: <e38ca399-f61b-4f56-8a43-aaed19839764@denx.de>
Date: Fri, 29 Nov 2024 18:32:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: replace some debug() by dev_dbg/err()
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241129124422.435998-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241129124422.435998-1-patrice.chotard@foss.st.com>
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

On 11/29/24 1:44 PM, Patrice Chotard wrote:
> Replace some debug() by dev_dbg() when dev variable
> is available/valid.
> 
> To ease debugging, use dev_err() instead of dev_dbg() for
> alerting when regulator has nonunique value.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
