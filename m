Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B40606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EbTew763;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wuTYh62F
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B6AA80F47;
	Sun,  1 Nov 2026 07:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b32599OJoRsA; Sun,  1 Nov 2026 07:01:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DDA9E810C5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516492;
	b=FryRtGIsD5ptO2/ylZNJ2D/CKDhQ0oKkuI8mFUqWjHnDDF8YzYLqqP+DFB3+tjWss2VO
	 0BVn8pynPbPk861yqrfw+pLDaVUyGSqvo9wA6DfCTnQXjlFAUwbIqR/XJSdIZEs4MVpIK
	 OOdro6D/tI6R5F+huShH9y2mI8K4IrJH6b04ZHAZX+JWKC3yC2WNBmYzaeP22kQISdFkV
	 ltGUtDU8PkfGVNuJBJh5OuiTQsGfeyopRgxx7EvrKAl/qfLFbfpCqFEQ4J8QNSO+3wESe
	 Mptact6M2rbHWub/0zGm1TBeLeeYsXyZP05TcGBsR6I3nVwQwmbAmCEuNYYptLW4MxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=e1QJypvI9hM8D1LlysTbOEQ8/SJIz1usSMO849ITq20=;
	b=W3+67Xj+9CXdZWeb+V+1aE2W/1ol2bO1f6Y3baWb5a5aVYlDdeCL35vGsO622zJ1/cfh
	 Krxe9TW1qfzgb+UgH7UosDzdSHFf6WH1qCgeJ7lAiXHUTPirNWiek4rCDvfqh9R7bAzBm
	 QnWrsvn0EDcydpwCXPn1OlmC18pLyvfAx2jLSPL5O+PSF16u8jWw7FwSOIU8DpkLiGEMT
	 23Oc6eO/fvfX6G/zFnUuU4jjPRC6Dt9VPC1qX/JkMhHIOmdgF2Hhs206lHSqcvO5iNokO
	 VcN45H7OJjY7JQY4WlPYV68YDGQGz+rV7OydRkiesdFyxVWTx4gy/nQ9hB1PvAkqIAA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516492;
	bh=e1QJypvI9hM8D1LlysTbOEQ8/SJIz1usSMO849ITq20=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EbTew763wmNTEs0cjV/IQSQx/m0BZ/FMiVgSKkiyKT0L/sPLtOkigB2HrnHtOYq5E
	 o4Ur37SMvVCfDmqDsRwcOlOjvbXUhF2HGwZQKnI81J0qAlIDYSG7mMOnJUzIrz4nTf
	 L3x2jFFGyO7EvRx4jSv8CuuDE6jugUHYDPmHaU9S+IkJjKMje3DJECy57rydFNAuOe
	 UwQlbyPmXcU5AzBRJi1uegVXBnM0Ws9po94nV4urYnG3vXkBtFjn/yZ7adweAZ6AhA
	 bhLTALNj21KiEhBcc50MVhcGpGkwu8M7Z7buRK274Xyf0LzO8Zt+PArakzbwQagErK
	 6J3huUPsJ6W9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDA9E810C5;
	Sun,  1 Nov 2026 07:01:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01C76D3A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E72D0407C5
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z8724l0fgKTM for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:01:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B3E7407A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516488;
 b=fDzbyLaJAhcVMSzJfI0h+HqXuk1G9FCvsjECZHUkdTUNpXw0cGL5eMyg/nPeuKHrHTiM
 e7i5V6vRIKSdGYfH73CfeYiymgMt3XLEAa5RaNtPjPYjpOqNyYeLg77d/gYeMJslEAZGb
 V+5VgZvJrxK2dnLHo7Na7SD5oOnY6GOffPoRfRSJTj2MANRy4LFJMIr1rOb/XVd6zrdtp
 TQqb2686QnUTB+o23M06rhD3RnLunmePKtFV+qRPNYKOsOFXUXspxQt07U/rouCDdviUq
 x8SiVN9UJSsh8KjUf27aZKPe8yUUJ1Iby3XYz5OO1S0SZKI+vhKVONPiXdL7rqKlf/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516488;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=e1QJypvI9hM8D1LlysTbOEQ8/SJIz1usSMO849ITq20=;
 b=Rwo3V1Bke2/s0/VTN4a1dgF3HTIiRD1PR9G7ecHMdpbaUDWnDpnW+wZ1QyCwA88DQe1f
 DaiiZ6zeCldTVDgrtQKLSrSHzAyt44b0q8aDBJ16u8Zg/4MtlziPx4jgP+lVB7aTIpOM3
 KkuD2gKrMv6DzNMQhCFwBz7agekt0YyBPBGrTtTcF+dqgb2P4X4ibdbcZp1RqdQxnbmeW
 0KY1Z8xmw3pi0an4AGigKzMqJxPQZHv2v4QW7sDGPsHy9JCAKpxohAwQyynTH0TR0ulQI
 yKb+8s2Piu2sR16D8BjYkNL/8HihXVCqi5XWn9hsSsZZ5D12iPLYHHNDaYS7y/vbQvw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=wuTYh62F; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=wuTYh62F
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B3E7407A0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:27 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e6eb21a8fso722166f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516485; x=1794121285;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e1QJypvI9hM8D1LlysTbOEQ8/SJIz1usSMO849ITq20=;
 b=wuTYh62F/kvps2XBBpHHkKWIQ0wUpOg806WZRcsxh1wkey7lVVXPDRwVmH+LSHaYyJ
 6HArf5WoU1fDfjWR9wLmYq5eGMAye8vhblDbkg2pw0SUnt2Oq70sUDd/PffCNKE6lfZV
 4WWAY6XEqd5Br/YXjK3gAB4kEgB5otfr1ZhbUNX508xF2Ycm12fiOUzaRpjD51+tXc9Y
 602fav/cIwA5j21Koe26amFHC/H52gdAPbkkrKC2938Ajp0QGWaZjkyh2Tg9Q9wsLbob
 eatKrSkZyJAzTpho5SzplkH7v5FmwHbyhLiFl+ipkZo+8UdPg7rmnC17W9Vh/TDp1/aa
 8reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516485; x=1794121285;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e1QJypvI9hM8D1LlysTbOEQ8/SJIz1usSMO849ITq20=;
 b=Kr8yB2TvDoLjNoW+xD+g3FV5bZHppohbv8J219Igl88FCdasgZT3HnrXkU7wUNqrKn
 KHtMJj8NAcEbGoCG820G+Rtp92Rbe66xl8i4P61mzI5E41S/cpKzcITdmZhsjArH0Yum
 yffbLp4Imwx4pWD3G4pVzmoTLmTXbwr+Axf6bYPhAYflQnUyX3krAF4aC9P6ginFgxWh
 sJnFLOwTQXv/mzRR7HkPib0d9WvqmXakEc2OmmFh3BsaIL3BAtLTR723444vkH3uxqCK
 I6U95eqei3OCNf0PZCJGYBeoPoIzpBtAeu8JleSt3l2ULbQ5dYt7y6K6UH+DwFy5GrHE
 QAJQ==
