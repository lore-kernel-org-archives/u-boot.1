Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB18C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3068B81C84;
	Tue, 25 Mar 2025 15:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=rums.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=rums.se header.i=@rums.se header.b="LdLxGSxs";
	dkim=permerror (0-bit key) header.d=rums.se header.i=@rums.se header.b="Q23P1hIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58B2180F70; Tue, 25 Mar 2025 09:00:08 +0100 (CET)
Received: from mailrelay4-2.pub.mailoutpod3-cph3.one.com
 (mailrelay4-2.pub.mailoutpod3-cph3.one.com [IPv6:2a02:2350:5:429::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF416808B6
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 09:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=rums.se
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=onilsson@rums.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742889604;
 x=1743494404; d=rums.se; s=rsa2;
 h=content-type:subject:reply-to:from:to:message-id:mime-version:date:from;
 bh=PD3uyIdXaR2w3hhopKjkFbr2jJ6nzMgvDKiXbg31f4Y=;
 b=LdLxGSxsZrozjOTzt/nPi9LeWMWAl037s1FCl+zvPON5kFD/CIRmVLdmZKtASEnR8j16FnYkI04uz
 2VrDCxv/7wYXLQjt5x8cbXdF2uTn8csGywuv58Ksio0HNPVfJQfbrzDHxk6Uu16KaobcE1U8iUoZjv
 aXQd3GFXWgxTqqglUKnHQsGPGvoFHcOzxF+kOKgbsqflJJFGhsRjwnm0rG+9mXjJtDkddLWlDVNJ6W
 KwAlGwtdPXossGnub7MCkG6G5SCbzfVAfs7YbWTVq8vw7mWZp/8Y6z3Z+SF318YFetY+M1CsbCbDat
 Z6Urjx7NsE2WcvliByAT4pqFTvVJIcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742889604;
 x=1743494404; d=rums.se; s=ed2;
 h=content-type:subject:reply-to:from:to:message-id:mime-version:date:from;
 bh=PD3uyIdXaR2w3hhopKjkFbr2jJ6nzMgvDKiXbg31f4Y=;
 b=Q23P1hICtfBG8jsM/0l0TO2yOaa3YU8KBEpRlZ5YA4Irm4AGRZNU3+lxPbY1rSVbxSyByDvmDz+qy
 7sqsdkWAQ==
X-HalOne-ID: 282484ad-094f-11f0-86f8-29b2d794c87d
Received: from onecom-webmail-backend-production-5f8dbfcff-wctzm
 (service.pub.live1-k8s-cph3.one.com [46.30.212.67])
 by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
 id 282484ad-094f-11f0-86f8-29b2d794c87d;
 Tue, 25 Mar 2025 08:00:04 +0000 (UTC)
X-Originating-IP: 85.226.134.249
User-Agent: One.com webmail 47.0.61
Date: Tue, 25 Mar 2025 09:00:03 +0100
MIME-Version: 1.0
Message-ID: <1742889603533.7.1744@webmail-backend-production-5f8dbfcff-mztks>
To: <u-boot@lists.denx.de>
From: "Oskar Nilsson" <onilsson@rums.se>
Subject: block devices on MTD and UBI
X-Mailman-Approved-At: Tue, 25 Mar 2025 15:56:16 +0100
Content-Type: text/plain; charset=UTF-8
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
Reply-To: onilsson@rums.se
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

>On 20-03-2025 17:03, Mike Looijmans wrote:
>> On 19-03-2025 15:06, Heiko Schocher wrote:
>>> Hello Mike,
>>>
>>> On 18.03.25 10:04, Mike Looijmans wrote:
>>>> I think I have everything set up to access MTD (and UBI) devices as
>>>> "block", however, lsblk always ignores them, and refuses to list
>>>> anything but the mmc. I can read ubifs and boot from it though, and
>>>> since UBI runs on top of MTD block devices, MTD block device should
>>>> be working, right?
>>>
>>> Yes. I must admit, I have no device on which I have such a setup...
>>>
>>> added Alexey (who introduced ubi block support), may he can give some
>>> hints.
>>>
>>>> I also have UBI_BLOCK enabled, so I would expect UBI volumes to
>>>> appear in the "lsblk" as well.
>>>
>>> good, that would have been my first question, if you have enabled
>>> "UBI_BLOCK"
>>>
>>>> Example U-boot session:
>>>>
>>>> Zynq> mtd list
>>>> SF: Detected n25q256ax1 with page size 256 Bytes, erase size 64 KiB,
>>>> total 32 MiB
>>>> List of MTD devices:
>>>> * nor0
>>>> - device: flash at 0
>>>> - parent: spi at e000d000
>>>> - driver: jedec_spi_nor
>>>> - path: /axi/spi at e000d000/flash at 0
>>>> - type: NOR flash
>>>> - block size: 0x10000 bytes
>>>> - min I/O: 0x1 bytes
>>>> - 0x000000000000-0x000002000000 : "nor0"
>>>> - 0x000000000000-0x000000100000 : "qspi-boot-bin"
>>>> - 0x000000100000-0x000002000000 : "qspi-rootfs"
>>>
>>> Aha, SPI NOR. I fear this is not supported yet.
>>>
>>> Do you have somehow called ubi_part() ?
>>>
>>> Can you try "ubi part...." and look if this helps?
>>
>> See below I guess...
>>
>>> It seems to me, that you have to implement this like it is done for
>>> spi nand:
>>>
>>> drivers/mtd/nand/spi/core.c
>>> 1180 static int spinand_bind(struct udevice *dev)
>>> 1181 {
>>> 1182 if (blk_enabled()) {
>>> 1183 struct spinand_plat *plat =3D dev_get_plat(dev);
>>> 1184 int ret;
>>> 1185
>>> 1186 if (CONFIG_IS_ENABLED(MTD_BLOCK)) {
>>> 1187 ret =3D mtd_bind(dev, &plat->mtd);
>>> 1188 if (ret)
>>> 1189 return ret;
>>> 1190 }
>>> 1191
>>> 1192 if (CONFIG_IS_ENABLED(UBI_BLOCK))
>>> 1193 return ubi_bind(dev);
>>> 1194 }
>>> 1195
>>> 1196 return 0;
>>> 1197 }
>>>
>> I guess that shouldn't be to hard to implement... I'll send a patch if
>> that fixes the MTD missing...
>
>Not as simple as one would think. The spi flash struct has its own "mtd"
>member which isn't a pointer but was already filled in. So I cannot
>simply call mtd_bind().
>
>I tried calling ubi_bind anyway, which had some effect:
>
>Zynq> lsblk
>Block Driver Devices
>-----------------------------
>efi_blk : <none>
>mmc_blk : mmc 0
>mtd_blk : <none>
>ubi_blk : mtd 0
>usb_storage_blk : <none>
>
>But that didn't get me any further. I'm quite puzzled by UBI block
>support...
>

I have been looking at the same issue, but haven't made much progress eithe=
r.

From my understanding, when enabling UBI_BLOCK the .bind function will add =
a
block device on top of the UBI device. It should then be usable by commands=

that expect a blk device like sqfsls.

Note that I'm on u-boot-imx 2024.04 and have back ported the ubi and mtd bl=
ock
patches, so there may be differences to latest.

Looking at the driver model, a .blk has been added:
=3D> dm tree
Class Index Probed Driver Name
-----------------------------------------------------------
root 0 [ + ] root_driver root_driver
thermal 0 [ ] imx_thermal |-- imx_thermal
simple_bus 0 [ + ] simple_bus |-- soc
mtd 0 [ + ] mxs-nand-dt | |-- nand-controller@1806000
blk 0 [ ] ubi_blk | | `-- <nand-controller@1806000.blk>
...

Calling sqfsls, seems to find the right volume (rootfs0):
=3D> sqfsls mtd 0 /
FS: Setting up block device: ifname=3D'mtd', dev_part_str=3D'0', fstype=3D6=

Read 512 bytes from volume rootfs0 to 9ef2cb80
Disk <nand-controller@1806000.blk> not ready
** Bad device specification mtd 0 **
Couldn't find partition mtd 0
FS: Failed to get partition info (err=3D-19)

Interestingly after each command that uses a blk device, I get 128 blk_part=
itions
=3D> dm tree
Class Index Probed Driver Name
-----------------------------------------------------------
root 0 [ + ] root_driver root_driver
thermal 0 [ ] imx_thermal |-- imx_thermal
simple_bus 0 [ + ] simple_bus |-- soc
mtd 0 [ + ] mxs-nand-dt | |-- nand-controller@1806000
blk 0 [ ] ubi_blk | | `-- <nand-controller@1806000.blk>
partition 0 [ ] blk_partition | | |-- <nand-controller@1806000.blk>:1
partition 1 [ ] blk_partition | | |-- <nand-controller@1806000.blk>:2
partition 2 [ ] blk_partition | | |-- <nand-controller@1806000.blk>:3
partition 3 [ ] blk_partition | | |-- <nand-controller@1806000.blk>:4
partition 4 [ ] blk_partition | | |-- <nand-controller@1806000.blk>:5
...

At first I also got the error "UBIFS not mounted, use ubifsmount to mount v=
olume first!"
To fix that I added this small patch:

diff --git a/disk/part.c b/disk/part.c
index 8982ef3bae..f168311e9a 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -524,7 +524,7 @@ int blk_get_device_part_str(const char *ifname, const c=
har *dev_part_str,
}
#endif

-#if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_SPL_BUILD) && !IS_E=
NABLED(CONFIG_UBI_BLOCK)
/*
* Special-case ubi, ubi goes through a mtd, rather than through
* a regular block device.


Reagrds,
Oskar Nilsson


