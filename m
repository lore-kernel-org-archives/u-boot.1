Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2ECC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 15:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 574F880C87;
	Wed, 29 Jul 2026 15:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hAn5CCsjjm6z; Wed, 29 Jul 2026 15:50:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6231D809B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785340209;
	bh=sMhyfGkEDXFU8diZFDdat8pD6EyYQjGMj6K3VSUlHX0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kx1eVx6+DLC6X2l2cgMDuyevlAzEH2lD1ia1H5S2I0T4gznxHWF3geyvrPteOEWs9
	 /40H8hMt/4b/WsaGiArybb7Mazhr5qCxJAyExklKa1pi0WSuD1lgLjP5t/gMun4G1Y
	 B459gTxzfRGA1FnslK1jE0+U1Pl6EEQgNVpRhbc41ZZdQQdt3XmVM+XyX+BoSDSfvM
	 tF/WRre+E8ZN8HTHirWk9FAYwoCuhBg7m+m9GhESPvp3EkJp7jPGDeI30gMGJVIqg+
	 C4tVerJ8FxQ4hGG2xY4la3oFk399TNxQBtIx8/MLFquRxuIN3VLK0Z9XG6gEZQqCjX
	 seEGjrodVHaFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6231D809B0;
	Wed, 29 Jul 2026 15:50:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 630EE788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4583C4074C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:50:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y0AUVN3OnpZ4 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 15:50:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D11C34073A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D11C34073A
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D11C34073A
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:50:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C69488494B; Wed, 29 Jul 2026 17:50:04 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABBCC82991
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 17:50:01 +0200 (CEST)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7ee4399c423so957522a34.0
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340200; x=1785945000;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sMhyfGkEDXFU8diZFDdat8pD6EyYQjGMj6K3VSUlHX0=;
 b=IACZR20lNa6dQ1h4/OOIdFLEco2zL2wJH2/qu2wIYykec9CjJ7pkUG5DdnOdAS5kEC
 /H6u3PC75K0bqXdu3HWWxFgQmFS3H0z+hmOpfD0/rkA1btvO4zm+aRecsUuLFcXB+W/t
 ZfkTgf0JXKdLqL1AzcqoZxpOPJk3MPRP0Ty8QocSmI6B47i5dk8/p+Wur2s9DS8MT4Pv
 l+hmfWQKFoqHx22qdQZBRCLr8M6gfOdc4QVqGtWHz+JQFduqseqmhyNTLekr+haKfru1
 vDZspPojoI/8KH6nOqD4j3cF3WKS1gJvoHw2dm/egJkSlREWtzJ3jw7hynlVSDYojhn6
 k60Q==
X-Gm-Message-State: AOJu0YzWuIYRqkdWyp9OSZkUwM1Qy3QXeZTWiihBFiICB772VzicmnV9
 p2dHCkrtwFSysDzmCr/fPfDtrLlJviX3hkewCESduybs5cZZC0ZCy/l8+1UeuNfE0eM=
X-Gm-Gg: AR+sD10wFGbbPD1F4a3NxCaPgKBOi03CT28w3ynMK+UuaNxSLFwnZhy5C09n3/s4Z5O
 aLaDCyv+dLcxZJWKAnxLl6yR8CDB8mOIKsRLWLd9KMtgWiLKS5kyNdG8MlrnTJDuDw0fn4LGK9q
 xyWDnzA7Jpm3fdrITmZTkto4VNNS3ouX8y/P4TLZCYYgvZratrHw8VDOrB2Se0wrf5TmiZoVudO
 +jnWhWyQqpgR/PL/8l9WL68ZpNoRBpc5nq8AwG9qmJVLpFWEyc4Poo0aIT0+isGRT+8Z3EQgeep
 1l0CkVq8J+RbuOlVacRC5h3HHChXK9U5quPf4tg7wLwKnRFZ4yEdlPt6UN/hpNM3BlY/SZwTUvw
 nxLPOSeOmcuAlOiG4MMKWy0jzsElO6ibLHHJDMSdcutNXd90Ydqdh6hKuGegPJr79Ca9wLxeMlv
 a2xf9F0jd+KMKjXD9nGksebMTJKKf8/8Qcrty8/F+54EwfupqPW+Vw5E9QhzwiOPjHGg==
X-Received: by 2002:a05:6830:3112:b0:7ee:41ca:e7b0 with SMTP id
 46e09a7af769-7efff12b145mr3983310a34.14.1785340200131; 
 Wed, 29 Jul 2026 08:50:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d595384sm2597232a34.4.2026.07.29.08.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:49:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
In-Reply-To: <20260715-mt8188-add-clk-add-display-related-clocks-v2-1-0aaf7accaeb0@baylibre.com>
References: <20260715-mt8188-add-clk-add-display-related-clocks-v2-1-0aaf7accaeb0@baylibre.com>
Subject: Re: [PATCH v2] clk: mediatek: mt8188: add display related clock driver
Message-Id: <178534015342.3352940.15918320377626067100.b4-ty@b4>
Date: Wed, 29 Jul 2026 10:49:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=430; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3MzsEHdsdW5fGVCIhC8SfU0kx/KQI+5wqIVE0LiRCp4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqaiEgapMtWSh4HUHIIgff+P+NjAvVPegu+45MD
 QwF7D/DA+SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamohIBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AxW8H/3FaQMsWrEV1oTtrJ2devD3g7gsgJpYZCudzz7z
 WofyDyy2RFaDmVRt2fkCpr/6uGtXN42UtpC7vkDzpQSt2ZyMojSwdxtdPvlgs42D8L9D5gKcaNu
 IXpgMrExilzHGmwMjqY7Qbx8detSpa6by8Q45hTK9LBBv6Hwfamcr7OAciUjadutUIsbSJy5Wl2
 i8PjFzblQwbnLrKvAtyq9KMsgbPPAv92DOPNgPMSZstaNuqKIC/PsojqvFnmdfpImy5V+eFPgbZ
 rbkudgD6jiCDazdRIBf9wQay7+LIa1qhM2PLX10+WPYWDvPbuZNLuN75hDE+UIkXVsrJ8nGvOHe
 SHUQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785340200; x=1785945000; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sMhyfGkEDXFU8diZFDdat8pD6EyYQjGMj6K3VSUlHX0=;
 b=fme0MxGfUIW+l3uZdjg5ko8N+wuWKfOfijsuMlpTPib9YcWOnQ4PZ9L8IIPWZPdujS
 laZbvENIpFRN21O3qDZ2/HgUk/bfuNPEuyCtuC+JkW7xgTUNGgKMjWnA9DiwsKJyX/+5
 6wibfulk8Jscf43iGZX6iv+3djXsQhVu9K30Euxbia85u/Z6Kv0FIEpUwWJH2MMtscgs
 wdQ8JhzpMLuzQdnUF8WFXfqZGpLHMydKB1GvzyDFeJXV6TASjO7/MMYkV8P83JYXle/g
 dvS8SeVd8+AEFikiGoOTJ2maKkmcX5FxoEbnPMa6VQxgP3ucHJRtJ166WsluwYa7wVAa
 0uig==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fme0MxGf
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="fme0MxGf"; 
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 15 Jul 2026 17:24:26 +0200, Julien Stephan wrote:
> clk: mediatek: mt8188: add display related clock driver

Made some tweaks to clean up macro whitespace and add trailing commas when
applying.

Applied to mediatek-for-main, thanks!

[1/1] clk: mediatek: mt8188: add display related clock driver
      commit: 8e883da9cf117d2a56ef20b4928ec0843ec5e316

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

