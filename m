Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF8606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U2bTuSk3;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G6RY6PI0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C10A8111D;
	Sat,  7 Nov 2026 04:42:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AqvdJvZk_lbU; Sat,  7 Nov 2026 04:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E1011810E7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794026562;
	b=G4LoFR/OrTeR7pIK+wI8t/49y7UwszURQhScvl7DK6tZABl8sRO91in067uiBy4Xah//
	 RdpOTDPWG8GIyUxz5DRHMH7NwppY5ixOq42jdhGWmDqYL1Gk4bpg977SG7KMC45Z1ZaKp
	 SJbmBRr0Rd95SuRu2YTkZql9tLkNp17iUSq8oGFBxZRGZNrhjVThICt8EyFo61c1g3wTe
	 O3y9Gm9W8+w2ZmdkbbVhygg94Xwnm8JnRkBSpySjEr0IYik2zqnukjbiiSjI/nut5F4YN
	 5Wg/C4hoAmkfXnLDdxesKpjrfkdhsPsy4/dd6KC+f4Ue+zqnhl6C6GaaeH98XT8PDeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794026562;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TK2PaVsMb7kdqWS4STHvy/DJIp2SZyz3YaaY0liWpK4=;
	b=Lcl5rjbwGM6bQRyhlRfZah9GB6tC9TN7aUYxcklXupAcXaW3ctggUCbNS9tAenqPVKsi
	 w2hj2srbHL6FNJUvspialVaso/z9C4pQoMV9WnKGWPB0uS3fgEQCqQL1pGvgy9u0oqIbX
	 JoHm+pxToUPQvkC6I4M52buglTwxwFAS9L65ohf8UelLNWm5cIUYuKMgAgXrVN0cwouj2
	 Gg6IwW5f0jHH9/mi81tYff3k9WVQ0HxBvrs90KlTTH9AmODh0IBnAhXvXeiIjCCB7buGI
	 z66WLiVg9AOT8roEHdAI8EThPvusB02A0Vq7ALmxppYuAJeh24m1IM0Ah7mnMTanAjQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G6RY6PI0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794026562;
	bh=TK2PaVsMb7kdqWS4STHvy/DJIp2SZyz3YaaY0liWpK4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U2bTuSk3o+WgwRhkIGWkT7+DEqSzH/lkXtYmszTa0iC9ejh0o5bds1WOz/H0VVjOK
	 rOpOb1yiPd2p3/NE4PAg7mPQvN+zkgbGxzDGcTWTLX6OigK29ldwd3/k/Wq7plei6I
	 Bi9K385RiLmGVnc0kIVlt+4eeHqE06cN18fLYi0MXAbDWEozmgiSyHiQczPVyhldUy
	 ClKfxsoSFjNEcl8yenFEOQI67o0U3g0MJn2LLv7w+DDtLXmJMnaBcTNBPp/awnyZFd
	 aTRCIKAs1q0N/S8zGhO3fIFVfNLO+udOrcxPOqw3Z2nzwx/rPHSu5OOntW70slzY+N
	 opQ8FIoq+btWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1011810E7;
	Sat,  7 Nov 2026 04:42:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 749CB31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6578D81565
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4c00QP_EfYU8 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2C2581542
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92c; helo=mail-ua1-x92c.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=G6RY6PI0
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2C2581542
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:46 +0000 (UTC)
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-996eeadfbeaso567370241.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793999745; x=1794604545;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TK2PaVsMb7kdqWS4STHvy/DJIp2SZyz3YaaY0liWpK4=;
 b=G6RY6PI0uFM7TWjG/V7FXB8sF5dM63FeGjkvcxrjYSQ68PYVMYnq8jKq4O8wiPiBgE
 JFob3rRugNX/ZmMSnRvL2AUCmXU3cZCmyYM3ooBFGc7M8Fv0xTh/sRU6Jwj3Sdy3lad0
 2JFwptNF3uUZJWJ9iucx8SR0XpNB5CaXzwY9eAnQbeBSyhfo3+YitYxKXAlqKVPbhQVy
 5FATXePqEiBRAlG52lyxZA23ilin4BquGvE66VpIfdVF4Jm6Tv7dG3c1G2oaIfDmRZwO
 6L3Ai2pQkCjRf6fS70uhbgga2wHSDW2xUz98NwPqCXYGY1nGeOZUkYeZzOEIyFoQDsVH
 prRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793999745; x=1794604545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TK2PaVsMb7kdqWS4STHvy/DJIp2SZyz3YaaY0liWpK4=;
 b=JJTgwx0VrChouzGQd6OYMkzIHETkqOqhtLexK3nyw1UO09339N/DqzmKv4cST0XuHC
 YIszTOaPO2rOzTswSjMKE1/cjYT6KW5P6/TkAOnbjQSUnlGtRumMBtqid2bbe1iKynrc
 S9LBYm0pkzh/sEgBVYxFMZapVdjxG1GBtJnILMulMa8tPDXp/D7Zaazw9mtQl+R+UVNy
 A6MCYzXLpmh+vb0/TjbjgP77NcwL+3ixtBHwDTxjqgeBcGbDHAxNXlbWw7HuSOEADDGh
 2EzXR75x6jB2YWE2PcXf7hi0XXpo6A020llfIZzJOMNQo1NZ36rX6GYlQ3CYVIazQWDn
 JZ0g==
