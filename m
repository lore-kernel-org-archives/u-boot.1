Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B086A606A329
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XkYpaLRe;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sN9hwczw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D5AF6070E;
	Wed,  4 Nov 2026 12:50:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OsLoYSY5UfOl; Wed,  4 Nov 2026 12:50:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 36BEC6062C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796617;
	b=jho9R0OkL2q3TlQDVJgRzrSB1F1ebcem7KwPf5Oc4GNqolsPjm/V62WnOIzKZg+YaErD
	 eIOOQ7z2X8URlJnNjlIjnl+lO4DjtU+MPQNXWtkm/d1ah4XDCrlJCBVX4WZrSaB9xYNI3
	 LKpPDJ7adJsB6xjYGqlNalgq8ecMHzChY/uyf7saB355NGTQ9W+3sBT5SjMEkDFDv+t28
	 UQ8HERtXVmWy0RRgW9znBv8TRXvBxMTxi4mvjoTR8EvOBRcqWGc6IkDuFwkOPPdBkEZtK
	 pS6VYzzR/dd7VtLxI/g0r7sJRhndeat7GTHtR/+LXz01ki2ybt4KJCAQ1kHJmmeewbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=36XhXB3rDMiZPORNtbMzI5UZfiavAXtLIHfu+AgKlBE=;
	b=hsn6eoyUQidURmQC+wQBYxKi8+GreD5KhUfZF2tYz90bZRUQ7gu72k4hHWODc1cq50sH
	 bq8ZC4XOnNzBrZiRgS0jIw7XeqsBf16hIjwbEo27o/hqAZ//smJXLQGkpggmtNFA/SM0E
	 4wovgPvO/mFLd1COTWpi+UXbAeDOC285gWLnLHTkyZ+zWa1yeyMOlEtmUBT3+RyZQPxtT
	 hOOS92QQvG0eOMlj6ZpOZH9F1l7nKstK3EZI2ZDr4Xifk3/l/m9LxTrWwpQPMXsiWD8/0
	 TUQyisOQtjBja+Xrq+lYFMSQcYy+gEu/Epm1EoH25/GnjXT66rGX8G0mHW2ksD9IQ9Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796617;
	bh=36XhXB3rDMiZPORNtbMzI5UZfiavAXtLIHfu+AgKlBE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XkYpaLRekMo4KbqUAGzdl9l6AdWEhuMUrqDxIj079uuYJ7HQH+HafvdMj29l+DPeo
	 bhDRrJQY8mD/o8LbzNM9hr5LyJ5lvtlBeAmjMphfmTj2/2YBRx4pY7937Qidlzhf6h
	 OvF+JIi2Wb2wdRQ8XxdTMHfD9c4AgLDFRrUH91vw61mNkklZtCthbzVzdxexkPT3bD
	 oz6D/bvsnYboMjDv1UJSYP6P8fqx0g22BgDgD8Yff/N26vT2fwZJvxf8HZiY1k8caW
	 UMKzM5OjZpc32zbscYtUK2OTJfQNAuFwFkOxNnrhoARfgDCtiwL0Z4LKe8pVhdrrqX
	 LzOUbUhx/RDzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36BEC6062C;
	Wed,  4 Nov 2026 12:50:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B654435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0ABE80CA6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E1Gcj5NTjJfM for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:50:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 99FE980C95
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796615;
 b=szp73aTqm7UIFG1MCLkLUQ/L4N/qVXjowRlrNBguuowZeVYQ934eMA0OX2Ym8RJR/s0N
 gmLqBqcPuwhZIulyG9ZedDy1nnZDCnqLIwZZbAAHaEhIKFeZU48/jCAWlcx+gSzorEw4W
 fDIY62RmPiw9pFAurI/LSJbJfj1tN0oX58ETchPoSklSkargwaGpmZSLsj/fAdvWPPa8i
 69dXawdB9qXq+8CisSK8EGx9psU3x/KcRaaQDEIfFt6FG6JCsK3mTQbcpGc2RoutotpbY
 V8RRUlLtOFB8XhMT62CyNPlh7HPD1/+NOXJxrPz3ZAadxphILzhBBXNsKVXrEHGOb4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796615;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=36XhXB3rDMiZPORNtbMzI5UZfiavAXtLIHfu+AgKlBE=;
 b=HbVgirhLSfQ+CBiUyLv0tz2i7rBKw3dd/9g5niQW7T4KsYMsMM/FcDeZv7INdBhfemmt
 cMAWagw4tufxEUMoiTv73C79L1PWMCp22PAesTpof7pkQmHJMW9x33kJ6JIy78/fyj9mr
 ijxpmPjkmkNHHIoHemnlZ6ChHzWT3LRrLvf5DIEi4rdj2L3fi6GWLaq97CkhGmXzWz7CZ
 7bFi2x3/ZyfKbl5emNDQQ2ml6EBMaqjtTVIvJJzcSnY4LfpdGnzgtksrGKYZR4obHpF+G
 nEaQqSQeR5SREqK4mFnRWY5hHZ6akUEJQSNDsNzxpsndZYnPsZtsxUEo3w3iPUFPx6w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=sN9hwczw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=sN9hwczw
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99FE980C95
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:13 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c445c95d553so91062766b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796611; x=1794401411;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=36XhXB3rDMiZPORNtbMzI5UZfiavAXtLIHfu+AgKlBE=;
 b=sN9hwczwGInUU9YvachN6jVkMpDvuE+Y4IR6UIdjmjztYcP9iPCGPs1zPpx8w+iFde
 mP68HLhb+rJM7vKeLbECU7Roii5OgjYVMvIoMmP6GSsxUbBgzhbMVJtCHHwZLBsRVI5L
 gpNdp2o5gUD9iqa+0iX6UUPw2bzijuIgErTGfrGzGYEHjO7ujSyVeDh+W7m49KhXK43I
 B38Hxhu1yDiXroRKRsSajxeo75KFm9XWB0jS8BsfnSWCtTl4ogkrlYSbJrxbp0jDVXNB
 iPoDJapfqED/IcOzVD4NniJzP8cJLMD8lp2Yi75Zf4liPrKray6PwZUgv4IyBc2/fhem
 NrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796611; x=1794401411;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=36XhXB3rDMiZPORNtbMzI5UZfiavAXtLIHfu+AgKlBE=;
 b=ufu1+FeU6Pr3ocdIFRYMHJUCeWjF45wtHf0VlH9c2S/iQJRDBGaBUL/HQV4jqGot7q
 9Urs6qKLSMxQaIcPFtwJRYU2MMjhabUdExsVxOAKcDIoBSo7OWQbZrKqEJ+AuK1p9KaD
 jvcYe6PedkylvD1UB5CyVtoq2pD7ihhtd4Ficwrjz+As4hAMHY0/Hg81Yzb+JXV1/NTQ
 SBOElbGzppDvEUp9Z/3QSn8Vv2bzqrPZLiMtuY7dV+YpXVYW3TbyJxGxdnrXhKydJ90H
 VaXXanBwlroW1iWiCk0KxrBSt2dyendUIssATckiQFCF42YFn+3MsBkJDIihCVahLqou
 2nCw==
