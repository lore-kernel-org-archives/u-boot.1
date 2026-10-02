Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58105CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 01:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDB8240CAC;
	Fri,  2 Oct 2026 01:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5PUdy1NZaJL0; Fri,  2 Oct 2026 01:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 352C040C99
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790903046;
	b=NjxH29sKqWthGrQ4CBgWTiQwGI6bBi38fAT9LxKieKh1H7eze3bM0BypHZwjsVJpzlri
	 +kG3oW4l097vwyjIM6iKTscXYbNooP3Xmf8lHDIh3sQn1rtsAHidPUzPyG30HewO/iBlX
	 rNy0YWqb+GkRL9VtOnhaxFp0lAkn+2FSMV8Rk3CRQ0rEbco/gz7ZAcPXS/vgz+vYNqKKl
	 QnOHzCqM5zKvy/NUqSjK8lJrNhR+LE7um5rHnxfFrD/FPhoMQJKGKfhAUJtvmRX8VViN6
	 lcyrrNTM9zMl3by5zXo3Jv8QjMmTKwD6koPvIJpquivNwx1UUhJPUAPwib3FFP7oGsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790903046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lPMcqDUX5Gn8jmAaop972eV2qw+yQn0lyws/GRAcBCY=;
	b=NpzV7LSJv+DpIS8ihXsxdsi2YTCGbjtiZYfFAsJEyzckphakL2v+MLdA8XtWDa/Z338+
	 jCag3wtJ3wpgnHfknQSBHaIxkMIjAfrb1kacf+TOU6XFVVna6hwb3mijRDd5TTgXfoCsn
	 Aby173Sj1aqbTDdgpPukcx8GP+fQ5UJNQB+QsjpkYhNsUJMnRzLhgWKZhh/xbWF/UVu2P
	 5C4k2DVS4KfOMmf6ii/VDoRO4bZmXki+meU2QL1zQOfcSj8RWkd6kLaxnZdlNtbqjw3UZ
	 sUa9GxBsM/Ay4s0tD7czZlyqCDtbPFv73I51bMJEkh/b9yzP/5Dr8GUztmXdhrRsK2Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790903046;
	bh=lPMcqDUX5Gn8jmAaop972eV2qw+yQn0lyws/GRAcBCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EyS+ml2VyE2jJKreUhoIq4uktypEmWBf99H5fT8qeaMinTo+g7OXTCbEBAAw/Lc4g
	 KUOPWpYGR2rtBaNWPKotcH7qMxAxfwCO6uWoJskJgu+dGzIj2c7IWLYrTcoGVMOK3K
	 P4187UPd++3k44lA510ZZAeBd9xcpn1QXhDLIct/qGLSGOiaQSxSyk2BaeiM8+HVLW
	 JAVksnL7dNqz3sn21PYxgrHo2cPJGDhIqKICJMM1eWzERX/A8KkgqGK3Go0FCf9POE
	 a8d5r+a6db/T2OXrrRXUHeVW3gf7x2genmMa5wyr7jPaDihwii8my/xYitM/nyDF2g
	 ci72sbfN2bDdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 352C040C99;
	Fri,  2 Oct 2026 01:04:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A67BF4D9F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98065400AE
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HXH-1BJ3PAJ7 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 01:04:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F396940062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790903042;
 b=gkmIrnJNP5y7PCLwhTggxbglNnRQpZ4qNS2cITfO9VUqZ2X2HwxdNDfevIIu/LxEcy8T
 h7Je/iseSNzzFv7EZWFWQgrGoi9FDlUUxPhGNH4iUf2DbBIzAGeGVYCxVChH4uE5wVRU9
 6rJyPaX+PPFO5RFdAusGGnGx6sCZi8f9C620WB7kFHX0DWznrQ5q2P4aUlXe3EpxBbAnq
 humlVo6lqMpHH57cE7WTqZ/2tiq/tT5/31Rz1NM6zkoDMQFQHG03VbVI6aViX+nbKAChl
 sWL4j8/jUAc+NQgFHX1OKugdcb7A+OelfbN1m94UaqI43/yM71Bdjk8mGFuWxbFwelA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790903042;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=lPMcqDUX5Gn8jmAaop972eV2qw+yQn0lyws/GRAcBCY=;
 b=PSKU2gNYCUASdVj2iAQySMlbLWb/eGfprBJatEx8aI5OzowRIqUoZW7gJGP+nspaRPVw
 3qTddhq3pn8GTJKZES2I3/MzU3IeUyd6bwiWSFT6tf37VOf2Ejl31/TiZqv+JaTDdNa7T
 n+/aVDvPnX0HUxJvUOd39LIPI6jtN6EzboILJUGjcICT9wgnLVXIdNxQSkEv/myzx9aMv
 5gEOgZfJZho6qauPAItCCeH39FHDSoOpd2pqNeJv9GixsmxQy2VxtFUvBrEqBlbMs2ZM/
 nQBXP8HtYfFwvZjSV+ojFXngLwgRvG0bkleBkHMkbiIP/GIAAOu7Bww/xFthu++PKlw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CfgkCyJI; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CfgkCyJI
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F396940062
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:04:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A70A43E17;
 Fri,  2 Oct 2026 01:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9511F000FF;
 Fri,  2 Oct 2026 01:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790903041;
 bh=lPMcqDUX5Gn8jmAaop972eV2qw+yQn0lyws/GRAcBCY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CfgkCyJIBRHJhjrbcLwXEEsaCVdYuxDZFLZLoZCXj2uGpwhuLX9NoIkGhAFOaYCoL
 QG88nPAmmk2sOrweunhICfZmFiCTiEqALeduF+ayfCm3uWD2h2BKVWYqcEL6xN6aaI
 VccnUNeJoR85zPLWEQPI8I1ieWGa1uWhVhLFjUUiQwShfJYUrafBkMY5dOtmOo5dL1
 iyiK7cL/vYl2A11i5K4oqrZ9WyBbQinCELLNzQidHwZjukVBsfgSnIdk7eaSgNqDUM
 4oOSOLS1iPlq8gEntoQmzjPUrePEPPc2gXALhhWFL++WAYyvJ36L29j7IbapQnjSh6
 qLiYe2Lo/Xz2g==
