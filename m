Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64084CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 23:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F2784659;
	Tue, 12 May 2026 01:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JZnuxzCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91A98465A; Tue, 12 May 2026 01:17:11 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1A72845E3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 01:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrigMJ0DXDdypNGFgq65IXkl9ha4P7ocCt/vSScV63vq3xY8KzRUNyUwHjEUY1o2r0r7ZTHVujuejsdi6zVc6ShYkqzKPYcUS/KW29QJFR1burhhqlaOkMfLVyGPtmZlsi5I8iE7AYw2Pb/WV1l+IorYUy9RnUzLgJYfImhCl2QrRP64/DCLa+d9bW3o2eVwbrXFkAmwTEPkh18VIs/CE2mYReXeNQbFjHDx9+P05qyvV+gr2tvg6FaAPrtg2dEHcz0LBRDKES+YjR32phPcpDr0QzoA/xg0HbWtUOpcJrFnfCJMISwU2TWMIt7npj+2c04cbVir8m1ZyR4s90xwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlzCt88L79HdAR6OeE4lFtqnnQAr2ysmYcBRgTrmyA4=;
 b=u0fICYxmnntZknIpt6xVXP6okuTVtuslXfRW5zrYXBxl7UxJNUlSzCaVmg2TpXo19gTPRcWvxJFs+gO2/OBpYpqXH6B37xeJ1enCa5NnO8Uf4LY4hT191jrnfwgNv2gO1CZ/czrh5e7BAWXmVgMWthxxqrU/8lyd0aXMrW7wNZeQ81Pi/PKLOP51S/WR79vaU8V+Ua7G4aDkV/o7z49fT5qPzzWWznIlgFL9SGbq42NqOSd/4fNtSXYSbqBo/llbhXW8zgIfwvr+Pg3MrkxiqK4gIyhFYc3iFbyRHCZb4Hz/q3xbFMu5SQ4s1osNn/N4qnn+boR83abxpN++CxJj7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlzCt88L79HdAR6OeE4lFtqnnQAr2ysmYcBRgTrmyA4=;
 b=JZnuxzCGKawKBjcrbqKj0RwfE10uWzKhgEyVGJmg3R982jVIm6BIoETgCJNRs3jhlOUC0LX1rytSUlsRl/t+Xhjg3mLfaAPdFuiLHSLnYRvaro+QUTLKB6/U0C20XKcivChG/d1YzmWglCsxEcrXeJDqVl3v5vH65b7PrhgWA2I=
Received: from BN9PR03CA0073.namprd03.prod.outlook.com (2603:10b6:408:fc::18)
 by SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 23:17:05 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:fc:cafe::c7) by BN9PR03CA0073.outlook.office365.com
 (2603:10b6:408:fc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 23:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Mon, 11 May 2026 23:17:03 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 18:17:01 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 18:17:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 18:17:00 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64BNH05u563223;
 Mon, 11 May 2026 18:17:00 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 May 2026 18:17:00 -0500
Message-ID: <DIG8BD5KUEKK.1H065W7FQ08DI@ti.com>
To: Simon Glass <sjg@chromium.org>, <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCHv6 2/3] boot_fdt_add_mem_rsv_regions: free old dtb
 reservations
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260508222911.450165-1-rs@ti.com>
 <20260508222911.450165-3-rs@ti.com>
 <CAFLszThwhR=BaySior+Bev7Phi0AEGaR2_ASOVSFr00-cLPKpQ@mail.gmail.com>
