Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19268606AAEC
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FtQTrF52;
	dkim=pass (1024-bit key, unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=JbpzJkjI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E46D460662;
	Mon, 19 Oct 2026 16:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iJiVRY-CTo4L; Mon, 19 Oct 2026 16:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CAFD560623
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792426448;
	b=m3CBa+gIfJepz+rreXEiFJAZ8f1tZ29PPiZ0PL1vBDv4kbjdCO1HSXfW2OCLmYESTMeW
	 ZvgAQ08+5P1HwiXuZR3zRvC9dycdZBQlHXJO21xJ4T74Fb19GkEIAc197qEM3nKEGTcM9
	 CnC/7D2uN4qpYNm1ee7pRghg6PToTZy07gYGJsaAPurHtDv57fH03bLWOBbUl+5qKispj
	 /jXPDu7N4Y/Mq20hGlO5XkjESNsq25t4US32h17XNFIGsTjT2k1md5RAUs9KSMCJy0wCA
	 276BVSs4h1hducDAVJg3pllpSJbKN1KuK8AnHemXdDVI/K4JtQoTNyypNJCZDt52Alg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792426448;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tdQMxZdwNGyUoYedWoa9xCG33k9eNsLk97E2Cgv3yZI=;
	b=QmgowxW09hwcARh70EkrIPWpUrY+hf3oKO2ZGJWrn5WXk4O3juLgEVIWdjmlvgpLhThB
	 Ro2Rmajzqo6DNN/BvNKGGwZqT+xOl2160xuEUFUXnH/hjkCQFCYpnGUKZp8iklTQS8s0m
	 RMWPmz4DVJtr7rdf2wOE77g6+oOhkIuURu5Eaja6Xcj39Qvtc4WG1DBnQq/Rd7K/vgRny
	 CTSiCnbE001Izzva/jVte3zpTSUSlcF/GBYIM6ZXf0NCGtFGakj9kyGf6ighyjRNgHU5D
	 c8ES7xxU1FuHmFxw1w3XXRcRfjdmg9u0wH4fMQZ/E/gXfu/dSwTwhPBYrEucaA+yahw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=none header.from=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=JbpzJkjI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792426447;
	bh=tdQMxZdwNGyUoYedWoa9xCG33k9eNsLk97E2Cgv3yZI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FtQTrF52lJaE4NlW0FHEvJag1dwhq7NdN/3JkzQiMZIU3WykT1Lb21iub1EQ6vD4r
	 RosIUp517QDGMMUWjCXtqIJ41rluH25pzL6dGe1FEzWm9FFz4iK5hg9bgg7X9H5ev7
	 fy2w536cuUumL1dIpmaZ+nIS2wb2MqU3sMa8ud2lZ/rRhHOYdkwe7rbCFO1hWjdLRL
	 MuFOm4zLIMHWpdcRLIzitAe61gZPgTwPzGxyH5L583UX5zuqt+1EZrqyk3Lf0jzEpj
	 Ug8v85c0dmWvzUlsbTLibCZfc5w6aU3dbg2iw9+BdqEPwu+W7AWuQsQMbmU0GjCUIM
	 VC0dsk0Eb6ooA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAFD560623;
	Mon, 19 Oct 2026 16:14:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B9CE1AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CBE160611
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cbIv8dgHxoVJ for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 16:14:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 847336060B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792426444;
 b=Df927UMMolv1ptOMf/5t5RtXReN+QyzKjzdepIESr9tR5TJ2hFlTT52cckokMbbyArvw
 hry3jOTA0vNFvTtBQ6VUBbmHI+TZ4eiYv7nTq4Y5cYCyf9mXsy3UeeLpeXS5KwQczh5WN
 2kJ9sv76+PJSs7glszpzKpd9dAHM7XlBK4n/UU272fEV2gogopZNDz4un+Ce5sQEFlop9
 cIjQSDL83Eyj27VpIjvWyrnDtjqmEecdKM2ad+a4g9YRejnKO3uILzz5SaU7BDpbbRE5D
 0m7p4KRr+3KtJuywkju0lL/CSSo10Ah/WfF0FYTGpkiShvGDvHNDZoNPNd8c0H9uVdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792426444;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-ZohoMailClient;
 bh=tdQMxZdwNGyUoYedWoa9xCG33k9eNsLk97E2Cgv3yZI=;
 b=IjbllHBhiASNzk+m2U6hTz7ggbgjn/lny5/j7hRUVu2fxAHZWPZ16GBLAg5wevdG5y3Z
 f2cBARuELe6H6rxIvD+fy9EQR+toAFKDl8fIrkMp10DS+qgNLofMCW2ZFs1kYXqoYFT/1
 +YcotpSvYNZQRfdMstdzVNtP1/eSKpTIBA6C8nyRy3AB3Cu7uBc60vaSuPDrpd+oJP1Df
 qxFiV5hkniX86bnXtGebdTM1u+ip1nmAvT5+fGW43Qq0BouvI9O0CDVkEL4SezH51r0JZ
 MFpkzh0z97mz/cmS3oAYO8cahaAoutKslQ2Mh5P+n+6+OSSL3Flt3jTc4/ZIiR+OUcA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=none header.from=pigmoral.tech;
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=JbpzJkjI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=JbpzJkjI
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 847336060B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792426410; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cbDYri37Os48FCBOTf4IxHbCfM4shMDKAPqLBs5duT/O0qSM/Yy/ce+WLdkWmB4V155bmseXsWOLa878rk8Fs01gHHxJkYiWNuj8gp71XbIV/rtMCcVmyGcK7NVRg089cyEG7oRuamfZA9pYZGbqtFF0+X0hEzN+kzHAnYqfSuA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792426410;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tdQMxZdwNGyUoYedWoa9xCG33k9eNsLk97E2Cgv3yZI=; 
 b=SLdT2JwyRjzuwoB65cO2DaoQIh8olLbXYgmWHrN8hncdKjy3HDDXhZWJhwcG5f0tLkiS/QBRl5YE1mYp4AcVgRtpe8/faBiWWLBL9sBJp+ZDkR0KhbaHtzdKdyAEgoDKBkp7swF5tCourKKrm7rD6UFQNgcfygqnDRHvOC7Jc6k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792426410; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=tdQMxZdwNGyUoYedWoa9xCG33k9eNsLk97E2Cgv3yZI=;
 b=JbpzJkjIsJXpHUXahH+soQKPujEE6EarXMwYzNE0UNs8VpbVG8GghuSCiuLrnFfx
 /591orTO/OnVgzuFTHpyMkV7H2rdv6gIPX9a3qELXGvb3jtL3dU8X5si9Sou3QQIja9
 UWgL8XJ2N0iBsE68tU0bNTbwSyFoGCa41rHkiBbE=
Received: by smtp.zohomail.com with SMTPS id 1792426406509260.12372929514015; 
 Mon, 19 Oct 2026 09:13:26 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 20 Oct 2026 00:13:03 +0800
Subject: [PATCH] bootm: Relocate RISC-V Linux Images before booting
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-bootm-riscv-image-relocation-v1-1-e583a2dd1d14@pigmoral.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QrCMAyF4VcZuTawzlmoryJetFmmEbdKWocw9
 u5mevnDOd8KhVW4wLlZQXmRInm2cIcG6B7nG6MM1tC1nXetC5hyrhOqFFpQpmgD5WemWO2I6di
 Tj6ch9MGDES/lUT4//nL9d3mnB1PdTdi2L+PB34GAAAAA
X-Change-ID: 20261019-bootm-riscv-image-relocation-b34c6a5d9496
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Yao Zi <me@ziyao.cc>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3985;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=llaSy72B1CstyCB6x0GRwxFCyY23gxpqtak+7e1XjmQ=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLKuOU7a2OBmFCH5KNxB7KmJn0uf0tVa8SLne2+XVNgtc
 +rMTbvbUcrCIMbFICumyMLlL/7PWofn2xGB1vswc1iZQIYwcHEKwEQkWhkZPi2eK31sg8dss58z
 nzL4nL6SNrn9dOrihJ5b8amMty6VhzP84e43dAnwVay7ypLcsPlg9JkepUqjzRvf7G29zXiQi2k
 NKwA=
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RISC-V Linux requires the kernel Image to be loaded at a 2 MiB aligned
address for RV64, or a 4 MiB aligned address for RV32 [1]. When booting
a FIT image with a kernel_noload payload, or an Android boot image via
fastboot boot, the kernel may be placed at an address that does not
meet these alignment requirements and fail to boot.

As already done for ARM64, call booti_setup() for RISC-V Linux Images
to obtain a suitable load address and relocate the kernel before
booting. This reuses the existing RISC-V booti placement policy.

Link: https://docs.kernel.org/arch/riscv/boot.html#kernel-location [1]
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
When testing Linux booting via fastboot on a RISC-V platform, I found
that the kernel failed to boot with the default Android boot image page
size:

  => fastboot udp
  Using virtio-net#0 device
  Listening for fastboot command on 10.0.2.15
  Starting download of 27273216 bytes
  ..........................................................................
  ..........................................................................
  ............................................................
  downloading of 27273216 bytes finished
  Booting kernel at 0x0000000082000000...
  
  
  ## Booting Android Image at 0x82000000 ...
  Kernel load addr 0x82000800 size 24849 KiB
  RAM disk load addr 0x83845000 size 1776 KiB
  Working FDT set to 83a01000
     XIP Kernel Image to 82000800
     Loading Device Tree to 000000009de87000, end 000000009de8b3b3 ... OK
  Working FDT set to 9de87000
  No RNG device
  
  Starting kernel ...

No kernel output followed. The kernel Image was placed at 0x82000800,
which does not meet the 2 MiB alignment requirement for RV64 Linux.

The 0x800 offset comes from the default Android boot image page size
used by fastboot. Passing --page-size 0x200000 works around the issue
in this setup by placing the kernel at 0x82200000.

ARM64 already handles kernel relocation in bootm by calling
booti_setup(). This patch extends that handling to RISC-V, reusing
the existing RISC-V booti placement policy without changing the
booti path.

The existing RISC-V booti_setup() relocates Images loaded in RAM to
ram_base + text_offset without explicitly aligning the address.
The RAM bases defined by the current RISC-V platforms are 4 MiB
aligned, while the standard Linux Image text_offset is 2 MiB for
RV64 and 4 MiB for RV32, so this placement satisfies the alignment
requirements.

If a future platform has an unaligned RAM base, a separate patch
will be needed to handle alignment in the RISC-V booti_setup(),
also benefiting the regular booti path.

For the Android boot image case, this depends on Igor's "bootm: set
os.arch for Android boot images" patch:

https://patch.msgid.link/20261012-upstream-bootm_android_b4-v2-1-4c18a34550a1@oss.qualcomm.com
---
 boot/bootm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 92c8452a5d35..ade241f3a337 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -883,15 +883,15 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_CMD_BOOTI) && images->os.arch == IH_ARCH_ARM64 &&
-	    images->os.os == IH_OS_LINUX) {
+	if (IS_ENABLED(CONFIG_CMD_BOOTI) && images->os.os == IH_OS_LINUX &&
+	    (images->os.arch == IH_ARCH_ARM64 || images->os.arch == IH_ARCH_RISCV)) {
 		ulong relocated_addr;
 		ulong image_size;
 		int ret;
 
 		ret = booti_setup(load, &relocated_addr, &image_size, false);
 		if (ret) {
-			printf("Failed to prep arm64 kernel (err=%d)\n", ret);
+			printf("Failed to prep kernel image (err=%d)\n", ret);
 			return BOOTM_ERR_RESET;
 		}
 

---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20261019-bootm-riscv-image-relocation-b34c6a5d9496

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

