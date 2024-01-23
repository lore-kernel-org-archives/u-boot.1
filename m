Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B30DC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 10:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8198187C3B;
	Tue, 23 Jan 2024 11:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CfZ5xWku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F6C87BF9; Tue, 23 Jan 2024 11:00:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F3C587A0E
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 11:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706004024; x=1706608824; i=xypron.glpk@gmx.de;
 bh=R0dG1rdTpwNgoBPYA4UZXnNXdjyXy++07U0CW5wbAls=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=CfZ5xWkuV/GbhGd//N5JKmqxgjPvcqQI1FwuPZmSqQa0w2eYUQayLw1Qh7KyRrjT
 4krjmjg0UmxA17Gbpdjsr2FOsgbOMwnUMeyIysSvP37CNWY0pl78uaHUbR2zuk8Sx
 0KbjpI6/TckVWm+U3R1MFo0fsgKhC6hJh1B0kxOK/o7p3BHoFTi/rXY1dLcH3Fri0
 EdbAGrfIqUDIimTJGeB+HLcWX80sEmLHqiQ7ntaVHYU6/VhbYDtGMC8oJtfWJwwo9
 U/qg0Oll18D/cxMka2boiL4HhvDBajRlB+PWFf4IgCzFcZ0CCB2rE3OEHcNZ2q7oF
 9wAu+JlUKh6TgssLIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdif-1rMUXN34Tt-00Ee9G; Tue, 23
 Jan 2024 11:00:24 +0100
Message-ID: <d2b79924-87bc-42a2-9d06-6fcba06ed267@gmx.de>
Date: Tue, 23 Jan 2024 11:00:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader : Suppress error print message
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, trini@konsulko.com,
 sjg@chromium.org, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 git@xilinx.com
References: <20240122191242.2989327-1-tejas.arvind.bhumkar@amd.com>
 <CAC_iWjKEMs_0WHyu7ttfvP30vG=sJnhY5XWY=5hGBTAW_5oxyg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKEMs_0WHyu7ttfvP30vG=sJnhY5XWY=5hGBTAW_5oxyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MOkojv3W4p6N6f9FJBGepeyoyifquB2/IIggurA6LVZFXtgWISd
 lS0W4qqseiVAhw0FaJmZZNX3RBKfIkmg5VLoih/vySVSrD5l/J4sgsMwMNWQBBCl/XQSUeN
 kEdwYvwTOGSGpTKtdJm0Psif8iZA6L9QMhdqgBdaH+3irgtXkB7CVBoXSch/MBmWopTPGcN
 C4XgTau86opnukkqtgLsg==
UI-OutboundReport: notjunk:1;M01:P0:aFtAdxL5e4s=;wv5JB4fTYU+J2MVMZ5gjqib1N/1
 7oobbIG6ThhbsqRd+1oE45WbrUn1EQ854lVliTGiyjsN95Z1PTk0WwfdbwAzjzMBaxICBNr+C
 E0Inic3fvJwdPndwio+cqXgU4xE5uRj61naTMAE6Z68kG2KRacV5hunuP/Rc7F3qwUgXR7ARQ
 4n9ZqRnjGv3HP3ob/HtN6tisXB74ALXvL7xH7iF9JI54RsSTcb8jgJhEeBBYZOCPXso5uU8mA
 e6GsJoaFfjOcyQK7YhWzD5Ko3+IPpHpxRPJ4QLJSSRM7sm7l+6PjrHWOdp28ZMuP+cGe9TN4T
 gone6j9zRKO+tBB+RaD7GQ0dmH6RN169KGhQsf6/rOD0IOImVHuNWoD1PYHMGN1ps7EYKUAnq
 bUZiJB/sW/3PPSxlYWcYniiiW6qMwCzqSDyjxegVjEDiHOdb/Mmj5pO473evzew17rRUwT3/k
 /YUtWutYs4cuWi6tqoxEupmAwUFcDcHIpH3PZxiNyS1u1MojXQtF+4yUi/fuuS8geGXOtBuMm
 vw8mc5yM0zLPBc0L43+6e9mrNOk+xp8sJHWFgWV8QOuwKNqypSZOgIuED3BPGKJSPV0aINxpL
 O5vVbef75iFCce0iOMn4tOEHfvvC9HFqJXXsPnFOUAdk9oU1o55lDFy1FPz1tODRBAgjexbwg
 +6xultAAKq6m0lOvX1h2RorGpe6RtaAApExzA7sJteF9WyzM8tC/bsElF2SPSiAq2S+qsTivv
 hNvnV/5Q+TfBQj4Vn2HgA3DV8QsJo3YGlFt4rheIXsjjX2Lgdv+Mg2ZPS6q61VFADvZW5Uabu
 m7443f3lsNSUJ0pGW+LbwPyqgikSB49jMEEdt09giFUxofGy+AFWcxxOf0PS9uDH/L5suzij1
 e+BoffgdqKZCo9yTndrHVGrbsDOZwGFSjsvzecQ2P40y6tzKPdz0V3UnNLZdcB3qn/sKa1siZ
 UIMELnjwHSBN7avHgGOvlJLpizQ=
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

