Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF22BCA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 15:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04B11608BD;
	Fri,  9 Oct 2026 15:48:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3yc1XVOIGZzX; Fri,  9 Oct 2026 15:48:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D7813607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791560884;
	b=aL9gEA8VB8saCwUSdmlFHSvFB62ggjuTChPfWL43CbT4jncISuGiu2SykELWTlxkDP75
	 pPh5/5SZxthWVaMquA1duR+oKKgmnH2964T0KCpg+FulNj3+G8/9hU+SVPu2it5x41RMt
	 4qpfbrbqDHggL0Vi2x9vQRr1qcB34ISw17aM8dtX6iVQTRDriHhVhT8f/sXEvaM3bVUaq
	 vT7MUQMmCD8chFz9Mlo7A4v7CrPb7JuNIVRK3HhBleCEFs24C08vgq7PDClqnZ/cycjEs
	 3O4Dcc86DJDlakKusyHIuz2MX2OxD6H1ieomCf0E2sQWcYAVbGL+GsgJBJeFSiz+yDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791560884;
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
	bh=YqymQ+1LYsnNkiFczqePQywSd/EEq9Ia+bsW0UfQTpk=;
	b=J9ewXmpniWUm7Z03gVCVFyASHppH8RUvN6faBmeU+uc4KlzF7b8WkbMkooJr70xkxmLv
	 LXGa+RUxC0wuziMnDgoxhzIfKBZVIOkC57x3Q3Q98pVhMhfqzhRHRAn7xVv1niu5i5Rq4
	 kgNlLhNZDxAVNEFvj0T72kxSEImwW3XQHY6oLMLpG3F9nUYRgNfmUB4pPlbIvWsI9jKZD
	 hzfFjhn9/ryUf0Q8pQ0cT59+0g7TJDR7vwqs8hLzxw/se0Dm8hbTr8zT5E8+l2wyYvqyT
	 YNi1wtFTC7LaHCsVj++ncgoon1P6i1NKXERqEvW7GD5qL7vGtITcWv1VQgGAtRlv5Pg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=PHtoCU61;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791560884;
	bh=YqymQ+1LYsnNkiFczqePQywSd/EEq9Ia+bsW0UfQTpk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dqOoSBozCoLMGK9IbrALVaUEMC8fREBzskwV3pn5FMoFzJq5y8jsWOyqw6Tl6D4RH
	 rajz6uaP21MdfX1+rhRPk5LDkcgWVBHnjM2Fv6lYnoQTxxGDnZS+08FiLgIhSDSY+9
	 7osdP7t8g1VEEvthI14U56EDu6zbNMeaDU2Q0hF4NlU36Kq/1zJ0WRBjJGJDZPWOde
	 UuWMjBsuJPoxrJvPKzs06Fmv0nGin/sowO4k54QywPbENXJCTIoHiT/c/Hm2RpSvb2
	 ZLGPZNZyFtRPTrtOfvFeUmJEme4jTNDUYN/nc0uaa9G5oF4kDRAqQX0SvWHZ5kmeCM
	 2ha2KtefCeq2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7813607B2;
	Fri,  9 Oct 2026 15:48:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 321C21D2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23900607B2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eqFp9M5pFThM for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 15:48:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1891360727
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791560881;
 b=IG8PiGt/90l8KL7J49vnfKIAt7dliDJ2NZhmbjHrMINPkXSX1ry0DvS0fyFn3Abk/HkE
 9QogyaqnxcQv4z+qCJj091B/+H1gbHa6wtNwlvgvN/5XtYSOLCo3PfIqItJL9EcczouJG
 NESILmB5i3WXQ6SUjuvMuBGiBoIxuAFJadFY2/s9fGH44NI7hozATYIciBY7AbL2skR4Z
 xBK/35p+RsruCG5WqO2+2MQz/8DupVeFucrih9xDoV1NbISPMSU2Swim7fIa9pS30Zlr4
 lOmsAo7Mdw2bHtFEbe+z99LwysrPwWViNNm04AXn3iVVNcvIeAmiYINM8t+p37l/9qA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791560881;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=YqymQ+1LYsnNkiFczqePQywSd/EEq9Ia+bsW0UfQTpk=;
 b=aBt0HFKAjSCGnD5cwjGx8pW8F9WIDzKgFvZ4RJdhjhA7d1S4YHbbN1TVnNralHaazjG+
 YTZMChKsDUcWWItUT15x3w3+vaEQ8TZ5QbOA0vLMBPpHboejVFpZv+5V4UYUdjzozUM64
 mEh+uEw5DDnQe5Am+knzYIE5EIbNweO2O/h1IlZIuc299Ci4ZwSJgfdUyDMQMzgZ2zlgm
 2O/K2zKdIuseHm8mDB0XFKTS4gyySdjptB4b3fII5NUYgrv3c8dWmh9cU68Fo2g0cKRtZ
 fS3qjP8TKfAleLFAV0SyTsMK0Kd6UG44guAbZOVyEQyzS4grnKT7p8B7kwayuU3NDwQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=PHtoCU61; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c672=ia=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=PHtoCU61
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1891360727
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791560878;
 bh=YqymQ+1LYsnNkiFczqePQywSd/EEq9Ia+bsW0UfQTpk=;
 b=PHtoCU61wuK7lvUmpkzKybqW+BGmCoSXMFioy8T3nrX1y8rU6yiano5E/6mgYKBESMcDxWuCs
 a3d64TzhT7Dri3b5ugnULQGv/CwnvrRHG4PXQtTiLrI7nJrxG7llLQsaPtJ4pqSkzv6TEymoniE
 YfzYs/Xq6p6XBK5Gb08GDYfSqRvAFJzhmWKakRnfSPPVWl8/UN3KGb62UFye+yvwwORrFw3polj
 xwbWFGnHMn9tKjo7uGBMLJdBcgwl9T9czNwOrpE6JPF0HjA8k504xmR8ptLFn+lUALgNrRqe1Bx
 MhxiDuzG6lnB/0tWEaKozkH/oGMIWtkNi62Dyc79hP8Q==
