Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E972C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 12:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A248288516;
	Mon, 10 Jun 2024 14:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="V7marI8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A141788532; Mon, 10 Jun 2024 14:54:37 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F115884FD
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 14:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718024054; x=1718628854; i=xypron.glpk@gmx.de;
 bh=TY2VMIrMCZHWux1DCfEOMwj+AZC5BCT2A8os0WMmWqM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=V7marI8y/rkT4Y1VwBcn0Rm7XXHG1iD2KH858dYDIguC+2XuVbv5XFuc6f+Z20s2
 sMOHagr803Fd0oHAQvJtFEuUqiCgJpspPF/IRECVj27mLxpqFzncG4EZLXhCZL2nf
 GZ+p8QWAyTfX8ZH9RjicFkHMDfHVhUXQ8STobAXHl8/ZRdwwNoLNnONFh9TZd0Ph5
 QEViA041gY9x4l60osyrjb8NcpRZzthe7TsumFRp85/IFs3Z9XbCI3aLqsc//5m/E
 mqLIYORBmiX+xLMV8o5ekL2Zznru3xOMol5f97i5q6NDPjBEKbwINVOkCocqAn7qG
 pPdxkMIEmgJzwboR6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.176.212]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1rwk3y22xs-00JVtH; Mon, 10
 Jun 2024 14:54:14 +0200
Message-ID: <79cb4931-469f-4065-b791-f1ba4398dfd0@gmx.de>
Date: Mon, 10 Jun 2024 14:54:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/31] lmb: allow for resizing lmb regions
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-10-sughosh.ganu@linaro.org>
 <CAC_iWjJARprGkjPQV4nVGKPWxBL+3iiSAuKcdqUNvn+hKV40XQ@mail.gmail.com>
 <CADg8p95O5FMyyLV3yZkRshrOB4nbKa4VdQwMxrSf4bB9z4e8Yg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADg8p95O5FMyyLV3yZkRshrOB4nbKa4VdQwMxrSf4bB9z4e8Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dj+vt2h6cB7C4duc8u90T00Ck7/+mAYvs0akqCh2nB6pXbrzvOd
 HQvLWrPBv/j4fisJLfcPV2Lllihxv0iLtnrA+F1MJ8mLXYwRSUugroUuOtgUfcGmP6XN4WQ
 7bquB0gr/RBkHxJpTBhcWQ+xvI4oFJEaAyRJkCmBK7x8qguDTa33Ff4L8He8sPbgWJ4099+
 g/UwYotCLoEEdKQRMVTsw==
UI-OutboundReport: notjunk:1;M01:P0:a9Gg5TJ8nhg=;7ybjafJCcy6TIwl92JfCVNRyeEU
 UhcpRl36aFHBpcIvUTOpYNp1HqO03iXApJivvObl8JMFs1DzLXxET0AsxvKs12BIc3VZcp6/3
 KQd3r05TyfUmUtS9Kne0s4J0IDwBIIjb4Dr5evXxDc9hxjCSvBxDH479TYetE//FHMLGpFMrk
 LTMNqrzZrdEqD7wf7fKOX65n2yaBhfzs2EJZs306ajqDoM78Eh52uzl1yi7eW3WY97MUXE7FT
 Ys6Vv2UjXEwAAkm3D1PpHv3+3YXLvzeo10Y1+SX+vNuuacwyGYf/0BwtP8gDl6uOd2rSCH8Bm
 2xnrvuj5iUwKfMAViHpjc/K4NH4XnVHo2OD+Bsurem8NgJ7hjxcEPxixcpaStPFS4iRkmnwhB
 AA+bsNk30z+wja5vxY+9GJNPUq4TFxRlkUKHxAROzOyUunoxCeLZ+Mt5HGZVCUj8NXlBi804q
 4COe+4ya0ZkRDZJAtjY8D2nA9u+iB7j50OslwpqWouiXUzKq+0OtebK227x/rKI/0x3B6YgOq
 xlOV/ankAqnun/qYGTTtcdGWgFk6TiYrDklB+b/yiIS4+6mbcWBPhfJjJPQjobfHd/n20nl0W
 n9qd7hjR4kPEYGWDgl1yfSt8LXz5DFA2YqfRM/B7Nwmx4Tl6xja4QOUSYpopkMvo7WoUPPqem
 BEkqe5//5x4/bWylSn5NkhMqXK39A2veOB/w+2O05odnJKFxcapzCnxPy0T6ggayEJEB3y41y
 w5n5Cbqrc1QAUYhaPIJKk+KRx7VRwfm8E19KNPRRYGVjJ7Upw+BWRoFsusbgL6QoYgPd3h8aw
 bQpqdbSWXmmEr8pTO70ptlGKHUWNpDz83A2rPR+WCYgZo=
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

