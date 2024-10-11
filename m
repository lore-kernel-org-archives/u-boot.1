Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4B1D1A427
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 23:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D309989419;
	Sat, 12 Oct 2024 01:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YrMn6z7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47048941A; Sat, 12 Oct 2024 01:18:25 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD5D89407
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 01:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728688702; x=1729293502; i=xypron.glpk@gmx.de;
 bh=t1RBuQXazfBCH/kerIrzxpUnO9B31k0kG2ZJI+L1giE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=YrMn6z7vz4/xX0KVkN3In01Ryw8mnlUSotItD8oOEveqfoLN1S5tFCd5dk0/HrcK
 MqTyGi2BMlxrCPk7D/xOOo7zgBpEkjs45iieGxwku5Wecfyg8CLsOzegjcd/eCNb5
 5O03Bfu9WFkGkEUKRQSun0DdrsNeEXeW7Lc7oDwjrwFkbgR0WKfnbb7zHsNJP499y
 PS9sBEEq4aK3loM5bbLiuipC4w6gQAH5TM4ZLOSPDb/Sy9Q3hTGmSvpmm0Se1s2DN
 1fBf5+Uxe7+aerrf2WDs9V0wMql6EbpVvTbJ41ldxYwiPYPS729+mDxqrulxiMXKG
 HUjY9+GX38AqKa3JkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.104.96]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1tg8h73I68-00qWRL; Sat, 12
 Oct 2024 01:18:22 +0200
Date: Sat, 12 Oct 2024 01:18:19 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_7/7=5D_cmd=3A_Update_the_m?=
 =?US-ASCII?Q?eminfo_command_to_show_the_memory_map?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241011214032.760072-8-sjg@chromium.org>
References: <20241011214032.760072-1-sjg@chromium.org>
 <20241011214032.760072-8-sjg@chromium.org>
Message-ID: <18910B7B-B3C3-4C4E-B2DC-5398F480E075@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9nLr400O+YlTS8JeBzmqhxcprLJgAqT6fR/rwHjmlyoa/Av7/v4
 RMswS6T7IaIb7XgCeds+MPiYAxvBXbSybjEhi7HSlqeNRm3NCw7IKRNlToqQRlhESqnWgIg
 nnrMVWfS2xjg0hbjd2FRyMb9+EWAuYLTJqs/YtuA0TwCevdnd54HIp/mos/ki1iG5ktqDCD
 3kS3DwkF+xGcOvPqy7lqA==
UI-OutboundReport: notjunk:1;M01:P0:SCCRkUK+XC8=;hkgo/vLUlGq+Z0H4NtDXAvIaUzf
 7t0HW1AK6QI3HoHj1cdMi/BCADb2LeHpCVXJ6OgDbfcE1Ds7rhvuAQNxF8XLtrNt81sF68r2e
 y4Ftt75tURuhCi9syFyJQ6X8fRxrdeSU3oB/+hMHbzx7SPLmrWy6C0wcG3OjLoHG0mlaD7+72
 k9OJHEW1dKMI4G6ChgnL2NQwA57R3uzQXE8NdWblJmz5xGGCbmdf9zudIM7Vdw82DBG+6OfCE
 xSH2V2ZBRXz4ltrPY49ChdT9cSGX6t20IPtf45iujfZkW+N2gk0+piQXzpw0zzhZdwAzVMFm+
 H+cHzm+0Ds8a0WEnWFlvzbKsdrZ6XbTvVIDyVH7FFy5zwOUUi13tugdygljWo1UYUhGzb8ndI
 gyZlvIm5x6lbNXjTLtWScAJhk/UFn0z6Xt1GQDvn8xb5hGPt6x/A/pzwB1dopTrLr5b15+w9P
 pb0pLADSJW/rsbTj2kLFQA1a2+LdAC7/y202pAZbX0ppg8R03g/fwcAlLks5MbvJyxJ+B1coW
 WOCY1s2OHuRffx9r+v4GteVSiMJCC+cOj6lCNsLhmSRipiFV8VEZjRgfFcF4PAlX4Aw6hPqRX
 rqZ9Q/POhMW2fGW30ihXVeIkLEAu60dGi9ztSEX5a1QzCyHawGclltAwaSe4IRDYI2MIekiff
 JM+LAyoMnm2tvK9oDVgnRYwySnFMuo3QjtD7RDgAMp1o4nuyc0kFsndXxheuSSCHe8iu6sICy
 rN/jAvz5awKj55eDE+OV9gO07DOwyZ+DQC3hxtqE5UXFQX56YiiqSVBKTwu8cNggsmKz7cl8a
 qoV1StEeagN1h4ZiseBT/fcA==
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



