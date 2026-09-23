Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C114C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 12:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86BF480EFD;
	Wed, 23 Sep 2026 12:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7WQySbsJ5V2v; Wed, 23 Sep 2026 12:47:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CA09380A8C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790167649;
	b=awRxB+cDsDqMHo4qEuvB3GHuHwlKoisEof0vbh4p8R9nngCJ/Bn5lvLejPIj4YaBMIIP
	 OExWWVHiNqMSGrjgCDcqpz8NULfY91y8ZWUsI5mYJu50PkYmiz77jU08i2SUQhQe1ZC+R
	 kMk8aYrOJZJZum78tcEMMuNhnFqSnMsIukabtHAvQGK+jqNMHLBTWXkseAJmJRRq6mf6Z
	 xOFaKPAV5PQxihALn31L8ojCyYwRxAQdu/aBTSGkXxGBd/PEN1sg4rCG3leHV01ozDp23
	 /e+bVYUhsC5kq8CDt8r0cRkxH55Q9QEHOtenlnw49GAtoNjGkLlPIoXgIQYNErA1nzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790167649;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ll0xe87ul8LI/CoMiXGPvko1UVdztq26G8hBTHtKWxA=;
	b=Ymb/CeBQYZTbLLCJqDGdXbmhBNU4ka6zDLkk/5EtbqlJ1pdBT+gzqcfuTnJIi5Ob2ZgZ
	 J8Yzyhke0Zzwjk3F7SBoG++pPe1IJf8/wVacHTn54dnB0CcXtyku16670hd8jxI6N3FS2
	 Lifb4mTVTm52kU5gOiuMD3rrm8W6faUAzEQjS0UhdWpOHauvtstd02NOCkhACm+cyp8sQ
	 M7kYkD/XoSvPT4UxiwnSbzFM+X/v32pxVytWxZYT7gbaRIzO2zUxvbebT1z5nJljKMBd6
	 H5Kp4+g8RSNFJQO5YkjlWk4RVeB4mqEibYIq2qHukWiwTslT76OXKRMz3k9TmwFT1HA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXWUr9Bw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790167648;
	bh=Ll0xe87ul8LI/CoMiXGPvko1UVdztq26G8hBTHtKWxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0v2bALtAkfL1/NrCS+wHcykQtEI5HH3tkdyDNcYGQm5+7jolfs2vap179cvyRREtg
	 1GriKQDrUgLxxrknqVFJJ5LLtXp6/qquGfF40oDpTurzDzxTsvswsrP4wdvtX7qAbq
	 qs06Q27ZF7auckoGlgdktG23IX/o/AQEraB1a9cFSIMWjXYU32LJ95aOc9SIa+4ssD
	 BHAyVtmo26YkDOhLjfGrFBE8id6KimvwvF1Wsx0AAmL963dgTGWkUvu5f3p2l/qRCc
	 Gnh4vGBQGe0V7249OzMx/lNaOS1nWneH7siKL7ZqK4vEwlgGbsZ8hT2ROOUvFDke29
	 Zq1MgKeBNYQUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA09380A8C;
	Wed, 23 Sep 2026 12:47:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29E3F28C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10A8E80A7A
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ogt8CV5CWgMc for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 12:47:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7273D80A86
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790167646;
 b=EhC/PNqkRMBjOldIxY9U5ww68ceDaDw3eB3EZ11cdCq9uCfoW5HfCWeRhpWYlX/+svs9
 PqgTpp7W+9Ii17JIMM7Vl0VyjN/p+i6Txy3XoiTxvqwERxPSfr5KAuAfsnfZuvymQ/PXp
 3cmJucj4AF6OAIOeMVj7oLGZ/MOcHP2OHDyVYw/emRv+QmpQb2WlUZ510EyWPdPu6d3Vh
 77SAMThG8pGCnwDXK4o+F3Eu7CfuzwnfOld550mRD04cMvTVlxOaMPEgZB6Q0KpRYL2u1
 JagnXpOMyT4kVlsrOlJdAk8aX1zcI4/Z/4FrgswxYAK0HceufANZK0JpVHMGpFl5d+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790167646;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Ll0xe87ul8LI/CoMiXGPvko1UVdztq26G8hBTHtKWxA=;
 b=X+sg3aSLJh3r3qu/hppoq3crGWFFJlVHb0J8IOdaK2YRz2ZjPhE2R7cRLONit5sQKiOC
 vpkMsM0nh5olStCUUo+wvQ65nw32DgiiNV4I2pk8kkb1S+2ft04bbYz71hgeG6HGy/qQv
 Q/Uh1byFX3PoZOV2+uLQ5m68S5bSbE0XkkQHsOkxp8J92OIHc25DCxpx9Ill6j5vSyYTl
 mBnkbmVHFsoqghbG1MOMDW+CR4XLgqX2XVNF0WbRqzPgt8RSiFyB7Xn5dwcaD25IU9q8k
 FrI4eEgcdXO+r/+W1ybyjcLo3aaCfFJ1AB8K/DGp+tI4rCxkoUzvIV+mW1Oo8/rAk4A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kXWUr9Bw; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=kXWUr9Bw
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7273D80A86
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3677D6020A;
 Wed, 23 Sep 2026 12:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E891F000FF;
 Wed, 23 Sep 2026 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790167644;
 bh=Ll0xe87ul8LI/CoMiXGPvko1UVdztq26G8hBTHtKWxA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kXWUr9BwWuhv8ugHCiOwyrUnUYHHKTIz9aOodKQGDLbX5ZfOqX4Bvwzx+PeDaL4Rj
 S8LexXVWoE4QSTl9hiaPWSmZssa56bffMdMz/EzSlC2HyCzh5G3W6EC01HvgRikX7Y
 4xlqQoZUHZVyo3DMVxFShXCD58D08aFYIfTBDPHn1d8cFzfn7DhJw/blERH7rlXq9L
 mAvrlGVaS9D0xGx4WiYWWi2euNnwfQrERaZDqYucmNkgfcp33p59uBMGIm7VwCS83B
 oWbBSZ/9Q2Jv0c80P9jP2xi+WeQQkaggQKeirx/DyU9tu5TZgVyH/MjerDrdp3nk4l
 diSHJLnx8tXlQ==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 12:46:46 +0000
