Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DBA606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZrD9qRwF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ePTtppc2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A15D180A70;
	Mon,  2 Nov 2026 07:03:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6HHMo1dWoeP6; Mon,  2 Nov 2026 07:03:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A351C809BE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793603030;
	b=PHqbIWqJux29XRpb0ZUeSfFlwqjZ0n3nvCZDDtac5vJKmd3dmGNBNtLqurSLPalEPXI/
	 AjztZdjNTqnbY7oBEWINUJPdAyTf6Ma8KWBZNAgzb8vuUHm/ZST7Nslyn9lb9+RM/ddsB
	 sn1ZFJPUmoLpMfoDS3VjXHyr/WLeVM+jQVl5Die0JrRA8RJh9912baeJFt31udaAvifCd
	 eX/880rv0CR/QuqXFVfv4xXvLVcfXQQTczsH+Op+dOnHuLwbwSC89X1wy0axdywJRAdzh
	 +//Sdwx+oowOOzACikCIODMjEuaB1iKyKcDRizFz8eXvzuYWY6HRTyDU9v7XfrrQXyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793603030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dEABzMtmMzxAQ7ep2kGdJr2rHT7ZNMdjGrorDMcENtU=;
	b=C27S98epE6v26Tq167Cz16C8/Q6MNAXFhUh055LnxREl9gT3rLtqGjioP8S7r+hqwIzm
	 V4mWUrXGT1Ed37vZ3zkPa02OxVSHl50eiS+LkdIO6dBFgGVQ6yEFVNaRZigdXUBb1+i+9
	 QNvtmeVId/i56EVAH6Ig1u27t8rMZCyjbVzhblAqHrSpYkrB/aBLNot3UPd8WOxhpO58R
	 9AkelMF5K59keTtCy4kSjGI9Y6JYJ2XHNxEZ4duzRhLNDRiQIK8urF0R0/DD+P9fvQGon
	 iou0VtrrV6SBbAIZaQsfxxyGmPb1fiMcY9k3uRl5Q/NkzPMkorTxz4ZvqZdHU806H3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793603030;
	bh=dEABzMtmMzxAQ7ep2kGdJr2rHT7ZNMdjGrorDMcENtU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZrD9qRwFe+IttxeGfcjR9rJF98OxNrNsaaf9gRgWFRvJX5za+NqfcpCY1ny9PGH4G
	 OiYu6XIa6vj0OLSulSyQU9Xs/BWyPKKNd5QeN5E7qGZqBps27GAKX1LDe4O6Fvs/Q2
	 uzoxs0bO6DMkGC0BLLXaeUM6NCKtZox2OvX/vDgvF6RygNkQ7EyWVb0eZNpBDfDaGY
	 tT7jqMdMqaj1LKfVjDfL2kqUOySsqEDRyiPnGxKaGAOAB0978uCQeP2DGBOe/mdvV2
	 gx7SNLnuaUo0H9U4G4ony/MUvWWqXn6gZNAZzIpIEp1UW0P2LGU7Vivtvlrcq7MaXa
	 Shq1GG1ceCCvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A351C809BE;
	Mon,  2 Nov 2026 07:03:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C0C22356
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:03:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6677400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8z7FBDLQlFZS for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 07:03:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 63DFA4008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793603027;
 b=L7RQ+t4i5yN3sFQhLN1DPEk46BdlNt2YnwXQVVPmDKRlOLtaCDZvuS9rvPz7+qskv5BF
 xSDFNZ+o5JG5F9nHYBk+AFzal4Kk/vGgN0EP7vFwCmmwQgXylC2E2SZ3RhxUCS/kYQekz
 hBD0g/NyYxA/eIepSzCtO7VqeI2+RSHx2o2+bJQDXOkM+TEc0xR26GIvu5ZZjxxqamZBJ
 rBW3utmQDKyL+DPr+4TZhiebsoeJ99/KngMI8mc9wzXIWPwglLmU1ghRrClTGEbVGNwXa
 v770hfd9iAfWFVjdUEdbL4TPVbI5ZvgF4/L7+XiKOOBd2/qumFFCYKSomozw9H9rlAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793603027;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID;
 bh=dEABzMtmMzxAQ7ep2kGdJr2rHT7ZNMdjGrorDMcENtU=;
 b=WCiycX5nN2E0bWGfbKGM9wvWuKOfX6ZTujEZZPo1wDL0N5DDEv+/hCqQDIlnXLuNyb9K
 NMbp0e5KO9b7CUoZrkGP4lz/MO8Bw1DMqVpXIn+zh+ZwXwORkzl8Ne7UY7/f4p1ESpsxj
 Ti7XUneb3CzIlH3O5ob/9hpwv857fkL7SIuuHyeCwMNpGqNgvmcAjGtj5/2g5DtXjw7y5
 6880vC30OCDTZbbyENsK+6eQ3arlx0AFwZepCNT5lW9dIrZGFgHwSwzeHDMA2kZgWie+J
 jKQtCp2q3FRdB+txC9cr+Jvj8DGTTi2mkwJ2OO/7/jmEVW0fFGqH/vMS6pROACCFwSQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ePTtppc2; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ePTtppc2
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63DFA4008C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:03:46 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so20725685e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 23:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793603025; x=1794207825;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dEABzMtmMzxAQ7ep2kGdJr2rHT7ZNMdjGrorDMcENtU=;
 b=ePTtppc25ZUL3EDXnkeAB1DrUhpRDigBa+kP8d5JtM1nVQa0A15luijKW2ejmqZiPx
 vfU+H0TO0VWzG96W3GvOrcGsnoX5WWc403SabJgqerIFxzjHuT3kvmsW+bcVqL3PoEwL
 0yIg5EZ+OBQ+2m49jd3v+McKS3RyMF7BDd4cZ8q6Bx7naMLe84cWPhCpAxBXi92fKzOY
 /DqXFYNFpiSwe23D9AneLMxNu1dBhUepRiABaLxnEd03mSAAFcyM7Tx7T3yHdy0fUf+c
 7KNVoEzPVW0ICrp2tv+TaU0yaQFV3zL8gfXYYkJkAjxgLcVoFu5cralpnpNexbDNoXcx
 IpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793603025; x=1794207825;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dEABzMtmMzxAQ7ep2kGdJr2rHT7ZNMdjGrorDMcENtU=;
 b=NqMWiUQWJ6fzY6Zz752h6o5zS0dawZoMq8QvsZ9+ax5DkOWrcFXWgrIcXI7SuXkFjD
 HpvgqFJbDl2aoqenrHZERCks/8XpyS5BYU6goDoRBVZCfERk1Y/XLqkzgMaQ0xqvWcBC
 bly37FtWYCluMaOQQkT8DHYnTT2ATM0lPrczaoTq6VS0ljsPv793L9R4l60slYS3OkFM
 4ccEkrSCCvHXGpAn1XZ9y3i8HxgbClirLmK+qVp6QpVe+WYf99All0thEgmkMiZyJz9U
 yFSwZ5XJmtWiZaJt1D44BRqL3vQTMXIwyvoW1SYfGeJiWiWs8b1zVvYZ4eWDFSzooPgJ
 JrFw==
