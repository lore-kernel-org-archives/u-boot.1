Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C9606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B1c3f20c;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kg1P3IWG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 697A16073F;
	Mon,  2 Nov 2026 03:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rti8pr5gA5O9; Mon,  2 Nov 2026 03:04:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9BEA860684
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793588695;
	b=QoSQk862m1dbmRa6znCdNlUMBaSeIioZGCjJBJ++hAdMldpHm8ZyVSzXwc60AUlqFk5y
	 rPWX7FJXRgw6MzqCwaTegkrnmt8ZjD+O1Pw9PoHZ58iS8qu+NSSX47rzD3r2D45z4imVS
	 NTP7AJ3SqNABx2tqe4xA22SL9kk0d27ECsevu43Tjwp3ZjwsxuIfDTf5jqd5/+Ro8B4/M
	 jUS0btHUNiXeCE66smN1F6pLyp468bFPfeSxzPUaO17RTnHIVBJCGKluACi84FISdXHPE
	 kczc/6a5zLnlkBOE6E1IVd4xii4aLSMbRrMiYxpSn/q+s7e5vLxIsrjM8rs/jE6BZeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793588695;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WqGFJtnPAf8uvsYrIjIcM50WgWNVHEpg3v1yHVX4Hco=;
	b=DY4JQZzdl6e9DhQgvqGrc1+UdBse9z3E4zgfwbDxU6EA94bvWpEXRfX9sobXdTrhvHKo
	 PhleDFNortche5nOYwEgT2tbIpKxpgF5GA3m4l2GHfieWOKTyJQr4uVzVTL5IXqOe1y+b
	 Or705W2+No3DWxC4aGvxZHIp3hUOABhtOIOxpqlph9KwPq424/gAyWVDNai1+iAvyxw9u
	 N5qdx994l3qCilZelOlmHucaZXz4w/0grkoCHIFTjGK1nm1bO4PSHavlSU0XxTHwIGUPL
	 NWMq7UdKwBfgp017SMIHFHBL+5Fqd0VPZJxWQL45eo6AjdZ3yFlRc9FhK8gKDI+6sWw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793588695;
	bh=WqGFJtnPAf8uvsYrIjIcM50WgWNVHEpg3v1yHVX4Hco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B1c3f20cjcD4Rle4Xx8IloyRgA45yvKQiFNVJtGD/G6T+ZzZuPC3ylwf5nLtDhany
	 lyn4jCYwwE5SUGh40UCDBlSc4I0CGtx+kFoy+0aCZ0id43nFmZEk/0Oc8+iraS8+Yu
	 J+9P/MnHhPVtoGSZfbZ34RRsuWD79+UxQjW2sQdw70dxfJWXtdoTdJux3vc5FTU4ZA
	 +NjoGQ8yTvaibH79pMJ12bRekziPFhbUtlR2TX9pP4CICgl3VJbNoeF1xnQ20/0M6J
	 uAT2S/M3MPxCSIfq5Lk0aLgtT7S0lz7fHRP44MuunxnabYcMoViQr7p0XYv5uhmR4b
	 pgXVdvpYpacFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BEA860684;
	Mon,  2 Nov 2026 03:04:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2B6D435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B071C4005F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gBt1wgdu2j3l for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 03:04:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2928840042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793588693;
 b=PTLaof9V3ScA1/uSxRfjEK2R0MRO+hnK0SIgs+wjJkNeuPrOWBCT3aSPQpoSOkRgWhZg
 cwJ7qQo1aOxO0Rm6ZRMMDy7MgLLzNRumSqBCfN71LHFtREQl1ZZ3kt8qEN9P+S3F10xhc
 ffab21fvVzaojVnZPJdp+jI9fHMUeXil7QCI28oBu9hTUmnd9Jd1WxW26HJl6OSzoSZEr
 7JlSjYJRsOUovzh2GALmoUDhhjge0BSQpwO+m5F5MahTpGDXJ2aQBxk+qJFrB1er96hF3
 4NR0jCcgP0Ji6KMADC8EV0WqSYqAQ3Dbri2w2TPrnIuzMQNy0leoJpp8ESjnv9UrpTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793588693;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=WqGFJtnPAf8uvsYrIjIcM50WgWNVHEpg3v1yHVX4Hco=;
 b=qddDBISxSJEAUza432y+D6FZE4kyEtkF5SVPmu0OmZJxInhoi70Ane+E9W/HtsV6dJjW
 U2bC2wAD8BagRVKCHaznPsUCq4k2nmUA79Q+BBqV9wxk277Oe+5zsqL4Ykl5sCB7w1wyG
 T34x1YZMw4UtYDhvV+nsEhVFuxG6/2Gum3BquhfaPJtjK1V8H76N56UF5QN21hYJiwtJf
 AZefWxPLPjRKYqVsF5lZiCYy6wqgB4PfBzvOoP1edExR46+xMEeNDyYYXmm4crlI+dSVW
 dgko5TGZrzTssnWknZ9M8nQax/LZcuDbpIk9RmzNGrlTz0bgvt8CumPziJw8TpW3rAg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Kg1P3IWG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Kg1P3IWG
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2928840042
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:52 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3acdcfa2bd3so1949064a91.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 19:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793588692; x=1794193492;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WqGFJtnPAf8uvsYrIjIcM50WgWNVHEpg3v1yHVX4Hco=;
 b=Kg1P3IWGLaHQcg7XS6gtZSpEnlKyi9ZkeL743GOJnpiZ4bNDQiPUwUAPz1K7esMaUP
 1e0EIcEHD4gbqzyx0LEE/WGHSLKCXL72Mv6Ncu6bqpEHHD2HXKLRovXnSiY3EmpfkMrv
 F3YKIZvteHyVnPqt79jtc8dEWh1M/TtLpgXXXajdObo+qF455Pdu4Ny4sMlv3PDZqWlE
 t/M7jXanl4idfdXHun0XAyPJg4eRUxpHyVK5GkeIc2BXlZ/9QVazClBKx41oFNhpR5eo
 d+5SnZdemihNicyXQHj8GHRO7j9yZuArJZ0yCH+e7R8/glQfuPdAd2BbJfKxAXblrheR
 A57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793588692; x=1794193492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WqGFJtnPAf8uvsYrIjIcM50WgWNVHEpg3v1yHVX4Hco=;
 b=Xm8GHAuLM7e1QIORMQERp3RmbzMj/TVkERC5CiomD+IqF5ldUDy4fw8RAWMw7PUChp
 YcIgguEPR08y/B57mdxuJ7dRiushO7zjCcOHJW9VGgOiSfjy3tg+woEzXjgOmgRoP4AI
 rXUYV298+VbxAeJRU7W9+HpMb92fQVcUaXacoljnL8Jt8IU8eQwCaPzcZL2EGKBXcV+3
 OQPD9ZvjPN7vcGCHToTeOwTLiMP4iR5aFmdt8wmTDvBS7yP4DO4NV5gXQKmrUVLoYjBp
 xA0ZaO1kxRdYDQ04B5uqxebvHVqSqW508azt4vv06EAOCsN7xKBi6hgPonnG1i1OPb9b
 NR+w==
