Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07172C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C100660B8D;
	Thu, 17 Sep 2026 17:19:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7TYDhYPFqLPI; Thu, 17 Sep 2026 17:19:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F0ABD60BB4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665586;
	b=cS64OVoU4ifJMKHibgJVGH0ZvN5tKeB46DJqGsjUdqVVQBbDXQsqah0qjwDvPydovS2R
	 vi1dWhUf3UiOIDih3rCOaYL9ZqKaFIETy8lDLA6pZobgZoyW6cPY7VgWy2KBjBW/qKiei
	 gvu6paX55+3U0zbXCt4Wq0BICkV7jUrWcr59JkmR0FB2f69SygosqBfGjLOlkB1nwpNRj
	 SNr9kAvHC76M6l5ZHBgM4U6i2FJrZl9PlNtE7Dy0r6WsCFpYb7wV1h1h5ggp7iVECu5d9
	 yxh/tZOfUISvngslUXlfdE4uXUwXRJgMDPsjVWhQ7ekDGFNWN+TEkjzBak+fqEGf/4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Envelope-From:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uTCR1ubWcf9KX17DJduf+kNq6GRT1la2rgG79rqgFAM=;
	b=sfQbcyFN8uk+lG6amoFNxA9fSRmbSq7CQTu/cB4F20TmF6xntXzoq2DUA6KQI094hQS/
	 9+i6fyovlaCt53HmqgW/P//LszwcVO5UrwY8CSK/x/BfwWRER0qvpVe6SoLfwxq9aL+H5
	 OrF8djY4VMQSZIZ+7RZuQzI+FYo0blKpzQlhZbiugWJTmL4sZvIYO8HJEzT0E83FphAnJ
	 ib1TH0Yr9awasvVCdPztwKSZ08K4M96SkgG/bMfeGog9cgxSptyeC+HmatLT/vHDj1pqM
	 zLUp+1g5KvIySJ6LFX4iOttPSwL4yLg+BAHu9Ab9GgA5riVlb3W5UyhxHEskX5qgnAg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665586;
	bh=uTCR1ubWcf9KX17DJduf+kNq6GRT1la2rgG79rqgFAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lYpiy2iHwB9Go2qp9+izTgnkyY0MxH232k2CAXE6Pv6d7sOkJ0zcHMJTVRWJ25LHj
	 PGu5KR6VgCipMwwbVFqUNqDgTSAVubWYUdURDKGq/mTB51WFcUtJ04PIkqYUmubYFO
	 PZS+5pHEsnRvU6FNWPzV8e2qiYMXky4ByRh+2mpGZBVJtas0S3Dwv87e26ZoXh3KKx
	 fspAHxQJn47b2xmVYyALDrZE6cmEckFEQOoYPRoW+Td6afUTWmFdPqzvD9HF8JhXBY
	 La+c64ySAgHxAc3NW3FPAenZFXgCm6R1CfidoaEIW3KDjFLHx2tzadfjDANqPjS+Xv
	 bSFCLvYAyhUGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0ABD60BB4;
	Thu, 17 Sep 2026 17:19:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A5EF037A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 977B840406
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:04:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QiSc_jSLUylG for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:04:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8ECFE403B1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=198.177.127.194
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789664673;
 b=pki560H0PLM8ictjr7N5rYxvUbjwSs02uN6UKgSHXFMupqkjnfYSEdtpDIFTvQNWvUYE
 dyjU7X0/KB5Q/qlZu8EGieFpZkJ2bY+VZj180jkSOvqRSwSPsXzow/vCIs4/YKG4nMqrZ
 r5Ws0n5vBSiMgRltUz67aG7X60j6UojTHnDWW/BlR5qLLvepnhuX7KXl3bEMG8Vme+s7a
 Ec6w21OUPGpagKckSvx7nruXJmuGiSRfji7m9pNJ/+6lwo1hiCf388lzmKTaOPuRg9c4q
 YIIR8X7hs6mPVHmkny+qi5nwxe8UHMGOGMyTlzMBtQJskxasulh0KyF0lEvTjThZD0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789664673;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Envelope-From;
 bh=uTCR1ubWcf9KX17DJduf+kNq6GRT1la2rgG79rqgFAM=;
 b=bs+9bUCyBnx19JrKjXOvifIBW7IRjqTq38BLvBsbOEHvAj6nQuegzGIccg6l8lFxrbZ9
 48iQ4Yrb83mWON/pDwiiTxxTiW++PiC7X4g6dyGzXo56kCllOvcCFxbEREJKcINoTanKL
 D3WcIINdpRXfuBG2zYPmIsPB5LsGQLKeopmtrgkoSOf6U4uu1ajwF1hrPw/83FFyXz7AS
 0qdFOZYZUefOLgsKu0dydl6ODv8HiTz/pGpsHi1rrddo57Bct6MNg+p45JJw289r2XMcj
 aA0uweNzC3rJbwwhIValyolqWq6yDT8/IHmvG50axTtHzAPW7aW346zl4tHgtEO+Odg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=machinesoul.in; 
 dkim=pass header.d=machinesoul.in header.i=@machinesoul.in header.a=rsa-sha256
 header.s=spacemail header.b=S+FWolxQ; 
 arc=none smtp.remote-ip=198.177.127.194
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.177.127.194;
 helo=out-utut-a194.jellyfish.systems;
 envelope-from=siddharth.menon@machinesoul.in; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=machinesoul.in
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=machinesoul.in header.i=@machinesoul.in
 header.a=rsa-sha256 header.s=spacemail header.b=S+FWolxQ