X-Forward-Email-ID: 6ac90cabec5a50a7d2b8efe9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <973f0112-e7f7-4cfa-bc01-2e0328592fad@kwiboo.se>
Date: Fri, 9 Oct 2026 17:47:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ram: rockchip: rk3568: Simplify get_info() ops
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-2-jonas@kwiboo.se>
 <f2a4bf52-8532-4f57-9354-1d2a3e33d875@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <f2a4bf52-8532-4f57-9354-1d2a3e33d875@0leil.net>
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

Hi Quentin,

On 10/9/2026 12:29 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/26 12:57 PM, Jonas Karlman wrote:
>> The PMUGRF base address is fixed and known at compile time. However,
>> the base address is read from DT at runtime in this driver, delaying
>> reading the two HW regs to determine RAM size by several ms.
>>
>> Change to use a constant for the PMUGRF base address to speed up reading
>> RAM size and simplify the driver by removing use of probe and private
>> data. The driver list entry name is also renamed to match the
>> compatible, for possible use with OF_PLATDATA.
>>
> 
> Questions apply to both rk3568 and rk3588 patches.
> 
> There's a lot to unpack here and it doesn't make things easy to review.
> 
> 1) I would really like to avoid hardcoding stuff. Did you try using 
> syscon_regmap_lookup_by_phandle(dev, "rockchip,grf"); after adding a 
> rockchip,grf = <&pmugrf>; property to the dmc node? (maybe it'd make 
> sense to name the property rockchip,pmugrf but that's a detail). I also 
> see benefit in being consistent across all drivers using the GRF when DM 
> is enabled. One issue I could foresee is that this typically will be 
> part of the TPL once we have an open DRAM init, and then we don't have 
> DM in TPL so we won't be able to read the device tree to get GRF via 
> that property. Is this your current worry?

I agree that we should avoid hardcoding stuff in general, with the CRU,
RAM and arch_cpu_init()+board_debug_uart_init() in xPL as exceptions.

Those are that core parts that typically may be needed in xPL, where
size and speed is important and/or DM or OF_PLATDATA may or may not be
involved.

Resolving values from DT has been proven to be very very slow in xPL
and pre-relocation phases, primarily due to slow API for navigating
nodes.

I also cannot understand why we should need to waste multiple CPU cycles,
energy and code size on resolving a fixed known constant value that
never is going to change. So no I have not nor do I plan to try and use
any DT lookup here ;-)

> 
> 2) why rename to match the compatible? What really matters is that they 
> are unique across the whole U-Boot code base. I don't see really the 
> benefit, but if it scratches an itch, I could see one commit that 
> renames all Rockchip DRAM drivers to be consistently named 
> rockchip_<soc>_dmc. Not a blocker.

The rename is "for possible use with OF_PLATDATA". With OF_PLATDATA the
driver is looked up using a DT compatible to driver name mapping.

Will split the rename to a separate commit for affected drivers in this
series. The intention of this series is only to align RK35xx SoCs to be 
consistent. Picking up similar work for remaining SoCs from [1] is
planned for a future series.

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/optimize

> 
> 3) What is removing probe+priv_auto helping with? We now need to call 
> rockchip_sdram_size for each call to ram_get_info(), which we only have 
> one so it's not such a big deal but it's still a bit odd to me when the 
> DRAM isn't going to change between calls (so somewhat joining Simon on 
> the caching thing that's done here before your patch)

Simons concern where mostly related to caching the base address from DT,
not really related to caching the RAM size, if I understood correctly.

As mentioned in commit message, to simplify the driver. There is really
no need to do an extra malloc for priv data or pre-calculate DRAM size
at probe() time. Also to align with the RAM drivers that was added later
i.e. rk3576, rk3528 and rk3506. And that I have prepared for rk3562,
rv1126b, rv1106, rv1103b, rk3538 and rk3572 in [2] ;-).

On a technical side; to simplify and prepare for possible future DRAM
init. We typically need two completely different parts from the RAM
driver depending on what phase is running.

During DRAM init (in TPL or possible SPL for older SoCs) we only need to
initialize DRAM and write encoded DRAM info to OS_REGx, before returning
to BROM.

During next xPL phase and in proper we typically only need to read and
decode the DRAM info from the same OS_REGx.

To keep the driver as simple as possible we only need to implement
following ops to help keep the complexity low:

.probe = init DRAM in TPL and do nothing in remaining phases
.get_info = return the decoded DRAM size

And for size constrained targets the entire driver could be replaced
with a size optimized sdram_init() function in TPL.

[2] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/tree/rk3562/drivers/ram/rockchip

> 
> Overall, except issues of the rk3568 and rk3588 syscons still being used 
> unlike claimed (a bug) and some slight commit log rewording of the other 
> commit logs, this and the next patch's commit log is lacking information 
> that should be the answer(s) to 1 and 3 (and please split 2 into a 
> separate commit if you really want to).

Will send a v2 refresh of this and other related/dependent series.

Regards,
Jonas

> 
> Cheers,
> Quentin

