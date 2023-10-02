Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD6BE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B9C8743C;
	Mon,  2 Oct 2023 03:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TqX59/dJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94E228726A; Mon,  2 Oct 2023 03:18:37 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB69F87280
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7a269637b98so111505539f.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209393; x=1696814193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Paja1OfNXvWTCdn0ELzhwWtRsQOeo1IC3tUlj/D3MX4=;
 b=TqX59/dJkn1G6YpEq6n0HsSXrpXbEPcK9wwoEOPBFSUMyOFMjd/+niFFnixNKO1GOH
 vRI5exvmg+/Gj0Dbarlq+eWtbCD9QayVEgAuSiH4uf1J4cHYxGUI0eLtJrLAd+CNb6eC
 EX16SLP7HAJOr3aZGFO95UpejKEF2qVf17Fso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209393; x=1696814193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Paja1OfNXvWTCdn0ELzhwWtRsQOeo1IC3tUlj/D3MX4=;
 b=JvgULEntn7kvFOY/8veFAlYRi9QJG1gz1vqC67u+0Q6BLHhs4JiIRxAF4Z5tzmi6uY
 Ep4PWtA/U+k7cJVKtMnRDbRGY3cDocCPnpu+tvyRQ+dq6ol9qMvJr7T4RiywklPgfHQc
 JtL+lXXyXqgqo205JxweMUlMkjIpK0IeMMA40sXRv6C9TRKIlD1PgAx9+T5bdrILvxNg
 yes6PJ3bLz+T9hAfjZE0M8lPdYAnzHtxo5E0L6MALsSI+Ls85rvRoV4wcoR1QTnlQ0Of
 XSbq1HAScTVV3Ea/hensog7o9w+F6Y7krArd2blHOgD2dn4wmqSEaMQ+ob4AGHugvmWj
 JVjQ==
X-Gm-Message-State: AOJu0Yxxo00CGllMOLfbLb6hm6vFKwdioc4JrXRIN83QawS3/qk1o9Xa
 JUF9RKmuvi7Rkj7oV5PCd5RLDZ+4FDyB47P4pjU=
X-Google-Smtp-Source: AGHT+IEhz4pzFvYX0++8d9BxeGVxu9UHlR5MoLrLep84Eo7F1Gw1Jw6HutDaRvuUy3uiTb3/mh11bg==
X-Received: by 2002:a05:6602:420d:b0:79f:d194:d6ea with SMTP id
 cb13-20020a056602420d00b0079fd194d6eamr12162595iob.5.1696209393134; 
 Sun, 01 Oct 2023 18:16:33 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 30/34] x86: coreboot: Show the option table
Date: Sun,  1 Oct 2023 19:15:40 -0600
Message-ID: <20231002011553.463514-31-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update the cbsysinfo command to show the contents of the CMOS option
table.

While we are here, add some example output for this command, along with
mention of what the unimplemented tags are.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/cbsysinfo.c         | 73 ++++++++++++++++++++++++++-
 doc/usage/cmd/cbsysinfo.rst | 99 +++++++++++++++++++++++++++++++++++++
 test/cmd/coreboot.c         |  7 +++
 3 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/cmd/x86/cbsysinfo.c b/cmd/x86/cbsysinfo.c
index 84822a3e3211..8c46203e1afa 100644
--- a/cmd/x86/cbsysinfo.c
+++ b/cmd/x86/cbsysinfo.c
@@ -185,6 +185,77 @@ static const char *timestamp_name(uint32_t id)
 	return "<unknown>";
 }
 
