Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCCC606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aaUhmVAt;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=RCqYCWRu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C581B60A7E;
	Sat, 24 Oct 2026 10:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gp3l0C1CSbnD; Sat, 24 Oct 2026 10:35:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9FCE060688
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792838102;
	b=BScFMUo7r9Njy5bTmlv0OjsI2d7m01PPXpdiJEfoJ7PRkAGUGtwXkBad3wSNjVkEYwDf
	 R0fHdhN7Lt07nwJLnOBtK6zawJDz1xzkfzXIe5DC8vetG2Udayzt4d8U3/zDrDCdV4SdQ
	 SnFI8+dDWsNpNxNu+oCv/Ok86uKIPCKr/W9YY95njDJBRlvcifMgyM7tU7nfqLfzya+/n
	 MSRjbkuTvCMim51O8uh6GLxLyGuukdjtr63H0SOxcEvc5ZXhZv/4kb9h0Vyge6bU2b4KK
	 OJAk/vVfPfBJqSwyxj78p4srZ5nSHtQVqNkcYwHXVqLIroctldLTH3VUs345xUWbX+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792838102;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=09ewgE114JZmh+p/dVyu93XfCmN0zEWqty12tAO4kh4=;
	b=AoQmTU7tZIpMi+aOvHucWTxjXKRprNBGkrucLBrN/iU+oHqFpa1q0ADN9Mkt8xFLFs1U
	 yplbbeXlAsHQLN02K1L8RQ/FPSeTji7PwoCQS/tCToj/ZCB26G08E2Va+DJJa846N/Ii8
	 VxZdhhftLVKh04yCwHLDeIPo70TDh6O7Z6lL8bg6CtY+Sty7WiNMJUFKAyyrNxc9jH98r
	 /gU9agYq7mN0vZjBYaTUsgEm5KM5mj2xE1Zy/3jRhlWyjb9Hxh0Frj175t/3Vx07GWPn4
	 LgX8n12oplGd3xufn0/Rz8HbPAAUxQYoyM81d1FJmD+Vc6jdwdaoebGfviSMQPZI1Wg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792838102;
	bh=09ewgE114JZmh+p/dVyu93XfCmN0zEWqty12tAO4kh4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aaUhmVAt7sX19S1XoHC/KXAzumytoAIkbKnXH+QtOLEUkeg89PBFv+VxSoXfxpm9x
	 1oJKacw81Rnddq29QrLL52lZWpHkWqHEzHoR4HFnC2vR0tYqqjz0piUjvOA7oEcA4P
	 3aEaqGUlEtUhCB2CgPPr/H77zc0WHqo6tNDN7JLYuGTqElWhFBGY8AxE8W80Gp02Da
	 o03QKhMripnOVM72qkY2AEHy2DL6irsSM/1pzmiplX8tD0Nn9FJay24mDvzIv84ilx
	 XyE1BELZLMk1Unolo0s004D0U9V/JvQ4Z6yOgdCyqOr119eOwpcG5W0udjV75KKzfU
	 6IkuXvWKhv37A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FCE060688;
	Sat, 24 Oct 2026 10:35:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F18A43
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54D4040A80
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nParl7FLnOsl for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 10:35:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8A849409C8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792838100;
 b=a0YsJqAS7P8dU+yAHsnKMQyGdB+/WWlJW4sm8gx9t7j90ek5NgLXrVYG+raVjJXillnM
 kq2wQrORdiuQknHiC9T6BQhCr4Iti+RuB5Bu0raOEQ0pBCbdqYkpQ6ZT8rxUtIdG1mRXV
 xBSMU7KrXKuSeNPcjiKScc+2DD5ISlZMYqtWKXbHMTY1u7hNNpZMVcPKs8CEUJcJg9ZV4
 7URYv4cWS3gQmW24buznoXPdRyKSkop8Tim6Fsawnzp1WpUt0iRWkII9ymLGOnObw18Wg
 qMTOgFZ8y/A5zVakLSxIZZc6qC2Caa1cxErxAHcSd8mkPJlBOV3Mveb6q//8Wge2j/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792838100;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=09ewgE114JZmh+p/dVyu93XfCmN0zEWqty12tAO4kh4=;
 b=qgLpUBV/6xQz/9BYNmyaghEOrGurGAfvOfYgPfMLe1x7AQ4eWGtl9olhPW1H+5wGe7w5
 APNiFBrdYphBbsAME/4NN5FEM8KxpDr9abmcrw4cyZAZutE2iQ0EklmHy7v6hxZUnLWnp
 773GiWal5i7ZkBi42T1+c5tGQAs1yRFTWpenFaSRvH5eTezlGuSSP0WhD5TnT7aAhN+h6
 rumdVSCXMnQ3X+EMqeLxW+G0EgPi+F+R90iBkmZnOjkDO4sC0BimK/1buYRG5j7LL/R6g
 jf6AMnW44CIfINwuJYJsBRX9/O0o3OltVvltjWVgWRH0NR8+gfS3u6oCaZTVc1yoQdw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=RCqYCWRu; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=RCqYCWRu
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A849409C8
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792838097; x=1793442897; i=xypron.glpk@gmx.de;
 bh=09ewgE114JZmh+p/dVyu93XfCmN0zEWqty12tAO4kh4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RCqYCWRuO+PdTLU8zuuUtAAEjb67n/6hBQv/Cl9os53Zf8g0O6LMqC1myaQFOzh/
 MY1S5Wh2TS02SUIU83gYolkRj2wl56g4dOnjFsBZTj3FQg9wyVB0suDFwB+FjsduS
 WsCML8hi/1SPox90HgvlAEo4HuAC3ifoQbKfwsbdTcICD9pk6K95ZFepzQ1H+8/mP
 z2dGWwQe2bqNPaonx6o+7iI4fkfISju0xzTCtXBRoJ2xALPkYftL34vjmxdv3TuaR
 3lz+fcUylqNvfvgyQ04MZVox3oXVwzaMPkIr6YgGD8xvT+rEaHNQTGHhDywAJ2d8B
 OCc26e5g6HMKnPynpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1wpgFk21JY-00etHC; Sat, 24
 Oct 2026 12:34:56 +0200
