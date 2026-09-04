Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A71C61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 14:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5442E40CB4;
	Fri,  4 Sep 2026 14:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1A0Mk75yb_Xy; Fri,  4 Sep 2026 14:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1455440C8A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788533264;
	b=r4OQggfXeGqVRgiCKbAgLwK5lV8eDq3UupwDxwE/79G+xg6AHAmgLk0MK1dzMI34Mo7W
	 BBrOeZRCdVLSX653nMr2uv+pT5BVGT92RAkgutLQJg4XXT683e+jNq6XDWiFXWu9aq37L
	 MWjxxWQiVMipWssNtCd2TSls8EnDK+ZZ0tuVuvTWIqgrt1xfb2XsI35QFS5+GS0E/tTp3
	 LjjOxQ2tny1ZVfhUOsewAhOky6LTbt78NHF8vH1QdwX/yNZAxWl+A5p6NM3jsTx1XSNcs
	 QtGZEUxgj66pMBW2QW7JMPsvyantX5Jo2kg7QtCaPhIqtWNBWZRl985MtkzS34AALmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788533264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hVTuRKpCwN2acHdiRrgcUYeNOH6lgxVBnt3U6OdPJWQ=;
	b=rivyHg0hKvU3IWClwwmY8i6+tV1bry5j6tslSvFakw+XG5XzC9UyvCTgUFdccH0oD2/e
	 sn/yzFnJnOY7nt8zGe4a+PbFgFZPi2t0k/0eib7HtONnl5Gu1igWWn/coCOSksWw5u5u4
	 F55Y7knbuS2HTYUQPt7cCBNBBd0SlnyQt9kWZkWNvYGWS3X6nAFpEqTrPNcqXDq9deAf8
	 pIyJwiYVDkr+rPweBWE3g6+oWM4EFN6v59ZOJ0CZtmsoqSJs942e/mFe3dmA2OAQ39+9m
	 x4fR5NAB242aEUkVHxcu9sGZgIeWlpshywiJ8bsyg+rgwXpjKt/98RG8vmR4L0HEuAQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hrSx6YoW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788533264;
	bh=hVTuRKpCwN2acHdiRrgcUYeNOH6lgxVBnt3U6OdPJWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aRdSlTIKh4bJ1WC+O/oZ2qp5Do8uEpRWZ24Q2hlIkTCcq1mURLhOn+/aDf6BqERPd
	 zWQb6OWMRbk/dZnI0JOIOY9qTtM1HQS1GO7WpSJwXn5XEi2rtqCASQUR0OFJdW+E+P
	 Mf3/Wapx2zeVr8vfHb2s1euSCiZaMReU811l/aHbnPlLz/IsFcsSNhYt6lQ+N8W6UV
	 jXdp8V5MQsO6u4jUwhZYKzb7G7KbiPEIyKx/jgdHGsq1ChyPHxJbCZLdgUy/QOpknc
	 UtVhjc5tOj8NljstuR1N5pHxj4ZRA4aTXZzsYrV14eu0Dgi9ZGmWX6L3kfpwSI1kWU
	 dboD1X2hsbd/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1455440C8A;
	Fri,  4 Sep 2026 14:47:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1330D363
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01B0F40BF9
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZH8ylHvYBy-F for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 14:47:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E805840BF0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788533253;
 b=f1X4BW5nS9zdvGJldlISTmysnv063hJUMNPRDwqYgNi7i/SkHX1uGNIt23LMtmkd5bzf
 D1/nVPI9A3wfOEwL6fe/IAIBpw9hqupgLml+0IgrQcceppuFCrmk0kfw75NmKAQ+IJk7K
 FYfKa4eAAcL5/Sg6kiIcr1d/Uq74ZjgNNYvOFblJthHW2TIAhZk6078NKbZp1mR0jQcoL
 BiAnMVLVBHgx4c5ePki3KXYdOlbXw2+hnmazoxFeYoSGcJG2zxe4+r1Yp2XzqluKfArkK
 FLDazgKo3CZQSKDpEGFM4T3iEkTrbIZ05Hiete8z6cUG0z+oWX6Qz3TDAnWOkzLJoCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788533253;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=hVTuRKpCwN2acHdiRrgcUYeNOH6lgxVBnt3U6OdPJWQ=;
 b=hM2Hvs7A4WcNXOuBduTHaHnyvc78UhZDQupsplhVWY85pNweIwKk0OmFfQXTkSwklNc8
 qAGV5j2ESyFA4Y7LI0YDpxQWms+NGf2FZcZueLrYm5w+xAbADqN6yIgTZ6ifnweo4e+HN
 sMAso7CrT8o+htwloDKL6eIccye16PVqhnSw76o9V/J7UplqT6+UQqmsoTCwgitWZG4DQ
 DZLA3DbWmF91cHbWRTMg3rWobRa6woLvHkcefmbwC73GCbQQph0LVtbBBiiIxqITvsK44
 CS1J1p4iEGIUcgfK7pSA4TmILQ4YaRC5XiGQ4qdjjsUY9b5Q+AmxvLc+uQEmg0Bi2Lg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hrSx6YoW; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hrSx6YoW
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E805840BF0
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:32 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-46ac24346b1so638654fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788533251; x=1789138051;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hVTuRKpCwN2acHdiRrgcUYeNOH6lgxVBnt3U6OdPJWQ=;
 b=hrSx6YoWMoYrSBDctMv8wcbN8BSaJqzQRmcMoWoppaNg8LMP+WfhiAoNRotrfpMLLq
 CXHnQmVWKBJ5k4zuGdL8DqYqYuWM3ToSfSFNtkJLbVIeRDzrGpY11M5Qhx2ycLCLk+JK
 oJrFehpuZHAkV2SJsPgooi9nwohfrVN+h+jm5SXqtqzNEzjqZ8EPmD2HaDu5bAMx7ziH
 gj2bOS/JU7qNQJ2GG5oi/RN+D4n86O2dzNL1VqY7TmNdVKKXhkxz2oEhcIaMq6eStpFD
 Ek6AsMCnCVXOaSkbvfs4MfCXRz6YjWTZhTPXhpWwnmONu0aw9IkHvbQ2DV/Wz0DXA14p
 N/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788533251; x=1789138051;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hVTuRKpCwN2acHdiRrgcUYeNOH6lgxVBnt3U6OdPJWQ=;
 b=OzSKs7r851jvrE7N+kmk/P8yAmmwksbiMayXi84S9hYGpgd2wJmxyV6zBnqdMx7Sn2
 3cghOWHdyNlA3T/3jhXW/ZhhbtOHSJu12gYMLtthMvqTfxIvi8h7nMj0Ks/eoKVHha5g
 wwD9IDoyTghoeAkFS7iAu9cipmvqPBoSfyi1yerPspGltq6Fnpri46Bemok7kK2yN3k1
 FTDAfdvzUbXdQHmU2MjoR41ktg2byTaEhfO/Dm377HaS02xRsU6V8cLyObhofkE1dZ8B
 la4CtxRKgepBRGpiwgEyUZTsi+sL8jQTk5i6m9x6ZTwUraWQaWLsNP1azGGnGNVgOfzY
 vJEg==
