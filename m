Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B10CF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 14:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9DC88A43;
	Sat, 21 Sep 2024 16:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726927519;
	bh=GPqhxwfo36Dy7HpcTubZB77Y/90egHY2HzVKOCiis9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LPw8+cJbENiOlKFJzktkBFsEI5s2KI5LnLLo/Q6V+c9AUoSswU/BsCFDPb0L02cGl
	 /aP8edWMk8sw8r38KmeogoIjZng9KE3UJ/dHwEuiUxa3IgsSgBK7s98XNwNzhX2qUS
	 11UmzijpQimmv41cOYpziuO/zHSaQwjvnTVhSbPgMfF+TBMMnuwP8KgeOA4w7In5bU
	 sI300z58dDuIxjct3ccMGrG1uYQz6ejCwnmyuNY3GyHJ6a+gMqciz28gnMyNvkkCMf
	 x+M3VeXLStMjJWVrcJFK7SyplF0eM1zOd3qcq0Yy31HkqrREQCu0VcoU9/CUVh9j0U
	 y6ohOXbQzV2lw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 712F8889CD;
 Sat, 21 Sep 2024 16:05:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726927518;
 bh=GPqhxwfo36Dy7HpcTubZB77Y/90egHY2HzVKOCiis9E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=r48AzCAMoswq6ByojWMzv/oVMQ6uH+YjlAFCJLhjH4GFcNlTwKA4gBVKXWKQncHih
 6nqzqSNyxnihNxFPVzg3Ft5mVnFLfTZrj8WLRZNg57kr0oe5aLiU6vgnqzeSwCitNO
 tDbxzwqw8F+AGIZfZkSgP9aF6kup6V6k7+M6+UObx9WWjQkuFOq3jme2Qh6LBs+44z
 mbxygODdNm3T/J4cv2V3S5EJg1GL44OFzKvsvRvM6YnAxJg9236rmJ1UHf1WKmJK29
 T6nvrQguM0nIUIxb9475nnPkT2dcs6PTfDA2UMRpt9NGgQuinelJBeh9eUevZqCXiH
 tARFwD8wejJjA==
Message-ID: <9eca93ee-0368-49b3-951c-6953d8b2a3b6@denx.de>
Date: Sat, 21 Sep 2024 15:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/20] arm: socfpga: agilex5: Add new system manager
 base addresses
To: tien.fong.chee@intel.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-2-tien.fong.chee@intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240920070242.20884-2-tien.fong.chee@intel.com>
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

On 9/20/24 9:02 AM, tien.fong.chee@intel.com wrote:
> From: Tien Fong Chee <tien.fong.chee@intel.com>
> 
> Initial creation of new system manager base addresses for Agilex5.
How much of this can be converted to DT probing ?
