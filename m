Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D6606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iwnRBqKM;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eomjM2LJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 930FF405C2;
	Sun,  1 Nov 2026 21:06:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AvjQ2JR4FHFp; Sun,  1 Nov 2026 21:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED077405D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567167;
	b=Tsffu9wJBjjZ6G+fcTGDrFRTuFDx5EuyCMTvi7OguFJyZWvA7dw0HMPfYISHNfRxKDRU
	 YuUumSQz9wbTOX205wS+Nm851vj2hCe2svJg6L+cuj0GSnsiWTwpnupfjeBcyhep5A0Wi
	 Uqb2VNLnTAp4zbTdg5hPCnX4wtfs/zYykxyrvfQjwErpBHvEA9LXZGu2nOYejCRr5fBq5
	 YwV69MheKyhx/rgYWlQs85Mo5H/+my9hJuu88y/5HLtOdxzKtqvboPkAABMwJBf5tRnIY
	 VnmWf6szd2FsMXLC9UHqYRTs1Zp7B7HS0iwKprkir9Dmo0Dpws9OywFPv5hWVcq9sug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aSc93HA/EPNJpbF1JA/K03yq+jZ7MeoT0hCKhCteZec=;
	b=JcC07fTaEKJlDrQIb4FyDoxhKQt/68/Eh2iHNM026AdORrBVGohdxDaSXNd+pLl0Gw36
	 rDzs7HPFE9obEwa3BTHiu1zu97/L9oKcgDgs/xlafKceBu+BnFO3+E0JMRypti1t7k86I
	 ye6hGgieeNHjoL2cPHy4kvMcgPwjmsbKgjSWd0FV5wSTPEV3xnIXSElcVV1aQlUX/r1n/
	 ewJ8Z5U8ERtrflN7+Wvlc7Jh6gkB3GFWsGFiTX8vRjbHSs/NwNOMksGXCgLE4bNeM+/Yp
	 ZNo6lMcSi0pU/Ui5cvsZ7WyuzHMoS6DfFF8AgMgiSuY6bknCdi6SVMzs9adhA/U3K2g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567167;
	bh=aSc93HA/EPNJpbF1JA/K03yq+jZ7MeoT0hCKhCteZec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iwnRBqKMx4z/OIpgdyiEYsKSQxP4QWULrWjDraptsegneBqIHA9f6zYMSFOa1jJtT
	 IcmCEdoDFZjlb+iJHsXvQuDILgx3ZPJTZgRT8a1gIpvppu0X31rH6zepBnkQc/zduY
	 pavHTqSvGrrvekeXwtfLXRD6kMro14CIFjHcWe6i1sk1N35HIH97YucVmKix9i+sV8
	 t7fCsEcLlt12YVZTpfEaDpBQ+rSnaHb/VOkoYCfCl6yNqqTMHF7Fk/BYlBrNny5bX8
	 da9A+pKmrMLqfxyOe4IxukOLsqa8+ZCml4aaFrgB3MkDIlPJMMmgktKAM2uKhgc8Ik
	 VKRtbs8FyA6Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED077405D9;
	Sun,  1 Nov 2026 21:06:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 83B1B435
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7580540079
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:06:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id srrNR3XwOHUt for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:06:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7EE704004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793567164;
 b=ijUuTunnmWSVOg+L2dnbVhxENUhHLKSH2nS4K8Fnu/INudKNyXSAGfj1NJlks9ZAZgWG
 2aEvQRy7q71PBpVDento0nRj8ZAfsFoIPHd+V16IuGx/iE2+mAl1Qxwk4fdHq3qXURy5H
 7G8mr+WoNLkGHikrHpJO/EUilMfdUXe816PWDDBA70K1ooTm60V7AcNsbmf7l1/RYHDUL
 b1u+6S5goUNFf67l87tXdaRX2YbraGIaSacdUVAnYEhOdrmCQl5tia4pylQacMaNqCfkz
 P72754UYCX0QryqWFs5vWBHKsBgWDisyGNWS6/m0smeu0mY+VCThYpLn72Z2C0QN5hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793567164;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=aSc93HA/EPNJpbF1JA/K03yq+jZ7MeoT0hCKhCteZec=;
 b=Vn1cBOCzu/ArEJCJrnPOpbRSCrfzogq+NLbEn37lG6yOTrKcXulp4202AfFHWY5qQ/vL
 Kc9aCfphrNkvFsFyAUXdwORTQWhXwXeIjtiFsxrbcSXbNDTvX+QR2pY09A97m3QldF/tD
 6SKTdiF4XdZlLIM5Np5kqUqhxEeHWrwgZnDIA0aHAlE3QatCrcx6mN9w6nygGxxNuRb+p
 3+AuVhf58wmVTkOypn0f9k3/LLX5dst1WOkO0AaJ37o1M0oXblfjO80qU7R3Qq/v8P/wl
 IDJT+yJAOZjwO3lsIB5jwCg2TFhJcPNwS3yr78s0DetuGq61VkPzTWxdFP5n9SezXPA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=eomjM2LJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=eomjM2LJ
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7EE704004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:06:04 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3a9a1ed66b9so17494011fa.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793567162; x=1794171962;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aSc93HA/EPNJpbF1JA/K03yq+jZ7MeoT0hCKhCteZec=;
 b=eomjM2LJv3UJtV3kqHAjdzTXxWC5Xik2WJp+XOUguXNNCstwtnad01a6IEG9MZDf7X
 OKgCnuPPi+ZJimGlC8T87rVtSOOboonnJ7FnSkSO4sKaxxnScLNKMoZ1qzYilIT/D1Md
 NHMhvrBHVGB8e+XxV0aobpG7hKZhy23pcdnKt5KkP+OeUg8vyTRWr0G39Hn9e5yldUBh
 qcy1xKj/EmoiWtYxWtV1vD89GBmGQ0axXZHCQjU0LvoijZ6ilBZpUgN4P1y24cc1UEQK
 ttO+9pvq9rFNp0ceurH0Pzi30aG8OKQb4poF0V7mC0DDGctcDOBnb/kc+6Hw+ggPPc3r
 Q58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793567162; x=1794171962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aSc93HA/EPNJpbF1JA/K03yq+jZ7MeoT0hCKhCteZec=;
 b=xWRPuEkuWO3qjZlKRoCIGsPdvpUcIHQXsyV8kQpC94tmiiafplSOvn/Pmb9vsghdkW
 W5b2R3u60lePmYKQuOz633w0hwBausX+6TXDUDyIl8IZWx2KbXP2wBGWiM2HEvkwH1pw
 Ic7TTQDp0r9AMzNlyrXueEgl29wZ4lelHUi7Pp71jYYhrGyzDgb/yse8hJpaMTZ1hYIY
 jQme9GL/Ti8qryXmtdwmHeV3r5xtemN5gTYlcWEBkYQjFxsK3puczrivDuUgpNArRbZk
 JGfQPnG6q1DNagTqAJfxYPxK9m7j+Abac45ovFk2hRHutAgrNqpctuhZVxgVAugw0BOD
 y8Qw==
