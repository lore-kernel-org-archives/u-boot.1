Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF22EC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 06:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2335A88980;
	Fri, 14 Jun 2024 08:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jEzQ6TX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F09A88988; Fri, 14 Jun 2024 08:59:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E6688934
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 08:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718348376; x=1718953176; i=xypron.glpk@gmx.de;
 bh=5jeSZi30KNkIKkDsEyu5vdkw+LgGHypPMg+A7E60shk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jEzQ6TX12Ce4FM6yTJCY+niftuOMAeQ7tf2Ggjd+fQDjLBJMBEbukt2gGI5+atqM
 pzL8dhctHG1iZQZ9DbJuaAHnf1V53gqcK3B7TDkB/IevqiaK9Yu6E7kU5J1+i2V87
 xbWXNnsbMIfcDO9aNGOQty795y17CrsSSrGzE9jCjymM5MUQz0Vr7+CyOpZwdTiPr
 5RXxysN3nNyJJeJgBJRkQhPnzmICc9ZnKTSLi2/ZWVnJaD1nu55qI3ckcuuefSwU4
 s76LF3bIyxMzekEpI7NwTNZ2Z4Bc4vSvr1QwJUiPN7zG/CeTmG598cZHzhQ1f9sBd
 FQg+7sQZ+Eh/ft9V5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRR0-1rqPLn3iv6-00NjBq; Fri, 14
 Jun 2024 08:59:35 +0200
Message-ID: <14ae7a31-757a-4220-b2a8-20204e3d7aa9@gmx.de>
Date: Fri, 14 Jun 2024 08:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-3-sjg@chromium.org>
 <CAC_iWj+fSRt2E3ZcHaXrKjC+Gz7LZu_EWgiegWG3F1MJMJrPNQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWj+fSRt2E3ZcHaXrKjC+Gz7LZu_EWgiegWG3F1MJMJrPNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oR9uv/ygHdAcS7u8lcU4zAjdpU/ESrsApIRbLC3Eu0Aa6WhjBpi
 nI63Rvpury9aSEYXb/7xmwVTRBJN7CPuaaay8b2QYvx9BFn4WcQebTIlNKdCoh/Mr0tHUsp
 DdP60+vvOB9Yb36qgzmBB6gufWqzK0IxM1B8hZLf+UaUVOoFsk8dWyWXyh4a5ymluxExIy5
 poDedkIUKRX11utF99csw==
UI-OutboundReport: notjunk:1;M01:P0:3bHExnHm0dg=;uIIJDfxSlXRk1eUY/DWXrztz7xN
 OlUJZVzl/h7OCsOQJJZyKe2UYezvYYMJqijkydMIixacj1U/swZqwPfr5vERh8tv1JDE7lC9L
 iGDk+O/K1yFySrX1lNbiU50PNVuSVQ0vEdyNQAgst98eF65/2qIH2qdVHNWanG51wTtbaiVvv
 C4Z0YxHvbFxfP7vHYyugGENf1KLYI4fzZ+lKFJKIKhQ/92wfZ6d16Oejv6XZGHB43CQD9zEjP
 48trwWCGbSRkjO0yDo6t7JALQKcbG2zPXcVViNx7aS48HDb1nrVgchUtyvDS+Lqo8ODvGp+ax
 s5usTxjFXEdWX7hHyO4mAQhBnKxu02avpl6iXS6YsFYMyFog4+bQvyIoUiPRSKMMGe98Lre1i
 qHfiqciURGq+qMLmoNAgiwa1R1mStxCno8IKIPz6xh7yuMj7NewS83GLP4xYJep7jprnujh2n
 XK9Nf405o0i0MWqgGAGtHUcPBo/A8u5Jth96IbjNIHaJzWxXhYnXTn+LS14pypsK9MhI0eLiS
 SjHP645+t3JtZOyD+fsyxtK1tYNbeNHgj2K73ubNToO8i60vae79u96P5vS3Gv8/li+aR0A64
 ISB//mBKfnavRdlwltyVNV+oWyDo4dCa+iXB+KbhmWw5y/28axRGVH+K0gS9FvYv3M++jElim
 BV0bNgr4I7tM+seGEJ0H6zQJtWmHJq5P7tE1qIF1VEP/enOk/KOchwMaOVLne98Mxhfa0RzSS
 +ejX0eAvItKyEybMVCgEBRWFvloU8afJfvH+MOEdMBBDvclEpQ+qatzm4zK2GkeIzJNllC9b+
 hd6kXzKa66/BRYI5qc8zazMTHWhjzh5Dyoaz7NOhBziPQ=
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

On 6/14/24 08:03, Ilias Apalodimas wrote:
> Hi Simon,
>
> On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@chromium.org> wrote:
>>
>> It does not make sense to enable all SHA algorithms unless they are
>> needed. It bloats the code and in this case, causes chromebook_link to
>> fail to build. That board does use the TPM, but not with measured boot,
>> nor EFI.
>>
>> Since EFI_TCG2_PROTOCOL already selects these options, we just need to
>> add them to MEASURED_BOOT as well.
>>
>> Note that the original commit combines refactoring and new features,
>> which makes it hard to see what is going on.
>>
>> Fixes: 97707f12fda tpm: Support boot measurements
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> Changes in v2:
>> - Put the conditions under EFI_TCG2_PROTOCOL
>> - Consider MEASURED_BOOT too
>>
>>   boot/Kconfig | 4 ++++
>>   lib/Kconfig  | 4 ----
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index 6f3096c15a6..b061891e109 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
>>   config MEASURED_BOOT
>>          bool "Measure boot images and configuration when booting witho=
ut EFI"
>>          depends on HASH && TPM_V2
>> +       select SHA1
>> +       select SHA256
>> +       select SHA384
>> +       select SHA512
>>          help
>>            This option enables measurement of the boot process when boo=
ting
>>            without UEFI . Measurement involves creating cryptographic h=
ashes
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 189e6eb31aa..568892fce44 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -438,10 +438,6 @@ config TPM
>>          bool "Trusted Platform Module (TPM) Support"
>>          depends on DM
>>          imply DM_RNG
>> -       select SHA1
>> -       select SHA256
>> -       select SHA384
>> -       select SHA512
>
> I am not sure this is the right way to deal with your problem.
> The TPM main functionality is to measure and extend PCRs, so shaXXXX
> is really required. To make things even worse, you don't know the PCR
> banks that are enabled beforehand. This is a runtime config of the
> TPM.

If neither MEASURED_BOOT nor EFI_TCG2_PROTOCOL is selected, U-Boot
cannot extend PCRs. So it seems fine to let these two select the
complete set of hashing algorithms. As Simon pointed out for
EFI_TCG2_PROTOCOL this is already done in lib/efi_loader/Kconfig.

Even if U-Boot does not support measured boot (EFI or non-EFI) we might
still be using the TPMs RNG.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
>   So this would make the TPM pretty useless. Can't you remove something
> that doesn't break functionality?
>
> Thanks
> /Ilias
>>          help
>>            This enables support for TPMs which can be used to provide s=
ecurity
>>            features for your board. The TPM can be connected via LPC or=
 I2C
>> --
>> 2.34.1
>>

