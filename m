Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E1BCEFC30
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 16:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC5B88CFC;
	Tue,  8 Oct 2024 18:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728405552;
	bh=L1RQ+YSvqc6sn8JFjVkej1RgTHxHPwRNKTRPq2ld8cs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dIUlWOQ5mBhV533vT/+Ms77ALTF+QY1rOwwM5nKMe6Hpc9qplXkia+4HGrEa3HD5M
	 5o6zy7+NHFKMyV2Z6k21WTIS+EZLwplhoqemYc2HfQoP0RIW0GhQLW5rD4ilwhjo0d
	 hq3c+RBGJ8vs4N9RW7+DopUdW9UzGq2Sx977QhtU9af2jVvivBrRc5WYMi2aNM6o40
	 YCvx82gQ+QlixOE9rpKa4nBOzL63I3k67jGJfgEhaLzDUwvpHgMDfau+wkq9WB/wfq
	 pGtMiWhzlszh+8f2JEFEnVKrKBJ2p7KT4uGSCa9W9jeBZ/ISDK7XpQZ10W4MrbSBdW
	 iFuPUmdESGa5Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0BE7D88EBB;
 Tue,  8 Oct 2024 18:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728405547;
 bh=L1RQ+YSvqc6sn8JFjVkej1RgTHxHPwRNKTRPq2ld8cs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=U43s2jS948aXjKuAVBUFaSIyTEqIzYR+LoWdQoN8xOLI1J912pJjfIpIQX3dEPZqg
 LzA/ijgvnmxBD/DrGJqpU4t9ujF0m11NJcqxSMjBGupzcQ7XvxJ2BvUACja6fHESdh
 tQ4Kg/J5fL6YMN4hhTy2vKicoZw5yQQdRqBw/eWDI77zT0Oire7/eDClulOaIDlXJB
 TB9eBP/0GV5FP8WzJap1qXguJo+xo7vrC2sDsObCDnVkRg+HNkXwEgQfrmfU9+hqvZ
 zfXlR7hAwvvnC/2RvoBOSrPLUqzX+mDp8gU9laVwkASSnQ0Lj7BgMzvpwt5uo6vO1P
 sTTLLRboeM9bQ==
Message-ID: <11783101-6747-4f94-a817-389c16112073@denx.de>
Date: Tue, 8 Oct 2024 18:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] usb: onboard-hub: Add reset-gpio support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
 <20241008154139.31204-2-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241008154139.31204-2-venkatesh.abbarapu@amd.com>
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

On 10/8/24 5:41 PM, Venkatesh Yadav Abbarapu wrote:
> As part of the reset, sets the direction of the pin to output before
> toggling the pin. Delay of millisecond is added in between low and
> high to meet the setup and hold time requirement of the reset.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
