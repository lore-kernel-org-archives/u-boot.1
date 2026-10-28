Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ADF606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kkkH6J8O;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XeXJQV5O
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B73F80DA9;
	Wed, 28 Oct 2026 05:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hNh76LnWV5wi; Wed, 28 Oct 2026 05:50:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 307A480CCE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166658;
	b=h6v/wJZ9vJkWKQJkg+1zJCuBaw1Bh0A9hCixH7svOQruAQxjiBbNwcbbIFiiiIelHD1g
	 fPLjkOK4YjLQhA+KRivkxMqzdF8CWxCKRk8LaD91rLYCvf5Y0r2xKkGeXkdFMj1CChE2K
	 xAtZnZDkHbmC9Nw9tFmwcg1HSXVbaDmcIIJxrBOa7LxjoSC2By9a31wxhVWfvALnKgCu7
	 Plv9XpU3uqQzp0Iueo9eKn8AzG4PDZixq5Ismk/GNDEEn4hoRdqUnv1w1M/yw8wGGxa/G
	 0RGsjzmhHDGReL1iGdgOYsTCmSTc4kIPi0xSdJ/+jWo9csX/KiK9f3MLM5X8eE73wsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ygpCNxU/5RT1uYqJ7u9+sTS24haZWXebtrL9XJvp6Lc=;
	b=QIl8Jy0ipkX45YgGdoVHNINSm0+4i3ybze9oU4V46iq5avnS7c4SsxpwrqV36fT57zbA
	 a1KCvs7JGWMLOEAt4Z0BRXhcMQJmcpD55l5gsblfXaAKD9zmv2mRGWVawsSDwDuFfHOAn
	 t5BVQiitgmgQBLVMALrPmHxhFl3DQL2F7xX/hoTlsyvfYtm/uiD8vQeimj2HfsJjiWHQc
	 dTefFgqJ62bkc83NwqIc9BoJFP3pQX1tHPVa7LHEO8A/cyFX42JzjaqVA4p+9DJBrTVg5
	 TDvHWYcj9dTKAG6HM4Y9cqiCNr63pgl246QHWa17jJeu4Xji9l4zVYUKjZh9G3pyRHQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166658;
	bh=ygpCNxU/5RT1uYqJ7u9+sTS24haZWXebtrL9XJvp6Lc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kkkH6J8ONO5l3wss0PiGUe4L7Imnt2SsJJXfAs+WCMyZv3Ki1IxP4q4bk5RtdN007
	 6vevRQ+cQPhKtCtNsQNOE2CouOIrINWN6I2SykIgLiuvhaQpwNwQoPdn39aG4LXD+f
	 /K2RyhNiM4C4ZnPQHUXoODoCB9w54rGputgFcQGgo9Fx0aB27xky+foGQFkm6UXRSm
	 dH3bGjVdMaWPAeEVs4TOpEXR+UufeLmvtpqrECzQeXnQBGeyU5ZC8FrIu3Cwoajc7e
	 CVq8TWIXtwGd1eIY7DhMRGw/dulGk65uV54rdUidzgS7fbmaVZmWedgqBp6Zqmnxsz
	 ZfSKGmyRg/+VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 307A480CCE;
	Wed, 28 Oct 2026 05:50:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC7114D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE51F6065C
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hgQRXKOwQaOa for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:50:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 82F6F605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166652;
 b=HCaBSe7e+N7g7eQytg0mOXcZvw0tgyzhm96JfGEd+DsYxTi7UnXwT6C4cU/M8BtnCK9j
 zkUN7B6LExzD3wAx6yTtL/UojsE2sqWxYYWbWd0iIn23CfqDxGLN9vn3wsIsOOIouVGyw
 I9UXZW7a61BZ2cqc2T9iRkT8JA2aNmJQAtlwjdW+w/ludXIV3xL0cagDXn+VoCWiah3ig
 M2PFjiSK9IaiIhoi+LHMxRoKsU5no3A0zYzfaRNr8y+RXAN8r8btoAYvN1hsaAdSOtlBL
 Zk9WxBujf3ZecP8l7IwZeLVNtMWNzWdDi9ch7JYvU7DxOXscHB0orJ8ojwx0APyEdvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166652;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=ygpCNxU/5RT1uYqJ7u9+sTS24haZWXebtrL9XJvp6Lc=;
 b=NMZPuDkqzBb72oOiBEoFIXUMDs8ZmrlxMu7otSQ7JetUD7thbW5bCmD3BWW4kI2kUsvV
 RBXAzvqjg0v4wMdJ8rPsBZa/zr10ly9FaUspUf3x767zL5hdE3l/394X/PPE7buJASd5y
 VwdMsFp1ntqmC92o3qzEFynmSKZrBWLLXZfVxgA/2BpAfzJ3FOZyeJ7NTOW6OrEunDpNd
 EpKhPn//HMPFhSgEwguDG13A1mFdF1TLv47fFoTObif9b7/PlW9Ie25wmwaLxvY6O4Fro
 0AHMMo9S/9zPHX1B2Zs1L4I+kOopxIKLE/4On9o4EGaYg0J29D1jzHrQ2RB5RM2+HyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=XeXJQV5O; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=XeXJQV5O
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82F6F605F7
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:52 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so4891465e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166650; x=1793771450;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ygpCNxU/5RT1uYqJ7u9+sTS24haZWXebtrL9XJvp6Lc=;
 b=XeXJQV5OVRcqq5gG48MexfmhrTjx4oYiKCL3L6DDyfyFFXC384JVDvLE84j8HYf7yL
 VSV0ESa/FQo+A6hunrksFn8gNz4Lne2n4BhAawkbbpPBpaVv3KjEjNOKRj5JLrLt0YlJ
 dedNocKmub11IdzbqgZFKHM0hRkmUEkQRAEacEacU6+EKg0cYnEmaCkhyA22igtQwJ5n
 CLYgp+3N6Ih9lqCbSEx2uHhzvY/MlWokrBmemojMXuruluq4bNo/ulBJ+QVOXYWBw5//
 54oNyRvpGROl7qUUmGTp1AQ1GDGIANQK9MtOGsKd8tkxFIwoBznDiMYlL215h5u604fH
 y6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166650; x=1793771450;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ygpCNxU/5RT1uYqJ7u9+sTS24haZWXebtrL9XJvp6Lc=;
 b=Yvz6hRUm1jkjQ3m36sOHpcfkqvdRp64sn4VsoOaYPqKPPleWp9yfBwM5T9M70EXani
 KhsVtho7JFIJVVJz64oHKf7x0JOWqNCRLE8l+vkvRRpHSNWpUCuKIk3bJXgg/Yjnm9l7
 wyICWP+ZeJJwKGhRaru2v4PQ9RgcUce/T14NjELv3g5n7gRUMbQU/eZ5L2inJkEUOx/8
 lo+qFPorVjNv3YlNmbDaoM9iVP7mw2Sf9d+GZG/c02oeBVD2Bx1tfPZiDWbNvEpC3SBG
 TJRR+DRyfLEFqbBJnmaqZ2G4HvneslS38LLRQy1JeJ7vVTVOX7FFG1hRbJSdzJXrAvkF
 HwHg==