On 10.06.24 14:20, Sughosh Ganu wrote:
> hi Ilias,
>
> On Mon, 10 Jun 2024 at 17:34, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Sughosh
>>
>>
>> On Fri, 7 Jun 2024 at 21:54, Sughosh Ganu <sughosh.ganu@linaro.org> wro=
te:
>>>
>>> Allow for resizing of LMB regions if the region attributes match. The
>>> current code returns a failure status on detecting an overlapping
>>> address. This worked up until now since the LMB calls were not
>>> persistent and global -- the LMB memory map was specific and private
>>> to a given caller of the LMB API's.
>>>
>>> With the change in the LMB code to make the LMB reservations
>>> persistent, there needs to be a check on whether the memory region can
>>> be resized, and then do it if so. To distinguish between memory that
>>> cannot be resized, add a new flag, LMB_NOOVERWRITE. Reserving a region
>>> of memory with this attribute would indicate that the region cannot be
>>> resized.
>>
>> Can you think of a memory region that needs to be protected from resizi=
ng?
>
> Actually, I think I could use a better term instead of 'resize'. The
> aim of this patch is to allow re-allocation/re-reservation of the same
> region of memory -- this will only be relevant for the LMB
> reservations, as these are used for loading images into memory. All
> other allocations(EFI currently) are true allocations in that these
> should not get overwritten at all. Memory once allocated, say for
> loading an EFI image, cannot be re-requested.
>
>
>> I think we should design this a bit differently.  For example, think
>> of someone loading a file in a memory region and then a subsystem
>> trying to resize its reserved memory overwriting that region. Instead
>> of this flag why don't we add
>> - A flag that indicates whether this region can be re-used (IOW
>> overwrites it), but only if the 'subsytem id' defined below matches
>> - a u32 that indicates the subsystem ID that initiated the transaction
>> -- e.g EFI, load command, U-Boot core .. etc
>>
>> Resizing can be enabled unconditionally in that case as long as there
>> is enough space. The only requirement would be that the request comes
>> from the same subsystem that reserved the memory in the beginning
>
> Like I mentioned above, resizing(or rather re-allocations) should only
> be allowed for the LMB subsystem. Any other module should not be
> returned an already allocated address. Which is why I mark any memory
> map update coming from the EFI module as no-overwrite.
>
> -sughosh
>>
>> Thanks
>> /Ilias
>>
>>>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> ---
>>>   include/lmb.h |   1 +
>>>   lib/lmb.c     | 120 ++++++++++++++++++++++++++++++++++++++++++++----=
--
>>>   2 files changed, 107 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/include/lmb.h b/include/lmb.h
>>> index 03bce2a50c..1d4cd255d2 100644
>>> --- a/include/lmb.h
>>> +++ b/include/lmb.h
>>> @@ -20,6 +20,7 @@
>>>   enum lmb_flags {
>>>          LMB_NONE                =3D 0x0,
>>>          LMB_NOMAP               =3D 0x4,
>>> +       LMB_NOOVERWRITE         =3D 0x8,
>>>   };
>>>
>>>   /**
>>> diff --git a/lib/lmb.c b/lib/lmb.c
>>> index de5a2cf23b..0a4f3d5bcd 100644
>>> --- a/lib/lmb.c
>>> +++ b/lib/lmb.c
>>> @@ -260,12 +260,88 @@ void lmb_add_memory(struct bd_info *bd)
>>>          }
>>>   }
>>>
>>> +static bool lmb_region_flags_match(struct lmb_region *rgn, unsigned l=
ong r1,
>>> +                                  enum lmb_flags flags)
>>> +{
>>> +       return rgn->region[r1].flags =3D=3D flags;
>>> +}
>>> +
>>> +static long lmb_merge_overlap_regions(struct lmb_region *rgn, unsigne=
d long i,
>>> +                                     phys_addr_t base, phys_size_t si=
ze,
>>> +                                     enum lmb_flags flags)
>>> +{
>>> +       phys_size_t rgnsize;
>>> +       unsigned long rgn_cnt, idx;
>>> +       phys_addr_t rgnbase, rgnend;
>>> +       phys_addr_t mergebase, mergeend;
>>> +
>>> +       rgn_cnt =3D 0;
>>> +       idx =3D i;
>>> +       /*
>>> +        * First thing to do is to identify how many regions does
>>> +        * the requested region overlap.
>>> +        * If the flags match, combine all these overlapping
>>> +        * regions into a single region, and remove the merged
>>> +        * regions.
>>> +        */
>>> +       while (idx < rgn->cnt - 1) {
>>> +               rgnbase =3D rgn->region[idx].base;
>>> +               rgnsize =3D rgn->region[idx].size;

It would be preferable to replace fixed size arrays by linked lists.
This will allow us to eliminate CONFIG_LMB_MAX_REGIONS.

EFI may create any number of non-coalescable memory regions.

Best regards

Heinrich

>>> +
>>> +               if (lmb_addrs_overlap(base, size, rgnbase,
>>> +                                     rgnsize)) {
>>> +                       if (!lmb_region_flags_match(rgn, idx, flags))
>>> +                               return -1;
>>> +                       rgn_cnt++;
>>> +                       idx++;
>>> +               }
>>> +       }
>>> +
>>> +       /* The merged region's base and size */
>>> +       rgnbase =3D rgn->region[i].base;
>>> +       mergebase =3D min(base, rgnbase);
>>> +       rgnend =3D rgn->region[idx].base + rgn->region[idx].size;
>>> +       mergeend =3D max(rgnend, (base + size));
>>> +
>>> +       rgn->region[i].base =3D mergebase;
>>> +       rgn->region[i].size =3D mergeend - mergebase;
>>> +
>>> +       /* Now remove the merged regions */
>>> +       while (--rgn_cnt)
>>> +               lmb_remove_region(rgn, i + 1);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static long lmb_resize_regions(struct lmb_region *rgn, unsigned long =
i,
>>> +                              phys_addr_t base, phys_size_t size,
>>> +                              enum lmb_flags flags)
>>> +{
>>> +       long ret =3D 0;
>>> +       phys_addr_t rgnend;
>>> +
>>> +       if (i =3D=3D rgn->cnt - 1 ||
>>> +               base + size < rgn->region[i + 1].base) {
>>> +               if (!lmb_region_flags_match(rgn, i, flags))
>>> +                       return -1;
>>> +
>>> +               rgnend =3D rgn->region[i].base + rgn->region[i].size;
>>> +               rgn->region[i].base =3D min(base, rgn->region[i].base)=
;
>>> +               rgnend =3D max(base + size, rgnend);
>>> +               rgn->region[i].size =3D rgnend - rgn->region[i].base;
>>> +       } else {
>>> +               ret =3D lmb_merge_overlap_regions(rgn, i, base, size, =
flags);
>>> +       }
>>> +
>>> +       return ret;
>>> +}
>>> +
>>>   /* This routine called with relocation disabled. */
>>>   static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t=
 base,
