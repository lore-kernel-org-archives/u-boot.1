Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9FD606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oTlbE2z6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v7x0jDjo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3F706085B;
	Tue,  3 Nov 2026 15:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qoms08jwTUlw; Tue,  3 Nov 2026 15:33:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C8F260686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720029;
	b=CwoZqQe9p6B0+dKt9cnMtp6IOgq9Lf7lvEGzBPTQEFy1m2Th85Plj1/lqKmzOtyO0mJ1
	 jRczPzN06G++rWpg5OhNy9NycxDL0y4E1fnk64vS6IInNxLcs3N8zuWiuBd+uXVJJCT/d
	 6DUUI7tPqioRtS0kWCyJxgbt8W2C1LJCRRsK/Z8GbVUEd7AgzzvRSLOSH2ljTbatnyPal
	 EYwDXd32vq3Ji/oil6DwkdQImNs7z1t1rnFKEPeadTXGdD4mz/kgJOwxdaqHS/HG1cly7
	 RpAAc0ZjdZnKl9MxojCUapVrGQa2thwp3okrT29yNhtfbcQJRXWR3eLc5IWuyZzREtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nixj3USDUvLM1jNqJU9Ok+gZTkA8Cz9XOanXsFaYSwA=;
	b=IbVnY+ZY7xPvWTOX1TYLvOCVSYO4aUAFMg6veiM2umkdNWrJWxFWLIcxRMLvAeH/Y/3l
	 kQP4UCcP4IJlseF2dMb2BgBkUl9thZOVn5a9CAtjBlrpTz5x6UIiXXzD/8Cz+vUdaaT2c
	 Xf5AxU9gaVixnRvKS19N+OCBcc/4B7ilQaIQlaKMG876VbvWpfU1pvhpO8/08bLw0oiAR
	 GAc0kbR5ezeWKDqdM2TehDmDjsMWVy6DpetzA/twXe8t5FUHS5r6RKzmaFZPm0B1eIBDZ
	 VPa4R15//4t9JnQcL9nnYUsKzww5dyv89QdRBfFzEhVZ6HIhKo3k4x/iKTXVmSS2rcQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v7x0jDjo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720029;
	bh=nixj3USDUvLM1jNqJU9Ok+gZTkA8Cz9XOanXsFaYSwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oTlbE2z6MmZa4FUCp7RAWSttoRc/TCB4KNUO8cJKWHZMXB6pgv1UbuKi1dWkodUdA
	 e8LXpGz4zVBVPOUlK3VWtClgGOLUJgcH8rfxFVbRgNSI7NXE1w7lPtb3HC9BptCXEO
	 LrTDXDWjEQWEKEoiUJONEH2rEPGj80P8CWol+6e1l7hz1UKPL2jRE9KBEvLZ5bcT07
	 SgRXL8N2uOWgYw2SaB8s13qPKfu4TpHOC5TfU4CB/Tf/CkZB1Arz55M6wRjK/nmzgx
	 8bcf27iSjdtH6MObSO0wlmOE2SQXw1zAmZdZqJgtcGgVDEJ3SnrUWH5YXRzn4gDjym
	 g3f4lqBAXj7NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C8F260686;
	Tue,  3 Nov 2026 15:33:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE581235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB97D606E6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oZBUX64TnveK for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D3DF60855
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793720025;
 b=gN4kaNcrvWcmjkqQDF7ST3j5+3+cb21GPQc9srfXrTnT0l2aBu3Wh15K8M2zhJ8Ff8n6
 /GRNUzgkTHHIOd/mTBi+vTQk9E693/jZNwFSsGc+oxCGu5APRqBDwTH+BkXRZboatayWv
 zc6TMG/pPfhrFCfcEcNddgwpROvNtgZi7M6InBEEQyl5R2baieSkYTiUgVBru8Lh8/HJS
 UYfbNaG/M1MeDEeNbKmbxGr40R+1YWU7O3mLW1HyTHQUp9HnuMj8fk2pgvx1OpmgVTZsn
 f7MgV2O/MbJXj0QQuKlmaKyufUZrrGC9R6A0nlisoDDUYPhjghy4ogoQAdD7Ai9ju/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720025;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=nixj3USDUvLM1jNqJU9Ok+gZTkA8Cz9XOanXsFaYSwA=;
 b=qsuqFoIz0fQxNEeVIxhcwk/oLtN8d1qaQHf5jng0F/AqD+zABnugvUUMJ4Mgj/gqNC6L
 FjdV6KJ8Z3AYyR+kSHJeA1qq28Tk4flUCUoHetwnsIN5auHcAT3GdIKEHvMW6e3/tG21+
 2UJbEKpP5v/IYsu+huEfx7Bm0pCBj/uABHl8uU9V9wGlM9DFyHfZ1DhWTCLc5wD2HB/0g
 fjYdCCUgnzlOkH6GNZhloE2JsVjQ2HC6HOPAty3dIdwTBBxyHhSuYV/qfEIYRC0jgiRLe
 4Cma4euj/2nEz5gcVNHXSlXb1PdSC6QO8TWSZoxKoMWC9qgc8L0WN55sYZQRRoMVqYg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=v7x0jDjo; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=v7x0jDjo
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D3DF60855
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:43 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so571295f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793720022; x=1794324822;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nixj3USDUvLM1jNqJU9Ok+gZTkA8Cz9XOanXsFaYSwA=;
 b=v7x0jDjoK9+oj9mdQndX+y4V35vArp6d+V7M+plQYGd9yssrX9GcyS1C2LYS93/nLY
 NCF8XX5mCsbzKcL8TbMCxFAp93WsmsFKB/8HBZ9AzrrirzxZNgx6yd7SAxEqAZS/Dbrf
 5Lnxr/yLj+rejvc7EJpY3p9hSlOyXL/ycd6ZfzwSn7vip8L9bVfPnwx7UQaRFCB1tKYY
 jj0faawutgsViWrJAqsQUsAT9cg6d1jwBmCfcK7pqPIKyCJo7dE4e+4VVuf4EGPcUKmb
 ukFrvkMlbSMWHhE9M8bXy8lshWDWKkGtROs6I/srgAIi7HcR5e7azKFg8kONDJDS7jJ7
 UgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720022; x=1794324822;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nixj3USDUvLM1jNqJU9Ok+gZTkA8Cz9XOanXsFaYSwA=;
 b=k+pqdBmQOD2DTEbFFSPjFDS3LfxbcUTvztxlqSNd7T5IYZq4KiTh9EXBSoHCKoU1mO
 AYUSiZHkkmUiYoVhZzHmzoJyeISWmT96pB5LPbRlz27KFGT+qN/jO0HraXGO1wj9/3bo
 ajmFwptRsMv9kFX0IImMtcgAW5OS6CZqYWGK5OxV6WUsZknnY2DJMIAWy6jUElcvcWie
 QRVVUo55RUkXUQq2NctDs37N79Wr9OW03IlURaiBYfxtcpyP39RZ6ZuV6vZ1tSlUVwhb
 LO6nwvVbesT2SfhfY5QxtQ4z9KtFYbvvvCUoGPq5XVjihdA/uIRWIoR5OQ1NDX7tGvct
 MUDw==
