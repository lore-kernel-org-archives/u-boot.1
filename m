Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41FA606A327
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CeXztIVJ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=soSnA12s
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C014E40729;
	Mon, 23 Nov 2026 19:38:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R2sob0FChAuA; Mon, 23 Nov 2026 19:38:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E40D940721
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795462689;
	b=QDGAqdrpYy8BQ32vhgE8JJw2zz+yNka9CC1p+nSU6Y8QTwTTHzZCzeWRo5QZdRIur9X3
	 7V06az/x7YXNzngy66MNXnp8q271aZwmGINn/rI4z68A6yEIPKThUwcFT94EAuL059yBz
	 IBloDb/gRbXtcrdjREVYSwsnRvB9AtUAWqBzzcC2sKbpU4eBaxV913fS0cmASqLTVwBhs
	 Df/zyRjrwov56k4WjquLoOcVHKsJnerMkpnqMyy92ALUYvKZxcwG3rplP4acoaG0SIfg2
	 eneZwH8fJ4qjfWEoc15TWkaDFcL4AySbcjVFLSWVQvpJXIx0E8NzMQ/MsoWriE1ozvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qCJuvzEsO1nUz0pmfOAiFRh5QbJoUusXq0qxderkdBE=;
	b=myasya6v/RndA8dbYcRrtbEK/4aWstLnn6u3I0lmuFdFb7TtSX/fSr948/ymzpl2TvRr
	 D57QaJVvf7M6pHJxzb6txZVIQWIH2JHMVOpb6HtOofRl7HXb6q0ZNjqeaCfjMTXBPn4sH
	 lRTp6QuQlBRmdU82uo8AnjawpOU7dEQKp+IetotZ//wVBLcZS1axQ3L9bhzebRWOKBAvi
	 DLCdxgI7rwUx/uL8wdtSRSC7J44EV/xzNKvlph+1Q/oyx4C91yJMy499E+/N5bKBXQtBH
	 07LIrciZYj5O2EonK+86HOC9VrNSB9H2vRoGYE4DtW9CX5XEWKeF1jxyRqpwIq/zygQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795462689;
	bh=qCJuvzEsO1nUz0pmfOAiFRh5QbJoUusXq0qxderkdBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CeXztIVJYNsHQYJPgxhlLfNZkSaOcKGccJFBOs+wjsz4Sa9Q1LJD+rc1zi9y+ly19
	 tqDZRCj+1IAqfZA6uODdyhMZsZMiHPvlHTeazide0B+k+GCyoJw/OTYMWmdOSSxrn1
	 qSVlrby8nzMk5ECFacHSm49lmGSYliSoQCU2RJYYKHhPTXFJTI3RbbF7G1O0mIR13g
	 /CNe5f/3pnInwLN5owChNR38ratLeEbSwP8GsbSuRT2+T6i0VzWHoQM/HhW9dh5eN8
	 e26+LUazBWleLKZxeT+FKT/yLWTvsajA+nKumzHXlgJ3t+Sw/Ept86sqBP/XKg0Jp+
	 I/7xhJ98ZAS5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E40D940721;
	Mon, 23 Nov 2026 19:38:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D37F422B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C544780E7D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:38:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UDjaSRysxO0i for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 19:38:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28A5C80E4D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=soSnA12s
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28A5C80E4D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:38:06 +0000 (UTC)
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-386bd881d39so487684eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795462686; x=1796067486;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qCJuvzEsO1nUz0pmfOAiFRh5QbJoUusXq0qxderkdBE=;
 b=soSnA12sEdEwzjZB2jfaL2hLtrvkqmDwoUL7U/fVN4OuHMZxjLmhSBwPcWGBce/feJ
 aB3TMUBhuJPK8dtgW/irQhZK9EY2tb8scpDEcnfZzVVDoN/VFfkZTZBKWNgy9gaTa155
 +c94ezFjjsYT5aFUocIcJTws0OOfX6llOowPo9ymboicUSn/T4dmNxE2VewCxx01kz1c
 tv9BhbwAl0t9llkKTNL93NkgdCcrxVf6qvm737uEAoE3IsdzYk7hpzmwdo/0CsSkvxNH
 CedLkf23jBBRumbRtY280VXC0GqXoySySglIZVx9H5MetQLNHVtmhcXk6NVr95GZngNY
 FdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795462686; x=1796067486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qCJuvzEsO1nUz0pmfOAiFRh5QbJoUusXq0qxderkdBE=;
 b=R6etGcZfJ7oxq0UCuqYevB9evOLyIsoRXo5J6hfAsIkMtJ2Mq8M2qJbs+/xFUuk9X8
 QiPHNJdXmYNQEoaPaCYwCUqLcYnl+KbMWQL/bujQw+bcJ++AoLvcZVunFnWNImM+m++U
 ooyyDPzKZWWwwnjnUpO0TfbjqwDi7zHwP/zfw/Z//PR7QHqDMWzpXpv9fdIihtkaxflc
 3+QrcqmXxbwrVp4l50j1MRxao5rW8HU2L18GbG4K/CqxsM1pBt9bXd3QpHi8QTi+9YhP
 Z0m8RaIorR9rAEw4sOb4dHQGlyCMrfUx6Du7TzTy9cvYCbe5GXm15B+mlrjPv45RivYv
 xpSA==
