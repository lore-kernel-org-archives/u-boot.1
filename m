Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8E606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DxUcOaYL;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TmHmkHhH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3003780F38;
	Tue, 27 Oct 2026 19:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HkhmB-jK06I2; Tue, 27 Oct 2026 19:43:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 65CB480F61
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793130187;
	b=oYU5OtG8bmZqfuTzamVdWW81ApODBgYcif4azWdj+7zV4gu/4/7xHR2LeQ7FgQXyPLbV
	 Ul8xI00VzssKBeWAwxei6nk84v8FtfIhQS0neZSKdQoHKvBeFUKoBFbXv5WSXMEcROgBL
	 vz4HeqW+kVP2q5yyGgmdjYXQ7o2jsr/23ELOPa5U+cfz/jLBXXJ4PecHISC1F327b760H
	 es70OXB9UiURUlLXZMt8EPltuPgKXIm12tUqZb/L3miF4m9/lQmJJbFnwJUD6eOz9lp5b
	 SYNqs1MvwVmjkNvK2n276+vnhT+46Rk1OaL91cyI2vUrvXAkCAVOl+pJFcsdzg+sWwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793130187;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GNsy/egYaqpggc2GeDRrlNs1iWtWYxUjd0zsvoQKvkM=;
	b=VrliOzd+A/xkmvkpsqM8IW0HTJqqmnTTg0321UeJq9l+oGl1Ja0tiYpDcoq036e18XDN
	 Upc/FA2ka80fKjEVa0UNXAAedCNE05RJIXiqknbh1KqYJKfioDTy1oOuOwvh7LGpbkvEn
	 ZFYI6K72WAiicDNcLnFsRwSFKNNQqwc76tIG6oIi5pyLHFOpwxXBGnBWRCkeTyKTCyy36
	 QAt/IzBYefMIt1ul/egRMsjG9YWCRVrmDsfEdowNuLxteBnbq60P2LyisvuhYviGF8KM0
	 0vDpAqvRIgCu8k/pXNfJ9LCUyu/45sFrL31I9P6aG3B08hbZjUFLfWV9TMUoCYGM1fw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793130187;
	bh=GNsy/egYaqpggc2GeDRrlNs1iWtWYxUjd0zsvoQKvkM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DxUcOaYLoC6rC8mX8NDt+4O0BgHGMpLX5/zuSJJcRX7gbr5pcjMA3/BSqjGzW15CQ
	 Zb80zciRo7p5CeywbzfYkhVYYyDtjqzum0tThrNvombFJC8b5eg3gWxNjmPSXBnrGT
	 pSMkHPCM9Iti/+DL81oOwKxVgqtpSZEtN64n7XazQZbZpsD5+6g0GPzVSn6D91DD80
	 3Hl8YxduobFXWftrKgAn1Z6VOtSAEu/OPymNyU1qK4TZXAMUonLkaDwZEfz1LRprN4
	 ZZ6hXbaSlLn6eOdLmp43ZMwLfovoyqxB4m8iMKCgzs4rctYYEmzhoBOYgFNQ2/Ezb9
	 o7Wnm7mnWfgLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65CB480F61;
	Tue, 27 Oct 2026 19:43:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22C0A4D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 142224055C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:41:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8b5sxIqcU-B for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 18:41:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20A014054F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::836"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793126471;
 b=mb48eJN9eWIVfcLZhH4fjXVauKeenJpzYsCgGY7NIm4LPFmKCML0MOBX9BfnOaTbm778
 ElG6SSndT+Fbg9uXnOVkVVJRdcvqNfcJxuvjVao++L47JfXWk+x8PUDbSPFp8mZoSLGNg
 ObpXSmwdtUrMtQSlMV8dXYfHlS3dOsOFzKLnmvFVsoxFaQi+OGyBSHBV4y+hpEEPvxXqy
 nF4yY8D9palw/oRX08F7Hde40COFdsL4M3b58PxmlOOG9+m9580Kww+nrTbwaauEsQh2E
 SRggy3igGpAwgWBGclUMBxfHXUQvs4fd3ER2eS6JhA8ziBTaZ09+Q1ki9tPiPxGHT2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793126471;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=GNsy/egYaqpggc2GeDRrlNs1iWtWYxUjd0zsvoQKvkM=;
 b=sZyY4NiisQIQ4RyzXzwescqmrsWP8CXyQ30vPN/t7oye9WTSWADfmnNgX4SlCxto37pf
 erRnYnQ28jaVEYajy/PYIw3BTCBSjnyNFV26I9Ig+KihnfUKV/jS0qNqeuLM0ZPwvJrcS
 QgYkc6ppQwEuheZxhIiA/YvpGN8h97mRRYttfnLSZ9WPAJI6+QpEtUXuniZs0OavWVM/I
 n+8eV3C+bX+JuhF9C1FryJiBxiC5LlFcONHurWFD+6Dn+me7aEkDrb/SWYimI4dmpcwgL
 K0KkWDhxbJALfaB+O3yXBYjBbpSs80Vl48plsonoQqOXuvn0E1UZO7dX/FYz1mme3rw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=TmHmkHhH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::836"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=TmHmkHhH
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20A014054F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:41:10 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-5365b48238dso2454951cf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793126469; x=1793731269;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GNsy/egYaqpggc2GeDRrlNs1iWtWYxUjd0zsvoQKvkM=;
 b=TmHmkHhHRWz8KR3YT3/GT/Sky8Z7WFRhRvqlrbgVJfkz4QeRtSpXXsxeuiUW1h4d+g
 D9lQoBfsclsYR+hi62ZKWubQHKhp+/+5fz5AzlMc3rWJ6XTNn13/yemjAdAjDY3dn2Iy
 3LtCD5dREKft1SjIjT1nZQ8G/q6KFPxPX55ImwmxjRCkgC81xAaMxIDDi26RnI/yB4Dw
 J5vwwQI+CppQwL/4WbmQOzybKNvKO5GTerosOt2qz0iZ4FNkA4OwENathTI3Foz9aMIj
 nhQQudeYpSvQqkO5Dacr4HRqLIEwRFqDDAjtwSIHiepjLvfVKVN0fOaudfXJN4JvuMcu
 rbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793126469; x=1793731269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GNsy/egYaqpggc2GeDRrlNs1iWtWYxUjd0zsvoQKvkM=;
 b=UyE1rM+UJdzr8TGeHuY1QqbwJUo64H7NbMjKPxjAfSL8MMzAG6bEq7Ogh8jz+Nb04E
 6ujq5hSC112Tqik1/9b7Z2B0iuKcVo+zFGdxfEwBOwqVDRySEKSu52mmSKD0GLaGYd1+
 RB7ZZdYqFXtSqqozyMl0TsN2bU5y/KEQ+p8OwU4CMH0n7Ra/Cx4DdU7GvKK96k2JxDDG
 ErskOQJD3HUXlb3+0bV7kNapwOWjjT4ebT7QLVkjU/SFgh7e4DwQfgAAl7oBhLCcn1Au
 TF3OLufxJtdi1sZCExYgQToTtiJqMZgpgwuENuutJATh0Ea4klYbS/YEfOXkdmTXLmhz
 SJuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGLqao/SLEqBiXQumJPgvBRfNWaMtH6/GXcR1uvfBqTQII40HlIuVfjAzfyqS50aUootRgVM0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKZu/mdbZ/aXbgzS/8EcDFB0DDW1UAnSiNdxfQeimYfCIDjns1m
 nrIbk5eKfhT6g7GuME49deekWkQ+N+J8McEnb5ygjVx5rJEBr0fxlQ6D
