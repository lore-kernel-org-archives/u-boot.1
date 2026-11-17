Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA475606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YG7vHSMi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qdo0KctZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85F68811A5;
	Tue, 17 Nov 2026 19:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bW1ET5-M_6bS; Tue, 17 Nov 2026 19:49:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E6ADD81196
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794944991;
	b=JElfBOsx2zgPHwsLV1W0K1dIc5n0yi+g14kcCKiEEpRiU4oc0MZhIeVJwsaH50Hro8Me
	 bL3LtMBupUD5UPhNXcHRMLPjSe6XjIo0mUMUlIjEBYwoTpZV4TBcfJsVA5XPMJJBrO6uQ
	 ssOaYYCZ3FPl/gC09RjdLRnLoa7HwJuO8W4rjo94GyEnBcSX3fRMC2/JPv6iVQ4MPpNVB
	 Hq6uRfHHc9rqFYbmb8ebHNdlu45RC0pOnW34d1zRfkutX4+Wk/YoneKgYw0SaYOzOvnH+
	 hc7yYRfllCo7vB/8XJ0D2WTqURZb+523bvXmXyFOpoPMIoFhYzf40JTB5yUaqqb1wSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794944991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vIgGqj114JyT7EA+ub5A6O/BYjs8QMpN90T/+m+lQes=;
	b=UhX5E0Ym4j51Uzj8a0RkI2Ex/3+DP/oVW1ylWQyQs5yZHyUXuJMFdgl5RS3sOvjLbb5B
	 2/0mYhxg/vtZbL1iGqowvfwM90bqIzifjib8+C8eVHt007811anWffVx9ST4jJ3c9KWec
	 o7NJf7z0RBC+KJGfAKYjcyizpHu0FKdoIMLfLN0YaokyTHUxZ6Ck2qCTS2Bsg8UIHDdpi
	 XzYUihN+FqtlizdHWFJLCN1PeCG6atzJdro0poyjbfBcCZY5Zf1doxmNL4IA64+nvVAaN
	 QkkNORK8i9LIclVVRNmzWEGcYNdNqMH+e+alY+GxvI/VhHHUpB0KTLI+V4WmAlJNG2A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794944991;
	bh=vIgGqj114JyT7EA+ub5A6O/BYjs8QMpN90T/+m+lQes=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YG7vHSMi2kXkHwPoIw7/6NNMxo0gfZQRS0BKq2Z0VfbQjJbCJjc0mXvbRYYCJ26/b
	 wCFfDX1ScaWNu8XAAzE3UAOClBjE9y7BTDlNHg1hqGCrHpl8QYJB9NLSQijr6EVKgn
	 p+dGBJSg+BECGEVKo5o8WVEzjAR8k6LbfNCwEVhPe1fWy5F9IkQ4HnF4N1M5uQEPz7
	 ThlTWhmDGUv/Z6IpaRE+1HY7rvZbLpbpg280YgqbvshjdoAKeMCo6hY4fALfTUHzbr
	 pOCfgdHiF4XMaKwjB4LqnyA9vZLA/mpA0bYNvLNewn7YVYsD9rmXQAUAzFz09aK11q
	 wAkm6u/dxSjlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6ADD81196;
	Tue, 17 Nov 2026 19:49:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC3451A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 19:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2963401DC
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 19:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_qrFQnO_P13 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 19:49:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2370D4005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=ehristev@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Qdo0KctZ
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2370D4005D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 19:49:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A4FE4074B;
 Tue, 17 Nov 2026 19:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4C91F000C4;
 Tue, 17 Nov 2026 19:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944987;
 bh=vIgGqj114JyT7EA+ub5A6O/BYjs8QMpN90T/+m+lQes=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Qdo0KctZ7yhXmnkorb3YYnEBLMFj9/gCAUZlcX81U66pqvvq1EW5AO+UUL0fDG7zj
 4+DmJ2cCOZzwYivKqkEPko2bNe9UKnU5rnoIq7eWQdDpCC0nRIPdQQKPV5X9OQ4R6P
 wpL+xUt6lUn8yQxieu/8iBsB1mjyU42ueJckeqR7JLdZnncga5X2AYs9CRrsq9Jc56
 NvD2x2E1fVyCUn3zjAOOFRVUFY5WnsGgpuRXM8qNi4mn1pRpDMTfpTxJnj/af+ANmD
 m2d2rCEsAmBwsIVcbVjEHGH11VPO9yzMW0suhAzvOEv4ZK6OuYKOeMHnyzzkBB5IWo
 Enl9KVaGF/70w==
Message-ID: <cc075ecd-efc9-4b9a-b0b4-6116993a905c@kernel.org>
Date: Tue, 17 Nov 2026 21:49:39 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] clk: at91: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
 <20261116173546.3487841-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20261116173546.3487841-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 19:34, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Eugen Hristev <ehristev@kernel.org>
> Cc: Lukasz Majewski <lukma@nabladev.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
Acked-by: Eugen Hristev <ehristev@kernel.org>