Subject: [PATCH 2/4] riscv: dts: spacemit: k3: add binman node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-00-basic-spacemit-k3-v1-2-fa1015f2cd1b@kernel.org>
References: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
In-Reply-To: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=613; i=dlan@kernel.org;
 h=from:subject:message-id; bh=6LbjmFelhlzxYE8jdNqMOg3/Ie5i0yYjoZ2aNBrlHPc=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs8pGfGKrQPMJIb8OasCQpGco3SdOtKW2Cqe/k
 yxTmQkligCJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarPKRhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2Y2A/+L78nWezsWtHBAtbyG1idp7LdDD3G4SA/zqWwqjpxbCVGK27pUuuCq
 5iCoAJXKdTmPPt1V8Z0DhxRkp+CIaVx+XGoA8CIS6sHalRDVt6BxU1CnnS996ReAyOvtFwwaGYY
 ydlxtNLilVVHuEcAYSZM7gdB/qiLDhRGg+Y4Vo2yqTQMEddgk8jtcM/g/mNVWVpIS9AxRs9YAn0
 OXmUis2N+BZNofnEyoVOmtvkVO2JIzsnBLbhgY6y06RdQM0DBeqo7eIUbDat88GizpkIYte8HIO
 jd7Z27gweZOedEPkKyZXp+kS7AQn29fWcftTs8qXymfsL6e2/V1gPrV+cmRG3/gGhfYjcXnl74N
 6IDg/IsKMwQd6l7ABr9A5ao5xETRW08SrZ+N1gVay0QPFQXevMNcec7EIoFcOc7DmC5bc/0Aq80
 7TqhzDAn5rhIdIBaNyz0ppTKR0GEjFTRrn8m+XkBdbWXQ/EHZ+oP3KO/ELrhZp1D3ZlJqAC8Prx
 v1HrF0zgsN1yE+uF9K7gBUGBs4UC8E8R1+hfprWh4MSWOtEo6pmQ+WZr6CvVAr/l7eGah/4VSZm
 5WngShHZ1eRIOGcebLoFYbA0RRJFs35ug+Ze+euFuuxgNNW53S9GCeBiKP2I/xq0lVJ8QSUl1KV
 8cZGzRTk7bdy9A7ww3a1kO14i9lg/M=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

SpacemiT K3 follow the standard riscv binman layout, which has opensbi
and U-Boot proper, so include the common binman dtsi file.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 arch/riscv/dts/k3-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/dts/k3-u-boot.dtsi b/arch/riscv/dts/k3-u-boot.dtsi
new file mode 100644
index 00000000000..f1c1c3ee6fd
--- /dev/null
+++ b/arch/riscv/dts/k3-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+ */
+
+#include "binman.dtsi"

-- 
2.55.0

