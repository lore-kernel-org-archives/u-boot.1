Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CA1C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 19:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DB55809C1;
	Wed,  5 Aug 2026 19:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AhmCCf5JCi-Z; Wed,  5 Aug 2026 19:47:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45219809BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785959267;
	bh=v1lW01GetE4EqXWLTFkbGiEjdVd9jELn9X0uE1OBtbM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zLQoyWoAX3MsFxNrFBbqKHv2kSNl9QtR0OdWVo9HRsOa9MGZPVzqgVTkikdgGm8JC
	 kRKR/81UoQpH9gP2HDeU3UyOuH3CiwPlRkoPtOizu4blJ4cQ2yQEt+4k+JoyN/df9s
	 TAjDGHlMboe0V+5sfXQspSxEIW76TyHpJIAaEq2H8OU6UoREwz20xAlghZXiAsxcyW
	 rYwVGGvzpozh/d5THXjsogf9jpJw6aGKfiPTb1fogNJ5cOBH0VqbaPzWWuixJ+0zgk
	 /Et8y06MoOA+tk6kWDmAEMPGGX4Wi5cIwevhMCzkwgF7TTC01XXTyu0u9dt5aeEA/e
	 Ji70C0W9gZowg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45219809BF;
	Wed,  5 Aug 2026 19:47:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED7DB730
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:47:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBAD94021B
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:47:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JciUmezEx1pF for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 19:47:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0F8944005E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F8944005E
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F8944005E
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:47:44 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4960fb63c75so912982b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 12:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785959264; x=1786564064;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v1lW01GetE4EqXWLTFkbGiEjdVd9jELn9X0uE1OBtbM=;
 b=NAs7k5bLf69Tf7I4Y9FS7GZf57FZLRtIJCMAmK/gwbz3G6ezxQyiVru3LTofYx20W/
 oxrhprDuSrck25cvvtKTk2p7wah/bPzoMG9UE7C1E1tUIuxFEpuJ9jTklrpFADjxeqG9
 AhXJLaCrhi6kgcrlAKMMF0yBe7gotFLneySDWLIMeRkfcgRHtyn810EP+P2Z5NvNGZrI
 93bO9sj9OL5IYOrHpwwC85vdnmrFlx8BQIW0hDa6UgA2GRnYG9lCx7Nik3IcetwlJ7Cd
 X1zvisFai8yFWRgWFfcnvtqeofi8fTx7Bdw40fNcXZL/mXfW3gUJfDGnBZ1hty8ke0Rw
 J2rQ==
X-Gm-Message-State: AOJu0Yw5o57Cr4oosg9EghOoGiDRLCTr56gYmJuhmvJOQX1wPcxNmMgY
 58dHwF91P546qA6LORPaXeJZPbuQvqFzX/5lK7NMqAxMmgg2QAQZe4tZ9r5fQbTlod8=
X-Gm-Gg: AR+sD13KCS3dPI0J2epdCIWrWIum40QrJsa7sKqP1UlTEjyUu+xjA+j4xe545NG8chT
 bMPvbZy/RMU85LfuIoeEzulWFkVfd73YpcxlQwjvy0iWJ0FnNRrtsiydfm7g87CC0pWlo+PXKWf
 Ux9+A8ouhsKQCCtOqOqZG2WoAJt0qO7j/xpW0DnnKThFC+AEh9TqWHnR4xEkH3b1c+RbijP1twd
 ohm2jk6/r7LXd6cRnySRNFLAH28SVqnMI9e1F4223bO9beUvovwDJtI860uw+w3TRRHI5DpsWGV
 Rwo6BmU0jVjVcAutsdfozaKyOVoV8VG5Ybx9NymD45YcjRStJyUVP8iSBh82BLYHFRnpOpAuXn2
 y9qwUXXYYgBl6N4KJUNEZyPh8EcdpD3NNiA7KBE9H0zoecg5Pr/+jx29APokhNqg/UyJdC4bzUl
 kr1JGFYwvcbksBcR45md1knt6q/jLDdfZeef4+uWsyNKdU5yThqutj7SLbthXXe1p2t70e1mXMg
 VsU
X-Received: by 2002:a05:6808:1185:b0:4a4:934:b316 with SMTP id
 5614622812f47-4afae2607a0mr4860047b6e.21.1785959263851; 
 Wed, 05 Aug 2026 12:47:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ebef:9550:d591:36ac])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae75db20sm2714380b6e.14.2026.08.05.12.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:47:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20260728-mt8188-clk-fix-top0-gate-polarity-v1-1-56bc92ba6055@baylibre.com>
References: <20260728-mt8188-clk-fix-top0-gate-polarity-v1-1-56bc92ba6055@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8188: fix top0 gate polarity
Message-Id: <178595925310.2270888.10704813531556095827.b4-ty@b4>
Date: Wed, 05 Aug 2026 14:47:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=321; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=wKVNVP+SDE1jBggi04e+wo6oAds9Q4PMhZtPwNHO8JI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqc5NXOpvwLyRnWqa+AWe9RXe0yypk7jP5xDGlq
 4Lzdc1PzOOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanOTVxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A+Y8H/AlQE59vmjOl0gBEqpRfv740AGqJYFurZz+lZe9
 rvBqdzzBdyu7jIckU5/lCzkHZjMX/5RxmzNJc6ZEDEe/ZxkDe11QRLEmBvm0jJcht+LLyq9t5E0
 0wc0YnRL/VISzvydBMvRRFQP8eOXs7AIe/cf44TERsCGN1a2DE3A487/ic6ApzWM23CPHE4COyO
 feFVBVP73QuL8EmNNcbH2Svwnk2NqOZdknzloukbecXc8XdzCh5noend0A9RGVzBeWif2j4Ys6z
 /2jVT5aJVXyym1MZVp4CMbYNS9e27x8L0yFMhausJ/GwvsQq3WTFKOeRzdmHLZv7g2XFwteNAop
 fqz4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785959264; x=1786564064;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v1lW01GetE4EqXWLTFkbGiEjdVd9jELn9X0uE1OBtbM=;
 b=divGBJFqhGCcSsWIf4e+iCaluQb26yOC+Tp5IaiQrufoKKKQYjefgz/83vY/1vC1+q
 GcayzdSaDa8ZX7yiDsH/SekUi2/kwWyHMqJdR43fAxZuNBK6hLf/wa9aGudpvhBRBWOk
 3D3eQsn8aaKAlJkS/f85br8SQRYEgKgZwQOc6wtls3gFQ6CpfgRg+HsO4XP2xP4N1JCo
 hEaJqf94uINXzV55CcK/EtuWB+vSlcrQaN6oVNtGZPk51cADVEKBD/P1Npu9SGSbFqpv
 Zix/ypvSsdsPJ0ozNzaLuPj1hurAQCZGD3gOSIb5+Jr8WGpPk8P3/rg9i7NNs4PbNIiX
 5I9g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=divGBJFq
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, 28 Jul 2026 14:28:23 +0200, Julien Stephan wrote:
> clk: mediatek: mt8188: fix top0 gate polarity

Applied to mediatek-for-main, thanks!

[1/1] clk: mediatek: mt8188: fix top0 gate polarity
      commit: e9b3c199557e05e4363ae96d9e3e9d25e996d393

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

