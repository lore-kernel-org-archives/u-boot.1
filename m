Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4D5606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UGfulgUH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ii2ep5Ee
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BF8740891;
	Fri, 23 Oct 2026 22:18:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2Sp4ADUQWJu; Fri, 23 Oct 2026 22:18:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3D6140706
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792793927;
	b=IUXaMlK5BQfLOyt6oP8wHGO1jOtF3mZHMPLxCowDFFTIHby0F97hGaHjgqv8Jh8vqQrQ
	 ATetz0lxqc3IBr3wi/jTZREUWNjG1iMMVx4LlUmzmuFxz1NXUdwAWeXqsJWUF3bNgK6mR
	 7Vo1FU5GTlCo9kozxYVbOtpFweBkMyiuaLfU/gsv2Bl0H6BYwCuBpQ1aVAkwebAas9IPm
	 2Sh3SpOx3BNVrtNXh+rrfEO/cfZY8ASBeEHfNbURX4QgQobHBNI2NNqIDM6vl1IVv+kMA
	 nXXit9pp0OpSdrR3fprLSkr/RZ5a/KARJ/EnwHlMO2TeWGCGDThnspil1TBkvFNoYQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792793927;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=V71M8+sIIOP37GgGSaian9U8qYXJGKZZ3EU1ou7tA+w=;
	b=r19f4iAaZA98lD3HAIFMlRNx6iyO2YL+OIExHy4zgUKCXN9W3ug05wxi+0+b68SMdvVw
	 0w6EaQs9b0BB/bxdcmfog2eWM7UExr6o6DeBtbF0z7gkDHv06HeXKCZw+s3m8vxZJd745
	 kzHsQKf2VO4DEJ1C+zQDBmY0JxC3Rj+iED36ubqb3L7Yt3omwYd9x0utu5LYDn2bE3ke2
	 gbIXVB85ny6siGJeQ/y6c+SatYOJWzzs3+tV8pJX4SvKMD4hQBSKRuFgdFLsoUZf4otpk
	 Dc92QSL6q1Rks0BzVRPZ0wEHzuo53slrF2KwL0/MKt92JqjgKDV8gAZ6tAt6q6weUyA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792793927;
	bh=V71M8+sIIOP37GgGSaian9U8qYXJGKZZ3EU1ou7tA+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UGfulgUH/eHWfCkNn1ZXzzUFO8IfHqJUfOXK/UHyGtIhTEhoZ36UTKDnxOS13Hwph
	 i4+47GicmKoKd9uK+9nQ8oPIVp8WGN8mMQpSLwIqf9BVus+uelIZ0Xil/ekKJ5gF79
	 bhEPPljX0Uez3oPPdF61e1lF+Igo3SQgsW8bKeaYceeSGvy/CL3JPpuQ2LGCd0erYY
	 XVDddxZtOYtwghefpV9LOESuk5U2Wlsr5jb9rObpsUd7gkx1AStPIXFkuARbucWAJP
	 V39DSwwpSk3Ho7p2Vsb1PfchD80r187uST2Vr3DbnlV/dQumeTQ9txc/XHFCcu4pHy
	 2labktSDeD39g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3D6140706;
	Fri, 23 Oct 2026 22:18:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0078A79F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2B6D40488
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G9q5JigyOxSZ for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:18:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 50FE54016D
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792793924;
 b=F3rc3vIRgVU2V5gcLdH4uyzRqrtOkVjdPxw5MKRXeIqyS0Wr/a5Kw744rz3YADiWLm54
 /9QiRVDiw+nuJSvxgc5+luPuAH9nBnbpFnVOi13jG6y83zFyPs41HokiTiwPE64IpqoG2
 fljX3Wm92jbwtfo66Zj3jPzsBjSILnrhXe8XgTTbXf/qdWZGKofE1GUYTvesRUXzrE20X
 b6f4CwScXGBrWuQkhoTw7oL22x2zubJmgjsxTKom/WH0jBWXJJHC+lY7t6dDz5BNOtUai
 sE36oCqSEHfU6aHGqK241c2MACb/1o2MmP/skpp5c0/2+B3875qvziqlywm0gZzMVnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792793924;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=V71M8+sIIOP37GgGSaian9U8qYXJGKZZ3EU1ou7tA+w=;
 b=c0jZidm/hm9Ng/UvnTjmmTyrCIdhLvNltAU2vBIQNxntvWdJ/2Ob/UZEnd4uV96HxiiO
 afKKm4yhHyFLD7VFuJ6yKKYu92s09Pm234y3Uj0HbD/ta1sJQBK7BmR6QDP7TTTSIVUHT
 6Azffg/w7h0zVEZh/AtOtzIvGH/cgY8EOYE5lZLZRACJo4VFvqaPBj80Qp8VxIp36R8zC
 163ItwxrkUW4m8BHNg9Z+/4fDGF0+MmDpfwjyv+eZeaffIGwxt6fEs2uJVqkUtUTayvVh
 LTTJeFr5FeKfc5c/Oysg5ONgtjYvM+8DsnCbs5jylbFl54VGGYNhQW58bv+9l7pg3Sg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ii2ep5Ee; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ii2ep5Ee
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50FE54016D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B4DA601DE;
 Fri, 23 Oct 2026 22:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761D61F01825;
 Fri, 23 Oct 2026 22:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792793921;
 bh=V71M8+sIIOP37GgGSaian9U8qYXJGKZZ3EU1ou7tA+w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ii2ep5Ee4wI5CFvHOT5gXql2HUqRFwMfGdSa2GLCiRpnKw2JxpTPL2GghuzlYO0QA
 LmZB22DE+0AlV1kxbEBD9AalF1/RuJ5RAddT5GlOXMPtAHkE4HOO2/4r5kqCHFHcHp
 JRDtARnJU0t2RlcPhhknwWWDHcX+ey2WmioM2dwK4OBbaM6HQKh4Oziy6qUZN9XdTr
 Djhd6nuf8dqCMIC8Ss7xfsVtIbUb/pZL79jfUfiG9/vc5D/k7DRky9uiVqguS+bhrZ
 Dqs6zniSXMlSHdji4Bk9qYOjgQlNGyjG1QvoTSMkS/rCUgshqBK5/AdncPkKved4cw
 5QH/8FUPd4B4A==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 24 Oct 2026 00:18:31 +0200
Subject: [PATCH v8 4/8] configs: stemmy: Boot EFI from external SD card
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-ux500-external-sdcard-v8-4-badcdf6db2ea@kernel.org>
References: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
In-Reply-To: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the fastboot-only command with standard bootflow scanning and
enable the EFI loader so the removable SD card can provide the default
ARM EFI executable. Filesystem probing is handled by the standard boot
framework and does not require the FAT command.
Skip global boot methods so EFI variables cannot redirect the scan to
the internal eMMC.

Disable mkeficapsule because generating capsule tools is unrelated to
running EFI payloads and adds a host GnuTLS build dependency.

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 configs/stemmy_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index 631ccababf1c..b1a14ab38210 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -14,10 +14,10 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_DEFAULT_DEVICE_TREE="ste-ux500-samsung-stemmy"
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
-# CONFIG_EFI_LOADER is not set
+CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fastbootcmd"
+CONFIG_BOOTCOMMAND="bootflow scan -lbG"
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
@@ -43,3 +43,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x685d
 CONFIG_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_MCDE_SIMPLE=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set

-- 
2.56.0

