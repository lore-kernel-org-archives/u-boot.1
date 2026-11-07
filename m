Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51B606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zKaPmGfi;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KkWpqT2l
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7DA97607E2;
	Sat,  7 Nov 2026 12:49:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GxSqtE6lFRIL; Sat,  7 Nov 2026 12:49:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B887660746
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055796;
	b=k/CjFwZjR6/p9u3QwtYzKDvy3rnGxYAcMocboUfWZ/Bm6w9B7fyrWOmVsdiL5t8CclXa
	 yBZDF2tU+4DYqeKMTx3p4m86SAwzs+tg8DYXhnUH8K18FpggyWFFT0lD9mmkBQ5/AFKY8
	 Rw0K1aOUSl/tZJMR/3Xifg+KbS7puHSqsr2h9wFkt7HLbPel7AVfR4BlMFbTL5I+pg1bc
	 aeAwdMGPoa5Xnhh9wULsMMatjbLg7zb69Ais+ON7T4/a6Yt9kWvIStphalYKnYw6JLplq
	 45B4QUBwgFfJf6mialOmVwTiPjn/ZGTlhlYbmzgZZE0PVWOFv2dOF3KE0yemejXQIxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055796;
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
	b=ghKDVhFhsVLGQRD6ALcMTNNF3d371YRZn5jxbcNBa1ohdGo6XxsbRhZe58IjDmTgGPFV
	 cCZE1okNk5Zn7g/Cw0R2E4P6FujnJ/+NaqdDTX5urEwn6O4wLa9iyKvwL9u4NDoO9B0Up
	 pQaOEzdpZl/5VDQ/BZb2M1PcQxMAF8NHvU5+swB+BmQcuO9seAe7DwYBxu2HnluaPwRU6
	 NHmk2/fvQdHMxdFsIJ19L/rG5l7Xow5BsizTzirG9m4DK7dhJBwAhTGvgAXdjPCj91Va9
	 YoT1yPPsaSuymakJbKclQfRUOnnaEGkJIfWMjlGFYxRwKITm26ZnAZf7sC6/4IcUyFA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055796;
	bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zKaPmGfimmrWm7a5eEZ4r7kjf+npZ4AnDc8IJtnKXbtRj9rDhUa1YombQZvY6fxWV
	 yLqCJLiGWw+s2JFACoSAaN3eolzKqNi4h3VRs2WUSPmt9694Q4kcH1WU8i5rgN2XpU
	 vk20fkXcpdkOhdtbJ8UGVPpQxbI0jPmSjKPQwFupldFc0SCjmSjCgMvMO8ImOuT8HI
	 WQidbJhzhHtNpd2d0LuV/GkeQhPQ4pobdpEn0mVerqeTD73YP+HU0TW28Uu/JOcxjR
	 az8YwVlZpWtLGR8KjhEfdDVUlJiiLPSoBorGQ+Hwk9+R+ZD9t8Th2B25/fte8T7h3O
	 ZkurfQfuKWbuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B887660746;
	Sat,  7 Nov 2026 12:49:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D78C2AC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B2C0810E8
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RipxpofEwWwR for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:22:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 334E880FC6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=KkWpqT2l
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 334E880FC6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:35 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b7073ddb15so14939a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036154; x=1794640954;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
 b=KkWpqT2lOLC1iUidxKALv2b3PXQ3NNP//CPKQX2Woq7C0IVhoIRub4y5G8VtvSu4Ri
 1p/1n5GOZSckp1fEDJjyBtMBSi01W+CqlQFfRvOjs0J/0BsmBmPRbGxXEtVRC78zpFYO
 O//QZEC4ewaKnYqCH7JPQm54IXcgt5KBReOkUIJNbww0xXTrpI59ym1HPX5nRzEPgDX7
 0Wl/6NCBHGe2qx0ymIDJyzo0YhV5XS+In9nyeOVAjd1uRiGKFLRoEgQddfPuAOiLEqfW
 M4XJNjn0Uauy64/FCr41HeLjow+4kq7I9BaUQhK7TkEpJPyP9zZ5aZ+s+ZAfqiXyAvfZ
 0xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036154; x=1794640954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
 b=OsTCtDOu0ZwIHMQ6fPqXky7hwBCOthPJTR6I9FPPdynBkbzoX5l0O9X8QeZaP21d+f
 xSNQFsL2v11tUmCjP6T+YCv4lnrapoIX9+fdl5Jfwx4EMTYTUMV7zHkjfpjpu/SA83bS
 igNkaHVmMGbyL7R846pvL9+Xxuv26FiOiCnpHz/GPCZf0FmJJB7xrV87XeUJ6mC9p/rN
 VfxJumAbmQPXvoOgDV/ZwcJPj+e1iflGcKjFithzRl6KlHOuAqtKBbwsIJUNvJROOChb
 CC8cVxldmnUczMwXMJsZ4d9ej3O2yRGhA43zuMfmeSLwWaiX+oDfw4gP7JaACdPD/tby
 yx1g==
X-Gm-Message-State: APuU4Z8RBj/FkCc4uoqFtgyjm8WJW4wLq1VIMc7eFrVYcPZfnpaUpacV
 58dHN6chZX5rjoEbnXzJ76GOH480KKYOshrlbczh1y9D/ei4lzGcS6JXLUjMmeHkI5SSl/mG8Rv
 u6nSI
X-Gm-Gg: AYBFou0AiIx2n921VtefMJehNVi5DRBH3S3VSiwxQZa0bxQYGwy04rtyubYfCxSu+Eb
 tHiAaihyLYPAbbs4K/Fp4b/cIzdp3G60ZIg18eOHXRpPTpP/OYcOQpXMyJ5DFee6natagj7hZwL
 is0bTxEu4hveiHpbPIb6wou9I3QnPIb7syhpl0a22b+bw/ZkbkB2XLFisgIrwjiYM62Z/RvfYCL
 +hl9RVEddsVkG54dAtgy7jdUGJtWEwHtyE4T/qWm86coSv+WSUf1RXb9Pa0FZxtcO0hif0wBqEj
 2JwXlAgH2P+eEKGMWdnEA+oybsRql8XmDnShckheyhy4x2XlmQ5X7PUIrV8/MsIwp31lL8W9XGr
 ME3RQruGGqEaUohxCyEgi8uLufwuznRlJ7GtWFf+7f6vWavGwL6cgz9cHJIddSTSmF60aZVYt03
 1ENrqG3kouKLkn6Y3W+Fg6AilCQIS6iTjexahPyUplpdd1Q62nzG92++iUONYGCLzOUM2sJvNqp
 ZgoIg3Wrzw+za2JGW0xaBD4KyheGG1zSTC9A5vgByY5s74/Yr7anIdDTJ/Sf4i4cd2JflyHKzjK
 SR+6Hi90Y6eibHGcH0zV2uIQhaM1qIU4z1peWRIOpHMW42cqeQN4jJckZCn+l5tAM1Ht29DItSJ
 Y7WSJxi3339A=
X-Received: by 2002:a17:906:e8c:b0:c2e:3698:dbba with SMTP id
 a640c23a62f3a-c4d34c172a2mr400781966b.4.1794036153756; 
 Fri, 06 Nov 2026 23:22:33 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356eae34sm132640566b.85.2026.11.06.23.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:22:33 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 03/30] phy: cadence: use reset_control_assert() from
 reset.h
Date: Sat,  7 Nov 2026 08:21:57 +0100
Message-ID: <20261107072224.3492260-4-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

