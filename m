Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B597CDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 09:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8705C86F39;
	Wed, 18 Oct 2023 11:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TrTGEbgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A32EA86F39; Wed, 18 Oct 2023 11:31:00 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E90086B73
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 11:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697621453; x=1698226253; i=xypron.glpk@gmx.de;
 bh=gGy3EkSp+ybtiXko4zIg24e2ZrKTyXS8GXMcPxN/u7M=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TrTGEbgTZyVtEUeCnV/o9tVXA+B+doqnXprxZ7ADtflI0sp9n18tVO9gdVP516ZEu5Ai7IotoiA
 buQprE4tnzGNnwbjm0abHiCPw5p518lOEGLP2q4DQguEfxVZpEqKD3JV3jYQXMs4Ic7hvGKgZTmoU
 E5IptfRuOj+I2wE0b16TxUPoiYz5qt+2RnNzbnoddXOyITWoN8/p+OJO6AaayY9j1Q5NOkVvUMePh
 Ce2PWJJ3wDmNgisS1Ivlaefi/HifQp4k17cyfp3kpTgElcEURebLkCPcuBeTaC7MHLqg71tXMUh5R
 mk3E6uXaYSVGek3zG7Q5DNyklHLdrlbE2QBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQj7-1ql3c81jR7-00Gs3Y; Wed, 18
 Oct 2023 11:30:53 +0200
Message-ID: <c6f6bb8d-6caf-497b-977c-108a0ff2f1e8@gmx.de>
Date: Wed, 18 Oct 2023 11:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] efi_loader: create default file boot option
Content-Language: en-US, de-DE
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-5-masahisa.kojima@linaro.org>
 <A2082A91-A1CC-43E8-B151-968D7746B906@gmx.de>
 <CAC_iWj+koNjVBR7TCJH_u_PvY5xDHgtBGRTHBRRgAx_aDeC8-A@mail.gmail.com>
 <ae12d900-fe7f-4f7b-9eb1-018aa719174f@gmx.de>
 <CADQ0-X8XGiek9oBEFeDtXaR2vcBsQS-NhJK5mL9TRLK+9gTJ2A@mail.gmail.com>
 <050e8bea-771b-491d-8d66-14fadcff0487@gmx.de>
 <CADQ0-X9n24HVJ_AoMszTUQy1wk+q=TfZG915mzd3gd=GScxjMA@mail.gmail.com>
 <CAC_iWjJccjJPEWpiBKOA+ue21JAcosVHsgQH7QJvMzcRBASkAw@mail.gmail.com>
 <CADQ0-X8ndi2UmqWTkcfp=1UsPRnZKDi3RJfFVJb7A6FsMZ4=Vw@mail.gmail.com>
 <CAC_iWjL8n7Zkm3qa7MHzjS9gi1ap9EJdezFML4bSmzFDUpMW-A@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjL8n7Zkm3qa7MHzjS9gi1ap9EJdezFML4bSmzFDUpMW-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vqRQSLffAc7ONNMzvkUZGNSzEA2ikgIW27smZlErGOJgvIBBdkh
 ihmI9Voe6xWs4cThtKkBhHtcELBIe303YTKc/xh4+oMLbemw6rdPGGuLgP1QkjY8SGz4upH
 uK9VuccDEEdjLrx6KmuhSwLf+dFo3CESrNLoWbwSU0Z3ZUhPulSlFX+6r++i1+rLlmdSGaH
 IksN4VppPQoOHPs36zFTw==
