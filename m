Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A6606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M661Hgmt;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=jAdzFuBd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DE1C81265;
	Sat, 28 Nov 2026 13:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2JJXDl0yULRk; Sat, 28 Nov 2026 13:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 725BA81282
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871784;
	b=TzA9AAJ536ChOt+zIsqrNP6cMOZOHTR7qrMZeE3p4vSggKw0kt78jPGa5C1r3IjZXm+7
	 +1fklxGhElPRuWhYJfHa9d9itTR8VdDf5bC43367wG7y5U84CGuzNSfO8G7+bjhIOIbxP
	 WBNb6Bc+bHuFF9TKwYDFUikgPF5M8hGuPKYRBKvvT8s6qWwk8m+YlQXfzxoojxpnpSa2W
	 COCUjGeysTkvaZfngKmHkmdoZ1V1cnl0xt2b7/lv1KteHDad68YevHqtIw03kUduCtxzf
	 KxUhc7lwjLAjfyUrk7pFqrfDHNp6FcGX7asVUw0gQ81Ubf7L2Wc1MseRENatpL3Cs+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871784;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gwtznRmkkHcCPj7tmOl3CQmxWasvvAlt4CCVHUA4EKU=;
	b=rLBFp2oHQiRW57z8MHvYBA/N9iCefwLcKDbA7+Z3gqKjjI7GC2C7B32qx2Gy/V0wWEGp
	 /N9PZXKl6piHVyxH4LM7UydmAlsS6pCLoGD6PIbVsfsBIWf68I+b6CgGvfqKyRsdjbqay
	 i8jimIP0BTBaW8pXRZipWA+7Y+LgUECpUJ1BZWD4MTcfVJXe27RxQrLlKba1SpXeAriEk
	 9IpthXzUBw6Ak0ebdSs/MSShW8GSTvRIAq3XLBOuQtSPHHXB5OxL4RrAPFtrO3dVszd/O
	 spJ+cE0rFBZzEFFSVFzN0YhyzoAXND3IgyQTrNDARdZN/L15PHvVhKR+s6dOAO/ZDDQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871784;
	bh=gwtznRmkkHcCPj7tmOl3CQmxWasvvAlt4CCVHUA4EKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M661HgmtN2BpguaGm/EHQUq0MFkMAemIcoXFITZKhqfIC+fBGfrcvfx2C8ECbZvcO
	 hoKxSkSuscAO8Kn+P2Qc7A7sIdy6TSevMGl6K2JCfR2n7yU/+Z6h2NQHsR/fgjtZP5
	 amuL2j9ARhdMTpyi7n5KkpmBbCJDI1Mt0b+GZ3bAimfmKiQuOB77fA9IjeAo1CPrbD
	 osDiTgJlbgExrjtC3L+j3YU+2ljAihG+DA1d7jkUvZMRPdxgF4eSzHr8Alqx7CY2Jm
	 rCNpe48oXyT6c/SX6LFPr4I1tPnAjAgcBPNPM0AJh0V8QSBlOD1HtnkeHEOOsxTZu/
	 PyIjw8juWU0OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 725BA81282;
	Sat, 28 Nov 2026 13:16:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2971C49D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BA85400C7
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sJSNxl_xDJT3 for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 07:48:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8B2DA4008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=jAdzFuBd
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B2DA4008C
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:48 +0000 (UTC)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6818B3F16D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795852127;
 bh=gwtznRmkkHcCPj7tmOl3CQmxWasvvAlt4CCVHUA4EKU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=jAdzFuBdX+CfVfXedwy2G8JAJY6OEolb12ytmlxJsnghCbQUlG7b3amMGJ6naJ0Gy
 8VQ2iq+G3VKZQKvmNP8gb672TYXeDD9jKJR+TTEPseKeqA9sk2WfmsOiNBe1OATdgL
 phxAYUJxmTk2gIY3IaGC2IQt6+CqAMDdwqBn14N7/joqSW6UnEtdZYTW29Dc89+fYY
 4KTFPefbTpugtTw/gQDkqjSIN9Y9H2IDg/34Qz7sTHN3v7TRtorSfJ1BMtAVJMnXK2
 /+mleNT2MkzTWJvmeChy6gKAcBmpCNt8Y+Pzd4sonx+f8tHM9ejfH0TRuJTY7TvbYv
 GiVEUkrbgbIrUUZoYCELjNFpElRELldDRn5we0EJBrb+e9UlCTyfGxXl/by1wnPk8O
 QQl9bnc0fquTThLmIUfb6hAjKPJ4y8X0WyHa4OjZcSwaradchfGdpJPq4YYtl03t9Q
 Qjg9jvyul1CUHkeRY50+tGUQjDNOKxCKpRhfVcR87yzwX3aKT+78tGE7O9YQ8fgYav
 1Yn7SQRuEsrtOiyC5t2x/KjfgHbCTARdH3+kStOCJQ4nTPzFiloKF0nh0G6knkDWOB
 zHAfOkYn39KVgthWADDPpDV3sv2Zu27WN7MIdmduPCt3O4rV7XhlJcPplnCtNaSPqW
 c0O+8ueAEQTCdK2Z4wBQYZZ0=
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cdb45b4ed6bso3110784a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795852126; x=1796456926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gwtznRmkkHcCPj7tmOl3CQmxWasvvAlt4CCVHUA4EKU=;
 b=b+acdqtQqSCDTdAbrQ7kFORWoIW7G/5nU9sPB7ChocgLnoYVnOnGucx6mBVjd9t8w7
 6Wyi3taRp+tQjeteFwEPWQdYD4FYg+Z6rB3hOjkgl85IuKxcGnSFbOYkrZpRG0Op+PAX
 mQ/SreXIlbPkBhhSm0p6+3QrfbCegA8UCxd1RyiDvbqY1kDffPhwZ9Kp/l05pj7b3yA9
 +UrJHG8NF1dF6kcHPbVrGRgts8Ka5II2mzFEU9QiAR/VbMbAe0gb5SV35YUUQ90PiYxQ
 7vpqw3mxz4elI6xijK96TwQibh+BGe4ogGCqz4EcCwgyg0Y+89CQ9MisKj29H8QNIICY
 zdxg==
