Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDCAC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 17:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A3A488395;
	Tue, 21 May 2024 19:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="tBCbPeC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E4D88345; Tue, 21 May 2024 17:50:43 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azolkn190140000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d005::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E11E28803A
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 17:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui6rgXUGxRebkALmGwbjU7KR3f4BzxXqLE5tlTD4MnTMbRYMgmGOBwBgelR7TW7A8WRLePNUN+5hpDf/jMWTvuDUSgTLH4rJzNtb7PHGw507j6yEolDms494cAWDI2VAMApRO4+RF+wsY7BafHMd2rTWqUN50IMtjHAaA5BjWDC6XAI0rm6xW50nlSgZ9EMFVFQRhkZZEBcvIKQJXZBjGH5Ca4ZUX+W14UNUI1d7RK6J2NZfodnfkW40Io+auWUwV8NtRAkM+tPqze5Pf9ufIMNp0FudADySVIe2CzJtWuCCtRCSc8T8BoMi/o98ycRpqT/H+8ocTrqFzGm73AI8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7391KvLDFGYMY3pKX5K1mOdMIEBAnnK83F66nvL8ryg=;
 b=Hk9lvhmooMjEGeYqNdospn92+Yyl935wPU65pIbG/B2L1dYjQSmJRqXVoS4nL9MqIo4eZYXTtQGsQ/gAfK8A+x4qiKlgjLu/qUfsai2YX8aIVG3hz4KBaDnzz8H6nBZ41CW9lQ7oQha9GQkh4IvrvHsj5cyZ3k6Bb3tFeUiXrxzf4W/5BldlaQJjDNC/C3MOtx2q0mc1FQA2LH3bB5qBqEIofqnDO5mo+Yv29DyeRfF61bFEskHN7cRc0HXvMy8Lz6Nes7sCP1gBnNqP184BYwkf3zuF+ZFOb24MU6Zn5eSwQaehKR947RiHc/4/1Msd/rx4hBT4lMB39CqO70vihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7391KvLDFGYMY3pKX5K1mOdMIEBAnnK83F66nvL8ryg=;
 b=tBCbPeC/57W043QcwmGiuVw0aKlFM40oNVKuHhWsysGXML0I8rm5uBOcvH+p+yFFbnGdLLgmv1jV58cwaysEE6BLzKi9Q4/OG19qIvWE5BgHirSz2K3V+WvE0QsxYdSqcFrtYiyPOmY7c9nw+7BQTwPmaurrxFy8jK0ORfTXp2xNvmdNPoGE6QHY5eEmxXNy1B1XrwVtX0YFsWJcqHTJOP3ENPGFJih15wmdCakh4KNaUDMAI6MrodIt22cRAoUpuVcFpn0vjFCiM16ivhQdDKNqTo6NqROqeMW+ZscPim98c+/gktuko4T5PNkfa4mJvK8uQ5ZhecDCZPH6FT7tYA==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 DS0PR05MB9677.namprd05.prod.outlook.com (2603:10b6:8:14b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.17; Tue, 21 May 2024 15:50:37 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::12a8:4f88:32b0:9407]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::12a8:4f88:32b0:9407%6]) with mapi id 15.20.7611.016; Tue, 21 May 2024
 15:50:37 +0000
Date: Tue, 21 May 2024 10:50:35 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG
 is enabled
Message-ID: <DM4PR05MB92290284BB3E861F651CBFEBA5EA2@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240515205049.3005256-1-tharvey@gateworks.com>
 <CAJ+vNU16cn31h_W4g6of8wDTNZNfuzm42K0B-_BMX6zeJSJTmg@mail.gmail.com>
 <07c0000c-c60a-42ad-8c49-608b7b15e7f8@amd.com>
 <CAJ+vNU3HZT=5An0hXCxoyTSJhpsTtOg=gUHf+ks_JKq38jEjRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU3HZT=5An0hXCxoyTSJhpsTtOg=gUHf+ks_JKq38jEjRw@mail.gmail.com>
