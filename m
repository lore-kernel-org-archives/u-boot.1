Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E7DC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D92260BDF;
	Thu,  3 Sep 2026 22:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6SXg6wRCgqTq; Thu,  3 Sep 2026 22:13:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 541FD60BBF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473624;
	b=FMKmN3C2SyxA4+P53CZpKQ7G8bvw3JSG1NNqKN4NEV4joMpez/bcp6tfqef8gsP8ZAeV
	 dVN4C5gHitl7TM97xVwvn2IuJBw+n/bAFIFz0FJikft5JHWiHxctisoRY8zrULufFu0Cc
	 ShQStTq1Jr2UqOSidDOjSDpX/z62ebKSq1YU4gA/tQDZq3SFcEimjYnbqCX6Gl2+zOl/U
	 Swzy80ExQV/8rNdNUegTK+W05LD0zGpKxVDgeK96JAvUc5XraFycfKsglrDioc4YtJgbQ
	 +o+Z52AH44LX3cTh51FN1PSHFXedQvdmG/h83GHmlVwdFOEqXWj+1eu0ahdGp2cYLuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473624;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=meZOoY7weYsnQd6XSyEKO7k+WaxGv51k/ZzQZQcfPgk=;
	b=XURW9mG2df20wXMrDPPSIJjQL/0EEuKoXOzqheBA2B+Lvto+A9wf3bZt0AI/T2jhxvog
	 E+Krw2sZESouMkGjNBlVsTU5Du07Uij45Uk8nZY5G1m3y9w70+EQYrIGUTvgTGzjg9ii4
	 YAfiy2NrVBvAizm4kwW16QANOe53Y/dDFN2OTM3EKvYXjs8pfYCen3U2DQHDll+X5wG+G
	 7Ditg4eZGCTTn/s3UPhI4My+MifV5rWzd41K+/i2OIAJw8MJimLpkrly1zwbhpqKCA9Ce
	 1k1wfnkTY+BhJbZa3qSP/gcrqjJTlfyOtIInyPFOmLOuzZkkAiP3a3GbcFmo9BPSA9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473624;
	bh=meZOoY7weYsnQd6XSyEKO7k+WaxGv51k/ZzQZQcfPgk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hXBi9EuFHmTO1XymbdwK6UhdInYCQ2StE6wiVUrE5jlgZsCNGIibx8hGDneGm2wYv
	 1Oz5KLNGrr+h7HdJma6wWMnJDctjLjlvCUOMwDOZ/751XkYNslYhgT5pk1DEpDHjhb
	 7TflqDaoP75vnRKfLfmNKkIXmdXvbcgUsxw10fb4xEYy9IvK4ym3CZnyvlWiXwcilP
	 nHbMpAEb1/CDkONPp62B1QY/s3jYE6uQ5Y5komLvtATWXZ91M1d4SITMSlpw9rz9xZ
	 ipQCrtVVZ7S5f1e/7s+SKxYzq3xuxvjhrwE4SIAFR/o+V8m0cawgRVeumSge6m/fWr
	 /TPEJYjYSbZbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 541FD60BBF;
	Thu,  3 Sep 2026 22:13:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 00B492FE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89C99810EF
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U4XMFGj4Zw_9 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C90E8810ED
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471493;
 b=En6UiuW/1Xm1UYp4FqVXLFRVKFEL6uPbGPKnUiScbnMnoLdQmuoadq2wa789rInzLoXx
 IGkt3WCEyWHfdd+FmXbQHyOiGj2IS4/BanpoRJLPTLlku5M0Rj7FjhkB2jzscwkR79EXI
 BpzH51IeDCgxkZs20RQ1ebjfyI5BRnnstKaEicTNc6l/XTG2jfYz1lUs6JfYI/5TpRwrN
 +gSqyBPXz5nZaVsEqNT/+D9n5oIegVqZ1S1xfc/pAF+0h/AaeMeEUWHmw/7if8HaZuLgf
 S05Sn5R9CDlEmUqkufHbeWxFIL4cBOYekKTN685UiSXAbsi6wwUR/9pGpBYT4p+MYzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471493;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=meZOoY7weYsnQd6XSyEKO7k+WaxGv51k/ZzQZQcfPgk=;
 b=Apep2uzaa50NZxRo6CxIQ/V9nD8AqQFOEiOdUCXRfhn4DDiKikSGCCZLo1qReqzdwFVS
 e+bQObvawu6JDOEI+f0DqrzgoJLs8f4RAUBwYOf2QGHtc51VhVdYZp195ky+i55f6MN03
 raEKHw99CKTnKe0+WQU2hqyMw10RFf1+qrgYaurg3zTnsBosS2HAjN9qzo+cWD7lA/TrS
 bByg2JwUUQGeE2m9OPlq4PWpLAbojYwcDYL+wmRJi/AfXFbONACd6xkfGIwSyonvxBRPg
 +yRqQAFXfhGUuJcHCFGjwm4LdpMkrCMVP5Sh4zxjn56jt04lcIIdx5jbS5wuYKSMLPA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XDZwanxM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XDZwanxM
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C90E8810ED
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:11 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4a46a53abc9so363459b6e.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471491; x=1789076291;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=meZOoY7weYsnQd6XSyEKO7k+WaxGv51k/ZzQZQcfPgk=;
 b=XDZwanxM+NKPR1sQvRAy9ZJlbXDKPb6IzsJGRmyYgI09eVcvCgK/31LwyzdKnGCH9y
 SzcNpNDXPmYohZvNBToIdpwDLD11CSf8I+muuvKrnW7Bf72bwu507aezGbJzjQjzgKpL
 4GHBU7/9+SDIEZ6yClkljPmcP5ZyRLvP/wyxwqXutRuB4mtuw/q8o/PPg3NyDlzj+tl/
 Obj5apOvR0kG/qSmKQVOEeWPv8P+3GzOENe0Yw8nAS/qU44Y3rByexZbAcVEuimLSk5O
 9xJnKYVyXQuMl0cedQkUJqtLvc6F1yG6DE6a/aYftlFx49tWNWScI1a4xS8o/wy7iNKj
 ihiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471491; x=1789076291;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=meZOoY7weYsnQd6XSyEKO7k+WaxGv51k/ZzQZQcfPgk=;
 b=mFmq03fGlCbsp0kK3hUVNKJyyCr83Ha/MuH+cImfaPTyDM7P1lQ5okCkX+3Tk+591E
 q3Y63Bw629jYoiB4E5TThtmM+uWOn+QMwKGwq7+Ftw4/KCLpRUWvYVck3RL1IZ23Spy+
 y+MEKivJ0S/GECkc/Sr2vxncDjEwzP+W0z9zAVKNdhi+whf7qv/igVsgNevHczF+FXm2
 27MibCd3hb7n9C5lAqzy6t3zKDKyj/rLa6Vk0FWifhZ4qbs3KwrEKSrkJbhJfkSy1GM8
 KVQTidGIOibRLyNzSg3MJSkx39jRiXzK5Q9sGXdL7mcvnYWcgCJCEQLIr1qxZQ4vCnrC
 aI3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUer/de6FWxZF5bm1AAoR37ZjfsoKl5HkFHMYx48mH9B+WsZmo23/nBprHFtxHY/R2TO0nVL0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kAOT05E81OmYuDgY8YI4q5y7Ho0onoxh4PWCcYY8eYZLUYpRWi
 zMDs0jhx7FKngIA9TYB7+nnTJqVoS7Rpjyz/W34MqlgTY0lDcVMHOey8CleMi3STsDY=
