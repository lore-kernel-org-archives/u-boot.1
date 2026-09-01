Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9CEC61DD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 21:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD0A740845;
	Tue,  1 Sep 2026 21:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zntj0t2FtJLc; Tue,  1 Sep 2026 21:52:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788299569;
	bh=HZ1u7bYLQrs2MQ6YEe8jBmivSu54RN4yBoJD4A142OY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=no1OgM/48Ap3lXfP/XRAMocbSgNAkSift+Zd3tDb4EU0fCWBdWw6FWenhOsjlSHCB
	 F7F+HWfqpgo763q5JpQaPFYIYjLMyDJm3ji2v3eLzV7PZNqysCRy1NjjQQgNgBAYcL
	 swYqn2SEkDWqcKTGx7rCJifctc94TNv5FToln6I6/JuwvCXHBZp7oUpnQVTtxJ0SUY
	 cIYju9PnuKQJUx7PjN+TM8zpRbsL2GNQYySYte/pbUeVkU1CdtDFxrgAU0qOFGN6nQ
	 kzhs6QT3aoLRWA1pBJjhM7MzRAAEC3SYWik8hgzmnzYWnTIqLdZHNJED7GEOYpf3gH
	 9db7ykDVl251w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70F614077C;
	Tue,  1 Sep 2026 21:52:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 59CE9127
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B34980DF0
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:52:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id roBG5stwErdJ for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 21:52:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JUNZ/lmX
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFB35809C1
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:52:46 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-46556b9e02cso263277fac.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788299565; x=1788904365;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HZ1u7bYLQrs2MQ6YEe8jBmivSu54RN4yBoJD4A142OY=;
 b=JUNZ/lmXxIf7oL4YWQEcQK2sfb8UkFb1/iivkRXbMOdVsh+7viD4KbOuJPPq4+E3Ed
 7GqaGLFdgen3C8BhLpMRI+5+4YjQpA4axMafLLM2Adwpp9FDWK5FVTy6IwFhvEZUb4G4
 0PfW2j2N1OeiHmV1KGQK7UPRPN0D8+B5gVQYvavT6Tmqpvb6YYZ3YIuSFzEl46t1syYw
 VQn+1FFPgUlmH+kSchI6Mte4+JcBlq3nqjTLy9rBxXqPkKSlAMmwAFb7Q5pkSCVPmG9y
 DdiEiA+0IipSrtvfKmZAFsMbAaKbaEkt0hLNkheQvnCINNzqcKpmhsu/6U1GZ6ZsX3tv
 3Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788299565; x=1788904365;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HZ1u7bYLQrs2MQ6YEe8jBmivSu54RN4yBoJD4A142OY=;
 b=sCFVGUNslEyTJySk4DhC3p0lU91ty2sVmwiLYFWO732/RLN/87ekHuuKJN90bRU5ZG
 bH3LIUQRTy1WrS+KPghTbL9seWMAfnvooTHRUboRFNhVCo6qXeUCbFtv8XZdl3AXx4ly
 +ML1oAprcYYDH7UYKFjR1UUGVgt85MH1erU8JoWJ8phIfDRyDpoPe5bKdM78XfEL2DFG
 NR1vG9J+9voCdD9FwCWLAqyl+ZGdAYM+C5CWhnqnyQclFjGkKf49rjcSun6HsmTKs1L/
 qTGNmER2DwR+cJkJe4acC5h71XNopc/KPyIR18y9e6z6WuPpZVDg43W4kA0E9iXa5gQy
 I5Lg==
X-Gm-Message-State: AFuF++nUkZo51/aVnAmpNQnl8EUOR8N3aU8ufcDVQDVBswUI5+46P2Q6
 Wf+QR6ChCpDgl1+N7sVxH4bE0VSOJuzSngjDwM9YSwzsqO4kLZtUgeTtblUNI2MT7lK1/C+XKKy
 QaHBq
