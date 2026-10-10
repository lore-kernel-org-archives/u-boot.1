Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05C5CA9EC7
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AED260A40;
	Sat, 10 Oct 2026 13:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hElmOo0w69Te; Sat, 10 Oct 2026 13:12:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 948816090B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791637949;
	b=WmpMGWI6nzL78cSmjBImmZD67nGYDgP8mGx4S4W2IURL7vZikAb37js3Qoq4TNoLhiZ9
	 SucaM/PTWYlHOKz4PfdgAfaB6DM5ubj8jDVqu9UgQML4T+fqOmrctBVjSqjDRMmOXSCXN
	 KTIizdaZKyR8sS9sNiMXfiNmhVwXxWwYEA1bNMLFg1sbg/M6aq1Mqq0p/EaD0UEi7n8mq
	 gH96MQVEj5nJ8/9h/ehwa68l/IKE7hL5W9ZJe/nxaCDRXNQL17sRE9iXYXkFsCSDVx9iE
	 +7nkTxb5RS/W6VxtTEnUBtYwp0PNrQFyHYieaTM9HXjLLZdR1TVV74U/vR2Oyc40VLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791637949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eQna9oYg7niZHXc8+sYUmaB9BwYMO1qLhpvZVXwhspQ=;
	b=nL06ES0zZ6oU9wwVKvrivGYRy/grkn9erdVUvgARprzheGrM1316esr+wRA978aiaT61
	 yr+CLmOy6Dx011Fim2t8rdOeyr8u4IbJDAQ0atFAobfxGsh3Y73YFNzAz9jbDYUAwE7Ks
	 E8x8ZplZ/NAw19MHnPhgU11deca4TTyfPDJCIeui7XaGvZyl0/pZpMZ+9jZUc7+FqEwq1
	 KZ3yIPYGF2twmy6Js8T5QoCjSmMT5h6cHc9pjvZQYpASAo9DCUNq4JD2jCuHdlmKSLAgp
	 vAqM+cMIs2lV6MIhHSZsTvcbxMB6qU8+mZq97MEEP0WPrU9KJsCEuTc1IPK+OBAhNeA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791637949;
	bh=eQna9oYg7niZHXc8+sYUmaB9BwYMO1qLhpvZVXwhspQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cOAZLzf76aok6PpkXMErLd2mtouz5Rx7wKYQtAHrMTuujCqOqTql8ucZLHIvvjJh3
	 HAdaunheDzKA0fxMinjfGo1Ay1Wd39u/lWOOvOjDcvbZG6ZnFWT4ABO6oDbrvGByZp
	 pSEi0T/GZWtqGHeTTO0XwUkzDevERrgoTd2gtOR/q3atDuzB9oZtMSsMd3I9dXNa4E
	 47i6GeNDwspvRDY9KUCUIft3js67XJqD0LxXDjr7wQLH1OsIJ2dXzllFbD6oRvnb1Z
	 F7wDtIoQ5hCRwnfqpUM2uQd9awsVXF73e7/HlRayn78Ie8mz82MQVkKtlak/DIo2vi
	 /KyeyWW1Sm2PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 948816090B;
	Sat, 10 Oct 2026 13:12:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CE4D22B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F22124080E
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qE6gJqQzpN3J for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 13:12:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B7B0540809
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791637940;
 b=duRGPsLHBq24FgIJ7t3ERK9pbZQBcurqvFd6TPD1bnNDXsMzjBssAO+pHx1x5Ts9uaU4
 VB3eiwXWxSbOrJemMWm9Zvc4bl7kF/aYi1joFx9Dng8VbrzvKxtmiRkvh7ZUMt8vrjvc+
 PhczMt8cZy0wYMdvPyzwYaPlLYuX8k+05K9lIFxz0KNNA1l7UVfTSVbURNT2HZFpgBgZH
 woKAw1qevKOaTKNzCV19+1VKVcClPHO6JW4vHpuW5w5+gU7JW2TWzHIM9OYhX05zoI952
 EMUqNuyn18QczW9mF5TcK7YzJo7Wbfi0xAInTOV/wrk1EiEysciog8qCAkDvYsxFAbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791637940;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=eQna9oYg7niZHXc8+sYUmaB9BwYMO1qLhpvZVXwhspQ=;
 b=Cp3r6lqipsMar8MxUXyc8Fmv5yaZRsbOsDZ2xqE6nrEtaPufcP4aIQD/U7AjbOH4rdov
 2t93B6HzPUrgqXmr5bqlYz00bhEvcXQWcoatNHO1pjc8hzgV6Ghf5s5zD9sAFvvCV0zTy
 XLnvVk9OYBw8cJt76GlCgHwWeUBQmvuBlZLT5tA1xKs/2nth9QzUVvsyuIBfY0iiebD+t
 4c+1gtmVgniy7v+ZjRuauy9mxWCvCpsLAylBaEyGbbhUPT24lHLZf97SuWS2d+O1jKwaw
 nz5JdlEoznp5SwTzlu0+YTJTf3fgazL6RQY2lxWd/GQBg2nPQ7Gfi2febFj53qfz8Dw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=mS82VJ8j; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=mS82VJ8j
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7B0540809
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:19 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso143108366b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1791637937; x=1792242737;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eQna9oYg7niZHXc8+sYUmaB9BwYMO1qLhpvZVXwhspQ=;
 b=mS82VJ8jlWfVMyY87pssydFP0gkkRxFhQb12BgliVs6kf38tlBCFF/ZTSClGJGEGmV
 WHXXxFdlwOU8cUyPRTwkBB5Im5w1ICZ0Zvk9IyFJSrc2Wm7BsI/uA20fqlF4IXbFX05p
 CvuB+tSc3F+LsInWRSecO+e7zoRfs5YCJGAUBkp8E/8qnrJjzobnmJBD/qs4t1DKjYiW
 de7RafRJbEcDc+BZdGnbWh8hMzffGDJ94q5b/TkpF3ZklGGULF+JsnkOwCGAq6duUtN2
 s8sMGvHWZoXuJaChbUJ7z2CgwHe8zceCkFqwuORIXDQYwqr9EcL5IpfU2rTr910hX7k0
 PBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791637937; x=1792242737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eQna9oYg7niZHXc8+sYUmaB9BwYMO1qLhpvZVXwhspQ=;
 b=bY9Q5wjrP3EtnIRw03lXDcnKpFzIfaY1VWXhgZd3ivOpPye9AoRtHC/RVw1n5tUcEh
 Myly0oPRAHOgOg49xL8hxqc8qlAh6OEmJmt3TscWOysI2+Rx4LFfo76Q8OlRbix8C2As
 04nQvPW8AElUYtJvQC0TMAkLRyCtUu0GrbnkCzvPFVo5EUf6dDUfWpWVqaslGDqVMoV6
 C8Tl6RuROxoG87k2g3EE9KvjRno1/V4yiPwxwJhkhgJqlNHND44C25+dHRGejzY4uvEd
 nyrUjJWSS5m35UPSFfhxaV9fEGXa5MvQmujHfsR0sO+/WrPrTgBHY6Tel1+bUXmjcEd8
 SxFg==