Am 11=2E Oktober 2024 23:40:31 MESZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>U-Boot has a fairly rigid memory map which is normally not visible
>unless debugging is enabled in board_f=2Ec
>
>Update the 'meminfo' command to show it=2E This command does not cover
>arch-specific pieces but gives a good overview of where things are=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>Changes in v2:
>- Modify the existing 'meminfo' command instead
>
> cmd/meminfo=2Ec             |  48 ++++++++++++++-
> doc/usage/cmd/meminfo=2Erst | 126 ++++++++++++++++++++++++++++++++++++++
> doc/usage/index=2Erst       |   1 +
> test/cmd/Makefile         |   3 +-
> test/cmd/meminfo=2Ec        |  38 ++++++++++++
> 5 files changed, 214 insertions(+), 2 deletions(-)
> create mode 100644 doc/usage/cmd/meminfo=2Erst
> create mode 100644 test/cmd/meminfo=2Ec
>
>diff --git a/cmd/meminfo=2Ec b/cmd/meminfo=2Ec
>index bb9bcec2e3f=2E=2Ee9a635bf4bf 100644
>--- a/cmd/meminfo=2Ec
>+++ b/cmd/meminfo=2Ec
>@@ -4,18 +4,64 @@
>  * Written by Simon Glass <sjg@chromium=2Eorg>
>  */
>=20
>+#include <bloblist=2Eh>
>+#include <bootstage=2Eh>
> #include <command=2Eh>
> #include <display_options=2Eh>
>+#include <malloc=2Eh>
>+#include <mapmem=2Eh>
> #include <asm/global_data=2Eh>
>=20
> DECLARE_GLOBAL_DATA_PTR;
>=20
>+static void print_region(const char *name, ulong base, ulong size, ulong=
 *uptop)
>+{
>+	ulong end =3D base + size;
>+
>+	printf("%-12s %8lx %8lx %8lx", name, base, size, end);
>+	if (*uptop)
>+		printf(" %8lx", *uptop - end);
>+	putc('\n');
>+	*uptop =3D base;
>+}
>+
> static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
>-		       char *const argv[])
>+		      char *const argv[])
> {
>+	ulong upto, stk_bot;
>+
> 	puts("DRAM:  ");
> 	print_size(gd->ram_size, "\n");
>=20
>+	printf("\n%-12s %8s %8s %8s %8s\n", "Region", "Base", "Size", "End",
>+	       "Gap");
>+	printf("------------------------------------------------\n");
>+	upto =3D 0;
>+	if (IS_ENABLED(CONFIG_VIDEO))
>+		print_region("video", gd_video_bottom(),
>+			     gd_video_size(), &upto);
>+	if (IS_ENABLED(CONFIG_TRACE))
>+		print_region("trace", map_to_sysmem(gd_trace_buff()),
>+			     gd_trace_size(), &upto);
>+	print_region("code", gd->relocaddr, gd->mon_len, &upto);
>+	print_region("malloc", map_to_sysmem((void *)mem_malloc_start),
>+		     mem_malloc_end - mem_malloc_start, &upto);
>+	print_region("board_info", map_to_sysmem(gd->bd),
>+		     sizeof(struct bd_info), &upto);
>+	print_region("global_data", map_to_sysmem((void *)gd),
>+		     sizeof(struct global_data), &upto);
>+	print_region("devicetree", map_to_sysmem(gd->fdt_blob),
>+		     fdt_totalsize(gd->fdt_blob), &upto);
>+	if (IS_ENABLED(CONFIG_BOOTSTAGE))
>+		print_region("bootstage", map_to_sysmem(gd_bootstage()),
>+			     bootstage_get_size(false), &upto);
>+	if (IS_ENABLED(CONFIG_BLOBLIST))
>+		print_region("bloblist", map_to_sysmem(gd_bloblist()),
>+			     bloblist_get_total_size(), &upto);
>+	stk_bot =3D gd->start_addr_sp - CONFIG_STACK_SIZE;
>+	print_region("stack", stk_bot, CONFIG_STACK_SIZE, &upto);
>+	print_region("free", gd->ram_base, stk_bot, &upto);
>+
> 	return 0;
> }
>=20
>diff --git a/doc/usage/cmd/meminfo=2Erst b/doc/usage/cmd/meminfo=2Erst
>new file mode 100644
>index 00000000000=2E=2Ec628119787e
>--- /dev/null
>+++ b/doc/usage/cmd/meminfo=2Erst
>@@ -0,0 +1,126 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0+:
>+
>+=2E=2E index::
>+   single: meminfo (command)
>+
>+meminfo command
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+Synopsis
>+--------
>+
>+::
>+
>+    meminfo
>+
>+Description
>+-----------
>+
>+The meminfo command shows the amount of memory, the layout of memory use=
d by
>+U-Boot and the region which is free for use by images=2E

