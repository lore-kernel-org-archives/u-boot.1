Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A72606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wriLJ8/S;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=ss0OVf3k
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC32381160;
	Wed, 21 Oct 2026 16:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MN5BNoiZzU9X; Wed, 21 Oct 2026 16:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F96A80F88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598708;
	b=nPs6uF290fDBAbkbUh/5C5uNyxq6aY0WyIZnyS12ojl1XK7z8d9o6zDPGAh7w+h3SQR+
	 ZIeuO4k2ZtmgAHqVNH/yR1InL2QwxaMQYLJWXhol7sbgj0ybhK9JuUlI4lv4E154hJRQP
	 kyGZx0DJdOynezGH8IasjwV+l5a3xQCNG5Dn8DXt18VSsVVMZp8JgsHwe5hj3JMb/hrp4
	 5zgRJXCUmH4K9Cd5tbEXeACAU7ATwprwaORVBC3QYT/kRjF7lcYbqYtHflB5/XNlDeIDr
	 hk1Z+4qQME0lh5gs7k6A9cSzwvNYclZY4UaxDjR0elsUMRoqq7G1x+Up7ZZupDzq3Ng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598708;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WYHr77AZjrkcWYfItMluX4VggjVk4u9OFoj5Sc5a+mE=;
	b=PEYK8lfMhuJZe7uKwBHb6yR+0aCgmhay4oyauLrvIlf38Qp2NnyrQeYaqKtcK+zQbkc8
	 /QeFMgu+xK2WG+8a34/szCM2Xy5+OfD+UFGZvWnetjC1DX0CEzE3FHv5nqbS34JFEYoGt
	 jI4PLAvJ9Hycc8jEvz4BPDo0+NTyExwD8RP02UyPFVc6UBisZVj1dcCccLzCnjXtMTExc
	 N+u6rC3H10MJE3rCscCpO1RfIYIdB032J3W2VH35tqnBsJKlJGA8a10BOZbU59K+/7blw
	 Nzce9bBUviKUwRVl647GP2/ZEhLuaFohIhhBTwv8ZaaZPCh5WB9/lh7P5o9NnqfIfZQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598708;
	bh=WYHr77AZjrkcWYfItMluX4VggjVk4u9OFoj5Sc5a+mE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wriLJ8/S3UwFEECSSeCi83WPxfz6q4FjnSPBgn/7H29YLe95BPSyRl5WxjB2Re6f/
	 uv4N30jlYr96kyNb7atr9f3ksrmKy/tA4mM3Ymugg7vZbQ5qaRzN0B80xRQXFsC2iJ
	 zUoLTMO6FGqwbbpiQ6l5G1d6N1wF/qxy4AkjHxy0Uow91VDYZmsUCk20VxlTZtJo6i
	 QylgJ1V2twKgcAyw97m1SFFcljfyhp3Q9lbh5ks3Tg5ZrYh5KHwbqB1SD9BrN/yqt+
	 ZMJ2qvTEqoosNU6B5FPk0eJzAJvSv1/FhErbP/a7S7XA6AcWzEpSE13QJAyBqNt+1m
	 QXRliT+9tAV9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F96A80F88;
	Wed, 21 Oct 2026 16:05:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C3449356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A92AE60844
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rbA9R5cZOF5b for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:05:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 47266607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598705;
 b=IHAwlr73Q9uyz+8h4abdn58nbSB4hug7BbOquYihItNS78ycHVh1Bsu8ocD93bEF/uhj
 r5xzR3bShYpXNv9s5jZsjKpmvhlGc7q7i28s6j4czAoyyErZxGrJp/NL8zQEynl6OdJYk
 YL0el53gtZ6U0nBjAiSXMdpks84aQFAGaW+ParrwiJnWeSICuDiwtbXd13GPFALEBhL+z
 1XIQpB0e0N3QZIFAg5EBsG0nMSawgOZRwnPtAhwSHNLCIj6Kk3WcWDQM1rj8VyvE7HBur
 +7zUQsb9/VoRVCFsgpcvLSVVfK9LHM4ndg1KRJ2nirYAWOEMHdPVC3nkhDypN9DQh6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598705;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=WYHr77AZjrkcWYfItMluX4VggjVk4u9OFoj5Sc5a+mE=;
 b=drFbpeNjx+LDwt+dDGR7D46PSL4C0keSmj2BpcTiOkLSIRmuqAphGPVOPiWYm+A/GaEa
 lQX74HkJZ3wT/BREWRV9oV9+HSJySQE+y6dwmaxVh9da/X+Ki+5ZqNXr410G9i8r4K1mH
 WAv+8quLKZVD/uWR/BPd088jhjY3IZAYbAuqm8zLCQ8MOX+/SsYJrv2eDBddLVqWY7dTm
 dYqRcxO7iR//zNNgbyy93GBO36F2I1O+WV9eArWad5c073TAeaubki2rG7i9ZfmGapLwo
 MWN8JPqiao/DBvd7rO+hS/U3V+T9hkTtdxelw7xOl0PNaNKJ/kKte0Y0BhwtjIL6POQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ss0OVf3k; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ss0OVf3k
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47266607E4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:03 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1ddc7c9beso5217805e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792598701; x=1793203501;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WYHr77AZjrkcWYfItMluX4VggjVk4u9OFoj5Sc5a+mE=;
 b=ss0OVf3kz5Z1ZodUk1xECJaXEBCO1QqLpyZLkdKT47GdP0OqqBQ3XDcFddyxL6NKyM
 6JoCVfbE/xa5d0YCDD4CFy156rVZVOJKePiDK3msUqt2UZcqZA3F5yNfQdjGdHn/FITY
 DWohQE5GItgEJZRyUKr6Amu3qDonPFyetroPUpG9I7JW8SNrg4wesUSxczmn+9ofCtwE
 LckGPpJX4hLCwuY1LgeWBJ/pbvmKyhdwLJ3AXRct3VblqwN4yfuVgqRRuq8roSgoclr7
 rTXoTg4OVUuxyWGcSa8IBwlyti2NY/5nNcEkqI84a1GWo47BeVLF/I4+yteKIXLTsbxG
 V9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598701; x=1793203501;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WYHr77AZjrkcWYfItMluX4VggjVk4u9OFoj5Sc5a+mE=;
 b=TMeinZ2CmN4vW1b9CWN1ReTagilhpyFU8P7h9ysmF41Rl0BtGEMfkG9N5QxY9ZmMg5
 zgrAbmmY4Mls/WuRLIN71rwcGsnouHHIzSHK+Vp3j4eQXJW0h6RtvG7ZQYfOVfjHyc5T
 M1wytQCf3gAlSot7fOhpH+J8nG3du6Rs0dNfWhaCKAC4er9FyriEpD3WLN+9GSgOfpYl
 AXcp/FGEENrtEF4OQloDYTRMXQisvGl2C0mUUScgcn97ts0y72slQ3mK73uAi21UVC1m
 /nTm1ctVF2p7T5ATZRur6WqJSzAVMyPSDmJdTR3LRJtWo4yzQ4QAefYyllaCFNqRSZbT
 u+Bg==
