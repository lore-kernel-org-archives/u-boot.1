Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127E9C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 06:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364B68841D;
	Tue, 25 Jun 2024 08:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=imag.fr header.i=@imag.fr header.b="NRdowXnF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C17E8844C; Tue, 25 Jun 2024 08:47:20 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F638882DA
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 08:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.duble@imag.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
 t=1719298038; bh=jWlFkYTh26URv/LQ7d7uAqlGUQWOMzMnc15nbtW+ufU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NRdowXnFgsM95zOWJHOH3Z+zQAYODwsg3Twx++3l81UGtPvhfS1rKNCLxuzw3A81T
 pkFsxCsGbklk1tKr+euVpxxXAOyF24zgr9WDYclxsYRvb7AOlYNCJo5dvO2GeJi9y/
 s1DLOi4uMC5qq0LVHBboBwMiPGOJCSgJVgqFH4HFIdzV7zsqf9+UG7j51ZQDWDR19o
 8OCYkMUj8OlTIsfzv8CmmbYBXsmWVnuPKfeDl8KheLQYVf4BR64Z028OtdUNaVf/UP
 zSGC5f7TdLWkX3aTHOjtEl8SgftUyewBrHXAd+Vgo8kgh/sG6itbB6L+jOXVMAw7bB
 LbyMJWkNO2vyg==
Received: from mailhub.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 0A7344030B;
 Tue, 25 Jun 2024 08:47:18 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub.u-ga.fr (Postfix) with ESMTP id 065C7100075;
 Tue, 25 Jun 2024 08:47:18 +0200 (CEST)
Received: from [129.88.53.250] (pimlig-dock-duble.imag.fr [129.88.53.250])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 (Authenticated sender: dublee@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id BF9E54007F;
 Tue, 25 Jun 2024 08:47:16 +0200 (CEST)
Message-ID: <2b902244-0688-432b-bd04-061a083a0fbd@imag.fr>
Date: Tue, 25 Jun 2024 08:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: fix wrong PCI range address in rk3568 dtsi
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Cc: joe hershberger <joe.hershberger@ni.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@lists.denx.de>
References: <1506177052.15003206.1719232828107.JavaMail.zimbra@univ-grenoble-alpes.fr>
 <6e542e4b-9785-4ce5-b10a-7ed1b54131a8@cherry.de>
Content-Language: en-US
From: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>
In-Reply-To: <6e542e4b-9785-4ce5-b10a-7ed1b54131a8@cherry.de>
X-Greylist: Whitelist-UGA SMTP Authentifie (dublee@univ-grenoble-alpes.fr) via
 smtps-465 ACL (41)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Quentin,

Le 24/06/2024 à 15:15, Quentin Schulz a écrit :
> Hi Etienne,
>
> On 6/24/24 2:40 PM, ETIENNE DUBLE wrote:
>> One of the PCI ranges was wrong in this device tree.
>> When testing with a FriendlyElec Nanopi R5C board, the
>> 2nd ethernet interface (labelled "wan") was not working
>> in u-boot because of that.
>>
>> With the correct value (found in FriendlyElec's downstream
>> u-boot repository), this 2nd ethernet interface now works.
>>
>> Signed-off-by: Etienne Dublé <etienne.duble@imag.fr>
>> ---
>>
>>   dts/upstream/src/arm64/rockchip/rk3568.dtsi | 2 +-
>
> dts/upstream is only for patches coming from **merged** Linux kernel 
> (i.e. releases or -rc releases or master branch from Linus Torvalds).
>
> We do not accept U-Boot-only patches in dts/upstream.
>
> Please submit the patch to the Linux kernel first and it will 
> eventually make it to that directory either via a 
> dts/update-dts-subtree.sh pull or dts/update-dts-subtree.sh pick. 
> Depending on maintainer's opinion, fixing the range in 
> arch/arm/dts/rk3568-u-boot.dtsi could be an option, but we really need 
> the patch sent to upstream Linux kernel community first.
>
> c.f. https://www.kernel.org/doc/html/v6.5/process/submitting-patches.html

I see, I will look at it.
In version 2 of the series I will remove this second patch and just 
mention that we are waiting for this problem to be fixed upstream, in 
the cover letter.

Cheers,
Etienne

-- 
Etienne Dublé
CNRS / LIG - Bâtiment IMAG
700 avenue Centrale - 38401 St Martin d'Hères
Bureau 426 - Tel 0457421431
