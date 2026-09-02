Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7648C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 12:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E4AF80F66;
	Wed,  2 Sep 2026 12:55:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R8fqUsVqkcuj; Wed,  2 Sep 2026 12:55:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788353753;
	bh=Ews4gHDrEozNQrVEnsjns2baCuvDnuXZZGeKaV/rVzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LV5ppNDRw+/lVVXSiq7B+mcpBHerCN2dGm1Vusm+KpMsET6HqFS6ATApavkw4r93q
	 CJM5kIXoU3AHh709+GT/rVva/ce5R4XjTDayAJd2aBK0QFZYwncka2elejfRVb6NPl
	 gg15DlA6wAsnEOIw09KBIKlA+UoX/3tJWcpScYwn6itK3UNu61ss0icSply45TT0Rl
	 gqVn666qa3beUuJlVpR2/Zyk1777nKusCsmLefWSNT7mL2jpSSQJay49Digj6M6DNf
	 /djtXYD1yqWNbgcv4R8HbzSSpJnuTnNbA6WshmUmtQ0BgAzCMdVNreTLH6BH8EHs6E
	 X9aOVpwDEZgew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FF7280F5A;
	Wed,  2 Sep 2026 12:55:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 411E8127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27AE16070B
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dG3_a4qhX_Zn for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 12:55:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.21;
 helo=mail-4321.protonmail.ch; envelope-from=rv@rasmusvillemoes.dk;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=MTmcU8Vl
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 46585606F5
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1788353514; x=1788612714;
 bh=Ews4gHDrEozNQrVEnsjns2baCuvDnuXZZGeKaV/rVzE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=MTmcU8VlZaVd2UA9hS2RrzjyKJjvTg/kbAONKxIIi51cjN3yWqp2O7z1+xKRx5D5Y
 e/GQ2+z08AF9D0XQEX9nM+b/POtQ9xRoFP6Q0pQkHTJvPv+cI3gt7JFAJShPEkMXJt
 xnJrWA3xOd/6MCs06ocM0nn9ZWBEJD/RgPP1jzAGdIghxS3SY7lX8pqwqf0zjvgDCW
 Tndpc0rJM6KdaehXmwVi4VWhjPh07hI14WYYD2sh+CgpvtWG2IqSWWKGyMr+UAW9AV
 KbXJ7ZeL4TtkrMbNcNqPrXzSBvr4bIVfTrx1LjbJkiXEBEa8Hyu3eFsy05WJZ97ZdM
 ou29DNuWTrHjA==
X-Pm-Submission-Id: 4hZjKj17Bbz1DF55
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Mattijs Korpershoek" <mkorpershoek@kernel.org>
Cc: <u-boot@lists.u-boot-project.org>,  "Igor Opaniuk"
 <igor.opaniuk@gmail.com>,  "Tom Rini" <trini@konsulko.com>,  "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>,  "Jens Wiklander"
 <jens.wiklander@linaro.org>
Subject: Re: [PATCH 1/3] cmd: optee_rpmb: sanitize TEE_ERROR -> E* translations
In-Reply-To: <87cxuvn7nu.fsf@kernel.org>
References: <20260828105005.200338-1-ravi@prevas.dk>
 <20260828105005.200338-2-ravi@prevas.dk>
 <v4mSV3qbM_Jr5WUA5V4XrfeeGvO5aSjdqEkiMVQrQBvcxy18KSUccAzMUicBxvgRotlKSH_Cj0JI07EbrXu4zA==@protonmail.internalid>
 <87cxuvn7nu.fsf@kernel.org>
Date: Wed, 02 Sep 2026 14:51:52 +0200
Message-ID: <87tso7ak9j.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Sep 02 2026, "Mattijs Korpershoek" <mkorpershoek@kernel.org> wrote:

> Hi Rasmus,
>
> Thank you for the patch.
>
> On Fri, Aug 28, 2026 at 12:50, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
>> Do not translate both OUT_OF_MEMORY and STORAGE_NO_SPACE to -ENOSPC;
>> we have -ENOMEM which is more fitting for the former.
>>
>> Similarly, -ENOENT is a better match for ITEM_NOT_FOUND than "some IO
>> went wrong".
>>
>> None of the callers currently care about the actual error code, so
>> this makes no functional change, but we will add special handling of
>> the -ENOSPC in a later patch.
>>
>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Thanks.

Note that the patch on the optee side is still in flux, and I have an
updated version of the U-Boot patches locally. None of this should be
merged until the optee side is sorted out and merged.

Rasmus
