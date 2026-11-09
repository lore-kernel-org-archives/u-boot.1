Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E97606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yUh3W34p;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KbYLXyQB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21E8B4059B;
	Mon,  9 Nov 2026 22:09:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w84TqPtYIr-Q; Mon,  9 Nov 2026 22:09:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F5A1405A3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794262157;
	b=Wn5LVXlhTBeix91tVZlFXZXMXSN2J9KKY0wxtvo1J5BefqkGFrqVT+LVNF7waSIoL3tN
	 1X4GycUtbhM2zLkcfO5MPFxrsIMSq6VGVxcE37/QmqklkICieRUzV074W2josljc0hDvs
	 dmp9f9H5CK2S9EmWGSpk6KxPGDMJTL7OBitSxTKIW/AyrcIuAgg8O3Em+ypV39fywkjWw
	 tZtqNXQL3toUQM8GvYBBL1DzBkZN1amS7e8V2+71zy0YfitEGf9W/RPF9RhkQOcIkaXO4
	 6bJ5ocVYo/kjki2t1d4RLNYuwGrl9TLPY2td5CjPZq+LlZplB83+QnvSSqhCqH8aXrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794262157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rGyo5xugHVbJb3/NmBL4sVvWVGu6JQMJsaH5OqtZiqE=;
	b=Jn+qvkNEAdSUPHoz7B/kZTstV6JSgTfNGEvyleFc5CZRbkwKMPByVDWsRhnQv4WtXJNF
	 YM12QF/zZfsJiLD9tVnIZa5+BQm+bBqqR9DIpF45av7lfBsb4pbM2Pe89sbsUe3AHLK9j
	 QMePb/dgVNpiruhZgPG9tLqeWA4hA6Qn+Ku+bJYxE660fXVXfE/r+0erJ2b4vvy0Cuueg
	 WS7U7R8yRZzFdQKe6myLRh90QCkMQcjXlukMif0TKW54jsCafI2VhZsReS5l/Tdx2HYAu
	 XHvxTEriqEpbKDt5CONcec5Su+htrprUUcpCrcsOlyLG3vLuRIRh4UGziCabmx5pw1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794262157;
	bh=rGyo5xugHVbJb3/NmBL4sVvWVGu6JQMJsaH5OqtZiqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yUh3W34p9neeOPHIqP66KC9DSzF72QgRM3TJv2khdJQrYfD9Hl0g7NxvdqW8SAALT
	 jBJuBAcjJA0Gjcz12EVpcW7+Fh8YYjsWgLg+nYHod9oIVXmhuGJHLFizqOAAcaXIh8
	 CH/Aj8ll/WZOT7J6dZXXrmHZMjIGMIvW/VKAwhg+1eeuA7j1Uo7jpFJd/jUZPiwjyh
	 a7P2lW9Aav3gCGLml3jJ2Me9zJK27i1+jxm8Gh72LzruJ0Y1TnIl0Fgyb4xEGFe1aL
	 bPtvTeulyAlLYWKjuyfGTfJ5SteSrj12P324yyiSUeDDBP73pOq1sYMjLH9+7IB1as
	 ijRu+Khx6jx5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F5A1405A3;
	Mon,  9 Nov 2026 22:09:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92ADECC4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8FF2860790
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fzF45CZKmtP2 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 22:09:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E58556062C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KbYLXyQB
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E58556062C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:09:15 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-8479f46ecd8so707274a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 14:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794262154; x=1794866954;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rGyo5xugHVbJb3/NmBL4sVvWVGu6JQMJsaH5OqtZiqE=;
 b=KbYLXyQB946PFW+i3F4Ng2Rd8eA0b459GD9z8dPhHK4NPABhtTCeHywu6KMuwKvAuF
 o4aybYDr+HVSpczPuH2fqQqHDnu4d4toI7gTyFaXgl+qROUSu1cICYXUe5Ny0rLBBn0i
 VXJYBcP/fk3t8qX2C5ci0tpQ1mIquJokPf1oMsU9+vyq9/Joxpt2aW5UyQywK+wF4mAt
 Ekf7pp70G7exT+tmPcwHAl72Pg9UxBYQBxgM0pA327Mik1kYZZxJcvrN8n6Q8juiOvLj
 SJrqN+Jzu486hHzxyjgF2mfFDTjlC1MDZIp4kgH0BufElsQzv/psZ6EVNt1eCMOjmVXh
 NiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794262154; x=1794866954;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rGyo5xugHVbJb3/NmBL4sVvWVGu6JQMJsaH5OqtZiqE=;
 b=gCig6DNck5OdJxbefI7299JChX98VKB7WxoSvH22JiEYR9ymib6mU3pSUAenDUehWK
 P89T9RX3navh4513B2RLeV/b5tc1LJkwEOVL/23Y8wCXCok6LpNb15cuY/e3FJgJnBK2
 0XNZyhSw6tz0bP4fnR45uM6UgyFP7phUIUSoMBSR2WOBrE13TU5V71Ui6OJ3AZXa6Iao
 5OkbBgCFD1kq2O3q4ghaJebSOVPHchB3ofoDDF6cLpVnUOYCBzK3GKpjF3S+SeqF6cN9
 fSA16hbQ+ptcoMJzAlDK8W4+VTkeCE8a0jtrUyjjmQGiGMLVQSiv0BnsyvHeBwwfAQtM
 RiIw==
