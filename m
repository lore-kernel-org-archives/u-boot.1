Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4C0C79F9E
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 17:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 164EF605D9;
	Sun,  6 Sep 2026 17:53:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXcyu4WWbXFY; Sun,  6 Sep 2026 17:53:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4EE5C605F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788717182;
	b=gzuMcvvYvW/NTG6jxUX3KPhZY2ZwPAWBUAauSgbZdEymJQnGu/U1B6m4D/9P2Fb/JwnZ
	 BxqNiuZdOJNv24UYYGjqVQFwbLEklg0n4DdrtWn1lqcvveMO3EqPLFDDBl2KLFeP290f3
	 HjGaTC/6tdAAtNWEFLL7ejU2Ml7uYEQSK/nUgItO5TVyUSmzrNc6ulPGt7db8v+JGXjqZ
	 qaYgI4T15Pk4vmZvGrKK5pHJQkcD7kozygXBXRU+aV6fLYGjEZEaUEtk9GvTX20TOto7r
	 rxZH+28V2nWyB+4T6+AXkCUtg6ctnxvBQO4NfdFXdCQjo43N9TdYse3xMfY1M6rfcfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788717182;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Subject:
	 User-Agent:Content-Type:MIME-Version:X-Virus-Scanned:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YcaGNRllmeiSg7F8sraRM3JbtncfgifoHifNFixE/zs=;
	b=imdXlGAT6ElAK560IUrbbiE10UQptHoFdErA4eYc/AZc2Ync5NlrtmgDupQ+ID5o/uU2
	 G20j8SX54HsKlKHB5b98wceEz9HvhW/Ca/s0W2k1yvcLciZ+eR/Of6OpeaC9JAvp04vDC
	 h+sLjPkKaYfMTS6zIz0kXdVGJPG+1uhEd+pjU0TEg0HKGpZnY+wRXxdzWH91VjzP9oXyM
	 eRE6FHOykp2P2TzKaU1TWgFCfrfDGeXYM+3ZpDutQ6l/c8EUfirS2wv2e+vlLQLMk9L3/
	 fF0+pKgtmO7Zch3zRjD5JJ9Gt5vHyiiom3gIVbGbKGuEALYuQwkiTd/8jnqxwnGinGQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788717182;
	bh=YcaGNRllmeiSg7F8sraRM3JbtncfgifoHifNFixE/zs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i7M20fN4vOZPbKUaOPKU5z/w+XkkjNbGX5JGZ4SMh1w3u1gheYrQXHCack13FiMQi
	 A+JuKvuZagTUcnSm6wXk0q6JEtOWc5DgcIxPBIlmjhhrviwgbGfWMCB8KcRvPtMu1h
	 ZNJenCl2xYUIxskczbOlG3JMLJ1LydoN+8xpxr+ApNmVaxUVoJJj3Q/01u7FctoEUA
	 33FFasuoyAOSuaH+WkBAgIvohl6ki2rutkegojzy40IEx3ihVr+3yGVueHvSKSAXic
	 HFWWYFyBiBoV3Ls1iucOLNFjjvuk1ofv/pe93HEID7mv1E3ePryXHzeAHQBBH73wcx
	 9DHR1hT/ULJ7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EE5C605F0;
	Sun,  6 Sep 2026 17:53:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 67D1572C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 16:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA6CE80BB2
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 16:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-DDPMXhDD4v for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 16:49:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9E78E80BAD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=167.235.121.166
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788713358;
 b=NTegyory+OuXK1nRWgL37lr0rlvFjRgtr/99cK7UmwgT1IRAFj1OtBKXdAUd6Kz8IPn4
 lkgC1UFwFMLYielA8aU2W7KRdy73WonN3KmEVnDuK7nfhMgaKADTPmjxQTL3oZGt4Ok/r
 4lDlqelv4qGPjteIoZQ4zjsP39VGdEmWrEZpKFZgn1c0pfwCfWdxlZQd4IiTqknjjM3Dl
 hcqrit2heON27tHphUm1xj+FbwRkZ3veClun8XPrXtQxbQQ0CWZzh0WquKimQ8LILZ3hL
 9c32FJGaO0ct3tPGIw+FnpFmHiIE2TMppW8Uc3UG5i2V877E2rFLh1otvqM6eDwKvhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788713358;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:Received:Date:
 Message-ID:From:To:Subject:User-Agent:Content-Type:MIME-Version:
 X-Virus-Scanned;
 bh=YcaGNRllmeiSg7F8sraRM3JbtncfgifoHifNFixE/zs=;
 b=KcWVD9mi51kAb2p3U/BenF79hDLSrgTquoBdGSrYREgZtetNc2zTsuwNUTTNWYJ55jpi
 uxdw+hXzD+/rVhZg7UmP3+b7FMoZmQZf12CyPzLFrkAg8ywBw23cQmDGC7Ckj2/7qU7xT
 Z2GVf5Ev9FAlaWFbB01mqjP8ynURERXduQ1zqPQ+rSclbCV6Kj3SUo7O8glWBw6mNPZCl
 chxF/sphmYjQogAj9n/2VKjp/ui90whMzVHF7oB9aKBT1o8ZT5IfB73krbKbv6PwWZzvh
 2JB0eN3ihaQLUMLal1U3DqfDHi17dRpu6/meG/ttNFQyNP4HiXKbiuog3ldSL9xnaDg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=zegrapher.com; 
 dkim=pass header.d=zegrapher.com header.i=@zegrapher.com header.a=rsa-sha256
 header.s=default2607 header.b=awe4K7wd; 
 arc=none smtp.remote-ip=167.235.121.166
