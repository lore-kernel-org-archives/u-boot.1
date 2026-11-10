Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA98606A7D6
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cQedTX1X;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=G049tbHf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 869F5813AB;
	Tue, 10 Nov 2026 13:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bAuyXlnCleRG; Tue, 10 Nov 2026 13:06:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B40D813CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315969;
	b=sSM4c4UA3XFfc8bU+ftTir3SpM6raDpSmEb/rkNZwIZgpPu30e+aAJ8sAhlxz1XFt6Oo
	 lOLAXrvMmDlpmuCvQRZhV9QYCKz+ToRVUAmOn5ru6J7aBmvLweBZpTctZr9OFhYD+Ctar
	 JtYEj8W4J12QMzWZmcIdI65xzgDz5LTbd2v/jPS6HayaD5gxf52rA52Bv1SKv7cLPmJiR
	 SdaheoPqjeEF8I4hWOLkyGObI1mWnXyLXrHblnctJCC6Nw/nBX615ade8V6rL7npK0Bwz
	 NunJMihUF56dutcXrIujmctOdVgO7CbehSLED78y3n7vOJDn1T497oRYzOelaucJy3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Puo+xRyxlJGQTQwRpq/6CqkdB0t0HuKT28cDd+LPWkA=;
	b=ax++M/Ozb1cWcB9+ybTmGCPZk+6TaskSOcfDD8NJq9sArIrhcdAhjZ24cybwZYdbZHPN
	 3F9li00Lx+gwCfqz9Pw9R0vV6pppByTLdKySJAQCJ2TZDgrNnFyK6BjAV4A+QMFsFpiZ6
	 MR1eTO7ZgOsJI8gyQjhrJalcvIcCnQIz4a0o0AhzMPTBk+AKxTb+Umka48c5c5xO1n77E
	 uFmrL0j+88fZnjnL7oIqr1fj0g0e6lcEbxHS90+n6wK1ZRwU5Qx0S7cUqgAcI1a71Fpyr
	 Rfb/FgSe1Mq8RRJEiICF5YWjgQe+SW84iOpD9ESIBnbnniMswZyJOQMUZ0/hcWBahyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315969;
	bh=Puo+xRyxlJGQTQwRpq/6CqkdB0t0HuKT28cDd+LPWkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cQedTX1XoAXpffdQHnDWFTeHIar1q2tv34nmbQ/Gko/AYiAqqiNMV4/HI5trAR3d4
	 wEsFCYnbhofjWWXYEiqme/qF3vkXF7kKWnHmXAk7ERPVtMUtI695466dB1iIWhBIuz
	 YeoFTqkzlVm+e5K6Pl3jEKqPLNT9B457F5vp+jSGGCz9AD1F/74lUesI+M5X/gH0R/
	 OwzWg8LV2vGwmCzAXkPgy/UOnSNoKqfdTc83+cz2cg3VEk+HjQGvIaod401jC2zxwB
	 2v4SGYJ2KQdUZxXLvuu/WMvxjP46PCIJ7dpY8Eoug7deNJoxxRaXOuWL+14Z9XXusE
	 SJWl+MZEMMIsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B40D813CF;
	Tue, 10 Nov 2026 13:06:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FA4BAF2
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71E92402EE
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nhy0tsc4XtnL for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 07:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E113F40098
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=G049tbHf
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E113F40098
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:02 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A8F783F452
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794297480;
 bh=Puo+xRyxlJGQTQwRpq/6CqkdB0t0HuKT28cDd+LPWkA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=G049tbHfAL7wXthE9YiZdgcCCkEBay6oD2zMVXq5AtnGf9N/76Pd+Ch+8AiusMdUD
 s4RZQEibj1/q+RcniRdY1bu3ZUDj7GkejYgWaA2gPx1K5uLIleEziZZy7M1gHE7MYL
 kJ4uLUcQ2Hzfw4+lEJGaqY0O0RXfyDiUQqlfKF8v4miQC2V/yS+BOVqW/vcBRXlNfv
 LsdryExoajw5kouo2mIq/Zhyj8cP75pe/96PKMRguw0wy5kFLFdpaJcGVhrblxM1z5
 MNoQmg7zK5ik8zuUOpL/fDlxWx4PyTnH5rCsKT4hiS0rM1Wj4YcCvU9cVwZyvzXb2o
 +iBFzI98TaAwFRLR3Hfi+VzpE1APVAyLZTcVzoJr3pBzA05p86u7ljpIgiL3ABNeNn
 eIV2qjYcEA4HU0y9vNxsXJsFBhuXUz3pW+LY1YDEpGelVKC85wgaO3H2bEbUN1eWkN
 7poS7FBwWPo5DFJDs0o7ZoPq/zpLsiYgxS2B1bvD/xTfn+9kf6oI2qvx/e3hh5OjCC
 LPBCI3+4sMhuT3UtbXB4RChIpx4if/SQPBg7TbykuFt1XDOHgSVLzuLqOZ56l5en/J
 POI9lkXt7COvq6bScF8qzR6rbwQwKaTPpzN4YUI+VET1J583yTOTcznDWxsxd8k0aM
 pUDF26/6ojXxeIagLuOQs1Qc=
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-370230d93efso1936906eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 23:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794297479; x=1794902279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Puo+xRyxlJGQTQwRpq/6CqkdB0t0HuKT28cDd+LPWkA=;
 b=HpSvyE/sXV9+N5i89uRrhQqgcFZsQFKAPQ0mBxALpz30Cg97aJvbfF01jLC2r/3KnP
 BCEyIOM5E832DD5ZUWPXouQNAbocyGBaw4dSXVO7BGLQ3XBgVmc78Sc/WY5kboo/y1Y1
 rgbEarFQD1tqMAlpt0iQkrIY3ML+ZfXaMhuL2+Xy7dvDDFZ48r+zSOlPyqq4OgU5CfQE
 gnahuSBVcQk5ROT2I1p9cpaTRwjVE1vkNuAhy0AuBLqagaNxC2zqNufHjCinqlCZbBl2
 H1wZcJJW7hxDQwr0jNjpcSfcVszM444VdxWB3ugbouJSPLKUlesaUlqWkg8TPKiv0qmD
 W7mQ==