Date: Sat, 24 Oct 2026 05:34:52 -0500
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ana Bobillo <anabobillo3@gmail.com>, u-boot@lists.u-boot-project.org
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/9=5D_block=2C_disk=3A_Check_bloc?=
 =?US-ASCII?Q?k_sizes_and_partition_tables_of_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
References: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
Message-ID: <22E4FA95-6F13-4C14-948A-6EBD295245DD@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZNztiVzFKdkMS/Q8mTIk4FPPDx3uTPHw60uflsrS10rL5dJ7c2j
 hXCkjt4udAYiA9KOi/xImV2r2ztCk/UIWPOi2Ya9zps8AbWZqaa2baE2p9NLgdU40WnArNi
 YTN/pjcjdA8ley3EOfHdCsNSM5jEeKjbzVLgfVdRWrnk/GmN3kEhAfy6qpBuOzLkIKOlbhG
 zdDnPukjA08alC4JBE9aw==
UI-OutboundReport: notjunk:1;M01:P0:ilmkGMpO1Xo=;fhde63rkYpnNLmv0PPyBFz5ljVT
 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
 whhWfhxXohJva1q7rINm3E/Guo6/z0g=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 24=2E Oktober 2026 05:12:28 GMT-05:00 schrieb Ana Bobillo <anabobillo3@g=