>>>                                   phys_size_t size, enum lmb_flags fla=
gs)
>>>   {
>>>          unsigned long coalesced =3D 0;
>>> -       long adjacent, i;
>>> +       long ret, i;
>>>
>>>          if (rgn->cnt =3D=3D 0) {
>>>                  rgn->region[0].base =3D base;
>>> @@ -290,23 +366,32 @@ static long lmb_add_region_flags(struct lmb_regi=
on *rgn, phys_addr_t base,
>>>                                  return -1; /* regions with new flags =
*/
>>>                  }
>>>
>>> -               adjacent =3D lmb_addrs_adjacent(base, size, rgnbase, r=
gnsize);
>>> -               if (adjacent > 0) {
>>> +               ret =3D lmb_addrs_adjacent(base, size, rgnbase, rgnsiz=
e);
>>> +               if (ret > 0) {
>>>                          if (flags !=3D rgnflags)
>>>                                  break;
>>>                          rgn->region[i].base -=3D size;
>>>                          rgn->region[i].size +=3D size;
>>>                          coalesced++;
>>>                          break;
>>> -               } else if (adjacent < 0) {
>>> +               } else if (ret < 0) {
>>>                          if (flags !=3D rgnflags)
>>>                                  break;
>>>                          rgn->region[i].size +=3D size;
>>>                          coalesced++;
>>>                          break;
>>>                  } else if (lmb_addrs_overlap(base, size, rgnbase, rgn=
size)) {
>>> -                       /* regions overlap */
>>> -                       return -1;
>>> +                       if (flags =3D=3D LMB_NONE) {
>>> +                               ret =3D lmb_resize_regions(rgn, i, bas=
e, size,
>>> +                                                        flags);
>>> +                               if (ret < 0)
>>> +                                       return -1;
>>> +
>>> +                               coalesced++;
>>> +                               break;
>>> +                       } else {
>>> +                               return -1;
>>> +                       }
>>>                  }
>>>          }
>>>
>>> @@ -448,7 +533,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr=
, phys_size_t size)
>>>   }
>>>
>>>   static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
>>> -                                   phys_addr_t max_addr)
>>> +                                   phys_addr_t max_addr, enum lmb_fla=
gs flags)
>>>   {
>>>          long i, rgn;
>>>          phys_addr_t base =3D 0;
>>> @@ -498,7 +583,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong=
 align, phys_addr_t max_addr)
