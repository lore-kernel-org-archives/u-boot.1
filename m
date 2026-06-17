Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE4DCD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 16:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98AB884833;
	Wed, 17 Jun 2026 18:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thundersoft.com header.i=@thundersoft.com header.b="eY4hC8j7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06FE584874; Wed, 17 Jun 2026 18:09:10 +0200 (CEST)
Received: from mail-m128178.netease.com (mail-m128178.netease.com
 [103.209.128.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F08F846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 18:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=thundersoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongyang.zhao@thundersoft.com
Received: from localhost.localdomain (unknown [113.235.125.44])
 by smtp.qiye.163.com (Hmail) with ESMTP id 42c805c2a;
 Thu, 18 Jun 2026 00:08:56 +0800 (GMT+08:00)
From: Hongyang Zhao <hongyang.zhao@thundersoft.com>
To: casey.connolly@linaro.org
Cc: balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 hongyang.zhao@thundersoft.com, jerome.forissier@arm.com,
 jstephan@baylibre.com, kory.maincent@bootlin.com,
 marek.vasut+renesas@mailbox.org, neil.armstrong@linaro.org,
 peng.fan@nxp.com, philip.molloy@analog.com, quentin.schulz@cherry.de,
 raymond.mao@riscstar.com, rosh@debian.org, sjg@chromium.org,
 stefan.roese@mailbox.org, sumit.garg@kernel.org, trini@konsulko.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de, visitorckw@gmail.com
Subject: Re: [PATCH 2/3] configs: Add qcs6490_rubikpi3_defconfig
Date: Thu, 18 Jun 2026 00:08:45 +0800
Message-ID: <20260617160845.32467-1-hongyang.zhao@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4d31e770-5803-49fd-841b-f6cfe92860d0@linaro.org>
References: <4d31e770-5803-49fd-841b-f6cfe92860d0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed657c34109d5kunmee0c5cbe16cb50
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSk5DVhhJSRpJSkpKGEwaS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSkhVSUhOVUpJTlVPT1lXWRYaDxIVHRRZQVlPS0hVSk
 tJT09PSFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
 b=eY4hC8j7tbZJgrgH2IRKMqc5UV7sdsGLCBQceLi4mOZyJXx7hABmr3qvRJ/nv9JaJwO6F9jnJFE/7ztSZuEtNTNOFfoyoDFZtwcqQiviuywJkEX6yM9Hmup4oxn4bAyQqh7FSqUaBfHgyNGDkdWSIwE7f/wnjJ/cjWsJrslhEdM=;
 s=default; c=relaxed/relaxed; d=thundersoft.com; v=1; 
 bh=R0AstKke00OdTNkcN4CgESvvDGu0aKRpHdUvLUorf6M=;
 h=date:mime-version:subject:message-id:from;
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

Hi Casey,

Thanks for your review.

On 17/06/2026 12:56, Hongyang Zhao wrote:
> > Add a defconfig for building U-Boot for the Thundercomm RUBIK Pi 3.
> >
> > The board reuses the existing QCM6490 configuration and selects the
> > RUBIK Pi 3 device tree. Add the defconfig to MAINTAINERS so the
> > Snapdragon maintainers are copied for future changes.
>
> Currently we're opportunistically trying to clean up the naming of
> defconfigs, could you prefix this with qcom_? That also means it doesn't
> need to be added to MAINTAINERS since it will be picked up automatically
> by the existing match criteria.
>

I understand, and I will fix it in v2.

--
Thanks and kind regards,
Hongyang
