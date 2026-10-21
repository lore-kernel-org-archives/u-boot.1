Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333DC606A326
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dXUAho67;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=HsDPLKbK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1053D811B1;
	Wed, 21 Oct 2026 16:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RqzPvC7qfRkR; Wed, 21 Oct 2026 16:05:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F5F0811A5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598721;
	b=X4LcCv6T+Q0Q21URUj6Yg0qnyu6Yr79kvTRlKSR2hlagU8hOtKs/QKQjqvgXHKknfxdJ
	 nDQsDIyi4X/bPegUsmlSIIg0ZKTDkB9PjTZdiVOZ4TxHu9KvuxQODfcbzTNI3ylxPkHpx
	 cpoLJALKe9x3SEeuYcpWe9FRv19aJL2gR/pCgji4nM3yKwm7eQE1nyJUCOVcwfFlmBzSX
	 QWLA8Vke5DXBlpdLx7/T+UGMfs8MBfwJbbA3dOb992UPf7f8n3rvjdI8u1CRUCKGPZ42R
	 /C9wTOp1PQbORCc8OhpIGPGcBUjG0ZCIi1jgJTmJGqZSpUnrYJ3ionEHr0VvzodRyrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AczzxuCQ+fJg5lqwTEHcDy0bK3wqZOGB1GK/YRXMKaY=;
	b=DxKtote8Jwq5zBu+qvMA0DTIi1vvTG4kBS7rvzWNeA+0BzzsIhAcC4AvJmKgfh9FZQ+w
	 U5uQZEupGHJ0PXl7DxA9GL+UFW59j/WImVu0cSw5zvEGZyqoTuE5tu7AWzji3nS2l6Fm/
	 4tkFE8EXSkKd/hRDHYcT2HR279yD4vJsec6JoPCrE84oD7z49sQfUvPt5/nq+4lg3oQ3D
	 j07jJl5e775sL8BfrqGUa448a0OXTtoYHFrmVkF1MNDSjr21LeSHvD+65eQPwYNEOxpgc
	 x3w+Q/FbK+QmV5wIpUUYjofRM7ZD8+RD9wniiXyOKuHKwwQugDS7rHGsF1CSjTMakRQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=HsDPLKbK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598721;
	bh=AczzxuCQ+fJg5lqwTEHcDy0bK3wqZOGB1GK/YRXMKaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dXUAho67u+dqejmmUDeYno3/EZCYq6y5UPXVpLFUMzChG66td2yJBjeaYdlCa9FN9
	 u3uRWllypdJa6DSWvVWPPT4Qcw1ZE0uymqFDQNIA/DNSJ33U1pCKYRFcDgZSG7Ekd1
	 KJMfJUoGQLEMd5RC2kQGRe5EG+MVrf44HmnorBR/ltoCE091sTuK0BVTIx0vspq/9g
	 qCb4AbfVW4SD3FwkbnbJxLcK4wbWCQeamsoQPUXK98U/yfLFoy0A7HjgIZ9QcptKHE
	 mmLp9lBrC0em9Qvb4tpa9rvPqyX9oxqoZ4/cQ8qO14fLaudWVaCFBoy6geq51eWQXN
	 DHwRvG1JY1DHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F5F0811A5;
	Wed, 21 Oct 2026 16:05:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D85041E17
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA00F80D9F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TPEG6APR5sDj for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9138181155
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598718;
 b=JuTEP8Chr1D8yfGHzJcJC+KMZIhi43yYUqVmy+dsosVJKvJqPIdVze8RRc/LaeYr901b
 WQh41fqAxSjB7wuEztB7pI3jCTxU5sWevEiNR1y7FzW8HT4mQxhj766ZOh3XAJYVp1w8d
 qbDJ9Z2RrD1JVji382n1gNB72NZERtn2Y0VTafUqyp3wmAiVzI5y4Fx4FfeoGDeJZ1Rze
 VT6xXxNwPGjEH5/6ww5RzKp6dmlxry9UvqFD6uIp1q8jfTiycQUqv50+jf/8rtcgi3tz1
 A1EqCWkjb5faxP6tODdvp7HQx0tDnYNvtnxxBQg61bOIKzCARLTWvEgEdB0yD9MvUnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598718;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=AczzxuCQ+fJg5lqwTEHcDy0bK3wqZOGB1GK/YRXMKaY=;
 b=eVwBtSbbY0fJqxHqsavcePEGHw72q8SsvhbQFyWR03mqj/H4rmgEeRY3BUrYSsBapp8Q
 8tT2olaAunPI1KuJ1MtQySeuewZP753mt7jNIEt4+RhuPraod6QURCGYZleo8BQv/puEv
 9KjQCaBEeFcq+6R0/d3PPZQlzs3ler1BcXD2BW1K11v3+KVZXDs5ywItmqnzNgzfTZLpt
 ScH5uciVln60OwwFfVxBUKxkR/t4TSvove0jrI6Vd33mhYcYlFgfDOblIWq0cfftySIdI
 8GthiF1M9Tfc9CHbPvqqWvWrwI+tK2ZmVIhYqxZwaccG4zzTkIlmHO14I2NO/qYWnVA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=HsDPLKbK; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=HsDPLKbK
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9138181155
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:16 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1d75f2f11so7057815e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792598715; x=1793203515;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AczzxuCQ+fJg5lqwTEHcDy0bK3wqZOGB1GK/YRXMKaY=;
 b=HsDPLKbKFKcJY1FWTNfAqKzCjJ0LfEbpaHJvn5mTxJk8ktN1DPiQR+daRrdFtVmPCh
 N6nNydhIeX8z76vn3ILATVgogpuoYbHrYS+X6fBBtLGJFXjOdQs8AnWIPkoK86nMje9N
 Fnp68odLi0dbgMYXLMeRdcDqd5AmRXci6aTUmmZF8d0/cRXrlfU0713OoV3C3g4JBSSO
 QwFZ1YWZByLoLeJWGjvusTzYpezZtY0J0l7BArzLJXj65r7OHkuKBaz5wzoX/rMvFJRp
 nJhmWG6cDEgQogVdtYsKifdHzDAHIivz5JzuwsnAMDmpw+D/MugCS5J05nRmQOjYV+fA
 3dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598715; x=1793203515;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AczzxuCQ+fJg5lqwTEHcDy0bK3wqZOGB1GK/YRXMKaY=;
 b=wfzI26vOqnfqAf6tD14+xUyYDPjhen+mh72Xt9FEQwSXmH4kqI2WGGjLXYRnD9V9W2
 dcQTtCp4W8N16nZTgItm0jPnQDcn1rmj5q3IaNarKQtrFfj6v5mwf2kzj440Ot7FYx/r
 kUC+AEKngAP11imUKhCKXDONZTfAMLf4BlJFTgR2CmHrsMJD8aY5eUL5ZkxLZL8qrLNE
 yTT1V6QnEeP4QC918A4gp28kG8FsRj8ZZnE7sO3kgtfTZ6bi5oBaZYW6CtD4q9cH4K0n
 ElFAfqH8HnIRXFdrolx5G3H2goLDIZmRk8pxGMMr78zlDLdlHIrCsr+7eQWJOnsKP3n5
 AiZA==
