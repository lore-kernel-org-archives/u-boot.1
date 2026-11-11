Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA5606A327
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eLNaaNeC;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=LTSW7L80
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2EC86071E;
	Wed, 11 Nov 2026 08:51:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nnF8tpIRIt6l; Wed, 11 Nov 2026 08:51:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 043A1606DB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794387103;
	b=N+0L321v35Fjv/XtLp+5/42JcyOEm6C26hY9sBZ4jcYWj8koHSkhMviE+0j1Pe5ireSF
	 h2a5lNnxgHRmaOjXhoFNJMDqZOdkI6v74Lmr8RQ5Fgu2OmdceK820deUnu9BQPABhmBtK
	 8ltxSefSWojjjJaEGMZ2MzM+lA5CERnrN91vay3TTj5biw9qZSONY5L3Ee4ZBt139jwUT
	 yyfo1lRoh7Cdf4KOpq3CGqIX5ocSEzUk7M81J13MlBoIskgRoycwhiyDVGOWy5YB6ar3Z
	 VZC4wd95KE3E4wNh6WR0OGkohJnaYVVT3L4PyI7otn2y5zBPpc3rUD3OKYTZtOApvOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794387103;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t52AIVyWWEFbd1M/BOFmfRvyWUpNQcoWWqvLRxexi0Y=;
	b=FsNS3BqhbWn0LylnvI17992zfgwyGRw70CzQc/DlajMfn9a4qYLAYaQ7oA4MMishMWu/
	 O2xiDsAUQiPKhMkg+u7gFmlLyL1r6LwsUaabPsfKBFAE8+nAViIkmejKT/CCvgBx3h2Xl
	 oi74HIOEhgilBiN6vhMJx9xGEU/YvuncQLlJU+qT8GxYJ+OCRwfVDqU688+tfJLRzpIHb
	 ic+lL2WJSNq5iThBxROy5877jqKhXFLMjQDToBsTvGW9vqrJjFaGx5YzzcOpFjeCHo92P
	 /qpDSaSc1rxzrOBPAkmWAAfrSQXxM0ERS8W7hJoaKLIYlI2fP6kb7bTc63fcid5mMWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794387103;
	bh=t52AIVyWWEFbd1M/BOFmfRvyWUpNQcoWWqvLRxexi0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eLNaaNeCBxQN20g6aCgS3RcAhFDdqRFrd2C4rROtdrcIAcwyKWPrYNQnixF/5O2hd
	 HV9oOkLruyuXMjYpDiAq8oN2VpUmfHqjtt3ORo9+tpcThicSRt/9FOaQJCIRFNc9Fl
	 TsYhKU41kdMjH7F3XlbBRmNxoFwVWzHvxebH+I8FDpybaiiBoWKdJvSiNAI41zqcqD
	 bmMirc2GGU7uTHxaLNnN0CK2E7EJaFXXdHp5OmpgVC9iEeYzRgVMSF7x0tXnqAa3J+
	 AhKrr1t4BoTfZMmbW7EyS890NgR3V8UdE2CxLSroHq5rvq5wuAvJB4N+wpacrqVkaQ
	 oILTZiHm+Og1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 043A1606DB;
	Wed, 11 Nov 2026 08:51:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF1632FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B546B40847
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e6Mt68j7l8Yj for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:51:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BC8894081D
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=LTSW7L80
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC8894081D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BD7A510DE48; Wed, 11 Nov 2026 09:51:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794387094;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=t52AIVyWWEFbd1M/BOFmfRvyWUpNQcoWWqvLRxexi0Y=;
 b=LTSW7L801I7oYcmMx/ypsWFnY/qecfVwFOknOIZQZGsJUbSZ97P6qR65+G+hXdWRYoAn1d
 TvjdE8bS8NzZdvjC6KyAynDpZIb6oKViN+DwbMpEvMUOLTT1RmXn4VcCj6ij7CW7STkLQw
 twXZEr/64dVEoXcYGq2DRxSYplvBUUS9PMVelPNb6n9jcjunxbdr6R6Q2lvkuThPf211LV
 R9Hu0rgBrHvS0wCy1eW5DMQhUL2n5OryyFhAtleuTsXDVR+vIVRv6SBZuELDgI/hlhGRaQ
 f8u33cEuIZwgAcRkeIuL4Ff7i2qIpfTTr3XV49OwMEnaMhGKqvCKgCoh8oLJog==
Message-ID: <1850e1c9-e11a-9681-112e-1b6bf7a2b551@nabladev.com>
Date: Wed, 11 Nov 2026 09:51:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [resend 2/2] cmd: i3c: drop unused includes and skip empty device
 slots
Content-Language: en-US
To: alif.zakuan.yuslaimi@altera.com,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Tom Rini
 <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>
References: <20261106031830.13625-1-alif.zakuan.yuslaimi@altera.com>
 <20261106031830.13625-3-alif.zakuan.yuslaimi@altera.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20261106031830.13625-3-alif.zakuan.yuslaimi@altera.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Alif,

On 06.11.26 04:18, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> 
> Remove headers that the command does not use, and skip NULL i3cdev
> entries when listing devices so a detached DAT slot cannot fault.
> 
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   cmd/i3c.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

@Dinesh: The patch is applied to me in patchwork, can I move it to you?
(Please send me your patchwork username, thanks!)

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