X-Gm-Message-State: APuU4Z+9giXuVtN4v1tCAsmCHLOKrkYcFwyuRREhRCLaUmFY91Pir4W9
 pKDm4mnL7XagQ9EDsIMxhU01yH14Gc4vWg4xsnnATr7BxnKsn5Xe5IFJ
X-Gm-Gg: AYBFou2o4vdV6RLGdGrZ1aAFGXCdoGDAWYWbg6BTpAgi9S5jizxPwZvvY0fXvv3hdsX
 /4s/8dWYdxdo4lOWSETTLumWP8dtPjMXYI9K/7soeMbVCkZwJ18br70exdDEAr8fzWOJvJBZagp
 zwm93e3Qt8KL0nu5bQhITCMDjAVrNRVtU0rb7dpCrvi0ral2YnNM+Z4Io5/3BDRM36P2Q3SM2VO
 1XC+Z017nQSBbmHRon7WmvY680n4nb0lYE9LC11zO4nq/QK0fqjHrFSUrx2dgAia6MQT/xIC+tv
 byO22RKzZNcNX+KXWDhP/VHhr8z76jQsMQizCIR+krzftlHFoI792A+J8Czy82tlGHzrtScVxOi
 AYctnrSZZIn+atcEQpWL23sQQHcWsvaa0sNVG82eUCFI5Dm25yinw2yFOlf4wn43ObUNHyiT91e
 XzRbXVgde1Eb0TRhaK9uJxjrxFGlBupkBVJWJY0kZFk43PVEafIuITRFXqxigLIoV66Uq65G8ha
 8UJrVw5N27sEAjTypr/1Jn4ZS8AAgmclJYLaeIA3p41ZX/lofKyGsDE+m5U3Dqu59Dlg3xu5RI8
 H/t34FSk2vXPo3yy70hJ97JO7p0627c=
X-Received: by 2002:a17:907:d9e:b0:c21:9b4b:2690 with SMTP id
 a640c23a62f3a-c4ca7a5763dmr1410637766b.17.1793796610414; 
 Wed, 04 Nov 2026 04:50:10 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e14093bsm66907366b.11.2026.11.04.04.50.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:50:10 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v4 00/14] block,
 disk: Check block sizes and partition tables of devices
