Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10811CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 14:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 525838460E;
	Wed, 24 Jun 2026 16:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wN+y28TL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFBA684671; Wed, 24 Jun 2026 16:29:01 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA3580398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 16:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4glkp04HNgz9vC4;
 Wed, 24 Jun 2026 16:28:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782311336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlJTSQVEUq3w4Ml7KnljPqhv6bWw0xrqK4EjtfCnvAA=;
 b=wN+y28TL/qBRCdw17VaICuE6ZvoBsionByACEB7RJ5hsWbfiWqEsXwLFLskQmDvvFnkOHL
 Yzfippfm72FIkV+co4zNVvVqQndAopaQ2yZNS0j6fJIHYsIck4RYBfGFWQkpK0T8cb0c1A
 6iCNb/Rlqy0xrLs8npjL288ihOVS7bap04f295MGJDvL4VanJ3TYqbTjHi5DHC/yxTRouE
 2bIStleWndverdSOEIzTzWGNbpRz8Tr3XTD0616qApq5SYnSHS7aO+AHXq37XmrQh6YrCA
 bieoXVWP6I2e/q4qHquPT1t3jnQ1cYXPO7xkZxLwTzzCg7/dMgtNjY2gSmZvAg==
Message-ID: <317edc52-aaad-4778-bae3-7ce177f49e84@mailbox.org>
Date: Wed, 24 Jun 2026 16:28:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: onboard-hub: Add support for Corechips SL6341 USB
 2.0/3.0 hub controller
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>
References: <20260512-sl6341-v2-1-fd5fc55e1f38@flipper.net>
 <14653d07-924c-46bc-9d3a-f1681e85053b@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <14653d07-924c-46bc-9d3a-f1681e85053b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7992b98892ebe5f3fd0
X-MBO-RS-META: b4x9ibg613d7qhdpntqs6d97cpqzemgp
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

On 6/24/26 4:15 PM, Quentin Schulz wrote:
> Hi Alexey, Tom,
> 
> On 5/12/26 3:55 PM, Alexey Charkov wrote:
>> Corechips SL6341 is a 4-port USB 2.0 and 3.0 hub controller. It always
>> requires external 1V1 power and can optionally use external 3V3 power
>> (or alternatively it has a 5V->3V3 LDO built in to derive 3V3 power from
>> VBUS). It also exposes a reset pin.
>>
>> Device tree bindings are merged for upstream release with Linux 7.1 as
>> commit bfcb86e58f3a ("dt-bindings: usb: Add Corechips SL6341 USB2.0/3.0
>> hub controller") [1]
>>
>> Link: https://github.com/torvalds/linux/commit/ 
>> bfcb86e58f3a58d05b95970d81b94cb011982780 [1]
>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>> ---
>> Changes in v2:
>> - Fixed the comment to correctly indicate the USB 3.0 entry
>> - Added an upstream commit reference for the DT binding
>> - V for volts in captials (commit message, thanks Marek)
>> - Reordered the compatibles by lexical order, not hex order (thanks 
>> Marek)
>> - Link to v1: https://lore.kernel.org/r/20260512-sl6341- 
>> v1-1-2819ac19e050@flipper.net
>> ---
>>   common/usb_onboard_hub.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>> index 6fc34489a98f..0684f7bfd479 100644
>> --- a/common/usb_onboard_hub.c
>> +++ b/common/usb_onboard_hub.c
>> @@ -262,6 +262,12 @@ static int usb_onboard_hub_remove(struct udevice 
>> *dev)
>>       return ret;
>>   }
>> +static const struct onboard_hub_data corechips_sl6341_data = {
>> +    .reset_us = 10000,
>> +    .num_supplies = 2,
>> +    .supply_names = { "vdd1v1-supply", "vdd3v3-supply" },
>> +};
>> +
>>   static const struct onboard_hub_data usb2514_data = {
>>       .power_on_delay_us = 500,
>>       .reset_us = 1,
>> @@ -285,7 +291,13 @@ static const struct onboard_hub_data usbhx3_data = {
>>   static const struct udevice_id usb_onboard_hub_ids[] = {
>>       /* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>> -    {    .compatible = "usb424,2514",    /* USB2514B USB 2.0 */
>> +    {    .compatible = "usb3431,6241",    /* Corechips SL6341 USB 2.0 */
> 
> Would be nice to have an additional newline after the opening curly 
> bracket to avoid this unnecessary chunk in the diff next time we add 
> support for yet another USB hub. It's also a bit surprising to add it 
> first in the list instead of last, but eh, nothing too important.
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> @Tom, can you take this for next please?
Why would Tom collect USB patches ?
