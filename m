Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADABAFA1FE3
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 19:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8B384370;
	Wed, 22 Apr 2026 21:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XgsBS/bo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B3584372; Wed, 22 Apr 2026 21:05:39 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1371F84227
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 21:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g17wH5R18z9tjW;
 Wed, 22 Apr 2026 21:05:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776884735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPj0JE4stBdtsP70qKDRybVtPM88YIJ1EtqA67DT6sg=;
 b=XgsBS/bofkJxeOD6UCkyW3T35iXecO2/Th/8s37NCiksbRWoF7tshrcSD0jbb86dGygVwk
 2RaRd8BEISAGVBJTFzGKlDafTiWFEOWsY0GOIVWWnKur1rJGLJ4lR/pMbsANFnWJNeQtAk
 /iMw9LT8JoAZmQxWZMUbHddHksP9pa1YKW/nc05fOzaKgHk6CnBy442i4XP3dKrsMNUZZ5
 3yKjMTrB6+gEhEiysh7mrensMDw3zrsgYk+HSGkoDUDwPlO1zRkc84oJIGs4spxg9gqz0e
 yrfSSN6S4xjoniGkQmxK/kLCMNCkfGRJMvRVZ3YKsJAsouvQWUbwP8ydJlXXpw==
Message-ID: <1fc9a89c-d660-40a6-8245-9d3dda7874ed@mailbox.org>
Date: Wed, 22 Apr 2026 21:05:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] misc: Add RZG2L OTP support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Tom Rini <trini@konsulko.com>, Paul Barker <paul@pbarker.dev>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, u-boot@lists.denx.de
References: <20260414091422.16952-1-othacehe@gnu.org>
 <a0bb44a6-1805-4c0c-b7a5-0d9d31f9d6b7@mailbox.org> <87wly6rp7f.fsf@gnu.org>
 <1f4fb105-9f77-4dec-871f-00d90fa0d169@mailbox.org> <87o6jb1gjv.fsf@gnu.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87o6jb1gjv.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ezhbhndzsewr6mskpj1r8tfnpzftzcp8
X-MBO-RS-ID: 7319b40fbd09e9da2b6
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/22/26 11:37 AM, Mathieu Othacehe wrote:

Hello Mathieu,

>> How about adding a new node into the DT which represents the fuse controller ?
> 
> I did that in the v3 :)
Thank you. I will have a look in the next few days.