X-Gm-Message-State: AFq9FYLyVoFpZWrwX0kQyXg+hCSWifw9xAz1kTcRil1m5LMPFAW+4TmS
 35bsa8AiyIuxRPa7UA1bNnksrXaFCCV97946y/zZqmlGIluIoGjykz5SQiOTCfJtufo=
X-Gm-Gg: AYBFou3mGdRxH3UDWDBF+AdYqSrxjFZce8AGlqFDt2/HHUMpYo+w6B357GadPcwm4T0
 3hmqazuHWB7Ng9MINh591VCrECv1udLHj6etvFyMA3cS0mNc4sLLFk/yhP/NOjKP533Xp+Q4CaV
 xSrrnD5gBC1pdpGqgxHEZpvSbZiRLx6vn3wdAPtYteU1A28NizgQa4hcID55xLTw26NXWEf72IO
 IlO0ZGzFgyqfijWXzOPHc4qBeagYhNkJcCFgz7B8qF5TtvF8r5iszxdws+4ABoFw+/wvGRgRIVB
 pKu0sHxAa6ejUBbG+ZB7HrWV//Erqj2pnwdz/g/sNyhevhAFsZEhMYNq9/+LUulKUV1edqSr6J1
 XFj1lSuLejg3z0ENYYkzQA8OPPDitrf3L6PKB1/uQGUrwVZKn5aAtlhqV79T8tT0klDoC1bjza9
 FgmGodRFeYrocDkDC7o2iR/hb9axtRnskaLK0DjNDVb63IGSgKzzBm3z9ZdCfBRnwU4WbIIPD02
 7ENNAtYiSGdT8vbYZGiYeuSxYBot5Ep3jx6aGu7sBr8MWKaZrN7X3YOegUDZWgJ+jWb/jgzP7UH
 A904FHdFQPPRCaemwZ+shkzMzaxDQfE=
