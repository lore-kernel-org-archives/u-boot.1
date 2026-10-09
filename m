Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21702CA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CD0D608D1;
	Fri,  9 Oct 2026 16:16:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YV4MNHlJ8NEo; Fri,  9 Oct 2026 16:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34DFF608DB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562559;
	b=adlJMbUEKCY4JptMPaqm76gO5OxYvEuT9bG6CTMvHEhigxnt6GJYUOfIqTyGeB1UxKZr
	 /sL4oLvZfQf8o7uWxK6/YrRh75N6r82QHiCq5mre2gGKEJz1jPeXz+0F0JdV4efjh4fZf
	 ikjezg5nVzZ0FU6MPBlUpj13Yp4vXH7XfTeRFndPXy03RMuu/Y0sfgvjx0DnGaQIZ00V0
	 k0hfaplsfcGQHqo1aaiRXexqcfEdR1Px7KwEyhkwE0r5Dqu9FW4LTkG7wLpfqxfbkSjE3
	 HxGvMxojck1f8nc56HaoDDDFsqNZvpnf9k4z4FeRJQgZYCdsILaBwu/jFbdB+NucngQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LsFYVM/SYYX+sqG2ON1WgJqL6WjLk3VVUC7Ji7ORSQA=;
	b=b8jCJkZjOqebcDkxaCxb/UFaoESZn/j8NxHWK1aVtBXX8LWgyQ730IXrtBSW58iI4yeZ
	 Bob+94knpOpqwk4PlVSefku1T/Bj35Ay+yptDs/hsyFw+4WScm1//9w1bXAvlUCxwcfQI
	 phwNv543PWMdF78ppR8rp/3yCgP3H6r5WXxhW7hnXXmAcIm7ShMUwxQbg4WclEpLWo6At
	 RU/ez8H26fy3KSjG2/PHalbsevr9M13RUYsIVCAeJQqMDDgPTHtdZ+tsxhCUG13eH7+rU
	 qjAOjx7EBw29zU0Lt9IAW0PQ2fipvk3c64hj7yBhag13Kp4Zxgn9YdF1Ma2ATB6vFCg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562559;
	bh=LsFYVM/SYYX+sqG2ON1WgJqL6WjLk3VVUC7Ji7ORSQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IApjb0bop1uVzwCfNglqBSsbHdbPibAMezXCGIr6PNfASuKpKhoW+VR2czx13Lm4U
	 aOJd4ZN6qoue7KoHpLGRDB7aWRhc6fSYE6Dve1Z4fucTZRBxrb0Id3hZKi4rUDgBL3
	 9h4WvCYAZu7jJK4RcyiKG+4wP56a/uSCnNOfYXr9ft8urYxMG9kj6nPC/4PbxXQjB6
	 OeA1EK9KEgH4jQvhVPNLbEMUOl+YcmeLdq1HCTyYVnwmsk46eU3Ll64FM473OlsNVA
	 RPu7l9vo6As75PzOpEi9Idk4NyWF0WJwwDIQBo8lBvKsk1KJDjlxtZ3Quo5/Je7jf0
	 gXQM/Uw6H6JPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34DFF608DB;
	Fri,  9 Oct 2026 16:15:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CD97184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EBC281416
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hyU8Mi0q5sND for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:15:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C94A81412
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562556;
 b=cMVUCZjWWTQLqV+mbYxBgQOc5uazGp9ipmKzpQYKn3DxGuwrU1MtDIxMoG+YiLtqp7Vp
 +/HNASJHmar43edCM5Pksxri1gi9WCWk5sa161sg+q+dm/c2rQ3Wrya/7i2KAyMCJYIUN
 XY8R84uuOUK/I4Wvnf2sOrjlpJXhF0AFbC8yvnby6sv0bQo69rr0gq0mdA+LoEsNy8qQ4
 rZzVlyP9MxLakZ2WeXK0mpVzTMhMYayOTIMC1vxVK8DoEPG3GB0lYwQxBihU3dRvObmv8
 FsYBQZ8FxzFlZkifo9V6Qb2Q9o2ytK87k5Mol9DxskA98bgnwiMgKMp1EmOVb1rNlmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562556;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=LsFYVM/SYYX+sqG2ON1WgJqL6WjLk3VVUC7Ji7ORSQA=;
 b=LJhFrnfWMvvYdA39oiQhpW0PwIH3NJ4Siiky/NWgf1L2WspmjyEXKtvPT3QN3iNK9n0K
 n45+glCrhSduUry5iSaNhfGroP3092fFd0PHHf6wp97RucXAjay9Hifv96eSpY1jRMqf1
 fSR08MKQJJWIkB8Vazs9mZK+lhh3OMbjpg4vpxo2Wn9Q4CJrYFBAUK2uoGo09FlsSrBM3
 /+8Rqt4iGxYFHf47UHjNwEwC2IMVwADfUH9iRJEz2/RYf87cWe855NcCE1t9UZn+U3ykx
 SyD4o+ocGACm4haRBzlmgqfh3BWAYpjpdPhJWeAXgLPVUYFe49bmTM5mDqdrCu39g9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="IcqG8Ff/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IcqG8Ff/
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C94A81412
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:55 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-825b40f8a26so2091636a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562555; x=1792167355;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LsFYVM/SYYX+sqG2ON1WgJqL6WjLk3VVUC7Ji7ORSQA=;
 b=IcqG8Ff/BauKLSYRwHO+krUJQX2gSlFT5t1QanoZrMVR1ezJ7QgVZN+W7UqbnSBxBF
 mVUWue71OKZBzsNXc7XT28q/Lu58CqfS/gZQrDHUKrheEmzor+lL7AVpmB5ulh1SqwsM
 6duIaO1hty55UBft8s/IoZceLHR/if7j5+j4CRonT2YG9yVy01NhAfmFRnDSCyKIsuep
 qTgfJuHch4I+oA6ZpAG8sAqAqN1z+jXhXNpA5Py+b8HVjAYHP2TfdjXIgGpWLSpOZ7QH
 2SwmIFr9m4FVJYtjS5932xYM+oBqOuhOEkMl5NeqAPyXstfI5TgsXkARgFFUR0eRbnRs
 6gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562555; x=1792167355;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LsFYVM/SYYX+sqG2ON1WgJqL6WjLk3VVUC7Ji7ORSQA=;
 b=y43EyyAnh8wuhHWRp9PPOXvnd49fzQgIJOVIGIfjb4PK3vgKCQI7/LQOx7yyh9ppv2
 yz0/u60Cs82zFUiUpzPxPV8A//CgbefVNMfBqh/NQxjtF1sfGOSQC/6bUBW8lXJPBJ0l
 /FJFJd/IGhWiccierlQBBk8dMAOY7sJ2eDXo8HJ/TF1AFZwODcZ49ZV1YnG1gNBJPwbN
 BEyxvZmPHeTraBNE4OjHu8x3plZVyIIR1VDnEHYVhzqq2u0xpbZxdw/GW8SLOGfDTw+5
 2sebSUCzyhStlLXjWc7Bjie1YkY71TIh/5OX3AgPCFIG9ronsoEXOOq+fw1K0QpkC7yM
 jJeQ==
