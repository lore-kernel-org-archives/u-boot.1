Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18F606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DH+MkRTL;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=aaCHIjco
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EF8460666;
	Mon, 16 Nov 2026 10:28:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id InPMddFnScll; Mon, 16 Nov 2026 10:28:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5FA82606CA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794824881;
	b=gekopHWbo4wlg5eQirumaC7POfQz9nLT+0m7/CzXl+2I0CmuDH4gBkYmUTaz6NQyBUgj
	 3MZBST0dcxDWRurydjvJT/WekG9ZyVTPQWZ2sC7o9l40Dw6cMNthfE1/rWHo+bKshgQD6
	 6QA4/2ZRWja2HFwTaq6k8eCPw+P+Pf9g1nqkrf+zsBBW7NQGMeCDF+etGspAAjxzEs3j8
	 xL6ygsIGbAMMChKKHQ37fgcQtdYACCS0+LuH44Da3wjjuoSsw18QGmxKm6aP2m00YZQaV
	 pSP7YPrB/dXSO1a14G0DJDB21zxQ8oCQWcJzSTAuwpzROSQMts4CMJCQ0yYk3qEmMHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794824881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BtEzaTxpub2Fu7amN2kwYU4LQcBNTkDPETE8bHZru88=;
	b=jUt49HlJqrKxGcyQctMSpDVAEzcizYNaat4T4zms0JdDGKUd57O4vocy7BCvH7NVTjvd
	 +Gq8g73UlkMmQOUHFpI2xSJMrnFqBYKQnumTPA3n6eLSojWgWftqF0Hnh5iLvXATvlzMb
	 RVLZJtpGolqxhnC8OAD8+awQGgHKVDGbyTkglLcPTNvLclCr1Rfh2fl3UwMBAHmOB+2ol
	 rKoLcdxEGL551BT/VmfEQ9EiAuh0mNzMawG6HgKmn40KPk//FjavxLh3sdpEbmSrx+NV/
	 9uspk4on5uvXRjzmgxuUex/uJANtaW7lZhWY04wwVKjSc2gkdVkkkXXy2/uJocRj8qQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794824881;
	bh=BtEzaTxpub2Fu7amN2kwYU4LQcBNTkDPETE8bHZru88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DH+MkRTLNCc1ty2nLE47iCDp2PK+IibXHTVmbUHRA5u1XUKtE2fUWeDp1D5XDWFrb
	 8bKzKbYeVaRDrrF80JRmCsbmgqmpYpZ+R45in832iz8t7M7OhxvQVntarV/4ngohIH
	 x8Z7OEp+DHEFsrGfIrQ7nwt+fUXYSMyBnwLrkqIZHRJQczFTdfDnwbbvAOTfWGUVnP
	 UXmCSo1zRI4XpyMzNW6yTDwAaz+4ECGRvAi87boX9Quy4TJrYFt8dYa/Cwm/3AWG+5
	 tUT3Frn79ow0+vmtjAnlyk5fNtLuIyUY7dVk6c04VkGPMLU2VEP28GhDR3JJEy39Em
	 CGLwbkjjK9GVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FA82606CA;
	Mon, 16 Nov 2026 10:28:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C43F28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 120EA405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:28:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lUgOFkYuMx5X for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:27:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2CB57405F1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=aaCHIjco
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CB57405F1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794824848;
 bh=BtEzaTxpub2Fu7amN2kwYU4LQcBNTkDPETE8bHZru88=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aaCHIjcoUmbP93Y9QI8d0+4aVYD+c3zUpSfMntaLY0pVzIpajpAOtoiQXpAWdPMzT
 pv/qHCQ/NU3w1wEIKRspds444p/8YWDXHSdEt++hqTW7UokEHcfaYvhsZhy/Mqc9x9
 9Aa3vPx9dsF2onJt7d9Hhtuskqn21NBK8Fm8clurnvVGSPkmZ5jZJISfnetQB9a81W
 J3FIA5/Oo61/6XaAJzhCMIQ185GWEdiKXRaHmGAP8SKgp5sW3u8L904w0N2KA4EvHE
 ShxS9eRSTcf3abcU57ZOWcLJZrJuCx+c7zIkzP7t5LyXSH55Xi0vBm/RLwuMiRx7S8
 YMVnYNlLDs+0A==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 1C0A9B2214C1;
 Mon, 16 Nov 2026 11:27:26 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v3 1/4] riscv: dts: spacemit: k3: override reserved status of
 mimsic and maplic
Date: Mon, 16 Nov 2026 02:26:27 -0800
Message-ID: <20261116102653.36927-2-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116102653.36927-1-e@freeshell.de>
References: <20261116102653.36927-1-e@freeshell.de>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux boot stalls when probing peripherals unless OpenSBI has the
enabled mimsic and maplic nodes. Override these nodes so Linux can boot.

Reported-by: Yixun Lan <dlan@kernel.org>
Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/spacemit-k3-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
index 352e85e7de87..278b36acc79f 100644
--- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
+++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
@@ -3,4 +3,8 @@
  * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
  */
 
+/* Override reserved status of mimsic and maplic for OpenSBI */
+&mimsic { status = "okay"; };
+&maplic { status = "okay"; };
+
 #include "spacemit-k3-binman.dtsi"
-- 
2.53.0

