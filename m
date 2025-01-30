Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F74BC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 13:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7DF82099;
	Thu, 30 Jan 2025 14:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="O3vVfThT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526D2820A0; Thu, 30 Jan 2025 14:23:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 645B680EB1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738243406; x=1738848206; i=xypron.glpk@gmx.de;
 bh=HREH9axiwuny5RCLxJYv++LSnLlTPnSGst9X2fJGM1A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=O3vVfThTxX4XbS2vfrGiEEEJLvDeP4UaWbdTXGB8oIJaVyOktvfcaXbS8TvxEPXg
 eFsFmG0FX8GgH9tlMl2NVSLBAnPPDxFZM6FYg11JLUI7Sl9tCC5hayfzU9oC0HAPO
 BKZPMByVx1YDofSK+a5Le2OWMHTHCaWidALTDHM2vEAmnjrXE6Wjs5vbnEsnuehmL
 Mq9VjE7mRJqAjDtFIzlQrTvG5HsKmCu0GaIWN9w8Ts7kVsqxgAgR22jWxittGzsF/
 3tGvs93NhYmBeolq1D5sEPZtLHxMefZLq6BVahXSwRqT7tZSkhAOi7UUg+e121Ztv
 ZNmEUl49SP/POFaepg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.109.104]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU5R-1szBt707MZ-00iIYt; Thu, 30
 Jan 2025 14:23:26 +0100
Message-ID: <bfbf426d-f4dd-4167-bc9a-4228bedd9418@gmx.de>
Date: Thu, 30 Jan 2025 14:23:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] arm64: Change mapping for data/rodata/text
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-5-ilias.apalodimas@linaro.org>
 <22898270-b5b6-4bcb-9c4a-f3d62dbf5c86@gmx.de>
 <CAC_iWjLc1KEeBze3CL9E7pd=--6KifGCprZ6r+uDGEoSTTPmMw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjLc1KEeBze3CL9E7pd=--6KifGCprZ6r+uDGEoSTTPmMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WxlhAvHiQiYD86JTZT4A+Vw/ZKKbjNYHM0mSmGwbQn0AFym+/rx
 CSJGd5d0iyz/kTakrb2tDkMYKuk3FYOEo3XjbbXcnEjRNA0G+ZLxkLO59bCDV970wjggnwq
 vQWqUdv6EcOHztiskDwJ24vRfpF+4dAPQZ+zRCV5gGGVy3C+HUpGI95Rx5IdEHgs0NUoPab
 jmttk5RIjpzcUC1YuA9RA==