Date: Wed, 04 Nov 2026 12:50:08 +0000
Message-ID: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot scans the partitions of a block device as soon as it probes it,
and takes several sizes from the device and from its partition tables
as they are. A USB stick or SD card that U-Boot merely probes can
therefore make it read or write outside its buffers. This series checks
those sizes where they are read.

Block size. A block driver sets the block size of a device from what
the device reports, and only the virtio block driver and the host
command check it. The partition and filesystem code sizes buffers by the
block size, expects a block to hold a 512-byte boot sector and converts
between bytes and blocks with log2(blksz). So a USB stick, SCSI disk,
ATAPI drive or NVMe namespace reporting a block size below 512 bytes,
one that is not a power of two or a huge one makes U-Boot read or write
outside its buffers, in the partition scan run when the device is probed
and in the filesystem code after it.

Patch 1 drops two local copies of is_power_of_2(), so that blk.h can
use the one in linux/log2.h, and patch 2 adds blk_valid_blksz() there.
Patch 3 fixes the reply the USB storage driver makes up when READ
CAPACITY fails, which gave a 128KiB block size on a little-endian host.
Patches 4-7 check the block size where the USB storage, SCSI, IDE
(ATAPI) and NVMe drivers read it, so that each refuses such a device
cleanly: the USB LUN is skipped instead of failing the whole stick, no
SCSI block device is created, the ATAPI drive is treated as one without
a medium and the NVMe namespace is skipped like an inactive one. Patch 8
then has blk_post_probe() refuse a block device whose block size
blk_valid_blksz() rejects, which covers every block driver when its
device is probed, outside SPL and TPL (their size limits leave no room
for it). The MMC code sets the block size of a card again when it
initialises the card anew, as "mmc rescan" does, which that check does
not see: patch 14 has it always use 512-byte blocks, whatever block
length the card reports, as it already did in DDR mode.

The upper bound is 64KiB, the largest logical block size Linux accepts;
the GPT code is already tested with block sizes up to 32KiB.

Partition tables. Patch 9 checks the header size and the size of the
partition entry array of a GPT, as Linux does, before they size the CRC
of the header and the entry buffer. It leaves alloc_read_gpt_entries()
alone, so it applies with or without Benoît Monin's "disk: efi: Reuse
the GPT entries buffer with simple malloc". Patch 10 walks the chain of
DOS extended partition tables in a loop: a table linking back to itself
adds no partition, so the limit added for CVE-2019-13103 did not stop
the recursion. As Linux does, the walk now gives up after a few tables
in a row that hold no partition. Patch 11 numbers at most 255 DOS
partitions, as Linux does: a higher number overflowed the buffer of the
UUID made up for a DOS partition. Patch 12 has the TCG2 measurement of
the GPT measure the GPT the partition driver uses, read with the
driver's own code. It read the primary GPT itself,
unchecked, while the driver falls back to the backup GPT when the
primary one is not valid, so PCR 5 could hold a GPT the partitions were
not found in, and the sizes in an unchecked header could make the
measurement read past its buffer. Patch 13 then indexes the entries
directly there, as they now always have the size of a gpt_entry.

Patches 4, 5, 8-12 and 14 add tests: DM tests on sandbox, for the GPT a
test in test/lib on a blkmap device, and for the TCG2 measurement a test
in test/py that starts an EFI application from a GPT disk on sandbox and
checks PCR 5. With the series they pass, as do the rest of "ut dm" and
"ut lib" on sandbox_defconfig with CONFIG_ASAN (but for lib_crypt, which
ASan flags without the series too), and each patch builds and passes the
tests present so far on its own. The test/py test is skipped with
CONFIG_ASAN, under which sandbox cannot run an EFI application; on
sandbox_defconfig it passes, as do the other EFI, TPM and GPT tests in
test/py. The IDE and NVMe changes are build tested only, as sandbox has
no emulator for them.

CI: the series passes all 91 jobs of U-Boot's Azure pipeline, in build
13729 of my CI-only pull request, on main ab4dc5aacf9.
PR:    https://github.com/u-boot/u-boot/pull/1064
Build: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13729

Changes in v4:
- Patch 11: number at most 255 DOS partitions, as Linux does, so that
  the UUID made up for each keeps its 11 characters, rather than making
  room for a three-digit partition number; new subject, and drop
  Simon's Reviewed-by (Heinrich)
- Add Simon's Reviewed-by to patches 12-14
- Patch 14: drop the reference to the patch adding blk_valid_blksz()
  from the commit message, and say "does" of DDR mode (Simon)
- Rebase on current main, which needed no changes to the patches

