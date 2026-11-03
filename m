Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5516A606A32F
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l8TUjzLh;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JfHr1I99
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B16E80C66;
	Tue,  3 Nov 2026 13:04:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D-XKzOmrKyBA; Tue,  3 Nov 2026 13:04:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 415EF80C6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711082;
	b=S1e/HdH5YZD0E0l8rTZWlCAdB/ZkiiS90RQHCp7Vueo0GhRwr2coeeHUgIMryUbat/Yo
	 AY3Qe4pv8jgD8cnq6pPgHI76+WA3qUcoBYaTDQFaIolEJ4ZBgYL4EDoqGQeKpKwNIJzjM
	 xaroi3OFTNa0f6GJ9JClCsxn2WajwoGl3roTZ5aENWyKqnqqoSHzQfeIjwGTXMIJuN9D7
	 L5J0Wv/cW1bY9XVPjo+ERDU29gnifWwQNgXWepkBSoHXHvRQtQwu0KjtRiNiPDdgMPy+2
	 IecJZuaRykvtgflQP40VuFv4FtU2NepjNIwc6WQ4FVgFNOCoRhcuDvabWkKDQ7sRphw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711082;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/+BIrslCe8VfsAnh4/7gy6bHFim/OUHoqLz6IpolHZ8=;
	b=INBsUmVBbAbFngbNcIAVcQbSlIkI4JPFU4IMfMPNf/MDQGnC0KYr+wk3M3B+Rzr8K529
	 vp5/+0jKDE/TfbmJypO+qg52ZH/GHZZ61W32F6Cwj4zjX8T4eTFtMrTXoJ4mVNMS19FHn
	 bJsqRUiyg/lebCxVhUQxg9O2LQNdxLbzE8x/tj9cyYV4merZy4CqQom1GqaqbW8vYy5bC
	 DfFF16F42+T91obXUEZuln+x2OdVVbRpn58KWlS/buu48k4KJb931PUA4Kl30zreV6u0z
	 J65Q1OTB3nWtP3WNifwKNZaMJIOuuon2DhoqLGlqNapwF9GVm9RkdLoVntpXgrqCIMQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711082;
	bh=/+BIrslCe8VfsAnh4/7gy6bHFim/OUHoqLz6IpolHZ8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l8TUjzLhBc0TxK2QXOGE3ZwNpzcUKYO+lxFINL8ub0iWS0Mj/+G0vzEkmOk1o57i9
	 ONZ+QKkzQ0zwCEMAlY+xWm46WptiVKPRhvVVil3S/t5nTG/90HWGF7SGKX8gWVMEoZ
	 J2+OQU/IDPc7SeavyGD9CMUVvq5lMSo/4GUowfhuXMp81LOInPC9CCzwGaiNy5baIG
	 7OP/G/tautyVaUH/l42/ePC/EYM6Fe62HXz/yomOUYdjdSfWQqWhAU4FJYNpSy+83d
	 cO+/iv2nfNCSXufUqXN1Jp+xuE6GS1H+BGhwJwv+Hep7kxQFNTE6C1sCMsZmhS9yRS
	 v25LjPPmp7jww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 415EF80C6A;
	Tue,  3 Nov 2026 13:04:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AE51235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6107A401DB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:48:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jQO6QEDqHuuC for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 04:48:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6804D400BE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::732"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793681309;
 b=CmAUGC7UAU7ZK6yaw8Xrvjxw5mNbRCNXNSQyiAtcX5Hx8Dm4ulfmhZuVsCwng/LGJVlt
 X4h9yJiqJkkdaTNVm7ClTh3hlQw4k+Q/wCrOhwsVrHz6cxw7C9S5D5vTXMg+VZpIHKBho
 Obz2Cg2csyvkmsmibMk74mG5qpi9P4khuMgMb+jbEg9rmCUNu12JD21+q2RwBzuP6XXTF
 9TiecC15PmcvHPTYHhofLqAT/VKnn1BamdPbQIAoHRswN6/UQxt5o+yJN68mBRNf6AyrS
 x0Vd9Z5XBnv0L0+lTx3kfZ8142qMl7zWodOxUMS/GcKzjmP87FjiLkYtPr+4i2m5mLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793681309;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=/+BIrslCe8VfsAnh4/7gy6bHFim/OUHoqLz6IpolHZ8=;
 b=Z/ZyaZXb6g96l0kkDudHkoboeGzQZ1OxoxcWwZjItwAO/0JytXMkzWHB55mXyn+jFUTU
 t2pahmB3jLjBmNKX9gfxJhIc2T0P0NJsJ0rj5YJ1T2W/3uOs5VH5UgwfvsYy9wAv/RCJP
 PU7KDJ1KBjDLkZcBLCJhqfNY2en9YOmC8iwflmwf7Iiu9l7Yp2gAcgVgQmlDK+IbfIT6F
 Dq5WvylsogOPfhGqSa5oMGmeYQ/VwjVGcA5oFzBBTAI3fga0LTXK6d2dkZqwAF+jwFvBH
 nY7VtdcGIt+3vMHNnzaJzDX44J0flYEsG3mS6MD/u7YV+BDYn+K1SZzIEwj6o3isU+A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=JfHr1I99; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::732"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::732; helo=mail-qk1-x732.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=JfHr1I99
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6804D400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:48:28 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-93f20c3aaa5so402495485a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 20:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793681307; x=1794286107;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/+BIrslCe8VfsAnh4/7gy6bHFim/OUHoqLz6IpolHZ8=;
 b=JfHr1I99hA6ku5dhleDOUKIB2OQjQ4+FJZHXVwdENs52Trw2Dz1xJGk9RexVZn4O5c
 uOfPQ6YbhUyOMDAHYMvLwof1kzuoxX8ZQXY0f4DlA/YTKD1vNwTNrxsycHMHpq/wYw82
 JBXpoYqrheo/KSfFTYOOG9VkmelyAHLjU+QVal7JP3MEvTQ0s2cSUV6WsmBXqMzhwxx5
 8Xyu9MiIG2A1RY9Tbyg8ZWtXns1ZkN+muuBiGeUmk8r15v60Anu3e8xsOM0MC7aKWoIF
 ODiKWt3+tBXoIEbKCFq7ySC49ymdTo4XV8GwrciumwGAwUKZB5jBCSyXgMKADf2oLJCp
 47qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793681307; x=1794286107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/+BIrslCe8VfsAnh4/7gy6bHFim/OUHoqLz6IpolHZ8=;
 b=TmKK/9FvS+X5u8JXLFYZhrfTEjutNA4zvI75jJEeYbaqPtdC8LhkQ1xcsLsdzTUJIE
 MOm2Ex8FEavxsF7Ix8Jtp/pg2NV2RFn+TlXvLbwrG3lUZn9uN1LCBc7GgI57MiJmQ/fh
 J3qMl0kcjW7LPYW+A4b4GJpe3wrHsSLdauk9byk99Xx7/L0Hapad8q/KveADcyw+a6/h
 F77/z0wrteFLHfWVIu80yxlrBA/4RZMNatnaaB1diTLcnYOHDAIGE3U/nox1qRsk5/jH
 qu50wQsavS/dTK0TPZrJiYg/O4nWxLOXGUgP31ws4NtdpLF5lE0yxAuPDhbB3YvcMJT9
 IH7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrKF7ZHhNVptaw7n7QfN70jDF3YBLbmQ2AFz7QnfHGfVCsjVnUCP/afkaPoWC5rtc7bCfQdL8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/s+qS6dFopW72rTHsTp91ZRD5TB6TrHj9J9J2b3MBqgWm31Cv9
 uaCaUNnxdwtOE20z/4o9Ta2kO7zciyIOmYTUCqBwPEB+GcI1AzZm+TsU3HnXaw==
