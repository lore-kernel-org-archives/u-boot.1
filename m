Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1819BD6C2B9
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 565938960D;
	Wed, 20 Nov 2024 01:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ic/orwiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C080C89121; Tue, 19 Nov 2024 23:29:05 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CF5E88BFC
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4314ff68358so6861385e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732055343; x=1732660143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPbKbHnkMocM0KL4IqDub9/M/xOFOXcao/owJ+z4rOU=;
 b=Ic/orwiOcb7S1mx2aa8ugevwJ6uxOZ3sm379Jcj+SOtwcPSU4UGAUSMrAsHlJGhNXx
 bTrNsTVD15rdfoksEFC45y5d0GbyJ+1j+EIQbDECdfX9RPQQCM2XkKAFWdHNTzFvuoet
 5Zy3rRrfrGqomvidSU5SatDEARNL0wQjgDClLtoXejz3MYk/JdWha90umycMbDCTCMAO
 c9I2RvaDsMHL6oO5qYgg97UYhIASEmE3sjWBNA8e2gPYaM+8maDZQqlRR9V9PFDwsQ98
 jVusLfEDlLVqzbDwUAHdi9wi+M83XpzA8O7/uLNuhftfkjvuHROlpe9zJnUByRw23tJB
 dM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732055343; x=1732660143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FPbKbHnkMocM0KL4IqDub9/M/xOFOXcao/owJ+z4rOU=;
 b=REm5Cy1KDC85X4c8450TcIC67bm6PpYtNdkH5fb2K0nP+GW6H9ZRPpBhO9zFdvJ85Q
 mcgLKtP2XkY/yKuEfKN+/14tVuzSleD6ayc5eclMlPceRnHmE9h2+1ucQxSllHg9ayTe
 YZKbiN5KRtnVjmZ2DLi07/mP5y20gXSnfcXyZbyv+oTBbbAU41vaUpaZR439LaQ/iizz
 BWfq1dW9KnnY5fH75MyqrjZedL6I+RpdIJs6jcgZFna5WJ1bNZViOgv3NqiPWSuj+QYN
 KJkvqEzCVk4nznLiphErc4/Z1DFP5WGTGbepTvHPqoNGBQXsaUeuVKc2QtaYnvst4tjP
 tZNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaPNHmb0I2wLLJg6svDx2vGgDzauui7xZWZ47lrIL2/pRT1/+rIbs6dudldCNyj3T8o+x+hJk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1ScMomCdIeMTwQ5wzGs2PLvIbZP8olK14lV5FIfco3tTiruow
 eFGeaYyehzLoUHek2IMoO11cFlHGWV6jES8Or8fQEuKMQzJph3hz
X-Gm-Gg: ASbGnctNBb1+Hr40HtI55Rd8ZyVqlwo3F5QpSVRBXCfoL+pc2FM9kDNsm7kkNoXMzk2
 H9XBQhJRY9AM6QpAZ+rMjCuGi25l+BpY7+hGSazgFd8HUNFMXWy4BxybM0JMxO1nh3rQjs0Je4V
 42qucYZe/Stl5/7q99MbeIfxOxSx13Qep3fwjDx8S+09suGw6BWEg4ry/7BjfwhDP/RvNll8wyO
 UmKKDz7NOM2nPj8OCyJuX3PPMcOpxrdVfohss1Vny6/kh8WZEC2l2++c5AbuVGqQ9Z9XO8ZxT69
 F5OCtY1nTw+/Krn/rHfv7rLP30hY
X-Google-Smtp-Source: AGHT+IGQ+QoXnsdGM/Gu24P+8thJRFtnCgKwSikiVfwdumKKl/ylflWSjSfUgwOLr76CymZwzSFQhg==
X-Received: by 2002:a05:600c:3501:b0:431:4e33:98ae with SMTP id
 5b1f17b1804b1-4334f020e5dmr1961705e9.5.1732055342530; 
 Tue, 19 Nov 2024 14:29:02 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac1fb7asm208058655e9.42.2024.11.19.14.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:29:01 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com,
 ada@thorsis.com, xypron.glpk@gmx.de
