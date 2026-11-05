Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E105606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BdkBYrCr;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=VqCDvf8V
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCD1C80A84;
	Thu,  5 Nov 2026 06:32:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLnyznp_hd2U; Thu,  5 Nov 2026 06:32:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 19AFB809B7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793860352;
	b=ccWLz/lpR6emrSMyH7PaeUDklj6JzMYXH+Ku26EHoaXfeywkQVpE4Vjs5JL4Cf5jB1YA
	 Sv0bdWJXDxQpJmPTr+ElkknGXBtTAVMKMjGy+d3jLm00bho29GAsNrbPwvAsdQVx+IruE
	 ar75RGa8QHc7lRzu7LquhymoIY1Jz2kpbjxMwMEKSOHDX8Ge1w3ylKjhepwC9jLE5d0mC
	 fFTPUGNO3W22UC0WAIiomfxCrto4MkIgX/6cTzKgn0Eg2matHqu0nAn1+l9TjObAatq2Y
	 0QomeYvY9wjPNXbtl0qiGQCWNVZeVLZkZqQw52BjTcsOME+4SPyVGshvkUmlI1OppBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793860352;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3hRcfVTKeylDgThQR9UnrAQgN9G6ipfBCnCVReNCe7I=;
	b=PvU9iWzH4RpamYb3bn1XdMQ6UOs+UnzeYfP0APJUqZ9LOhCxUFVWDuicAYvKSmPdQslW
	 lk72xAGrlg6+e8UbEXMkq39oRS0iUl/yuCABW8HwVdKk2XzAk4LUZ74qLadIcGkV2a7Bn
	 YIb3eZ5l+0R2PZo/sPS62ME8l3GMLAWPmfF2fm8B/eRZh2hYEonHYHLdZQ5RYN76LspSF
	 w4rd7kMMPqsMkLB7oeu7tI4l++yD1WJmYN+lbkrpNP6+9T96gwD98GbFcHvHsXQF63frG
	 xk/HdFvVRio4VeyO1n0JXcjiGOnPTFJzOlbc+IguU9Mc35ecoZoQKKdR8UqGFjOts+A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=VqCDvf8V;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793860352;
	bh=3hRcfVTKeylDgThQR9UnrAQgN9G6ipfBCnCVReNCe7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BdkBYrCrOvlFlZrPSjq8Q0JO9cAALWYfUxVXEYukS6q8BKj+G/z44Ua0mrZ9pBmR1
	 grmgUEagXIR8dJGNq8QQqKHXvU8OFDrbHbn1mA9JXmRXPIYQIzuDhZTvPJsLIEUZGA
	 Ip68ILpfDN5D8hIu53sp0qCcXwmkKrqA1NWafu/a4Pcg7PExa2+EGVrt9ZvYqyXdZn
	 DZ0QA257yCTGTct2ZCjW+k9NWWI6MrZGvgFDA8MS+kZW4voWh4q+QCulujg0OgbGaN
	 MZHgq6fMHuPlyxTxyd9GVPZJc29aSJdXQU7Anp6/A4V5rSUWsa+zyKG18pQgkSrvsT
	 n6H8BTsoK7enA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19AFB809B7;
	Thu,  5 Nov 2026 06:32:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B05C7362
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98A95809B7
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 40OQ84Estk9Y for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 06:32:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AE53880993
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com;
 envelope-from=shubham@octane.security; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=octane.security
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=octane.security header.i=@octane.security
 header.a=rsa-sha256 header.s=google header.b=VqCDvf8V
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE53880993
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:32:29 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8a05f2d5cd3so733443b3a.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 22:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=octane.security; s=google; t=1793860349; x=1794465149;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3hRcfVTKeylDgThQR9UnrAQgN9G6ipfBCnCVReNCe7I=;
 b=VqCDvf8Vcxi9Q4GyBXlJtfTcWqTJDZtReJraRwqjsrykcPZZla6/uYtdRk0Fm58qSI
 xRnEE63AZ2/XDLxw9CldJ4m1XYGN3ditzSf2FLq+1tCWbdZYBBkyLbbdfCJq8xvTSO+v
 Gtr/wn55so8bjI06XgyNaFgJSEvCWFlzRktvTUX9bUhFeJqGpcmIQuGdDIGnY/bz3hAO
 m5yJx2T/pMkQCfxD/jAuBXKQGLjQYD/dN2lQ19uvdskuXZvlXhGnWjCKqY1nLCutkdnO
 6IcjmA0w0cOXjdEB12edy0fN6C3yn2rQoGu1S0QNylx4zlkjJhIoEbXRGgiTlSZtIBer
 oOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793860349; x=1794465149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3hRcfVTKeylDgThQR9UnrAQgN9G6ipfBCnCVReNCe7I=;
 b=dzcDg9DbOJ/ypOZUGgGPGQ3cbMLBINsaCyP1SVvfYQDZGzhdFcVqmU5qBSXgs6GGdw
 GPhTzcQ+urCgaoVPl4FoHkfm8ectUFtcrbt3uj80mgXw+HR/HuJKb7hEUV127CT/Ipsv
 xj+23SwqfVxZcvXJZfM+etRnLW3xUbJfM3ikhAI0ZfJlqg3+SH+EM9csqTDpg8/D4KKS
 ZMu1o+lj2Jled/aU3LryVDnOtDBS2m6VE3k/bREViuJsKINzY4mLcG8Iuc6j3QY7o9eq
 vSst4XsU35GH//0+fDvbzjs+2Bv+pDKm5LX9D8FPdQ1lyYixGzedtEJRHVL0JCRklFrk
 mo0Q==