The information offered by this command cannot be used for this purpose as=
 it is incomplete=2E

Memory allocated in LMB cannot be used to load images=2E And EFI in future=
 will use LMB for allocations=2E

The command should be changed to show LMB allocations=2E

Best regards

Heinrich


>+
>+The layout of memory is set up before relocation, within the init sequen=
ce in
>+``board_init_f()``, specifically the various ``reserve_=2E=2E=2E()`` fun=
ctions=2E This
>+'reservation' of memory starts from the top of RAM and proceeds downward=
s,
>+ending with the stack=2E This results in the maximum possible amount of =
memory
>+being left free for image-loading=2E
>+
>+The meminfo command writes the DRAM size, then the rest of its outputs i=
n 5
>+columns:
>+
>+Region
>+   Name of the region
>+
>+Base
>+    Base address of the region, i=2Ee=2E where it starts in memory
>+
>+Size
>+    Size of the region, which may be a little smaller than the actual si=
ze
>+    reserved, e=2Eg=2E due to alignment
>+
>+End
>+    End of the region=2E The last byte of the region is one lower than t=
he address
>+    shown here
>+
>+Gap
>+    Gap between the end of this region and the base of the one above
>+
>+Regions shown are:
>+
>+video
>+    Memory reserved for video framebuffers=2E This reservation happens i=
n the
>+    bind() methods of all video drivers which are present before relocat=
ion,
>+    so the size depends on that maximum amount of memory which all such =
drivers
>+    want to reserve=2E This may be significantly greater than the amount=
 actually
>+    needed, if the display is ultimately set to a smaller resolution or =
colour
>+    depth than the maximum supported=2E
>+
>+code
>+    U-Boot's code and Block-Starting Symbol (BSS) region=2E Before reloc=
ation,
>+    U-Boot copies its code to a high region and sets up a BSS immediatel=
y after
>+    that=2E The size of this region is generally therefore ``__bss_end``=
 -
