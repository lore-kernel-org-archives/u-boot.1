Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6FFCA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A475080E4C;
	Mon,  5 Oct 2026 05:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VuU9bU-i5z4q; Mon,  5 Oct 2026 05:13:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B0F0B80E35
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177194;
	b=TI3Zll7nEzred0UttZw3uxhpZqcgXLNkV61rX2Clk40Q8YNp1eoruaGd34V/bSQgxDbG
	 uxfeqNHO/jmKBe01Exs1p56GaoObp/7nAf5M9T64canaFP7twkEn+7B0HGFhbAQGKV0Tj
	 UcfCr07BAUu9L6feFzR+csz+ygD8MIdYdJIJ+Kq6SXsUZ5Z5FRe7eJKXaVYzW5JxlE4v+
	 ihF0aABnssUKj23JvhuIhBAapaFIRekwyXbUcK5j83wvDHdp1OalqcYNTfAoKJmaquxkq
	 +n4L11lvnWZiml/OaW+e/dl9kc2plQbzM7aEJq/dUjWpC9F5bXiC7pzVZEQoOGRfzIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177194;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=pS3jAmJ5nq4eqNKTCWzpFuu5DEth3Hfq4lXBgTdmZVU=;
	b=h7gIrgkC7kMwIy97o7sfeeGvWJ/JS1YZdxHMmiQWN7nLW523x0K5AJkETOtDIG9+Eb8F
	 2tI1HDNOeck+4Q/bNjEb0qDUaZ9LUa9IUsAMCjPZ1G1o+T6jRHGc6ZeSDQMAsbB4/RRLg
	 B8N4hJAUrHJ2YKB5/Zo4atg0/pi5y4WEIIzwFQOVK2j3+5wVyxo10Bc9OdtMqaxUK0ZVv
	 IteKLK8cwWY5Kvlvj9V76aHi5oP0X9OUy8fqhVU13cMlGdgcIDk+LH42uVp1T/JWrUrmM
	 1MYx48jnoAUtgBLFl5RQ+2Wi0YnaI14pMRFIAtBa2UBkBhO5Fk55gLLw70bflfVfsxw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177194;
	bh=pS3jAmJ5nq4eqNKTCWzpFuu5DEth3Hfq4lXBgTdmZVU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=jJXCjecSmtJSsY0uBixlowyG19ULKYz9iFgPsJMg8NxFrt+/+KcvkhoZvgayBfRQP
	 i4Q6HMbwcoz2m+S0s7HXXiMbzecA2o1rTiz2BGxHdLbSS1mObBwIEUHAYgxXme9Zew
	 yUqKHwpvzEDF72s7BAORW9l7ahdQDgw+iMJvCRRNAOYl/ZTlh2j4YGQAMKc6sm1kmX
	 5e7I5g045kjDKZ0uaHa+33bGQW/xCnzpnbqG2KgNIBNeSIiJKSiboMfPYbCjyxIM1y
	 s9QaV5LcdiHvqbvQZvZgviBSLZXyERYzWLp6p3m6SNIYgCq8SSXrcmrvVopWQ90IP0
	 zKM7Qz3xNCcNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0F0B80E35;
	Mon,  5 Oct 2026 05:13:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D7BB2E0
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 20:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 839E1400C8
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 20:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sAmqVPtPpCcU for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 20:48:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DFD4D40004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791146919;
 b=q1Tuo6pfTn+sU9NLJfd7fhQ+e2GN/+iX+gv69dd2Rho2bDcgxjmhavStvcdFCC0K9taQ
 NvO/1hPoJeKGrOPB5AXkUY0Q0FdgyEZ5I1Memt8JRVlHJgny2Ltc5oV1iAgq2knl+elEk
 jdvZvuEfPnNpaqVDAw9gFRDmxOhtHmcATPIZBYfJ7Zb+u9RRceJdIuVPuopk+hv6KJmxO
 vv224KrAf0fpBeQrgznpQ8JOy4wQTZVZGo7B9dol8eTv3p9+fXZdV/a20tfRH/skxekVY
 pkpd5xLYSCXx9wZgrK9yudu0EsSoemyc/Rkd5pHnXNXjbsq44eMaSal9pK89rPy9TbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791146919;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=pS3jAmJ5nq4eqNKTCWzpFuu5DEth3Hfq4lXBgTdmZVU=;
 b=UMd3VhrsJxZRml2P+ga5WLbNdU8Cxmn9ZLUPawKhcgmiv9hx3BXMTKUa5ctMROQFZehb
 mLpelOKNsvy5Qh1PCM1/aYtMnfDcsjSMrqNsNQf9LBI9rFDf+YlYeK7tOU39V9r2Ifms4
 xg27E0Zz5P80f+3fnb0kaUeI6eHl+tuDd+Es/AJYstopRzZx10OUQts9qE+luUIsVc70Q
 l2oLZW6kEqOkcgAR3OUWCYVAX6LETkny7iwnfhu4cWz2P6pjQufWMjH9eq/3LOY6/JTfG
 xdC3zEoknT1yhsFpt3eqsNtSQTacbXRB5pHS6aIooQujBnM+WTdD+WDhbJ6Hk+VMB0g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CoYyh1+4; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CoYyh1+4
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFD4D40004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 20:48:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CA9D060210;
 Sun,  4 Oct 2026 20:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 769FAC2BCB9;
 Sun,  4 Oct 2026 20:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791146916;
 bh=jaT0NHLdfgnWNJvX/Eo8/sYYshllPbCO03oh7UbVwvA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=CoYyh1+4+gqYIejbTal1daJp987+jPNG2h4BarghM0Og2Pu15og1+ZDLl3MZbso3A
 pddh06Tjk9VIGKS5tIoiVeGNj1JIWklY3UUQ9mzL1uC7NPHqZ6Z1s8zocPlmAU8fqj
 DDilehH9SrNQpSDqXYGTf2PuOmkTSMuQ4lFmFhLmB60Zp1WFS4P80C454T5RqCj65/
 x1/Vgd3kT/5/0Tucy+Z4qh4dffx39WiyV9TNF7zSMDCkh4ueLlFpqydQnUsnuy2rcU
 9a8CNYGtx1mwExfVcT8iaa68qpPCg9srFUcWAaUd609MoQ3zAtVUEv2bRAsCRuPXqh
 /zthPW9TwcGDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 54897CA5FFC;
 Sun,  4 Oct 2026 20:48:36 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 04 Oct 2026 22:48:26 +0200
