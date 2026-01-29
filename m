Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB2ED6101A
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 14:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5269383D9F;
	Thu, 29 Jan 2026 15:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l3iCnFQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D78A83D9F; Thu, 29 Jan 2026 15:09:35 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651D283AAD
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 15:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 094356001A;
 Thu, 29 Jan 2026 14:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B25C4CEF7;
 Thu, 29 Jan 2026 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769695770;
 bh=i+t0GDvL4g7dBuEJb5j0qaCefSugl3yBwXjoVdWoqIs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=l3iCnFQ4uNZEoh9Ksod3OUfZ+Z68Ho07hajVABeEtgdxKUR3hd6nfwyh4wTWAiNFQ
 R0h4cXD5Vpqd0EQcfpbldQLY29/QNVipxbrg927/NEV26emUatlnfcLcwEEW/DcE5q
 8SdA8X1VyDXwK8mgedpmIUa3eH/zCo5gNWyinblKQXz5pNCHXb5YCa8oaY+is0UUe7
 rFfbQqYGorCs+dWKL1IBYEkPysqmkWlIRQNt/8e8+XfibokrVHFjk6fXuFCmXX4A1w
 rV9f14ehDcfEMTEU2RzZhWu1QYJ+ODxgHxIL8sdfdy6yid5JBpK4lCPagkLL012ZSh
 MaKwuLYD98sbQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heiko Schocher <hs@nabladev.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>, Dmitrii Merkurev
 <dimorinny@google.com>, Fabio Estevam <festevam@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, Stefano
 Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 0/2] fastboot: mmc: fix bootloader offset
In-Reply-To: <7d9a3b43-7a6c-dc97-69ad-b71acd062538@nabladev.com>
References: <20260124054712.7939-1-hs@nabladev.com> <87y0lkogbt.fsf@kernel.org>
 <e7917bc9-11b1-18d0-1f04-9d6af003c1cd@nabladev.com>
 <875x8kohmf.fsf@kernel.org>
 <7d9a3b43-7a6c-dc97-69ad-b71acd062538@nabladev.com>
Date: Thu, 29 Jan 2026 15:09:27 +0100
Message-ID: <87zf5wmrxk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jan 29, 2026 at 11:41, Heiko Schocher <hs@nabladev.com> wrote:

> Hello Mattijs,
>
> On 29.01.26 11:09, Mattijs Korpershoek wrote:
>> On Mon, Jan 26, 2026 at 16:46, Heiko Schocher <hs@nabladev.com> wrote:
>>=20
>>> Hello Mattijs,
>>>
>>> On 26.01.26 10:48, Mattijs Korpershoek wrote:
>>>> Hi Heiko,
>>>>
>>>> Thank you for the patch.
>>>
>>> You are welcome!
>>>
>>>>
>>>> On Sat, Jan 24, 2026 at 06:47, Heiko Schocher <hs@nabladev.com> wrote:
>>>>
>>>>> Not for all SoCs the bootloader start at offset 0x0,
>>>>> in a hardware partition of an emmc. So we need the possibility to
>>>>> set the correct offset, where bootloader starts.
>>>>>
>>>>> Example:
>>>>>
>>>>> imx8qxp revision C0 emmc Partition layout
>>>>>
>>>>> | eMMC block / partition | Offset     | Size  | Purpose              =
          |
>>>>> | ---------------------- | ---------- | ----- | ---------------------=
--------- |
>>>>> | /dev/mmcblk0boot0      | 0x0        | 2MB   | imx-boot-container A =
          |
>>>>> |                        | 0x00220000 | 128kB | secure boot signature=
 rootfs A |
>>>>> | /dev/mmcblk0boot1      | 0x0        | 2MB   | imx-boot-container B =
          |
>>>>> |                        | 0x00200000 | 8kB   | U-Boot env 0         =
          |
>>>>> |                        | 0x00202000 | 8kB   | U-Boot env 1         =
          |
>>>>> |                        | 0x00220000 | 128kB | secure boot signature=
 rootfs B |
>>>>>
>>>>> imx8qxp rev B0 emmc Partition layout
>>>>>
>>>>> | eMMC block / partition | Offset     | Size  | Purpose              =
          |
>>>>> | ---------------------- | ---------- | ----- | ---------------------=
--------- |
>>>>> | /dev/mmcblk0boot0      | 0x00008000 | 2MB   | imx-boot-container A =
          |
>>>>> |                        | 0x00220000 | 128kB | secure boot signature=
 rootfs A |
>>>>> | /dev/mmcblk0boot1      | 0x0        | 8kB   | U-Boot env 0         =
          |
>>>>> |                        | 0x00002000 | 8kB   | U-Boot env 1         =
          |
>>>>> |                        | 0x00008000 | 2MB   | imx-boot-container B =
          |
>>>>>
>>>>
>>>> Why can't we use raw partition descriptors for this?
>>>>
>>>> See:
>>>> https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-=
descriptors
>>>
>>> Thanks for this hint!
>>>
>>> Possible yes ( I must try)... but this will lead in adding
>>> complexity to scripts people use all over there and needs
>>> to adapt CI setups, as siemens has B0 and C0 variants.
>>=20
>> If you try, please let me know.
>
> I am sorry, did not find time yet... sorry.
>
>> Do the same boards (as in U-Boot board definition) have multiple SoC
>> variants (B0 and C0) ?
>
> Yes there is the capricorn board in U-Boot and it have different
> variants (not all mainlined yet) with B0 and C0 variants...
> number of boardvariants grown over the years, started even with A0 SoCs
> (IIRC)...
>
>> In that case I understand it's a pain to add more script complexity.
>
> It is. and U-Boot could easily detect the SoC revision... and it is
> fix ... so no need for having this configurable and making mistakes...

I agree.

>
>>> If we introduce this series, user has nothing to know about
>>> offsets for different CPU modules as no change in API for
>>> them...
>>=20
>> I understand, and I do like this approach as well. I just don't like
>> having 2 code paths/approaches for the "same thing".
>
> Hmm... understandable...
>
>>=20
>> I am not saying that this is a NAK, but i'd like to iterate a bit to see
>> if we can either deprecated raw partition descriptors (and migrate
>> existing boards) or use that everywhere.
>
> No idea if this is possible for all boards?
>
> May user want to write "some data" to an offset... which is not
> SoC/board dependent...
>
> "flash bootloader" is well defined -> flash the bootloader, so I argue
> that this should simply burn the bootloader to the correct offset...
>
> "raw" interface -> do what you think you need write to wherever you want.=
..
>
>> I will try to use this series on VIM3 to see how it behaves. It will
>> take some time though.
>
> VIM3 ? Is this a imx8qxp based hardware?

No VIM3 is a board made by Khadas that has an Amlogic SoC. But they use
the raw partition description for bootloader offset:

include/configs/khadas-vim3_android.h
52:     "fastboot_raw_partition_bootloader=3D0x1 0xfff mmcpart 1\0"     \
53:     "fastboot_raw_partition_bootenv=3D0x0 0xfff mmcpart 2\0"        \

So i'm wondering if this series can be useful to the VIM3 (so that we
could drop the fastboot_raw_partition_* from khadas-vim3_android.h)


>
> Thanks for your time!
>
> bye,
> Heiko
>>=20
>> Thanks
>> Mattijs
>>=20
>>>
>>> bye,
>>> Heiko
>>> --=20
>>> Nabla Software Engineering
>>> HRB 40522 Augsburg
>>> Phone: +49 821 45592596
>>> E-Mail: office@nabladev.com
>>> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
>
> --=20
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