X-Gm-Message-State: APuU4Z92/6hqVRbTvuOUDkZ0+gkoJQ/UktxqpbsUwLEulj8wHJwkTEUz
 ifQ1NnBeWzCUV36Xy4VyDeu+34nOwcvzMEc237thy/N/Jgs9TqQUhrzFZKIf5tp1AHw432VXMBk
 qprb8XZDx67YxWpAATDWhYvRMOJKZN/2oNtE2z3w+5eQT+zwBW3mfmcktecGOzFgR8tf4ylHxt+
 IJ9+4cDluwNdd1jSbljGz+
X-Gm-Gg: AYBFou0bXiAaVkWWBWWe26Ol0i7mvYztteFX3H8NEH8Eu7fv0ML0Mnjt4daYqtSmUNL
 4WYMf9Vo7OXf524bzxUoyQoNOXLxIxmogVpswoh24qYMJ0kEmTVp7GPHLY6pXxGmW0tpuScJWZ8
 fwPWrEyZBt8rvvUJicA8uq/+ZWmZpTcbBnWBwIEUayZ0vTq2SF4c0QZcPBeLmU6CYu13H+70hyB
 bv8PCM7CXeG4azwzsI0dG6wMIZbpiIch8FDdw/CzrzUtmKmFfoq0yi44JElp8soBhPpVMEnFFqw
 vgrysnjj1BCi9uUktIOUJksbYhn69tpWtuI3eqwYR6ZYPaY/XXOzlJgMwomU3YfuXdb83p01oeq
 WQSAxkmDrzLaUAOkW4QKe9cnKqkjNRJIoHq7taE0cpE9F29bWn4FB8gwnUgiZzrCM4KYiKM6p2n
 HgH4o73RCnN7am2AsGsJA5nhy0
X-Received: by 2002:a05:7301:e22:b0:36d:b933:675c with SMTP id
 5a478bee46e88-3751ef74fa7mr3615708eec.17.1794297479031; 
 Mon, 09 Nov 2026 23:57:59 -0800 (PST)
X-Received: by 2002:a05:7301:e22:b0:36d:b933:675c with SMTP id
 5a478bee46e88-3751ef74fa7mr3615669eec.17.1794297478327; 
 Mon, 09 Nov 2026 23:57:58 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe3261csm4212914eec.4.2026.11.09.23.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 23:57:57 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 4/6] test: pstore: check that the zones are found where
 Linux puts them
Date: Tue, 10 Nov 2026 07:56:40 +0000
Message-ID: <20261110075707.1409824-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110075707.1409824-1-aristo.chen@canonical.com>
References: <20261110075707.1409824-1-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set sizes that Linux rounds down, with memory left over for the dump
records, then write a dump record larger than the record size in the
second dump zone and a console record where Linux puts them. Check that
pstore display shows both records, that pstore display dump shows
nothing for a dump zone that does not exist, also when the offset of
its index wraps around in 64 bits, and that pstore save writes both
records.

Also check that the console zone is found at the start of the memory
when the record size is 0, and that pstore set accepts sizes that only
fit once rounded down and rejects sizes whose sum wraps around in 32
bits.

Without the zone layout fix, the first test finds neither record, the
last one fails on pstore set, and in the second one pstore display
loops forever, which test.py treats as a lab failure that stops the
whole run.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_pstore.py | 98 ++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/test/py/tests/test_pstore.py b/test/py/tests/test_pstore.py
index 35836882552..d7178d8a19c 100644
--- a/test/py/tests/test_pstore.py
+++ b/test/py/tests/test_pstore.py
@@ -197,3 +197,101 @@ def test_pstore_buffer_too_large(ubman):
     finally:
         # Restore the default record sizes
         ubman.restart_uboot()
