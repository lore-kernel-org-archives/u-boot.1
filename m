Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C2606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 05:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sbZi+Auh;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Xk/zxK8m
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B720C809EC;
	Wed,  4 Nov 2026 05:09:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 586Nm_AXuAV5; Wed,  4 Nov 2026 05:09:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 025DD80A82
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793768990;
	b=HWA7hGdgBdmU0RBZO4ckzSHFYkhi3eVpgEDXqzL6ysHB4iHpgHlJUSgOE7prrVQ6hfO0
	 K44tUIG9VVwcDinKORMDGCy1x0GS/5Cri8XPSfEy23tEWNS/Hp/KYkp5xbETIsScNvR9X
	 3zWPPwWSzlh2CccnpX6fjahlIye8Z2rReZ4Hut/OkkaSmsNGpYqK7c9CnpfpZT0fdAenK
	 VM34m4a64O0+wM8Wm34gjdiqIGOjK0BXthMyZa0GLHkfWO1xnKvTKaPbKY0kYgQkR4F7J
	 BtT+AB8VOeK06c8NU7aUyOprQgwNAJMm/CnN2zsC3BYvCrT10Rvl8aTyBRO5GdTQj3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793768990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w/KaDUP1hIPErtIW+8vmjXQFhyPoBLDQl8jU+s15Lgc=;
	b=LoHG5xYCs9WAwy8m5oPbwZq3yYuIKzTzZi3IwDP8rOkjZqAiwUKxxKRfETEzheEfdyKI
	 s2JcqDU0/YHF3f0a0bomnFMSjSUsomLJCKaB9yu8I5jg6M8gq1VG9oRfja6fQp5LRTxwY
	 iFVFdfH8iRIx7OhM1W433/UCZ/xlZPe4jchRqiMiGDCIJvjNPWrwmIFyp7woMiuThLtTt
	 bodc7tnwuMleFNogwLBqUc/NI3KNbRdxrQbDAQ1IGBVouBrqUGWXroBMRNKLZUesIuupx
	 Pre8K4xkwUusXkAwVKDeRe1CmlZtvObY9weOOHBeXXMv/sGFnoF8TUTlc242Hct8pcA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="Xk/zxK8m";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793768990;
	bh=w/KaDUP1hIPErtIW+8vmjXQFhyPoBLDQl8jU+s15Lgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sbZi+Auhm0a9fX2FKf1LWGtP8gOPMn+kxLqh6QW1tjdRQHUm6eEbq6IvqyZoNEt+P
	 yPpX60Onwpw/ZWsblSUJ2gfcS9cOGSVAxgDv8PcUWymeJAt6buraEzyPrvY7kcUEUs
	 +E4fTQsXNCn0IxBIusn7N4uGuJaEQhB95PvCWHsi0Bsr95rwKGi3f6J+F+SZw9PSr7
	 +IeK3m3EK+oOC76s9dZuU1Sj16Us+2gBSQhmGsYrSa0Gm8ZEUkTn19ZiN0t4jZvn/l
	 zjbHq88GVr1YGGZqcrA2mLHP36L1QPg7eWtZaBd9Un247KcT7L0Y+Q0GAZ+yNhe+RH
	 XNrazLoyP8e2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 025DD80A82;
	Wed,  4 Nov 2026 05:09:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41FD72AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27D8380A82
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:09:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JVmHKqmFs3eo for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 05:09:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4EE18809EC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793768987;
 b=nfSTBKN13NpRzeB3B8eZNgAYUF5NQSzGHMH6CRMGoyYDPLmslTH3vBAdF0UUEqbiJnVA
 P8DPncOK0GA+G0ohCmNxp9CSPzsgIyeqKj0LPDpcJj4U+TU73ZREMbnWTlHkOcQJfSQ1P
 zro7h9stI0ziQz5z7uememXxqyOH4eyYrayv32JmviGrHgYLgqKDvIGQAVKgf3Q8qKNbE
 dsrqYXVCoJAIvhqAx2oF2STVh25s6GNH9n+fFkj3gIzJaliHTqxjVXifr0UYY7OIc5t0j
 W/pgVfgmhvTHTRqwofcapxzEvGphuhEtIVTeFx3w+RC9qxELGPgiDtJTBYT/jyifx4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793768987;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=w/KaDUP1hIPErtIW+8vmjXQFhyPoBLDQl8jU+s15Lgc=;
 b=gsEx7ZM2XwWOACaODfUy8cjsuAT1EyAQ9glzf+lSdhSbVCf6ODW3fF7npW9yRufCzQG1
 jarckEKGYCcqCKBI79ayFIgcF5BBMEr0dWNWcHGU3xDITUwCk7OhQKOg1zXrKd/rR3m0r
 1yzie6q5DeE+t4U3gI2WivhMftpFYBP5iqQ5BzZAIqhyf7EnCsnonyaF/vXhOPTfHSmD1
 EujerdaZtuk5VX9XjeP7LouW7+MgJI937N1Zrw6/wDzI4zF7lQEWHgFCO/X3BLmBxT5fY
 D4AEtIXr3tO69thbvpVwHrPQuDp7gJFmdX24brYk/1/Pds3u7J/KwIRpGPPar5VxpWQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="Xk/zxK8m"; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Xk/zxK8m
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EE18809EC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:09:46 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKD5M1hwKzMlyk;
 Wed, 04 Nov 2026 06:09:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793768983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/KaDUP1hIPErtIW+8vmjXQFhyPoBLDQl8jU+s15Lgc=;
 b=Xk/zxK8mCgmQzl4YKfKyFxKv4/R0gjsKHxyf/cWoVBEX2HUQWB2xVF8ZgUqHbhBkp2W1+n
 moOLSxjFBn+tl4EdpYUOmccD2KEjoNuXvkbOgOBqNjRvvOQLH8epcQ2Tn4/B8DXYXWDHV5
 6m/BeTDbZ9gxs7pZET/VDN5mmYP46w6j7HMoJ31S5cf3t76qjyA9SEDL5W6dScjAxA5muI
 r87FAaltotZcSseRrgOplKuuVr5oMFKCF/KMgAaYY8+rePKeGXAMqYu6q9OWzBB8xIRWwT
 fzBLzqbThJAmTnrLmNkcAhtw5RIAF/NpORI0B8V1Eeyoq5QjEN05hGdr6ZTfyA==