X-Gm-Message-State: APuU4Z/aR97K3L2B5nTZx4+UwD+k+DtseabtOwsHX0+qLWxFVvqp0tGZ
 Bp+AtDidE7ptVONF4jNC8iS83AQQg/mq+8Gltr1MNKrgf1/3b0ihGO0SenS2vay6
X-Gm-Gg: AYBFou200Ac0mSoETOf2CRLigF9GlvZKiHUSmIKRp6wXZqxn9NqOlfCHoIMVqh6+7Hq
 KiivBRJcxdnq5eXuk/t86MqaB8f3nFTqPq6VVmVpdQqJHVf7OhNXa3gJjStQFiW9pueUKzz8bmm
 e8HsV9G+yMOlm70RFmVoIMjB5PDdffSg/lj7EScW1MTvy2y5SJm0h3QNSdIAGVG42GeUI0zDlyc
 iQDktSYmhOAMKrIxTHF/LJxQQyEtT3kLpu+4Uv69D+rD8WMSqgsi+ih8un3C5tKiHoWVs9B/lo+
 FLegPwvuevs/8nVZsY7PSqbkPUZ8Bxyc6Qn3XCmbp4Kr/gILuu6bdS74HjUVZjJQcKwhA20YKbz
 Nqn/4MYejTOOV8LLUJtngB4IWuyF/84/MK61SL9eEAJTBtmMaQJJyMCgfV1PMKrwiT9XckSlE2l
 67BqlM1kslPYCeCUih7ze2foxROtGtcPQAp+6JPiKsoHZeABTehLbA4VGSvddF0BZLfBDecMi+1
 IVwdJr3Oxa/j3hu1rBLjXBp+4ICBCnITi5HjaMNxa8LI3HmzcFHdNHa9YI/ylpiJDD1tfRQ1lDS
 2UWqr8EQPmMuY70N7p78hFXUd+Twzag0DohHzC/n6LlQQW+mhST1dFGkbV56eG38f/o=
X-Received: by 2002:a05:6102:c46:b0:7cc:7801:b317 with SMTP id
 ada2fe7eead31-7d2a1541f1amr2175877137.9.1793999744996; 
 Fri, 06 Nov 2026 13:15:44 -0800 (PST)
Received: from mateus-laptop.. ([2804:1eb0:a0:15ff:e3:543a:df0a:607a])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99bab48acb7sm2614087241.1.2026.11.06.13.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:15:44 -0800 (PST)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alison Wang <alison.wang@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>
Subject: [PATCH v2 0/6] ls1021aiot: Fix the boot on current main and enable FIT
Date: Fri,  6 Nov 2026 18:15:32 -0300
Message-ID: <cover.1793999703.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 04:42:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These patches get the LS1021A-IoT board booting on current main and let
it boot FIT images.

Tested on my board (rev 1.0 silicon), which also needs a local RCW change
for the UART.

Changes in v2:
- Rebase on main. Only 4/6 conflicted, with commit 8ab9f25f7e39.

Mateus Lima Alves (6):
  armv7: ls102xa: Apply erratum A-008850 on all LS1021A boards
  armv7: ls102xa: Terminate CCI-400 barriers before cpu_init_cp15
  configs: ls1021aiot_sdcard: Reserve 1 MiB for U-Boot in the SPL memory
    map
  configs: ls1021aiot: Enable FIT image support
  configs: ls1021aiot: Allow 64 MiB decompressed OS images
  board: nxp: ls1021aiot: Keep the IFC enabled in the OS device tree

 arch/arm/cpu/armv7/ls102xa/Kconfig  |  2 +-
 arch/arm/cpu/armv7/ls102xa/soc.c    |  3 ---
 arch/arm/cpu/armv7/start.S          |  6 ++++++
 board/nxp/ls1021aiot/ls1021aiot.c   | 16 ++++++++++++++++
 configs/ls1021aiot_qspi_defconfig   |  3 +++
 configs/ls1021aiot_sdcard_defconfig |  7 +++++--
 include/fsl_ddr_sdram.h             |  4 ----
 include/fsl_immap.h                 |  4 ++++
 8 files changed, 35 insertions(+), 10 deletions(-)

-- 
2.43.0

