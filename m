Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA800606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hexlukeu;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NJO7mHPH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C212810D0;
	Sat, 31 Oct 2026 10:36:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wAgkGDI-KnBd; Sat, 31 Oct 2026 10:36:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9DFBA810BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793442973;
	b=aoeojC+pSR1FhYzFOWMNu01F/CEoKoDTX9P9RiQGzRZL0VubnzzvTzENz3wSQkyyZdkC
	 CgR3S0NWBL8+q3+wUmxVWqlDscNngt3EPy3HN0pfXGdeA+vuNSh+XRiq17AyttIl7rnZu
	 yPNTbvm3qnLxuUDJMqK5YUqnaqzaGctBd0fbzd8uHryRvCOsM0nPzKlS8c9tPtgIuixw7
	 qILVwGOE1cq3P64F7UHR+QC5fX2WkzJsQt3kvfUMiHgqbRVKlTM3SpAV+vlAmX6adzCi8
	 n0Lc1RcaywE30N8KOA/cHWapdLXXvYnFdXpMlVYTXYNeM1VgqMg84Y3CLHERJwuHcnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793442973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8+LZej+01KSDbnUMbhnaxjo478tN0HKOFtNw92VfyoA=;
	b=piRoVBUcAr4xGudsf+VjAZ5uGGC6YYu6Kd/LEQpXo4uIErKKbAfb5GDV01DZdwK+POU6
	 y1lXaeDd0PWTk2K6V7XmrHZ6XvZmgaw9WS1lNoqwkmuuPdl+iKKXmrfIAp28dyT6VNQnw
	 2c2EowalaSC3J3IOFA1unwf1hdn9fK6w3GiNvaOXdVqZoyViH6WP9EzhJvG/iaPX9r0FM
	 JgZRPzAuMeWO9o1Rtt0r5KfNKXsT4SiD6wa0fkqOdc/aL+Pun/BAOcz963bu3UDOYcJC7
	 RESbaweeIUuQwam+KkbA/CVxpmxQyI0Hjjuhw/cgNsR4+6f61le15Vtv47VqZfgFAHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793442973;
	bh=8+LZej+01KSDbnUMbhnaxjo478tN0HKOFtNw92VfyoA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Hexlukeu2qGBdsti7TZXM6LvNKdr4lSabfxNvjcwyCPqjVKnj+1I6XI4kRz/xZR8L
	 QUdRI2F9RikVycL+I1X7zvhf8fvTl1vVtAQAqbcbXWdnffHNfS4Yvyr/99YZFf92CS
	 19XBOiNvZE8LVeGvpr6CETllkBsW5XOcfnraXMnL4CAypKFj8YcI0uohydnrJWBw/w
	 OTC5CPkoAR7apy6IrxVKmtGwddKUpVBXBp7ASCEyFku/7fX4nIOxUBYiaOyDeywPbN
	 Vo951KQROUlJeCMXvBISZixDXT04oznQQbbvy+4eNLxgsGlReC5s+ABSFI/SVBgwB6
	 i59lTocrMCXOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DFBA810BB;
	Sat, 31 Oct 2026 10:36:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 18B5B362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 10:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 097E040057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 10:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uIX9iMFO3PsL for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 10:36:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E00694004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793442971;
 b=CUqK7ClgZGkFoxPLgylXs+o25IebWlnPhjh2fdbOsbWyyUNr+rCOssDKC1At4nkvivut
 NdQ7bDozgxH9Z0QbcK/h++x8hxRSd4XLp3IxWRI4h0dldKNyvPfCZ/NZZw8tIGFvZsl/q
 NHaFsCGFaXeN7n7eVRi8Mv9yOMpdrxQHGiGw/3Egedb/rYnIoIf2kYktN6hKdK1f4bS1P
 CJ5g6itDZG5ZjKOjKzgVY3NqrOnel+HU8d0sJCwZWBcwaeILLOBJIgiBXD1OUkuAFlw5L
 fNKjhBu2huUpLraiTHeiSbPJyo4Yjhd/mNCcADTrB3wafFwnAAGiGzFltC9fOLuSJXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793442971;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=8+LZej+01KSDbnUMbhnaxjo478tN0HKOFtNw92VfyoA=;
 b=te0Yy/O4FGE3EnGZ4yW9V+LtvDN/02zgiSKNgFEChhw/bd14cJB7C69PFCYmEa8Xg6S2
 XDWzhqaGfxe48bJrjGWklnXYhHkDsZYx3xYEvENIhBqZ5cfAau3yIOu9at61zORq33vYL
 WNQq1AR8EW2GBtDif+gOmFhgsVTX0wRdAD1QhpbKNdiAOIFa3cDdHeHi/EMzeEgkUoD2/
 u+3rggWVFQCm/B1XflSWjeFHMeqhb16L3WHCUyvQXVUKOAMx0wSeqPubmvHpcKxYY40DL
 eS4vM66G122wF0SmNx90ebBd3YspAOTAUeXQmDeZM7n8txzGym6uF+hDZ+cJC4L27Gw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=NJO7mHPH; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22b; helo=mail-lj1-x22b.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=NJO7mHPH
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E00694004D
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 10:36:10 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-3ab4354db11so13472491fa.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793442968; x=1794047768;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8+LZej+01KSDbnUMbhnaxjo478tN0HKOFtNw92VfyoA=;
 b=NJO7mHPH/UQ/ttEZHxd17ABzrcLX4D2IbMhfru5efMw1+Bfex+j1wHHQCB2YlKd6k4
 1vVonxiZELG3ioiM1uLFsRKgRun0buN458xm8QaWsDo9CC3zlGI/dxEZX2G8YMdzxCQS
 U81EGLBV0/tS4SH9XA8BFlciySiUA3iVIIABsqMEBmJpsNbCFN5WIyKt8d4OyJoKDDbi
 aUf7PUwVrKmj1QR2I7tXkkw6KAiqY0XxoIGxazhLK2rloTCDXMKZ+JKDUHEiDEdkeZCb
 liaQzLquz5OrC0aEP+lU6CCoJ0PIScc12+ipRJYdJLNAT2OEfRFH2nm5SVmfCzZ6GX/b
 bZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793442968; x=1794047768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8+LZej+01KSDbnUMbhnaxjo478tN0HKOFtNw92VfyoA=;
 b=YMpJV5c3Uvjq8qWysetTnW35DHY5QkKk4/1o7zuHcBA7zqiNM/N9nvyIzyrQqYbg8A
 fuFiixeSDb7g/fvKEadcdkJ1aM0EzfkKxK+O3dCt2tIo9Dv0K/v5GvPKzyP2Mo+3o8Qf
 J/T01l1UXply1sTYsXkke2cjkhB9U9RAB4hiO0JoeS6lQw4tsFwJPrAWcXkhlmwAjskQ
 YVXuv7FLeTsd4caR/spQ6e4buZqsUiDK76xoEDM/wxJyhSOS/WU8nh2ABVxLynBRlkth
 OcBGqvzuZSgIMMCuywYWGXHskESOBFNCaCGiNt4Qc2K72YlwXhPPbRE1QhCBsK1d+U3S
 gHyA==
