Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0796C982DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9437D40BBE;
	Fri, 18 Sep 2026 12:14:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UttiOKAULZAe; Fri, 18 Sep 2026 12:14:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2E78640BD3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789733667;
	b=WihOryD4q60byRmgZn50hJlQSghd0xdxJ52+PafF4F2OZZD2RELjKP/GkGcIJr6Os4RC
	 SeKM25IAh+uvJGCcFIBRmFwwX3PltcKZBpLxazyYHCdt9vDVCAIJsTKx9JLScIyPOrVaW
	 tVp3VnHNDmY6EyOv36gZFqNSJrvKbSCg3QJbinUoMI9Ns6orLMOm8fohpu1Gzq41bkvPh
	 jvkua7DMeeAyPsFvJ3eZhCXmMg6KduiD7QL50qrpnRa0Ak6FcNLRZSnNnma+O7zbdYyQN
	 Gpoty6UR87Rr2BXn1Swzt/fp9jdWXZVkMGbEy91tDeHpFOjAqZo7GmGvH/22RhcpAkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789733667;
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
	b=LO9mJErzUmJDzLwOqBULnF5sJ2Zce7jRQp4L+T5ktBqTNjcYoZfwCQFFMmkC86DzVxon
	 1XNdT2rFNl0N85Ck1uBoB388wXgU7R82yYkUL67Yk5bbnwRfI7Z3+Zr4cSOVtkIgNijpm
	 VC684+9yYCOYZOF7LTwCanSvB3MEQw6OOYfXXgjkSp4bRjDJ6UKySsGd8REMqfV+MB5X8
	 FoaJQuzcPgFJ2gnoj7+dEficbW8BikvWu7dxd34gWWTIoLlScfe24i+EX+PdwysQKXaw6
	 p2bVEvlDzN0Rw8C/b2EcrEHr3OfVKA7Mc9NwyNRpXjauOMQAZvaAZajhy+v8bN9THzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789733667;
	bh=eQna9oYg7niZHXc8+sYUmaB9BwYMO1qLhpvZVXwhspQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AUhUI60KMDncx5LqkEe7tM/jDrnLneRaaSUHhMm9TSmM9WUfpUPJK8sbo9De/KEEM
	 Kc4niDKkMIAS5c2y/Sy9LdKoCwM7lBwPHm2ltJGt/J62giJw9SLkFu25oX0smsk1kL
	 WQqGrxFGzdoqi3e8IX0X8UPMAQ/gM5puzQQi5msbGmGcF/YGMwWPpyxsRTQHAvTHVx
	 XNqQIPC+JAco076TcAHEwNk0wp/QEqWvoUXWInACjMdm1v5qP4ZZCDEJDPF+Qe/wNX
	 tVIWrAXHGlx/3Q0HQC/kEPUhDdKyJQOOxx6QAg2t8839wYucwa4HtVLb1lXSYm/rHr
	 GBiMHSrLO2NHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E78640BD3;
	Fri, 18 Sep 2026 12:14:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BC74242D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE58B60D67
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9WWJZdAS_GXF for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AD36B60B9B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789733665;
 b=WrhIxm/GP2/0MW31IxkR0DYS/vM+Os2BKy3W6Uo5mjufCjCug/3JKA3+ik8P4GCaJDGs
 YzGSffhvWuW6XhHrqSIxLFJfsXntqGzVMpnXQA2cpw6CsaTmS/XJWsnOSc5iY00PTSAlb
 utKLqs0DYswUqmsVtRpnlNwtaVapKj7g9pb438KyngriLw/TvScGS0jd4/UepIsv6KlA1
 lQKXjNewCM1+44nNDEUFsRkXZEPh5JFSjdNti/rTMOwG0oEB03UTsxvC3RmGpSxk6T9gW
 OQJ2WXyGuVIIhRBpjnlacmrjosYTLdchC6si/AYqw1zhOP0WM/PND8wAXqsVLKn6jMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789733665;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=eQna9oYg7niZHXc8+sYUmaB9BwYMO1qLhpvZVXwhspQ=;
 b=Kv5fUb54RhFc2Mhm13bDTpK2J2PRsEIBeDTVrv/QSBObELxtELrXRAMZyudAMApg5DBY
 IbenkYqMl4ke+f2S9RoIrltoNJMOSgihIS9eAt6ZrmZRA5bhHQLS6eAGftKhlVEzhfq4Y
 0ji61lkLTC3ENNMhdbYSmaure74nQZkfbk3JnIiPbHONWvWC9OFoD/B0bDFbOBoKCNQX4
 jQXNa7GZiwK7o+kQ6Kb0Z+a1ehuCkulzfv4WuB3h/ZThrJD+l2H8uOcCg5YS45ZvDOVVz
 rHGdnMFXnY8Kv3mbaImit6hnk22dyw/HZvCQJrQ3mhpBaXQBwJyknq7DSAaKc4rrlEg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=w6w7VcZU; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=w6w7VcZU
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD36B60B9B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:24 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so9195305e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789733663; x=1790338463;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eQna9oYg7niZHXc8+sYUmaB9BwYMO1qLhpvZVXwhspQ=;
 b=w6w7VcZUXCoku8AuaISVcXT2REKXc6DGvnrRPtM0Fd6Ae7FS8BNQS6cT+I4FsFTQ07
 9lI6y6ujttfrnRQeQQmo9Eglyb8GitqMYPI0JYhJG9Rpi1xmovBEBhMRJbohneSoWasq
 rDEocdblEyahjACe4eyV/hXA8QUMQA0jgpFIeYnDAELXqj+8n85pdhomj0ZlpCb1DC5L
 gJ6WA5nAy1q3/hz5jBEP9z7pdq3j6Paf5HXR8+n0RUQRCxgCSyE9zRAPOSmiABWofUOX
 tIxJ/A6J3eb9pbkwqui67og/TbW87w583hDqSrHKO1XAiv6zrCQ7EpPpMA1Hd3iRftAH
 Cq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733663; x=1790338463;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eQna9oYg7niZHXc8+sYUmaB9BwYMO1qLhpvZVXwhspQ=;
 b=0mY9UVytSjh3BfIjoQvbjuaTyrmnjVpNA6S8A+kEycrsQuCYMNAnRJSMwegyJ5X1vw
 9cRIdBhGPHvbA11ddU3K4qWtF77zyv+l5sP5n/qa9mXxRbjAz3btDDr8bRN/8dq+pRCJ
 43LjwR1O+sUQqn5yp7AAJfWWHDkGht9WHMTsPyUSUPKsGWPDg1Y02tscbGrhinQIP/VM
 HcVIPe19rLxZB5I9i3blEv0QY8VOqKakqhVrrhcxTrz6c2YJ5l4spjv/URq/0qE0adVc
 59duYE6ndiUlgiqG0vTdV89YqSQDgW9mjuj1zPz/jW1rMBn2Ton2u61biPIW7x84a9WZ
 3KlA==
