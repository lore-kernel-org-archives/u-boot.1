Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB854CEFD0C
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0953A83C08;
	Wed,  7 Jan 2026 01:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qF4lGv2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB3983C4B; Wed,  7 Jan 2026 01:03:09 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D51839DE
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dm7XT4n7Zz9sVv;
 Wed,  7 Jan 2026 01:03:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767744185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVpJjB9aW6vLNtrMy2CIIx+/apTGxrOP8+Jz6TLrzdE=;
 b=qF4lGv2V6qpmSBFkBzhEr2hOnBzv9sg/oxWJ+jAZRUc0eziHHvJHoCULe/BdYrVJIPjaus
 FTUtMGvyvATZf1kRNCfmrSNJCFHWdAmK35lYoa+3c92qQP3uu16fnf29ysJYiXQFTZ8p/f
 2wLGOkKkYUaDvhTm0Wd3cShuJmX7TzTKbVesT6Wqi8Y4eV/jpjH+Q4Lghn0RTvdybGWqcH
 I1J5WO5R9C3q+onEZLp2mw+lJj+5xQrWrgnNWR3EaZpj6DbYnQpPpkWK0pQeBEkcTqBucG
 PNemr6Fj8vj6YrwdDMAIVRqsbIFwCF2mVu9s5RgVW1on2liLaulhPypVhY0IQg==
Message-ID: <702afe1c-ef45-4628-a4b6-fb52440e996c@mailbox.org>
Date: Wed, 7 Jan 2026 01:03:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: Add power sequencing driver for PCI slots
To: Sean Anderson <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260106223409.748335-1-sean.anderson@linux.dev>
 <bafc0b79-9126-4cdc-92d1-dd6fe2f884ac@mailbox.org>
 <70d036ee-e61b-44bb-9160-697e4d3f75e1@linux.dev>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <70d036ee-e61b-44bb-9160-697e4d3f75e1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j4bh5mjbemmewto5oupre73c4sn4sz9e
X-MBO-RS-ID: 4cbb7ca15041050df96
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

On 1/7/26 12:32 AM, Sean Anderson wrote:
> On 1/6/26 18:14, Marek Vasut wrote:
>> On 1/6/26 11:34 PM, Sean Anderson wrote:
>>> Extend the PCI bridge driver to enable resources associated with PCI
>>> slots like clocks, power rails, and resets. This is modeled off of the
>>> PCI power control subsystem in Linux. The traditional compatible for PCI
>>> slots in U-Boot is pci-bridge, but Linux uses the more-systematic
>>> pciclass,0604 so add that as an option.
>>
>> Oh, nice :)
>>
>>> +static int __maybe_unused pci_bridge_probe(struct udevice *dev)
>>> +{
>>> +    struct clk clk;
>>> +    struct gpio_desc perst;
>>> +
>>> +    if (!clk_get_by_index(dev, 0, &clk)) {
>>> +        int ret = clk_enable(&clk);
>>> +
>>> +        if (ret)
>>> +            return log_msg_ret("clk", ret);
>>
>> Should we use dev_err() instead ?
> 
> I thought we weren't supposed to log by default in device drivers to reduce text size?
Tom had a different take on it, lets wait for him. Me personally, I like 
the dev_* functions as they are compatible with Linux ones, which is 
nice and non-confusing.
