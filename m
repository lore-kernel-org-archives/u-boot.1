Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD5EC98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9DAD41340;
	Wed, 23 Sep 2026 21:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 20Mkt4kmerSX; Wed, 23 Sep 2026 21:31:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DD66241330
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790199061;
	b=stop0HBSfhYmHx+5fW2voV8WKBSypsykQE1Ry8aVvdbrYEHnKQA/niHpqN92fdcHRPl/
	 Xs+yzlaLvEkE/NDDKksWD8effUcLJeaVUsEVWpCijMiKnE0hoqvNEzMsxNBREIQgc8GDg
	 U4ctfyp7WyzAnVM/DtUp9v0kTd+qzu1o5XduCysygUjw7a+cZEdrU3XWJP4dSEj84uhMb
	 U3KGFsFZa4RiTAWepzeCF5kwMl3KJ0prSMA0ELUBjXiwOi9wcptyk/rrvEDx2pN0DiyqK
	 SYPtSJ/B46kuYbL5mCQzL34zCoG0ckC6DNvXsv8lvRon+MHDgb9DThd4cmtlNJTUBcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790199061;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PWiZDs4vslbgxBXVflpODcYoI9o3BsRdpYsGYX9ANdo=;
	b=hMm8ZoLZ38lgGAmqUegiXX8udISLfzi+gIR29HdFdl15ncniEhr0X/k3sFW5pqn/LndO
	 sAVX/A/I/e2FMcTjMmvfEC4rSWPJ4VbeTUhXE2hd+J2Q+UQtDI0v0XyQbIU0G0bcj1VM3
	 oRFBxd9JxSDtd4Z5cTS8de3NXgNUwqogTB+1ePZ9UbsCnATVZgUYZlN/cZg4bFdaZAhT3
	 DAxoHLWr5eT+jAJMG7nexiqNRr+aws7N7YSRBmaxePHIK5Ov7mNEXN/Heqo6gJpiaBBAM
	 WmY7y2zfOajSamAcyNgg0ar4UO31nF0QAo+7B1Q6Py/jLjh5/UhKNyXwctcH2lEPJNQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790199061;
	bh=PWiZDs4vslbgxBXVflpODcYoI9o3BsRdpYsGYX9ANdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v1U7IS+Inp3jZggZqGyBKK2X7nuavgF6N5j84EU6xQx1qFMiOJKMZeXSlUNpnImhj
	 XtyH9dM3MwDRXw1HSyNrwwix0uzWsSX1nUWUjdxfP7a2EJ/MW/zKqDYi5+O8pEjqk7
	 4gQ8GI27+ed6J5cG1KXIUFiqZi/cqIHdkqQnzaBUcooR/YWnOJQ53Qwpnkmv4RdcMh
	 //KbmMhfhuesn/RUlZheJNlQbrHF67UU75jDNgm/KTGtdxIVxar624d9oMR0QvpLls
	 +6fcnCginSZxoMmVsixTHMgFHysONvsNkRj9kRIxfJOhzyNHGYvjfou40v93W+FP4Z
	 T/EZQVuBsdUkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD66241330;
	Wed, 23 Sep 2026 21:31:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 740583A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 588CA60B85
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OV_7903RmkPQ for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:30:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A5DF660B3F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790199057;
 b=dA9+sh5bYjtPrGWPSKPav8X0YTdqi95OZCxO9GaWJYpO3EKYvlBifG02DloHtDXUVmBm
 lTZFeeOdKTpIbd3FF8X5TuFoB0zr77i+vd7NuJhFsyBDQRZkPennhB6ffpwCSh6nPatfX
 04QGwtmUjFBwkKVWLJGDjskaSJv8BtiWnSoq7iw4fjB5oM/IXDNBGvsYJmJZl0hnSgc+e
 2oPDAirlewz6fD0kMQIrEL7KxiaynSHdZ81I/HYDZBvE2FSrcp17n4W2WVa6DMU1osATA
 CIuGKSk/iLYXcHnYbs4uI4aW/FI35tQejf139GKGX+7+k7kQbjC0rYbNrHC+I8OsIKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790199057;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=PWiZDs4vslbgxBXVflpODcYoI9o3BsRdpYsGYX9ANdo=;
 b=Dmh/8p0escuiebuqe5NItcaOFS6zrbuGFIwpvSOg0Sm7llYiMvA/IRNlfRhmfJS3rOkm
 meLiyg38gXBEvdc8RTylms9jfvk025rVd+yarEGr+1zCC8Vybg5Z7SJO9/bpmJz8qXH4o
 TkpbgJpd7E3tD0c23Zr93cZxzvUeWMb0D8wFMUL92g+E3IaUuEZZHz00mPcn2TfGVOho9
 j5uvBfcGCem9XMLQJffTi8av6FbBH0AbWGTrPLfW1Z21JlS1Ra9vWW8UI5qcDR3wBSjDa
 sWooud8qz02qfptAL9VvOrFErrsmoCa2uenjAGqUBzmAA8llMgwYa1NSodyhwcVJC+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qOWiPaZn; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qOWiPaZn
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5DF660B3F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:57 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so1033559a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790199057; x=1790803857;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PWiZDs4vslbgxBXVflpODcYoI9o3BsRdpYsGYX9ANdo=;
 b=qOWiPaZn2Pt2CVajPwJsasPPnnDWFvdn42pMKWhLfmm9gwY3IbkLNKsBcHKcIOOyN4
 dcS8SOpsmo9wcvaZ4zgVKf81tEHeUTNCaj/m/ruNFROaly9giN5Nyo5LKsIPnq51McXJ
 XA3JnSIt0nqf48ShyIoGv12dbJxPdE2V7Wh1iLxvAniXdc3TzVAnQ/VZIm6VgcSrRNUL
 y4wMLhd5zycImgRWBYN6YDJQE3yQo6E0hvUlhDlqcM5KvVBouBZbOoSNtABQxuMaFyvB
 kslTocvB7JDHvmalcGbMMgIV1RavtOY1yfc1AGuoPdEC1k80yRShP1nXsQSMNeVI3uqr
 IQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790199057; x=1790803857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PWiZDs4vslbgxBXVflpODcYoI9o3BsRdpYsGYX9ANdo=;
 b=ihxfeLJH/tx8SZQHVs82HoBFAej/F8UdJrlHzNkvOGHc3faEu6Gn2h9D8mKLGTAltC
 bf137x8fC6hIZg04NXs/2C9eaIaXuT7fZDOU33Pmk5KwSCWoSeYwMeikJTJWXPCAoGvx
 IH+0R2v0l0IZj/amqLdMO9fynFJhiVGr9aWLFKlsTvE+qHCyqE42iVCGwnDleM2DHyj4
 fQ8+vtgNFuECt7rMShLcOgkIBEwbe2W1G4OP74C9PcDhosKX4wa9dfxOLyQG5ciRkCjL
 QvGiRq8U3WR+l7bdYRhBhw81LbGM3lOadiHmmib4tat85MArnNSqx2NwoH49GtHrGbPp
 4CNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXeJ0pFAZzG93KA6Ru+GibPsjJjumk6kXUc111gBcCUFs08hoYd93NGdO7KvhjdmdrT2b08eY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nyYOORzWBS3gYr5ui2cL0z2T3xdD+aHFW2Zgj0DFm11FZSOjvm
 a0GJwdL+vjfCFUuviPkRhWEDSw2LyAoTjozB8fi/lbJSiNPjMRxxpzlr
