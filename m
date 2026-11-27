Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA351606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hUSRsIES;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BhlvZwdu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 775B9812FF;
	Fri, 27 Nov 2026 18:00:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id phLSZISK2xCE; Fri, 27 Nov 2026 18:00:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 67D7F812D6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795802420;
	b=cViPBt4UpvqHoFjSQP+PEFfL5XK8UUM9RYMzxZQDlca9/e9YT3tnr6AVA440LZGkLfC4
	 A1oVwHbyD2+fs2yWZNzp2va07Eatv+yJp/p/BBAwqzzk2XiTQ6XlGisAzEE2HfkXZo/S6
	 NrZ3ysd4B9wLpwRBmnlZGG2floXr72blHOe8f1hAFEdrSRLxA+1Xh8Raw+kRldDptR7R5
	 XCUAKC7g43Sz2wVV8qxs+DqonQpwsdNLWmhdiIu3zZPFPY0HdeVmAhbdkt7KWVVVdlTqJ
	 gkqX8ikK08Eu8kdXYw+ecFUjBWyGMdnFGh4wR1lL6UnsLR3DqlLoMcTsgSM441fIUoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795802420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tt9lmA7ffhir7RD2KLZ8foizfe6xD0yy+Ndt0/lPbIE=;
	b=kcTeiOPZX4npZdclPbsiWsUpdTAgLONkWXcLKpmM/WZpNI1eUMUykE4lmwYW3BCapitd
	 S99lbgu/f/z9P3eKdCFopeH69XzR+lu0JbC+ABc1XiXQXC4MfYaZeZmvf4lTcJ+4NmaGU
	 Z6bQ+2M81qQZ5Eztls6JF8B7tHg0uCreCSKdeZxwkBfkKHu8031HMqKFwTzhTr1DDimwp
	 ueopMXE3cnV6ixiN1ecNuifhvdCmltf6nBUunv8KGGfdIW/O9aYrKTiXyKYuLMSY1CkxO
	 +28vMyvWlztUcOp/Iyf2BSRiXXSlZ1PjhmU2P681HH8U3+gee2ClQpiEbc5zA+2mUTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BhlvZwdu;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795802420;
	bh=tt9lmA7ffhir7RD2KLZ8foizfe6xD0yy+Ndt0/lPbIE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hUSRsIESWLd5c5mxTP1o4845fKybI9X4pE2x4mCDAmgS1VhF9c7r2vbPCfPhLgR24
	 sPxSXxAt72Nvxx9ZRuJ39/qYy5aWbzZIcJXcINbuy6jxQZ7E6h87srRKje2PykCHNi
	 ieM8r4+1Z11NBVPBKx8g0p+b3U5GRgRQ6a0AVm8IGQi/LQJjxwJXB8OAsztD1vd9Ys
	 qIr5epHhYetPnV5GU5Py14bVVL3nz4cjtuj54VZhOOb2DvC+y21tair2zb+BOF1P6k
	 fHkd9Xq4dv5Knq3HMmD+aFm5qunqO0uVm6rbD3PGNNkLGrHK22pQZ5nFZuVpq2TiCj
	 CShmD8nSEbjcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67D7F812D6;
	Fri, 27 Nov 2026 18:00:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F19C3D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 53E80812F6
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cT8-iXavWMgZ for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:00:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F026881196
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BhlvZwdu
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F026881196
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:17 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso60253165e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795802416; x=1796407216;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tt9lmA7ffhir7RD2KLZ8foizfe6xD0yy+Ndt0/lPbIE=;
 b=BhlvZwdujp+aHdojGmSVkDQVKlHMJVUfGepy92A5c6Z+FaW6j2TVKSc5ErfXVMXYyk
 hH6V6qG+RUd7veiTQYlA3zb+4LkARZ/JANeMmVutUvIRduVy58zH+tbfC564+beB5VSG
 R6yU5wySzo0EGQlsvmigM8J1qi6L0FqgFYOPW9biNo5DJuOAsOKOwNNO8WJpu5yKbp2l
 daFE9iiTpcT8W8SF//zzm1djm2gavtr+8To8ZgNYqEkfZzvaIviSHwW3GFwJqshnPILm
 j38WoE7RXDxPrS/hM8uiW2LvEYo/2s9Xs3C3KpEigXembtBjnnRCvEMZV1iX6WSddhQP
 41YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795802416; x=1796407216;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tt9lmA7ffhir7RD2KLZ8foizfe6xD0yy+Ndt0/lPbIE=;
 b=dffOMxngiN7/xCTwUWACOGvfe4efiTWhJgzslTFkJ9kWoQ5JRxjP1U5RKfflPiJtKF
 mNeabB2ER7zS2Ac9G7YIMoN5CvOPk7KK2TWvc+Z7kooMgGTfA+TvNWVrLV8IXOKK1vqg
 GENcb3rvydP1R0LNiEtx/qXqHOxtOS/73eesBTeAOnSksE7DLwprUysMBgQP0xf2Rykb
 Gpmu/A8ddU18cUjiFWyQ4jWX4ZanVvyfLUhg5l+ubKX2PfisWY3ga0xQmUorGy/ymkh4
 iMP5au4moBaGJVQNdNhX2zf9oqbAmoc3iqzDmm2PQux6tUipsvoXDF3QVUZy97ZRJslW
 ezsQ==
