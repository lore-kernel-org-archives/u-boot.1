Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46A5C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 13:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1FC88793B;
	Thu,  4 Jan 2024 14:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 077788793F; Thu,  4 Jan 2024 14:28:35 +0100 (CET)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E84587867
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 14:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp91t1704374898t9zqdzhj
Received: from ubuntu.. ( [111.196.133.100]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 04 Jan 2024 21:28:17 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: znfcQSa1hKY114vIWcTHItrh6uaAFPzWuSQr39k60XOuQqHJ7W6EE1GZXEzlH
 20J2TCMFuPRNJHwzJKPqrdX8MaSEVvVp7w/AyJksdHIYWObZ+7CpX+/IBdj7sJBKHLKYkKq
 Q5rYyM04DSOn2pSur4dqlIkF1pjPyhjLl4Gl4hYfEscga+41OAVbLU5A0lniHVcyb52ugdo
 wZx/3ThHX27diV8Wxa4srU39vgzTiyM/zGevD2qRWK+19fqCmCSMqFzLVPRiCIWFpEUu8x3
 ERmJHlID+f4sqpMJzjImLruOzVu3enCBuxoYhSymuCzswVdzTiujQ+PysVIhIeXQDOhWqM2
 vMBAxoBYgHD5Ez8K8bdZOSNeFriXGr8z07pjxT7Q7QFNhqsGpI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12667789777571002493
From: Bin Meng <bmeng@tinylab.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH] tools: docker: Drop the git user name and email configuration
Date: Thu,  4 Jan 2024 21:28:17 +0800
Message-Id: <20240104132817.278079-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

Since commit b45ab9ca6621 ("CI: Update to QEMU 8.0.3"), the manual
patch applying was removed, hence there is no need to do a git user
name and email configuration.

Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

 tools/docker/Dockerfile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index c4a2596b48..c12ed0fd9b 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -179,9 +179,6 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
 	git checkout v8.0.3 && \
-	# config user.name and user.email to make 'git am' happy
-	git config user.name u-boot && \
-	git config user.email u-boot@denx.de && \
 	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
-- 
2.34.1

