Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41353C3DA6E
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 01:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A1E87692;
	Tue, 26 Dec 2023 02:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="r7sBBgjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0A0877CB; Tue, 26 Dec 2023 02:43:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EF0287687
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 02:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703554991; x=1704159791; i=xypron.glpk@gmx.de;
 bh=Ba++M7tHmWAUDx79S6Wc5sENJRuLtWip2LuLLG40ECc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=r7sBBgjw54jxLynaCPzHPx32HXqXFl1HlVrSR8BQr542z+moB1hTAbdrqV+raOoR
 S/wkIfJOkIxMtaF/kuKp+9X/lS0SqrfZs/p8JZecq5/c7/m2iTY/yXV1HDo6VEqpS
 kQvYthl/D5riGeKi1EgCIhJxVp8Zgf+P+3VUkPjU2PqwaufmJ8vox+dCs+UAEzeue
 qULImYzQStGi0aeg7gbaGSZsW00CVhCQHo0z2Fj8Z8bG6p30fEmHhnOY0hvMY5zb/
 6XbyLPcEYgNmyEq8zNGa+Idw3OuK08cEsN37vB1K24NSFvc8fncEXtgCHsxt2SnKS
 +H4kS1zLvULufm3Eog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCbB-1rn48t3rVp-00V8n7; Tue, 26
 Dec 2023 02:43:11 +0100
Date: Tue, 26 Dec 2023 02:43:09 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/3=5D_efi=5Floader=3A_avoid_pointe?=
 =?US-ASCII?Q?r_access_after_calling_efi=5Fdelete=5Fhandle?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CADQ0-X-LuZGHRGR=MkXEHaHg4p3ToBU2CbxkP9Phyw8sGCrBtw@mail.gmail.com>
References: <20231225044356.626900-1-masahisa.kojima@linaro.org>
 <20231225044356.626900-3-masahisa.kojima@linaro.org>
 <585c8dd4-2fc9-44ff-b71b-ca1ad384c223@gmx.de>
 <CADQ0-X-LuZGHRGR=MkXEHaHg4p3ToBU2CbxkP9Phyw8sGCrBtw@mail.gmail.com>
Message-ID: <4C5AB456-685F-4912-9528-298C2080F122@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3NJ8+jLhcKDb4mQN7bTgsJH2Wfobam1qPaN6/ca/ZzFhrDXmtsq
 TrRh5RaUbm2jjLtCfl8dLFToMuPhaoiodz7qZpUSu6k7GkPhjEEZbTI3gDaWLKuJqCV635e
 VKKGR5v3UqEiBAlBXEJ/sUbi0GTcwoia88gAyPfNrjOprdv2M8W6jWQqbrvaFdXkdRdAjUg
 cGwaC6t6Nf47cXWsmIofg==
UI-OutboundReport: notjunk:1;M01:P0:rE3E98Q5+dc=;YDmTVR9PBB/Zl4Cg37pU6n0e/5z
 hjynP5ZqpnoptTCtrDEtc81/CtCKiN8jVMhT73j2h1DYJ2PY/puPn5yWZ3Q/4kdpRXRSGDmRk
 1v9JuKlUnOaiVgIlb864P9jXBJSrVZbNUBrPqvKwBLPnUBZkq+6I3UoOma8Ys+lncoK5mECcV
 rBZV9NCP3bi/o2c+xyoV6Z8G59/Pe4z4JO3PmLB/3BkV8H7OOCUlc5pYrSGJQLdGxXm7Ii4DY
 CAoR53cnE8f7/gceJ03GOP7ZkO4duT48z5cg37gUwuviIdrvKUBBefdKGTk3L0s0eSa3iUFjP
 v2JAPNYdWE7R+MFdtNYrA/c2D8+zntxDKYz8jcRGHgCU1sdyEbLkPvLFnlziCR5b330OTpfF+
 8g1DFq4YTmmlqmQDWjUzjlXuUwCte+AI09u5Qg+avhwzqNaZdL1cleEtvbEbhCNK/NBvA3hAh
 wkWCsWDedWzw4q1MEnrbV3fE1LY/jHmFBZQ4oPLeyaAfkCB3dbPcjQ3eC9yF4a3fXOZ3WY35v
 WWdH7wdcHo2c5KSk2eYAhHqJjFflYtwDaqB3Luk+c+N4OsPRYHpRWSvfxsWMwA7EtRqUpczZ8
 +9k2GbJ17y3/3EB9DLyGNSRgJ3C64MO8miFP8T0lBD+aPIX0Vv3+ZQ0RFewhhardp2+1q0XoK
 KeycE5gZUTTCqJsiGWlkT9XeiiDqkC5UF3t3Hv2JeYL6KCMpVFFhmChCn0aqYpy5Y0KT8d03t
 0vkRxKSJj6nfCdNeTclk2SEcmmhg0tf/Uzp7UiN6GJeP5086xwxsyRkPpPNDoGP+wSyQEThmi
 qu/1HVCa57OJonczdAHCKpfA5yK9VDubRQKDcuK7H7G2RJNiup8OqSKG/ZPUJNuK7b2aFCQ7h
 jDszBn4ai+hmRUGuhejnQhevBtMZjHQLkX8N7xn7HnpEoKD+1gPhDpfOXR7gb4ZPDo3aY0HF5
 D3OghofLeF6A+yVa74hVmV1ybiw=
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



