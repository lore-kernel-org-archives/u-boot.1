Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226B7CC6B10
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF2DC406EA;
	Tue, 13 Oct 2026 08:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ubs8w3RIhxmE; Tue, 13 Oct 2026 08:45:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13D2E406E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881100;
	b=JseyBfhsHedvHheWZLNhHANckLnhWYqYNMqL8vj1LBfIchxdQY2GgUdVP98O30onMWWl
	 jUXQwDRLlRYl8PM+eRBr3Nf4K0EU65aksX9LKe3nAZypuUAJCV4D++wqNE9JcS43DYp6W
	 7ZPN4u+jUj0+nK/F/ePqTMdhNJWxEhl1Tiu3PciZw3zP1hNRSkQxm8TCUGe5awWCMRIFu
	 Xzgtfp9QCTCMVebE3kUlbrUAzd6vEFrMYi9o66CSJyD0wU1QcQO6DhJMKmvbjRgUwMd4K
	 0R3UdC9Yccm9am+tH9wB4ZBA8GPJ2Ogz/PMeY7bujciy3fM2oGYKBwU7RZhqLAIp/oA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881100;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LgqGzwyWCV6zruLVr+rV9Y+8lgvI+Y2oQHjNBhRw8Uc=;
	b=bp7Qj0PGPQ5Sl+TJ/npQIbD46COzGM1mWQjJkzscUCnMFgrmOi5jWDrSzVPZD37FT/UX
	 Ftkequ6VCbifJN83ewwgPb1toFC94Ko95eFwNghhU52HBJ63OIeidN+VbTuwgLYeqjdlD
	 1WkQ4rdKEYy3ih+Clh+SdhHXEqyfUFp6dJPFPpavvqRIM1AKqtAwxhoLzwj/FTH2VH1Eo
	 52dsy4lc4WFyuPugbQ87S8KXE9g/ssnl0h64kmM8ZOC0ltHYjIux6e16TYt5+7XfDpSBo
	 nDSs+zbw4jviR4EPZ1rdLPVVTNWDRp0XNk/CWNvxSJX+pe3mTwyhzVXBUFmEHkz+8dA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881100;
	bh=LgqGzwyWCV6zruLVr+rV9Y+8lgvI+Y2oQHjNBhRw8Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C43oNjJSXGhaG0/kLPVg/zkfc1XOF3yAdJFCcFIayyYWUJk2Zw6Oi/iWApjxiBlnC
	 nEJJ42owZDqb1Qh/5fOlJ8yotnUaMKjOD6MD56tlm8R03yqOffppmPVSNWTs8xK9WF
	 4aRV4Dx7bh3AqO142tBckG590RSawNxk1DLNSM6CxLGqwd6g/PMpFGeMcHvSQVdaAm
	 Vnw9t1jjNjPzTgXo6RnZZEOtvF0c9s+9UIYlCT88es6Hvsd5kM3QSoEeahqLTUBt78
	 RqZBeeFQz+cfSRJvYnEWUi1KG6zPP+u2/vxyWUWGyZARanieore2npnfVzkskdNP7x
	 OednKzzvu2DEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13D2E406E6;
	Tue, 13 Oct 2026 08:45:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D1E6D788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B428F401EC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 05kS6uFSPqcW for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:44:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0F3984005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881098;
 b=sqUSUdhPUKRl65BnkMXAEzg03smYvTTZeVPr5do1TIVhMRnLdatyI7gx/muvOPzXrcXI
 EE38Lcg8WuARGBQVPqwGmlvhdOXY2HkhjWJmTudGCsSZjLzEeNl9pvdtjQDSnhQ1ZkUCR
 Mq0qAkfac+qmJh0gwHdBkLxeVXZQ64QzKkJu4LO6DgO7ugOQp1VJA5jQ3hCMaCXZpUBtO
 o/SkS8Zc2t+ZxUNMh+LvEafHI7BjvcTJjrcPDThPmRPN1Ub8iJW2tf7azUvqYmK0AVRv5
 uXqpaCaO/ejR4OhVJKkD4I4MTa9+HO/vCdO2MSJqoKt2AJGAs7SCuq7aUS84q/dYeNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881098;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=LgqGzwyWCV6zruLVr+rV9Y+8lgvI+Y2oQHjNBhRw8Uc=;
 b=c2McC+QqTcWHmAIRVjjRKT8C9xdQMe+1DcqyNyHvbgfCKvXvHwzk59oXtoAHj8KUIflJ
 CVKxVV5rfengoxQmmRBOrXUEdWDjw5UAe3WIxhvTWtjAoZohuqMqOUgnKt67n1QboWdQL
 OWczblLnhTQkXbAdtTgcBJ8kUVYOXtI9YKxWQ02oiI9lkpnZsUReSBdwrr10Daa/1swvI
 S+WfPCMXl2WFMMrQzlOFmc0OeqDKhYvNfpJi0qOmnrSGXRkskIORBk8GUZ3AelTOEDYZ3
 3LupsMiw1JNmVQOvfRlsJRVkxX7u6fA29j7D8vdC6yFplmWZV1TfqdEyjcoBUjo6M0Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kkTcTHJF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kkTcTHJF
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F3984005F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:44:57 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-88b5f43cb8aso795797b3a.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791881097; x=1792485897;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LgqGzwyWCV6zruLVr+rV9Y+8lgvI+Y2oQHjNBhRw8Uc=;
 b=kkTcTHJFD51cvAqrbNNs+HrZtnGq4nR2+RMh5a8EtMLR3pxOpNheFWTgyQowmI3IDu
 hNv/W6aa+u/W8UUFmjyOHZo4s8Ey2RxHw1bieHq/JoY7wAu8uXPj7BeEAAFcIQ9srTWc
 OlBrwEwwxgbGzdANG+159rvF9ajYlt+xm32RnHVK9YKxr8L+kpnRdUxIRMbBAWXldNt6
 IQXVbk5ik5SbB/HQrzg815d5tUU2UWv2goJFcpkFHW5G3zOeCrYlxG6juNQc1YUpRep8
 BrGZscbCcLKn8JqjDN2mntJQJ5r52uzAx+wHUWqcNcx6a7fFzLiwYzF3po3pWGW79ha/
 33qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881097; x=1792485897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LgqGzwyWCV6zruLVr+rV9Y+8lgvI+Y2oQHjNBhRw8Uc=;
 b=SvtKefnSz2Ge4Y3qudkMQxAnLeUMSHCMWPLbT7WGmsKkqRnC55F/fmfJTDeTkYeCkT
 O34EHzVGuuoP81vQgyuOWVPe4pjqx+R+S78ENj+rkHdKzjWrM89ru7OlY+TUfd2oZgqg
 wMHrptY3G0dYblEj/bRNOIX8cpLL7xlYvw4f5Fwy8Q7dgy31yOkOKMY2E/C/A1dV/OVd
 0/M2RWHKtyhc0ribtfDAPScLPW5wHPcXYkJ+4DnU/8w+UqUq1sBMVNPGfSK1/1Mqv3Ai
 DtDS3LuDff8AwrT7VIpHs4LfAUqY35lv5rejt/YTKZkiURfDCy0djlg1O9ABqCN7CUAV
 gbxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQIK1K5P91PVZG0mahD8ZV7rtnmzRg5+CsLiMfY18RpnFY2uX5kZaRqlhrZ1tl3e5dYvR+32g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKGYw01QzgRauPRebxtUvktML7TG4RRL7Acy9y5tWDv2/aw6+ct
 S21TGb/5xPjBBQVjW1is27KBs9td65Sgoh6+6/Wc39D8/83j+fCY0YYO
