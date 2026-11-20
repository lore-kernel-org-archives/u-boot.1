Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C71606A6A2
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WoUHeZZM;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MxlsVKAk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D31B28191E;
	Fri, 20 Nov 2026 22:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 79hWjeCHBCWp; Fri, 20 Nov 2026 22:05:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3419B81916
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212338;
	b=FjXXxwmM5dc1GLsA5AyStkMZ1Y2t/lanq/+/mY1EPWBfID6kuZUmeB8hwdUv+hQyj7oY
	 ApIgNIbPAt4ww9LScAqKoVErMI7YzuH5gP64MTmifUrCfXdPT1D/iNxQVt7AMCObaaiiH
	 bCwJkn4fla+3GoDiptlZjTyUJ1VDGMcexQskHMZpSmArLkOweXlm2UU/flOHIVCpKlceC
	 yYZfDX6mAOeJefaM1h8bVnumkCsvH9kEceLAjoFTGdZE+wFyQNQHD6OdOgF3XkMaJOsks
	 xQd+hhyDBrMLIM11Qwgd4nI88h5vyvggpKwqBAjz9cmAgHoss1DM2VitzWeC/WHHH3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212338;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CEXj2+xi0vCFvO51IkoHt3FUqY2utfFrPkP4DqWAeSc=;
	b=dtisIwqdgqleMrsSQQ5+Dt7CcFZt+hMT0P/Rt/ewHIMg8Cxd/HGLnXvuY89NWZ1iXzLJ
	 P83yDm5sPBQUyYorf16Erwd7uyCj9wqy02tY4uRrD4ByR2mhleaSkLfIuXe24HKD6flGl
	 lxnshA7QGKLJPyJzHhgneKpY2xp2wSyefeRjuNLKT3ccFsLvSFQ5JsQ/B6pEEaT1hpqCi
	 KKqTeLL1IbxOs+gIRi5RB1hRkiUlDdIQPkGKsSPNBH0arlON8CtTeAYM8m4Sw8+FNeHEU
	 e/PujtQIEETbK48LjkTE4Mn2urovyy5BCkZYhtvBh76E+GEJ8l8XKgWXEFuD2KMCi7Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MxlsVKAk;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212338;
	bh=CEXj2+xi0vCFvO51IkoHt3FUqY2utfFrPkP4DqWAeSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WoUHeZZMn+afBi11dexFJK4kRJP6OaQyFQzzrQ6dHFmeZX9yKJ5vGiSTAGJg3EYy6
	 /Rq7SmNMN5wuU8gPFm8B8e/kvNDnRN9ncPGN+Nn/BaS+rQ0tOgfxFBtvnWgIymaYGx
	 vzt5aUxC8zVahX6s6bHgjgHQqaL+wk7Tn12o2PapUXx1hqtdN8AVB9LCF4y/tEt7LE
	 map77Dh4JkxuXgBP+gWaEtZYHcTCsh6lk8/kd4mRZEHtqHnNK/0GEVAb36E8nnkKeR
	 ATzpKx+vkfCDQ+izwMhfZA2wzvBhCLhE97+0xLVeAM2SsZIYO5VhtTr2/vO43Hpb6e
	 BA9ZBCXqoG+BA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3419B81916;
	Fri, 20 Nov 2026 22:05:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73AC5465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 451808186E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRFWhIDXHFQT for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:05:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 95DA481771
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MxlsVKAk
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95DA481771
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:24 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-48e94879f02so515019fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795212324; x=1795817124;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CEXj2+xi0vCFvO51IkoHt3FUqY2utfFrPkP4DqWAeSc=;
 b=MxlsVKAk76u5xckD9N0m1sO140eHxyld0gnYPEVZp1qUjqMHORz0vj6hVKjpiefzpd
 1KVSzyBeWa4gE1IPXCoFBmL+44tvSNohTrOnX5d3RA8G5I3+5SHUDpet88sq8WI3dUQ7
 yxsUFD8+MpfxKAtTq1G3H9GpheCMszn4qT7LXB+QbsXlW7dzBbs1YExdQbcepN2zOIHR
 SHo3clJy7CubRK5Bl6Itrx37KbPMfXLe/vjWNgsLKKLIvoeg2PxsCVf8BSiM2LweSp4c
 oSSKH/O4teVSnNxPKRHycLR051xM6M7wJE/Y4L5Z72KsBvUvkxJmyMJ3j82CWFSQu1Td
 n5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212324; x=1795817124;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CEXj2+xi0vCFvO51IkoHt3FUqY2utfFrPkP4DqWAeSc=;
 b=L0B+8VXIsUycYWoNPUbVpqRFzsfWhw/lO1hPxiDt9cAlUpaixEiTGYK1rrNnJdNK+X
 NgHbBCt7Kbx38tk1d/gCgxFVDhhmwcnzPqKmfeHI7dcm+WWi4eZgLTgoTV1aE8JFJGvK
 k8ZhohK6/1MbVX7IkR/6w8Lo4rzyLo9dSVbm/FJKMcjgXC6YDOBoW0Pdk29zWlLBrzcm
 yX2mVinAQ/rdEpRr+JLDsAHzNFqGMajaU/J1RndD3nNDu7hgbnMQEuriuEv0Eymtybo7
 PR3bQZ0YokSem+OiYWeiN3ImZ8tYH+YO9PAKOAnmmWjby9tNVELklCWC1Ij3iKuU8urx
 8QTg==