X-Gm-Message-State: APuU4Z8DykBLrnmyFbk/UCCi+WsNT+QqrCnyinaBcpTehQKRcmcwLEAZ
 UpMmYTpG9dM7OcRlkkyFXMvIfxfhxlMR6P8KNJhgnO8jiklRcGwmcYzeAEf7bWAPIFB3YcLpIs6
 gbaXNt3QyJ1iYKRUO6fee4SCiWpqP2n2frPjxC5zA53t5FkkhgjmfzfLD2ABSXInHNR3w4nHBXR
 4LHxHdPjIhcbjezmPglQ==
X-Gm-Gg: AZFdTZdXJdFfb8u/zjTdMAVbXnmZ539W0nM7MipFhsbZI0rFaEd3ICzy2OSKi+X7Law
 xsmjo71R3+iteGZU60krSPNcBV13D95rjaL3FrH7r31YHVoEA4KqZYGCpA/eAz/IkjhOk6CQOD/
 LJEsIgnPdFrz0Mf53E4EtaD7EzM8j0j5MZ/Hnq966B521Zu/MxxeocdLT7qFvyx39hR9uhvzYfx
 NzuTrr98CQccWZl1OaUGUroaW4Q1lGdBz2/n8VUY3JWBWXtwLaWPVPJ6CJFaHsuCRgXQ9/TPjkn
 houSXs7v7krVwHJ99CPCAUrd+JjdafE7e9tE5NwfqznnH7/pBKX6sB+MkRPu/718lgwmxuO2YsB
 bZQK1XTo2mbsXZSG5hLr1KH6tViJCIwgAQECKL9c9SS+Uh5DZb6EEXYjVs4FOBR5CnodjmnH03M
 tryaEX80aUJTrOeRv6z+NRPksW
