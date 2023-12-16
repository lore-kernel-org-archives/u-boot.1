Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19361C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 19:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8670587805;
	Sat, 16 Dec 2023 20:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="APhe1msg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40C2A87A64; Sat, 16 Dec 2023 20:04:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10A318775F
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 20:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702753447; x=1703358247; i=xypron.glpk@gmx.de;
 bh=TQDaeAsLtmBB+1Vt+lu8vl5+HmdsqWnqEmYrDbWwC80=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=APhe1msgDEEViMIazfNPtG1svsCYnKDMSLIBQ6IOSPxJcFnaCcwEtj7fHtSHnyMB
 tcwHD8OCXdphIEKulH0uaWMy5IHx26ySXp/4rkWyXIMiT7GVYEHkdX+LKlFB+I495
 BOYWTa0yQPcbmLvub49OEIvATX06AL5yvKCdzPHtEjecxKW2qcIMAhvjAw9gxz1+o
 ls+G3sNhvgcjD8dKm9ZDLMjhdCXyvmr1OTR6yTlxA2pHSFT6Nzn1VvIC66fV+DuLo
 Ij1K7wBEtfuFrLptPg3TJ4cAG6MoSjh1NjWBHt4oMfly1yF3Q2EmYfW2YWuGuxvA6
 mLA6N2RiGT7dude8GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.0.170] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1r6rn90vPg-007ibV; Sat, 16
 Dec 2023 20:04:07 +0100
Message-ID: <a55d0848-c70e-43a9-9223-60515aea8052@gmx.de>
Date: Sat, 16 Dec 2023 20:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal: U-Boot memory management
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:riXw7f7guy8WbygsmzP2xqIUyvuOaYtcQLAO3YZv0JzleJQySmW
 Jmd4R6nDZ004YIBWHc4RsxmA+my2agZ/h6bDeYcKR+MKYA695AWB/0kIN7IK3RDCTXvjJ0Q
 7mHxdkgVzFspsYasZCKi0pSGIRcsEiO2Hv6jzgetXmQykP/L0sJ2JzQZ6+7C8Z7M2guCDUZ
 aWDaDDtCk41hpnVSMs+Rw==
UI-OutboundReport: notjunk:1;M01:P0:DVk7FyGsLec=;qtU8yv7BPWxG5H4DGOXX7FYdfKH
 /sR6hsalwlrPoYIHQFtCh++jitu3MTuitQ2n5MSfzc181HQgpCW3aDT8uNWWYrTeDsBZk6z/E
 Ayx21r/rjX3RXol+R6SsBOql49QgoosFN5ETC41daYL/i8LH7OJ0r+SdOT3VeKabXehSnFvej
 rZ63q2YiBkYjKjWlBNg7+pXCUG7g0z6FJHGoDofbplLlgzjUs4nTZEdfcWkjgZodofmoWfRF1
 cvg4qkxxAUL1AyjVHKK8BiyAr5oumU44q1VCTrJj6lY/IOCNbGUgAtD1stbokLZGdDnhSYEZx
 k6hHbSpzZlFODNpjuSuseubegHk0Hr0xGTyfX6oqkEEiPLQ34ZfB+24Qli4YEDFHThmTZP5Ai
 MM5UrVCgufMimMaujEGtQVVj+vXN+zq1CL9LztudN4SzNfISmVVqgc8ZXusUvLTH6Qdk/5a4l
 SUAtv7tukRYVmgSJ0lnsoXky65RwM9NcYxJ4bBxcprhBGJuQrFmllFjuOiU+UKt0gCfCZ9EbU
 bYxkaPdKc4rF9re850APQM18JLr4prSbM0no3+tBU6ayT9Gxy6IRacjkM28I2U9gcWV+bsiPc
 DD3XyfYaDErn6PwxcaxsfHV+5DLkHCKzKdUAtprebsemToXghS48InrPqL2lGtctSoHxQWib2
 oZEiqi2GyjmY8Elvjd/3LCpkQcAnI73GkcZI8YewpcqSTHLHNLGMCNmmsOt1fRatluYhl1OIG
 peVDSFkf23OS7uKUKsBBvvTRYO+nhm1HI067hU1xaTgsMBGCYs7Jj1IDYH5A9xlq72JFaqI8b
 fAmIkVnKW4iWVNAShocCLHZswvOjkTS5cRN7TIM41SKMAkbZM2brKYFHvOmUUSOsn/kHKhCgO
 Ee4OapYZvhkSsbYc2+tT/qw057TTsu76ye+OPaVS7jthilHbzPMnxpjOGAKQKvViTcBc3i3Ts
 cd+UGv+bEYJuM3a9dAMAXYdFtqA=
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

