Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBC5C5DF85
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B962F80DF0;
	Wed, 19 Aug 2026 03:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qjgsn4-_RmL3; Wed, 19 Aug 2026 03:55:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111748;
	bh=kkI7TSX9h09x+T0r/8UTMI/PRVggzQx3pgrUrnHQXso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CODvg11z+lqjW7yA6Go+FTmh/Fxxh1HAfXhGE6Kas+cv7t7PHbyfKA0SoUZkjpG2m
	 iNXXQIEYJYJX/m9ny6jmvAYxKaNFy19PWBQX4Sds2RCJDPqYbaYhY07VR+mlrFoHoa
	 emeiVPNVZeFGvSHb8ixokqDhGcEFyAb4ACImTBb0cTrP+i4JJGJfK8m5vawAEhAebK
	 lY9AaYqWX0Y/00wxW1UTY59iYdhpEiSrQtPN+NZa2/bInp4hnGIkaknShPy3797UJk
	 6/bNMqh9ysB/i4c5QreknNfWjygahaUBxO7Q94CyDjaVC4ey6zF1Ai9LWshIsFQLwK
	 lcR37yunJMyeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19FB180DE5;
	Wed, 19 Aug 2026 03:55:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5001C1460
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3653E60650
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X4IwXbSHFwxD for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:55:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=F/KkZbMs
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86A2B60606
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:46 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so822486a91.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111745; x=1787716545;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kkI7TSX9h09x+T0r/8UTMI/PRVggzQx3pgrUrnHQXso=;
 b=F/KkZbMsjr1UNG0LCVggUr77t3O/qlI+fqjIhYFGNYPDCQrpobmiwNlf4SCf7nlkDj
 fBQu9ETbOYo0+AdEEsrMLPLnRj/ghI6FgsLmWiDA7tBQrH0BmGmxFDo6PbAmcqpxAHDp
 alHW8YZSXTsbWopOe2QDJeC9547I/m9iQNMFRAbE3vCfwx1jMdu8KpLhc9yj2kzRbJmQ
 22g5ecPkZwCjf5QcivrgPsSHp0m+iLdVZzCLV1ZppU6ga3mHH2Lq+aaY0y0cnMI3DKtO
 elrFLy4++ZsvPtgvULBK8yO23jJx5KwcoH0uYqOXjWPjZT+AvG5pCpFVitiMII5yAwCt
 9kFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111745; x=1787716545;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kkI7TSX9h09x+T0r/8UTMI/PRVggzQx3pgrUrnHQXso=;
 b=MQ0uRv7Ntn1GgDi9QcwtnIja3wvd5augdxkRSvVxWPB0iMTLp6jFW4orjjiKaccD7y
 ymgnmfh0vY+Gva9L644QZYxM+IUHD5qAsp6iWjayYmAnbyCioDmE7uvMrNJwgqov9t1x
 Kr3ZwZ/b/V69O5GnRPBSK7CizFPSrJh7WsezoinvxybdzH4s84AaOow82pD35vKCpyup
 WiSJUtHEdutTNqX7y692JSOzOgmWVkBf+va0vH/qggWTYvu1+MhZAPvtjwCjE5RgD5ub
 gzGsLXOksNa+gIxIDZzgF+5up/ZfyBYaGt3g64AMdaoLY0n9l73mQlkTWBQSxBI8wQb2
 uBKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxeLfb3dqTeqGZmXHFiBRXRzvfzKtaZZuONI1SJgImc6IvATWUMP3KlLBj/fGjP0+F5hyytmw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxEYnUIrsj3pqHRh/ajAQzOtfSOK/o6KyviaV5rlyhwzaWoPaIR
 Bpbpik/aTp6xynbbAxiUSEm6CKMRYX6F29tM4XCdnn0ri60Rpo/rEP+On8kaU6n2nH8=
X-Gm-Gg: AR+sD10Ar0qwS0/LVFYc6vDvAh9xBrjgPKJC5ufNDt/hz2ocBJdfd4spJzZOtp4AELh
 rQjJPPOd1GqqsScSDXFkcMe3yldQ5igrfOdCcOHK5nn/poyw5RRCPpyI8yH68uQqqm5JAadhNBR
 Zz/E6VhEwtBX5Cdtp3hJgPrJhlDGeB+IAmqTH/J1d5u+64ri0ujc+f6WLwx3Dtkv/Ul4sKIPJ3x
 krieLr5+lxo/G/Q9OXBcx1dWo1kWATxZMXeCiof22zHGs2ow94E+MyOAxNfnd0nK8PiDWxKhcbz
 1qPW0wl6QhJbe26zHYamqwQySd31BehnYDCIFwwsn15uiN63k9cB+zQG/drbHC2bH3CoV7F7W8D
 gX6g4J9DYRhUdTQrffASs3Avcxq8z5LnwHuP1OCUvWh4w0zEj4AfBhu8+RFxxrT7tGeIzxVS1hQ
 47itiyocmUAdWOnYxF2MVSwRwOl2MZl6fEDufYPm10WXUT7QcnN2DwGk3lNAYvJWC6pSsoXL90M
 Cg2PTh2yxO9i/Zz+5SDH7DugcwePj326WXBwFqlJW9RTtqZRCximwbta5HmKSVSt8J1qchiFRyK
 wb85NnzoPpCZaY7iDAfzwWQ2RQ==
X-Received: by 2002:a17:90b:3c4d:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-39580f04a50mr3333392a91.6.1787111745624; 
 Tue, 18 Aug 2026 20:55:45 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:55:45 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:44 +0800
Subject: [PATCH v9 02/19] pinctrl: k1: fix pull-up/pull-down configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-2-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@kenrel.org>
X-Mailer: b4 0.15.2
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

Fix pull-up/pull-down configuration to honor the argument parameter:
when argument is non-zero, enable the requested pull direction;
when argument is zero, clear all pull bits to disable.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Reviewed-by: Yixun Lan <dlan@kenrel.org>

---
v9:
- Rebase since drop patch "fix drive strength configuration".
v7:
- Simplify pull-up/pull-down configuration by using a single
  clrsetbits_le32() call.
v6:
- Fix pull-up/pull-down configuration.
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index a6a22eacac7b..9ca4ef7c771e 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -406,7 +406,6 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
 	void __iomem *addr;
-	u32 mask = 0;
 	unsigned int io_type;
 	u8 ds;
 	bool found;
@@ -421,12 +420,12 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		clrbits_le32(addr, PAD_PULLUP | PAD_PULLDOWN | PAD_PULL_EN);
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
-		clrsetbits_le32(addr, mask, PAD_PULLDOWN | PAD_PULL_EN);
+		clrsetbits_le32(addr, PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN,
+				argument ? PAD_PULLDOWN | PAD_PULL_EN : 0);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
-		clrsetbits_le32(addr, mask, PAD_PULLUP | PAD_PULL_EN);
+		clrsetbits_le32(addr, PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN,
+				argument ? PAD_PULLUP | PAD_PULL_EN : 0);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		io_type = IO_TYPE_1V8;

-- 
2.51.0

