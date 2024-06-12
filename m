Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76261C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 14:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E788881F;
	Wed, 12 Jun 2024 16:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4269885D0; Wed, 12 Jun 2024 16:59:01 +0200 (CEST)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [83.166.143.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E05887FF
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 16:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vzpb61pjPzGq4;
 Wed, 12 Jun 2024 16:58:58 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vzpb564TrzBc3; Wed, 12 Jun 2024 16:58:57 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Jun 2024 16:58:48 +0200
Subject: [PATCH 3/4] doc: bootstd: fix typos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-bootflow-efi-crash-v1-3-27b71b0ff08a@cherry.de>
References: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
In-Reply-To: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This fixes a few syntactic issues as well as typos and grammar.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/bootstd.rst | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
index a07a72581e7..34631089ae0 100644
--- a/doc/develop/bootstd.rst
+++ b/doc/develop/bootstd.rst
@@ -39,7 +39,7 @@ Bootflow
 
 A bootflow is a file that describes how to boot a distro. Conceptually there can
 be different formats for that file but at present U-Boot only supports the
-BootLoaderSpec_ format. which looks something like this::
+BootLoaderSpec_ format which looks something like this::
 
    menu autoboot Welcome to Fedora-Workstation-armhfp-31-1.9. Automatic boot in # second{,s}. Press a key for options.
    menu title Fedora-Workstation-armhfp-31-1.9 Boot Options.
@@ -52,7 +52,7 @@ BootLoaderSpec_ format. which looks something like this::
        initrd /initramfs-5.3.7-301.fc31.armv7hl.img
 
 As you can see it specifies a kernel, a ramdisk (initrd) and a directory from
-which to load devicetree files. The details are described in distro_bootcmd_.
+which to load Device Tree files. The details are described in distro_bootcmd_.
 
 The bootflow is provided by the distro. It is not part of U-Boot. U-Boot's job
 is simply to interpret the file and carry out the instructions. This allows
@@ -85,7 +85,7 @@ Bootmeth
 --------
 
 Once the list of filesystems is provided, how does U-Boot find the bootflow
-files in these filesystems. That is the job of bootmeth. Each boot method has
+files in these filesystems? That is the job of bootmeth. Each boot method has
 its own way of doing this.
 
 For example, the distro bootmeth simply looks through the provided filesystem
@@ -106,7 +106,7 @@ they scan a lot of devices.
 Boot process
 ------------
 
-U-Boot tries to use the 'lazy init' approach whereever possible and distro boot
+U-Boot tries to use the 'lazy init' approach wherever possible and distro boot
 is no exception. The algorithm is::
 
    while (get next bootdev)
@@ -174,13 +174,13 @@ the same way as setting this variable.
 Bootdev uclass
 --------------
 
-The bootdev uclass provides an simple API call to obtain a bootflows from a
+The bootdev uclass provides a simple API call to obtain a bootflow from a
 device::
 
    int bootdev_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
                             struct bootflow *bflow);
 
-This takes a iterator which indicates the bootdev, partition and bootmeth to
+This takes an iterator which indicates the bootdev, partition and bootmeth to
 use. It returns a bootflow. This is the core of the bootdev implementation. The
 bootdev drivers that implement this differ depending on the media they are
 reading from, but each is responsible for returning a valid bootflow if
@@ -188,7 +188,7 @@ available.
 
 A helper called `bootdev_find_in_blk()` makes it fairly easy to implement this
 function for each media device uclass, in a few lines of code. For many types
-ot bootdevs, the `get_bootflow` member can be NULL, indicating that the default
+of bootdevs, the `get_bootflow` member can be NULL, indicating that the default
 handler is used. This is called `default_get_bootflow()` and it only works with
 block devices.
 
@@ -196,7 +196,7 @@ block devices.
 Bootdev drivers
 ---------------
 
