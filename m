Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332B8FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF24B8460E;
	Tue, 28 Apr 2026 16:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DnxgXl76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5854E8460E; Tue, 28 Apr 2026 16:02:20 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C836C84150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso825321866b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777384937; cv=none;
 d=google.com; s=arc-20240605;
 b=REE84aCMs4pP6WxdMHUQ+ItQlI0yBYFo06NuyJTM8YmF6q2YHwEkTOiu156CCLFRrP
 ajM59CSlkHDBpO/5wIRHFDgqVvZfSsnJxStVXkzJ4v3/A7keTTWCZvQNRcLDUf2PHoHC
 Qza4Rl+lgu2PcZq2V3/TtD6FlAwxLIBnNo4jP2o1ne43ep/Ec5HslxrYkQ+lI4yL/Vh4
 bOvApW2LQA1bZNN+0VLGw7LMTEt6hEuojhJcstGgpSsbpdSnju0i5Unkv2tGe9pBXOT4
 ELpQJo0WIhIHfY3yGqr6F3MbsXPsS6ADTIOoNK9/gPhZRXhBC7ng/+n7lMqfLs72FpWU
 KMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V4k5EbqKE9PRMCLJxxnHAch+ghnW4wNoCpjq0ZseBFg=;
 fh=9l5ysx59nzIxklnTjuF0tQZP9yy/N2ntIV0g4eZh/ew=;
 b=PgA0+4kcWM1/J2fRCfUJU4yeIKYxVfEa+VDHKUSurfFPgRVMUFUnD4GEASmdZEoe/N
 5RJasI5anSX0QkLiGtihVEDWyjNawjyQHeZ0v6mS0qajqom8uzZeczg2mHDWbCrYRt9X
 WD6aOSwpu7+hlBafETk+mhk+b10OS9njGVUXudDg8g8AXiBHgtGA6AEf5layUk13Fall
 vDaq9hTlbblHZBQ4JsfGFhjjP7RsyTpch2jBRAaTesk4Hy6H/5vHrohCD7+pP0Gvbbkl
 AsjsbIiuY90Rj+/+cOxy4prx4aZQt11Xs4KMNKtsNgHBhggVbX64JHL1AMqRHxyIVtJA
 /jww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777384937; x=1777989737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V4k5EbqKE9PRMCLJxxnHAch+ghnW4wNoCpjq0ZseBFg=;
 b=DnxgXl76RYAUVXYc8kgYwceoM1pcL0TF3Y7/2b/qd/cy8+NMtNoSia0NJkateeSGXG
 mYZIT1tkw/4q8OgI3H0zKAw4HVVf1/HfF/D27eKh1ufNcaqVPXT5wRJgVSgwRFWJpgXV
 FsKjnghxFeWAoPACQDkjTic10JLCuTltcR2so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777384937; x=1777989737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4k5EbqKE9PRMCLJxxnHAch+ghnW4wNoCpjq0ZseBFg=;
 b=Bm8qhd0c0M1guQEqzgMPLFLc5EPnS1doYo0WW00UnqwiBloYbMV0++eai1A83awMR1
 jTAobKVtd43vKp9+9TuTBd2Nf1izJgUT4FWhOUwQwaZfvoTFLsI/ruXAr74BQnx6Ojhz
 dKHchwOI85+uBezyWX/d+kFkJq6BE0kLcfmdmoweAzyAjj5qORJW3JydCHyfuBYyDjv+
 quaVck8TEe2hqgpKPU2ah4rtHTUrnCv+Kqxc2tKd/Nv1ggw8gcBQtMjtWIQb5Cs+4gpA
 aCHv0/L3tsuvaN974FYPoWAkTXlZ7iqlFKOnJbDiwdFnPWEjgljVU668pVMyTLJl5swI
 KcrA==
X-Gm-Message-State: AOJu0Yw/M7CEJ64fbqsfdUEvJor3PDt6ELfU/UWOh8hBb8ww+7UsAGL0
 MmSxh2AaLS/m8oOMlr5eFqUIefUoBa646EJ1EYGh0H6O2R/3W1Qk2IEZB92W4vo9i7VD3h7lGeg
 sZiI9vIfin7IKr8wfj+NxpsoYkESBsWyCPwUpZYxUTGlcHyRKYxI=
X-Gm-Gg: AeBDieviPc2wja/TkgbL/uO7bQwht3x/yHSBHec/pSWpeuEgGYEuK/ro7LWCMPCTlCh
 vhB+TuL0NWiWXSs97GQjPiPMtfD5QkWm74s/vKlU3bnRxCdZFBdmPYtLNYNLW0MJx3Q/TDp/3X0
 O/B0Aty/JcL4uJfJpzCt7l7jAZbigxMCnEQbCXzcLu6mOcemVsmyYevU99He7y6D/YR9jhMN0gT
 ka29kAck5pPoud0Vjezxfjj+Bh55PSCR203sH02lAc+WP+6yws16UD4JExl7PObyu66Z8uRTIHk
 BrOqos1vjVD/adEJQcT+lFbTsoA=
X-Received: by 2002:a17:907:7b97:b0:bab:3188:5f12 with SMTP id
 a640c23a62f3a-bb8018ddb63mr205354566b.5.1777384936919; Tue, 28 Apr 2026
 07:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260424033401.90360-1-marex@nabladev.com>
