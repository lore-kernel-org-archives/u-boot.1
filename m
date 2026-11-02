Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E8606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jJKTuv64;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bYenBWRl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5350D606BA;
	Mon,  2 Nov 2026 07:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jhsh8Eut68ek; Mon,  2 Nov 2026 07:04:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4054460687
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793603042;
	b=TqTUBXmvAuTjdGmNMOFi+fZ4keJPrTqe4SMbOAL8D8akWDNBa4TvD6iZ4Qn+C5hVosjN
	 NradmvcTVtBIiV3cKkQgS1y5j6tMSB/AafyalkmDfjKN8FBLe/hmTMxhQp5th1mfuxcA6
	 oWH+NRLIeC37G0G5WpOomjzbYtcZoFwH0mHj46zWRH1oaKLWjhvw9kQoMYhfCpquB4OxB
	 w9tDEXc3en2fCx3acP5ydv46hCnc8KWuyM9MFEolfUVrgVnGEibluoLILMUxD8+jT+yYf
	 f0cf0cs9s8FGVTNYzkD30K4u7+rb86kEGrQB/0hBcz6GdKhoyDoW7ADTEquqkMfll+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793603042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vGfMVasBDqrdAtJBBdAnfpfqNbS/8OiP3ekwx1bBifE=;
	b=kUxmkSppHO0lKL6bWsfeOifglhdtSkJyvWSQp0+5aVAgJHrCbjbARLcttb6TNAfonck6
	 2lyVhwrgU+pQeg6cIEogxhR9Z5K6y0+JGYzzO7pFGH0gR1ZxuM1w4exS6mEZ5X9gKXFgw
	 BIPUaEHct3NBaODU7S7XRy2dD7FOTTPLJa2fg/vtt4H6ehIWBafD+A++tSkcMfHB8Vh5f
	 O7iEGkudG+q3gzsbA1FEAH2SY2YXW9VnR1ARjH7fsXnUnewWs27WXzrqAgJoZiVN+zpkt
	 tbiWce7IjCXpVJSEmIUnk0u8fhwq0AbLeC0GqOvgY2RpssZnsaE5GiJqeWwS8MMjeLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793603042;
	bh=vGfMVasBDqrdAtJBBdAnfpfqNbS/8OiP3ekwx1bBifE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jJKTuv648HbnftIBa1T5JDr+TVWeJDLDycFxaBoFdMc947cBew53zNPVvOTBZ7fdA
	 dv6MhvF1OWtNo9Mk329fcFKlDSPrxkDIveW5KW6+4xxKbNthqiz7wm99Knp9av1Usg
	 tRsXwNtRi4jo8tyMatVq1c7eaP0/g5MiHtQr2XB8iWabPt7y2f6Gb9YFY8rRNWx/Nu
	 DiL5UFlDqubIR8SPYAnn5U+2j+2stfUzN83ZwkWVRpq3EsfrGTYVZE82QWd3wCvf7T
	 NdGmWSsi+n79i6ApDumu5Wrwlxc1s+obxgKg63NZEpuETu+gYJhch7+qghFa+svBUY
	 mjG5MQ0vDIYHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4054460687;
	Mon,  2 Nov 2026 07:04:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 23FB3156
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21507400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id djDrHHFkWBmZ for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 07:04:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D95434008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793603040;
 b=rfLCwvuRU3PE1BGNkUy8YtVRFLVqu7vBSlcsZAM6HylxLV67NEIpg1qYFP1GjZkAo87R
 6Wmzi8N+hJCUs4k8Pr6oEVkzzS1vDk3WSQgv8SqIIPaNRvJqpeXtAAXrWFrNmK+JqYYR/
 H+HVXNWOo+U6TO13MFpZadzDp8H2DGwh8dVkqGB9M6hUXksrdiF6OT7cXe2lLB7zykcUV
 WddnzzhV8LcJC44ReyYcE+Szn+j3w2AEqZW8XPuR24ybQHPMQpV8yXmWfjSVQ0FtYDHLJ
 Hlu42ZvTsstqQKhVpb6lmDJhGgGvVsAcdY5q48swZums+GO1IZqN/y9zSxjh/2Max2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793603040;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=vGfMVasBDqrdAtJBBdAnfpfqNbS/8OiP3ekwx1bBifE=;
 b=oJG0HLQUQ01PXWpEpQFEqIwzxMq6JIY7lx29CCORIO0LcdonuduNC0HsPoA/d5ItPAQo
 sJmtfZv2x8vUAG/9uJD+5n2/JaLOVH7N51DozjWaIPOUGy1nPuIdUWRE7pIEsFknsdVF+
 Q6CNTk4trPDJ33KUW08/dwnq7Dk2DbjLICcl4jfNJwJEsWJqruGGAfmeGlpySY/zKNlTH
 6Uq00mEymXClIBQL+gWsK2MIuTLdbnHTe1EiXXEwQwPjFkCI58wXcH6fyz6D9D5RYvdpk
 X87mqaM7Oy3XhMpcdEmxJPKg+1G4O8zOwZgtsPyuSKni2g8FQJrxBio0R+LgOJ3OMgw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=bYenBWRl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=bYenBWRl
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D95434008C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:03:59 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1465592f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 23:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793603037; x=1794207837;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vGfMVasBDqrdAtJBBdAnfpfqNbS/8OiP3ekwx1bBifE=;
 b=bYenBWRlyUtjdm54DA5KIFyuaJBiqnjhswH93vSDhAeqtfNY+6Lmkck5vfFvaDm/co
 EnkhRsqDg1xd76CWs62U7X6WNs1oqg60c0M+Npgzpo7w1fsNImHwKrXYSy/eJZIz54BB
 tgfH3C+B4SzLBf0mnDr7WiK3QlSQb7R/6d1WHMbvjJGeWIKIUEEkflauOFMIAlrT+yyy
 J3VEcjcBYICuDhI8b0BDIXmNmPBHlY3NuprkFb1i75frUBOlLTOLg5tZArAewOFYwlYb
 rg0k6jldlXPmc8KCqoApfW7CwALCG9BcKZk8S9itf3gI1DP4CmMJxvbnrMxSRPYB65Ft
 7Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793603037; x=1794207837;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vGfMVasBDqrdAtJBBdAnfpfqNbS/8OiP3ekwx1bBifE=;
 b=A/pQhYix+7vXm78wmn8WFoIRWrMGtFJXwgA4GjMxHjvaozBnf2ndxlIsMB4UuIBy3A
 dUpJUNY3uFpA+q5IYWr3a9LYQHVbptc3+om2sWBWg84aqXf6G8Gx+vMaNQ2G1yTYWmW8
 3v4nusEFe5f45Eqdjdb05gDWfQni5Ep+AyLuwGzCXwzLpLJcR9c81jKNDwAvnV5feBto
 9/ox70ORknaU1XQlftJ9XDqbsUmh6fmPEkkF9rGbYAZP/4OOID/DBW6grhsw6nkQ+2c0
 n03dGDsLX2uvzXT+rYLaxIAH+9YFRxofL8XAsos0P9LbY9mVIAlHCyhhcFKZO3gO5qv7
 8YbQ==
