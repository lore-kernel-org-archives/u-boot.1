Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF2AF99C6A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 21:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54D38420C;
	Fri, 17 Apr 2026 23:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aru7pR66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D28E84223; Fri, 17 Apr 2026 23:40:55 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29464841C8
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 23:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-46f0fa0e398so714559b6e.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776462052; x=1777066852;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZzErNUQjwzxCKkq8O/3lyh5qkrPLW92i0P9B3KCyms=;
 b=aru7pR66kPgyY+JJYy8gjW6UztRjYJ6tYqZY92U+cJFZ5D+5vzMDgAIwiGEtqZkSEo
 4z7YuTxN1Vou7Qfk7IchhS0ZX2BG9LFEscSXAsVqIRVvr1VSJg0AxyzLARGq/J/TTV0c
 RhiA0ofqM7Px+f+GkUqrKWzB81OT+m7DdKlj6dPjRRRYUyICA7uygVKBtNoDstdVUO2W
 NdkEOzBeEkUfl2P+LXCVob3geKXGdkYLH53WwDMfc3hvphQfiW9SMV7PKIAiIh49++Fc
 INP4VSFBoLrFFrPpJ2V0vHPPH9h2+i7K7w2WoqpbvYy92FkKaeYAfCmqss6OjiGuNkM3
 4BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776462052; x=1777066852;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fZzErNUQjwzxCKkq8O/3lyh5qkrPLW92i0P9B3KCyms=;
 b=HNMC5r5GxqvUfCkGLbdKSfFuB3YAmvT67UktTIQVLoXC6ZI4ekZW+d2ps9P/Il4DVO
 C4OfomSnPL0VbOa6piPJ4ykIkHuO/7UwmdW64ceDOZxOz5tPuEubFXT7YkJTQXclsC7z
 /jnCwduYZ+C/WakYC+bofCUIOgTm78DNHHu1tPQjW5eQL1ZSKlQSH0VOBVfRmc2qen1h
 BTsnvMEJYZYHoSTJVDx378Jmh09QG73/heFfyqkm8g+3WPC3rUexcY+pgOqocmhj3eNd
 yepry3EgiImCIpJLzpKXkBaktuXU9rn8maQo8z6UmQ9cIFSsVEiYVrbkJ+nHKBIqT5b/
 mGfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ84n6LuVlgmUIjcXsbOwcFr2dQXPH5idz8riEtJoFvPWMdWkEosSZbgHH9YzekpUZ1p5Fh9JxA=@lists.denx.de
X-Gm-Message-State: AOJu0YxdBybHV5nJ+ieSZdg9dCQS4B/m784s34ZS1eWFQKlp+Uxy7JG+
 qhLaBMGEOTcQd8W9BFTTwWBFMdOKIU7mWgYqCHYioUo/gWCFv0fUTxqpgJVYE8z8jKQ=
X-Gm-Gg: AeBDieuPQfn1n+2ONZlOBT2ol2hbJ0WrKBZ8iRSHSusU5YWZb4mol0iH8kH1uUOLwIS
 OCQzXxZ18Xw8i6wanFK5b13uzTRCgugxJ5JBCauVqEq/xb43gzTHESeSKcM8JmefVhLnyw5Ck0S
 f7AUx9mk/MYlVfDoxbY4Eg4ZH99/bZUIUMeI+DbYZumoer7NF+Z+ROc2c5An28HHYtMjNLNRsrd
 Sa5M6FKaCJxG7u4kOmw6261PKkb0jFPuDjh97H/bLSw4R4oKN0EyjYe8+0feM/89dyowASQgPIx
 w02NhfJoZKm5wOqt1l+0G7jcHYSAXaML6jK8yl5cA0epRKxofGXooH7S6wqGUfAfWciLas7NVog
 B7qen3OTFH0R+DTOA2NNIYa4QvbvaPibfQppkXs9X3kl4Z5nFlxaqixtXqTJy+8+N9IyyPjMDqY
 q4dp/zhYe/UJ4ueY/A8+fjwPCaMorxqr8wiTYBpsI7qdFSea9l
X-Received: by 2002:a05:6808:3447:b0:467:254:b90 with SMTP id
 5614622812f47-4799c876f79mr2436710b6e.10.1776462051800; 
 Fri, 17 Apr 2026 14:40:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ef27:3314:b886:cd3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4799fef6dd0sm1801357b6e.5.2026.04.17.14.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 14:40:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
Subject: Re: [PATCH 0/6] arm: mediatek: add UFS support for Genio 520/720 EVKs
Message-Id: <177646203771.59267.7634760092135792833.b4-ty@b4>
Date: Fri, 17 Apr 2026 16:40:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=OAxVs27DM09A4pievlGAH+Ue9bFguIdgHipfxITyGM8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp4qja+rjzX0hUQT9jEoKEjCilSoX/DCt45DEI8
 qC254kzWcSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeKo2hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aux4IAIDAfXIBVJgl65Jj2m6jUlo8Omrxt6JbHCnO3up
 ys3PBDU+K0xrFhHgWnW/Bg24bQUAKtUNYKFAyCFXeugwcvQra8ratoDdaZ5VKDgUtuN/WJj/LvP
 IKvNzib7K3+ifh5Uk/iM6VnRtPyVNhTZRcKqQIYxmUE2vl7QdigJPzhhdYo/NmCeyZV/gmjJErI
 lILPa+H8QfCGFBqEoHASaIV6/2cvRZGR9XwCEa2FIt2UUQhz50mgauRUuYwug6p8KBfWaTz+wyo
 3TvWV4wwwvXReHR7x3F2aECfsPmJ5c5agKKb36c9tF2Ombd03aKYRKCQG3H03g8tdyAqzoegKyS
 vfNg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 30 Mar 2026 15:42:12 -0500, David Lechner wrote:
> arm: mediatek: add UFS support for Genio 520/720 EVKs
> 
> This series adds support for booting from UFS on the MediaTek Genio 520
> and Genio 720 EVKs. The first few patches are adding missing runtime
> dependencies. Then we add the required devicetrees and defconfigs.
> 
> To apply cleanly, the UFS patches depend on [1] and the devicetree
> patches depend on [2].
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/6] ufs: ufs-mediatek: add mt8183-ufshci compatible
      commit: 816fb59203a15a0e87afffceb28e0e05341a0282
[2/6] ufs: mediatek: clean up zero terminator
      commit: 10ba04272df2c4cec966f83dee15d854eed24b69
[3/6] clk: mediatek: mt8189: add UFS clocks
      commit: 9e966cd1c93d369c69b1756b9d9209727255c7bd
[4/6] arm: dts: mt8189: add UFS nodes
      commit: a6c71f526caf7dcc4666a2be7154490d1e28c72d
[5/6] arm: dts: mediatek: add UFS variant of Genio 520/720 EVK
      commit: 31719a47c578dfcde4da62930df628f564d48499
[6/6] config: mediatek: add UFS defconfigs for Genio 520/720 EVKs
      commit: 9bc9e17d25d9a91a717f5b483a54f30abc5b2d1d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

