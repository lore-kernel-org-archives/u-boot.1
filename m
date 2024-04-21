Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47065C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 20:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB51882FD;
	Sun, 21 Apr 2024 22:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713731355;
	bh=6iGttA6Lga+D0XYY7Ppgso9ZLkb+fFt+eIYTQJrxp8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wUxLxeJFwYu8zfjV0gYB83ZOW+9UsMKoVqSeRo+GGSjwSOsxOJorP9rq9e5Bowybm
	 qwpA7SJenqE5Ukmq/YcX1o7+T1/5TDEkdpapb4LAh8NyJAwHmB/soV88KunJk9xHCA
	 nYKzm5ZWhmRC7fRHw2hfhhryxN2jc/IpTnl9JKpBja5ymqQFbTCWEHhxyZWs2wJho7
	 9rUUzu/TfFIKXgQ8+Ao+KelmMOIbUFu91VxCwu0qBTLpPBtIcCKaqrIg3jgbdjljHn
	 3f9Z/KiKz+Zkd2TSiLw1nOMhcwgM4sk/p4X8fKqtqOE8g1zeMvRHNujJcN2czTxvGa
	 DwxwAJ0L2+Dvw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4F06C87ED0;
 Sun, 21 Apr 2024 22:29:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713731354;
 bh=6iGttA6Lga+D0XYY7Ppgso9ZLkb+fFt+eIYTQJrxp8s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vbfZYIR/Dmdq2VwF4DdOJO3g7uj0mferVEHNVYu++Rtu0Ea0/sxKTl0eLqwpdFvRX
 LIufDxIe48/W5JS9sxDBWsXZ+O7qTU4Mt8RBqR4mcXIZTtY4lgPJcb0VNSbqrvER/1
 wiMp0iG/3MAF3SI/MaDaC7vWKkb+aJtoVJ+dkyi/9vR8d/yZKpKALQMGwAE/TcdZi3
 sE4g7IRWWi6JzTSUa7bhOViyYCbtbtVcp21B/JGWy1sNSdMALwyU9kKQCgszhzAZY8
 ZjmGOjp6YRVdMrFcrqx8nbmA5EYftzzzRVmJOSuy984jdnRiryQ1YvFIaHZBVDf9m/
 rthcaesQiCJTg==
Message-ID: <b8089d71-42f1-4cb7-9b5e-e3cd99e9ffa5@denx.de>
Date: Sun, 21 Apr 2024 22:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: stm32: add PWR regulators support on
 stm32mp131
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240319024534.103299-1-marex@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240319024534.103299-1-marex@denx.de>
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

On 3/19/24 3:45 AM, Marek Vasut wrote:
> This patch adds STM32 PWR regulators DT support on stm32mp131.
> This requires TFA to clear RCC_SECCFGR, is disabled by default
> and can only be enabled on board DT level.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

It seems these patches have been missed from the recent PR ?

Is there any feedback on those patches ?