X-Gm-Message-State: APuU4Z+EkiwQLZzdKBqnRLp9PyulgFIEOZkmny9F0Ft5lYy+1uI2o1PF
 Dm8qOjynlPqBE89qUAN94bEWBeIK/BH4tNIPINGMXjcjlebjaPKLlc3N
X-Gm-Gg: AZFdTZeYoSvumFPOYh1yO0rNynTEdNO4alrC6n6s/W6Kqd+o+1lGWqZ58cflduNfTbf
 T1/kuC25s3PE1ADk8IXKyjY1pJjYvvi6dKBQUiAIUhJBbfMk+3D3b4l01VgVfnDKRYxLk0OB45n
 HX4CbWAh/upuTw2pdX4JifKUP3CfNMf73ncCTpE74OghvJ1+9AG3opeEB4Ne1DexL5Pwyfss/bM
 EC+IEAezTJi5Vy/AGVn+0QVBty1b9JL1/gUpmAfwaifd9CFO42g9/Th5cD5FhsQOwfBDdM+PyrF
 A8vKBlBXgVnIQZwBn/HFxqYNr7vpnLyGeQMN9g7ljfY++zrFyT3yzLU6FZXTz8Npw18hZSBI3W6
 HgPvwHetfeebFrmiD9dLPXwZFr0BGpuPKwtAhhZbFgJc/RcDRAdEk7d7eGFmYVuC48FVBwPIOQw
 epxsA2qWU0PhlXPIW30ILjyAVR5oSWCKNsw9FW/5jvs2T7QhLFoo8BXBzL+Rqv5DW6E+Sc41T9O
 DiA6yZKjtlL4yQ+CQ2W1rGKUMHqbkpfuFO7LjW0Z+FT/OeWG5bVhcmZJwZteBE9LQDUaDD1hfrk
 r5XmHewBrW7tDvkN0bdb4f07JQJIxjCVjJZ/aJ3G+6Pd/3EUSwqq+g9/+MGk
X-Received: by 2002:a05:600c:4f84:b0:4bb:5f3b:25a9 with SMTP id
 5b1f17b1804b1-4bb88820f39mr483200105e9.30.1795802415789; 
 Fri, 27 Nov 2026 10:00:15 -0800 (PST)
Received: from [127.0.1.1] ([151.71.203.75]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm695638385e9.1.2026.11.27.10.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:00:15 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH v4 0/4] Improve Rockchip SDRAM types support configuration
Date: Fri, 27 Nov 2026 19:00:09 +0100
Message-Id: <20261127-ddr-multi-v4-0-c66608f3e06f@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACrFCWsC/13NSw7CIBSF4a0YxmLggpQ6ch/GAeXRYvow0Daap
 nuX1qiNw5Pc778TijZ4G9FpN6FgRx9916bB9zukK9WWFnuTNgICgkiQ2JiAm6HuPQbNnRGcca4
 lSvf3YJ1/rK3L9b3jUNys7pfAclH52HfhuT4b6XL36eab7kgxwZroTLJMWQPkXDbK1wfdNWjpj
 vCVlMBxKyHJQoJzuZaCFOpfsp+kVGwlS9LZ3BWMKEZFvpXzPL8AtQUM8ygBAAA=