X-Received: by 2002:a05:600c:1987:b0:4a1:6517:ccf1 with SMTP id
 5b1f17b1804b1-4ac16fa2edbmr211574065e9.9.1793603024529; 
 Sun, 01 Nov 2026 23:03:44 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf751c2d2sm275953385e9.15.2026.11.01.23.03.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 23:03:44 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 0/4] bootstd: Bound file loads from boot media
Date: Mon, 02 Nov 2026 07:03:42 +0000
Message-ID: <a601d668-436a-4aa7-bb10-950a89d324ed@gmail.com>
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
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Bootstd reads files from whatever boot media it finds, such as a USB
stick or SD card, or from a TFTP server, and some of the sizes and
offsets that decide where those files land in memory come from the
media itself. This series checks them in four places where they are
used as they are.

Patch 1: the pxe parser reads a file named by 'include' to the memory
just after the config file that includes it. The extlinux and pxe
bootmeths parse the config file from a heap buffer allocated to fit it,
so the included file, of up to 1GB, is written past the end of that
buffer. Refuse 'include' in a config file read by a bootmeth; the pxe
and sysboot commands, which read the config file to ${pxefile_addr_r},
keep it.

Patch 2: the load command refuses to read a file over reserved memory,
such as U-Boot itself, since the fix for CVE-2018-18440. The bootmeths
and sysboot read files with fs_read(), which does not check this, so a
large kernel, initrd or FDT can be written over U-Boot. sysboot had the
check until it stopped using the load commands. Use the load command's
checked read in both.

Patch 3: the ChromiumOS bootmeth takes the bootloader address and size
from the kernel preamble without checking them against the kernel body.
Check them, in the same way as the recent keyblock_size check. Its
private data is now allocated zeroed, since the error path frees a
buffer pointer in it which is only set once the read succeeds.

Patch 4: zimage_get_kernel_version() takes the offset of the version
string from the setup header and reads as far as the nul terminator,
without a limit on either. Give it the size of what it may read. This
one is for x86 and touches the ChromiumOS bootmeth only to pass the
size.

Patches 1-3 add sandbox tests (bootflow_extlinux_include,
bootmeth_read_reserved and two more partitions in the bootflow_cros
image) which fail without the fix and pass with it. All the bootstd
tests pass on sandbox with the series applied, and patch 4 builds for
qemu-x86_64.

The patches are independent of each other.

CI: Azure build 13713 passed, all jobs, with this series on
https://github.com/u-boot/u-boot/pull/1064, a CI-only pull request,
merged with main 3973f3c4d24:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13713

Ana Bobillo (4):
  boot: pxe: Refuse 'include' in a config file read by a bootmeth
  fs: Check reserved memory when bootmeths and sysboot read files
  bootstd: cros: Check where the preamble puts the bootloader
  x86: zimage: Bound the kernel version string to the image

 arch/x86/lib/zimage.c    | 27 ++++++++++-----
 boot/bootmeth-uclass.c   |  2 +-
 boot/bootmeth_cros.c     | 31 +++++++++++++++--
 boot/bootmeth_extlinux.c |  3 ++
 boot/bootmeth_pxe.c      |  3 ++
 boot/pxe_utils.c         |  7 ++++
 cmd/sysboot.c            |  2 +-
 fs/fs.c                  | 12 +++++--
 include/bootm.h          |  6 ++--
 include/fs.h             | 19 ++++++++++
 include/pxe_utils.h      |  3 ++
 test/boot/bootflow.c     | 51 +++++++++++++++++++++++++--
 test/boot/bootmeth.c     | 75 ++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 22 +++++++++---
 14 files changed, 238 insertions(+), 25 deletions(-)


base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
