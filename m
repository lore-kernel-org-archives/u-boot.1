Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733E8CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21EF140946;
	Sat, 17 Oct 2026 13:01:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkJt6WliqsRq; Sat, 17 Oct 2026 13:01:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72A9A40930
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242079;
	b=qEj8Ari5cRm1irvaJ3zONKB686EeblPdioOgi7kqntPa2KSvM03btlcyCbJmrxs4+oDh
	 l2G14HZw16JnygzI9szOx3wLgb4zcyuqzR/eN1doAhsmld3aQC+CIXUu09udbixKK/32G
	 9Qj3dk/V7xtXJI95Je6Eh4TIcybT04/G8Dup+N81cr1rLndsdiDDt3B2lvJqs3Wdw7dBq
	 qH4GGtDEuYjZgVDrTH+C9SqE1pKGavy8C6k5roEQDy36xAtieD9y6/fQl0QJTJ/cq9wV+
	 WT2up7tB9r7hbuQrBUgSlaJkYbBbFVpnjTzsdA4emVyoq74LP58+pvZjRqDnHCtk0ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242079;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6PPMq2XdzZd4yWMoxmlFd0rLrq4HfYvZfTW9eEYZ3L8=;
	b=h6t7dKNGix/urBFEnjfQm7FWhsrrPxcF2kfPgWTWItlINywPjeA4PvqHBPXkNLDYtm+Y
	 wqo70lUELQpPIgT0xVeqBCrKPDGlA17yhtqFrU9BJsdcsxNQ6e6Y1TDEO3KlibeMMzRHl
	 /MXGCSda+qdfPV/9O3ikCQgqe+aIM/e5/+FDFgsRqkCrRM+qYh4R9PHIZg9lPx5Vavl2E
	 4TkxucRk/a73sW2GkTfb3bznKZ0Et9jTLAekd9rkMMuN78Azzat2VVDNtvpe3SkYph1r0
	 C6LBuHzhSf/wfHoyZHhjrVUc6QZaL+Df8UdSprcPcUC07335T17SxyEtrHTnb+9iCAQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=DRq139IS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242079;
	bh=6PPMq2XdzZd4yWMoxmlFd0rLrq4HfYvZfTW9eEYZ3L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xQPndHrUISLRUW6xwPsUTr0Zd3CsrrmBA+AR/coCw8dsr98pOci3ohz+bPmNRZZyt
	 hLJfukt67cTRmHfqdeMpjTZL060Zz7RSRV22mxODbvIE5u1j6LbYgCF/YzfUbkLk7w
	 bydTWjaj4b5asVbIS7YqNpERC9LpjC8ap9LZvX+b7ThJT2Nyd4jZBjRneXLejBmcdn
	 rzHL5wmMreVRr6U9aoYvxn/OB/9z25lrpT4bdKq0iw0WjMGkYbWBuqmKgp4fFWR8hZ
	 jWzs6Tr2yBRAeZUGzPsWf7sV0oAV9uwsHwPIw52H0HHX0nsw+rzzykgOAT3CQW6PVR
	 QYkQtz5b/OjIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72A9A40930;
	Sat, 17 Oct 2026 13:01:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DB96465
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F58A4082D
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w35beRSdXnC9 for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 12:36:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61F614082B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792240592;
 b=n2bCEFE80RHYmxZn9u7Famqejx8YT+rrGSEdDF1t1dElD6UJu0UvoYptJRDpHJdOMtJo
 XKjbNLU3VRBFrKa1p2P7YJgomT6Iv3wnsWRXDfn2Tkl+Wwnud5cOoD01/3XrOUgaQvgsX
 Fgc1R0Kj4bIxTiJVEcI3wSU6ZsoSfyKl702XC7a0Ap/Y+6QP3Ec3miH226bnIzeagIek9
 YDczYSgUC1PBWs0+OQabiDtxE2k3UqWaIFat6SN1g7cD3UNawnQyY8+U4FUzKiKN7rXua
 EXhd8QbRjfFVVfM7CVjLBq7zS9V4J02wsMkDKKkR05k1WQj/x8N22G8NIzE/EZz2PMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792240592;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=6PPMq2XdzZd4yWMoxmlFd0rLrq4HfYvZfTW9eEYZ3L8=;
 b=ZPNtM1X6oDP34oXlsO3ug/WBOv8q1D2jCxuX/YZq7/ZVvVh2qBk/TYySSlWUixAtmdEC
 TTM8ecq129AajpM4jKYAoJ3Cccb9Wmym13TSU2LN3yEGcK3xJzdxDq42IOX/f4qWFSyYF
 S/mMrD3qdOrbl7KHCSJnHKf4Z8FEC2sgHkQsJ7aVhGa/KDeF8AqI64a8646TjiBnTX368
 Zs1bevA4qO2wfkLkM6eakihGqkLc6mytdFGE7PlnT1/TnMBIoQpwpMTOO9lSzWHyFEWcG
 wQWL8lJlwujkUR2nNSqHeqXGHwdGGfHIjg5fp3e4KbaL0uKLUKmn5t46G0UE1RU+8ww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=DRq139IS; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=DRq139IS
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61F614082B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:31 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E5C2D3F11C
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792240589;
 bh=6PPMq2XdzZd4yWMoxmlFd0rLrq4HfYvZfTW9eEYZ3L8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=DRq139ISB8IEH0JN01JeQML1turqlRPFhO/zVNF4FgPsalKRStP92RX1vSecugt3g
 teUcYNk9jdVdfgnZ8qnlhigLJWGjACnHt/PSkBYlYRpzAyhZzFcmO6m5CCZi96PktJ
 D3ofdcIi+YQyZr1iGbErSTwHK3y+s2U9cOylu2LfFGvvVDJZKrKtBvZK0vozVWX4wA
 CbhuyG5Y/e4LwIR/Nvtj8CUkk5yZuTFOPjDiip+S1Yxp+vTYKXGn/gvXnPc6rKhtKc
 dGKwoUMs6TplorXQktMyCygXqseVxjPE7LAAPBfnic1ZZGbVIfP30wOWg+xretLfEe
 9uCN37oY6YJLWYutQ3UJMjds6Zuuia/PuzlSNPX5g9Tq0+cqUYLkVB+suagLhfszcx
 OTQ+seRiqDnLTeGFwWxIflrfhVYL6Qd5Z7XeuihKJFResMoaKsSmFB8+NuVJDysZxr
 TNoF+Tp8o6/XdxHhv+oWWFi+RaqczxyvIyOGgzELXdEnVuBpwUC9DqJossnGShRpJ7
 4yTaZQYkDy7gbphS2C89Z8HoK8pHrpwaLbluL9IMQvKYh34VWnuo0u13iOwa5QYN0y
 mkhqZEAIRD/ITWhaXCUNY/pN97OkOa9cRcitsJaBC3JKHZmHV8FnGoj6DtB37fuU8M
 PtuYgIJOAqvzqvks7Pyj6uSU=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso1580948a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240588; x=1792845388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6PPMq2XdzZd4yWMoxmlFd0rLrq4HfYvZfTW9eEYZ3L8=;
 b=fPAyyXYEvVVG6CjZC1fFEjRz5QXhc8UvUNzCwvsoNN9RVenstqeJWfaOLYkvj6AWS9
 IquTxEBp0SPIrGeVb7EIcI8EPvUF7NgZn7XUKKniYTUCP0oH/tBcll3VIFQloYcBMbDH
 z8ub2fIXzWD6rTJ4JzI9aEqLK9Hxf/+WQPZTickXPH8VXgq7IGgTr3/FR7MpgERuZg8k
 dbZpc78ZYjn/uVyoIU8q4dCH5CyAFuxC8EpKhuiZlGIzRdKpAN/HtG9DMeD4zWnsKjky
 5slIro3j8iFywdZK+wHYbhn+9l3+ZDswBpae5MjIp854EfWD/g1/HRoAyKhltWjYEvtD
 yqsg==
