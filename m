Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2F3C61CE2
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 651B6405EE;
	Mon, 24 Aug 2026 19:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GoSoNYF3qO3g; Mon, 24 Aug 2026 19:53:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787601188;
	bh=QWZ+8dY8KquSW+gRJwsjYHeEtI9rWgXoMHhOlwB7h5g=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OhZQ1P0wB31Ny3KKmDvNMBoB2oJsQLVEGVaYQNPPpO+2DgZGmO/+UnVBNPE8dvX9d
	 flOgvF/aClQC6Ek1Sxt19PhQX8uh7isqQcUc+KXsyvXXQkYVQQij8b2Mii+DtquzsY
	 KQuSGW+xq2WRepsvXlbnOab63C5IEk/16ZMdf+S3ux52tDNrhk2SHYo05XqM+1TsOs
	 QTYewFI9XW+xgv99iYXxlw+Vy1AlFUp5wgEvKGwxaXcoq4HaVhyLhZ9cgELG+sD3rZ
	 nB94m9zfxpombrhgqoavketaeWfYQ84E7pujxQ+tXQSihUxVtOuNzAj4qotWMpzK6v
	 U83CL0CuIkdbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B78B040564;
	Mon, 24 Aug 2026 19:53:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 66337279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6445E80BD3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kCtdgJU26me6 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 19:53:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=ai2dxHkS
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8CA280D2C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:05 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso3053726a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787601184; x=1788205984;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QWZ+8dY8KquSW+gRJwsjYHeEtI9rWgXoMHhOlwB7h5g=;
 b=ai2dxHkSF+zkMAQOzXuDpMxBJrH+Hf5jiZHMA2r2zzA7Lv+ynv3tHnOOAddocQEee0
 piTaVpdWlCbNnTgXNP97y7HTiaMXXHALpbrJYZejOk/qEupjVSW1flbRuS7JI+n1AzAf
 aQ+j+pee2t2UM4EVQogiIE6D6f7z6fGHQgTeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601184; x=1788205984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QWZ+8dY8KquSW+gRJwsjYHeEtI9rWgXoMHhOlwB7h5g=;
 b=mfPe7ERqBjX6ceInpoucVMTktnIFIcufWHWbZip5Ht7s/KaqhGqOcM2jwGK3aM9w6N
 sUPTNSoG8siTxgSkEgmcnlQuknZKuqSzPG1gXaYJSIiyEu8M9B0V5UyrrqFt2CwdB5vu
 +Qmrl1Mw42wcOn1yfwdhG9P0EUeBbEcU6XqVxsNkRB5s3gl3d5TC8nFelRL8kjsVVGqJ
 Zb/LkCQ26ux2i8DeqJrg8X0AwTMkCkLEyO/2RfOBi/z+FO1q8DW2n43chT1L+nIbKrE7
 ClVjpKBdPiKOU6QUYko8XlYHqnrAAmoDwhk5MskIDB+GrT47xB+mo3+y3sPAT5vQJtkJ
 /vCA==
X-Gm-Message-State: AFuF++mF1zoR/pwIXQF9skPCgbN9Ps/IqgKs6/IRrZnVaaVtUL//TTkX
 QmXbJbI1c+Ken0oleViJw7Ex0D34RkGTqhS2RnCTiE4omM7wmizc6CVyN1HGrRY5aJCCUb/9a61
 nJn5/Ez3z6oVs
X-Gm-Gg: AR+sD11iAnU4rRwvsxWyXTbKMa6myyKapSRM7v2bMJ3AbMGjwz9cJ/JiPQ3r2bNI0Ln
 2QSLKMgMxIg8leFMOdLcIzMEcCxgviIGVen8132Xg0BOKlgBU53hXXwsyYP4tv+ofwQpZNI12qZ
 uWaeLi3qRB4WmpnW6k+2szfXgO+q7CY8E8uWZVABUEFm0AhleaFPBqpyNFtoLOJTqKP0kiLKcYx
 QEETOSc3yY3eQzPW9P07I71Lxf0rjg91BoaYlzmO9ddVsebQ+FsaZANshaKHJZShsTMJd5tF1xJ
 PpibEQDtgF/cgzDXlQFuJ+K21QZmFmtVrF4kABZzS5C0MMKy4Na2unkN5fVF3PqUDrA5hXgL94b
 WhXCL9HUAZjZgsRw0ejwqEfzbE8/lemzkw0hUh/+O+m3FNw9m1O5zIPM/EE1xOUlAEme3mvgVF8
 Zievvrrpq3bzLcQmfLsw83Su7TmEQ0aThiGFKw6Ax/UAEOo+LbXIRM8e0OchT6Az0z0Yzsit/88
 0iN0D5k2i9LfeGPq4Y9mpu3UnLsiYAoYtzYnELU5SwqgNunHjbQm0YmwgQB9k7ajuFPWUjK2E6d
 X+FRNMv3uBvC4pa5yL9CzaJl4pBfULlO5VHuEo8RISa3KA==