On 1/23/24 09:33, Ilias Apalodimas wrote:
> Hi Tejas,
>
> On Mon, 22 Jan 2024 at 21:12, Tejas Bhumkar
> <tejas.arvind.bhumkar@amd.com> wrote:
>>
>> Currently, on certain Xilinx platforms, an issue has been
>> identified, manifesting as follows:

Hello Tejas,

thank you for bringing forward this issue.

Which defconfig are you relating to?

>>
>> Starting kernel ...
>>
>> efi_free_pool: illegal free 0x0000000077830040
>> efi_free_pool: illegal free 0x000000007782d040
>> efi_free_pool: illegal free 0x000000007782c040
>>
>> The issue arises when the ramdisk image is relocated, placing
>> it within the previously allocated EFI memory region( as EFI
>> is established quite early in U-Boot).

Which version of U-Boot are you on? Commit 06d514d77c37 ("lmb: consider
EFI memory map") was meant to avoid such a situation.

>
> I don't mind suppressing the print for some time, but out of
> curiosity, how is the ramdisk relocated? LMB should be aware of the
> EFI regions by then, so I assume the relocation code doesn't check
> those?

The indicated situation is serious. If the EFI sub-system is using the
same memory area as the ramdisk, this may lead to corruption of the
ramdisk. Suppressing the messages is by no means adequate to solve the
problem.

Best regards

Heinrich


>
> Thanks
> /Ilias
>
>> Consequently, when
>> attempting to release memory in the EFI memory region during
>> the handover process to the kernel,we encounter memory violations.
>>
>> Highlighting that EFI remains active primarily during the
>> booting of an EFI application, and the lmb persists while
>> configuring images for the boot process. Since we aren't
>> utilizing the EFI memory region during the boot process,
>> there is no adverse impact even in the event of a violation.
>>
>> Currently, there is an ongoing discussion regarding the handling
>> strategies of three memory allocators: malloc, lmb, and EFI. This
>> discussion is documented in the email chain
>> titled "Proposal: U-Boot memory management."
>>
>> Therefore, it is advisable to suppress the print message during
>> the boot process for now.
>>
>> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
>> ---
>>   lib/efi_loader/efi_memory.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index edfad2d95a..821fe7616e 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -713,7 +713,7 @@ efi_status_t efi_free_pool(void *buffer)
>>          /* Check that this memory was allocated by efi_allocate_pool()=
 */
>>          if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
>>              alloc->checksum !=3D checksum(alloc)) {
>> -               printf("%s: illegal free 0x%p\n", __func__, buffer);
>> +               debug("%s: illegal free 0x%p\n", __func__, buffer);
>>                  return EFI_INVALID_PARAMETER;
>>          }
>>          /* Avoid double free */
>> --
>> 2.27.0
>>

