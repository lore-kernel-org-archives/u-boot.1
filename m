Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA17CC79F87
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 14:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42F1240BF9;
	Fri,  4 Sep 2026 14:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHMEk_yyqJgF; Fri,  4 Sep 2026 14:47:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5598440BDE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788533253;
	b=rpmnl1ghvG9UXHTyuw3nOR7hEeU5Jp6TDfMhAZfPz+D4fvqqvFZNO4NTitEHKCgBVeyq
	 mlnvAeraeU739+MfGQWmUkEbgnguoIn/GRuCSKBM5wuxV5iSb9gKKTOQ6oY8YkGpleDLu
	 dL12KyRuOK44Ht643EwblWlhjIAjredY275tuedRTSbVOAplBflQ3Rx1pfcuM+KqV5WR8
	 0mMEKN5b2YVv+e2f8fhBFuSfQuRfHdMJdfKAsta9ySvuA1Kjb/j6sLo1ATEzcQ2Ia6Ltg
	 SHU7D+7Mm23kNzZMMF5XCFtiG69Vh3QaZh0C8TNjog8j7aOeSUj+iLUVIVL1sB1FEfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788533253;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VgSeVJ8WzoeOidizRaeiWXO1qpoadOrjynnMUfTjGNw=;
	b=G4YpBaezuNo/SPRqiIAxdHqpxxzc9E9D3VO2lQ1dK/rwo50z4mHEhmuenk0Xzbo8avey
	 0ki3HpTmGKm/qA4J7o4+mFgNQ++9B65sgpRAfzZG9oBBKjorXuTCOBN4KAacSjwMFCiBz
	 EDfpyjYJU1rBmLn06AYwUnXyi+x5IuxD0lwsHFQOa06NtG4YLb1KujukfoUdHz9oUrbsx
	 IFv2lY1ABJpW4BgCdruYpUWcxaOmwG+4/5UxzhRkON49yp14VILoMYCpp41pKvuhDDgrP
	 m7daQbon/fYYKFNNCL4qcunBcvHaYtj/bdJ+GS5F9CsuMvtiZT9YOzZmHcGSxPQ1vtA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788533253;
	bh=VgSeVJ8WzoeOidizRaeiWXO1qpoadOrjynnMUfTjGNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uEUMf/tRdoCF6ZKJGpYNhgTaf+eTneaUYfB3o/4nLBCYIhtwJBnqJ18ssVB3vsMsE
	 veKOVEycRkdKsP+dPVbOlgG2BZKA8uTPZheM5rZG5mWWA7JFsauyG8uWOsQ42u45p0
	 dkXAyQ5d3QL+B+zgom+eiJyEp0tzTcOoXpV2rrOAIlCsVT1WTn0iqf+Pv9GqZTAWp4
	 Ev7PlXy4UdZQO9zEhALbAjRHm44zsjgHFj53OfdNZIBZQHdpqhcQ8vcnHf8FIBYqx4
	 4DVCjBIebvIvHNj6UFhogt1G67uqGS9v4/7eBxBoKc07KSmgltCzv+bOmHnYyHc3oa
	 EXz91ALeV01tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5598440BDE;
	Fri,  4 Sep 2026 14:47:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 45F432FC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C75A404CE
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZsxOeSvNyyXm for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 14:47:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 67EFF404B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788533248;
 b=QMO4AVBERQ6ILH3JqFcaZ2+aQhoWIvNweolhaO3PyZERNKWmZBgj4pbgbKdOwj5XLhO6
 REyS5nEpJBCox+bUSbaZ+xK5ShAgsl1FfLkW2d8CfodtPCeJ2x8udfSJ05GP88FstovP3
 WMSMsnGvhqOwg/RoDZLmODbYFeiV8DMzL33saz00PgyCwxx3/x5RsUyrqVYP6UwBID+0U
 w7iSfxYTucVphEXvQKC+J9HTgRstxIfsoW35COKA4rUnrLqhiVofDwdi8p1Jj48Jx4m/S
 j/2xOoUoeyZopGkFjB97OmQVNXpnD3Xadu3TQcUEsVLsQDe5BBCZRkXjf3If00HLbhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788533248;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=VgSeVJ8WzoeOidizRaeiWXO1qpoadOrjynnMUfTjGNw=;
 b=LczMgjFBRmur7FttcdUugiNihMPgbmX7em1TSoWZJSKug5BS7rRzLGtp0bYePjQUMbZ0
 gTO0Ml8l49CYoAOvQ/SM83fVpMiJnryv0zZPAQNJ0+0cVeJbmDFus4Sd9zuuukdM+EgQm
 wyYdrmYGPvpLAi3GODYJjpUBASf4PnBHSygttCTbcy9gpIYajt9Blu7jsdJeZTy0wtY2i
 f2riO7DZXO0Aa2pSpuQ/u28qYB2dB/PFP0rBVj7DRq7/KYbwazp2lKKsQfohbe/1IMSPY
 06lXlDYQ3F/f4blIGjwgsR3EDO7slpq9QECq0RnnIKTo653ckfTfwi0ufVRDGgWGY5w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=N7ylJb0s; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=N7ylJb0s
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67EFF404B3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:27 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4679f619d3bso746362fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788533246; x=1789138046;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VgSeVJ8WzoeOidizRaeiWXO1qpoadOrjynnMUfTjGNw=;
 b=N7ylJb0sFT7HfzXDqhto0vrNc7Ck5tYWmK+R3Md6wthdbFiBeD9uH2Qh/+Vq1YYwRA
 e3jtFZ6lteodPxEnRoz/LC8qbHHWXNgIdHuiWEhNUL/AQSWpIY/Ir6BBd4lD5ACYpuT1
 gQ9Ya/cvg35fUiyvtO2aE6K6RGCVW93rhHZBIrUoORXwo5BrjBQCjUKsFjEiHKx0Rryd
 s/7Wm+I9Men/rNopEm/dQ7Chb99utQLW2hqlRFBldwD+4xeQpTSpp+j7OUAjd7Kf1wxx
 B3SIGRE2Grd8hOAG1XlS6IAoSkpj5OiyQsPCQFP+ezJ1oaFwcebezN/MS0nVSlXCYEw/
 w85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788533246; x=1789138046;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VgSeVJ8WzoeOidizRaeiWXO1qpoadOrjynnMUfTjGNw=;
 b=dsvsILMXEpIJiupmZI5tTXyjXs1DVg0e/itzfQ1/Zp9Q5OXjEiH8X++SX76Xu1QovI
 ZSUIhZn0pHyTFfRo7N+KBe1qvWLeRXepSSBRF4ikx496nwQ4wlLHhjZJpRpgV9+xVWwR
 rhYeIxgLwknAQMogj9AVT8/rcFyqbHrtoTzQUtnwCUUZ2VjRaFLCQbdqEdULKikPSubY
 /Hv4hR4TDt6flhwHoqmUIMdMkLbp+X1BPB1+uO34OAwWfk/D8oVyXl7QLUf4M659/6SD
 kt9H6H3H8vWkiWvAVad/5mII8YMfVVr7RwZf3O8ytA0brVZSgowy8kEc7Q5w7xTp/Gm1
 ++aQ==
