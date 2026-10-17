Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59210CCF2CE
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B02C60677;
	Sat, 17 Oct 2026 13:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8rWbCel3XbB; Sat, 17 Oct 2026 13:01:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B44B60686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242086;
	b=CcDUYxqQjVKqflA7ux6aIGRRIstTsYCdTB+PYvtLGndB/6m/osXxhrZdacdg1S7uwSPM
	 pxo8QFuATbtOOxrJa8v99QNJ/tI2gXIxnWcF6PU2cYyavB/KfQ4QzI8SC26q+b3MLtsaD
	 0w3GXOoaE4eRwsxRcaZxjdFfEPCmObhTZca2Gukupn95aECNQdGxqc1qEHNhpXvgrYp/C
	 eooixNYhds4gsUasSp6a0a9n+2wrUncgJPIQvxZv6yJQPLs4OT4Sp6MIs/5pl5svjbq+C
	 OqTN5ysl4SX5mUXrPfXghqZypmv2GYc/rudtGHtcb6XoEra/MgjbIGlonvrk5izAxrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Hz7PLQ5eHgtpIUB+Hvd8vUVcp8BTgFtjqw29VF9LvvA=;
	b=PxeElNsTIiYkL+y+1RNyDqJqvIZ904+1A/pubBekoD2EN1AF4o4xzBmTqSDqAjXDBxQC
	 +XYlkFv7I4YXCja9Y7EKw1VvcyGrsLxrJnbbaMPV+HFMQw8yy4PGPzU6Z37mSIyZyDqJS
	 VcsjyfbnbqNO8iMmpDg0wCPdif5dCkHSCN9DX72ituYqMmc73Vvkt+QqFq/Q+AcA5BIDB
	 0JZawICrhKHME46f8Roc8usbP6YrjxM5bp83cw1oe5m89DPkPWc44jQjNtrNLqrsGirIp
	 KncUiFE/6KgKfwfXlhWCApXDjCtUGLjyQUdrnd68triKnJNQQTV7D3YLLjx4LVOwhLg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242086;
	bh=Hz7PLQ5eHgtpIUB+Hvd8vUVcp8BTgFtjqw29VF9LvvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lw5RnxMMEbyt1eQ4eQJx0WZDGpYoJ7qmjtyCS0mIpTr0Cd01je6uYmfDmCiFfM6Zb
	 donCsyP9PfJtwBdKSori8nmyly+TUx7Aa+Q84plruNPmTVJg/zptXsmjSFYJyQiz+l
	 MEvWNvqre5E/SYiI3Kbj8V6NypwpJJhK8nmlR+C1Tdw1YBy/SnmdAdugkrU2cG2eDP
	 yvpfpAZlX10Gnw9n03AfQY7TMYCc7nFVdp52D5OdXC6ft3YZw1JHQYZiysTOqYg2KD
	 Z4vVwNS9T9QgfptpXBM/BC6hj7tPKO37dH5XDn+6wFzFb0ZTE24FoJ5GiDax2gYOY4
	 2piC0PhH+mABg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B44B60686;
	Sat, 17 Oct 2026 13:01:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BDE5E2A8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A44D840082
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10wCDSOyDQBt for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 12:36:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EB82E40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792240603;
 b=VVq2HT/0vw3Fu7bG/wRrkvMGRFkO/jWkkmBGvUeqs8VUDShQFdRgEE9pH9lAinrc2yYC
 vVyfHIBdUyvZwYPFSFO+ppbl5VegdaG0c07w8IiyIoDeU8H3zpWpP3QgeFu6JRk/+FuTH
 LLb75mbE61eKtDQOpXAtSqIcMImMoqvOhXCFizWTH0e4DI61nws0iybW7FEH3EZvVbVRI
 /hPLoiGQ114kgtokLehZv1pNgYoZF7N/bQI6XBk+g4bCKr6kx5Kq2Fge0fTm5OM4Et0Tv
 0gs9oYrKCY1N06jRlxA6XIw9DYQUcCx22Paur7S6qDeHBlEn9zksm4Z8T8RZMTirqtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792240603;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=Hz7PLQ5eHgtpIUB+Hvd8vUVcp8BTgFtjqw29VF9LvvA=;
 b=pR3Dw8RfB9ABpCcNzZFvKfKLgNxZdl1zvq1nM7XQ7uiiHH4OUKIvf2+pRXBpiGW32BSF
 Htxn6O1s+X9z9vrgk/UyHXc5Yoa8pNeeW7ZIyFYiZwI/SGrVmnsN4VPZ1tSICapiSJxfT
 cz6HqvITXNXcI7mjYXNHOQrWjXDzVub2Nt156/BRqT1jCyi7UT0VI/NrWdTuCGBDIteCy
 M3EsfSi8Y7NzTzqVx+vkJxbcAPqZa1h/ozn1l6ctfvts9uZ9sHbUCGW8UIEw8xzm5fPam
 ZUHGCqYcrpmDWkNQiYkC5rZx7Fs5mhsyL4ZVEfXeQ8K3GIrxEmJIB/xkoqnfyHvqJPg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=otiPmjJP; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=otiPmjJP
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB82E40024
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:42 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B29C73F162
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792240600;
 bh=Hz7PLQ5eHgtpIUB+Hvd8vUVcp8BTgFtjqw29VF9LvvA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=otiPmjJPcX7Z5VgFkYnGhvzcPpa9ZoeSNUI2XoTzgIqvvg1Incl+oHQSLqyKlGqCz
 IT4sYOCV+kHKG9NH2PbpaRZ8GUO/mXjuISjUXfRd93w+u5q+iFkVy/3rj4wUZOmP8x
 Ymc5Qh4tFEn8YsrF1t7wiXiZzWrKnXzTOgaBPE2GO68F7sEYrt6zsOmICSAg4xcTiT
 ap6z14/BYJpOaB2M0XjfTP5Q6hfrBDNdfbzJ5uI1xsO4N0mFfARWFEYFe2+3CG5AUI
 9eG/Jmh0VrsZgSGPNKX//xGXK16u/D0kmeGCBHAQcuIy2EIgQr/VgYXGL408izdweA
 xeh2bKw1YRZze9OkQZr+1Ma2ofjXj/aiPnVam0YajSgFgog24NWvuFDPDOVMzMKiNI
 tTdg9TY0RHnz6gnIYecpivwCr15RsNNNvL9pd8wr5HcapdFy/mEH71oN9vLotSoA8H
 slzIil50qi4EIns1bujxyRHgwGmJwyeyn/ZFqb/Jq2ioPA4Fy/zB9IzgaK/P5Ii1z0
 FDhwO1MY5OZSCNNjXrI5+Tb5vnDRvjrrT7O0/tJcFTi1zdcJ6Yc18mQJyXIt4fbW3T
 igyFH9oUE294/vb4bJDPtKvrknNfniFGEIapXRFk8kI6DNyHbosPwSMSSMJcj9mY0P
 4xdxuU/kasCBqbBtt3GSH+E4=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso1085921a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240599; x=1792845399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hz7PLQ5eHgtpIUB+Hvd8vUVcp8BTgFtjqw29VF9LvvA=;
 b=Ipkx24ZSZnzsHMLx05hx3y1vCdpcV8iSy/TpW5OQOh7CaYlTEZNbdGABU68eAFFEDU
 lx/ZdbRzS1d6xvy7AOk/jBPmgnut7SrWsaJ0P3pjB+w/Suv93fP4HdUSWwQ6A6Q/oJ2W
 D1TjZDWe7Qhi41hwvWGoL/HGaip/diiSK+dwYnlho+ymDgIckqlBoZwhgWKrBOJ5WD/p
 R2ofzYrH0YpY5MyJwoN6htOeQl2eS9YLe6ZBXbSNNecuPjGZ9TcbKTIEvUwwi011fvN1
 8An8uOzXHoipz4Y/tCSBh14H8jLUUIUvN5RyAiRyACT9lQIKjh4sN+ipNGheU4j6vI2J
 c5QA==
