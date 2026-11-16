Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B94606A891
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qRnPnoY0;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=vCMJ32YJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EC7F4079A;
	Mon, 16 Nov 2026 17:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q8DBLOBZJH6a; Mon, 16 Nov 2026 17:57:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5DA9B40779
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794851860;
	b=H4TeKjh/PyJxK41Z6NFawCpCefQhctOUzugg3Vbp8hEj6vlpLD6ih4m0fQZ0VEQbD7mt
	 wOOQBdzYtfsGC/Cnb8TPeNy24i0aFN3wvcE6bdtsuMs73fucj58TycxSOdeyJwgXHeSj1
	 Wk4YqDJJc1y0DtHQntkgybU2vOxBHSZG1n1VtMkxvG2zH2HFuMe4NaAl6+Lqy6vg/TUXc
	 7SPPkG/PpkUH84knjlQPVbhdYJlLJK4oRCBnjB8g2HlhZg6IC1sqsPqkGJNfymWwRzNAN
	 zqTo5s1vqQ76q2xriyOZ+D/WiF36epkYGFPiUf5nRJd1YUg4FY9ApHZfEMMFBWkx/vQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794851860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TX6yf98G9l4Oa2gVRnXfin7PLHz2m7B4SmwbadHNmhg=;
	b=PjB8D1MP6oXOdVX05vUCX57Yn4xXZVLQEZhv3GcDU1b+oCIG0vA6Cq0OO7SnMTXbNMw1
	 jTAazyN39A+rmFIZ9cEQRLcb2g21UNsU9hWRdvN1ZbtOXb7D2BYWBQYYbz0IxHMuefaHm
	 hrEO9CvMas4pPVlBTerQZ2eU5OrCUjsUtQc8s0+EoZxxEDAgz5vfjakVdslsBelQGP7V/
	 EDH+4SqUtYDNf5XfYFR7swek5x8OB6hpXlImUgug4YDfQKROtb52TLBgDRBB9+NdOkoDM
	 GnFugpHNhwpa1yoHTD6fhkgmXYBeZ8kikjP1TyKmuBSi5dLWkCHvGLbsHh5CjvPim2A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=vCMJ32YJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794851860;
	bh=TX6yf98G9l4Oa2gVRnXfin7PLHz2m7B4SmwbadHNmhg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qRnPnoY0ME/A1uI16rbHjqRx+NirCCYV/e/jYR6k9en46UZ761VzJwELntw348j4W
	 1MiX3OJI8NX5z5GQSTyykMS2HKU2Fs4x5rPb6WgbGs4wPvRpNWlocicZU2uEJSR4XW
	 mpJNVg5xFOC+xHBs3egoeqkXSK3QUM/brl4BTEtSfZCsGKcC3wlDOX6QpqPCeXv2KL
	 wpQ1LQ3sWhqUTTHGcuxqMZP1K0n1Lk3i9b3JRMzIbFL35StMWzVZOvqBVAXzs8GhZZ
	 irzoI5VEuvFip0FsXe1Bqusfp6QJDY03Hp+0Dg97nZgRpr/oee+GGs2EqQDCtmhLAL
	 a4vJafEqY3R5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DA9B40779;
	Mon, 16 Nov 2026 17:57:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53291260
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3890A40779
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iSEOb2v-qa_z for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:57:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 11C9040774
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=kory.maincent@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=vCMJ32YJ
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11C9040774
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:57:34 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6B095C4EFDD;
 Mon, 16 Nov 2026 17:57:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3B6616023F;
 Mon, 16 Nov 2026 17:57:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 596C411BC0870; Mon, 16 Nov 2026 18:57:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794851851; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=TX6yf98G9l4Oa2gVRnXfin7PLHz2m7B4SmwbadHNmhg=;
 b=vCMJ32YJeg8q5ymxgWYJ8jK5SPW3N1eDL1mP441GolGglWf2GHwdhRh46DgeZ72+/LEWMq
 ltHEmzTkumYe+PDwWgcpVr4baGmnl/IaEN5cOEfwttDYDtXUa5/38t56lXxE0mff9o636r
 6P8CV1vPmqK5RAeE+36KNOo0YC/cYIFCKloolKfBpc8bYfJfsk4QVX965bP+URPTFZJ0Ex
 5aF7pTe9DYVcKenvNgzUbqDKhav5vr7WdJGD090E0BDXaV8ZZ/Bx0W27uXN2EIvrYzqMAM
 VoITLxZP8trufuZ03wQA+6YBln2kGDyqmNl+zSUwg5DXTDNDPWEfs3nGBKDdaA==
Message-ID: <dd8dbc78-e4de-463c-ad79-cdb8c7043b91@bootlin.com>
Date: Mon, 16 Nov 2026 18:57:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] fwu: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20261116173646.3487945-1-marek.vasut+renesas@mailbox.org>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261116173646.3487945-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 18:36, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

