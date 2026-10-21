Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4A606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HlHUdCfm;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=fk1iiRfg;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=znGy55jl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A5DD810E0;
	Wed, 21 Oct 2026 10:26:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MniinWP9Vo1R; Wed, 21 Oct 2026 10:26:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8120F810C3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792578408;
	b=KUKzteNQnE/vWQeMDuLB9BCHI9yAX02gtlQapC9QW/1FMfurhuxoxqAHg21poY4OtpRT
	 UARA0Cpq2ddxgALnDvJUMzvH6VpwBg1KzO1fcGxQj8NP80jjTbt64ZfdBE3yprOYt6LXx
	 U+D/MEz2GI1jQ0uRV+M/J75W5hVVo5NhvHriphG6djUHeJrwRWQYaE4n2vjBRWrLFie/t
	 lVN9P/Vy7pICb/Go6WRtO5hEIWNp1tlpUKelA/qXXcnxbBnunBh3IPypLo1QvsONNOAtc
	 w8kRIvCE0WInpLyocFg8oClLJ8UL63wL2dv0jo6SRH7zxtV5uusR5hDmlcKDtQWZgRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792578408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+ciMhqw9NgEwHQq+15uXS52cF2Rrmq/TYohcJYiycfY=;
	b=XkiiydZ25ZYszLQIlFMaeDdgjU2gvtx573ijdJUFawiyNX7E9erpqAIDIN1c0ryCXkg+
	 IUP+SGqm5ysBT7Igwgf+iiasQq6K86JgCJNP1x1KWOWSeqGwBVwvreQgkr+Zy6SKu0hwx
	 IukqeZPXxv+SS0/s4p1nF3GKXKtEALSUFsnUJD5fmw1E1CLjglz/BZQje3qaJwXq1A1/b
	 wBada69HAiNW8bZHFhihkD27K6S6ovR4P/kyxwabXaS24s9rgzRO79unq5hpsQm8ly8yc
	 ehMydSXMPkKASJTCHMiI2D8hGRbR77qc+A60g0MBeMFSrFqXfM3AKOhcJ4LhE7Ipe3A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=fk1iiRfg;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=znGy55jl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792578408;
	bh=+ciMhqw9NgEwHQq+15uXS52cF2Rrmq/TYohcJYiycfY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HlHUdCfmj+o7kR6CU8cZ7yK6TSQ/H0vnXXNnEWcpzVwBDE4KBpz+DeBWuGwtpXqs3
	 +vA2zf2MN1XCDXFI+g8v2jZjS5xN0up8/sleI6U5XX1lOmPGP6TvokTN8uBASvc57y
	 zR/5w+nxOvLEWTdsZOw7EElulwSO8n+xfpP+Kx3ISMpJjTVMj9yMgVVxc9eny7YTow
	 9QY7yvtIJ/xcJ7fsNCVGN3giCH0a/CdzfbQ6NYyq6VmpwRpYXm1YWS6utUIeQuC6eg
	 WzUo/7rnZ8wWD6MCcwWgUZW96EugUeaU8HLKRFDTxj6TFGhnoWTya79Xx8MaruZz1E
	 1sKue5aKnbj7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8120F810C3;
	Wed, 21 Oct 2026 10:26:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 37B6C1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3596480D9C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y-KTCVkThSDF for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 10:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9A1C180F56
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792578398;
 b=TGyODEOpkbpAAMsOrrKfyPQe0jhMnZ8jj6QqczK9lLSIJ2i92oFoIZMVQR8fpLtB8mq7
 Bx9NtCRfdrpK18erCAFNHTYe1yjio6KaaSgIexiK0FfXOM5+xl00lPOO68fL0zGaQ8Lv2
 B/lnbDtViwYtwn410xx4ViHELwboalGv3q/oYldnHVdE/wvYi9U08ubsXv0ra9RgTI5zC
 FftYps3+WelTwgZqS66GYxjmDfuYaw+O8BYTJ84PNrJ3pQUAPaqjhKPNQVYpQ8e0uBO5D
 qu4VcEqx3+ntaMDdmyHXpzt0L87XNgGzB0A+RF+1ITKh1dy31FFQHpTAJZtlgWWq01g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792578398;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=+ciMhqw9NgEwHQq+15uXS52cF2Rrmq/TYohcJYiycfY=;
 b=GGPOVMxBB20hRSFTik5hq7NdsTyrpTRPTgHWB74nVSWzADz0xDpSnrPYN2gj5ar2yuDM
 8twRat+p4BzPlWJfVN79ZeO9T/IRAEoN42m/DJODEZilvOT8w6aeJ6dq+zhk7pUAkP5ym
 aA7q5gvATTBIhWHCCGdtlcdxKxh56xMtFTMOCI0vAIh7fh2/gtTcCwEn/f7KD9bNGIZkf
 4T2QOuMe4ORImEIoCuYrWCx/3R4CjNkl+hBBNNwqakThyfQROgasbylra7OPpANg5MRvG
 Knrc7x5ebMcvkVgyCnFYd6hPqQnIaP0wy09SbnROM5VmVPeiYEToSR6qo+Vga7U51CQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=fk1iiRfg; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=znGy55jl; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=fk1iiRfg; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=znGy55jl
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A1C180F56
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792578388;
 x=1793183188; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=+ciMhqw9NgEwHQq+15uXS52cF2Rrmq/TYohcJYiycfY=;
 b=fk1iiRfgnokXIZYsM75dmTQ7169nLQQar/BawGHD8RZCz3Sc2ZdLma8vx4M6Y+kc2eyLAhQkH+p+r
 1qkkJ2+rN20AdduIdsXGRQybTCfKjDFzyj0gDaPPtK0LQsT7xGsndX3uCW+a2ri8QxiCkDT4W65gZe
 K2I0E0cv+eMGYUkx+BiREGcBykN2KiqKtFusG7tFBhwAX4qYnaPPCkBzbEeZVkcK8dpeMOU2yniI7O
 QFdGfYq7RqxOmXR/1DnsJjcmFek78x7pjEHzFjwD9Fovou3q8LPZjIo3OT3Dpsy5HftCUbjhd1Ol2J
 lvTZ9uos+UgjZrNKCw/PVcgGClyoT+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792578388;
 x=1793183188; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=+ciMhqw9NgEwHQq+15uXS52cF2Rrmq/TYohcJYiycfY=;
 b=znGy55jlRKrF4v1CuXxVYLUgyI7CvD+QPZuUW6boAIh+9L8pXIvV6t4IXpI48Wy+ns6T7082AC84h
 G6INRa7Dg==
