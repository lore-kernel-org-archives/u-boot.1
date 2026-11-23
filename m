Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1082606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jrAfi69l;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8xulyiI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AFDD80E36;
	Mon, 23 Nov 2026 19:38:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MKwQIj4TJwU7; Mon, 23 Nov 2026 19:38:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2CBF80E48
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795462679;
	b=HU1lYm0SqTgB+JDTz0bc+uhRv+PQxOIVUx+UcLalYchbg4j6SogCVQ5UG2yQDybfnz21
	 nJ7FhCTgjyA9V8jI3sXX5NpTsYPYoVP04h7KTQNVmlZl/InwNlOmKfURTTzLRzDsObWmp
	 qwgZo1LD7OIIwHuP7bVBrTGihhmjKyw43F1aMCI66uO8nekRsD4/F4zsMQSSA+X/TbGGn
	 60E2OgTD1IT/YS5Ny2gu3mh/HYpkcql3uzTW9eosc3qbhcRw+xRRsvWOHi+fqgKgJc2Nj
	 7GAETVk5lZ0KxFgO74OGCZlTEaracxwOpEVC/0u9KjfPQNm/q5NIT2WuKKWC9dR3S9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bIiCFEpDjmMOgfFcJ4n/jz7gL//gMzJXgOK2F1Lu+QY=;
	b=bwiynAjwIBZLIssKCe9O4JGet0aaz68BZH0sLoGOoMcmD2lnC2Qos4JwKdClDxyn9SZs
	 YZhmzfwtXybFT6BUQ3q7pNDmFptNKBOfaZX5SvwKcWOqShUJ0jLzsm5K18+MfYQEFxrHf
	 18tPJcWEQvrfjdj27Cqfg6fNRsYCXNU/pZ002rdJzVa+JMNb4kocJ4ynj+9E6lgCTlLBA
	 zX8IhL8vZhRzJg64+462ZZ4hAlmb6sqArqTjUCVNEwR8WYsFmNF6sZy/hC2XSqqtahAOd
	 EbesCgkNufbtQ6LH64qXd+XvE8YBJSlnn4BeGCFCbePoaCxGXjpo0xeApxldinI+pTw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8xulyiI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795462679;
	bh=bIiCFEpDjmMOgfFcJ4n/jz7gL//gMzJXgOK2F1Lu+QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jrAfi69lUw5tFEvN76OoebNNamJ+kh+dlW62UFrWxF1a/+DYTmZvoqmGjfAcPoXOn
	 RBNfkuurqFnpnrRTgXktLsPX0J2KjNJdPvH4buMCOJ366Fx248/RLZda88RnHgL9fi
	 miGhCpWdag+4H7/rhgvPHEqt9OQFL/j5GF75faQ2hgyYMN0pUp0foqKDs2C8NxF6zV
	 cps5GZTDc7va5AKVLYYzz9bMxA86Pkye2NfRtsAh4cnS4jFgwDz9FJlALMqjgnKaDe
	 UXoHfbfdBxkJI53y7hX+sRpBsRWujD1M16EUEk1dogoXF6bNX9M/h0ygixhclAD7Js
	 cLc+1vhGXhY7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2CBF80E48;
	Mon, 23 Nov 2026 19:37:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9034522B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76A0D80E48
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0doxjnOoBqU9 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 19:37:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D4BCE80E36
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=P8xulyiI
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4BCE80E36
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:57 +0000 (UTC)
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so6196340c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795462676; x=1796067476;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bIiCFEpDjmMOgfFcJ4n/jz7gL//gMzJXgOK2F1Lu+QY=;
 b=P8xulyiIvD9GoeUAjMdmgleJ8Gcd6YDAMiUXEymzqNwZkb1fSQJj6Mon4XrqRJ43q0
 z/JYzDnLuYHAyftiVYfxfedDNgyfNqFx/w5ldjx+lBTey/0wJQkAyGfSpLkXVvn1qKsh
 1xB8DY+m5Z8zWJKNrFiK0D8iaRC1XZUGcE8lseVPVJWlVZ+thp5n35zytlGCBfRKi3+R
 xthiDFltHT0qY3tGsvEetbvsvNIUmb+DmeMA2NhoFipcEuGgcVuEvKm5u3//s890+2kI
 spdKd3380zjrPZ9UnBq875OaOXH/J7mPasxkFZp04q5h/+OoANm91jESoO5b5XfZgD3A
 3HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795462676; x=1796067476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bIiCFEpDjmMOgfFcJ4n/jz7gL//gMzJXgOK2F1Lu+QY=;
 b=hLcw3xlDTMC8aCx6bKXncEwTKLoyx1kpHSYrJwoo5yTUON5FUmUFhtHRdbsOZaskZn
 GPMle+MiQAcbRO/Xaq/zU+ur+ganSjgxauvENp/qrVa89vAdSLiYK7cg6+gcoAB7aS1d
 q61WdPdHYmpXfZyb/Hv0xlmbOwlEH00EVxtVHYCge8yi5Mu8sZnkaiF9lTKZ85x+iMad
 iYIMjennIIBKFpJdmbCE9jkttWOnbVka9Z2sWX2HPAEmlcNAcv5U7u0ByWKcjyXdi47/
 DZ+Tq/ceyqa9LqIKRGYxd25sRWNHGN69wajlI61OzaB/fYqsg+38obyjgQKX1BSeFke2
 BZmg==