X-Gm-Message-State: AFuF++k3wKpot6Hdt4mbuV8LrGxjdC0SqCC0ayiQ/+/DWBSK0oF3/wEo
 dj3s66En0DDX0s8H05HUzCLBW+uMovKDiFgWWVFpi3gW66oYQBU5pqnj40BENY7ufyE=
X-Gm-Gg: AYBFou2pWkbbZcfF7IuYZJOb16TCTZK1DlncCWXjvoj/24MZPrU5jSZUtvDoqrHa8bW
 7B4f9hbsZWpCJ7KOOadHOWN+J/KLKspnoIe7J0Opgfuo8Ffl19FXaYvGtOzCWrYFuQmmNbD4t+6
 7rnKiWKbggLsLiXymCHsiTFPH9+lvA4g/ipm6Ljk+FHIqMbaM4xzUppv/4Y865FwoNE+44YVmhQ
 bwIYYjLs/Bm3EMvDAfdxK84wGwxjJ1gKuP7ZDy6ptBcfgOvqeXHtnx7xaq3QGNXwgObaxT6xioj
 ygMS6XjtqcUWOkGQ57emL8JLokAXuMVw4qdOysJeeuHqpFnv0sXM1J25jRERvK7fU8HVamkEw17
 ns4o9ODG75CgwFsci40ruDz29aofsDUmnnP3kYA4ITEH7xKaDN7TfvHEX2iW6AVkouCjawsi1HN
 +pG6dZpj4P0tufJWTydNBNbHiryC4ZPv/o3NfsLbU2o7A8qm1y/G/Wlwla6FTzYoHtzGK978JMN
 gZz
X-Received: by 2002:a05:6870:c24c:b0:417:4693:ca0 with SMTP id
 586e51a60fabf-475523c61b8mr5328872fac.14.1788533246542; 
 Fri, 04 Sep 2026 07:47:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47554935962sm2118988fac.12.2026.09.04.07.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:47:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 04 Sep 2026 09:46:29 -0500
