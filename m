Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D129BC47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 15:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2428A87A71;
	Fri, 29 Dec 2023 16:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="moIBl3nQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4DD187A54; Fri, 29 Dec 2023 16:42:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A7687A78
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 16:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703864562; x=1704469362; i=xypron.glpk@gmx.de;
 bh=Vx33CEq8Z4hSlEEqLH9M8WZF2WOZ9Rapoyxam6rEWTQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=moIBl3nQr8LO2IOQ6V+h1ybQAWGxZ9X/rk1QXJFfTykWiakBGLUBP4s65n/KaYFv
 vavu+TtDv2Ndo80hmzrud0mRHwcKu/TFw9fjYRg8Rt+3F6b1Xx3uzs6OP686/IKZX
 3U1xHyzkvqMnc95uBXMEOgf9Du/DxuFza1SQ7egUjtTHBLseCUkbDUi4jGjDEpx8k
 GuImI3F8O9Mz8hYuA8ATigF1hrOfsdOJH61U8QJQ7g3EakNkVqceL9F2apcQvMyYy
 gxeK5oXlq0oX98TTBOkPhlANRQbDdwvWBgzZQ5i6evvGq4PvxGVRB7D+dn+lw0qWE
 kIQz4CJWA3iLzBo7kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f9h-1rFfJ70QAx-004CPz; Fri, 29
 Dec 2023 16:42:42 +0100
Date: Fri, 29 Dec 2023 16:42:41 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: Proposal: U-Boot memory management
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
Message-ID: <A5970853-6611-4726-8D9F-E92C5E18A103@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5ZSvCcf25MGbIFzfs/o7iXo+GFb7RnSmH3tCDAImQJ+0or7G/Fr
 U5kYFNmtKRRqVuMDuZAfnOT9lh6/DFxp2KVIvveLgrvMyUdhEI2RAIg5n2VwOHhZxxJctLR
 oO/hMAROKiF8RBGps8ddYa6wk1fAYsubBCE2K8xbnaxcbnrUbz6lmyaedEpEP7FlX4rBsYZ
 bIFc5G/oXoUmzqZvnDqyg==
UI-OutboundReport: notjunk:1;M01:P0:d218iNoQnqg=;blpB0zC3Utzr9oc/LSbvYH4WKmy
 wAx/F60FxfWnM/ARmEak6kek7/w2XypxjB91Wt44orypnKTOwi+F9LFaznk6t47N7kRvvWEQt
 ijq94cb5wNFO9JIgLyEOPhbASPGKq9NpvlDMePhWLICScUV4zD4Q5n4Ghnv/INRrHq6fJzp1L
 SILt12h2J2upceft/eaRvdbJlo9dCW4uUPfAoBZqBdiZpdDdfTOuTy2BALwNmqIL060qohHbb
 4OA2tID4ag22qVCFuzC8ufjQqE35i+Ar8GHToRAaPqQ6DZep4qcOvv1KPiJNsedp8iKNXpbtp
 1E8Jns5uuJExhXq5A3DPzbkIdihbaDvyss8wo0GnjkX24NvsNA7u3szzGb2LFYR5WC4f0ij4K
 voBUHxVndomz5QBWw8FN0jMtUH+cm2I5i+2NtIzAd5uzC5OaMytNyjJtE1/yOJC59GxiStlS3
 A6ByIKjImQsztPOFvQmyPC05/yBwNn1LWdPky5Kfu9gUHLK/INZ3C3F0x0j8qx5LrpHDpBHf2
 gi0stKxCWn9M0cVXVmL1uhIheAYo7IOX2uJODOn2sKRnwTmpwU81i067Kxr33ZfRSn3kLwAhY
 pp4pJNsWiaHu8mFO/RQSpp51WB5RschrTicB5A9dlt3iE0lWqM6UFmWLoExyUKfNI8jf2ALj9
 aJoqgXHmS3gNuzKC9QLtzD7Z/9ubogkYo6V7GrrZJpHuaDy6BTc/gsSxPih1HbqXms/1mWI1n
 drIneVGOIjhtkKTMbpixIwSQBq/o48+1Pw/8Bmd7+llOYIKf1xiawzvKToPl1BkzItzZevsgY
 ZC2XSG4RvyYZUTCmGyFwHCv36wp01FVTLSMcKkCFEvtpQ+AweCPKlp1+Oq5/jiN1EItUWr0/e
 ZzsopWSXpVade4v07iGhjVPfgd2HseDaccCWnXy6XFYhdduYKLsZxnUATn5tLTnMCULblfhVO
 vUP8ZAIEBzmVcHIXr531QqSWtMk=
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