Cc: mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 pbrobinson@gmail.com, n-francis@ti.com, afd@ti.com, al.kochet@gmail.com,
 u-boot@lists.denx.de, l.rubusch@gmail.com
Subject: [PATCH v1 3/3] doc: develop: Fix typos and wording in
 binman/entries.rst
Date: Tue, 19 Nov 2024 22:28:37 +0000
Message-Id: <20241119222837.27550-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241119222837.27550-1-l.rubusch@gmail.com>
References: <20241119222837.27550-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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

Fix some typos and wording in binman/entries.rst.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 tools/binman/entries.rst | 104 +++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index e918162fb4..abec03bb3c 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -7,18 +7,18 @@ fairly easy to create new entry types. Just add a new file to the 'etype'
 directory. You can use the existing entries as examples.
 
 Note that some entries are subclasses of others, using and extending their
-features to produce new behaviours.
+features to produce new behaviors.
 
 
 
 .. _etype_alternates_fdt:
 
-Entry: alternates-fdt: Entry that generates alternative sections for each devicetree provided
+Entry: alternates-fdt: Entry that generates alternative sections for each device-tree provided
 ---------------------------------------------------------------------------------------------
 
 When creating an image designed to boot on multiple models, each model
-requires its own devicetree. This entry deals with selecting the correct
-devicetree from a directory containing them. Each one is read in turn, then
+requires its own device-tree. This entry deals with selecting the correct
+device-tree from a directory containing them. Each one is read in turn, then
 used to produce section contents which are written to a file. This results
 in a number of images, one for each model.
 
@@ -48,8 +48,8 @@ of each of the alternates is the same as the 'default' one, so they can in
 principle be 'slotted in' to the appropriate place in the main image.
 
 The optional `fdt-phase` property indicates the phase to build. In this
-case, it etype runs fdtgrep to obtain the devicetree subset for that phase,
-respecting the `bootph-xxx` tags in the devicetree.
+case, it etype runs fdtgrep to obtain the device-tree subset for that phase,
+respecting the `bootph-xxx` tags in the device-tree.
 
 
 
@@ -214,7 +214,7 @@ icons, for example. For verified boot it could be used for each part of the
 image (e.g. separate FIPs for A and B) but cannot describe the whole
 firmware image. As with FMAP there is no hierarchy defined, although FMAP
 works around this by having 'section' areas which encompass others. A
-similar workaround would be possible with FIP but is not currently defined.
+similar workaround would be possible with FIP but it is not currently defined.
 
 It is recommended to always add an fdtmap to every image, as well as any
 FIPs so that binman and other tools can access the entire image correctly.
@@ -240,7 +240,7 @@ Properties / Entry arguments:
         lz4: Use lz4 compression (via 'lz4' command-line utility)
 
 This entry reads data from a file and places it in the entry. The
-default filename is often specified specified by the subclass. See for
+default filename is often specified by the subclass. See for
 example the 'u-boot' entry which provides the filename 'u-boot.bin'.
 
 If compression is enabled, an extra 'uncomp-size' property is written to
@@ -283,10 +283,10 @@ See 'blob' for Properties / Entry arguments.
 Entry: blob-ext-list: List of externally built binary blobs
 -----------------------------------------------------------
 
-This is like blob-ext except that a number of blobs can be provided,
-typically with some sort of relationship, e.g. all are DDC parameters.
+This is like blob-ext except that a few blobs can be provided,
+typically, with some sort of relationship, e.g. all are DDC parameters.
 
-If any of the external files needed by this llist is missing, binman can
+If any of the external files needed by this list is missing, binman can
 optionally ignore it and produce a broken image with a warning.
 
 Args:
@@ -335,7 +335,7 @@ structure and allows the position of individual files to be set, since it is
 designed to support execute-in-place in an x86 SPI-flash device. Where XIP
 is not used, it supports compression and storing ELF files.
 
-CBFS is used by coreboot as its way of orgnanising SPI-flash contents.
+CBFS is used by coreboot as its way of organizing SPI-flash contents.
 
 The contents of the CBFS are defined by subnodes of the cbfs entry, e.g.::
 
