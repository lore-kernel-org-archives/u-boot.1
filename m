Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0D606A332
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vp/93VHt;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FaTO/vBA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C79656081B;
	Tue,  3 Nov 2026 13:05:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bT-EGHFa72oe; Tue,  3 Nov 2026 13:05:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1544B60844
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711137;
	b=PWkxojbaeUShhVOQi29qIzrRjD87hK3SGXt6cmTZB7EVqvmmyVK7haRUD28ypO90lgXM
	 xjCgiA3XJDpsb/v8Eh95rRuAUofZGyZu2CGeKd9gsAPpXlKn8Hs4ESY8+IdoWzItyqCPY
	 BR7B5AhjXzNmPyHLTf/O6zqpJUf19rOsEaeeefM5Mn3+H5u/PkgvLkYyidEZzrLO4zMi+
	 0QXgiqu9DEWHvyGn0dPoAnHUBS9bLD/3BvWpGimxbzeCAkJ96M4JbRjVDmp6z2Ja4oy3k
	 f9fieZB8TLDF8vBc4UoSWSLm/1Ka9lt8EKv8erLj56b+b68IChes3OZT5/UlbdY9Ckw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711137;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EnIpmoiGzzYjx6EBkqfEtXTezzwBBWUzqCFhqbz6F6w=;
	b=rRYBYPdcd6hzE6VEIapofVsJFfkAM7HtZ6YlS3zNHxmjVpNSGmQv4FFe2obtLZhiYfEG
	 lJ9JOnJ78rusWhUXMp02lHtn2Ob8vxzjY0ETObOOOx3FfTwqcfMl5TRyre0yyj6wBEbP7
	 sVQw8nTetb2aZcKcXjRAMfxHPMNcpp7yE/Sg5ANpVDrtr4png4yUKIf9A9NDAmSPuH2tf
	 ltGM95T35x2jJ1uWFOzNeP8tyyjDnSXkhqjSFyit0Sbcd6reHABrPPLqqJ7/UOdHu9zIy
	 qRppZXI0CYZCzsyq6Qyr1PbANkkOMEoqGoDV84HN9pEW4cDYm0T5PoPrZCcWmphSwFg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711137;
	bh=EnIpmoiGzzYjx6EBkqfEtXTezzwBBWUzqCFhqbz6F6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vp/93VHtX20sX84OmvxC24IAnT5O2vXqvFGQnI429XkLuDeyo7aEGwbOUd1BUu4mY
	 YDWyGNQCBwWYg+YJHreDFmp5TZ845q1QVXzfpHlGDmui5gn5dSwWT1nYngSOM+XJ1f
	 to8j5s0kFXsEfvlmOSV4e1IUwQ1uJ+hAnNmEA9nNiqEE1kHEc0qt8loK8ZdUrW7NeY
	 l2jZuxnDET0paCQlM7gQ819WKiYcxtG/oYKqjn0qQdweTCroMHodxWWU9f/ULJqVZK
	 M+78lhd1gTCd4PzfYLeVmIRn9hgHDYPk0uyt6/6R2H6NTmWQB68qQ1mw3FKCdPoVLl
	 GBodbA0PStefg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1544B60844;
	Tue,  3 Nov 2026 13:05:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BE0A6D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B00C180D34
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pZrC6UrfbZoS for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:59:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C21F380C74
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699944;
 b=V99eTCGW+141P/HRrfqqZB1o+ihU+hFhbe/JXkM+hyMqQRP6jOgz2641xXivb7Gc5CJ9
 bYtAwWa5RJXqOg5XmQdLjG/nsX13FXRbkir2j3jHkcRruEB7Kk2INZceFXsnj0+Xf7HcH
 X9vyIPAsT89HWkESedVcqKxYhoBpHSZr9eodPwN375oNGJWGVWwzE78xErmScLhuP6qJx
 kXh0EzDCdsNFD0Dpf8msg/5XWVcndnfZT4sn6mgrhQNkp+ZXmgzOGSaQRAXChOrKKFDoj
 lVvH2SsyHW/RY9Gtky7h54xtqPF3Aw+S0u0L9CQYWw66+VDQslRwAq0TQKTcrhFJkyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699944;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=EnIpmoiGzzYjx6EBkqfEtXTezzwBBWUzqCFhqbz6F6w=;
 b=hyvxX/OWtvS3xLjWHxzCptIuZJurYvg9FUIQ//z7MNb9ztR1tmbnIy6SooHcS6fUxXjv
 cD1BLiLaBMojah/GhhvrhFt1fzf15LRw27GRpq2I89VKim5kc1Ef9bBnubxTdlbwf3NLO
 Bku6UcYDqHCOk6LmtxxDEQJUADSW5uDx81fvM4eVM8KMDLgybehWEfQEb1LBTwUl/Pn1N
 c7ZOSmv79YSLEmPo1KHAA5xCqySwwGxp9jj2cDt7V5jYXwAtBNmeD6o1TN+Q+4z3g8anT
 FGaO5EbG1ALekVD+9TEDIDt+ruo+ulYI9LFnU4MA/uJEcq8gbm4/a6Z7nQ5bjiKE5rQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="FaTO/vBA"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FaTO/vBA
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C21F380C74
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:02 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so29793795e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699941; x=1794304741;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EnIpmoiGzzYjx6EBkqfEtXTezzwBBWUzqCFhqbz6F6w=;
 b=FaTO/vBAMnM0yEadYnUkVi7cBtNsoyw36A38IfHGcAXxvHJmPzEPdqzvwspuoOKl4I
 5KUrDoyyYOnjinnH9BKDERq8af1/4GTpMhf77PjYjmleTvTOrmwqzwhQOlYExg8f4uBm
 ZJaRxGKL/SEHMtYPuXB1EsVi+DJ6JU4Ib1ZrbmR7Twg8nVsSASinkM64VnO0uod9mH+0
 JLg0XCVzPjlPOSadWthrODyvoHCtW7rlxf6Tfd82i+kqOvOZDF3r6KiMqwESftE4aMtm
 956y3bThyJ8bJCx6+XlHENGLj8ky1rZeB3fcBpajo7byB/imxiBjLD84zXt03B6e248/
 lDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699941; x=1794304741;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EnIpmoiGzzYjx6EBkqfEtXTezzwBBWUzqCFhqbz6F6w=;
 b=Ch2bFVE2ZXPkcR7+XWyghkf8hJxfg8H2ApVpRW16lPWEWcqbqbvqzjsUi6gTpQS5rs
 HasmkVtEkgt+EYQ8H4FkcYxByJsBKcnykpc3IavaL8CMno/wQS3bdJceTkxYYXCwNdRt
 UZD+lAaJPTBKNkhcL9EjAx16q3ptflQr9L6a19AF8YL4qqBjQwfyauwtk+p8ls/ZJijE
 11V0Bg0aEijNvWO7IBJBWtYhDLf9TdvDSdgsa/SyJ45ojG2xhQ49SLdg3W6bh/iPUncl
 xMbVAwkcGgqnhvzc6yXO0rhZ0Q07gtzHpDRH2ap3i3+3i7S4EAVrrEiSbzy0Ir8xBxwp
 Q2KA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxk4OKTKVo11MJQTknYI1vXsvlC+NpYHqCBswws1gIVJgGuoAUmFYM67MS3tTekKEAXn/5Ifh4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Qz+432E5o3MOWC8EB5teynLzEEkau+8vCB+tU862aO3rowd8z
 7rJLw/VR8MSE5NN2ciatpZM9nNHvwDuFKJKjYfopgnScKNSIA2dt6fg3WrYl4IIH8fQ=