X-Gm-Gg: AYBFou1DoRffjArguXC53pfMLnWCojwRCAQq4LaLzzMPYbV16FM/Lkpwuy7/VNd+bKQ
 6B8kz5D7mzuJC7T/VGREiqnh6eZEBKm1Hedap9FrcPBhW47FRtB0KQ4W5maf6sbAeHctwiQWatb
 18TPXwToi92DRvB0DENUquc7HnFSxtxCGE9+tHHLlLrtztDb+Fc2vAFMeYUeVWSwgiCa7z9OJcP
 694DnazxvTAn6B0HYKXu9XB2j5Lo9umD2qnwF2HlCfA8a5w7o8Ie/pn2Mb+FfVjd5D/H4IkfYld
 n8fWJ4wkiZBBD+0taeWMuJjCoi3Jp9AS+m1IQmZU5uAlMGGxI72t3DHkcKwWZi2QyB7XmgKrn+5
 LzOUDijKYWyHXvxgQA2gv/tFpYR9KzkT3msdz1M7BQx0kPQgn7gWRL7aZnSfrJljGJJYdbrlMZS
 93q+CH7cO5XXG7SR9kcMPhEehZswK2LDawZJN9KeUmzgQ9wrpRCDHuqN/ATlEhgTih6u5UtOSuV
 JnDYksOmFA0ZsNLFrgjNcSrRDZoI1PLEBlCG+JoVItyOJe7Eb12PlKoE/cjifczzPXiDn3iUbMC
 O4+DicufKBAKhCvwrke/y0bTbh7ce4PppOq9oLJdeqwZm+tno7WM/g==