X-Gm-Gg: AYBFou3yPERvMNsLsgxl0Uk2UP+yqduSgoKTN2XSWCQ7XsA+UKxZynH2XWdqtBabrTN
 0SVJQrKQ+yrNlkjhQ0tdHhsfvvDsuu9+wePkIIgXlFK3qA071Ac3Hcv9UHCjx1kJiXynHEZtwo0
 3IlRfoEAROGqzJKE/bO/s/3DmknBNJR2cmY19C2NzxeZoaiwMl5lRkCTZpqa809APhWZ+7J6M3S
 cJVXTOuK3KneBUD7Krtkds/J38zSJI0aWcBnc8Ve2tgzbvOoa6JrhX77na4DYqC4yK8eDNlVZMR
 Uqc764xgd4lN68S/xOoDlDSxXzs5PFl9qpCmdo9WC12WN81VGTaUMIe7WZClP1bgxsiEUUFx7VP
 hvwhThWc83pU5zk1K7HQvpekIkJ/qxI0U3LAwnaa/R413mXh4w70tQ+385JsyKVycKFiZO2EgPV
 NYkO6+fnuKxODIDD1fc/e5DltQ22Nly/YhyczdAdS60QzXp5dQqkdZCrYbAnk9Txy6CEsDWQGnI
 HKLtyIZc2/LkH5fry23TAr3d8VW9DXS4jU1nA5dFhtP26IA1LRZkCF3yys4hlcFmKrhSxsTvcHh
 ItY=