>>>   {
>>>          phys_addr_t alloc;
>>>
>>> -       alloc =3D __lmb_alloc_base(size, align, max_addr);
>>> +       alloc =3D __lmb_alloc_base(size, align, max_addr, LMB_NONE);
>>>
>>>          if (alloc =3D=3D 0)
>>>                  printf("ERROR: Failed to allocate 0x%lx bytes below 0=
x%lx.\n",
>>> @@ -507,11 +592,8 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulon=
g align, phys_addr_t max_addr)
>>>          return alloc;
>>>   }
>>>
>>> -/*
>>> - * Try to allocate a specific address range: must be in defined memor=
y but not
>>> - * reserved
>>> - */
>>> -phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
>>> +static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t siz=
e,
>>> +                                   enum lmb_flags flags)
>>>   {
>>>          long rgn;
>>>
>>> @@ -526,13 +608,23 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phy=
s_size_t size)
>>>                                        lmb.memory.region[rgn].size,
>>>                                        base + size - 1, 1)) {
>>>                          /* ok, reserve the memory */
>>> -                       if (lmb_reserve(base, size) >=3D 0)
>>> +                       if (lmb_reserve_flags(base, size, flags) >=3D =
0)
>>>                                  return base;
>>>                  }
>>>          }
>>> +
>>>          return 0;
>>>   }
>>>
>>> +/*
>>> + * Try to allocate a specific address range: must be in defined memor=
y but not
>>> + * reserved
>>> + */
>>> +phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
>>> +{
>>> +       return __lmb_alloc_addr(base, size, LMB_NONE);
>>> +}
>>> +
>>>   /* Return number of bytes from a given address that are free */
>>>   phys_size_t lmb_get_free_size(phys_addr_t addr)
>>>   {
>>> --
>>> 2.34.1
>>>