X-Gm-Message-State: AFq9FYIu7ERXsQUb97Vt3t3PH1mHECCymPnJxnDp6ZPJzc6I6M/NxfJ1
 r4tJP54Gg4S9zdKu7SVDgMRmF35+AQg7cx5CF/Sv/j6nzEb2WEG0s5haAVve0kNc3E4=
X-Gm-Gg: AYBFou1FHnUGatsg8PwxFihhAwONR7W1bBtyCOIewTBIZf2a4q9Tzqb6dNTznhe2cxm
 yeYDpQ25zfQabHkFIkZYlOHrb0fm5ySLKQi/nDVP7SgmOC57zR4Cupod2urLvZ3TdvqE6Lg9Jpt
 SVwZ1OmTwsyaueE4pHwC6gRnDwytOsCycB50t/H4XfSqUf72OrCtC5LKtmg9ND58908OAZoGGhj
 rAsUVohQBkLXzfMkvUu9sPb05TaqU8B70oKj6s5SHtfxHFbkAKpjrMQDP+uWnV1F9v8lDs5k2w0
 OxCHzQhdb2p5Tc9MzhaPNW98imc1W1lP89t9Kza1NgSy42epi7klSP6w/qn1FIyjhi14L5X4VWl
 ZXxtQGCIwpkpjK263dreCDxieH7J28mNKu++pk5LNueFSBKXYMCfbSkhenL7k0eStmpFFFpQdSX
 SwVzk9AyoC+XLxaAZWOxiVnwMgSFU3L+dKHVQvFWjDGc6TDjvxAPNWpYCQuZaF2gEPk/rMJEXzZ
 Hb0oQ32kBOEhMHYJmHfgt0OOU/XMyWEZ4DIcpj0eayHgo8BkBtZHywTijA1vtD0bJDLz04GRiVh
 T8UqsBxQ4UtkZvnE4CUk7IrOyb2OCxWnfqkFQa1nb6QBBUj4IwaqUNr3kQ==
