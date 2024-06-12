Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC35C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 06:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EDD88870E;
	Wed, 12 Jun 2024 08:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RsV7qkUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC9E38870E; Wed, 12 Jun 2024 08:06:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B25880AD
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 08:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718172377; x=1718777177; i=xypron.glpk@gmx.de;
 bh=Wfm/T3qfCaAEjKuwXW1kGqn4tCEwJ1QJpW4NWv2GyF0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RsV7qkUJ/+eJ7dCxV/McYuWcMoG3sf93inuj5OocAxx0SQOHX1x7wTMVJtXVJeOQ
 BZbpW4eTPpFT8ZqBTwAAgz5tUn++9Gxe6jwFue/gJmZGKfh9swkkaHBn5CNCs7O1U
 VbbuRX/uiRe05oeLVzt04civNSACS8hQwtvPM2o31iBB4vW3HVTurLpng5oS0Xbkf
 DeBJ2UhCoPZKLO2UHQdtxrbdopEfT2rBmvMjSzRleshyqpVsqkHekO3It1EhYbj9p
 9A78tij6AKGnvgTx4h8HsVoE8KSxjWYVRPUgvcEwlgx8en4eErHFfbWqlfZmLkMWP
 uwxN+SOihDCwgJnvMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([109.42.176.212]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1poA-1sF4CH1x8q-0044q1; Wed, 12
 Jun 2024 08:06:17 +0200
Date: Wed, 12 Jun 2024 08:06:15 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_15/31=5D_efi=5Fmemory=3A_add?=
 =?US-ASCII?Q?_an_event_handler_to_update_memory_map?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTjm_k6DLCZcMCevf78-K7MsiqWGq5ONxowDVMpRe_XB7g@mail.gmail.com>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <50d0efab-0df6-47ef-a4e9-b0e3d6ec2556@gmx.de>
 <20240611143635.GF68077@bill-the-cat>
 <CAFLszTiEWw0tey4zeqjPYe2TsSWH1P4Xakn8OrOKSwqDU+EM_A@mail.gmail.com>
 <20240611210138.GL68077@bill-the-cat>
 <CAFLszThcanoRd=8A8wq0RWzSHerPPZxYdvyT8AjLNfH1QvyDiw@mail.gmail.com>
 <20240611225417.GN68077@bill-the-cat>
 <CAFLszTjm_k6DLCZcMCevf78-K7MsiqWGq5ONxowDVMpRe_XB7g@mail.gmail.com>
Message-ID: <22A3B5E5-69E7-4FC3-94FB-293B538D8E47@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ctkjQWtNrGEdG2Ia8BVOHa3A++1stNEL9Y5tgEQyDcQsWj93a1E
 Nd5lz68gIsYB3iHAanuxlZt9YLFWXdTfZs3TE2OaowjgyJ1AyUT2YSAWb/CEXz/AVhKaqIU
 0DX55SAZwmSpJzck0ZE0LEOe+2KID5MyLJWPsfim5r/zaxYplBbv/5B/Ux/DtNTxuN6N4BW
 Jl/z4cH+guD0DrzqS7Znw==
UI-OutboundReport: notjunk:1;M01:P0:0QbQz/kU0sA=;4X2uZTAlXS+yLaPW68+Se4f7j8k
 EhOK2ipmQEDW9j6znTQwOz6fUkTEkZQMWxEPzxxobhEAQg/KfgGwtYbvJp97NTC99Br5kT2gk
 cudRPrIJXlVyPRHXSFU6CNmg1v4OkuNTYslC+n4hjF2t8w2hxFgAS5yogwRRjyd9iWa/y1hBR
 UIDDZLGVWAzVOZJOadl4/4BOyCqGzAuBQb7HUekPFQubDJKpIHABWxzIrfi4yrDUIKtsv+LAv
 uPwm8/1kNQRtMNG1erWTH+vww0/xGN6tkOd4G+CFag+h4eYO0G9aR6oLTz/lztReM1QjdH5pa
 PWuWNHvsmk+5MtZ6q8VAruxbLcyoAkQtCdGwH7JT8PXy/egBpsOjoRujypb/ViuTxfHgSmMV2
 xgUeFr82h9jHbHlyudq+AX/NJYu5qKKuj1vem54s5ZwD8x/0bbEXJdCTDEAkkBeXUHc8orbXv
 ue7ojpDN6cvVpxrYQGIoFyvtKW+mHysMmEKvdv1aR0sc9fauQz2mJN3BnhIawlJ1hRPPp87d+
 EEaByM2YtfkxAZPP+vsx4+12WtTy5imB4w8vJMlNDMdXiK56OZEahNtULEMGmSzW04Sv+nVEU
 B/15E1bGigu/SK5qzBTp6K0S8MokE3rzE05tSIKZnO2dqKFjNPEVUUxMa/G+Jq6MGeyKgYmo2
 Nocl82+fr/qVUKqoUEd/uE6sDj3AUVnfIkQHa3MCGC8wVcKYXCbSAnF9HOIbzQYPinhlWXR09
 h8ssf7IfdGsDR6d54br02iKVePpWzBM3Rx3uRj4C6tFvYzSLIKSpDOlWmOykQbjlNL8jT+R4l
 8/WE0yjVbl6Eiqkjj3nWS5cyr4eIk8yf05qVRxeoseX5M=
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



Am 12=2E Juni 2024 04:42:00 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Hi Tom,
>
>On Tue, 11 Jun 2024 at 16:54, Tom Rini <trini@konsulko=2Ecom> wrote:
>>
>> On Tue, Jun 11, 2024 at 04:22:25PM -0600, Simon Glass wrote:
>> > Hi Tom,
>> >
>> > On Tue, 11 Jun 2024 at 15:01, Tom Rini <trini@konsulko=2Ecom> wrote:
>> > >
>> > > On Tue, Jun 11, 2024 at 12:52:19PM -0600, Simon Glass wrote:
>> > > > Hi,
>> > > >
>> > > > On Tue, 11 Jun 2024 at 08:36, Tom Rini <trini@konsulko=2Ecom> wro=
te:
>> > > > >
>> > > > > On Tue, Jun 11, 2024 at 12:17:16PM +0200, Heinrich Schuchardt w=
rote:
>> > > > > > On 07=2E06=2E24 20:52, Sughosh Ganu wrote:
>> > > > > > > There are events that would be used to notify other interes=
ted modules
>> > > > > > > of any changes in available and occupied memory=2E This wou=
ld happen
>> > > > > > > when a module allocates or reserves memory, or frees up mem=
ory=2E These
>> > > > > > > changes in memory map should be notified to other intereste=
d modules
>> > > > > > > so that the allocated memory does not get overwritten=2E Ad=
d an event
>> > > > > > > handler in the EFI memory module to update the EFI memory m=
ap
>> > > > > > > accordingly when such changes happen=2E As a consequence, a=
ny subsequent
>> > > > > > > memory request would honour the updated memory map and only=
 available
>> > > > > > > memory would be allocated from=2E
>> > > > > > >
>> > > > > > > Signed-off-by: Sughosh Ganu <sughosh=2Eganu@linaro=2Eorg>
>> > > > > > > ---
>> > > > > > >   lib/efi_loader/efi_memory=2Ec | 70 ++++++++++++++++++++++=
++++++++-------
>> > > > > > >   1 file changed, 58 insertions(+), 12 deletions(-)
>> > > > > > >
>> > > > > > > diff --git a/lib/efi_loader/efi_memory=2Ec b/lib/efi_loader=
/efi_memory=2Ec
>> > > > > > > index 435e580fb3=2E=2E93244161b0 100644
>> > > > > > > --- a/lib/efi_loader/efi_memory=2Ec
>> > > > > > > +++ b/lib/efi_loader/efi_memory=2Ec
>> > > > > > > @@ -73,6 +73,10 @@ struct efi_pool_allocation {
>> > > > > > >   #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
>> > > > > > >   extern bool is_addr_in_ram(uintptr_t addr);
>> > > > > > >
>> > > > > > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64=
 pages,
>> > > > > > > +                                       int memory_type,
>> > > > > > > +                                       bool overlap_only_r=
am);
>> > > > > > > +
>> > > > > > >   static void efi_map_update_notify(u64 addr, u64 size, u8 =
op)
>> > > > > > >   {
>> > > > > > >     struct event_efi_mem_map_update efi_map =3D {0};
>> > > > > > > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 ad=
dr, u64 size, u8 op)
>> > > > > > >     if (is_addr_in_ram((uintptr_t)addr))
>> > > > > > >             event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, =
sizeof(efi_map));
>> > > > > > >   }
>> > > > > > > +
>> > > > > > > +static int lmb_mem_map_update_sync(void *ctx, struct event=
 *event)