X-Received: by 2002:a05:6a20:eeca:10b0:3e1:833a:6343 with SMTP id
 adf61e73a8af0-3e1833a7b1bmr4717627637.3.1791881096738; 
 Tue, 13 Oct 2026 01:44:56 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da0596f9sm5383924a12.31.2026.10.13.01.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:44:56 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>, Eric Chung <eric.chung@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: E Shattow <e@freeshell.de>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [RFC PATCH 1/2] mmc: k1: use the io clock rate when max-frequency is
 absent
Date: Tue, 13 Oct 2026 16:44:47 +0800
Message-ID: <20261013084448.433298-2-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013084448.433298-1-alan.tseng.cs@gmail.com>
References: <20261013084448.433298-1-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The driver sets the io clock to cfg.f_max, which mmc_of_parse() only
fills in from the "max-frequency" property. The compatible has no
driver data, so without that property f_max is 0 and probe asks the
clock framework for a rate of 0. Every K1 board therefore needs a
max-frequency override in its -u-boot.dtsi, and the property cannot go
into the upstream device tree because the Linux driver does not need
it: sdhci-of-k1.c reports clk_get_rate() of the io clock as the
maximum.

Do the same here. Keep setting the rate when max-frequency is present,
and otherwise use the rate the io clock already runs at.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 drivers/mmc/spacemit_sdhci.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index f5578f38b..9b22ae48a 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -606,10 +606,26 @@ static int spacemit_sdhci_probe(struct udevice *dev)
 		goto err_reset;
 	}
 
-	ret = clk_set_rate(&clk, plat->cfg.f_max);
-	if (ret) {
-		log_err("Failed to set io clk: %d\n", ret);
-		goto err_reset;
+	/*
+	 * Without a "max-frequency" property, use the io clock at the rate
+	 * it already runs at, as the Linux driver does, rather than asking
+	 * for a rate of 0.
+	 */
+	if (plat->cfg.f_max) {
+		ret = clk_set_rate(&clk, plat->cfg.f_max);
+		if (ret) {
+			log_err("Failed to set io clk: %d\n", ret);
+			goto err_reset;
+		}
+	} else {
+		ulong rate = clk_get_rate(&clk);
+
+		if (!rate || IS_ERR_VALUE(rate)) {
+			log_err("Failed to get io clk rate: %ld\n", (long)rate);
+			ret = rate ? (int)rate : -EINVAL;
+			goto err_reset;
+		}
+		plat->cfg.f_max = rate;
 	}
 
 	/* Set quirks */
-- 
2.43.0

