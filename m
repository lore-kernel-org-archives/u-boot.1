Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DF2FCA18E
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A31483A8C;
	Mon,  9 Mar 2026 22:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CKNmS0CO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A30583BC8; Mon,  9 Mar 2026 22:19:37 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C84BB83952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1773091173;
 bh=kuhpxkc90eWGjKcFCbD2Ed+nVMTnZCRt4ynYrTz5cuk=;
 b=CKNmS0CO0wIng8PIyPqOI4MyE1/sJeh7mYsTxv+H9fR7jZKeMvrkUCSkmnZ42Qcvq9uCBMpNH
 meYVvv8a9bc0Z6FAUHBm8FwZ29crgbadZZTNon050bZdsdoD/Vuani/13yRS4w0iPuLNehaOSXp
 I5chnhziBSdDXIQ8/jPovf26pvC61Z9vdl3Fm+D5glcL4pbV/bMNND9ZsvoIQcooYEe2hdQ0L74
 sSsVAl0M2GZkKqDKjEuMobO3SZojwznJ1xWHrQItQSe7p+W943qYSF9S6Y2F/59WX9RQqQqE0QM
 WCf4bri41LFU71oObpmPOzdABxwzmPmD6cOB+AdTKt/A==
X-Forward-Email-ID: 69af396473df1871069cad60
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <25eb3b47-976e-41ff-b51d-fc828314e200@kwiboo.se>
Date: Mon, 9 Mar 2026 22:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: scale buffer pool size with TFTP block size
To: "Vinay Tilak, Pranav" <Pranav.VinayTilak@amd.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Simek, Michal" <michal.simek@amd.com>, "git (AMD-Xilinx)" <git@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>, Tom Rini <trini@konsulko.com>,
 "nd@arm.com" <nd@arm.com>
References: <20260305064033.8726-1-pranav.vinaytilak@amd.com>
 <a3262e83-95dd-46fe-a0cf-fd6d7e429ab1@arm.com>
 <PH0PR12MB70963209D076B0D27A12FFDFFB79A@PH0PR12MB7096.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <PH0PR12MB70963209D076B0D27A12FFDFFB79A@PH0PR12MB7096.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 3/9/2026 2:19 PM, Vinay Tilak, Pranav wrote:
> [Public]
> 
> Hi Jerome,
> 
>> -----Original Message-----
>> From: Jerome Forissier <jerome.forissier@arm.com>
>> Sent: Monday, March 9, 2026 1:38 PM
>> To: Vinay Tilak, Pranav <Pranav.VinayTilak@amd.com>; u-boot@lists.denx.de;
>> Simek, Michal <michal.simek@amd.com>
>> Cc: git (AMD-Xilinx) <git@amd.com>; Begari, Padmarao
>> <Padmarao.Begari@amd.com>; Tom Rini <trini@konsulko.com>;
>> nd@arm.com
>> Subject: Re: [PATCH] net: lwip: scale buffer pool size with TFTP block size
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> Hi Pranav,
>>
>> On 05/03/2026 07:40, Pranav Tilak wrote:
>>> TFTP transfers fail when tftpblocksize is set to 8192 or larger due to
>>> insufficient buffer resources for IP fragment reassembly.
>>>
>>> Adjust PBUF_POOL_SIZE and IP_REASS_MAX_PBUFS based on
>>> CONFIG_TFTP_BLOCKSIZE to support larger TFTP transfers while keeping
>>> memory usage efficient.
>>>
>>> - CONFIG_TFTP_BLOCKSIZE >= 12288:PBUF_POOL_SIZE=18,
>>> IP_REASS_MAX_PBUFS=12
>>>
>>> - CONFIG_TFTP_BLOCKSIZE >= 8192:PBUF_POOL_SIZE=12,
>>> IP_REASS_MAX_PBUFS=6
>>>
>>> - CONFIG_TFTP_BLOCKSIZE undefined: PBUF_POOL_SIZE=8,
>>> IP_REASS_MAX_PBUFS=4
>>
>> How are these values computed? Could you find a formula instead of using
>> #if/#elif/#else/endif?
> 
> We can use this formula for calculating the values of PBUF_POOL_SIZE and IP_REASS_MAX_PBUFS.
> 1500 (MTU) - 20 (IP header) = 1480 usable bytes/fragments.
> IP_REASS_MAX_PBUFS = (((CONFIG_TFTP_BLOCKSIZE) + 1479) / 1480) + 2
> [ceiling division to calculate fragment count + some headroom for next block sync].
> PBUF_POOL_SIZE = (IP_REASS_MAX_PBUFS) * 2
> [Reassembly buffers * 2].

The lwip comment for IP_REASS_MAX_PBUFS only suggest PBUF_POOL_SIZE is
more than 2x IP_REASS_MAX_PBUFS when both IPv4 and IPv6 is enabled.

Maybe something like following should work?

  #if defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE > 4096
  #define PBUF_POOL_SIZE                  (((CONFIG_TFTP_BLOCKSIZE + 1479) / 1480) + 6)
  #else
  [...]
  #define IP_REASS_MAX_PBUFS              (PBUF_POOL_SIZE - 4)

That seem to work great when I test with TFTP_BLOCKSIZE=16352 on my
Rockchip boards together with a PBUF_POOL_BUFSIZE fix [1].

[1] https://lore.kernel.org/u-boot/20260309210642.522626-1-jonas@kwiboo.se/

Regards,
Jonas

> 
> We can scale only if CONFIG_TFTP_BLOCKSIZE > 4096 else use the default values.
>>
>> Thanks,
>> --
>> Jerome
>>
>>> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
>>> ---
>>>  lib/lwip/u-boot/lwipopts.h | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
>>> index e8a2c9d7a0a..b4ff31096fe 100644
>>> --- a/lib/lwip/u-boot/lwipopts.h
>>> +++ b/lib/lwip/u-boot/lwipopts.h
>>> @@ -65,7 +65,14 @@
>>>  #define MEM_ALIGNMENT                   8
>>>
>>>  #define MEMP_NUM_TCP_SEG                16
>>> +
>>> +#if defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >=
>> 12288
>>> +#define PBUF_POOL_SIZE                  18
>>> +#elif defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >=
>> 8192
>>> +#define PBUF_POOL_SIZE                  12
>>> +#else
>>>  #define PBUF_POOL_SIZE                  8
>>> +#endif
>>>
>>>  #define LWIP_ARP                        1
>>>  #define ARP_TABLE_SIZE                  4
>>> @@ -76,7 +83,15 @@
>>>  #define IP_REASSEMBLY                   1
>>>  #define IP_FRAG                         1
>>>  #define IP_REASS_MAXAGE                 3
>>> +
>>> +#if defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >=
>> 12288
>>> +#define IP_REASS_MAX_PBUFS              12
>>> +#elif defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >=
>> 8192
>>> +#define IP_REASS_MAX_PBUFS              6
>>> +#else
>>>  #define IP_REASS_MAX_PBUFS              4
>>> +#endif
>>> +
>>>  #define IP_FRAG_USES_STATIC_BUF         0
>>>
>>>  #define IP_DEFAULT_TTL                  255
> 
> Thanks,
> Pranav Tilak

