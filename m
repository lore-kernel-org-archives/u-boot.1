Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16976606A337
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k8DWogxG;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CsFbUeIb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E207281686;
	Fri, 20 Nov 2026 22:05:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fsTGjp4PT9Kf; Fri, 20 Nov 2026 22:05:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF1338165F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212315;
	b=kLYAyGcCnt15UaJYKXNpbsyPcZQZ53fyFEPGDNwJXUrSoZLvxtfbQ611Amz7XwoJfkMi
	 b3piuG2DcZ2R90H3MPd76ZXcU4xFkeexndvonvSpo65yVLM5N/jwMhyk2rlDi6yjE+eri
	 pIqYRdEzHRGWowDq64cfarmr1cx6L0ZQYPzlhKZ+rpGYtrFzDSt0EZbkBZ1ZXZG2sPeMf
	 fnEdYcp2AubSa0DZprtnqk6rBuNkfww4NLkDFeDZ0XZkmMablHWOV8JMUCqTu1oDNJj1r
	 HM/fGbSvE3Fpk/iedpX7tYOERwbqSoOeCc16vr1JJenN+3p05iMuLRE4zBSRdNSSbRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212315;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nlrrb9rlV0WremtL0+gxn7JBzkLk7TU8VMhw0aGLlwY=;
	b=VZwNuYSE0jG6/jRMHmlO6ePn7n81pia2W6SBWvdthp/qsQepadkXqHJUDM5fgO5fG2Xc
	 oBOpQ2SW8SUFzRpXw6PnNIgh0jpmdeqM4H12e9ukz5QrhiAybONg1Q2Zw5Ub56iuRu+jU
	 ncPBX7LVVRjjhEpdHTmDw7QkQ0J5gTS1RQYJHy/5ED+b8e6S2/B50tfPEIXg4BC/vzDK/
	 0UKC+8bhSXiv78tp8MZpZeRscCEmw+NVtpFj8z8ioSMD7cyW5jQ7LviPhCeMNJbuzciUF
	 hdgL8YO07+MKn9ZAa1LuHIBj7V0wEa5wx2+gzyhlqHLvb6HQ8gGb8mBQKxEejCp3BIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212315;
	bh=nlrrb9rlV0WremtL0+gxn7JBzkLk7TU8VMhw0aGLlwY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k8DWogxG1ISmkVXkUIthJ8M3qO2l3QRI7EeKOf4kHH9P5Zi2KHfQ6l+paan79X12a
	 66oXymFY/rvfnaSmizhpeUZ/QcclRLCT1Vmo4hitPzvRmWG4nZzPdd8ZYs8vj20fZH
	 CNY5jomlNYVaE9naQBpl2jrvwilbbr825HIJP2vBA9BuGZn2cvS7mEELMQRuDYKbxc
	 1c9wwOSuLsBpjYirmhdMnC8H2spnTvLNyeHGDIXUw+ok3C2rNhESmPHvRKPWT+2RBz
	 848M6Yag512O2PEY8lzGEAn+UmsJgSqYhMx6BneIA8mmu0Y1BLRlXczmM9vqpqzkt3
	 q1tTTn8+UAQFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF1338165F;
	Fri, 20 Nov 2026 22:05:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B75B8310
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92E0B4076D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVZMAZ6KCpqP for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:05:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7688D4076C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CsFbUeIb
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7688D4076C
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:10 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-8631e07b756so536918a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795212309; x=1795817109;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nlrrb9rlV0WremtL0+gxn7JBzkLk7TU8VMhw0aGLlwY=;
 b=CsFbUeIbhAkpevAglWzHoaZZFpBp8jXUv8l/NX3dpu+R9SWmf13G/ha+rHAuxMbe/H
 oZRlm+x7OjTk9Au5EVp/1PIsHC/n9OjY6s1zfvGpdEp3Ilwo3yaPgTEGNWQJRSghykYb
 FyUVFwzAUhHHUilmr4Hn/ng5NJhkYH3Laerk1BtxoXZAlond0VhYu6jMqKu8nFEOFrKb
 5wxGKOyPU7AIUmXliZLsdcQwPcIMsqSqj/5uOi0FTZyVhI3VALbOLSht9MoixAx0xyl7
 +kUDqTbwVcirInw7nYb0lBZqcgMgL90XrJwLqoS2DotNpPecJWX8QZWuAiLJasWRbvxT
 rgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212309; x=1795817109;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nlrrb9rlV0WremtL0+gxn7JBzkLk7TU8VMhw0aGLlwY=;
 b=nWdqfnLIi46IUHV/VOuNJZoGSVhcGD+ASdJFxPEcwxjYZS4JkNaKJtTUiDv+ZlpNor
 Hn9djgDE81Z1fsFmtqFQbQZuVNzjX+tTua/JVMebZMIFQomvKfIg95jOqZolpVuq8dzX
 4VsbCntI5/1BcMi2QkQNWGCeG44/2PMM+pJiDoyzyr1HTh04MrWVcUoYdlz8+DQzobDi
 HYdEW/tPjNtVSH34DARSG+eSyPpTKJJP/tG5ib78VDv1bR2XlRp3gpzwQNacxWnA8YLa
 mDsy3iizepf6S9P3Ro617NDJp9Ps8vJJ8lkerrXB0M4uwhL+1HQS58B8rcCS7iOp8G1g
 Up3Q==
X-Gm-Message-State: APuU4Z/sDooL+pQC2ZuC2rEQcFxGaWwjfF5fEdnfbqlPRC7U3f9Pn2fN
 YHfoGaBOBZX2thAnpQk5vxUE5iAXm63e5qrI5wo+eXun5DoQeLDtSj+O8J9dS1UeDos=
X-Gm-Gg: AYBFou3DLUDBQJSVc4jULb1WbHDbBF8gf6UJCwK8dzmXTUJHAY3xUYQiDPihYIsbiNt
 Zg6dFgghBzooTMfN14fvY/8UeAZbbZQH0pUjqKREkVxredDLu7waYjIWsPHYovzbHbv6ZOFrZRt
 vCdPyvTXWcjcpzSdVzqjkfwSDRBX3ZwyNaZa83r/7w4N7+wxAjCQVhC0rFviOY2kIHhtE2wvisT
 YHOZYUD2f8VHjHpWTkF8/fAx0Iu5B+0D05h0ufuesfjYOwbcwaSQ+IbJtldmMWU+k0r/FHOSHwa
 ZDt78CDlZ0SWBxHfMr62ckG5RABQnAsmI45XVaZfSVmQLQA98+q9YY76pvuj4QNVk/lrdZNl/wD
 bilvyHG7j8+8tkI+rIefQ5JH8ZUJzwkmX7BP2L3KN60WC3/PnZJu1zkVuSw2RFTrgb94aHbHgsR
 Da8M8WnzICDEwwemy1Q3voQX+mNk71+Leq90jsop+F9hbvuPzJ/vqAT/SBZqhvFaSD+wY90VhBR
 GfspdO/d2C51oh7aSlVi7RwWrbUF9VbkXvMuTNF5EoHEl4vgsE55zVXYyn/N1ZgLXvYhDwepEKV
 JCUfOIIHhgZ/AQ5YzLOd2G9rELRibSII