X-Gm-Message-State: APuU4Z8xG/Y9p9qKRt9duPd3RNUG5UOnCmg6+aVS1kCp2h++71n0D6Il
 XmJW4JE7W1H12PafJeabVJyZ8tsjAxcbmJvHZtse/VeZT04ozDTTTzTWtth2QVGb4tjMT7TKWuf
 fd/eY
X-Gm-Gg: AYBFou3c7gjRWYAg1gdKVUmLXjJM3N7kHioVCS/gykPca4NuuVBlNjecs60MI7C08/i
 U+NMkfPWzd+tt3MKtG4TYSbkzVd48SYMeYdGVVb5o5vaYKgdxuLDPGtl/t6VU7Ifi+73/SWoe75
 J5eDqg7xQ7zzK3yXBswhaJN6aLwIT4YbNNlnLTponaibbrmqpCG38H/dHGaPOb3kVcD67np3sh5
 sTnCFpeTPOxUsjpue04M1Ux3az1ZiQceNbCauEmiPf3AAD1XBlF1eXFIQrkDOb/CmS4CmQqEWFs
 10dN1Cr5XlmVfsp6pmMGJoT9A0yHeIXrWTOaNkHRBukr/TvHFBFkc1PaQx+BYTherTnlPKn8IJf
 Q8oyWkOxDioZg7h8Tr3cSNOQJZrPmE7CBxuVm4RJ2A/Eo1bQ3TxZPyfAdataI+BTkKkotfaFHrY
 fEuTUMLKeas27QpLbLIyk39fqryacrxTK9fdckDNTC9+VkPmCRnmnz5WFfnRrtYsb3PCFhlcfZR
 DxwVx/xibRl1OprK2KTkO/qWG1hmUsGshYMh4444UJzvnEFToplPHMmSUlYCLLJyZTUNuWMszpY
 FVZKSAwhslNPMdHXMjkR9DPwSgKoCOGspDZtf4ToN3rkmdum7R8raXN5kW+Kmwxp49soDEwqLJd
 UV74bbw+baqoW9S2b2MdESo9NM/NgcXnnGxEE37d8Z6Ex68oCx4IG/AD9W2T9g73fC/Sc61w=
X-Received: by 2002:a05:6a00:3911:b0:881:e626:74a0 with SMTP id
 d2e1a72fcca58-8a9be490bb2mr13717949b3a.47.1793860348588; 
 Wed, 04 Nov 2026 22:32:28 -0800 (PST)
Received: from localhost.localdomain ([157.119.219.79])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09ba508fasm1607541b3a.48.2026.11.04.22.32.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 22:32:28 -0800 (PST)
From: Shubham Antil <shubham@octane.security>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, xypron.glpk@gmx.de, sjg@chromium.org,
 maxin.john@gmail.com, gio@octane.security
Subject: Re: [PATCH] fs: fat: bound getsize in the FAT write-path cache fills
Date: Thu,  5 Nov 2026 12:02:23 +0530
Message-ID: <20261105063223.90560-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105061133.88030-1-shubham@octane.security>
References: <20261105061133.88030-1-shubham@octane.security>
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

This is a short note on the security issue behind the patch we sent
today (Message-ID:
<20261105061133.88030-1-shubham@octane.security>).

In set_fatent_value(), getsize is a signed int. The existing "cap
length if fatlength is not a multiple of FATBUFBLOCKS" line
underflows when startblock > fatlength (getsize = fatlength -
startblock, both __u32). The wrapped value is passed to disk_read()
as the block count. disk_read() has no bound of its own, so a
crafted FAT (tiny fatlength from the BPB, plus a directory entry
with a large start cluster) makes the block layer read far past the
fixed 3072-byte fatbuf -- a heap out-of-bounds write of attacker
disk contents. The path is reached by overwriting an existing file
with a smaller one (set_contents() truncation).

That is a controlled-content out-of-bounds write. We score the
proven impact as CVSS 3.1 AV:L/AC:L/PR:N/UI:R/S:U/C:N/I:H/A:H =
7.1.

This is a missing sibling of CVE-2025-24857. 87d85139a96a ("fs:
fat: Perform sanity checks on getsize in get_fatent()") added the
same clamp on the read path in fs/fat/fat.c only. The identical
cache-fill in fs/fat/fat_write.c was never touched. A clamp that
lives only in get_fatent() does not close this site.
flush_dirty_fat_buffer() has the same getsize computation feeding
disk_write(); that path fails safe today via the write overflow
check, and the posted patch bounds both sites.

On QEMU-TCG the same spray can be steered into bootloader code
execution: TCG re-translates DMA-written code pages, so the
overwrite of the relocated image becomes fetchable. That is an
emulator property, not something we score for hardware. Physical
ARM64 keeps executing cached .text after a DMA write (no icache
maintenance from the image), so the expected hardware outcome
remains the heap overwrite and a crash or reset.

Affected: CONFIG_FAT_WRITE (not enabled by sandbox_defconfig or
qemu_arm64_defconfig; shipped in roughly two dozen in-tree
defconfigs). The posted patch makes getsize unsigned and clamps it
to FATBUFBLOCKS before the transfer, as get_fatent() already does.

We are not attaching a PoC. Happy to answer review comments on the
patch.

Thanks,
Shubham Antil
Octane Security
