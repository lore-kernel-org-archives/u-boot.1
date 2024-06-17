Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E26C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECE3A882F0;
	Mon, 17 Jun 2024 16:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=writeme.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=writeme.com header.i=sinan@writeme.com header.b="LmxfABw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B76F288307; Mon, 17 Jun 2024 16:10:31 +0200 (CEST)
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61589882FA
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=writeme.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sinan@writeme.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=writeme.com;
 s=s1089575; t=1718633423; x=1719238223; i=sinan@writeme.com;
 bh=YmcYxqwvgCEWoPTyQGGUTMlwDY3uLAfNO5Yde1tMCLA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LmxfABw0ubF0+i6T7Eu3woirSDPJSSnO4fw5EjrKm8hFzt61hocCL3N1H9C6Knxt
 00RaJrA7RhCHF50gjT3m1lXGLGCunsRTqx09Biwa3EZ8qpEqiSqm2uJ4EdGwK2VcI
 ClB17dZketzJnhGNF42TxiCgVSwbQaocox7zS73LmLArFKTWSZX0ZeZWNhRR84V8S
 lt/Q3d78Obx1cd0j6wyWcFK4B98p2wLuOJnl3Jc+gJzeBdd5oee26uGAyO63t180l
 URxUuozZWTaJ0eeLxx1m8xDl8lzs3//gMQ80BKGUiSXsE6Sojeg9l9K7xcR7XDTcR
 k5VqtMm9c7xuW/vwOw==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.1.23] ([85.153.225.143]) by smtp.mail.com (mrgmxus004
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0MDiX2-1s9vGr1zkk-006eO4;
 Mon, 17 Jun 2024 16:10:23 +0200
Message-ID: <eb09ea16-8c1f-46e3-91d5-f805d03a9e06@writeme.com>
Date: Mon, 17 Jun 2024 10:10:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] board: freescale: p1_p2_rdb_pc: Add weak function
 p1_p2_rdb_pc_fix_fdt_model() for fixing DT model string
To: =?UTF-8?Q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240606163326.386950-1-marek.mojik@nic.cz>
 <20240606163326.386950-3-marek.mojik@nic.cz>
 <b8ae27d5-8131-4031-ad18-d467ecb8227d@writeme.com>
 <6b35d9a3-7705-4b83-818a-b4141d5df577@nic.cz>
Content-Language: en-US
From: Sinan Akman <sinan@writeme.com>
In-Reply-To: <6b35d9a3-7705-4b83-818a-b4141d5df577@nic.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lcDGCB1FDgISAgoZFKaMqECMqFi4jtGwzegvocDBdM5jaZrRAbl
 F67iDwSVQXVl/dRseQNxOiA8XfS4aPZtIu5ig9GCM67JidpHF8sdZAImGQGh2PM1DYmbBAl
 0TOAYOwBg1JXiN5f23HsABHieA8rP2ZoZ95D6Gvu0eZRU0mgLx722eSnfXwpc3bGRSTOw99
 dx6wZLPpr3cEWrrsjkAKg==
