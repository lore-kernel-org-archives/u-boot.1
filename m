Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0051CC43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 16:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E6B3846F4;
	Thu,  2 Jul 2026 18:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X4zEi3vO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A41D846FD; Thu,  2 Jul 2026 18:43:10 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E229084671
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 18:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pbiel7@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-37dedd62b90so987491a91.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 09:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783010586; cv=none;
 d=google.com; s=arc-20260327;
 b=AVAdjKFIC/IN54sWqHkYgEzQ/KQiMZDo1fg19nQJDbpfaj9IV7xXovnTdKzm6FP4uK
 cwfiOUKykIiZ2g4IuboiHGy6AVustTjd4FAvK8eXZ7pqR7Xu8/v7oXmJzk6uDeaSAqgy
 o1GpctR4JF5LfyCBGKj56nu4LsV2RIqA6c+7qK6HRv53Q74BCpTJi0aOwvASVbmDnOIp
 e8e84t4QzKDtzjsEKqH15G/dsFT3avxz6P2TNjf4g2HsVwIq5KkG648yg78j74bdvp+7
 bbQ5vL47Za5IBwNRiJPWuSIHZ/LkER743fPaZe7L3JSyhg2DPegbkYwRCkiN027gDD2/
 w52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=M+lllCimOILrr2Hz9VVM5+Gk00aVxAX6iFRgXnZGTQM=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=HToWXmkB3qQfVJrCCcuT7czXlQl68uGEKTwnY5H6sFYyoM3hjD0ZKSr+sPb6DDJ9Sf
 kELsPeoovor5g2mGKN4AhwCrT1Pcb3z9tU2HrzOsFMyawPoLv/reml+IKM0f/nTk8xtV
 ZJivZXS5u5tZ/O0mzp3YgW8j1rbjR36p0yIZg7S+GT1EE3uSyuLo8xP0JbZulWC3u/pv
 Y0Xc0KpYRvK1/evzB7dtE/ZNOWYvS3Dm2IwPI0Zjd9H3MeUuWAagNPpDgn3NQbkz6wnc
 9PX2G6bvR0gRqVWvEhAR8boH+m5FXKklevjtXFkBitl6RkMLEKUn1+2CXts3yaRyMY7F
 +RBQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010586; x=1783615386; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=M+lllCimOILrr2Hz9VVM5+Gk00aVxAX6iFRgXnZGTQM=;
 b=X4zEi3vOGTTmkf9PB9PpTFYPhBzADBVNloBUZt7sspmH+Ueb8sf+25b4gOmkjH98Dc
 L8xt/G0X5+q9OeRLACNCDJzC3pkRk3aYtCptjRgSGuL9Opv6GWpFiifEGXJToB6+lgHu
 m9kS+qsC4T0tPtR/opu8wqG63QH43ISxhFjjdkWB6AhskOBE80UTtHApPCsQFIp1ft/W
 5R3aVNlUrT/Vc+WI6gEyUcC5TdwSGVgP9EGv7H27pnugd/JEeOoXXmascngnUYgqqMCX
 EZhpWyZ1dhbA6ZCwKi3UQnRwWinMLJDZbk3NBsU+i5f+QGleObe+8F2V6aizZF7bplwC
 qbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010586; x=1783615386;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M+lllCimOILrr2Hz9VVM5+Gk00aVxAX6iFRgXnZGTQM=;
 b=JkyrDUY0T8ex0O0n9Fl8Hbpe66mvso3O4+l2my1kVDxSMw+vpigd44XcZfj4h/GqFv
 PtDUCGukrcmEERQ0jiPiuLinNcjgbONj4fIk4/FwMPC/9go4QPKedcSs0fde+p+YZcC8
 UsnNXaQ1Ythh23JKXjRgCct2yRfQGiJam1odrtokCelTQ+RK1qwNdGN5P4Vq/OJ0ydig
 h5gyCgItxjO5wTndA2F6/zVdftSlYL6UdjzGoz9VJIwbNhqOQLj53H/gTUzuZXea+miI
 KXtBTQ480+RO35t0+vTSCxGCbOklpDvX1u8F5UATm5B56ZlXRaiMTGPjRIEsM35t5f3j
 150w==
X-Gm-Message-State: AOJu0Yx+i+vWWv8ioByb1gfL8F+o8dYHuSP4wDVbV4pJv37qvzQBLqPA
 mtY+JJf9B9yGhAy2/iXu2fMx9RmXQ1RJiM9S+P17WMhjvqB4gVPyfuOv+8TQ3Y2NCZbf3qQi+Mi
 H1TKsStUBvuYjcCGWrP5RtISPvoMrn5msjaSYDRc=
