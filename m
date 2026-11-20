Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5082606A687
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0kGGrnWz;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UQLlRPBV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5439281846;
	Fri, 20 Nov 2026 22:05:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t4OCPLALFjfZ; Fri, 20 Nov 2026 22:05:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9AD0E8177A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212322;
	b=XpW8/01iee6P9i9yD1P/ryZyyFcNuFewpttBXjtfNNRsOuRS6E4J1afmaOhaGye/467y
	 Y1K+ZQz9h3mREpIOqtnWWqvOc7I6FUymQc6xaYRGZ5/PbK8+16Pm7kdui300B44vjohi+
	 V6PFM89XqFGYoTK2Yxyvv7lnDkOvW7GHCiEyWY2ar2w3HMIlX9UP8k2ZX2/1lDVlrZofB
	 TTfK/1aWWiOjrJTumBSzVvav8/AJamfQotMZxpMcTosIXtptL4JyN6J3FgtVZ4+rWWri1
	 fmHr2z29zomz6/fx3v3RkxzcIerWzSoAljT16x4GYBQMzWbegcTU4yxTGR4qSaydR+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lSodj/r8GNeNsOos0dd+KHdH/76NEhQGYov/DqcmJBo=;
	b=QhAYOrnm3rgvIP49OS3s6lZTy/bswmOHHF5IqWNS+Yl7Xj/+rBUqtW0dlbv/JI6bhfub
	 L+eVxyUZ1RlrBZgMpy+jYVIgmBkDh+/OcP7rJhipWe3RL0TOjuv4sGmAsBviM+DKtge18
	 PREFbnmD10Ck7Sdn/2MbHoIu3kMOqZaiHXLJsxT728l2Ts9tA4lb+ukCAj7nnYVFd9ik/
	 lP4CYnWFUnsCKpR02JtAKKElCZv62HsH91oY4ZOQEmf8GhRg3Ez2hXUBZWL+m6L6uDY9s
	 6hNr8S0ifElGjPh5MtwlmQL4vya6VX/5f5dCX61E8RKUvE1UaX2eud/HzgmIj385tEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212322;
	bh=lSodj/r8GNeNsOos0dd+KHdH/76NEhQGYov/DqcmJBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0kGGrnWz2Dncit9bPgTvb0Ncdegr8gJu09zRfTPPkBkA7MWNkqRrYQCnhfH/RCeyu
	 y1tK1JOMa+DmmaZsrjVSPtkGnjT1zjrARWwjAclXLP1YvnYOBK2BdWtdwWrdz2s3u/
	 CvF2vhYwiWu9AoEi4TVRzD3skIzxv4wu9TasGwC1XjNlOMu7AhT3jzRZm2LNx8OBEb
	 BCiZllUsmW/iu5PbODPx5h1ooeKqeT8PpxghLPGkVuc0B9D8eSh+IqZE/7fSlz15iA
	 s4wui6PMg4+RjZQdCD4hwfRt1gTPTR0Jd3ywjgzCemZDALb9WUgM1535uaKSD4Co62
	 QV58nMEs8J9RA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AD0E8177A;
	Fri, 20 Nov 2026 22:05:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 417359C1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33ABC40176
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RDxzWtzw88hq for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:05:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6D39440208
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UQLlRPBV
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D39440208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:16 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4ad881b6517so1126223fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795212316; x=1795817116;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lSodj/r8GNeNsOos0dd+KHdH/76NEhQGYov/DqcmJBo=;
 b=UQLlRPBVK8KwvGJlpAbhSHpm2WQqyePWSgnJrq6p4uEihVeMxvs81i07VwyuN4yqO7
 T30/JsVq50BBeZYV7HxSmv2nv2hZbcU3MGNaZzzpIp3BmRGlV0uKq58b1V0jxGtMJLka
 S0FPEY4QkRikIuXQV3ZoC0+nCdX9uwsew8Wkj3vs1xqtuWmQ7ZT0g3kSa5thV/QNLz60
 X6HZroD8zoIUWlHbliFIWJvMty72S2K0YkEEQxeIQ790H5bJR1aRzNHLYatQgKBop8Ei
 RNxuKraeOUzrxfigJuq6J/1kwAdEnLh1KSUu4x7pQsG1/xgjPZAMEz+twHM8Ywn0/+F7
 46yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212316; x=1795817116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lSodj/r8GNeNsOos0dd+KHdH/76NEhQGYov/DqcmJBo=;
 b=GRA+9tUxp/nSbbXSDMr3osYMs0dgR3J1cdx8rRHHZKYqtUX29lf/RhuqH65WZ11xdG
 rZVdl399O7BVbXpKTcM6ajAYGNGBNqPR6PV9QW8lQs7EnvA8AOokiZBZgxkRcY9IgPJR
 zZRgqXUsRnNyy7SB2eETJ4n7LFzA0OJLRjUHnPziWRDjWgKiqO90HEAkzFMD2Z9f8JKX
 /2K93TYgXoIUcgYbTpNOoM6DdCV0S2MvRqYlq+uZwOOk9U0aICziLisYd7bunmLWsk4z
 ATYGD/Mxnz41m5p0OWcnWOVXofOgZlc7ThEGpPsA3drnMGmxkm0If9s1QHoujDEWU6GZ
 /xrQ==
