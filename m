Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10575CA0FE5
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 15:59:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1966F847C3;
	Fri,  1 Sep 2023 17:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693583977;
	bh=PVh7DUH3VOQHx7lwhF2Q3ytkGLJ0Bs6v4Q4iXbp8CS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sYtfXf7/uTRWvwmLepm9TeAAkBvMqBxpMAMhiqnoVMOWvbmz/TWJD3zyA2f9lnl0R
	 3aMBjljpBUne/tbZzWgeDNNM83QKuj0lARyZJzPpcrbjE1iZSLI5u8tDEGLX7DzocS
	 Wdpp2KL3bu315is1hbSGlV8908XYjPEi8B260pwY7sTeSWWExbhuJXfMIBbegston4
	 XdBZsNTQUfGrM/uynvbfPGoSbgOZ1P4G60NFNmjJD8N+NkAQzv/vRdhFwJ06xwjFgp
	 dwOKzIujBTr786bcipJgK5AdVi7243vCWcoKTgrhbuQBzsBR265niCJ/wsJEcgdkKi
	 lkn20CnT05vfw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2DAD984698;
 Fri,  1 Sep 2023 17:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693583975;
 bh=PVh7DUH3VOQHx7lwhF2Q3ytkGLJ0Bs6v4Q4iXbp8CS0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NT+cujMl+1A5LB4IyiGeDI9mSL0YLNdRtEhNVZILW5ammIoM614dYyHXJ1vjDQ6VT
 OYusOSclqqWkP08OSitBKlzmkmkTnOjOs507fKclvi4hc0hpLQlQBFLjqgJseGTmWG
 ZmJ9s7hfRjUb1P8ZqQpeSmsr0BLTaXqGUlvfJ8zpmcABZ7JAaJp6j6rb9Ym0msKZCh
 3maiVh6QWthyVoKGbmQ/ubp8jxYVaypoYXyVBDvhNVqXJlTnEqnuZrG5eLdblnFs8Z
 vi9Iwh0zfORUb6CHZreq0Y/L238q9/UBoTvICA+Tq8jBU7JKreAEnoHomTf2x38Fnh
 arOU5/6j7g/VQ==
Message-ID: <541f6ca4-9ee5-e2c9-7a9e-bc8f13562a8c@denx.de>
Date: Fri, 1 Sep 2023 17:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] usb: host: ohci-generic: Make usage of clock/reset bulk()
 API
Content-Language: en-US
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
References: <20230830080150.473374-1-fabrice.gasnier@foss.st.com>
 <84041468-abf2-9b68-6701-6605f4948bf5@denx.de>
 <2e1cf0cd-1d98-16fe-97e8-96604bbb009c@foss.st.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <2e1cf0cd-1d98-16fe-97e8-96604bbb009c@foss.st.com>
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

On 9/1/23 14:05, Fabrice Gasnier wrote:
> On 8/30/23 17:18, Marek Vasut wrote:
>> On 8/30/23 10:01, Fabrice Gasnier wrote:
>>> Make usage of clock and reset bulk API in order to simplify the code
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>> ---
>>>
>>>    drivers/usb/host/ohci-generic.c | 92 +++++++++++----------------------
>>>    1 file changed, 29 insertions(+), 63 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/ohci-generic.c
>>> b/drivers/usb/host/ohci-generic.c
>>> index 2d8d38ce9a40..95aa608d8c19 100644
>>> --- a/drivers/usb/host/ohci-generic.c
>>> +++ b/drivers/usb/host/ohci-generic.c
>>> @@ -16,75 +16,41 @@
>>>      struct generic_ohci {
>>>        ohci_t ohci;
>>> -    struct clk *clocks;    /* clock list */
>>> -    struct reset_ctl *resets; /* reset list */
>>> +    struct clk_bulk clocks;    /* clock list */
>>> +    struct reset_ctl_bulk resets; /* reset list */
>>>        struct phy phy;
>>> -    int clock_count;    /* number of clock in clock list */
>>> -    int reset_count;    /* number of reset in reset list */
>>>    };
>>>      static int ohci_usb_probe(struct udevice *dev)
>>>    {
>>>        struct ohci_regs *regs = dev_read_addr_ptr(dev);
>>>        struct generic_ohci *priv = dev_get_priv(dev);
>>> -    int i, err, ret, clock_nb, reset_nb;
>>> -
>>> -    err = 0;
>>> -    priv->clock_count = 0;
>>> -    clock_nb = dev_count_phandle_with_args(dev, "clocks",
>>> "#clock-cells",
>>> -                           0);
>>> -    if (clock_nb > 0) {
>>> -        priv->clocks = devm_kcalloc(dev, clock_nb, sizeof(struct clk),
>>> -                        GFP_KERNEL);
>>> -        if (!priv->clocks)
>>> -            return -ENOMEM;
>>> -
>>> -        for (i = 0; i < clock_nb; i++) {
>>> -            err = clk_get_by_index(dev, i, &priv->clocks[i]);
>>> -            if (err < 0)
>>> -                break;
>>> -
>>> -            err = clk_enable(&priv->clocks[i]);
>>> -            if (err && err != -ENOSYS) {
>>> -                dev_err(dev, "failed to enable clock %d\n", i);
>>> -                clk_free(&priv->clocks[i]);
>>> -                goto clk_err;
>>> -            }
>>> -            priv->clock_count++;
>>> -        }
>>> -    } else if (clock_nb != -ENOENT) {
>>> -        dev_err(dev, "failed to get clock phandle(%d)\n", clock_nb);
>>> -        return clock_nb;
>>> +    int err, ret;
>>> +
>>> +    ret = clk_get_bulk(dev, &priv->clocks);
>>> +    if (ret && ret != -ENOENT) {
>>> +        dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);
>>
>> Plural of 'clock' is still 'clock' , please fix just the text, keep the
>> variable name .
> 
> Hi Marek,
> 
> Are you sure ? Taking a closer look on the web, also in Linux or u-boot,
> I can see plural of clock is clocks. Documentation also deals with
> multiple clocks too.

I also looked it up in a dictionary now and even asked about it, 
clearly, I am wrong. Sorry.
