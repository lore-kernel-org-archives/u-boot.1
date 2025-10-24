Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4C3CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 15:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8606B8390D;
	Fri, 24 Oct 2025 17:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD82836B2; Fri, 24 Oct 2025 17:12:34 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FB06838BB
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 17:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms02z.xe.abb.com (Postfix) with ESMTPS id 9BF3F728C;
 Fri, 24 Oct 2025 17:12:31 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025102417122891-28981 ;
 Fri, 24 Oct 2025 17:12:28 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025102417123119-18302 ;
 Fri, 24 Oct 2025 17:12:31 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Bin Meng" <bmeng.cn@gmail.com>,
 "Patrick Rudolph" <patrick.rudolph@9elements.com>,
 "Tom Rini" <trini@konsulko.com>
Subject: [PATCH 9/9] doc: develop: virtio: Fix qemu example (true/false ->
 on/off)
Date: Fri, 24 Oct 2025 17:12:05 +0200
Message-ID: <20251024151219.100970-10-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 10/24/2025 05:12:31 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 10/24/2025 05:12:31 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:28 PM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/24/2025 05:12:29 PM,
 Serialize complete at 10/24/2025 05:12:29 PM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
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

The given qemu examples use true/false, while qemu actually on/off.

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
---

 doc/develop/driver-model/virtio.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model=
/virtio.rst
index 31b94d04675..9a5e3240c3c 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -118,9 +118,9 @@ By default QEMU creates VirtIO legacy devices by defaul=
t. To create non-legacy
=20
   $ qemu-system-i386 -nographic -bios u-boot.rom \
     -netdev tap,ifname=3Dtap0,id=3Dnet0 \
-    -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Dtrue,disable-mod=
ern=3Dfalse \
+    -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-moder=
n=3Doff \
     -drive if=3Dnone,file=3Dtest.img,format=3Draw,id=3Dhd0 \
-    -device virtio-blk-pci,drive=3Dhd0,disable-legacy=3Dtrue,disable-moder=
n=3Dfalse
+    -device virtio-blk-pci,drive=3Dhd0,disable-legacy=3Don,disable-modern=
=3Doff
=20
 A 'virtio' command is provided in U-Boot shell.
=20
--=20
2.51.1

