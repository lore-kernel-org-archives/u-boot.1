Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42DBC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 239A08397A;
	Wed, 28 May 2025 14:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gMs7uOZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F8988004F; Wed, 28 May 2025 14:34:07 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A908883AAB
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd41.google.com with SMTP id
 ca18e2360f4ac-85de3e8d0adso117179539f.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435640; x=1749040440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/+tNE8ygu6RRHBWkG6P62H2XIMes9BSx12XYwieUn0=;
 b=gMs7uOZ4nwy6rfVPjonZyQSPLuK9QiqqwOSaOVkIEUj9oBig39hSaIM/NRA7/igcAB
 TGpqvUv49rI5vc6x54JMwqlMhsLX+Wo0nuFlFsPMEvF+gu7XlHjVN1vBy5P44vaZpL7Z
 m68CFsLObJInNh1mASjK4W8rnL8h5WulS+pmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435640; x=1749040440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M/+tNE8ygu6RRHBWkG6P62H2XIMes9BSx12XYwieUn0=;
 b=I9PpSut+G6pVgZCfskj237Y2Ot3fXqAfiOexm6lSoaqV8/FR5xX25JtBkO0UIv2eYq
 OTptuC4PTsiERCK13t0JDMmSqT/Pi4NTVODhGn9lJVn55rxUPgMJzeKPA8ySAYDwEAV5
 BDd49RlodLNhJ4t6SqfaiLgZM9jTKNM/jV4gNTwWepv2btzI8sGg/BxduBWl0eFQVopd
 cyRa1nRPPhtPmR5WHDNgSf9rsdN4SCdqf1hEU5Cc0gwscMExZknl/DkuySlrcfQtoL2R
 UwVpkrczE0vRLK7Szakez6LkAhB9uPp64AiKSKxULCaJAgrObX1hJFTZG26lemL5lukg
 hCkA==
X-Gm-Message-State: AOJu0YwjmA6wVeG9X9ltJfGy/vhGN4adADNZrwvHEbigbTB6Tp3wgeKT
 wwDz8T7y7J1jzqkZ4DZ9X9nkOonnIbcC0X/aN3QbsXhqmI0ubZHyMVU7FXQSGa6Gsom3GX+jBv3
 WMmyVupdXvCw=
X-Gm-Gg: ASbGncvSzJ6rkCd3UtIqdgaX+PNPUzY3W/Kl4zeitV8pxD9mjoAny13Y4zrxwL4AZOw
 5tfgz4j9DN7AvFbkiUQRfxHUXdNBq9NJmR3Dp058BD0+GpXdguXUHAGigL2iDf5UxCMM+VEmHWL
 W8wU2nNW0EUBEuw/lb6njDsU+fNB/FiV0jSBaMSKax6e5/4zEUPeEetE3FliO5tCvt40JTwkYhO
 wfjgK/eSwak2CBNqAHxfMW1ALZQJ52EmzQ5iK062KUQdsjVL/kseTEm/in187Tkky6UH4TZevL0
 M/onpNHk6R3d1Gwpyuoc8eu0BIf7Vj/h6Hp5yvUpTlni3hkgSdJniA+dTbV7zdPvPY4nNMilwxl
 04Xg3WIiimaZIcVvzbRn+xhE=
X-Google-Smtp-Source: AGHT+IEo+s5Yk3VQ2saOrgZcRp3Z8DWorOyuUOsd5nUSB7iWH5guRW1Gd0/At0u86fdUhjdaINgNJA==
X-Received: by 2002:a05:6e02:3802:b0:3dc:90fc:282d with SMTP id
 e9e14a558f8ab-3dc9b6e5684mr123117085ab.16.1748435640098; 
 Wed, 28 May 2025 05:34:00 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Alexander Dahl <ada@thorsis.com>,
 Greg Malysa <malysagreg@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v5 22/25] passage: Add documentation
Date: Wed, 28 May 2025 06:32:24 -0600
Message-ID: <20250528063224.v5.22.I91d5b9ae45e8d1081b1e165620ad1946bd69af00@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

Add documentation about standard passage and update the maintainers.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Fix 'that' typo
- Update docs for the various code changes

