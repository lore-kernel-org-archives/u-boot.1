Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14174606A323
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JPsT8dWt;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=Ebe1U76B;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=CS/IRHZL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24BA860709;
	Sat, 14 Nov 2026 16:21:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yr8JSdBVruFE; Sat, 14 Nov 2026 16:21:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34F7560726
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794673313;
	b=qVtwVcFe98b+d+bK/sCawG+oogJf7IVqSXcPd5gYHWKoAtOlay2wcPD/IgRNjlOYxVee
	 FlvJ1FtGW18yyIlCSgjd4NV9+0yqdiJq9i5tf2rAWklLSs3SFVE2bkOBMM4hRw17nBx7h
	 uAXZuS789hqNbn988YzpHubN0/WK+OibkoPXiJu6QFAPVvX7e21MXho9tOWL4YV9sRvBR
	 yFW4EU3j2PTB6EwtSNoQ5m8RcpMPSr+HgtqXkzLS20obXn9Yj0hLajt/hBL20tHp9PT4Z
	 nseRVjNcq6IcKiDCOUpr1oFLNrLnl0JMUZN243G1cFEvISJxxN4OSP8ZCnGjNwO2ulg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794673313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pfhDUPsU7Wf3k3MKQppGH3HnFdzM+mkyMnhJjMy46Bw=;
	b=W7JONheYqZCv25ETCNYK2sg86zSqwtYNA8fFv6k+X07EMJZeyC6QuqXDXRFzDAE8CND/
	 BskODCqKKriIphAZDr5XTJZ0x6uxdMm71eNvlyilRZQotYYxmlTtad/7QqDBM0b2m7Jlr
	 eNVgaMCaFb+fel0Bw/WCtZr+PBa42JxCJup2MTx9K79Naxjk0MuhmlTL3Qkpz+aZD3qM2
	 BxRXsgNXiDkwJ4wCpTI9GFQfu56KglcK5hv1eRFnccnOZPErVOXhjzqHTndQxTIKrKcSF
	 ki+c4e6BJta+KgtUgdpAvZ+eH1hTWkExtKSDMgm9h8tNLbIJqGteYLdaK+vSpNU/Gtg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794673313;
	bh=pfhDUPsU7Wf3k3MKQppGH3HnFdzM+mkyMnhJjMy46Bw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JPsT8dWt1wBGZ+D936iWOzQBGhBuy0KssrlJbq+doa3gtF8cyihSvpDUEy5nR36KW
	 pXWdmTRbEEhHNbb1/jRbmKZ8KsmeXZRStRRMJp7QPwfcfnPIMASITeMGbWXp2kmcj1
	 GZrLB9hdskpkhl8xRQhsA4qW+T9Jt0mTOI6ReILtX8LPAxvx18VE8In2lTIhu/A3R+
	 tU5AKVV2kupZGl/oi6uL9fSbaAx4NSr0ZBjAmh1ugP9jEQfor2A2HlanSUN/bIRhw4
	 Aofm0E0UlgzDQt/hM/maqQzTP9RTslwUIgmGNV0Tm2iEoIPrfbMpKTkMPt0d4jJ6fz
	 FEezhWkT6Gptg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34F7560726;
	Sat, 14 Nov 2026 16:21:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6874A72D
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A4F240807
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ba0d6ArytooW for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 16:21:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3EC1D407E4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=69.169.224.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.11;
 helo=b224-11.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a1dadd6475-8f780921-2373-4bd2-93f9-4d0fa089b150-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=Ebe1U76B; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=CS/IRHZL
Received: from b224-11.smtp-out.eu-central-1.amazonses.com
 (b224-11.smtp-out.eu-central-1.amazonses.com [69.169.224.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EC1D407E4
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1794673304;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=PjjovOkbVi7pmeAUhqtguWMWmePhkT/IPr6ezM0ReBM=;
 b=Ebe1U76B03sIs0cYzcAgRrn9RkZCBWZ7hbmYXvIALqzATWGajxfS9XPndCOtBLqk
 XUH5HBwoFrFnBjqKw6LcFxiqdq/nqpPDcHvWd64zw5DQKJhoWHIGw1tU+zu5d+d1IRw
 x1EN9VFPpIRYMbsyGe3pkQaBDVcMO1fD0oNxO8XhgVBiU8dJnENCbJNbb7sEHyc278p
 jQEB15Awlo9YRn2R9gO4T01cADX6v47VdGF+iXWQvCXyDYAKaYNm9VuICi+k+eQPdfY
 bXABZPM6CL431RcCdJzKQdxbXmVqahicL2v6iZxSk+tWSuHrE0oUsKCQfcGZWySyxzi
 pgptXHYrDg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1794673304;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=PjjovOkbVi7pmeAUhqtguWMWmePhkT/IPr6ezM0ReBM=;
 b=CS/IRHZLECfHuhkqImHlDKqxyFDH3oQopnjBYo4J/Gd5rur2volI9r+2pUEbBLp7
 AB8YkyesWXBQuyWW+N6k7iaq8gUKyAeLqNofv27QuHlL6VDvSSRI+wLyEjRe/AryU0d
 iYRwLA8mrAKGGeIXkrnAdSXleBC0PTt1iYJVnX3U=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Sat, 14 Nov 2026 16:21:44 +0000
Subject: [PATCH v3 03/13] ARM1176: Add support for
 SKIP_LOWLEVEL_INIT/SKIP_LOWLEVEL_INIT_ONLY
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a1dadd6475-8f780921-2373-4bd2-93f9-4d0fa089b150-000000@eu-central-1.amazonses.com>
References: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
In-Reply-To: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Vencislav Atanasov <user890104@freemyipod.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Honbo He <hehongbo918@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Stefan Roese <stefan.roese@mailbox.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794673300; l=1006;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=PjjovOkbVi7pmeAUhqtguWMWmePhkT/IPr6ezM0ReBM=;
 b=liyGYTvD+30968d9ligg6Nix1H/0TW98qAbO0L7/0xoG7BRLYMEnv8Vv5ilTTuaLUfgDqO8KH
 dMgdyFSXYxfAkXbwlxY0TIALXeJHPqGL1utU/xTBm7wE1EwBsgMa0YX
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.11.14-69.169.224.11
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

Boards which don't need any init code can define it.

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/cpu/arm1176/start.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/cpu/arm1176/start.S b/arch/arm/cpu/arm1176/start.S
index b041faba5f4..eec3d5f7289 100644
--- a/arch/arm/cpu/arm1176/start.S
+++ b/arch/arm/cpu/arm1176/start.S
@@ -91,6 +91,7 @@ pie_fixup_done:
  *
  *************************************************************************
  */
+#if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
 	/*
 	 * we do sys-critical inits only at reboot,
 	 * not when booting from ram!
@@ -136,7 +137,10 @@ mmu_disable_phys:
 	/*
 	 * Go setup Memory and board specific bits prior to relocation.
 	 */
+#if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT_ONLY)
 	bl	lowlevel_init		/* go setup pll,mux,memory */
+#endif /* CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT_ONLY) */
+#endif /* CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT) */
 
 	bl	_main
 

-- 
Git-157)