X-Gm-Message-State: APuU4Z/TTPncmEzoD+X1p/lUJAejOpnQVnvjeO2unF3jbpcv1VzyLWJZ
 K+J6thiuC8zTlCzVE308PSZp/Dk6Np0sZRUn5evxD6NjMlh23lqMfYFxvSGHmQ==
X-Gm-Gg: AZFdTZfiPdt/IUXYMcYpwA64xCSeNlBwek7UNQfYHBur2xOPIZFwNtMzGQL+xwYllNL
 K4eRgorl2et1D+WHiyOIjNhPu/jHouhzgi65ETbxyURUCYhgkhG7J8TbVF9G9q0HsLTV8ttYygJ
 5xzurBAbziHTuo+anRuySCWB220MIEuioXstz/VeICTLEQpK57PEEXRGx4ocmUspfmnFJnPrmfT
 wLAC9fM0OVaTTVxITDG4UMc1czN6uYERYM7TELh+ann41I2cO/+91ZB5UF/2LEZRJSbfaB9qZTw
 aRMtxLQZhaDWKXbKdL7w6p8P2vO11jdIeebQZwI1fpvrtXepi7qSXy8YnaMQDxHKopeP3RnTofU
 He7FEZ6qMuQtVGj5y5VW5W4L9DTtq/Eh25MeC0tMJ53CEbh7mwhszdNoKmSCr/flYAaQxW+Z1uU
 ODw6ldehECd9SOMiqssw+4WdCi5XTp1MuZQsXHc5M1uD4crR4RvToD4j3aPoP/LGUPU6bUvbPHm
 h5PoLCIyeEUR0BY42G2mgEnLkWCVcv3VBJCpW0W+vU7DmNCI5W6lUgiTodZW9NKcrGWcUcUSPa3
 wguNpWI67HGSiq4yhBbOhJWC2KNj
X-Received: by 2002:a05:7301:4710:b0:378:314:4042 with SMTP id
 5a478bee46e88-385702587c5mr12182929eec.14.1795462685985; 
 Mon, 23 Nov 2026 11:38:05 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c0c1dsm41796268eec.21.2026.11.23.11.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:38:05 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH v2 6/6] riscv: spacemit: k1: Enable GPIO and pinctrl support
 in SPL
Date: Mon, 23 Nov 2026 19:37:04 +0000
Message-ID: <20261123193714.5096-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123193714.5096-1-linux.amoon@gmail.com>
References: <20261123193714.5096-1-linux.amoon@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable GPIO and pinctrl support in SPL for the SpacemiT K1 SoC.

Select the SPL driver model GPIO framework and the SpacemiT GPIO
driver, along with the pinctrl framework and K1 pinctrl driver.

These drivers allow SPL to configure pin multiplexing and access
GPIOs required by early boot peripherals, including I2C, MMC and
other board-specific devices.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/spacemit_k1_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 0f6e9284259..6c60ca789a9 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -121,3 +121,8 @@ CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_ONBOARD_HUB=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_SPACEMIT_GPIO=y
+CONFIG_SPL_PINCTRL_SPACEMIT_K1=y
-- 
2.56.1