X-Gm-Message-State: AFq9FYItDxTRyhrgXyeFcNYJpS5m8cg/Air0LTWTGBVU7yrFeNDh0FWR
 i2aVvZsblEkMB+tGGRzvOQ7At6rU9jQrjU9cX+cskKNPvkFLcZx+LA/cqD+o9y6F6x3TIgaBjQK
 LFeWc6CPaSjYLEKM5efLx4/c6r3q4I1JLIv1619/pvf5THrtY4Tqhi/S+TY3xlajLKFY8fZe77S
 LXN/wNDdZGlqL3ag82Uw==
X-Gm-Gg: AYBFou0aGRpIQ5GGQEh75Zk6lf3VQ2LWGc5MXY9nHT+K5Z6fI4MlWwsrJ7T/PxOBt7W
 mxQ9wfPsN0cnmKFJYsmgsPh00NqHUS8T2JfzAsNI1EyBpnj7acl3m0RGlQrLRzbk7KYN5S8/R0f
 4c9pqLOmxsmXJlLta7pKqvy+3k56Wx8fU35Q7wL2uh8osjv765S1qGR/4JMMXhoF29j3mj+BTKr
 rBl+Aeb7adpJGLLXq7jqozpaBj+QoPVfQ2BxL4G2VcqJ/9kSARtjocZAdByOCszsAKpfWgB0J/z
 DhbftdV1X4gN3Dpo/6Dlr9h2KU/knmGi+YY20mSN5y+QzfAjZeXNWkBKbXrcncGFqDiPQ43UlqX
 k5XJOV00b3wc9lCzirSQFGC4kZtmDpVlIW1efP+/hCXcprpU=