X-Gm-Message-State: APuU4Z9GSy5K5PQsGd0JF4iWxexBKHSpwfH0Fs8rQxL0I4g3o72O8osB
 83nOPlYp1BYfb6+KD9pW/+F3GBjubQM/SffZDgn+EgHq+3+t+VWUZYuH5vYYUtVWack=
X-Gm-Gg: AYBFou2ei1C0U5ZuIl/r7keaF8aLAZRj64BFO5WWeytJJB6VAYdWLpjvtw3J8+3Hneo
 1BE9X5x/9e07R3X1p9s9wqT/X6TlPs1XYhpP4rVk5vBJdso4HS8QPkINaVkIWcXbVmV2GD9wNZP
 5MGSa4RRK65wyPwJDiq/2OzTMqTCh4yeX6GPYbb6oTW989pg6V6XxVp1YjyoyeLi+sxklvflXAY
 3YxsBKIdPycwrrsPQVDNuW6wvtqhA/TZP1KNt4oOt0FKvWcdx60W7sMSfIsKDGixs23vJ+3oW07
 ZWEboM9p60qQaw8xA5aqcxAiMCHaJDuK1Zm8rQ0xXc0Abs32/XVjVwWt0NK4OBanyX0iqUPbdOg
 midMTK2LunC9ti/hqjvRBAH2k25Iz3he/4gPHcVxauSsin9v1ZxJz3BMw74c5We1NR/SZdeZeZN
 bEdsayYm//idWFRQr4Cs9cWTfyrzI7RQ9QKqlUOUve+iwxMHynxkW2wMeaU66c+IbrHA9DlGeqM
 GsgjQjDtmfvc3Sniufo5tLgWcBZeUxnYi9ERZY4EDwIMiRkFtGjDEh45GI0sYz+ZIg8oRbkOKg2
 WPEukZZ/DXW8iqR3Bd/K0dNMM0Xi0v8K
X-Received: by 2002:a5d:588e:0:b0:48e:6bbb:c3f3 with SMTP id
 ffacd0b85a97d-48e6e2fd071mr14531549f8f.28.1793516485321; 
 Sun, 01 Nov 2026 00:01:25 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae25dsm11367248f8f.59.2026.11.01.00.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:01:24 -0700 (PDT)
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
Subject: [PATCH v3 00/14] block,
 disk: Check block sizes and partition tables of devices
Date: Sun, 01 Nov 2026 07:01:22 +0000
Message-ID: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
in a row that hold no partition. Patch 11 makes room for partition
number 256 in the UUID made up for a DOS partition. Patch 12 has the
TCG2 measurement of the GPT measure the GPT the partition driver uses,
read with the driver's own code. It read the primary GPT itself,
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
13719 of my CI-only pull request, on main 3401e006432.
PR:    https://github.com/u-boot/u-boot/pull/1064
Build: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13719

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
  disk: part_dos: Make room for a three-digit partition number in the
    UUID
  efi_loader: Measure the GPT the partition driver uses
  efi_loader: Index the GPT entries directly in tcg2_measure_gpt_data()
  mmc: Always use a 512-byte block length

 arch/sandbox/include/asm/test.h  |  30 ++++
 cmd/host.c                       |   5 +-
 common/usb_storage.c             |  10 +-
 disk/part_dos.c                  | 291 ++++++++++++++++++-------------
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
 test/dm/part.c                   | 221 +++++++++++++++++++++++
 test/dm/scsi.c                   |  37 ++++
 test/dm/usb.c                    |  51 ++++++
 test/lib/part_efi.c              | 222 +++++++++++++++++++++++
 test/py/tests/test_efi_tcg2.py   | 246 ++++++++++++++++++++++++++
 26 files changed, 1329 insertions(+), 213 deletions(-)
 create mode 100644 test/py/tests/test_efi_tcg2.py


base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
