Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E66D13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 11:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C34B8907E;
	Mon, 28 Oct 2024 12:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="q1qJXPZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277F289095; Mon, 28 Oct 2024 12:21:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1A38907B
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 12:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730114460; x=1730719260; i=xypron.glpk@gmx.de;
 bh=Jc5TaacjECcQxGZP+JP/YGIj4AEAQMlr7fFj/Qwe+fQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=q1qJXPZxVTf6gnsc9FYIANY9+0NtiqPSRof8VZa7fS2dk9QvsVRUPvLpFWGoEMlI
 2BiUNgX5axZo7cvnXf1ukzyAgRBq2v/lZUfXe6FsUBTy8esdR4UcdMecfqV4YDREs
 b/V/b6zhwTo8xcQJQi1Jcw/szbD4mrU2Bq8FpPxEVi41MKkiwVSOfay+WGMkT3+VH
 IAjq5+F0yg9NID0q5zG+gg8bbt8cUhGjt6hH2ZViZFGl2YBgOMEN3C6rfAqfBSAM8
 mIjOr1L/VZ1tmC68UFjQSI9oH1yfjDnudnsD7yeeycsaRP2nKpZVyBtDBN4C/tjz9
 Z1ncviMMxmyaDb3z+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.150.8.169] ([145.103.114.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel7v-1tdLVh1VKv-00dnuf; Mon, 28
 Oct 2024 12:21:00 +0100
Message-ID: <098632e4-4f83-44e3-9c6a-859ece33e917@gmx.de>
Date: Mon, 28 Oct 2024 12:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] sandbox: Report host default-filename in native
 mode
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-6-sjg@chromium.org>
 <CAC_iWjKUjsMdqXa2YZGiu1FSsjx_aH6cDQsi+2Ng5i-+9obQhQ@mail.gmail.com>
 <CAFLszTgZPQOeyoKuB85Qgu0cSdQ0Upgpk2Q01mmNY4XFgiW43w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTgZPQOeyoKuB85Qgu0cSdQ0Upgpk2Q01mmNY4XFgiW43w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YJfGX7jbwc9jl+KFRnwZTaLvjB0IGMWw2jca9+pXjUvsdnQSAL4
 gPLkWYOfSYEwTzlvzm/6ToMze7r639/NVHfL6vYVdy4YYgxi55PV+SL5japJ1a6dz4bcHlp
 guNj9r8lgyoCoXSTwKBNLTFiJof/eRwb/NSaPz6mjPMh5qOlTPb5We2qrtg5vUJMeNpgzhM
 1KNifyOpxDZC4ywO9WoQQ==
UI-OutboundReport: notjunk:1;M01:P0:gYOrdJ6jvpw=;vvkc+i8/5C/ECT/zwfDJ8zjX+CG
 qUvAo3r4/PE4ncsT5SDJGvXrX9QuyrfHfaIjdGtrm3HyZpr/+vbGlR3Ld7ndn1yEDqD0eB3Yl
 0rDcBXAIOvMsBOALSvZIYZnTxW7HNuKFMtO2MAo9bfuPH5+QPLYnOMqvNFOt9I8io+5Dhg6tD
 gh7KPj/qir8zCVmwXCAKA/R9oslO8Knsv4KkoVoZf5idgHSO+JL9O9fNRAKJEZyn7GcOpqG9S
 WyDehCNE9GqBkSOZxxNHEZzECQBPDgptU042LhcpO33FAaskoz9JUAEYPswPcBlu1nfKzmNht
 8fVJ/QwUwoYCGEMhiAj+qYnSd4IKDdQ3IWntDPnNynMAj3+NXwzu9Ut6hkdwF/48HfCKfNlOh
 q5cL6nC7xG+3fn4KHaGXnNk0uMUSH7ddjf8VAnmzNRE8i/E661JHgjy474QLyJVFM6FtZKfYg
 lAXfwfH3hslich7yOizijjigED5I+cI67jvZwFEhVutcnV2c4TfF1//T8xJSg0ZFZo0JqRsh8
 6D7cyqAZom4hPvpqXQb/7wRuXA3wWiwlpOckkV/XqAsy7gUDc05II6qBr2vz0DHhoKBrbU1Db
 GOUutgQYuKTikjDUjwWNT7p2RR0TELdTL/SUSXpiBSLMdgmDbG4JAEYunbr3xIPqMhvWKYJYP
 hb+7qIbkr8TqiVOd0ex+8fvCn+6KQ73gvLGge6qaKI+DRzDoLr6xZoD0gqEnF/kJ7oeJv3ZXQ
 fiNLbGa2sd18RC3WeZuLAmUj7rgX/QqRGe8olKjb2wMT3qF/Z2MQ9Fr72LNXPsyHeUBfWrA1l
 LHn2hVSSn60k+uMUAdaWzepsJvKJkMJ6+bs/g6W/lHEgM=
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

On 10/27/24 18:16, Simon Glass wrote:
> Hi Ilias, Heinrich,
>
> On Fri, 25 Oct 2024 at 11:57, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Simon,
>>
>>
>> On Tue, 22 Oct 2024 at 15:00, Simon Glass <sjg@chromium.org> wrote:
>>>
>>> When the --native flag is given, pretend to be running the host
>>> architecture rather than sandbox.
>>>
>>> Add an 'efidebug filename' command to report it.
>>
>> Heinrich does this allow you to continue your testing in native archs?
>
> Yes, Heinrich seems OK with it.

I highlighted to Simon, that it is important to me that the sandbox
continues to support booting standard compliant images via shim, GRUB,
just into the Linux EFI stub.

Introducing a sandbox specific EFI binary name or PXE value provides no
value. But at least the current suggestion does not do harm except
forcing sandbox users to remember another command line parameter.

Tests on QEMU or real hardware should use the architecture specific
filename for the EFI binary and this is not what the test provided by
patch 7/8 does.

Best regards

Heinrich

>
> Separately from this patch, at present something is broken / missing
> on x86_64 (with recent QEMU / Tianocore), so I cannot run the tests
> with qemu-x86_64 today. It was apparently running OK before the last
> EDK II and QEMU updates.
>
> Also sandbox only works with the EFI Self-Certification Test (SCT)
> when natively compiled on aarch64 or riscv64[1][2]. There might be
> something missing on sandbox x86_64, which gives a segfault when
> running InstallX64.efi
>
> I am running these:
> ii  ovmf           2024.02-2    all          UEFI firmware for 64-bit
> x86 virtual machines
> ii  qemu-system-x86 1:8.2.2+ds-0ubuntu1.2 amd64        QEMU full
> system emulation binaries (x86)
>
> So far I have not tried going back to older versions.
>
>>
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> Changes in v8:
>>> - Add new patch to report host default-filename in native mode
>>>
>>>   boot/bootmeth_efi.c | 25 ++------------------
>>>   boot/efi_fname.c    | 57 +++++++++++++++++++++++++++++++++----------=
--
>>>   cmd/efidebug.c      | 25 ++++++++++++++++++++
>>>   include/efi.h       | 25 ++++++++++++++++++++
>>>   4 files changed, 94 insertions(+), 38 deletions(-)
>>>
>
> [..]
>
>>> diff --git a/include/efi.h b/include/efi.h
>>> index 1b8093bd4d3..70bb47e742f 100644
>>> --- a/include/efi.h
>>> +++ b/include/efi.h
>>> @@ -678,4 +678,29 @@ void efi_show_tables(struct efi_system_table *sys=
tab);
>>>    */
>>>   const char *efi_get_basename(void);
>>>
>>> +#ifdef CONFIG_SANDBOX
>>> +#include <asm/state.h>
>>> +#endif
>>> +
>>> +static inline bool efi_use_host_arch(void)
>>> +{
>>> +#ifdef CONFIG_SANDBOX
>>
>> #if IS_ENABLED(CONFIG_SANDBOX) is preferred no ?
>
> That is more for use with if(), which I cannot use here.
>
>>
>>> +       struct sandbox_state *state =3D state_get_current();
>>> +
>>> +       return state->native;
>>> +#else
>>> +       return false;
>>> +#endif
>>> +}
>>> +
> [..]
>
> Regards,
> Simon
>
> [1] https://github.com/U-Boot-EFI/u-boot-sct-results
> [2] https://github.com/xypron/sct_release_test/tree/main