UI-OutboundReport: notjunk:1;M01:P0:ziPW2hmq5k4=;Ny7ZwZjyJSa1gY0PbspqhjbzZcm
 N7x/uLhPvUs55nSs30sqeT48fsYUYGH7/OIcGxzP2C0IIFTAodgokzzWHTSo8IZrkFiJHCnWO
 MYbSP1GwEYwgpRD0Gq1PWnpGogYHmb2rCGnxEiY15k3gn6vjeb002l/UjCjWEvhZTzVT76LK/
 xWwCMavAY+samhrIuCgB6wYUq2wwssdkua5/zF5WCIHTwozwcsEsSUqQYBQp3pKPXI8vfDFQ9
 BqmCjtJM0NS5Unwpmqg+JfciRGzggSiCyGP2FYwoQXs99PtJypM5Vz5UUB4yarY7KkxVSHRjG
 LoT/1qhMGHywzVkCs70eb4mUL0bOETkQ+Bv4F2/UIiAyfBKdBN58/lCfyZLKao96hINZAXYrQ
 Ezr8njd99qMd1rT5MSqKcE/60NtUMwNTm6udaNF/cavLjBlhiKZWv8oCOo4VWFE6pT4+RQjkS
 hQMbGc/vLr6RHqx2xbyd6Bxl+fAhdAhVQ0gGaW6Nznru6icmr39QDUb6pRUC4k1fWdF2cKy7A
 o728qIGpVYe4Ie1Ljr43lzIE5k66jvzr6tlFHw5WShIWGfr6QNkQQIWt3K8SD57Nkh7NZsUgt
 52CbkcX6C3hxoC8sPOCbbZ1nASNI71LC4YkfILtJKeeMQGRgW5qE696wCyOM5zWTVsP1ibJo5
 Z/nADwt9BKjEKWwIfMC/uFCy0adaoEnalf7vMgxiha82JQ25sPY1khsnaZhPnvEs6Z3cSxgwC
 1SC+E9WztrLdw83Y2+M3kZ90xTsohKKXYpJzP3pI0EGf124/kicCoc7TB/DjVedSpvTJ5G0wn
 2ZBfmEeOC+l+APwyulEuhnzTV0xDpbr6B/fJfAqTqx2EwxrAnXUIHmG3ctTOF0kunhjp+MdMw
 JZRWSB1DY+G7/Vm2PkP4Yygi7XKxVJ6FclFIe3myvULPUum70o2PBQHxzgWHLJhGmAYvFLJ3m
 mXb/CFo6gD7NPtLryMqBwPLqsMk=
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

On 10/18/23 11:12, Ilias Apalodimas wrote:
> Hi Kojima-san
>
> On Wed, 18 Oct 2023 at 12:07, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
>>
>> Hi Ilias,
>>
>> On Wed, 18 Oct 2023 at 04:47, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>>>
>>> Hi all,
>>>
>>> On Tue, 17 Oct 2023 at 08:33, Masahisa Kojima
>>> <masahisa.kojima@linaro.org> wrote:
>>>>
>>>> Hi Heinrich,
>>>>
>>>> On Mon, 16 Oct 2023 at 23:52, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
>>>>>
>>>>> On 16.10.23 15:00, Masahisa Kojima wrote:
>>>>>> On Mon, 16 Oct 2023 at 21:46, Heinrich Schuchardt <xypron.glpk@gmx.=
de> wrote:
>>>>>>>
>>>>>>> On 16.10.23 14:31, Ilias Apalodimas wrote:
>>>>>>>> Hi Heinrich,
>>>>>>>>
>>>>>>>> On Mon, 16 Oct 2023 at 10:06, Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Am 16. Oktober 2023 08:45:21 MESZ schrieb Masahisa Kojima <masah=
isa.kojima@linaro.org>:
>>>>>>>>>> Current efibootmgr automatically creates the
>>>>>>>>>> boot options of all disks and partitions installing
>>>>>>>>>> EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
>>>>>>>>>> Some of the automatically created boot options are
>>>>>>>>>> useless if the disk and partition does not have
>>>>>>>>>> the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
>>>>>>>>>>
>>>>>>>>>> This commit only creates the boot option if the disk and
>>>>>>>>>> partition have the default file so that system can directly
>>>>>>>>>> boot from it.
>>>>>>>>>
>>>>>>>>> I don't directly see the user benefit.
>>>>>>>>
>>>>>>>> The user can add an HTTP boot option now and the installer will
>>>>>>>> automatically start.  That would allow products to ship with a si=
ngle
>>>>>>>> boot option provisioned and run an installer on first boot
>>>>>>>
>>>>>>> This commit is not about HTTP. It changes how boot options for blo=
ck
>>>>>>> devices are created.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Reading all file systems will increase the boot time. Shouldn't =
we avoid this?
>>>>>>>>
>>>>>>>> Any idea what would be an alternative?  But when we added the
>>>>>>>> automatic boot options we said we should avoid dynamic scanning a=
nd
>>>>>>>> store results in a file.  This is doing a similar thing.  The onl=
y
>>>>>>>> difference is that it mounts the iso image before adding the boot
>>>>>>>> option.
>>>>>>>
>>>>>>> The alternative is to keep showing boot options for block devices =
even
>>>>>>> if there is no BOOTxxxx.EFI file.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> What does EDK II do?
>>>>>>>>
>>>>>>>> No Idea :)
>>>>>>>
>>>>>>>
>>>>>>> On my workstation I get generated boot options
>>>>>>>
>>>>>>> Boot0001* UEFI:CD/DVD Drive     BBS(129,,0x0)
>>>>>>> Boot0003* UEFI:Removable Device BBS(130,,0x0)
>>>>>>> Boot0004* UEFI:Network Device   BBS(131,,0x0)
>>>>>>>
>>>>>>> without any media inserted and without any PXE server available.
>>>>>>
>>>>>> It is just information about how the EDK2 works.
>>>>>> When I attach the Fedora installation media on EDK2(OVMF),
>>>>>> the automatically generated boot option is as follows.
>>>>>>
>>>>>> UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,=
Master,0x0)
>>>>>
>>>>> An ATAPI drive typically is not removable. So I wonder why it is lis=
ted.
>>>>> Did you set the removable flag on the command line?
>>>>
>>>> I guess it is not removable(actually I don't know how to set the
>>>> device as removable).
>>>> I just attached the iso image to QEMU with something like '-hda
>>>> Fedora_netinst.iso".
>>>>
>>>> According to the EDK II implementation[1], the boot option is
>>>> enumerated with the following order.
>>>>    1. Removable BlockIo
>>>>    2. Fixed BlockIo
>>>>    3. Non-BlockIo SimpleFileSystem
>>>>    4. LoadFile
>>>> So boot option for the fixed device such as HDD is also automatically=
 created.
