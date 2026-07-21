Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13E6C44520
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 00:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32648406D4;
	Tue, 21 Jul 2026 00:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id daZ2O7AIhuPs; Tue, 21 Jul 2026 00:05:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27B604074E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784592320;
	bh=Vtp6dYwjWjI8gvVA/B5EaT4pEMZ71mxrEieDRCBswso=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fhpi6jH+kUuOE+Z1piU5LeEStsRuJHPbpZXxWPrYhR9WfFaYeG61EdTSt8NCV5xYK
	 EU0x3qwH8fQPnTe2OinEVH3UN/3WkgPbh+Mmq73Jv5zxR5Iry3Zb9aMvvKeef+YNzW
	 CKE231Y2CcmDklr71lELcG2JtubbIOGNLjhVsEC+EZ/QcGwpoTt9k+HHueK0D1wvEd
	 gcBFCLUSPwMN+gzMSMc6nwQ/pgpJKIrNjA1S+V1g4ngCxdKLMeH3cCfVAegsGjWTnA
	 RyV4efXhvsMXBhFEuNlYDuElGIhjEUzb2HKZyxZZ6VWl0NknyN+b0XEMADGmYnlp/G
	 i787dicX1Axrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27B604074E;
	Tue, 21 Jul 2026 00:05:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B7EF38E
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 00:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D53E6076D
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 00:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CEkkz3nUCWwV for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 00:05:17 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 50FB76076A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50FB76076A
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50FB76076A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 00:05:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4EB483E76; Tue, 21 Jul 2026 02:05:15 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F56582991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 02:05:13 +0200 (CEST)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7ea9c6ea7deso65236a34.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 17:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784592312; x=1785197112;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vtp6dYwjWjI8gvVA/B5EaT4pEMZ71mxrEieDRCBswso=;
 b=XY9qqwGHMLUHAzMaXWSLejthQb+kATwoiCblDjIWFl8Fokv+q+55EoqCJkno30TBou
 fo5nXGJ7up8CgT5VNjzq0gg52kzNWavk2siuHZqN476FqoG3MPXh7sHJ9lJrcqDSA7mU
 bbyquL890eU86RPld2WKL1g6hhZsmtejemiK29nFkfi0+JPf7Vyip3ZHSjlGbN8twTIF
 1SyTL5PRZ1vhLomEJkfcE0Wpij5ZWD3PtXRpq8xdU/cNVro58nCY82/C9JqykKwusddh
 jTf6fHTRuPcdSxxxQzZKQS7uBWvdTmw3iAcf20t1Hd7wsHTgwCpkra/SsbgpmbrlLZU3
 y5/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMNG7evscgn0Iyhdsc+0cI5R4j9dRyHq0HEZKjkFpA+YltCvmjsFDwTnkSnFIsPm5VoYqD+ng=@lists.denx.de
X-Gm-Message-State: AOJu0YwwjCvlxUuDsLjPZmdVylEZrVVIfKeR7UGWd3IO9RNlD2VXhV7t
 4KgD+i3u0H9CORr/ht+sLV9aiNl4PFBgVHwfA+d3EoA9zG1igePQgVqtx3hHu76IwEc=
X-Gm-Gg: AfdE7cn68ea9y+dlPJVi5XZLTJ6VqogMvH7RYsnr4scLIDDqFTKjOZQJlOzN99yEIaA
 i0h7OfQpN9uASGfLssqLOZGt7XZhkNc9mtKgjb+CHM9JTn68TyglsSZhCdO+cjFneP/JFvagEqG
 7qhQ7IBdKzl+FtreRdlEU0fuoeJ+orF692ub/dYFBmuTA6yJsjNpYAm4UZehiVO9eInrQdvmfgK
 3vs6H5m1BQfmViHPsy7RqUqpO074AIlIQ35IT1DzfyouCP6PNr2mLrCpBfTs3aymxB61M0n/pTh
 vKAGhgHbietJPxvnO7mEFbrBkGTIjeCnYtxcPK/T8ofpiT/S8dgXJ5ra8wJI4gPJw/zS+D9Oedc
 6UISbX5FBPnZl85GddXGGTLpkzAK15uwPYjuXPHZLIivwCBWznsL83ZcLFTHX+hR9u+gjRDLC8F
 KoLX7b1u9ecejjzDUfdwx8+xIkaG4yaausz0cyAAMwlKH83Atw1UbB
X-Received: by 2002:a05:6830:82f4:b0:7dc:d2ad:fb29 with SMTP id
 46e09a7af769-7eda4d928eemr8006738a34.24.1784592311819; 
 Mon, 20 Jul 2026 17:05:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8ce6:b98e:1126:f7f0?
 ([2600:8803:e7e4:500:8ce6:b98e:1126:f7f0])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edaf9ddfc8sm9500198a34.25.2026.07.20.17.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 17:05:11 -0700 (PDT)
Message-ID: <7e5b16c4-c87b-4e4a-85d9-efcca6ada689@baylibre.com>
Date: Mon, 20 Jul 2026 19:05:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] configs: mt8390: enable eMMC FIT boot from SPL
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
 <20260718-ccaione-upstream-mt8390-spl-v1-2-1256b6dfda3f@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260718-ccaione-upstream-mt8390-spl-v1-2-1256b6dfda3f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784592312; x=1785197112; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vtp6dYwjWjI8gvVA/B5EaT4pEMZ71mxrEieDRCBswso=;
 b=a8AAxdUzNPRmQM6c16BR8K6Ieeck+kVxX9Koaf7fKud0ShPLc4VlTk7pr6nIDZ/j4l
 f+OMrmVDrjWsKDhl5UOQ5/z5XT8gqTKcDABug/KNv5sDBJPUvjJTLw4Okzr8hizUVnkS
 l4zd4/Wi08zgECSxH7qOvvn7kbxPFBQXm5rp8VF+29p3NCVSC2jwWUNms0yQctxUjEHt
 kyyuSGOHo58gUc+EPUp4ZQoyzM5hSpihw3rB+iODbt0u5rB1KS/eXcWdcPCQkWX3aNXE
 xI3Kr/64z2+eko/A7p+uU6yGHqLwcmJfiQVdxywoItYhEYzW+P293EDS06xoPl59EmAg
 g3wQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=a8AAxdUz
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="a8AAxdUz"; 
 dkim-atps=neutral
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/18/26 11:16 AM, Carlo Caione wrote:
> Enable the normal Genio 700 SPL path entered by the external DDR
> loader at 0x40000000. Bound the raw SPL to the loader's 0xaf000-byte

s/Bound/Bind/

I can fix this up when applying if nothing else comes up.

> copy window, place BSS separately in DRAM, and retain the
> non-overlapping SPL malloc region.
> 
> Use generic SPL MMC, GPT, FIT, and Arm Trusted Firmware support to load
> the firmware FIT from eMMC partition 1. Keep U-Boot proper at the shared
> MT8188 CONFIG_TEXT_BASE of 0x4c000000.
> 
> The MediaTek BL31 used on Genio 700 stalls when passed the runtime
> devicetree as its platform parameter. Enable SPL_ATF_NO_PLATFORM_PARAM
> so SPL can still use the tree to locate OP-TEE and U-Boot while passing
> NULL as the separate BL31 platform parameter.
> 
