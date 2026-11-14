Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38026606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VD5C29Qg;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIjuZFcu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50E0A8198D;
	Sat, 14 Nov 2026 09:11:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D0XqrM5Aidt7; Sat, 14 Nov 2026 09:11:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6554481801
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794647495;
	b=IbhsRr/ji5M0BM6cYHCOgsxHwcH/RsMJ9gv+1mSkq4qVfglY+mKCxx6gHOHJe7cT93Fs
	 k6X+jm8rZP6BrfQe76A1b7ziU4gNFbet5239n2W43VWVkFniN5AXnyWcXSr8GHnkUG61X
	 Cakb1HAoVEpVjwN34RhxfEilFtCWKSZB8ExUdUXG5PUTt5lQdUFgMEjcDB5ZPOE3/DuLc
	 ZFCgWIeRTS4G/hoBSPJrcN6esHAK6TUaYA3mSujRTL8Z7pCPXDQ/Tp4DjoUHQdRVsrUNq
	 0YZyz/iFNTZZjAYxmHNat2O+4KCNxYhgF5ouQTOGGq2+lNNwBS3S6Gou9wnMBwZFyiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794647495;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=c9Ah3NrFGPRPN4D7tALqi9qQIgdqW+GrzGuZLoZ2rzI=;
	b=pmP10caJfFG/aw36I1ATYAgwXrUwVYG1rgh4jSfpURo5FC4iZ50MZMi7o7wOrVcMu90p
	 HViodcdrM1vcgRT/Awo7oqA2l6emtIZ9Xzm+JlAFxDd2yZJd0LEKGoSy6zwIduEI673Pt
	 rJteFRwvJlH7jsUSNCQHGTLQ9IS7ZuwjuB2I13hxDE0R0L7J79H1Pe9QsKBYoSvch/U/j
	 Lai0wEWTxPug8I3vZxht6ncjX4Rn4HPKhx+Fy3+Ej+krCBYZYZ4ANQNahH0wufO2yxvCY
	 vfGoHBovSv5TkzsvOwLJShmz0SuASz6o/Ua3innfdKfcuA5p7W2BX58PNXjummiHNZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794647495;
	bh=c9Ah3NrFGPRPN4D7tALqi9qQIgdqW+GrzGuZLoZ2rzI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VD5C29QgRnjdQvCKoi83QHnqPTjhziPGJFlk/CFOpTYyT7IkpdLL6lFZT+TENOJrq
	 KF91YCz0XHL6VJrHSAFZcfZrl76off9il903eTcLl7I6p0DQun47jSVCDHe3zKykiS
	 gzSFmkiood4piI6N5UMwzhif1wjYjPuiFrmP727kDP77AoA9ng+VSgls0PVLXxjpWz
	 9aLKIjcM35NjTbX16VU92ePJQ+g8CcyrwMRfW9dUdW2wi1KH7KpS8HTQHoHpU+JPjs
	 35mekPhvRbQU0PX+5efBDFfj2YRw2EWBQ2jwkPAWNh1hwSuFwduY44KxbUoUSuUguI
	 01DpHDOibawww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6554481801;
	Sat, 14 Nov 2026 09:11:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E2A2260
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D4A540DF6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3l4K_bv5iyYN for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 09:11:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 497694089C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=wIjuZFcu
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 497694089C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:31 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3ab43d1dbceso3467201fa.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 01:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794647490; x=1795252290;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c9Ah3NrFGPRPN4D7tALqi9qQIgdqW+GrzGuZLoZ2rzI=;
 b=wIjuZFcuRdbW6glL3lsoX8t4sIxKwN73/CsmLbwJiE1imnl2EoGv+tzPWWImVgPlCu
 Hy62xMKCaPM282piGAa3ePvUsHfjbSL/lnDDb+OhDOI05isSUD3JY79Agd+MjiEUIFZl
 EBSxt7fXubHt2Zh+wZK2EP6C7KxnEmlwIlQFAs1n7EhgCJ1GaV5+Z5uKIpFhJ5MsyLz/
 DJxcHahQvWIZ7BaLOsVe7mgGzKPIy1E2l1EAuqXR322F8lVwn8sXUFavjtBBHUhf/WkR
 2zGDIjA6izSM/29JoZNhZD60qeuwt2D5JbvMcOAt4+IP2LXOtD0Kdib6c661kUiwfz2I
 fv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794647490; x=1795252290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c9Ah3NrFGPRPN4D7tALqi9qQIgdqW+GrzGuZLoZ2rzI=;
 b=sBiV9nYbcyIvWXH+abhycBJOUcS5HgyO4vPq49zX6Zxl3AtVRqZ6lUSw7Zi3xqCFuA
 GbLBmSXjsjS7I36zR1G6wuYRZNLbIN6Uy/qUZh2I9yLEf4ETyTJ2M4DR21Pa4ghwS8Qe
 hrStrBicyTnje6HbzTPVGsI6MPpcqTpyRrD1Dddvss13pICrzYE3QVjKV3eJwy6Tqp99
 dxdDK7OIU1xytmJ+PuJrsVfJQWzDHk/63yEpB4suNIjmFhoflqNuDVSAPES2kyERhKFR
 8TVLujMoPhH7fDVYlvPf033Mkmk3sLidacEaZs7EXwbDkTGFqqW1xLcxpzqKuUabc2cX
 r3ag==
