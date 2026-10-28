Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9B606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uRVCLDy1;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=goT6z28U
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22F8A811A4;
	Wed, 28 Oct 2026 18:46:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aEdJtA1SVZIh; Wed, 28 Oct 2026 18:46:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 42BC581F2D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793213166;
	b=W/c6vHmufD6K7kurnXj64XsnfE+unArK4Hk5Zx5zwuFwEj3vE91xFUW8AK9NXhyj7K9X
	 elR8KL4r23Fvnd3mJI/Yi3w5yEOl+YjDveiTc2+IurVXwrKb7hizST4pOMTVk0EEI46T0
	 +Mc+ueAJiAPwV4YZpLmh2Y6B91o+Z1TWSFKG2IiDvXirad9yCfCY2a20vic6RCiIUsULn
	 Jo9o8Z73eIn3NkrvwL/cBLrHt5Ss47HGV/hXHf7w7bI0hirdMFqX9onfpNWBUO7MSgSk7
	 M9ORkkZAbZNySNNxOtMtOK2YEoLuzdrHJLc09di8hB2eGEiIuhwh3+xZbhI3PE6kEeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793213166;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BFRbuzdPwuyg5MZ2NcTELWvFDJdmbKfl+M/9DavFmGg=;
	b=AMmZj2/BU2nOXcWKGmGvzuQZQ5s1ibHb0H39A9PgNz4IUc9e4NCWd4TiD48T6p0lywbZ
	 UjeRZEYZ3IC/0tTq0DqLGvqgzHSq0Ji8Oa9O1YDpHkp0/CJDFUDUwPr6ZWfp4X+jrGMav
	 vvjBi+hUTPIisjdTozEtWQXZdKIdMDOwB398Xu7fx36luuUSlbVVeeKl2vpveEUGENzjc
	 HMbSSGdmPAIqVTKY56iUsxCOLSafmCqHCVgePRod1qFWFYWxQjoVbmV7+va3cyVrvK7tJ
	 2WFA3XfsYYdegR4B/V29ezCFTOICdc94aQTTfCumnoZEaqKMDbQ4j+mLoG6uE+lM/jg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=goT6z28U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793213166;
	bh=BFRbuzdPwuyg5MZ2NcTELWvFDJdmbKfl+M/9DavFmGg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uRVCLDy1KF/CuRMIvnUpvpJQrZliIKoH91OxvzzLJZ74Em5mvQTVXAzaAceAu5jy3
	 9tlrLuxxzxcJ5N0ugAyF2K+E8iQ/UapLHegerKtX+iY8xqLUmYtnP/SFNZ0Iw41Ee+
	 sHOs3p0q1xk4VucQengqhuRIpmqOAKjiHkuNqlDeg5CXySGIgHNTNAeqLoKGPUwY+W
	 cZBwBQbawtxW3DSRnqoxHcuRCFD5FW69r8y/rVrNdkjB337L3GyKSGo2R6V+CinZ0+
	 Xc2GdYo8KLI1Ef04FZNxQ7WlM/LcTuEV7Ybgr9dC8BFvWlPnzKAOWm2QYlH3pqjDnc
	 wZo1kS+zOqTdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42BC581F2D;
	Wed, 28 Oct 2026 18:46:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 98E93362
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:46:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95F1681F28
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:46:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhgkUqbiyCHn for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:46:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BBF72811A4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793213164;
 b=HNOsO35Y95kjiBsS+54pP2pdNeTmCD+Xi0sukoIZC2tvsPBxjP7AerXGaLBYaseFEagG
 HkUtUIeIj5F85lr2i5SUg6E1cL9gXLU1PbWI5mI7wozqeRQhxVqk3mCkNrkO3QAfI3UrT
 7/8tNW60qCWyTvi/zK5Y+UsuObjDODDZbG6cqga2JJ6nugDUWF6i9TdQIf9uqeJnSI3Hr
 ekmoiM1zdU1yzfty7NYGJ5RAkYerGiBJ4zpm3SlNycP9gtZEgsqpbi9IaihxM43akCirD
 k7HgD2te1NVKLU8p5+7EGG23K2oizmaIPE18LkrVSKRXylGchaDCEU4uTmfVGz43xwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793213164;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=BFRbuzdPwuyg5MZ2NcTELWvFDJdmbKfl+M/9DavFmGg=;
 b=kdtGPsjVypap81zPOd9A73rufDDG8m5WE7OC01n1Lq4dnVDz+MsA/VXH2u2ZNmGPjjLz
 SEftcuOZXywQmyXzrIPzTKzrFa3DOqf5F29LS3VyyH8mcqOHF2O1t82VCYEevu3NoUskW
 YvU1C1Pdbb1ZNvmKlhuzjPo0hwyrHyqLcOfVy/Am8uFxhgdEGchVpxL6EUKxJobG50k3K
 6zzVkyp43GOiZ/wQYI2urQiXJEmAriO4YbmoTSwPTypFFwQLo6HLpNMjXQOYgY6qxCZ/n
 x9kqCi26x608oCrNwwzUDDeyX0wnolPcYum8iIN8ThxnLl+LAg2e0pqmINT2bJtpkeQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=goT6z28U; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=goT6z28U
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBF72811A4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793213148;
 bh=BFRbuzdPwuyg5MZ2NcTELWvFDJdmbKfl+M/9DavFmGg=;
 h=From:To:Cc:Subject:Date:From;
 b=goT6z28U3IxF1BGp1RaJSVekm+CsnglQdBXlojb62J4jS8XlG2GvKO2LnPG0tzZzQ
 y2uJ8thqJzxmczgKwPFzrrzFaRtqmhnRYh7rtmkm9oabLB5dvl2zwQTSl17YoMUSlz
 Zp+UGf2UhYTQZyHttnTK5pjzNTzAc5jywtTvMnRJXYt2iVOHvmlhp81cw1t/Mjo9Y3
 /ZeJS8EZidZg+hqDMtpTbnFAbxk/6pXb85id2e9OkSLxaCQ27Tr0BKtuavXG6J/oSd
 Dn1o3dL8cQe8879TpZpa7C0SGKG0VQSQl2kVnEPOWue7xWHrdhwx40lwWCRHm25o0B
 4zfy0TnpXPccQ==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id EBB0EB220530;
 Wed, 28 Oct 2026 19:45:47 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v1 0/3] Spacemit K3 enable Linux boot
