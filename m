Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6606E60A2606
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bWtVpGZ7;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kFJHmsCZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4014E40A85;
	Fri, 30 Oct 2026 13:00:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WTS3xZ3z0QAL; Fri, 30 Oct 2026 13:00:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39A7C40AE5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793365200;
	b=MefmlOOvCYgJfwUdxqELAggbczOH0dY2sJYa9a+gP8nHF4j5rJSxzPcgmBQ2sZHvIQri
	 XLz6YubRejQdSukedY+fKZzppDHi3cSoEJqsQ6+vwLGlOqJW0rGJuRSc18VbK2z2hd2cD
	 Hgz/QnL5nvntRfrRBPcAZ/+1jB8DXlV2fseC5W3rZ+IU2bMb4pGaUUoUxzneLZktGpLjg
	 iwjbzygfD00lyA2HIWostQYToOZ2MOMB3MN2Xtn+Pz6cyQLqHM7LYDuV4B+IalOXDJIuC
	 CGp1oAQpNsbAopcHSyX/OzzhBwhmWW/ALO06dXoqHt/5VTT6GCs1+YtM6+fOBQxEH1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793365200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-Last-TLS-Session-Version:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jv9BC8iYyvEPpFjvcIDE1Vs2+LQ/TBUpqfJsUUBe6xs=;
	b=aU+RF7JGq63p4jWyF1FonaMnfQOeFCbc9e1Qm2MPeAmKLHenO3bRHYRVM7TlT7Plb+DY
	 27QLnT8WVLVkFEvzIGHgIewGbesx5OUFk2T5I83hqDzaBRYtYI4g57cPVgQib4HGpdHX7
	 qidLiWXDaWoSuJY6tVA7Bc26rOnoeujzC+TYtsk1Rp5J9FcP3awCYWorOM09fXoap4aJ6
	 bJlE/vhrE0bzmwPh4ClKCVteshhBvzoALxJZvZis59ZSOwTUT4vTPeWzUAmx88irShwf8
	 Ms0VHh7eSPQLYQE6l/rtIvpNxUOZ2Mt9Q9q1ZdJUG2Mtls+2+KJVXtBO7R1DNoTHsfw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793365200;
	bh=jv9BC8iYyvEPpFjvcIDE1Vs2+LQ/TBUpqfJsUUBe6xs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bWtVpGZ7rRFs6bgl/RBYMMqXc17JkCZutBNdbLlKUbg6nXeornO7TzaVXrmY2Szgg
	 Np3wzHW9D17PxolbceB6I8oY+9AgJOV69YKbNU426CescELT8XEd4fwI66PkG9jOtV
	 KcX0/ixLdRjMEDCfYQO2lOPYVYNsmJREXLILoMhNWrdle9BzX9cU/mPMgOSdhllOqv
	 JhEoFjuM+Kxaakdv/Q+EUtzUm7vT5mNe8Xj5VXi20cLJHFNDJzayTOM595F1P0i8Vv
	 wkD1BrKNb3B5xXHQDCTakwc9RJ4lud5iPPCuQiekh91PGZwjruICMsoSP/EbPcbSbh
	 4mjJGkaUWRXMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39A7C40AE5;
	Fri, 30 Oct 2026 13:00:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F07252C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5A214008B
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:25:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wUq-4bd8l2KR for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:25:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8215540063
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793352337;
 b=sYpW7/is2vnR6nJ2Z2P2To/A9SruHsdsPV99mRguH7cWKMe81fsGBEmqEjtxKJE68wJ4
 GMVejorfCLd5pQdIFU1EMJhdduyy6zOSHGDtg6y0XbWi71wiMPpsXi4RMv6tJb8/kWJ8J
 PVgvqfSxESDippIemBz/5ea3Tkq+077+LrLUlF0lHPApJ9gnqYvbmRphCfAwvbhegsf74
 TU3yJs8TdBAQhzQXxF8U7KRq4RdxUMaNVWR38wkPHun/pQJdHfwwfmShanX08/KuC4sUl
 YWTWYNgFqySrK44wTm4jV8cxDoTvqsAAUG3yYX6h8FhUEM7VjmClLDdKBLCbav8lRdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793352337;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
 bh=jv9BC8iYyvEPpFjvcIDE1Vs2+LQ/TBUpqfJsUUBe6xs=;
 b=pnJW85Epz21tQXn5urs0SJ8DGC6Va6G/phFdFeUtC0biSKWY398/As2aQrESjADPIFOb
 9mFotVXZfX8dU+hXxnpGX+TolLygOVZWz99R6qnBlXwtOgQSmG6zVnw2a14z3g834QR0K
 MzVfiZoi4jGlz09hh7sZ1/rr2K3Zca70xW7vEuHOBqGQqpwkI85nCCawYPk0fZeygQf2+
 g+hYJtlm2szZMtyNgeF+UPqO5prbu3p8eFahjnCT2YtGl06QZggeYtZ53CuhwcDs+TzNh
 IZ/jzgwl3OBGIRoNrosXuaxvxLwiCar7bjCqymiPNzxMV2g/mp4Krn4EO22QkfuOjxw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=kFJHmsCZ; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=miquel.raynal@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=kFJHmsCZ
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8215540063
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:25:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 087E41A13BB
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:25:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C7DFD603C2;
 Fri, 30 Oct 2026 09:25:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EDDC2103287DA; Fri, 30 Oct 2026 10:25:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793352332; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=jv9BC8iYyvEPpFjvcIDE1Vs2+LQ/TBUpqfJsUUBe6xs=;
 b=kFJHmsCZmanX52+gROEjWQlmvglb7hriLwqOV3+GdMGR63Fz4xjuqYrkBKTez0wTXJBMCN
 uAS8E+r6yKYabtLs7ut9i65OYWLKxKHSBVEjmMDZ1zDStXIpMIqwqMnincaFuLcUbVMCQo
 PLf6fPz2BbhOfhDF0V1gxujSbvAT8nPiXROC1AULmtp9hOzbFsCG9effDJ28Gxo1M4sdzN
 m3X6waMCjRr1UJdm2YKWBQdm1/UkuKGp522oSIWTAIQU9BMG6xQtmlzhezPnlFf/lAoiR+
 nK9j0QcyjZ0E8aRJ8L3w3Kn+WBnJkHTOleYv2Qf4p1g9vlsrD/+UPWnIcpq2yw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Oscar Deschamps <odeschamps.mail@gmail.com>