X-Gm-Message-State: AFuF++lsF1k79kBXmTtFjBQfdg0WrrVbTs3htJvlffMZSNzfywGrxhIT
 5RXE8xoyvq0vt0X+6WU1T3qFhQZ5kv8ktx6wchkuG6PyY93tGuS+IAnG+dkJpsgQPGJLiFobjw3
 yrsBS
X-Gm-Gg: AYBFou1K3YnMcm1epQrMKSihaBmZxwgL5tZViLmUKoGPc6tBzgnt+GZJ+fDB3aU3PAT
 c+ybC6mGa5A82Ruw28V2/2YcWWW4rkE8jaGinCY1uwMxqLuZSiw6IhY0JKcaXf9FWqziHvl3bbP
 HrvNXjniAtfjEeh2ubNwrymo0BmJNhHCbZZkeEviBwKhYWyHefjtFjad9MFfZpXdjSeXeEm86DI
 L0+ZCw3manpNvZaYrdxTlqjvh2+iFlhBgR+Yqt5wL54YdC1AoyM0HNwzQ9/EARB4EqPiopNqGFY
 HH78VycAEjwyTGGfE4V01bnRYsGxdCbUMTQwooSRQZQ7Bij/Co0L7J2XfuUy6H/Xso3+NtZpN2P
 GlIlqYyXPgRWtsJ+8MB3lHomYh7fkYo0h9uUMYcYQv7rmtuXTzEbWLTMPnKF102KHPKk273MByn
 h/wH9LWlUJAqzuG0L6MsumJnoCI9hekcS+kjhqoS/w0ecapKEHNZv8S8EqAxsVq6e/xXPmMPT5+
 sliJIgtBkcp7Cx73V6ItpD2RGf/3Ih/94RGuLZYxuJ7UEam1dg=
X-Received: by 2002:a05:600c:1d0d:b0:49c:e27c:6b10 with SMTP id
 5b1f17b1804b1-49fc5681652mr28892305e9.3.1789733662664; 
 Fri, 18 Sep 2026 05:14:22 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc59286b6sm42755035e9.4.2026.09.18.05.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:14:22 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 16:13:56 +0400
Subject: [PATCH v2 7/7] test: py: gpt: Test the GPT layout on a device with
 4096-byte blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-gpt-4k-v2-7-daefa4792e9f@flipper.net>
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
In-Reply-To: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6987; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Ao/wOLPIZOxyG7gi4exFpVOhhnr4peoffJfqNQ1Yitc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt1eY7O6/N45x827U/j3asfMhil2HmKvv0ha8ge1h2r
 NweVs99HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1o1mMDKvFuDU673V62XOXH/jfJv6w+/4mz5up5i8Uj5heKJ953Ifhv6vEP/0
 XS0V6dTMPrVVewXP3ZW/sgsaT2RMPrGOtmKe9lh0A
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

