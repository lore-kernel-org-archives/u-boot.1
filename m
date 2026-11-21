Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4C606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UYeEeLxv;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uyAb0QJB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4745160728;
	Sat, 21 Nov 2026 13:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1j_18Y9wK5C8; Sat, 21 Nov 2026 13:14:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 043896071E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266859;
	b=jC2CKpkVRsDMjuMHFCUCN/JZmphoTI43ZaYtXuQ2KEIIr8saKh+aJJfaLViObtwgSXM2
	 9kWDfCmg7Yegy4YLc62EZ1hXZDeMnVZjPmsmpnkGP/mSywweq7l+kJKUY8nzfzTkx6oRz
	 Hi3pKWJxUGrn8x5BxmFEqoa3u6Dze8ORR2lNLWB0uVSF2Dqby5Nfy0uOZcD4pScH7AOgo
	 UmINi/CQioAY0G9fjPHl5LdncTuoeF1KLI6yVz4PYvecniAXLhp+aZq5eof9kKD95Yxfw
	 K75LHsNsY91buWOU2HnPoXk/ZBnw2enCZMCsO3DvLfyjgaXAobzyp2r+isvZ3NThmhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266859;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
	b=naVHiNORDWJFDXSq7k9MR0Uj9lBuo0owDsEKJ4Yv0aueZrhI4QIO1hLbY3kRZCDLwqX8
	 zWQ03BP7LnPFdK7CgSYndEcBBy4pN9thubkW/eu8aqayfGx/Vv7a30b/+/egjG2yQo95b
	 lNd2cDO+8bOGr8M+MeHdsNWXiqOOXkQA9CeggNDDD/eziSM2MDuiYM7chWNHc+PxXbpLf
	 rbO+KOASM+nMFtUjna4WREO/DLnyZc1c0tXECdYvhIz1YSDOdDbt2+oWkInZXvnUq+rfy
	 igbZHo2kuwQ+uzA6ho53fqbWehYBiZooV7JXqz2yLVqXP9k2MgvKQNIEFyiU7zrP3Zw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266859;
	bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UYeEeLxvl7AmGWeLfVp+bOvA6zT69oXNwDt/ElVPtcOK+XfTzu/v5Da3BIDnTWJ+u
	 5hJxYs1r2lIFQygMpjcN2R6/+l3XpmhN/mXllDzJtTbWVjMsZuXEqFvCapZRt7CV4V
	 c+Iae3cjEhCLKdntAdJrZjdas4cE4NlIoYPGhsP+0Exbh95nE5mFrTFOnzoEC/Jxxa
	 Aj1l/v8zh1QCtgsZJT8UJYOHTAwsRrxGlXirOm9bg7CJkSN6c4WEbGprakXU7lexem
	 AzPu+orgV+50s/nlTZAm4WATIHOwhmvO75TRYo8hXJg+VwjC/PPmWI21RinmuqjwXR
	 dLtuQtSD8oxHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 043896071E;
	Sat, 21 Nov 2026 13:14:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 196F615D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F407B400F5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dwz_QnLg-sIr for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:53:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1423E40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=uyAb0QJB
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1423E40012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:54 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c504707acfeso32939666b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262033; x=1795866833;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
 b=uyAb0QJBUfQXbdskS6rvvwXqLT34hvRXg68jmt1CvxxZLuklmXs0ULpShaeXAq/R+5
 4QK59NTnvF4V3u8DkHyyxXf01Yx1DvBpTg5gNWsKZBaMjlCsCPPoeRvQ5ZEqu2/nMQBe
 AdtrAQMYJ7E9NsA9B+Oo1jckV4em11xj811S1NJ6hB03dv6qahoLbmU1dpBkkXVe8nWq
 wrqyzxnZBU0uyNHRr8A5P431+1LrTAEktMNDMYLtgza52WBHQselPkTR9OEsp/hfvUcj
 loWKjHmcZuR7exorTcsn1TRm5lOTAYb1AeicSq4SqY6Kpngf1bHAwB7OTKxdOi5PNYBi
 2ggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262033; x=1795866833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
 b=YKgshmKFY+2BmUNfDWr5Q3WB9PgFqh1/MjZ1CbZ176E4zXD0Ae4UCMQmkQ4G4sSoYc
 MXHXSXetmifXEeK/OaQ8kN16PlRpxtGoG28siMHfbxODB4MBhy41T775SaLPYbBFpa7M
 cg5/bLcgQnDpTMOfaaDR8569CLP94kzTPHiTE6UuyT1vr5A5spj/UEGg2EhW8MJ6+h9a
 J5nzU3Drrn+ZIfnFYvbhFigJ0hsMMhavqATRhNGvfBvplIHTsfO1yl1ADVvgewpTw1AM
 qjyFYyPxpD7zkjRy9YvEvrLwhS+zZ52YX8/ioLQgHUMHmnlFCUmJkKGmYBPiXFodY0mm
 odEg==
