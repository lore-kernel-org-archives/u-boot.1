Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C66C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 906EF60670;
	Mon, 24 Aug 2026 19:53:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jz31QuelZTS2; Mon, 24 Aug 2026 19:53:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787601191;
	bh=wCPtZDRQhGwz4wuSnoUn1SvmwbZA4kSNqEPVCT4gTlU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nnzKUIzHUxPUa2HBX9ymfspN6IE57c3+DLqedPY5sJ7fpjihAFt2pBuqAAVks2uYp
	 ExOi7YgbOswYtng3o2RMF9SGzs8MoE89sXFbznPuyPKUxFaUXD1s5Qf4X1kjRx3R9/
	 HLOifi5sdrUSZfH5+1AIn9zQAxkxRDccA6SY6b3OBWhFvCg6hga4loD0JkHEtrz9lL
	 gomp955NyGa7lQZt4Jvx0gMsN8128HWpbhpLEh1JLmu2UnrkuHKvg3Junc8cuqDG3+
	 odVYIZr/c6LtXK4qjis0MM70SwDxxZ3EcMlKIaAG+2zr99yX/e78lq63DPPprKrYIM
	 2Sm31mEfgrw1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42793606A8;
	Mon, 24 Aug 2026 19:53:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E47DC4B8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6BDA400D1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eEtCjYycPqZP for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 19:53:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dcYsUjdh
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30C48400A2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:06 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7ee37dc91f5so2972254a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787601185; x=1788205985;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wCPtZDRQhGwz4wuSnoUn1SvmwbZA4kSNqEPVCT4gTlU=;
 b=dcYsUjdhDYIpGATKNWEKLDBz9YIubMYyM3CCnjhsMT02Cgn1dyBjv12HYO1tvOmypc
 83hWpqehu7k8cpctdKRsHCmmNBaOownMlzwSXPKWys8xCFYE4Xe0H0Ls2bjUTn51Wolv
 dCdTiqvkOzxaF+VStHcbgkUc7UXhZsdWQAVRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601185; x=1788205985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wCPtZDRQhGwz4wuSnoUn1SvmwbZA4kSNqEPVCT4gTlU=;
 b=JPiCSR/xHxrEbtLvTSEYTolFPEpiF+Xm+fl1HXJIIuGGwITJFr2GVQG/m/n+ISaQUQ
 hu1tb36weFih7SOOjnqT/bB8G2VGNK1RDAJBCM7wGu8BDH9Q7Ez41AmGL+ajqJokzN3E
 7p1YD3ycDPo3QyGS4CkDFhysVD6kkgi4d9sE6lnebQRyU1rS5pzdoOFOFJADo8dCTaEM
 Vn6S5RVUjYM6dtWsK3dAAqDbjpizM66E4HA+Ti4bk7/2QI2dapPsYHWFzgC9218tmiwA
 bjSmcR37/MKlbU6kXodggR1iqZ4Q3WiEVea73tHnana7RZJ8pW1hyxZHfjovJ4tw10kc
 mWSA==
X-Gm-Message-State: AFuF++kpoUztOb5XS14m85gH6zFgUQ9gUsMvH+aPjdwhzLLGcSvYJ9JQ
 5eb7Yq+cTV8UOOCQwmDB1XCuROgsZpFFpA60wKYm0V1hdaQYPwJ6j/GrM7dhWub6SG1/KP9ige6
 vIJHkbZuIdR6w
X-Gm-Gg: AR+sD10Q0EFS4rYVqgYwrZG21s6ekljoyABqHqgt0UJvuZ1fSU55Eb5aR1lalrM3BuM
 ecWNtTjQGRwmjzjuDQEmRtmfYA9mkC+gzhXDO1S126kEBebRO8hjwgugYrKj0q2pWlL3Fwcv+PP
 DlVE60QAOWxHAWx74etD6/3Cwh3hhM16a0xtBeIB+CnCCKACJ1T1yMKIB/rTT8jesiwVw1789E2
 GBbYzl7idC0BOvWTF9sSlTzTEGluz0++iys0QaTdnOtOUwsyqgP1ARv/NgIMAVVW+R5o2GViUBp
 AQhVfW0tM0loaE4RWXaSwrm8/IEJ2cGVOGcVyMymaDv7hgj5D0oIshEcKC7DZ/iFkVY/YXYRrHo
 BqxF6givzUgKu3O4OxmCP2zh2nTz50Pqz6zNHjEu6vFtIGTF14RrpkXtzYcrBhnVVrArNLRj15U
 YSDJdkYUL7TzGPiIUghkmWHocQQ8jApgw75Ji5VmIwzmw6vGkwy56Bq1vYY0dcrRfBnx8ROLf7j
 FlLLGAi/ynhymJ5d5O0Z3OLTRfjteJ3jXqsA4enAwXbQ+bTZc7JtrHJTzg2Rx3MwIArz9yBhDQh
 hOoWXrJbqElPX/6h80bIYXy3ZOeQLv3GpeVdwkGD/c89
X-Received: by 2002:a05:6830:6d0f:b0:7e6:ee1f:96f1 with SMTP id
 46e09a7af769-7f4763e1935mr23734364a34.5.1787601185460; 
 Mon, 24 Aug 2026 12:53:05 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc8623esm4975162a34.22.2026.08.24.12.53.05
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:53:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 3/5] dts: Correct entry for OF_OMIT_DTB
Date: Mon, 24 Aug 2026 13:48:47 -0600
Message-ID: <20260824195224.556419-5-trini@konsulko.com>
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

When we omit writing a device tree file is not something that should be
prompted for but rather it should be selected when needed, and the
"default y if ..." conditions should be used for when this should be
enabled without being selected.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 dts/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index b7a2d12a73b5..a2973ef40860 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -213,8 +213,7 @@ config OF_HAS_PRIOR_STAGE
 	  disabled in the board's defconfig file.
 
 config OF_OMIT_DTB
-	bool "Omit the device tree output when building"
-	default y if OF_HAS_PRIOR_STAGE && !BINMAN
+	def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN
 	help
 	  As a special case, avoid writing a device tree file u-boot.dtb when
 	  building. Also don't include that file in u-boot.bin
-- 
2.43.0

