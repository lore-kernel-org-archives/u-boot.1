Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B3BCC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B53261169;
	Fri, 16 Oct 2026 13:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O7cCDrlELTo4; Fri, 16 Oct 2026 13:24:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 49FDF61175
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157051;
	b=rzJnJMujZDPSrDjKUgONJ39qCjaJw8/zAqj/1cPIz9vfS4ej4HwUeFwpMKQPaPZnY4ai
	 H4qmJKSTMotXIGzEBugjkdOXdGWsblXzKSHkBfkTMDWPwPXhTjIS7eKxB6VtGc1vEr7Yu
	 hdqleUnRUOqtpO4V5C3wI5NVtNZ8gLyZObV5n+x9LXKXKONEfC4aXtjfI7PEOutufdkrD
	 36xIcATldfarsbRd5TbOArVMpJZulbHLyWGbccDHCTUdzp+QqKGx9RGsIIc16eZ/FaBVU
	 lv3w3otSP6A0+MZ66cH9ps+mnrz9txXavfY/5vHZdawNRDkY2N06NrMouxCeVAEgB0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157051;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pvIKtgapzI4POHaXrCs+z3de+y/y524prpOyqiXjsmQ=;
	b=lAGnhiUvdGhHATjZ3WIyL9PvuW1gSY6QJhX4CqIyoSAwGcjkfpkBlqtrsYKL5WEIw3CW
	 prjF+dM8p8pYmH+u7oV6CjNIocPKTvK9tuW49VPS08uigkLZGAM3ixdJwZMimBqDIcOH8
	 Y8W+tJkVFZc8ViARVyWx0HF44iEI2Isu8UBTVCu3jp/33A+EN3TNXyPiP/RIMG2Q7uHIN
	 TsUszPQTLvHM5a0/UjB3heIhm8ZqZxbzefCJjgV8AXmyJ1BedXnzXTnk+pO4H9I+UIk5y
	 CNqJ4ACfDO/v0fApkZNvzKGOLFP1cZhqQSH1N0z0KchYBazbdKG1tPAYI24ZsUtDRcg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b="RHaagb/r";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157051;
	bh=pvIKtgapzI4POHaXrCs+z3de+y/y524prpOyqiXjsmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J9TM3CfSiQDRX8+YGyfH5TdRt7l594COOKeYUsKdZ0Q5+b4UW+23YbGFqd1nETrje
	 7kBJMofuB7FTCoyQrN2TYsBXpI7yRzQN9iuPyqk82kjPXtFEJIM9vbz304Fm627NEN
	 rMJV7+MZVo2Jf/dkiGfFI5HHqnzI4qRTbCzkmiRUkBsGP2hNluzROVzKSeFpHy9IZF
	 3+vaongR84kYmAxvRg+a1ynq2dgLGJFBAHbRbfVEF8AfEWbAuSSyESO38lOOLiYNHu
	 qU7X+MMdxL2uGUVuTeWSEBqzEcVr0cROTisFPXgkbtlSl7lwDHn/z0jEhrTwsNGQf1
	 FvWUlCI+q+Tgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49FDF61175;
	Fri, 16 Oct 2026 13:24:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBF93362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B99ED60A72
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id APG-Az47Jz-u for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:18:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC0526079B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792138690;
 b=K0nr4Cj+5ZfDH+AXUgtNpWstkNu0IcEFTZRlDjoOEG2CkTcnoQdbgwSlBR0B2CiW7GP3
 oWH7SCRUK7QsQapvON/gJsxFvZLIOvJk+81T3fh45T5kJ3L/C2yYmhoFLOrP65pvu+p8Z
 Zn0U95Q/QAjYhzgtSORE+gP4FiOtx4gjeJPO+wiHTmF3/c9A5cQDfjSytwTq78S1coHJ4
 aH/kCCl4eNIlOMz3zP2xVK03mB3knkYIWPsDZJ+qfIcHQVf7YtQ/Fc+LEvgBBwAHi2OP9
 8ZuyIB3XIMcfb3udwsuld1mnonRmHtmG2SoqBskGCUyYZpBo9uca2ZSIuywSDtFoPEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792138690;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=pvIKtgapzI4POHaXrCs+z3de+y/y524prpOyqiXjsmQ=;
 b=XlAeqtExbwDc3CJ1BpfbXftJbyhx9qHyTVrQIbi1yuo5yGgflFNrlwGbuyjUtg/DewJY
 hz5kBQ/HoWdzObtR61OvanmYaohqJeCVEa7ee8I4KDFmas9KSC5hJjsQhPh2Y2A0okIQs
 4sSo4TZUCKpiPirQRr7U0iVMP1mihlUJxq8ojyBhxJ76NezcURzb6Zqv0jjU/pLQ1LCs5
 yXeqU+zeoA+Wsp2fOeZNyuySOuvn6TBEf9UeU7c15Uxxety2HsxGAUbvU/YDsMMkVmj3u
 9Bl4uf4gokT0CPcf4NhhzUompOiASWv0BJi7lqSAh/E3ARvZhW1mMgNWHOEDUZD0SyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b="RHaagb/r"; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=RHaagb/r
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC0526079B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:09 +0000 (UTC)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0FBD54103B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792138688;
 bh=pvIKtgapzI4POHaXrCs+z3de+y/y524prpOyqiXjsmQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=RHaagb/rUZMq1l5WxyKl7slQBdRHcXvaSZYbX4KbdhHkdOnhU+iYRFXnAMvtGWmQJ
 EIV1XzrYPI7ZnfZHS3wL+VY+QRhr0Z+A8pyNZF1UMRCj/d7JzSrtJr4II+iIK88+B2
 mtAxAwr1sax8U6ZKqYlqgVLeO/muZDuQGySLwJQKZXy8ebQK0rsNX1NpYsNYkQ7HsR
 qMm1A7t8cRF0fGJPQxFy8X644Q0nZEoYuJAA8O4mFcFNCm6ylB0bM2MW/K6vfVLqXB
 kvfGm0VXQOqqAYhd6ub+FbWaKYyEyhQo5SUuWbEGno49Q/RMYWsBgy2OrTFvRKNl6h
 uiXE8vj8kYeVXvjyJwbOn6QI5B6T5bRnqvHm41/yhTAcAzLZlm00zLTfP1c2H2rGHe
 K5lycGJCqY28lgV76K5O2QqOg/WYFsyT27/WDX4YQQz9NwpfKqlrv23QlhA4nKKAuT
 j11GEPhvwBYOiVFVcuII6EnvMrb3u9QjgPeuhJNTuphDfULrj3wcvnuEM8szmV5N3c
 6MYhC0bFK8uIywqekhn7Dpg8rxFrRGLwoawTQnRMl1DBwSEGKddHl5RX6umcI77Y3h
 Oa8TYkegXSDef+ubTMMs73ui7IXm03sNMcrUWuSWbUmjF7l+bMCBwieukbCQDW7WWI
 fi3yRjTFFvQeCZp3mtOoHAxQ=
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so828758a91.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792138686; x=1792743486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pvIKtgapzI4POHaXrCs+z3de+y/y524prpOyqiXjsmQ=;
 b=wCz9nMZE6YrufMH/6zTOMyis4gVCbPIaS9A9uLvV+oZKz0ts+vmJhlRwig0R86gx3B
 i/2cbIBPWu240bAybXoDqj3uzZ2AoZLT3bUkEwYcspzDVm/IPDnK/hVv6NWpTRjsgNaD
 7hXyGTd/5t3dS1HT0Yc+HEWmd4jAcghjl+dH2ASX7vFJ0ymF659yXE8jGBL+Qs3fuUj0
 ITQxkixNS/uy5Rk1kVx8XQPSypjApcMkVrkq8oxmNbvaHvAvS37xnFDy5pQjbqwac9l1
 lABhdkOr/1WK0WhFkrTVAOervEcLuwy2+ICbNUt2LllA9ho0pKkk/ZAHXtnjDKn74F0n
 0l/Q==
