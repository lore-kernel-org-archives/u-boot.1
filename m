Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72694CC6B10
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28294406A8;
	Tue, 13 Oct 2026 08:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GUtQy1WPWzds; Tue, 13 Oct 2026 08:44:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 51ACD406AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881097;
	b=ZyiBypCl4UlJCi900GXGukNophAPywLKPQID+Ai7kiM9C+GbjAPz5zO0549d5mbUAPxT
	 MmDbIL2qPe1ubOvuWgLGMdrash399EjBIj30G5l37MWmn+UQeic1RsoqJXAJLDN+bwnVp
	 H99rSMarX0jV721dlA6tgM6uO1/K+bjUSq7vOVGmALjSKUpF3OQIiUFHstWSrgVAx7A7E
	 FY6ZWgY/gq/zQFPjuZ/LxWb6t8CWo0GOLv1ZkQFU1O3omTpCjMDkjWZBA1yrmMcljYWPj
	 el6W4GwsGf3yLpWK5ym2XRySVYxjWv2hoY5+fMBMBV5za3C3dwxAoNUJdi7mPgo7/+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YlWKSirwna/tHw2QoEJDSUBzFMA2lHI0ZSQkA/dqpw8=;
	b=FHS+SnbtpAeE/K+bVWTaVY3QIHMHTRYahTotRtkOhv3QGpr5RkxYbCPDuG0qfXgZ6GT2
	 +0gjA3C46p58LT9mpBKqq0H1cJkZWhN0V4yL0AZEeJj9dE/BkcF+mr5P4wnlSbleoVpUT
	 M6pluydvSP60yVOuU8QlOSWjON07LqAjp5K/BCzYUwbw1C2KwQBf6+COWhoB9JFc+2Bf4
	 jaZGU6IP0wNqtA0A6oMhnFf81OlcrHp1MAWBPu18vqMugpQXiAI50MVaBJ88xiBzFVuxD
	 84gAQIQsMveQChXu5DeNkQvoQclfUXIU+jcpt831JJ6KPwLWFFZhKCmpEEc9my2k9bA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C3TG48Ps;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881097;
	bh=YlWKSirwna/tHw2QoEJDSUBzFMA2lHI0ZSQkA/dqpw8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OLtCl8zw3K7qCQOOGzJv/4ZgY/MyN+cSZPfI0Ky3uyyDQiBnZ/9vWApM0voz7gwFF
	 1KzFzgOGw743bVNXL6b+J27kpAq+Z5MlQ+bulCM2xgUEq1rvCVkGvhMSRU6Xi2SosE
	 jT4A5x60+Q5YUZmKog1A8YQMZYSbJ28wFDuXgGHub9Ieuz2SmxEmKBXSdnk4+rIqmD
	 Et1JcYKoW22NZhR6zHOdulXcRtRpKfAbysss+yQj+kEvnjrIYhG5KIC+9VkR/Y9qj3
	 UuIcNrblMEjyotpomf1aao/E1oUNbvpk9JBzRtPQhRWzk/6ndLTMFy7hekNTlJfYBG
	 PBuo4cXph4fbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51ACD406AE;
	Tue, 13 Oct 2026 08:44:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35EB9DE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2595B406AE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2FmMgp4nQk-Y for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:44:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 46D3F406A8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881095;
 b=kpKk7Bo+VpI9llfsuHZuZALwBtORSNz9qOY5kNY4Md/0v6kBJzWuzxaF4xKgKrz3447V
 UhPJvdPbERBy40dZCOtLaX6PJTcCVciMPVwON4K8lDiyPB1Cre1w+tnRqQ06Fy9PNykm3
 JnT8jDHZ87rZW5wsToDN9rsEiupm3jEq7KG3FZRM5tAJkbqCu114BPQQbbyc5ukujfR78
 aNC4aUylVDVHqhOCogjMlGuuzsXlulPSyWyxjFtu98yijM5ou6ddc8ZpffJVIt8Tdjii/
 +ymZF/bC9RFcWKcXoHs7aglt2dhxoj8MJ05qGybXem9emh3F2Npjc5YSq5aJ0rhsXFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881095;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=YlWKSirwna/tHw2QoEJDSUBzFMA2lHI0ZSQkA/dqpw8=;
 b=hd21/4rs1oCQg+uJJfy9AqGvxq+iA/chPUvyuc//taHK0WUqKdTL2+xzyDAXP+zsA/L3
 FfMSqmgF5ZmP0MxfEHfjO+zIB5Xu6zCgM1rf9Lzjkrg1xfFVo8X2pY7k/VTReokrn14wz
 +q6klEYMq7ZqrYDVWdxiSOMMkjsl70dEg0UP5HFKxvrW/MHOHOG7wM+3l2ZWhmzK4dpmJ
 qu4FuqjZk5vI7owlju0+8dK2oAcscbEeH3IFmoROhogBXEv7frKDUG/TVRzPM7PceN8wh
 e/uy3VcYn/2ytk+2rldsPrh5l9KPw58ANaLied4gJjcZRQ6mdd6d2Q3VpVy+VvZSpVw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=C3TG48Ps; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=C3TG48Ps
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46D3F406A8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:44:54 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cd3310348d2so2103268a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791881094; x=1792485894;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YlWKSirwna/tHw2QoEJDSUBzFMA2lHI0ZSQkA/dqpw8=;
 b=C3TG48PsyrhPR/Ar1DIojTbxqymYuOJ7ENpQ3SHh/kkJY+iJ6ASEEW9srJGYUY5i0V
 eTVFqidzuvfXiEZ1+D1DVnIfVReXsvMTo9shoH7f4OcmqWyx43KntVO5rXQQ19H2pfoK
 cy8v01UhNNB3kJitZc9NhKE41R+cwaJ/O0HwFYWDzWdpYpKBjVkZlBLC+Pzcjpm3vKMb
 F1zM1QMbRMx4/Z0fYVET4jJLNHIVm0Na9j2gy1niXjxXDBHd9x2Q10pAgQ1QFbVgBRQM
 +6qkw9B1lNZbuPEo/YwosWuwR9vLv9txMW9Lia8E+Q3iQrDrqwvVONocSOLC5PiURe4g
 T5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881094; x=1792485894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YlWKSirwna/tHw2QoEJDSUBzFMA2lHI0ZSQkA/dqpw8=;
 b=1SOnZrqC2RHy6pFjgApaoRgU2aHlYUhAED0ZJewMpl2CxYrmLuXU3FdeffPKkUcHZD
 WT9uGaXcTP6xJsi97F8oJKGy/CJMvqFI/BFmoZITJFXv2WxQEvdaDwLQfcb3hcdPWEVv
 v/FsXZWKTrICBd9v8y1guRyvFF7tDWrbr1be29dTr81Ljva9xo6S22VfKbeAWQzV1uTf
 4QeSXdFdpLnimOIsvmhP964PQHRTpROLXxIXQlDPHb/l6fT/AkEmOe3WCoBIEm6x8t4D
 xO7lhqT2yt43FnWmFJs6Eh7oi76f4lAI2Fwg7QZkF4oN00qOBcPCPLht8SVfnVFNNJni
 HRzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMo1qq5M2xLWfS5FFTwlnZfjXDw1V0r3NUw/zcZMQxensVBmIQOwtNIxnLwo93QVQh85gZVcs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKAZE/99k44tjE2OotcwmmRCGz3kOn2wB/yzJk8CVjZmzqaQhuv
 cy0S3SfYWAr2IxSsIR+6v4+SFXQBdOb8C2DDWKm6OPu5Ecni0ivHfD+U
