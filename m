Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC9CCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6602580D45;
	Mon, 28 Sep 2026 12:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hIr35jtvt9vT; Mon, 28 Sep 2026 12:50:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 07CF780D49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790599813;
	b=OHgg3taxfRzWesPDH4okymoBwQIeGJuu4Jp/JzV26/l7mc2q9OnR6l6x3AFIPwtO4vNf
	 hPf2ZyFH5bvj7+IECtqOIe4qwFYBwBu+joI662Ye8SOUTy4HkvO9VlWJuVLertTMEznD9
	 uBZUOfIcIkq7fJQyGFr+nuaDI56clWtkmVopgQg3v9keM0rxLdyNhI60hW7Wo31COP6Ox
	 xFB/mMAbqWOBMfeOSvltiPsgW32hVjBEo3B0b0VHQRzsP3Q0ifABIDdjOYvJnuB9RBH+q
	 6RkfCE9K412oVqOL/hJYgMVLUqTy0cyGelsyhyIUBmlcE3h2pF1uohadBYgQ9liWPzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790599813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gwJIVV9fcXhakisRB39q/QdILyNyvbV5CEPd2RSJBE4=;
	b=H3flpVmStp3DWkj0C6pPMCppL7UxQI/51VCljGkVWFLa5xwa8+LAyfDAgMMfdVbvB+AI
	 Wfq1Yk0UFlRrhpWYVoE2q0MjgWGlGBGsokoERuyG8f2hE3anTJtUzJu1pEsLRVchloAkE
	 mn5ZmnjCApbMKbumFwSl1+4lFPKB2nwD+OF1blMijTx3wvUTBXorSoO5KJdhH7hpfqEdz
	 6195tWBCFIVEPK+zk1PFqFSbaXUqYAa0rZuJTXiE36sOvwhzva6QyBpoDbbt9Eo4wEw69
	 7Y7dag3EQWeA0j5Qz7iA5UDXvJCObqJ6RqLUyfnE5UmEyfU/YWo+Mh/j6rWGOD/hOEQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790599813;
	bh=gwJIVV9fcXhakisRB39q/QdILyNyvbV5CEPd2RSJBE4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z2OEqyrrRzeVZXAOtpZgy54aej4XOfa/dsjm2JdYCU2Yo7bdb+2JN+9m2ddDAei+9
	 hiY9ArXrFYws8dLKHWL2FmDJUvomND7OlkpkzPeAPxbS9+H6Y11p4KELH/ZU+AJiMw
	 X8a5f2i0ppfXhB1YddCpqCk5OcdOOR+jl5GQWgcjdHYeUT6PXqse8tq33IXlzD6775
	 e7U7hFuHv64eAOS2Sw3YRJ8yj90RsPNUXxqnLAZd801tybQFW/49PcVJ38d5O0tjFa
	 BMYEms1sCeHqK9Bi07d4407eTFlrZbANbXlOjWRQp6L5NK3NfN24usucxURZS3Doxk
	 CrwpBDrhTjPEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07CF780D49;
	Mon, 28 Sep 2026 12:50:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9590D2B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83EC2401F1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sJjAFTYm8BKy for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:50:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A50A4401D8
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790599810;
 b=ljY3m3X2ErS6M1dier9WUKQwW20zQVjNO8c+7dbIWlwbyU8k6laYc4TMfm465cnD4BtY
 kTpzobtq8fttzFcB1uDqITVuAms26iuZ/1fgz25TrwnEUnGbegEluf0fjyd344lxfxTdF
 5HKVagVQRSl/SstzQRxG9Wxe77dIY1mF6Yf09nYPu5Y8oEhGY9Fjvg/XvbJwSEwBbr0wD
 xO9X+ZrU+mDK/nQItBpSlVU8msVGbpVJm0CzEf9c6wbSBc+Dx6yyEQ3e5p7xRQFJVPfRd
 2MqVLkN81UyjP0fGvEIU1im09OiwAX3JV3+k10gAeknryX5dtKx511aKRFCVyva+Tkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790599810;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:
 From:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=gwJIVV9fcXhakisRB39q/QdILyNyvbV5CEPd2RSJBE4=;
 b=L5f/2hpFfYCNZTu95eBoEEELmpik//8z5ZhQ1VR9w2iHEhzdCAyOKvIMJ6ujBhkYnWO9
 /mrhj2m5bWutjyl1+S/uwZmAgF97u47slVVKssEvp7pJJ3SwvRn+2IKTo9xq/hpXe9WAw
 vcycjei/eRvVkhM3K0KMdd4TlWaBO40JGjNUrzFvp0dPc32NKIdC89FPXM9PP9p9T+bZF
 5huTTqlpzdJD7U99jnYSuTWK67kjloMz1DsEu5UR9Nzp2iQ77GiOmum0I+GsQqxZD0H7w
 9yu2nMvNBVfzLOhZP/b+rSPLLYq3M0HeH8b3/DPhtCV91X+8v/axtTEDDD9eqUj+vYw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=mbOdHIhB; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=a985=hv=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=mbOdHIhB
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A50A4401D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: From: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1790599808;
 bh=gwJIVV9fcXhakisRB39q/QdILyNyvbV5CEPd2RSJBE4=;
 b=mbOdHIhBQBkbgkjcLd1XUkYbHxePyGNd/WZ6KzQmJa7IVERZcHED5odi2yB1eBgMVM3FLLcGf
 oaxjvsu7xVVPy7sNy7iQoP2nnOEcCPtDRNw/D7MWSno46rUa7KbU718g5LTOy4k1dvFoER8V7Qa
 B/d0M3g+jy9WX6hb8JNbas+oVzCV0vzN9gZkmwBPrpx98Jdllml6kzMS1ZdUk2QpCtaG5xOevfe
 s/soIDHN2k5kiwHxZc/D0kbJFTxJBPJfbJGwdMdgLOkMk6ugZnCG8yivIw0oB8XPPZPlqpdThyA
 Ia4Ncdqmgn5KAOJFfc+t1AOy26ERDOhyonzjX4ZOQAxA==