X-Received: by 2002:a05:6830:730b:b0:7e6:deb1:485b with SMTP id
 46e09a7af769-7f4afb44ccdmr1348241a34.16.1787601184213; 
 Mon, 24 Aug 2026 12:53:04 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc8623esm4975162a34.22.2026.08.24.12.53.01
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:53:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 1/5] dts: Correct behavior of OF_OMIT_DTB
Date: Mon, 24 Aug 2026 13:48:45 -0600
Message-ID: <20260824195224.556419-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824195224.556419-2-trini@konsulko.com>
References: <20260824195224.556419-2-trini@konsulko.com>
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

When we have enabled CONFIG_OF_OMIT_DTB, we really should then be not
forcing a device tree to be built. This involves two things. First, when
OF_SEPARATE is set, don't say we still need to build dts/dt.dtb. Second,
our init_sp_bss_offset_check check can only cover the non-dtb portion.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Makefile | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 98702205c36d..56a8ca9fb4bb 100644
--- a/Makefile
+++ b/Makefile
@@ -1237,7 +1237,7 @@ INPUTS-$(CONFIG_TPL) += tpl/u-boot-tpl.bin
 INPUTS-$(CONFIG_VPL) += vpl/u-boot-vpl.bin
 
 # Allow omitting the .dtb output if it is not normally used
-INPUTS-$(CONFIG_OF_SEPARATE) += $(if $(CONFIG_OF_OMIT_DTB),dts/dt.dtb,u-boot.dtb)
+INPUTS-$(CONFIG_OF_SEPARATE) += $(if $(CONFIG_OF_OMIT_DTB),,u-boot.dtb)
 ifeq ($(CONFIG_SPL_FRAMEWORK),y)
 INPUTS-$(CONFIG_OF_SEPARATE) += u-boot-dtb.img
 endif
@@ -1615,12 +1615,18 @@ endif
 # The 1/4 margin below is somewhat arbitrary. The likely initial SP usage is
 # so low that the DTB could probably use 90%+ of the available space, for
 # current values of CONFIG_SYS_INIT_SP_BSS_OFFSET at least. However, let's be
-# safe for now and tweak this later if space becomes tight.
+# safe for now and tweak this later if space becomes tight. When we omit the
+# DTB we simply have to have accounted for this when configuring U-Boot.
 # A rejected alternative would be to check that some absolute minimum stack
 # space was available. However, since CONFIG_SYS_INIT_SP_BSS_OFFSET is
 # deliberately build-specific, to take account of build-to-build stack usage
 # differences due to different feature sets, there is no common absolute value
 # to check against.
+ifneq ($(CONFIG_OF_OMIT_DTB),)
+init_sp_bss_offset_check: FORCE
+	space=$(CONFIG_SYS_INIT_SP_BSS_OFFSET) ; \
+	$(subtract_sys_malloc_f_len)
+else
 init_sp_bss_offset_check: u-boot.dtb FORCE
 	@dtb_size=$(shell wc -c u-boot.dtb | awk '{print $$1}') ; \
 	space=$(CONFIG_SYS_INIT_SP_BSS_OFFSET) ; \
@@ -1632,6 +1638,7 @@ init_sp_bss_offset_check: u-boot.dtb FORCE
 		exit 1 ; \
 	fi
 endif
+endif
 
 shell_cmd = { $(call echo-cmd,$(1)) $(cmd_$(1)); }
 
-- 
2.43.0

