Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A078C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2EA2869C5;
	Tue, 15 Aug 2023 00:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mXnbsmmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF6CC869B9; Tue, 15 Aug 2023 00:41:26 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78684869C0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79095499a16so181232439f.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052883; x=1692657683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwMGfVc9oMBs5QsOYS/j2gLnKxxnU2ImfKV6Ln9bD5o=;
 b=mXnbsmmnl6PJJjseiOzAvibOxH1WrKfHJkYMrvLozdZldRHjTxnUN60GjLFBEDPuMd
 BYzGsMafpL0PcvGMWhQ77905chHImU0iK3BEHI14cF/zijBa2hsVWQ+zNK7Bdc3u8Uh+
 47r0IqkXn3ojTapjp6AfRQZAedCvUMUzcEj6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052883; x=1692657683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RwMGfVc9oMBs5QsOYS/j2gLnKxxnU2ImfKV6Ln9bD5o=;
 b=Os3Z0rrY6BzSQUmYZahge3QJfqdH/qkBZBEqfLOotcd2Bq0rlhj2aUuavTrgq92KNt
 LuOaQmPd1NZAv/2qD7J4pQ9QKrarS8BOJiscdQArl+1UonfFndanGJfyJ4vML5xng3xy
 ukj6cOZtnFkmD6b1rOc+VlwqzjOt/8YYmq7li+1U+gt7DibCaojrGBjX2UqOmgJ0/akO
 3lmkV2yVYzThvBbs4c/McFtzxTWtokOfToaQh/tIpyba4N75Q+z91gl5SH29pZXWNrp9
 DzwabrY2WWa2Hl5Lq6cRuvA7uLBKFoOYHbhFLLnaEwBjJW76lU0ouoKSzbt33eho1zQ0
 MaBQ==
X-Gm-Message-State: AOJu0YwHuc3X/TtQ9Gvbs3WFhAsR1RUQrCVueuStki2mQRWaYZC1SYh8
 26Bv+WxRbrtqQQkdMBwmcOf8ZrrkjPRVlKCvPuE=
X-Google-Smtp-Source: AGHT+IHAYNMY8dk8V0hQ4Zt7WEQU/S6iEEnXRIpSIfodUSKjJCA7RB9ZcvOWW0XxyHG4XGztxv+SOQ==
X-Received: by 2002:a92:c249:0:b0:347:7399:e9c1 with SMTP id
 k9-20020a92c249000000b003477399e9c1mr16883374ilo.14.1692052883001; 
 Mon, 14 Aug 2023 15:41:23 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH 09/19] expo: Add documentation for the configuration editor
Date: Mon, 14 Aug 2023 16:40:29 -0600
Message-ID: <20230814224047.535491-10-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

This is mentioned in passing in the 'cedit' command. Its file format is
described under `expo`. But it would be better if it had its own entry
in the documentation.

Add a new 'cedit' entry with a few details about this feature.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/cedit.rst   | 147 ++++++++++++++++++++++++++++++++++++++++
 doc/develop/expo.rst    |   3 +
 doc/develop/index.rst   |   1 +
 doc/usage/cmd/cedit.rst |   2 +
 4 files changed, 153 insertions(+)
 create mode 100644 doc/develop/cedit.rst