X-Gm-Message-State: AFq9FYITdi3U9wa1MaoGHGCUpL2/WMAFSYv0AHYjPC1uZwhAezZJ3CxP
 q88Tn6UhCi+A02bgqznNJii89JCP5yA+pTW5W7QrWzStf82OdKxvkhIKtNS8wdoDGLhxOii7Csf
 541j8mzdpPKPQiiZCA87VugFroTa3vZaP64heHuOmC8xy8Q5PYkyFcXJZ3hGd2TkNIOtruc1KH6
 oGnhlLovHmFddbDhG0DA==
X-Gm-Gg: AYBFou3lYgNAfK/lNWAcdhekxe2VU8jQV/KIpiLV6+bQDlK88opSbV+SoXbe/gI0ZPr
 4h53O/++hJqgVJYM4DKIIOpHrriemegW/hkA57aEMZJ5G2uGK3QLYrIJbD/GsRfXDcyFUxu2gjM
 jCw99atMksBeFS5BMab1Fq4V/xZDx8Da+owp+yL60NSpaPn4dKT2I7tu8y5w5RNt9mVRi6CyHpt
 9Jmdp2k74tUMbbUtwSNMA4KUOejOJuJpYSbZlsGCXo8PB96crGCAnx4jdVvTEeGeTkWVcmm8C4O
 UimK5jE3Sh7LOKhVTSh+szIWg2QeD4q8Z6jSF/oYic7I3jHr4vF9Ur0cLNhTpe5iX9UOieW25if
 Bvu5EaumIyQnC2VNqhbCuWNjfZvLRacGtX7K5lRKJQE5/FCs=
