Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E31E6688C
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 20:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D9C808AF;
	Fri, 19 Dec 2025 21:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iuMNDXYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5956F80FA1; Fri, 19 Dec 2025 21:44:29 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FEA9803F5
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 21:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766177065; x=1766781865; i=xypron.glpk@gmx.de;
 bh=sjfmnQpH++rTuEAIYQDCIv131Z+Ohf/yWiy+JqCZEy8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iuMNDXYqgDzCcPJIFVLLWbOmOefcXkP3iZfF+hf48uuPSzUECaIykc8pFzfZpLYW
 i4awqSfjVdNaA9HXX5h9l34IdXEbfVca2lNrg87hFLIW3LaZz3NTWx29/YqwzMKM9
 nrqFS8wRdrgwn2wTtfy5Wgku9M/RTDjmm3zsUd/aIdIrQyb2DX3fo8bkG0tsw3Rp3
 HUvpdqD7Q2gXryb+I6X/Ir8hD9/22ps8Xi6rMvyuig8nz1Q0vcBmBeAIbui7gUE97
 kWNxHWiuhgE8zezcWC0jQyCXevjFaWCit76m+Ls111wRzAgQovvFo+cMqkAs/XCn1
 RjYPSkLDuVvUboBEzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsYx-1vlDWg1mEZ-00DaxZ; Fri, 19
 Dec 2025 21:44:25 +0100
Message-ID: <ecd34bbd-0b19-4c25-8095-61a2de226261@gmx.de>
Date: Fri, 19 Dec 2025 21:44:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] efi_loader: Fix kernel panic when FTRACE is enabled
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251217072558.2949569-1-patrick.rudolph@9elements.com>
 <20251217072558.2949569-2-patrick.rudolph@9elements.com>
 <CAC_iWjKceKOGbZFVuYSTVvJkmW2yA8Aa9O7xECL05FRXrywSow@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKceKOGbZFVuYSTVvJkmW2yA8Aa9O7xECL05FRXrywSow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yx6MwTONKJjsExnNzkJI9XZ6V6XJBHYaOQwwsKyFndLwqigwjvQ
 3ityljRF5768gR/p67XFWYR/C2if62/lSS5B0pBHrxghGVvN5TbpVAWF5192hTqQ2to8MVM
 vgI/uLgtNWbtfpB8gyLWqCOElM2zJ7Z4exQDbE3QTZm1lcKiIPES16DKiy2WGvIIWvOTuW9
 ZYHHudhX9imqU6WgMQogQ==
UI-OutboundReport: notjunk:1;M01:P0:BCtBdCMimtA=;PYQBeE1vK+2833NROCyw067SLM4
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

On 12/17/25 11:39, Ilias Apalodimas wrote:
> Thanks Patrick,
>=20
> On Wed, 17 Dec 2025 at 09:26, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
>>
>> When FTRACE is enabled the EFI runtime will call the tracing functions
>> that are not marked as __efi_runtime and cause a kernel panic since
>> the functions have been previously unmapped by the kernel.
>>
>> Resolve this issue by adding the 'notrace' attribute to '__efi_runtime'
>> attribute and thus disable tracing the EFI runtime. If required this
>> can be worked out latter.

What is the point of actually booting with a U-Boot binary with FTRACE=20
enabled? All your trace data will be lost.

Wouldn't it be preferable to error out at ExitBootServices() and=20
retrieve the trace?

The current implementation of FTRACE looks flawed. The trace buffer=20
should be allocated from LMB so that it cannot overwrite images or EFI dat=
a.

Best regards

Heinrich

>>
>=20
> So I agree with this. Fixing is just a matter of moving the missing
> functions to the runtime section, but I don;t think it's worth it,
> unless someone *really* wants to instrument runtime calls.
> OTOH runtime calls in the OS are rare and very limited
>=20
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>=20
>=20
>> TEST=3DCan boot a UEFI compatible linux OS on qemu-q35 when U-Boot was
>>       built with FTRACE=3D1.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> ---
>>   include/efi_loader.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>> index 3e70ac07055..7a13c390cbe 100644
>> --- a/include/efi_loader.h
>> +++ b/include/efi_loader.h
>> @@ -66,7 +66,7 @@ struct bootflow;
>>    *
>>    *   static __efi_runtime compute_my_table(void);
>>    */
>> -#define __efi_runtime __section(".text.efi_runtime")
>> +#define __efi_runtime __section(".text.efi_runtime") notrace
>>
>>   /*
>>    * Call this with mmio_ptr as the _pointer_ to a pointer to an MMIO r=
egion
>> --
>> 2.52.0
>>