X-Received: by 2002:a05:6a00:3ccf:b0:89f:c71e:aba5 with SMTP id
 d2e1a72fcca58-8c87c8657c4mr26848673b3a.37.1795852125828; 
 Fri, 27 Nov 2026 23:48:45 -0800 (PST)
X-Received: by 2002:a05:6a00:3ccf:b0:89f:c71e:aba5 with SMTP id
 d2e1a72fcca58-8c87c8657c4mr26848658b3a.37.1795852125468; 
 Fri, 27 Nov 2026 23:48:45 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e4af1fsm14086238b3a.28.2026.11.27.23.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 23:48:45 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 4/4] test: pstore: check that compressed dump records are
 decompressed
Date: Sat, 28 Nov 2026 07:47:40 +0000
Message-ID: <20261128074801.11306-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128074801.11306-1-aristo.chen@canonical.com>
References: <20261128074801.11306-1-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Nov 2026 13:16:13 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test with compressed dump records that pstore display and pstore
save must decompress: one as Linux 6.6 and later write them and one as
Linux 4.17 to 6.5 do, from a text that the two do not compress to the
same data, and one that takes 3 times the size of its zone once
decompressed, which is the limit. A record that is not compressed
follows the first two. The test also has records that must be kept
compressed: one that would take one byte more than the limit, one that
is cut short, one with the zlib header of Linux 4.16 and older, and one
that does not hold deflate data.

Add a test with a dump zone that the malloc pool has room for, but not
3 more times: its record must be kept compressed too.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_pstore.py | 106 +++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/test/py/tests/test_pstore.py b/test/py/tests/test_pstore.py
index 3fb262253ef..c2496ba7874 100644
--- a/test/py/tests/test_pstore.py
+++ b/test/py/tests/test_pstore.py
@@ -8,6 +8,7 @@ import os
 import tempfile
 import shutil
 import struct
+import zlib
 
 PSTORE_ADDR=0x3000000
 PSTORE_LENGTH=0x100000
@@ -58,6 +59,16 @@ def write_record(ubman, addr, sig, data):
         f.flush()
         ubman.run_command('host load hostfs - 0x%x %s' % (addr, f.name))
 
+def deflate(data, wbits=-zlib.MAX_WBITS):
+    """Compress data as Linux does for a dump record
+
+    A negative wbits gives deflate data without the zlib header and checksum,
+    which is what Linux 4.17 and later write.
+    """
+
+    compress = zlib.compressobj(wbits=wbits)
+    return compress.compress(data) + compress.flush()
+
 @pytest.mark.buildconfigspec('cmd_pstore')
 def test_pstore_display_all_records(ubman):
     """Test that pstore displays all records."""
@@ -379,3 +390,98 @@ def test_pstore_save_zone_numbers(ubman):
                ['dmesg-ramoops-0', 'dmesg-ramoops-2'])
         with open('%s/dmesg-ramoops-2' % (outdir), 'rb') as f:
             assert(f.read() == b'zone 2\n')