X-Gm-Gg: AYBFou1FSPJUCGGcLMNwNr9NMLp876wiISxuS3NvV35aaNUnfKn7zrg8+5VLGE8HHKE
 Jfug0W4yb0P2S2D8Aiv6zSm5k/mGyXyxS2ffTFDIPF8ChnYe6zlpN0ne5w40kSmxxlto7NSzUlq
 xfHQv6gxgi6XkUbUbPuy4BhtUbdIQcBf6uaFqo0nAen/vbdAJJ8I/gdYLgvduKWSjvrjUJZ8gxw
 48zDRlMCroTGWW1XWYV3+4VLl1VruHutGg7wzPpOZs8k3y2ZIvmKMbvY+IMiyroLegnUfRM2CBn
 ruyqT+Uz33N8CTUird84tHLObDcGb5CJ0SzpWezQSMlaIO+AG0oQWrxIWbTaMfXix7GHRkqRlYr
 2GItTyWOiP+PAELN8bPmANA2j2L9Z05n1qdWgpWkyGOK6YuHxEQvLJlNe8lq2t/m5gxKEUnpnn8
 v/cyhr/pTYJ1yrywSjLwmkP11XV8xb2utl32BuGEOKlz4eIleSP3e9jjZR8cU7fkYCmg==
X-Received: by 2002:a05:6808:5187:b0:4b3:3e1:4999 with SMTP id
 5614622812f47-4b96284bbacmr1353679b6e.15.1788471490887; 
 Thu, 03 Sep 2026 14:38:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:38:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:54 -0500
