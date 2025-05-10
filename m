Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5925C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3A582BD6;
	Sat, 10 May 2025 15:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ecol9rPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4B582C2F; Sat, 10 May 2025 15:44:22 +0200 (CEST)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388A082952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-ad21c5d9db2so307952466b.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884659; x=1747489459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FledNIehwSRz6rOMauD8TMowenKPLm4V61DLvXZizDc=;
 b=Ecol9rPMnTbVwB3baCnPHazw+Z4V/dDOE6m/8kh5cnZpjYydufQKyf4APLunUdOSDI
 MdotXgqb+AfXd7yqGCoHeA5DtjaE2TfdCRoL5I7JLiqDzw4mfrybrLgphh+Y946ae08J
 vznE7F66ZiC3sz8Ais3CwP1LwkdF7PqZ8tgRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884659; x=1747489459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FledNIehwSRz6rOMauD8TMowenKPLm4V61DLvXZizDc=;
 b=b2j3Q0sh80K8GkvQNQ41bIChgdGRzDw3lhjAHvKTvWMDhhp5EsmAFfiK7S3VOiuzow
 IIM5EDnJhGgNmyVkq5fPDPm/0jscEtGi+WgAVJbzMbYkEohpzGJv5FiLNJW2Amf7dpEr
 NxfLUC43XxJAPk37TcqRwxhMtUm4d9kkRsDZ57GSbTn3j5SzVVW9Aq6CqBgM2AItKx9d
 FXKr4Naspj937DLD0vLST0XHPw1MS0VTYLPwlXcX14O5dcuo25ZnrteOsH/+8gggApc6
 Hxq8i9CAJLHWzrjJEW7A6mUHkBdHTOR4PRGtQRrIK1iKMmeMBehtkNZDJO+XoSyJhdX5
 eymQ==
X-Gm-Message-State: AOJu0YzCw0Mfb2C5DKzw8QDdqGpPI4XfdefSSNrg8a8TVE8tPYyDrAt8
 YliZJ0OmXJ3gZwQ1amPbrrcAjLvriUOni1BohQcZhrcE78UX+8llWUkvJmhXqap2jmoAFUaj45I
 FUlOzT5q+A2FS
X-Gm-Gg: ASbGnctACnQO5pD97A/aSiaXSDveeyJN9zC36w0MnXZruoXjC8rioLgQfRa35pqt5/R
 5adASx1CSeIA+NNFRlhfXCevMA2zYb7Pj1L4KzddI1exKkECr3QftkT00a2vivYaLzqySfMjzKr
 qRy6wf9g2/XDHKz40TBJggV/sz40FxZb/mzCZctwZN8CONvn05izYdBIWOfcdFEM6CdjA24MS2E
 LUQn5s1w/jSEpVEL27not33xHcPTxDSRuuprQ9ffWsGrp+W8b0COQj4hQWkbn65fkDSm3hu8r5c
 Src8V+X7yDy7I+r7bGBJT0t6ok4R2EjhWJVWN6GHDsEi9okqwisgI8uMUzzCCsJ0f9dL
X-Google-Smtp-Source: AGHT+IHzZhvD8YPhVm7YyVnPkN3AQ6S36gGcRUlDLyPiM6AHetcwalza7KHFpaBkLHEQagcVdlo2QQ==
X-Received: by 2002:a17:907:a313:b0:ad2:3fd9:961f with SMTP id
 a640c23a62f3a-ad23fd99de8mr113934766b.30.1746884658464; 
 Sat, 10 May 2025 06:44:18 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:44:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Dahl <ada@thorsis.com>, Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v4 19/22] passage: Add documentation
Date: Sat, 10 May 2025 15:42:17 +0200
Message-ID: <20250510154214.v4.19.I91d5b9ae45e8d1081b1e165620ad1946bd69af00@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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
index c907f8c9c2c..f4cafcc6603 100644
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