Changes in v3:
- Add Simon's Reviewed-by to patches 1-11
- Patch 12: rename part_get_gpt_primary() to part_get_gpt(), measure
  the backup header as it is when the primary header is marked IGNOREME
  (ChromeOS), name the device in the warning when no valid GPT is read,
  and shorten the commit message (Simon)
- New patch 13, which indexes the GPT entries directly in
  tcg2_measure_gpt_data() and reads their count with le32_to_cpu()
  (Simon)
- New patch 14, which has the MMC code always use 512-byte blocks, as
  blk_post_probe() does not see the block size it sets when a card is
  initialised again
- Rebase on current main, which needed no changes to the patches

Changes in v2:
- Reorder the block size patches, so that each step is bisectable: the
  helper first, then the driver patches, and the blk_post_probe() check
  last (Simon)
- Use is_power_of_2() in blk_valid_blksz() (Simon), after a new patch 1
  that drops the local copies in the btrfs code and bcm2835_sdhost, which
  clash with it
- Split the USB READ CAPACITY fallback fix into a patch of its own, with
  a Fixes: tag, and fake 2880 blocks rather than 2881 (Simon)
- Name the LUN that the USB storage driver skips, and check the message
  in the test (Simon)
- Take the ATAPI block sizes 0, 2340 and 2352 as 2048, as Linux does,
  and say what is skipped otherwise (Simon)
- Leave the blk_post_probe() check out of SPL and TPL, where it took the
  SPL of imx28_btt3 and popmetal-rk3288 over their size limits and broke
  the link of evb-rk3036's, and say why it is outside the PARTITIONS
  condition (Simon)
- Include linux/sizes.h in part_efi.c, and word the GPT commit message
  so that the fastboot path is not taken as fully covered (Simon)
- Write the DOS walk as a for loop with a helper that follows the links,
  and stop it after 16 tables in a row without a partition (Simon)
- Measure the GPT the partition driver uses, which checks the CRC of
  the entries too (Simon), and when the primary GPT is not valid the
  backup one, with the primary header made from it, as EDK2 does
  (Ilias); say what the bug does to PCR 5 (Ilias)
- Avoid ut_assertok() of a known -ENOMEM in the GPT test (Coverity)

Ana Bobillo (14):
  treewide: Use is_power_of_2() from linux/log2.h
  block: Add blk_valid_blksz() to check a block size
  usb: storage: Fix the capacity faked when READ CAPACITY fails
  usb: storage: Refuse a block size the block layer cannot use
  scsi: Refuse a block size the block layer cannot use
  ide: Refuse an ATAPI block size atapi_read() cannot read
  nvme: Skip a namespace with an unsupported LBA data size
  block: Refuse a device with an unsupported block size
  disk: part_efi: Check the header and entry sizes of a GPT
  disk: part_dos: Walk the extended partition tables in a bounded loop
  disk: part_dos: Number at most 255 partitions, as Linux does
  efi_loader: Measure the GPT the partition driver uses
  efi_loader: Index the GPT entries directly in tcg2_measure_gpt_data()
  mmc: Always use a 512-byte block length

 arch/sandbox/include/asm/test.h  |  30 ++++
 cmd/host.c                       |   5 +-
 common/usb_storage.c             |  10 +-
 disk/part_dos.c                  | 298 ++++++++++++++++++-------------
 disk/part_efi.c                  |  74 +++++++-
 drivers/block/blk-uclass.c       |  15 ++
 drivers/block/ide.c              |  23 ++-
 drivers/mmc/bcm2835_sdhost.c     |   6 +-
 drivers/mmc/mmc.c                |  34 ++--
 drivers/mmc/sandbox_mmc.c        |  11 +-
 drivers/nvme/nvme.c              |  33 +++-
 drivers/scsi/sandbox_scsi.c      |   8 +
 drivers/scsi/scsi.c              |   4 +
 drivers/usb/emul/sandbox_flash.c |   8 +
 drivers/virtio/virtio_blk.c      |   2 +-
 fs/btrfs/compat.h                |   6 +-
 include/blk.h                    |  21 +++
 include/part.h                   |  27 +++
 lib/efi_loader/efi_tcg2.c        |  76 ++++----
 test/dm/blk.c                    |  41 +++++
 test/dm/mmc.c                    |  40 +++++
 test/dm/part.c                   | 234 ++++++++++++++++++++++++
 test/dm/scsi.c                   |  37 ++++
 test/dm/usb.c                    |  51 ++++++
 test/lib/part_efi.c              | 222 +++++++++++++++++++++++
 test/py/tests/test_efi_tcg2.py   | 246 +++++++++++++++++++++++++
 26 files changed, 1346 insertions(+), 216 deletions(-)
 create mode 100644 test/py/tests/test_efi_tcg2.py


base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
