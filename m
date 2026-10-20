Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216C9606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MlP6c+IT;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=GHdawTaG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE9CD6070C;
	Wed, 21 Oct 2026 02:21:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ysFmsgST2Qej; Wed, 21 Oct 2026 02:21:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D1926074D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549293;
	b=EJanewi6a1oCVxeyTX5e2O4xsRblFuTMM4+vxl0xlYEU8rEnUOp79zCNGjLZb/EURXxk
	 XbaMJ4O13UM1vMcVaXr6UGkrYKCdK2wJdC/BlYUpKLqa/WOy/XMvXob/M0LawW9TYULgF
	 8Hi5JR0bmAV/Ji5DHfsND6/7peTEuzCgqGincYsi6c7M5i9SFK6wO9OYG+1V+19O1qIln
	 HREXTfLYZjaHT+OIPiuv9ubDKpKaMAC9CYfmRDJl49RNNhsXZ4Ps9B4BIRtlqoba35zjI
	 QMymd1wiZk66K7CfPpt4pKg6Q+sTXwJNkyIRg0xFFG+rfX6d+76n1BwwE4jxcQuABMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549293;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FZa+kjvhCGX9p1yrlaEkinztkyVOZGVJgtzhLCuY/qE=;
	b=B5D4Rs2LVExp3Xr4FRtXaCB7ExQozwZPjx0RIRi97mb1xapgv+3n3ClTESJ30JyjF54s
	 l19cjKCndkpGOYD2VdLhP4WZ8m1ct4RKAfvVCso26qxXlSqoxT+FV6hgquKsDR7/MmHKC
	 /2XwHumUJunEa3P/GdiGmMuxuT0jKvSCT9WK4G3AIa8qkjzwoWqGebe5f1as/ypSvS0dg
	 Ep2/aPFSV21u439k7DgGckk52bRNJXVFneqIleGw+Vm575MNvoVgWESTwmBRijhAnBTOJ
	 5fJDmXa73a3YVXff2OVZllcRrC8K2dtlrb6famZCYCwdtN+CPpchgvvBoPKlLSE1cOw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549293;
	bh=FZa+kjvhCGX9p1yrlaEkinztkyVOZGVJgtzhLCuY/qE=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MlP6c+ITkV5mVDJxk4k0WkPfpYk4wWcrnUM+glD4b9s4vOlFbsIx3toO/0xRITMTF
	 Bc/omemjyAploerhzbbkIFg0pv6B3MZdM4kHCBKODofw5QcyhZflLZnRYXJywWeMgO
	 HEPezlCXmqsYFovhvA9W1M+tjzOK0IFY+GndwPPgx5WthX/c6d1VNq6CUud6PgDgNx
	 BKS2UMTRjtgHKbL2tGIvRsIogH4CKkjlO6hecppS5TWSMMGHeUSafo3byQ3BKqmeer
	 fOHmeJ6w2BrSz5AD7hWCouBYl8N6dVE9w9SUDzlpdbH6/+SwDefWJ7aO01uegschMq
	 n35uo4cjlYn9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D1926074D;
	Wed, 21 Oct 2026 02:21:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE0D93A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFA1F407B2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dUtYa2Df_FtR for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:21:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0A35407AD
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792549291;
 b=GB9RB9yWvIvijOr7wlfPZizb6UcZajHPIqGNXHVdqK4WWD8dK+dpZOMmA5p++f8DR7ud
 gAJYwMqpT1p6hiex6J2RfRH9Kk5CRbcXaqsuxLwTYkC5ii5TEO5RbE6GcOZ8Z9h15QPSE
 crEDlYqyvh7LypzE0wQgoC4K1CXTcXhMObQcQSK1lQyN4d70KvzqosTyrk9RII7N5XU7Z
 TSg1pbKMszYdRpKyHaA7PS5ghUnaoV5yFVWfEM1VIdUnW42Zl0DOp9noKaPuJSJzMD9L5
 AQwDaNniLm40+lB2L+osHo6eKw1yIjIdwWBmVyaB4Ko2zM93vXBiOE0NZ90cI2x/eZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549291;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=FZa+kjvhCGX9p1yrlaEkinztkyVOZGVJgtzhLCuY/qE=;
 b=rTYEQqPCLtBUhe4TVm9G81heXjtAuttGn7NSvdDyRu2WL3KjlnuzfMUHwealx59zYy4M
 gn6hMQxR7Bb+J/ElFb8K2pcLHg4vIUJpe/8tnWq1ohBTnkT/8ZP31BjONldywlh9nn3uH
 PhH2yiNSansTDB5q3n7TWpVKaeTI0/uA8aGtyNRaFOSf+13perkKt3K3DBzZ/9nPhfPDa
 jCaNTiUvzVuqZnNg4L2jOBmw8Njr7gbeWTYILytdpd5GQ0C8QRSi8QTAlVwZrJ5MIfDR9
 I40VDGxV9M3qwow7y/H4Root3xogs2pVyN8MIRQeRLkBEmm6LuPfVToy3ERAQQRaMPg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=GHdawTaG; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=GHdawTaG
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0A35407AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0E70310A36D; Wed, 21 Oct 2026 04:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792549287;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=FZa+kjvhCGX9p1yrlaEkinztkyVOZGVJgtzhLCuY/qE=;
 b=GHdawTaG/jqK5aMuhegMBj7xAIpsheVtlODz0l3KQdeFjxQ3/rwUE7lQ7S3K7NU5EGrFZv
 hz7LiPkQUQJYDT921Os/KVgWKvJpGe1cONfDjjQHViYrOrsfppjv+9028cUmC+RP1CtBF3
 57sLwd/DxymMWXiFl2qjyiUfgaMNtOwUDYp2auegObsRKpf7MyL/rhOn4tz1mbHMimXJTT
 HjMriD8eS7dRkGXvqWyHVrvjZmfV1vY2Ue9tMebqlR967idtoe4WXSVhocq5gYg3vRBbOF
 3a7Yc1LxPfjLSTaxKkQQf1tInlthkOaSOmPivXeng8+rF8FSsPregJI5uAkybw==