X-Gm-Gg: AYBFou32bBSS4v/04r4FIYbVxCmS8boKEodcNqw1SMax8n418X6eZiWEDayQXC3ILub
 MF5RxgmJVO84cLDpdjqbBxjFWWosPs4dqUSscIsBFIGnT2FxuvqMKkzFuD+phSR67z1SNwGdzu/
 ksITKphQYThF0AOAh1dLcO7cgY6pGxzz/Ht0v9MLd7/ZLOP/6BqvuyuXoWkdHCOd1NtLyggDa6t
 lLptRXpIMWDUyQH18h2RJI6X+QVylb+0+AV8+291qF04k5e7lqwpUxMUS7bR4Hu6T4NF00rrPmb
 tGDqrUPFb8MiCc0jYdgYQAAmA/pZqDE+aBR9ZLIKbFisrR4j+A2F/sqNDi3HqTuo8+BZC/xRnkd
 ZPzUgI1MThhQz0n/jbWsJL6v6EZtwWBd1dNWjlwoMVnnETVRTowpQABYi+7BWzZU1lQVjgj/HjY
 zJX5voPxHBmesJZVHLvw3LwYyhqFas8Uq0h2xCYVbfZhw0cgiy4yyqOyvH1sOkQBy5yUn18V+0D
 o2Zqkd9Y14JB1+JnTZ/+cfGSa8WVD+ZMXKGFy5x605KMfVFbdl2e/gffyjXjzAaHt+mw/u3ozQF
 SC3BAQUZOZBzct+nv2cWCNsAvZvwkdDP9Dp0KoA3YmXaPJBPOJ1Tkw==
X-Received: by 2002:a17:90b:524f:b0:3a7:96c1:f6f6 with SMTP id
 98e67ed59e1d1-3ab36dfdcfamr8156096a91.34.1791881094132; 
 Tue, 13 Oct 2026 01:44:54 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da0596f9sm5383924a12.31.2026.10.13.01.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:44:53 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>, Eric Chung <eric.chung@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: E Shattow <e@freeshell.de>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [RFC PATCH 0/2] mmc: k1: do not require max-frequency in the device
 tree
Date: Tue, 13 Oct 2026 16:44:46 +0800
Message-ID: <20261013084448.433298-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The K1 SDHCI driver sets the io clock to cfg.f_max, which is only
filled in from a "max-frequency" property, so each K1 board carries
max-frequency = <204800000> for the SD and eMMC nodes in its
-u-boot.dtsi. E Shattow pointed out that this property is unlikely to
be accepted in the upstream device tree and looks like a driver issue
[1]. The Linux driver indeed does not need it: it reports the current
io clock rate as the maximum.

Patch 1 makes the U-Boot driver do the same when max-frequency is
absent. Patch 2 drops the property from the BPI-F3 and MusePi Pro
overlays.

This is an RFC because I could only build-test it: spacemit_k1_defconfig
builds (SPL and u-boot.itb), and the resulting BPI-F3 and MusePi Pro
DTBs no longer carry max-frequency on the MMC nodes. I have not run it
on hardware. The open question is what rate the io clock runs at when
SPL and U-Boot probe the controllers: if the BootROM or SPL leaves it
well below 204.8 MHz, SD and eMMC will still work but run slower, and
the driver may need a default rate instead of the current one. A test
on a BPI-F3 or MusePi Pro, or a pointer to the expected clock setup,
would be very welcome.

[1] https://lore.kernel.org/u-boot/5d323a11-da4e-4071-bdeb-ab5c03e8f85e@freeshell.de/

Hung-Chun Tseng (2):
  mmc: k1: use the io clock rate when max-frequency is absent
  riscv: dts: k1: drop max-frequency from the SD and eMMC nodes

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  2 --
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  2 --
 drivers/mmc/spacemit_sdhci.c              | 24 +++++++++++++++++++----
 3 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.43.0