X-Gm-Message-State: AFq9FYL5BcSGfxnutmbTLotL0aGlSsfp275gZYRMFOzviIAxi/7c9gcN
 ZU7IHgs1hUr0B/9vRwlo8kf/i0r2AT3CtfMsDSNl6A0ohxKMAPINhKFe8GRYzQ==
X-Gm-Gg: AYBFou2oJvnrwPNLByTLMeTkY6/lOi2MZO4Alq7VEwSsql9rIFcAOVRdIYEybFZJbey
 KBTkNhbYOwvScC7SErjPB9P5I4KWn+nT1sqGjmGglkZIlAcc9DIJiLZItwExOhoz9Y9fUSbESN8
 ZX9wVC9nujycZKfLnN75h1jhJ1HYpfGUJqdeiQY3TTb3kZALTTm/0OZw75B/ZwXfy8K+t2DZ3RM
 s2qjIVLj7TQfeN9z+8HxFBdZoE94mKbkK7IDVv0iU94Ou45ptsCFJSROTJtAcz+Pn9pjvc3+pz8
 wUYZ1GVhkMYdv6QOeUtxv+eAPfcmwFxi8gfiN0tcGbCSXlpi3Bv4bUu4KWiDEbemtrQvKNhlr4U
 gF11Qkv4QvmAUnSRKN7qTkEtbk4jPvq4Gae0RFSabvFyhUAZp+GFPraqTVItOUlfHCiIYVxoKEI
 6tU2HQ/VE4LlD+yAsivrs442YeYYdZDhcr5d5AVILh+EfClnZCRgb1FiZGY+L2fxIm7cEkqYoJE
 v7GmMtD0puB/OnbEFNRLXDUTrESMSVctlCX5nx36F6JbGdeN6Oo9L+31MSzjsB8M0aXezHzbVh1
 uol8lEgtDJpa8C6PkzR/2BZ8I6NC7P1/cbafHH3ZlQ7dc0wihn2DiLaxI3dQhS1V8yPmIlpiWfv
 QpQ==
