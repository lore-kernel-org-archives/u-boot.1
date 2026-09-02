Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E085C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 12:45:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B984E6087F;
	Wed,  2 Sep 2026 12:45:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id whB_1vGU8vkk; Wed,  2 Sep 2026 12:45:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788353147;
	bh=NaIma5pUfOPMDHztcykgUcFopYRKZyN62JSmthCM2OY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IY9Vi3fGlOvEHEmn+KUNsnm/UjYmpBHwHzo8RK8X9eloe/zVj4ge3NheusMFA7zir
	 9edk1hahIBB8lnNPVmE1n/ryJl2QgzgiB9WtVjh34P/VLvgZ/0/o/ysLSsWK3aTfKh
	 DhC48MYg9r2RyaIdn7zb38g7W7GK2RetHagEew4uEw63UENhmExpjoEwx6LqsajmgM
	 0a3nzsxhJWskbyHcTO2gtp25j742Hu0DGOKnzwSwNlqkTgJ0UfUAgHMYE9WM2iJcor
	 UxeDV4xTeMtYxb+CmhnjRSPuVaEWpSFIsQBA5UUH6tjMGtprIHQkIfWIdOogamAWEk
	 UZU39dlZRg/XQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEF3F60874;
	Wed,  2 Sep 2026 12:45:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C56DA498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:45:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5A2B408D2
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SR3HDjII08fc for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 12:45:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=mk6B3z8P
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F2D94086E
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:45:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95DD2600D1;
 Wed,  2 Sep 2026 12:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08221F000E9;
 Wed,  2 Sep 2026 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788353144;
 bh=NaIma5pUfOPMDHztcykgUcFopYRKZyN62JSmthCM2OY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=mk6B3z8PB4HE25Fh0poviznyLyYorLqvi8o+z/JgNNU/bVQCJeDgUHylqcbDNXu2B
 OfUXFSY0iytlK5NnKgMu3Gu29gxezEr3YgrGi2odGzwXqWvYe7JVgz1E09wk7Oen5W
 d8XiQTVOQZSJH8EexbcLI0LtMJlt459wVbQ/a8leaXrWS3tJlHhidb2sUTKrKu0JYS
 fmH3SGh5zlL5G7lGCJtSr2NuvpgDwrc1XNVVPIWtM7EOHkwqmBHFq54p6XTvcG/yhU
 NvAcUea6qvNfNisOorpKf8ZMN4czTYa6BUNt1t62mba4w8W8u040KS26lmWST9tlDV
 hBWqSMS3q1/iQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jens Wiklander
 <jens.wiklander@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH 1/3] cmd: optee_rpmb: sanitize TEE_ERROR -> E* translations
In-Reply-To: <20260828105005.200338-2-ravi@prevas.dk>
References: <20260828105005.200338-1-ravi@prevas.dk>
 <20260828105005.200338-2-ravi@prevas.dk>
Date: Wed, 02 Sep 2026 14:45:41 +0200
Message-ID: <87cxuvn7nu.fsf@kernel.org>
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

Hi Rasmus,

Thank you for the patch.

On Fri, Aug 28, 2026 at 12:50, Rasmus Villemoes <ravi@prevas.dk> wrote:

> Do not translate both OUT_OF_MEMORY and STORAGE_NO_SPACE to -ENOSPC;
> we have -ENOMEM which is more fitting for the former.
>
> Similarly, -ENOENT is a better match for ITEM_NOT_FOUND than "some IO
> went wrong".
>
> None of the callers currently care about the actual error code, so
> this makes no functional change, but we will add special handling of
> the -ENOSPC in a later patch.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  cmd/optee_rpmb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
