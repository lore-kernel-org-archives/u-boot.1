Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FD606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vqscX7WI;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=FeXIXv8R
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4EE180C93;
	Sat, 21 Nov 2026 12:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8IAHGUe_UbRk; Sat, 21 Nov 2026 12:13:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D685A80CA2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795263199;
	b=qj21OVfnoqnikSEA7lNCS57EwklEVQBlAkxF3h6t9z4H7OOK7VYvFKEn4lIE2p5i0v3I
	 2EW6QEl272BhUOd5EhJNw96B5m6qrFNtnqJuDE4M1m6M//D004b5SI3m6wpCEWHPo7FvK
	 olR0WiPjT2gZApSc55B2dLHGBcJGxzEs+uNfHwe+R7mxWqzhXTypnayOg7nbaLlDDTh4e
	 fSw4Jgw70D+xYBkCnN99vKFiGXpCqDb6k1NkE0cqG5EyK7wtXPoqIZ3L7Cx5JEOwOUu3F
	 NsShDOUeUZ01S5okCtxvbn9QiXcG4irFjbSeWNZdAzqegHOvxxbTq+txIfIPMDk33oA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795263199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PI8SJoZeBKHVo52vVv95v6j6DzJvAs1xsox57b0Ojls=;
	b=gOB8rOeZyj/IgeIF0RHkBv4ScvivUr5W7NJ3j2Wuk0RmULnjDhBXum7iOqdIGP6ard9O
	 xckfzPQhc5fyM8tMWzu8t9o8LFOVO6wRMdInvnNwHc5jo5S08Loblh6m7jkGvAciOsoVa
	 F2U7AOOEPhpi0ysKt9xSlbTQny8sqWxeG42ESWDex5gu5LVRKtdFBXxVfaW4xEb/VmScW
	 64mJb1ehUXXDf6m23+NB3aFqyZHYQl/S5FILCUfaax9uqMD0bjg2Jgft+ZoELQ/z8b2Zq
	 0bdPLyS1HWkufIWdj3T4eI1uwu59/Mn6g5Flr1HBd7gMNdb8I2ihh3d664PLoclNrvg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795263199;
	bh=PI8SJoZeBKHVo52vVv95v6j6DzJvAs1xsox57b0Ojls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vqscX7WISpgxRMS54uHJePmth6oAhi0VbInoSlrxPPqp1NJRrFAG7mzhvpiz0F+Mu
	 FHBHOjVskMJv/eXnqct0pwOqbYXitzyV9+X10U8yQVUAi2AVRkusCEUZzLpzEj8uYt
	 h7xQi5lF1dx04q4/YSbIYdzLygiRZy4lobcq4bUV51zcD+ezMmfcdHovh26jJivTIt
	 quD+OqYW0Ws5QbzzB0alPHmTfa4buOklK6tDJ2PUEFF718D+tYjf2TN72mZsKEFxN3
	 IHRzNfMMEsKZw/myZlEABjUIjzX5d9tHKyXyO7sMDQrf+Fxn5Yy7kaPV1zbbmwRb2S
	 lYzQUVtheE3/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D685A80CA2;
	Sat, 21 Nov 2026 12:13:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF589465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B145D4077F
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:13:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lg98TZi3fDt1 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:13:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC68D4071C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=FeXIXv8R
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC68D4071C
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:13:16 +0000 (UTC)
Received: from L30177.local (unknown [78.240.64.50])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id A8785B0053E;
 Sat, 21 Nov 2026 13:13:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1795263194;
 bh=71Cy8paIh9jmW11eFMXtAdcJvjwYi6lmO0A26eY8e7Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FeXIXv8RBo6lYYEpG6bWK5edpnt+wZmpwyPXQdelIxqIi+azCIRWO7NBFZe+ot6/A
 lFbhv6oKyNfq+J/gBeEbdv6NXIk3cFm26qCQl+dRlJoucGMzGHf0e00OFZWKgkTSUX
 HZg7wl1IsmTvXJ6GvX6/G+w0lKHoo1ENxqnf9HAQzzMHJRlwlu71vG+40a/BuUQAVa
 CMXyqgk8WrskN4OJzLObuXWUHFSRorYNFhmx2DHKt3xKICr3ojXDivgtJCWsGJTBb5
 ypqwUf0Z9WveFfKucA/HmhIARUzEwg34fjIR2975bAhWBD4vydBXwGNbPP+cU0L93K
 bDZzQzJS5W0ag==
Date: Sat, 21 Nov 2026 13:13:01 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Denis Mukhin <dmukhin@ford.com>, E Shattow <e@freeshell.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?utf-8?Q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Subject: Re: [PATCH v2 0/3] dts: build the DTS from a directory outside the
 tree
Message-ID: <awGKzbCCcVmdyj1R@L30177.local>
References: <20261110075256.1800130-1-vjardin@free.fr>
 <20261120174649.GA1006920@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120174649.GA1006920@bill-the-cat>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Fri, Nov 20, 2026 at 11:46:49AM -0600, Tom Rini wrote:
> With this series I now get:
> +(boston32r2 boston32r2el boston32r6 boston32r6el boston64r2 boston64r2el boston64r6 boston64r6el) scripts/Makefile.dts:37: warning: ignoring old recipe for target 'dtbs'
>
> when building for those (MIPS) platforms. Please investigate, thanks.

I understand it was a legacy issue.
I did provide a v3, https://lore.kernel.org/all/20261121120445.3795725-2-vjardin@free.fr/

Thank you,
  Vincent
