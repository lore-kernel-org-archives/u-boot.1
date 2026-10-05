Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7850CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DCCE406B9;
	Mon,  5 Oct 2026 11:20:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LnpFysao0iA3; Mon,  5 Oct 2026 11:20:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 940474061F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791199239;
	b=B4gX8QXgGMtvsCj1B8kPi+IR9rFhVyZLaNLWNUIysmft0EDLyZAjp7PY2Od2aLfoFG01
	 tHhkGjJynmx7/DBCqR3AZLN+CkmaM470MRvsA1gjUYYlRBNJbopf/KXxovoYspLyJldaS
	 NL/5XwJyxa6S+WZIMoVYtLPezd+kaNTH9/7w2+MGIGJvwkgIL3xfWtU0oIpwdPSAw4j5d
	 uy17hco3zSslc89cvN7lz5ZBcNonLJNp6rkmye8NIxMHvbNsYA+kFvnppZy3vU4qIn3/t
	 RQLb5BI/hPUn4rHyi2HG1U5jPq5ExbMnuVsmUPyBCwfv8JtKl4SZ1+THwXzo8dJtPCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791199239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8wWgf5JUc8qhBN7ZPMcwxNEa3weS5ZDlc1ClvjObLF4=;
	b=R1z2xhPj0kHMsqsAESyy+TAMT/zoFdaZZJUW5tUnzPAJnx9HypvGxIIXz3eKyopoq9Od
	 4i4L6NhoiWessUUbmrDeTG3irGWQpYC6uuiCWiITHRsB96iNKj+LosVdOz5ZANL7yjPeJ
	 KaP1Dz97fnZ5YxrwnyXpytCayvPKvxOaNMLv2ywb2+G/y7Uk6IXk/qyzz0EjI+gAf18nY
	 0U9dfhbwo2fsWiniT0f/fq4HxKZ8t8Glh2OGvW+2Zg1Fq4lr1r1If6gl8+HPaf4ZydRRH
	 wS/H3SwaL4JVQjXUTfqqnCiQTx5JVjCMaoPy+AX3mlc6cPzurcWVtYGrUyyzRkFQB+A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791199239;
	bh=8wWgf5JUc8qhBN7ZPMcwxNEa3weS5ZDlc1ClvjObLF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ITZDewyvJFfmTbyik0YIfQj0WQ4OUFJBgmgdi/W9vYC++P2mCl3quj0l9F04Q+6Ns
	 BuV9tjS5arZV71abZYjYCdrhlucwX8IPQHQVpi5LdXueo/kwBHeEzcCPiC1EDDJkmt
	 BYeoBwYW52CaxEjw6mBhBJQWFx2BfdQgaj+AaexyJWXNsthVHPPWbXegy8gkX1u+bU
	 GW9kXO4ORPynFyAlg5B2urz2pxh5x/MGwIXjIo6QtMpY5XMmD+fg3hgcc48EFCNipt
	 AfuGmZTHM8canZL0M3ca/33LoHLZKUtgRTQNROM5CsABZTUXmWUerHtHAJYR9E7j5y
	 EYwEaD6hUn5bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 940474061F;
	Mon,  5 Oct 2026 11:20:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C098282
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DC80400AA
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZK__bDE172di for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4904B4007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791198808;
 b=G20APNbcfy7yLBIhzxcYZGk/ctGHSLfLWQjksAiMeitZeSj7hVxK7Me1YMBXIUrKgJYu
 TAnfM47NFERNjgIQ+sC23ZoVNXuZN0V1rFj1gFJbjlQVY9ikjsUGE7C9tezsFtCbqFlER
 ENqG/tlsineWNGiPq/rDYLpVwMJE8oUo32PXlv+9lAdx1ttNai4xRnx2bDnvoTGP9PdYN
 ku3MzSUnoUgLbiDEkIMtD4UJE0OHZqF7azYcE3582CwlBsUe1nshSXsx61Xmpt3j7w1I1
 tViAC5TfV6g83H8Nx6p/LLG1KJJwY3UooeQipJojSSyVFUEz4ihdepOijRQS3FuUQnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198808;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=8wWgf5JUc8qhBN7ZPMcwxNEa3weS5ZDlc1ClvjObLF4=;
 b=Am3EnDo14S1/psROGZTNVx0aeLpHYZ000HqNiMxFKgFe/fntqVwzNMqJzMZxK7iY/s2j
 D8yjIpKz191q66yOm8yePFp9NfSj2/YZIjG6snkjQAJVEaftragbmMBu7wc2F6upxFYXR
 on2Xj3YWVNi+JRKG/sMZF9mDFQ9NL3lXmHbKeZFBiTliL8yXF5NboL8asmQqn+iu8bxye
 DQACaD50zhyuCNAqA8jfRBK3CYyxZFzVjLtz9OJ6h4hMpdyoOtoqdkfHV80zAghtWJuRl
 sItOmfhQQQRTCCLO2Y7pltX+LnjqBBKhxt2FyY/FfPZYDwAQqf+sIcsMAxxeJk43apA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Vu3Vhqq1; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Vu3Vhqq1
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4904B4007E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:27 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hyxZr0b5lzMlJQ;
 Mon, 05 Oct 2026 13:13:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791198804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wWgf5JUc8qhBN7ZPMcwxNEa3weS5ZDlc1ClvjObLF4=;
 b=Vu3Vhqq1qn1Gc8t9i3QluCjXbgkNn6yr+Rj0TdbpjzhjwRBA2GOO+viL2q35OYt8dHQ+CI
 tqy421elECWXdzIslwOCutqFbWplPIe3rjaQIOnQ9BBKlRayAxXk/2z5umSeQwXMC5yzTz
 XP2VoJWKr12w+agXxDEAUeW+QM2W6d19A6u0ZWHVJOKh4Z0tjKTMFMEyfqcSWU+Ue44CCE
 EMKeYSQnEWRen4c/tZvOvGDnATX2S0ZmwFJON4V62KumnH0Ng1gtz8yc0aadehZlmTrmAw
 omu593k3tsULl/m/IfT5FUoOWEOg5ndkgs+iOWfyfhW4yXd6OOW42pfa8WVGkA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v3 4/6] watchdog: octeontx_wdt: set max_timeout_ms in probe
Date: Mon,  5 Oct 2026 13:11:55 +0200
Message-ID: <20261005111314.719129-4-stefan.roese@mailbox.org>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-4-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
 <20260818-rinta-watchdog-gettime-v3-4-423f5caf526d@nokia.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7763ae7ee63eabaffa6
X-MBO-RS-META: 74kepzgpsmz98dunzk1w6mwbg3ftkabz
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/18/26 10:43, Juuso Rinta wrote:

> Report the hardware-limited maximum timeout value to the wdt
> uclass by setting max_timeout_ms in the per-device uclass-plat
> data during octeontx_wdt_probe().
>
> The timeout is programmed via the 16-bit WDOG_LEN field in
> configured steps, so the largest representable timeout is
> (0xffff << 8) steps. This is then converted to milliseconds
> via the timershift and clock rate, and set only when the rate
> is valid and non-zero.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