X-Received: by 2002:a05:6808:1511:b0:572:6ee:8b6b with SMTP id
 5614622812f47-57a0c9c6599mr4831385b6e.66.1795212309262; 
 Fri, 20 Nov 2026 14:05:09 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3878346fac.12.2026.11.20.14.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:05:07 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 00/10] binman: support separate binman devicetree from
 control devicetree
Date: Fri, 20 Nov 2026 16:03:41 -0600
Message-Id: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4VS22rcMBD9lcXPnaCRZNkypeQ/QijSeLRx68vGk
 k1C2H+v7F1Cy27oi2CQzmWOzkcRee44Fs3ho5h57WI3jXmQ3w4FvbjxyNC1eS6kkAZRGBjSbzj
 y2E3gu3FwI7TJAwnPxqJlS22RoaeZQ/e20z49X+a4+F9MaeO6vpj5dcl66fKsGDhGt+s1h+8XO
 TRA5LIjhuUU08xugHjqIbiY/DQl2I9VgYDKK8uVU7om8+jde9/5mR9oGn5sarfcQspb7iHVygp
 oHaxl5ixrW8vAiArlLednPDmtSzgafD/5vosJUja5BQCa81X2ZS2ZZsX7QLVv9Qk+uRhh5mMEh
 UpQqEwtEZtV3kMLVH/9SSXFzoVGCo2GjJT6P8C8NNYWUnAQ2gRWy1oprMiQaFb1RXpoN5mfS4i
 w6hyVQa1kK7wsa3qcYnx4XVyfkxq+jOu+741QOzIuVHXLlbh69y4ybHRdag4ttrokK40rKwzeE
 LJpKxQlyVpk70bnKpbsiq15LznQaX7f+53j34p27Za8X+UVt3VKCmSVtFSKf36+eD6fz38ADJV
 lEDUDAAA=
X-Change-ID: 20261106-mtk-genio-binman-dtb-c0be6919e9cd
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=32148;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=Ngqrt/l22ogk5owN/NQ5iQXDBwc5CYqYWsILpUaqvC8=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMPJXZAdbEy7DnLDj6BqCA7buee2QGR6ak+75
 d0k+uTMpEGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDDyRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AujoIAIjzYOau22j+EsNVQseQhG0LM0enwp/d5iBYFU8
 2+VjyxM8VQIaW4pmQNT/IFTpjDE4/tutOL7XbqWP/UJRbxmG0OdLrMm/B+VBorQAOLdB+N1nSlL
 D9+jbTgn2MbhCU4MnnCQbLCfA1QY61bDZB4ceS96k6yD5uxS6St2ZkCNO3DfH/KII3LEG/gK5im
 fmsQtevbQ0tBgprbv91KnGtcQmUy1DgEqT3rXOsswKNtL8pBZCwM3jbnYLsCP9JTJQ8e+Wf2DTG
 NZcjTVOPGS1h2KPpsUnA6htr4Bu5He1Tb5r9fkaH8q7tCpOPvVX8UN388BU1nVY06KWs65ygrg7
 ogTA=
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Anyone who has worked on hardware that uses a devicetree for the
hardware description should know the mantra "the devicetree describes
the hardware, not the configuration".

Binman is describing configuration and not the hardware itself,
therefore it doesn't belong in the control devicetree that describes
the hardware. So we propose encouraging the separation of these two
descriptions into separate devicetree files. In most cases, binman
info is not needed at runtime anyway, so combining it with the control
devicetree is unnecessary, takes up space, and causes DTS validation
to fail because binman is not part of any standard devicetree schema.

Currently, only Xilinx is doing this kind of separation. This series
makes it possible for more platforms to adopt this separation. The first
patches fix binman so that the image gets the U-Boot control devicetree
rather than the binman one when the two are separate binaries. And they
make BINMAN_DTB work with OF_UPSTREAM, and document the recommendation.
The remaining patches update the MediaTek Genio targets to make use of
all of this.

The binman patches do not depend on the MediaTek ones, so they can be
applied on their own.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- binman: fix "binman replace" on an image built with a separate
  control devicetree, and add a test for it (Carlo)
- Rebase on v2 of "mediatek: mt8189: add UFS boot for Genio 520 and 720
  SPL"
- Link to v1: https://patch.msgid.link/20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com

---
Casey Connolly (1):
      binman: support building binman dtb when OF_UPSTREAM is enabled