X-Gm-Message-State: AFq9FYLwJh5ymUthRDmS5TJfs7/2ea4zE0yFTYWYCPbvw0/j+Pn569na
 js2Obopaoume3OmIsMDobQNdDpFfOeYgT15XjwEY1F1c+WpmQfUoBAEzYhd2jrwhEx2xeu05plp
 cWX7gB2eXnpB33ElwmXCF+Cwk+vneVTHpBmrDWWEENP6bAhtHMG7SR5cmCVj7bt8EVadTyFGdLM
 zMry88MFiW8KRp4fhtOQ==
X-Gm-Gg: AYBFou349pBLIXYvRzaPMf2YjlD6vkbY0c0xYRCU4CvQHI0P9C1ybTW5SAkOv5Tm61k
 Qhdiuh3rNmL3XidFZIRJWTuRsxsHEDfKXK2IhRqMmf9F4Q+lR5PhfhOvP+c/LBnVMIOWwMqy7ZO
 dmsgP7aXsUObU2PwCPorndGG/12h6Y29munLOYmj1i7gLR4IXnHVdvvGE2uhrxxH+NvybCpgDxv
 BiFCmkR9pQxV4QL5Xgv8qJ58q81y3X9IeQ9fB2x0oUs1YLCFknh2d4KSycW/g6CKysUfy2+On9z
 pi9B6/63bgMou8Elk4vLxYCuh7QMrCsFtdzRhUecOE+fHKG83YpaBRYXKRDCBsz1NKzVrCTGytq
 MSlQL1R4Yj+YioL4JuayscA3H/L+T7weUPVcdflZiwSNTMS1IpSntXh3uXf5gojCnFA==