In-Reply-To: <CAFLszThwhR=BaySior+Bev7Phi0AEGaR2_ASOVSFr00-cLPKpQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SJ0PR10MB4605:EE_
X-MS-Office365-Filtering-Correlation-Id: 3065087a-9459-466a-fd3f-08deafb3693f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: a+2SnZteSViTxCZfLKj9THpg83Eay6scRGGpQtG7gLPC1scxNhfV0d2S1Um/sdPU1V+Ezm0pWDHAwR9WKGSD4lf81CLn42WtvCoWJVdO31a4Do+hQd5BohyLxXBMIRCr2DA5qIvM+eAgjL6sTOKpqe+H4kyYCJ5B2CItm1148eNWWtp1zcg+6SEyM0p5laJ0f11Qspy8ADy30FG1urqHs0UPyoIUyGJu+IkqIshMNO7rl7M/gwTGD8cLFv91fhrKKEcuu/lK+bH81REZPd4hoE31BRGlv44GC6U2w4X5B8E+5ywGG3S5CUqdUIUyhwBL/w05oxS0DSdXm0Q44RxAMz8ipOKLML754W/fBM1TA5tezesEU9NMhNXCkv4R5uZPnQIIZLAg5zKRG6updwRtB7g1mTADCNANEl8qfJH84lqhzbjh3u13n8tUY9izflnxx6atJ5I+YkSKPe3yURAT+1fuGi/jaTbrMefppjtQHXhbpNIJaSbOJ9vWRsi6V9SFVnwO28oHJnpk1YI/bRj+ZV0TV/0+VgFCuYAdzbl7fQDJVVgO7yVMcWC019n4VydxM7kXJzcR25m3pCxmSrFWnjJykLoBvzo9AOAF2hKt/WmOPwarvwY2RWWOEfEYGqtGxQlK94Ve2KXS6uVpyYiJuyR296QGz/Bm9u2T+uXAvWSrvMUQHIfBhPbEpIQMmbm/HiVhNz9BYFG6XB5X8AMJIG3c1GzaW6+v0XXH2BL3+i0=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yLdgLlhDcBjx7BPzf8KV96Xjj5TJTesR9+8kdz7weDLl+4Jg7sXOrGlg4gHsNNYVNbBESK6tafoDKcUZuoVsJy+Cv+5B7YFiO8FWPCEB0XtxfE420Pnb/z75Ecv0inAYgmMbLm8MOxjLqxwnWYDSuH5e3sp0PbZutOYKXdTKoPzObqjhW/+po3DYMCHgUZhV8rHBHRjflM/fdQvpLaFglXHJvHO0j8JTudwQAeps3xGLNZh2PNcMFGh1eejm9Jc+l1BzoVqYvu4/oRztDZYE6OGAAYpfxboqw6GQ5MpHJpUlsXcniE9xGAE5IMaNMnV0b0s9rRFEuHKKCZVM+tU+dd3xXRb4zgX9TzrKcBy3KpKE1GpzETdb7a0+Zn3C82koedAQ36AYEnkgLfyHwxbD72T0vdS/wFMBXX7/xRuIcUf2b5h1oYNExVSnMlGX0ioX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 23:17:03.1858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3065087a-9459-466a-fd3f-08deafb3693f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4605
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

On Mon May 11, 2026 at 1:27 PM CDT, Simon Glass wrote:
> Hi Randolph,
>
> On 2026-05-08T22:29:09, Randolph Sapp <rs@ti.com> wrote:
>> boot_fdt_add_mem_rsv_regions: free old dtb reservations
>>
>> Add a free flag and an initial call to free allocations covered by the
>> global FDT. This assumes that all calls to boot_fdt_add_mem_rsv_regions
>> occur before the transition to the new device tree, thus we can access
>> the currently active device tree through the global data pointer.
>>
>> This allows us to clearly indicate to the user when a device tree
>> reservation fails. How we handle this can still use some improvement.
>> Right now we'll keep the default behavior and try to boot anyway.
>>
>> This functionality was broken in:
>> 5a6aa7d ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_=
region()")
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> arch/mips/lib/bootm.c |  2 +-
>>  boot/bootm.c          |  2 +-
>>  boot/bootm_os.c       |  2 +-
>>  boot/image-board.c    |  2 +-
>>  boot/image-fdt.c      | 55 +++++++++++++++++++++++++++++++++++---------=
-------
>>  include/image.h       |  2 +-
>>  lib/lmb.c             |  2 +-
>>  7 files changed, 44 insertions(+), 23 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> with some thoughts below
>
>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> @@ -108,12 +124,16 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
>> +     /* Remove old regions */
>> +     if (gd->fdt_blob !=3D fdt_blob)
>> +             boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob, true);
>> +
>
> Recursing through the public entry point with a flipped bool is hard
> to follow, and it relies on the implicit invariant that the recursive
> call will not itself recurse. I'd find this clearer as two named
> helpers. For example you could have boot_fdt_reserve_regions() and
> boot_fdt_free_regions() sharing a static walker. Then the intent at
> the call site would be obvious.
>
> Please also add a comment explaining the assumption from the commit
> message: this must run before gd->fdt_blob is swapped to the new tree
> (since nothing in the code itself enforces it)

