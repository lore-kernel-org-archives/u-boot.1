Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7065606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jZ5W6Sgk;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=k7hulJ29
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F8E281777;
	Thu, 12 Nov 2026 21:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3BmbpSXNWaa; Thu, 12 Nov 2026 21:16:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D8E081769
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794518196;
	b=tWQZ8GixkZreNYdn7zgTKU+ubVmVca5iQKwg/wkWHAyHwV5WjbhO99uDq8/r+M5U5cp8
	 g9TZGhve04jy0/K/m7CfyJ6kKhZLjRRjVnfdS4cAcqiSYkTpvpxwYCxn3M+OzdKnq3npc
	 5GzikcqmE++uoChnuGJW/MgYeyRAZOUtgcRHkAP9OnyWZyhBHE+uv36dMoVPT7XVd3WVV
	 NQBMTemD9VfK6clryBFzCrmvxXgO747hmSKKGoN3EwwuhFGOajGpl95VqjPSMycHEKgJd
	 KmQyQi99RoIZr7dMlHdi96+zBLhYSM7C5nDicvI1iDD9+9LuhGd68Fd24j/jB4JPCZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518196;
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
	b=WB4FL4E3NWwJwa3aJPzIisr90mCIGouoaT+8eSTaShRNrJxrlajQBjT9N85n1OXNpGHc
	 xhn34fOkzbazDn9KfjqwTYbOXI+e+B8gxu+Y3hn+ouFTCroNFYssj+fxPcIKGu1aoe7t3
	 M8wMjPPBPoM45m9XuLyr7X3SO0JgLFO9ZDweK+qBsAOgdS2Q0rzl5YvGmJ0GZpvGGykyl
	 /Zmfv9V8y0CCmB7jAGWQpEElBC9TSDJs7Tq6CH5H9AhzxKcbLAF3r0oivknbZ9WoQOMvK
	 CmAhlsPJcouruJRGbRBbuY/x4ytSiYGBoRfe+dzCsCoQLqscDwqYF2LDEZurjs91PMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794518196;
	bh=lSodj/r8GNeNsOos0dd+KHdH/76NEhQGYov/DqcmJBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jZ5W6SgkrcA93ECGjUuqnDmNoIQ/vtCPPaE/kEF6fb7gNWdT/BIMXx9r2osNfDW4K
	 Fc6r/pTDYXu1udU/ftLtfE5YNTtKj2eiqd3Ha8CEAq5tFfAJeNI+kLm+u2Ah2TOGyC
	 XYZU9fR1mRXIK3z6ZA+sEL/kgpThv3ZtERfH3G16aS7EmvfrRM87iBuEF60Ia4EbnQ
	 aYyBMUTZACZ57ReZ5GYUScyrBSbcTlvq3s9hdTnB+1yU/fVwI3OmV2udu0jS21JNNh
	 jx4TYpXi1x0bGkqAtuDbnn/jvXkbTmHXfYLDAHM4TNhcUSjZKEctIyJAoDqfStBHPs
	 vWi01pe3PKEFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D8E081769;
	Thu, 12 Nov 2026 21:16:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 96F7B1790
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88DE14099F
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z-loyXiHut1E for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:16:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B658E40974
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=k7hulJ29
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B658E40974
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:32 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4b28d9537bcso283534b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794518191; x=1795122991;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lSodj/r8GNeNsOos0dd+KHdH/76NEhQGYov/DqcmJBo=;
 b=k7hulJ29itE9SghWoY6oO1mj0sMgnSZfe+KP6ICm/oaKthfcWIdwirE6RhdluYfCjB
 kOGzO2IMS4hK6Ri+IBvJJGzgQQDgzsW32yU2dpC8RcOlhIHvsbdf5o3WKZxe2JvBMkIR
 svOaZ/Igpn3Wn7JzBd0/7wu/LAjjX5EsVeipKUQqmwfXGBZ40Nqa9y7F6xEOr6mrIHY+
 JFufgKHwbHxOpl+1rRva6IM51G5DMiDQqJCNv86b4AJfPF6FVJfKiHfr5m11EYzR04es
 psZCCFwNUpWOiwSY0QOwCOYTdkqH7Qgw4Xu0WBLkpMb185DaRFHjGpHzdJeXE1s0ty9J
 98SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518191; x=1795122991;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lSodj/r8GNeNsOos0dd+KHdH/76NEhQGYov/DqcmJBo=;
 b=yDfK3f4W4h1OX9UxnHkwLMBZxImvYdTRPS6CSePU5+uLuZI6BdMIQMx6kQ7YwNpOuA
 VX7rDCGY6tSm6IfWWagVBMMyfcTXFF8tzhKgircy+bx+Xs7OuYwYq7jLWAVpk/fu28ml
 3nJR3Z4BOUrDbBbESa8PmI2ki+xMiklHX3BACBq/lwJ18fWi5Kjwd2bO1etYnYiLWmiX
 94mIonh4sp2jrjys58cKqyLKIGoTD1NiIFUmDO8nw4pvnVmbFqhuzzmhimPG53GfUefQ
 tQFtQ6LFQlmywDm1CTtyu6wwdrax2lTpgFm2xZiu/2WuD1Sr0pzoEye1yPdnaWlmM5Ds
 yoXg==