X-Gm-Message-State: APuU4Z/aBYpzdHyNaAvq2gTrwL26h9+9rVQm1EdGOdOXGSwZjxBBOwhZ
 jpQbHosp5mRaw+upEM89W+tqgp+Yh3AqEwLECx9SUW4Zxn+VujFXjFz4UObNczTQtGM=
X-Gm-Gg: AZFdTZcmOdnwofTJhkyKO0leMiriiJOCWQ0mk3ZbNeJMXx983kL5d/Cv/A8UMS3eLdA
 bz58A8HDJmPKxtp4WsMtIv4PWhdYEtj+0ZwwWEO97CeTUdq8QdTef/0BnGPJ5y/zfOA0HY2om79
 AjiBI028LJUxPH7cmXJwAQQZkxQ5FkjhsvHKX0V8BY1IyL56iE55FNAEpryzeUvycnmpR/PdEqb
 Pe4dKrHKgwIYwq719F1a+EbpX/PbDub8BFPbapqTiwv0IETLD7WkMkyu6KHiVuYZ5zZmZghpl7m
 IEH/GcFFSrEwvLbkFnalH1q8gEgkOSO7dWEXLfMjr0LQun7ljGuv+teiZBI8Rjq+NVYMS7yjXQF
 OcVy82wNBkwz6tJBi9160sooUxAD1gx5ukc1f3YkYiQFdWkK3IjrAIYAlOvM6iHVoQxeHzye/LL
 jsZ8jSVmIUBhj7yw8+Y+7aSWXmye4IJWB795GOVQBi6u4/4T3D44KvdLG/xczYfn9/SvrzzP/kf
 vQTHxKroHY1crXGe8ISHloTs7mxjsnCRMpWcuT6aq71mRz+XVbpn2ZhVH3Ij6xDNfFhzRbtF0Ni
 sNiv0lK7z4NTaKQk1D7ArofObG8YQOed
X-Received: by 2002:a05:6870:65a1:b0:4a2:4d67:5977 with SMTP id
 586e51a60fabf-4bc81ca27c4mr4586264fac.18.1795212323774; 
 Fri, 20 Nov 2026 14:05:23 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3878346fac.12.2026.11.20.14.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:05:23 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 16:03:47 -0600
Subject: [PATCH v2 06/10] binman: recommend a separate devicetree for the
 image description
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-binman-dtb-v2-6-4fa1894b7e2f@baylibre.com>
References: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
In-Reply-To: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1712; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=qVK5YBtFo/QtWkP4D5ghtgS9HJyV0TZIRy9caTnVb6I=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMPwp/PxKjm2//BXkDsz48aX7M050gWfgK5Ac
 Hydc84PfKWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDD8BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ax7cIAJQCkKoH0sCoKdEG73FBQ7pSakYwDpsnXzasMb9
 enPZ8ORPCsVY2FZEdxDjhXfRgbfUd6wLTbcz8mSCETtBT5cW+RPtzI0SO/LbKc7DrHzL68GADiO
 XeXIVJl7m45LDloVFqMpcQJamX5pv05apKj4lGX0HeKTVn6x8mFihjpkeVKdvwQtcEmM8zFycFd
 /KQfj4lUuH+MwPCATIhmqSB1u0FSHbneLZDApFLpVgC/KTEF+ETSJhrh6P12C8kRbh3fYfMPqWk
 mrE8Ocq8A7SdmgcZj9g3GNtRl8fP8n80Mks+4Aek29mNsI05DGdUXBx0Nm0dghpAvJEYEEuGIYj
 hGPg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Recommend keeping the binman image description out of the U-Boot
control devicetree when that devicetree describes the hardware, by
putting it in a separate devicetree selected with CONFIG_BINMAN_DTB. The
binman node does not describe the hardware, and boards can now keep it
separate without losing their u-boot-dtb entries.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 tools/binman/binman.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index abff7e8a414..9acbe558f0d 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -287,6 +287,15 @@ same files that describe your board's hardware to describe how the image is
 assembled. Typically, the images description is in a common file used by all
 boards with a particular SoC (e.g. `imx8mp-u-boot.dtsi`).
 
+Where the U-Boot control devicetree describes the hardware, e.g. when it comes
+from Linux, it is better to keep the binman image description out of it, since
+it is not part of the hardware. Put the binman node in a separate devicetree and
+select it with `CONFIG_BINMAN_DTB`. That devicetree can `#include` common
+`.dtsi` files to share the binman image description between boards. The control
+devicetree then holds only the hardware description, and it passes the
+devicetree schema checks. Keep the binman node in the control devicetree only if
+U-Boot reads it at run time with `CONFIG_BINMAN_FDT`.
+
 Where a particular board needs to make changes, it can override properties in
 the SoC file, just as it would for any other devicetree property. It can also
 add an image that is specific to the board.

-- 
2.53.0