>> > > > > > > +{
>> > > > > > > +   u8 op;
>> > > > > > > +   u64 addr;
>> > > > > > > +   u64 pages;
>> > > > > > > +   efi_status_t status;
>> > > > > > > +   struct event_lmb_map_update *lmb_map =3D &event->data=
=2Elmb_map;
>> > > > > > > +
>> > > > > > > +   addr =3D (uintptr_t)map_sysmem(lmb_map->base, 0);
>> > > > > > > +   pages =3D efi_size_in_pages(lmb_map->size + (addr & EFI=
_PAGE_MASK));
>> > > > > > > +   op =3D lmb_map->op;
>> > > > > > > +   addr &=3D ~EFI_PAGE_MASK;
>> > > > > > > +
>> > > > > > > +   if (op !=3D MAP_OP_RESERVE && op !=3D MAP_OP_FREE) {
>> > > > > > > +           log_debug("Invalid map update op received (%d)\=
n", op);
>> > > > > > > +           return -1;
>> > > > > > > +   }
>> > > > > > > +
>> > > > > > > +   status =3D __efi_add_memory_map_pg(addr, pages,
>> > > > > > > +                                    op =3D=3D MAP_OP_FREE =
?
>> > > > > > > +                                    EFI_CONVENTIONAL_MEMOR=
Y :
>> > > > > >
>> > > > > > This is dangerous=2E LMB might turn memory that is marked as
>> > > > > > EfiReservedMemory which the OS must respect into EfiBootServi=
cesData
>> > > > > > which the OS may discard=2E
>> > > > > >
>> > > > > > E=2Eg=2E initr_lmb() is being called after efi_memory_init()=
=2E
>> > > > > >
>> > > > > > Getting all cases of synchronization properly tested seems ve=
ry hard to
>> > > > > > me=2E Everything would be much easier if we had only a single=
 memory
>> > > > > > management system=2E
>> > > > >
>> > > > > Yes, Sughosh is working on the single memory reservation system=
 for
>> > > > > everyone to use=2E This pairs with the single memory allocation=
 system
>> > > > > (malloc) that we have=2E Parts of the code base that aren't kee=
ping these
>> > > > > systems up to date / obeying their results need to be corrected=
=2E
>> > > >
>> > > > The EFI allocations don't happen until boot time=2E=2E=2Eso why d=
o we need
>> > > > to do this now? We can instead have an EFI function to scan LMB a=
nd
>> > > > add to its memory map=2E
>> > >
>> > > We're talking about reservations, not allocations=2E So yes, when s=
omeone
>> > > is making their reservation, they need to make it=2E I don't unders=
tand
>> > > your question=2E
>> >
>> > As I understand it, this is used to tell EFI about a memory reservati=
on=2E
>>
>> This patch, or this series? This series isn't about EFI=2E This patch i=
s,
>> yes=2E
>>
>> > But the EFI code can scan the LMB reservations just before booting an=
d
>> > update its tables=2E I don't see a need to keep them in sync before t=
he
>> > boot actually happens=2E
>>
>> But that wouldn't work=2E If something needs to reserve a region it nee=
ds
>> to do it when it starts using it=2E It's not about the EFI map for the =
OS,
>> it's about making sure that U-Boot doesn't scribble over a now-reserved
>> area=2E
>
>I'm not convinced of that yet=2E EFI does not do allocations until it
>starts loading images, and it uses LMB for those (or at least it does
>with bootstd)=2E I'm just trying to keep this all as simple as possible=
=2E

You can load a boot time EFI driver which keeps running while you return t=
o U-Boot to load another file=2E

The background activity of the EFI driver binary can result in any number =
of allocations=2E

Best regards

Heinrich


>
>Regards,
>Simon
