Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8B5C624D6
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B8D0810FF;
	Sat,  5 Sep 2026 09:15:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQYJVCiLO4Wm; Sat,  5 Sep 2026 09:15:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B0C4F8110E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599717;
	b=ShSKx0FthgRsXbMpa9xx1tEtlXWwaVGgqNQwjn5PZOcUTnpCNrSfalBfiXPhhAsbf98g
	 JveqDdbcYcGsH+Wd+EyehKpPbjhrvVpHPmQ0pxdrP8biXFZJ1aVKtrDI9BjEqjsi5wQjh
	 2G6xGYS7fhruViQChUqd5mcylQhGtfDc/5CIlIomCeTaDiT1CPrZVFXWLwxj5QWlTYTXn
	 p2SSiH0CoyCDv2xo/ZxDT+eX5whNGT31uQpOYQCuBJMWfen5X5NYHPkGGyCyKSwFcsRqT
	 k9DHK1nLt3bDWk3UZKskVcEsVgo1ek7+4Y12jPV72wn8k7lwYc+eQhZjcLxpJ7mujhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
	b=R5n+mnLW/a3Ejfy82QWYYstci5HvsSOkap2MWo825HcjDKw2ZGxZMh5Q/Q+tIttDM3+k
	 oJJGkUXRV1kUJyjOzVW2jR1coT0uwuCMMlFByP3uPQ3XWqwdYsRa/Hl/gjhAd3/LnS6np
	 2HBW2qtCNaehk5/jxGpge4fS3ETKXxu44ubHfLn9e28FPH8t1reFoZJ3IzbZJVRIyEmvF
	 K/ABPS5CBIJXC6rbZOyfgmMnNkfsumruYCrH0r+WUQ0tOyM5TfGNczuXh3k0ABoDoQ25G
	 CKiTpUwMMwkOiuJxOYzKfgO27H0zevKfVVmpRS69e2FhmQjxwoFXfh3DRgMsBgEFj0Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=iKXc3c8R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599717;
	bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fmNMa+Kvs1JrNV9sVSE2DoLn9Pr2rf5Yq1V610n7wDB4T9rRwrY6m28P6bu0iDX01
	 BRoasQmb3dtSOMP3c9qcXPuxMoe8w5s6gWUeDttRIA+d5XKVKsLxKP52pN+iBgHaDD
	 rVuD8flNORm5Ci9iBrW/w5eZm7+A0LbRBvVnHZ32PYoKv+vTV+zqCM/n8G9xBcB1t9
	 YMVO4yfVZIh2GiVtJk49YR/WIRUjKnL9OgtANCIsWkjHkKDZ3IGlzToAC67e28lGZD
	 RtXLFn9dAeCzeUZ+lHCOz9NHV/1ovX0ZU90Skdh6sq/d/O/bI7tD/WaugvXPrwcsWo
	 He/yUajiPCeuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0C4F8110E;
	Sat,  5 Sep 2026 09:15:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 304C82FC
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 167498110E
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lk_wZmeK1pyL for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:15:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4BFBF810FF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599715;
 b=NTG+mmJ+skiO+s9e8KKrq3LEYZXUf3ufBPQwPQAHQd6ufUdLhHK7epi4wGO5fRkrfO1g
 6y9iU0Y0SExpq13pCuJUZ6814MUGU18/S2pAj2VhOTN5fsVMVCadnvhUBUzFoQS6nB3wA
 wAZ1TxcbQBhYsEZOtNIpkKaIe63mpz3TDMzJ/lGbK6VHeD7Z5ikpK2IfjmhUHOctQQWr5
 6h6oqd+/DjyIhJSBA29H/8+v6tfwdL8Sv0qi/3HCdOXci2iy2MEAYCXi3uozhf722zoi4
 8nqs0Ae9dvYCMY/Whx7RW+c3GhpeBVNP2rJMIBdCuClKZ9ho3lL9IoZrqFCLK/bZmrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599715;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=KtBOxKHgNb4CJQqBsPS9oJWJyqRL9vleSkvsrixnxPzU5v2Qf43Kx8GRQ4kW/W2AZ0mY
 rEsnFiythirpzBUmDxVe8kM5qFgewqDIb8muI1/48pUmaebiCU8zGfO653KHGilW+Vttf
 GkZmAzOCQofsMvXGc31tt1713ogGE22iaaMeLGaFmVZ9zU33R8Lyv3aMN81iNfqrDjvuy
 jl/+yOQE5ykC5N1xihEHucfpljKqHFvxfqAs0TsmQ7spkH3R39P2I/zh2J8DYv6gq1t5h
 LBaHgwBg34n483C7Xk9essGTbDIeRjHAIB/v44MIEhjpvUTiCH6BNwv5PQrTf0bzXOw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=iKXc3c8R; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=iKXc3c8R
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4BFBF810FF
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:13 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2d9520b9155so15509255ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599713; x=1789204513;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=iKXc3c8RSSqQQY/jDvh9VjuKlfZFo3IcgSRb3/bNsTg5gH5IvQv1Km7cjabxXluXAU
 ybf5/iSN8XgmnwRuFgp2K+QWuKj+EEN+9GnO0EG3g0pQYxZLBzRIF3NoA/b3s8Kx89QL
 jYOpIgHtiha+gQn3pCQW+z3WJwx3Z7+Q0qdAZSZTMZduGRWVLGttunK6wq37N/+i/goV
 JwIdqEkOGHVwKs7D8I0MIkXT+V1jz/2r/wQwUGRnpEiJisDl9KWrCBlZtIvt5PHE3iBz
 g0TUHALnTIMULQ2TBejWN+scQNOnLGseliEuWcnK1Lz8EuvtWTFDgtBeZ5eyKSJsTThz
 attg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599713; x=1789204513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=RzKw1ka/3siOWw/VOck0pL2g0dhiAUi6BxR9Cc0XZL9wa97CFIASus/cOTXNpK/Doh
 9/A8eFhbYEp72BFImaifYa8PuP0Y5Xjzl+HFl+ald5sWdt1O4aA3SNfkiuO647/IdFN4
 KYihQCWsLk9aocLEDSmzxIOYPO6KeglHHVnz3OnONd70F6TzcEIFb4MpDAwGBmqXxfCz
 XADAC6twc1T0HL6YCpCD+PzSgF0nVJj5ktuHo68yVEBFjl9btFSOklxXY7L6ZSzFS2Qo
 LFfv6tZ7YQVlxZiouoVd0W3MMVu4k+8JdmKcDlYvYBlhCkhWAlvXGQDyLac3Z9IanLca
 hRjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1J0OEyEbBquj1P0Jz3QYU/IA/orhDLxawTaMOpdGzQhLz0sw3rT9wwrkj6+SQDNqx81UrCOY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kPyviTKw+004ah7DjvcTAe9b0jb900nVJTgfM+pYFfXTsjUwF/
 0RIYv5tDQS9GqIZ9qZsBE0f01Jjz59a6XzlRhSvMXFlSN2XO0Xap5+0wST6edS7nW34=
