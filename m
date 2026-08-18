Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10C9C5DF74
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F4D840809;
	Tue, 18 Aug 2026 13:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fYh7YfP7APjG; Tue, 18 Aug 2026 13:34:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0827840760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787060079;
	bh=ewfOTplKbobRgs5xxJU5xZtJWqULKxZMaaPVMh6iswA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ol8vi8y7zXZPcrNxc0w5ssrHOG5RCh9pK/Fb4ANcwkG/hsmxPQ2ttvXwvCslqBxI3
	 5Zfgg8F8pGb/ySsGms6c7B8XJPdA047u/5HV3WtX5tb7GUVVOn3ycucrWenoNlicTo
	 9rKY3+4BpCDUxVkKZp8evD1zwLVphcnWtPmx91rD4Ink+aCD2OCHKAyNo5Q0hK0l6k
	 EisrLZ90056ZaaZ2ftuBAJdQGqX9+5JU7bPiX8maeUzTbQYon1GGycubtkXlhBMuW9
	 mc512GxAri1NBG83BMljc9il4nRuluPZ+8UVnmiU568+M4w+lDBtirWFhFU/DkhNDi
	 hFpBAIZ0GORwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0827840760;
	Tue, 18 Aug 2026 13:34:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 131362EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDA5C80E73
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HCJdILYLPBhp for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:34:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2082D80E72
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2082D80E72
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Sl5yIj7/
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2082D80E72
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:34:35 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4518ad44e83so2878826fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787060074; x=1787664874;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ewfOTplKbobRgs5xxJU5xZtJWqULKxZMaaPVMh6iswA=;
 b=Sl5yIj7/tajXIoYEo3ETFx1/DvWCZaLMaSKDPqi4TdGtbhnlbrs5MlQnQ69r3YD/D4
 Be2sE7CE6Qik4p3apeXWw2PazC7slTzIcAuJIvfgb4z9h8hsdsqcGOZOE/En7hpuN2Qo
 /Buks8WmC8qXyvkUGxLR26ODj6YvPkrBV3liravIT5y/mV9nsI0PZ6tJKphGAgWyIuZY
 LoGMzf2y38Tw/y+jSL93fyjbIM/2Trj0gkoitlFL8I2PnY4BsRPwA5ansvroYrsZSqg7
 D8OH48hzaGNW83CB3diqwI9k3TkOuMCQph1DyLkplq/FncrS9U06r+VE+CdcqrTE7Ky4
 bY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787060074; x=1787664874;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ewfOTplKbobRgs5xxJU5xZtJWqULKxZMaaPVMh6iswA=;
 b=GpX/Vmi73oO/E5khe7AuvMnH6wjccbY5ulj9HkCRsCpuA9PVT0zL2d1O66kMVgFltN
 fvMEJdBylO0u0abNby+ZVvw1po3jEZKa5WyoT1IsckCeht+BuLSX6fhv7KU1C87d9SYC
 Cv5WwzD6L0rozapE6VXvSlvWJUMJrInleVpzouq92ndPbGcOSsgr44pB5w3KVqzyyrqh
 0Com2TU5aH92XQ3EsIGjAMVo+bw1GhyKUnjRAXFQ/6nlETrFeb1JF6tUDkD2PkwQQoCr
 BF7AlGC9jhsP4keF4OzJvhi6WbpaxEXdQknlnMMMCB1GbohZD8fcztIGSInttjVUTJ7I
 jSmA==
X-Gm-Message-State: AOJu0YyNTo01LjGtgZ28QQ9zWPDtPLysgd6qCgP1M6/I0hcBpwXDe4nn
 6gEB3KKxjZLiyGZiqEeg9iGlahv88sXXv2jNXaFQmUdPbjmmCX8fL+KGU1nlzAMK6HQ=