+
+@pytest.mark.buildconfigspec('cmd_pstore')
+@pytest.mark.buildconfigspec('gzip')
+def test_pstore_compressed_dump(ubman):
+    """Test that pstore decompresses the compressed dump records."""
+
+    # Lines that have nothing in common, twice. The second half is found 3 KiB
+    # back, which is within the window of Linux 6.6 and later, and not within
+    # the 2 KiB one of Linux 4.17 to 6.5.
+    half = b''.join(b'%08x\n' % (i * 0x9e3779b1 % 2**32) for i in range(334))
+    text = half * 2
+    # As much as pstore decompresses, 3 times the size of a dump zone, which
+    # is more than Linux writes to a zone
+    limit = b'compressed dump\n' * (3 * 0x1000 // 16)
+    plain = b'plain dump\n'
+    # For each dump zone: the compression flag of the record, its data, and
+    # what pstore save writes for it, None if the record is kept compressed
+    records = [
+        # As Linux 6.6 and later compress, then as Linux 4.17 to 6.5 do
+        (b'C', deflate(text), text),
+        (b'C', deflate(text, -11), text),
+        # Not compressed, after records that were decompressed
+        (b'D', plain, plain),
+        # At the limit once decompressed, then one byte above it
+        (b'C', deflate(limit), limit),
+        (b'C', deflate(limit + b'x'), None),
+        # Cut short
+        (b'C', deflate(text)[:-1], None),
+        # With the zlib header of Linux 4.16 and older
+        (b'C', deflate(text, 12), None),
+        # Not deflate data
+        (b'C', b'\xff' * 32, None),
+    ]
+    # The two windows do not give the same data
+    assert(len(records[0][1]) < len(records[1][1]))
+
+    ubman.run_command('')
+    ubman.run_command_list([
+        'mw.b 0x%x 0 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH),
+        'pstore set 0x%x 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH)])
+    for index, (flag, data, saved) in enumerate(records):
+        write_record(ubman, PSTORE_ADDR + index * 0x1000, PSTORE_SIG,
+                     b'====%d.0-%s\n' % (index, flag) + data)
+
+    response = ubman.run_command('pstore display dump')
+    assert(response.count('**** Dump') == 4)
+    # The last line of each half of the text, in two records
+    assert(response.count(half[-9:-1].decode()) == 4)
+    assert(response.count('compressed dump') == len(limit) // 16)
+    assert('plain dump' in response)
+    assert(response.count('display not available') == 4)
+
+    with tempfile.TemporaryDirectory() as outdir:
+        ubman.run_command('pstore save hostfs - %s' % (outdir))
+        names = []
+        for index, (flag, data, saved) in enumerate(records):
+            name = 'dmesg-ramoops-%d' % (index)
+            if saved is None:
+                # Saved as it is, under the name of a compressed record
+                name, saved = name + '.enc.z', data
+            names.append(name)
+            with open('%s/%s' % (outdir, name), 'rb') as f:
+                assert(f.read() == saved)
+        assert(sorted(os.listdir(outdir)) == sorted(names))
+
+@pytest.mark.buildconfigspec('cmd_pstore')
+@pytest.mark.buildconfigspec('gzip')
+def test_pstore_compressed_dump_no_memory(ubman):
+    """Test that pstore keeps a dump record compressed when memory is short."""
+
+    # One dump zone that the malloc pool has room for once, to read a record,
+    # but not 3 more times, to decompress it
+    malloc_len = int(ubman.config.buildconfig['config_sys_malloc_len'], 0)
+    zone = (malloc_len * 5 // 12) & ~1
+    record = 1 << (zone.bit_length() - 1)
+    data = deflate(b'compressed dump\n')
+
+    ubman.run_command('')
+    try:
+        ubman.run_command('pstore set 0x%x 0x%x 0x%x 0 0 0' %
+                          (PSTORE_ADDR, zone, record))
+        write_record(ubman, PSTORE_ADDR, PSTORE_SIG, b'====1.0-C\n' + data)
+
+        response = ubman.run_command('pstore display')
+        assert('bytes to decompress a record' in response)
+        assert('display not available' in response)
+
+        with tempfile.TemporaryDirectory() as outdir:
+            response = ubman.run_command('pstore save hostfs - %s' % (outdir))
+            assert('bytes to decompress a record' in response)
+            with open('%s/dmesg-ramoops-0.enc.z' % (outdir), 'rb') as f:
+                assert(f.read() == data)
+    finally:
+        # Restore the default record sizes
+        ubman.restart_uboot()
-- 
2.43.0