X-Gm-Gg: AYBFou3kixUSk8l75FW8OpgqcmuALphXE+J/CApYGpJ+7C36lcIe+MSeqAgpHNaX2Bu
 GVOd1j5r72CCTn0grSt7SEEWTh5DZei/1Xws5NKydcgtXDI0JxicxG+R9qUMqTakegXPpPRBnaU
 Cpl6nIOYglfwtJf6u6ak/8LLdyqhUtJrbwQGQWBaacCveEefpT1t1FA3dlkiq29Xa8oxQvRPSRo
 HOy/W1JcPX6cNkV/owkYT/qaAH/6VPjcGlHsMrr+hgnqXRWAb1qOzm4XKDQZixH0wrBten02zjl
 P2VnBhwEkMwx8PUpLpMiCKWhCPa8VSehZq4F0E6vQNs2sXcd79o7kK2ZPvEYXFM2JI8toC376j3
 Vd3bXEId5VUBy2y75E+FX7LILzSeQ+ZQSEMHogo11dMS9V+6caZRubVfOVmMp12s2zOiTGnuDpt
 TlWUUlGE2/5tzxapOuBRVRJLpRQlW6LOClosOR3Prnq/IotIm6Kt4o9/s5HPZTG1O4R5EU/PYzc
 PPfM6kzeaNlLtdgRBKORMtFnFHEAEIJmT0wd/Mlj4RAJynO7nQUZNa+F44p4BXrIchq49rsughF
 KbgbTiSsFfYxEM7cDUOPP303Jw==
X-Received: by 2002:a17:903:3803:b0:2d7:7cb:a44a with SMTP id
 d9443c01a7336-2db127bf3damr180647565ad.11.1788599713407; 
 Sat, 05 Sep 2026 02:15:13 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:15:12 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:28 +0800
Subject: [PATCH v11 15/17] MAINTAINER: update Spacemit K1 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-15-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
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

Update the maintainer for Spacemit K1 from Guodong to Eric.

Add mmc driver to maintained files.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Add mmc driver to maintained files.
v4:
- Update the maintainer.
---
 board/spacemit/k1/MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 32d47ecc8f1e..4b2bc4ecfc10 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,6 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@gmail.com>
-M:	Guodong Xu <guodong.xu@riscstar.com>
+M:	Eric Chung <eric.chung@riscstar.com>
 L:	u-boot-spacemit@groups.io
 S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi
@@ -9,6 +9,7 @@ F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
+F:	drivers/mmc/spacemit_sdhci.c
 F:	drivers/pinctrl/spacemit/
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c

-- 
2.51.0

