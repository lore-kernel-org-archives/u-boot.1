Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D0606A321
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T+O35YKI;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9KgrkzN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDCD060B18;
	Fri, 27 Nov 2026 14:15:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kF08MiV5Cn0y; Fri, 27 Nov 2026 14:15:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 501F560B01
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795788921;
	b=moT8GX+ZPFQjZ+m+HKqohyBD4SOFDY22U+ZcjFSLFz1oczwkuKt26nvAFKl1PrXSMhZc
	 ghRMRul758f54RjcFea67vDc82yZ/x2eIVsutP08hxukUuYEOWy5NeQs+2MEvLLSXzheE
	 2R598fSpTNH2xOjqopiNx8JHtJP4X0niia+GcGZivFpOkmNGPbfrIas1plUOtb/3aV5Cf
	 hvY6T93LWCkifza5dMxEGWoFND4pp2qLAoMf4bSv2lj9K77Y72Law5jMYMtQxI843+beD
	 FR2FMHEXhuHcx0r4pAlodq5hT7WHcZlT4vkcuT1gBt6uaim3GUyYtjtMabJfkU8pvSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795788921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4Rz36aWm797DoSe8H0e7W/lWxxL2ftKFfRdP6nybVEM=;
	b=REOJ5gQfqvzxU1ugF+JBy3yAOlmYICwYjuWuyRsw0RzUmKfIw4UrAcgVpJnZMts2m3FB
	 FQlEJJxSi6PiPlwpMdbF7z6T/xr4+yz2ldQjES5FH6X5R6QbIAaor9bQorHY11AYDn4P8
	 lKkhJhVk1SiVJTex20moY+G9awDB5fyn6Xe25Iknnei2YZYGfvbjmhXwYTv16bcs1ixIX
	 4AJae92Qhm9BNyYEC0yFUrp6yNlccM034ccT2N+5Ubl1sz7p1xAQ9MUActfQLgK+Z8s/Y
	 4uSWBahbN15y/wMB7B+UpAoObtFy5Yihvw50s6jLptw6uu3hK8QDigk39d3XLhyeHgA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795788921;
	bh=4Rz36aWm797DoSe8H0e7W/lWxxL2ftKFfRdP6nybVEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T+O35YKISPrYSyJNSdckChk7VEkdPPrdrNhRAD2lkgQj63ia1dY5ACo8NyY/QQeDJ
	 JF8xQAbUYScSRQObYkd6v6DYDqLaO8coScdw6eldXlPgb9DOv5D52B4/C/tEJrEcH3
	 QLEnmprCd3tTNaJ/j5gjyErmyKDiUewEwQZeWu20GTHE6QuuBj4gKX7AONgnqop8Gz
	 b478XQFCqYMkBycqjialgt83VKgb898UUswdQRSC+ymQWbRhtg/d2L2RVsnuuH0gHD
	 JNYdJHg83KabA6Iwd+W034sa71bcNt8Yc+/Ae11MZMBMQiNGmlwX5ue1KxUCxaRuQe
	 zEm5WYZH0KPuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 501F560B01;
	Fri, 27 Nov 2026 14:15:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD562373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF0D540A62
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:15:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 05D3t39TKiLo for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 14:15:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA0F440A56
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Z9KgrkzN
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA0F440A56
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:15:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B81EB446A7;
 Fri, 27 Nov 2026 14:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F681F00893;
 Fri, 27 Nov 2026 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795788917;
 bh=4Rz36aWm797DoSe8H0e7W/lWxxL2ftKFfRdP6nybVEM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=Z9KgrkzN7kSrJ0E51tFpmiIiKQzYO7sKR0FnV0bhn4dH39DapxCvBmuKWMVcrmeFy
 0gkU56WRImApf6ehq1daDDuF8wpW1ycPgxtIPx7nXrSnP03OTwYr8EWAiArRG9Y33Q
 o93ZbB7/r9EvReSjQh/pfQrUtN5NhBGWXIRAgQgZ6Vkyjpn7cmdYL5wDhKbctrA2FY
 IlmAXveJpuvlvC8jd+z++EFRbAUw9rcuruAYaolpt3iNpjWDCa0q5PONcGYlSmO+vW
 Nto4BN+AHGIPDA56lwKBfc9MGK/OCz45j2TS+RSd0FbRdL1y+tB5cQkOa8LfnWwP/6
 HvVQMgAWRikhg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
References: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/7] test: cover the AVB lock state and preloaded
 verification
Message-Id: <179578889655.2215474.11539661881481566556.b4-ty@b4>
Date: Fri, 27 Nov 2026 15:14:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=kX7VZCodJ262e1/XC5+6Z3BrqUtJH6r80A2oWPY+n0M=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCZBznGlpEulRZuMeC1j12hEKS0MDyq+XWkFJ5
 mWZ2XGMP2iJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawmQcwAKCRAZDR20Zk4Z
 NT4JB/wISOafZZLzFO4JsyfPi5GU9f3AQt/OxZEGeRiFvSnz2YS2zjXagKsOswOXcqFr+XiHaFG
 aDStqLPRFO+OF3iihoXhTGuOMoO/2CSbBuAfv8DDbBOkWqUgu508uZDDZmrHcmM1+wt8+Ib32cr
 GbmGjCXQE63qp4slOHqabjExCoaHFOjK9Xp4nUK/WIQpj9VSek68sTsSS5jVwT+/KT2IpFNJDSC
 zH5HV4jh1pgMHlyW2gkl1G1mEBpEJPO8WaFuaZptaGtVha28zh1m0qe8h/dAx7LLYwn/qRRDMQ2
 clB2HamyJMbb71OH6Kuqi0LOgOxC3H66/RAUl8upbloP7FGY
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 24 Nov 2026 17:24:57 +0100, Igor Opaniuk wrote:
> test: cover the AVB lock state and preloaded verification
> 
> The AVB lock/unlock series [1] came without tests. Add them for the hex
> persistent value commands, avb lock/unlock, the verification of
> preloaded partitions used by the Android bootmeth, and fastboot's
> flashing lock/unlock/get_unlock_ability.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/7] tee: sandbox: keep zero bytes in persistent values
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/1587a685d2312074a61127b8d0fc7809fd4c2ed7
[2/7] test: avb: test the hex persistent value commands
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/a9410d692f50ce04007365425a89b8cdd9120853
[3/7] test: avb: test the lock and unlock commands
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/b6512b9a69e132e6bc66d257db2420ce5dc67bee
[4/7] test: py: android: replace a disk image in one step
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/be7859acdad221cfb16bcad458c8b108610b6530
[5/7] test: py: create the bootstd images for a ut test run on its own
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/51e9a1aa07847e505ee5c9dd2f8f8b3121ea18d1
[6/7] test: avb: test verification of preloaded partitions
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/f1441be37f90a1cfdca78415af9311b6641140fb
[7/7] test: dm: fastboot: test the flashing commands
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/524feceaf96a06d1a12dada1674541feb27ccc13

--
Mattijs
