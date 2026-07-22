Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904B6C4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 05:39:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 090E36071B;
	Wed, 22 Jul 2026 05:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AVtdJ3BOv9JR; Wed, 22 Jul 2026 05:39:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39D7C6071D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784698745;
	bh=FxEA+XsYS7vLM73TnJk0dH8vfAZkgw51VqiRsYvviQo=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dEdRIoBkcGLtHLWgD5ZV22assGq2EVMVnUIVeAu8I9NotiLup7UC1xrXz+fVMLGCq
	 /VA0ejjX3Ws5lnYCwes3m2bZmgyrBct7xPKtIhQUaMgt0upnxIFnzfL9e4JYV2PP7A
	 AilwPYCSSYSe//vTxcLTY+lit9zSwbn2kU/HQ62AzQSU0KEXPpTTDKm2sw9JhGS0Yk
	 D8E5xXQ5LlMIYXSzKB0SN3L5mNzK2a8H+wqf5fZINCpR4rwTNsxmVN7SlwjKiPaTbE
	 TliOXW9ElZHLZIgqoWXgmPOz/OTvjrFc3G14jcbSVx4ydMxsfhPO0y2C5o8Wwg0LPj
	 L7e4LXzJ09hWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39D7C6071D;
	Wed, 22 Jul 2026 05:39:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8FC442A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF0356071D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R9m0wus4LZ77 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 05:39:03 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=advaitd@mechasystems.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B87C86071B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B87C86071B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B87C86071B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:39:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C134848BA; Wed, 22 Jul 2026 07:39:00 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D94803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 07:38:58 +0200 (CEST)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38df94d4dd8so6401717a91.2
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 22:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784698736; cv=none;
 d=google.com; s=arc-20260327;
 b=fqmFDH9lQGm8aTrQ2okRZXJzzIgCgeLa6uro4ABdjWlmlmJ15g+AnavTRoDKAAOuCa
 GwytgZzYjKMvMZ4gZys1nml8SYQtbjz4Q1XXOrE2kXDidNIfHytjioK2Nm+bbBK2JeIq
 KJ0jl53NRkHVBgBhf7hsKsiQIm8FpGqFlFgNVsFivnd+V/DyLw50IEPjanQ+2FLjSrbA
 MQS0CJPkF0Vxc1bOjurYGHk3CO580boirg+OAuDXJXYAs5f7/85nlHZqTovK+4FJ1ULc
 9kSUgqmnAdPhWZqK0QsWT+r9z9zQc0D9jWY3Aj1WHQf0XG4cN2lyAoBNPsGycbZBXSWd
 pV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FxEA+XsYS7vLM73TnJk0dH8vfAZkgw51VqiRsYvviQo=;
 fh=EMNcP4QWO6ObukPpfU9GuxhtFYYTqKLA3gJyGTzlBh8=;
 b=YZzkZ7jdvGLVGtMrvnyljM5kKKfS9g9SG5WH9RYEWg1l2Oz/OjU8YwMAN2oA0uFydk
 uNEdBEZOohqM0MA5MR5l2luC7SPhlvwraQZJhK5dal5xlCQd8XipF6LfIJ6VQjNza4dC
 q/hqBDVgzGsg+AFdteM4lVLnw/gR/ivnOPVAAPcOv5aFyxiaYiHPQEFI/kQrWF3lIHGO
 r62w3dzDI5+IOA748agmBk0G66Z+X+Bsi02qJYYJ5pXl+t5yeOZ7aQPcVHnF727b1CMq
 Np2Gn285Pn6eY3V1uYq0BV0orjMZDZ10ks9JT0gDIAd0IH0ppN/v7p+jV9XwOMHn5CHE
 w1lA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784698736; x=1785303536;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FxEA+XsYS7vLM73TnJk0dH8vfAZkgw51VqiRsYvviQo=;
 b=Xp1YH4VaLJUZIkhUBjXyLDV7B+SMR0YxVIAEFXIT/2U1bCmkbp00jmfUiX6YufQf2r
 XZ/lwHEMecLNp2Izy19q1xv34WbB3nqnj0pGDPtJ15YRHXQMGLqcQ5YZnQUNpIRum6jb
 rME8Bjl2niassm+2ZwBFakwViMRr271+gkuG4nGTTWfxl3Aq83X/+3brP24XbIRNNpqx
 XYSToMBD12/RQ6bZGHL9eKRlTluLIrfis+upa2N3FhuMLDMrOJlmThcZz8NjlMMoMg5K
 8cISINLP7TdbDRERU5TArFXjgwZSMz79vgrSkbmxXLADKg/4qAoW4GGwT2ae1tkkmY30
 Nzhw==
