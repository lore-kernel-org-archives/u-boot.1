Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED698606A330
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zSEfgOtL;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=N0dN21tf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0DAA81416;
	Fri,  6 Nov 2026 16:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0p8GpmaU6FoZ; Fri,  6 Nov 2026 16:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1378781402
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793980977;
	b=lV+hBQpbljeqpWS9/aXZH/08/9V2nePHufkWYVX5PlJ1XQRmOB2ZBsp0/Vl7eatLqPpx
	 tX9bsRDWgX3b0OhNPhojnecdtScEZlB+3PRFRJPESdT/pN2UszpngAZgI73fU41rZqHmi
	 AvSz8hCRyIi2yUIu0zRDNSOwCc1w7CJbH/yMiYXpy8hnINzs6I7h75ChZsmTD2DBsGtzu
	 raqsirhT08vCjXw/u+grWHQjwipkuBDNfT34UcH4CtJrjq2ea8ZtMwKIYtXdbGl1/C+oE
	 NEIK8+Wj+RxEOJPhl/KkIYc8G10cFOr97DrmN5VasISfKbOSMkxwG19WtjuvotJhqKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793980977;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lMPXhV2UkBr7C1RNWxLS8bKKjedZ6EaHJIuT4/P19gU=;
	b=EPL9eUL9kFe8F7XlZ5MWRDpky4Iq+qyX2M8pBabbgDxwHGmIzOV1cowCqQlZt7DrFKcI
	 rTC1xT3lfhsQ3CgwemEcUPrQvHVPTFoKT84BzPu4XmI0KZP3uSxG9ps5CxpB/FTeaeEfj
	 jh5rdB443SJAlSs6XOiWXCrFqCYkK1zOxD7j2qZno5ROImRdGlkli2clsCEBs7gE0VzxT
	 KshDpZYr5hwuxYxithvBfdCd52kLRtVo90PTdMjxEgjO2p7xK9RjE2t/aytk/TGljLX7/
	 bhIdiCPkcWxGPq5HAgn9WRbik9PohB68cqefaVxNl+zEJUdZLLbJlxBw9FQ0Rq97B5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793980977;
	bh=lMPXhV2UkBr7C1RNWxLS8bKKjedZ6EaHJIuT4/P19gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zSEfgOtLtw6GFPjNlSiubGIdXJzLNjGaNoH8CdPl4PFp1YBhGQPuDpcIyfIKvx/15
	 H5GFIxfNzbZUyz41MNq50mE7wwKLKZ5h5zsWZW7C7RJ3N0rZKClWhBPWAlgMtj7i9U
	 ip5D1IHCjw1QiEMAZ3wWfhtfJuiPumuS0qfMiTENghCgqZmRtkAcWnC8hIo8xHBEP9
	 Rr0pGl2TTduH3lBDQiYB0wVUeEtNXS8CWNa/nXzgYVzAY6odbghr2C6WMOVuyLL5bx
	 kAWNNJ8PXg3Ti3mjuADOMy+ne1DyQwXru0BIg6lAxnUChJl0Pvoa/AxGKmEuVMja/m
	 rh9H3ZEf0yaMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1378781402;
	Fri,  6 Nov 2026 16:02:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0021D49B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E643D403D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mT58R24OkI-Y for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:02:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 42DBB403CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=N0dN21tf
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42DBB403CB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:48 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jLkTx4XcjzMldn;
 Fri, 06 Nov 2026 17:02:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793980965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMPXhV2UkBr7C1RNWxLS8bKKjedZ6EaHJIuT4/P19gU=;
 b=N0dN21tfRBwnSWQZiy0hZ7gFHNxW+JlaOq/paLFDEd+dgEo3tmBfXg/d3Mfzn8dH8aumDL
 N85aJ1pGXGVHU6jWXiVYUFE1/paYGUWL9KD7CsSuBEigPKXiUf4Du2E9eSrYPJtLdOV/rp
 HGuIswzHi0OuPcESi733cu/eHOKB8mqUuxgOxtpkXcfbiWMFFWvvZtQSoEbw7osj/SrJze
 9iXSSGdMYqjgi/w07aORT7oG+KHzWVM55UVuHLTryZURusnRRfYmm/5gjB//T6lW/8fFdB
 NgqfUGwfyIYfZPEcfJ52VxsaerkT91XQFb+hIlQbGcW1HvQX4LGNa6hXCD56mQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 7/9] watchdog: max6370_wdt: add get_timeout operation
Date: Fri,  6 Nov 2026 17:02:33 +0100
Message-ID: <20261106160236.749429-7-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-7-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-7-07de25b6312a@nokia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gjbh1c5udu1comgqucj35uq5a39bw91x
X-MBO-RS-ID: c416faca7da90a1c4da
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06.11.26 10:34, Juuso Rinta wrote:
> Implement the get_timeout operation for the max6370_wdt watchdog driver.
> This is useful because the device supports a fixed set of periods, so
> max6370_wdt_start() rounds the requested value up to the next one.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