UI-OutboundReport: notjunk:1;M01:P0:q3CKiM2q32w=;6ICDly4wJLbU6VIryi0l2zYq147
 DsDJ02J16ULUvNvaWuLz7/ifmOx7b4LAq06C0+cr/KZTvO0WJyPlHMJ9osPekxOIq3raSVhOZ
 LC+vd63iTrSfWTiMqKmZNNS4H19ufyl71sMIowsGxusIAjt2jMEKVSrqwEebYSU7H0WI4VxTv
 yci+s1OYnEVvfdHK1MNMbEjptMRt0W9kkZeihG1d0o48JQ76QuU3G9GCChJDi88T0/TZmI7a8
 6r5LSbltI+Ybshba9UpbUabLUpJhnZzw22kAm2gciZMrmm+SXkt25aO+BQJSuEVP5K5ptY834
 1UbvgwKDBPsPi7xr2vDSg+lMxsdBcRMV7rgxnaCHyy8RbTYKrH6axTG35qfOGhoJX61pcq8Pp
 khUerjT+NmFIidQ1UxFgX4uq/PrIM6J2NCyRRNKPxEks3YacGMdS1vr9sZW1Cmf8DTkMh5lYZ
 mAjuduXTyNctwPXJxiph2Z5j/K2YE0pI5p0V097SDa1nUqCqWrp+PwXOkLmqF5On2Pbz5GEW8
 H2j1l/LGKf7lgrXSp2ynIYwD9vdc3aQb+XIeQ8mYvTx8WWUWvvIcjg3H9Q7mrXhDXOtqwp30E
 Sf3PLhK8Ze61bAgHAVP84obqipjZ92vmaM5GHjcJouS8LymVZJ6R4z1q06yVdN4nGbGRXYRpo
 SGaHcyWNcZ/iKxlLMJ6Biqr/VolIaNIjivkjJi5A3Ho/aXA6kj8trxFeWvjof9AesSheQHQeQ
 XwjcV15crry+/FBDaYIhj79W2fd1TT5NT0lK6DMmEHU4YP+u9gb61ngYfObcxIVdpmvsJTx/9
 dWnZUF7fSRjUOd0Rv/RmILGcKZnAjd7sE/6CgacP8Af6GR8WwaqU7EW4xlf0QJ2onv5rTTYrH
 ZRvKOBZ6ZLQpsiFGvYteoyL2aPD+CigQN49tSs+kSGQqr1nT0zIYdtCOVCAWRWo/DGYfKFiq3
 FrdYVqeftSKFlua2mDZsy0g06IKRyyNNqBo3r+dLtG3aMv8OQ8KkNg89Dw8gueGfhqlAajgGa
 zIfIZ4khJk2i6E8uflt3Kh5WFkTVY+q0JozmMEJF0oYEY3WpMVKaTzyXvnGsbjej9vkenSDkc
 DkWjFeXaT0wQTjfPLTZDoCqZY6V3q7ToODckH7fcaCyKdBvVmoqtxnPjyUOKb9Rg1DzHgW9I5
 iytMaSi4Q9395G/jPbxnd/PMX5oI4Mb1cCKaW0JZMZQ==
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

On 1/30/25 10:29, Ilias Apalodimas wrote:
> Hi Heinrich,
>
> On Thu, 30 Jan 2025 at 12:24, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 1/30/25 07:20, Ilias Apalodimas wrote:
>>> Now that we have everything in place switch the page permissions for
>>> .rodata, .text and .data just after we relocate everything in top of t=
he
>>> RAM.
>>>
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> ---
>>>    common/board_r.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/common/board_r.c b/common/board_r.c
>>> index 179259b00de8..38944f600fd6 100644
>>> --- a/common/board_r.c
>>> +++ b/common/board_r.c
>>> @@ -170,6 +170,13 @@ static int initr_reloc_global_data(void)
>>>        efi_save_gd();
>>>
>>>        efi_runtime_relocate(gd->relocaddr, NULL);
>>> +
>>> +#if (IS_ENABLED(CONFIG_ARM64))
>>
>> '#if' should be replaced by 'if (CONFIG_IS_ENABLED())'.
>>
>> Shall we make mmu_set_attrs() a weak function which each architecture
>> can override?
>
> In order to do the IS_ENABLED as you asked, we need to define a weak
> function, otherwise the linker will complain.
> I can add a generic mmu_set_attrs() in the next version. The right way
> to do this in the future is to have a proper MMU API.

For IS_ENABLED you only need the definition in the header file and the
implementation where it is configured.

With the weak function no 'if' is needed.

Best regards

Heinrich

>
>>
>>> +     mmu_set_attrs((u64)(__start_rodata), (u64)(__end_rodata - __star=
t_rodata), 1);
>>> +     mmu_set_attrs((u64)(__start_data), (u64)(__end_data - __start_da=
ta), 3);
>>> +     mmu_set_attrs((u64)(__text_start), (u64)(__text_end - __text_sta=
rt), 2);
>>
>> Please, replace 1, 2, 3 by constants both here and in mmu_set_attrs, e.=
g.
>>
>> 1 -> MMU_ATTR_RO
>> 2 -> MMU_ATTR_RX
>> 3 -> MMU_ATTR_RW
>
> Yea I am explaining the same thing in the cover letter
>
> Thanks
> /Ilias
>>
>> Best regards
>>
>> Heinrich
>>
>>> +#endif
>>> +
>>>    #endif
>>>
>>>        return 0;
>>

