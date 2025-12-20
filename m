Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A263E668B4
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 16:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B087835B3;
	Sat, 20 Dec 2025 17:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lWvxj9cK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19F5833C6; Sat, 20 Dec 2025 17:57:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC0080050
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 17:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766249827; x=1766854627; i=xypron.glpk@gmx.de;
 bh=hRUawA0HZo7HJcBxX4nZl3HLeHsz5CvdEdw6UDiYOos=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lWvxj9cKpGBywCvvz3jzW0AJ6qHTCfoF/Urmn0WAHUx8PsHUwWNBgiDeZIG3FVx8
 xEBMO60TA+2SMug6IMACV+VoDNwihx05Jkseho4IIWzPqAoPeuzEqNlxElu/ZyDXv
 HNylN6/yILGuGW9oZM3Wb55D3tmhRCqrkjVQoOMDq+FE9hTTxRKeXW/P3/3j5SJqI
 T/dLqLd6OAfjQrC2fr2dISgdtz6TY7dCD8IrOh5+RVvtck4oz9Zq2son84SeRisvi
 99EoSR2z+AHGtk0IlodatKRyI1GCOPlYDhkbjSqEO/cjjq0R3pghdj5T/JVU11MVk
 2rECgTzR6zEUGmHqtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9nxt-1vaYVS2k1l-000fc7; Sat, 20
 Dec 2025 17:57:07 +0100
Message-ID: <b8b4a933-cbcf-4941-8283-632679e69d11@gmx.de>
Date: Sat, 20 Dec 2025 17:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] efi_loader: Fix kernel panic when FTRACE is enabled
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20251217072558.2949569-1-patrick.rudolph@9elements.com>
 <20251217072558.2949569-2-patrick.rudolph@9elements.com>
 <CAC_iWjKceKOGbZFVuYSTVvJkmW2yA8Aa9O7xECL05FRXrywSow@mail.gmail.com>
 <ecd34bbd-0b19-4c25-8095-61a2de226261@gmx.de>
 <CALNFmy3X7FNWQmTtsNh7=2WSzOszK90my_h6LraT=7z=qRU6VA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CALNFmy3X7FNWQmTtsNh7=2WSzOszK90my_h6LraT=7z=qRU6VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WpkfgQ9EXT1H64oSR0zBiWR+vR2N8nYIcxV9SVMPjb9Lv4+o+Yq
 /jG3lAh/km+e9r8HFYkTGLQRFmUeAyckV/cJJxkgnfvD8dqvGYJw65m0jDJ/riE/lpl1bHk
 waKiyATWEizTplL6oVZWtqHScmXhu8nua2mY1vdACkrzeKLVqmiqdCrZPXp+RlkiPxjouqR
 9CaSnyEqGQr4Za/i5hurA==
UI-OutboundReport: notjunk:1;M01:P0:QfgX0uNFmVo=;VFC1gHPS7ApRI3Ea0hA6r9KOWck
 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
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

On 12/20/25 14:52, Patrick Rudolph wrote:
> On Fri, Dec 19, 2025 at 9:44=E2=80=AFPM Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
>>
>> On 12/17/25 11:39, Ilias Apalodimas wrote:
>>> Thanks Patrick,
>>>
>>> On Wed, 17 Dec 2025 at 09:26, Patrick Rudolph
>>> <patrick.rudolph@9elements.com> wrote:
>>>>
>>>> When FTRACE is enabled the EFI runtime will call the tracing function=
s
>>>> that are not marked as __efi_runtime and cause a kernel panic since
>>>> the functions have been previously unmapped by the kernel.
>>>>
>>>> Resolve this issue by adding the 'notrace' attribute to '__efi_runtim=
e'
>>>> attribute and thus disable tracing the EFI runtime. If required this
>>>> can be worked out latter.
>>
>> What is the point of actually booting with a U-Boot binary with FTRACE
>> enabled? All your trace data will be lost.
>>
>> Wouldn't it be preferable to error out at ExitBootServices() and
>> retrieve the trace?
>>
>> The current implementation of FTRACE looks flawed. The trace buffer
>> should be allocated from LMB so that it cannot overwrite images or EFI =
data.
>>
> Hi Heinrich,
> I'm not that familiar with the tracing yet. My expectation was that
> the trace buffer is marked as reserved
> and could be retrieved from /dev/mem, however that's not the case.
> I updated the CONFIG_BOOTCOMMAND to write the trace file to disk
> before it runs "bootflow scan"
> as described in the documentation. I can then retrieve the trace data
> from disk. That works for me.
>=20
> Regards,
> Patrick Rudolph

Trace logic
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The logic introduced by commit 852d4dbd70ba ("trace: Detect an infinite=20
loop") just switches of tracing when __cyg_profile_func_enter() is=20
invoked with hdr->trace_locked=3Dtrue. This lets us end up with having to=
=20
mark dozens of functions as notrace because they are invoked by=20
add_ftrace().

A better approach than switching of tracing is to simply return without=20
recording the entry by adding

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!hdr || hdr->trace_lo=
cked)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;

at the start of __cyg_profile_func_enter() and __cyg_profile_func_exit().

Once the outermost __cyg_profile_func_enter() is finished it will unlock=
=20
the trace.

Missing relocation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Unfortunately there are more bugs that need to be solved to make tracing=
=20
work properly.

On qemu-riscv64_smode_defconfig I found that there is also an issue in=20
notify_dynamic() which is invoked when searching for the timer driver.

When looping over state->spy_head, list_for_each_entry_safe() does not=20
discover the end of the list and loops forever though the list is empty.

The reason is that the address of state->spy_head has been relocated but=
=20
state->spy_head.next and state>spy_head.prev still point to the=20
unrelocated address. Therefore list_for_entry_safe() does not discover=20
the end of the list.

We should not start tracing before initr_reloc().

When placing INITCALL(initr_trace) directly after INITCALL(initr_reloc)=20
the timer driver panics with

     Could not initialize timer (err -11).

In initcall_run_r() we need to place INITCALL(initr_trace) after=20
INITCALL(initr_dm) to let the timer driver work properly.


Defaults
=3D=3D=3D=3D=3D=3D=3D=3D

The current defaults for tracing are not helpful. The observed call=20
depth for `bootefi hello` is 42. The default of 16 MiB as trace buffer=20
is way too low to catch a boot process. Rather think of 1-2 GiB.

Best regards

Heinrich>

>>>
>>> So I agree with this. Fixing is just a matter of moving the missing
>>> functions to the runtime section, but I don;t think it's worth it,
>>> unless someone *really* wants to instrument runtime calls.
>>> OTOH runtime calls in the OS are rare and very limited
>>>
>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>
>>>
>>>> TEST=3DCan boot a UEFI compatible linux OS on qemu-q35 when U-Boot wa=
s
>>>>        built with FTRACE=3D1.
>>>>
>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>> ---
>>>>    include/efi_loader.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>>>> index 3e70ac07055..7a13c390cbe 100644
>>>> --- a/include/efi_loader.h
>>>> +++ b/include/efi_loader.h
>>>> @@ -66,7 +66,7 @@ struct bootflow;
>>>>     *
>>>>     *   static __efi_runtime compute_my_table(void);
>>>>     */
>>>> -#define __efi_runtime __section(".text.efi_runtime")
>>>> +#define __efi_runtime __section(".text.efi_runtime") notrace
>>>>
>>>>    /*
>>>>     * Call this with mmio_ptr as the _pointer_ to a pointer to an MMI=
O region
>>>> --
>>>> 2.52.0
>>>>
>>

