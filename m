Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76646C61DCB
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 19:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ADC5605D9;
	Sat, 29 Aug 2026 19:35:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j-Mt5-66O31j; Sat, 29 Aug 2026 19:34:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788032098;
	bh=+GXpy4so6Fzy8/XMY9xrwj27iUipjMnVqaNucvFNR04=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m8WqcQgseq2/Yr3fweDoi8q+41lk37LFGX99qu4anqFTPnT/MeSFU/r8MnfzOJ+Jq
	 KvMQlKa4OnOwu/gocrUx4unan1GvJNz5184ViluJPMYUmidIrS2sPAAkGJ8qk3dqVb
	 QBNpZnplSZXATlcF6Qgr6uULZoO3g5T2JKU/DH+v3aaBS1MUFhK8XIgzgj7VKwCBDn
	 N2f181RlPhVTuKjW35g4r21rsYVDRz8FqxiPkP9cchTwRafuBqHwv+S9h3aA5uEi/b
	 pvLBX6KdH6H3qT2sLY2ys7DCbdfEqdG4BXqTFVJ/oO26TBEw6Qb8wgKnOn8lgtS4bP
	 mcl4a+y7e5BoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54FAF605D5;
	Sat, 29 Aug 2026 19:34:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E0B1127
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B6D240681
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P4eULOKcQN_s for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 19:34:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NdfQppIK
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 703054061E
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:34:54 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc1c73645a1so1650602a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788032094; x=1788636894;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+GXpy4so6Fzy8/XMY9xrwj27iUipjMnVqaNucvFNR04=;
 b=NdfQppIKG+kCzcP5OtUcALrIgAkeq1fedxg302cAE7R6wZVT5G6E6l/Ictr7D6LX3Q
 k9ex7x+zObZH7vJZXRvqtrTckhDmSexL7NgbUsMAGGJdLmfXn7FuYvhCP8wsFG8VSLjp
 8ptWE5Pc1b9PepfH0f/SLwwFyHMb9d+vzCA27cdYi5rEuATFA3qjvMUn+31ZBGpOu3ds
 jpxekG6CElhxJ1D1G/8Ejf8sT+MyhZu7COuO6jG9xxCNTU6QSM4GZ9cSJLW3M14mMIKz
 k/q4BmzsEQE8XUvE6/azoutmzMvkW0zatjBISi7bX/P9BA/QmN9HliL1v0e8+/yBZJIk
 OT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788032094; x=1788636894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+GXpy4so6Fzy8/XMY9xrwj27iUipjMnVqaNucvFNR04=;
 b=hVTnbaPNoHwpsPZoPVQqWsx9OhZ4KHRMsilHtIKTR7t5ES351ys+nPLUUUx7TwTDys
 K2TKsVyCbJnANI44XY9rOV/4yy5w33LDV7rJg+ZlYk7OgJxQ50V/0NjcCqB68qYjFFBk
 pLze2E22fKGlpyMr2plvR7H75pu0stbSxFB00B7WVB3PPCV0ITzXR+7/rBJ1wfUBTYnE
 gqnGJPojyNizLjQTjYltWWqS7XpbuNJdNA4MiFVp6BdLYVkq9wUtnjZqXz+LUj4ui7kY
 tR+dEvnTRBB5vghvI5L5890A6iCdy0AqbD66xmrzpvdg3gOEbOsH1meIt0fYhezBK23w
 42hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBE+pnC0xweGlS8L3S8Y7eE4obMK9QkgRtczUZBkBldsLgDJPGd8Isd4CN7DD/FJX0Z2fciPc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l1ECBWpkdVl4aqHba/ClfSmqwDF4GBYy+UWWptzjVP7VufQuLJ
 1xizPAPNoI8i90Ey8JU0TNOJtvvdF6NdLevA8kDYXSvNw0t+wd5+RGIn
X-Gm-Gg: AYBFou3cU/yuHNPgYSuAdf7dm5crcvogXAuvkQkDtkOhBEEXxrYJDKeJFidnxsUgjRp
 kdxBIu36Gxbfyt4cdC9G42rXMHFeoQs8jRGpf5jCZR6u76GTqxcs9Abeaj8VoM3PLXy1yXfSPDj
 3qnCugTA1+0xast0doX6Mld6CLRExqkwkg18r5Mv0kR9iKwxICnPni4QhznTc2LIMdOe7jMgxmj
 oI/jN/PBvOFC9zkaANaFWPf8Go0CcyWDmuH8QZr39M75ZfJUrV7miA7mbX2N0+hyq1CqJpR708t
 dNs4Fberl7SXeLjK2e/Bm4pUT8JrVsoRR9bppB94GgEBBNuiNzEcfYgaxSTOPd51Znq0jF2mCUL
 0v6ZCxGCdpyNTjOx9jbfsU53WHNh2XKC0CnL7WB6jpU9aeZXnNAUl6dm6XR9daz3yc2mlEHSXO+
 XdcN3arnNgbzb6XR8FUvUpINbQp/vttCNJbVsW8UQgx+1QPx5D3QiLdZnXWot/pvP8pXOYw7Ka3
 GGBgU68f47rY3Gix4onzXNV/JdNGUWNC2KPoFGDqX6QJNhI+lZ+tEKwPJOBTjWti5o=
X-Received: by 2002:a17:90b:1dce:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-396d0ea8b47mr26261963a91.3.1788032094081; 
 Sat, 29 Aug 2026 12:34:54 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (184.247.229.35.bc.googleusercontent.com. [35.229.247.184])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396dda7c922sm8052963a91.7.2026.08.29.12.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 12:34:53 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [u-boot-test-hooks][PATCH] travis-ci: Add 9P device support to
 qemu_arm64
Date: Sat, 29 Aug 2026 19:34:43 +0000
Message-ID: <20260829193443.2666920-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
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

Expose a 9P filesystem device over virtio with mount tag 'rootfs' to
enable testing of 9P filesystem in pytest.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 bin/travis-ci/conf.qemu_arm64 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/travis-ci/conf.qemu_arm64 b/bin/travis-ci/conf.qemu_arm64
index 690c2a6..254e613 100644
--- a/bin/travis-ci/conf.qemu_arm64
+++ b/bin/travis-ci/conf.qemu_arm64
@@ -40,5 +40,6 @@ qemu_binary="qemu-system-aarch64"
 qemu_net_args="-netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0"
 qemu_host_args="-semihosting-config enable=on,target=native"
 qemu_tpm_args="-chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
-qemu_extra_args="-m 4G -cpu cortex-a57 -nographic -device virtio-rng-pci -d unimp ${qemu_host_args} ${qemu_net_args} ${qemu_tpm_args}"
+qemu_9p_args="-fsdev local,id=fsdev0,path=${UBOOT_TRAVIS_BUILD_DIR},security_model=none -device virtio-9p-device,fsdev=fsdev0,mount_tag=rootfs"
+qemu_extra_args="-m 4G -cpu cortex-a57 -nographic -device virtio-rng-pci -d unimp ${qemu_host_args} ${qemu_net_args} ${qemu_tpm_args} ${qemu_9p_args}"
 reset_impl=none
-- 
2.55.0.897.gb25b4bd76c-goog