X-Gm-Message-State: AFq9FYKxe7wYPQxGhgnPG6IHbylYDkBAw9OwHpB8kPBk5rpnFOprQinP
 6/wsl1rzyQoVIVAfQWzCX7PIDxwyqCLTcwvN4Lg70wMcvcmM9TRfWZX7Mx+ouHmJjUo=
X-Gm-Gg: AYBFou36z5cm87ni0g/V5WVM4AYkhTJwPZB4wJO60TI+2+BGrRUJSB3diLU7HUlvtlS
 cDEvfeWAIJVsNB+bncSwVpyn7fbh6bE25CsDT79e31o6NkORqGbKG1KYk74NVRuUxAEbhEZRofZ
 hukM/3AG+Lg33qqlUof+ke8Yi1KrnNZQUfDJ+I8dFf5wpBjngI+7q7ktev2kn4A5df+zcR0IpWr
 /5g04M1NrCipKHRZVlX28rENKG+g/2tG5sdiooYeEvcnQ1v0dyl7jL7XhqAi/2QIP9VyMLI6yp9
 W1NMdMfXQfz+MtML/VbMk1Po57ixAxQCol2z6sAjARjgu1mbVEzfyg/VZIdmz5w6gq08Yr5K0vk
 rwYBUj5mQVfYDaDob6BhgNwm2XWJqq3R33EAI290uqj91dscbEptD+igLnD1UCyqt7CMIxfU+3A
 7gfrQ9DGv1o4ZFeoKuXtHxJlXKwTXX+7zYmLvmTVFUqEiJMHNucLz3i8dOx6Wsy2+ikXbE8FPXk
 4X+vnldfYYM2TZyATdo
