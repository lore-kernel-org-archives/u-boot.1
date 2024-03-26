Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA94CD11DD
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA1C87F65;
	Tue, 26 Mar 2024 13:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711454499;
	bh=NrE2drfcJ7REOMqq1da2UIxpVXF3Pm49HKKA1yvAyoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxLnMhhawbsXr/bRw2yYkEUxqMqMmUNjoI9elCN95kuKXY+jSnx7Bit/yxwx9UsqV
	 +vCL551Pz+rcLY/lsdeP6i+yfmnl16UGG3HpViylOfgeOGywQjwEsYt21i+AVzyRUb
	 blmS3cbUjYKZFmLXKBApnp2gCGOCJXr8Ubxca6ox7PlxdozVvp/qBMyhlS8xDU3V4a
	 INOpKf0kLEl/FoAoeyWvs317qtZuRnamvkKPPWrmfrPtqR76loABoSddPFxvf/ZUpw
	 lpcQNR+AMC+ft4vSZSsqoJWjXW1SoWCOMoZFmBD8FnfUx1A+H+ILE3e7RMLI3XIhpj
	 2a247/I0e4yeg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DB09287FB6;
 Tue, 26 Mar 2024 13:01:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711454497;
 bh=NrE2drfcJ7REOMqq1da2UIxpVXF3Pm49HKKA1yvAyoU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OM9yCSYuKjnaOVSxSH09HaJ6IbStJ1+YU4OoE5Lfp+1oWTnPXUto55BiJdSIPetvr
 bgSbIhFwwZ6HM4rdlybY/E9GAPT/9kakCQgtHuyF1rv78nk9YTYHYtztZxm8mAJgS8
 2zdzal95/ChMani3ukA5vSMcY1urEZtHmhzUWR1AhuIpdR1z/7yZFCMOyl9Gvfg9Aj
 s1svCa0sPc/bdZdwiF2dSOFzeA7jD7+VMB6YnLX2cYflL2014ayC30ZLxb9JiieAXj
 b3SsZShVGKjXP4l+j6voLlmFOoORORbAfVlmKnW2aoFJaT19TSXMVavH2kgvF7D50+
 R8lxT4VntQ48w==
Message-ID: <87b40ef9-c8fc-473a-bda7-13ccdf5275a1@denx.de>
Date: Tue, 26 Mar 2024 12:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] usb: Add environment based device ignorelist
To: Janne Grunau <j@jannau.net>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 u-boot@lists.denx.de, asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>
References: <20240322-asahi-keyboards-v3-0-3106dd4c4e19@jannau.net>
 <20240322-asahi-keyboards-v3-4-3106dd4c4e19@jannau.net>
 <fcc7e54e-5e52-4b27-bc0c-801954ccf0ca@denx.de> <ZgKKB_j02eAVltTs@robin>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZgKKB_j02eAVltTs@robin>
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

On 3/26/24 9:40 AM, Janne Grunau wrote:
> On Fri, Mar 22, 2024 at 12:56:37PM +0100, Marek Vasut wrote:
>> On 3/22/24 8:47 AM, Janne Grunau via B4 Relay wrote:
>>
>> [...]
>>
>>> @@ -1099,6 +1142,20 @@ int usb_select_config(struct usb_device *dev)
>>>    	le16_to_cpus(&dev->descriptor.idProduct);
>>>    	le16_to_cpus(&dev->descriptor.bcdDevice);
>>>    
>>> +	/* ignore devices from usb_ignorelist */
>>> +	err = usb_device_is_ignored(dev->descriptor.idVendor,
>>> +				    dev->descriptor.idProduct);
>>> +	if (err == -ENODEV) {
>>> +		dev_dbg(dev->dev, "Ignoring USB device 0x%x:0x%x\n",
>>> +			dev->descriptor.idVendor, dev->descriptor.idProduct);
>>> +		return err;
>>> +	} else if (err == -EINVAL) {
>>> +		printf("usb_ignorelist parse error in \"%s\"\n",
>>> +		       env_get("usb_ignorelist"));
>>
>> Please use dev_err() here consistently with dev_dbg() above.
> 
> I didn't use dev_err() since the parsing error is not specific to the
> device. It doesn't matter much. I'll change it and resend after we've
> settled the new discussion about the interface limit.

Then please just clarify this in the commit message, that's fine.

Thanks !
