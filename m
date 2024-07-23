Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DE3C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A0D388881;
	Tue, 23 Jul 2024 15:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721742768;
	bh=TBqy2S4lHisjk94OMk+ankHL5n2jfjrOmsYzY5F2IOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V4AJ7EFdRKOSyfJA95sn6DVP7W+rEHw6f0lYXzyDG4RLtvJnF9VFHoPIyrff/tKJX
	 /0YVm/LdpV11S0JDqxc8i3RIFBclvKSpxSAb5wBXCIXUGG8RBNs1kTh+MsHvV0u4QI
	 5EQLeqZwYTbBoJ5dhpVV7eZsfcfiFizRLDdoC6scaZue34V/BvZ4btdxvwEeja1+oF
	 9jiomC4y0FQm1PJEIDPjafmrrVMlst1kZpShSiUeAZTLaHjPSvfTl49n6M79dMJ0Qm
	 dnYOz84wSuH8Ca+nuNvhcpB2JlkO5VJxKrLkJJhQdg52s9Afa1aFXTBqaz/3mknBsY
	 Z/xCemWkNWLew==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EEF0D887FA;
 Tue, 23 Jul 2024 15:52:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721742767;
 bh=TBqy2S4lHisjk94OMk+ankHL5n2jfjrOmsYzY5F2IOo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GhhSrxjzy4mI2EAO325Kga5QrFM1wpX91I6y2hJWsm+6ZOu9WgCZAEljDl3cyQgHA
 zBE/1ZvwXWrVFclbKsuauaRNrjwisslLwALw7GZHA0AO89N+w0KCOoKlueFQfsV4vI
 l8V4X8IFwDPDGPsal3/s3w5xA9J3+yrV1wSzE+BXjv+hvGMkO2HlFAbj5+wm1a0qKh
 kkBuiebuEG8pmCce2ug5ZSw3ACTVCoI0pchGb5jo2A4Lvp/yQy6azja0Rn/SV5NRB6
 iCVsiItpVBIyl7f8aiJnKpdCf0Jx+ffPk6ruFC7NjEKIWBhNepb03WAE7iIm8RGSJb
 L36zZC226dKSg==
Message-ID: <20ec5d58-ea88-4e38-86cd-4522ad87435f@denx.de>
Date: Tue, 23 Jul 2024 15:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] usb: gadget: atmel: Fix typo in
 usb_gadget_register_driver()
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-4-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240723131817.262596-4-zli@ogga.fr>
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

On 7/23/24 3:18 PM, Zixun LI wrote:
> Replace "paramter" by "parameter".
> 
> Signed-off-by: Zixun LI <zli@ogga.fr>

Reviewed-by: Marek Vasut <marex@denx.de>

This is really MUCH better and MUCH easier to review, thank you!