David Lechner (9):
      binman: allow a control devicetree separate from the image description
      Makefile: give binman the control devicetree with BINMAN_DTB
      dts: always build the binman devicetree from BINMAN_DTB
      lib: Kconfig: do not enable BINMAN_FDT by default with BINMAN_DTB
      binman: recommend a separate devicetree for the image description
      arm: dts: mediatek: drop the -u-boot suffix from the Genio binman files
      arm: mediatek: describe the Genio images in a separate binman devicetree
      board: mediatek: add a Genio boot images config fragment
      doc: board: mediatek: use the Genio boot images config fragment

 .gitignore                                         |  1 +
 Makefile                                           | 16 +++--
 arch/arm/dts/mt8188-genio-binman.dts               | 15 ++++
 arch/arm/dts/mt8189-genio-binman.dts               | 13 ++++
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      | 10 ---
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi           |  6 --
 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi      |  9 ---
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      | 10 ---
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi      |  9 ---
 arch/arm/dts/mtk-genio-binman-u-boot.dtsi          | 12 ----
 arch/arm/dts/mtk-genio-binman.dtsi                 | 26 +++++++
 ...boot.dtsi => mtk-genio-bootloaders-binman.dtsi} |  2 +
 ...binman-u-boot.dtsi => mtk-genio-da-binman.dtsi} |  2 +-
 ...an-u-boot.dtsi => mtk-genio-da-fit-binman.dtsi} |  2 +
 ...-boot.dtsi => mtk-genio-loader-spl-binman.dtsi} |  2 +
 ...-u-boot.dtsi => mtk-genio-mtk-boot-binman.dtsi} |  3 +-
 arch/arm/mach-mediatek/Kconfig                     |  5 ++
 board/mediatek/MAINTAINERS                         |  7 +-
 board/mediatek/genio-boot-images.config            |  5 ++
 doc/board/mediatek/mt8188-genio-evk.rst            |  9 +--
 doc/board/mediatek/mt8189-genio-evk.rst            | 14 ++--
 dts/Makefile                                       | 20 +++++-
 lib/Kconfig                                        |  9 ++-
 tools/binman/binman.rst                            | 22 +++++-
 tools/binman/cmdline.py                            |  3 +
 tools/binman/control.py                            | 14 ++--
 tools/binman/etype/fdtmap.py                       |  3 +-
 tools/binman/ftest.py                              | 80 +++++++++++++++++++++-
 tools/binman/state.py                              | 50 +++++++++++---
 tools/binman/test/fdt/u_boot_dtb_separate.dts      | 13 ++++
 .../test/fdt/u_boot_dtb_separate_expanded.dts      | 13 ++++
 .../binman/test/fdt/u_boot_dtb_separate_fdtmap.dts | 15 ++++
 .../test/fdt/u_boot_dtb_separate_replace.dts       | 19 +++++
 33 files changed, 336 insertions(+), 103 deletions(-)