X-Gm-Message-State: APuU4Z9VlOqrly+H0l66If+vlvfRr0yOFNycH2Wqm2pxl9B808q6/Afc
 KKHDcfLbHOVWXWY6CknKcCB5gyjxTJT/mJWz9DKGinaBmmsqamhs5PB/r8S/e+D+AIQ=
X-Gm-Gg: AYBFou16rHHzn1aU659zKznMEMJjxEFFvASxpNj818PyNNVmvtqENJEIIO55q6j7kgY
 NV73V0Ev4FNje30GnZDEQLBO1/QW52jPaJNjOCgIvEfHtmsLS+ajkLxpUL8aagiJUEPu59+pYjM
 VFp1De6GtROfSQy6ajp7R50umE/t5BBLDznec2M7j5Rj3Y9HpYvg4pFohPUFD9nV50xEwbPv77P
 a7IA8xXCzrWFZJfTx5DT/1+R2iHvULwLoOQ/rpto7lIhluE6jMVFUy5eJvc43s6cLJNGdMSeRH/
 OLSqk6LoooFmqfbZr0mEoplBBz2e/QaCbJ/TpTTdT1IwXSrikmuBQND+KZYjSFq778Xtt1XAyjb
 nnDJ0PlCLF5OCmIEHpAQGlHju9PAH7/BRRRVSsKqIGNA9GyJKJDT9zv0aRY8ACNt6zYpPPBLqf6
 nmlBYqrPX7Dm+v/r6p5cQj1O2gDptrcxgQvx0edlaYkVqLhMFdPxGgkhEKh2yZgY/TV34U/5EuB
 7tShYmebIbMoyEyINR6mW9y50wlMap9+mQ5OfHCP+Vz4hrTYR/ygzSEQEBSETV9NFNzmWNa6AdD
 zvQXmAbczMn/E2vU+MSGEw+1B6x9Ato=