+static void show_option_vals(const struct cb_cmos_option_table *tab,
+			     uint id)
+{
+	const void *ptr, *end;
+	bool found = false;
+
+	end = (void *)tab + tab->size;
+	for (ptr = (void *)tab + tab->header_length; ptr < end;) {
+		const struct cb_record *rec = ptr;
+
+		switch (rec->tag) {
+		case CB_TAG_OPTION_ENUM: {
+			const struct cb_cmos_enums *enums = ptr;
+
+			if (enums->config_id == id) {
+				if (!found)
+					printf("  ");
+				printf(" %d:%s", enums->value, enums->text);
+				found = true;
+			}
+			break;
+		}
+			break;
+		case CB_TAG_OPTION_DEFAULTS:
+		case CB_TAG_OPTION_CHECKSUM:
+		case CB_TAG_OPTION:
+			break;
+		default:
+			printf("tag %x\n", rec->tag);
+			break;
+		}
+		ptr += rec->size;
+	}
+}
+
+static void show_option_table(const struct cb_cmos_option_table *tab)
+{
+	const void *ptr, *end;
+
+	print_ptr("option_table", tab);
+	if (!tab->size)
+		return;
+
+	printf(" Bit  Len  Cfg  ID  Name\n");
+	end = (void *)tab + tab->size;
+	for (ptr = (void *)tab + tab->header_length; ptr < end;) {
+		const struct cb_record *rec = ptr;
+
+		switch (rec->tag) {
+		case CB_TAG_OPTION: {
+			const struct cb_cmos_entries *entry = ptr;
+
+			printf("%4x %4x  %3c %3x  %-20s", entry->bit,
+			       entry->length, entry->config, entry->config_id,
+			       entry->name);
+			show_option_vals(tab, entry->config_id);
+			printf("\n");
+			break;
+		}
+		case CB_TAG_OPTION_ENUM:
+		case CB_TAG_OPTION_DEFAULTS:
+		case CB_TAG_OPTION_CHECKSUM:
+			break;
+		default:
+			printf("tag %x\n", rec->tag);
+			break;
+		}
+		ptr += rec->size;
+	}
+}
+
 static void show_table(struct sysinfo_t *info, bool verbose)
 {
 	struct cb_serial *ser = info->serial;
@@ -219,7 +290,7 @@ static void show_table(struct sysinfo_t *info, bool verbose)
 		printf("%12d: %02x:%-8s %016llx %016llx\n", i, mr->type,
 		       get_mem_name(mr->type), mr->base, mr->size);
 	}
