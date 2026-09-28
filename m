Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910D6CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 11:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D31680D6E;
	Mon, 28 Sep 2026 11:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hfwql1k4FYlK; Mon, 28 Sep 2026 11:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 85BB580D60
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790595308;
	b=sWlftE2nsy5kzaYZiT2sgRJFQ3AUEm5ns19RKT6YMseSusjJKLjeqiHsNQAOhAAZJm+0
	 EtnlYdFrU7j/vLT9NoVQs7Nv3VWDmyKbEHTPfQJZAeJl+AnNh55D+rrzLVBFCBDF6Z1Bm
	 HchpQzKtT6+/P6ZwAtDnVjiMcVa6JuUH344FkMJgYMP/ZOweujuu2O5MNwCk5Gv6hi4lD
	 Ubu5vng+U4aTvqPNNc6myx1/qYM4WPCIH3pzktqYgOXuitwAHTgBaTB4+R7UC1MbZFKUi
	 y0nLFYdWDWoGeFCtRvmk8gFQwctL7nKXR+sv9OsFWfp0St8xTNZPBmrtMiMlPjq3RhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790595308;
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
	bh=zRyMvXK4nnnRRoDIgqjpt0OSjxuKZ+9XY5I+ei5Eq9U=;
	b=Jn9w6Yv6B/8UAuEjYnoChLQDJJy+yjFmnAAm0RA7yFD1LCnq6gjp5lmnp/4lnfLacF4a
	 LADJ877XCGhyQFnN4AW/JYIcrt3IZGusODzR1C3f8u+N3Ba5wIRgQGjxiuLkV/RhP6UiX
	 bhkX8t2e/Lho0GquD3rp/pCBuxhvNZ36t4lbY9cWxV029Tl7alPStsnqPHAkAL1GjuJny
	 bofcKSEiXxWnlFdNjnSssdWYULeE4YtJkBTpVz4lNA+VC8qgIcX3BlAisjGaoAk/4nWq1
	 5wlWDm03Pv5OpdM0BOA/izfGPNx5cKp9aOgz/sCJn2roqc1jDmvYa/n0yDMjIrNHcGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790595308;
	bh=zRyMvXK4nnnRRoDIgqjpt0OSjxuKZ+9XY5I+ei5Eq9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BjKma7r+cwQHKoAwSmm9XEIpXEyzNoeF//hFWN+sKtkWYUUZjJrLp2U2yGhdwM/5B
	 bknspjCgc3Df+phcYhJtEAmiehBgebucV1kW30Q0KtAaruWem0C4HJy+pzspA5yhU1
	 TQ4iwFTs+r9q89xvJFecMBSRzjyST0O3zaul6NJJT+XFAmbgbfsYW7X5+zgs85/mFR
	 IUZEvtEzvPfY2fAWIxL/lNjSIlLkh21kMq/qKw/GF18DXHn+SbnGQMFwzjEVFJc4Ac
	 PngVsbCgH0hgZeoMIRT0UNKKeJ83wCiT4DeR/O4V5+aGHX2vT+koda+JTl4XJfI/BT
	 ga6UHzeuqTYQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85BB580D60;
	Mon, 28 Sep 2026 11:35:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E3E9C24E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C95F760631
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGzcHjHJkTWA for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D879D60601
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790595306;
 b=cQn+6WjS9EpCzSbIHEPEfVJ3/IAuiraWLSW8vhz7854B9kL8+DJqXlOetcub0mYxjsN+
 nqaLIskzhd20jm1mkAssV02BAvIcFb7jl6t/rgInN519TgVjiBJENJ3el3Yc6PHtlReTj
 lIl6QpPYRT+vJ4kE6FaAxpzZFVaJojaMKMIReS22C0HB8AjYyaUMnGVld+mIovqNlZLKt
 Zut8ezqnh4InThP+1h/gq8DqRpRZR1GQN6+Cpw17OdAx/Fw9/5ovbJn83MweNo5E2g3Ri
 kyeKPVa4UAfFOzC4cLamb+EuvoAR4BiR5sy44y2xOZ+lQATXgwY8IaHaMsjlLGlldXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790595306;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=zRyMvXK4nnnRRoDIgqjpt0OSjxuKZ+9XY5I+ei5Eq9U=;
 b=We4ai/t1zerRcx5CAEw3bCzWN9Icly44gyDRfJSnZ9Jh1NTarXWdrxDYUGkCw1petPzB
 qWgH71jg5MjYpKkse3+6XyrgER53wiuSYePz9+R3z+VuQ99JuGr0Z2RHNup0NlKNg31Yv
 FuN49hgbbQScrZo312Wy2c39ViYVnl8k8I8esZ4f0IQsQ2RwR+okPtk1MLhWR0ZkkJklX
 vYfiQeyixXjyZmJK2xOpnX7lsIX3uuhuurjf/jDii83Edtj4WHLqkoiXfMAkU9Fy6hLPF
 Kq4XaSrLAJ/b02bMEkHat0FjPkPYvzO6e8R7Tadfwy19SdsA5J6V2/Yj58pPkLCEA5g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=WyKPbThD; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c238=hu=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=WyKPbThD
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D879D60601
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1790595304;
 bh=zRyMvXK4nnnRRoDIgqjpt0OSjxuKZ+9XY5I+ei5Eq9U=;
 b=WyKPbThDikBnob+tqPONmwZxRETPBpFpKvKec0rOHWWGbGGrzDWcYb+vs9H/T85m4Svs2Cw+D
 UazMHSSqyByp1fVLtybdwbk6ljvc2HUUpNmB+YLCgD7jctbszaYBXMuM6HeQaKHhz7NCgwqx8uv
 edzIiW9rI/wXZ4xvlBa0rJ7Xj7Awxu48xT4OQCP4+ugx7nAksNx3X+iqFH1Z2If5ErYgw+zyESM
 KFAEIu1DwAT31Z5WfhHFppq3tkVEt4EDe7QdIDGKScx8owTn7jQCnXwri4VkTIPr5mgmbQLySXf
 g3M2p4+h66/nDMzIAOyAMBFyZrQ5xITIgXA38MkgyYow==
