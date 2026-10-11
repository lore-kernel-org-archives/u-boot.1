Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C67ACA9EC9
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 10:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D93F6061A;
	Sun, 11 Oct 2026 10:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kOUp6UdBlhKD; Sun, 11 Oct 2026 10:43:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CD99660612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791715418;
	b=Oui9gpPEPqzwDFp3GorPWI+ld/hgdPvl9XK4CQAHUvAEMVVGlrgDkIzkNRoSCAgNaKAO
	 0I+qDRXLyuhzW4mrqbOONvuQ14xcyoDKhn+fMe9n6gYmBIC3Ul13ocQOw/Y9D/QEHqn7H
	 p4YWBm72KKN/V5AxtsIDAfWkxVwOhRakPzwNeBoSiOkL1xL4GM9ZPv1f+kO4w2+IrFAID
	 4+diPrEvdTgOtJy6E4rrk2XseJWRYJSlr6waSruaMG9xp4dyhh78YqZcZzv3UPej9Orxp
	 HCHEZWX1QX1tRSo3rMEq4kR2rikxl0Haf2YcuF+rGoF7Kb/6E9wPUO8nySLqvScwyPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791715418;
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
	bh=Yn2/875Uf9PmK1sBbLk+zJbq91qzeG690y1e+7gE1kU=;
	b=hHJAmOcEZm2Ceg/ZDZQcFG8qWLnFIkMsTUygKaB4Eeub8K3i9rX7q4x71omK0y+CcddJ
	 9ycvmVjJ+MEtN2Jc+4iEZcRiClR9TfAbT/yFNKD6A/KOJw+nqFZBzax64MgTyA/Vt8xVt
	 8I7feHIXRMbau65mX9QMmIUu8uqDw9vd43kwTtAtaQLhIadlMa4u6L5RGjz30FV81fIrr
	 ByeGoB2LCjloML+qjVBVyK3J/PJINY8X7d4ikmpRX9hez7eG0SC6OKbkXvECp2y9ICZjN
	 IZVE48KzgOqoCPiN0wgh7C/w41X2979K76AOfkxAlPUicl/mV/e5+JHvl8EhxUF8rEw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791715417;
	bh=Yn2/875Uf9PmK1sBbLk+zJbq91qzeG690y1e+7gE1kU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xjgwdtUBmwpJi//S1mo3fMfaU+YhPOvV1+2UAs4Qq2t0m69oMuztu8BgyiaHOnFMZ
	 YW6u+EEqPRWNXej1xDhw62AgH9tTiEwUKreaZxvX5rGaAK9mfvVOwwgsF/he/RB/QT
	 FcdDB/dLwM7eeB8eVNlkR1BshQ5XmPPhPQSTJvAQMwQ7O05Ud3NhCW/gjHJ5Wf9Sf+
	 4OhjiIeXKK+kL7ToEc8iOBJOEI6dj/aRkJ20E/5h4UfjlyfVxC1tbNdnvFg2b/lXB8
	 r/h2PipjhptrgM4ZL0zQc1UVQE43R1D6W6yZg/7g2QlXwB1cJrA11bAtdjQMYOJJ7K
	 PjCZlgYihQeww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD99660612;
	Sun, 11 Oct 2026 10:43:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FACD235
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 712334062A
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:43:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B36wrCK6Toq2 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 10:43:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 97FBE4059E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791715415;
 b=PbjrBEklYG0Y0BhzmVLFv0aWfmQ7GOQU0Hrv9olf7TIJ+sniTCcevLRssRiyg4IvzQ4n
 GpdwkuR/uoX+NGFxeDkcAc1i0L/yawjnbHRdV3UIp0gDXERyjrzWMZiYZw2T22DfyQnaf
 GDBBexDicSsbWyi6KRGW7tpzLXcg8nmi3naaMMIahi0TFyP9QKxucTufpHM4iIkrgaEz1
 BJ2lMdSaJvcPiIM23Cyo8A2Cm8qoV2gVrnoZ735CbZrJ3fKG/79UZXC03dD6hrbrjrChw
 GsYUqiPZiPTB3ReFNQn6B/cJnpjlPsHI8R9w2Le2HVeIHzITOG9Z9hzMg1eDOpDXsow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791715415;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=Yn2/875Uf9PmK1sBbLk+zJbq91qzeG690y1e+7gE1kU=;
 b=hD2f/jA8d8JmHZdBbKjOHpj4637+9zPywrNAInJeOB362aKSTw5oniq9Pm/zPP2PmMvy
 yEkmqC3SA0ReGYR+LGSEuMRTV6CfUDsN4szQNHjuKcVmPpoBLv1bi1qxTwFIiFYKzqwEt
 UavVMjbmd2IbDXXuvU+Qxf0XRRFyV7fyhl95ez6te+GKva9g1WS2m0ISTGna/AgiWluwu
 SYoEBITDdDiG0qcHVIyIZC1PHxwabjaJOyN0Wn/SvdYcpUzwMbWOsQ+gCKRxrbCMFuDI3
 m1lyO7wRJmmJEZYSd/q5ZIr1uBZGRysZPBiJCDJ7bwXH0ymtyGSKrjQNGq/ARlNySlg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=tsnSpaQx; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7247=ib=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tsnSpaQx
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97FBE4059E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791715413;
 bh=Yn2/875Uf9PmK1sBbLk+zJbq91qzeG690y1e+7gE1kU=;
 b=tsnSpaQx65ysf1ie9D79OGRvjCEHp8UQmJx0iXu6UDLy5J2hn6GJjrWK/ERNL8+iZRdZfVr4S
 Ze9sxtfLyCJspsw/GhvC1W+lllD0T3QJRpXOvVhvEHXHX9f9Z/VDeMCYdOSDM5ijDdFgWPE6kX1
 DGiVrmq/IBVifLunAkaaCSZP84LICc2K0U4l78iDpgCKck4L5UvrW0h/8LhhAl3D0JJ9+0o1HF1
 zqF0x3/ItrOgX7Efj57rIpra3P+3IDPRk12WlWUnHYnYvsE0nCfRbmFpL7XZc2F9I30ydeWuD77
 dQnMWwD9GDsXQp8MdhEkfaR+H2Nr2R0A6N1unn8rDanQ==
X-Forward-Email-ID: 6acb685390d5aa3528e395f0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f9bf319a-946e-422b-96d0-9f0d2fe14615@kwiboo.se>
Date: Sun, 11 Oct 2026 12:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] rockchip: rk3568: Use fixed CRU and PMU CRU base
 addresses
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-4-jonas@kwiboo.se>
 <6729005a-3875-4854-b6e6-54d64d5bc454@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <6729005a-3875-4854-b6e6-54d64d5bc454@0leil.net>
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

On 10/9/2026 10:35 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/26 11:44 PM, Jonas Karlman wrote:
>> The rockchip_get_cru() helper is used by the sysreset_rockchip to get
>> the SoC specific CRU base address, and the rockchip_get_pmucru() helper
>> is only used by the RK3399 specific RAM driver. These helpers may
>> trigger a full clock driver probe to get the fixed CRU base address from
>> the clock driver private data, something that can take several ms.
>>
>> Change to return the fixed RK3568 specific CRU or PMU CRU base address
>> directly to simplify and remove the unneeded complexity of using runtime
>> lookup in SoC specific code.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   .../include/asm/arch-rockchip/cru_rk3568.h    |  5 +--
>>   arch/arm/mach-rockchip/rk3568/clk_rk3568.c    | 33 ++-----------------
>>   2 files changed, 5 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
>> index d72f241d0150..e2dc3cda5577 100644
>> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
>> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
>> @@ -35,7 +35,6 @@ struct rk3568_clk_info {
>>   	bool is_cru;
>>   };
>>   
>> -/* Private data for the clock driver - used by rockchip_get_cru() */
>>   struct rk3568_pmuclk_priv {
>>   	struct rk3568_pmucru *pmucru;
>>   	ulong ppll_hz;
>> @@ -120,8 +119,10 @@ struct pll_rate_table {
>>   	unsigned int frac;
>>   };
>>   
>> -#define RK3568_PMU_MODE			0x80
>> +#define RK3568_PMU_CRU_BASE		0xfdd00000
>>   #define RK3568_PMU_PLL_CON(x)		((x) * 0x4)
>> +#define RK3568_PMU_MODE			0x80
>> +#define RK3568_CRU_BASE			0xfdd20000
>>   #define RK3568_PLL_CON(x)		((x) * 0x4)
>>   #define RK3568_MODE_CON			0xc0
>>   
>> diff --git a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
>> index 1c6b2ece602b..ccd98a91cd16 100644
>> --- a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
>> +++ b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
>> @@ -4,10 +4,7 @@
>>    */
>>   
>>   #include <dm.h>
>> -#include <syscon.h>
>> -#include <asm/arch-rockchip/clock.h>
>>   #include <asm/arch-rockchip/cru_rk3568.h>
>> -#include <linux/err.h>
>>   
>>   int rockchip_get_clk(struct udevice **devp)
>>   {
> 
> There's no user of that function anymore after this patch, so just 
> squash the patch removing it later in this series with this patch here.

This function is technically a public function declared in
asm/arch-rockchip/clock.h. Removing it in same patch that refactors to
use a constant seem like it would go against your normal stand on not
doing two different things in one patch, and a reason why it was split
to begin with ;-)

Regards,
Jonas

> 
> Cheers,
> Quentin