Message-ID: <976abcd3-f947-4273-ac2a-97f7eb10f367@mailbox.org>
Date: Wed, 4 Nov 2026 06:08:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs: rcar-gen5: Enable env erase on the Ironhide
 Cortex-A U-Boot
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Aristo Chen <aristo.chen@canonical.com>
References: <20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com>
 <20261026-clegoffic-env-flash-erase-v1-3-18777abd1bde@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261026-clegoffic-env-flash-erase-v1-3-18777abd1bde@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5krntbm1cwk8adwpchpqyof1oos7wncm
X-MBO-RS-ID: 144c2167442822fdb79
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 3:41 PM, Clément Le Goffic wrote:
> Enable CONFIG_CMD_ERASEENV so that env erase drops the environment saved
> in the eMMC boot partition.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
> ---
>   configs/r8a78000_ironhide_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
> index 527d338a663a..bb11166092e1 100644
> --- a/configs/r8a78000_ironhide_defconfig
> +++ b/configs/r8a78000_ironhide_defconfig
> @@ -16,6 +16,7 @@ CONFIG_CLK_COMPOSITE_CCF=y
>   CONFIG_CLK_SCMI=y
>   CONFIG_CMD_CLK=y
>   CONFIG_CMD_ARMFFA=y
> +CONFIG_CMD_ERASEENV=y
>   CONFIG_CMD_MEMTEST=y
>   CONFIG_CMD_SCMI=y
>   CONFIG_CMD_UFS=y
This should be enabled in configs/renesas_rcar.config once , not for 
every board separately, that only leads to inconsistency.
