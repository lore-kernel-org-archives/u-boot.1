Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6671CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 11:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3142A80D86;
	Mon, 28 Sep 2026 11:55:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QrYq4lZrbDw7; Mon, 28 Sep 2026 11:55:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 139DD80D73
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596519;
	b=ZmILbYlE+hT2ynGMrs3vX415K/CWxJg/daQaS+jDU+jkyG83fsofdsTCJ7aPQ1kx8pxJ
	 fZHMg0Qm9k3jkvzOu2VIPX2ZFw2wEQy6Iy0aI4mhON8TqkzSLJpr4qBLhunGV5UZ3J6Hl
	 qkjTs7KpaqDGUiX9actCyBo9GIIJ5vOlWjoVNA3e59xHvwShoosMqb3QGaURc6cVXQ1E5
	 AxwRF7OzghqKAoL1BR2EG9zNuf/v1b1NpHHeQM7D0NJX4wRPXK+6ZvDRSS6+gf3PitTqS
	 kF2WBxnWpDNcfXDQDMsvuCwpnqCHusclFYCmWlCuX3I6aGi2yH+YgoeLq+TxqZya60g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T0Hcc1PDrH7R4eJgSztYTs6jUDXucLZmh8Tw+q7NVSg=;
	b=lVMBVkihN4Absj+JWk90KijNGY7FOoDUPI/uyMGqitIQoPfpn1s/z7jvba5qKh9KzlsB
	 jlAtBw5w6oFf9Ce9A8ehSrjTnsiSaYjQXY2xVrUNLUk8KBHVmyvt8ltsPnKwD+hwNveyS
	 rEqFWprrbLfp3h5DZoVI+C3pl9Comzo+AWLn23UTSQJ2zTvtiUbDONODvPpVFoihVBshe
	 jbdWPUoBYwJCraihFwb82eEHfZJmjK9ghGtpBfYLlXcevRTmiTa5/KFN799VfCaC8AYvX
	 oOnlFo93U0ps4qR75V9rFCnWpSa9kzEvS5xhRzfkcMgU9QQ+VJtJW2U6OoAuI/ewiBA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596519;
	bh=T0Hcc1PDrH7R4eJgSztYTs6jUDXucLZmh8Tw+q7NVSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WCNBnf9nZMFDKm7VquLglLEqvkzGxjyQZflZ0iRiLvRk32aeFpDdjvG36kDaojlcy
	 81vt6nB3VQhJT/qiBLO2dvoF3cOYSWIpqMS5EIMKXeeyCpvUhzL8FAxC+SQ/Ne9Q2m
	 wgzniDSNOLPZZbzcneBNxVQeKhOlaym4CKNYso9P7De1CjQS/+kF11uA2IhHk1HhjQ
	 ew8+53vt9roq93AEzMwgrAlpwk1s0OQGafvdoCCJsQjHI0UvJUIZrlBUNo3O6bGPO1
	 cgvooeR9t1QC9Cgm2lofuR0IoiC0E8JKcbPIAdfgHEKqhu0vknEh49n7Y0aR1NTUIT
	 HQwZ2CX8zgSiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 139DD80D73;
	Mon, 28 Sep 2026 11:55:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 43B84194
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 354E7400DB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BO6ZiXxvAwe8 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:55:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 17F6C40063
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790596516;
 b=ErEasyjRDpPinRMAB1rGgyrpgKC1joNdd6QYZUbidPVNrdgXnU09a0I+NijQZ2vA5zHE
 H6ViHU0cNq3594cC7uV1Rjw43DtZsxYtzFqZ18P8d4T9ctZZlTZGqHmNGkNlDQphe0gte
 oanSB/oXgRunS52Y8nSx9NFDCIcFpvW9+x1sQD+Zs3JDDARq9UGsgpNc55XoLRJraJZ+h
 yzGlMuc4I1bjUhIjnstqnqaScfsg4OjBway1HLvjMxlibPmrcm6vdzjR0f0FL9Ueb34OG
 OunrVMOICd9vCDDt0L0KNE9AQMZESYoxgcyo/AtkWfnpZe/IZv1H1JRResOR6e5ZEvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596516;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=T0Hcc1PDrH7R4eJgSztYTs6jUDXucLZmh8Tw+q7NVSg=;
 b=Lka+XJRGnSbk7Oamv78FbGjCY99EMM95H2U0nBXzLElS5cN3yVOUWmvc2lbUwhhuD/8f
 p6SihGZz2/HDaTatWhzOaXTeQyLxF0tXAO0z4ioJ/2le6x3LlLSozugizfjoRwPdCybcS
 kOuizD8bVPP5lfcakfA426de3NFNLtn1lhI92u0Dea+JQEa6/EiNaCMLhqlrAFqbzQWOp
 GoLy7lziEnZNElD9dhfTo8XLg46nOk/6dsWedySCY4Qwvy4ZdVhi7PJCI/4cJQl+Afyq+
 FGZ+vIBRdTBxU6qKVJp+eksDvhL/iN8Gqsrm0sSDI6vDSDt/7kCWVS5MVGcS6MMQ08g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=fZAnbNOL; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c238=hu=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=fZAnbNOL
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17F6C40063
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1790596513;
 bh=T0Hcc1PDrH7R4eJgSztYTs6jUDXucLZmh8Tw+q7NVSg=;
 b=fZAnbNOLSVsE5SedcjD6YZzwjDcJiBEvLrYMzaOUTLtUPYoT5J9n000RzFre6QNM2l++Gh9dp
 JrYiOIK7ZcYagA8OTBTnqNoYkPQ1dLDCedCYO6SEoveppjjI/XzKRrKZJxLFd7S0GBZKG9kQP6n
 KduReBK+4hlrNnvVb/w4lxgWfNe3VRdfDJee/gIHMcJwq+Apf8GEd1Zre0tQKZ16l4g31etO264
 sC6vYN36nOV8ejcoVboO9nEc27EbRCkbtkN//JeSgpoYlPQeJ9M03DhIc6YsbXx/r5UxeOrl3Kc
 IpSA0FE9fzrzdxoQPXCod5Dqaw7kr13jKEOhBr73yeKQ==