Date: Wed, 28 Oct 2026 11:45:04 -0700
Message-ID: <20261028184526.1887640-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adopt some fixes needed for Linux v7.2.10+ boot and enable
BOOTSTD_FULL together with minimal env addr variable defaults.

Build and test only with vendor BSP k3-br-v1.0.10 having reduced
configuration to avoid a memory resource conflict. The vendor BSP SPL
in its default configuration attempts to load opensbi separately from
u-boot main app, and also attempts to load an embedded controller OS
image, neither of which is useful for mainline opensbi, mainline
Linux, and mainline U-Boot. Instructions and supplemental patches for
the reduced vendor BSP build are co-dependent on this series; a
follow-up will be posted with details after this series is sent.

E Shattow (3):
  riscv: dts: spacemit: k3: override reserved status of mimsic and
    maplic
  riscv: dts: spacemit: k3: adopt override to drop M-level IMSIC guest
    props
  configs: spacemit: k3: enable CONFIG_BOOTSTD_FULL

 arch/riscv/dts/spacemit-k3-u-boot.dtsi | 12 ++++++++++++
 configs/spacemit_k3_defconfig          |  9 +--------
 include/configs/spacemit-k3.h          |  6 ++++++
 3 files changed, 19 insertions(+), 8 deletions(-)


base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
-- 
2.53.0