X-Gm-Message-State: AOJu0YwM1N4jROu4/K/hIQm6XenVsiPZ53I5081PGjCKPbYlHnlLRX19
 DiGhO1DjG/hJFe/rCOz4AD3AdWQ+glkov3TeS8jIf0Jght4h3xj6kNneR8/Z58lbgT6dXxeP4R3
 Agvp1bTITlAhZClDzDEx0OrOB+sSh6ZiBU2LWWMLw4g==
X-Gm-Gg: AR+sD12GM04agYXXNzRQqL75e7MbyqlNnodgUv06SAUrlnRhqrHbFxqrP+YbG8BvPQ7
 GHervx/msRSs487V3024/prrHegYoQ95+X3kwBNHYqcszQb0SACorW3VRM6bZk//AmTUXF9etXF
 5UQPUxbvdtdePA4Wq0IeFjCtf/+sd3B22u+CBZ4WjZXl3zAMHpTBkiA0JVENvPBzOoUy33HTcp0
 6sOzEZlyk+BnnuDM4+43SqM/FJTgXLnG2N3cTmgmPt2YFyDn2Vac7rPmBR/4yJNZAPjK+Onkg==
X-Received: by 2002:a17:90b:5605:b0:385:d033:d9f1 with SMTP id
 98e67ed59e1d1-38e4b5058c3mr22614498a91.28.1784698736360; Tue, 21 Jul 2026
 22:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260716110318.97757-1-advaitd@mechasystems.com>
 <CAPVz0n0zSAwzx5=xTBcitECQnmrjS+Fh5UboFC=igup=Sump6g@mail.gmail.com>
In-Reply-To: <CAPVz0n0zSAwzx5=xTBcitECQnmrjS+Fh5UboFC=igup=Sump6g@mail.gmail.com>
Date: Wed, 22 Jul 2026 11:08:44 +0530
X-Gm-Features: AUfX_mxYrX0PxxbmRbDKJpmRtNID5aroZ0Q45Xcsrps3fZsejeWrz3ZT1gB0x2Q
Message-ID: <CAAPs2HR=b1YTiSf_3t0Dvq07vK_41svYFpb=Y3AGmFKxVSnTnA@mail.gmail.com>
Subject: Re: [PATCH v3] video: add ChipWealth CH13726A AMOLED panel driver
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mechasystems.com; s=google; t=1784698736; x=1785303536; darn=lists.denx.de; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FxEA+XsYS7vLM73TnJk0dH8vfAZkgw51VqiRsYvviQo=;
 b=v6VXjkMcg5OPltde2zjHhYM5kBhSWzpG4MhwEoVB+mRFvKcz7UKqIfuvRZ8xMyzqIZ
 lgiVdrnGtC4njkkYxbydrxgRe9iHWsxxZ9oVG3vZepry1lV7Mpn1JGOpaqrFcw+q8yte
 5EefN3RsAOYqfQ2P1rjQeR/ZmJx9fTGxOg3t7WNZ6lMe/J/jIEw81sxk0ZbfWbXrLEJn
 NirIo51IKh+TMyMwSrwF7OC+JjV75gsWz7kIQbPdTvD6nKvKf8U23F9oEKaKqE03ccrR
 1yGRZAwgmjUAt3vzaufz4fQEXlstcicsNptlO70Oqxcu3iNj0GmokYnpk6qpLlYhDyBu
 7Gjg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=mechasystems.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mechasystems.com header.i=@mechasystems.com
 header.a=rsa-sha256 header.s=google header.b=v6VXjkMc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=mechasystems.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=advaitd@mechasystems.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=mechasystems.com header.i=@mechasystems.com
 header.b="v6VXjkMc"; 
 dkim-atps=neutral
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
From: Advait Dhamorikar via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Advait Dhamorikar <advaitd@mechasystems.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Svyatoslav,

> I must have missed this previously, sorry. The reg udevice pointer
> seems not to be used anywhere.

My bad, I should've noticed it earlier as well.
I'll fix this and submit a v4.

Best,
Advait