X-Gm-Gg: AYBFou1JaFkuRCOhnwLYd0/LuAq7Rd5xHBwURzI1xFQHav9nKBf1JjCXLwgEhzt3oAx
 IEy085fl4DGs5XBKN/jwnh5Yc/+9Ym+wcox+9dZQWZN8lxDY13hn5/ebB7kpu5MLHcyJsEtJs9x
 YKx5E39cliuVbutZPDVWeLmlj/xNamtEqoEeSCWC7L6JjMiji4hpD3sbgxhVinXjvKtviZY9pcm
 DBbfONLUhLSWMIn/zYSjkqmp7l0rFIg0BNdjKTBfZSrEN+NzrGbnCRJ7DaNvbpP6/+mTWsciUCF
 MVuaBNjhcV3mD5dk7KKyaoSEaRi36u9mZdarMFLawx8AIgulA1W7eoyYfnp2mIpjHdI8/mxiZjH
 KHN0659UVXbuhkMUhTrwH5ZXipm88GIpReryeyPFW2sKrz4uSOixcc3mhiLhFU+BkQ85XenMde7
 baiomababJoFq1mtjPmxASmBEK4nAFZQHgrkUNn99SnG6YQAXeyOo7WLcFDuoBy8PGy8HLJvDvx
 jpU2PmFILAE8fQhcclgzmelHkzMLvlpop/hxTH0bzlMxog3rSC4VSrulW4x4LU35WzZc1upvjBM
 CCRZjJnjBHL5o/3GWob+6j1mNA==
X-Received: by 2002:a05:600c:c48e:b0:4a3:2f35:38b4 with SMTP id
 5b1f17b1804b1-4ac16bc4829mr292510275e9.10.1793699940718; 
 Tue, 03 Nov 2026 01:59:00 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cebdbsm50079025e9.3.2026.11.03.01.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:59 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:56:07 +0100
Subject: [PATCH v10 21/24] arm: mach-k3: am62px: Enable 32kHz LFOSC during
 LPM resume
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-21-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=msp@baylibre.com;
 h=from:subject:message-id; bh=hZd6yXrzz4n+ykYHu8QjjO77c84cvaFRGnt0ticbRe4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXG3T4M4T2b12rHrP0+Q1Hlxdp1TI2sTf8wy3PHChO+
 japU2xdRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzk6R+G/wlcBbP/7JfePz37
 Rf/Elh/rfPZ7zi98z165xd5o3gu1TTsZGf6+MKtW56upyM7Rv/Piqs6ZPyfiPa/ruwl/m+J0s0D
 wOysA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Akashdeep Kaur <a-kaur@ti.com>

Enable the 32kHz low-frequency oscillator (LFOSC) during IO+DDR
low power mode resume for AM62P SoC by calling enable_32k_lfosc()
in the LPM resume path.

The 32kHz clock is required by the RTC to maintain timekeeping and
generate wakeup events during deep sleep. This ensures the clock is
available early in the resume sequence for proper RTC operation.

The function is conditionally enabled via CONFIG_TI_K3_BOARD_LFOSC
for boards with external 32.768kHz crystal oscillators.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 59a01cc1a244..1f25799ef8aa 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -221,6 +221,9 @@ void board_init_f(ulong dummy)
 	if (wkup_ctrl_is_lpm_exit()) {
 		u64 meta_data_addr;
 
+		if (IS_ENABLED(CONFIG_TI_K3_BOARD_LFOSC))
+			enable_32k_lfosc();
+
 		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
 		if (ret)
 			panic("Failed to get LPM meta data address %d\n", ret);

-- 
2.55.0