X-Forward-Email-ID: 6aba627db5f3e4be6d10b4f2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.16.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f88ba51b-6f70-4619-baae-816249876c6f@kwiboo.se>
Date: Mon, 28 Sep 2026 14:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/30] sysreset: rockchip: Add rockchip_sysreset_bind()
 helper
From: Jonas Karlman <jonas@kwiboo.se>
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20260805174509.2968252-1-jonas@kwiboo.se>
 <20260805174509.2968252-22-jonas@kwiboo.se>
 <CAC928Hbh+XG_EA89aBeG4=fUYrm1YbuZug7JFy7EOnOdzv__+g@mail.gmail.com>
 <a12a9273-af9f-4477-8965-2e5f1d4a00da@kwiboo.se>
Content-Language: en-US
In-Reply-To: <a12a9273-af9f-4477-8965-2e5f1d4a00da@kwiboo.se>
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

Hi again,

On 9/28/2026 1:55 PM, Jonas Karlman wrote:
> Hi Massimo,
> 
> On 9/27/2026 5:17 PM, Massimo Pegorer wrote:
>> Hi Jonas,
>>
>> On 8/5/2026 5:44 PM, Jonas Karlman wrote:
>>>
>>> Implement the sysreset get_status() ops and return same value as the
>>> existing get_reset_cause() helper used for DISPLAY_CPUINFO. Only include
>>> the ops in U-Boot proper to avoid increasing code size for xPL builds.
>>
>> Does excluding xPL build guard break any XPL size constraint? Otherwise, I would
>> avoid it, to have a driver with the same functions wherever it is built in. It
>> can be added later on, should constraints require dropping unused functions.
> 
> There is currently no use for sysreset_get_status() in xPL, and my recent
> rk3562 branch push failed due to xPL size limits on rk3288-popmetal. So
> including this in xPL would mostly just waste space for no real gain,
> or do you have any specific use-case in mind?
> 
>>
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>  drivers/sysreset/sysreset_rockchip.c | 52 ++++++++++++++++++++++++++++
>>>  1 file changed, 52 insertions(+)
>>>
>>> diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
>>> index 27ba4ee0667c..4b10d6bb762e 100644
>>> --- a/drivers/sysreset/sysreset_rockchip.c
>>> +++ b/drivers/sysreset/sysreset_rockchip.c
>>> @@ -11,8 +11,19 @@
>>>  #include <asm/arch-rockchip/clock.h>
>>>  #include <asm/arch-rockchip/hardware.h>
>>>
>>> +enum {
>>> +       GLB_POR_RST,
>>> +       FST_GLB_RST_ST          = BIT(0),
>>> +       SND_GLB_RST_ST          = BIT(1),
>>> +       FST_GLB_TSADC_RST_ST    = BIT(2),
>>> +       SND_GLB_TSADC_RST_ST    = BIT(3),
>>> +       FST_GLB_WDT_RST_ST      = BIT(4),
>>> +       SND_GLB_WDT_RST_ST      = BIT(5),
>>> +};
>>> +
>>>  struct sysreset_reg {
>>>         unsigned long cru_base;
>>> +       unsigned int glb_rst_st;
>>>         unsigned int glb_srst_fst;
>>>         unsigned int glb_srst_snd;
>>>  };
>>> @@ -38,8 +49,48 @@ static int rockchip_sysreset_request(struct udevice *dev, enum sysreset_t type)
>>>         return -EINPROGRESS;
>>>  }
>>>
>>> +static const char __maybe_unused *rockchip_sysreset_get_cause(u32 data)
>>> +{
>>> +       if (data == GLB_POR_RST)
>>> +               return "POR";
>>> +       else if (data & (FST_GLB_RST_ST | SND_GLB_RST_ST))
>>> +               return "RST";
>>> +       else if (data & (FST_GLB_TSADC_RST_ST | SND_GLB_TSADC_RST_ST))
>>> +               return "THERMAL";
>>> +       else if (data & (FST_GLB_WDT_RST_ST | SND_GLB_WDT_RST_ST))
>>> +               return "WDOG";
>>> +       else
>>> +               return NULL;
>>> +}
>>
>> As already stated in the RFC I sent [1], neither the glb_rst_st register
>> bit-flag definitions nor the logic on how to handle them are common across
>> Rockchip SoCs.
> 
> Please be explicit, from what I can see in TRM for the mentioned SoCs,
> PX30 and RK3308, both have similar status stored in bit 0-5.