X-Gm-Message-State: APuU4Z9hnIjeJ2ZkCx/Yd+mBOmFAzGOo6jRjPRmyjHxqFD2qM+ksyHVH
 PYQSuarPfiWkaxy2eg79KRrW1gOwmq/vxv01EmHoOegsw3mh0T/csmU6GqzUho38
X-Gm-Gg: AYBFou03pCiL2eBP8STwmHxbY+yzz0PrTvIk62FFXi6II8g302mK53EHSGMZk3E9ujq
 dVjwxBdiAFXwAQEOTzAXntvq/2kadI1XcFMdvwurr/YsWAgJ9LXou5KyHaI/9iTaFXq0RVIZy6k
 0zoxDSY45LZYu0h6BqO1xxsMw6DnQrODXT84+GLK59VM5Q8Z9ul4rdND0KJ/Dnq70FthWq0WTUD
 7mRC1VW6x4h2wIY6nmgCzBgSDygJvL3vlJqFxLGnZTqySebGgQE9o+d1RBAqakFkRJFIoNqI63L
 xC4arXmh2HruEhfAsUkST4HTb81kVBReUCVS0sB6Pdq/hX2vKj4gjM2KMIZ5oVTxXM8Ll0aRRTX
 EmJPedDaeHV6SX+biRlvVAULjTRDsH0RZUZ5BecErUjKDwtWQqf4pckpoJ0MAVC0Ts/98sQR61F
 cEHAEDu11PfsTe2tbapo/4eiZMPzyM88rc1AkwqRwMcipL5EdMwH3wQP4wx0b7U5YqWfc/11bW4
 11xcKTUclW+C84G4zIPnWWThcgIuOu6PUkH1lQwG4DOlbZgGF1SF7dHDjzVyEWrqQ1z+GTeNkAj
 +9UOC/2aVAFITb2wqDwJd2kcTY1x5jGd6v55TCPfv7t36PTsfamN/8g3iHxgLFTgsEshc+qrAdS
 ix3SkC7RKPHGi9iMe78XSCcqvQdUQ+dj0Bkf+8IikDuat3UqSdEYhEUOw3KaBnq46d2HqIcvZP5
 5zAQSDXMJS
X-Received: by 2002:a17:90b:5111:b0:39e:6d82:dca with SMTP id
 98e67ed59e1d1-3ae897f5b58mr6612885a91.30.1793588692243; 
 Sun, 01 Nov 2026 19:04:52 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845432e4sm11995159a91.3.2026.11.01.19.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 19:04:52 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de,
 Bin Meng <bin.meng@processmission.com>
Subject: [PATCH v6 3/6] MAINTAINERS: Add entry for virtio RTC
Date: Mon,  2 Nov 2026 11:04:39 +0800
Message-ID: <f2c16678f604a8b5f1501247a412bb94c0fd369d.1793588058.git.alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793588058.git.alan.tseng.cs@gmail.com>
References: <cover.1793588058.git.alan.tseng.cs@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add myself as the maintainer of the virtio RTC driver.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index af3ca0f1b..b82b91494 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1887,6 +1887,11 @@ F:	include/virtio*.h
 F:	test/dm/virtio*.c
 F:	doc/develop/driver-model/virtio.rst
 
+VIRTIO RTC
+M:	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+S:	Maintained
+F:	drivers/virtio/virtio_rtc.c
+
 WATCHDOG
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-- 
2.43.0