X-Received: by 2002:a05:600c:c116:b0:4a1:7659:9b94 with SMTP id
 5b1f17b1804b1-4a1fdd15d29mr49350595e9.13.1792598714601; 
 Wed, 21 Oct 2026 09:05:14 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd629bbsm54075975e9.5.2026.10.21.09.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:12 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 21 Oct 2026 20:04:48 +0400
Subject: [PATCH v3 3/4] spl: ufs: allow loading U-Boot from the active boot
 logical unit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-ufs-spl-boot-wlu-v3-3-064e73cd2209@flipper.net>
References: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
In-Reply-To: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5062; i=alchark@flipper.net;
 h=from:subject:message-id; bh=d2QBtmkIk1IoDq2IaHHH3knzYfJH0xfznpBbQffqYww=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTdeLTSiXdKvlQMC28N09+dRn3Gb/TDpORfB9qKuN907
 J0YwOzbMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFS/fMPI8Lve7Hm5ewT3zZuZVWx7bd73ryy6n967+74Wv/75S5qXORgZlrx+yqR
 X+3qPTdBzhTVLlT++ee6ZqvaMa/r3PfeVc05t4wcA
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Naming a fixed SCSI device number cannot express "use the currently
active boot LU". Offer the boot LU that bBootLunEn selects as an
alternative source, so that switching the device between boot LU A and
boot LU B moves U-Boot along with it and the SPL needs no
reconfiguration.

Take the first UFS controller: no in-tree board that loads U-Boot from
UFS in the SPL has more than one, and the SPL has no way to select among
them anyway, as BOOT_DEVICE_UFS does not name a controller.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/Kconfig   | 37 +++++++++++++++++++++++++++++++++++--
 common/spl/spl_ufs.c | 42 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4930ecb08610..778ea1b1942b 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1648,9 +1648,41 @@ config SPL_UFS_SUPPORT
 	  use of UFS devices such as hard drives and flash drivers for
 	  loading U-Boot.
 
