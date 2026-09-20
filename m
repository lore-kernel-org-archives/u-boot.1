Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D12C982D8
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D677280DCB;
	Sun, 20 Sep 2026 15:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cK-E4ueHnrdZ; Sun, 20 Sep 2026 15:49:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2BD8C80D8F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919342;
	b=Kqm+rc0RsQXZNnkTM7jM61DOu013U/q+NdUCno/ijryuiOevJZ0ib1TqeC59KPdf9KDa
	 cZEfH1UqHZEue33fiMByfgcP2Swvyg4YuNCa+LiopEK48uw5D4UEQwOVyD13lNtVtE3xB
	 Ib/VEAr/brlNnwOpa3EKF7woKfpG7YoEpagzGa4SKjFgYzCkYumXuu0P8PtE8UbY+nlgJ
	 OVUXH4AzLL0AwWya0X2xv26J0/W82eMb8RuMcO5A7hOpjWXAAb7Ct19mIive7pJqA98xn
	 Hmceb5lEcfY/sDLuuIzQoabhiTbcY7nuLBsbANPhyT3upReaXacOa4ETgi15LcVzTDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uqeOV8zwTBo6xZ6i1ntB1S42/0TTd8YslVJm71uv4zY=;
	b=FSoBokPdJJXR6RQ4ubWPrQsGmqVzkKPEL4ZTMWcHyYT8IhC+LfVYAsnFFyZ4yae0vl0F
	 1NhS23sqdOpcGOKkMQoqTJqBvA14H84iIDny0SSjHTtSiaZsIf9lp4+uZJ+an2oqvsoFo
	 KYfKlRa1W8l4HNp6kDquJYDUOOxu6TcByemj2Yov8lUSmb2j+CxnKZWXGTO7Auncne+li
	 1i30G2ZFkvkDN6NQw5DkcYpExWoDh753L/SPeynmmXkssjV4B3LQVTBW9NJuAvmxzz/bE
	 CpdkgdPq/592dD1mF5V9cjVJ83sZbbt3d0HV1xvnRDMCUK3n4IcXSuzYW3IJp3z4b4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919342;
	bh=uqeOV8zwTBo6xZ6i1ntB1S42/0TTd8YslVJm71uv4zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aewQN6jW0otg+YkT33Drt9L5A56gbtTpM/+ygzH0CAHLOYXAX/FvRm5tct+8TIwQR
	 ugMv3ufdS7MoUFgJ9d4ToI9iEO825MiOu2mzsvFHkUlAWhBxw8ePe4L3hvka4/eS9I
	 Th3AJwPC9Fp2Jkf66eyoUjtN7XoTqsUZDkrM/b3Syeq1ch8k+ckiiJjBirpqCihCgo
	 m1LwsECLSrLQcP94PRFe6pbZJIxQWAngQ1fSA6xhdXLaI2aC5drU/VbQL/Q7HO7uuY
	 L+/lcBxL7qOHVqFrA+PbkIIPG9OS63h9TEjUlNOM05aA83YI0D24D95gr22G817u1Q
	 9YjziWrQ+2gTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BD8C80D8F;
	Sun, 20 Sep 2026 15:49:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B118224D
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2F084009D
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:15:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id noLlHshFBXo8 for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 15:15:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D5B584002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789917321;
 b=K+bgT6rWTQar5CxMdm81D91Ccn258cOgEOdp7voRyGqiCXWZq8JOliDmp1rzkTgof/wc
 lsJpWPARP6c/HaM1MIAzNDre10FlRistEHkSTFG9uO7PWpAsY/VfcvoOs9R1IB0bNPgmo
 t20BEP5nkVXf0iTBHhYYRKV3r5PfmuIdNdplk4+G6rpOnb0yBhtq+P6q8jcNU4FZtWBJm
 5z/puqLi7VSm3KRV/lLQ34Wp0wxc5c5NouYg2scG+62dq4x3kKbzNdvdVfdZS7ub592Vq
 zIuNPXdZgKGEC64lObpaQPemkVEhQR01lBTtkyKQTvXN/tGeL8rg8kXcoe+jOcVmkZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789917321;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=uqeOV8zwTBo6xZ6i1ntB1S42/0TTd8YslVJm71uv4zY=;
 b=jDrWDAIojP/V3DG+JGgaXXEWD/lpr5LwWiyk/rd1fSwi/kSdInfHYBLjmAWpIDmUJezU
 FHIpY1GHIRxD8TRih4KyOt8W8trA4C/VH6N5O1xaawCY205jkUhW0IbNlU244LwkJcsql
 obdSJKh/f9mYKnis2XL6TbnMt8d0cQ2zXcnAGHk+tMPqOXptsbwenQf09cBTJwUUJK1xt
 gwwjsVTok3MBCCcn/liN3RGeUHQF4/dsUfgpqg5akhuJ7h00SSeL1ZN8pZO7NiuAeMjgL
 9UnF7cQYOiTx+E/KlQ+EwNb4Db2bmaVwj+cwtt1aZJXHQ6IcZJyE2OWpQXk5gppev1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=lex.la; 
 dkim=pass header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google
 header.b=MS6Imc6R; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=f@lex.la; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=lex.la header.i=@lex.la header.a=rsa-sha256
 header.s=google header.b=MS6Imc6R
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5B584002B
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:15:20 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so12599885e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lex.la; s=google; t=1789917319; x=1790522119; darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uqeOV8zwTBo6xZ6i1ntB1S42/0TTd8YslVJm71uv4zY=;
 b=MS6Imc6RTHhX6jRdHjh+NLGvE31Pc/O/DkJtCnsqvAuCF0k1sVdiq5LOLHXmPHhNhu
 uvxMdBfOnQEggnSKitkmiBaROCMWFflXeEovaY2L5zoW+6BD6jnMJAmO7V5v73levNJt
 fFeeTwsOKmCO/hbU4aIHKIECVvcwAZmgrus2IJxUvGTekSlAVA75fKX5C3FfSyqM2CMF
 JaaETtcZy1vNNlr+SWfb4d7SlN0Dj6EpkRqnElpiv+/iyMQON3LhFuqdV7tbH4sRPlir
 Z6D7PStk/1t+fBf7E1Jae/qle6LCcmVP/HUz5z+7XsZ6AY1k+JCOt+W6PonjidIjjlPn
 HaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789917319; x=1790522119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uqeOV8zwTBo6xZ6i1ntB1S42/0TTd8YslVJm71uv4zY=;
 b=RN88DIEMDG7keJwftXtfFjy6Il5hFCoyLv5YF/cwr+YUbmMLdbz2i27xjtUe12l7lQ
 1YHcbvkj7cTw1fYx9BZ4+sJqRRiBjUxt0eB4xgiqkCACBzopeOd4AWRoku5uxoP/e0hL
 z4IUaI5uF0Zp87yiqY7wyDVXnjZ2tr0CLjE68oQpOgTtDgr1Tawzd8DJDv5Wb0GdqXat
 vmFKdFfu1Bxmta3Xu7NmjWlisNir/3VcW24qT5+chWwqkXGgK2Lm5ErAnATsXUS/8Dqn
 TPp+NVN/WkVSAkL3LfheVTOoucy9tL2ln2/P++SpfAYvWo8sTTggnP+6Bw9+VPOOIXUs
 0FxA==
