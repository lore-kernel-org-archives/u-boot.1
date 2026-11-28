Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9D606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jUEyAbL1;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=oucy7ygp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CBE48121F;
	Sat, 28 Nov 2026 13:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id odftjXCh48VC; Sat, 28 Nov 2026 13:12:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D003681233
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871553;
	b=PCcp6tjzjOrYM7BqLMq5mVxA3ABJld3vQmTgiMv1g5/Mq2/QPuLYBfzIEioLIltPaSAJ
	 gD6/glszePCLOTBajfLafGW8thhYrk+lk/ZCCn8YlGybKyH3oa1KFCvF4VGN1gTb+wt5Z
	 TX3tK0rL+xtIISZJBDvGf/g8G69mRRp/JMNg8O2K1fOuz2SVoasbnDn3/S02VJpycEGGC
	 GEO36LawDdsukPjgZPK7f2jcqUqUn3tFvPcyU3ip0qUBoluzbp7dP94shMviGdW+5k/H/
	 l9vdjzsDOT4cZhSwtKSFxZ+1NZm5ekcBp8KK/IfI6j/l3dbg8DA4v0dKDRnGbi99BNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=G9cTcYwv4zHCOEhQjgDZeqKFKEdpOiv1pEQvzTZzytw=;
	b=QoEtQYbLor5x7C+064uKZQHPogzb3Lk8oBKtw9AUadRWrNEaIIRqriT+sQvUD8Wc12SI
	 /v0QvaVnBUQbiERXNEjhxH7NG+ml8EJt0O7iCDHTleJMXehykKUjgrM8Gnuzoi493fM/F
	 +MJlVB1k6TC5ubgw3pASdjPMj5Gm1P/uuSrpb74vDT3g7dq/vfRSd1niOtSKV8NnhI5mb
	 6+t9iVPCZytwXE3zHniUgqlYbI7cZLV2Nimhjg7EpaGawW/VJPPmRfkS8ExCQS/2ZAzz8
	 A1gvrYDcBlfu+SiXNBnwy4WoMkSuIttiq/fPDy/OR32feN8FfeUhW50dt/906EhKm4w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871553;
	bh=G9cTcYwv4zHCOEhQjgDZeqKFKEdpOiv1pEQvzTZzytw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jUEyAbL1XGqzVjwSWY78FF1jp9/cRnrAKKIyhWGbG2oIt6h4qxVVjEqVqWy/9dpH1
	 sQr00eTunekfse3Tc4LNsfb2FOzmU9nTeU8OF69ltl0o4xYqXX5gFIVqKC31/dp7tg
	 O0Pya2JF6vwdLs2P3Zx16ik9C0MVTw8T9b6VjcZSZ4ZzynlJkaQIb/uePzrPIPRQtG
	 6ASu46QTokaNLRCYlgpP/AMCPLmgXxBBZl5oGcr42341PsZ/aH/6vwC7o6/zsf6mnA
	 bd8fxo/T2x5V0mrnNU/5GShpsuAx1ruHMNMkwDdaahwnDwKFsk8G6hgOotLsmv+yGK
	 yT6B8ooC7pOpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D003681233;
	Sat, 28 Nov 2026 13:12:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E9A026D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63FA340645
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 80Ea7mGAqr04 for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8020840659
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=oucy7ygp
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8020840659
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:11 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so7876195f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871529; x=1796476329;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G9cTcYwv4zHCOEhQjgDZeqKFKEdpOiv1pEQvzTZzytw=;
 b=oucy7ygp8xNxR1pgpb8o22Bhqr3NKlw1EqI6CabZzcVH5SNOlklqm8o7Jvp0s6oPpE
 EgoZTZp+NvxVS6NmyaFiF6LdnYpx108dVuK9c20PIbzcET+qJRtxDWco4qeDVj+loTfI
 bOEEYscTeIRXSz09TV+TUbYSImZfczunwhmXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871529; x=1796476329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G9cTcYwv4zHCOEhQjgDZeqKFKEdpOiv1pEQvzTZzytw=;
 b=W7lZxfNeUEjggFyC2J0YY8+kYuitklba/HlGeHmb4blCvvNeVhvI6k92pNdaKg9pdz
 i+ZnpvFYUWguNHgcPjGIUpdOjCWp4vFXFut3EK7Vtbq/E3m6sWUkZ2AgltpmPnUugDdi
 yb86xSMQhu2SOqjSyEGM6KdzCyB/sLVJIj+j5PgONVOD14IKCl4TI7jE8BVVbqt6Hs/s
 OVpre5/6+D+FcUWhCv8Iih89L1m78U/hYT0HG0mwEUX10Tn4uV4ATHb9pjDsdpGILmfj
 uPv1B9/UIl1f5N+hVfTz7C+c/lkf9tuVTxTIiX7PqMYA7keHCw9Yhd7GSHq+fJvvlYfi
 ppZg==
