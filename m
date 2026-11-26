Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2781606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jR+/YKkU;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTQIGM0t
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2D7E80F52;
	Thu, 26 Nov 2026 05:01:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3wjBa3CkzTJ; Thu, 26 Nov 2026 05:01:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B17DD80F3E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795669312;
	b=tg7hf6cbB3J9EwOjyJA9BvphP2vg9rwNaoR55fAtJG70d5s+Nx1iPt+Oo9yXXJG4hIla
	 2gZVh8xjX9aRQrFPTr87Ohkimd5ysAOwxYHXBNAemsyiYoRklmcBxQkI5doTt86hMlaO6
	 ZtwxXbxNK1bKJ27WVu6KY7xFr4S0dCrmesrFXQ1wCP+iHew639afW8MwbxNiXlgtGyDxz
	 H/63Gavwb9s2/8Vizp5zRnOzUJJOXA6SErn/azqsAap5WO7NCyI8mZMZBImqav8wahbxn
	 g7KayPar5Lc5uvkArQ3HYCOxB2xO2F/HMIzbeRvi1GfIqsQPzLTR3sXVGUpDJVkES/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795669312;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2sIlkZq+ib9YiZ2csv17ueAxplgaiHMSc6dh2/Ka/Lg=;
	b=HNZZKmcMpTUqx7e/Bhl19ck9SBPNnz4UGYH8pYFGAh0DOOhVURgoIOMMHgqDMfbrpDnP
	 NAKti90vm1YqSzXRGniSxdY8yarbe83kt+yjMNlE6EhaCQtFAldke6rNfr+WZj8LvCazp
	 XAeMvlB5Vx3I6SNC1oKu7/VS5z40oiqu0e/f/lD3g08e14rk8Op/yIoFOTirlwLjZjPBP
	 Jd5qN2KmdxQ26Kwz9QOAKkMHIllZ5nqP/8pvKdMXsxJraiJbvLD4owScDK6kLwcJvErzx
	 aJFmCfBJ7g7okzp214kqljq/3nwvKYBzTK3l4ghhYMtcLseH9euk99rd1N+56A/M6Gg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	spf=fail smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTQIGM0t;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795669312;
	bh=2sIlkZq+ib9YiZ2csv17ueAxplgaiHMSc6dh2/Ka/Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jR+/YKkUhF/DR3AQuu8Vm5NP8XK2ECBvyrZBwFwZd9+2XwxAoa0GfIuj0Qzhw5b6t
	 fhsrYHq+0jPPCIiijkMEDoPVfQJ1NMwZQNCTCFm0t+InuhIMMlDNsGH+fCdUInVFyI
	 7RP3nyekDDVUktZ0oFlgDPbASjE5FzgnZO60c+qq1hkdGgyJ5ZHbCGVfd3kiw3N6Ve
	 NWZCVeudVzRFsNJlZdMxkpoJDchg1DvB58ICG9MVazeHJTDCj/B2DzQvjMdJ3fL5+z
	 ag/4qDqW3L6J3fuObhbAKugIMZc+qiVwpxOrW+n6JzTTBVCR4/D52jwL2zgqsm8grS
	 SWj9AnZKBsL4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B17DD80F3E;
	Thu, 26 Nov 2026 05:01:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5EFB22B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B764B80893
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:03:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uY0JkqT5HGxu for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 03:03:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 751BD80865
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=leeonion.muyu@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=eTQIGM0t
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 751BD80865
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:03:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 113E783108; Thu, 26 Nov 2026 04:03:08 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB53383108
 for <u-boot@lists.denx.de>; Thu, 26 Nov 2026 04:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leeonion.muyu@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8a9f9473029so4973972b3a.2
 for <u-boot@lists.denx.de>; Wed, 25 Nov 2026 19:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795662179; x=1796266979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2sIlkZq+ib9YiZ2csv17ueAxplgaiHMSc6dh2/Ka/Lg=;
 b=eTQIGM0t2Ithvqr+1HZg4HHVZ+EaDLZBpGlzAf2QiG6R72f0lZHD7+rmdWd7gRpmvF
 08MEhh7y7sGJgKhUd7phRAWAjCg4rgxy6CUgeYeoPJlwmiVEf/3BkD6TQBK+k9AbVj74
 pkUssZh9/+J8tTnq8SsdqLhlZwIY0l8aAsbYFfCvjMN2BtFstOihe46w2vm0wojQzbZX
 BdXFbdMA0GMQstKhbe2beulbp9P5jZPYhWwnG6RAX4IGmhG2yi4O3EySTABHFSQkBDp4
 qUTxCFHZo2tQv7zEHnD/Cct4z26XijyKU5S+Rqj+DOewtt2dn9aRt64XJG9a2W4ZGz2g
 rrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795662179; x=1796266979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2sIlkZq+ib9YiZ2csv17ueAxplgaiHMSc6dh2/Ka/Lg=;
 b=WP7eDr8YQH7kEO9qjas3ik0/kWdGlsDeAlonTbyHzp3h2IK1X3hTzD2AuJjZ+ETWp+
 UrmLvOCnvSWlEerKnzoh7trSqxJLclF0uAD/XRaxDjES6t4Ncq3UfAICyHUESdQnTKQ5
 yy58fC/ewpWL+iCaRW7FBAFl114G/MHWE+/MXcPldWUP+IEXytulu2qBxiht6UYcaAQ+
 6onaZNsaVlLQmjaYi6yjm6FvUTkzcYrFnFbz2JzEzdd+lEvKt18D0TzDSvB21jb3zu9S
 BwZbqFtvnSPQRhihp9Qhp3HaqktxOccXIkioK1Vvgo+92uiAuHcT/Pf1J9pCefQY/L0+
 vP2A==