On 12/16/23 19:01, Simon Glass wrote:
> Hi,
>
> This records my thoughts after a discussion with Ilias & Heinrich re
> memory allocation in U-Boot.
>
> 1. malloc()
>
> malloc() is used for programmatic memory allocation. It allows memory
> to be freed. It is not designed for very large allocations (e.g. a
> 10MB kernel or 100MB ramdisk).
>
> 2. lmb
>
> lmb is used for large blocks of memory, such as those needed for a
> kernel or ramdisk. Allocation is only transitory, for the purposes of
> loading some images and booting. If the boot fails, then all lmb
> allocations go away.
>
> lmb is set up by getting all available memory and then removing what
> is used by U-Boot (code, data, malloc() space, etc.)
>
> lmb reservations have a few flags so that areas of memory can be
> provided with attributes
>
> There are some corner cases...e.g. loading a file does an lmb
> allocation but only for the purpose of avoiding a file being loaded
> over U-Boot code/data. The allocation is dropped immediately after the
> file is loaded. Within the bootm command, or when using standard boot,
> this would be fairly easy to solve.
>
> Linux has renamed lmb to memblock. We should consider doing the same.
>
> 3. EFI
>
> EFI has its own memory-allocation tables.
>
> Like lmb, EFI is able to deal with large allocations. But via a 'pool'
> function it can also do smaller allocations similar to malloc(),
> although each one uses at least 4KB at present.
>
> EFI allocations do not go away when a boot fails.
>
> With EFI it is possible to add allocations post facto, in which case
> they are added to the allocation table just as if the memory was
> allocated with EFI to begin with.
>
> The EFI allocations and the lmb allocations use the same memory, so in
> principle could conflict.
>
> EFI allocations are sometimes used to allocate internal U-Boot data as
> well, if needed by the EFI app. For example, while efi_image_parse()
> uses malloc(), efi_var_mem.c uses EFI allocations since the code runs
> in the app context and may need to access the memory after U-Boot has
> exited. Also efi_smbios.c uses allocate_pages() and then adds a new
> mapping as well.
>
> EFI memory has attributes, including what the memory is used for (to
> some degree of granularity). See enum efi_memory_type and struct
> efi_mem_desc. In the latter there are also attribute flags - whether
> memory is cacheable, etc.
>
> EFI also has the x86 idea of 'conventional' memory, meaning (I
> believe) that below 4GB that isn't reserved for the hardware/system.
> This is meaningless, or at least confusing, on ARM systems.
>
> 4. reservations
>
> It is perhaps worth mentioning a fourth method of memory management,
> where U-Boot reserves chunks of memory before relocation (in
> board_init_f.c), e.g. for the framebuffer, U-Boot code, the malloc()
> region, etc.
>
>
> Problems
> =E2=80=94-------
>
> There are no urgent problems, but here are some things that could be imp=
roved:
>
> 1. EFI should attach most of its data structures to driver model. This
> work has started, with the partition support, but more effort would
> help. This would make it easier to see which memory is related to
> devices and which is separate.
>
> 2. Some drivers do EFI reservations today, whether EFI is used for
> booting or not (e.g. rockchip video rk_vop_probe()).

Hello Simon,

thank you for summarizing our discussion.

Some U-Boot drivers including rockchip video inform the EFI sub-system
that memory is reserved.

Furthermore drivers like arch/arm/mach-bcm283x/reset.c exist that are
still used after ExitBootServices. mmio addresses have to be updated
when Linux creates its virtual memory map. Currently this is done via
efi_add_runtime_mmio(). A more UEFI style method would be to register an
event handler for ExitBootServices() and use ConvertPointer() in the
event handler.

>
> 3. U-Boot doesn't really map arch-specific memory attributes (e.g.
> armv8's struct mm_region) to EFI ones.

U-Boot fails to set up RWX properties. E.g. the region where a FIT image
is loaded should not be executable.

>
> 4. EFI duplicates some code from bootm, some of which relates to
> memory allocation (e.g. FDT fixup).

Fixup code is not duplicated but invoked via image_setup_libfdt().

>
> 5. EFI code is used even if EFI is never used to boot


* Only a minimum initialization of the EFI sub-system happens in
efi_init_early().
* Some EFI code is called when probing block devices because we wanted
the EFI and the dm part to be integrated.
* The rest of the initialization in efi_init_obj_list() is only invoked
if an EFI command is invoked.

>
> 6. EFI allocations can result in the same memory being used as has
> already been allocated by lmb. Users may load files which overwrite
> memory allocated by EFI.