X-Gm-Message-State: AFq9FYIQqYkHDCFurXgoFwtndSrj03BUkKaKUwkrD2vdsYo3nXZVl8oL
 HHUX9AxNS1LSnvNHKpycboh117029orhTfl1e4cmcHb0g9dY6Ox/50Dt
X-Gm-Gg: AYBFou25iE2mwKoK3ulGguYRA3OnsUcVmQ6i3ER1C+sI869ZYEmFEmaShBI5IiS9ePf
 QzrWDXl20hQNSZL8jVE9jk1oDnzrIUKSjyzNtzf2IeyIQYnKuccTBjgjMx694aEC8XJG6dNsVTF
 eyhuAM1ejgg/52tyA7wFhY8H71irxQuCiWPyBI1a5xpfUpcFpdybPRI3Dkhw4GF0v8aCIpc1vK4
 wShlHbBDb5XylD92IJVzeV49sMsvyg+J+F+s4nuHa5rIFIxA1u46hDu8KvznuaT9gqKm6VD1WCc
 A+5TzOX5fyzgsL+u9iY9gED1pbi3wvnl5QorhDEOxPrB0s8O67k84NepyAoX8nsR3EFtMFDhbt4
 81MK+8Ty/ycP0kWatvgcKM5mvPr059DruKjc2t29lbt611Fi/Z24uM/5kISm33tFIaLAobBfnKk
 wWR6qO2zksBPgHIPGi7tMfcDFZZYONBjdEJsQVSuligUZBOwva4fLLaFQwMCxUnKwEsk5MyqT/5
 iO6cIzQrF472ZrIl2DTt00vAS1r8/LGZjPXiAvaaONib50R2hYRT5Rcj/MnZAUJgyLul5y899Q5
 1EM1A1bdMwmym6f1BImNRi4rYoKvuoY=