X-Forwarded-Encrypted: i=1;
 AL+hErE6Jvpec2UkdaB5Csgqnuf0J294FzL47PJx8rdSsK/6mRM9qy39zMwMQhBuouGkwec7snf/ico=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9x48JOfmTEd9ZQzEI8NG8ardQI3WJmpqsxPfmrgkVy2QfNd73M
 5zwjxUiR6iGUzKVfyiwbRr6bL5miJsz64keSDruJA0sxhZecehivNMqvLSVwl5NTe4Y=
X-Gm-Gg: AYBFou2JKyGkcKYOER/rguXRZk+fZmm3ATx7cPX6vyczqM5X+glpADYI7qslayN85nP
 KkqyTe7PhPlVXA2GwhxZblmMxkAszhkJGvtvG+A7L0V6O9hB6f0AS+i/66PNSg9ZKx85/9BY45N
 GSTDPYCpe26aIWle5+099tgGyMgF5eDWVni23N9VQu2AbZEkBXMmyl3GpkbfLQx91gMzbdFWi/H
 HiXDs0+uU2GpKZv7yR6pU9VTlt14A63Sqa7Jz2ZhCsCY/ySZZbCRhXE/B5K7QRrJtEU4E7Gs+QB
 rBXL1zhPQ6/dCyv7ybsU/j460HRPavJzUO5PKPrhIjCV3bPQqzLCq7ZSfUqaIjxNHR0pK0su8Sd
 Hy8gu4cxQZToj94F5vBrqiYfbia8LWiM41q2IGgxO2oYRS7xoMN1Fs7Z89dBZlmhisz1fhgvSPa
 /NHpzSIzBdDG003+JaWKKEhSooxP84OIWbK/uLi+2G+/JTv+Mtbg383fGhy8CH76w6R1UVL2QzO
 YRfj+FDmQ6Sm8Yg+EkJFqDH/68tWBimkS1VCtdC4n7HIKX7VBgfGT264JrxcrOw+fyv1VES1Nta
 Omc3/RnDUfmtZWXXXZzm53xR6LQBIqnTAQ==
X-Received: by 2002:a05:6830:441e:b0:81b:c62c:b63 with SMTP id
 46e09a7af769-860dc7f124cmr522362a34.18.1794262154280; 
 Mon, 09 Nov 2026 14:09:14 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcc25984sm408994a34.25.2026.11.09.14.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:09:13 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
In-Reply-To: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
References: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
Subject: Re: (subset) [PATCH v5 0/4] Add Genio 510 and 700 BootROM download
 agents
Message-Id: <179426206122.3924283.989178798521388207.b4-ty@b4>
Date: Mon, 09 Nov 2026 16:07:41 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=LY1ITJULSAA6lvlD1ApZBpiCEJWQCKKH7+4KTWrNIOE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq8kSB2msmaNdWLTI5rFirLg2CAkLjuRO+04FRx
 ifFKVYiUCaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavJEgRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZjsH/AwcCOrlF/4kBRa8jh6Do+yR7CW0J25LTI+dKyc
 MUwLtfL/fEExAfNWWwxdvvdaKjkDPLDjOW3BUqGtcBoOxk/ZH+ICuvgbYnUtiAgWXkYIzwCBbA4
 7rIMqYxVFYWltYzC4mrSZLZR3oz+Cb4nfg2yOBv7lKHrbRCz3PGKgAHyecqg1Tl08lUsXkZB2RG
 zO+ppzCUgvI8wEFZgDea4xpxYFYywW047AJrDG4hwWCLOtynRIWV5pJRxtpWubkBIbpNYzBCB94
 NyZabgNex01WJ/xwrYsmyzHCt8d5U1gvlVbW0wamOHwANjLKIJ/m/PSyAsB9Pc9q2I8CO9HTX2J
 oS1c=
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 11:26:14 +0200, Carlo Caione wrote:
> Add Genio 510 and 700 BootROM download agents
> 
> Genio 510 and 700 need a way to provision blank eMMC and recover boards
> with unusable boot firmware. Add RAM-based fastboot download agents that
> can be loaded through the MediaTek BootROM download protocol without
> relying on the installed bootloader.
> 
> [...]

Applied to mediatek-for-next, thanks!

I skipped [4/4] in favor of Steffen's series.

[1/4] arm: mediatek: enable SPL fastboot DAs on Genio 510 and 700
      commit: 58de035d2c465a003af41759075540756142b056
[2/4] arm: mediatek: enable U-Boot fastboot DAs on Genio 510 and 700
      commit: 3cae27a572c8655d929806b7ed466d118dfd13f1
[3/4] doc: board: mediatek: document Genio download agents
      commit: 810d7132c6f03430588ff45dacf62e62f3906598

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

