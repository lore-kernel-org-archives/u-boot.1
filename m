Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2C606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dagg5t+5;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vA9BE5Aj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4894340CCF;
	Fri, 27 Nov 2026 19:48:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BMxyVMTVPRka; Fri, 27 Nov 2026 19:48:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 945BF40D06
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795808910;
	b=BCNu1cZ363m6/uhBfozpVEfUcblCdxwUcewZjLuY6CyLDnskrnyeGIeKsguTcvBaspp+
	 nfkkEYQGsUubBr9AszjiFNmqB4dAY53AqM5F39ddMTbdGBArrqDP15x2HTiDpObGPnkAs
	 EeNJwDPV+9RngVm0MLNPc038nDg8suOgmLkYzwl8E1c9HRb0DxXABcyTUAzDUXZb7Ie7G
	 VEuxTlmwx5BsNhThU9wAsvw8BFfyrjOZeu74/BN0mnoVAB/MmjumgszQ7G23Kvp2As+5Z
	 MHeZ5hNLJ9GsfMWyGDvmmzvdaGjDaFSW7V5WiaTaSlHo+/yaKpAAcyO+HK/5kvxGXHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795808910;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=C3IB9j4zknRVVZla2gG5l7QxBxrJVbLvWSJIK+usCLc=;
	b=eRdl0WXVZRa70wFDVp3tp6hLsVKEuafLPMJdim4m9IIJIAiKyzimVYrDB3onp0P1+LEi
	 VSiy97S+V9J1AZpHLrRbRRpdJL46RwPnxgezoo/4oN5besabqWqkUAlE39Z7FPdEQH+55
	 yaSbUjSBbLEe5PoZIRKB8Z2maVwo5qMUyUZFBwyUcIjOSwqUvyBHdDb9llCWPM4nbyNGL
	 3CZN6lA5UOCVtT/qJBEeKGdMJCZ+w28p8Ep2UOXWHgUdKpuLsz0ghzqkzyU5xpULjSvVY
	 +8113XviwjPNw+2uFlZZqzbEBWPEpRd//FdavogqP0PP2fzIbjMcY8CUuVm20M5Motg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vA9BE5Aj;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795808910;
	bh=C3IB9j4zknRVVZla2gG5l7QxBxrJVbLvWSJIK+usCLc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dagg5t+51bjs76HJjUdOfONefr5jvmNIr1ipNT7C9cXP7dFEaJ69IJ2YcDu5lS9qp
	 SnlR+DGlE1txlHBExBO0NF4rgKsv0F4aUt8yqau6Sai8mTBAA/3XzpTfTwABRKxLuA
	 3q215jPmojeHLjNloXwVuag5NMdA8SC0HkgqQMRv64suMrcsSAbMN3r0nFd+z1kxKg
	 l7fEd5n0VA+BjFrChXbhrcrj1nHP9TXA6iQ5Z9RAZqPLkTypwRM8jmlXdvUyUpdb8T
	 V10362hBWLaynPIDGwANqSk556Vf3fcnjkiJEmB9EMHwtUs3Tb5SxcvSeo366s4TxU
	 mYbO2WplO0gEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 945BF40D06;
	Fri, 27 Nov 2026 19:48:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D014F2BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1C0340D06
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:48:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EQJufeIhtTcR for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 19:48:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0C8BB40CCF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com;
 envelope-from=nathbappai@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=vA9BE5Aj
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C8BB40CCF
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:48:28 +0000 (UTC)
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-38190551625so16105177eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795808907; x=1796413707;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C3IB9j4zknRVVZla2gG5l7QxBxrJVbLvWSJIK+usCLc=;
 b=vA9BE5AjsvT52c1RxsqbBMnLvoSwm4IXPqdWDfVEg3Tphz/cCCwST+QxWe6QRVImmL
 hXKn/5zoLPGfhi+Cw/flSHde8qxDHP/l33O1efu3M1puDvVxytyGrjzz2rqeN6m47JmF
 mWSiaXLxa4DBeLqtb/kzlXmXPXnT2m52agoDXnPrO5LKwxhiBt714m+IjmXc0PwAu4Cg
 VLje8ErUykxs8XofKd1KIZeOYtrO4mEUernhB053sDSGoiZyWCpVz1RTEkjCJRmmwACT
 F6op7bIn7Y+55xiMtS7XrDwgzvlkHJdyrFhufCVkiaTTZI9CRvga2CRBuXp4B87pSrja
 pVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808907; x=1796413707;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C3IB9j4zknRVVZla2gG5l7QxBxrJVbLvWSJIK+usCLc=;
 b=Iy/BJ21RP/WjzpVXeaLtWxer9eOZFvWsPaltVZ2W/vYZO8tPKyUY23F6nVAOV0nOR/
 xrmQoVlCP3NPmRA/cbuMQQlQZuuVAFMFaIBNoY9UQ+XVSKc1r3cOFm3di5I4S4FqUsn0
 6W5wAQkFoNYdQRNDK52LVQIKcrhuYfiJmvlb1n3a7ocJsQFVJ6iwuyZ2mgbNLVm8/LWu
 As/dSKWnACOqpn8RFYrS7jh57ApuFx52c69j3lbVS0fjKd2EvUCQhRRP84Cvw4M0H3hW
 s6affCiqJrP6Gc6sNIQ8Wp9gJEWU7c1bnqnkWFsOkHFKwXcy+UWr5Z06Hd9rogIOjlc4
 Fr9g==