X-Gm-Message-State: APuU4Z/lp1NY3wlgsc9C0N3sI6+mxf7oKxHtugevSPukQRNFVnYFQS/m
 vD5UUoH9pr7ZjfV4mYmNejifHlspFJNwnLpaKaHfZ4DNHvCZaHmLldMF+vvPlmX98eU=
X-Gm-Gg: AYBFou0UzsWwN1y9/pNm8yPOhaxPR6R6rgoRRysjJMiLgNoyKV0bKYTejHCbbi6OZjn
 uZv6JInp2xGnjkOEk0T5B3yWmoP7+icCoxP2Aq5NB7GMMJWTT72b642rfWRiwFmt3wmgG4+rgyc
 2+n06FQCu3gdIsd0T/wxTj0TtQEo6L7Fv3pw8qCMxnroGbgNo1jWA7Gsi76ZT5U9JTBMUHh3TtY
 jHwatJl52HVlblPviOxYTLT3Av55IzBOCdMn+xI3SzNALGY3LfkwL0rvawHf4DWR0w+Kq7728q6
 OsmDMTfZcTx2ekrSrBcyD7JvaxZDbVxQM79w8NWweHjmUCFCwL1718QSGD4MgNKYHDIUKwc4tNJ
 seZF984Sp8DiEELMq6EC/YIybMQIoFDH+obfl4i4YIpHeRf38vSr4c/sHggqTWw63kux5AsUlGq
 WJI+IlCmh4rVk0pYS6TG5OdFVYjD5RoTCBDpU82GxPQ9KoYI5yG4KvsdUiDSCn9ywMJijasUNeD
 +yuFgMk6R9MBefPvImmE26E5oXC5aA+gFv5PeD3bAvYHdLmYn5UlN/m0GfC19a9EwwyvRAN2ToR
 lWqT8A06J8cdvaQs102sFRcT1QWypmwH/A==
X-Received: by 2002:a05:6808:6614:b0:568:2782:d1b4 with SMTP id
 5614622812f47-56e66272a59mr275339b6e.32.1794518191236; 
 Thu, 12 Nov 2026 13:16:31 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1a61:46bf:438b:5fc0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm263804b6e.15.2026.11.12.13.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:16:29 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Nov 2026 15:14:58 -0600
Subject: [PATCH 03/10] binman: support building binman dtb when OF_UPSTREAM
 is enabled
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mtk-genio-binman-dtb-v1-3-65cfc9329c50@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq9ixwhyTOHhqrw1cRbgd/EK+eD9VPNbJYW30U/
 yJ0WZCUoM2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavYscBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AfgUIAJ0HChxy0RvPK+UdGITQJxr0QFrgNVs8+SKqUi8
 CATvuvez4YzROxMyQI+96sKkg7+i6d3dyeOL5rlmE8p4GUR8nPIaS1leOZn7N31l7wd1bxfsZAE
 LeA66jXb3gsb8GF0ONGzYZ8kGIqPfsRNKulZV+ugh9c3tpf1mW40WD0yZNtM/3IimZJngJ8u6v5
 +lVgSoi/1ogUxw8LnHul1aaR+VStMChaHWl99qzM9s4gV0PVd/kFxlp+jVJ+YT3gMb+nrnp5r9p
 ivxOGGsQ+aH/pg3inkt48wbpvuFuweE2ZbXqhv2H2W/zlWAWWKMQCi2cYTI8EkZ5L0pnbRF/IEm
 /fLU=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

