Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4A606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=txHqqUsT;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pG3eUoJv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B52F981673;
	Fri,  6 Nov 2026 21:37:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z8j5Ynv1fwll; Fri,  6 Nov 2026 21:37:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F238481665
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794001026;
	b=luNER3XNXZszi85TIKLEmZwL2je+deU39O6oCmkn6mZ8xDJ3lZhUH7uzepXEzdd0IIjx
	 i8J6JuqyXOk5e17bXugRjWwoxwjbm7vJaG7KtmU2lKVpWSVdIYZM/4Oz2Wh62dfNN3uwY
	 gVC6YfXiltSETAdL7iavfDaq8rJ/2gH+P4DEL9pS7H6OkJuKg0swneH16HUp4NDhwFOFn
	 RDa07pzfUXGRPMm0ZVW6ALFgEEVYIkxXSTh03R4C+318pUpPA0eRAuxFoQRLSDCuw7FnZ
	 NuMSW31jRLRpoaM5CzZpaVxYq/LOwqsSlh59zxiUOqpeF2MH80Rq0mnCJnh8L9mT+kA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794001026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3KYIrydtCuk9jNEs+GAXPFsN6wPzsI790iP3lpOpBcA=;
	b=Z6lKbzlztNp+E1ABfyGVtdx94/gw+7hagBaV/Yz1lSOCU8bLiiNyrmX8qioexhVm3ZSl
	 3aKgPoC/o6jP7fqtKSA4cDA6PjWtie6MFNc1ZJsprjz47aStXg1JumB4RM104GwOX3mrM
	 MF8zaLGO8/UCqhM0Cbb9E5eynC5zGcFGrQyyAC8XJ8Duu6YvVhFbaWKSfoI7roMNbMilH
	 Qybv8blvNnbl5U0Kn0onBTkZBWxhJGl+GJg5e4RoGwJFf9f0S2fUMsQiFlgDY5wnOc6Sa
	 dKl9sW6PVZufeRFR+MuQSspFBe3XXnv3K5cbCvMTwgplsfUsQAKCPZsLzG8j1OQlyew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794001026;
	bh=3KYIrydtCuk9jNEs+GAXPFsN6wPzsI790iP3lpOpBcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=txHqqUsTkSW1kLo0IMdlZ+a0GfOKEjwpCcMBRAEQiB/dW35CG3TO7yh2vSOsrtdTA
	 f32GBLN9HJaLKYYK3Yh5rvNuzOqhkdzwAaoY/Nl/R9rQ7+D7ao8cbdARMhzs3rvllr
	 t5SqAbgPDcgqJob4hyL+eTVSZMVhx7tcc+1xC+yWqmgreRSQqemYoRL6UJ4LPD6w1b
	 y6xAAPSWvvslPkSAPxnQSQ9pDH3KVnlJdruE1FhbSvL+ICemtoNaMRgIE3iGkgc2ng
	 ZvI6a8D1Ns4hGdLnOFbuVqn68dmzIWleoMO/i0+IObGa7HCy7B8Y9wFIPs5CCHZgHG
	 Ss2vv9gAtCaOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F238481665;
	Fri,  6 Nov 2026 21:37:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AA961C6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 409C040401
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:37:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wHPgS9Lp4g6m for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:37:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8B7D5400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pG3eUoJv
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B7D5400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:37:00 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-5058b105df7so388177b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794001020; x=1794605820;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3KYIrydtCuk9jNEs+GAXPFsN6wPzsI790iP3lpOpBcA=;
 b=pG3eUoJvm4kyGKV4U+HqjxqPx8+nUIR4ZmPvH0wh3O3ieu28HEYpG6wH5dUAojoJ8X
 XLFBgWIcvFNQum9kTPRqy+mlvNVpRiyjcjyDVLY1PJleWLtf6HqHxEjPzMR952FtKtls
 +Ng2aROCRfrJ8PC/RA8H15x2yRhGsHcaGYJNvB5RxaGz+q0j+PcNlyRv8rMZgUSSgBCe
 fjoa0rL4X3TbI17aKJK6hefYj0e5K7F0c/PyHsjNjuL6HYyQUvqGFKgZ5LnMMAVeuSGh
 egLhLfeuRT0WWPPKBZmLJ0TKuZ41q6VeB8cGI7ahEU20q0j5RSadvVxltLtVwzRsu7Va
 X52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794001020; x=1794605820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3KYIrydtCuk9jNEs+GAXPFsN6wPzsI790iP3lpOpBcA=;
 b=DaVFzYIsV8hagsBNFPOtl9RswnoL/+diTJr9wuSFL/QJBaKzHHyV7vkh0ohEuUVV4y
 iAQPxVWqMzJI7OrYmFT10tZ6D3+ZhOAW/Yywf+7z10Xsjl0thWMklvfG3MKctjqJtsvr
 EqsiWrr8DELvEVOfRLUEcWjkx/OAQziit7k42+mQBej3JmteathzdlOK9LOXsbEUpPSS
 14W6+mYhciR7DIkqiatVpILp4GSlmmMQ6XyvO/PxP6OMKtpwAPl02WbHXEsdBBu5wCLt
 i71xkJWla01LraWcxR/QsiRGhRlgdTNFiK/lJQMaODCZfnjqLumXMTTqdSvFtciAwHcA
 7YmQ==
