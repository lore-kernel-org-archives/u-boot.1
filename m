Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08835C61DD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 21:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA7EB407C1;
	Tue,  1 Sep 2026 21:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MVcQaVfy3wJb; Tue,  1 Sep 2026 21:58:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788299925;
	bh=Gouv27HHsB4DrNfWnCLq0tjBudACrZuvsWkFp6T7al0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1O7qNOT3TuEQLRjyyzPNG6sl8cXI9bQNQRpqzz+iID+gmHu35xQbyE+W+P2fFWBpj
	 XBp78uUnCDKgxdvMQaPQhLMCyC/PW9hXLX/hT4tgut5XabnJjF7C1soYIz9HHGevue
	 CNe8HoMfxz3OjgdgRtYLcYliEy2JGxXlKgk4QxJn2ynm8woBWwK5aT3/CkKgKhoAHF
	 1ChANk89vpaKeJ56xEkjRA+PXHNFOsfBhaBKvoRFa39efla4Sy88y5pdsvgeI6c/4r
	 3HJRK+AN0hYXSxzVLq860KuWTj3Obeq3y4aaFWam8s0talJS/0K85uN4hcMrzgor7J
	 sZbGATGfrt8UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59DA04077C;
	Tue,  1 Sep 2026 21:58:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A48C4498
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8AA25607BB
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6qwZZAp8nLZQ for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 21:58:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fTSUbxNd
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 551486079B
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:58:41 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7f64ea07036so260329a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788299921; x=1788904721;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gouv27HHsB4DrNfWnCLq0tjBudACrZuvsWkFp6T7al0=;
 b=fTSUbxNdsZcFCTqjG2msWj44A0JwfSXGhsZCtlXaqAxPrRKbS694PDBQtC/t40rXiI
 ARGucXqrI8jPeyyfLHFrqercjz7wmyGf4a7HxKcak6pzIylNiv5eONqlYJvfnIZQ+PIt
 kIbdcRmxdQtpmsblQva8mCrYAtWd57aafKMYOpFukazwndyxeXlkDlFOmSbJYdAkWc2p
 Gc+04R15CsRO9wD1XaXdfnC/0yleeHNppgCzOmViYyJWdFLzFM+PQmj1WaZ+Rc7JZZap
 hC0PdnYhKriBx6IVVWnjcmyCTKl9Z71Boczs49cT6d5q2gvmVsuR/eDbPDYKF8HA/zyX
 NnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788299921; x=1788904721;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gouv27HHsB4DrNfWnCLq0tjBudACrZuvsWkFp6T7al0=;
 b=Gfxux5jftkwRnKH/xclEfrr/5kFE+pGMHZ437jskNZoyL+e0wg/9GM+HWJZCETiXFp
 aO1eCmEqEboHTS72LhtwbGvDv6i//pOYQIaLF583u+y87+iUgf1k4GyKVq7V1qYyoZEl
 oToz9kJ5kIAu7/L6DuCgf9X+0HHTRC37qTm1891kwvdbMAK+jBKO4FnH9jknATJsUEos
 VaMYwAQLdpMOGpLo0DcZBZtKDRXIn3CtsqfrnU53mzifBOVEVx84QKcUHV/Bz5jMyesF
 Rjz7SJahAfQcAxJUVym4pZHuZ51YIDlb09Dw3btav0tXudKx6a9h89T6TV8EFd4TqMic
 2NLw==
X-Gm-Message-State: AFuF++kVVgyRsEzDEy9cnDq0fta/NWDkriGnUVJnJESJgYdMG8bvruSp
 qtw085d1a7Ru6sfzx4dePfisnvZJXkMfQ1tZqv28uAs7BbNJpBNjBIC6em3TQOM7xHY=