UI-OutboundReport: notjunk:1;M01:P0:UWzZewnh78U=;BAmLO7kJERsAKDms094d9qI42I6
 N2q+309P+dZm8EPuKSzBPeVLCPLxz6kwR/r3IVoxu/QWqSKdSuCX7LloDC2fntcM9rZoSwx90
 3y09QNuCLEWDIpibFECpLd9A97aQDgV/wXPRCnlHgrl959aQE2CDz8cppfmh4abhrHmxty+6W
 DpnDZ9rSaywuPgrmDQDvB1FFPHd07hvSrr/FLn++s8EEEJPP70zF9/voixk6qhlnbHew9Zzy4
 Qm30pV+p49OwEb0WhJcGN1Bq5ickmU8TPlKzbVQQxCS/e+GAHYxRr7p9UsfcjEIsByws0b9Yt
 2JwTxWosNHlaCS5yJscz6QrPxYnMHoO4Ph0ISbcl4ThttcZl/CXYgGNkg54y0HwidhcGB6F3i
 ljKff2i+9JE7yi2rRCJNgVspjiJni4hwNK189iE+QhG0kqTICRkFGQtHYiWWqeJvl8nBy/FK/
 Ha70WlX40O/LeKuwhP7oGvJXTlmTdpXcOveO17FP9MtCXyBe0yq0fxmHaJQi+QRaJLacSlVH8
 kLjYLyCsSXAFL3FmPdZbHa9Oguawmn1tj5ksQkR/pFaCzJz273l3mm77pXu4eY2zpp7/OHZZX
 FICSdYpbURIFztldA3WDmP0SRsYjcWIcaCZMrA73gyXmfcf0wmrjhzpf7ZUo2aFs4FzGDRDCO
 22ilbD/Buk4Y0pW7W5eLN2MSEkrU5/cvZbIfhiUBuQaD98nSkAD3jHMvEqsKo5y9eXeu5yyrz
 0k3SVcgd6BCe1+nexnkqGc6E+cIecDLR4wCW61t0cXbvATOXS4pmZNbdrVUGVeeJ/eT0LJdhp
 MSVPHRbOv/IGoQjC6/9x8SDTf6HMB59CbS47D6DjklDhJ9RsjtvjL3bQ9m1Vam1Cd8oycv6QA
 sxZmFJ/CLH53//w==
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



On 2024-06-17 8:16 a.m., Marek Moj=C3=ADk wrote:
>
>
> On 6/7/24 1:32 AM, Sinan Akman wrote:
>>
>> On 2024-06-06 12:33 p.m., Marek Moj=C3=ADk wrote:
>>> From: Pali Roh=C3=A1r <pali@kernel.org>
>>>
>>> This allows boards to fixup / overwrite DT model string when booting O=
S.
>>>
>>> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>>> Signed-off-by: Marek Moj=C3=ADk <marek.mojik@nic.cz>
>>> ---
>>> =C2=A0 board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c | 4 ++++
>>> =C2=A0 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
>>> b/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
>>> index 399ff72072..336d274cdb 100644
>>> --- a/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
>>> +++ b/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
>>> @@ -364,6 +364,8 @@ int board_early_init_r(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>>
>>> +__weak void p1_p2_rdb_pc_fix_fdt_model(void *blob) {}
>>> +
>>> =C2=A0 #if defined(CONFIG_OF_BOARD_SETUP) || defined(CONFIG_OF_BOARD_F=
IXUP)
>>> =C2=A0 static void fix_max6370_watchdog(void *blob)
>>> =C2=A0 {
>>> @@ -407,6 +409,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sizeof("okay"), 0);
>>> =C2=A0 #endif
>>>
>>> +=C2=A0=C2=A0=C2=A0 p1_p2_rdb_pc_fix_fdt_model(blob);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fix_max6370_watchdog(blob);
>>>
>>> =C2=A0 #if defined(CONFIG_HAS_FSL_DR_USB)
>>> @@ -464,6 +467,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>>> =C2=A0 #ifdef CONFIG_OF_BOARD_FIXUP
>>> =C2=A0 int board_fix_fdt(void *blob)
>>> =C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 p1_p2_rdb_pc_fix_fdt_model(blob);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fix_max6370_watchdog(blob);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>
>>
>> Hi Marek
>>
>> I have a P2020-RDB board and last time I tried to test ToT (couple
>> months ago)
>>
>> I needed to remove a watchdog patch that was added by Pali (a year+
>> ago). I
>>
>> believe because of the differences in CPLD that patch kept resetting on
>> my board.
>>
>>
>> I am traveling (again) but when I am back on July 10th I can give a
>> try to
>>
>> test this if you prefer.
>>
>>
>> Best regards
>>
>> Sinan Akman
>>
>
>
> Hi Sinan,

   Hi Marek

>
> What do you mean by ToT?

   I meant tip of the tree.

> ... Regardless, I don't have access to P2020-RDB,
> so you will have to test it yourself.

   Will do.

   Thanks
   Sinan Akman