X-Gm-Gg: AfdE7cmMWllZCvYdIj12oz2+0q8jbzvyCmqvkG29ihYxbw1Pzzkw9d6IfC1WPNMHIRd
 NHOrofiAqVMzZ4PBYOsJvKUmtoCi6+5Zmg8iGWHqASX3xl0HYUCjFMIucQKQZcOZwjwkng/ZWgI
 FRCuz39BPM2bibIWtwg/YfCg/NpcW9DtQR8LXnEWH0/ACRozFD6vaI8XlOXeuO94d4BAfPrSIec
 EaD6nPePFgGU6FNx+d6u6eLKXYVyy+6u4YXUIBE+uZHdkv98xo6oJ2LkFVsh3HEbGrdKFKCLA96
 8DZNa9HofZaNKflm76D4aZVUhC1X4WnY3uOIv8EZuSOnDy38wPBm9fuQgGMbrkQai6T3GpjNmLT
 usVl5oBvC4HWr
X-Received: by 2002:a17:90a:e70c:b0:380:ce69:2669 with SMTP id
 98e67ed59e1d1-381122ebda9mr642117a91.9.1783010586154; Thu, 02 Jul 2026
 09:43:06 -0700 (PDT)
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Thu, 2 Jul 2026 18:42:52 +0200
X-Gm-Features: AVVi8CeCJAUwYCiOr5EozszIopgw5joZ5f1_IvdXqMjDZlCx-bVn7ZT58OIN9SI
Message-ID: <CA+DkFDb-nAaiECtYX-QcX4-iW6hQPxRtYt_EeKOhDzznqR2ofQ@mail.gmail.com>
Subject: DRA821 Firmware Update: A/B boot and dynamic SPL payload selection
To: u-boot@lists.denx.de
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

Hi
I've been exploring the possibility of firmware update on the DRA821
platform and have a few questions regarding the solution that came to
my mind.
I target both SD and eMMC storage but SD is rather for development
purposes although extensively used so it should work as similar as
possible to prod solution. I need to update as much as possible with
possible rollback in case of boot failures.

For those not familiar with this SoC the boot flow is roughly (let's
skip details) something like this:
- bootROM loads tiboot3 (that contains spl) on R5 core
- spl loads tispl.bin (that contains BL31, BL32, A72 SPL) on A72 core
- A72 SPL loads u-boot.img with u-boot proper
- u-boot proper loads kernel

So my initial idea is to
- store tiboot3.bin on boot0/boot1 eMMC boot hw partition
- store tispl.bin, uboot.img, fitImage (with kernel) on boot-a /
boot-b UDA partitions
- put all the logic of slot selection in R5 SPL

So R5 SPL once loaded by bootROM, would use some sort of metadata
(let's assume some env variables for now, btw any better idea?), to
decide what slot to boot, then based on this information would load
tispl.bin. In the next phase A72 SPL would basically do the same for
the u-boot.img, and finally u-boot proper would load appropriate
fitImage. In general the selected slot index would be propagated to
each stage so each stage knows what slot to boot.

R5 SPL would also handle possible rollback by using some sort of boot
counter (e.g. stored in backup registers of SoC).

tiboot3.bin would also be updatable but I would update it only for
some special reasons - in this case I would just switch boot0 ->
boot1, or boot1 -> boot0. This case would require special care because
if an update failed, there would be no automatic rollback and users
would be forced to use backup boot mode.

In theory and from my perspective it looks good, however I've stumbled
upon some problems.
First - there is no possibility to use a board specific function to
select the boot partition. Currently SPL iterates over a list of
partitions and selects first bootable - more about this in
spl_mmc.c/spl_mmc_do_fs_boot() - would it be sensible to add here a
board specific weak function that would select the appropriate
partition to boot? If so - would it be welcome also in the mainline or
rather not?  CONFIG_SYS_MMCSD_FS_BOOT_PARTITION is obviously not the
case because the partition has to be selected dynamically.

Second - some SoCs do not support GPT partitioning schemes, and when
more partitions are required for various reasons there is no simple
way to provide separate partitions for boot slots (e.g. boot-a,
boot-b, root-a, root-b, data). In this case one could potentially use
single boot partition and use e.g. boot/tispl-a.bin / tispl-b.bin for
"slot" selection, but this is the same story as in case of partition
selection - the name of payload is hardcoded in config - would it make
sense to also support dynamic payload selection?

I would be grateful for any suggestion, especially if the solution I
outlined above does not completely make sense.
Just for the record - I come from another SoC where the first external
bootloader was implemented in TF-A (BL2) which has a well-defined boot
slot selection through PSA firmware update - that's why I try to
figure out something similar on DRA821 SoC.

Best regards.
Patryk