X-Received: by 2002:a05:6000:2085:b0:48e:7a41:d78e with SMTP id
 ffacd0b85a97d-48e7a41d798mr10572027f8f.19.1793603037243; 
 Sun, 01 Nov 2026 23:03:57 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a84esm20274190f8f.39.2026.11.01.23.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 23:03:56 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 2/4] fs: Check reserved memory when bootmeths and sysboot read
 files
Date: Mon, 02 Nov 2026 07:03:55 +0000
Message-ID: <f80a6cca-512b-433a-a469-dcd3e50c1215@gmail.com>
In-Reply-To: <a601d668-436a-4aa7-bb10-950a89d324ed@gmail.com>
References: <a601d668-436a-4aa7-bb10-950a89d324ed@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

Since commit aa3c609e2be5 ("fs: prevent overwriting reserved memory"),
which fixed CVE-2018-18440, the load command refuses to read a file over
reserved memory, such as U-Boot's own code, stack and heap. The bootmeths
and the sysboot command read files with fs_read() instead, which does
not have that check:

- bootmeth_common_read_file() only checks the size of the file against
  a limit given by the caller, which is 1GB for extlinux and EFI
- sysboot_read_file() does not check the size at all. sysboot used the
  load commands, and so had the check, until
  commit 81a2f8d34b4e ("pxe: Refactor sysboot to have one helper")

So a large kernel, initrd, FDT or config file on the boot media, read to
an address taken from the environment, such as ${kernel_addr_r}, can be
written over U-Boot itself.

Export the read which the load command uses as fs_read_checked() and use
it in do_load(), bootmeth_common_read_file() and sysboot_read_file().
Close the filesystem when the check fails, as a successful read does,
since a bootflow scan can now fail the check many times.

Bootmeths now refuse to read a file over reserved memory just as the
load command does, so a board whose environment puts
${kernel_addr_r} or similar in a reserved region will see an error where
the file was written over that region before.

Add a test which tries to read a file to reserved memory with a bootmeth
and with sysboot.