X-Gm-Message-State: APuU4Z8ejjNgK4yzpjuME10IYs5zFG2wOQnfshTh7cSQ210CPLXWAvHQ
 mivHyKV3NW+QB6xtwsi5BpNdc/Wqnpwa2+aUzU6KBlAQSuGC9+vhtrOWqDFxUwTHzM0ASE5Aoip
 x7jHu
X-Gm-Gg: AZFdTZc9HzHf16EVSf0ZLU5NXLhZtvUoS2dLSOzuE0nfJexAjOgIlqiB3dyoP9eKLli
 RXTy6ooK/yBhCBKcN5ppBYOIDZPuRq2wBSLPK6szxzKrgDQcjCPbP81izJ7RxkET911MF5cgUvE
 hQAW856pra3FuO3YT2LxDHXoqz1JOVK9LiVPRe8iDu1Bpl4VwEgG5lsP0Y9PWkWTvleZ5qaRN9w
 I51nmK1XEw6kAdI1L1FFFPCSmxpJaNljxuEEBiA1HLDne4PYkeZmWTyPqqRItWkEpoUEfttVJHx
 +deCO3fbjWp6TSvXh6z+zRfgXFT4z+GQkPIgMC3MJThU/7Nxc5Q4rpMdnCz34XdO79KHCU5+Rwt
 0vfaGzel0Ux9WD5alnsfxSnlkO9uMZyy3fGhYrN6QG6JqpG+sGIpSrEQLlYqJ0nBWWJShNE3g3g
 kBd5ucXyoltcYeChDnRujC8jvixHV4wealjI4XwiflPV51zhB7QklFWfbVZhgKZWpCDx1JPOjPN
 w24Jk8eeuvrgzpYerz+Pq4lIejXwb3KIRhMUhLKQk8ciXezy3B+P73VOZTYZwc/az9AYdG7YK+M
 acVpzrmgplG2BwJ4AEDN+haLWhO/VQXnIDxTHSWADtH+YljzQ2cfJRwoddmvyWifim5fTL99RJ6
 yHkc4C/K2QCcEIiubdmTQAQTSLHdAhTI=
X-Received: by 2002:a05:6402:404d:10b0:6b8:7d2e:838 with SMTP id
 4fb4d7f45d1cf-6ba37c769cdmr4430633a12.1.1795262032859; 
 Sat, 21 Nov 2026 03:53:52 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370cbeb0sm2366040a12.10.2026.11.21.03.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:53:52 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 04/31] phy: cadence: use reset_control_assert() from
 reset.h
Date: Sat, 21 Nov 2026 12:53:08 +0100
Message-ID: <20261121115335.548142-5-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

reset.h now has reset_control_assert() and reset_control_deassert().
They return 0 for a NULL reset and call reset_assert() and
reset_deassert() otherwise.

The sierra driver had its own copy of that in cdns_reset_assert() and
cdns_reset_deassert(), and torrent mapped the names to reset_assert()
and reset_deassert() with a define. Drop both and use the helpers from
reset.h.

The only change in behaviour is in torrent: a NULL phy_rst now returns
0 instead of a NULL dereference.

Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/phy/cadence/phy-cadence-sierra.c  | 18 ------------------
 drivers/phy/cadence/phy-cadence-torrent.c |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 9f8a6d8d43d0..d8b2e040c50d 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -258,8 +258,6 @@ struct cdns_sierra_pll_mux {
 	struct regmap_field     *termen_field;
 };
 
-#define reset_control_assert(rst) cdns_reset_assert(rst)
-#define reset_control_deassert(rst) cdns_reset_deassert(rst)
 #define reset_control reset_ctl
 
 enum cdns_sierra_phy_type {
@@ -336,22 +334,6 @@ struct cdns_sierra_phy {
 	unsigned int already_configured;
 };
 
-static inline int cdns_reset_assert(struct reset_control *rst)
-{
-	if (rst)
-		return reset_assert(rst);
-	else
-		return 0;
-}
-
-static inline int cdns_reset_deassert(struct reset_control *rst)
-{
-	if (rst)
-		return reset_deassert(rst);
-	else
-		return 0;
-}
-
 static int cdns_sierra_link_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = dev_get_priv(gphy->dev);
diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index c903fcdb3317..b9f61cbeaace 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -215,8 +215,6 @@ static const struct reg_field phy_pma_cmn_ctrl_2 =
 static const struct reg_field phy_pma_pll_raw_ctrl =
 					REG_FIELD(PHY_PMA_PLL_RAW_CTRL, 0, 1);
 
-#define reset_control_assert reset_assert
-#define reset_control_deassert reset_deassert
 #define reset_control reset_ctl
 #define reset_control_put reset_free
 
-- 
2.53.0

