Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3159C5DF66
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 862D6813FB;
	Thu, 13 Aug 2026 20:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LH-P6uAeHYh0; Thu, 13 Aug 2026 20:17:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C1E2813FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652265;
	bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n5c7Gfic+6cDi0EV7HHwLkkAblWib/rL2iXaI6jkYGvn20TXpOsHH28/ODdM1rbLB
	 MQUvGKltpfsLhepKNAyv+l2KAMe5XvQRBHbaU8b2o3tr74sAQJCsbYJMUJKaKN0udm
	 vhPlER4VV4dDulnhHeMgpZpqL+oVfGoNOKi38TBwxo3cCnETcpu25M9czv5eidrO0t
	 sJcteHln2SEHBOc5RpxCUBZvBP6q4UB61iVg8/iTyfX4m1Na0VrGQeYyvqyM1BDnZY
	 QvTjrdO5ghmXzM2lLfCuXgmvkbzFO19vuZmRt+O8O8GSZc5lTkqjpPC3eJGOWo5bnF
	 7+9tYe+HQZ8FA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C1E2813FE;
	Thu, 13 Aug 2026 20:17:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4F312B2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B457606D7
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jRTyfcpr--gt for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 19:59:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CBD52606D5
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CBD52606D5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=abn1BYrP
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBD52606D5
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:12 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6aae90e595fso211910eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786651152; x=1787255952;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
 b=abn1BYrP0tLJ0/1oGsp5HxLZV3xS7QjBi8NBSCsHvQBEoGwRcJQx8eKABxTUsyZPqr
 1XRooE4R9Uo8kPsBoE3bX9XspudbTMOtFtl1zKeAbAoMIE3FTwUDKIxht1Y74oncTQ6s
 x/ZuOr4lfDauASB02/5j5fKYJjJTxNyyhfwPRMIdh85Wv+qRZZ+JnER1s1oIxM3ROhuG
 xNij4GyFg+pFgm5AC9nhM0AjIw6alyvu4nW+CVCkv5ZEggpwF1opfeDQFxmCNMCDNdRI
 +ePM+4ovGXOuBGLUOIqvGKmi3o/LdrtWFbEXKt4/nwEOxOn96lulZkv5OZt1wRmaN90J
 QEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651152; x=1787255952;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
 b=Kybw9j6ylJQOz6SEw1QUVy3jnmWNgiL73uBO2WGhh0sbpmdh2YnWBlp+tFZV8Wh6lv
 fm36+fU1ACplAnSY9TnNBqniIr6wKjRRbM3a0wYQQo0YANvu4COOuyeMY3yZDujIPRt3
 GuEOFSYX+JNa5iL+6wSrVFEplvkLMtRFFHxAXuVJAdn4g3OsbSmdV1aVd7tljkku5H5k
 nlmtCDfe/Ux81MCep3mQZj+GkhZmPAyvrG1HnCviOVQcPu7tWrgTrFqhZAgyTE7R8h1b
 yLh5t8TQB81jOyRvxeJDdL7K+weVxmKBFzfU0QumCLlzWZV/TNyWuZiRZGCbl8CU3gfl
 W4TA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqaFOb/0cAgyaX5PURfyJ2EpAL3wdeLeZU96BSr94BHOMkGWu54LyP+051uxUWJpUtkypQNdN4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxCIlijfnWZKJd9/v4QTm6wQCiiNmF5JiTeHO5Rxre+IEM+QclB
 mqPmZ4NWeepHU5CoVuJP95+4fqAZ+xKKr759PCtXf7rYqiGwvpl40UuM
X-Gm-Gg: AR+sD10lpzykdFMMmTPhHvQRQdAvQ4vkN7DhjntHy4cpdwOpkR3DVDTXFxudeJF65p4
 alLX7H+XtzpxT/VpMmr60ELKP7kG5d1A27MfM7nBHlkcB1na5I+8Fz3vpFt0hbNnvYBDJwpwt2S
 PkbexySfposwQlicGlF0nVshRxgb2ApJqfTyYV/S2lebFbxquIm83OE8XTFb5QTdgI8wMlxIfQ+
 ybMVNYtC7apb38NI1wM+uQY6Ai5Oe2d6LoZhhOboKI3mJy8O75fVNb6XUR+w2Kfqe6A4939KKvJ
 3CqtppYO346KkEDx2aD5PhM+GNk40TViKSkmh+jVV7oBit1Ydwbi7OZrRuWV8s2xIN8q1mWaSKL
 0FdVcV92oj1/Ejaw6zYzCTgmn5H+cmw1aZi33uH3u3qtzps/3c7y5LntaBN7GJ/5YVjNvubIK9r
 62i6IBNHe8V+KioFRejMog1kEAmuxKP6eSlYGLq2P0It53125cziVhKYgZCJqbD1PcYcDLhnEp6
 qSoHq/05fUNpNwimOcf8QF0dhmnqTKob4ikTQlFCt1JMYAbgH98BU11X5BSnmhv64ThsToxYtrT
 m+WPKOg1DbbW2acBXvrLRy2PoHJtkdVm19NekGYb8/8o72Mik7poKupzAl5kUmEOkyj1dv2QqEz
 fvL+2FlGSi2JBWvd1
X-Received: by 2002:a05:6820:2011:b0:6aa:fac5:a3af with SMTP id
 006d021491bc7-6b0d61f7c0fmr988176eaf.16.1786651151710; 
 Thu, 13 Aug 2026 12:59:11 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c34sm3345507eaf.6.2026.08.13.12.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:59:11 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 13 Aug 2026 13:58:54 -0600
Subject: [PATCH v7 01/15] cmd: aes: fix DM operation handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-submit-ce-series-v2-v7-1-593fcd8479fd@gmail.com>
References: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
In-Reply-To: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 20:17:42 +0000
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

The DM AES command path takes operation-specific arguments after the
common arguments. argv[1] holds the mode, "ecb" or "cbc", while argv[2]
holds the requested operation, "enc" or "dec".

The DM path checked argv[1] for the operation, so the ecb and cbc
commands always returned CMD_RET_USAGE before running. Parse argv[2]
instead.

Fixes: b01444aa14cf ("cmd: aes: Add support for DM AES drivers")
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Limit the patch to the argv parsing fix  (suggested by Simon Glass)
  - State that the commands always returned usage
    (suggested by Simon Glass)
  - Add a Fixes tag  (suggested by Simon Glass)
---
 cmd/aes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/aes.c b/cmd/aes.c
index 3fd83013ffe..edcd87cf11b 100644
--- a/cmd/aes.c
+++ b/cmd/aes.c
@@ -175,9 +175,9 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;
@@ -223,9 +223,9 @@ int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;

-- 
2.53.0