>+    ``__image_copy_start``
>+
>+malloc
>+    Contains the malloc() heap=2E The size of this is set by
>+    ``CONFIG_SYS_MALLOC_LEN``=2E
>+
>+board_info
>+    Contains the ``bd_info`` structure, with some information about the =
current
>+    board=2E
>+
>+global_data
>+    Contains the global-data structure, pointed to by ``gd``=2E This inc=
ludes
>+    various pointers, values and flags which control U-Boot=2E
>+
>+devicetree
>+    Contains the flatted devicetree blob (FDT) being used by U-Boot to c=
onfigure
>+    itself and its devices=2E
>+
>+bootstage
>+    Contains the bootstage records, which keep track of boot time as U-B=
oot
>+    executes=2E The size of this is determined by
>+    ``CONFIG_BOOTSTAGE_RECORD_COUNT``, with each record taking approxima=
tely
>+    32 bytes=2E
>+
>+bloblist
>+    Contains the bloblist, which is a list of tables and other data crea=
ted by
>+    U-Boot while executed=2E The size of this is determined by
>+    ``CONFIG_BLOBLIST_SIZE``=2E
>+
>+stack
>+    Contains U-Boot's stack, growing downwards from the top=2E The nomin=
al size of
>+    this region is set by ``CONFIG_STACK_SIZE`` but there is no actual l=
imit
>+    enforced, so the stack can grow behind that=2E Images should be load=
ed lower
>+    in memory to avoid any conflict=2E
>+
>+free
>+    Free memory, which is available for loading images=2E The base addre=
ss of
>+    this is ``gd->ram_base`` which is generally set by ``CFG_SYS_SDRAM_B=
ASE``=2E
>+
>+Example
>+-------
>+
>+::
>+
>+    =3D> meminfo
>+    DRAM:  256 MiB
>+
>+    Region           Base     Size      End      Gap
>+    ------------------------------------------------
>+    video         f000000  1000000 10000000
>+    code          ec3a000   3c5d28  efffd28      2d8
>+    malloc        8c38000  6002000  ec3a000        0
>+    board_info    8c37f90       68  8c37ff8        8
>+    global_data   8c37d80      208  8c37f88        8
>+    devicetree    8c33000     4d7d  8c37d7d        3
>+    bootstage     8c32c20      3c8  8c32fe8       18
>+    bloblist      8c32000      400  8c32400      820
>+    stack         7c31ff0  1000000  8c31ff0       10
>+    free                0  7c31ff0  7c31ff0        0
>+
>+
>+Return value
>+------------
>+
>+The return value $? is always 0 (true)=2E
>diff --git a/doc/usage/index=2Erst b/doc/usage/index=2Erst
>index 70563374899=2E=2E3939add8eaf 100644
>--- a/doc/usage/index=2Erst
>+++ b/doc/usage/index=2Erst
>@@ -83,6 +83,7 @@ Shell commands
>    cmd/loads
>    cmd/loadx
>    cmd/loady
>+   cmd/meminfo
>    cmd/mbr
>    cmd/md
>    cmd/mmc
>diff --git a/test/cmd/Makefile b/test/cmd/Makefile
>index 8f2134998ad=2E=2E0f1c8d77dd9 100644
>--- a/test/cmd/Makefile
>+++ b/test/cmd/Makefile
>@@ -18,8 +18,9 @@ obj-$(CONFIG_CMD_FDT) +=3D fdt=2Eo
> obj-$(CONFIG_CONSOLE_TRUETYPE) +=3D font=2Eo
> obj-$(CONFIG_CMD_HISTORY) +=3D history=2Eo
> obj-$(CONFIG_CMD_LOADM) +=3D loadm=2Eo
>-obj-$(CONFIG_CMD_MEM_SEARCH) +=3D mem_search=2Eo
>+obj-$(CONFIG_CMD_MEMINFO) +=3D meminfo=2Eo
> obj-$(CONFIG_CMD_MEMORY) +=3D mem_copy=2Eo
>+obj-$(CONFIG_CMD_MEM_SEARCH) +=3D mem_search=2Eo
> ifdef CONFIG_CMD_PCI
> obj-$(CONFIG_CMD_PCI_MPS) +=3D pci_mps=2Eo
> endif
>diff --git a/test/cmd/meminfo=2Ec b/test/cmd/meminfo=2Ec
>new file mode 100644
>index 00000000000=2E=2E84981305bf0
>--- /dev/null
>+++ b/test/cmd/meminfo=2Ec
>@@ -0,0 +1,38 @@
>+// SPDX-License-Identifier: GPL-2=2E0+
>+/*
>+ * Test for 'meminfo' command
>+ *
>+ * Copyright 2024 Google LLC
>+ * Written by Simon Glass <sjg@chromium=2Eorg>
>+ */
>+
>+#include <dm/test=2Eh>
>+#include <test/cmd=2Eh>
>+#include <test/ut=2Eh>
>+
>+/* Test 'meminfo' command */
>+static int cmd_test_meminfo(struct unit_test_state *uts)
>+{
>+	ut_assertok(run_command("meminfo", 0));
>+	ut_assert_nextline("DRAM:  256 MiB");
>+	ut_assert_nextline_empty();
>+
>+	ut_assert_nextline("Region           Base     Size      End      Gap");
>+	ut_assert_nextlinen("-");
>+
>+	/* For now we don't worry about checking the values */
>+	ut_assert_nextlinen("video");
>+	ut_assert_nextlinen("code");
>+	ut_assert_nextlinen("malloc");
>+	ut_assert_nextlinen("board_info");
>+	ut_assert_nextlinen("global_data");
>+	ut_assert_nextlinen("devicetree");
>+	ut_assert_nextlinen("bootstage");
>+	ut_assert_nextlinen("bloblist");
>+	ut_assert_nextlinen("stack");
>+	ut_assert_nextlinen("free");
>+	ut_assert_console_end();
>+
>+	return 0;
>+}
>+CMD_TEST(cmd_test_meminfo, UTF_CONSOLE);
