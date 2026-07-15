Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542D7C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 13:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6878484A7B;
	Wed, 15 Jul 2026 15:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Rt15ES3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB2BD84AAE; Wed, 15 Jul 2026 15:13:50 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94CD484A4B
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4a46a53abc9so1446589b6e.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784121227; x=1784726027; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l9sixlX5YMrOOmyT380/x2nIEfmYVDtDqsvSuDMG+Do=;
 b=Rt15ES3W/2eLSvtHCUJ51A7Fpuq3owoH3pBSjawp+69bB62ljUexZ+s/4Q81aPV3ri
 eJc8SpVLeoXiCJ3TGOpFfRp/ME3eOVAkN9wEgccb1B0SUE91vjE7hZxzdNgOcy8Y7DdB
 Qv9trgeRnO7KgFeABklfp5I9/juiGQlhJbpWWZAKUW7tkhgbY5To4GEOOvf1s9O+2N80
 FceEDMmDvhp9DXpEspUiatW2H7gAJuL6dXfEg/SHgvcvKNqRjDX4OG9j8fnXWchoynuv
 g23XtegB1KSuKxovWaJCeK7TDxu4C53vDUMpvyCQBN75yl4Wtngz5rLb90bnTp3J5cal
 8oeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784121227; x=1784726027;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l9sixlX5YMrOOmyT380/x2nIEfmYVDtDqsvSuDMG+Do=;
 b=la2IAd6bfFPJzt5S7ky9Ebp1kryTK24CyjqB3GwA/BgkupvXI1qDXYkd334jXIG99L
 6FG/qP8ALFu1K9kgKXk2uXFJyzvJAq4bnsdlR9Dob095UQYBgNlOPwTx+6w6hhCxRjMi
 rEbUmy9c+SEq72hnNK8Y7ghez6sCF9SjfBIJyVqWcQCMIjARxe7lUkhR3ijjXuFYufF7
 cYUuKURStf3xoV37TYBD3+K9+hxf1D8tKz3eNCJDQ2SWJq9ulKGaqvxbWD0ioKuo1XGn
 zAMaV0+Mb4zJYTQFuKKkulJ5zaOxk0o3nyZq1QEPC7Z3cOoQo9r3Z43Byda+9wvpX6vg
 /JGA==
X-Gm-Message-State: AOJu0Yxghm/Z6Nfx9rolvyVKrvX5jMElhzBHdptyW1McHEsMyyBjdUOd
 zh590RclLrFrudH1uQwgTaYUwPNMk383obBfWLeu6bKsaoFWp36XEeQ2dQ6y1ByMEzQ=
X-Gm-Gg: AfdE7clJJlYU6r5n+767u8tBTf4xiUJ8JB6naI+BPAHau7wnC3m29O40735QOrKYxhR
 VuO0+f8buJfxUyfM6LmmS7538FK30+69Qs19E71cPlYDGQ5GDF1FN4fEYVnvC23222L6RrH6Kve
 ALGwEJWAEQOF0DoGvE7VHsF5J0KEDcUgpk9tJQvLTjezVARzDTmxlv6wSdZSC7mzEgJmA2RLZVX
 eRMItPpg2d90GI8C5j0+hGLaHSPhHnmdivpIhM1EtWIRw7hvC7LYriMhn3AEI7TFe0f6r3f0GjF
 CPCjghnH/lHIc7RMp9KWU1quFWIlBLtDaTfinVP0414w2otidyUgs+/JCWHDQdCcLI9jRH45bNO
 0+HtM6CJL0ySBoo1TZ1KZhWtaDdhFv1DpXc47WZiUWlp/dzqk5buc7Bw6GuShJOeHwAfjsEiPJ5
 siMHNFQXTM1ID8gaE4Eg==
X-Received: by 2002:a05:6808:179e:b0:496:9b3:486 with SMTP id
 5614622812f47-4a42ae0a5e6mr10940141b6e.14.1784121227291; 
 Wed, 15 Jul 2026 06:13:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2b99:1202:cb56:140a])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a42fca3bf6sm9513933b6e.9.2026.07.15.06.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:13:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
In-Reply-To: <20260701-mt8188-clk-add-missing-clock-in-pericfg-ao-v1-1-13109b199248@baylibre.com>
References: <20260701-mt8188-clk-add-missing-clock-in-pericfg-ao-v1-1-13109b199248@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8188: add missing clock in pericfg_ao
Message-Id: <178412121094.1218700.5307022475294742118.b4-ty@b4>
Date: Wed, 15 Jul 2026 08:13:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=339; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=78fhlZsE9+kZiok/wG6Ifcg6gZAUceUZS+UlZ4dbMf0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqV4eB0Y9ufbkkkdkbVOU6Mf7wCFPhmUrMPKf3N
 x3kAtpOLOiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaleHgRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AqtgH/jGWStcLbUeo94hI6IvaolDmgRb3WgvspHkkPVg
 sM1YGjdAFgDhFNqXosNiCapaHhD+Wt5+UESXFsrs5wPwDPwWuOY9ar3Bu0uLH2hce/vTnCGG+y+
 36+JNI8l7sykozi9xQ2B5QQJqf10Ve+dw5Jc457vHOxDzBX7+g6ChP+fyKivE2wAwhKoihgyzy5
 a0Zk2OxwVWqZW/EamsYMjwWsM8yvcbQG0lF74Sdu0zvsc4fFvyCCd4Q7k962bMO9GjihZKGQ/VB
 IZU7bxBnzTQaezDPtSodW0nuq/kB3/Z5Sio06CMXk55gpqjCDLVFsEsnOYNkRwADsiiMTJDjzVS
 5Svg=
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

On Wed, 01 Jul 2026 17:13:00 +0200, Julien Stephan wrote:
> clk: mediatek: mt8188: add missing clock in pericfg_ao

Applied to mediatek-for-main, thanks!

[1/1] clk: mediatek: mt8188: add missing clock in pericfg_ao
      commit: 424a5f2e97da1942ba2bfa8eff2564c99dbd2a51

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

