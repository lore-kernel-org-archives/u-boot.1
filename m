Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18B606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZDoyyrsx;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=B1e0sJ3r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DFF640B1B;
	Wed, 11 Nov 2026 23:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1YDdCMHhH_C5; Wed, 11 Nov 2026 23:13:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1DCF407FF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794438798;
	b=rBW/hW+OQQ4HTP/W00BtfVz4iVoVwivPD/2wjuqk7YtdzDIEybwlM6M2tCNTETdlxO2q
	 R8rmUEJaYrV4O8fq6JePfbj+Y0jhvmsWeop8/KjpChB2LsNeqvF+/T5b6IAiNVKBiU+Fn
	 QV2L9vLXutP14b993It+922BJuHX6rTASRxa5G7RAPV1Qz+a9EysnN8js+SlFv+kmOB+Y
	 /DX40nRSrXNN4PMJK6/oN6OiKqECAjdJZPgbjw62D2QsUj9/W6Y78EncDpoMp66hv203Z
	 ZH3iui648hfjobt2F/3Fb8XReXH9njifAy87QWPT/f3wEU4tdE6zxcl6lCYq8AwUrww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794438798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hgCHqDSjdQ2IZXb8qcSMRVoiXs6SoHvBhHmtpYkfWig=;
	b=NZZgeziUb5ZvE2cN8XG273tXXX6nv4lbMZjxXztn+pw7/Htyn7l9IsYjfOigJYdqi76b
	 Z+lnDFUXXFBpksE9RbMfHcwyLiDu3V1Jc5I+jBv14RR3BQe0+G/QHksDeeBh312EikxeA
	 CD9wfxplywHwoZVZaoror34sRYI9emPsq7wfLx+xy13V+oQvQ3gDLgQoHqac+P8XhfEK6
	 llvM20wcblvUJAvwaxBth0LfNfxlTLpITZ2+Ja4plQCTIZhD+a1epoaOAyeeZmE43DJIY
	 wRqpGxKtvMKsmky7kOR3lPylYrkmhhODlBVQIFd9n7yvIs3EnPGSi1EQ8YWlW0FDD8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=B1e0sJ3r;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794438798;
	bh=hgCHqDSjdQ2IZXb8qcSMRVoiXs6SoHvBhHmtpYkfWig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZDoyyrsxYzVC2d/nU0jYAecCzcf1PGmHWP1sU7OPfJwftMF3gKexusmH1dB77ApoY
	 ljjVGmRzzE/2b3YHgra6CwtIZYUD9O/Ckf/LBVngFFX5YFU9ZryAvR+VKEpKahXnVb
	 4RrN1ZSGnxEWaDzIMDuftvVO5o2a9pnVKf3H0OUrR9kQ5bI+o3f1/OYjs52Fc6fY7F
	 KkV6ZnAWYPOWqVwlhNGs8FoyBZ1qtywWMuDo4Hub2fZswUi6tDRGnGlFfQzIeVTp2P
	 BOE1TCpbP2g28lTrYVdwzJwaXmR+rJjzUklb7tM8cU69KYQCz9EvVZ4yrTKag8jXdm
	 kGCOnnaeYOA9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1DCF407FF;
	Wed, 11 Nov 2026 23:13:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E084DE09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D21BD40B1B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ytbocwkM-x-a for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 23:13:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 44C1040A5C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=B1e0sJ3r
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44C1040A5C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794438794; bh=hgCHqDSjdQ2IZXb8qcSMRVoiXs6SoHvBhHmtpYkfWig=;
 b=B1e0sJ3rJXl7q33/k7WTZzh1xBx5Usc5DyGk7hdfIxO+4zcfkqOdTZ+n7TWlU+chsvRqagAEw
 SmaORBvajn9k9ic/Ul8eWxpn6ltaFD4ESYi6CiDqCCADEMKqktF0F2Eyscn6X84djjiHFYRQ+yV
 p6fFkCG1DLUvyOVRZjfVW0ZIzZwdpQLdekQP3o2AshlXvI0QhaIPVAyZlDESLSnfzd5NSSnHldP
 HAnihZOX4vBvMmNtwkfnif06LJXSVaxMnoIEUM6SRVbxacAtiE0+c5BXi1dXvjgd1/021oBX7lL
 F/0TqtHlllBayI4Ar3uY8rb80FMQ7GzUu19uhQXVXCaQ==
X-Forward-Email-ID: 6af4f689f53292d6859f33d5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@nabladev.com>, u-boot@lists.u-boot-project.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 5/8] clk: rockchip: rk3588: Remove redundant PLL register
 macros
Date: Wed, 11 Nov 2026 23:12:46 +0000
Message-ID: <20261111231251.160051-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111231251.160051-1-jonas@kwiboo.se>
References: <20261111231251.160051-1-jonas@kwiboo.se>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the duplicate RK3588_PLL_CON definition and the unused
RK3588_MODE_CON definition. RK3588_MODE_CON0 is used by the driver.

Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v3:
- No change
Changes in v2:
- Split from "rk3588: Fix trivial clock configuration errors"
- Add fixes tag
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index afce8a44af3b..c83010e518ee 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -105,9 +105,6 @@ struct pll_rate_table {
 	unsigned int k;
 };
 
-#define RK3588_PLL_CON(x)		((x) * 0x4)
-#define RK3588_MODE_CON			0x280
-
 #define RK3588_PHP_CRU_BASE		0x8000
 #define RK3588_PMU_CRU_BASE		0x30000
 #define RK3588_BIGCORE0_CRU_BASE	0x50000
-- 
2.56.1