X-Received: by 2002:a05:600c:1c23:b0:4a1:9663:7633 with SMTP id
 5b1f17b1804b1-4a9662a0b67mr22594845e9.11.1793166650239; 
 Tue, 27 Oct 2026 22:50:50 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97cebfa16sm29821415e9.13.2026.10.27.22.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:50:49 -0700 (PDT)
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
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 00/12] block,
 disk: Check block sizes and partition tables of devices
Date: Wed, 28 Oct 2026 05:50:48 +0000
Message-ID: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
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
initialises the card anew, as "mmc rescan" does; a follow-up will check
it there.

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
measurement read past its buffer.

Patches 4, 5 and 8-12 add tests: DM tests on sandbox, for the GPT a
test in test/lib on a blkmap device, and for the TCG2 measurement a test
in test/py that starts an EFI application from a GPT disk on sandbox and
checks PCR 5. With the series they pass, as do the rest of "ut dm" and
"ut lib" on sandbox_defconfig with CONFIG_ASAN (but for lib_crypt, which
ASan flags without the series too), and each patch builds and passes the
tests present so far on its own. The test/py test is
skipped with CONFIG_ASAN, under which sandbox cannot run an EFI
application; on sandbox_defconfig it passes, as do the other EFI, TPM
and GPT tests in test/py. The IDE and NVMe changes are build tested
only, as sandbox has no emulator for them.

CI: stacked with my other three series under review, the series passes
all 91 jobs of U-Boot's Azure pipeline, in build 13698 of my CI-only
pull request. Its first run, build 13695, showed the SPL cost of the
blk_post_probe() check on the boards named in the changes below.
PR:    https://github.com/u-boot/u-boot/pull/1064
Build: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13698

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

Ana Bobillo (12):
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

 arch/sandbox/include/asm/test.h  |  20 +++
 cmd/host.c                       |   5 +-
 common/usb_storage.c             |  10 +-
 disk/part_dos.c                  | 291 ++++++++++++++++++-------------
 disk/part_efi.c                  |  68 +++++++-
 drivers/block/blk-uclass.c       |  15 ++
 drivers/block/ide.c              |  23 ++-
 drivers/mmc/bcm2835_sdhost.c     |   6 +-
 drivers/nvme/nvme.c              |  33 +++-
 drivers/scsi/sandbox_scsi.c      |   8 +
 drivers/scsi/scsi.c              |   4 +
 drivers/usb/emul/sandbox_flash.c |   8 +
 drivers/virtio/virtio_blk.c      |   2 +-
 fs/btrfs/compat.h                |   6 +-
 include/blk.h                    |  21 +++
 include/part.h                   |  26 +++
 lib/efi_loader/efi_tcg2.c        |  51 +++---
 test/dm/blk.c                    |  41 +++++
 test/dm/part.c                   | 221 +++++++++++++++++++++++
 test/dm/scsi.c                   |  37 ++++
 test/dm/usb.c                    |  51 ++++++
 test/lib/part_efi.c              | 203 +++++++++++++++++++++
 test/py/tests/test_efi_tcg2.py   | 222 +++++++++++++++++++++++
 23 files changed, 1198 insertions(+), 174 deletions(-)
 create mode 100644 test/py/tests/test_efi_tcg2.py


base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