Fair point. Moved the walking logic to a static boot_fdt_handle_mem_rsv_reg=
ions
and made boot_fdt_add_mem_rsv_regions call into it.

>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> @@ -69,35 +69,51 @@ static const struct legacy_img_hdr *image_get_fdt(ul=
ong fdt_addr)
>> -     } else if (ret !=3D -EEXIST && ret !=3D -EINVAL) {
>> -             puts("ERROR: reserving fdt memory region failed ");
>> -             printf("(addr=3D%llx size=3D%llx flags=3D%x)\n",
>> -                    (unsigned long long)addr,
>> -                    (unsigned long long)size, flags);
>> +     } else {
>> +             printf("ERROR: %s fdt memory region failed (addr=3D%llx si=
ze=3D%llx flags=3D%x): %ld\n",
>> +                    free ? 'freeing' : 'reserving', (unsigned long long=
)addr,
>> +                    (unsigned long long)size, flags, ret);
>>       }
>
> Dropping the -EEXIST/-EINVAL filter only works on the reserve path
> once the free path always succeeds. On the free side, anything in the
> old fdt's reserved-memory that wasn't actually picked up by
> lmb_reserve_common() (a non-enabled subnode, or a region since
> split/coalesced inside LMB) will now produce a spurious "ERROR:
> freeing fdt memory region failed" line.

Nah, coalesced regions can be freed without issue. The region is simply spl=
it if
needed in _lmb_free.

If the free or allocation doesn't succeed for any reason the user must be *=
at
least* be informed. This hidden warning stuff was the start of all of this.=
 I
don't like keeping the users in the dark.

> I'm not sure if this actually happens? You could try it on a board
> whose memreserve/reserved-memory layout differs between the U-Boot dtb
> and the kernel dtb? Perhaps for now, best to tolerate  -EINVAL on the
> free path at least.

To humor this, the pocketbeagle2 actually has 2 regions back to back.
memory@9da00000 and memory@9db00000. Allocation and freeing of these region=
s
works without fault. Removing memory@9db00000 from the kernel dtb, but keep=
ing
it in the u-boot dtb results in no warnings. Removing memory@9db00000 in u-=
boot
and keeping it in the kernel fdt also resulted in no warnings.

The only thing that would produce logs would be:
1. If someone actually switched gd->fdt_blob before calling this function
2. If someone called this function without switching gd->fdt_blob afterward

Both of these *should* produce warnings, considering they would permanently=
 and
incorrectly change the LMB regions. That would have been unusual in the old
path, we're just making it explicitly bad now.

>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> @@ -108,12 +124,16 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
>> +     /* Remove old regions */
>> +     if (gd->fdt_blob !=3D fdt_blob)
>> +             boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob, true);
>
> Just to check - the cast drops the const from gd->fdt_blob and we then
> walk it read-only, which is fine, but boot_fdt_add_mem_rsv_regions()
> takes a non-const void * for no good reason that I can see? Worth a
> brief comment so a future reader doesn't try to 'fix' the cast.
>
> Regards,
> Simon

Fair point, I just switched boot_fdt_add_mem_rsv_regions to use const.
