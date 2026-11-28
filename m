Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465BF606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EjsQn7dk;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=AZEj7J7q
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0390660623;
	Sat, 28 Nov 2026 13:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRbpsjaD27_m; Sat, 28 Nov 2026 13:11:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E63E60626
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871505;
	b=oL+0B7MCWg0YJVXQNlqlvZ3d7k2nvj13BbMojE0RBz8NWi4M4JaD1GdEwLmnu8XrPGEi
	 +T0acfl768MG2sxwteNNaUu4gdMAVWez8qTMrgG1tddps8YNGP1hz4Wg0bQbuDhLjO/gn
	 1KfDAoVrDhP+M7qJ4YxiHLlOSA5aqnHoVswByj3kmFtNz6eK/xRUrfVRikus0Zwge4+aK
	 pHKW8vJ4Drv8g1bN5qvuaSkSTUfaSSwdUe8TpIS2XZtAhbDMUZjeTfzgAJGNEHvdmRLNI
	 P8q8qIgKdrySyExnzu3J50MebMfk7zZjCudJaEbqEyRJlwRyQw3uD94PvqONj+sg8NA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871505;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9p4WOet8AkILhU5f/VlUZibOtk9yEUT7JLGreigcNes=;
	b=cNmC4wbqwSy1k4pUjyJySZXsSiQ/bz8rJmQm0BhjqY9brj9Tp4WAzPXmEeF+VysyJ3TU
	 xNrqL1P+svJWipZ4MMdVfyCnaKKv+NecIcYK7FZ3+ZQ+R2XDS1HL2GPWqsqrwaJNX6Wxc
	 nihqRemI+pXskjEOJTNYPA9xgNtzQ5bET/yShzM4QOP+YChemvthO3Bm9Liq7Xb2PixzL
	 vM+Ik+OTkD7g3uk0cHw9L3Z33UhcB5g1Tas0VBiuIM1KaMdj0Ust7hDFRQBZBGDv6TuNQ
	 J3axzUDyBBac954rUnMejTyIqAuEFAEAxvtEmzoq7FVdINv6YGtDFfhjJ8S2o8lVQXA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871505;
	bh=9p4WOet8AkILhU5f/VlUZibOtk9yEUT7JLGreigcNes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EjsQn7dkm+JRi3zf9srxp91NFGemaE2hdnT/dYFGPknAA/vnqR8Mue16mBdFOjCqH
	 M5sOYTuR2YNuasWxPmUWVy3lnghvbrVU2L2eMopOGBb5XxkTF1fqsjt8CYb16dCSq7
	 MH4ZizBGEEjWg5EayXHm97BExAON4Sonk+V/uehElN+/scItZ5j4G2WSjlCodUzOZB
	 UZBroo6I83DLKFIKkoxkK5RKzm7Q0cW+IRfqJr0D4uLuG6m9KZD0VWVhBohqRvQYUe
	 h8ZvLtmVnH6nltSN1NUivqyhaGtZxALKy8jw9nXouwOQ3q7rKypb//JTUmEczCaDjz
	 y3vUBgHSrpLGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E63E60626;
	Sat, 28 Nov 2026 13:11:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AEEA33D9
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93B2A4065D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yoag1SvIfz4f for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76C1940645
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=AZEj7J7q
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76C1940645
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:37 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso82958925e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871496; x=1796476296;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9p4WOet8AkILhU5f/VlUZibOtk9yEUT7JLGreigcNes=;
 b=AZEj7J7qAnw5IYxJIettmkLAtHtclo/semnGdB/6lqKm+K1hFetgPSjyKu9H3dgTQO
 GnefrudCaVyhspyBIH3Dm7jnDtnc2TP2Y0nEvgekcWA7YFU7/4LzyAOKZsn5/+sY6A25
 I2zlaxaJdEJc8t1TTwquRfUko9v2S5xy6hUus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871496; x=1796476296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9p4WOet8AkILhU5f/VlUZibOtk9yEUT7JLGreigcNes=;
 b=XLRfpfksW8ugP7W3YgMtdvUl02LWi7b1trnXHL1qj1MMjm4kXVokrcQm46e6LIbLY+
 az8n2e9cuXkuw0CgtFh0e9wifsmU4oZpG5u0uoxUi1Qa8O+Mt80pFCsXGliJkK7zgD7U
 EcxIhsnhRvLCfuYQjGBnBdpYx53wglrEVTMB7kJgMFEJBaMPhiD+lByy0lprOO6EGyWn
 i3awjausWanpnPhG75/3MbPZIUFoF/gGGNGNigfB06CayQzJbHgQHYAGv/t0zTZoxYJ3
 LKtF0CEcsWIXJrtjiWJmfJznalWeXghtYHCQzkBwluJZIlN94b51CVaVWnjFSn+Vs0YQ
 Qv5w==
