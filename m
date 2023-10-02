Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D66E7490C
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 19:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80DFD86DBC;
	Mon,  2 Oct 2023 21:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="husae6c5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A15586D59; Mon,  2 Oct 2023 21:29:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A29286DD3
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 21:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bc9a=FR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1696274938;
 bh=Rl3pa15kIxuKdcUR2Plz7qwWT0uhAmKM5/zWIAhxIb8=;
 b=husae6c5/nJB1UM0lKodJHFmUx7QbK6NeYgBzvWB6KQjJDIcrI/As+0Sufz8Qr5PeZqnBnyKw
 CIq4X+UTFu2ezkgMGiKRX5XTl4AaoSSQcU8+6fxVijM+LauDiF9sdvhEdDcBM5mxqAd6GvZSHsd
 ldtyEKQRxXQY9XQj81Bm8S/XKTbWRxCQgkNwr26yyah+fJNisoiMlEk4dgYStptYbFCBQkjuy/9
 vQhsgK1nB18Kf1MN3shxZhPPbeGafDx+5l+sHWLP9HcE3pYxbI17QVohSPPKFI9FbbXg/NCNYZb
 /YuoZVmfLSlP5BDRQskAfGFJJE0Pn6JAaPBwBwyfI61g==
Message-ID: <550d1f16-b788-d2b5-c2d9-fe5d199e63e1@kwiboo.se>
Date: Mon, 2 Oct 2023 21:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
Content-Language: en-US
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de, Ferass El Hafidi <vitali64pmemail@protonmail.com>
References: <20230929230655.2932698-1-jonas@kwiboo.se>
 <CAPnjgZ2O7kxiRt9j3forPPjm=R5EgmLdZKVrwVbyR156YhNDpw@mail.gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAPnjgZ2O7kxiRt9j3forPPjm=R5EgmLdZKVrwVbyR156YhNDpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 651b19f9bc08fefbb6f1b9de
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

On 2023-10-02 20:56, Simon Glass wrote:
> On Fri, 29 Sept 2023 at 17:07, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> The alignment hole caused by cmdidx in struct mmc_cmd cause strange
>> issues together with the peephole2 optimization on Amlogic SoCs.
>> Following was observed while working on SPL support for Amlogic SoCs.
>>
>> sd_get_capabilities() normally issue a CMD55 followed by a CMD51.
>> However, on at least Amlogic S905 (Cortex-A53) and S905X3 (Cortex-A55),
>> CMD55 was instead followed by CMD8 (and a few reties) in SPL.
>>
>> Code from the call site:
>>
>>   cmd.cmdidx = SD_CMD_APP_SEND_SCR; // 51
>>   ...
>>   data.blocksize = 8;
>>   ...
>>   err = mmc_send_cmd_retry(mmc, &cmd, &data, 3);
>>
>> Running the code with MMC_TRACE enabled shows:
>>
>> CMD_SEND:55
>>                 ARG                      0x50480000
>>                 MMC_RSP_R1,5,6,7         0x00000920
>> CMD_SEND:8
>>                 ARG                      0x00000000
>>                 RET                      -110
>>
>> Removing the alignment hole by changing cmdidx from ushort to uint or
>> building with -fno-peephole2 flag seem to resolve this issue.
>>
>> CMD_SEND:55
>>                 ARG                      0x50480000
>>                 MMC_RSP_R1,5,6,7         0x00000920
>> CMD_SEND:51
>>                 ARG                      0x00000000
>>                 MMC_RSP_R1,5,6,7         0x00000920
>>
>> Same issue was observed building U-Boot with gcc 8-13. Please advise on
>> how to best work around this possible gcc optimization bug.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  arch/arm/cpu/armv8/config.mk | 2 ++
>>  include/mmc.h                | 2 +-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
>> index 4d74b2a533e0..7177dcd7c73b 100644
>> --- a/arch/arm/cpu/armv8/config.mk
>> +++ b/arch/arm/cpu/armv8/config.mk
>> @@ -7,6 +7,8 @@ PLATFORM_RELFLAGS += $(call cc-option,-mbranch-protection=none)
>>  PF_NO_UNALIGNED := $(call cc-option, -mstrict-align)
>>  PLATFORM_CPPFLAGS += $(PF_NO_UNALIGNED)
>>
>> +PLATFORM_CPPFLAGS += $(call cc-option,-fno-peephole2)
> 
> Eek really?

As mentioned the issue could be resolved with changing cmdidx from
ushort to uint or disabling the peephole2 optimization.

For the purpose of trying to get more feedback on the issue I included
both changes that would resolve my issue.

Also if there is one struct affected, there could be other similar
structs affected by a similar issue.

I do not really know if this could be a cpu errata, compiler bug or
something else, including some assembly from a non-working and working
case (peephole2 optimization enabled/disabled).

Code generated with ushort and peephole2 enabled (not working):

  60 06 80 52     mov        w0,#0x33		// 51
  f5 3f 06 91     add        x21,sp,#0x18f
  e0 23 01 79     strh       w0,[sp, #cmd]
  e0 03 00 b2     mov        x0,#0x100000001
  b5 e6 7a 92     and        x21,x21,#-0x40
  f5 03 06 a9     stp        x21,x0,[sp, #data]
  00 01 80 52     mov        w0,#0x8
  e2 83 01 91     add        x2,sp,#0x60
  e1 43 02 91     add        x1,sp,#0x90
  63 00 80 52     mov        w3,#0x3
  e0 73 00 b9     str        w0,[sp, #blocksize]
  e0 03 13 aa     mov        x0,x19
  f6 ff 12 29     stp        w22,wzr,[sp, #resp_type]
  50 fd ff 97     bl         mmc_send_cmd_retry

Code generated with ushort and peephole2 disabled (working):

  60 06 80 52     mov        w0,#0x33		// 51
  e0 23 01 79     strh       w0,[sp, #cmd]
  e0 03 00 b2     mov        x0,#0x100000001
  f5 3f 06 91     add        x21,sp,#0x18f
  e0 37 00 f9     str        x0,[sp, #local_168]
  00 01 80 52     mov        w0,#0x8
  b5 e6 7a 92     and        x21,x21,#-0x40
  e2 83 01 91     add        x2,sp,#0x60
  e1 43 02 91     add        x1,sp,#0x90
  63 00 80 52     mov        w3,#0x3
  f5 33 00 f9     str        x21,[sp, #data]
  e0 73 00 b9     str        w0,[sp, #blocksize]
  e0 03 13 aa     mov        x0,x19
  f6 97 00 b9     str        w22,[sp, #resp_type]
  ff 9b 00 b9     str        wzr,[sp, #cmdarg]
  4a fd ff 97     bl         mmc_send_cmd_retry

Hoping someone can see something strange I cannot.

Regards,
Jonas

> 
>> +
>>  EFI_LDS := elf_aarch64_efi.lds
>>  EFI_CRT0 := crt0_aarch64_efi.o
>>  EFI_RELOC := reloc_aarch64_efi.o
>> diff --git a/include/mmc.h b/include/mmc.h
>> index 9aef31ea5deb..7b3868bb5664 100644
>> --- a/include/mmc.h
>> +++ b/include/mmc.h
>> @@ -413,7 +413,7 @@ struct mmc_cid {
>>  };
>>
>>  struct mmc_cmd {
>> -       ushort cmdidx;
>> +       uint cmdidx;
> 
> This bit looks OK.
> 
>>         uint resp_type;
>>         uint cmdarg;
>>         uint response[4];
>> --
>> 2.42.0
>>
> 
> Regards,
> Simon