From: Yixun Lan <dlan@kernel.org>
Date: Fri, 02 Oct 2026 01:03:12 +0000
Subject: [PATCH v2 2/4] riscv: dts: spacemit: k3: add binman node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-00-basic-spacemit-k3-v2-2-fd6779a0317c@kernel.org>
References: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
In-Reply-To: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=613; i=dlan@kernel.org;
 h=from:subject:message-id; bh=H0AjWBmkbMOjQHzwbC95sU4Y/moAEcEfumX5qT43yvI=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqvwLwczDtqk+kBcU2ITLBvi3VuqsfkKnwt+fgE
 OeaUMX8PGCJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCar8C8BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3QhA/9E1D41SrsusDhJZGMfmbXRMN+SIUu523yfN82x/tkPTST30WkvPA3V
 IaDKhfe/7GeqagAJUsrP8gMUv9B6tITJjMoBsDRJJg3DdQ3AKri0fo57fpPESNIObmXbXU/U8g1
 AeK/eAonTsogrTw8IpiX7i2KXcX8ZQmqwNYBNIMMHCMjV/TT+nXstLN/7A7idIdtVM+hJraiKwi
 9/KfqVzfrGhmzCzeTrkd+ihyc5etw6B+X2mXFkYOrAQ6St/0Z10j0cdgvs3xT0iKCefXWN4NYte
 nkkNJ6h++b7DV2UuemjlGfQcio+44ersawxDfChAAa4EKOwxDznEUgd8kmUm5Zts0LoP03lASC/
 UdeAKz+ixgCUsjzrfnmzgCAOXHOuTxrHPBTuCjv1xBNO5CQ6ZqKpR47TFDPTOS6vD6wnQsR5N2V
 zYpCyQro/YIx1fisF4l2dtdfsmh+owZydMczUye4/DXLV6zBxGmCfjEcb2cM5osKB7Uom+GCPQt
 74nTDoEBsh8T70pH1OJkFAoBvEASWg9zkW/8zIgTsiW44XOOjxlcL3TeWhHw/9L3j4u3V7+dqiS
 B0YHrFdH3tkUnl5MgqV4uxA+RZ/B4S0+2Vbz7IZREs3Zb01c3pW+AMIaKkOSy02T3fniMWvR5tX
 bwL1KZt9C/EqwQs2pKYG2JppTCvfo8=
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
2.56.0

