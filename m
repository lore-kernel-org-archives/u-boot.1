Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E38FF5104
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 16:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C43BE8404A;
	Tue,  7 Apr 2026 18:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="N2Ft8Ljm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D59840BE; Tue,  7 Apr 2026 18:01:42 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED8983F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 18:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40946982a78so1653675fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775577698; x=1776182498;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeRnzOC9gA/oAm0lTbGlZzn28YMfjPwYhyfLsxy8Kvs=;
 b=N2Ft8Ljm4rnCw/cidcGuq4MlbUB80kPnK7BeZ5i5g1xqJiVpY+FSsrsSzDYwHHyiUg
 4KDxSY75SQ3oAe5K1Kk15ABdfX8PEQAJPupoMv+/7N77PqTyYup0bZ4FOJ4gtZVs6Crj
 B82eflEAdy79fZ1wLS+L8pg4DbPizaitAUCpi97oLabbB6qmQABD66Rwkn+UFVAeOkeA
 u9I03ApDgFf2bSYA9EGbieM1qS8RGF4X28HH2lKtxBKUA8K9zOr5Mf8mhDws6mKtJLob
 tbO8PzFzxSdU8IcxsuthVlqMWQZvXracpcL0s1VO1SUR5N7rr+fKasQAUO+NP7/FYJRZ
 Vhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775577698; x=1776182498;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MeRnzOC9gA/oAm0lTbGlZzn28YMfjPwYhyfLsxy8Kvs=;
 b=F5YAM5ooz4lQACRaAjLoyaOvtSn0Tz6eXPoTRmPrkzZyAYQKcQymUuOpJAtAcAFyat
 plPX0fq0cWvBMxXu7uWQcM54S6Pqs01HKmeSBhZLXSE8fA+Hx28ipaUs7oTexIjc3+5I
 XJLVH/L3iDQetygfmh5R6JhrPUFdqaqbZcEuwPRHQGAqeC7JX8jk2ffUaD04Gy5lfJW5
 80Z9Uv6/2bJLR254/WmnrLFiv3v7bB7p/sVMYTYDdg8wh5WICyUc5Xq36qcpDTHrrD05
 T/Z5Oq9GbrpZeMryCdCjByA8P7HR3uC5eYWZA3crNo/LS6JMvSdjkIbGmacItlVj3Obg
 w8Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu+aG4FjI/zAUnYliCk7W/3n0rfeyjc4j7b0lGlgUlIfh8Nq0d6Ze4xU0R2V34Gblr6VfMeIw=@lists.denx.de
X-Gm-Message-State: AOJu0YwBkAGnLdl9ztthUl3wqRhSpkFR7WFCN9ehJjRdCjENd9fdx4yt
 EV0xUfBbpSK3vuQ7DvDM+fQxb+DRPEColSYN6B0C/jzSJM+9edawBODDg4K4vvoxelw=
X-Gm-Gg: AeBDieut0adT52D0XVIByCIPJxVG4nCa8aY3k2dgrCpyTOaly/0SHXqjuF9ROejIyEw
 eBUT7nF4cJjHLNRIs2OVMGEqbmtC7w8Ysz7ZG/tfdTKvOXfBs8SHN/F++2o1Y5OZPHk2B4VLKhy
 iF4zHndc4MRABOuGvwazZFYpwIoEX0+qq5vomiM/yxoF1uOOfZRlfIXSncTipM5fIOOB8nUB6WD
 nCG3P9WZMmeLcSESgTfCGieOn/4wFPXqzx/6+EAPKEdsEnVDtHhXWGquOH94EfA+EfYi36XAOuw
 bLunXWuObH32UbyOYqDCY2pE0X75xgJExDdJWrWwcng2hxwTdiBkmRjcHPWNU2sqRvJAIuda4rV
 nhG8T7HNp2SkUaj5aaaV7v3Ey9A9TsDBVKYcjuU7VNAjj+Dg/hlI0UfbTnyK502olUE8wH5uivs
 xU1MTQuMU4yIF60ZiOlXIa1cETrfgV
X-Received: by 2002:a05:6870:d146:b0:423:4cc7:b1b6 with SMTP id
 586e51a60fabf-4234cc7db2fmr6184707fac.22.1775577696609; 
 Tue, 07 Apr 2026 09:01:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f738:1ffd:6365:30a7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9593484fac.7.2026.04.07.09.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 09:01:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Cathy Xu <ot_cathy.xu@mediatek.com>
In-Reply-To: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
Subject: Re: [PATCH v3 0/6] boards: mediatek: initial support for Genio 720 EVK
Message-Id: <177557768255.837601.14565870114374554567.b4-ty@b4>
Date: Tue, 07 Apr 2026 11:01:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=87RwZu0QSzxfLlK0SOGN7U0i7UmoZS2JvwvOosGas0U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1SpYZ0CYXrMqDQBrCMHUxdl+fZP16Jux3vSNq
 FF5ZWjF/U+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadUqWBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A/gcH/jlB6zMiom2oUHzXxuiocvH05tJRfcOc/Hfn1Ux
 17oJwTnlvYrp+jJ1WDzSOF0SMdo9alRRLW0L28HZkDzIaon6XOdJ7VhM1fiV9AlgpV8W5xkETcp
 wBp6ZCVagZF0gNQqsYPFSAjUFAhV1vU4wY5kJZjPPbhVMogkf7eQdP42OngAieIMjUksctH61BM
 CuLyTJc+XrcUo/+lpMbPZAVzYGuFGQQYSlZuvGHr2fw8SxFvO7sWdWY2ER8V4jErflP+/rcy/cF
 J6XiKoSyXAthSlVq0hdF9DyanbRP2geyih9/OkGFFZ6eXZMyjxRMenk2P5j0mWoSJx1WrJ5yxnP
 wby0=
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

On Mon, 23 Mar 2026 15:16:51 -0500, David Lechner wrote:
> boards: mediatek: initial support for Genio 720 EVK
> 
> These patches along with the listed prerequisites are enough to get the
> MediaTek Genio 720 EVK board to boot into Linux from the eMMC (with a
> bit of extra config that isn't included here because it isn't generic.)
> 
> This is currently being upstreamed in Linux as well, so we just have
> some minimal devicetree files here to hold us over for a while until we
> can switch to the upstream ones.
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/6] clk: mediatek: mt8189: add some VLP clocks
      commit: c594a2a7ee9aa644999953fd64792ca3d1f98827
[2/6] arm: mediatek: add support of MT8189 SoC family
      commit: 437090305f9d1cbc7b8a7fff5d78ef31454ca283
[3/6] arm: dts: mediatek: mt8189: Add pinmux macro header file
      commit: 91a41a2084c9534f7c2201fe6767b4ad77356811
[4/6] arm: dts: mediatek: Add MediaTek MT8189 dtsi file
      commit: 2eb1c269b0a551f500e2e61c2ab5d8c69eb378b3
[5/6] arm: dts: mediatek: Add MediaTek Genio 520/720 EVK DTS
      commit: 06a4a171fba4cf7d7956e28d0a778deba092f8f8
[6/6] board: mediatek: Add Genio 520/720 EVK defconfigs
      commit: 75902cc1f407b7380b5659667f37b0ee6d3ef3ef

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