X-Received: by 2002:a17:90b:2c86:b0:3ab:330d:6e47 with SMTP id
 98e67ed59e1d1-3acbb7b6d77mr1688571a91.10.1792138686352; 
 Fri, 16 Oct 2026 01:18:06 -0700 (PDT)
X-Received: by 2002:a17:90b:2c86:b0:3ab:330d:6e47 with SMTP id
 98e67ed59e1d1-3acbb7b6d77mr1688555a91.10.1792138685857; 
 Fri, 16 Oct 2026 01:18:05 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9474b52fsm9149405a91.9.2026.10.16.01.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:18:04 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 5/5] test: py: cover invalid external data properties in
 fit_import_data()
Date: Fri, 16 Oct 2026 08:16:27 +0000
Message-ID: <20261016081719.814357-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016081719.814357-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261016081719.814357-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Build an external-data FIT, then point one image's data-offset far past
the end of the file and, separately, make its data-size run a few bytes
past the end, re-processing the result with mkimage -F each time. Both
must be rejected with a diagnostic naming that image. Previously the
first crashed mkimage and the second silently imported the bytes beyond
the end of the file as image data.

Also check that a FIT whose images are all empty, which mkimage -E -p
writes with data-position past the end of the file, still re-processes,
since an empty region has nothing to read.

Finally, check that a data-offset or data-size that is not exactly one
cell is skipped like a missing property, so that mkimage finds no data
for the image and fails. fdtdec_get_int() already ignored an empty
property, so that case covers the length check the import now relies on
in the accessors. A property of two cells used to be imported from its
first cell, so that <0 0> made the image use another image's data or
left it empty.

While at it, correct the comment in
test_fit_import_data_missing_offset(), which said that the hashing stage
reports the skipped image. mkimage stops before that stage, in the
cipher pass, which runs first and fetches the data of every image.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
v2: also cover a data-offset and data-size of two cells, rename the
test to test_fit_import_data_prop_len and reword its comment and the
last paragraph of the commit message, as suggested by Simon. Neither
names the hashing stage any more, since mkimage stops in the cipher
pass before reaching it, and the comment of the existing
test_fit_import_data_missing_offset() is corrected too.

 test/py/tests/test_fit_import_data.py | 96 ++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_fit_import_data.py b/test/py/tests/test_fit_import_data.py
index 95f7114243e..7ce59291953 100644
--- a/test/py/tests/test_fit_import_data.py
+++ b/test/py/tests/test_fit_import_data.py
@@ -3,7 +3,7 @@
 #
 # Test mkimage import of external data in fit_import_data()
 
-"""Regression test for stale per-image state in fit_import_data().
+"""Regression tests for fit_import_data().
 
 The import loop used to keep the data pointer and external property name
 of the previous image, so an image node carrying data-size but neither
@@ -11,6 +11,11 @@ data-offset nor data-position imported the previous image's data and
 then made mkimage abort without printing any diagnostic. Such a node
 must be skipped by the import and reported by the later processing
 stages instead.