X-Gm-Gg: AYBFou0m6GKrdYx6jjN0lfjd4veBI41rfWIedcbYC63gR6x7586ghwPqe2XMEM6m1MD
 Z++QRIyZgmCD4y9jz+a+R/fGAySyCfqvJrKn9Evi9GrCI/Evv6pwk8Ls+ea4mxi39d7uwOWwUEB
 dBv6V5x1Zi+MLvJvFX6RNWQ0aDney6NROoV/UeCFagr+XFq6BQPu9Afo1AWoqWasZDI3vCtp2Zd
 XbaCOFPbhMJHIdi9FMrUum+dJdqQtN5jyh7fqj0YJ3capK8bEgoGUmZU2LspPT+lzAzlKkNDDSs
 wRgGl6reYJ2mdSBO5xltJIX6Fx0fpBtsktgNPD5r9mmyNxdDD9Xh5oHSMQlkVVcHwqmlhmFShVM
 SeOC0X8EBpeuVR3z+u6U8Bgl8kkK9lpBrqsvlNvOkf4r/Fbtxw3LZb3pvmST2mgFgQ5KK03eHDT
 LQPom7jODTsQeR5evKaD8ak7T6GysUgjBOCz6F+tz8oqaByL89gOE0b2b9UOSv6jZAJ4wfpOBkf
 +vETiHXFMezzDP7Tw4gtn6kHFgea3IiZ+JKa6SKBwQWvhxrYYfIT5WlZfLRnA6h8ox+fwewkd42
 LJdBbStghWwHGJz3Fg+nPhc1PoCdQZC4GbvqIIRAyObOTHf1T0TD
X-Received: by 2002:a05:620a:444f:b0:93e:6620:bde7 with SMTP id
 af79cd13be357-94421712a51mr2122138985a.20.1793681307454; 
 Mon, 02 Nov 2026 20:48:27 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94425ac5322sm996274085a.39.2026.11.02.20.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 20:48:26 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] cmd: efidebug: require the URI argument of 'boot add -u'
Date: Mon,  2 Nov 2026 23:47:56 -0500
Message-ID: <20261103044822.583008-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

efi_boot_add_uri() is called with argv[0] pointing to "-u" and reads
the boot option id, the label and the URI from argv[1] to argv[3], but
it only requires argc >= 3. When the URI is left out, as in

  efidebug boot add -u 1 label

argv[3] is the NULL pointer that terminates the argument list. It is
passed to wget_validate_uri(), which dereferences it in strchr(). On
sandbox the command crashes with a segmentation fault.

Require four arguments, so that a missing URI is reported as a usage
error.

Fixes: f01c961ee34c ("cmd: efidebug: add uri device path")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Tested on sandbox_defconfig with EFI_HTTP_BOOT=y: without this patch
'efidebug boot add -u 1 NoUri' crashes with a segmentation fault; with
it the command prints the usage and returns 1.
'efidebug boot add -u 7 Uri http://1.2.3.4/a.efi' still creates
Boot0007 with the URI device path.

 cmd/efidebug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index f7329156038..09d14ffd3b4 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -742,7 +742,7 @@ static int efi_boot_add_uri(int argc, char *const argv[], u16 *var_name16,
 	efi_uintn_t uridp_len;
 	struct efi_device_path_uri *uridp;
 
-	if (argc < 3 || lo->label)
+	if (argc < 4 || lo->label)
 		return CMD_RET_USAGE;
 
 	id = (int)hextoul(argv[1], &endp);
-- 
2.43.0