-A bootdev driver is typically fairly simple. Here is one for mmc::
+A bootdev driver is typically fairly simple. Here is one for MMC::
 
     static int mmc_bootdev_bind(struct udevice *dev)
     {
@@ -328,7 +328,7 @@ or::
 
 
 Here, `eth_bootdev` is the name of the Ethernet bootdev driver and `dev`
-is the ethernet device. This function is safe to call even if standard boot is
+is the Ethernet device. This function is safe to call even if standard boot is
 not enabled, since it does nothing in that case. It can be added to all uclasses
 which implement suitable media.
 
@@ -340,7 +340,7 @@ Standard boot requires a single instance of the bootstd device to make things
 work. This includes global information about the state of standard boot. See
 `struct bootstd_priv` for this structure, accessed with `bootstd_get_priv()`.
 
-Within the devicetree, if you add bootmeth devices, they should be children of
+Within the Device Tree, if you add bootmeth devices, they should be children of
 the bootstd device. See `arch/sandbox/dts/test.dts` for an example of this.
 
 
@@ -349,12 +349,12 @@ the bootstd device. See `arch/sandbox/dts/test.dts` for an example of this.
 Automatic devices
 -----------------
 
-It is possible to define all the required devices in the devicetree manually,
+It is possible to define all the required devices in the Device Tree manually,
 but it is not necessary. The bootstd uclass includes a `dm_scan_other()`
 function which creates the bootstd device if not found. If no bootmeth devices
 are found at all, it creates one for each available bootmeth driver.
 
-If your devicetree has any bootmeth device it must have all of them that you
+If your Device Tree has any bootmeth device it must have all of them that you
 want to use, since no bootmeth devices will be created automatically in that
 case.
 
@@ -363,8 +363,8 @@ Using devicetree
 ----------------
 
 If a bootdev is complicated or needs configuration information, it can be
-added to the devicetree as a child of the media device. For example, imagine a
-bootdev which reads a bootflow from SPI flash. The devicetree fragment might
+added to the Device Tree as a child of the media device. For example, imagine a
+bootdev which reads a bootflow from SPI flash. The Device Tree fragment might
 look like this::
 
     spi@0 {
@@ -398,7 +398,7 @@ Standard boot is enabled with `CONFIG_BOOTSTD`. Each bootmeth has its own CONFIG
 option also. For example, `CONFIG_BOOTMETH_EXTLINUX` enables support for
 booting from a disk using an `extlinux.conf` file.
 
-To enable all feature sof standard boot, use `CONFIG_BOOTSTD_FULL`. This
+To enable all features of standard boot, use `CONFIG_BOOTSTD_FULL`. This
 includes the full set of commands, more error messages when things go wrong and
 bootmeth ordering with the bootmeths environment variable.
 
@@ -492,9 +492,9 @@ Theory of operation
 This describes how standard boot progresses through to booting an operating
 system.
 
-To start. all the necessary devices must be bound, including bootstd, which
+To start, all the necessary devices must be bound, including bootstd, which
 provides the top-level `struct bootstd_priv` containing optional configuration
-information. The bootstd device is also holds the various lists used while
+information. The bootstd device also holds the various lists used while
 scanning. This step is normally handled automatically by driver model, as
 described in `Automatic Devices`_.
 
@@ -504,7 +504,7 @@ those bootdevs. So, all up, we need a single bootstd device, one or more bootdev
 devices and one or more bootmeth devices.
 
 Once these are ready, typically a `bootflow scan` command is issued. This kicks
-of the iteration process, which involves hunting for bootdevs and looking
+off the iteration process, which involves hunting for bootdevs and looking
 through the bootdevs and their partitions one by one to find bootflows.
 
 Iteration is kicked off using `bootflow_scan_first()`.
@@ -526,7 +526,7 @@ Then the iterator is set up to according to the parameters given:
 
   - If `label` indicates a numeric bootdev number (e.g. "2") then
     `BOOTFLOW_METHF_SINGLE_DEV` is set. In this case, moving to the next bootdev
-    simple stops, since there is only one. No hunters are used.
+    simply stops, since there is only one. No hunters are used.
   - If `label` indicates a particular media device (e.g. "mmc1") then
     `BOOTFLOWIF_SINGLE_MEDIA` is set. In this case, moving to the next bootdev
     processes just the children of the media device. Hunters are used, in this
@@ -554,7 +554,7 @@ bootdev and disturb the original ordering.
 
 Next, the ordering of bootmeths is determined, by `bootmeth_setup_iter_order()`.
 By default the ordering is again by sequence number, i.e. the `/aliases` node,
-or failing that the order in the devicetree. But the `bootmeth order` command
+or failing that the order in the Device Tree. But the `bootmeth order` command
 or `bootmeths` environment variable can be used to set up an ordering. If that
 has been done, the ordering is in `struct bootstd_priv`, so that ordering is
 simply copied into the iterator. Either way, the `method_order` array it set up,
@@ -652,12 +652,12 @@ valid bootflow is found early on. With `bootflow scan -b`, that causes the
 bootflow to be immediately booted. Assuming it is successful, the iteration never
 completes.
 
-Also note that the iterator hold the **current** combination being considered.
+Also note that the iterator holds the **current** combination being considered.
 So when `iter_incr()` is called, it increments to the next one and returns it,
 the new **current** combination.
 
 Note also the `err` field in `struct bootflow_iter`. This is normally 0 and has
-thus has no effect on `iter_inc()`. But if it is non-zero, signalling an error,
+thus no effect on `iter_inc()`. But if it is non-zero, signalling an error,
 it indicates to the iterator what it should do when called. It can force moving
 to the next partition, or bootdev, for example. The special values
 `BF_NO_MORE_PARTS` and `BF_NO_MORE_DEVICES` handle this. When `iter_incr` sees
@@ -675,7 +675,7 @@ So what happens inside of `bootflow_check()`? It simply calls the uclass
 method `bootdev_get_bootflow()` to ask the bootdev to return a bootflow. It
 passes the iterator to the bootdev method, so that function knows what we are
 talking about. At first, the bootflow is set up in the state `BOOTFLOWST_BASE`,
-with just the `method` and `dev` intiialised. But the bootdev may fill in more,
+with just the `method` and `dev` initialised. But the bootdev may fill in more,
 e.g. updating the state, depending on what it finds. For global bootmeths the
 `bootmeth_get_bootflow()` function is called instead of
 `bootdev_get_bootflow()`.
@@ -733,12 +733,12 @@ bootflow is handled by the bootmeth driver for that bootflow. In the case of
 extlinux boot, this parses and processes the `extlinux.conf` file that was read.
 See `extlinux_boot()` for how that works. The processing may involve reading
 additional files, which is handled by the `read_file()` method, which is
-`extlinux_read_file()` in this case. All bootmethds should support reading
+`extlinux_read_file()` in this case. All bootmeths should support reading
 files, since the bootflow is typically only the basic instructions and does not
 include the operating system itself, ramdisk, device tree, etc.
 
 The vast majority of the bootstd code is concerned with iterating through
-partitions on bootdevs and using bootmethds to find bootflows.
+partitions on bootdevs and using bootmeths to find bootflows.
 
 How about bootdevs which are not block devices? They are handled by the same
 methods as above, but with a different implementation. For example, the bootmeth

-- 
2.45.2