X-Received: by 2002:a17:90b:580f:b0:3ab:2d46:1dd2 with SMTP id
 98e67ed59e1d1-3acee728d3emr2327477a91.6.1792240599109; 
 Sat, 17 Oct 2026 05:36:39 -0700 (PDT)
X-Received: by 2002:a17:90b:580f:b0:3ab:2d46:1dd2 with SMTP id
 98e67ed59e1d1-3acee728d3emr2327458a91.6.1792240598747; 
 Sat, 17 Oct 2026 05:36:38 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f4cadsm7909410a91.12.2026.10.17.05.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 05:36:36 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 6/6] test: pstore: check a dump record whose header line is
 cut
Date: Sat, 17 Oct 2026 12:34:21 +0000
Message-ID: <20261017123554.211799-7-aristo.chen@canonical.com>
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

Load the sample records and cut the second dump record inside its
header line. Check that pstore display shows only the first dump record
and that pstore save does not save the second one. Without looking for
the end of the header within the record, pstore display shows the
second record with stale data of the first one, and pstore save writes
far more than the record to dmesg-ramoops-1.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_pstore.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/test/py/tests/test_pstore.py b/test/py/tests/test_pstore.py
index 6c1d5eef2d1..d2d4273d6d0 100644
--- a/test/py/tests/test_pstore.py
+++ b/test/py/tests/test_pstore.py
@@ -143,3 +143,23 @@ def test_pstore_set_larger_record(ubman):
         ubman.restart_uboot()
 
     shutil.rmtree(outdir)
+
+@pytest.mark.buildconfigspec('cmd_pstore')
+def test_pstore_cut_dump_header(ubman):
+    """Test that pstore skips a dump record whose header line is cut."""
+
+    outdir = tempfile.mkdtemp()
+
+    ubman.run_command('')
+    ubman.run_command('mw.b 0x%x 0 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH))
+    load_pstore(ubman)
+    # Cut the second dump record inside its header line
+    write_header(ubman, PSTORE_ADDR + 4096, PSTORE_SIG, 8, 8)
+
+    response = ubman.run_command('pstore display dump')
+    assert(response.count('**** Dump') == 1)
+
+    ubman.run_command('pstore save hostfs - %s' % (outdir))
+    assert(not os.path.exists('%s/dmesg-ramoops-1' % (outdir)))
+
+    shutil.rmtree(outdir)
-- 
2.43.0

