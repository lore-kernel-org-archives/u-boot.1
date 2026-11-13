Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6134606A330
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JUji7Xad;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXy4Q5yU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F8FA60DEA;
	Fri, 13 Nov 2026 23:50:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m7hTuv6ggbMg; Fri, 13 Nov 2026 23:50:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53B1560D91
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794613815;
	b=afwx49OoPcy1kCNs79+gmLCr9B+4EkM/TQLYj8VLHa/zySc9jANToQiqV4krgloI9Kup
	 OGhsHJ5OId/47RFmzi/6FHaweDN8IfOXWnwZZCY5C9T2YGSfojPLIMzWKqiIJc8bd9ESZ
	 GpUBR8x78+oudmzMrmI2BcRz1pp/Ka0xLVKX8xWgKBUOlW6txx0Onnd6BDn236nGu8/CD
	 DhkP8w0P74AL+Aux52kNhXmr1OTyFjnaCWUJPdij7yil2ZjTkQWVXs0dwcAUiPNg38xlN
	 ZKZcItng9sNaEX2suTLsPsQ+Y94Tt3PgJ7VBe6PY7ohPCmjb+JGJSDkPWEMalj2bOrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794613815;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HNigoe5ZQQnD9jJfIosz9mp56zio9SMy4Rns/5DLVNg=;
	b=DAfuvoETQzp7139+uK3Hn0gkQB1FLQCr3LXAjOiN+v9Opem7TGzr0GRwLkcNINOROXqn
	 9sUYaroBAQ7ybMlfxlu6B3UDG7x1iNNRLxzwfZ7a+I1ooIq7ztvgPJCTyxW+vFl3L+Y55
	 Yr78wESAh0pjyouahqa31p4hctIQ7xmlxqZ7LoZFpQBLP42EwaCULIvBOAmBB52IuKIpE
	 q7HhcXVP9S4boT2xnzCDWGJpJ/pO3DAbDVfdeDYiy6g9AxJLndnma9flwUjJFyBawlnJ4
	 wrZXKkZTm9LZDohmt7J3MWA8+bpsxOIz33x+ZAzWrbieHZh3tmjRkJTd4tGPK5Svatg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794613815;
	bh=HNigoe5ZQQnD9jJfIosz9mp56zio9SMy4Rns/5DLVNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JUji7Xad8V2fWYra8KOTUroDPDV/QnzULOlZ1QlLkOe18A4P7eWYStAkli+MA5Dqd
	 WylOc9L8slXhEsBRgdsfXtN7eRN9wCCID9oakLBVP7MWvoA3Znja8+daaVz2oqJnXS
	 peOaAIFSLTXT/xLMkKZXcI5XjNN1FGYx+ScSPHS4DWAV/GUNloTLXNIn6kkqcsiRdq
	 Cy6Qxzs1JhXKnufgz8FLrrZFYCE7kzzPARy5ErOxjmtQPShnvF09B3teBNPTZqYZJg
	 ePbSeNF4hT73kG/LbeUAg3B8JER6JhqNpq10PboF3tZirShT+/SQyA/BvcjdVVVf7t
	 KOVGNSrq6V6ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53B1560D91;
	Fri, 13 Nov 2026 23:50:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0223D1E7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E305681801
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:50:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VZInfoWwrPRU for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 23:50:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 20FCF817F2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=YXy4Q5yU
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20FCF817F2
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:50:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F73744726;
 Fri, 13 Nov 2026 23:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426541F000C4;
 Fri, 13 Nov 2026 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794613812;
 bh=HNigoe5ZQQnD9jJfIosz9mp56zio9SMy4Rns/5DLVNg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YXy4Q5yUhVs4WBBk1kD2IUmd4cvsq4eL/sxr2XR0dLX5jm1dH+mAkP3jsiMkOF2pj
 /IKw1GhIrS7key+MHE3FVn7qqw3TyqsLwekoDB5f7+YSLqnVU/Vj2TF1MceFFEa5PO
 fmWQJ8ZRF7LExPQNiSQk8kS5jbX2QT5cbjcu1c3nO4WD0Uhe6Dltc/DjsZ8IeykeWG
 D3nbXNaaqFZHC3KDy24uSJZx+VF1XRNDUwddZ2oEz8QtaxOOlo6sRn3PBhTyVT9zXZ
 f0cN095EIxh0yap6e/0Nok7PB3Kj+dWwDTPm9Ofqt18y6WEVLCGRkNHE7nIoWx2tbd
 RP3h5yyiYxotw==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Yixun Lan <dlan@kernel.org>
Cc: Yao Zi <me@ziyao.cc>, Eric Chung <eric.chung@riscstar.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>
Subject: Re: [PATCH] spacemit: k1: fix SD Card Detection for MusePi Pro
Date: Fri, 13 Nov 2026 23:50:07 +0000
Message-ID: <179461199570.267836.2577890610236802366.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111-02-k1-sdcard-fix-cd-v1-1-08f89230a13c@kernel.org>
References: <20261111-02-k1-sdcard-fix-cd-v1-1-08f89230a13c@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 11 Nov 2026 10:49:55 +0000, Yixun Lan wrote:
> Previously, on the MusePi Pro board, reading the value from the
> SD Card Dectect pin always returned 0, and cd-gpio is overrided
> in dts as active low, causing the system to always treat the SD
> Card exist regardless of whether it was actually inserted or not.
> 
> With GPIO bias patch[1], the GPIO_PULL_UP flag can be passed down
> at the Card Dectect pin request through "cd-gpios" property. So with
> correct pull up settings, the SD card CD pin is just work fine, no
> need to override the DT property, so use the default from dts upstream.
> 
> [...]

Applied, thanks! Queued in SpacemiT custodian tree, for-main branch

[1/1] spacemit: k1: fix SD Card Detection for MusePi Pro
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/e7cc804442a675cdf24b2ff56835212c7ed5bbca

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