X-Forward-Email-ID: 6aba559f7c3fbae63f6e831b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.16.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a12a9273-af9f-4477-8965-2e5f1d4a00da@kwiboo.se>
Date: Mon, 28 Sep 2026 13:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/30] sysreset: rockchip: Add rockchip_sysreset_bind()
 helper
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20260805174509.2968252-1-jonas@kwiboo.se>
 <20260805174509.2968252-22-jonas@kwiboo.se>
 <CAC928Hbh+XG_EA89aBeG4=fUYrm1YbuZug7JFy7EOnOdzv__+g@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAC928Hbh+XG_EA89aBeG4=fUYrm1YbuZug7JFy7EOnOdzv__+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Massimo,

On 9/27/2026 5:17 PM, Massimo Pegorer wrote:
> Hi Jonas,
> 
> On 8/5/2026 5:44 PM, Jonas Karlman wrote:
>>
>> Implement the sysreset get_status() ops and return same value as the
>> existing get_reset_cause() helper used for DISPLAY_CPUINFO. Only include
>> the ops in U-Boot proper to avoid increasing code size for xPL builds.
> 
> Does excluding xPL build guard break any XPL size constraint? Otherwise, I would
> avoid it, to have a driver with the same functions wherever it is built in. It
> can be added later on, should constraints require dropping unused functions.

There is currently no use for sysreset_get_status() in xPL, and my recent
rk3562 branch push failed due to xPL size limits on rk3288-popmetal. So
including this in xPL would mostly just waste space for no real gain,
or do you have any specific use-case in mind?

