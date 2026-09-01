Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E99FC61DD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 21:42:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7F9240A3C;
	Tue,  1 Sep 2026 21:42:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fifGXuprNliX; Tue,  1 Sep 2026 21:42:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788298949;
	bh=sCvGJW/SuiL8V2MR0RJ0W4K3o4cmBHFqDMxKBleS5jM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ax+Z2fD7p2tRmeysFoZxZa5lG4nVE/oCfk3i8c2Y93ME3dC4RUPyI/ffm0NDi1mw2
	 FjZAMe3g1oGhrzaRnG0Pz/jcNjakwTbGRiS/XyQAP5nD3cmveWMtpqlCBGDHOrMeUe
	 rqkixLyhuUeEnUjvjH2V2qfZh6KD92Dnpfmp2IciJK1PsfuVE8+2xuJbd9rVuICD4+
	 JE1DxYZPmFwHKu0CfO1DYvM1cIgRNAberBXZqU8BtxzIM0dM92QfUPgOsYf/bDWABi
	 OO+CLY+X93hY3eUX2AXejaLHLqR/gRigGKO7jjkK8co3tIHPCpSh81rtBr597GWrpy
	 ugzsh4HDJwUGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5345540A2D;
	Tue,  1 Sep 2026 21:42:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3864B279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29AD1607B8
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:42:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e69RIOkrPBdQ for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 21:42:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Hv8FgC3b
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8541F60649
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:42:25 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-46adfc80ff6so223940fac.2
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788298945; x=1788903745;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sCvGJW/SuiL8V2MR0RJ0W4K3o4cmBHFqDMxKBleS5jM=;
 b=Hv8FgC3b3R1+iz1jNrFGtB7BimAism+TDGfnwvnUay7IzmYFf6FpYWJ0gGHsIB+xiP
 YJ3kTZtcJ1xA5ocNa51TRHb+bL8WnyuAt4SON5Pf+sGZP2lx9GtnRZ+pmoSozBwZ79IW
 x/+lsITlWBFMilO2QbF1mnX6v2RQabFnUE2Ul8+Xg5PNCt5AKXm5V8VMCKVV16uCLwuN
 brxoUtq9YJSF0gBWXocHKiuD1XXytw8tpXhLtW8i7c0+4eR9PybgC79gw9Q4I5wBhMXV
 FDiDpRFvPi53EIgO+hIyYJvvMjXdMTlM2lOfPedw1Jcpt6yIo4gBEJN620ot98y7kzEN
 euMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788298945; x=1788903745;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sCvGJW/SuiL8V2MR0RJ0W4K3o4cmBHFqDMxKBleS5jM=;
 b=SMiEoq04ZZoGO1XRztihdiyNQjfUlwZFAVuIq4z8JixTBq4rxI7CtVW+C7Zuy6co9t
 rkxxv5hQzFbAr6IK6rruFPuaMlmqeopdJHaVBz2S3gj35Jltz3WNPn6zPPmnhQKLpfAJ
 yh13YuPuAryXvoicWOVSZjRc4/jd4dCg9lXKZoPmsdjVnxOS+Yxw9P8ak3taOij0npUZ
 Aq+HqTSo+jO8rlhZUupVkKUTv7FH4sKkT7H/V33B7Qufcow++r9jliM1IdmR7Js/f1mJ
 V5hBu3cGKHzvl6ABm/O413XU6a9aRrHRmJzjT2rIynl02lALCGjSTpyMrTIon21JVPJf
 fyzA==
X-Gm-Message-State: AFuF++mdx2aDyUxcw7sAcvIS6YSXYNn8YH3QeYB+1mt2RAhBDpqfUw40
 mfPXwGRth9Cpn532BqSsJnvuZeZPVERce5FVnuo1P7OAcvfqCxA2jSShM/LzxiGX/0M=
X-Gm-Gg: AR+sD10mweUfegLHAdp8AmT0VnjiLPScHmMPbottOv6bMSU3e4cYplqk8hCC2fav/Lh
 5nSFKyxVXlnyCVdyDpZemwKEosQO5dIoPvqrAWLVA5G3aE129Ey5m8T3GRuH440bmsyirVZz7oz
 JVGjcbTrNcbOfeZrG/QeBBrxJlqpSKxRnRHoI+1fbSCkbA6UDzoB67XLXJIBZn5nqqHIbmM4daG
 r0N/1pT6x79iQWFa7nVvvAPnH4dkoLLqRRVgKHrO6syvThzu93G6BjC03cVmj5UZtm4ipj4VLei
 X7PBcagdHyajFNl5JngUfD1K+tqwsJjGaWOolifIdOFa6cwPITdWene17in28LTMCP8ehBR7sJ+
 gxcL1jD0lsYIXnjQydKH8nqJYdPSLBI1oVL/S0Eszk+e70it+vlYtMBccIaXZ6fZVpZm2gOFCA1
 ZaRQBFTaWvB63EJwIsPEdbF7t3Qo5Ka2crLFoK7zt5sln11WuJtVDKhOsZwxmJ2pUjdqXtK4y2P
 21A
X-Received: by 2002:a05:6820:2086:b0:6ae:90c3:32b6 with SMTP id
 006d021491bc7-6b43622f0fcmr1588181eaf.1.1788298944988; 
 Tue, 01 Sep 2026 14:42:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:523f:532b:33f7:89e5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f32f87146sm1309843fac.13.2026.09.01.14.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 14:42:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Sam Shih <Sam.Shih@mediatek.com>
In-Reply-To: <20260813-mtk-clk-fix-reprobe-regression-v2-1-c7d1076a7ada@baylibre.com>
References: <20260813-mtk-clk-fix-reprobe-regression-v2-1-c7d1076a7ada@baylibre.com>
Subject: Re: [PATCH v2] clk: mediatek: fix using clocks before relocation
Message-Id: <178829893000.2485046.9720147239160734059.b4-ty@b4>
Date: Tue, 01 Sep 2026 16:42:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=328; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=gYxBWesndBIPC8bBuUuwWsrpIRU0GjDKpPfchuYaZpA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBql0a4pBVEsspTdQBT7izzy98fczbIT+tdNH9+Z
 goGi0EpPnqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapdGuBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AVcYH/0FUBSQ4CppmUVRpGSwf7lX3iy8HYk347ILJTbd
 /ENuNeILcvu99HiL9sEyOSJZ2kCKy2/TxW2TK4PTZmsysNVf+8yHwn+AJcurpgaouxp23q79XUf
 MbJXO2Lw8RRQKD3cAqM7XZlru4NbEckdeLhV+7FyjuZD1QO5HyQD6p+7HBUOfw5h2RbgwnK/jaP
 S5iJqo/NVLC4e1AnokhY7lhYgaIFGdFiMbBmXBurYqRPWzQsoPaXjju67fAsI/GY8ewzZWrtF5b
 eTh7JA3GTcfGLwAjfq7q94lq47/LfYy6+ZmZZp9I0cwib0hm+/Nidqca03sMxGk7WaoCDhH6P4F
 fQqg=
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

On Thu, 13 Aug 2026 09:40:16 -0500, David Lechner wrote:
> clk: mediatek: fix using clocks before relocation

Applied to mediatek-for-next, thanks!

[1/1] clk: mediatek: fix using clocks before relocation
      commit: 6961f8e6f8c06837d4eba0794fe0d0ed6c4dabee

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