X-Forwarded-Encrypted: i=1;
 AL+hErHDlcjwQHXmHr7ZTYIax33k/MKpzdFut7Ez3ImEaFHjpHuraHoAa4yGnQjrQI6eRQB9VmzQubs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Ho3Cyal3UE7nhpL+0uxMa9LJ3x62286PyOKLyQg8BjIt7t+Qn
 MO5u3tLh9ca1Cp7IZ+bzB7+fYxIv/zurd3lXo5W1jaMaUJxp+OgPE2IXqKo9DhXgLnKEoJqTVVn
 TRwi/
X-Gm-Gg: AZFdTZdHzcGYDsmlgfyklnCxddaX5l441/azGY6jIBOvwczyN2x5ZFgn/U/HTUdroxU
 V31tgNAXy9W1pfhRnxGGVMhuQM88tntyZ7lyI9/7aNr6tsNzTY8hEpMqmiN6kOlSMfAiropYp9m
 9FfEt1MeJCgmopPQEPWOkwURklzhCHPX0bMC325+Pm0kfW4zhREJKrzEaRIuhElIdGgw6Bl5SdH
 xqahEFkEEIJSv+jzj762vcPXfmIwgNEUJDm96kCg3clH0lBGzKR3PoAb0F0Tm5zPjbabt++QJzq
 4iucF2XxSN7xAvZMmEYH3qssknziGcGYfnvYqtWPppP1B0AkDfmPf4GqYmvh+klZKymYB1ko/eY
 EsUUQeYiR3d+F7ws/7aW585LnPr4Lj0uRmRRDwXtEQThCPyqdHG6ssBuX9rVWZjBoL6g7wCRAHP
 KOJ3IcdNyNFAntZGizhqkheIApzN5L4UhHJULH5yEy6PwhzOz7YHAsfv6mCstqUnlsrs33yat8m
 +nvL5/6CYgoSdJ3/nwOts7p6IqOr1n3yx+tvmLhOLYISN9cO/aoQbRwbIT/ZvfZkI+c086iMMHM
 5SEhztMSUL7O1inqk9XlCrgP8IjR0Dvrzc9y3Ohl9lyL9kF65sLWEGDEby1DQd/n7C1F/1U9dpv
 A0UM0kKi3OJsTXNtPWQBB4GKyHbapFNhzZ8N27GUEG8vHthVA2V8dbzMPwsHtRDGJL60s3npaHn
 5RzZqNtu7nQfLFEraefKYxJkvT/kY=
X-Received: by 2002:a05:600c:8b5c:b0:4bb:741d:ea0 with SMTP id
 5b1f17b1804b1-4bb8880f621mr605591115e9.17.1795871495940; 
 Sat, 28 Nov 2026 05:11:35 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:35 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 02/29] arm64: dts: st: add power-domains to sdmmc1 on
 stm32mp231
Date: Sat, 28 Nov 2026 14:10:19 +0100
Message-ID: <20261128131125.2141352-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
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

The sdmmc1 node was introduced early in the SoC bring-up before power
domains were systematically mapped. Add the missing power-domains
property to align it with the rest of the peripheral nodes.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-3-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: d92944ee1693b20c71215c3ad1a1661f05e85108 ]

(cherry picked from commit 38e8d79eac568b36a01076a5dba1e85676eab895)
---

(no changes since v1)

 dts/upstream/src/arm64/st/stm32mp231.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp231.dtsi b/dts/upstream/src/arm64/st/stm32mp231.dtsi
index 9e1d240888ff..0feb8943efae 100644
--- a/dts/upstream/src/arm64/st/stm32mp231.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp231.dtsi
@@ -727,6 +727,7 @@
 				cap-mmc-highspeed;
 				max-frequency = <120000000>;
 				access-controllers = <&rifsc 76>;
+				power-domains = <&cluster_pd>;
 				status = "disabled";
 			};
 
-- 
2.43.0