+choice
+	prompt "Source of the U-Boot image on UFS"
+	depends on SPL_UFS_SUPPORT
+	default SPL_UFS_RAW_U_BOOT_USE_DEVNUM
+	help
+	  Pick how the SPL decides which UFS logical unit holds U-Boot. Either
+	  name a SCSI device outright, or follow the boot logical unit that
+	  the device itself is set to boot from.
+
+config SPL_UFS_RAW_U_BOOT_USE_DEVNUM
+	bool "A fixed SCSI device number"
+	help
+	  Load U-Boot from the logical unit that shows up at a known SCSI
+	  device number once the SPL has scanned the bus.
+
+config SPL_UFS_RAW_U_BOOT_USE_BOOT_LUN
+	bool "The active UFS boot logical unit"
+	help
+	  Load U-Boot from whichever logical unit the bBootLunEn attribute
+	  of the first UFS device selects, i.e. the enabled unit whose
+	  bBootLunID matches it (boot LU A or boot LU B). Switching between
+	  A and B on the device then moves U-Boot along with it, and the SPL
+	  needs no reconfiguration.
+
+	  Booting has to be enabled on the device (bBootLunEn is not 0) and
+	  one enabled logical unit has to carry the selected bBootLunID,
+	  otherwise the SPL does not find a boot LU to load from.
+
+	  SPL_UFS_RAW_U_BOOT_SECTOR counts from the start of that boot LU.
+
+endchoice
+
 config SPL_UFS_RAW_U_BOOT_DEVNUM
 	int "SCSI device number of the UFS device to load U-Boot from"
-	depends on SPL_UFS_SUPPORT
+	depends on SPL_UFS_RAW_U_BOOT_USE_DEVNUM
 	default 0
 	help
 	  UFS devices are usually configured with multiple LUNs, which present
@@ -1666,7 +1698,8 @@ config SPL_UFS_RAW_U_BOOT_SECTOR
 	depends on SPL_UFS_SUPPORT
 	default 0x800 if ARCH_ROCKCHIP
 	help
-	  Address on the block device to load U-Boot from.
+	  Address on the block device to load U-Boot from, i.e. on the
+	  logical unit selected above, counting from its start.
 	  Units: UFS sectors (1 sector = 4096 bytes).
 
 config SPL_WATCHDOG
diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
index cef1843f40f3..1f7d2edae9d7 100644
--- a/common/spl/spl_ufs.c
+++ b/common/spl/spl_ufs.c
@@ -3,11 +3,13 @@
  * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
  */
 
+#include <dm.h>
 #include <spl.h>
 #include <spl_load.h>
 #include <scsi.h>
 #include <errno.h>
 #include <image.h>
+#include <ufs.h>
 #include <linux/compiler.h>
 #include <log.h>
 
@@ -20,20 +22,52 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
 	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
 }
 
+static int spl_ufs_get_boot_lu_blk(struct blk_desc **bdp)
+{
+	struct udevice *ufs, *scsi;
+	int lun, ret;
+
+	ret = uclass_first_device_err(UCLASS_UFS, &ufs);
+	if (ret)
+		return ret;
+
+	ret = device_find_first_child_by_uclass(ufs, UCLASS_SCSI, &scsi);
+	if (ret)
+		return ret;
+
+	lun = ufs_get_boot_lun(scsi);
+	if (lun < 0)
+		return lun;
+
+	/* A UFS controller only ever has a single target */
+	return scsi_get_blk_by_lun(scsi, 0, lun, bdp);
+}
+
 static int spl_ufs_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
 	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
-	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
 	struct spl_load_info load;
 	struct blk_desc *bd;
 	int err;
 
 	/* try to recognize storage devices immediately */
 	scsi_scan(false);
-	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
-	if (!bd)
-		return -ENODEV;
+	if (IS_ENABLED(CONFIG_SPL_UFS_RAW_U_BOOT_USE_BOOT_LUN)) {
+		err = spl_ufs_get_boot_lu_blk(&bd);
+		if (err) {
+			printf("%s: UFS active boot LU not found (error=%d)\n",
+			       __func__, err);
+			return err;
+		}
+	} else {
+		int devnum = IF_ENABLED_INT(CONFIG_SPL_UFS_RAW_U_BOOT_USE_DEVNUM,
+					    CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM);
+
+		bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
+		if (!bd)
+			return -ENODEV;
+	}
 
 	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
 	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);

-- 
2.55.0