X-Change-ID: 20260828-ddr-multi-2c4fd64344c8
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
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

This series splits from [1] as preliminary to a next series related to
support of multiple SDRAM types at a time in Rockchip PX30 SoC TPL. 

The first patch improves clarity of SDRAM type support selection for
Rockchip SoCs at Kconfig level. Not all the SDRAM type config options
named in the Kconfig are supported by each of the Rockchip SoCs.

The second patch adds RAM_ROCKCHIP_DDR3 option, forcing PX30 RK3399 and
RV1126 configurations to select at least one of the RAM_ROCKCHIP_XXX 
SDRAM type options, dropping the fallback behaviour of using DDR3
parameters set when no option is selected, adopted by these SoCs
drivers: now, if none is selected, a compile-time error is raised,
instead.

The third patch raises an error if more than one RAM_ROCKCHIP_XXX SDRAM
type option is selected when compiling PX30 or RV1126: these drivers
support just one type at a time. Drop previous approach of choosing
one type among the selected based on a debatable and embedded order,
not evident at configuration level. A compile-time error arises also
when compiling for RK3399 and the LPDDR4 option is not the only one
selected.

The fourth patch extends RK3399 SDRAM driver to include support for DDR3
LPDDR3 and LPDDR4 at the same time. This introduces minor behavioural
changes and TPL size increase (buildman report). Instead, the first
three patches do not introduce any change in the built binary artifacts.

All RK3399 configurations have been built selecting all the SDRAM config
options for testing: no TPL size error arised at build time. I do not
have any RK3399 board, therefore I did not run any test on hardware.

[1] https://patch.msgid.link/20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Changes in v4:
- 1/4 add to LPDDR3 option depends on RK3399 too
- 2/4 add the RK3399 case in the SDRAM type handling
- 3/4 raise error for RK3399 with LPDDR4 + DDR3 and/or LPDDR3
- 4/4 (new) support RK3399 LPDDR4 + DDR3 and/or LPDDR3 case
- Link to v3: https://patch.msgid.link/20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com

Changes in v3:
- Split 1/4 of v2 into 3 different patches as follow:
-- 1/3 only add SoC guards to Rockchip SDRAM config options.
-- 2/3 new DDR3 config option and raise error if no SDRAM type is selected.
-- 3/3 raise error if more than one SDRAM type is selected.
- Drop useless replacing of defined() with IS_ENABLED().
- Drop PX30 multi SDRAM support (2/4 of v2) for another series.
- Drop TPL size optimizations (3/4 and 4/4 of v2) for another series.
- Align cover-letter description with updated series contents.
- Link to v2: https://patch.msgid.link/20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com

Changes in v2:
- Update and reword cover letter.
- Do not duplicate config options based on SoC.
- Add SDRAM config option for DDR3 explicit selection.
- Raise compile time error if no SDRAM type is selected.
- Raise compile time error if more than one type is selected but the
  driver does not support more than one at a time.
- Change order to alphabetical one, as the most trivial option.
- Slightly optimize sdram driver debugging code.
- Add config option for size-constrained driver debugging.
- Link to v1: https://patch.msgid.link/20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com

To: u-boot@lists.u-boot-project.org
To: Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>

---
Massimo Pegorer (4):
      ram: rockchip: improve SDRAM type config selection
      ram: rockchip: add DDR3 SDRAM type config option
      ram: rockchip: raise error when configuration is unsupported
      ram: rockchip: rk3399: support multiple SDRAM types at a time

 drivers/ram/rockchip/Kconfig        | 24 ++++++++++++------
 drivers/ram/rockchip/sdram_px30.c   | 11 ++++++++-
 drivers/ram/rockchip/sdram_rk3399.c | 49 +++++++++++++++++++++++++++++--------
 drivers/ram/rockchip/sdram_rv1126.c | 10 +++++++-
 4 files changed, 74 insertions(+), 20 deletions(-)
---
base-commit: a1ce46a6689641dd83d725edbfc3f5719abf3a94
change-id: 20260828-ddr-multi-2c4fd64344c8

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

