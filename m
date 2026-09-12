Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700EFC88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 12:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3775F40766;
	Sat, 12 Sep 2026 12:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id McqgU9d0B4wk; Sat, 12 Sep 2026 12:37:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6148040752
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789216655;
	b=cktxbYE1MJCLMf2gbk7k1MswbHdi3udpUFwx/vf0qqRWSzOrn8ZE2phyqk6ZEOfcwgZD
	 k3TOb4VIJITVtzIK+seRQ0Q0t8LGeRHJ8qgg7R0T2+yzB0mMb+beUw4jvDeNMofMRA2Rs
	 U/xDRK6tgH6KC1UUPOckmeI7V9HWeys7CJF3sapOvA7okM2xwiumF79LIJmPxWTY88DRG
	 SXZVhj90pgTUNFA0YjvAMZYmFDyRkW0RUIJihQm3csfSTTe+L+DAxctY07tRQ4mWy0jeX
	 MUu0oijmlejFVdyc6GmzK1FDz50iT6QIg5drgLtb+Lzvj1EBHEXI4UvgrpM0WBnVtvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789216655;
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
	b=dRiXUntfG6Mx5O0/ETlSaMttzA3hGK7LOZWtku334eURShoNU69nEWasms5LiKb/alWD
	 M8bYHSUcpo6qMhgWPbJoCTWQD0aCiJdQtwEqeGZ+QrDXHh/foMO88zSAUyPtufCD9qnXH
	 /DJhq6MjZIMCKexrUv+nG0YRr96jRWLFymoczseQLGt5jeBRh+FGpmAGTK4hgmVKqpIPp
	 vW+zAI+N5mJbfqy6+a8DSzAQRWYhIIIKkIzoLe3UOUTtVVq6GDOjtSMvTJxsb3j/vJboc
	 ikEU2+ut9ZRuxXANkTtG41FBhi6GeAi0ARajXDbjbDHuk/R/Mqt94hXxsPyzcp/Alpw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789216655;
	bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zftxq50FwKSnhwTWDWRCMl4fB1kxvTlL0w24RdtLzI6oHMKmvMQCjXF7ezZOlRp3q
	 OVbgqvvP/c1W/n5JdUny3jobq2VjTUWv/Qs5d5PZgcjiE0K5BA12zvaVagLoPFQI2b
	 YUM33ZYhvmDWoE7KAJ8MfXynsX5zwWlAFSpmc0KnRDIbxDJoOqjCGOGcGdtdtm6+4G
	 WCfu9N09m+CHnY1EHIRF7Dud00QxW9VSsxpFMeAQ2hbnrK68dbigajb87AU862Yv7I
	 XaoY8sdwN7rqy+Pgn+0pdilrje/z0F4sPwi/v65v+OmPaawqFTfwuFiMrZ5LzPMUZu
	 wN6jXPxe66N9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6148040752;
	Sat, 12 Sep 2026 12:37:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CE2B769
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82B464009E
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKN5d5BM2NuJ for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A23484007D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789216652;
 b=Ffbe1q1tq7AS54dRxdqOVttdzbs8JzGeevYweIEkK8ACCJ4ZDwQPA4GZinJF3G/xiNV9
 PBTKPyRuKZ7+6C6ZcRjc1vRFL5A5aJbmG10LPzeCoUZHvZn32xO/EQlY53fEokqQ5Hrv+
 QFdzq+MYif29qwgTl1iZN/Rre2q+OMzNGqaBWoZzmPuY8PNRJ9411pddUCEI266Bd8g7Q
 uuSS+5H//PD0Hctf8Jq3ExHET5JqIGE3z4cPulP0GMF6mm9t5FW3cuYxbgm68QqvdM38T
 el5Sf+l03h+FZLl7APQSB6WvoOdyo6hTGNUhNX+6nRQEFtqBX9+YKdQOI2T2nlrDT9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789216652;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=H/AeZwjhrGgAyKQ04GxJzWeg9To3KuUfCc5h+Buq/jmK/ztEPnXPt0EibES0EEYqv18k
 JBCYaTpXEzgfIACl3VgHwrWNw0mfNBjbwnIR/6ra7Y4K4sJdlACkPTeyzVCGnw1FfQekW
 pByRkcJZMmBAEyn19mmm3aplaXgZukUxg78rAE+yX0rWyfOX9yLZDjFPVqYTklYkOfyvn
 RvACivYtSHia6QOLXjlIPs6Evsf4WlQ9zTWHUNU7HjIThF4qbNzfXk1WoWQGWYLKSVwmJ
 QCHdbIsJZsM3uD3XwdZYW/4XAjGx6U4drc3HlT3EDZojiTuB+Z71U4Yp9o+H+wTXCNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=rk7R3MVL; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=rk7R3MVL
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A23484007D
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:32 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d715f4a587so25144855ad.2
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789216652; x=1789821452;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=rk7R3MVLkPhUBQEQTi9EP0Vh6gre+zlyJx32lSr70V9x+fb2RBZO2JPB15xn3dxL1d
 8HzjRwSwzImRyxUZLo3qhiou/ef84uVwQUIu8Lkx3jx/gUY7owMX0a8v6GpwMWC03NXK
 WtusoXK+6myIMDpJq2U/as2lm62d6pBqzpwJAy+jrAmzxWbAKOnizbAq9S6avpOmnERE
 9NXbPUaOld2kZsJEcBWaQhDL+9WRAgH1C3sEHsjCB8+QQa85H/vN87Hm+gBH6h3CHtkn
 0RVmwuRPDguW6HmDIks9GeHAgU97naaJu2lBbEaAGOmdLJykGZ/QIpUG+2Guc4mrkQDl
 d5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789216652; x=1789821452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=p/8lNiYno/Z6MpyXFuoL88CvNsSrO14Fi/lzGOh4/F+JGWUzE1+T/cxJyTJ526OgGk
 WJHdrW/NTA6/gdA6bzG3ggZWjwOjVlBK/URAi940c1Xqh1Avcz1N4acPI3oVOoHuBv4U
 Z+UPSQY/BMiZCNFJWmO8hVRJYQjLO5sMoQhQIPug2hLh2pHCs/8ijI3NQ2dM57ZwN2jL
 6f1lF3croajDVucNI/aqSwDDya7sKyJIMmDdZ/akgPe5hf5wiOaDHH9fY9CRRv+FeHVl
 ZQXmH6xAgjj9s26trPMOcH2N84FyE7GCB0G5reelIVueEOLkZkySuvLxMecDHgROkiRh
 Q9Og==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFdv+YPz1vuUkNDisVyCPtzbwPKi9M7Kpo6fHxXGgsmI2KAWFYRZyT3VnptvnWodUy6r1qIfk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mybidoBKIFA4/xRlWgBlrUKlLZlnG8NG5MMi/otXXyG3VKbd/1
 7CjS2A1MvIA7X+UbMJvuAN1WBSHQM74UJK09aDBZ+0jzB9GZ/WV/BZyHTYTH7jHcA5c=