X-Gm-Message-State: APuU4Z8PK//6Nrg4EpnIK3uspXZKaPAyNjmOvLScDRauKwx4vvkS1N1l
 YVRcCzvXIvavd+ayV/QMClzqSEA4OpzOuMYNa1z9QPbMjT3MZ++vtXUaMPb1k3RNyqNNtk1O
X-Gm-Gg: AYBFou2DVPNTLpD1xm8uqANCJVWQzisphh7yS6FUh8/NuTFr0dwidu+dYknIVP3aEUZ
 TXgAYbZUQIWvdKWAXFazBKWuN3D8fj6hPr01UEpmVqPPxzmND4sAsyRDVZ2eNuetJyzLgjDjWdn
 yNmSebQSiE2fdRuN5f864hGJh6EudaQvc8Ji/FvDcT12i1OJA65Mr01yZhPb/ytyPsTRXqMAMaA
 3lIij/6en51qAYzqMqFvAJN7J9mcstf0lzchoIyCrIiFOkftQjxLNuPnjc0msqVRYpyBpUN3sPB
 8bcTdioLYEqTMW4a6G+4EV8Qn6KDdNV9DcLuZjiBdBccI9aRfXihcYwnPMaGBOtBr58PJxI7kXn
 VzFLOyflB43zKgeR1yQHHihb1Y8F8gx99T462lAnVv0N4rxWcpFH6BByU3l4xX96QpLTByuNLhA
 osyen6i0T4nneU3/5w5AI7/hI9zRW4noyapNQysL+qsxz3eeF4yCvYS0a1b3YgdrIbelr9SwB5+
 rObzkvZd7LTAPZkOvQxzc724xyx6GO/w3Qg/7gg+twP+V1FU6NJhR6ENjZdNSEMn44Az83bIBJj
 DX3nCOJya3GZXHe0CIsI6B9glz5+PTw=
X-Received: by 2002:a05:6000:2283:b0:48e:7475:fe7b with SMTP id
 ffacd0b85a97d-48e7475fea6mr29980683f8f.6.1793720022030; 
 Tue, 03 Nov 2026 07:33:42 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a6bsm25644026f8f.27.2026.11.03.07.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:33:41 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 2/4] fs: Check reserved memory when bootmeths and sysboot
 read files
Date: Tue, 03 Nov 2026 15:33:39 +0000
Message-ID: <a247826d-aeef-4212-9a83-5ad44be44869@gmail.com>
In-Reply-To: <68656bc0-c727-4d25-8066-f2633c04e02a@gmail.com>
References: <68656bc0-c727-4d25-8066-f2633c04e02a@gmail.com>
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
(no changes since v1)

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