X-Forwarded-Encrypted: i=1;
 AL+hErE/khi6W8t71pWTw7bzAHdoBK/1ipWz/viNDVcqw/bSdwCYoqW+AhaDLbDmTEW4xz4efRnvt2k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Cm/Wv9ybqrKWjOtbORd5IWwH78SkgkgdW6oh7dhETvrWvmzRk
 iSrqEykDiHDApYQCOQL8rB0L4ax/Ix4Bsg+dpGLNIKsvxnMQ3Ac2gxfaWcXn9VrrXUc=
X-Gm-Gg: AZFdTZekWegTF6j/GJ12Q0e2gojjH7duq4UHq2dOGMnxM77xqCqP6rRqYjmhp1amqma
 umz9ftCShYzGJk71QA58VO5y81jkS241ozgFoh8wdGrvBNnmYLCPlW01iXPq8R4yMn/UlXSm9yf
 HqI9U6Dn5Djrtatp7WiP8MxV4wm8nXpD4Qy4/3irN2noyDXHVRhGc6eBIHmdfMqi4kJLhpd8RZX
 4YmS/zYQhpvt2DRDqKoMeUnQIuO8zIcXNvLvkiAK1X48wYpjQrCklaSxdXSqART2avr2tni4zbJ
 J86VsCuQEVLFLd5aO+bh20y7W5XUuxSeLf7qmr6kWdI2GfSTRNDTOqc+BU+YKh1l+UTGzNBWUrf
 OTFcTPcJg8W1l7ya3Ra3ApX0E9nKQFxt9C1XSxJARYVhPxfRkA/uEkyLivBiTwSJanvOIxTa2PM
 IRJBtoNXWVCVyA005+VHWoKkr9NNLw0+UVaEiVnHb8/yG0aLi8vZ2XnMeMNJ/Sf0g9baPPCcIgc
 AnMhMKlH1mAxO0fxUBNRdj+lcpst7yzgqgl0jqMr+ZnOUEjYfVpyUHKewMftU/MoxIuhL6nTMxW
 az1ejefyU0bFCP6EKBNd4cSzP7BtSDcDhQaD1MPjkmckW+Xky6FRQ3fXxM5wrQmwRgkxv8OHdXS
 FOjAcUpsTUkSgtBuS0T5l01Dar0LbF0RVE/B2rcabFSewx/d1wa8Fx1HN/ezLyLDwtRlVIIsOM0
 hOKSJ7pZXkOpx/jmel0aLr3GvfJQ==
X-Received: by 2002:a05:600c:1da9:b0:4b1:2026:6b41 with SMTP id
 5b1f17b1804b1-4bb88819294mr577222115e9.30.1795871529273; 
 Sat, 28 Nov 2026 05:12:09 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:12:08 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 25/29] dts: support applying DT overlays to the control DT
 with OF_UPSTREAM
Date: Sat, 28 Nov 2026 14:10:42 +0100
Message-ID: <20261128131125.2141352-26-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Extend to OF_UPSTREAM the support for building the control DT by
applying DT overlays to a base DT, so far available for the DTs in
arch/$(ARCH)/dts only. The upstream DT overlays to apply are listed in
CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Tom Rini <trini@konsulko.com>

---

Changes in v3:
- Add Reviewed-by tag

Changes in v2:
- New patch

 dts/Kconfig          | 10 ++++++++++
 dts/Makefile         |  2 ++
 scripts/Makefile.dts |  7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/dts/Kconfig b/dts/Kconfig
index a2973ef40860..f8cc3b26b10f 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -137,6 +137,16 @@ config OF_UPSTREAM_VENDOR
 	help
 	  Select the vendor to build all devicetree files for.
 
+config OF_UPSTREAM_CONTROL_DT_OVERLAYS
+	string "List of upstream device tree overlays to apply for DT control"
+	depends on OF_UPSTREAM
+	help
+	  This option specifies a list of device tree overlays to apply at
+	  build time to the device tree used for DT control, so that the
+	  board can select at run-time the hardware they describe. This is
+	  a list of device tree overlays (without the .dtbo suffix)
+	  separated by <space>.
+
 config OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS
 	bool "Build local DTBOs as fallback for DTBOs missing upstream"
 	default n
diff --git a/dts/Makefile b/dts/Makefile
index befc6de18056..3fee5a0515c0 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -32,6 +32,8 @@ endif
 
 ifneq ($(EXT_DTB),)
 DTB := $(EXT_DTB)
+else ifneq ($(subst ",,$(CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS)),)
+DTB := $(dt_dir)/$(DEVICE_TREE)-overlays.dtb
 else
 DTB := $(dt_dir)/$(DEVICE_TREE).dtb
 endif
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 3871a4ad4123..5067f6ea2daf 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -16,6 +16,13 @@ dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
 
 endif
 
+ifneq ($(subst ",,$(CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS)),)
+control-dt := $(if $(DEVICE_TREE),$(DEVICE_TREE),$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE)))
+$(control-dt)-overlays-dtbs := $(control-dt).dtb \
+	$(patsubst %,%.dtbo,$(subst ",,$(CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS)))
+dtb-y += $(control-dt)-overlays.dtb
+endif
+
 ifneq ($(CONFIG_SYS_DTC_PAD_BYTES),0)
 DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
 endif
-- 
2.43.0