X-Gm-Message-State: AFuF++nV8Bx5DKGK7RhDB6ibKHpKRAM+vhUmGCKU+PMRUpPUyL0nrxZa
 JA+ERcBXPknD3GRXrfp1pToLV+qhnzDDwwKgbRYUHH/8DYOV1S875x8fxHb+o7KEkJk=
X-Gm-Gg: AYBFou2iLHs047CJTysFRfhfSCO9Gue7u7RzkaJZK8xbf5KED2yRSdUfvLHtm0IYSsx
 //rmKjMJxXz4fSWMy+HpTQsQwZvzC+KYyhpjFXj20JbIIp1ENDYfcAW855jlinZ9+wObrFQNoTh
 OrL9jxjXktyqpFBZj0Uf/GLZnwvPrh8SnXEY4rA2gufUHoNYAg9wCTxnqPdR2iaUabIByQyqnve
 M9MVyaE92T9EBTwXiKQjRpFVPqQdzPHBJdZGNJdUCd8xgP2EazQ7g49qvlQAbDkXZaAWG84lXOM
 AHdNk0qtUkY06C+BVJ15JnYmNlcBwU7yAvEuvTp01OpP9r3DdbTR9rzx1Ny4FTvF2MK4oRVt3q4
 P/Q5GF/Mm4gsUfUvcQqeCAvfH6cK5YjqXsfg1RAj4D3eUY08SF6FpO/eQS4mMkFc20dqw1jMi70
 zZUBHZ7T7Z2Ij4vcBeuwGDkaHafStCYLH3m+q3Am5Hbh1i7mLXrm5vuGNT45dqCL0tcF+icok3f
 asO
X-Received: by 2002:a05:6871:3504:b0:434:5c90:9d87 with SMTP id
 586e51a60fabf-47552d76a01mr4870400fac.12.1788533251184; 
 Fri, 04 Sep 2026 07:47:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47554935962sm2118988fac.12.2026.09.04.07.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:47:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 04 Sep 2026 09:46:33 -0500
Subject: [PATCH 6/6] configs: mt8189: enable the power domain driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mtk-power-domain-mt8189-v1-6-ab9d8cd0f01a@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=593; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=DuMEijAZ+QgDOQBqI+HL7G0U8uqN4JeI1l5y6GLdrpg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmtnyYDag9Pye5OQpVMXCPAa+xwVTsp1y6czxF
 vHvWcdwNmaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaprZ8hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ATfEH/jcOnlvWbQ0kTZQHuZTu4f1rn50SliigthFd8BN
 5ENvCCLZ6W5rysOhmA3Eujp3kxCPROeXAfU+BZ1mOY/7Qj0j3xshiKmcgcDFpkLxHz+rSdrFVVK
 1rZwYNp5qNPtU+PlPsNtoIDCWarOqJ93jBJOfROK13Pbvv3lQq41d5x5nxm1NEsR1tCKAItmr+3
 BrKRkpUvjLORKEfAD2lpJP3U+aD06fZ0dfy32cnmcJZv39hOFRXksKvFEbZTS6esLVCpxpuMBqp
 QJxdmj+3ZqhLckMwcePKOIBP7zPJN+G/x0nnzmjtCn4jZWrNiMSMc72naGMmss098azH0XHb7qs
 0878=
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

Enable POWER_DOMAIN on TARGET_MT8189. This will enable the MediaTek
power domain driver as well.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index bc662811ade..8fdb6eed288 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -36,6 +36,7 @@ CONFIG_PHY=y
 CONFIG_PHY_MTK_TPHY=y
 CONFIG_PHY_MTK_XSPHY=y
 CONFIG_PINCTRL=y
+CONFIG_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y

-- 
2.43.0