X-Gm-Message-State: AFuF++kYSjHiiJ+PzBMCuIFNc5Sdnx4XP66fU3Mk0js7VAi/ZkF0DxqW
 aLXvokZiLFPa+JSFRTmerTSVAemdSbcfA8iYgOskrqUuRAZ9zYqCsw7cfjHybeR7sCY=
X-Gm-Gg: AYBFou31r1gMuzWIWYD5/7CWc8QC4zFi6oVPkCQWpbUmRD2TYYtqHjkHndXPmpq9kwG
 QS24F/qr+rMysCFsUhZPI2ux+GdtSlKa+OxgnS+QnMOgUD5i0QpFujs5bNhRiz4b3yB9YbzdnKC
 WTj4wZZvweeGeaOhpgRttEfXVO24Q6zJOEhI4hV7bNuO95e2vcEUZ4tuz+MxRbpoCIUaLevzS4L
 0cGbm9oTr2QccsjeXfrYP8kZfMoMHfJEpvi1331vx4UN+14OSW/ore9jVCMc246ufLdJl4L9cZH
 fzEFmCU6dHkmzWFJaX8QQPA/5R3irYY6Y5DLVAJeeposCgXj9DHwYKerQy/r+7vHrC/d+80yOxn
 NqQacTYn7kfaEGrVVoTfsUZNR3OjtDQ+bNuPPlyexHmrIQr1QkRy3/lisToIaEKSlPtM4mERVgg
 KPifPORjgh8I1+wljHAQJeEoX9P+Mk+VlXzmZ8OgNRjTJBOFYsBYQfqM5RJAXPD96OPzjsoNpGF
 lM=
X-Received: by 2002:a05:6808:30aa:b0:4ab:318c:6b38 with SMTP id
 5614622812f47-50c435bb696mr1930806b6e.1.1791562554891; 
 Fri, 09 Oct 2026 09:15:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:15:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:06 -0500
