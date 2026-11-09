Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8F606A323
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SLniOYq8;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=tPCV0dN9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B048D6078D;
	Mon,  9 Nov 2026 13:23:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s3z4Ygde7JLS; Mon,  9 Nov 2026 13:23:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B0DF06074C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794230601;
	b=fU+JIWVA7q0juWq9xGOtZdO3JxJ1ciYwNLpGYpVjZ1KAxUJXHGQIv2u+oZk8quq0F2rL
	 2PNzq7FeSepIYKeqFANItuwZ+LD0EnTAIauvGJFIwg0g8z7zPpkELdoHjiw9GAVNAUXIn
	 dM0VJvwBJ92Gnb8zJe6PnUwzJ7+pFvbYZ77IoHNH12ql6LU+7gkYv8rxZ2JhNCuBK0zln
	 NuOk6cRsi01HOB3HPru82jcw7uvkh9t008cReWC4rWdoCv2qeCq89g7PD0giEw3DU1iNN
	 vqjrxvSjj8PiyHvbVFciVMu+n7PSrR2r5CLdBgdeJxrJapU8iKJuO5w/0Xezffkk5Xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794230601;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tYTE+IODEfl1W5wVT9TKGZwUSVe/ajZwM93AgqgHoYI=;
	b=iKdqWd30jhpkoazwQ5+T1uK9fFQJRDZ0mLLByHS+d7PJy3rW2SIMpQR9hAxWw81BR9Zp
	 jzoWj/xjNuS+T/aV6rd/8WQbC97gFG08aKxISps49lSqELsDgkvCsfTagpJ0toT/qw1u6
	 PU6MWZfK6xAcTpDSKAaG69/qwKB4iBfY/do5tmuLoJSHBZf3Z7AmC1mhzL6NtdvMwgmaF
	 t73kWTOQgUxlXU32uvWcP2GfZ3C/DtZVfulZFVexFsy8KHUK2zMK82vyEtE+QwcvNI+b7
	 yJMVEWLpGsR91cI+iWO4T7JMaL8flu/k0jPBQqld6gpsmPMn7IQY8K54ZcR6rUhD7+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794230601;
	bh=tYTE+IODEfl1W5wVT9TKGZwUSVe/ajZwM93AgqgHoYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SLniOYq8ujNzCqA0K75OptMhsK5eLyl9m4ir3shUt57vsnbBi8MSC0Avy3teCKGw9
	 68FrUMpsYtYcOpbDB7qAGTV8WArEC3pSqlpJxBaIrf7/06ZJJnOsBnsfh3xLhlscnB
	 byFPPnZeO3p+6t04Y5hhR6Wi1xzTn5QQ47pQ6XvxRtZFEe7a3JA59iNiXdZL+QmOtX
	 2PBy9TIP5459jDPYasgPOjJFih54G5vEkGyE0lVQaFraImrhKNPRiOlWkJrraMpLqT
	 1fzc/mtJnGUG87r9VeJ9vtgjqI3q/ZDq/aF7fvSyuqyEpZp35v5GuveFElNlqvndaf
	 0Mvbd/uQaeAkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0DF06074C;
	Mon,  9 Nov 2026 13:23:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2748E251
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:23:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E01040703
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:23:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jc6VB9OdlzjB for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 13:23:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1D9D6406E1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=tPCV0dN9
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D9D6406E1
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:23:19 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jNVpX1NRNz8shN;
 Mon, 09 Nov 2026 14:23:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794230596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tYTE+IODEfl1W5wVT9TKGZwUSVe/ajZwM93AgqgHoYI=;
 b=tPCV0dN92sxW204O73RmW07F5ZlWCvt2BxOMhl+S2/9yU9FSIg0zbFjwh9m4QSsTZwqpr2
 nlGvij/oqi8Ay1hYkVHsQC5rPIJJja4l9RXb+s2+8uHvN6kt5z92ubzjX14daEMJzZUf3X
 VSmhN5pUQ3DHsY33ORWljlJ8crj9nv0jEeaHg7qbba0OF204K01ItppUTs6px9XPuykZpc
 HvCSgbhmcl3Ny1PN4wmiXWSHiGOOhfUbQa48+fjxd9AA3A1yNXsM78c/kKqJAFTIwhBgq/
 fXrRUv3H5HSRwWVFJs+tZuiFy5HoXhv5jBYyVEddfeMj39Em+WAxFO1J5UTaAQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Ozan Durgut <ozndrgt@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 u-boot@lists.u-boot-project.org
Cc: linux@analog.com, Tom Rini <trini@konsulko.com>, utsav.agarwal@analog.com,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: Re: [PATCH v2] watchdog: adi_wdt: get SEC fault source ID from DT
Date: Mon,  9 Nov 2026 14:23:14 +0100
Message-ID: <20261109132315.2040021-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260730190256.114708-1-ozndrgt@gmail.com>
References: <20260730163621.83050-1-ozndrgt@gmail.com>
 <20260730190256.114708-1-ozndrgt@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qhqsiifm86k6kzzdiptzznrfsjio5nd8
X-MBO-RS-ID: ce973cca5aefd16eca3
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 7/30/26 21:02, Ozan Durgut wrote:

> From: UtsavAgarwalADI <utsav.agarwal@analog.com>
>
> The ADI watchdog drives a reset through a Security (SEC) controller
> fault source. The source index was hardcoded to 3 in adi_wdt_start(),
> which is only correct for the SC5xx parts that happen to use that
> index; other ADI SoCs map WDOG0 to a different SEC fault source.
>
> Read the index from a new "adi,secid" device tree property so boards
> that route the watchdog fault to a different SEC source can configure
> it. The property is required; if it is absent the driver prints a
> diagnostic and fails to probe, which makes a stale device tree from
> before this change easy to spot.
>
> Set adi,secid = <3> in the SC57x, SC58x, SC594 and SC598 device trees
> to match the value they relied on before.
>
> Co-developed-by: Ozan Durgut <ozan.durgut@analog.com>
> Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
> Signed-off-by: UtsavAgarwalADI <utsav.agarwal@analog.com>

Applied to u-boot-watchdog/main

Thanks,
Stefan