Subject: [PATCH 2/6] configs: mediatek: drop no longer needed POWER_DOMAIN
 options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mtk-power-domain-mt8189-v1-2-ab9d8cd0f01a@baylibre.com>
References: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
In-Reply-To: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, David Woodhouse <dwmw2@infradead.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2955; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=zNjzuAWw7XZwPCZ0Vemw1DCbjT+hxMavVLKK9pTDz7w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmtnVE48fVlGbPFrgw6soF6MeeQRdelDjhWwNo
 7aswl4whg2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaprZ1RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASLQIAIKSqA2mxhaCjnNrGK5jGmKUR1mBpPWlTgYg+0v
 ZL5UZOZI+Gm1fbMmDCRKcFq6/n60QnPSJ9uwvyQVO+NfxxEhrWS3drqlEiCvhqJlWqOxooEbfYE
 Tpn5rVbbotpD0/R9u+XnWLIEiqYftmzi27maHA4N2l3FWd4SoVyEcK0r2AymKD2PrwMsrRi2HMs
 KuoilLORl/Ei8QPxoeSGGUdmcqKfQxMVvfbyQMfvDFbUb/Qb6b9vmPBEF9SqGL1K2/RNQ3LqwG+
 mt0UqDbirPEBKG4CUwUPFA60n3P7pVmwIPkIANRBGEOvH6cZacoemPTlb1zsLuTBxjZFN3Pb+6E
 8BJM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Drop CONFIG_MTxxxx_POWER_DOMAIN from all MediaTek defconfig files. These
options no longer exist and MTK_POWER_DOMAIN is enabled by default when
POWER_DOMAIN is enabled.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt7622_rfb_defconfig               | 1 -
 configs/mt7623a_unielec_u7623_02_defconfig | 1 -
 configs/mt7623n_bpir2_defconfig            | 1 -
 configs/mt7629_rfb_defconfig               | 1 -
 configs/mt8188.config                      | 1 -
 configs/mt8366_genio_360_evk_defconfig     | 1 -
 6 files changed, 6 deletions(-)

diff --git a/configs/mt7622_rfb_defconfig b/configs/mt7622_rfb_defconfig
index d35bed49afa..d67c7ce3da0 100644
--- a/configs/mt7622_rfb_defconfig
+++ b/configs/mt7622_rfb_defconfig
@@ -49,7 +49,6 @@ CONFIG_PHY_FIXED=y
 CONFIG_PCIE_MEDIATEK=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MT7622_POWER_DOMAIN=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
diff --git a/configs/mt7623a_unielec_u7623_02_defconfig b/configs/mt7623a_unielec_u7623_02_defconfig
index 13fe8766b98..974a169c7f5 100644
--- a/configs/mt7623a_unielec_u7623_02_defconfig
+++ b/configs/mt7623a_unielec_u7623_02_defconfig
@@ -47,7 +47,6 @@ CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MT2701_POWER_DOMAIN=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 CONFIG_SYSRESET=y
diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
index 13fd033b2f7..eb695f91feb 100644
--- a/configs/mt7623n_bpir2_defconfig
+++ b/configs/mt7623n_bpir2_defconfig
@@ -49,7 +49,6 @@ CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MT2701_POWER_DOMAIN=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 CONFIG_SYSRESET=y
diff --git a/configs/mt7629_rfb_defconfig b/configs/mt7629_rfb_defconfig
index 4b2412cc571..8629f88a358 100644
--- a/configs/mt7629_rfb_defconfig
+++ b/configs/mt7629_rfb_defconfig
@@ -81,7 +81,6 @@ CONFIG_PHY=y
 CONFIG_PHY_MTK_TPHY=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MT7622_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_RAM=y
diff --git a/configs/mt8188.config b/configs/mt8188.config
index b234da6734b..ba0f6086478 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -21,7 +21,6 @@ CONFIG_MMC_MTK=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MT8188_POWER_DOMAIN=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
diff --git a/configs/mt8366_genio_360_evk_defconfig b/configs/mt8366_genio_360_evk_defconfig
index 03de6573aa5..36ad9f93af3 100644
--- a/configs/mt8366_genio_360_evk_defconfig
+++ b/configs/mt8366_genio_360_evk_defconfig
@@ -26,7 +26,6 @@ CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MT8366_POWER_DOMAIN=y
 CONFIG_MMC_MTK=y
 CONFIG_FS_FAT=y
 CONFIG_MTD=y

-- 
2.43.0