Cc: joaomarcos.costa@bootlin.com,  richard.genoud@bootlin.com,
 trini@konsulko.com,  thomas.petazzoni@bootlin.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] fs/squashfs: fix NULL dereference on empty-directory
 lookup
In-Reply-To: <20261029153940.461197-1-odeschamps.mail@gmail.com> (Oscar
 Deschamps's message of "Thu, 29 Oct 2026 16:39:40 +0100")
References: <20261029153940.461197-1-odeschamps.mail@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 30 Oct 2026 10:25:31 +0100
Message-ID: <87bj8bee0k.fsf@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 30 Oct 2026 12:59:42 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 at 16:39:40 +01, Oscar Deschamps <odeschamps.mail@gmail.com> wrote:

> The three directory-search loops in sqfs.c use the local `ret` to tell
> whether the requested name was found. When the loop runs zero times
> `ret` keeps the 0 left by the preceding sqfs_opendir_nest(),
> so the "not found" check is skipped and the NULL dirs->entry
> is dereferenced (dirs->entry->inode_offset). A crafted or corrupted image
> can thus crash U-Boot (a NULL read) while resolving,
> reading or sizing a path.
>
> Treat a loop that produced no entry as "not found" in sqfs_search_dir(),
> sqfs_read_nest() and sqfs_size_nest(). Found by fuzzing the SquashFS
> parser.
>
> Signed-off-by: Oscar Deschamps <odeschamps.mail@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
