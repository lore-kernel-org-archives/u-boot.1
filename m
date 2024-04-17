Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22928C001CC
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 16:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7036B884B7;
	Wed, 17 Apr 2024 18:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713372472;
	bh=qA7Rvmj+/9c4cMr0JqhLU70HL4ooLgbMqzWapRCqTtk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OP8+u/RakzrJrpH0GC/OYn1NXt2M++tk/EfpaAIvaYgFywvwXUPf11nr0nTmWEpqf
	 6D6WIcnHET3Uq9dakbegpc4DpwRWBtVVWRtTGff+8dBUUYdpyAzvhjDRegl/Db85X+
	 qz9I5IqPs2t/bXndfX+DPEBWGzpKEQx5mL18g3eC3LuAfqK0bN5RZ18fA29AbN6Y4i
	 88y9NLmaEIxJwt9MmH1tHBrT/Uch+Q0tMc4pwIL+aaNpX7UA3JW0zuHVFyazO0pM5C
	 wM43ghTcCuSAXfZU9E+WNwfhpNZaBQ8ltVQceoO++x/K9xfAeGW6zeBbu0KJh8/IjC
	 57fSRCP5VI5cA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 36EAD884AB;
 Wed, 17 Apr 2024 18:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713372471;
 bh=qA7Rvmj+/9c4cMr0JqhLU70HL4ooLgbMqzWapRCqTtk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=wvMqOHnK7CNveiArS8Zi8IRuz1MZWSr+jKVEB+Nrr1KhX9lNkL1gLIbpXWz/xuoSw
 j2AmcPxiiyrhhRhXXw+vB8XxQ50xJgi+Q3NQRiuqgkjYI8YxJLmWrlNWoV5UZKllqH
 jHvbEe99iTLGZ+T9V5HV1/QRcJqZoYT5uEaZiP/zXB/4kd3dKnMSlAy3u9iTTyohh4
 o2rnNZaxX8X4KjHcXhtoPrcIZZYyLXfeO8hE0X9KHCWwP/tjy35srj7/VWm7v8CYK2
 h2aeRpDU0I3H50OL+2HKKQllS2ixCOulQ4TAGdb5QPiLnHH3hMQK9qlNyenkvSemir
 TeisGTqD5GeXg==
Message-ID: <c0756783-64a7-4a01-a7d9-c24c5489615b@denx.de>
Date: Wed, 17 Apr 2024 18:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] net: dwc_eth_qos: Clean up STM32 glue code and
 add STM32MP13xx support
To: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Roullier <christophe.roullier@st.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240326120745.27581-1-marex@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240326120745.27581-1-marex@denx.de>
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

On 3/26/24 1:07 PM, Marek Vasut wrote:
> Split off STM32 glue code from the DWMAC driver into separate
> file, similar to what other SoCs already do, to avoid mixing
> the ST specifics with generic DWMAC core code.
> 
> Clean the STM32 DWMAC board code which is currently duplicated
> in multiple board files, move it into the newly separated glue
> code, since the code is not board specific, it is only generic
> DT parsing and generic register programming.
> 
> Add STM32MP13xx support based on ST downstream patches on top,
> although that part is mostly rewritten from scratch.

Can either of you, Patrice/Patrick, pick this series via ST tree and 
create a MR for Tom (possibly including the other long outstanding 
patches too) ?

Thanks