X-Gm-Message-State: APuU4Z8qpa/LSzr+vPzi3HK1neIzcqpRF64Bbiqvt3rw7+GAM0E6mVIP
 zcD+TsQRxQz+hrF7vPckbUM3DMLqJ5KcEIqYUKW4WCPJJB8kbRUrnMhRntV+JA==
X-Gm-Gg: AZFdTZf7uO9+58urbPKCqvTU/Hh5pr9edxrh38SEfDWsUhmrlz0gTtdcRbkST2gShLN
 kwv8nAf1nbu+RR1xNoyxLPq/zZFsQ2LpmSM+bnIz0s5Ve4CpH/OOOaZsKfrF67qeNEzDfNYHUQK
 AoSh81oRPaBHeXCOyFHDyA+LXDCqoMV1iTsyHsIM8ezXH1YY+fQpSzd+VE5/udY7voIkKjK21wE
 nWZF6+FcJj1dOk2ZHwuaGW3XF9eSXCcUGaqoOAmJjlsizVnTBxNBbqahyzzpNgCFwK47ZJTH7As
 PDWVxwJBMlAegogRc1zLGpQsoLzwmwJDWqdM8eLOO0ybiHFHPZjAeDWRA5XXEJtJYfFqSyrq9ro
 BYKW9FijBuSWQCtnss7f7jpIuaSUi7MvcfiQktEnFQ5mTh3yaBMIJrpQQaOJGzfC3axsrx6iEHk
 DoHtXfXaJoRJDsp6zom7iSiPBg2rb6vhhMctmTKYzS+HjEX6518a6s+x/FAs5UgOZ6BKE70IG3G
 x1y8qb6c+R0PWyPlbLJQjNQwqnyAHc/00SsOtIH1q2+Emhm+GysVF56zVvpEvxKzcKzZEA27lti
 HA2fXNCVaPgWoMYNXrLyOrgb0Hyv
X-Received: by 2002:a05:7023:a41:b0:1a3:87c8:7efc with SMTP id
 a92af1059eb24-1b5569026dcmr10761220c88.39.1795462676395; 
 Mon, 23 Nov 2026 11:37:56 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c0c1dsm41796268eec.21.2026.11.23.11.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:37:55 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Subject: [PATCH v2 4/6] pinctrl: spacemit: Add SPL support for K1/K3 pinctrl
 driver
Date: Mon, 23 Nov 2026 19:37:02 +0000
Message-ID: <20261123193714.5096-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123193714.5096-1-linux.amoon@gmail.com>
References: <20261123193714.5096-1-linux.amoon@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a Kconfig option to enable the SpacemiT K1/K3 pinctrl driver
in SPL, allowing pin multiplexing and pin configuration during
early board initialization.

Depend on SPL_PINCTRL instead of SPL_DM_GPIO, as pinctrl support
does not require the GPIO subsystem.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pinctrl/spacemit/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
index 87cba336923..ad5b458480a 100644
--- a/drivers/pinctrl/spacemit/Kconfig
+++ b/drivers/pinctrl/spacemit/Kconfig
@@ -7,3 +7,11 @@ config PINCTRL_SPACEMIT_K1
 	  The driver is controlled by a device tree node which contains both
 	  the GPIO definitions and pin control functions for each available
 	  multiplex function.
+
+config SPL_PINCTRL_SPACEMIT_K1
+	bool "SpacemiT K1/K3 pinctrl driver in SPL"
+	depends on SPL_PINCTRL && (TARGET_SPACEMIT_K1 || TARGET_SPACEMIT_K3)
+	select PINCTRL_SPACEMIT_K1
+	help
+	  Enable the SpacemiT K1/K3 pinctrl driver in SPL to configure
+	  pin multiplexing and pin settings during early initialization.
-- 
2.56.1