+
+@pytest.mark.buildconfigspec('cmd_pstore')
+def test_pstore_zone_layout(ubman):
+    """Test that pstore finds the zones where Linux puts them."""
+
+    # Linux rounds the console size down to 0x1000, which leaves 0xf000 for
+    # the dump records: 3 zones of 0x5000 for a record size of 0x4000
+    dump1 = PSTORE_ADDR + 0x5000
+    console = PSTORE_ADDR + 0xf000
+    # Larger than the record size, but fits in the zone
+    dump = b'x' * 0x4800 + b'\nend of dump 1\n'
+    # Looks like a dump record, to catch a read past the dump zones
+    text = b'====1.0-D\nconsole text\n'
+
+    ubman.run_command('')
+    try:
+        ubman.run_command_list([
+            'mw.b 0x%x 0 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH),
+            'pstore set 0x%x 0x12000 0x4000 0x1800 0x1000 0x1000' %
+            (PSTORE_ADDR)])
+        write_record(ubman, dump1, PSTORE_SIG, b'====1.0-D\n' + dump)
+        write_record(ubman, console, PSTORE_SIG, text)
+
+        response = ubman.run_command('pstore display')
+        assert('end of dump 1' in response)
+        assert('console text' in response)
+
+        # There is no dump zone 3
+        response = ubman.run_command('pstore display dump 3')
+        assert('****' not in response)
+        if ubman.config.buildconfig.get('config_64bit') == 'y':
+            # Nor zone 2^52 + 1, whose offset wraps around to zone 1
+            response = ubman.run_command('pstore display dump %d' %
+                                         ((1 << 52) + 1))
+            assert('****' not in response)
+
+        with tempfile.TemporaryDirectory() as outdir:
+            ubman.run_command('pstore save hostfs - %s' % (outdir))
+            with open('%s/dmesg-ramoops-0' % (outdir), 'rb') as f:
+                assert(f.read() == dump)
+            with open('%s/console-ramoops-0' % (outdir), 'rb') as f:
+                assert(f.read() == text)
+    finally:
+        # Restore the default record sizes
+        ubman.restart_uboot()
+
+@pytest.mark.buildconfigspec('cmd_pstore')
+def test_pstore_no_dump_zones(ubman):
+    """Test that pstore finds the console zone with a record size of 0."""
+
+    ubman.run_command('')
+    try:
+        ubman.run_command_list([
+            'mw.b 0x%x 0 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH),
+            'pstore set 0x%x 0x%x 0 0x1000 0x1000 0x1000' %
+            (PSTORE_ADDR, PSTORE_LENGTH)])
+        # Linux makes no dump zones, the console zone comes first
+        write_record(ubman, PSTORE_ADDR, PSTORE_SIG, b'console text\n')
+
+        response = ubman.run_command('pstore display')
+        assert('console text' in response)
+        response = ubman.run_command('pstore display dump 0')
+        assert('****' not in response)
+
+        with tempfile.TemporaryDirectory() as outdir:
+            ubman.run_command('pstore save hostfs - %s' % (outdir))
+            with open('%s/console-ramoops-0' % (outdir), 'rb') as f:
+                assert(f.read() == b'console text\n')
+    finally:
+        # Restore the default record sizes
+        ubman.restart_uboot()
+
+@pytest.mark.buildconfigspec('cmd_pstore')
+def test_pstore_rounded_sizes(ubman):
+    """Test that pstore set checks the sizes as Linux rounds them."""
+
+    ubman.run_command('')
+    try:
+        # Rounded down to 0x1000, a dump and a console zone fit in 0x2000
+        ubman.run_command('mw.b 0x%x 0 0x2000' % (PSTORE_ADDR))
+        response = ubman.run_command('pstore set 0x%x 0x2000 0x1800 0x1800 0 0'
+                                     % (PSTORE_ADDR))
+        assert('should be larger' not in response)
+        write_record(ubman, PSTORE_ADDR + 0x1000, PSTORE_SIG,
+                     b'console text\n')
+        response = ubman.run_command('pstore display console')
+        assert('console text' in response)
+
+        # Sizes whose sum wraps around in 32 bits
+        response = ubman.run_command(
+            'pstore set 0x%x 0x%x 0x80000000 0x80000000 0x80000000 0x80000000'
+            % (PSTORE_ADDR, PSTORE_LENGTH))
+        assert('should be larger' in response)
+        response = ubman.run_command('pstore display')
+        assert('Please set PStore configuration' in response)
+    finally:
+        # Restore the default record sizes
+        ubman.restart_uboot()
-- 
2.43.0