X-TMN: [GE2CD1FVjzXvznvMChMBrfNJ+3snNS+e]
X-ClientProxiedBy: SA9PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:806:22::34) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <ZkzCy28qG950yuWJ@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|DS0PR05MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e63b57-942b-4757-89b9-08dc79adc229
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|3412199016|440099019;
X-Microsoft-Antispam-Message-Info: 5yfK39GhbD7prfO1l51nt15eIKc1TseHzY5rK67O/he3J2f1ax8aL2VjwuP0XhXdtErZ2io/Ig6+H1AHZNkgHg7CiLMUA2iAao/GSK1L5MOUNDaIRHQ/ubYYwRIuYEfAtSux6PJE516dGTctWgTzZ6RsQr5bWRe5iuCSG2Dcn82E28RQOQ0nVn2rz8wGCeivpO0jbgxddCeeeaTxJOz+08w8iB3RqW0eIhHPm3NVqoD/rl74muJtZxet2t2NH/EirfqwyZuO3ivEd42ZwEn7lYIJXMS8mMjAq8zBLIVtGQoFCo0Thi4WEKVxWyVREfWkWtVNMUgfwy0NChuuL/pHR+lkxTg9jrPFGnP3T99xhqpqT5g3d/FcJicq/8BUhCePHWDBLl9WNNFd4UiHesrOjRX2GXRzqGkVwwc4IqgzFP5YUTkjq0SqyGPpcO15dVvkCfP5jyQ8LCnY+8Vo41ZMYaF404AlLVBdqQARJn8ap61HL0Ng9h3gIQeJKn051tedwJu6S37to+pVGtt2u0YZX1qTgqRMJn19hHhiR9fgrVaBx1cQ4812SJzuXbJHItvB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFJTWlUTGtYVVE5SFdOVkhZWVpBRDdrL3RWVEVnSUJaeDlWem91SGxHQzdr?=
 =?utf-8?B?NXd6WGhodmY4YTFnZUF4VXQ4a2F3U1FFU0IrQTB6b29LenJFaTJzU0NtVVkx?=
 =?utf-8?B?WmJmd1dnbHZzVFZCWmxidW5QWTVncGpLUldMSkROdTZ1TkpEVXJKTDg0dmZn?=
 =?utf-8?B?RFdqSWI3bU1LUWhnYWtEN2Nqcy9pTUFlcGZuRnE5RXFhRnJkbmVSVm02cWJ3?=
 =?utf-8?B?cksycmZGWjVYMEZOKzMvd3JJU043cURWWmVkWmZ6OVJXRFJBSnAyUEJOSCtl?=
 =?utf-8?B?ZUE0RnhXYlJuQlZMVFhFZkFBVDlRckZBYzlndzc5bWhiRVlUM0pQSkM2aElJ?=
 =?utf-8?B?d2tEYWNHeHdTbzRWNnFsVml1SFZlY2RQTmRzOWE2VHNYcDdtNDI3dUw2Qkc5?=
 =?utf-8?B?NmNEZFZnS3p0c09PK1I0TFlreGVIWUpGZ293LzVTTmZUbTNzaUpyNmlKcVdZ?=
 =?utf-8?B?Ym9zcEFVekt1TS9DRUkxNHd2dFJZNDZOZWtUNm1VcWFUWWQ4aHIvN2ZhaFN6?=
 =?utf-8?B?elE2TG96V1VCYVArM1FZbmRHbGhOQldMOUZJemI3RlJpM2RFM0FQOGs3QXQ3?=
 =?utf-8?B?WUJyQ3ZBRis5T0pYN0NxQmkxMW1iS2xrRkRVQnEzMm1mVTY4SVdmbXUzMGZr?=
 =?utf-8?B?ZEppVmN1WlIyLzAzZVM1azRaYTZPTU0xaDhJNUdvVStKMHZ4VmJqc1IzOExL?=
 =?utf-8?B?S1UrdWY2TlpKSW1YNnQvU3lrQ2s2MFlYdlN1ZEJocjhnMGZSZHJGamtjS0lt?=
 =?utf-8?B?aHFrZHU3b1BiS21pd3djUlNraEVpS3o3SXAvU0hrdjFLZDFHRlpUS1M0bDNh?=
 =?utf-8?B?Z0huOVgrZ09nMExrNmRpaXRORnhwYVVYN0dBa2M4N2lveFJiV0V0cWxvcGxq?=
 =?utf-8?B?TGxRcTN4V2g5UjEyYS80OVo0ODdkMnNMOTFNV2lMMS9hZHA1cDl2Mk5uMGg4?=
 =?utf-8?B?aWdzeHY4ZTJSOW5TeFRPTCszWlpQWEtGclQ3alhkbStNOVFiMXNVcE1pZWVt?=
 =?utf-8?B?WW5xSExycmVmc3ZtZEZiNGFQaVZ4R1VFcThBVkFpZjlEWGt3ekpVNDdNSmFi?=
 =?utf-8?B?S3R5ek1wMm1BcXdpRzU2UEFmY2dKbVMzdWk4blBmc0R5bDFOTlZsNGdNVXlP?=
 =?utf-8?B?TjVZdjZPUFBQeEJCSzlJMTkvVXN3QUZSUXJQK2d6T0xWdkxiOHdCRjMrb3Q4?=
 =?utf-8?B?UjFrM0NuTE1XZ0hya0hJZ1I5NnN2NG1EV2ZvUGFjVnlCY2ZCMjlaNk56bzEx?=
 =?utf-8?B?bHlPNDlHL1pLMTdhblVxOWpDeG41TlhkRTRHNStYUlhwZHR6alRjOXI0TVZt?=
 =?utf-8?B?M0NQeXRrWlhFdlBlUTVneURTOTRlWXM4VWVQdzVLVk9LR0xGWklLbU45NXBG?=
 =?utf-8?B?cFBTUUpLMi9PTW5sbnlwdEF5c1BKaitmcGRDRGxsODJldzRydGNaS3p3TGF3?=
 =?utf-8?B?N2pvL0JPQlFSK00vRlYvS1lzSnVaUU5zM0RTSm5aKytJSFVtVTM0S09QL2Zt?=
 =?utf-8?B?dUIrYXJzUFI5aXdpNWIveDhOcEY2VlkraVNnUWQ2K05EL1JPZmlQNWM0SVJH?=
 =?utf-8?B?MTk1N2ZBU1o2TGJCNk80TnlwMEtmVmJqSXJ4bU83eEtGbmhCSFlyYlNBQ3BB?=
 =?utf-8?Q?95ZsgsXD+OBMvYYDfpAtTY79qGd90dcY2n5vLHllTtYg=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e63b57-942b-4757-89b9-08dc79adc229
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 15:50:37.7984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB9677
X-Mailman-Approved-At: Tue, 21 May 2024 19:35:48 +0200
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