X-Greylist: delayed 1401 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 06 Sep 2026 16:49:17 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zegrapher.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=zegrapher.com header.i=@zegrapher.com
 header.a=rsa-sha256 header.s=default2607 header.b=awe4K7wd
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=167.235.121.166;
 helo=www739.your-server.de; envelope-from=adel.ks@zegrapher.com;
 receiver=<UNKNOWN> 
Received: from www739.your-server.de (www739.your-server.de [167.235.121.166])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E78E80BAD
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=zegrapher.com; s=default2607; h=MIME-Version:Content-Type:Subject:To:From:
 Message-ID:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=YcaGNRllmeiSg7F8sraRM3JbtncfgifoHifNFixE/zs=; b=awe4K7wdk5dBwb5cMLZILqJm+e
 4n9bWfJb8zpa/7b1jZ7MvcLh/78WudV3ntIxbXgUGOA4VcqkTuVAxF2BeiwIZnE+1VvhIF2cjJoBJ
 0FlDCqLLrH20xrx++J8T+DqBTq3JokiwBFSiEmTFUNBLRkqRG/0VUw+zdlsKA0S+xNOk7fRXPj9rg
 NHTCuar2JTmHOjZcGHi2lnFokTnrH5lG522PkNNusQ2Yxx0L3By33eFMy9e076Y5j+wHsf5Z6FdsU
 iQt1/PFK3HWvHnqITUpSzLqUHkm/gj+vuZEISWnQ68OWHXRZvuxtj0aD+XuCyZQ4ZiRPZj1H1wevm
 VJU//Luw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www739.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.5) (envelope-from <adel.ks@zegrapher.com>)
 id 1x3Fgn-000000006JF-01JT for u-boot@lists.u-boot-project.org;
 Sun, 06 Sep 2026 18:25:53 +0200
Received: from [192.168.0.33] (helo=webmail.your-server.de)
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <adel.ks@zegrapher.com>)
 id 1x3Fgm-0001ia-2q for u-boot@lists.u-boot-project.org;
 Sun, 06 Sep 2026 18:25:52 +0200
Date: Sun, 06 Sep 2026 18:25:52 +0200
Message-ID: <20260906182552.Horde.mWSnZmjufjhuBgLpFbVVWrJ@webmail.your-server.de>
From: adel.ks@zegrapher.com
To: u-boot@lists.u-boot-project.org
Subject: rpi: copy few more things from the firmware device tree to make
 rpi-eeprom-update work
User-Agent: Horde Application Framework 5
Content-Type: multipart/mixed; boundary="=_t9rh0dLBXSsTRASkunYttEG"
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28115/Sun Sep  6 08:26:06 2026)
X-Mailman-Approved-At: Sun, 06 Sep 2026 17:53:01 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This message is in MIME format.

--=_t9rh0dLBXSsTRASkunYttEG
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Content-Disposition: inline

Hey,

I have an rpi4 with uboot, archlinuxarm, mainline kernel. And  
rpi-eeprom-update fails with

```
Device does not a have a Raspberry Pi bootloader EEPROM (e.g. Pi 4 or  
Pi 5). Skipping bootloader update.
```

An LLM helped me fix this with a patch in the packaged  
`/boot/boot.txt`, that properly passes through the sysfs entries  
rpi-eeprom-update relies on