X-Gm-Gg: AYBFou04O1svWy1AAntWA4Vepi57TzpFRXS8BdkXQe5x1wth7iLrC/JD2XyVaNCj2O4
 ROWVjHvDR1fnjfXL3IoC46zOfvG5WBVtSeo2AO5fjNp9A0/ci2C2LomCP6wf5fFixRBSP52w1fO
 BCSnHq99Vzb5qWccNriy+Yp1I+P7rvUC8B1lRmjt2XgABmJx5imZBtpDJVFJmd9K1czMcPd+Ge7
 db63x++gJXtr8XHARKivLmxNL+oMVXokKkVwN6O++lQRQgFD0kXRPmunKtXA5QhZUvFg6P7Yq34
 SQSTxTzWZKtszROWd2DCzxd/m2Xkg3Fz2PUA7yjJyE1kCrF9OyeH5/y/sfipq1S8IWN7c9F5IVh
 +X0x9p3QAzSV/7xOw1GvuaZFTbzxcC/mVDM6HhgkHH/4N5WanCJ6UKMPkuIB/ZeoDq513C0hS8J
 VrdhahRL0/bHo1AxJD+jPfCidaVmsna8zNl6/+KB9GkYwWW2viwviomlvs/bidyqDG0GQVqqWJr
 jiVtPKgeTalsx8+tvzxXDZqnLHyHakkuPv77Ji37R5wAXJYp/PGUfL3s4n1QVibMIAici2xJsWH
 InGFyh+A4bHiHvGejnXy6Q5xmZZOfLYBf9h7
X-Received: by 2002:a17:90a:38c4:b0:399:ecd:d68d with SMTP id
 98e67ed59e1d1-39d9c342654mr10021868a91.22.1789216651762; 
 Sat, 12 Sep 2026 05:37:31 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba71cesm13288737c88.13.2026.09.12.05.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:37:31 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 12 Sep 2026 20:36:58 +0800
Subject: [PATCH v13 5/7] MAINTAINER: update Spacemit K1 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-m4-v13-5-71043b29630f@riscstar.com>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
In-Reply-To: <20260912-m4-v13-0-71043b29630f@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>, 
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>, 
 Johan Jonker <jbx6244@gmail.com>
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

