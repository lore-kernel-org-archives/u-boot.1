Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF3D606A327
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KuPQGDqC;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iwfrDVqp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94E0281184;
	Tue,  3 Nov 2026 13:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SA-E4h4Hx1pi; Tue,  3 Nov 2026 13:05:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7766C810F7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711114;
	b=dna4krzY3P7CYiZyEWZVgwI6Q/WYBQyxkiYr2Ca3i9IZHruPJoUmyDFJiNZjz9mq3ZjT
	 D/ZLyfVKWBwLmbNjgRC4KhYaF9LL41yw5an3kT4GSA1Gf5dbM+Nuu5mEhpRgDbrFlHLe0
	 puHCHDoVuroyKg4tcM+tM+Aq6xShgNIL2x7ETQL7CBKNkg3P6nYSObSeXPpPhMEQ1Izci
	 1Qa9Vqy2xzSI+w9zob8N/Wu/L8g/YnUq9682GcMPx9Wg3NI+/zNrYxmz5eChAt9CBI77j
	 jLzRIOyV84isPpFXaSfbahzYIyITpBnAIQVHFIr0y8hN7KeM8yCJvci2uSEpDiNTX3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GVZBdthL8jusbUrtVxoxrboJizTuilN6SKA9AIjiVf0=;
	b=Pd4FCu3TLB/qZLF1Y/DWidug9YtCagFSjcPGI+l/n5eZfQ2MIOx5n7yPf53rLnBGFGkX
	 Z/CJ+sbbD/yTuV+mb6OoY9kugQEkPhno5cnN/NGPy/Z/cUiLQW2lHRAFobhaj/ioyrxmj
	 PDtHk9WknFD+IrGAzuGuczJXcCww6HWuPeS39lOnr/eXJ3kUaj72q3rJSBtBHQ8QHT//e
	 y/wv/+7UhGr0oyPzu4sm6O2YNEuj1Hb4hVRxDq1Xr7Kqr+QVgIdju0p7/4JwYi3LZrOF8
	 Xh0k5dp5eDWMyuLSFllRMqq0XycbL2QHGZrsdLhywV0JzMOCykTWlilReIE4n+yHOvQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iwfrDVqp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711114;
	bh=GVZBdthL8jusbUrtVxoxrboJizTuilN6SKA9AIjiVf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KuPQGDqCJMTKcg/FkvCG3YJLsaZzdNYUcbokhr7p6sPpGtvj7T8wVx07lWVdPWNpR
	 B4DjSYnoN7gGztQ1P/lrMUwGr66WfjJR1uIRtj0b2Sj/PnHFFbuptpwLWYkFfMxUhB
	 tIM1y6MfWTMkZ4Lzjrjp75fBUdxVIQ77UrXyhZb7YQ3m8MjcWiBv3DVHWtOfvf/joS
	 /wrYhmIteDjjKl3i0mZK6Qmq5ORELQ8mCHHmUMG3NOWD80veO0gmJmEsmyBeJc1atR
	 gqjCVKn6bvS2wZn2hiMPmDo/nA+FJPjuJJ6kXnJy2Zv7YchLmtTOsUhqOQ9gwEAWjB
	 p4WoRDYOMEEtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7766C810F7;
	Tue,  3 Nov 2026 13:05:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 32EBA435
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 246B480AEC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fRQ6BnkoAKiw for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB72E8081F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699922;
 b=fVrnmDugzyU4RcTsu4sT1qeqjbqFYyWraRzLzLDl6Wq6eu26VEB8PFP714ikB7qnV611
 s59CAv/04XRmRLD++Xprcyj310EN8ftD0Djyvypgjxz5m4Agj46vYxQD9ShvPAFRnvZnB
 3xkR0Qr09vyY39pP0KKoXNSZ1hJEq9lJP9m/tvblJZ2S7F+7ZLXkzbsaQmjnu/fNgP5bI
 U5P+Ml7VWJW2nzTtAmmOykweAQDHvbzHYZiiZ+z73HQsOr6KoDBa+p7LbVpxqLVaUoQRW
 /BSABZyisQLq+rfF9WLCSAF1xe5oENge9kkCh8ccqcBwBeOcSKh/A5Kcm1AkRXDn9mA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699922;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=GVZBdthL8jusbUrtVxoxrboJizTuilN6SKA9AIjiVf0=;
 b=ZjCXj/yrrBl+Xsotb9+RHhrZKYcU9Rg0lnMgsSK2EF1BempScBT5A148F+U3dwin3yUj
 RUfr3cR9TPRmfZHz/ylBE5MMsTY6Pgxpt75KpKhYzwPda3gyL2n+FFug4dX8f6XC2B+IH
 SqbmmlnTmZXg92mYDguCG39rtczLPmCUZyOs6GmISFPliTEAbVu1LT7f0Xg0hHq/7NY2z
 Uz9/sI4k9ZWNTkj5RZRvRPhxe23Ye5REryKw3uFX8SYhhkqAC5OU4qhuYkC3dFO4SfjQl
 lE4KGuFo/bDtIQhLJfHIyNBE7it3FIMBFXHXLiCkgMo2Za27s3dWt+qfijZlGhbfQVQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=iwfrDVqp; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iwfrDVqp
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB72E8081F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:41 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so3116918f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699919; x=1794304719;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GVZBdthL8jusbUrtVxoxrboJizTuilN6SKA9AIjiVf0=;
 b=iwfrDVqpKPRLURyew4DxBR6L/IDXWyvopSliXW0kdqvqWpm/M3sbPwD4iPYyK1q6o5
 26V+4dehTyqFMdqGpKISZ9oeW6MEeLwDvsNjrwK18a072nzyh+5jUF6GRPPWQnrO+YVj
 /yUXBX6DKTOvkEBSNGJ+c1zrTb1darlVmeX/CLSM2sK0Lh6THBURyaCRTy5SvsFcg7Df
 ODiiPbRUdogmAPmkimVXfgV7PQm27eMg5mu8xd+BcnuB/77pVpHET3OwzsV2SDpnwtI7
 pCWUNK5N75P0gu1R+1OapCODKsgzUjBItLUXLSFTQRTyWGnTKR9z3NBHMRF/3TPRrCty
 frVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699919; x=1794304719;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GVZBdthL8jusbUrtVxoxrboJizTuilN6SKA9AIjiVf0=;
 b=YygaRcG7iI7GTuqx+VQuPlqUOxiJgeytLJQ9uukpCH30va/yBrcIat0uNRMLuFte9Z
 qYvcifgjtllbSOcVXYJtWNZu227NaxzdjAijJ5dO0lP5+A2XU7A+Yd+SRZiziXeVJCeG
 OQNi4TWYipTDRy4wZxeX0VXb5tR4LqPb/AubdPbsfLeTeSxFl+fM4FEAC77VP/jdAlha
 He2rAiPu4t7Beu23g5l5UKi0CknQc0qQNgmjY0sdPbKippTc9sXU8vHF7sJOsJ2L+MGk
 VKk8j6mud+yUYGm5UwcaRfbCpvc9m/FrqXynh2fhjAfTnOV3Bptwj6Dl3VtvRHY75nPL
 6sJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjZuzwx4qyvTXWqVjhWqKhH7F78OtitUDW8h17cQlF//Pv26Jb8rhUpQ3jWf4QJMe8l1GgzPY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+vwQ/NHo4wQxWBVl5J8tfhPOQdEQU90U+suULuhYxHeB4tezzg
 FvO3HjM+w2ow5ZOiv2nfRvVDvhjrD+YKAEAX7Erm7ga0HAsXTBMfxdny1uoBiLWtzQg=
