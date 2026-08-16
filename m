Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BB8C5B572
	for <u-boot@archiver.kernel.org>; Sun, 16 Aug 2026 23:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27E8A4065D;
	Sun, 16 Aug 2026 23:44:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XlsecgTjNdl; Sun, 16 Aug 2026 23:44:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFE3F40634
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786923883;
	bh=laG3jyQh+EmpNSHJXraPQvL6biPAoSRwOcfpxJgFv/Y=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rs5Xoau6XJmzKtcQkUNBfwDHvBmOPV7F72GlmFomK2QGvAhGojgZfgsAKVGv1ZFh5
	 smU1c93sfR25DXOEa5xrOkz7rnNC+x+eI7X0fTOujDm2uQLjPG42i0A5uJjD+4T2rQ
	 x3wz9V67svuLyF8w/RU064i44D29wQvSKMYTBclmdH+WfTQSOk/M1B8XbaLHLkJVG4
	 JZ4grdmkx5XBK8PWcJGZuRIUA4zrPKSFsb9qbp2Z6u29hsNsHXuklBHQeB14ahZXT0
	 HHyvxHDgm2AL6LZeArnfneB5FkKe9He19+3Xoiq/gWZXJjT50ajyPbNVtRhzsyw0W7
	 3ZNEDcrjdZt4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFE3F40634;
	Sun, 16 Aug 2026 23:44:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 99C802B2
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B41980C45
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i3oJyGo2yODs for <u-boot@lists.u-boot-project.org>;
 Sun, 16 Aug 2026 23:44:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5CCA280C42
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CCA280C42
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CCA280C42
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:40 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hNXck3283zMlFV;
 Mon, 17 Aug 2026 01:44:38 +0200 (CEST)
Message-ID: <6c19074c-3372-4631-8985-a45f33cbbebc@mailbox.org>
Date: Sun, 16 Aug 2026 13:32:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] gpio: dwapb_gpio: Enable all clocks
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260814-rzn1-2026-10-gpio-v2-1-7490cc61b337@linaro.org>
 <9eb93d89-41f9-4c9b-a876-22e6f496443a@mailbox.org>
 <aoByMCnVSX_GyuU5@maple.netwinder.org>
Content-Language: en-US
In-Reply-To: <aoByMCnVSX_GyuU5@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jg41919dwptjtkobti767ddjgzt9ks1r
X-MBO-RS-ID: 2d8e0383493b39aa992
X-Rspamd-Queue-Id: 4hNXck3283zMlFV
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/15/26 4:05 PM, Ralph Siemsen wrote:
> On Sat, Aug 15, 2026 at 12:05:55AM +0200, Marek Vasut wrote:
>> On 8/14/26 8:29 PM, Ralph Siemsen wrote:
>>
>> [...]
>>
>>> @@ -132,12 +134,34 @@ static int gpio_dwapb_reset(struct udevice *dev)
>>>      return 0;
>>>  }
>>> +static int gpio_dwapb_enable_optional_clocks(struct udevice *dev)
>>> +{
>>> +    struct gpio_dwapb_priv *priv = dev_get_priv(dev);
>>> +    int ret;
>>> +
>>> +    ret = clk_get_bulk(dev, &priv->clks);
>>> +    if (ret) {
>>> +        /* Clocks are optional */
>>> +        if (ret != -ENOENT)
>>> +            dev_err(dev, "Failed to get clocks: %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = clk_enable_bulk(&priv->clks);
>>> +    if (ret)
>>> +        dev_err(dev, "Failed to enable clocks: %d\n", ret);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>  static int gpio_dwapb_probe(struct udevice *dev)
>>>  {
>>>      struct gpio_dev_priv *priv = dev_get_uclass_priv(dev);
>>>      struct gpio_dwapb_plat *plat = dev_get_plat(dev);
>>>      if (!plat) {
>>> +        gpio_dwapb_enable_optional_clocks(dev);
> 
>> Error is not propagated from this call.
> 
> This was intentional. All existing users work without explicitly 
> enabling the clock. They probably do it in board specific code, or in a 
> previous boot stage.

ENOENT (clock not found) is fine to convert to 0 and return that 0 to 
cover such cases. Other errors (e.g. ENOMEM?) should be propagated.

> While adding clk_enable() should be harmless, what if it fails on some 
> of the existing boards? I would rather not break them, this can be quite 
> hard to debug.

If the users care and test, the error will get found and fixed. Else, 
apply best effort, sigh.

>> Fail path that would disable the clock is missing in this function.
> 
> Okay, I can add this.
Thank you