Subject: [PATCH 2/2] arm: snapdragon: export kernel_addr_r_size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-b4-dfu-alt-info-env-expand-v1-2-700eb0e54b61@protonmail.com>
References: <20261004-b4-dfu-alt-info-env-expand-v1-0-700eb0e54b61@protonmail.com>
In-Reply-To: <20261004-b4-dfu-alt-info-env-expand-v1-0-700eb0e54b61@protonmail.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@linux.dev>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791146915; l=969;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=TMcEEwctAcjfWgy4s8/8EISXg1ISob5U7HUdIo1r3o0=;
 b=Dg2ORcCwT3X/WK8jTdxgt1L4rPPpbA5pYpRaZw8WPaGe3t+zt8b3jGGksuZDLbiy13INSSMbP
 1yu/JRYsTFJD7BYFGp+8O7nmnoed1qjaMpp0Fmk4BzZgFm83EboVJMs
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:03 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

board_late_init() allocates SZ_128M for kernel_addr_r but never
exported the size, only the address.

kernel_addr_r_size mirrors the existing kernel_comp_addr_r /
kernel_comp_size pairing already done for the compressed-kernel
buffer.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 arch/arm/mach-snapdragon/board.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 829a0109ac7..70d53a30329 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -530,6 +530,7 @@ int board_late_init(void)
 	status |= !lmb_alloc(SZ_128M, &addr) ?
 		env_set_hex("loadaddr", addr) : 1;
 	status |= env_set_hex("kernel_addr_r", addr);
+	status |= env_set_hex("kernel_addr_r_size", SZ_128M);
 	status |= !lmb_alloc(SZ_128M, &addr) ?
 		env_set_hex("ramdisk_addr_r", addr) : 1;
 	status |= !lmb_alloc(KERNEL_COMP_SIZE, &addr) ?

-- 
2.55.0