X-Gm-Message-State: AFuF++lJ4jzJ3Y6khJd/cNaIG1elrNvABuq4GDnWyjfbacZz9WT8e8kT
 sGtcK+JblHvkfbO8qKeOC0XSngEHks556bqA1yEFLORvv0q3EkrGoM61jIlWUMpO4bQ7m+2WalS
 gEUqHMnb40A==
X-Gm-Gg: AYBFou33chU4a8QFF3fuS46l7lSFiUBhD4h5vKXUbAzijzJpyHpMxmXPNfLamPQ0kTY
 IVAdY6M/l7rpYWHMTKBOGdE6taLlhoZzlVMBs3oF80kmQ+qhw9QzDdt3HjsgPLERyOqYxiWhKq9
 KBF7Hc3iyzBJlirAlr9M3HDvHRUDZb3/CoeAd239u4M8cqZSDL1VdjXHkMaiNVcgEEd74nrJg8c
 FjlaFstBImHUg6465sdT1r6l3Bv8ftIniUnGJnNxPIk5gjQIdoNYZwheGgNXDxFlpoOkSQT2Lzy
 JEmUiCNUTh6GdnqVfOfV17lOnLZLIfIEV/j92PuN75Vx49va2KvVyYzSxVg+5p85q0ai2EeI7uU
 dNc4dQNv/v0b6gCvS8r1YMsA9ODKjw6cTayY1KH7b7mlrHoJP9EPHlbx+Jh9ALOYg+bT4a4ENIP
 z/cQm3ojM4tW6Sd/0ho+12P8/2YwUvnMN6Nzny47LadtMI/Rwu9SAZOYUYu59a
X-Received: by 2002:a05:600c:6211:b0:49f:c199:e1e2 with SMTP id
 5b1f17b1804b1-49fc5851eaemr100899515e9.28.1789917318785; 
 Sun, 20 Sep 2026 08:15:18 -0700 (PDT)
Received: from remote-01 ([84.17.55.230]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd3bd69b4sm11723105e9.8.2026.09.20.08.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 08:15:18 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, weijie.gao@mediatek.com, ryder.lee@mediatek.com,
 chunfeng.yun@mediatek.com, GSS_MTK_Uboot_upstream@mediatek.com,
 ilias.apalodimas@linaro.org, Aleksei Sviridkin <f@lex.la>
Subject: [PATCH 2/2] arm: mediatek: default the kernel image header text
 offset base
Date: Sun, 20 Sep 2026 18:15:12 +0300
Message-ID: <20260920151512.401899-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920151512.401899-1-f@lex.la>
References: <20260920151512.401899-1-f@lex.la>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:48:55 +0000
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

LNX_KRNL_IMG_TEXT_OFFSET_BASE has no default of its own, so enabling
LINUX_KERNEL_IMAGE_HEADER on a MediaTek board leaves it empty and the
link fails. mmp, rockchip and apple default it to TEXT_BASE, which
gives a zero text_offset; do the same here. A board whose stock loader
places the image at a fixed offset above its base sets the value in its
defconfig instead. Found while chainloading U-Boot from the stock loader
of the Keenetic KN-1012.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 arch/arm/mach-mediatek/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 5e6c50ca64..8e10e8c820 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -215,4 +215,7 @@ config MTK_TZ_MOVABLE
 	select OF_SYSTEM_SETUP
 	bool
 
+config LNX_KRNL_IMG_TEXT_OFFSET_BASE
+	default TEXT_BASE
+
 endif
-- 
2.53.0

