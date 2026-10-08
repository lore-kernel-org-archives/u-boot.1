Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86778CA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 21:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 731C581387;
	Thu,  8 Oct 2026 21:25:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id emf8tHPHOEMO; Thu,  8 Oct 2026 21:25:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A146481192
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791494711;
	b=p9nuv5e73TmShu/o0G2Avtw0dXsujLgF/ZfyX/9DpKUispdrF7R9E1jR40ogde3Z+9c7
	 8kPQi2qDRKgFInSNkP4+a8oFFbngXtB1gFVx6BgCkMqM6u7L76Cjvo1ND0AEjnsgz58gu
	 lTWH7cvQ/dMJvb9U41fyBHbiIYHNuOvhEnRI0Z+tm5gm16aqc7sTm63A68citXgvyPJrA
	 Xl9VrB6LN6IQOJ9XGyM8iJHNOYxi/uuF0fg4HqK2fQzmP53X8vit9iv4ikckizXKiUZg1
	 NDsIMlvrIHg7F28aDG37nTWSbHhB1TpbH0NA8xA2tClAtAKznilo7iFBSf6ZCSKenjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791494711;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mhBQLy2/tOyoL1ln58oS/5awdoTohwkIDu23vvboNeY=;
	b=VcjduicXUAZlKNf7CexruiFCvB7d+FJRY1jNKdgp73FkzTgKEPsYOmMELJbABvY9laPo
	 hYP/zXkqVddSRwF1wASokWRmMSCcHz/J2gZL/hj3FedRgI2UR7VaSifF8SsTJN1jzs71N
	 zy7V69V2gXuC7lqHa5tsgCp9SHawXQXL0BmCkvxQ8qsZ2oZvKrTgRqngvsAOi1045d2o0
	 7MMnU1NuKj+LX5LIY3zlQ2yzxxP+8Kt3DO+9bzIq5mcXswV0swBlg3kW7lRLa+/PCJPng
	 +TNw3JJGwmKc/5uOnlqvLMhQkg5R5Su8tV/lbUzvooyu4iNM5Q/lJ61nJa+Nxe+QODw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791494711;
	bh=mhBQLy2/tOyoL1ln58oS/5awdoTohwkIDu23vvboNeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vX9vj9QHpGsrjCq3/fDNQLvg2GDmUUErvwjQsrLghROgWSwQkwSRzB5xFrSsEO6Ga
	 6BSXcp13fysvkZxedmYpTre740M613lxg6x84BBBtXKZ6D2QF7uheMEt+OX2K4shPf
	 5PPY//Vtdgp2NkatXMBo1BTiDiMAVNl08StlJPuU7HTVTvg2VeNTtoAJmgrcf8c9mQ
	 FA/hNSfrgXTok12suGc3i9vd0g7BtBlXl6jgNIq1qdbunpltJ75ARobBsv+EocqCvS
	 1vJiIK/wvCb7F8z+7Vt6KcWJV5O2ZWI1sSbxizI2+r9Ylbdg+jg9PJqNlfB0gYKRnn
	 6wrqVUWX/P8yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A146481192;
	Thu,  8 Oct 2026 21:25:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 623A62B2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27B8F6084A
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yv0ujRLHTkJ7 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 21:25:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A0757607B2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791494708;
 b=kvkhegr41Jt2XcV20NqeuEkrW1c4t6Jp4FbWCyAmMoP1GWfCha10+M2mw4WvFG+w2XVk
 nnwr0dPQtpU/TDiLNF8d1d/2jQYRj4a8MXSU+J2Ux5FS18KFnFsG2BV8Cg7CL90ZEBdFd
 Py1aNpZQ/ztLqmWyy5oOsi7HoaH2Qb4VxQ8wrUCfQSWZ8RwZdShcWPBA1g/13B98R57iG
 r0Jl8blJHJYYA+Bz1CR3qTuKGBPvk6qUWWEuUROSBj3ioXbewl/fOfhmAWPZGur/JJqzN
 CRGRrYcgD+fHJfd3cM3H0aQp+Guhz/cGlbyo6SKjWbbxDapGoI7W9AF/KnXoH8+Askg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791494708;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=mhBQLy2/tOyoL1ln58oS/5awdoTohwkIDu23vvboNeY=;
 b=Ut3K+ARNmmTUJt4eySP0tdd8fAYybuw/hmfv1sYad6Qv1gpbP3qlej0lIoTcmcLDJKYv
 vThKqlfBVbrfYAk42tDLaUEHQ1Olrfnq6/vkpTauL/6JieUYqVS5V90aEm3ZpMiB4AWvi
 cJijtXsUtDlhZjeqy8lTQxB29EmDoc9yO0Z4JvZF7OkYoaG5EPry4d3Aq0dUr689W0QBv
 hCSeK4EupHJTDdsY7sclZnmAPfMz4tqWfFsCzfmpZgr2xoZHv52/4Cv7LmuLoccbblJDa
 Q+YXlqYhmAuwJ6PWnIU4cDdOwST5ky+cTY8hmDTkyTdHSyIOrRr1WTDok4/zhY4V+TQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=tD3oFc6x; 
 arc=none smtp.remote-ip=185.136.65.228
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 08 Oct 2026 21:25:06 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=tD3oFc6x
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.228;
 helo=mta-65-228.siemens.flowmailer.net;
 envelope-from=fm-664519-20261008212400049ce31021000207a4-alkerz@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0757607B2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:25:06 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 20261008212400049ce31021000207a4
 for <u-boot@lists.u-boot-project.org>;
 Thu, 08 Oct 2026 23:24:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mhBQLy2/tOyoL1ln58oS/5awdoTohwkIDu23vvboNeY=;
 b=tD3oFc6x1edNoO5dFlgFLPKTG7llR5idymCvBiPCp2ld6vWbA+uXe8oJhsY3MyRYKe4OoO
 jj/gq+cAuDcF0QI1z7JsI1xhPG88DtKfikHX/CsMlFp0AtqjLAM+PTHDtoUmvy1GKu6B4+cS
 ny1Ew0u951XM2EdNosmzXqk/yFdXbYWxmLKLsjQNsxtFnixQvb2ueYWxMrP9SW7GYnWJA1im
 4gS1yE96cIc5yeS1pBY93kXQrNe3aBr/HL+LQs5NqSqvcGGInCXlYTUEICY2921HmBxwN5Et
 fd3dPoAYvQYvcmQcv1W505lf7TTsv5CYNAYjwjhtUXr+4+z8aFDjZwIw==;
From: Michael Haener <michael.haener@siemens.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 1/3] tpm: Add an option to start the TPM during init
Date: Thu,  8 Oct 2026 23:23:59 +0200
Message-Id: <20261008212359.204161-1-michael.haener@siemens.com>
In-Reply-To: <DLZDZTZVOEHY.1MJ22UQOHL27P@linaro.org>
References: <DLZDZTZVOEHY.1MJ22UQOHL27P@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
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

Hi Ilias,

On Thu Oct 8, 2026 at 1:32 PM EEST, Ilias Apalodimas wrote:
> I am thinking if we should also remove the tpm_auto_start() from
> efi_tcg2.c now and select the new Kconfig option.

I would rather not do that.

TPM_AUTOSTART is meant to be opt-in. EFI_TCG2_PROTOCOL is 'default y'
for TPM_V2, so a select would enable the early startup on nearly every
board with a TPMv2, even boards which never boot via EFI.

I would keep the call in efi_tcg2.c instead. Calling tpm_auto_start()
twice is harmless.

Regards,
Michael