X-Received: by 2002:a17:907:7210:b0:c2d:d4dd:8d0 with SMTP id
 a640c23a62f3a-c31a702e5c8mr507152566b.16.1791637937292; 
 Sat, 10 Oct 2026 06:12:17 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.209.196.154])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a71d42sm240051766b.32.2026.10.10.06.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:12:17 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 10 Oct 2026 17:11:44 +0400
Subject: [PATCH v3 7/7] test: py: gpt: Test the GPT layout on a device with
 4096-byte blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-gpt-4k-v3-7-89fd290f85cb@flipper.net>
References: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
In-Reply-To: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6987; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Ao/wOLPIZOxyG7gi4exFpVOhhnr4peoffJfqNQ1Yitc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSdslzEpq5WeMje02a2StVv7i1CUce63pkzWp9ecZDvY
 5pgZY53x0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFOt+J+R4WWv3IkJZ1P+tne+nTn7JBerUQLDSq8pa5Kibrj+jZAP8WRkuKYveqS
 mLHvm20DhCacETqwp+de9tOf7U8OneREf3wvc5QYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Bind a blank image with a 4096-byte logical block size, let U-Boot write a
GPT to it, and then check the result both through 'part list' and by
unpacking the primary and backup headers straight out of the image. The
interesting assertion is that the backup partition entry array ends
immediately before the backup header in the last block, which is what
regresses when the array size is computed with a hardcoded block count.

No sgdisk is needed since U-Boot creates the table itself, so unlike the
other tests here this one has no requiredtool marker. The number of entries
comes from the build config rather than being hardcoded to 128, so the
expected LBAs are recomputed for builds that set
CONFIG_EFI_PARTITION_ENTRIES_NUMBERS differently.

Unbind the device at the end. Every test in this file binds the label '0'
and none of them unbinds it, which works only because they all bind the
same kind of device; this one does not, so leaving a 4096-byte device
behind would change what the next test sees.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/py/tests/test_gpt.py | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index fb4c8ba67d48..ef592f4d22a9 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -6,6 +6,7 @@
 
 import os
 import pytest
+import struct
 import utils
 
 """
@@ -45,6 +46,28 @@ def parse_gpt_parts(disk_str):
 
     return parts
 
+# Layout of gpt_header from include/part_efi.h. It is __packed and
+# little-endian, and struct.calcsize() of this is 92, its header_size.
+GPT_HEADER_FMT = '<8sIIIIQQQQ16sQIII'
+GPT_HEADER_FIELDS = (
+    'signature', 'revision', 'header_size', 'header_crc32', 'reserved1',
+    'my_lba', 'alternate_lba', 'first_usable_lba', 'last_usable_lba',
+    'disk_guid', 'partition_entry_lba', 'num_partition_entries',
+    'sizeof_partition_entry', 'partition_entry_array_crc32')
+
+def parse_gpt_header(blob):
+    """Unpack a raw GPT header.
+
+    Args:
+        blob: Bytes starting at the first byte of the header
+
+    Returns:
+        A dict mapping each gpt_header field name to its value
+    """
+    size = struct.calcsize(GPT_HEADER_FMT)
+    return dict(zip(GPT_HEADER_FIELDS,
+                    struct.unpack(GPT_HEADER_FMT, blob[:size])))
+
 class GptTestDiskImage(object):
     """Disk Image used by the GPT tests."""
 
@@ -93,6 +116,36 @@ class GptTestDiskImage(object):
         cmd = ('cp', persistent, self.path)
         utils.run_and_log(ubman, cmd)
 
+class BlankDiskImage(object):
+    """Zero-filled disk image with no partition table on it."""
+
+    def __init__(self, ubman, size=4 * 1024 * 1024):
+        """Initialize a new BlankDiskImage object.
+
+        Args:
+            ubman: A U-Boot console.
+            size: Image size in bytes. Must be a multiple of the block size
+                the image is later bound with.
+
+        Returns:
+            Nothing.
+        """
+
+        self.size = size
+        self.path = os.path.join(ubman.config.result_dir,
+                                 'test_gpt_blank_disk_image.bin')
+        ubman.log.action('Generating ' + self.path)
+        with open(self.path, 'wb') as fd:
+            fd.truncate(size)
+
+@pytest.fixture(scope='function')
+def blank_disk_image(ubman):
+    """pytest fixture to provide an empty BlankDiskImage object to tests.
+    This is function-scoped because it uses ubman, which is also
+    function-scoped."""
+
+    return BlankDiskImage(ubman)
+
 @pytest.fixture(scope='function')
 def state_disk_image(ubman):
     """pytest fixture to provide a GptTestDiskImage object to tests.