Subject: [PATCH 03/13] phy: add the DisplayPort PHY configuration options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-3-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2793; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=kZKQkvKBBpZQp1c+cfGDFaKefPcCd1hbGqHTef/TRMY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRLkZCQwo4xwkGX5hveHTyDqVWOCNhwHf0bJL
 ZBOM+lqrXSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskS5BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AkCoH/3susIbJDsB4vUoaJJ3J/F3JwIr4pJiHiqA1ZBP
 QQWi4kfB3hiTm0Ht/LXD8vMdGYRxaMvBbczgLZwq6XqW26UtdMH25qGZsn/u2DoaVRS8hUaNl7s
 s/vGXQZBawvyjOSXLLBQ2R4ke1E5m0jMYHw0Weo1XC5FF/9UVb7t5wC4fVzW4qXNrhcod2p79kt
 qLcvtY7W83VfQgJvUHqp+p7gQYP4kmxRqYsSjPowenJaEmAQ93iMwLGSvUKUPbe5UtW2rorPjg4
 I6Xp6hT8LNdRt0ndJndi6JmD1BezbAu/Lm9wkWWxQNKMcgbn7/hsEai0b9e98lZsIjs1s+NJtac
 KVrI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add struct phy_configure_opts_dp, the parameters a DisplayPort
transmitter passes to generic_phy_configure() to set the link rate,
the lane count, the per lane voltage swing and pre-emphasis, and spread
spectrum clocking on its PHY.

It is copied from Linux's include/linux/phy/phy-dp.h, as
include/phy-mipi-dphy.h was for MIPI D-PHYs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/phy-dp.h | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/include/phy-dp.h b/include/phy-dp.h
new file mode 100644
index 00000000000..80692610c4f
--- /dev/null
+++ b/include/phy-dp.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2019 Cadence Design Systems Inc.
+ */
+
+#ifndef __PHY_DP_H_
+#define __PHY_DP_H_
+
+#include <linux/types.h>
+
+#define PHY_SUBMODE_DP	0
+#define PHY_SUBMODE_EDP	1
+
+/**
+ * struct phy_configure_opts_dp - DisplayPort PHY configuration set
+ *
+ * This structure is used to represent the configuration state of a
+ * DisplayPort phy.
+ */
+struct phy_configure_opts_dp {
+	/**
+	 * @link_rate:
+	 *
+	 * Link Rate, in Mb/s, of the main link.
+	 *
+	 * Allowed values: 1620, 2160, 2430, 2700, 3240, 4320, 5400, 8100 Mb/s
+	 */
+	unsigned int link_rate;
+
+	/**
+	 * @lanes:
+	 *
+	 * Number of active, consecutive, data lanes, starting from
+	 * lane 0, used for the transmissions on main link.
+	 *
+	 * Allowed values: 1, 2, 4
+	 */
+	unsigned int lanes;
+
+	/**
+	 * @voltage:
+	 *
+	 * Voltage swing levels, as specified by DisplayPort specification,
+	 * to be used by particular lanes. One value per lane.
+	 * voltage[0] is for lane 0, voltage[1] is for lane 1, etc.
+	 *
+	 * Maximum value: 3
+	 */
+	unsigned int voltage[4];
+
+	/**
+	 * @pre:
+	 *
+	 * Pre-emphasis levels, as specified by DisplayPort specification, to be
+	 * used by particular lanes. One value per lane.
+	 *
+	 * Maximum value: 3
+	 */
+	unsigned int pre[4];
+
+	/**
+	 * @ssc:
+	 *
+	 * Flag indicating, whether or not to enable spread-spectrum clocking.
+	 *
+	 */
+	u8 ssc : 1;
+
+	/**
+	 * @set_rate:
+	 *
+	 * Flag indicating, whether or not reconfigure link rate and SSC to
+	 * requested values.
+	 *
+	 */
+	u8 set_rate : 1;
+
+	/**
+	 * @set_lanes:
+	 *
+	 * Flag indicating, whether or not reconfigure lane count to
+	 * requested value.
+	 *
+	 */
+	u8 set_lanes : 1;
+
+	/**
+	 * @set_voltages:
+	 *
+	 * Flag indicating, whether or not reconfigure voltage swing
+	 * and pre-emphasis to requested values. Only lanes specified
+	 * by "lanes" parameter will be affected.
+	 *
+	 */
+	u8 set_voltages : 1;
+};
+
+#endif /* __PHY_DP_H_ */

-- 
2.53.0