X-Gm-Gg: AYBFou2aktVFJ3j8goyz+cqOHmak59mzzvjOalq+WUA4dFMj4zJLoOa5kfA0cC3VhGx
 nWe0gNg5hd0IaTEPthR5K7/kABLXJ4uyLClkl859+NukL7hQI1Wc5YmDPyPyL6a+4p93P9hlbfl
 oPrfrxneivyUJMuVuMGV0+eApENkrKzmWSP5RKdAzWgdbifTNFRSVNCxxLqVtCuhPheZBkOc7gQ
 dV92pZgpNlhL7l8T/0mWnO69B46DrPw/K4cs1cGbuCtlYQOaU9xbACY2vJxg5/PLys/uy19992V
 GuND4aIOnU8ndOe39n9qSHTsHNC+xC6fkIka5ql9JJcqa8ZAkLTYK3Y2aGetlRx56UXYVBYm5ol
 fAygeyZjarDlE6yHHsrjrqTt5tEcBCVCnEL1euDlsnMtQSs9sNArNdR4Hwl2HopTq5yKxfmaUjt
 aosaNZtcCnleaWitcM9x0MkesUv67i8FmsvrzNYR5vi7US7ZyQCkJxuSwjKmXy6rWA3kYV27YvV
 RFhf5xG+WABvqo6kA0tUjcDN8ryd/rCFWEfJALpsSUynWYBxLFSLVoMvTeCaDVtTajSvP+cOcTV
 5Y7SMtts6cz9LWWi5ufTBpHJ7A==
X-Received: by 2002:a05:6000:25c5:b0:48e:3d2:44ac with SMTP id
 ffacd0b85a97d-48e6e4f5610mr27637327f8f.15.1793699919344; 
 Tue, 03 Nov 2026 01:58:39 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723bfsm22711539f8f.15.2026.11.03.01.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:38 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:54 +0100