Subject: [PATCH 10/14] phy: rockchip: inno-dsidphy: check
 dev_read_addr_ptr() for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-10-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Dylan Hung <dylan_hung@aspeedtech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QVeo9CqSDIrrvQit1mSPvmpCj22EROJv5Ho3IXbic3k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmeh6Wf0AGL8ZNI4ii3SZOYtGpoak2esZ0SRSs
 Sdru9KBWsaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnoehYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Alc0H/R3tu0AuT7W5IJImsc0qpVhBRrnC8jz8jLq8ibX
 QUe5dhMVtMYI3yBdjDJ8nH0znyJjS1FlXErQhDBP+RSH4h9A3TRjIhEdnju/B1xZYdc2vQdQUjj
 XoQtFuesMtF5ZgWpUTl3A7du1b+OcyIbZ1A4GEQuDMiowyX1wQHjlbDNr2VrRfK0DHHLBeVQQBO
 +Hd06GQoMGIag9CH3U29s8aM5ulBj8Ggr0F2JI29ScMlVCb2D/eSHjmvxHz566PfGsaKglX0f+K
 QGO/evgnbFXjRegOHhVdQnkoPjB4yFZQoZMx9ZVFWNV2wgXoKPIHC8iYDEdTUURHaDZZ0JEHEsL
 j7Y4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:11 +0000
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

Check the return value of dev_read_addr_ptr() for NULL instead of
IS_ERR(). This function only ever returns NULL on failure.

Add <errno.h>, since this is the first error code used directly
in this file.

Fixes: bf57dd5889be ("drivers: phy: add Innosilicon DSI-DPHY driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
index 5be76e05339..9aaca8a50e3 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
@@ -9,6 +9,7 @@
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <div64.h>
+#include <errno.h>
 #include <generic-phy.h>
 #include <linux/kernel.h>
 #include <linux/iopoll.h>
@@ -625,8 +626,8 @@ static int inno_dsidphy_probe(struct udevice *dev)
 	inno->pdata = (const struct inno_video_phy_plat_data *)dev_get_driver_data(dev);
 
 	inno->phy_base = dev_read_addr_ptr(dev);
-	if (IS_ERR(inno->phy_base))
-		return PTR_ERR(inno->phy_base);
+	if (!inno->phy_base)
+		return -EINVAL;
 
 	inno->ref_clk = devm_clk_get(dev, "ref");
 	if (IS_ERR(inno->ref_clk)) {

-- 
2.43.0