X-Forwarded-Encrypted: i=1;
 AL+hErEFimMkCIWZF2ao1AhmQFIWqJ44vAE5iU1fkoEmhIpgaGHzGPJDvzvGfgCFlY+ECKuVZlNxEG8=@lists.denx.de
X-Gm-Message-State: APuU4Z+vOP4MZAnCfWolstqMRuB2ne69v0Y4tl3l9agB9TsQ469H36N0
 cD1O3RCETXpeM9+dLsAE+JJvsz87b+d9v73Tfyh1FU4OJvR5n5Hzao9K
X-Gm-Gg: AZFdTZeLRhmWHy8Dax7u/BmICvdOigdtEUBXgpyr6GV3lBXB4rRKiLo75vevPt5rKzP
 Mu5BZxqnQ9WEd6PSaaMTpASlhbGYKAkpLzcYrXfm/IvFPx23BNcQ6jNOCcC6HZBWrhglG88fa1/
 +skVzpRAv/Lcw7cNGcWhOT6qNxmNCo8mXGWqQ7CKEfciRqs8FTfowYAgg6qa4bDr6kuyqGhot8T
 ss+Y7K84TJebHvWEMUPWqlQFxEFRC6AXmwoVZPtSXc1arPKOY2HR46645kJKnPMR8RxgFLt3Lnj
 4Vqf9mFxZiezNvKTPVlJgcSXP8cpiQXmMMNJUBOe7Zkoj+ihJEPmuDzUgdkOxttvf1q/uf1s5YL
 nl2qlz5UcT2Xv2L9C/1JVDEutrx82lP55bxoo6qvI6vjs+QWrV3l///iFUSMp29YaIO1YFErncm
 pHd3fF4PnS1j3OUNZZ+K/gvwSqdNf7DnJlIjKp0vNJsShI6hs3ATCb/Ezq0HbKGErisUCE8HBcS
 NEr7t73NhQW+ADP2MilFIvWXL05xoMu93EkfSnmqUoIoV0o7dZZ7qEwmR79DTRM6+Jvpbby1/xl
 k9If73U3LRo5q09MSeMo2IIpv6ztypXRKg==
X-Received: by 2002:a05:6a00:2d9f:b0:8a5:97ca:1389 with SMTP id
 d2e1a72fcca58-8c87bdb42d4mr21120203b3a.15.1795662179123; 
 Wed, 25 Nov 2026 19:02:59 -0800 (PST)
Received: from server225.. ([39.170.101.209]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c908a56acfsm9231474b3a.23.2026.11.25.19.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 19:02:58 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: catalin.marinas@arm.com, will@kernel.org, palmer@dabbelt.com,
 pjw@kernel.org
Cc: cyan@meta.com, mark.rutland@arm.com, alex@ghiti.fr,
 emil.renner.berthing@canonical.com, masahiroy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
 Ping Li <leeonion.muyu@gmail.com>
Subject: [PATCH v2 0/2] arm64,
 riscv: boot: emit standard LZ4 frame for Image.lz4
Date: Thu, 26 Nov 2026 11:02:31 +0800
Message-Id: <20261126030233.2546274-1-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124065650.1968930-1-leeonion.muyu@gmail.com>
References: <20261124065650.1968930-1-leeonion.muyu@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 26 Nov 2026 05:01:45 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The shared cmd_lz4 rule in scripts/Makefile.lib passes -l to the lz4
tool, producing the legacy LZ4 format (magic 0x184C2102).  The only
in-kernel lz4 decompressor, lib/decompress_unlz4, understands exactly
this legacy format, and all of its users - the self-extracting images
of other architectures (which compress their payloads with the
*_with_size variants) and the lz4-compressed initramfs - keep working
through the unchanged shared rule.

arm64 and riscv build Image.lz4 with the plain cmd_lz4, but a
compressed boot image on these architectures is handed to the
bootloader, not decompressed by the kernel itself.  U-Boot, whose
compressed-kernel path (boot/image.c image_decomp ->
lib/lz4_wrapper.c ulz4fn) only accepts the standard LZ4 frame (magic
0x184D2204) and returns -EPROTONOSUPPORT for anything else, cannot
decompress the Image.lz4 built today.  Bootloaders that decompress
legacy lz4 frames do exist in the wild (mkbootimg on Android offers a
separate lz4_legacy option), but U-Boot and its tooling only ever
supported the standard frame.

So both architectures currently produce images that no mainstream
bootloader can decompress.  Fix both by emitting the standard frame
through local rules, leaving the shared cmd_lz4 untouched for the
in-kernel users.

Changes in v2:
- Pass -BI so the blocks stay independent regardless of what the lz4
  CLI defaults to in the future; deployed U-Boot decoders reject
  linked blocks (suggested by Yann Collet).
- -BI was introduced in lz4 v1.9.0 - older lz4 versions reject the
  flag but already default to independent blocks, so the rule probes
  for -BI support first.

Ping Li (2):
  arm64: boot: emit standard LZ4 frame for Image.lz4
  riscv: boot: emit standard LZ4 frame for Image.lz4

 arch/arm64/boot/Makefile | 20 +++++++++++++++++++-
 arch/riscv/boot/Makefile | 20 +++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.34.1

