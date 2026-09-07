Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52183C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 12:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4C89605F5;
	Mon,  7 Sep 2026 12:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gNSxMAP2IyYK; Mon,  7 Sep 2026 12:14:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D962560686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788783242;
	b=idM7lagyAO0eUJtzp/KYCU3rLSC2ApGI4oedJdL8351vcfDiPsILl1ks4Gbkuk82IxTz
	 5dmyNh1Yk2U5o5ebGOOsWQqNFqYxNajUAlkzPj/X/0U9+wla/duEbavtWy0ps5b/oNSOf
	 gCqhTMCtsSfadconvxB/D7eVWBKgJM6iXphDc0Uj9zBpJPs1Xs+kmQqsmuU8t16nq8Zck
	 kw/l/2P5UbvTNiEWQn/RKdE90FI+V8uF/4g2gpA2VIJMehJpwQHPCOu9gDj/Ba17AlqAH
	 EtoZv3xyPHW+gMh4vXuMed7R2tIemqjtyGyY073dL7AZ4JFr+S68vyomaI5JcRV+p+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788783242;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BgTB0A3042MbYx6mb3ppgahNcs4N5KoTy6a/lFgqwt4=;
	b=sTiErqQcD1ztGf8I1fUiYU+CBOP+oi3PjeBhb7/x7gObJxcTyPYkb09hRfKM2fUZO1MW
	 I7tvaa898rDyh3oDPN2mD7LQEa7aNh5V/k2q7GtH0bUXlMo3optaOEKAyEqxUsel2FguL
	 7s+WjxS8LG69qwGpA25Mdv/Wgt9Yd3lj8xOVfeMKltkS70esQJuVZmbz2/w4fbKxr52xf
	 80t2Hp44x1TZV1WWq7pRcx2MA4uNNPVXhN5UWUn9NmMJT1Pm3tjckpKo93mXNxwEuJY4n
	 hBohyHzkR7a4Q5hKx3SqKpf4jYm82KmhmVz90XOXBb5KGk1sm61IgHVkgR6otZ7WyRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788783242;
	bh=BgTB0A3042MbYx6mb3ppgahNcs4N5KoTy6a/lFgqwt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O63Ady/Anup3chE7EswGF69V7FXInW4/2LnJYMgsvll6tJ+r6xNpajb4gfynGHY5A
	 gWkKmzvc4ve2DYOsuFNzG9s+H5+k13iafvXZrgCRwdT4yoLPXMcBG+pAHCqIkgguhu
	 EAmO1xpyGsofL2Wn0En+xi+9tl9t3I7krMGHoBsLQbUF12oQPGc6KFQCNlpgZJ1zYz
	 HonFTlySpNRO1GOwf4RRySh1BKWqTCpVH3ct4hF/vSgIIOVfiIWPn+Y1l7iG0/RGOG
	 Zd90CT+MqCUp+QwAf1QCxeygu8TiKyrEhZTQ1sZbGdzVyA1xd6EB5Xt3b7oseLB/nH
	 ekhLUSgIrFe2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D962560686;
	Mon,  7 Sep 2026 12:14:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CE36388
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 230114059E
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZJSTPy8R4c2w for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 12:13:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 298E54059C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788783238;
 b=Lp+yLWNGchY8YB+8znz/7cBVsf+MEszeWk1v0KCb83U8r1I2FZj7S260zxfnsVBevL7x
 1rVdxmsPV0Q2U70YnN8xHQMv6mTbVsxdikXrykA4XpX3VKB+XiXnntG1U42TW7XHtdqHs
 nxNQPLb3np+28fIR5Zl+JSPT5CA+Jy+IGjUkQ2o43kbQkgdk76L0IY/ksymL9Pt7iZNS+
 yDNVzM51jDnNgn11YcsQtpNpHVsKM2AG7H5QmXUhhgxpdt4i7W7dQEPckIZlrLAyilsys
 IteMh97H7AxvbU/CM0OCUkk1yaoDnHqWpTwOJ3bjSlJH0ER57oNlyudAZ7ERF4a723w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788783238;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=BgTB0A3042MbYx6mb3ppgahNcs4N5KoTy6a/lFgqwt4=;
 b=oUAKNZg22Hg+FME8CJYstiFOe87xLvZr2F5YkF9DZalGK9i5+JzWSKekGMOO4ywCwEb1
 u5T0MTvIe47g0ylB0TJVFK3hf+2qKDv8ddAovwuOC2Wul+1aSIk99kgqYURNmDx1CJM1D
 v9zS8II1y+QmMqXrzIjvSCpUZ4UkCY+nRbD5pgpZB9VrrSLLt33R7qfozwh8sjB9OUfIk
 sUP0qpjgzjdC80K10fXf0qitqn9Srv+cWKKcEUCVqs3SlKWptoDgpvpqwZ3ks7yL7LgMn
 JQnVGUfIGQNxWauFCrsDUHI0hvFIYwV1E1gXJ1bArnBj1zzEz2YVEPBPXXuGyQ0P2tg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=hoWm8hMr; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=hoWm8hMr
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 298E54059C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:13:57 +0000 (UTC)
Received: from smtp202.mailbox.org (unknown [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hdmFZ1w7KzKmT7;
 Mon, 07 Sep 2026 14:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788783234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgTB0A3042MbYx6mb3ppgahNcs4N5KoTy6a/lFgqwt4=;
 b=hoWm8hMrC0nnfOpbiqRn2GxUnTiEWS/MV9EwIYqALOv8xTarBWaKRkZC103MUO1bQoJBi6
 a2biplJ4qshynfBpL/Ldxk+xQGFWQt4Cufy50ks+QdfrVp98U6vxRKEFw+53HRipVSmS8c
 oEoeTbQ1AootQqdcxY8uPx/C96TleExi6xUttz+7DTcw1ASc+nUi/avHe6PM2rEnhB7Cc2
 76k9qWNLXfEZ/7Swq9N0kBXRAR70prSIPk6TpT6LXdUBzdUV2YzFYMVE+dCGTFliHq7J80
 0vK24sDuVXEizwy8d54c1rFUuSAKOhHZaVehJ3QB+vcPW/uLco3zgIcs7OzkWQ==
Message-ID: <6e0b7172-b3c5-455e-b00f-370d43083b2b@mailbox.org>
Date: Mon, 7 Sep 2026 14:13:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] lib: lmb: return -EFAULT for partial bank-boundary overlap
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>
References: <20260907-lmb-alloc-addr-efault-v1-1-7a5b73c2318c@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260907-lmb-alloc-addr-efault-v1-1-7a5b73c2318c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1uoiygy1agr7arr4fj8p374gk3ymoo6m
X-MBO-RS-ID: 0414b29a988a3ca85d0
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

On 9/7/26 1:56 PM, Balaji Selvanathan wrote:
> _lmb_alloc_addr() returns -EINVAL when a reservation overlaps an
> available memory bank but does not fully fit inside it, and -EFAULT
> when it does not overlap any bank at all.
> 
> So for the partial-overlap case, it returns -EINVAL and
> boot_fdt_handle_region() in boot/image-fdt.c prints "ERROR: reserving
> fdt memory region failed" during boot which makes it sound like a
> serious error.
The commit message does not explain why do you think the overlap is not 
a serious error, and why it could be ignored.
