Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7AFF54AC7
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 14:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E192680212;
	Tue, 24 Mar 2026 15:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Byn0zTmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B461C80517; Tue, 24 Mar 2026 15:41:36 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DEB780087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 15:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d751ef36ccso2063780a34.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774363293; x=1774968093;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycEkj71xjlYKfA5k3htDVGudW9AHqTmVqtFpLTVQqEA=;
 b=Byn0zTmf4MbhPh3O7N0sWtFnCwuW/485SKJlv5Nxiwy/UN/BTkIjQNd1jYEBFhQ9AW
 mjVfH7HXcM6l+Eh0se+Z+SBGe+anVY4zWVSqIEIpkqw/238Um53d6U9TStYU1NF7zniI
 q0z9Vibj6hj9HgqW5Bhx065D6oYzPZ30prmbQ3FtNQMBbM9eTwpcpGBr4nzJ9ZZW9Jcs
 jLCojY05OaCnt5NKKYIJdeqor/+lzp1aUiAZ6mO4NEnFRYBHFuYl3FCouLzZ6bXLDJW3
 XVdpn2XhGBxNerJSkc9LLCQQRLC+iu7FWDxYck9KrYIg3aFJFX6zx6oxcBHEGNltI2ft
 /WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363293; x=1774968093;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ycEkj71xjlYKfA5k3htDVGudW9AHqTmVqtFpLTVQqEA=;
 b=cJromtDDTA6Cin8Wc6pC0LEhFfd0TBcj61NNbH7wcx99kTnln+WBW1gvCDINeNfCs3
 /6rJqNJipMjreCGfCXnJNv4UVd/l8+deoDGitPCvf1rrItAU+IqolAcgWNUArakHLDrK
 Ugy83QcynwN0ZjyKoocQ0IgPNK4u1EGuZah4Xo7up8/H/QhWMJXHibJP54WWH1uRKZlF
 5T5qXOgNf3PQEqES93JLVfbWTuoszinX7YavwQqALj1TVTvoR93ca5zJz3M4h+nv5B9M
 tJrgY3blp3HQyUTKi44slmODZKCzYwydKut4H2IIs74hQEcBDbzWEPSvypuxOq/IF1Au
 hBPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5MBm3Pu5dOQQdH5T97S6/JHUXQIsziQBfmNNZUZXpC6KZ4i3zT/5v/LKnnun2kjWM2mmGPbg=@lists.denx.de
X-Gm-Message-State: AOJu0YwWQUTlPZzpeAyTNZD+bNQ+OJVyurDcIqFz5YYV/Hjso+xEl+UP
 osxRZqhLsrAuOrwosP/oULKKQZadrSvz5jhMb/TTCZl5KxGXh+3AScT0/OzJj2Qvc0vrbjZNNrH
 OaNZX
X-Gm-Gg: ATEYQzw1sNh9dBGdqnTi46Qc5bGbpBYiAewnQyKazn2xaRCL1BRGskT1NxCtw/lxkMl
 avgfW/we/9iTA89ezJDUabNAoPwzwLnQ3brTZaDMvYs2J4ngGvo3PNEAJe+ZcXVANOTm/s14j2c
 t+ES5/FOo4ztcH6qHTULHRSW4QaZvT35kdaFJEbjOegmvO1SShQSRR5WZMKMuzXyI/nJpIv3Im5
 KOar3xFw1apmBwaWJZA/0zYaFY9PX2f5Rz4ooAwS5zOFYGuGfOuPVKkXZmlqr8m4oZDxqh2pe0R
 8XEQ+LcgWdF723PZmG1jU9sriBAURT4rdQmqeSZWIgPh48tORJ5VUdf2BYHchuxwJ5Wz3QwvEC+
 w4WODEK0a0S+8C99mWB0p5JZBt6ktdzEi6qiOXnKcZz/IK3MbjCPHzmTkqc04X74T9CXKFMF03C
 97FUsEg0RJMADQD0NuUwt5kZ8XCvk=
X-Received: by 2002:a05:6830:4118:b0:7d9:ad99:9ff0 with SMTP id
 46e09a7af769-7d9ad99a072mr7244010a34.30.1774363292927; 
 Tue, 24 Mar 2026 07:41:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a85:a776:3f75:a1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eae62322sm12263379a34.26.2026.03.24.07.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 07:41:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-0-6ee4743a8465@baylibre.com>
References: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-0-6ee4743a8465@baylibre.com>
Subject: Re: [PATCH 0/2] clk: mediatek: avoid more "extra" topckgen clocks
Message-Id: <177436327915.2186727.643832596729660503.b4-ty@b4>
Date: Tue, 24 Mar 2026 09:41:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=lsyzi4sorDGK28DBjAx6ptBezEGcH3bGT99biTjcGms=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwqKTycF1SRjADsINlwGlQD3udaNgW5aD2s4Jk
 itcmyEklnSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacKikxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuiUH/R3cLDdj/hSChJJgP09pTHlKpYyXcaoSUW8jWs9
 5OWYS/sD18IEBPG8tshRE6H6Im+NIUQIO64iEfWWNVeZdMxS9V0neAECsDwnPJZP0lOoi9FRBAA
 giODGwExZ7FsB8jrmKDE77soxryneeZEGoMVey9EtUWh02nhzs8FFjoLe2JnVWIecs+g8oo1rrV
 qTOcqJDV4byO9JCePQUwzB6p9YvTiTXizMccOvRzTlxgET/5fO5kLJC2SQspBE7ouYaD1FhRewL
 hpqUul8mkM0vA7oxvw01ENzBswA3qUVAof3hRbzgo3k2v4PgSnnotr+7K1AiKDvv8DYFf6Ocrf3
 yzr0=
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

On Mon, 09 Mar 2026 17:51:09 -0500, David Lechner wrote:
> clk: mediatek: avoid more "extra" topckgen clocks
> 
> This is similar to [1] in the goal to not add extra #defines for
> topckgen clocks that aren't in the dt-bindings, but in these cases,
> we are not able to fully stop using the ID map.
> 
> [1]: https://lore.kernel.org/all/20260303-mtk-clk-8365-drop-map-v1-1-17f81c375290@baylibre.com/
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/2] clk: mediatek: mt8188: use ext_clock_rates
      commit: 1e1654c7dc9c2a41475feafba65cd2eb5ce5be5d
[2/2] clk: mediatek: mt8195: use ext_clock_rates
      commit: 248b8b9bcca8c14c7a21af9567136ea0e351f8f7

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