Subject: [PATCH v10 08/24] arm64: dts: ti: k3-am62p: Split r5f memory
 region
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-8-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5712; i=msp@baylibre.com;
 h=from:subject:message-id; bh=WxLjf6Qvn82L7KP2GQTk5o56nkPu707U5CkGmMf4h7U=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX659yXub2frKqUyFLZto9sxMflaLTJuUUCE00tq8LE
 LxmHTSvo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZyfj7Db/Yfnl5+RenMVapH
 rE/YHJl31WnPiR8R5W/a5eyytwl2r2f476twoeaU4gT3Kb4vqt/+uhLk+5hZ6tzRLWubHX3XHts
 TwwMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
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

Split the firmware memory region in more specific parts so it is better
described where to find which information. Specifically the LPM metadata
region is important as bootloader software like U-Boot has to know where
that data is to be able to read that data.

Reviewed-by: Bryan Brattlof <bb@ti.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Reviewed-by: Stefano Radaelli <stefano.r@variscite.com>
Link: https://patch.msgid.link/20260918-topic-am62a-ioddr-dt-v6-19-v9-8-40972ef1f663@baylibre.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 46b7261c2bad842e8b9a25106c132bb8ae83d634 ]

(cherry picked from commit 2570b94c6492ba7000ba0135ffed167af952c1a8)
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 .../src/arm64/ti/k3-am62p-ti-ipc-firmware.dtsi     | 10 ++++++--
 dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi     | 28 ++++++++++++++++++++--
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts         | 28 ++++++++++++++++++++--
 dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi   | 28 ++++++++++++++++++++--
 4 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62p-ti-ipc-firmware.dtsi b/dts/upstream/src/arm64/ti/k3-am62p-ti-ipc-firmware.dtsi
index 5d7f701420e2..84dfbfd1986c 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p-ti-ipc-firmware.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62p-ti-ipc-firmware.dtsi
@@ -44,8 +44,14 @@
 &wkup_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
 	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
-			<&wkup_r5fss0_core0_memory_region>;
-	memory-region-names = "dma", "firmware";
+			<&wkup_r5fss0_core0_ipc_region>,
+			<&wkup_r5fss0_core0_lpm_fs_stub_region>,
+			<&wkup_r5fss0_core0_lpm_metadata_region>,
+			<&wkup_r5fss0_core0_lpm_rest_region>,
+			<&wkup_r5fss0_core0_dm_region>;
+	memory-region-names = "dma", "ipc", "lpm-stub",
+			      "lpm-metadata", "lpm-context",
+			      "dm-firmware";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi b/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
index 8a5ff5c45757..45ab9d947b3a 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
@@ -168,9 +168,33 @@
 			no-map;
 		};
 
-		wkup_r5fss0_core0_memory_region: memory@9c900000 {
+		wkup_r5fss0_core0_ipc_region: memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0x01d08000>;
+			reg = <0x00 0x9c900000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_fs_stub_region: memory@9ca00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca00000 0x00 0x8000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_metadata_region: memory@9ca08000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca08000 0x00 0x1000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_rest_region: memory@9ca09000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca09000 0x00 0x97000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dm_region: memory@9caa0000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9caa0000 0x00 0x1b68000>;
 			no-map;
 		};
 	};
diff --git a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
index b8af9ec81b0c..bb027c65eddd 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
@@ -55,9 +55,33 @@
 			no-map;
 		};
 
-		wkup_r5fss0_core0_memory_region: memory@9c900000 {
+		wkup_r5fss0_core0_ipc_region: memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0x1d08000>;
+			reg = <0x00 0x9c900000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_fs_stub_region: memory@9ca00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca00000 0x00 0x8000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_metadata_region: memory@9ca08000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca08000 0x00 0x1000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_rest_region: memory@9ca09000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca09000 0x00 0x97000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dm_region: memory@9caa0000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9caa0000 0x00 0x1b68000>;
 			no-map;
 		};
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi b/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi
index 3d1a2c5bc464..31f670fdd91d 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi
@@ -69,9 +69,33 @@
 			no-map;
 		};
 
-		wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
+		wkup_r5fss0_core0_ipc_region: r5f-memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0x01d08000>;
+			reg = <0x00 0x9c900000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_fs_stub_region: r5f-memory@9ca00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca00000 0x00 0x8000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_metadata_region: r5f-memory@9ca08000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca08000 0x00 0x1000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_rest_region: r5f-memory@9ca09000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca09000 0x00 0x97000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dm_region: r5f-memory@9caa0000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9caa0000 0x00 0x1b68000>;
 			no-map;
 		};
 

-- 
2.55.0

