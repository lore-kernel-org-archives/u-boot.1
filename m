Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24089C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 13:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 995698497A;
	Sat, 11 Jul 2026 15:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GGMoA0nZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1603B8407E; Sat, 11 Jul 2026 13:03:08 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81F183EEF
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 13:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miladh1539@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-ca957432c7fso1270265a12.1
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 04:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783767784; cv=none;
 d=google.com; s=arc-20260327;
 b=cUDnSU9doEw1Ata5iyLE2i9QPLxUMSWK+j39wd8aJKyvBg2dzGx1eFqAsiPGSjF8Z6
 MfBSjioqXqcFt8KGA7TY5OGw+wq0SHKeb46btdVglEmXScLzLYXfgRo2vofggD0DkL6z
 DuaKZHkm30UHsw7Uv3xMNZvVDC0Ref8tNZPxTJiWHV2AtEVLdZpXUeGYNTdrXjBo1yqw
 q5Kqc5S/RStKK/1i/0wgL7TAh6jx/UaCriu0MHR04+j8YQCVhNAh3e5xs93nCa+lwKeI
 TeJXmWmsHQbdsb3CAOjuhE0KNfK9iay8h+8tkDwJWYgxnxGn4H4icq7J3j9ZE0cuybme
 Eo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=ppUqU0ZLeksiUDnsPyDOhX5ZACUvgdxmFuBY/0xMJSI=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=au+JbGakkaL/vnSQdD93NsH36e9Bnhh1f3/MSjjg2JFxptuRViSVvw0cj35wyX/ar6
 gaCCgLe8NHvhppUZRwF777X0ThvfBoEdY5VpkaTcv192DmENVuPwkBHjye3xG9/PBHdF
 TgvqRLneQCMcOv2tgfUMGeL45TnUF5MpdItzczI3pv302LjbzzyYN5b9kpsD8yBYHt4i
 HRikKSqlMgzPqADRNA4Lb58mXjXPqGEm5ks4duBNrCO9a+wKu7zz8FISeGPGQhSv24kV
 zZQwifIxU3uFlnvYodDCZVmMRommuf5hIsXep6aQFD481xnjCReyiZDuC1EkSaepboEU
 /9qA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783767784; x=1784372584; darn=lists.denx.de;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ppUqU0ZLeksiUDnsPyDOhX5ZACUvgdxmFuBY/0xMJSI=;
 b=GGMoA0nZ6SsqMVgCfEtnfbTUL8bkC1gCma9fvnJclmj9dk5P2lkvV7iGnBVrgsg/WT
 q0H9PNMfCjHwcxnqjZPRA4FY1DWONH0WoWNK0NZfKsm8WZcV9ooVyy6pXthwkmtjCp4m
 4aP7FBimiviAYDII7eSVfYn3h4XzKE7euz976RSpyTFg7VA1NWFb5ztHHOpD/1ilfAFr
 C1RthgmHfET7mGq7FPvueIMzzrot1D57yaUI/OSKN6la155EdKuLIHFm73imPXvqY+ZJ
 K3/S9bY+QdmaBnmBKXdQDVU36iGz98Gmui1oNiLA95ZGHVQlVp2AYLUJMeZ/xh39+W0i
 YCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783767784; x=1784372584;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ppUqU0ZLeksiUDnsPyDOhX5ZACUvgdxmFuBY/0xMJSI=;
 b=c2mlKOHgqk8VlCcm9mgsO9QO39PSAb3csBTJheP//Xf324zM6R/fsZhUn5lk27X1sp
 J/yubqw2djFAZBOS/A6f7bQdBkoCy4S7pndd5WTZpFPuFM1HmObosR324d/wr4LUknZz
 4vz9lUJW4sMl4McsTRZuD3iHP+lXB2OZRaHW+ieXai5P/KLaeKr+kLR25AeBoY6Afwad
 K335Bx8PL9Ljb9epeQ1oKPYX/32JQh1Gak2PnIe7USazCmf19MmERimnkyBdW3II1YX0
 ngUnDp9PZ71almxSVXL32PJmSp2SrYekuVxEeYFLbMNRgIXZ+scdoOKfB889U7/swYSI
 L3sQ==
X-Gm-Message-State: AOJu0YyZaR/0qN5QADQeIC/+sRQ3g5XthzrfOmvKKW1LxyEjFw0zsQ1w
 ZQH//xKmIGXwiAS4vpvb4HeiTLaGVA/ZR0160nCrVMuv+EP23dvwIaYsr6mkGf9nDTjTjw9err2
 0FwESz34DK1j3SvA6FMX5s8dzpzrdvjWyWQwsd/0=