X-Gm-Message-State: APuU4Z/63ZtA7oB0cm7QjpVcB707Fv40l+3xLVbL+as4WhHFYveUgRXa
 VA2aFzZyafLkkkpmwdvelEHZN5RGK/kGiXlznaPphMiLQgaNSmIxZjm8kdaLrBCM
X-Gm-Gg: AYBFou1ey41HSx/0mwHlUD2DuMyCEKAHlo08vsFUObB80zrvKeLYKQHHRVUHSEQ2Yzn
 L67WHYBSrIK1dvRCHB0ja/2aT5SOiNJj900jH/YCoqIXK8vBNk1jlFGnMn07tkjZM2FUTaaxgCM
 JEXoZzBovyJS28BHaaRFBqLzIC+ZVhXK7MXRO27n6BSgnHtq+Hda2NF8uH22OaBL/bj64r7TMWu
 7YvpJx03ZzMBDkDtEbmnGTOsPCWEGcLz3IkYJUIDfM1gIIagChDZ2xYHaFwqsyk9rK5bEqC1ZdB
 IGmvJHSv5IdRfdm5Vk2qCfKSUpNtFrDS/mQsMCn6reJUysL7MxoFe1ZlpacmudfU3WoeA4zl9s1
 uNhE7S2MBHLPnI74/ggMhD8q6RMED23x+LCfFLUdvYji8mmI0q6i7ptmMwlrdwwXWHq1ebxCYez
 n0ajkIf5ztyA4aagFvpnsBO6UCg75rMHH4QY6PHg3Ge+wlFI62zhhodl58PnsPq/cMgvg+ejumF
 gJ4qWuBLUc3EOEqfstA+ZCjMDbNWmi0NPwiT/N/qiuGiwcfMOJnYUFd70HrQKJp+/I9xY7BHDjR
 zj0hqNAx7UpYHFohA+gIz0GG/j4s+NSTSnkH+9J/xtdUn06XpvRbykmAigSO7kiNUQ8=
X-Received: by 2002:a05:651c:b07:b0:3aa:f72e:8ef5 with SMTP id
 38308e7fff4ca-3acb7a8f83cmr19344831fa.19.1793567161883; 
 Sun, 01 Nov 2026 13:06:01 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm19882441fa.20.2026.11.01.13.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:05:59 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 09/10] configs: add the Lichee RV Dock defconfig
Date: Sun,  1 Nov 2026 23:04:48 +0200
Message-ID: <20261101210449.1235102-10-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
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

Sipeed Lichee RV Dock: D1, 512 MB DDR3.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 MAINTAINERS                      |  1 +
 configs/lichee_rv_dock_defconfig | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 configs/lichee_rv_dock_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 587d4a30377..6618000f168 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1549,6 +1549,7 @@ S:	Maintained
 F:	arch/riscv/cpu/sun20i/
 F:	arch/riscv/include/asm/arch-sun20i/
 F:	board/sun20i/
+F:	configs/lichee_rv_dock_defconfig
 F:	include/configs/sun20i.h
 
 RNG
diff --git a/configs/lichee_rv_dock_defconfig b/configs/lichee_rv_dock_defconfig
new file mode 100644
index 00000000000..a4c9821cfa4
--- /dev/null
+++ b/configs/lichee_rv_dock_defconfig
@@ -0,0 +1,14 @@
+CONFIG_RISCV=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun20i-d1-lichee-rv-dock"
+CONFIG_DRAM_SUNXI_ODT_EN=0x1
+CONFIG_DRAM_SUNXI_TPR0=0x004a2195
+CONFIG_DRAM_SUNXI_TPR11=0x00870000
+CONFIG_DRAM_SUNXI_TPR12=0x00000024
+CONFIG_DRAM_SUNXI_TPR13=0x34050100
+CONFIG_TARGET_SUN20I=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+# CONFIG_SPL_SMP is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
+CONFIG_NS16550_CLK_ENABLE=y
-- 
2.43.0