@@ -351,8 +351,8 @@ The contents of the CBFS are defined by subnodes of the cbfs entry, e.g.::
 
 This creates a CBFS 1MB in size two files in it: u-boot.bin and u-boot.dtb.
 Note that the size is required since binman does not support calculating it.
-The contents of each entry is just what binman would normally provide if it
-were not a CBFS node. A blob type can be used to import arbitrary files as
+The contents of each entry are just what binman would normally provide if it
+was not a CBFS node. A blob type can be used to import arbitrary files as
 with the second subnode below::
 
     cbfs {
@@ -431,7 +431,7 @@ cbfs-offset:
     specify where the file should be placed in cases where a fixed position
     is needed. Typical uses are for code which is not relocatable and must
     execute in-place from a particular address. This works because SPI flash
-    is generally mapped into memory on x86 devices. The file header is
+    is mapped into memory on x86 devices. The file header is
     placed before this offset so that the data start lines up exactly with
     the chosen offset. If this property is not provided, then the file is
     placed in the next available spot.
@@ -439,9 +439,9 @@ cbfs-offset:
 The current implementation supports only a subset of CBFS features. It does
 not support other file types (e.g. payload), adding multiple files (like the
 'files' entry with a pattern supported by binman), putting files at a
-particular offset in the CBFS and a few other things.
+offset in the CBFS and a few other things.
 
-Of course binman can create images containing multiple CBFSs, simply by
+Of course, binman can create images containing multiple CBFSs, simply by
 defining these in the binman config::
 
 
@@ -475,7 +475,7 @@ defining these in the binman config::
     };
 
 This creates an 8MB image with two CBFSs, one at offset 1MB, one at 7MB,
-both of size 1MB.
+both sizes 1MB.
 
 
 
@@ -745,11 +745,11 @@ Example output for a simple image with U-Boot and an FDT map::
         };
     };
 
-If allow-repack is used then 'orig-offset' and 'orig-size' properties are
+If allow-repack is used, then 'orig-offset' and 'orig-size' properties are
 added as necessary. See the binman README.
 
 When extracting files, an alternative 'fdt' format is available for fdtmaps.
-Use `binman extract -F fdt ...` to use this. It will export a devicetree,
+Use `binman extract -F fdt ...` to use this. It will export a device-tree,
 without the fdtmap header, so it can be viewed with `fdtdump`.
 
 
@@ -766,8 +766,8 @@ Properties / Entry arguments:
         lz4: Use lz4 compression (via 'lz4' command-line utility)
     - files-align: Align each file to the given alignment
 
-This entry reads a number of files and places each in a separate sub-entry
-within this entry. To access these you need to enable device-tree updates
+The entry reads a few files and places each in a separate sub-entry
+within this entry. To access it you need to enable device-tree updates
 at run-time so you can obtain the file positions.
 
 
@@ -883,7 +883,7 @@ NAME
     Name of the dtb as provided (i.e. without adding '.dtb')
 
 The `default` property, if present, will be automatically set to the name
-if of configuration whose devicetree matches the `default-dt` entry
+if of configuration whose device-tree matches the `default-dt` entry
 argument, e.g. with `-a default-dt=sun50i-a64-pine64-lts`.
 
 Available substitutions for property values in these nodes are:
@@ -919,7 +919,7 @@ U-Boot supports creating fdt and config nodes automatically. To do this,
 pass an `of-list` property (e.g. `-a of-list=file1 file2`). This tells
 binman that you want to generates nodes for two files: `file1.dtb` and
 `file2.dtb`. The `fit,fdt-list` property (see above) indicates that
-`of-list` should be used. If the property is missing you will get an error.
+`of-list` should be used. If the property is missing, you get an error.
 
 Then add a 'generator node', a node with a name starting with '@'::
 
@@ -953,20 +953,20 @@ You can create config nodes in a similar way::
 This tells binman to create nodes `config-1` and `config-2`, i.e. a config
 for each of your two files.
 
-Note that if no devicetree files are provided (with '-a of-list' as above)
+Note that if no device-tree files are provided (with '-a of-list' as above)
 then no nodes will be generated.
 
 The 'fit,compatible' property (if present) is replaced with the compatible
