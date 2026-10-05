Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73310CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C989C4062D;
	Mon,  5 Oct 2026 11:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qO9wofMi77oC; Mon,  5 Oct 2026 11:35:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C5BFE40383
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200118;
	b=ZcD52bxrixEcquL4inbKZ4CfiQ58jkkjskrkkX0y73LbYUPSgxO+/N8anR/CweYbmxSy
	 ovt1jo2O6hPtPxYYLEpPWl1GLdPHyNrOpKsgXab6he29Na5/ygUi/DgbNcc9Gtx/B8v4w
	 3XUqRTKOwDD9gRfPr6Z2n3/swl26i4k9xCaCEJtdiP1/TaDkhdMO3btNipTqnmKbOE9fx
	 r+NMUTevl3Iwbh/b82nQ1T+KZX79r//hbAzGI9sRdU8QDGwpjcnswe3HBLSrWU7r6K5iL
	 ZNRfi/BgcLUNFWwoyTpT7rK4tZY8c1G5lVLXSxmj21QhmEoAK+sS4wubgu8e2fbLqWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791200118;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BXQm1YNhWW8UUYfHJEzNxG5A+uO4O/MnydxZ/plyf0E=;
	b=CtFN7HiDT4LLVWl5zuoaBKXOmO3wl6wwXAHb05z9mB1OnL+sEZmVur0YRnM2Dn8NKrwK
	 LYfXGBdpCxQRdvavjwtt2+aazZS+QRsOZoBSXrF0qPRPXCODfRI//uXCKS3YvCMgFZRH2
	 fntkykDHiGTNzZg1hqVyZZ08ppHUJVl+vWfeE/wp+675vmoPV/OkVl3wGI1nuwR4NzafX
	 xB5lq+9rL0RB0Bpc1vqmGMAdD4Lj/TDBl2+rHUtrsR9SNby3si+NhdpfXaCEKusV8846L
	 +whKf/MUbbSnHYl0fhJ5t4XcmpA18E9KJ4bQbdOPpnQxihZJroIRINtG+LC6qScSnsA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=OX4dZ05R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791200117;
	bh=BXQm1YNhWW8UUYfHJEzNxG5A+uO4O/MnydxZ/plyf0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jrMMrb4F/TWYcBR9XnIrIUbtHeG2FCcfMKWKbwOb1EUB+CJuG6QOccdOqtoQCqiuM
	 pDwKouQZojMh7Jd3dCyq2dhpPE0piAXLcaXUkfsyhXOb+U1o6U8QN1qbzpg99d9Hof
	 TcZUR1Iq3jCYs6HmUtDOdvXyWm+m8rsbAsVmxxTjQkBHZ3ZzWTFSi/X7qBb4qaBXbK
	 3glE9QPVjZXj77NtM0tfYEtF0m3rGp5sJ9KHP9qwN2dmObodtzL/4MkYt6JUATsdjC
	 DZ7y9Kyi8SDn4Ua3blGzyyA7aiV3HnXziecRB/UzjLKkEE67sfj2rFvKeNrp4+22aE
	 /lycPYfYnQ/IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5BFE40383;
	Mon,  5 Oct 2026 11:35:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F055F1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D690C405E7
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v45KO4YxA3Ls for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:23:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 366E84052C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791199404;
 b=rXxpYV9K9rc7ENEw9/6jok3GI2xSc/Q8boavzCgYuv1+naPKDY7tJ5F16skCoWPcWJtl
 JTUiZY7h6xZbZNQZdZGHJVNliZ2nMH7mmgJXAxSbZFwSYwv3VDm4b7q0vtV6+Isdue0S3
 r3cNxsKwhKloZVxGeV7ezl7AOlVvkW3ayw5BpEvkYxfMKKPeetmKn48fbkZyMTfWsFlWa
 bWkXQj66EVYLc/bpClNZCIbFj/YchcafboP4oesQXNk7EG1xnKyqDnosl0ITwTXqfcXLH
 7FYwKVIqf6h52Zueq5c1htGwVANDmDl2m+kCX1UVBdwqsd1qL82sZs9mS2tFzaQ7UMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791199404;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=BXQm1YNhWW8UUYfHJEzNxG5A+uO4O/MnydxZ/plyf0E=;
 b=HbC0Aq3xc/54/Nh7fuVxkpWePDEXHPmhT+o8qsn+KUD5jrvssIre8PRza80yOQzXSupd
 tuIPsWxv/EazkPYZj/NQ2utcfQUy406G8vVP4hmngOGtmQ4TOOvrlK7IEHSrqHjzjYXGf
 0c51NnPohrC/bLetH5R4OOLvcZLsJrS4Ml4buBhofC9rJu5Y8dO+YaPHR5CYonwiI1f4L
 e2T1p6JVwfs0yygZj72S3ntlDfWVqCHGD3dklHOqOMYh1i/FGCqKnskg3nqmC4QBxa5Hh
 +fqmzFfIUDQ0MtbJyS4p/CrKeG6XgsNZj8knhnWhOoyLM9gzqlVKPmK3K0vIaqAfLRw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=OX4dZ05R; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=OX4dZ05R
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 366E84052C
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:23:23 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hyxpJ6dLjzMlQy;
 Mon, 05 Oct 2026 13:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791199400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXQm1YNhWW8UUYfHJEzNxG5A+uO4O/MnydxZ/plyf0E=;
 b=OX4dZ05RaesMDMrbZO+xqr7klf4KIVei9KGFfi8TUhqS5EcpiwfYZPYWY3HuLRuroW4Qeh
 /8oNX0tRvgwo73jmBjvAzUEbiUF/Q7f0hKb+MGeyEsziykDqA9CLkQh0gsstDP96wMxvwM
 UOoFTnV0QiWbgNOJnsvce1TRZ2P0b1eePAzQBlOYb4eyt4BWcLKURZbBKngxNsSeEOO1Nf
 oSKDrqEhPzZTzb8lz2eAt6KDjCWhoW6RNi846rAKZw10390t0DoIaxZ88v3PFpH3ir3wbP
 RfSxa0jYZhDJy/JgxV5pQAWYtW+nsB+uC3i9aD3Hl6cX770+ZalyzI55UbOH9g==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v3 6/6] test: wdt: add a test for max_timeout_ms
Date: Mon,  5 Oct 2026 13:23:17 +0200
Message-ID: <20261005112318.727176-1-stefan.roese@mailbox.org>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-6-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
 <20260818-rinta-watchdog-gettime-v3-6-423f5caf526d@nokia.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: r1nd69kwksr9hc937kpzau7qybtzdkeq
X-MBO-RS-ID: f0a7c4b401cdfa6b38c
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

> Add a DM test for the case where wdt_start() is called with
> a timeout_ms value greater than the (emulated) hardware-supported
> limit.
>
> Add console-print asserts for both the clamped and unclamped cases,
> as well as for the per-device uclass-plat data max_timeout_ms field.
>
> Add matching tests for the GPIO driver, which does not set the
> max_timeout_ms value.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