In-Reply-To: <20260424033401.90360-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 08:02:04 -0600
X-Gm-Features: AVHnY4Kv8phqwRZzwz8I7-G0IAzzcYSnmeJ2PXmO50sHuvzxs4V3kqFjtc_nNhw
Message-ID: <CAFLszTiDO_A58xAExeW7sOa=rOz8V-2ttOEJOH3mdC71HQNn1w@mail.gmail.com>
Subject: Re: [PATCH] cmd: ums: Switch HW partition before block access
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-04-24T03:33:38, Marek Vasut <marex@nabladev.com> wrote:
> cmd: ums: Switch HW partition before block access
>
> An UMS session with eMMC device specifier "ums C mmc dev.part1,dev.part2"
> exposes the same eMMC HW partition 'part2' twice instead of exposing both
> HW partitions 'part1' and 'part2'. Fix this by switching the eMMC HW
> partition before block device read/write access.
>
> An eMMC is represented by a single struct blk_desc, with the currently
> selected HW partition being stored in this struct blk_desc. Each call to
> part_get_info_by_dev_and_name_or_num() with partition string dev[.partN]
> does trigger HW partition switch by calling blk_get_device_part_str() ->
> blk_get_device_part_str() -> get_dev_hwpart() -> get_dev_hwpart() ->
> blk_dselect_hwpart(). The ums_init() iterates over the device specifier
> string and calls part_get_info_by_dev_and_name_or_num() in a loop for
> each dev[.partN] entry used as the partition string. If the device
> specifier string contains more than one dev[.partN] partition strings
> for the same dev device, then it is the HW partition described in the
> last dev[.partN] partition string entry that is accessed for all dev
> device partition strings in the device specifier string, because that
> last dev[.partN] partition string entry was the last one that triggered
> blk_dselect_hwpart() call for that device.
>
> To access the expected HW partition for every dev[.partN] partition string
> entry, it is necessary to call blk_dselect_hwpart() before each block read
> or write. Store HW partition described for each dev[.partN] partition string
> in struct ums and use the stored value to make it so.
>
> The blk_dselect_hwpart() does test whether the currently selected HW
> partition is already configured in hardware and does not reconfigure
> the hardware if that is the case, therefore for the majority of block
> reads and writes, blk_dselect_hwpart() is a no-op with negligible
> performance impact.
>
> Example reproducer is listed below. The last sector of both eMMC HW BOOT
> partitions is populated with distinct test pattern and UMS is launched:
>
> "
> => mmc dev 1 1 ; mmc read $loadaddr 0x1fff 1 ; md $loadaddr 4
> switch to partitions #1, OK
> mmc1(part 1) is current device
> MMC read: dev # 1, block # 8191, count 1 ... 1 blocks read: OK
> 84000000: 1234abcd 1234abcd 1234abcd 1234abcd  ..4...4...4...4.
>
> => mmc dev 1 2 ; mmc read $loadaddr 0x1fff 1 ; md $loadaddr 4
> switch to partitions #2, OK
> mmc1(part 2) is current device
> MMC read: dev # 1, block # 8191, count 1 ... 1 blocks read: OK
> 84000000: 567890ef 567890ef 567890ef 567890ef  ..xV..xV..xV..xV
>
> => ums 0 mmc 1.1,1.2
> UMS: LUN 0, dev mmc 1, hwpart 1, sector 0x0, count 0x2000
> UMS: LUN 1, dev mmc 1, hwpart 2, sector 0x0, count 0x2000
> "
>
> Read of the two block devices on host without this fix produces
> identical data present in HW BOOT partition 2:
>
> "
> $ dd if=/dev/sdX of=mmc-a.bin ; dd if=/dev/sdY of=mmc-b.bin
> $ hexdump -C mmc-a.bin | tail -n 3 | head -n 1 ; \
>   hexdump -C mmc-b.bin | tail -n 3 | head -n 1
> 003ffe00  ef 90 78 56 ef 90 78 56  ef 90 78 56 ef 90 78 56  |..xV..xV..xV..xV|
> 003ffe00  ef 90 78 56 ef 90 78 56  ef 90 78 56 ef 90 78 56  |..xV..xV..xV..xV|
> "
>
> Read of the two block devices on host with this fix produces the
> expected distinct data from either HW BOOT partition 1 or 2:
>
> "
> $ dd if=/dev/sdX of=mmc-a.bin ; dd if=/dev/sdY of=mmc-b.bin
> $ hexdump -C mmc-a.bin | tail -n 3 | head -n 1 ; \
>   hexdump -C mmc-b.bin | tail -n 3 | head -n 1
> 003ffe00  cd ab 34 12 cd ab 34 12  cd ab 34 12 cd ab 34 12  |..4...4...4...4.|
> 003ffe00  ef 90 78 56 ef 90 78 56  ef 90 78 56 ef 90 78 56  |..xV..xV..xV..xV|
> "
>
> Reported-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
>
> cmd/usb_mass_storage.c     | 11 +++++++++++
>  include/usb_mass_storage.h |  1 +
>  2 files changed, 12 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