X-Received: by 2002:a2e:8a88:0:b0:3a5:e792:2dc8 with SMTP id
 38308e7fff4ca-3acb7ad2a7emr9596841fa.16.1793442967746; 
 Sat, 31 Oct 2026 03:36:07 -0700 (PDT)
Received: from Thor.lan (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi.
 [2001:99a:a58:9b00:9119:221d:45f0:de83])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe072d025sm542425e87.38.2026.10.31.03.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 03:36:05 -0700 (PDT)
From: "Maxin B. John" <maxin.john@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: cmd: add documentation for binop
Date: Sat, 31 Oct 2026 12:35:59 +0200
Message-ID: <20261031103603.1807331-1-maxin.john@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add documentation for the binop command.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
 doc/usage/cmd/binop.rst | 103 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 doc/usage/cmd/binop.rst

diff --git a/doc/usage/cmd/binop.rst b/doc/usage/cmd/binop.rst
new file mode 100644
index 000000000000..e14b799ea7f2
--- /dev/null
+++ b/doc/usage/cmd/binop.rst
@@ -0,0 +1,103 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: binop (command)
+
+binop command
+=============
+
+Synopsis
+--------
+
+::
+
+    binop op count src1 src2 [dest]
+
+Description
+-----------
+
+The binop command applies a bitwise binary operation to two byte arrays of
+count bytes. Bytes are processed independently; no endian or word-size
+conversion is performed. The result is written to dest or, if dest is
+omitted, printed to the console.
+
+op
+    Operation to perform:
+
+    * ``xor`` - set each bit where the operands differ
+    * ``or`` - set each bit that is set in either operand
+    * ``and`` - set each bit that is set in both operands
+
+count
+    Number of bytes to process, specified in decimal. Must be
+    greater than zero.
+
+src1, src2
+    Input operands. Each operand is either:
+
+    - an environment variable name, whose value is parsed as a hex string
+    - a hex string, if no environment variable with that name exists
+    - a memory address prefixed with '*', in which case count bytes are
+      read from that address
+
+    An existing environment variable takes precedence over interpreting
+    the argument as a hex string. Prefixing an argument with ``*``
+    explicitly selects memory access. Hex strings must contain an even
+    number of hexadecimal digits and may not describe more than count
+    bytes. Shorter values are zero-padded at the end.
+
+dest
+    Optional destination. If prefixed with '*', the result is written to
+    that memory address. Otherwise dest is the name of an environment
+    variable which receives the result as a lowercase hex string with two
+    hex digits per byte. If dest is omitted, the result is printed as hex
+    bytes separated by spaces, 16 bytes per line.
+
+Addresses are parsed as hexadecimal numbers. The caller is responsible
+for ensuring that the specified memory is accessible and, for
+destinations, writable.
+
+Invalid counts, operators, addresses or hex strings are rejected and the
+destination is left unchanged.
+
+Examples
+--------
+
+XOR two hex strings and store the result in an environment variable::
+
+    => binop xor 4 01020304 ffffffff binop_out
+    => printenv binop_out
+    binop_out=fefdfcfb
+
+AND two hex strings::
+
+    => binop and 4 0f0f0f0f 00ff00ff binop_out
+    => printenv binop_out
+    binop_out=000f000f
+
+Read an operand from an environment variable. The short value is
+zero-padded::
+
+    => setenv binop_a 0102
+    => binop or 4 binop_a 03 binop_out
+    => printenv binop_out
+    binop_out=03020000
+
+Print the result to the console::
+
+    => binop xor 2 0102 0304
+    02 06
+
+Read from and write to memory (addresses are hexadecimal)::
+
+    => binop xor 4 *0x80000000 01010101 *0x80000010
+
+Configuration
+-------------
+
+The binop command is available if CONFIG_CMD_BINOP=y.
+
+Return value
+------------
+
+The return value $? is 0 on success and 1 on failure.
-- 
2.47.3