X-Gm-Gg: AYBFou3ZuXRSvM1wLpgvyoCE89/H/unIDwiygA7RvlzHSM5mc+IkFvTobHaSvN1TqBU
 D2xLvFXLnuMWpk6TFXsjFQB9Dml4BEH0hqs17qYmbDU2P0nC7kuph0ZIljCzytx+YiEejf9X+Ax
 o7SqA/6AS4+Vi/QMRYwsLQ0vZcQLLsfgQ1ru/882MTemd267YISDIfmbr8+nHr22svRUvmE++hR
 FXEjYV4BfxOCXHffZl2qtxMt5QkvfQeIXgia+JZHH4Pwbw4bIaGz8uls5ES1GkiysYxp//P+cU7
 WocqDOk69MAmVqz0nVh3QSLkelBQAZSnEAAN/EJBVOpYhARieJ4Zxm9Edzy+7WGKdRrGZWNCGAz
 lRna1SIhJtMGl7WqnF+U1sxOOP4zghkdznwKVPbu7oRwVgHZaeSY+GR6Zny8kxiiKwjHwvqoEPV
 Be22tszXHrfT7I8jQcXa4cfIpRn016fPD550hVe1vFdvEERf5GRQlxKwkEp6IFtCr7i9CeGvx4w
 Owo73HX0kC9yTA1xMNsgOvFKMSSkSqWlh1/Nw98DRSLPYRkIlQu3bMe1y8ZsA3qqimte3uCFdjI