X-Gm-Gg: AfdE7cn+EF3mvzIu+QU4E4jf1Q2DKsY2GPhFbdq3J6XiqJa+ela1MaHe2u49uKG++g3
 BpG/GCwHtMnUvKDvXf6WYucOBZvO5SD6c7xfyUf39PiHLpa8p+hfRGVbn7A4C4sIxurH8OeVdjl
 ceCbp2jBj7srvxUU4/cde1SaSJU+MKyrY6pizBXRb42yKhv9U7PmxTiLXOaVBrdDQ8MA0BfOMxm
 KvgUOGWf3VYHIWsT1CRpHt4Pn1K2SV1Ms6DRktAiGM1DxpOFHlMhtPci02vdKmXXkVLda3OJCRN
 lU7Wovz3bYt0QidZOsduEYdCgUc5yg9ORCtwmA==
X-Received: by 2002:a05:6a21:e097:b0:3b4:b276:a789 with SMTP id
 adf61e73a8af0-3c110b43701mr2710116637.36.1783767784081; Sat, 11 Jul 2026
 04:03:04 -0700 (PDT)
MIME-Version: 1.0
From: Milad <miladh1539@gmail.com>
Date: Sat, 11 Jul 2026 13:02:53 +0200
X-Gm-Features: AVVi8CcbbLlqOXF3i77h3vRzKWCust6LOKjrcG0rvWBLmRyrFVLd4xJL08_im-o
Message-ID: <CA+H9utxui0X9K_b8j5qE5=6DUpApaYZXmj2mWdpsy=BCeQfowg@mail.gmail.com>
Subject: =?UTF-8?Q?VisionFive_2_=E2=80=94_SD_card_=28mmc1=29_fails_=22voltage_selec?=
 =?UTF-8?Q?t=22_=2F_=22Error_reading_cluster=22_in_U=2DBoot_v2026=2E07?=
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sat, 11 Jul 2026 15:24:10 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Board: StarFive VisionFive 2, revision v1.3B, 8GiB RAM variant
Boot mode: SPI NOR U-Boot (recommended/supported mode, not the deprecated
BootROM direct-boot)

U-Boot version: v2026.07 final release, self-built on-board (native RISC-V
build) from the official u-boot-2026.07.tar.bz2 tarball + OpenSBI v1.7,
built Jul 10 2026 with gcc 15.3.0 / GNU ld 2.46.50.20260617

Issue:
SD card (mmc1) fails to initialize in U-Boot. Full serial output:

Card did not respond to voltage select! : -110
** Booting bootflow '<NULL>' with efi_mgr
Loading Boot0000 'usb 0' failed
Error reading cluster
Loading Boot0001 'mmc 1' failed
EFI boot manager: Cannot load any image
Boot failed (err=3D-14)
Card did not respond to voltage select! : -110
Card did not respond to voltage select! : -110
Card did not respond to voltage select! : -110
Card did not respond to voltage select! : -110

Isolation steps taken:
- Reproduced identically on two different SD cards: a Samsung Pro Plus
128GB (UHS-I) and an Apacer 16GB R85 (SDHC, non-UHS)
- Confirmed the cards, SD slot, and filesystem contents are all healthy:
booted the Debian installer's Linux environment from USB, and it detects
and cleanly mounts the same SD card's partitions (mmcblk1, mmcblk1p1-3),
with valid EFI files present at correct sizes (BOOTRISCV64.EFI and
grubriscv64.efi, ~156KB each)
- Running `mmc info` directly at the U-Boot prompt fails outright with the
same -110 error, before any filesystem access is attempted
- Installing the same Debian image to a USB mass storage drive instead of
SD works perfectly =E2=80=94 boots and installs with no issues, confirming =
the
failure is isolated specifically to the MMC/SD driver path
- Also reproduced on a v2026.07-rc4 build with an identical failure, so
this is not limited to a release candidate =E2=80=94 it persists in the fin=
al
v2026.07 release
- Have not tested eMMC (don't have a card on hand)

Expected behavior:
SD card should initialize and boot normally. Booting via SPI-loaded U-Boot
reading SD/eMMC as normal storage is the standard supported path on this
board =E2=80=94 only direct BootROM SD/eMMC boot (bypassing SPI U-Boot enti=
rely) is
documented as deprecated, which is not what's being used here.

Happy to provide more logs, test patches, or do further research if useful.

Thanks,
M.H.