Am 26=2E Dezember 2023 02:13:08 MEZ schrieb Masahisa Kojima <masahisa=2Eko=
jima@linaro=2Eorg>:
>Hi Heinrich,
>
>On Mon, 25 Dec 2023 at 19:05, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>> On 12/25/23 05:43, Masahisa Kojima wrote:
>> > efi_delete_handle() calls efi_purge_handle(), then it finally
>> > frees the efi handle=2E
>> > Both diskobj and handle variables in efi_disk_remove() have
>> > the same pointer, we can not access diskobj->dp after calling
>> > efi_delete_handle()=2E
>> >
>> > This commit saves the struct efi_device_path pointer before
>> > calling efi_delete_handle()=2E This commit also fixes the
>> > missing free for volume member in struct efi_disk_obj=2E
>> >
>> > Signed-off-by: Masahisa Kojima <masahisa=2Ekojima@linaro=2Eorg>
>> > ---
>> >   lib/efi_loader/efi_disk=2Ec | 12 +++++++++---
>> >   1 file changed, 9 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/lib/efi_loader/efi_disk=2Ec b/lib/efi_loader/efi_disk=2E=
c
>> > index a2f8b531a3=2E=2E415d8601ba 100644
>> > --- a/lib/efi_loader/efi_disk=2Ec
>> > +++ b/lib/efi_loader/efi_disk=2Ec
>> > @@ -701,7 +701,9 @@ int efi_disk_remove(void *ctx, struct event *even=
t)
>> >       struct udevice *dev =3D event->data=2Edm=2Edev;
>> >       efi_handle_t handle;
>> >       struct blk_desc *desc;
>> > +     struct efi_device_path *dp =3D NULL;
>> >       struct efi_disk_obj *diskobj =3D NULL;
>> > +     struct efi_simple_file_system_protocol *volume =3D NULL;
>> >       efi_status_t ret;
>> >
>> >       if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
>> > @@ -722,14 +724,18 @@ int efi_disk_remove(void *ctx, struct event *ev=
ent)
>> >               return 0;
>> >       }
>> >
>> > +     if (diskobj) {
>>
>>
>>    diskobj =3D container_of(handle, struct efi_disk_obj, header);
>>
>> can be replaced by
>>
>>    diskobj =3D handle
>>
>> We should check the handle immediately after dev_tag_get_ptr() and
>> return 0 if the handle =3D=3D NULL=2E
>
>OK, I will try to improve the efi_disk_remove() function=2E
>
>>
>> > +             dp =3D diskobj->dp;
>> > +             volume =3D diskobj->volume;
>> > +     }
>> > +
>> >       ret =3D efi_delete_handle(handle);
>>
>> We must not delete the handle in case of UCLASS_EFI_LOADER=2E
>>
>> Instead of calling efi_delete_handle we should uninstall all protocols
>> that we have installed=2E If no protocol is left the handle will go awa=
y=2E
>>
>> To make the protocols to delete tractable they should be opened with
>> BY_DRIVER=2E
>
>efi_delete_handle() calls efi_remove_all_protocols(), and frees the efi h=
andle
>if no protocol is left on the handle=2E
>So I think efi_delete_handle() does all the required processes mentioned =
above=2E

Given an EFI application like iPXE that provides a handle with the block I=
O protocol implemented by the application: Why should U-Boot remove the blo=
ck IO protocol or the device path protocol when the application calls Disco=
nnectController()?

Best regards

Heinrich

>
>>
>> When a partition is removed we must close the protocol interfaces opene=
d
>> with EFI_OPEN_PROTOCOL_BY_CHILD_CONTROLLER (cf=2E efi_disk_add_dev())=
=2E
>
>OK, I will fix this=2E
>
>Thanks,
>Masahisa Kojima
>
>>
>> Best regards
>>
>> Heinrich
>>
>> >       /* Do not delete DM device if there are still EFI drivers attac=
hed=2E */
>> >       if (ret !=3D EFI_SUCCESS)
>> >               return -1;
>> >
>> > -     if (diskobj)
>> > -             efi_free_pool(diskobj->dp);
>> > -
>> > +     efi_free_pool(dp);
>> > +     free(volume);
>> >       dev_tag_del(dev, DM_TAG_EFI);
>> >
>> >       return 0;
>>