X-Received: by 2002:a17:90b:4e8f:b0:39e:6c68:1551 with SMTP id
 98e67ed59e1d1-3a09896c4demr359210a91.25.1790199056757; 
 Wed, 23 Sep 2026 14:30:56 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0973c4fb4sm909513a91.17.2026.09.23.14.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:30:56 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 4/6] doc: 9p: Add 9P filesystem documentation
Date: Wed, 23 Sep 2026 21:30:00 +0000
Message-ID: <20260923213002.1070404-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923213002.1070404-1-visitorckw@gmail.com>
References: <20260923213002.1070404-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add documentation for 9P filesystem support, including configuration
options, QEMU configuration, and basic usage examples.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Use double backticks for literal text in 9p.rst.
---
 doc/usage/filesystems/9p.rst | 55 ++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst          |  1 +
 2 files changed, 56 insertions(+)
 create mode 100644 doc/usage/filesystems/9p.rst

diff --git a/doc/usage/filesystems/9p.rst b/doc/usage/filesystems/9p.rst
new file mode 100644
index 00000000000..fb4e8bcb9c0
--- /dev/null
+++ b/doc/usage/filesystems/9p.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+9P Filesystem
+=============
+
+The 9P filesystem is a network-based file sharing protocol. It is primarily
+used to share files between a host and a guest over virtio, providing a way
+to load kernels, device trees, and initial ramdisks without needing a disk
+image or networking setup like TFTP.
+
+Configuration
+-------------
+
+To enable the 9P filesystem support, you must enable the following configuration
+options:
+
+* ``CONFIG_FS_9P``: Enables the 9P filesystem layer.
+* ``CONFIG_NET_9P``: Enables the core 9P2000.L client protocol.
+* ``CONFIG_VIRTIO_9P``: Enables the virtio transport driver for 9P.
+
+QEMU Setup
+----------
+
+To use 9P with QEMU, you need to expose a host directory to the guest using
+the ``-fsdev`` and ``-device`` parameters.
+
+For example, to share the host's ``/tmp/shared`` directory with the guest under
+the mount tag ``rootfs``:
+
+.. code-block:: bash
+
+    qemu-system-aarch64 \
+        -machine virt \
+        -nographic \
+        -fsdev local,id=fsdev0,path=/tmp/shared,security_model=none \
+        -device virtio-9p-device,fsdev=fsdev0,mount_tag=rootfs
+
+U-Boot Usage
+------------
+
+Once booted into U-Boot, you must first probe the virtio subsystem. You can then
+access the 9P filesystem using the ``9p`` interface name. You can specify a mount tag
+(such as ``rootfs``), a device index (such as ``0``), or use ``-`` to select the
+default (first) device.
+
+.. code-block:: bash
+
+    => virtio scan
+    => ls 9p rootfs /
+    => ls 9p 0 /
+    => ls 9p - /
+    => load 9p rootfs $kernel_addr_r /Image
+    => load 9p rootfs $ramdisk_addr_r /initramfs.cpio
+    => booti $kernel_addr_r $ramdisk_addr_r:$filesize $fdtcontroladdr
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 6f477b842ca..6d7ca6b9aec 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -46,3 +46,4 @@ File Systems
    :maxdepth: 1
 
    filesystems/ext4
+   filesystems/9p
-- 
2.56.0.rc1.310.g51773c2048-goog

