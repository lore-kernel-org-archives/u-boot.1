Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4436C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 16:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05D4387EDD;
	Sun, 17 Mar 2024 17:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710692562;
	bh=YRqO7gUGcvQXjOqCvdbpKcyfFP5ACW7NQhaGd3q5BtQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YoUwORAUTbVo+Hp+xwAiVISWbPJD8poTfGwLBHlOV6CFKdQLi4OXhNb1sa0PvOWoo
	 /V/KxD07cA/0A/H4lra+Qf+mZ3mzCfNP0uF//tfHX7kH14ZRfVs/4428rFczeGlXQh
	 AAs84kGPJ2hX0uLkiMlr4CoSzw4si57z4vKMRz3x2s7kzqOJR9cRcJeJsJBoUJIqou
	 L2Tb0lCj9mn69CqgYAoH1JJyGHeUk+Fpxzen+XsGXydYRmPjh/FGHkMsQ1m6NS11V1
	 4EOxqeWmAhLh/d0UY9BzTvLVZWfKxzP8X5Pje9wqUBPTZ7K4w9G/VZWuTZXsqrT9u/
	 NZ5KJX/4DThYg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D9726879F3;
 Sun, 17 Mar 2024 17:22:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710692560;
 bh=YRqO7gUGcvQXjOqCvdbpKcyfFP5ACW7NQhaGd3q5BtQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UfzGc8ROi6aiVDGEVvCEkrqnNRQ7QLMKjV2OWUHWconFUx2UGX3G+IwbDKuRuLQyc
 qL503OJHoJpicKMscr8ELfUaUeljszLquC/7eODjQLbPqbzF0Hi3LUfFTPyJx+n+m7
 qZ2g7SkAh01bbG5r5rF/pjwF+VPv5yvmiG5Os4OgZyx/Hl6cCXUAG1zPnTC5t1s56V
 I+bnMCNF5pNq+3U19q6UiLRvVnz2ShC1rTQEgIID9+5svAHrj+3jwmyAUJyiAb6gmV
 rq91Z1sEd4n1ervbkzFvc6VSd+TUFUhMiDLDIP4S13khMAGtvs20thGZw3ezwUteI4
 lrF9VYSWb/9Zg==
Message-ID: <dc748670-27ba-41e3-ae68-c4c35e90fe59@denx.de>
Date: Sun, 17 Mar 2024 17:07:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] usb: Add environment based device blocklist
Content-Language: en-US
To: Janne Grunau <j@jannau.net>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
 <5faec4e0-c375-4bc1-9eda-ca7da14eea3b@app.fastmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <5faec4e0-c375-4bc1-9eda-ca7da14eea3b@app.fastmail.com>
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

On 3/17/24 12:34 PM, Janne Grunau wrote:
> Hej,
> 
> On Sun, Mar 17, 2024, at 12:07, Janne Grunau via B4 Relay wrote:
>> From: Janne Grunau <j@jannau.net>
>>
>> Add the environment variable "usb_blocklist" to prevent USB devices
>> listed in it from being used. This allows to ignore devices which
>> trigger bugs in u-boot's USB stack or are undesirable for other reasons.
>> Devices emulating keyboards are one example. U-boot currently supports
>> only one USB keyboard device. Most commonly, people run into this with
>> Yubikeys, so let's ignore those in the default environment.
>>
>> Based on previous USB keyboard specific patches for the same purpose.
>>
>> Link:
>> https://lore.kernel.org/u-boot/7ab604fb-0fec-4f5e-8708-7a3a7e2cb568@denx.de/
>> Signed-off-by: Janne Grunau <j@jannau.net>
>> ---
>>   common/usb.c              | 56
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   doc/usage/environment.rst | 12 ++++++++++
>>   include/env_default.h     | 11 ++++++++++
>>   3 files changed, 79 insertions(+)
>>
>> diff --git a/common/usb.c b/common/usb.c
>> index 836506dcd9..73af5be066 100644
>> --- a/common/usb.c
>> +++ b/common/usb.c
>> @@ -1084,6 +1084,57 @@ static int usb_prepare_device(struct usb_device
>> *dev, int addr, bool do_read,
>>   	return 0;
>>   }
>>
>> +static int usb_blocklist_parse_error(const char *blocklist, size_t pos)
>> +{
>> +	printf("usb_blocklist parse error at char %zu in \"%s\"\n", pos,
>> +	       blocklist);
>> +	return 0;
>> +}
>> +
>> +static int usb_device_is_blocked(u16 id_vendor, u16 id_product)
>> +{
>> +	ulong vid, pid;
>> +	char *end;
>> +	const char *block_str = env_get("usb_blocklist");
>> +	const char *cur = block_str;
>> +
>> +	/* parse "usb_blocklist" strictly */
>> +	while (cur && cur[0] != '\0') {
>> +		vid = simple_strtoul(cur, &end, 0);
>> +		if (cur == end || end[0] != ':')
>> +			return usb_blocklist_parse_error(block_str,
>> +							 cur - block_str);
>> +
>> +		cur = end + 1;
>> +		pid = simple_strtoul(cur, &end, 0);
>> +		if (cur == end && end[0] != '*')
>> +			return usb_blocklist_parse_error(block_str,
>> +							 cur - block_str);
>> +
>> +		if (end[0] == '*') {
>> +			/* use out of range idProduct as wildcard indication */
>> +			pid = U16_MAX + 1;
>> +			end++;
>> +		}
>> +		if (end[0] != ',' && end[0] != '\0')
>> +			return usb_blocklist_parse_error(block_str,
>> +							 cur - block_str);
>> +
>> +		if (id_vendor == vid && (pid > U16_MAX || id_product == pid)) {
>> +			printf("Ignoring USB device 0x%x:0x%x\n",id_vendor,
>> +			      id_product);
> 
> this is a leftover from testing, already removed locally

You could turn this into dev_dbg()
