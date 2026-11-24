Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B14606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vdbg+hXO;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=hCX77/Sh;
	dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=mBAlUq7P
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97BAB405C5;
	Tue, 24 Nov 2026 20:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5bKK9-jF39Aq; Tue, 24 Nov 2026 20:59:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 937C6405CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795553944;
	b=qIyyofcNxMsYqFCpdqbOzGBu7+es4f7+oNrZHIWUOxVXy3LO13hrL3V8Md6HodzU7BE7
	 VAmJXrVUMKU4rl6ANcpzWm9bsqiteU+TK1J2p0wgvgXTHPOu4mazmqcjtFoyVqfzOcwvv
	 43pzozbVi7Ragt/mEVBYdP9p+GdmZyJcF4w8HL6qloY/V/F6zZjPUJjGzATzBShJX4xM9
	 GIzZlQiaV4U8Xe7Nkne/n7EiKhQHMrviVnjDbJ44E7QcWfvsx927vH7o3zktOtBXfQ1zT
	 GCGdZ6iAfLxL8Q/60aLuZFXM2KNhmpNP2NMyHHC70IRfOarC130A6sf3abNY259ooAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795553944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2wJIyA1Yp9LHGJGNYjsSIqVg0mbhXp3RHAYsvX2XwBw=;
	b=VK0yi8zihVwMQi8c6f6eaIqGj/bFrihgplA9PtzYLDCzMMdOKN9ddnLtWAoCHEB6xYhR
	 Sz+qWanlZPv7499pdMwQIctzhggZlSzXj0rnd3kUwM65XGl5GMReMp0a5wJr8YuohWXux
	 6ejlRZh98Jy6utt04gqQlV4mP6C1HqlUoT9HC7K3LIoFj8mjGbfj/n15HwG/CTTNNRtGX
	 uEu/PtU2u3acATAihJU7JFQrKsYyApOAYtKm0YJyIkyoi6x5HJuUvJFvRBnJ7MFHf5ELm
	 HUgASAaBMmf6mzSpmIAzvbNnN0Jjc7a4Z/fQFQWSLsOkkaiD0O5767k3v1G6dL6Nypw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b="hCX77/Sh";
	dkim=pass header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=mBAlUq7P;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795553944;
	bh=2wJIyA1Yp9LHGJGNYjsSIqVg0mbhXp3RHAYsvX2XwBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vdbg+hXOC4Pb9UN0H3NRcqpoK4Z/sxvmGwH+zjrAW9XlsmHChBrBebldb82Gqu6V0
	 ykm/MKiU1pa8eeFbXeS0aKev4Q2UYLWlfKPAXytsxqIIFHz/J9qi4iUkfbJRl3odGl
	 Sp1onKnV6b89OFnQy/Wd3nSfWQMErZlKBI4slsZ5iM5DjgkIo630vjzGEpZIK8ZkdI
	 z4LnN5y/U/UV2nUSFSnjFnRpdBHbwSjtqiw3Ba5UI53RsZ/5ZNfyhgYD4qxdjbOzGQ
	 C889RlehhO9rWsvSHzPhzt/QGog4HfE0E2/buaVpIX6ioAGaKCIpKQMS9xtm+tu47s
	 R1dkBjRmkcCUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 937C6405CF;
	Tue, 24 Nov 2026 20:59:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EEA96325
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC55240352
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:58:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UodesobjFXdl for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 20:58:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 010B9405BD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=cbd4=jo=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=hCX77/Sh; 
 dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=mBAlUq7P
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 010B9405BD
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=fe-e1b5cab7be; t=1795553936;
 bh=2wJIyA1Yp9LHGJGNYjsSIqVg0mbhXp3RHAYsvX2XwBw=;
 b=hCX77/ShiyxUj5YTTr37dOLV0pAs6IyzqNV994XBqzgplM05sWZ6hLjURquda2Oj7rcx2wxZA
 26dRr1BTYegFYX2KD11CsK3wU6Xtn7bqKhz/lZact93P/SbTJeWBZV3GN84VfpG88DQi286UNP6
 wzaz7X5qQl1ShbWglKf/thCzRJrWwRVoP61B9lGRrEKSK5b1xn+ZYnALitEbeB/na1HVixHmM8q
 qmyNs32HQ7C9yvqPm5a7+0+/gHuuFGOmrXDldR1LtpR9HTgCZldm7w20jsWloHU9IC0z7sSXseg
 ch1wF70/zWabEyLBpOxhrm3w9+CR1l/RsI0BrkEBPuHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=default; t=1795553936;
 bh=2wJIyA1Yp9LHGJGNYjsSIqVg0mbhXp3RHAYsvX2XwBw=;
 b=mBAlUq7PFtKaRZtnBwe64aaGQGB+0LmR9x0tzH+FuGPEA+gJufQ1VPXKifT4CO9s0jlwoSynC
 F5bYn4X3NEhIpyDPpwjiQH6ELzYN15/LkoIP5N6mY6Fqejrmqw34Ef1RH1mSWp/sDXnUDiHBSFg
 um1gxOnJ4QxbA8z1RbHFcKQ=
CFBL-Feedback-ID: 6b05fa8f1eedfc30af5a5377:32e4e91f8a05247592141857a06ec60b
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b05fa8f1eedfc30af5a5377
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/4] rockchip: rk3506: Imply OF_UPSTREAM
Date: Tue, 24 Nov 2026 20:58:42 +0000
Message-ID: <20261124205846.1536932-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124205846.1536932-1-jonas@kwiboo.se>
References: <20261124205846.1536932-1-jonas@kwiboo.se>
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

The Rockchip platform typically require new board targets to use
OF_UPSTREAM and board device trees from dts/upstream.

Imply OF_UPSTREAM at SoC level for RK3506.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Collect r-b tags
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index c1dbcce1e27c..50698f355d33 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -341,6 +341,7 @@ config ROCKCHIP_RK3506
 	imply MISC_INIT_R
 	imply OF_LIBFDT_OVERLAY
 	imply OF_LIVE
+	imply OF_UPSTREAM
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
-- 
2.56.1