X-Gm-Gg: AR+sD10fD3oe1dM+qt7TBYyuPogcOtoZJ7PeQa4Ef6zMFaL3NUBtSNU+J8u6rCLGfXT
 MA8oaBfn6sqEzKPQzB9p3Y9ov/dQx2mUkywRIj502QdZJbFKiuX6HHD1bADryeWY9sGunA+MPxq
 MpuHHKtj+/xpmxHH3EChi6zlyNv60xsgBrV7u6P28AK474nS3j/p4X+VK/XzWk4rZVwGD4SEpLi
 eDokNkOeURTJ7pX6nKlxV6DF34unUnt0Qd6aDLngr0Vv+v3SusZxjGNMC+XnA27O7BQPqmh5SIj
 SBnBk+PfhYu/owt1wWlrO3SzYPNDnre/lmqk3IqPeFA5qkz+9ySWXIcLLFiJtImzsbEBGTP5Bwj
 zA70KeiRfGtAH70sq0NkMYjgAT8vvysZ6H3iV582FjbukWvyz6BOcotF8FEOvTFEmTRA/lMZOjU
 E9yDxDgN028oOZpyFJPTIQnP42V0h2G+w6hCNKgAlqQk4qoH57DeDUOlgIHkoZHAo7uw==
X-Received: by 2002:a05:6871:6a8:b0:448:9d5b:6393 with SMTP id
 586e51a60fabf-45e92133e2dmr29148421fac.14.1787060074479; 
 Tue, 18 Aug 2026 06:34:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1cf0:fc72:ac61:29db])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45f22aea39fsm3177704fac.6.2026.08.18.06.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:34:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Aug 2026 08:34:17 -0500
Subject: [PATCH] power: domain: mtk: remove setting DCM_TOP_EN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-mtk-power-domain-remove-dcm-v1-1-13de7925ceec@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBAG0KuQWTsJYNDqVYyL/nzV0bQlLSIJ4
 e5WXb7NW6kgCwqdm5UyZimSYkW3a8jedbyBxVVT3/aHVnWKw/TkMb2R2aWgJXJGSDPY2cBHf9J
 G7Y1XGKgOY4aX5bdfrn+Xl3nATt+Stu0Di+ozE38AAAA=
X-Change-ID: 20260818-mtk-power-domain-remove-dcm-7f9ab83bf8e5
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=AzHCWZ122e0GJoi/+PRCMblC68lz294TLmqf+Bk7dRQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqhF9haBvFPHfD0VtIRNLgXjMUfGXLI+LGJl6aU
 +lN/wQY/2uJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaoRfYRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7t0H/iXY0OVFNwcLcE4Rg9nomdGn2bugx1X9gl0mcZ6
 7xnebkhtVkj3UO7SFxEDba/j/znnlsHdb+j0YB6tu+yARQRaRWdVcEYy6TYA5wzzvqKEn0aGi2a
 VUnuFaUwN3OdrsM4S9Rpw7DZV8Dviy7dlRkV7/pZt4qwN0pX7j42wY4T0t7wKHvyC/9gMYK8JlH
 ICwXLOkBtaEGgBtXub6OBOwB6eR0b1KJApV8t+oQPZlXFAYf0SbGvSHdKK6bfEdNNQ+dfqlZcpU
 6jDZ85ROzeV+YVSw9ygyv+T+HQR0EiPHIJ49LXUFaqFIR4RVCRrJSzAUe4h0IdIKLYYUG8Ps4WK
 NJuU=
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

Remove setting DCM_TOP_EN (Dynamic Clock Management). This is not
present in the Linux driver and MT8xxx SoCs don't have this register.
Writing this register causes a hard fault on MT8366.

Fixes: a81e1f8a7cf2 ("power: domain: mediatek: add support for the power-controller model")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 9eef58d2d57..b0cb8bad6e6 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -368,11 +368,6 @@ static int mtk_scpsys_add_one_domain(struct udevice *dev, ofnode node, int paren
 			return PTR_ERR(regmap);
 
 		domain->infracfg = regmap_get_range(regmap, 0);
-
-		/* enable Infra DCM */
-		if (domain->infracfg)
-			setbits_le32(domain->infracfg + INFRA_TOPDCM_CTRL,
-				     DCM_TOP_EN);
 	}
 
 	num_clks = ofnode_read_string_count(node, "clock-names");

---
base-commit: 7581a12eb96c8b8825b65a9c597696cb28cb6155
change-id: 20260818-mtk-power-domain-remove-dcm-7f9ab83bf8e5

Best regards,
--  
David Lechner <dlechner@baylibre.com>