Changes in v2:
- Add comments about how to pass standard passage to EFI
- Add comments about passing a bloblist to Linux
- Add detailed arch-specific information
- Fix 'it' typo

 MAINTAINERS                   |  10 +
 board/sandbox/stdpass_check.c |   3 +-
 doc/develop/bloblist.rst      |   4 +-
 doc/develop/index.rst         |   1 +
 doc/develop/std_passage.rst   | 384 ++++++++++++++++++++++++++++++++++
 5 files changed, 399 insertions(+), 3 deletions(-)
 create mode 100644 doc/develop/std_passage.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385..6e4cc8fd310 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1681,6 +1681,16 @@ F:	common/stackprot.c
 F:	cmd/stackprot_test.c
 F:	test/py/tests/test_stackprotector.py
 
+STANDARD PASSAGE
+M:	Simon Glass <sjg@chromium.org>
+F:	board/sandbox/stdpass_check.c
+F:	cmd/bloblist.c
+F:	common/bloblist.c
+F:	doc/develop/std_passage.rst
+F:	include/bloblist.h
+F:	include/stdpass/
+F:	test/bloblist.c
+
 TARGET_BCMNS3
 M:	Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
 S:	Maintained
diff --git a/board/sandbox/stdpass_check.c b/board/sandbox/stdpass_check.c
index c8ddb635f57..2244a90c3ba 100644
--- a/board/sandbox/stdpass_check.c
+++ b/board/sandbox/stdpass_check.c
@@ -21,7 +21,8 @@ void check_spl_handoff(void)
  * 1. Add your header file to U-Boot, or to include/stdpass if it is not used in
  * U-Boot
  *
- * 2. Add a function below to include the header and use the struct
+ * 2. Add a function below to include the header and use the struct. Please put
+ * your function in order of tag ID (see bloblist.h)
  *
  * Template follows, see above for example
  */
diff --git a/doc/develop/bloblist.rst b/doc/develop/bloblist.rst
index 28431039adc..5888bfd6610 100644
--- a/doc/develop/bloblist.rst
+++ b/doc/develop/bloblist.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-Blob Lists - bloblist
-=====================
+Bloblist
+========
 
 Introduction
 ------------
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 0c83ef109ab..59c3e39ef73 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -53,6 +53,7 @@ Implementation
    smbios
    spl
    falcon
+   std_passage
    uefi/index
    vbe
    version