X-Received: by 2002:a17:90b:4e8b:b0:3a0:9640:8039 with SMTP id
 98e67ed59e1d1-3aceebf6ba0mr2325038a91.30.1792240588382; 
 Sat, 17 Oct 2026 05:36:28 -0700 (PDT)
X-Received: by 2002:a17:90b:4e8b:b0:3a0:9640:8039 with SMTP id
 98e67ed59e1d1-3aceebf6ba0mr2325031a91.30.1792240588029; 
 Sat, 17 Oct 2026 05:36:28 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f4cadsm7909410a91.12.2026.10.17.05.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 05:36:27 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 2/6] test: pstore: check that records with an invalid
 header are skipped
Date: Sat, 17 Oct 2026 12:34:17 +0000
Message-ID: <20261017123554.211799-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017123554.211799-1-aristo.chen@canonical.com>
References: <20261017123554.211799-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:14 +0000
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

Write a console record whose start is beyond its size, the same in the
ftrace zone without a signature, and a user record larger than its
zone minus the header. Check that pstore display shows none of them
and that pstore save writes no file. Without the record header checks,
the first two crash U-Boot and the last one is shown.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_pstore.py | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/test/py/tests/test_pstore.py b/test/py/tests/test_pstore.py
index 70e07503ad3..28a60291a85 100644
--- a/test/py/tests/test_pstore.py
+++ b/test/py/tests/test_pstore.py
@@ -10,6 +10,7 @@ import shutil
 
 PSTORE_ADDR=0x3000000
 PSTORE_LENGTH=0x100000
+PSTORE_SIG=0x43474244
 PSTORE_PANIC1='test/py/tests/test_pstore_data_panic1.hex'
 PSTORE_PANIC2='test/py/tests/test_pstore_data_panic2.hex'
 PSTORE_CONSOLE='test/py/tests/test_pstore_data_console.hex'
@@ -40,6 +41,14 @@ def checkfile(ubman, path, filesize, checksum):
         'setenv filesize'])
     assert(checksum in ''.join(output))
 
+def write_header(ubman, addr, sig, start, size):
+    """Write a record header at addr"""
+
+    ubman.run_command_list([
+        'mw.l 0x%x 0x%x' % (addr, sig),
+        'mw.l 0x%x 0x%x' % (addr + 4, start),
+        'mw.l 0x%x 0x%x' % (addr + 8, size)])
+
 @pytest.mark.buildconfigspec('cmd_pstore')
 def test_pstore_display_all_records(ubman):
     """Test that pstore displays all records."""
@@ -75,3 +84,31 @@ def test_pstore_save_records(ubman):
     checkfile(ubman, '%s/console-ramoops-0' % (outdir), 4084, 'bb44de4a9b8ebd9b17ae98003287325b')
 
     shutil.rmtree(outdir)
+
+@pytest.mark.buildconfigspec('cmd_pstore')
+def test_pstore_invalid_records(ubman):
+    """Test that pstore skips records with an invalid header."""
+
+    console = PSTORE_ADDR + PSTORE_LENGTH - 3 * 4096
+    ftrace = console + 4096
+    pmsg = ftrace + 4096
+    outdir = tempfile.mkdtemp()
+
+    ubman.run_command('')
+    ubman.run_command_list([
+        'mw.b 0x%x 0 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH),
+        'pstore set 0x%x 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH)])
+    # Start beyond the size
+    write_header(ubman, console, PSTORE_SIG, 0x10, 0x8)
+    # The same in the ftrace zone, which is read without checking the signature
+    write_header(ubman, ftrace, 0, 0x10, 0x8)
+    # Size larger than the zone minus the header
+    write_header(ubman, pmsg, PSTORE_SIG, 0, 4096)
+
+    response = ubman.run_command('pstore display')
+    assert('****' not in response)
+
+    ubman.run_command('pstore save hostfs - %s' % (outdir))
+    assert(not os.listdir(outdir))
+
+    shutil.rmtree(outdir)
-- 
2.43.0