X-Received: by 2002:a05:622a:4d3:b0:537:dea7:adb1 with SMTP id
 d75a77b69052e-53fc8db64e0mr3429211cf.4.1793126469363; 
 Tue, 27 Oct 2026 11:41:09 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c6bc95b66sm40453416d6.43.2026.10.27.11.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:41:08 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] clk: Disable parent clock when clk_enable() fails
Date: Tue, 27 Oct 2026 14:40:16 -0400
Message-ID: <20261027184105.6534-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 19:43:02 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With CONFIG_CLK_CCF, clk_enable() on a clock that is registered by id
and has an enable_count of zero first enables the parent clock if the
parent device is a clock, and only then calls the clock's own enable
op. If that op fails, for example because clk_fracn_gppll_prepare()
returns -ETIMEDOUT when an i.MX93 PLL does not lock, clk_enable()
returns the error without undoing the parent enable.

The enable_count of the clock itself is not incremented in that case, so
a later clk_disable() of it returns early with "already disabled" and
never propagates to the parent. Every failed attempt therefore leaves
the parent's enable_count one higher, and the parent stays enabled even
after all of its real users have disabled it.

Disable the parent again when the enable op fails, the same way
clk_disable() drops the parent reference when the last user of a clock
goes away.

Fixes: 0520be0f67e3 ("clk: prograte clk enable/disable to parent")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/clk/clk-uclass.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 0069ce9a887..3fc772c8b4f 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -669,7 +669,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 int clk_enable(struct clk *clk)
 {
 	const struct clk_ops *ops;
-	struct clk *clkp = NULL;
+	struct clk *clkp = NULL, *parent = NULL;
 	int ret;
 
 	debug("%s(clk=%p name=%s)\n", __func__, clk, clk ? clk->dev->name : "NULL");
@@ -687,7 +687,8 @@ int clk_enable(struct clk *clk)
 			}
 			if (clkp->dev->parent &&
 			    device_get_uclass_id(clkp->dev->parent) == UCLASS_CLK) {
-				ret = clk_enable(dev_get_clk_ptr(clkp->dev->parent));
+				parent = dev_get_clk_ptr(clkp->dev->parent);
+				ret = clk_enable(parent);
 				if (ret) {
 					printf("Enable %s failed\n",
 					       clkp->dev->parent->name);
@@ -700,6 +701,8 @@ int clk_enable(struct clk *clk)
 			ret = ops->enable(clkp ? clkp : clk);
 			if (ret) {
 				printf("Enable %s failed\n", clk->dev->name);
+				if (parent)
+					clk_disable(parent);
 				return ret;
 			}
 		}
-- 
2.43.0