Received: from out-utut-a194.jellyfish.systems
 (out-utut-a194.jellyfish.systems [198.177.127.194])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8ECFE403B1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [223.181.11.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.spacemail.com (Postfix) with ESMTPSA id 4hm2D755rcz2x9D;
 Thu, 17 Sep 2026 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machinesoul.in;
 s=spacemail; t=1789664666;
 bh=uTCR1ubWcf9KX17DJduf+kNq6GRT1la2rgG79rqgFAM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S+FWolxQtxGODSEpXU93ePgeoFYqtxV6whXKMMP/SzYR7To5Warcp4j6i26G1HBbb
 2yCIQyOEKWh6pW8Fyd70LH45alkdz5LFacodesJLGEfatb8xHkkPuT/o/S20Lm0RLv
 2Gq1tgZTO/kBPyagrK2hdxsQg/i0pyUkEP99CScoGTiQWcM+eKvFak8tZk/EhvB4Mk
 J0YfDqCGTqXnjre9yGNEmYnOS0iOnV8/3oInWPHWqe+zVw2pSnSHfuDZIOV3aME+5L
 x8PPBx1Iil0HGZ1TNih4dClRrzWC6ap2IFQBPW8yVYAMtexkvoVuaSCEo7o4eAt+IU
 6tiVM8O+hLO8w==
From: Siddharth Menon <siddharth.menon@machinesoul.in>
To: siddharth.menon@machinesoul.in
Cc: festevam@gmail.com, peng.fan@nxp.com, sbabic@nabladev.com,
 trini@konsulko.com, u-boot@lists.u-boot-project.org, uboot-imx@nxp.com
Subject: Re: [PATCH v2 0/2] button: imx: port snvs_pwrkey driver to u-boot
Date: Thu, 17 Sep 2026 22:34:13 +0530
Message-ID: <20260917170413.199503-1-siddharth.menon@machinesoul.in>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917-snvs-pwrkey-v2-0-15b41002385f@machinesoul.in>
References: <20260917-snvs-pwrkey-v2-0-15b41002385f@machinesoul.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: siddharth.menon@machinesoul.in
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:43 +0000
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

Hi, I would like to make a correction regarding the feedback I mentioned in the cover letter.
It was from Fabio Estevam, not Tom Rini.

Sorry about the mix-up.

Best regards
Siddharth