X-Gm-Message-State: APuU4Z/6U0SzEuhmYbIRtVrQrOGGzYIatqty06FEboC+KvW2zI8HaJdJ
 +PpvbCqhbWBzgrG1myKF2NTnpWCw+oBCtq5ajZmcJYb/ZJKT8THgFDvNTgH0sHcOEZA=
X-Gm-Gg: AYBFou1Dd67uEt+oGIJprp8OF4pZomz6pruG1ujUd5KCUGIMMhyqL3+sj14m/OIdj+a
 OX0Q9zd5WjN8zpw28PbPON/l3XCVPr6h4+vsWxIePpoLwAOIxy0gsJIY71hfRwNK7UWkqckFo9I
 IOX5ThINIi2i85RUpNTdUNZJT6tIugd6d/6KJ3WyaM6KrHKVemIAfDu8k9Nlq7AkFNCoTslyBBS
 4lNNKLHnu0bbG9BqfcZafKiLaZPZS2amOfljZxN1u9vAuB3E2zYPGYckNysXxZt8X3o+g0Fvzt7
 1fSqGiBuSKYfMwE6mSs5CAnJAt5Vn66GSD8D8YwbFoyrBtcRRkCsNs1ECPw9vlu2DnurXiFSpIp
 jnD/+K3L99EHmmR7amkMv0MlHXywubXzCmiqGqjZOoeh3NZIZ9cvivtnJL4Z6ZhFERQDMlwJxmU
 lhv1WfnsNBvCjQjNjs2AjF1V7LMVpooRGVpwDWvVS3bbHZBqn22x1q0YefrDZ3j8AcIpBfbnylv
 bObVzGCswlUMs/byT2UMIzJC3dPAHJFO+yeuIW5cJgm3FRs7bekLc8YdkmlF7n6Cr2uOHdvimuL
 UIsEA2UCqdn4r7MDRH3SxEug/vgURcSgLA==
X-Received: by 2002:a05:6808:1246:b0:567:cbf5:bbab with SMTP id
 5614622812f47-567e14643fbmr2658413b6e.60.1794001019893; 
 Fri, 06 Nov 2026 13:36:59 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7e70338sm2475624b6e.12.2026.11.06.13.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:36:59 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Nov 2026 15:35:55 -0600
Subject: [PATCH 5/7] arm: mediatek: make the BootROM header info configurable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-mtk-genio-720-spl-ufs-v1-5-90c578b6c43b@baylibre.com>
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
In-Reply-To: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=OiSMCvjFjHclHsbZAaQtNYQKkGg9XL8Df9cViWu+BJ4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7khbeVjzhReiivXpZB88SqJH8U/R6DoCTUiTu
 VQiA+h+f1yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5IWxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AwjQH/0RVhfnaVHCd3RHUuueUuiOr9QsW9jeqWSEDX/D
 shhM22eWUcHrR/PhLGVyUQvADvr6FoI3DNsnOZbDOjqBHSBV5Q5pJPIl5sycM4iPr3duAP7mlCe
 RMwOwkz24PwcHBAa90DBvN5d2VXfLpe1R1pu6H6Es2b0yyHXEwdDiLvzlwq5Wl8E/QsqlkO8y92
 H8zeowb4xRwYOPeS2/YsgK79Pq6XlvZ8G3Fn2SsJZrvNfl/pJn8kUR+bmLdRx8PJjRm9Qjn4+9e
 fPvfcsSKAGHiRsIRauKF3BX+SYg3N3xcaX7zvCpp52d6amiB1uyZRgkuEJCemHMS5gN0fKKQrA5
 UYB4=
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a prompt to MTK_BROM_HEADER_INFO so that a configuration can
override the per-SoC default. Some SoCs can boot from more than one type
of storage, and the BootROM image header has to name the one that the
image is written to.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index fec9601e80c..4f7bedcb28b 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -221,11 +221,16 @@ config SYS_CONFIG_NAME
 	default "mt8518" if TARGET_MT8518
 
 config MTK_BROM_HEADER_INFO
-	string
+	string "MediaTek BootROM image header options"
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
 	default "media=emmc;arm64=1" if TARGET_MT8188 || TARGET_MT8189
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
+	help
+	  Option string passed to mkimage -n when generating the MediaTek
+	  BootROM image (mtk_image). The media key must name the storage
+	  that the image is written to, for example "media=emmc" or
+	  "media=ufs". See doc/README.mediatek for the supported keys.
 
 config SPL_MTK_FIRMWARE_AB
 	bool "MediaTek firmware A/B boot in SPL"

-- 
2.53.0