```
--- a/boot/boot.txt
+++ b/boot/boot.txt
@@ -7,6 +7,18 @@

  if load ${devtype} ${devnum}:${bootpart} ${kernel_addr_r} /Image; then
    if load ${devtype} ${devnum}:${bootpart} ${fdt_addr_r}  
/dtbs/${fdtfile}; then
+    fdt addr ${fdt_addr_r}
+    fdt resize 8192
+    if fdt addr ${fdtcontroladdr}; then
+      fdt get value fwrev /system linux,revision
+      fdt get value blts /chosen/bootloader build-timestamp
+      fdt addr ${fdt_addr_r}
+      fdt mknode / system
+      fdt set /system linux,revision <${fwrev}>
+      fdt mknode /chosen bootloader
+      fdt set /chosen/bootloader build-timestamp <${blts}>
+    fi
+    fdt addr ${fdt_addr_r}
      if load ${devtype} ${devnum}:${bootpart} ${ramdisk_addr_r}  
/initramfs-linux.img; then
        booti ${kernel_addr_r} ${ramdisk_addr_r}:${filesize} ${fdt_addr_r};
      else
```

And suggested that the fix be upstream, please find attached the very  
small patch with the suggested (untested) changes that may be useful.

Kind regards,

Adel KARA SLIMANE

--=_t9rh0dLBXSsTRASkunYttEG
Content-Type: text/x-diff; name=rpi-fixes.patch
Content-Disposition: attachment; size=2953; filename=rpi-fixes.patch

From 5e79d602b15b80dc4eadc6a4aca32693b90307b0 Mon Sep 17 00:00:00 2001
From: Adel KARA SLIMANE <adel.ks@zegrapher.com>
Date: Sun, 6 Sep 2026 15:50:00 +0200
Subject: [PATCH 1/2] rpi: copy the board revision code from the firmware
 device tree

The firmware writes the board revision to /system/linux,revision, which
userspace reads to identify the board. The node is absent from a device
tree loaded from disk, so create it first.
---
 board/raspberrypi/rpi/rpi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 1da5df92..0c821564 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -598,6 +598,22 @@ int copy_property(void *dst, void *src, char *path, char *property)
 	return fdt_setprop(dst, dst_offset, property, prop, len);
 }
 
+/* Add a subnode to @parent if it is not there already */
+static int ensure_subnode(void *fdt, const char *parent, const char *name)
+{
+	int poff, off;
+
+	poff = fdt_path_offset(fdt, parent);
+	if (poff < 0)
+		return poff;
+
+	off = fdt_subnode_offset(fdt, poff, name);
+	if (off >= 0)
+		return off;
+
+	return fdt_add_subnode(fdt, poff, name);
+}
+
 /* Copy tweaks from the firmware dtb to the loaded dtb */
 void  update_fdt_from_fw(void *fdt, void *fw_fdt)
 {
@@ -608,6 +624,10 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
 	/* The firmware provides a more precise model; so copy that */
 	copy_property(fdt, fw_fdt, "/", "model");
 
+	/* board revision code, read by userspace to identify the board */
+	if (ensure_subnode(fdt, "/", "system") >= 0)
+		copy_property(fdt, fw_fdt, "/system", "linux,revision");
+
 	/* memory reserve as suggested by the firmware */
 	copy_property(fdt, fw_fdt, "/", "memreserve");
 
-- 
2.55.0


From 59edcbf174a6c9b5338445a5bc6e8a94e3ffb044 Mon Sep 17 00:00:00 2001
From: Adel KARA SLIMANE <adel.ks@zegrapher.com>
Date: Sun, 6 Sep 2026 15:50:00 +0200
Subject: [PATCH 2/2] rpi: copy the bootloader build timestamp from the
 firmware device tree

rpi-eeprom-update reads /chosen/bootloader/build-timestamp to find the
running EEPROM version. Without it the tool cannot tell whether an
update is needed.
---
 board/raspberrypi/rpi/rpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 0c821564..c08af8d3 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -644,6 +644,11 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
 	if (copy_property(fdt, fw_fdt, "blconfig", "reg") == 0)
 		copy_property(fdt, fw_fdt, "blconfig", "status");
 
+	/* version of the bootloader EEPROM */
+	if (ensure_subnode(fdt, "/chosen", "bootloader") >= 0)
+		copy_property(fdt, fw_fdt, "/chosen/bootloader",
+			      "build-timestamp");
+
 	/* kernel address randomisation seed as provided by the firmware */
 	copy_property(fdt, fw_fdt, "/chosen", "kaslr-seed");
 
-- 
2.55.0


--=_t9rh0dLBXSsTRASkunYttEG--