-string from the root node of the devicetree, so that things work correctly
-with FIT's configuration-matching algortihm.
+string from the root node of the device-tree, so that things work correctly
+with FIT's configuration-matching algorithm.
 
 Dealing with phases
 ~~~~~~~~~~~~~~~~~~~
 
 FIT can be used to load firmware. In this case it may be necessary to run
-the devicetree for each model through fdtgrep to remove unwanted properties.
+the device-tree for each model through fdtgrep to remove unwanted properties.
 The 'fit,fdt-phase' property can be provided to indicate the phase for which
-the devicetree is intended.
+the device-tree is intended.
 
 For example this indicates that the FDT should be processed for VPL::
 
@@ -1164,7 +1164,7 @@ Properties / Entry arguments:
 
 FMAP is a simple format used by flashrom, an open-source utility for
 reading and writing the SPI flash, typically on x86 CPUs. The format
-provides flashrom with a list of areas, so it knows what it in the flash.
+provides flashrom with a list of areas, that it knows what is in the flash.
 It can then read or write just a single area, instead of the whole flash.
 
 The format is defined by the flashrom project, in the file lib/fmap.h -
@@ -1214,7 +1214,7 @@ Entry: image-header: An entry which contains a pointer to the FDT map
 
 Properties / Entry arguments:
     location: Location of header ("start" or "end" of image). This is
-        optional. If omitted then the entry must have an offset property.
+        optional. If omitted, then the entry must have an offset property.
 
 This adds an 8-byte entry to the start or end of the image, pointing to the
 location of the FDT map. The format is a magic number followed by an offset
@@ -1223,7 +1223,7 @@ from the start or end of the image, in twos-compliment format.
 This entry must be in the top-level part of the image.
 
 NOTE: If the location is at the start/end, you will probably need to specify
-sort-by-offset for the image, unless you actually put the image header
+sort-by-offset for the image, unless you put the image header
 first/last in the entry list.
 
 
@@ -1338,7 +1338,7 @@ Properties / Entry arguments:
 This file contains a binary blob which is used on some devices to set up
 the silicon. U-Boot executes this code in U-Boot proper after SDRAM is
 running, so that it can make full use of memory. Documentation is typically
-not available in sufficient detail to allow U-Boot do this this itself.
+not available in sufficient detail to allow U-Boot do this itself.
 
 An example filename is 'fsp_s.bin'
 
@@ -1411,7 +1411,7 @@ Properties / Entry arguments:
 This file contains code used by the SoC that is required to make it work.
 The Management Engine is like a background task that runs things that are
 not clearly documented, but may include keyboard, display and network
-access. For platform that use ME it is not possible to disable it. U-Boot
+access. For platforms using ME, it is not possible to disable it. U-Boot
 does not directly execute code in the ME binary.
 
 A typical filename is 'me.bin'.
@@ -1664,7 +1664,7 @@ placed at offset 'RESET_VECTOR_ADDRESS - 0xffc'.
 
 .. _etype_pre_load:
 
-Entry: pre-load: Pre load image header
+Entry: pre-load: Pre-load image header
 --------------------------------------
 
 Properties / Entry arguments:
@@ -2216,14 +2216,14 @@ Properties / Entry arguments:
 Entry: u-boot-expanded: U-Boot flat binary broken out into its component parts
 ------------------------------------------------------------------------------
 
-This is a section containing the U-Boot binary and a devicetree. Using this
+This is a section containing the U-Boot binary and a device-tree. Using this
 entry type automatically creates this section, with the following entries
 in it:
 
    u-boot-nodtb
    u-boot-dtb
 
-Having the devicetree separate allows binman to update it in the final
+Having the device-tree separate allows binman to update it in the final
 image, so that the entries positions are provided to the running U-Boot.
 
 
@@ -2303,8 +2303,8 @@ to avoid the data overlapping with U-Boot variables. This entry is useful in
 that case. It automatically pads out the entry size to cover both the code,
 data and BSS.
 
