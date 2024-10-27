Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BB8D1356D
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CDAD88E78;
	Sun, 27 Oct 2024 17:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730045355;
	bh=KaeP0ij6aTIsBXOK6rpt4cj39lI9YMPbQAo3cjyBVBM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ro0H6iCpTvGiw4NNnAxF2L3w63iWifBPmhqm7VlB7osMCZSGjeEbSCm+2doiZCef2
	 5dRm5FU2huLHezpPcu0ZsR/sAi/1VJj34VsRnafdAb/qG71SYurBXyIj8pcMQ4Ex8c
	 Ibc6lW3OAdwjczqvP5j8UCs/NZxG9LpLLnYzkA/ZhzIyMpn7EIQwz0g4vyEbuWd3Mn
	 vMcGi2vSf1zfQJha+XZykx7Z0S0SvrnSLm1tMdQyFG9zpv0cRs7WGz33+r4SJxsh/6
	 Y5ApksQZBLlyUABE+tqZcFKNF0uY180m3+oFdrvQU7ajJIVprBJ82LCN8rcIgubOxb
	 zWUMklElF6mZw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C0990881A5;
 Sun, 27 Oct 2024 17:09:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730045354;
 bh=KaeP0ij6aTIsBXOK6rpt4cj39lI9YMPbQAo3cjyBVBM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=zwVHOz/KEQYtVO0le/ssqhkUzzEg8IWV+qE0oyS5zkFOcshD3KU0+fZXTRNfTb8Op
 X4e7lxXB5dRgx0pzLQwh0nCplS1k8M+mwAdQj5W+L5XeDUy+PNMqpl96v+4IWlknBb
 73wcnAiePGx89tM2uEBI/TAlDW8auTvlGPeYZBfzU52rXnI/EZ9QN5/DcAWBw2vBWJ
 6BlgeuK+WZNzH6KxkvNbHJk7AU7FCvrxOBLCEm8PianshZ2BhAzRqeihvYWC08BQd8
 dQQFKMbEph0UJSh3CNS52AY705Llc2aDWwXhT9QGwqNEAZD3u0VL4zEO/WA+WFiT1L
 sF8XApHWhQIYQ==
Message-ID: <45e7d331-f72a-40a2-8519-3c81ab00ec8d@denx.de>
Date: Sun, 27 Oct 2024 15:43:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] eth: asix88179: Fix drop of large fragmented packets
To: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241027051250.35627-1-admin@khoahoang.com>
 <20241027051250.35627-3-admin@khoahoang.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241027051250.35627-3-admin@khoahoang.com>
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

On 10/27/24 6:12 AM, Khoa Hoang wrote:
> When receiving large fragmented packets, the ASIX 88179A can drop
> packets due to an insufficient URB buffer size. This change adjusts
> the URB buffer size to match the configuration used in the Linux
> kernel, resolving packet drop issues observed when performing TFTP
> with a 16KB block size.
Is there a test case ? Can you please include it in the commit message ?

Thank you