X-Forwarded-Encrypted: i=1;
 AL+hErG6Crlp7V2txZFGVGxC7V1rVUGz8B+MAG1/12Uny7zaSUKLAHMnv9VD5ovmYOKsnx0/5rfKtJI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+VIftIAdzMaZAfZo4eu9SrEl6cYSp8iIHWf2swdeFrxjwCuu/i
 iRoVN6ZHO3GEYt7gCUzsg6FpP+07gGuC5F0//DXiFw/7MW0zDkHH4xMp4wGFEOKwpx4=
X-Gm-Gg: AZFdTZcYqTv4hryyK6GMYYU4DkIFefN4ORDtzF3cKP9k7XaSt11D5O8TtYBA06KDtG5
 nmSIVS+hlDYU6QUXBGzH97+dQ+PLjyga9s7/Zm6QQs2SvyOA7klfjmAww9egHmi024jgsuZscRG
 kEPT0Aea8A4BLP2YD1DKW2XdhrQlLdkT9aFLD09/uH5yQ7abQbnKJ3HVb7AyUKXCyju/xFm0clR
 elS5Q1gl1jIud1WD+EiCsxh3IrFZY+Ym1ysDevVNCrGpQzGGqVOBW6ckoaMadao35DVt10DrUrV
 NaEqug3ObFiW4SUt33JK4Es3uCS/dqMYV16J3IYImv2olcM/SinkRf3sgBw5iP0lHeY2p6oli8P
 1h3nM5KkhoszQW/jP2ezIlqLrM1153KqKWwyFSDrsmCFSEEMA21664SR62rV7HX/WuGnSolcU8E
 wsOMHzc5XXFaskr7DHHGh5Cp+QoXiuSvUntOY1kXFPPLB+qub7tFo+b9jk+3ZE8Q+I6PjgGLhKl
 GL7qSRH3YBhH9Lrb4vtg5tQSW43KmOJ9LghOfKDAE/Vcf+Q7IvQeGSrXX/TgzZxSb2dsX/m1qBN
 uhHQ8Y1lCsxN6S/jznr2FdxC8p0dNq6CbhM=
X-Received: by 2002:a05:693c:60d4:b0:37e:fac6:7ef1 with SMTP id
 5a478bee46e88-38571120627mr25656825eec.39.1795808907556; 
 Fri, 27 Nov 2026 11:48:27 -0800 (PST)
Received: from [192.168.0.102] ([103.94.107.232])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm84893422eec.26.2026.11.27.11.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:48:27 -0800 (PST)
From: Biswapriyo Nath <nathbappai@gmail.com>
Subject: [PATCH 0/2] qcom: rpm regulator support
Date: Fri, 27 Nov 2026 19:48:13 +0000
Message-Id: <20261127-qcom-rpm-regulator-v1-0-c150ea719275@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WNQQqDMBBFryKzbsSkNtKueo/iIiajTatGM0YK4
 t2bqtDFDHx4/78FCL1FgluygMfZknV9DPyUgH6qvkFmTcwgMiE5FwUbteuYH+JhE1o1Oc94LmQ
 ljKhyYyAWB4+1/Wyjj3LPFKoX6um3dBAexxBt045Bh0Rqs92SwyX/rqa1/ZvNgmWMX4qsMFrW5
 6u8O6J0DKqNXJfGB+W6fgG93MvZ0wAAAA==
X-Change-ID: 20261127-qcom-rpm-regulator-1426b2d2b4dd
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Johan Jonker <jbx6244@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795808901; l=1318;
 i=nathbappai@gmail.com; s=20260718; h=from:subject:message-id;
 bh=NVJFa0cRbYyOAKI7sww1G/a/44vDs5WO7z676WCOHHQ=;
 b=388KeoZG9jNdnmyvVJ9qynYbrqs790jirxL4+Z3sc4YOuWyCF73xavfnoJ+BLild4AjftU3pM
 jfF5YrtFqe9Bgb/lq7gsRF4yFBfaiNQKJpBOAyQCNaNDwS4uu+kFOa5
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=ATtK28d7wNTkFPtwgWLEaJ1T7ikcnGabljPw7CKsQ0Q=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series introduces support for the RPM regulators using GLINK
transport. The driver is taken from Linux, then modified and simplified
for U-Boot. This is tested with QCM2290 and SM6125 SoCs. Both devices
can enable regulators with this driver.

Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
Biswapriyo Nath (2):
      power: regulator: add Qualcomm RPM regulator driver
      configs: qcom_defconfig: enable RPM regulator driver

 configs/qcom_defconfig                       |   1 +
 drivers/power/regulator/Kconfig              |   9 +
 drivers/power/regulator/Makefile             |   1 +
 drivers/power/regulator/qcom_smd-regulator.c | 439 +++++++++++++++++++++++++++
 include/soc/qcom/smd-rpm.h                   |  45 +++
 5 files changed, 495 insertions(+)
---
base-commit: e7d288315aaaba5e63017603e37267bea52d530a
change-id: 20261127-qcom-rpm-regulator-1426b2d2b4dd
prerequisite-message-id: 20261126-qcom-rpm-glink-v2-0-15707dc6f396@oss.qualcomm.com
prerequisite-patch-id: 0347f4ff5c5483bcd34b4c138c8e8074ef64a710
prerequisite-patch-id: 6e56870d1ba02ad3dbc64e2e485cc5e4fe00e0be
prerequisite-patch-id: 5d8793c16eeb129f8d4e5e239af94d717478b0fa
prerequisite-patch-id: eaf0d9c0cdaa82f1bf29538b9e4599a57a8121a3

Best regards,
--  
Biswapriyo Nath <nathbappai@gmail.com>