X-Gm-Message-State: AFq9FYJ4yXxxmcyXP9uaAxNPRC3FHSPsmJxqXDRmtFdkNhw40tM8G9mW
 4fQzCNoOS8QTlg1CrQam9TcSbiJ6gU9rLT8MmOUXpjqwRDew0eNnVjAvVnfovHoTrNY=
X-Gm-Gg: AYBFou0bBW1KYmPddUOySFkAOEUop7rQI592kzmxFlr73q1eWzMDzqGxYywxVd+tus5
 ceP1bkSrg0Dnksmu6WbxbnwGmWz4BkIYcf62fbBGnR+nYrxReBrlDtcGgLp7+KNXLsanyE2ORIS
 y4QoVgHdt0ztdCowkj+wAWatk9YX2GZq/N8NDPEgX9Wo2LG9OcxLQVP1Q9rSYEA9jXL2jSUcsIc
 IEnJ2/uBBg5CHe41xOtmU/CTZyzNjsWhAUvLTKh5j3qL5kLInYSl16jsKJn8qWXC5RPzUl+XElj
 lxS8gYyCUnoraKoBp70WQca6be1bOJH0raU7sT6nGlN+fRthw5qUKPvtwP8r88NmBJ+hkLHjBoP
 DJpaJrAW0cuA/HtwUWyq5WhBRtomgkYLBwt/zUHH3ya337zfi0SxoOpna7mSPrn2iUDSQl3VliO
 NWeJLuiuH87wa4U7KXK69c1g9Gc8kjpPA5Vrtsryv45h3CzicrlZ4H2JPhdYFjq1lNs6aObol1W
 i513iL1Ol8DAi8DHrdx+NJe0y2H4qBMdeEUhh5kyrKNXyI6gZIEEDx/JKsvt5i/raxZO60QyiFr
 8j4kgZYGeRMvARU2HwoDdAEEl8SLFkVx4MHV
X-Received: by 2002:a05:600c:3b17:b0:4a0:2391:6540 with SMTP id
 5b1f17b1804b1-4a1fdd4a3a4mr58691405e9.25.1792598701396; 
 Wed, 21 Oct 2026 09:05:01 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd629bbsm54075975e9.5.2026.10.21.09.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:00 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v3 0/4] spl: ufs: Add support for loading U-Boot from the
 active boot LU