X-Forward-Email-ID: 6aba50e35860254349dec012
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.16.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2bd91337-2648-4f7c-be21-d526574f7c64@kwiboo.se>
Date: Mon, 28 Sep 2026 13:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/30] sysreset: rockchip: Add rockchip_sysreset_bind()
 helper
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Quentin Schulz <u-boot@0leil.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20260805174509.2968252-1-jonas@kwiboo.se>
 <20260805174509.2968252-2-jonas@kwiboo.se>
 <CAC928HbGTRYNXdVnExJLGMDLBewYVSJ9uZiwG2aF5b6PsOC9oA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAC928HbGTRYNXdVnExJLGMDLBewYVSJ9uZiwG2aF5b6PsOC9oA@mail.gmail.com>
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

On 9/27/2026 2:09 PM, Massimo Pegorer wrote:
> Hi Jonas,
> 
> On 8/5/2026 5:44 PM, Jonas Karlman wrote:
>>
>> The sysreset_rockchip driver uses the rockchip_get_cru() helper to get
>> the CRU base address. However, use of this helper adds unnecessary
>> abstractions and limits the driver to only work for a single SoC.
>>
>> Add a rockchip_sysreset_bind() helper intended to be used in clock
>> drivers. This helper expects the CRU base address and the offset to the
>> global reset state register as parameters in addition to the offset to
>> the first and second global software reset register.
> 
> What do you think about dropping cru_base from sysreset_reg struct and providing
> registers addresses instead of offsets as arguments of rockchip_sysreset_bind(),
> to be stored in sysreset_reg struct? There is no other use of cru_base than
> summing it with offsets.

I think it is better to keep base address and regs address different.
Mostly because that is current practice, semi-required to keep
bisect-ability, and more closely matches base + reg description in TRM.

It will also ease a possible future transition to use regmap API or a
possible change to get the base address from cru ofnode.

Regards,
Jonas

> 
> Regards,
> Massimo
> 
>>
>> The helper wraps similar handling as existing clock drivers, and will
>> be extended to make use of the CRU base address and state register
>> offset after all clock drivers have been converted to use this helper.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  arch/arm/include/asm/arch-rockchip/clock.h | 15 +++++++++++
>>  drivers/sysreset/sysreset_rockchip.c       | 31 ++++++++++++++++++++--
>>  2 files changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
>> index cf8bb0f04636..1b12867b489b 100644
>> --- a/arch/arm/include/asm/arch-rockchip/clock.h
>> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
>> @@ -186,6 +186,21 @@ void rk3288_clk_configure_cpu(struct rockchip_cru *cru, struct rk3288_grf *grf);
>>
>>  int rockchip_get_clk(struct udevice **devp);
>>
>> +/*
>> + * rockchip_sysreset_bind() - Bind system reset device as child of clock device
>> + *
>> + * @pdev: clock udevice
>> + * @cru_base: base address of the clock/reset unit registers
>> + * @glb_rst_st: offset of the global reset state register
>> + * @glb_srst_fst: offset of the first global software reset register
>> + * @glb_srst_snd: offset of the second global software reset register
>> + * Return: 0 success, or error value
>> + */
>> +int rockchip_sysreset_bind(struct udevice *pdev,
>> +                          unsigned long cru_base,
>> +                          unsigned int glb_rst_st,
>> +                          unsigned int glb_srst_fst,
>> +                          unsigned int glb_srst_snd);
>>  /*
>>   * rockchip_reset_bind() - Bind soft reset device as child of clock device
>>   *
>> diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
>> index 00308f9a33b7..39cb16ec5456 100644
>> --- a/drivers/sysreset/sysreset_rockchip.c
>> +++ b/drivers/sysreset/sysreset_rockchip.c
>> @@ -4,10 +4,11 @@
>>   */
>>
>>  #include <dm.h>
>> -#include <errno.h>
>> +#include <dm/device-internal.h>
>> +#include <dm/lists.h>
>> +#include <stdlib.h>
>>  #include <sysreset.h>
>>  #include <asm/arch-rockchip/clock.h>
>> -#include <asm/arch-rockchip/cru_rk3328.h>
>>  #include <asm/arch-rockchip/hardware.h>
>>  #include <linux/err.h>
>>
>> @@ -42,3 +43,29 @@ U_BOOT_DRIVER(sysreset_rockchip) = {
>>         .id     = UCLASS_SYSRESET,
>>         .ops    = &rockchip_sysreset,
>>  };
>> +
>> +int rockchip_sysreset_bind(struct udevice *pdev,
>> +                          unsigned long cru_base,
>> +                          unsigned int glb_rst_st,
>> +                          unsigned int glb_srst_fst,
>> +                          unsigned int glb_srst_snd)
>> +{
>> +       struct udevice *sysreset_dev;
>> +       struct sysreset_reg *priv;
>> +       int ret;
>> +
>> +       ret = device_bind_driver(pdev, "rockchip_sysreset", "sysreset",
>> +                                &sysreset_dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       priv = malloc(sizeof(struct sysreset_reg));
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       priv->glb_srst_fst_value = glb_srst_fst;
>> +       priv->glb_srst_snd_value = glb_srst_snd;
>> +       dev_set_priv(sysreset_dev, priv);
>> +
>> +       return 0;
>> +}
>> --
>> 2.54.0

