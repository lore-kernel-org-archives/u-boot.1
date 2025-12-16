Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3052D637DF
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 22:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B2C183A5A;
	Tue, 16 Dec 2025 23:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nS58dSPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4531183A7A; Tue, 16 Dec 2025 23:23:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3442E839FA
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 23:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1765923788; x=1766528588; i=xypron.glpk@gmx.de;
 bh=lx0c53LZ9Oojp995fSpX/edW7+mw/zJHgM3ACdjfUlc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=nS58dSPb8O99+mtZ9a0qkX5dWNtbeUH/NWwonu3gC6MZdyNxzOzOhejskKUXktIu
 /drqNzLMdj8H2WMcqvnwTAowEzIh+Oir/9AYxETwwzdLK175n883oaonoZS8qG8NN
 sKAmjCqbvFS//B53B+TvLGTg91sO7Z/hE7LarTpxuvLfcSHRucANjnvQ1FUusqGni
 FsUgbOiZj0YsJCQqqH0+eobOS3Htoer/9niBTwMW3iRGQ2YQsJjDdzcZWy3XIENyn
 FshoZvoRRd9TuDaIOj+rPTVvk2qqEz+EqVOtNvSki2nD9clLREeEmFnYt13jw9k/w
 CuOsKsW1CHdgwMKBFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([61.8.137.194]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1w7QyB0Tfe-00hFg7; Tue, 16
 Dec 2025 23:23:08 +0100
Date: Tue, 16 Dec 2025 23:23:02 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 John Toomey <john.toomey@amd.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 andrew.goodbody@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_efi=5Floader=3A_Trigger_capsule_upd?=
 =?US-ASCII?Q?ates_with_automatically_generated_boot_options?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAC_iWjL696HDh5_p9BnoYBfwsHsEyBai2p26+Df5O5bKhSqHZA@mail.gmail.com>
References: <20251216074710.270479-1-ilias.apalodimas@linaro.org>
 <d70c8dad-dc9e-461d-a0f8-afc27d818b50@gmx.de>
 <CAC_iWjL696HDh5_p9BnoYBfwsHsEyBai2p26+Df5O5bKhSqHZA@mail.gmail.com>
Message-ID: <254D80CF-E09B-4DFA-B1FB-395B62EA3FE3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BFyJAeTNhHC3s9AHT1cdSxzB5J1usxtULLwlY8Enj6QuJ7SSca2
 OVx4IO9Ia/S5R/Dlp560AjZ981JuTGHE0PqcpHllfPiB0ov6Wh8fpBSJK0DLh7S0uvlNSlk
 bFtfwbOV5qZHZPjKpOl/cLz+LIOSUmcRdCgRB3ydG0n3/4Urc3OoyFSD/7bNbpnHVRKa91Y
 r/iItIhQVJiXVBk2Hm6iQ==
UI-OutboundReport: notjunk:1;M01:P0:xbdBvyE7fzM=;PyDUcOoIuqJfNOHjMvgp4yK+8Gt
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

Am 16=2E Dezember 2025 17:48:42 MEZ schrieb Ilias Apalodimas <ilias=2Eapalo=
dimas@linaro=2Eorg>:
>Hi Heinrich,
>
>[=2E=2E=2E]
>
>
>
>> >
>> >   /**
>> > - * device_is_present_and_system_part - check if a device exists
>> > + * get_esp_handle - check if a device exists and contains an ESP
>>
>> The logic looks ok=2E Yet, the descriptions need rework=2E
>>
>> "check if a device exists and contains an ESP":
>> This is not what this function does=2E It checks if a device has an ESP=
 as
>> immediate child=2E
>
>Not only=2E If the provided DP is a pointing to a file in the ESP in
>will exit before trying to probe any of the disk children=2E
>
>>
>> >    *
>> >    * Check if a device pointed to by the device path, @dp, exists and=
 is
>> > - * located in UEFI system partition=2E
>> > + * either an ESP or a disk containing an ESP=2E
>>
>> Nowhere do you check if the device is a disk=2E The end node of @dp cou=
ld
>> be anything=2E
>>
>> An NVMe drive may have many namespaces, a SCSI drive many LUNs=2E
>>
>> The partition is not the child of the drive but of the namespace or the=
 LUN=2E
>>
>> An NVMe(NSID,EUI) node in a device-path is for a namespace not for a
>> drive=2E Similarly an Scsi(PUN,LUN) node is for the LUN and not for the
>> drive (PUN)=2E
>>
>> Please, provide an accurate function description=2E
>
>I am not sure I understand what you are expecting here=2E
>We treat disks and partitions as a 'udevice'=2E What the function does
>is look at the provided DP and get the associated handle for the
>device to look at the device children=2E
>I haven't looked closely into SCSI or NVMe device paths=2E Do you have
>any suggestions?
>
>>
>> >    *
>> >    * @dp              device path
>> > - * Return:   true - yes, false - no
>> > + * Return:   ESP handle or NULL
>> >    */
>> > -static bool device_is_present_and_system_part(struct efi_device_path=
 *dp)
>> > +efi_handle_t get_esp_handle(struct efi_device_path *dp)
>> >   {
>> > -     efi_handle_t handle;
>> > +     efi_handle_t handle, dev_handle;
>> > +     struct udevice *child_dev;
>> >       struct efi_device_path *rem;
>> > +     efi_status_t ret;
>> >
>> >       /* Check device exists */
>> > -     handle =3D efi_dp_find_obj(dp, NULL, NULL);
>> > -     if (!handle)
>> > -             return false;
>> > +     dev_handle =3D efi_dp_find_obj(dp, NULL, NULL);
>> > +     if (!dev_handle)
>> > +             return NULL;
>> >
>> >       /* Check device is on system partition */
>>
>> Should this be
>> "Check if the device path points to an EFI system partition"?
>
>This checks if the DP is on a partition with the ESP installed=2E
>'device' is the udevice u-boot defines=2E
>I don't mind changing it=2E

I just dislike the inaccurate langage=2E

A device like mmc 0:0 cannot be *on a system partition*=2E The ESP GUID ca=
n be installed on the same handle as the device path dp=2E

>
>>
>> >       handle =3D efi_dp_find_obj(dp, &efi_system_partition_guid, &rem=
);
>> > -     if (!handle)
>> > -             return false;
>> > +     if (handle)
>> > +             return handle;
>> > +
>> > +     /* If it's a disk check its children */
>>
>> The object that you check may be anything, not necessarily a disk=2E

An EFI application can create an ESP partition device with any parent, e=
=2Eg=2E Mem()=2E

The function does not care what is the last node of dp=2E

"Check if any direct child of the dp handle is an ESP" would match what th=
e loop does=2E


>
>efi_disk_create_raw() and efi_disk_create_part() are used to create
>the EFI tags=2E What else can it be?
>Shall I just remove the comment?
>
>Thanks
>/Ilias
>>
>> Best regards
>>
>> Heinrich
>>