X-HalOne-ID: df989a66-cd39-11f1-8909-33fc7c51c1c8
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-7f8e-6877-ce5b-5167.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:7f8e:6877:ce5b:5167])
 by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id df989a66-cd39-11f1-8909-33fc7c51c1c8;
 Wed, 21 Oct 2026 10:26:28 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>, E Shattow <e@freeshell.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/5] tools: Accept .key and .pem private keys for FIT signing
Date: Wed, 21 Oct 2026 12:26:21 +0200
Message-ID: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mkimage -k uses .key files for RSA and .pem files for ECDSA even though
both contain PEM-encoded private keys.

This series accepts both suffixes while keeping the existing preference:
RSA tries .key first and ECDSA tries .pem first. The alternate suffix is
tried only when the preferred file does not exist.

File-open errors are preserved so only missing keys are skipped. The
series also removes outdated ECDSA comments and documents the lookup order.

Ayoub Zaki (5):
  tools: Preserve FIT signing key file-open errors
  lib: ecdsa: Remove outdated key lookup comments
  lib: ecdsa: Accept .key private key files as a fallback
  lib: rsa: Accept .pem private key files as a fallback
  doc: fit: Document private key filename fallbacks

 doc/mkimage.1               |  3 +++
 doc/usage/fit/signature.rst |  7 ++++---
 lib/ecdsa/ecdsa-libcrypto.c | 26 ++++++++++++++++----------
 lib/rsa/rsa-sign.c          | 15 +++++++++++----
 4 files changed, 34 insertions(+), 17 deletions(-)

-- 
2.53.0