Date: Wed, 21 Oct 2026 20:04:45 +0400
Message-Id: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NSw7CIBgE4KsY1mJ4tNi68h7GBbQ/FtO0BChqm
 t5dqDEx6nKSmW9m5MEZ8OiwmZGDaLwZhxT4doOaTg4XwKZNGTHCBKkJx5P22Nseq3EM+NZPmJI
 GGNBCaVqiNLMOtLmv5On8yn5SV2hCdnKjMz6M7rF+Rpp7b7745SPFBJe1BJBUNEULR90ba8HtB
 ggoH0T2QdDqD8ESUUnBge+ZUuKLWJblCSc1UPUHAQAA
X-Change-ID: 20260903-ufs-spl-boot-wlu-10ce2e14bf15
To: u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Alexey Charkov <alchark@flipper.net>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Carlo Caione <ccaione@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4119; i=alchark@flipper.net;
 h=from:subject:message-id; bh=glZyUq/Wz0Y+YgJZOKQCdRm2I5iKuQnS04fvTeXCSnc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTdeLSSSWh/2b90FZUKrUavm8ZCTxesa1HcvlLaTXKJT
 XxOffjvjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKa6diMjw69HBfUWbmH7ptyec79shs+fIrNZDq3zI97r/X4gsOzLsWsM/wNYvLn
 erpi+aOWVz6cEN6//1cAQ5WP57nvOpMMc7vNqBDgB
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UFS devices have a built-in A/B boot mechanism. Two of the provisioned
logical units are marked as boot LU A and boot LU B through bBootLunID
in their unit configuration descriptors, and the device attribute
bBootLunEn selects which of them is active. The device then presents the
active one through the boot well known logical unit (0xb0).

This series lets the SPL load U-Boot from whichever boot LU is active,
so that switching bBootLunEn moves U-Boot along with it without the need
to hardcode the "real" LUN in the SPL configuration. Instead of reading
through the boot W-LU, which describes no geometry of its own and would
need special handling in the SCSI scan, the SPL resolves bBootLunEn
against the unit descriptors itself and reads the matching LU as an
ordinary block device.

Patch 1 adds a UFS helper that reports the active boot LU, patch 2 a
per-controller SCSI lookup by target and LUN, patch 3 the SPL option,
and patch 4 documents the UFS load method and how to provision the boot
LUs for it.

No in-tree defconfig enables the new option. The two boards that load
U-Boot from UFS (rock-4d-rk3576 and nanopi-m5-rk3576) ship with the
provisioning that Rockchip's maskrom loader writes by default, which
makes both boot LUs 4 MiB large: enough for the SPL, but not for U-Boot
proper. Using the boot LU on them takes reprovisioning the UFS with
larger boot LUs first, as the FlipperOS installer does (16 MiB each) on
all boards it supports, these two included, so their defconfigs keep the
fixed SCSI device number. Flipper One (RK3576) will select the new option
once that board is upstreamed.

CI for this series: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1657

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v3:
- Resolve the active boot LU on the host and load from it as an ordinary
  LU instead of through the boot W-LU, dropping the W-LU scan, the
  wlun_alias op, the INQUIRY retry, DEV_TYPE_WLUN and the W-LU ids
  (thanks Simon)
- Drop the sense data patch, superseded by commit 768aa39691e0 ("ufs:
  surface sense data from ufs_scsi_exec()")
- Bound the unit descriptor walk by bMaxNumberLU, skip disabled units,
  and return a negative errno when the device rejects a query (thanks
  Simon)
- Document the parameters and return values of the boot LU helper
  (thanks Simon)
- Scope the target/LUN lookup to one controller and add a test for it
  (thanks Simon)
- Use IF_ENABLED_INT() in the SPL loader, rewrap the Kconfig help and
  say that the sector counts from the start of the boot LU (thanks Simon)
- Print the error code when the SPL cannot find the boot LU
- Document the UFS load method and boot LU provisioning (thanks Simon)
- Link to v2: https://patch.msgid.link/20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net

Changes in v2:
- Add a check for null wluns pointer (thanks Neil)
- Slightly reword the commit message on patch 1 (thanks Neil)
- Link to v1: https://patch.msgid.link/20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net

---
Alexey Charkov (4):
      ufs: report the active boot logical unit
      scsi: add a lookup by target and LUN
      spl: ufs: allow loading U-Boot from the active boot logical unit
      doc: spl: describe loading U-Boot from UFS

 common/spl/Kconfig         | 37 ++++++++++++++++++++++++++++--
 common/spl/spl_ufs.c       | 42 ++++++++++++++++++++++++++++++----
 doc/usage/spl_boot.rst     | 42 ++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi-uclass.c | 21 +++++++++++++++++
 drivers/ufs/ufs-uclass.c   | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs.h          | 39 ++++++++++++++++++++++++++++++++
 include/scsi.h             | 17 ++++++++++++++
 include/ufs.h              | 17 ++++++++++++++
 test/dm/scsi.c             | 22 ++++++++++++++++++
 9 files changed, 287 insertions(+), 6 deletions(-)
---
base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
change-id: 20260903-ufs-spl-boot-wlu-10ce2e14bf15

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