diff --git a/doc/develop/std_passage.rst b/doc/develop/std_passage.rst
new file mode 100644
index 00000000000..cd3e5e065a3
--- /dev/null
+++ b/doc/develop/std_passage.rst
@@ -0,0 +1,384 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Standard Passage
+================
+
+Introduction
+------------
+
+It is sometimes necessary for SPL to communicate information to U-Boot proper,
+such as the RAM size. This can sometimes be handled by adding the value to a
+Kconfig which both SPL and U-Boot proper can use. But this does not work for
+values which are detected at runtime.
+
+In some cases other firmware binaries are used alongside U-Boot and these may
+need to pass information to U-Boot or receive information from it. In this case
+there is no shared build system and it is clumsy so have to specify matching
+build options across projects.
+
+U-Boot provides a standard way of passing information between different phases
+(TPL, SPL, U-Boot). This is called `standard passage` since it creates a
+standard passage through which any sort of information can flow.
+
+
+How it works
+------------
+
+The standard passage is very simple. It is really just a way of sending a
+bloblist between programs, either at a fixed address, or using registers to
+indicate the location.
+
+A :doc:`bloblist` is a simple, contiguous data structure containing a number of
+blobs. Each blob has a tag to indicate what it contains. It is designed for
+simple information, like a small C struct. For more complex data, a devicetree
+is preferred since it has bindings and is extensible.
+
+The bloblist is typically set up initially by one of the early phases of U-Boot,
+such as TPL. It starts either at a fixed address or is allocated in memory using
+malloc(). After that, TPL passes the location of the bloblist to SPL (using
+machine register in an architecture-specific way) and SPL passes it to U-Boot
+proper. It is possible to add new blobs to the bloblist at each phase. U-Boot
+proper relocates the bloblist so can expand it if desired.
+
+
+Use by other projects
+---------------------
+
+The standard passage is also intended to be used by other firmware projects,
+particularly if they interface with U-Boot. It allows that project's firmware
+binaries to pass information to U-Boot (if they run before U-Boot) or receive
+information from U-Boot (if they run afterwards).
+
+These projects can copy and modify the bloblist code provided they have a
+compatible license (GPLv2 or later).
+
+
+Allocating tags
+---------------
+
+Tags are defined in the `bloblist.h` header file. For the moment, the U-Boot
+tree is the upstream repository for tags.
+
+Tags may be allocated in the following areas:
+
+BLOBLISTT_AREA_FIRMWARE_TOP
+    A small area for tags of considerable relevance to multiple projects
+
+BLOBLISTT_AREA_FIRMWARE
+    A larger area for tags likely to be relevant to multiple projects either now
+    or in the future
+
+BLOBLISTT_PRIVATE_AREA
+    Used for private flags. Do not send patches with these. They are for local
+    or temporary use. Standard firmware binaries which see these tags in the
+    bloblist typically refuse to boot.
+
+To add a new tag for your project, send a patch to the U-Boot project with:
+
+  - your new tag, using the next available number in the area your choose
+  - a header file in include/stdpass/ containing your struct definition if your
+    struct is not actually used in U-Boot
+  - a line of code in `board/sandbox/stdpass_check.c` to use the struct (see
+    that file for instructions)
+
+The struct definition does not need to match the code style or types names used
+in the other project. For example, your project might use a type like
+__UNSIGNED_INT32 which in U-Boot would be written as u32. Types should be sized
+so that the struct is the same on 32- and 64-bit machines. Avoid using __packed
+if possible. Instead try to order members so that it is not necessary.
+
+Conflicts are resolved before applying patches to mainline, so your actual tag
+value may change when the patch is applied. Once your patch is accepted your tag
+is allocated for all time.
+
+Devicetree
+----------
+
+Devicetree has a special place in the standard passage. One of the bloblist tags
+is BLOBLISTT_CONTROL_FDT which indicates that the blob contains a devicetree
+intended to control U-Boot (or other binaries). This devicetree provides
+hardware information and configuration in a generic way using standard bindings,
+so that it is available for any project to use. The bindings are compatible with
+operating systems (including Linux) so there is no need to remove them before
+calling the OS.
+
+In cases where a binary wants to access the devicetree but does not want to
+implement the bloblist feature, the offset of the devicetree within the
+bloblist is provided. This avoids the need to implement bloblists just to
+access the devicetree. This is a convenience feature intended for use in
+degenerate cases.
+
+However U-Boot itself does not permit accepting a devicetree through standard
+passage unless it is part of a valid bloblist. It is easy to turn on the
+bloblist feature in U-Boot, so such a variation would only serve to confuse
+things and encourage degeneration in other projects.
+
+
+Standard passage API
+--------------------
+
+The protocol for passing a bloblist through the standard passage from one
+binary to another is architecture-specific, meaning it works differently on
+32-/64-bit ARM and x86, for example, if only because of the different register
+naming.
+
+The bloblist is mandatory. If there is no information to pass, the bloblist must
+still be provided. Following firmware stages may add blobs to the bloblist,
+making use of the existing space.
+
+The minimum bloblist size is 256 bytes, but 4KB is recommended.
+
+Two registers are used to pass the bloblist and devicetree pointers. Others may
+be used depending on the architecture. The protocol chosen for each architecture
+should be compatible with the Linux protocol, with a way of determining whether
+standard passage is used. This is done not because Linux might start using
+standard passage, but to avoid reinventing the wheel.
+
+For 32-bit ARM:
+
+  =========  ==============================================
+  Register   Contents
+  =========  ==============================================
+  r0         0
+  r1         0x010fb10b (indicates standard passage v1)
+  r2         Address of devicetree
+  r3         Address of bloblist
+  lr         Return address
+  =========  ==============================================
+
+For 64-bit ARM:
+
+  =========  ===================================================
+  Register   Contents
+  =========  ===================================================
+  x0         Address of devicetree
+  x1         00000001_4a0fb10b (indicates standard passage v1)
+  x2         0
+  x3         Address of bloblist
+  x30        Return address
+  =========  ===================================================
+
+Registers for x86 will be added also, at some point.
+
+The devicetree is provided as an address but is normally included within the
+bloblist, meaning that searching for the BLOBLISTT_CONTROL_DTB blob with the
+bloblist produces the same result as the devicetree address passed here. Having
+everything in a bloblist makes it easier to manage memory, since it is all in
+one contiguous block.
+
+
+Usage guidelines
+----------------
+
+As mentioned above, blobs should contain small, simple blocks of information,
+typically represented by a C structure. Using it for large or complex structures
+is only permitted if these are defined by a standard byte-accurate form.
+Examples include devicetree, ACPI tables, SMBIOS tables and the like.
+There are also a lot of pre-existing firmware binaries which are quite complex
+but qualify because it is not possible to convert them to devicetree now. Apart
+from those exceptions, keep it simple!
+
+For complex data structures, devicetree can be used. The libfdt library has an
+overhead of around 5-10KB which is small enough that most firmware binaries can
+easily incorporate it. For those that must run in very constrained environments,
+like U-Boot TPL, a simple blob can be used instead, as explained in the
+preceding paragraph.
+
+Devicetree bindings must be defined so that the format of the data is well
+understood. This is done through the `dt-schema`_ project, although this process
+is still in its infancy.
+
+
+EFI
+---
+
+When using EFI a different calling convention is used. For example, with 64-bit
+ARM we have:
+
+  =========  ===================================================
+  Register   Contents
+  =========  ===================================================
+  x0         handle
+  x1         system table
+  x30        Return address
+  =========  ===================================================
+
+It is not possible to pass the bloblist in a register in this case. Instead, a
+config table can be used. The GUID for a bloblist is
+4effe9da-7728-11ec-8df6-136969a780ff
+
+
+Linux and bloblists
+-------------------
+
+It is possible to effectively pass a bloblist to Linux, or other Operating
+Systems. However it is not expected that Linux would actually implement the
+bloblist data structure. How does this work?
+
+The bloblist sits in memory with some things in it, including a devicetree,
+perhaps an SMBIOS table and a TPM log. But when U-Boot calls Linux it puts the
+address/size of those individual things in the devicetree. They don't move and
+are still contiguous in memory, but the bloblist around them is forgotten. Linux
+doesn't know that the three separate things it is picking up are actually part
+of a bloblist structure, since it doesn't care about that. Even a console log
+can work the same way. There is no need to teach Linux about bloblist when it
+already has a perfectly good means to accept these items (via devicetree).
+
+ACPI can operate in a similar way. The ACPI tables can point to things that
+happen to be in a bloblist, but without any knowledge of that needed in Linux,
+grub, etc. In fact the ACPI tables themselves may well be in a bloblist, as they
+are in U-Boot.
+
+
+Private firmware
+----------------
+
+Standard passage is intended to operate with open-source firmware. It may be
+that closed-source firmware may use standard passage, or happen to work with it.
+If so, that is a happy coincidence, but the focus here is on open-source
+firmware.
+
+
+Updates
+-------
+
+Updates and patches to this documentation are welcome. Please submit them to
+the U-Boot project in the normal way.
+
+
+Design notes
+------------
+
+This section describes some of the reasons behind the design decisions implied
+by this feature.
+
+Why devicetree?
+~~~~~~~~~~~~~~~
+
+Firmware is getting large and complicated, with a concomitant need for more
+complex communication between binaries. We don't want to use C structs to pass
+around complex data, nor invent new binary formats for everything that comes up.
+The devicetree provides a useful format and is already widely used in firmware.
+It supports bindings and provides validation to check for compliance, by virtue
+of the Linux project and `dt-schema`_. It is easily extensible, being basically
+an efficient, hierarchical, ordered dictionary.
+
+Some examples of how complex and annoying binary formats can become are SMBIOS
+tables and Intel's Video BIOS tables. The world does not need another binary
+format.
+
+
+Why not *just* devicetree?
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Some early firmware binaries run in very little memory and only need to pass a
+few values on to later phases. Devicetree is too heavy-weight for these cases.
+For example, it is generally not possible for TPL to access a devicetree, which
+is one of the motivations for the of-platdata feature.
+
+
+Why not protobuf, YAML, JSON?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+They are not as efficient and either use a lot more code or require parsing
+before use. Devicetree happens to be a nice compromise.
+
+
+Why not something else?
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Possibly. Please propose it.
+
+
+Why not UUIDs?
+~~~~~~~~~~~~~~
+
+Why use a simple integer tag instead of an 'industry-standard' UUID? Many
+reasons:
+
+- Code should be as readable as possible. GUIDs require something like::
+
+    EFI_GUID(0x6dadf1d1, 0xd4cc, 0x4910, \
+        0xbb, 0x6e, 0x82, 0xb1, 0xfd, 0x80, 0xff, 0x3d)
+
+  which is much harder to read than::
+
+    enum {
+        BLOBLISTT_SPL_HANDOFF = 123,
+    };
+
+- UUIDs are more like a hash than a sequence number. Git uses them, although a
+  short form of the hash is commonly shown. Why use a hash to identify
+  something when we only have a small number of items?
+
+- We don't need to worry about collisions in open source software. We can have
+  a shared repo and allocate sequence numbers from there. UUIDs come from the
+  idea that everyone is working independently so people need to be able to
+  allocate their own numbers and be sure that they will not conflict. This is
+  needed in the PC BIOS industry where there is little shared source /
+  cooperation. It is not helpful with open source.
+
+- UUIDs come across as just obfuscation. Does anyone know what these values
+  mean? How would we look them up? Who owns which one? Is there a central
+  registry?::
+
+    EFI_GUID(0x721acf02, 0x4d77, 0x4c2a, 0xb3, 0xdc, 0x27, 0x0b, 0x7b, 0xa9, 0xe4, 0xb0)
+    EFI_GUID(0xa034147d, 0x690c, 0x4154, 0x8d, 0xe6, 0xc0, 0x44, 0x64, 0x1d, 0xe9, 0x42)
+    EFI_GUID(0xbbcff46c, 0xc8d3, 0x4113, 0x89, 0x85, 0xb9, 0xd4, 0xf3, 0xb3, 0xf6, 0x4e)
+    EFI_GUID(0x69a79759, 0x1373, 0x4367, 0xa6, 0xc4, 0xc7, 0xf5, 0x9e, 0xfd, 0x98, 0x6e)
+    EFI_GUID(0xd038747c, 0xd00c, 0x4980, 0xb3, 0x19, 0x49, 0x01, 0x99, 0xa4, 0x7d, 0x55)
+    EFI_GUID(0x9c7c3aa7, 0x5332, 0x4917, 0x82, 0xb9, 0x56, 0xa5, 0xf3, 0xe6, 0x2a, 0x07)
+
+- It is overkill to use 16 bytes for a unique identifier in a shared project.
+  It is about 10^38. Modern SoCs cannot keep that in a register and there is no
+  C int type to represent it on most common hardware today! Having to check that
+  adds time and code to no benefit. In early boot, space and time are
+  particularly precious.
+
+
+Why contiguous?
+~~~~~~~~~~~~~~~
+
+It is easier to allocate a single block of data than to allocate lots of little
+blocks. It is easy to relocate if needed (a simple copy of a block of memory).
+It can be expanded by relocating it. If we absolutely need to create a linked
+list then pointers to external data can be added to a blob.
+
+
+Why bloblist?
+~~~~~~~~~~~~~
+
+Bloblist is a simple format with an integer tag. It avoids UUIDs and meets the
+requirements above. Some tweaks may be desirable to the format, but that can be
+worked out in code review.
+
+
+Why pass the devicetree address?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+In cases where a binary wants to access the devicetree but does not want to
+implement the bloblist feature, the address of the devicetree within the
+bloblist is provided. This avoids the need to implement bloblists just to
+access the devicetree. This is a convenience feature intended for use in
+degenerate cases. It also allows access to the devicetree before the bloblist
+has been parsed.
+
+
+Why use registers to pass values between binaries?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It seems like the obvious solution. We could use a shared memory region with
+shared configuration between projects, but that is error prone and difficult to
+keep in sync.
+
+
+Firmware Handoff Specification
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For ARM, the `Firmware Handoff Specification
+<https://firmwarehandoff.github.io/firmware_handoff/main/index.html>`_
+has been created. See the
+`repo <https://github.com/FirmwareHandoff/firmware_handoff>`_ also.
+
+
+.. _`dt-schema`: https://github.com/devicetree-org/dt-schema
-- 
2.43.0