X-Gm-Message-State: APuU4Z9Pyrcn5ZhpG64gYbqukqkWWpT7Bv4Z1kffVHPtsX7Pe8f8Oxbh
 vjS2E5FWKsK4jseqvyeh8jH3jPjAVo9e9h+paMS6mZdYcQI3jzP1IlIy0DGWy/wSmmzW0w==
X-Gm-Gg: AYBFou3XfrjaVsni6ghxn2iFLMJbL9cw2sirbNGd7YZVaqY5roRcQeZM4Y6FhxibR5H
 oMkQ3VuV6VfTeQhueo2B+kQBv32nHT247P8mq9+9EXQaj1JFtVO/s5EaQEIrCC3hdkEKBqU9KJQ
 EvhbYT+X48Do2Lwz0+bIcRJ3TXWPCKIZuMLZpAlNOf+ozJeOAG20S62chn/RsUVKE9t635PJfr3
 ivnJdWvvvsLTAPsrxKlvjm+k90KdJ7HR18OrcOTb++OuDKArgegtAjCPzF2hREXtt2alufvv02r
 JA2KBUqxCxoqPT7uRBFtzqqtQUpE0NGKCk47ma70BKSPomQFAr3yKpR1S9u3Caq3O3rOastMq7Y
 /LGwXQUNX1+WM8UBXebvYuI9BMKkjFvQKIzo+UC/bM6Rn+tR04PSv1fyjSAKA4Lfmvv2QbAagjZ
 4qvYk2lZx15oCwSNk2lBjfPatP8E9xFXq7HDPmrg+MxpIEf5uXPZXRDLYFnx5jMdI/8ltV/FVpp
 hXEq/q3mPjBNKZ54mBThYh05wUlfG4USTPS5e7F9tmPoJPUddv+W+Oaf9vX3RWBSTcx18eS0JaG
 gCpTibbmMDhVZt2RqKFgno137QqUCoLtrnSsfy4=
X-Received: by 2002:a2e:300a:0:b0:3ae:11a4:22e8 with SMTP id
 38308e7fff4ca-3ae2b4c64b8mr13401581fa.1.1794647489782; 
 Sat, 14 Nov 2026 01:11:29 -0800 (PST)
Received: from OpenwrtBuild.lan ([178.207.14.215])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae2b7aebd1sm17097191fa.29.2026.11.14.01.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 01:11:29 -0800 (PST)
From: Mikhail Zhilkin <csharper2005@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com,
 trini@konsulko.com, dlechner@baylibre.com,
 Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v2 0/3] net: mtk_eth: an8855: fix packet loss and sync with
 Linux
Date: Sat, 14 Nov 2026 12:10:46 +0300
Message-ID: <20261114091049.2418574-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

his patch series aligns the U-Boot Airoha AN8855 switch initialization
code with the proposed Linux DSA driver [1], fixing several register
configuration bugs and improving overall signal integrity.

[1] https://lore.kernel.org/all/20261009161102.38961-11-ansuelsmth@gmail.com/

The current default U-Boot configuration leaves the SerDes with
marginal drive characteristics. On some hardware iterations, this
results in severe packet loss (50-60%) and timeouts during TFTP
recovery. This drop occurs because of marginal signal integrity on the
internal 2500Base-X link connecting the switch to the CPU.

By correcting a bitwise shift overlap, enabling link error recovery,
and applying the proper TX FIR / RX CDR analog tuning parameters used
in the proposed Linux driver, this series ensures a stable physical
link between the CPU and switch across different boards.

These changes have been run-tested on the CMCC RAX3000ME and Xiaomi
AX3000T, both featuring the AN8855 switch, confirming stable network
operation and reliable gigabit TFTP recovery.

Changes in v2:
- Clarified in the cover letter that the referenced Linux driver is
  currently proposed/pending, and added a link to the patch series on
  lore.
- Added `Fixes:` tag to all three patches in the series.
- (Patch 3) Moved analog tuning parameters to the beginning of the init
  sequence, removed a redundant bitwise operation, and added a comment
  clarifying the 2500BASE-X values based on v1 review feedback.

Mikhail Zhilkin (3):
  net: mtk_eth: an8855: fix bit collision in RX_CTRL_8 register
  net: mtk_eth: an8855: sync link error recovery config with Linux
  net: mtk_eth: an8855: sync SerDes tuning with Linux

 drivers/net/mtk_eth/an8855.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

-- 
2.53.0

