Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CAEE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97CD7871D2;
	Mon,  2 Oct 2023 03:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eKwioPPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92F387161; Mon,  2 Oct 2023 03:15:21 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86BE8870C4
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79f95439795so56193739f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209263; x=1696814063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eWxtMMngdMUnTWa2V2sodCcfeTuRiLLOcS7LMwNOmY=;
 b=eKwioPPCXyAleJ5J/2+Q2JQEYRi+ncVwMB5O6iACfHra5g5ZCpEYQsr/o4/s5yxNHN
 MX7tGlZcQz8qRiNxby7+6Uj0NqdYX5gP0NDsePTJMfX0A07qntvir8wcJCePAfdfAuja
 M46i1kpeStrvB2Ss8yKPty9oxQVGnabZh9NNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209263; x=1696814063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eWxtMMngdMUnTWa2V2sodCcfeTuRiLLOcS7LMwNOmY=;
 b=kX+PSvziJ8GjU1fIDvTVde4Gs4DRJl1eBrcKERo/vK+D6Llc+OP6+HEciIZ/AR3Fwq
 +3g5kPoj3yp8lEPtJTBmJtLKv2CQfzGlknY8TVVM7sacwm7GwLubXGxetf+Nk1/uMAD5
 NG19g2VlvUk2gWh4a21j6fwC3j53dri3ocY1ty0gqhYNXY1dFIV6ojKMRH//wYzs02Pp
 WgBObkmxSAehpWgQ1/AOowYSfRJzrVtWLLsRwKJUCP4ciifn/oiXKZ6z8sREQnWeeoLR
 w3UiGvKiqQj4mXddn5UUVsBjZWepEcM6kOyNjGHh1Qf+J8oouDq6iQW4NzC2oscjvUlB
 tsxA==
X-Gm-Message-State: AOJu0YxdAxbe7Th8EDA9zpbsxroW570C0DgLw0TAJM9ZXS20CLgC+vwD
 4fwlxRwcSCMQILrtpt5YXLm9TXOdC3JX2v25rk0=
X-Google-Smtp-Source: AGHT+IHFao+6vs6mkE9K/+Epx/u5Gd+y7emuDRXCu/znEiCm665eaGw06lYybaoHsH5vSF2DD45oZg==
X-Received: by 2002:a05:6e02:1cac:b0:348:c606:bd1a with SMTP id
 x12-20020a056e021cac00b00348c606bd1amr9384563ill.15.1696209263130; 
 Sun, 01 Oct 2023 18:14:23 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 36/36] expo: Update documentation to include textline
Date: Sun,  1 Oct 2023 19:13:40 -0600
Message-ID: <20231002011349.461284-37-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

(no changes since v1)

 doc/develop/cedit.rst |  3 ++-
 doc/develop/expo.rst  | 48 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/doc/develop/cedit.rst b/doc/develop/cedit.rst
index 63dff9d3f140..82305b921f0a 100644
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
index f13761995d3f..c87b6ec81285 100644
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
2.42.0.582.g8ccd20d70d-goog

