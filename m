Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C36D13588
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 03:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FCC488C53;
	Mon, 28 Oct 2024 04:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730085574;
	bh=V67iAQLXWtwy6SLI0Pn0YmtF+VGnvHWxbcPgHvNmUXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D2mdicYUhjm1ALVvjrfx635+/vfjJYWlsz+5YQyjDmbhcHRzNBBZmA3tWbOADOujn
	 vWMVgHUxRl0xJXKR1Kq6INXaEZf8cKtznhMXSvtVZOa6I1IJdn/Yx0CiUvBmlQATr+
	 D8zh4+KSURCTVglkALP/4efpo4VlSfXNmSowJTSA5MrjrwjonAlhq/3jkVtY/rULUO
	 YnUNPNdMs91Cg6OHSnC8+PQ/VI/3SfyTfQzsrY+3T8DqZxK7v/bUtJLlY5ZOE8Rt4u
	 V4KqBvzWR74ncPtOqmpYrb27e+Caq4xByL8MP0H/bOOzsvmsr1l3Qu/9w2bDscRPWL
	 GYBeAYb+3vdgg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C346988FD6;
 Mon, 28 Oct 2024 04:19:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730085568;
 bh=V67iAQLXWtwy6SLI0Pn0YmtF+VGnvHWxbcPgHvNmUXQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pktLbpLwUCNNVHwK1QQu1M+jTLY8Z2NR5+cxYD0ER7+eVVtVmG1NWa48cp8t1uuVX
 OPz/3cqeJpFpkG8WwADxllN8lgg9xwietwkMLgL1vc+23gwj6Jk9wTL6ZfxflWrXaN
 WZmt7v52HRpCz8st7rozrbQb9BYrvY/7DIVHR+Va051zXPUwC4Xjio39lwKLHlFW5+
 HHmoi9Wf/JXn2vfrCGE1l8AgdLZX153o8cJ9tPR8Y8DzKYVOYdDpXjisP489O6pWe6
 k8os2HRH+wzPWv1h/jxJszxrWbvmIBfdV7GEMGT4n6jarWw3xB7gkLGEEgKqyCK3gC
 51JY85aJWKLeQ==
Message-ID: <49fac6ee-3602-4860-b475-1148126131ff@denx.de>
Date: Mon, 28 Oct 2024 03:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] eth: asix88179: Fix drop of large fragmented packets
To: Khoa Hoang <admin@khoahoang.com>
Cc: u-boot <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20241027051250.35627-1-admin@khoahoang.com>
 <20241027051250.35627-3-admin@khoahoang.com>
 <45e7d331-f72a-40a2-8519-3c81ab00ec8d@denx.de>
 <192d042cde3.be30af8c153741.7905134334586786560@khoahoang.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <192d042cde3.be30af8c153741.7905134334586786560@khoahoang.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/28/24 12:14 AM, Khoa Hoang wrote:
> ---- On Sun, 27 Oct 2024 07:43:26 -0700 Marek Vasut  wrote ---
> 
>   > On 10/27/24 6:12 AM, Khoa Hoang wrote:
>   > > When receiving large fragmented packets, the ASIX 88179A can drop
>   > > packets due to an insufficient URB buffer size. This change adjusts
>   > > the URB buffer size to match the configuration used in the Linux
>   > > kernel, resolving packet drop issues observed when performing TFTP
>   > > with a 16KB block size.
>   > Is there a test case ? Can you please include it in the commit message ?
>   >
>   > Thank you
>   >
> To reproduce this issue, set the following configurations in the config file:
> 
> CONFIG_IP_DEFRAG=y
> CONFIG_TFTP_BLOCKSIZE=16352
> CONFIG_TFTP_WINDOWSIZE=1468
> 
> Then, run tftpboot, and it will fail to load with a timeout error:
> => tftpboot zImage
> Using axg0 device
> TFTP from server 192.168.128.130; our IP address is 192.168.128.244
> Filename 'zImage'.
> Load address: 0x20000000
> Loading: ##T T T T T T
> Retry count exceeded; starting again
> 
> I’ll include this information in the commit message in the next version.

Thank you!