Fixes: a950d31abe98 ("bootstd: Add the bootmeth uclass and helpers")
Fixes: 81a2f8d34b4e ("pxe: Refactor sysboot to have one helper")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 boot/bootmeth-uclass.c |  2 +-
 cmd/sysboot.c          |  2 +-
 fs/fs.c                | 12 +++++--
 include/fs.h           | 19 +++++++++++
 test/boot/bootmeth.c   | 75 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index c841dd0d6d4..b0d0c3a4e38 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -449,7 +449,7 @@ int bootmeth_common_read_file(struct udevice *dev, struct bootflow *bflow,
 	if (ret)
 		return log_msg_ret("fs", ret);
 
-	ret = fs_read(file_path, addr, 0, 0, &len_read);
+	ret = fs_read_checked(file_path, addr, 0, 0, &len_read);
 	if (ret)
 		return ret;
 	*sizep = len_read;
diff --git a/cmd/sysboot.c b/cmd/sysboot.c
index 93d4a400830..1e78767eec2 100644
--- a/cmd/sysboot.c
+++ b/cmd/sysboot.c
@@ -35,7 +35,7 @@ static int sysboot_read_file(struct pxe_context *ctx, const char *file_path,
 	ret = fs_set_blk_dev(info->ifname, info->dev_part_str, info->fstype);
 	if (ret)
 		return ret;
-	ret = fs_read(file_path, addr, 0, 0, &len_read);
+	ret = fs_read_checked(file_path, addr, 0, 0, &len_read);
 	if (ret)
 		return ret;
 	*sizep = len_read;
diff --git a/fs/fs.c b/fs/fs.c
index b18ccec8cb4..a8574b30c7f 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -682,8 +682,10 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 #if CONFIG_IS_ENABLED(LMB)
 	if (do_lmb_check) {
 		ret = fs_read_lmb_check(filename, addr, offset, len, info);
-		if (ret)
+		if (ret) {
+			fs_close();
 			return ret;
+		}
 	}
 #endif
 
@@ -709,6 +711,12 @@ int fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 	return _fs_read(filename, addr, offset, len, 0, actread);
 }
 
+int fs_read_checked(const char *filename, ulong addr, loff_t offset,
+		    loff_t len, loff_t *actread)
+{
+	return _fs_read(filename, addr, offset, len, 1, actread);
+}
+
 int fs_write(const char *filename, ulong addr, loff_t offset, loff_t len,
 	     loff_t *actwrite)
 {
@@ -911,7 +919,7 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 		pos = 0;
 
 	time = get_timer(0);
-	ret = _fs_read(filename, addr, pos, bytes, 1, &len_read);
+	ret = fs_read_checked(filename, addr, pos, bytes, &len_read);
 	time = get_timer(time);
 	if (ret < 0) {
 		log_err("Failed to load '%s'\n", filename);
diff --git a/include/fs.h b/include/fs.h
index 8afc81c0017..28d8a7cc98b 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -152,6 +152,25 @@ int fs_size(const char *filename, loff_t *size);
 int fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 	    loff_t *actread);
 
+/**
+ * fs_read_checked() - read a file without overwriting reserved memory
+ *
+ * This is like fs_read() but, as the 'load' command does, it refuses to read
+ * a file over memory that is reserved (if LMB is enabled), such as U-Boot
+ * itself. Use this to read a file whose size is not under the caller's
+ * control to an address that is not a buffer the caller allocated.
+ *
+ * @filename:	full path of the file to read from
+ * @addr:	address of the buffer to write to
+ * @offset:	offset in the file from where to start reading
+ * @len:	the number of bytes to read. Use 0 to read entire file.
+ * @actread:	returns the actual number of bytes read
+ * Return:	0 if OK with valid @actread, -ENOSPC if the file would overwrite
+ *		reserved memory, other -ve value on other error
+ */
+int fs_read_checked(const char *filename, ulong addr, loff_t offset,
+		    loff_t len, loff_t *actread);
+
 /**
  * fs_write() - write file to the partition previously set by fs_set_blk_dev()
  *
diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
index 8400a2e7879..09fc21bbc1b 100644
--- a/test/boot/bootmeth.c
+++ b/test/boot/bootmeth.c
@@ -6,10 +6,16 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <bootflow.h>
 #include <bootmeth.h>
 #include <bootstd.h>
+#include <command.h>
 #include <dm.h>
 #include <env.h>
+#include <lmb.h>
+#include <mapmem.h>
+#include <vsprintf.h>
+#include <linux/sizes.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
 
@@ -228,3 +234,72 @@ static int bootmeth_state(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootmeth_state, UTF_DM | UTF_SCAN_FDT);
+
+/* Check for the message given when a file would overwrite reserved memory */
+static int check_reserved_msg(struct unit_test_state *uts)
+{
+	if (IS_ENABLED(CONFIG_LOGF_FUNC))
+		ut_assert_nextline(
+			"   fs_read_lmb_check() ** Reading file would overwrite reserved memory **");
+	else
+		ut_assert_nextline("** Reading file would overwrite reserved memory **");
+
+	return 0;
+}
+
+/* Check that reading a file cannot overwrite reserved memory */
+static int bootmeth_read_reserved(struct unit_test_state *uts)
+{
+	const ulong size = SZ_4K;
+	struct bootstd_priv *std;
+	struct bootflow *bflow;
+	phys_addr_t addr;
+	char cmd[80];
+	ulong limit;
+	char *buf;
+	int i;
+
+	if (!CONFIG_IS_ENABLED(LMB))
+		return -EAGAIN;
+
+	ut_assertok(run_command("bootdev select 1", 0));
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assertok(run_command("bootflow select 0", 0));
+	ut_assertok(bootstd_get_priv(&std));
+	bflow = std->cur_bootflow;
+	ut_assertnonnull(bflow);
+	ut_assert(bflow->size <= size);
+
+	/* Reserve some memory, as U-Boot does for itself */
+	ut_assertok(lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_4K, &addr, size,
+				  LMB_NOOVERWRITE));
+	buf = map_sysmem(addr, size);
+	memset(buf, 0xaa, size);
+	console_record_reset_enable();
+
+	limit = size;
+	ut_asserteq(-ENOSPC, bootmeth_read_file(bflow->method, bflow,
+						bflow->fname, addr,
+						BFI_EXTLINUX_CFG, &limit));
+	ut_assertok(check_reserved_msg(uts));
+	ut_assert_console_end();
+
+	if (IS_ENABLED(CONFIG_CMD_SYSBOOT)) {
+		snprintf(cmd, sizeof(cmd), "sysboot mmc 1:1 any %lx %s",
+			 (ulong)addr, bflow->fname);
+		ut_asserteq(1, run_command(cmd, 0));
+		ut_assert_nextline("Retrieving file: %s", bflow->fname);
+		ut_assertok(check_reserved_msg(uts));
+		ut_assert_nextline("Error reading config file");
+		ut_assert_console_end();
+		ut_assertok(env_set("bootfile", NULL));
+	}
+
+	for (i = 0; i < size; i++)
+		ut_asserteq(0xaa, (u8)buf[i]);
+	unmap_sysmem(buf);
+	ut_assertok(lmb_free(addr, size, LMB_NOOVERWRITE));
+
+	return 0;
+}
+BOOTSTD_TEST(bootmeth_read_reserved, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
