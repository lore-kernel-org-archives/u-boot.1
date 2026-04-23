Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5263DFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7BA584262;
	Sat, 25 Apr 2026 18:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=qrv-systems.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F67984154; Sat, 25 Apr 2026 18:45:10 +0200 (CEST)
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406BF83FF5
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=qrv-systems.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr6.vodafonemail.de (Postfix) with ESMTPS id 4g1rbS3RtRz3sTpX
 for <u-boot@lists.denx.de>; Thu, 23 Apr 2026 22:38:28 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ipservice-092-208-227-006.092.208.pools.vodafone-ip.de [92.208.227.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4g1rbS1HKKz90qf
 for <u-boot@lists.denx.de>; Thu, 23 Apr 2026 22:38:25 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id C08532ED22D; Fri, 24 Apr 2026 00:38:24 +0200 (CEST)
Date: Fri, 24 Apr 2026 00:38:24 +0200
From: Yuri Zaporozhets <yuriz@qrv-systems.net>
To: u-boot@lists.denx.de
Subject: U-Boot/RISC-V: another OS to test: QRV, port of QNX 6.4
Message-ID: <aeqfYIjKskBMx7L1@tachyon.qrv-systems.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-purgate-server: smtpa07
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 801
X-purgate-ID: 155817::1776983908-3CC37C2E-4CFD2DCD/0/0
X-Mailman-Approved-At: Sat, 25 Apr 2026 18:55:12 +0200
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

Dear U-Boot RISC-V users,

For those of you who like microkernels, it might be interesting to test yet
another OS on your RISC-V platform: QRV, which is my port of QNX 6.4 to 64-bit
RISC-V. The sources can be found at:

https://github.com/r-tty/qrv

(one shell script clones the monartis/openqnx repo and patches it to QRV.
Then, in directory os/, the usual "make" command builds everything)

I tested QRV in QEMU, and also on SiFive U740 ("Unmatched") -- that's all
what I got. It would be interesting to see whether QRV boots on other
RISC-V boards too.

Booting in U-Boot is straightforward, and doesn't differ from Linux
(kernel+initramfs are loaded; kernel is started). Instructions for booting
in U-Boot are in the boot/ directory.

Thanks in advance!

-- 
Regards,
Yuri