-	print_ptr("option_table", info->option_table);
+	show_option_table(info->option_table);
 
 	print_hex("CMOS start", info->cmos_range_start);
 	if (info->cmos_range_start) {
diff --git a/doc/usage/cmd/cbsysinfo.rst b/doc/usage/cmd/cbsysinfo.rst
index 8c03a85169dc..ea6878e54232 100644
--- a/doc/usage/cmd/cbsysinfo.rst
+++ b/doc/usage/cmd/cbsysinfo.rst
@@ -23,3 +23,102 @@ Example
 ::
 
     => cbsysinfo
+    Coreboot table at 500, size 5c4, records 1d (dec 29), decoded to 000000007dce4520, forwarded to 000000007ff9a000
+
+    CPU KHz     : 0
+    Serial I/O port: 00000000
+       base        : 00000000
+       pointer     : 000000007ff9a370
+       type        : 1
+       base        : 000003f8
+       baud        : 0d115200
+       regwidth    : 1
+       input_hz    : 0d1843200
+       PCI addr    : 00000010
+    Mem ranges  : 7
+              id: type               ||   base        ||   size
+               0: 10:table    0000000000000000 0000000000001000
+               1: 01:ram      0000000000001000 000000000009f000
+               2: 02:reserved 00000000000a0000 0000000000060000
+               3: 01:ram      0000000000100000 000000007fe6d000
+               4: 10:table    000000007ff6d000 0000000000093000
+               5: 02:reserved 00000000fec00000 0000000000001000
+               6: 02:reserved 00000000ff800000 0000000000800000
+    option_table: 000000007ff9a018
+     Bit  Len  Cfg  ID  Name
+       0  180    r   0  reserved_memory
+     180    1    e   4  boot_option            0:Fallback 1:Normal
+     184    4    h   0  reboot_counter
+     190    8    r   0  reserved_century
+     1b8    8    r   0  reserved_ibm_ps2_century
+     1c0    1    e   1  power_on_after_fail    0:Disable 1:Enable
+     1c4    4    e   6  debug_level            5:Notice 6:Info 7:Debug 8:Spew
+     1d0   80    r   0  vbnv
+     3f0   10    h   0  check_sum
+    CMOS start  : 1c0
+       CMOS end    : 1cf
+       CMOS csum loc: 3f0
+    VBNV start  : ffffffff
+    VBNV size   : ffffffff
+    CB version  : 4.21-5-g7e6eae9679e3-dirty
+       Extra       :
+       Build       : Thu Sep 07 14:52:41 UTC 2023
+       Time        : 14:52:41
+    Framebuffer : 000000007ff9a410
+       Phys addr   :         fd000000
+       X res       : 0d800
+       X res       : 0d600
+       Bytes / line: c80
+       Bpp         : 0d32
+       pos/size      red 16/8, green 8/8, blue 0/8, reserved 24/8
+    GPIOs       : 0
+              id: port     polarity val name
+    MACs        : 0d10
+               0: 12:00:00:00:28:00
+               1: 00:00:00:fd:00:00
+               2: 20:03:00:00:58:02
+               3: 80:0c:00:00:20:10
+               4: 08:00:08:18:08:00
+               5: 16:00:00:00:10:00
+               6: 00:d0:fd:7f:00:00
+               7: 17:00:00:00:10:00
+               8: 00:e0:fd:7f:00:00
+               9: 37:00:00:00:10:00
+    Multiboot tab: 0000000000000000
+    CB header   : 000000007ff9a000
+    CB mainboard: 000000007ff9a344
+       vendor      : 0: Emulation
+       part_number : 10: QEMU x86 i440fx/piix4
+    vboot handoff: 0000000000000000
+       size        : 0
+       vdat addr   : 0000000000000000
+       size        : 0
+    SMBIOS      :         7ff6d000
+       size        : 8000
+    ROM MTRR    : 0
+    Tstamp table: 000000007ffdd000
+    CBmem cons  : 000000007ffde000
+    Size        : 1fff8
+    Cursor      : 3332
+    MRC cache   : 0000000000000000
+    ACPI GNVS   : 0000000000000000
+    Board ID    : ffffffff
+    RAM code    : ffffffff
+    WiFi calib  : 0000000000000000
+    Ramoops buff:                0
+       size        : 0
+    SF size     : 0
+    SF sector   : 0
+    SF erase cmd: 0
+    FMAP offset :                0
+    CBFS offset :              200
+    CBFS size   :           3ffe00
+    Boot media size:           400000
+    MTC start   :                0
+    MTC size    : 0
+    Chrome OS VPD: 0000000000000000
+    RSDP        : 000000007ff75000
+    Unimpl.     : 10 37 40
+    =>
+
+Note that "Unimpl." shows tags which U-Boot does not currently implement.
diff --git a/test/cmd/coreboot.c b/test/cmd/coreboot.c
index 277c670c15e9..eb3d8905986d 100644
--- a/test/cmd/coreboot.c
+++ b/test/cmd/coreboot.c
@@ -23,6 +23,13 @@ static int test_cmd_cbsysinfo(struct unit_test_state *uts)
 	ut_assertok(run_command("cbsysinfo", 0));
 	ut_assert_nextlinen("Coreboot table at");
 
+	/* Make sure CMOS options are enabled */
+	ut_assert_skip_to_line(
+		" 1c0    1    e   1  power_on_after_fail    0:Disable 1:Enable");
+	ut_assert_skip_to_line("CMOS start  : 1c0");
+	ut_assert_nextline("   CMOS end    : 1cf");
+	ut_assert_nextline("   CMOS csum loc: 3f0");
+
 	/* Make sure the linear frame buffer is enabled */
 	ut_assert_skip_to_linen("Framebuffer");
 	ut_assert_nextlinen("   Phys addr");
-- 
2.42.0.582.g8ccd20d70d-goog

