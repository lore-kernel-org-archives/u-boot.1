Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4044606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0yYv8zGK;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UtwePtY3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EA2680E38;
	Mon, 23 Nov 2026 20:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mKBZj_uFnYEe; Mon, 23 Nov 2026 20:57:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2A9880DC5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795467458;
	b=QMwyTkxtzW6uHzDA3UlmT+k9An1sYXDJzILt1PFpqOnqQCaUkCtU2P8Qbx4mznTQSQAH
	 IsSHJsKQySXLIfOCxK1/T7f6GF7KgYZXJuMbURI6/Ldk1gD3OG4B3i2Y43/V7TTiBSSUc
	 FxVr2d5jRety7LxZn4LYGs+/yuxQJfWz9Ee1JDGDtDEQWwi182NixjfDD3pfhVnazuhwR
	 q+mmvRZQ46dXhIQy9XlNA625caAByOUZl/P7YbuY27T1GRJikJ0npzCVpSwa2bJ7vwj2p
	 D7cxQ5/wFsCcuyKYcNygazV1AAePY/H/+qMTn8CTNwnq6WfJq+ERT4yD2slxHRzHp7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795467458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/ENkpUltrY3OWYP91KGXEyyA1P2YDUgX5TkWQtMR+2s=;
	b=pNlY5lk0NAGJwGH70XK2JQTT7GvUCj9G2I5PYA6tSIGDp10qaVHMkjj6VrKPFo545G0t
	 M75C7mW7y5iaAjFMACPfFgdkZ0U/XuwDZRMggJYT2yVwefLnDpQ6Hh1TeiYwxd8clVrSq
	 NgeS4DH+AhG7me8/h/S0+z/+bwAXQr+0+D+qka7xSgq7r4zfsyNk8N5DSPc3hB8TzGS2a
	 WmXtR1wB2pBhdwSsvMy+dL+SPT5jMO0kdFz5IkMPrYofw+zcqbRRJDezO4imLlvpHCefH
	 2YIXjFFohg9pqoEiNXQMKd6P/AgqGQksc2EpWBNsGooAkcOZsuJCvmHw6tL3fvMRkxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795467458;
	bh=/ENkpUltrY3OWYP91KGXEyyA1P2YDUgX5TkWQtMR+2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0yYv8zGKzZrVp7zQnI6qImAYnrhYURz4saxmqh8KRyjxmpekyqeElnjLgT6EB2WVp
	 nxCVKFD2YUibjssFv2/PxVs9ORwJc1Jbv4iXH3vut5baodu9M8G9JdTN167MI4c0I5
	 vKMC+A35KjPxD+06vsLak7ucE2HKKWiryCM787e6ZwwQNw4YKXFOhAecRGaoz/PMFU
	 8RgulK3oBeg/0ouR/zX6l616KVsMzThvqSm0wMvgD626BTWUT3Iap0Md1lPfl8nrqU
	 Mbu5MtWceBIM97+GbO6JsCzGydkWoLInwTko0W/+XeuK+PtaWaeIvd9n9bCfJtwuMu
	 nPLouXi2IXfRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2A9880DC5;
	Mon, 23 Nov 2026 20:57:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 97B3922B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 899106067E
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:57:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bzQijMq7sPne for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 20:57:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCA2E605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UtwePtY3
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCA2E605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:57:32 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4b0348a4c79so2655340fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795467451; x=1796072251;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ENkpUltrY3OWYP91KGXEyyA1P2YDUgX5TkWQtMR+2s=;
 b=UtwePtY3QHbyRo28W7u1q4zdIQY3TuCvC7ZQm4VaLPopJmCKUm2Tclomc9nDXA1SmY
 iQ+NW7Ov79XdEZETyGOqZCCQEiA/MYWg/MPQw8mIKmgQ2YmwSh5WyqA1tSZfNvd60rJJ
 wt3v4TSRZX8Zyy2Mm+wcRg59wZOlPBOa3M0Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795467451; x=1796072251;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ENkpUltrY3OWYP91KGXEyyA1P2YDUgX5TkWQtMR+2s=;
 b=lY4yaLFNWfvOOqo+n97mWL1nLH5IXzhQ05gkYnlugi6NEfGYbB6D0fmEGgHIMGIpTn
 c2Kj2dDgTDTLZhEG8s0MQoZU+IzuhdX1HYXvqk9uDNo+4T+/uqOEHWvC034Nd3Q+MtbC
 uDc9JZfm86YxAkF5KkMelfNLPVnVGuDfOEUHNFeTS7InHXHdHRfq4748O/+n6p5W1MEX
 S3xlX/48869B2a43CZISpWffQtBvkBO96rqqpOhVWxIcmFJP2y8zKSMpnjmbfjng3WMN
 uTd4/unT2smc/m9qwuqRUBxvc6VEQ/jED7yFs/GY3xWA19dgOuImCcoJTMcC50ftX6DF
 LdEQ==