X-Gm-Gg: AYBFou2BTtnbtpD/vD7hsxSpjiBKpC7217v6QK4AvCh8bV4SCUPtPIXv1zhWrQ1QTld
 nZ25gJuX/xUK8EkSOI6FqkXRUArrWGUfhEiPXyy4QSVXe+7mfsxe7DumxojLkpPD1B5AfzcGALf
 cUzt58NCNdns4g4XtQh6X0WFCFIMNpkS8/UtZHQHUU6gHwfQ9NgdYR+Ju4jSry+dDUeQucqqh59
 n51z+I/ayHmgy0OPJgqCIegciTaxdCA5zsaCh3sGziY4sXMP3NfVFXqYwMVNwzCJ1+ZuB57idMy
 Lk4b54av9z7ha8BeJm0EKvyrNfsX9HF68RlamC0QnGfqNQK03GJ3dT2EEY2LUSSqCWedIlrs/qQ
 9s4lwoDMa/IhkLPlYBNd1s1RwQfS9fC72O7tvsvQHGeJec6n7yB0spdM27Asi+rBRnc4CAjqqcy
 ZDO7KZiOFc84ZaYFM5ifQPhf5IbtrQUhlzILC9tK1K5QPwvtA9U73RwKycCgB5jDPuSw==
X-Received: by 2002:a05:6870:b513:b0:42f:f3b2:e2c9 with SMTP id
 586e51a60fabf-46f7acb54e4mr164431fac.0.1788299565116; 
 Tue, 01 Sep 2026 14:52:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:523f:532b:33f7:89e5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f33084673sm1441996fac.16.2026.09.01.14.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 14:52:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Irving-CH Lin <irving-ch.lin@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20260814-mtk-clk-mt8366-v2-0-5e9e952de8d8@baylibre.com>
References: <20260814-mtk-clk-mt8366-v2-0-5e9e952de8d8@baylibre.com>
Subject: Re: [PATCH v2 0/2] clk: mediatek: mt8366: add new clock driver
Message-Id: <178829954695.2485046.5422828839433522022.b4-ty@b4>
Date: Tue, 01 Sep 2026 16:52:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=805; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=onqF67IVmZDvzkBOm5D3nd1rXY9eKEjy6y+AN5V3zLU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBql0kkgHGSshbAnNsKZh+fM13qdEKmvG28pSK+B
 EI383w7noeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapdJJBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiJIH+wQ3c6WQ21UWDWcxsfFCgWDrkcH6skjwt3WhX2g
 5WoUUyHSPAFRs88qD+nBvCG9y+nR9T8JpJGq5dEvsEiyDVoDTdxEulNcbsvyL3XZM9q4hdVq3dV
 wFts7IWk+/wpbj8L5tSt6SpwIMR0ufmtR5NCwdyUzUqDUsE547GPk6vkDlnB4tk3HPbuS4bHKdu
 6WCtLAttn5qF/dT32Dc5veNjJVdmYFPBIffvwJacuImFEM5FJQD1GO2fmlVWec3hXhFsWEcjtR/
 NjEMGfgyktnL7c0vlQfdTduhTGefHgVhPl5+tU33Upq2fzw6z+IFoo7UuAbrWYlnNUM/mS0FTph
 aJaE=
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

On Fri, 14 Aug 2026 09:31:01 -0500, David Lechner wrote:
> clk: mediatek: mt8366: add new clock driver
> 
> A new clock driver for the MediaTek MT8366 SoC. This is part of the
> ongoing work to bring up the Genio 360 EVK.
> 
> v1 was based on downstream U-Boot, but it turns out that it had a
> stripped down version of the clock driver that was missing many clocks.
> This has been updated to use downstream Linux as a reference so now
> should have all of the clocks.
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/2] dt-bindings: clock: add MT8366 clock header
      commit: 706c533cf4ca06221c4e70f71870ee1503aff6b2
[2/2] clk: mediatek: add support for MT8366
      commit: fb9339ce399614f0b427ac19c36c54feb1a42747

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