X-Gm-Message-State: APuU4Z+xHizh9V+a88eZp1MM54dSjjyssARX4YFcv9+j9CYSX2T323W1
 uAYeXKEvnQXe7qm3QiZBg08IfFNolXoljC1ZNdSM7xrwBX5o0vJ6yE56J+z4ga4nErE=
X-Gm-Gg: AZFdTZcIEZQOuV9UJ3o8yZBtf0cks5YXkEhHmwQ2gAa26QuuPQwKmPExaZTERsGPMBK
 D+6hiwWFi86X1LTeg7Qdq6dGoqe+7FV2M4YM1KArw1fLhVhZWRa4wmAHyhOSl/4wbQBXAYlVbM/
 BkBqNUVqMXgNygFo63NTxDwX5UnDkvbsT7uALh2qyAZooFq6eqn3lPLz2bPEZPXSm2uZ0Z7Eu/5
 +DBMIbx7u/nZLXXPeUBCTPoYVRobaIGdUOnVLLcBMfAiTgWGY7IygJLg1fyUNBp94DZNXRWdnH6
 xmk0Mp7yY8R604PqNXYpvirszSwYFvfPpbC9bg93CDgDSvOLfbp1QGRDN+v0328Et8g43liLF6g
 0zgkopkYb963Av/xjG9OZalYoouEtQe8M3kWx7h5an2MCLbrJw8C6T9HTe0veNq5CBVQtxTFxTl
 DojuEFFU3czksmr1/uBx9vnU4vmuNOyt5jktvquQovg1FezGBQCBXt5p18tQpeCgs5s3aeQE3t/
 r9KkIP0LkEJCqavJtd2NC9OdHphJg7wSWftrPQL3ktOWjk0j4DOYW4tm2hK9830w4hhQAHgqyzi
 gyTS71xViztfoFn3qu/rm5Pt2aio68W2
X-Received: by 2002:a05:6871:ca01:b0:448:9d5b:6393 with SMTP id
 586e51a60fabf-4bd09a77fd4mr3383552fac.14.1795212315547; 
 Fri, 20 Nov 2026 14:05:15 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3878346fac.12.2026.11.20.14.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:05:15 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 16:03:44 -0600
Subject: [PATCH v2 03/10] binman: support building binman dtb when
 OF_UPSTREAM is enabled
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-binman-dtb-v2-3-4fa1894b7e2f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1746; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=MSfClqAwuEVUnTM+wVYUOHxIAj3/fyvlP4hMnelzXSY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMPcdvgkZjCTYk5OlcazetsDG55KlM5CwIC7l
 wvjyR1U+T6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDD3BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ah/sH/jOvQhTnaUxKe8+xmTUEEX3QEF8N3hNmPhTepTu
 OqH/zpeqAd9OTIcBteSDTkMHna9JpsbI8Fkwhe3Tve+d/LvntOyrDsdJjjb/1cznsycsQR369MR
 rbC2Z8aat6GSmGtIv85oundcLdNzZYNFmeTtJS5/Q4//fcilCz88z/XIOI8UxmoLTwPEq8hAFCQ
 VgOFoxyPDlXXWNtr6iWIADfFAOA21ZDnD9jJot3ZjAyZLVJNwkPqbtEOkImJ2N+rjPtXG/gCRlX
 v+AUBl2mMmmWknoGW/0MQ/T2UqrlvA+F4aNLJgLuvSbvkRF7qmSA6H1fCHHbUscpIHQehoFMMLx
 mTD0=
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

From: Casey Connolly <casey.connolly@linaro.org>

Since binman DTB files are not upstream they are kept in the U-Boot dts
dirs, this means they will not be built when building with OF_UPSTREAM
enabled. Resolve this by adding a rule to build the binman DTB if both
conditions are met.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
[dlechner: only depend on the binman devicetree target with OF_UPSTREAM,
 since the rule only exists then; strip a leading ./ from the path]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 dts/Makefile | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/dts/Makefile b/dts/Makefile
index befc6de1805..c85a333df9c 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -30,6 +30,17 @@ else
 local_dtbos :=
 endif
 
+# With OF_UPSTREAM, arch/$(ARCH)/dts is not built, so build the binman
+# devicetree from there explicitly.
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+binman_dtb := $(patsubst ./%,%,$(subst ",,$(CONFIG_BINMAN_DTB)))
+endif
+ifneq ($(binman_dtb),)
+binman_dtb_target := binman-dtb
+else
+binman_dtb_target :=
+endif
+
 ifneq ($(EXT_DTB),)
 DTB := $(EXT_DTB)
 else
@@ -50,7 +61,7 @@ endif
 
 targets += dt.dtb
 
-$(DTB): arch-dtbs $(local_dtbos)
+$(DTB): arch-dtbs $(local_dtbos) $(binman_dtb_target)
 	$(Q)test -e $@ || (						\
 	echo >&2;							\
 	echo >&2 "Device Tree Source ($@) is not correctly specified.";	\
@@ -69,6 +80,12 @@ local-dtbos:
 	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbos
 endif
 
+ifneq ($(binman_dtb),)
+PHONY += binman-dtb
+binman-dtb:
+	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts $(binman_dtb)
+endif
+
 ifeq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
 # support "out-of-tree" build for dtb-spl

-- 
2.53.0