The most worrisome issue is that EFI may allocate memory where U-Boot
has loaded files like initrd as the EFI sub-system is never informed
which memory is used for files.

Loading files should not be possible without creating a memory
reservation that becomes visible to the EFI sub-system.

>
>
> Lifetime
> --------
>
> We have three different memory allocators with different purposes. Can
> we unify them a little?
>
> Within U-Boot:
> - malloc() space lives forever
> - lmb lives while setting out images for booting
> - EFI (mostly) lives while booting an EFI app
>
> In practice, EFI is set up early in U-Boot. Some of this is necessary,
> some not. EFI allocations stay around forever. This works OK since
> large allocations are normally not done in EFI, so memory isn't really
> consumed to any great degree by the boot process.

U-Boot can load EFI drivers which stay resident in memory after the
efi_main() method has returned to U-Boot. The next EFI application then
may use the driver. Therefore is essential that the EFI subsystem has
access to a valid memory model at all times.

>
> What happens to EFI allocations if the app returns? They are still
> present, in case another app is run. This seems fine.
>
> API
> =E2=80=93--
> Can we unify some APIs?
>
> It should be possible to use lmb for large EFI memory allocations, so
> long as they are only needed for booting. We effectively do this
> today, since EFI does not manage the arrangement of loaded images in
> memory. for the most part.
>
> It would not make sense to use EFI allocation to replace lmb and
> malloc(), of course.
>
> Could we use a common (lower-level) API for allocation, used by both
> lmb and EFI? They do have some similarities. However they have
> different lifetime constraints (EFI allocations are never dropped,
> unlikely lmb).

The way lmb is used is a deficiency of U-Boot. E.g. you can load an
initrd that overwrites the previously loaded kernel and then try to boot.

What we need is a common memory management library where allocations are
never dropped and which is used by all file loads.

>
> ** Overall, it seems that the existence of memory allocation in
> boot-time services has created confusion. Memory allocation is
> muddled, with both U-Boot code and boot-time services calling the same
> memory allocator. This just has not been clearly thought out.
>

We have to implement what the UEFI specification requires. Some
boot-time services must allocate memory via AllocatePool() or
AllocatePages() because that memory is handed out to the caller of an
API function and it is the callers obligation to free the memory via
FreePool() or FreePages().

>
> Proposal
> =E2=80=94-------
>
> Here are some ideas:
>
> 1. For video, use the driver model API to locate the video regions, or
> block off the entire framebuffer memory, for all devices as a whole.
> Use efi_add_memory_map()

When video memory is located higher than the stack the EFI sub-system
will not make use of the memory.

>
> 2. Add memory attributes to UCLASS_RAM and use them in EFI, mapping to
> the EFI_MEMORY_... attributes in struct efi_mem_desc.
>
> 3. Add all EFI reservations just before booting the app, as we do with
> devicetree fixup. With this model, malloc() and lmb are used for all
> allocation. Then efi_add_memory_map() is called for each region in
> turn just before booting. Memory attributes are dealt with above. The
> type (enum efi_memory_type) can be determined simply by the data
> structure stored in it, as is done today. For example, SMBIOS tables
> can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used and EFI code
> understands the meaning of each.

This would require a permanent storage of the reservations. Keep it
easy, unify the memory management and make it persistent.

>
> 4. Avoid setting up EFI memory at the start of U-Boot. Do it only when
> booting. This looks to require very little effort.

There is no such thing as EFI memory. We only have one physical memory
that we have to keep track of.

It is not possible to set up the EFI memory map if you don't keep track
of all memory allocations including all file loads over the whole
lifetime of U-Boot.

>
> 5. Avoid calling efi_allocate_pages() and efi_allocate_pool() outside
> boot-time services. This solves the problem 6. If memory is needed by
> an app, allocate it with malloc() and see 3. There are only two
> efi_allocate_pages() (smbios and efi_runtime). There are more calls of
> efi_allocate_pool(), but most of these seem easy to fix up. For
> example, efi_init_event_log() allocates a buffer, but this can be
> allocated in normal malloc() space or in a bloblist.

If we have a unified memory allocation layer, efi_allocate_pages() and
efi_allocate_pool() will be implemented by calls into that layer and
issue 6) will vanish.

>
> 6. Don't worry too much about whether EFI will be used for booting.
> The cost is likely not that great: use bootstage to measure it as is
> done for driver model. Try to minmise the cost of its tables,
> particularly for execution time, but otherwise just rely on the
> ability to disable EFI_LOADER.

The time intensive part of having EFI enabled is scanning file systems
for boot files and capsules.

Best regards

Heinrich
