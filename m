Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B45C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 19:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 523E380EC0;
	Fri, 21 Feb 2025 20:22:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BY4UMSeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B8EC80F56; Fri, 21 Feb 2025 20:22:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60206807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 20:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740165725; x=1740770525; i=xypron.glpk@gmx.de;
 bh=hrSxBYUgsamwzKT60zCRmibJ/4fv+0RjfIoYF5cCY8w=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BY4UMSeDiSMFoB3bRFyXiCHURWaU7TYRQRbMGw3L8prmKyKyR37QazcpvsZkkvu/
 5UqOyK1oRSoILAAo4913+MrbqhhGFDgu5xvvO7tR8MAvNPVA5lYVr5q+KBuwF4wNS
 apVhfoVKcvs50wxHK2l0d3lK9ZRtbJ7Ike4CusRRY7BxmvzjjxkKwwpZDQ+VpZxzt
 npAP8IiQ8FefA4Guvz3o17ALtzQOK8ou0Uy5X484FIiDGISiX95EstotzoKQzwGl+
 L228CMEm99EgEaVHKK7LrxRr8ymRIBKOVdL/TnR1C7Z0TxU8VLJtfNbMeReBc+MBe
 6FcihEKDKoBWqMZg5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbVu-1tXpsw2xck-003zOP; Fri, 21
 Feb 2025 20:22:04 +0100
Date: Fri, 21 Feb 2025 20:22:02 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
CC: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_5/5=5D_blkmap=3A_add_pmem_?=
 =?US-ASCII?Q?nodes_for_blkmap_memory_mapped_slices?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAC_iWj+a-hcvS=u_Gtk39UyjSPuMgWoao982TzN+wb5uKnS=hg@mail.gmail.com>
References: <20250203105912.196654-1-sughosh.ganu@linaro.org>
 <20250203105912.196654-6-sughosh.ganu@linaro.org>
 <CAC_iWj+a-hcvS=u_Gtk39UyjSPuMgWoao982TzN+wb5uKnS=hg@mail.gmail.com>
Message-ID: <62C0A2AF-2936-46DA-9307-7AAA90512B4C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FcfZtapTG0hvHofOagmqV9upmXqNBLRMZCg7PuSBsnYOJ0hILIY
 k54EcUrNE8q0YAsCNF/yQ2dwjM6Ss89jXr1ZBWi9LSqgerHW+zC2vPV/FKqovCgORGzNGhJ
 m7pRLBDAiALsDN5MrYnmIyfjTDn86yeOtxPjgJzZeeMxOeQC9V2JMLEfsVeG8ovCWkmOfLp
 LlxWfFiAnccZUWOLUCWyw==
UI-OutboundReport: notjunk:1;M01:P0:LphRql/xQ8E=;wfHT47Zb7u2vJYbZX/oLAkBSlub
 vgRTopRhTMgGq72bAnKB89P1DT0MqrbA33hmdHKoBdbdF7fX6l0yzNa2jpRuqFrlMcfNdvC2q
 CbxZh/2r2vvGkKCgnT5TlhSVOgJNn8Mi6WFMwioJFqJDsdCw1JeBdC01wcksfdvMIqH8xItPj
 uCaDC9BtIcwbpza22z/7ey9H+K7dj/uS10s53441/qeYPUsMazXp7C70QuRKZLFX0gYCooLGT
 e8rQnRWc3eqZCCpztR1tbQlsQfig+mfrJNvZnTubl3opROZ558LpxgQhNgCr4OZU+70KhmQy0
 NgXA4IEbED6k8Km4Vqa/DJe+HW4mUA7DlxOpy91xUb2Tunx+7n7BHDK62HSaMV8jbZP/iiua4
 xfFtVEC0EEd0Le2JfR13aWVwsgXC1IMpXxHId2MFojXLJZlk8bqE5dWnE625Nyq2SOFKTBQLg
 nHdbr4iYOHUWropKGfB/rUnEk6m5K615O8lqBrAY/silm+T75ePn0h/fcDUmRV+MMS5gIOdr4
 FgOcxy6bYu5atiJgzvb2Hb17LjM/ex8LGjZw9fMgvavUo0iJ6Jfq4v4BOGsAeoouN70/0SEkJ
 ghZNi8LuNkzWlXVLm721HGXznm9YqpwPa8zcczaSkww4Qwjpb4kXGlroPAs8rOayHLgfgZ0H5
 ZHa/GcIxE2SZ58rBmB+6ovLKMxVMQftAvdy0oDwxo4wnS0RSjgKeSKO+2vH2ozbWEG7QuIpJu
 oyjh22H/daun64gZaZMdkQjCbFeJkBDLIW9lyLZhNZbz1JzY4LaB6VNwDIyQ64riBIGfVPZBT
 4ntsCX7sqpGeCW1rMmWBfNZeo6mKhsgCorLVymvPxXpwWU8rFYLR8Cgxz6UzSuAm4oRZZKvRP
 8ODdgc8JwVpiMntKrDOu6oG3ktfBcciXnlkH0F4UNQ1RbqTQ1I5Ryp3yaf9SIl9IFvK9wiOpT
 OWKAZC4mGc7UrvaYf4MnNJRwl1nmZ9UJJ0KkGhLWSLu7oHkbdnGtzanz31+uFpeNmqu4XEEmB
 PV8qov66yYJreTy57HNZ3h7Bs+EBhhJc0L09qaE/XFYMbs3Cs7MezuSA53YdkmQK1Ac3TkaM4
 4GvIDzugMNO8ccR4BxFRu0rKmM1gQbuNF19Zgr97dfiqeRhE1fHe7gYrl6zI0euuvk9/VGpg9
 1iQkOVDdcgkkgvD7Hjng2VrPzlbt3u9t0VNvHD7wqZWPiUKiEQLfi+WtKwwLRavVAqyTwbPIe
 4ZEVzpIIq5zL+pOOJKldUhky2GGyMxANKIa2+tbDdJxunrwW87nE2nMOTFhNJ+t2tb1r1yStL
 gcSdhRiZ8z2u4Y6WjxgGgktnue+4K0um/r/sCPanen/kp1OYCqWnpI9xUsQ5NG8ln/u+YAsrT
 ICYAPKh/Ks0gJV53j1lVRLglqpopC5X/sma/uj4a15EbpOFG4V5QKuE7JO
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