+
+The import also read each image's external data at the offset and size
+the FIT declares without checking them against the file, so a region
+reaching past the end of the file crashed mkimage or imported unrelated
+memory as image data. Such a region must be rejected before it is read.
 """
 
 import os
@@ -107,9 +112,96 @@ def test_fit_import_data_missing_offset(ubman):
     fdtput_keep_data(itb, '/images/kernel-2', 'data-offset', opts=['-d'])
 
     # Re-processing must skip the malformed image in the import, so that
-    # the hashing stage reports it; previously the stale pointer made the
+    # a later stage reports it; previously the stale pointer made the
     # import write kernel-1's data into kernel-2 and abort silently
     result = subprocess.run([mkimage, '-F', itb],
                             capture_output=True, text=True)
     assert result.returncode != 0
     assert "Can't get image data/size" in result.stderr
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+def test_fit_import_data_out_of_range(ubman):
+    """External data outside the file must be rejected, not read"""
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    params = {
+        'kernel1': fit_util.make_kernel(ubman, 'oob-kernel1.bin', 'first'),
+        'kernel2': fit_util.make_kernel(ubman, 'oob-kernel2.bin', 'second'),
+    }
+    its = fit_util.make_its(ubman, BASE_ITS, params, 'oob.its')
+    itb = fit_util.make_fname(ubman, 'oob.itb')
+
+    result = subprocess.run([mkimage, '-E', '-f', its, itb],
+                            capture_output=True, text=True)
+    assert result.returncode == 0, result.stderr
+
+    # Point kernel-2's data far past the end of the file
+    fdtput_keep_data(itb, '/images/kernel-2', 'data-offset', '0x40000000',
+                     opts=['-t', 'i'])
+    result = subprocess.run([mkimage, '-F', itb],
+                            capture_output=True, text=True)
+    assert result.returncode != 0
+    assert "image 'kernel-2': external data" in result.stderr
+    assert 'outside the FIT file' in result.stderr
+
+    # A size running just past the end of the file must be rejected too.
+    # kernel-2's data comes last, padded to 4 bytes, so 4 bytes more than
+    # its real size always reach past the end.
+    result = subprocess.run([mkimage, '-E', '-f', its, itb],
+                            capture_output=True, text=True)
+    assert result.returncode == 0, result.stderr
+    size = os.path.getsize(params['kernel2']) + 4
+    fdtput_keep_data(itb, '/images/kernel-2', 'data-size', f'{size:#x}',
+                     opts=['-t', 'i'])
+    result = subprocess.run([mkimage, '-F', itb],
+                            capture_output=True, text=True)
+    assert result.returncode != 0
+    assert "image 'kernel-2': external data" in result.stderr
+
+    # An empty region has nothing to read, so it is accepted even past the
+    # end of the file, which is where mkimage -E -p places it when every
+    # image is empty
+    for name in ('kernel1', 'kernel2'):
+        params[name] = fit_util.make_fname(ubman, f'oob-empty-{name}.bin')
+        with open(params[name], 'wb'):
+            pass
+    its = fit_util.make_its(ubman, BASE_ITS, params, 'oob-empty.its')
+    result = subprocess.run([mkimage, '-E', '-p', '0x1000', '-f', its, itb],
+                            capture_output=True, text=True)
+    assert result.returncode == 0, result.stderr
+    assert os.path.getsize(itb) < 0x1000
+    result = subprocess.run([mkimage, '-F', itb],
+                            capture_output=True, text=True)
+    assert result.returncode == 0, result.stderr
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+def test_fit_import_data_prop_len(ubman):
+    """An external data property that is not exactly one cell is not read"""
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    params = {
+        'kernel1': fit_util.make_kernel(ubman, 'len-kernel1.bin', 'first'),
+        'kernel2': fit_util.make_kernel(ubman, 'len-kernel2.bin', 'second'),
+    }
+    its = fit_util.make_its(ubman, BASE_ITS, params, 'len.its')
+    itb = fit_util.make_fname(ubman, 'len.itb')
+
+    # A property that is not exactly one cell must be skipped like a
+    # missing one, so that mkimage finds no data for the image and fails.
+    # An empty one must not be read from the bytes that follow it, and one
+    # of two cells must not be taken from its first cell.
+    for prop in ('data-offset', 'data-size'):
+        for cells in ([], ['0', '0']):
+            result = subprocess.run([mkimage, '-E', '-f', its, itb],
+                                    capture_output=True, text=True)
+            assert result.returncode == 0, result.stderr
+            fdtput_keep_data(itb, '/images/kernel-2', prop, *cells,
+                             opts=['-t', 'i'])
+            result = subprocess.run([mkimage, '-F', itb],
+                                    capture_output=True, text=True)
+            assert result.returncode != 0
+            assert "Can't get image data/size" in result.stderr
-- 
2.43.0