diff --git a/doc/develop/cedit.rst b/doc/develop/cedit.rst
new file mode 100644
index 000000000000..48262ee535e9
--- /dev/null
+++ b/doc/develop/cedit.rst
@@ -0,0 +1,147 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Configuration Editor
+====================
+
+Introduction
+------------
+
+U-Boot provides a configuration editor which allows settings to be changed in
+a GUI or text environment.
+
+
+This feature is still in development and has a number of limitations. For
+example, cedit only supports menu items (there is no numeric or text entry),
+provides no support for colour text and does not support scrolling. Still it is
+possible to use it for simple applications.
+
+
+Overview
+--------
+
+The configuration editor makes use of :doc:`expo` to build a description of the
+configuration screens and allow user to interact with it.
+
+To create a single-scene cedit for your application:
+
+#. Design the scene, i.e. the objects that need to be present and what their
+   possible values are
+
+#. Enter this in .dts format
+
+#. Create a header file containing the IDs
+
+#. Run the 'expo.py' tool to generate a .dtb file containing the layout, which
+   can be used by U-Boot
+
+#. Use the :doc:`../usage/cmd/cedit` to create the cedit, read the settings,
+   present the cedit to the user and save the settings afterwards.
+
+Each of these is described in a separate section. See :ref:`expo_example` for
+an example file.
+
+
+Design a scene
+--------------
+
+Using a piece of paper or a drawing tool, lay out the objects you want in your
+scene. Typically you will use the default layout engine, which simply puts items
+one after the other from top to bottom. So use a single column and show the
+prompt and value for each object.
+
+For menu items, show one of the values, but keep in mind what else you need.
+
+
+Create an expo-format file
+--------------------------
+
+The description is in the form of a devicetree file, as documented at
+:ref:`expo_format`. Since everything in an expo has an ID number (an integer
+greater than 1) the description is written terms of these IDs. They each have
+an enum value. which is typically taken care of by the `expo.py` tool.
+
+The expo should have a `scenes` node with a named scene as a subnode. Within the
+scene, add properties for the scene, then a subnode for each object in the
+scene.
+
+All object nodes require an `id` value and a `type` property. Other properties
+depend on the type. For example, a menu has a `title` and an `item-label` list
+proving the text for the menu items, as well as an `item-id` list providing the
+ID of each menu item, so it can be selected.
+
+Text properties may have two variants. For example `title` specifies the title
+of a menu, but you can instead use `title-id` to specify the string ID to use as
+the title. String are defined in a separate area, common to the whole expo,
+which contains a subnode for each string. Within that subnode are the ID and the
+`value` (i.e. the text). For now only English is supported, but in future it may
+be possible to append a language identifier to provide other values (e.g.
+'value-es' for Spanish).
+
+
+Create an ID header-file
+------------------------
+
+Expo needs to know the integer value to use for every ID referenced in your
+expo-format file. For example, if you have defined a `cpu-speed` node with an
+id of `ID_CPU_SPEED`, then Expo needs to know the value of `ID_CPU_SPEED`.
+
+When you write C code to use the expo, you may need to know the IDs. For
+example, to find which value the user selected in `cpu-speed` menu, you must
+use the `ID_CPU_SPEED` ID. The ID is the only way to refer to anything in Expo.
+
+Since we need a shared set of IDs, it is best to have a header file containing
+them. Expo supports doing this with an enum, where every ID is listed in the
+enum::
+
+    enum {
+        ZERO,
+
+        ID_PROMPT,
+
+        ID_SCENE1,
+        ID_SCENE1_TITLE,
+        ...
+    };
+
+The C compiler can parse this directly. The `expo.py` tool parses it for expo.
+
+Create a header file containing every ID mentioned in your expo. Try to group
+related things together.
+
+
+Build the expo layout
+---------------------
+
+Use the `expo.py` tool to build a .dtb for your expo::
+
+    ./tools/expo.py -e expo_ids.h -l expo_layout.dts -o expo.dtb
+
+This uses the enum in the provided header file to get the ID numbers, grabs
+the `.dts` file, inserts the ID numbers and then uses the devicetree compiler to
+build a `.dtb` file.
+
+If you get an error::
+
+    Devicetree compiler error:
+    Error: <stdin>:9.19-20 syntax error
+    FATAL ERROR: Unable to parse input tree
+
+that means that something is wrong with your syntax, or perhaps you have an ID
+in the `.dts` file that is not mentioned in your enum. Check both files and try
+again.
+
+
+Use the command interface
+-------------------------
+
+See the :doc:`../usage/cmd/cedit` command for information on available commands.
+Typically you will use `cedit load` to load the `.dtb` file and `cedit run` to
+let the user interact with it.
+
+
+Multiple scenes
+---------------
+
+Expo supports multiple scenes but has no pre-determined way of moving between
+them. You could use selection of a menu item as a signal to change the scene,
+but this is not currently implemented in the cedit code (see `cedit_run()`).
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index 0643283ae481..fde91494799e 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -358,6 +358,9 @@ The `expo_arrange()` function can be called to arrange the expo objects in a
 suitable manner. For each scene it puts the title at the top, the prompt at the
 bottom and the objects in order from top to bottom.
 
+
+.. _expo_example:
+
 Expo format example
 ~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 263d404b4ca8..730055e273e5 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -37,6 +37,7 @@ Implementation
    driver-model/index
    environment
    expo
+   cedit
    event
    global_data
    logging
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index 8e1110c7c77e..3d815bd27af2 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -22,6 +22,8 @@ It makes use of the expo subsystem.
 The description is in the form of a devicetree file, as documented at
 :ref:`expo_format`.
 
+See :doc:`../../develop/cedit` for information about the configuration editor.
+
 Example
 -------
 
-- 
2.41.0.694.ge786442a9b-goog

