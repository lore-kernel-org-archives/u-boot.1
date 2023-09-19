Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02B9CE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F5686C6E;
	Tue, 19 Sep 2023 20:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HziNXhzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48AD986BE1; Tue, 19 Sep 2023 20:09:59 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210F986C67
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34fc96995ddso12460515ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146995; x=1695751795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51QfOLdUoLutM3lqRl/8U6X+ew+4fTNOM0eEOTsmOsk=;
 b=HziNXhzAb6AOnLE4kG+hAIFoktL251DNAOyXsT8dfDttBqLosPEXLkPGrld2n/M1rM
 uz1Qz+9UpXujU9GFXTMUxc2iaK2WRvJrkAaF2IL0yTMbQl2Z90knO8DCNba5FCJcrOWl
 OmnJMsiDqjkMkpDoZCUcmL5+4So+H1AKxuI40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146995; x=1695751795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51QfOLdUoLutM3lqRl/8U6X+ew+4fTNOM0eEOTsmOsk=;
 b=eY64Kjne3dNcDERfsoF3ZsPkPI58C2NlHU0+L/CccwO+VYuy2KYn9iIeiH55bjG6Yp
 KlHw4IeI1TZpdWJYN7eXl/p5fh0z+BJsMkxmGgH5BiDAtvy9uG118LangawkXwP+xUsV
 sRrGguSu+BRZNFqprAfyass7ymaji3jfcblZxcEhDhXNC4s2FIfQd+kgvQQGEhxd3YLS
 WdX6xuknC8ft5Thi1Ryr9JEQDS0GqJDln1AyBY8+eOOL+TJeQ554NyqzFt8taoxmFJT6
 8V2z98QJ3+LRIUz2b6oCQyP1FDM6la/6tS3hCrxjVVgJPcVsAvOaEsxvL3nRff23MO1a
 jNtw==
X-Gm-Message-State: AOJu0YwM70eSEfUOhxyGIfqeF+naCSuUM4K1rEGMtAcLGxK5mNpsrMe5
 1tBY6tiqE1lQqn5lebZ5ZwZrJD9s5KnZM5Tp2WQ=
X-Google-Smtp-Source: AGHT+IG2iddRG7Uk3xOfF9Lux5+ImFVZrfg9stHDWLt2PC1f0cK7FCazT6YlbfRse6enPj5EcZHqWw==
X-Received: by 2002:a05:6e02:1d0b:b0:34f:cf55:779f with SMTP id
 i11-20020a056e021d0b00b0034fcf55779fmr684285ila.28.1695146995707; 
 Tue, 19 Sep 2023 11:09:55 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 36/36] expo: Update documentation to include textline
Date: Tue, 19 Sep 2023 12:09:06 -0600
Message-ID: <20230919180918.2904313-37-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

Update the expo documentation to include mention of this new object
type.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/cedit.rst |  3 ++-
 doc/develop/expo.rst  | 48 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/doc/develop/cedit.rst b/doc/develop/cedit.rst
index 63dff9d3f14..82305b921f0 100644
--- a/doc/develop/cedit.rst
+++ b/doc/develop/cedit.rst
@@ -162,7 +162,8 @@ Cedit provides several options for persistent settings:
 - Writing an FDT file to a filesystem
 - Writing to U-Boot's environment variables, which are then typically stored in
   a persistent manner
-- Writing to CMOS RAM registers (common on x86 machines)
+- Writing to CMOS RAM registers (common on x86 machines). Note that textline
+  objects do not appear in CMOS RAM registers
 
 For now, reading and writing settings is not automatic. See the
 :doc:`../usage/cmd/cedit` for how to do this on the command line or in a
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index f13761995d3..c87b6ec8128 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -63,9 +63,12 @@ select the item), label and description. All three are shown in a single line
 within the menu. Items can also have a preview image, which is shown when the
 item is highlighted.
 
-All components have a name. This is purely for debugging, so it is easy to see
-what object is referred to. Of course the ID numbers can help as well, but they
-are less easy to distinguish.
+A `textline object` contains a label and an editable string.
+
+All components have a name. This is mostly for debugging, so it is easy to see
+what object is referred to, although the name is also used for saving values.
+Of course the ID numbers can help as well, but they are less easy to
+distinguish.
 
 While the expo implementation provides support for handling keypresses and
 rendering on the display or serial port, it does not actually deal with reading
@@ -136,7 +139,9 @@ this is to use `cli_ch_process()`, since it handles conversion of escape
 sequences into keys. However, expo has some special menu-key codes for
 navigating the interface. These are defined in `enum bootmenu_key` and include
 `BKEY_UP` for moving up and `BKEY_SELECT` for selecting an item. You can use
-`bootmenu_conv_key()` to convert an ASCII key into one of these.
+`bootmenu_conv_key()` to convert an ASCII key into one of these, but if it
+returns a value >= `BKEY_FIRST_EXTRA` then you should pass the unmodified ASCII
+key to the expo, since it may be used by textline objects.
 
 Once a keypress is decoded, call `expo_send_key()` to send it to the expo. This
 may cause an update to the expo state and may produce an action.
@@ -312,6 +317,9 @@ type
     "menu"
         Menu containing items which can be selected by the user
 
+    "textline"
+        A line of text which can be edited
+
 id
     type: u32, required
 
@@ -362,6 +370,26 @@ desc-label / desc-label-id
     Specifies the description for each item in the menu. These are currently
     only intended for use in simple mode.
 
+Textline nodes have the following additional properties:
+
+label / label-id
+    type: string / u32, required
+
+    Specifies the label of the textline. This is shown to the left of the area
+    for this textline.
+
+edit-id
+    type: u32, required
+
+    Specifies the ID of the of the editable text object. This can be used to
+    obtain the text from the textline
+
+max-chars:
+    type: u32, required
+
+    Specifies the maximum number of characters permitted to be in the textline.
+    The user will be prevented from adding more.
+
 
 Expo layout
 ~~~~~~~~~~~
@@ -401,6 +429,9 @@ strings are provided inline in the nodes where they are used.
         ID_AC_ON,
         ID_AC_MEMORY,
 
+        ID_MACHINE_NAME,
+        ID_MACHINE_NAME_EDIT,
+
         ID_DYNAMIC_START,
     */
 
@@ -447,6 +478,13 @@ strings are provided inline in the nodes where they are used.
 
                     item-id = <ID_AC_OFF ID_AC_ON ID_AC_MEMORY>;
                 };
+
+            machine-name {
+                id = <ID_MACHINE_NAME>;
+                type = "textline";
+                max-chars = <20>;
+                title = "Machine name";
+                edit-id = <ID_MACHINE_NAME_EDIT>;
             };
         };
 
@@ -474,7 +512,7 @@ Some ideas for future work:
 - Image formats other than BMP
 - Use of ANSI sequences to control a serial terminal
 - Colour selection
-- Support for more widgets, e.g. text, numeric, radio/option
+- Support for more widgets, e.g. numeric, radio/option
 - Mouse support
 - Integrate Nuklear, NxWidgets or some other library for a richer UI
 - Optimise rendering by only updating the display with changes since last render
-- 
2.42.0.459.ge4e396fd5e-goog