@@ -330,6 +383,72 @@ def test_gpt_write(state_disk_image, ubman):
     output = ubman.run_command('gpt guid host 0')
     assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
 
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_gpt')
+@pytest.mark.buildconfigspec('cmd_part')
+def test_gpt_write_4k_sectors(blank_disk_image, ubman):
+    """Test the GPT layout written to a device with 4096-byte sectors.
+
+    The partition entry array takes up fewer blocks on a device with large
+    sectors, and the backup array has to end immediately before the backup
+    header in the last block whatever the block size is.
+    """
+
+    blksz = 4096
+    entry_sz = 128
+    nblocks = blank_disk_image.size // blksz
+    entries = int(ubman.config.buildconfig.get(
+        'config_efi_partition_entries_numbers', 128))
+    pte_blocks = -(-entries * entry_sz // blksz)
+
+    first_usable = 2 + pte_blocks
+    last_usable = nblocks - pte_blocks - 2
+
+    ubman.run_command(f'host bind 0 {blank_disk_image.path} {blksz}')
+
+    output = ubman.run_command('gpt write host 0 "name=all,size=0"')
+    assert 'Writing GPT: success!' in output
+    output = ubman.run_command('gpt verify host 0')
+    assert 'Verify GPT: success!' in output
+
+    output = ubman.run_command('part list host 0')
+    assert f'0x{first_usable:08x}\t0x{last_usable:08x}\t"all"' in output
+
+    with open(blank_disk_image.path, 'rb') as fd:
+        data = fd.read()
+
+    # The primary header sits in block 1 and describes the whole layout
+    prim = parse_gpt_header(data[blksz:])
+    assert prim['signature'] == b'EFI PART'
+    assert prim['my_lba'] == 1
+    assert prim['alternate_lba'] == nblocks - 1
+    assert prim['partition_entry_lba'] == 2
+    assert prim['first_usable_lba'] == first_usable
+    assert prim['last_usable_lba'] == last_usable
+    assert prim['num_partition_entries'] == entries
+    assert prim['sizeof_partition_entry'] == entry_sz
+
+    # The backup header sits in the very last block...
+    bkp = parse_gpt_header(data[(nblocks - 1) * blksz:])
+    assert bkp['signature'] == b'EFI PART'
+    assert bkp['my_lba'] == nblocks - 1
+    assert bkp['alternate_lba'] == 1
+    assert bkp['first_usable_lba'] == first_usable
+    assert bkp['last_usable_lba'] == last_usable
+
+    # ...and its entry array must end immediately before it
+    assert bkp['partition_entry_lba'] == last_usable + 1
+    assert bkp['partition_entry_lba'] + pte_blocks == nblocks - 1
+
+    # The backup array holds the same entries as the primary one
+    pte_len = entries * entry_sz
+    bkp_off = bkp['partition_entry_lba'] * blksz
+    assert data[bkp_off:bkp_off + pte_len] == data[2 * blksz:2 * blksz + pte_len]
+
+    # Unlike the other tests here this one binds a device with a non-default
+    # block size, so drop it again rather than leave it for whatever runs next
+    ubman.run_command('host unbind 0')
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.buildconfigspec('cmd_part')

-- 
2.55.0