Okay, I now understand that PX30 and RK3308 use a different bits
compared to other RK SoCs.

> 
>>
>> [1] https://lore.kernel.org/all/20260920-reset-v1-0-42820216369f@gmail.com/
>>
>> Possibile approaches I see to overcome the issue: add a bit of information into
>> rockchip_sysreset_bind() arguments to instruct the sysreset driver on how to
>> decode glb_rst_st value; implement rockchip_sysreset_get_cause() at mach level
>> and pass it to the driver as function pointer arg of rockchip_sysreset_bind().
>> Other ideas?
> 
> This series is trying to move away from using arch/board specific
> functions. If we need to extend with support for the finer grain reset
> statuses, it should be handled with logic in the driver. E.g. checking
> compatible of CRU ofnode.
> 
>>
>> In both of the cases I would probably feel that the mach area is a better place
>> to implement get_cause() instead of sysreset driver code. Of course, we would
>> lose static advantage but with LTO it is probably a minor issue. Anyway, I do
>> not have enough deep knowledge of U-Boot architecture.
> 
> We should avoid new uses of arch/board functions in U-Boot proper, as it
> would hinder a future possibility to use same U-Boot proper binary on
> multiple SoCs. We are not even close to have that possibility but normal
> handling in U-Boot is to use driver model and check compatible to handle
> SoC specific parts.
> 
> Current sysreset driver is not bound to the CRU ofnode, so checking cru
> compatible may hard. However, it could be a different/future direction
> for this driver once we need SoC specific handling.

Something like following could possible be used:

diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
index 4b10d6bb762e..a6a7e61c8baf 100644
--- a/drivers/sysreset/sysreset_rockchip.c
+++ b/drivers/sysreset/sysreset_rockchip.c
@@ -67,6 +67,7 @@ static int __maybe_unused rockchip_sysreset_get_status(struct udevice *dev,
 						       char *buf, int size)
 {
 	struct sysreset_reg *priv = dev_get_priv(dev);
+	struct udevice *parent = dev_get_parent(dev);
 	const char *cause;
 	u32 data;
 
@@ -77,7 +78,11 @@ static int __maybe_unused rockchip_sysreset_get_status(struct udevice *dev,
 		return -ENOSYS;
 
 	data = readl(priv->cru_base + priv->glb_rst_st);
-	cause = rockchip_sysreset_get_cause(data);
+	if (device_is_compatible(parent, "rockchip,rk3308-cru") ||
+	    device_is_compatible(parent, "rockchip,px30-cru"))
+		cause = px30_sysreset_get_cause(data);
+	else
+		cause = rockchip_sysreset_get_cause(data);
 	if (!cause)
 		return -ENODATA;

Or maybe some more elaborate compatible opt-in handling to only add
get_status() ops support for the SoCs currently being supported by
get_reset_cause().

Regards,
Jonas

> 
> Regards,
> Jonas
> 
>>
>> Regards,
>> Massimo
>>
>>> +
>>> +static int __maybe_unused rockchip_sysreset_get_status(struct udevice *dev,
>>> +                                                      char *buf, int size)
>>> +{
>>> +       struct sysreset_reg *priv = dev_get_priv(dev);
>>> +       const char *cause;
>>> +       u32 data;
>>> +
>>> +       if (!buf || size <= 0)
>>> +               return -EINVAL;
>>> +
>>> +       if (!priv->cru_base || !priv->glb_rst_st)
>>> +               return -ENOSYS;
>>> +
>>> +       data = readl(priv->cru_base + priv->glb_rst_st);
>>> +       cause = rockchip_sysreset_get_cause(data);
>>> +       if (!cause)
>>> +               return -ENODATA;
>>> +
>>> +       strlcpy(buf, cause, size);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>  static struct sysreset_ops rockchip_sysreset = {
>>>         .request        = rockchip_sysreset_request,
>>> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
>>> +       .get_status     = rockchip_sysreset_get_status,
>>> +#endif
>>>  };
>>>
>>>  U_BOOT_DRIVER(sysreset_rockchip) = {
>>> @@ -68,6 +119,7 @@ int rockchip_sysreset_bind(struct udevice *pdev,
>>>                 return -ENOMEM;
>>>
>>>         priv->cru_base = cru_base;
>>> +       priv->glb_rst_st = glb_rst_st;
>>>         priv->glb_srst_fst = glb_srst_fst;
>>>         priv->glb_srst_snd = glb_srst_snd;
>>>         dev_set_priv(sysreset_dev, priv);
>>> --
>>> 2.54.0
> 