>>>>
>>>> [1] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Librar=
y/UefiBootManagerLib/BmBoot.c#L2150
>>>>
>>>>>
>>>>>>
>>>>>> When this boot option is selected, Fedora installer automatically s=
tarts.
>>>>>> So EDK II is searching the default file on the fly.
>>>>>
>>>>> What is shown if you attach a medium without Bootaa64.efi?
>>>>
>>>> The same boot option is created.
>>>> UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Ma=
ster,0x0)
>>>
>>> I went back to reading the spec and I think Heinrich is right.  We
>>> don't need that check at all. Going through [0] paragraph 4 says
>>> " This search occurs when the device path of the boot image listed in
>>> any boot option points directly to an EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
>>> device and does not specify the exact file to load"
>>>
>>> So we should *only* add an automatic variable without the default
>>> application.  Our code in try_load_entry() will search for that
>>>
>>
>> Thank you for checking the UEFI specification and sorry for
>> overlooking the above.
>> So we will go back to the previous on the fly default application searc=
h.
>
> Yes, I was about to suggest that.
> The problem as I understand it that the current patch not only
> disregards disks and partitions that dont have a default (i.e
> bootaa64.efi) file. It also *changes* the default boot option we add,
> and instead of the disk it adds a file.  That is the part that's
> against the spec.  On top of that it changes the behavior of efi
> bootmgr and we never call the expand_media_path.
>
> So my suggestion would be
> - Drop #4
> - Adjust patch 5 and instead of loading the boot entry directly, scan
> for the special autogenerated boot option and look for that file there
>
> Heinrich would that work for you?

That is fine with me. This allows us to handle any deviations of U-Boot
from the spec concerning generated boot options in a separate patch series=
.

We still need to look into adding the deletion of the blkmap resource in
case of error or when the EFI application returns.

Best regards

Heinrich

>
> Thanks
> /Ilias
>>
>> Thanks,
>> Masahisa Kojima
>>
>>> [0] https://uefi.org/specs/UEFI/2.10/03_Boot_Manager.html#load-option-=
processing
>>>
>>> Regards
>>> /Ilias
>>>>
>>>> Thanks,
>>>> Masahisa Kojima
>>>>
>>>>>