Am 29=2E Dezember 2023 06:36:09 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi,
>
>On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <sjg@chromium=2Eorg> =
wrote:
>>
>> Hi,
>>
>> This records my thoughts after a discussion with Ilias & Heinrich re
>> memory allocation in U-Boot=2E
>>
>> 1=2E malloc()
>>
>> malloc() is used for programmatic memory allocation=2E It allows memory
>> to be freed=2E It is not designed for very large allocations (e=2Eg=2E =
a
>> 10MB kernel or 100MB ramdisk)=2E
>>
>> 2=2E lmb
>>
>> lmb is used for large blocks of memory, such as those needed for a
>> kernel or ramdisk=2E Allocation is only transitory, for the purposes of
>> loading some images and booting=2E If the boot fails, then all lmb
>> allocations go away=2E
>>
>> lmb is set up by getting all available memory and then removing what
>> is used by U-Boot (code, data, malloc() space, etc=2E)
>>
>> lmb reservations have a few flags so that areas of memory can be
>> provided with attributes
>>
>> There are some corner cases=2E=2E=2Ee=2Eg=2E loading a file does an lmb
>> allocation but only for the purpose of avoiding a file being loaded
>> over U-Boot code/data=2E The allocation is dropped immediately after th=
e
>> file is loaded=2E Within the bootm command, or when using standard boot=
,
>> this would be fairly easy to solve=2E
>>
>> Linux has renamed lmb to memblock=2E We should consider doing the same=
=2E
>>
>> 3=2E EFI
>>
>> EFI has its own memory-allocation tables=2E
>>
>> Like lmb, EFI is able to deal with large allocations=2E But via a 'pool=
'
>> function it can also do smaller allocations similar to malloc(),
>> although each one uses at least 4KB at present=2E
>>
>> EFI allocations do not go away when a boot fails=2E
>>
>> With EFI it is possible to add allocations post facto, in which case
>> they are added to the allocation table just as if the memory was
>> allocated with EFI to begin with=2E
>>
>> The EFI allocations and the lmb allocations use the same memory, so in
>> principle could conflict=2E
>>
>> EFI allocations are sometimes used to allocate internal U-Boot data as
>> well, if needed by the EFI app=2E For example, while efi_image_parse()
>> uses malloc(), efi_var_mem=2Ec uses EFI allocations since the code runs
>> in the app context and may need to access the memory after U-Boot has
>> exited=2E Also efi_smbios=2Ec uses allocate_pages() and then adds a new
>> mapping as well=2E
>>
>> EFI memory has attributes, including what the memory is used for (to
>> some degree of granularity)=2E See enum efi_memory_type and struct
>> efi_mem_desc=2E In the latter there are also attribute flags - whether
>> memory is cacheable, etc=2E
>>
>> EFI also has the x86 idea of 'conventional' memory, meaning (I
>> believe) that below 4GB that isn't reserved for the hardware/system=2E
>> This is meaningless, or at least confusing, on ARM systems=2E
>>
>> 4=2E reservations
>>
>> It is perhaps worth mentioning a fourth method of memory management,
>> where U-Boot reserves chunks of memory before relocation (in
>> board_init_f=2Ec), e=2Eg=2E for the framebuffer, U-Boot code, the mallo=
c()
>> region, etc=2E
>>
>>
>> Problems
>> =E2=80=94-------
>>
>> There are no urgent problems, but here are some things that could be im=
proved:
>>
>> 1=2E EFI should attach most of its data structures to driver model=2E T=
his
>> work has started, with the partition support, but more effort would
>> help=2E This would make it easier to see which memory is related to
>> devices and which is separate=2E
>>
>> 2=2E Some drivers do EFI reservations today, whether EFI is used for
>> booting or not (e=2Eg=2E rockchip video rk_vop_probe())=2E
>>
>> 3=2E U-Boot doesn't really map arch-specific memory attributes (e=2Eg=
=2E
>> armv8's struct mm_region) to EFI ones=2E
>>
>> 4=2E EFI duplicates some code from bootm, some of which relates to
>> memory allocation (e=2Eg=2E FDT fixup)=2E
>>
>> 5=2E EFI code is used even if EFI is never used to boot
>>
>> 6=2E EFI allocations can result in the same memory being used as has
>> already been allocated by lmb=2E Users may load files which overwrite
>> memory allocated by EFI=2E
>
>7=2E We need to support doing an allocation when a file is loaded (to
>ensure files do not overlap), without making it too difficult to load
>multiple files to the same place, if desired=2E
>
>>
>>
>> Lifetime
>> --------
>>
>> We have three different memory allocators with different purposes=2E Ca=
n
>> we unify them a little?
>>
>> Within U-Boot:
>> - malloc() space lives forever
>> - lmb lives while setting out images for booting
>> - EFI (mostly) lives while booting an EFI app
>>
>> In practice, EFI is set up early in U-Boot=2E Some of this is necessary=
,
>> some not=2E EFI allocations stay around forever=2E This works OK since
>> large allocations are normally not done in EFI, so memory isn't really
>> consumed to any great degree by the boot process=2E
>>
>> What happens to EFI allocations if the app returns? They are still
>> present, in case another app is run=2E This seems fine=2E
>>
>> API
>> =E2=80=93--
>> Can we unify some APIs?
>>
>> It should be possible to use lmb for large EFI memory allocations, so
>> long as they are only needed for booting=2E We effectively do this
>> today, since EFI does not manage the arrangement of loaded images in
>> memory=2E for the most part=2E
>>
>> It would not make sense to use EFI allocation to replace lmb and
>> malloc(), of course=2E
>>
>> Could we use a common (lower-level) API for allocation, used by both
>> lmb and EFI? They do have some similarities=2E However they have
>> different lifetime constraints (EFI allocations are never dropped,
>> unlikely lmb)=2E
>>
>> ** Overall, it seems that the existence of memory allocation in
>> boot-time services has created confusion=2E Memory allocation is
>> muddled, with both U-Boot code and boot-time services calling the same
>> memory allocator=2E This just has not been clearly thought out=2E
>>
>>
>> Proposal
>> =E2=80=94-------
>>
>> Here are some ideas:
>>
>> 1=2E For video, use the driver model API to locate the video regions, o=
r
>> block off the entire framebuffer memory, for all devices as a whole=2E
>> Use efi_add_memory_map()
>>
>> 2=2E Add memory attributes to UCLASS_RAM and use them in EFI, mapping t=
o
>> the EFI_MEMORY_=2E=2E=2E attributes in struct efi_mem_desc=2E
>>
>> 3=2E Add all EFI reservations just before booting the app, as we do wit=
h
>> devicetree fixup=2E With this model, malloc() and lmb are used for all
>> allocation=2E Then efi_add_memory_map() is called for each region in
>> turn just before booting=2E Memory attributes are dealt with above=2E T=
he
>> type (enum efi_memory_type) can be determined simply by the data
>> structure stored in it, as is done today=2E For example, SMBIOS tables
>> can use EFI_ACPI_RECLAIM_MEMORY=2E Very few types are used and EFI code
>> understands the meaning of each=2E
>>
>> 4=2E Avoid setting up EFI memory at the start of U-Boot=2E Do it only w=
hen
>> booting=2E This looks to require very little effort=2E
>>
>> 5=2E Avoid calling efi_allocate_pages() and efi_allocate_pool() outside
>> boot-time services=2E This solves the problem 6=2E If memory is needed =
by
>> an app, allocate it with malloc() and see 3=2E There are only two
>> efi_allocate_pages() (smbios and efi_runtime)=2E There are more calls o=
f
>> efi_allocate_pool(), but most of these seem easy to fix up=2E For
>> example, efi_init_event_log() allocates a buffer, but this can be
>> allocated in normal malloc() space or in a bloblist=2E
>>
>> 6=2E Don't worry too much about whether EFI will be used for booting=2E
>> The cost is likely not that great: use bootstage to measure it as is
>> done for driver model=2E Try to minmise the cost of its tables,
>> particularly for execution time, but otherwise just rely on the
>> ability to disable EFI_LOADER=2E
>
>7=2E Add a flag to the 'load' command:
>
>-m <type> - make an lmb allocation for the file
>   <type> is the image type to use (kernel, ramdisk, flat_dt)
>
>any existing allocation for that type will be automatically freed
>first=2E If <type> is "none" then no freeing is possible: any loaded
>images just stack up in lmb=2E

It is unclear what your suggestion means for the address field=2E

If you still specify an address, what would be the benefit of such a flag?

If -m replaces the address, how do you refer to different loaded files of =
the same type, e=2Eg=2E two EFI binaries?

Best regards

Heinrich


>
>Add an 'lmb' (or memblock) command to allow listing and clearing allocati=
ons=2E
>
>Regards,
>Simon