mail=2Ecom>:
>U-Boot scans the partitions of a block device as soon as it probes it,
>and takes several sizes from the device and from its partition tables
>as they are=2E A USB stick or SD card that U-Boot merely probes can
>therefore make it read or write outside its buffers=2E This series checks
>those sizes where they are read=2E
>
>Block size=2E A block driver sets the block size of a device from what
>the device reports, and only the virtio block driver and the host
>command check it=2E The partition and filesystem code sizes buffers by th=
e
>block size, expects a block to hold a 512-byte boot sector and converts
>between bytes and blocks with log2(blksz)=2E So a USB stick, SCSI disk,
>ATAPI drive or NVMe namespace reporting a block size below 512 bytes,
>one that is not a power of two or a huge one makes U-Boot read or write
>outside its buffers, in the partition scan run when the device is probed
>and in the filesystem code after it=2E
>
>Patch 1 adds blk_valid_blksz() and has blk_post_probe() refuse a block
>device whose block size it rejects, which covers every block driver=2E
>Patches 2-5 check the block size where the USB storage, SCSI, IDE
>(ATAPI) and NVMe drivers read it, so that each refuses such a device
>cleanly: the USB LUN is skipped instead of failing the whole stick, no
>SCSI block device is created, the ATAPI drive is treated as one without
>a medium and the NVMe namespace is skipped like an inactive one=2E
>
>The upper bound is 64KiB, the largest logical block size Linux accepts;
>the GPT code is already tested with block sizes up to 32KiB=2E
>
>Partition tables=2E Patch 6 checks the header size and the size of the
>partition entry array of a GPT, as Linux does, before they size the
>CRC of the header and the entry buffer=2E It leaves
>alloc_read_gpt_entries() alone, so it applies with or without Beno=C3=AEt
>Monin's "disk: efi: Reuse the GPT entries buffer with simple malloc"=2E
>Patch 7 walks the chain of DOS extended partition tables in a loop,
>bounded by the number of tables read: a table linking back to itself
>adds no partition, so the limit added for CVE-2019-13103 did not stop
>the recursion=2E Patch 8 makes room for partition number 256 in the UUID
>made up for a DOS partition=2E Patch 9 has the TCG2 measurement of the
>GPT check the primary header it reads itself with validate_gpt_header(),
>now exported: the partition driver falls back to the backup header when
>the primary one is not valid, so the measurement could still take its
>sizes from a primary header that the driver refused=2E
>
>Patches 1-3 and 6-9 add tests: DM tests on sandbox, for the GPT a test
>in test/lib on a blkmap device, and for the TCG2 measurement a test in
>test/py that starts an EFI application from a GPT disk on sandbox and
>checks PCR 5=2E Without the series the new tests fail; with it they pass,
>as do the rest of "ut dm" and "ut lib" on sandbox_defconfig with
>CONFIG_ASAN (but for lib_crypt, which ASan flags without the series
>too), and every patch builds on its own=2E The test/py test is skipped
>with CONFIG_ASAN, under which sandbox cannot run an EFI application; on
>sandbox_defconfig it passes, as do the other EFI, TPM and GPT tests in
>test/py=2E The IDE and NVMe changes are build tested only, as sandbox has
>no emulator for them=2E
>
>Ana Bobillo (9):
>  block: Refuse a device with an unsupported block size
>  usb: storage: Refuse a block size the block layer cannot use
>  scsi: Refuse a block size the block layer cannot use
>  ide: Refuse an ATAPI block size atapi_read() cannot read
>  nvme: Skip a namespace with an unsupported LBA data size
>  disk: part_efi: Check the header and entry sizes of a GPT
>  disk: part_dos: Walk the extended partition tables in a bounded loop
>  disk: part_dos: Make room for a three-digit partition number in the
>    UUID
>  efi_loader: Check the GPT header before measuring it
>
> arch/sandbox/include/asm/test=2Eh  |  20 ++++
> cmd/host=2Ec                       |   6 +-
> common/usb_storage=2Ec             |   8 +-
> disk/part_dos=2Ec                  |  47 ++++++---
> disk/part_efi=2Ec                  |  48 +++++++--
> drivers/block/blk-uclass=2Ec       |  15 ++-
> drivers/block/ide=2Ec              |  11 +-
> drivers/nvme/nvme=2Ec              |  33 +++++-
> drivers/scsi/sandbox_scsi=2Ec      |   8 ++
> drivers/scsi/scsi=2Ec              |   4 +
> drivers/usb/emul/sandbox_flash=2Ec |   8 ++
> drivers/virtio/virtio_blk=2Ec      |   3 +-
> include/blk=2Eh                    |  20 ++++
> include/part=2Eh                   |  23 +++++
> lib/efi_loader/efi_tcg2=2Ec        |  16 +++
> test/dm/blk=2Ec                    |  41 ++++++++
> test/dm/part=2Ec                   | 146 ++++++++++++++++++++++++++
> test/dm/scsi=2Ec                   |  37 +++++++
> test/dm/usb=2Ec                    |  45 ++++++++
> test/lib/part_efi=2Ec              | 161 +++++++++++++++++++++++++++++
> test/py/tests/test_efi_tcg2=2Epy   | 170 +++++++++++++++++++++++++++++++
> 21 files changed, 839 insertions(+), 31 deletions(-)
> create mode 100644 test/py/tests/test_efi_tcg2=2Epy

Hello Ana,

Thank you for your contribution=2E

Unfortunately you sent the patches as appendices=2E This does not work wit=
h tools like b4 or patchwork used by the U-Boot project=2E

Please, resend the series with git send-email=2E See https://git-scm=2Ecom=
/docs/git-send-email =2E

Best regards

Heinrich