On Mon, May 20, 2024 at 09:37:21AM -0700, Tim Harvey wrote:
> On Mon, May 20, 2024 at 1:29 AM Michal Simek <michal.simek@amd.com> wrote:
> >
> > Hi Tim,
> >
> > On 5/16/24 17:58, Tim Harvey wrote:
> > > On Wed, May 15, 2024 at 1:50 PM Tim Harvey <tharvey@gateworks.com> wrote:
> > >>
> > >> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> > >> randomize the virtual address at which the kernel image is loaded, it
> > >> expects entropy to be provided by the bootloader by populating
> > >> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> > >>
> > >> If we have DM_RNG enabled populate this value automatically when
> > >> fdt_chosen is called unless ARMV8_SEC_FIRMWARE_SUPPORT is enabled as
> > >> it's implementation uses a different source of entropy.
> > >>
> > >> As this fdt node is added elsewhere create a library function and
> > >> use it to deduplicate code.
> > >>
> > >> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> > >> but left in place in case boot scripts exist that rely on this command
> > >> existing and returning success. An informational message is printed to
> > >> alert users of this command that it is likely no longer needed.
> > >>
> > >> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > >> ---
> > >> v2:
> > >>   - fix typo in commit msg
> > >>   - use stack for seed to avoid unecessary malloc/free
> > >>   - move to a library function and deduplicate code by using it elsewhere
> > >> ---
> > >>   board/xilinx/common/board.c | 35 -----------------------------
> > >>   boot/fdt_support.c          | 10 +++++++++
> > >>   boot/pxe_utils.c            | 35 +++--------------------------
> > >>   cmd/kaslrseed.c             | 45 ++++++-------------------------------
> > >>   include/kaslrseed.h         | 17 ++++++++++++++
> > >>   lib/Makefile                |  1 +
> > >>   lib/kaslrseed.c             | 34 ++++++++++++++++++++++++++++
> > >>   7 files changed, 72 insertions(+), 105 deletions(-)
> > >>   create mode 100644 include/kaslrseed.h
> > >>   create mode 100644 lib/kaslrseed.c
> > >>
> > >> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> > >> index 30a81376ac41..f741e8957818 100644
> > >> --- a/board/xilinx/common/board.c
> > >> +++ b/board/xilinx/common/board.c
> > >> @@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> > >>          if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
> > >>                  fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
> > >>
> > >> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > >> -               debug("No RNG device\n");
> > >> -               return 0;
> > >> -       }
> > >> -
> > >> -       if (dm_rng_read(dev, buf, n)) {
> > >> -               debug("Reading RNG failed\n");
> > >> -               return 0;
> > >> -       }
> > >> -
> > >> -       if (!blob) {
> > >> -               debug("No FDT memory address configured. Please configure\n"
> > >> -                     "the FDT address via \"fdt addr <address>\" command.\n"
> > >> -                     "Aborting!\n");
> > >> -               return 0;
> > >> -       }
> > >> -
> > >> -       ret = fdt_check_header(blob);
> > >> -       if (ret < 0) {
> > >> -               debug("fdt_chosen: %s\n", fdt_strerror(ret));
> > >> -               return ret;
> > >> -       }
> > >> -
> > >> -       nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
> > >> -       if (nodeoffset < 0) {
> > >> -               debug("Reading chosen node failed\n");
> > >> -               return nodeoffset;
> > >> -       }
> > >> -
> > >> -       ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> > >> -       if (ret < 0) {
> > >> -               debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> > >> -               return ret;
> > >> -       }
> > >> -
> > >>          return 0;
> > >>   }
> > >>   #endif
> > >> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > >> index 874ca4d6f5af..3455d60d69dc 100644
> > >> --- a/boot/fdt_support.c
> > >> +++ b/boot/fdt_support.c
> > >> @@ -8,6 +8,7 @@
> > >>
> > >>   #include <abuf.h>
> > >>   #include <env.h>
> > >> +#include <kaslrseed.h>
> > >>   #include <log.h>
> > >>   #include <mapmem.h>
> > >>   #include <net.h>
> > >> @@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
> > >>          if (nodeoffset < 0)
> > >>                  return nodeoffset;
> > >>
> > >> +       if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWARE_SUPPORT)) {
> > >> +               err = fdt_kaslrseed(fdt);
> > >> +               if (err) {
> > >> +                       printf("WARNING: could not set kaslr-seed %s.\n",
> > >> +                              fdt_strerror(err));
> > >> +                       return err;
> > >> +               }
> > >> +       }
> > >> +
> > >>          if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
> > >>                  err = fdt_setprop(fdt, nodeoffset, "rng-seed",
> > >>                                    abuf_data(&buf), abuf_size(&buf));
> > >> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> > >> index 4b22bb6f525a..8d70233fc08d 100644
> > >> --- a/boot/pxe_utils.c
> > >> +++ b/boot/pxe_utils.c
> > >> @@ -8,6 +8,7 @@
> > >>   #include <dm.h>
> > >>   #include <env.h>
> > >>   #include <image.h>
> > >> +#include <kaslrseed.h>
> > >>   #include <log.h>
> > >>   #include <malloc.h>
> > >>   #include <mapmem.h>
> > >> @@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
> > >>   #if CONFIG_IS_ENABLED(DM_RNG)
> > >>          ulong fdt_addr;
> > >>          struct fdt_header *working_fdt;
> > >> -       size_t n = 0x8;
> > >> -       struct udevice *dev;
> > >> -       u64 *buf;
> > >> -       int nodeoffset;
> > >>          int err;
> > >>
> > >>          /* Get the main fdt and map it */
> > >> @@ -342,35 +339,9 @@ static void label_boot_kaslrseed(void)
> > >>          if (err <= 0)
> > >>                  return;
> > >>
> > >> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > >> -               printf("No RNG device\n");
> > >> -               return;
> > >> -       }
> > >> -
> > >> -       nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> > >> -       if (nodeoffset < 0) {
> > >> -               printf("Reading chosen node failed\n");
> > >> -               return;
> > >> -       }
> > >> -
> > >> -       buf = malloc(n);
> > >> -       if (!buf) {
> > >> -               printf("Out of memory\n");
> > >> -               return;
> > >> -       }
> > >> -
> > >> -       if (dm_rng_read(dev, buf, n)) {
> > >> -               printf("Reading RNG failed\n");
> > >> -               goto err;
> > >> -       }
> > >> -
> > >> -       err = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> > >> -       if (err < 0) {
> > >> +       err = fdt_kaslrseed(working_fdt);
> > >> +       if (err < 0)
> > >>                  printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
> > >> -               goto err;
> > >> -       }
> > >> -err:
> > >> -       free(buf);
> > >>   #endif
> > >>          return;
> > >>   }
> > >> diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> > >> index e0d3c7fe7489..ea5c07d729cf 100644
> > >> --- a/cmd/kaslrseed.c
> > >> +++ b/cmd/kaslrseed.c
> > >> @@ -9,33 +9,16 @@
> > >>   #include <command.h>
> > >>   #include <dm.h>
> > >>   #include <hexdump.h>
> > >> +#include <kaslrseed.h>
> > >>   #include <malloc.h>
> > >>   #include <rng.h>
> > >>   #include <fdt_support.h>
> > >>
> > >>   static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> > >>   {
> > >> -       size_t n = 0x8;
> > >> -       struct udevice *dev;
> > >> -       u64 *buf;
> > >> -       int nodeoffset;
> > >> -       int ret = CMD_RET_SUCCESS;
> > >> +       int err;
> > >>
> > >> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > >> -               printf("No RNG device\n");
> > >> -               return CMD_RET_FAILURE;
> > >> -       }
> > >> -
> > >> -       buf = malloc(n);
> > >> -       if (!buf) {
> > >> -               printf("Out of memory\n");
> > >> -               return CMD_RET_FAILURE;
> > >> -       }
> > >> -
> > >> -       if (dm_rng_read(dev, buf, n)) {
> > >> -               printf("Reading RNG failed\n");
> > >> -               return CMD_RET_FAILURE;
> > >> -       }
> > >> +       printf("Notice: a /chosen/kaslr-seed is automatically added to the device-tree when booted via booti/bootm/bootz therefore using this command is likely no longer needed");
> > >>
> > >>          if (!working_fdt) {
> > >>                  printf("No FDT memory address configured. Please configure\n"
> > >> @@ -44,27 +27,13 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> > >>                  return CMD_RET_FAILURE;
> > >>          }
> > >>
> > >> -       ret = fdt_check_header(working_fdt);
> > >> -       if (ret < 0) {
> > >> -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
> > >> +       err = fdt_kaslrseed(working_fdt);
> > >> +       if (err < 0) {
> > >> +               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
> > >>                  return CMD_RET_FAILURE;
> > >>          }
> > >>
> > >> -       nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> > >> -       if (nodeoffset < 0) {
> > >> -               printf("Reading chosen node failed\n");
> > >> -               return CMD_RET_FAILURE;
> > >> -       }
> > >> -
> > >> -       ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> > >> -       if (ret < 0) {
> > >> -               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> > >> -               return CMD_RET_FAILURE;
> > >> -       }
> > >> -
> > >> -       free(buf);
> > >> -
> > >> -       return ret;
> > >> +       return CMD_RET_SUCCESS;
> > >>   }
> > >>
> > >>   U_BOOT_LONGHELP(kaslrseed,
> > >> diff --git a/include/kaslrseed.h b/include/kaslrseed.h
> > >> new file mode 100644
> > >> index 000000000000..3fe82f418acf
> > >> --- /dev/null
> > >> +++ b/include/kaslrseed.h
> > >> @@ -0,0 +1,17 @@
> > >> +/* SPDX-License-Identifier: GPL-2.0+ */
> > >> +/*
> > >> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> > >> + */
> > >> +
> > >> +#if !defined _KASLRSEED_H_
> > >> +#define _KASLRSEED_H_
> > >> +
> > >> +/**
> > >> + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
> > >> + *
> > >> + * @blob:      fdt blob
> > >> + * Return:     0 if OK, -ve on error
> > >> + */
> > >> +int fdt_kaslrseed(void *blob);
> > >> +
> > >> +#endif /* _KASLRSEED_H_ */
> > >> diff --git a/lib/Makefile b/lib/Makefile
> > >> index 2a76acf100d0..20a0242055fa 100644
> > >> --- a/lib/Makefile
> > >> +++ b/lib/Makefile
> > >> @@ -149,6 +149,7 @@ obj-y += date.o
> > >>   obj-y += rtc-lib.o
> > >>   obj-$(CONFIG_LIB_ELF) += elf.o
> > >>
> > >> +obj-$(CONFIG_DM_RNG) += kaslrseed.o
> > >>   obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) += semihosting.o
> > >>
> > >>   #
> > >> diff --git a/lib/kaslrseed.c b/lib/kaslrseed.c
> > >> new file mode 100644
> > >> index 000000000000..ad06bee2b88d
> > >> --- /dev/null
> > >> +++ b/lib/kaslrseed.c
> > >> @@ -0,0 +1,34 @@
> > >> +// SPDX-License-Identifier: GPL-2.0+
> > >> +/*
> > >> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> > >> + */
> > >> +#include <dm.h>
> > >> +#include <rng.h>
> > >> +#include <fdt_support.h>
> > >> +
> > >> +int fdt_kaslrseed(void *fdt)
> > >> +{
> > >> +       struct udevice *dev;
> > >> +       int nodeoffset;
> > >> +       u64 data;
> > >> +       int err;
> > >> +
> > >> +       err = fdt_check_header(fdt);
> > >> +       if (err < 0)
> > >> +               return err;
> > >> +
> > >> +       /* find or create "/chosen" node. */
> > >> +       nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
> > >> +       if (nodeoffset < 0)
> > >> +               return nodeoffset;
> > >> +
> > >> +       err = uclass_get_device(UCLASS_RNG, 0, &dev);
> > >> +       if (!err)
> > >> +               err = dm_rng_read(dev, &data, sizeof(data));
> > >> +       if (!err)
> > >> +               err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeof(data));
> > >> +       if (err < 0)
> > >> +               printf("WARNING: could not set kaslr-seed %s.\n", fdt_strerror(err));
> >
> > I have used debug messages to better track if error happens. I think it would be
> > good if you can extend your code with it.
> > Because if this fails people have to start tracking if issue is that there is
> > RNG device or reading fails or issue with setting up property.
> 
> Hi Michal,
> 
> I'm assuming there is no valid case to have DM_RNG enabled and no
> UCLASS_RNG driver which is why I'm printing an error if it ultimately
> fails (vs a silent debug statement). If that is true then I should
> probably printf errors for all the cases above vs debugs wouldn't you
> think?
> 
> >
> > In v1 it was said that you won't update it if the kaslr-seed property exists.
> > I can't see this in the code. Or do I read it incorrectly?
> >
> 
> That was a question posed in the discussion but I didn't get an answer
> if that was what I should do. None of the three places I'm
> deduplicating the functionality from check to see if it already
> exists... they would overwrite an existing one. Is there a valid case
> where you would not want to overwrite it?
> 
> >
> > >> +
> > >> +       return err;
> > >> +}
> > >> --
> > >> 2.25.1
> > >>
> > >
> > > I realized I forgot a few CC's here. Adding:
> > >
> > > Michal Simek <michal.simek@amd.com> (board/xilinx/common/board.c and
> > > configs/xilinx* which have CMD_KASLRSEED)
> > > Andy Yan <andy.yan@rock-chips.com> (configs/evb-rk3308_defconfig and
> > > configs/roc-cc-rk3308_defconfig which have CMD_KASLRSEED)
> > > Akash Gajjar <gajjar04akash@gmail.com>
> > > (configs/rock-pi-s-rk3308_defconfig which has CMD_KASLRSEED)
> > > Ilias Apalodimas <ilias.apalodimas@linaro.org> (MEASURE_DEVICETREE,
> > > MEASURED_BOOT)
> > >
> > > Michal, I see that board/xilinx/common/board.c is adding
> > > chosen/kaslr-seed in ft_board_setup as well as some of the
> > > configs/xilinx boards enabling CMD_KASLRSEED - can we remove
> > > CMD_ASLRSEED from those boards? (ie no bootscripts require it?)
> >
> >
> > Based on my note above that you shouldn't change kaslr-seed if exists.
> 
> I can add that if you think it's the correct behavior, but that is not
> what is done in the current code.
> 
> >
> > What would also make sense is to extend kaslrseed command to pass one more
> > parameter to pass which RNG instance should generate data on system with more
> > RNGs. Then pretty much with command you can choose different RNG because current
> > code hardcoded it to instance 0.
> 
> Do you mean extend the command or the fdt_kaslrseed function? I'm
> trying to obsolete the command.
> 
> I can add an index to fdt_kaslrseed but would it be more useful to add
> a udevice* that is used unless null? I can't see where someone wanting
> to call this function would know the index of a specific UCLASS_RNG
> device and not have the device * handy instead.
> 
> It sounds like with the question of not overwriting an existing value
> you are anticipating board specific ft_board_setup functions that may
> want to behave differently and choose a different rng source? If so,
> ft_board_setup is called 'after' fdt_chosen so maybe fdt_kaslrseed
> also needs a boolean to tell it to overwrite existing?
> 
> Are you open to removing CMD_KASLRSEED from the configs/xilinx* which
> have it? If I can get everyone's approval for the few boards that
> include CMD_KASLRSEED I would like to remove the command if we are
> doing it automatically.
> 
> (adding Chris Morgan <macromorgan@hotmail.com> to cc who authored that cmd)

I'm fine with removing the command entirely if we can do it
automatically, as long as we don't break other users. I've actually
been simply duplicating the rng-seed command on my boards to also
seed the kaslr-seed value. This was just a command at the time I
thought was useful, but if there's better ways to do it I'm open to it.

Thank you,
Chris

> 
> >
> > Do you have correct dependency in generic code when MEASURED_BOOT is enabled as
> > was mentioned in v1? If yes it should be mentioned in commit message.
> >
> 
> Likely something is needed but I'm not sure if it's MEASURED_BOOT or
> MEASURE_DEVICETREE - That's a question I posed to Ilias.
> 
> Best Regards,
> 
> Tim