Message-ID: <57fbea68-b608-45f9-933f-e9f28cc118c6@nabladev.com>
Date: Tue, 20 Oct 2026 14:42:33 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
To: Fiona Klute <fiona.klute@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261020112358.523872-1-fiona.klute@gmx.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261020112358.523872-1-fiona.klute@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 1:23 PM, Fiona Klute wrote:
> CONFIG_ENV_WRITEABLE_LIST only restricts loading stored environment,
> not runtime modification e.g. using "env set", while the Kconfig
> description implied otherwise. Describe the actual behavior, and add a
> note in the documentation.
> 
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
> Changes v1 -> v2:
> * "can be written from" -> "can be loaded from"
> * clarify that "env save" will also store non-writeable variables
> 
>   doc/develop/environment.rst | 7 +++++++
>   env/Kconfig                 | 5 +++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/develop/environment.rst b/doc/develop/environment.rst
> index a7ed4aab0a5..c402ee026f7 100644
> --- a/doc/develop/environment.rst
> +++ b/doc/develop/environment.rst
> @@ -89,3 +89,10 @@ an association in the static list.
>   If CONFIG_REGEX is defined, the variable name is evaluated as a regular
>   expression. This allows multiple variables to define the same flags without
>   explicitly listing them all.
> +
> +If CONFIG_ENV_WRITEABLE_LIST is defined, only environment variables
> +which explicitly set the 'w' writeable flag can be loaded from stored
> +environment. It restricts only environment loading, not runtime
> +modification using "env set", etc. Non-writable variables can still be

s@can still be@are@

> +written to stored environment (e.g. ``env save``, or ``fw_setenv``
> +from a running OS), but will be ignored when loading the environment.
> diff --git a/env/Kconfig b/env/Kconfig
> index c6df09a3349..394e91833a3 100644
> --- a/env/Kconfig
With that fixed:

Reviewed-by: Marek Vasut <marex@nabladev.com>

Thank you !