X-Gm-Gg: AR+sD13yAsrqf3GvtGOHqusEyPgpXDIaUIJodBv1Jl4h3zSRbGMis9n3pGIStLY4bkI
 zkvrEbOV8eEE6GWjtn2VxTi+DamQTsWC0349kqFHSBnruW2u3kcScIVWbT7QYhqT4sfzhKO0ljp
 neCYArhFTuYeBGmpyTU0PUu+c2H6RbSBGuUgij/Mtn7YPJXrnJU16P70paATho9gq/goV/Kj0wZ
 kM9/cgeF2EKYyzCqkqcDQ+CVv8i/ki9xShOx/wdDv+XANptFpDUJbf3H5gKC1hBr98FV/4rYQVM
 uyXRMQhiA8OJczMeadmDEQS6bPpcDZorqcTautdpGT3goFaQaQt0Otr4LyhJQX5ap252fwNysG0
 46h9WVsWkUggQD6W9CjlR1L5nuuB6bFTMkZs19nmyhUYgyj83nARjDyGJfTrETsYCbFsZZwCUZG
 n5joKb8kDEw3M1BdAxtsDkULsWXavIyBThIy3sDx/Pq5/+M4BnX6Y0hRYWcKSDs8G+sA==
X-Received: by 2002:a05:6830:3c0c:b0:7f4:edd8:b7eb with SMTP id
 46e09a7af769-7f77fc170camr629569a34.6.1788299920954; 
 Tue, 01 Sep 2026 14:58:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:523f:532b:33f7:89e5])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f74d1b206dsm598556a34.10.2026.09.01.14.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 14:58:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Irving-ch Lin <irving-ch.lin@mediatek.com>
In-Reply-To: <20260814-mtk-power-domain-mt8366-v1-0-6a0bb4a766bb@baylibre.com>
References: <20260814-mtk-power-domain-mt8366-v1-0-6a0bb4a766bb@baylibre.com>
Subject: Re: [PATCH 0/4] power: domain: mtk: add mt8366 power domain
Message-Id: <178829990585.2485046.3399819181852765077.b4-ty@b4>
Date: Tue, 01 Sep 2026 16:58:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=+4BtRKeOG/VXxRL9oe7K+EeKBJBQzfIgsZqSihOjer8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBql0qInZ8PfG2H0yWN24rGLbJ/oV0GOac/BsV8E
 AjPhaywmSqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapdKiBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aj7gH/0cjKwHWQBIeqOAsT3vUHBak39lVEi3EZCvi28u
 WRpJ5yAPWw/uK7StuJQJAgLv0M7fyPeQigSKCtBbCaXoP50wBlApQunkhrc4eI/PLbqGciDalc6
 OCq1EKwQTefBsvL8ZrXaR7YBSqY+7cUHIObXDv4HOnx2crx2VBZJ8RkvjRzyS5WnNP019VEirH+
 IrgYibPM88CxjaxxbIBq+dJyauaJgXkZDjhcOQONfZ0k83Idy5fC5hMEYbiZ8ZikiAKkUpKHQPo
 NUrtm8bTL1ZaX1PhHLip4b+A8CMZh25eyJDr4QBDwpW7p1pa8K7Wt4xITWhjuYGF7uaNbelLrgS
 FV9Y=
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

On Fri, 14 Aug 2026 09:56:20 -0500, David Lechner wrote:
> power: domain: mtk: add mt8366 power domain
> 
> Add a new power domain driver for the Mediatek MT8366 SoC. This driver
> is based on the downstream Linux driver and has been adapted to U-Boot.
> This is part of the ongoing effort to bring up the Genio 360 EVK.
> 
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/4] power: domain: mtk: add bus_prot_sta_mask field
      commit: 49570ec9d701a727dc1d57e0e84c8554abc9abd9
[2/4] power: domain: mtk: add BUS_PROT_WR_IGN() macros
      commit: 927bf999f615593ac4258b9640ece818fbdbe575
[3/4] dt-bindings: power: add mediatek,mt8366-power.h
      commit: faf353d1498f55d52909dae41786bd1d30ae2dee
[4/4] power: domain: mtk: add mt8366 power domain
      commit: 115f9a66bfaae4b50e56366c2707a916ac13986b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