X-Gm-Message-State: APuU4Z8hjm02RDtLII81pTUzBU5SLhoxd3w6XCxJ1b1ZKPSzezLYod9M
 QbwWZZ0Jjqr2pcrfvHgyQDMFdNybV2Tqgkn53eujrsgEDlr74IS2+WHfwBNjjnGTfA6uMH8fA4q
 p6vv67kO1085V
X-Gm-Gg: AZFdTZcUQytmuTV+GCQgIqQGGVcAOHTf54IDa9jLxAYgKD9wOyf8LSnFARgx1V1HzJn
 879GmkpUL6aFA7Tvn/IxO6q4iBoHjYtRCQD+B/oALymR7eXIUkBy96ucH6ZYghfjREr+fHPdD/U
 wqtD0YIcQQZBLroTzjo6funHCFdbn6NoY1WMAElDD0c54V02i6EAjF+JS9Oc+bkCssxpjafLLVj
 hmryc/Ti9z7GxDCh+hYrrpmqMLvDXA2YALsr0Vy9rUEtQKFyAQIE7V2ljKpPY85QbtaZPZf7hND
 k7RoJkySUinxzInt2QX9KUwrStj5M2nrr2qmm8Asj2oDrjy29LzW4l8z/YimZh3wYPM0pPl1JWF
 vxbVB0hkSEV2QHUIV0OPNVa+fF1872JG0tN8N+7WoMNokTClBSJ7TLMm5w7wa+rHp8TlA44BsSZ
 VDVeVis5oY1oKv4rGsrhuXJ7m/ePyQYIS6cIANcDjUVZjI2SNpPjy/EeJwRqVPB9gbrbQuBYckI
 pnM1uqTY4v+2Q5ImorIwg57TyQJFwEzE1f2//9IJtPXQC5D18x7n7GZbKt65UFe8UVLcW9jRP9D
 zxfKWVxbMgUGLg9QvQ5BUlF7+S5TGflq4vUA09et9lHTonIwcfiYncUZxzRRnlmnJx35Y3zW81y
 Wa67xF3vmCouGeJXj8uoTxwv6z1rExU+CyWYyIeKghEjPbWiPRAf7F6+oY4VkorgnVxq1ywUnYo
 38CHQpgnntg+mkiI0Hhomg89/PBzbF5Q==
X-Received: by 2002:a05:6870:46a5:b0:494:ad56:c418 with SMTP id
 586e51a60fabf-4bc84f1cf62mr11329417fac.50.1795467451551; 
 Mon, 23 Nov 2026 12:57:31 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5ebdbb4fsm11151928fac.5.2026.11.23.12.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 12:57:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@nabladev.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
In-Reply-To: <xhkdb33sru3y8.fsf@mkorpers-koolstof.csb>
References: <xhkdb33sru3y8.fsf@mkorpers-koolstof.csb>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20261123 into next
Message-Id: <179546745061.3478803.7145017951086799765.b4-ty@konsulko.com>
Date: Mon, 23 Nov 2026 14:57:30 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 13:28:47 +0100, Mattijs Korpershoek wrote:

> Please find the following PR for next:
> 
> Android:
> * Add support for init_boot partition in bootmeth_android
> 
> Fastboot:
> * Use $fastboot_addr_r as default buffer address when set
> * Invalidate stale/incomplete downloads on new sessions
> * Don't fastboot boot when an ACK failed
> * Support fastboot boot <fitImage> in spl
> * Support legacy U-Boot images in fastboot spl
> * Support raw U-Boot images in fastboot spl
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