> 
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  drivers/sysreset/sysreset_rockchip.c | 52 ++++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
>> index 27ba4ee0667c..4b10d6bb762e 100644
>> --- a/drivers/sysreset/sysreset_rockchip.c
>> +++ b/drivers/sysreset/sysreset_rockchip.c
>> @@ -11,8 +11,19 @@
>>  #include <asm/arch-rockchip/clock.h>
>>  #include <asm/arch-rockchip/hardware.h>
>>
>> +enum {
>> +       GLB_POR_RST,
>> +       FST_GLB_RST_ST          = BIT(0),
>> +       SND_GLB_RST_ST          = BIT(1),
>> +       FST_GLB_TSADC_RST_ST    = BIT(2),
>> +       SND_GLB_TSADC_RST_ST    = BIT(3),
>> +       FST_GLB_WDT_RST_ST      = BIT(4),
>> +       SND_GLB_WDT_RST_ST      = BIT(5),
>> +};
>> +
>>  struct sysreset_reg {
>>         unsigned long cru_base;
>> +       unsigned int glb_rst_st;
>>         unsigned int glb_srst_fst;
>>         unsigned int glb_srst_snd;
>>  };
>> @@ -38,8 +49,48 @@ static int rockchip_sysreset_request(struct udevice *dev, enum sysreset_t type)
>>         return -EINPROGRESS;
>>  }
>>
>> +static const char __maybe_unused *rockchip_sysreset_get_cause(u32 data)
>> +{
>> +       if (data == GLB_POR_RST)
>> +               return "POR";
>> +       else if (data & (FST_GLB_RST_ST | SND_GLB_RST_ST))
>> +               return "RST";
>> +       else if (data & (FST_GLB_TSADC_RST_ST | SND_GLB_TSADC_RST_ST))
>> +               return "THERMAL";
>> +       else if (data & (FST_GLB_WDT_RST_ST | SND_GLB_WDT_RST_ST))
>> +               return "WDOG";
>> +       else
>> +               return NULL;
>> +}
> 
> As already stated in the RFC I sent [1], neither the glb_rst_st register
> bit-flag definitions nor the logic on how to handle them are common across
> Rockchip SoCs.

Please be explicit, from what I can see in TRM for the mentioned SoCs,
PX30 and RK3308, both have similar status stored in bit 0-5.

> 
> [1] https://lore.kernel.org/all/20260920-reset-v1-0-42820216369f@gmail.com/
> 
> Possibile approaches I see to overcome the issue: add a bit of information into
> rockchip_sysreset_bind() arguments to instruct the sysreset driver on how to
> decode glb_rst_st value; implement rockchip_sysreset_get_cause() at mach level
> and pass it to the driver as function pointer arg of rockchip_sysreset_bind().
> Other ideas?

This series is trying to move away from using arch/board specific
functions. If we need to extend with support for the finer grain reset
statuses, it should be handled with logic in the driver. E.g. checking
compatible of CRU ofnode.

> 
> In both of the cases I would probably feel that the mach area is a better place
> to implement get_cause() instead of sysreset driver code. Of course, we would
> lose static advantage but with LTO it is probably a minor issue. Anyway, I do
> not have enough deep knowledge of U-Boot architecture.

We should avoid new uses of arch/board functions in U-Boot proper, as it
would hinder a future possibility to use same U-Boot proper binary on
multiple SoCs. We are not even close to have that possibility but normal
handling in U-Boot is to use driver model and check compatible to handle
SoC specific parts.

Current sysreset driver is not bound to the CRU ofnode, so checking cru
compatible may hard. However, it could be a different/future direction
for this driver once we need SoC specific handling.

Regards,
Jonas

> 
> Regards,
> Massimo
> 
>> +
>> +static int __maybe_unused rockchip_sysreset_get_status(struct udevice *dev,
>> +                                                      char *buf, int size)
>> +{
>> +       struct sysreset_reg *priv = dev_get_priv(dev);
>> +       const char *cause;
>> +       u32 data;
>> +
>> +       if (!buf || size <= 0)
>> +               return -EINVAL;
>> +
>> +       if (!priv->cru_base || !priv->glb_rst_st)
>> +               return -ENOSYS;
>> +
>> +       data = readl(priv->cru_base + priv->glb_rst_st);
>> +       cause = rockchip_sysreset_get_cause(data);
>> +       if (!cause)
>> +               return -ENODATA;
>> +
>> +       strlcpy(buf, cause, size);
>> +
>> +       return 0;
>> +}
>> +
>>  static struct sysreset_ops rockchip_sysreset = {
>>         .request        = rockchip_sysreset_request,
>> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
>> +       .get_status     = rockchip_sysreset_get_status,
>> +#endif
>>  };
>>
>>  U_BOOT_DRIVER(sysreset_rockchip) = {
>> @@ -68,6 +119,7 @@ int rockchip_sysreset_bind(struct udevice *pdev,
>>                 return -ENOMEM;
>>
>>         priv->cru_base = cru_base;
>> +       priv->glb_rst_st = glb_rst_st;
>>         priv->glb_srst_fst = glb_srst_fst;
>>         priv->glb_srst_snd = glb_srst_snd;
>>         dev_set_priv(sysreset_dev, priv);
>> --
>> 2.54.0