Am 21=2E Februar 2025 19:55:03 MEZ schrieb Ilias Apalodimas <ilias=2Eapalod=
imas@linaro=2Eorg>:
>Hi Sughosh
>
>This generally looks ok, but I don't love the idea of unconditionally
>preserving all slices regardless of their usage=2E
>Basically, if a user doesn't unmap that slice it will end in kernel
>memory=2E My fear is that someone will forget device sensitive data in a
>blkmap=2E=2E=2E=2E

I don't that you can easily determine which blkmap and which blkmap slice =
was created why=2E

But can we realisticly assume that a device that U-Boot reads from is secu=
re against reading at kernel runtime=2E I don't believe so as U-Boot runs a=
t the same exception level as the kernel=2E U-Boot and the kernel do not em=
pty RAM=2E You always have to assume that whatever is in U-Boot memory is d=
icoverable at kernel runtime=2E

If you load sensitive data, you must overwrite it before booting=2E

Best regards

Heinrich



>
>On Mon, 3 Feb 2025 at 12:59, Sughosh Ganu <sughosh=2Eganu@linaro=2Eorg> w=
rote:
>>
>> The EFI HTTP boot puts the ISO installer image at some location in
>> memory which needs to be added to the devicetree as persistent
>> memory (pmem) node=2E The OS installer then gets information about the
>> presence of this ISO image through the pmem node and proceeds with the
>> installation=2E
>>
>> In U-Boot, this ISO image gets mounted as a blkmap device, with a
>> memory mapped slice=2E Add a helper function which iterates through all
>> such memory mapped blkmap slices, and calls the FDT fixup function to
>> add the pmem node=2E Invoke this helper function as part of the DT fixu=
p
>> which happens before booting the OS=2E
>>
>> Signed-off-by: Sughosh Ganu <sughosh=2Eganu@linaro=2Eorg>
>> ---
>> Changes since V3:
>> * Move the definition of the helper function to the efi_helper=2Ec
>> * Remove the region of the blkmap mem map device from the EFI memory
>>   map along with adding the pmem node
>>
>
>[=2E=2E=2E]
>
>> @@ -680,3 +683,52 @@ out:
>>
>>         return ret;
>>  }
>> +
>> +static int add_blkmap_pmem_nodes(void *fdt, struct blkmap *bm)
>> +{
>> +       int ret;
>> +       u32 size;
>> +       ulong addr;
>> +       efi_status_t status;
>> +       struct blkmap_mem *bmm;
>> +       struct blkmap_slice *bms;
>> +       struct blk_desc *bd =3D dev_get_uclass_plat(bm->blk);
>> +
>> +       list_for_each_entry(bms, &bm->slices, node) {
>> +               if (bms->type !=3D BLKMAP_SLICE_MEM)
>> +                       continue;
>
>Can we convert the 'type' to 'preserve' and teach
>blkmap_create_ramdisk() to pass that flag?
>This way we can unconditionally pass it from EFI HTTP installers, and
>let the command line users decide if they want to preserve it=2E
>
>
>> +
>> +               bmm =3D container_of(bms, struct blkmap_mem, slice);
>> +
>> +               addr =3D (ulong)(uintptr_t)bmm->addr;
>> +               size =3D (u32)bms->blkcnt << bd->log2blksz;
>> +
>> +               ret =3D fdt_fixup_pmem_region(fdt, addr, size);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               status =3D efi_remove_memory_map(addr, size,
>> +                                              EFI_CONVENTIONAL_MEMORY)=
;
>> +               if (status !=3D EFI_SUCCESS)
>> +                       return -1;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>
>
>Thanks
>/Ilias

