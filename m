Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A4BC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 02:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F808855D;
	Tue, 23 Apr 2024 04:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713840957;
	bh=FWs0FxrjEjLBC8HQ6fFb5RJcWYY9/XWl+H99N916p4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D8O4OBcm/V7Zf4zdtXAE6ONLFYEn1dq6UgDxgOA5vb2xXzWtM6W4FD8lV1rHrhSIL
	 KEzGRpkHIINANWvqkrmYLEHasDqCimmMLPhAoKZYovpuQLNqAQqxGggDfKxNraoPm/
	 gU+hOTgcvs9tItvA2891N2jBDAm5eVT9IRhGeEOh2CFuHc6SfBsBH1MYVSPZWvWRB9
	 8r1uHWKZiCTFhzyYtMj3sWd0zeEYjTON8gbMh8/J8+fdE/52zQkdcmVpkEn4Vk8W5H
	 n3fV4AYgvwfGgUSBWcn3ZUD4BJ2NwLF6cFJUpHKSSNo1u1VlV5FWUkxUSfn5wng7NX
	 1MWAIQPMO8GWA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 496DC8854E;
 Tue, 23 Apr 2024 04:55:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713840954;
 bh=FWs0FxrjEjLBC8HQ6fFb5RJcWYY9/XWl+H99N916p4w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Hm0m2x6xvSaeGzBqxKndBmgzFRiR+EDeo8J8+FqNzkH6CrnhyeySiB3NtP4aTOXhC
 m696RC9rWNlqIyY31wUmZV2gbXotJseWi6BUzIL51nFyW6B1jyyHO4fbddDC52vhpI
 loo0pdhKLq+oR1WIMvAndVRC3PjDAwFSFIcx34IMdipe6IDKlJagZBFnqReQvnfKJU
 DipEIjlaUXoxlFQBwDIE04TADOwdPrvwlndfVenFy+cfoJp4Fb58US/A8NZ5Z/+u6P
 0V+8sZz1Dqs+ZDeB9nZKeGC6Bp9e0cP+llsty9iuT96DDxUea2stuR99pAV6/1OWN9
 Z7aI6/h63O4PA==
Message-ID: <a731279b-67eb-48f6-a5cf-5a427e1cb46d@denx.de>
Date: Tue, 23 Apr 2024 02:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: support USB 3.1 controllers
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
References: <20240411160527.835767-1-caleb.connolly@linaro.org>
 <9793571e-fdb1-41d5-b967-948dabe9bc4a@denx.de>
 <66f19871-1c7b-4b85-a924-42ee03c1f241@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <66f19871-1c7b-4b85-a924-42ee03c1f241@linaro.org>
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

On 4/22/24 12:53 PM, Caleb Connolly wrote:
> 
> On 21/04/2024 22:38, Marek Vasut wrote:
>> On 4/11/24 6:05 PM, Caleb Connolly wrote:
>>> The revision is different for these, add the additional check as in
>>> xhci-dwc3 core_init code.
>>>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>
>> Is there a matching Linux kernel patch , or does Linux do some other 
>> check ?
> 
> I just took this change from the xhci-dwc3 driver tbh... But I did some 
> archeology and it seems the associated Linux patch would be 690fb3718a70 
> ("usb: dwc3: Support Synopsys USB 3.1 IP").

Can you please mention it in the commit message, and send a V2 with my:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks
