Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BE0C5516D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 19:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64C4840D0D;
	Thu, 30 Jul 2026 19:29:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EgJLFpcUp6vj; Thu, 30 Jul 2026 19:29:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9992640D06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785439792;
	bh=m3MUEcWW6J/y/0PsmsK4Koe+j1rJ8lrYXdEfPwFBgx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g0S85tYTs8MdRDgrCCUDZrsVIw5PgHqTOD6EFMQozT5V2ur0bWoRprHnsQAzyHi93
	 ZftPXJ0UanR6LNqC9M69uveBQX6Ll8+Oae/u74vhZO8SdlFFj5pJmhlxWSWPMngVQP
	 7iWb+AWgBtfiRPzWq6NBjnfC5wwKfwGS87n3eWcWx9UZ879dl7D40zlSJdp56Z5ixS
	 cLM0/dk85nXgFC+Nb/zs8gNSEn3/EdRxp3QTaU1qBY2jG5/TdyimRmN3emC141dVUM
	 Mnmgf1HFoaxAVXFrWaT6YX26cbkAZ77i+h/sGQzkoH0FE2fBFKWYBL84y2+GXhpTG9
	 QKV4F0HPF6qVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9992640D06;
	Thu, 30 Jul 2026 19:29:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D4BC227C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BADBD40094
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xf-8PYo8OToD for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 19:29:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 777AC40090
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 777AC40090
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 777AC40090
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:29:47 +0000 (UTC)
X-Forward-Email-ID: 6a6ba625cc73bb7f85bc5c7e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d6fed548-ca94-4d34-9902-9b61b240a4a9@kwiboo.se>
Date: Thu, 30 Jul 2026 21:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3576: Disable force_jtag by default
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260730123001.1211166-1-jonas@kwiboo.se>
 <dd4b848e-6007-4299-8889-56f020c7eb80@cherry.de>
 <62593683-5bb0-4e14-80eb-08239867ee88@kwiboo.se>
 <efa0739a-eeee-4e30-97cb-a54c034e7744@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <efa0739a-eeee-4e30-97cb-a54c034e7744@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785439787;
 bh=m3MUEcWW6J/y/0PsmsK4Koe+j1rJ8lrYXdEfPwFBgx8=;
 b=EEqZrMp9gVfHeURWA6XRMpTu/kiCBEO+iviQeD8JjAmvA4DwNlYrLBAUls4MwTKYd1EHxLNuz
 jXdcIFMDJhefNfwODeIhB7dWLTcKrwoLGbQ4Fh8EhCDdBeeynpf7OpdO4f/cxS+GEt7RuxVZ+K/
 B4jrjE7dK3d4xVDokEM15jHE2LgRXlD8xbF6QckoACK3YlRJusK5Qi9XMsgYreSrWVo97Y5X2aV
 jv1WlVr4ZjgIHlPA2HCiTFKK65bAMgDgaZmrwVIVEhz+5gjWFRZLiK9WUOyJfSATBKH1ezUgyqi
 PVn3dLkfzHSzkoGbvMgW3Aq8xiGYMEKOk4X2y9bb35Tg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=EEqZrMp9
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On 7/30/2026 5:19 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/30/26 4:35 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 7/30/2026 4:17 PM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 7/30/26 2:30 PM, Jonas Karlman wrote:
>>>> Rockchip SoCs can automatically switch between jtag and sdmmc based on
>>>> the following rules:
>>>> - all the SDMMC pins including SDMMC_DET set as SDMMC function in GRF,
>>>> - force_jtag bit in GRF is 1,
>>>> - SDMMC_DET is low (no card detected),
>>>>
>>>> Note that the BootROM may mux all SDMMC pins in their SDMMC function or
>>>> not, depending on the boot medium that were tried.
>>>>
>>>> Because SDMMC_DET pin is not guaranteed to be used as an SD card card
>>>> detect pin, it could be low at boot or even switch at runtime, which
>>>> would enable the jtag function and render the SD card unusable.
>>>>
>>>> Or boards using cd-gpios may switch the SDMMC_DET pin to GPIO function,
>>>> which would enable the jtag function and render the SD card unusable.
>>>>
>>>> With commit d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of dts repo [1]
>>>> into dts/upstream") there are now RK3576 boards that have changed to use
>>>> cd-gpios for the SDMMC_DET pin, e.g. NanoPi R76S, that may have issues
>>>> detecting SD card unless force_jtag is disabled.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>    arch/arm/mach-rockchip/rk3576/rk3576.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
>>>> index e3e93f663959..0f41f210a9a5 100644
>>>> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
>>>> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
>>>> @@ -26,6 +26,9 @@
>>>>    #define SYS_SGRF_SOC_CON15	0x005C
>>>>    #define SYS_SGRF_SOC_CON20	0x0070
>>>>    
>>>> +#define TOP_IOC_BASE		0x26044000
>>>> +#define IOC_MISC_CON		0x00F0
>>>> +
>>>>    #define FW_PMU1SGRF_BASE	0x26003000
>>>>    #define PMU1SGRF_SLV_LOOKUP0	0x80
>>>>    
>>>> @@ -190,6 +193,10 @@ int arch_cpu_init(void)
>>>>    	 */
>>>>    	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
>>>>    
>>>> +	/* Disable JTAG exposed on SDMMC pins (GPIO2A2 and GPIO2A3) */
>>>> +	if (IS_ENABLED(CONFIG_ROCKCHIP_DISABLE_FORCE_JTAG))
>>>> +		writel(0x00020000, TOP_IOC_BASE + IOC_MISC_CON);
>>>> +
>>>
>>> Please:
>>> - use a constant (e.g. #define TOP_IOC_FORCE_JTAG BIT(1))
>>> - use rk_clrreg(TOP_IOC_BASE + IOC_MISC_CON, TOP_IOC_FORCE_JTAG)
>>>
>>> It'd be nice to be consistent here and do the same for other writel all
>>> over arch/arm/mach-rockchip/ but that's a different kind of task :)
>>
>> I know we are inconsistent across multiple SoCs, however in rk3576 we
>> are exclusivity using writel() so I decided to continue to use writel()
>> for this change for consistency with surrounding code, and therefore
>> disagree with your suggested changes :-)
>>
>> In my opinion mixed used of both writel() and rk_reg() funcs are worse
>> than a consistent use of writel() within same file and function.
>>
> 
> I understand but this here is quite misleading as it could be understood 
> as "you need to write bit 16 to disable JTAG" which is technically 
> correct, but only because bit 1 is 0 and that is the one that actually 
> matters.
> 
> Can we maybe compromise on using
> writel(RK_CLRBITS(TOP_IOC_FORCE_JTAG), TOP_IOC_BASE + IOC_MISC_CON)
> ?

Possible, what we really should do is to import hw_bitfield.h from Linux
and start using FIELD_PREP_WM16() instead of using the rk_xregs and
RK_xBITS macros, should be easier now that bitfield.h have been updated.

The rk_xregs and RK_xBITS macros currently have what I consider a design
flaw/limitation in that they have no mask parameter and instead treat
(clr | set) as the mask, meaning you can very easily overflow the
intended field or be incorrectly used to clear one field and set another.

I have been working on a future series that converts RK35xx clock
drivers to use FIELD_GET/PREP, but should probably also change to use
FIELD_PREP_WM16 and drop use of rk_clrsetreg() before posting.

Will see if I can import hw_bitfield.h and change to use FIELD_PREP_WM16
for a v2.

Regards,
Jonas

> 
> Cheers,
> Quentin