-The contents of this entry will a certain number of zero bytes, determined
-by __bss_size
+The contents of this entry will be filled up with a number of zero bytes,
+determined by __bss_size
 
 The ELF file 'spl/u-boot-spl' must also be available for this to work, since
 binman uses that to look up the BSS address.
@@ -2348,14 +2348,14 @@ Properties / Entry arguments:
         select)
 
 This is a section containing the U-Boot binary, BSS padding if needed and a
-devicetree. Using this entry type automatically creates this section, with
+device-tree. Using this entry type automatically creates this section, with
 the following entries in it:
 
    u-boot-spl-nodtb
    u-boot-spl-bss-pad
    u-boot-dtb
 
-Having the devicetree separate allows binman to update it in the final
+Having the device-tree separate allows binman to update it in the final
 image, so that the entries positions are provided to the running U-Boot.
 
 This entry is selected based on the value of the 'spl-dtb' entryarg. If
@@ -2479,8 +2479,8 @@ to avoid the data overlapping with U-Boot variables. This entry is useful in
 that case. It automatically pads out the entry size to cover both the code,
 data and BSS.
 
-The contents of this entry will a certain number of zero bytes, determined
-by __bss_size
+The contents of this entry will be filled up with a number of zero bytes,
+determined by __bss_size
 
 The ELF file 'tpl/u-boot-tpl' must also be available for this to work, since
 binman uses that to look up the BSS address.
@@ -2536,14 +2536,14 @@ Properties / Entry arguments:
         select)
 
 This is a section containing the U-Boot binary, BSS padding if needed and a
-devicetree. Using this entry type automatically creates this section, with
+device-tree. Using this entry type automatically creates this section, with
 the following entries in it:
 
    u-boot-tpl-nodtb
    u-boot-tpl-bss-pad
    u-boot-dtb
 
-Having the devicetree separate allows binman to update it in the final
+Having the device-tree separate allows binman to update it in the final
 image, so that the entries positions are provided to the running U-Boot.
 
 This entry is selected based on the value of the 'tpl-dtb' entryarg. If
@@ -2678,8 +2678,8 @@ to avoid the data overlapping with U-Boot variables. This entry is useful in
 that case. It automatically pads out the entry size to cover both the code,
 data and BSS.
 
-The contents of this entry will a certain number of zero bytes, determined
-by __bss_size
+The contents of this entry will be filled up with a number of zero bytes,
+determined by __bss_size
 
 The ELF file 'vpl/u-boot-vpl' must also be available for this to work, since
 binman uses that to look up the BSS address.
@@ -2723,14 +2723,14 @@ Properties / Entry arguments:
         select)
 
 This is a section containing the U-Boot binary, BSS padding if needed and a
-devicetree. Using this entry type automatically creates this section, with
+device-tree. Using this entry type automatically creates this section, with
 the following entries in it:
 
    u-boot-vpl-nodtb
    u-boot-vpl-bss-pad
    u-boot-dtb
 
-Having the devicetree separate allows binman to update it in the final
+Having the device-tree separate allows binman to update it in the final
 image, so that the entries positions are provided to the running U-Boot.
 
 This entry is selected based on the value of the 'vpl-dtb' entryarg. If
@@ -2774,7 +2774,7 @@ Properties / Entry arguments:
 See Entry_u_boot_ucode for full details of the three entries involved in
 this process. This entry updates U-Boot with the offset and size of the
 microcode, to allow early x86 boot code to find it without doing anything
-complicated. Otherwise it is the same as the u-boot entry.
+complicated. Otherwise, it is the same as the u-boot entry.
 
 
 
@@ -2947,8 +2947,8 @@ Properties / Entry arguments:
     - keysrc-enc: (Optional) Key source when using decryption engine
     - pmufw-filename: Filename of PMU firmware. Default: pmu-firmware.elf
     - psk-key-name-hint: Name of primary secret key to use for signing the
-                         secondardy public key. Format: .pem file
-    - ssk-key-name-hint: Name of secondardy secret key to use for signing
+                         secondary public key. Format: .pem file
+    - ssk-key-name-hint: Name of secondary secret key to use for signing
                          the boot image. Format: .pem file
 
 The etype is used to create a boot image for Xilinx ZynqMP
-- 
2.39.2