---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git next
change-id: 20261106-mtk-genio-binman-dtb-c0be6919e9cd
prerequisite-message-id: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
prerequisite-patch-id: 15e30b35b9a32d98cea92287c95973bb55655b8d
prerequisite-patch-id: 74b01d9723a9eebb7a438ae6f3aa84fecbd86a2f
prerequisite-patch-id: 84ffa226fd432b97e30508988d556056f19488d8
prerequisite-patch-id: 4cd55c11a0eca6c43f12359f8f79ca2462677c97
prerequisite-patch-id: 6d301cbbd2d389bb156e2f9565f02c7d1eb9fed1
prerequisite-patch-id: b7c90ab34aa03a40c1978c9cce52d88e101e4350
prerequisite-patch-id: 110fc69a696fa4dd74fb7e14a50c97e3b7238a9a
prerequisite-message-id: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
prerequisite-patch-id: 47bd1028b5d35a3cc00be6cfd2efa94a8fcbf521
prerequisite-patch-id: aceec0866b3329401896512d235b7e01dc1746b1
prerequisite-patch-id: 9f0be27b51978f99dd1d301f4e346e323f057407
prerequisite-patch-id: 94bec74d37c3b2d2b22ffc303d8f2ac567db22c4
prerequisite-change-id: 20261104-bloblist-tl-fixes-4e2617a399c6:v1
prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
prerequisite-change-id: 20261103-spl-bloblist-pass-regs-3130cf768211:v2
prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
prerequisite-change-id: 20261013-mtk-genio-720-spl-1620416c6224:v2
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
prerequisite-change-id: 20261013-mtk-mt8189-tfa-fdt-94283317c6c0:v3
prerequisite-patch-id: 79df99b8a797eed3bedbfcbafb7cda7e019f0445
prerequisite-patch-id: bc8ebcd6928771bcb436408a6c10ac4f00b2c265
prerequisite-patch-id: 0f5ccd0db365686315ced7255063d0404cdf5250
prerequisite-patch-id: a435fbd4cca84219d404138e2d8ee1a96d669366
prerequisite-patch-id: 4407c23f51001d4996a8e790270825fd8281d7f5
prerequisite-patch-id: 14bb13c537f635ee2589d626e0031e9a80c348d5
prerequisite-patch-id: 0b59a9f24e103a77700ca1cc99052ba318017b9d
prerequisite-patch-id: fc1dc7d141126db709479fb8477fe11536e6811c
prerequisite-patch-id: 2b22eb0b87c0c9e5c35e0b2719eedb3228503dbf
prerequisite-patch-id: 90108657775725ee881493b1af8e2ae51c8debc9
prerequisite-patch-id: ba3b4599b6ce497f7bf5bcafd2c93c89a0c7f5d4
prerequisite-patch-id: b47cebc4433bc3a0e5c3932a8cd64afea88d32a9
prerequisite-patch-id: a8a6f8e478b4888ff1c6affbcf14f1bb801f6cb9
prerequisite-patch-id: 537ec57f093f5cc68529116aabb6fec1296e9ed5
prerequisite-patch-id: bcd4644665e032714d68c49ad9afb36b25b9f418
prerequisite-patch-id: 1eda3254e8ba4f67886c788467d5cb3e706e51f7
prerequisite-patch-id: 0396e7309b235e7a577aa54549f260d6561d6cc5
prerequisite-patch-id: 3ff8b871bc763b373ac93eb095a0ac362f4fb4f9
prerequisite-patch-id: f3288ee3e395bff11655165a34c9617be55cc52a
prerequisite-patch-id: 893c19a121729050c2095888af67d5cee32c67d1
prerequisite-patch-id: 8c900b341eac7dd1b2f69a434b2fa808ac79e914
prerequisite-patch-id: 974eaa9cb6adf9749f6225fe1e67dd9433318625
prerequisite-patch-id: cdb2934ed5393e539f856e6f4de36140cd8ad697
prerequisite-patch-id: ab91736213909c77894d8e47594f548592f96bb4
prerequisite-patch-id: 15e30b35b9a32d98cea92287c95973bb55655b8d
prerequisite-patch-id: 74b01d9723a9eebb7a438ae6f3aa84fecbd86a2f
prerequisite-patch-id: 84ffa226fd432b97e30508988d556056f19488d8
prerequisite-patch-id: b6ef8f19bc0e45642fadc98a2a70a8a77e16cc31
prerequisite-patch-id: 6d301cbbd2d389bb156e2f9565f02c7d1eb9fed1
prerequisite-patch-id: 21aae4cff1307c55e73d737cd68552b6ea1b73f2
prerequisite-patch-id: 110fc69a696fa4dd74fb7e14a50c97e3b7238a9a
prerequisite-patch-id: 2ec906b416c75e44362332459fcd498872a22124
prerequisite-patch-id: aceec0866b3329401896512d235b7e01dc1746b1
prerequisite-patch-id: 41d8b9c212ca0950fb1ccbea92d8f62a3c42676a
prerequisite-patch-id: 94bec74d37c3b2d2b22ffc303d8f2ac567db22c4
prerequisite-patch-id: 4391fbbb5b04123f46d3eb3ec7b183be7152d338
prerequisite-patch-id: 08e009e1d4f6ef7fffaddeb82f9e35692bd593e4
prerequisite-patch-id: 14b40c9224527e76382332cf547d070f1d3a40ed
prerequisite-patch-id: eca0139a7cedf72a4e8a99324a846dea15392e4b
prerequisite-patch-id: cde323ef8d773b7dad5a278faaca89bb71405ab1
prerequisite-patch-id: 6abe9e3824531990933ada4bd58ff483637f3794
prerequisite-patch-id: 4344564d375dc6002077d382335ce759523ffa29
prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
prerequisite-patch-id: ef70f6dcf4e6aea68256028734614efc067c954d
prerequisite-patch-id: 7b0018d240640afe5884016e6fface46efcbc8b4
prerequisite-patch-id: 569f315372b1b8f55a5a94f1385175252dc33b9f
prerequisite-patch-id: 626521a0082e6a51722120a189d64c3cfdff6750
prerequisite-patch-id: f5f6fabf8e9a55c44413a76791d3713fe6415a33
prerequisite-patch-id: f031399df28961dad8315ffa6ad1ee0ff77116ec
prerequisite-patch-id: 93483198419cccb47c2f31e79b5e31d3e9c99a7e
prerequisite-patch-id: 800ed16084da22bb470b878714b22960475acd3b
prerequisite-message-id: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
prerequisite-patch-id: 8adf07351c5a4eb61976ceeced2d0ab0eadf235d
prerequisite-patch-id: 55ead548e0a7c82c4296cc9b9fa047f110c1e306
prerequisite-patch-id: 34bbdb130ae694420b954f41a536b8eb8df77791
prerequisite-patch-id: 5a62f8304a1790b31accf47af84815bffaa92b89
prerequisite-patch-id: d2e87bf5a992d19bde372fb230f4589242f12d40
prerequisite-patch-id: 0429aaac18b3a3d564662f2b93aa3af755c880db
prerequisite-patch-id: a577a9e2266f5b16dd0bf1b8b4312952f736380d
prerequisite-patch-id: 3223b00fa7e9c330054e19f256b4e601008160f2
prerequisite-patch-id: f1cf16250799f803bde22d6dae704cc5338ec76c
prerequisite-change-id: 20261013-mtk-genio-720-spl-ufs-4ac6af78de70:v2
prerequisite-patch-id: 79df99b8a797eed3bedbfcbafb7cda7e019f0445
prerequisite-patch-id: bc8ebcd6928771bcb436408a6c10ac4f00b2c265
prerequisite-patch-id: 0f5ccd0db365686315ced7255063d0404cdf5250
prerequisite-patch-id: a435fbd4cca84219d404138e2d8ee1a96d669366
prerequisite-patch-id: 4407c23f51001d4996a8e790270825fd8281d7f5
prerequisite-patch-id: 14bb13c537f635ee2589d626e0031e9a80c348d5
prerequisite-patch-id: 0b59a9f24e103a77700ca1cc99052ba318017b9d
prerequisite-patch-id: fc1dc7d141126db709479fb8477fe11536e6811c
prerequisite-patch-id: 2b22eb0b87c0c9e5c35e0b2719eedb3228503dbf
prerequisite-patch-id: 90108657775725ee881493b1af8e2ae51c8debc9
prerequisite-patch-id: ba3b4599b6ce497f7bf5bcafd2c93c89a0c7f5d4
prerequisite-patch-id: b47cebc4433bc3a0e5c3932a8cd64afea88d32a9
prerequisite-patch-id: a8a6f8e478b4888ff1c6affbcf14f1bb801f6cb9
prerequisite-patch-id: 537ec57f093f5cc68529116aabb6fec1296e9ed5
prerequisite-patch-id: bcd4644665e032714d68c49ad9afb36b25b9f418
prerequisite-patch-id: 1eda3254e8ba4f67886c788467d5cb3e706e51f7
prerequisite-patch-id: 0396e7309b235e7a577aa54549f260d6561d6cc5
prerequisite-patch-id: 3ff8b871bc763b373ac93eb095a0ac362f4fb4f9
prerequisite-patch-id: f3288ee3e395bff11655165a34c9617be55cc52a
prerequisite-patch-id: 893c19a121729050c2095888af67d5cee32c67d1
prerequisite-patch-id: 8c900b341eac7dd1b2f69a434b2fa808ac79e914
prerequisite-patch-id: 180113519aa422aef5b1d6384c8e65a943482cf5
prerequisite-patch-id: a5493d2e60617de14414c25c63d9f77f3fbc7ca9
prerequisite-patch-id: 3b798f71b18533fa36c3864daaf3b60099201097
prerequisite-patch-id: 731b2a85b293eb24b8a9ad5cbd4b2052591ec9d7
prerequisite-patch-id: f44798150ea9c5cf44a43ba0ee5561ed6d522063
prerequisite-patch-id: 01bd0fde93d212bbce964da6cc85f5aace84bddf
prerequisite-patch-id: c5662096f7f5cc7abfd5b178e145fe006737152d
prerequisite-patch-id: 74e53343d8fb0f2e7baee9848b7d81320910ed4a
prerequisite-patch-id: f018d9e03bd324a7853ab106eaaeb770f20bfb1a
prerequisite-patch-id: 95e0ae837a7ba3ca39b2a4b8421ac105234d677a
prerequisite-patch-id: 88e610436d6e9630fac7212c08251727fbe27fc3
prerequisite-patch-id: 0949dcf268f48d1fb7ee912fc57188b73fd4ae58
prerequisite-patch-id: 1474c68c12a790dc0abe513ffa5f71c5d72934eb
prerequisite-patch-id: fdc92399e83ba67d6f157e7e9fec546624226db6
prerequisite-patch-id: bb0f680620dd60fe1f55507198c1daba04d51ca0
prerequisite-patch-id: b60ed43a099f02bf9743f90a7cf474ca844d71d2
prerequisite-patch-id: f18d63e4e8c0ca8f08573f2395dd58b698e1da27
prerequisite-patch-id: ce11ab44a0332ef9682d3f6cb34a5f8648a1c619
prerequisite-patch-id: 3c5e447deebe943a6b8a98c2d017d1c0eab5da25
prerequisite-patch-id: dc6c98cdbffe9b3f19b8a0fc303f9b2902defa07
prerequisite-patch-id: 558d3536869699311008e4d6cce6a2a18a727eca
prerequisite-patch-id: 805a0898b88d8e1291e8262044d1d6bed1d45be2
prerequisite-patch-id: 8d7155ea7c0941b756129b6a490f9413b51b05ef
prerequisite-patch-id: 2e2af65eace7eed81fae9e1b092b951909d40cf4
prerequisite-patch-id: d23b6c65e336be85f9db407bbddebaa810181b41
prerequisite-patch-id: 876842cb87caf5549b143cb46b406b835e727eb4
prerequisite-patch-id: dfd917a8eda1c93eba73ebb180e2db12adfb0e15
prerequisite-patch-id: 05bae350cd48b1e93f4bb07b9e8759cda4d6c095
prerequisite-patch-id: bea71fa6ac38132f016f06062ebb725b56033993
prerequisite-patch-id: 603e5d5ab1e686bf88f7d3fdbedf5a51f78556fa
prerequisite-patch-id: 809e69050ec3ba5858c2861a45fca2999d7681ac
prerequisite-patch-id: 4fcfbe2b8d6c2cf5757ed30010fcd0fd25b2f07c
prerequisite-patch-id: 39fef29dd41c485e23e93de4af82138e25c21701
prerequisite-patch-id: 505256a47487b37ecea03a102d4617b43e962473
prerequisite-patch-id: 4d64774e86552280f1b0f47edca96edf97360d7e
prerequisite-patch-id: ee697c692feaf987cf826b4829ba953abb45ae9b
prerequisite-patch-id: 5b6d52b9c4294753ba3f8b0898b8df769c68ce6f
prerequisite-patch-id: 4ea635de9af26f9c4e0a26c667189a32adc818e7
prerequisite-patch-id: c7bc4b558252d4db0043bf3abb3ec6410983a1e9
prerequisite-patch-id: c77edea93a6f266654d9a1979d1bf8c6cda9f8a9
prerequisite-patch-id: 919b022467a24916e9723e6bb44a61b8d3033cd6
prerequisite-patch-id: 6d5ee57c18d631d517611686c584231132aa6f23
prerequisite-patch-id: 8a5fbf37a516fd7dc8ab0c59cac315ebebe3fc99
prerequisite-patch-id: 45e54230c5cb1cc02627cf2f3b2a577b84c7d42c
prerequisite-patch-id: 4398704757cdce9c2b70659f9ed41034069aa02b
prerequisite-patch-id: d5d2582327962cab72f81a632dabce89cdc67391
prerequisite-patch-id: c62492e276af6518e38d7d9c4a704917086faa6b
prerequisite-patch-id: 822172b99aaadcce25fd2bca6e9a184c8f8f66e4
prerequisite-patch-id: d5e6fc93179f40fa3e29af07d2ffb6e39f89faec
prerequisite-patch-id: f9df17fceb66159ad4accc4f8a3e0f7dd274ab46
prerequisite-patch-id: bbbd8043f933f2732fbe42398889cbc7e0cf4dda
prerequisite-patch-id: 41190287a89e9b07b94cfe3193c01899adfae173
prerequisite-patch-id: 26ca48e502e41f881ca8c513e341f22a72670c91
prerequisite-patch-id: 6cba52dcdc8accacc8ef3e8989bbde57042a1fff
prerequisite-patch-id: 1fc0e9f40bfc55b0a1fde4c7b05b023baf5fbe6f
prerequisite-patch-id: 622f4f4882701834ca39b59e540aa9aabe6ad4dd
prerequisite-patch-id: 55e5cd25c262a7cba950baff41e87d5753ac0317
prerequisite-patch-id: 00b560b784f434c9609db5f4e4617a24debca854
prerequisite-patch-id: 3be96ccc02c5eb9024ee784abcece741d1bf4ab2
prerequisite-patch-id: 0482a7683818a8fec47e6d86a06836401308f3e4
prerequisite-patch-id: e7a1f5882faf7f23a9b39d2e8f46fa167c9949da
prerequisite-patch-id: 46da428dcc2b2614216b06f0c406cb9ba5742a02
prerequisite-patch-id: 992d1283537f6c06f5f789ac7e2ffd5959ce0bcd
prerequisite-patch-id: fcf8ca56e3b3169ca1d15ef98a2ba7b86a500497
prerequisite-patch-id: c9b3df94501f1f6d360122de7760245b8c8cbed2
prerequisite-patch-id: 6b2a92a9f5d02390ec69faa1d15e0d4a2095dc4c
prerequisite-patch-id: 190361f49727995e2ce01c3dffe5cfe80ba8860e
prerequisite-patch-id: 46468089e10930b9184c684d99e0c64f350b68d7
prerequisite-patch-id: af62f5ceb1b871ad2ceaca7823c67b3e3de02071
prerequisite-patch-id: 892d729b6c7760ab4cbe3d91279156b89eee7119
prerequisite-patch-id: 09ce19f8cb2b645edffb281432d5a66aa04fcd66
prerequisite-patch-id: 30d4ddadb1af79c7085ab1bdc5ff6cd458819398
prerequisite-patch-id: 1ff0950016f89c2c85e67dd537bfab5f8c69c4a0
prerequisite-patch-id: dfae11d9defa56cef564b8738d2a804317e17964
prerequisite-patch-id: 0de8ab562c22ed1cea20c64417e84d8dfe76791e
prerequisite-patch-id: 8be521390f8c86e98fec8f7cec731b24baf85b85
prerequisite-patch-id: 238b0f3a5c3004d4e24f55ab207f59424d59a4c9
prerequisite-patch-id: 4491fa1d384a57496e7f7c1ae81eef3dcee3d1b6
prerequisite-patch-id: b4ce5ff140e7132ccd304d96c072b90e76896469
prerequisite-patch-id: 7d47232a35aee90c8db401b7439e71ca2d8c2361
prerequisite-patch-id: 6dbce6a4bb68d9cee9b2f3bb372c4c744686bca3
prerequisite-patch-id: 92417d59722bec13c37acd0abea6af250a9c1f16
prerequisite-patch-id: d5717747fc524a6040f24beca4c54393b5a44957
prerequisite-patch-id: 6a0f06f1a1ebf8ff15edd054a1501d15db6d485f
prerequisite-patch-id: 22f8cc1a49f9948142a0439cea4678eca6f09ce6
prerequisite-patch-id: 46b3ff84afc93f088dad014bee482e6bd4cdd82c
prerequisite-patch-id: 3df56af9f8137f3da1bf0636cb0c6924ea11702e
prerequisite-patch-id: ca023a03447aac0fe756bc4957793dfeae583331
prerequisite-patch-id: b6e491d31cc840b35f0a72af68d65b02e0b80fe3
prerequisite-patch-id: beeebc507adbfa6a9613caf91eaa8ee2819a2c22
prerequisite-patch-id: 26ceffe944a9625d9f11ef279842795a05987ea9
prerequisite-patch-id: 5bc3123be8a4995b4020cfc0178f277d5cc095a6
prerequisite-patch-id: dd7957b39c29b294753f3612c85a544c8384c192
prerequisite-patch-id: 169b43f254e60a8fe4400032a494892d737d27df
prerequisite-patch-id: 11c68890947f416465ffa120c1defea109125df6
prerequisite-patch-id: 0482a7683818a8fec47e6d86a06836401308f3e4
prerequisite-patch-id: 87ab2294998439179842acab9370cb8b67cacd40
prerequisite-patch-id: d49821c05f338173dee1e41121902204005c63a8
prerequisite-patch-id: 54aa06e9e4ad9d16e0d32efe7459e3b90a7058fc
prerequisite-patch-id: f3f59f374ca9974bb08ce598068b0825db8e497f
prerequisite-patch-id: 18a3d2b368524f4ee1bb6ae3ebb32a0d1e4861e5
prerequisite-patch-id: 47629a9b4cffc91b4a6c998a6e277ffdbcd52028
prerequisite-patch-id: d9392d6eab14eb16efdb2079a9b274182df534a1
prerequisite-patch-id: 329a01c16d5ab00df565e87a88620f07761358ca
prerequisite-patch-id: b4b3df66ff637e03b24de6aa5471e29b4802bc46
prerequisite-patch-id: b18560e708d6de31d4c8cae47d6929f77585b06b
prerequisite-patch-id: 6a8c72712e55e80d379cdd6bc8e2f753dde2d0b2
prerequisite-patch-id: ac3721e1d000848e796963b1c7e63d97702b3dd7
prerequisite-patch-id: 939a2d47705bfb5d776c6c300436c2cfea85590d
prerequisite-patch-id: 093a3ba613013680ef58b8e6925b82e33f7b87fd
prerequisite-patch-id: 52025f862cf1c1e81959c6fde5e2118a0737e57d
prerequisite-patch-id: ccf65df5363208cac534a59ea7206f58bcc31888
prerequisite-patch-id: 7c72becccd783eb6b35e50970b0b87c95017e610
prerequisite-patch-id: ad9ad791ad231404179cdfa578ed764845d62c7c
prerequisite-patch-id: 1d380e6f3bca0606ce71615ec881cecc34a45e3e
prerequisite-patch-id: 649dfd89cf6cfb9664c6820b2ae79dbb30e05fb1
prerequisite-patch-id: 8d4ba44db86526bc377e013d2cc028e40c8934d8
prerequisite-patch-id: 9a74e78f7c384318640df74b8ebc4fcddf86cf16
prerequisite-patch-id: b64d8d8045e20f059608ec0d63041fc2964d5db8
prerequisite-patch-id: 01e16e2802373f436af22e4df0d530028b7eb652
prerequisite-patch-id: 407b47ae56a829a3031b61538aa74ec973a7f098
prerequisite-patch-id: 6eaa28df70eabf2f5beee0eff1029308f47ea9a6
prerequisite-patch-id: ee86c5410d49002ddc2cb98c07b2e9c428a0b0ff
prerequisite-patch-id: 88cbf5e3baac5ce99f3ba0c633d90863377a70a9
prerequisite-patch-id: 070b1b21b826e0fae9c16bef00c7fca59876d871
prerequisite-patch-id: 0b51f71fcbfff0d3e6a7fec3c1492ff29e183ea0
prerequisite-patch-id: 985b7ff6787db0262554e58fa4cc94d003d72327
prerequisite-patch-id: 09c947cec38a4cb0a84d92af2d8eb4cc99f748d6
prerequisite-patch-id: 0053449ec714a230b6e1383975a06e3609fc8244
prerequisite-patch-id: d8675c7eb3250bccbda0f1e15b48c66706d3ba8c
prerequisite-patch-id: e42023e9d6bd6736b6a619cb2e89333b791542ed
prerequisite-patch-id: 1f404e3478a4f04b7e25e7a2a5ef0fe631dc9bbc
prerequisite-patch-id: 8b20f0828ca7c09cd8633b5ab68f1eeb4e2cc074
prerequisite-patch-id: ed9405dac2ef8d17e5b6cb86883f01b62fa7be30
prerequisite-patch-id: fb90789ad90c92d1c2911a1e194a5a4818daf898
prerequisite-patch-id: be26994b56c309a052187653b7fc972e0626b914
prerequisite-patch-id: 7e9b315969780c6d5fa402c00227f00c63d18bef
prerequisite-patch-id: 28303c3259e9341febcd15a91a5e01d519519593
prerequisite-patch-id: 34a8cb19bbb69d4e8b628ed85212ced3d6103ab1
prerequisite-patch-id: 3b753d6c955f5eb7d98453c69f956904efc2307b
prerequisite-patch-id: f538f852317bbe13a11c3fc7be19730ce45d0c71
prerequisite-patch-id: e4c15dd96fb5127e14853856b1590c0234483a01
prerequisite-patch-id: abcfa18114a8eb590de2ce2c2edfdf34c9d9e816
prerequisite-patch-id: 9e03620f71bb912b452a54e9711247358759af7e
prerequisite-patch-id: 063ffe8bf10383fed5af13180cdfa966f4c190cb
prerequisite-patch-id: bc5b6264356259b5bab58a8dc8bd39b2434a4134
prerequisite-patch-id: cc64b211732189ffd5b333e756b636500ecb5a33
prerequisite-patch-id: 86ce443a7c9989fdd165da56cb1c7f4c3ea4d625
prerequisite-patch-id: 3bca8244f0dee791e6776eb515426edaa8aae6e7
prerequisite-patch-id: 6ab5e4f2be197bd1711e00caef8307d29f14e7e3
prerequisite-patch-id: 1cd9c6b1fd931bf59a4f0b56e6366bf4233ee524
prerequisite-patch-id: 6abe9e3824531990933ada4bd58ff483637f3794
prerequisite-patch-id: 4344564d375dc6002077d382335ce759523ffa29
prerequisite-patch-id: eb190089eec77bcf33e4af575c054bc0c903edcc
prerequisite-patch-id: 504f2d272c05d352c895546bb6913892b2dedaaa
prerequisite-patch-id: 2ec906b416c75e44362332459fcd498872a22124
prerequisite-patch-id: aceec0866b3329401896512d235b7e01dc1746b1
prerequisite-patch-id: 41d8b9c212ca0950fb1ccbea92d8f62a3c42676a
prerequisite-patch-id: aba641ff2ea1ac6e9a3b9a39d2c08645c47d5f07
prerequisite-patch-id: fe0dabb7e52ac18361666c62dbcc19e5d7728ab5
prerequisite-patch-id: 6b2386dfd455af886c6a6792243326fe65113e9c
prerequisite-patch-id: 39b12b5169607481b0d8ac9d057243d5e1019519
prerequisite-patch-id: 1e9a483b9dbaa07ddad995001e82b5ed407adc06
prerequisite-patch-id: 10f493cd791ea98308b8b108f14f58941e7f60fb
prerequisite-patch-id: dababf3b5f129f82563cf04dd1c2dba4c3ef033c
prerequisite-patch-id: 68a4e370c33256066ab56c12ba48e6df3b177a6b
prerequisite-patch-id: 13b76b0d6687ef26c3248445970f01d22aca846f
prerequisite-patch-id: 755afbe9813e6495b2e137209270c9e089271dc2
prerequisite-patch-id: cac24f7351a55bcd75f83050eb2ab3c0ca02ed86
prerequisite-patch-id: ee63ccc8626983ca60ca2f36cc7157a29e54e46a
prerequisite-patch-id: 0632471d8eace2662c0b39f5c401f51e3c284036
prerequisite-patch-id: b8beac767f731a235e8f917d4026e3b94bfeb95d
prerequisite-patch-id: ee1daf2c0174ecb808c4baacd1eac08de506a20f
prerequisite-patch-id: aa0b5f0e29b584691ff28ce0b610a082708b2250
prerequisite-patch-id: f785c97000fd7221a25dc12a90abc7b57fbf5653
prerequisite-patch-id: 097089e930b96667114bebaaf1a097a4c8539357
prerequisite-patch-id: ca48c7dd41fcbb98c0c9381a90ddf4c817e62bc3
prerequisite-patch-id: e8ee659e8c3072b21912efb14c8c8312d6258ebd
prerequisite-patch-id: d14c5e971e39b4f768665c67e1294d884aac6e07
prerequisite-patch-id: fd50bef7aae51ebfc164d2e3a60373403ed07904
prerequisite-patch-id: def5ed3e8f5aa1bc872474f9ba597e495c5f71c3
prerequisite-patch-id: 17b4920bc9e6f45f8b71d7a601123ff06a2d6e31
prerequisite-patch-id: dc5853792e6059a58f16ad7da3a2825fb0760381
prerequisite-patch-id: e26cbd3370e6e50f32ea1056ef26209b8e4604b3
prerequisite-patch-id: 7d67192624b26fd56c9f9db97bf48808554466ab
prerequisite-patch-id: 2dee5dcd5c4b4cb84a973c12806f789d51e45be1
prerequisite-patch-id: fe902fd1b1d1e3758a647ad45b5a8ad1566b7531
prerequisite-patch-id: 6e53252c5630c1fa8e3ed10d748a98bcb2518a44
prerequisite-patch-id: 846098e3f6bc91b9860851afed55429f6b6da227
prerequisite-patch-id: ea9238c9215ccd4aa80b52b1f3117a2cf2bae0e2
prerequisite-patch-id: 9c748369d11e6cbd8bf8a3c173d6276b2c33bb83
prerequisite-patch-id: c37559957e0835a66a3e9a97172d06d215552a8d
prerequisite-patch-id: 1f16fa175eddd5bff8c6a516cb03b489ba8abfee
prerequisite-patch-id: eb3842f91ddb96feb1f672d393c4dfc713163584
prerequisite-patch-id: a2c1070067a9073277b591b113b2f681c222dc5f
prerequisite-patch-id: c12e8f921e8c18f978f945028373b7e7ce39688b
prerequisite-patch-id: 5a3b36d2d397c83612d8e2f13432f937b163f83a
prerequisite-patch-id: 230f1af574770c13a1f7ff7accd2352d01613f02
prerequisite-patch-id: c9188aff16204f73fb711707b2391ee11458c63a
prerequisite-patch-id: 2727f015907bc8f68e2a866c05c0dcb2613e97a2
prerequisite-patch-id: 4da429d9c6699a1520c561ee2e8d4fb37e95ee9a
prerequisite-patch-id: 0da00ccb63d8cd292fc2e68d3e3be4a71ecd5c07
prerequisite-patch-id: fc6cf3ef47b21e3fc03db2ee1f0d805515a61e05
prerequisite-patch-id: 02cadb05dfbdfef90471f3fa0778657679fa7739
prerequisite-patch-id: 2f876a06ca7bb48d0ad3b06c748a95a89e2b3dcb
prerequisite-patch-id: 69f03a94e2df1f30ca900200720221978b99753d
prerequisite-patch-id: 6a16feb6dc79b752a1c31a7a4de99b085e635f9e
prerequisite-patch-id: 13aade1876f4611e1db3f8d18ea024859517384d
prerequisite-patch-id: 5fba9b6f437b4114aca15469f93bb3fc9088a5fd
prerequisite-patch-id: 84be2a2665e3ec50da8d6049e69d679190fa0b7f
prerequisite-patch-id: 35b5df36b2bba22055e53540a015b6dcaeef4d7e
prerequisite-patch-id: da7660660f4ccd3fdd3148ac2901fff3f947828a
prerequisite-patch-id: 36d41fa4d867267b0cf8d1de92904888b24eedac
prerequisite-patch-id: dd05ac311e66ce2e58bee21495f7a8ec9deb09f8
prerequisite-patch-id: cb5fd30a379d6fec8a588fe559eee2a27c26655d
prerequisite-patch-id: 82ba708552f0ee3c1b66b15d7bcb8286a66717fa
prerequisite-patch-id: 18b63dd11c2197a7ab3c0b4cddf0f1d8e96bfeb0
prerequisite-patch-id: 732e72c7c54a02b77c2ddd9030c8f2e2382f09fd
prerequisite-patch-id: 4b0d0eeff122a29150349722242aa6535b59a4da
prerequisite-patch-id: fe4386d1c6466785bad33689b6b9a307e4397d15
prerequisite-patch-id: 7def038d7f0942c6428fdbb3e400d3aa3b488e76
prerequisite-patch-id: bea26a0377ef9b305799b030edc8644fe557f344
prerequisite-patch-id: 8c9776c4da0fe9c1dfb23c194b6e3f94e58b9920
prerequisite-patch-id: 9304832cc57c42357c667a2e92352e9ce3e950c4
prerequisite-patch-id: a7613dddb66d018b38f506e5e47ab18a2aa824b1
prerequisite-patch-id: 55c5dd7510d8fdce329edb9c4172dfe8b0bb5764
prerequisite-patch-id: 5c7198ef30d21db76142868d9bb091239044845e
prerequisite-patch-id: afdc2841a15d5da72be2b4d078383f3606ee79dc
prerequisite-patch-id: 4868eb4733870e9bd082b1cc8852cc5a9f2bbeb7
prerequisite-patch-id: 1e2bf04565211c02699a59f7754f7d4632ebcd41
prerequisite-patch-id: 2b72a893fe4485746d3160269f24d7fc7c24495e
prerequisite-patch-id: 087570f1e19425315326dab8302a266ef140639c
prerequisite-patch-id: 7b16ab685011186835598426b01f76e5c965af40
prerequisite-patch-id: b133a30e0323a75d2abb71d6622416bf8bcb4df9
prerequisite-patch-id: eb39c7e13b257329b3e76a64f72ee8a9c8149bfa
prerequisite-patch-id: e2a85de49dfbce587cec4161e3a8c2265f1360f0
prerequisite-patch-id: f51db13978f74c5ea4ee3231ea60fdf467b6de84
prerequisite-patch-id: 2676c75e64ddaab319f688374b3548fc4e88759b
prerequisite-patch-id: 4f494e98b8faa6a9ebda0ffb8f1ba29eb37af423
prerequisite-patch-id: fe2f56626cb0a6a746f932ee47b9b5ed92d1cb9d
prerequisite-patch-id: af46526d7fbb20b36566f9f1dc6960f4012cc1b2
prerequisite-patch-id: dd19f129f820cef17ab506a1ae9162bc054f7a6c
prerequisite-patch-id: 85075039343774f6e41a0fe5b42bc5b3fdb021b4
prerequisite-patch-id: a376c0624be88ae8d82ef0a39601f6651d32f9dc
prerequisite-patch-id: 3fbdb4010b2455cfd65b36741c24f329c242d4b6
prerequisite-patch-id: a4cd89f18cc2ac924b2c92d3b0d52890ccd17817
prerequisite-patch-id: 3c987219be87d554f0d0bc2e1e5aceaa9b2ebd8c
prerequisite-patch-id: 15e30b35b9a32d98cea92287c95973bb55655b8d
prerequisite-patch-id: 74b01d9723a9eebb7a438ae6f3aa84fecbd86a2f
prerequisite-patch-id: 84ffa226fd432b97e30508988d556056f19488d8
prerequisite-patch-id: 4cd55c11a0eca6c43f12359f8f79ca2462677c97
prerequisite-patch-id: 7edd1469f8b57165d0466178fb5d854d71d48d2c
prerequisite-patch-id: b7c90ab34aa03a40c1978c9cce52d88e101e4350
prerequisite-patch-id: 110fc69a696fa4dd74fb7e14a50c97e3b7238a9a
prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
prerequisite-patch-id: ef70f6dcf4e6aea68256028734614efc067c954d
prerequisite-patch-id: 7b0018d240640afe5884016e6fface46efcbc8b4
prerequisite-patch-id: 569f315372b1b8f55a5a94f1385175252dc33b9f
prerequisite-patch-id: 626521a0082e6a51722120a189d64c3cfdff6750
prerequisite-patch-id: f5f6fabf8e9a55c44413a76791d3713fe6415a33
prerequisite-patch-id: f031399df28961dad8315ffa6ad1ee0ff77116ec
prerequisite-patch-id: 93483198419cccb47c2f31e79b5e31d3e9c99a7e
prerequisite-patch-id: 800ed16084da22bb470b878714b22960475acd3b
prerequisite-patch-id: 6c44e76abdeb8319ce17dab256fb99ea6a5e77ea
prerequisite-patch-id: e2797515d1f51c260b7f991889e91f7b7b44676c
prerequisite-patch-id: 02f4420a0bd9ac7d1de7eb1a3ad59ee2fc117804
prerequisite-patch-id: b7d35b10e31938b57bb38aff7145eae090893f2b
prerequisite-patch-id: 93318a4ddebf24432063549989b91d9ff998bdec
prerequisite-patch-id: 55ead548e0a7c82c4296cc9b9fa047f110c1e306
prerequisite-patch-id: 34bbdb130ae694420b954f41a536b8eb8df77791
prerequisite-patch-id: 5a62f8304a1790b31accf47af84815bffaa92b89
prerequisite-patch-id: d2e87bf5a992d19bde372fb230f4589242f12d40
prerequisite-patch-id: 0429aaac18b3a3d564662f2b93aa3af755c880db
prerequisite-patch-id: a577a9e2266f5b16dd0bf1b8b4312952f736380d
prerequisite-patch-id: 3223b00fa7e9c330054e19f256b4e601008160f2
prerequisite-patch-id: f1cf16250799f803bde22d6dae704cc5338ec76c
prerequisite-patch-id: 781986f407c7f833f3a157bcaa9b6384f964fe11
prerequisite-patch-id: 3bf3c90938956b7658c93fb0a14a21c7aa73631d
prerequisite-patch-id: 02b38c80a29bacf911dff822f7a022285bfd6c8a
prerequisite-patch-id: 6044e9b4883574d1350c02107179c32532d12c7c
prerequisite-patch-id: da68d5daa20b63029f1de165d40d399fb0ec0207
prerequisite-patch-id: 0d9bf4d3f321845f908bc96dcf0b844c14701218
prerequisite-patch-id: 24910c0e34355ac74ac3e0701e24d09e18450b90
prerequisite-patch-id: 640fa47c52c8d79ae409b7077e030cfe8d336287
prerequisite-patch-id: de19c1094bc466beef1d7d648974f925f7cbfb91
prerequisite-patch-id: b7a47b00dbae5f9c322e7625baf15198cd18564f

Best regards,
--  
David Lechner <dlechner@baylibre.com>

