Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74061CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 169C180854;
	Mon,  5 Oct 2026 07:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jDVkrPvvb6Wa; Mon,  5 Oct 2026 07:45:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 691B680C68
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791186353;
	b=aWW3aniSCuOhpfUDi0/Ehjq+OfmNJc93N6vPRrsYPWCASD4IAC1rmffnZ1rQay8XHKzV
	 2zzHhQzfnyNYEnvueo6y/srqlGAjEt6bIlG6ceyThDTyvDiaU6ZnBSjzqnDeykXX0w3U4
	 sjOi4fcDA3VgyuWT7ddK9q521arSuSMARb8kEM5QcJeTNLGnARTPrK6yd0U73+FRji+Il
	 xsbIHGSW2uDx74+eKBrglVpKhRk+p18QVX4rkUku2YlrD/BWHWcfAoGpbOP514UN7rgB6
	 kvxbDyROB/UnyxOTyFcO1/WbCSwVNnwWoliaxof1FPXZsII6NglaSTRMj35q+nHPvmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791186353;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=78D+8UorpTBtKyUpmQDB3B5Um7JGPNBDJG//Klz+904=;
	b=Rve3uIniPG/a/t/Whyqqsbrc6tc1/lzgXZEASf3kjQ5yab4mSO+/St5uO7OYDDG5v5GZ
	 1mqVEKvzKCQD3FZuy8M1x59ammkCg7PdvFPW6Ue0tN2kIg/B7MTnw0RDhXBrDs23Fy922
	 gOy8FKNutfM/7QmN3WnpEHS2XY8Une1frsRqnI1nVjMiIR0ALl7bllPlmosqwmPwMfHVx
	 TnOizuP0PuODMMxjyq/8PgE8zw1uSxQkrTxZJO9tL9eBcZKpLLk9BTLyiL13/qqtlOH62
	 H+MAKyhPNkyQZMDYD/8zaJdUth8twEv/CmCIzIdelOmOAT7OneYjZUddoBTsQNZgTgw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=yKcL2C1V;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cyhUqk33;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791186353;
	bh=78D+8UorpTBtKyUpmQDB3B5Um7JGPNBDJG//Klz+904=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XEUGHkxqKFJCeyeIwvKeP816mrqrKXYNpEvO5b3poBUQrL9lKT9ZobQ2xqn9giJms
	 aob0LGPQc2jFK8XGhnFPvo8hEe2D5qxY3ES0lQQggcxlZ11odHjkG6GfsMF6O+Xgnx
	 bMpQF5spCvXr3aDATU58V0ZRMdDBrFEklK4ApDQCwxc9k7jYBBz453HMUUolH9HvQH
	 Gxd3yaE9zLUwe1rVnImkLI8McCSKwEzRowOgC7OooUj82CDCOijpyqcch5OqW5qMda
	 Z8PSJDHyvKRjsoCrTpd7RdrMagaMFSSvwfXI8RlxlCINFDv3gLBydXANWfsVU14+Qf
	 nYGqOHyE5/jpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 691B680C68;
	Mon,  5 Oct 2026 07:45:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F4CF1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C3A180C68
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xm-x0va0bXga for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:44:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8F50780C67
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791186289;
 b=Jh645u5JeWaoZTz9z0E+L/SeXoz0x1Y7mwOKzqCftVdb8gnyL2JsACCf4UZtqgLDw6Zo
 YILrWiqARlJtOf0q2zqoSBwpbbEjVSH27HOVWTh+sdZfDknRkJMnG0Z9UaNXmPxqxnS2O
 R/XiSiqd2cVNuBxsvvzF48TPN2MDhQ/SChRUJzKKXDSAInjnkk4cyM1yPZiE6sbBQvS4x
 DvrKlcrLub/sa4db7YLAPtMzCxt9yhYdEjzYRPQvD8avJN2b2i3IFsBUjAft77ieZyBBi
 N3BO7K9MP/VEdFiqWLY53T8iusUE+PnvM/8MdReVNyiGVyw+nyqL60JMnT+rRCoyREA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791186289;
 h=Received-SPF:Received:DKIM-Signature:From:DKIM-Signature:To:Cc:
 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
 X-Rspamd-Queue-Id;
 bh=78D+8UorpTBtKyUpmQDB3B5Um7JGPNBDJG//Klz+904=;
 b=qm8UvWvt7RTTPwdGcAC/9GchIZLfDWMBEhVWFwkJwKGiptGQoTlFlSTz3Umm5oQV76Iu
 6drPaTfPoJAKScpuBFFS5umMAFbwEjrGl1a7lJcauOsXXFO4/W7OybjdUtWWYBV9bfXw6
 8prZjJoYk3nLmmHxf6wmdoIw5fgyqnxOZxA1qqvc+SRjl03JbmP752sDICcvGn1+fn8HY
 +4QwTFYn+nMY7TrhyUq618KqGgahGXk2CrkxKemVTwWSIQPrt3UfYb3FHPwU1tCuIjgbt
 G3Kn0cdxKyz8LptJWQvDIy9CpDSU0miqZv4HuvdhG80BFYBr7PfsfeFYdmNTn1m7ytQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=yKcL2C1V; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cyhUqk33; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=yKcL2C1V; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=cyhUqk33
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F50780C67
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:44:47 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hyry43q38z8t1V;
 Mon, 05 Oct 2026 09:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791186284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78D+8UorpTBtKyUpmQDB3B5Um7JGPNBDJG//Klz+904=;
 b=yKcL2C1Vmw/qOZ0YigC8LyR9t0I9OIga4NUNNa0o/NbWyE8iO9Zwx9crzRSqv7wJgTQFzo
 hHbkARQRSmclgHyvQCEnupnWnuGlT0PPbVzME1YlpX0xqDKPq5KDOR0+e5o+muVwrOaGSs
 wNDDWLpqgyapPtNwcV35Oz3sWfpQsCp2huX0LsQ+vGX5IpsWr7eYMaa2PU5Zx3HfU9/m9Z
 v3UhwnGuC1tATqlCZmNMjolRo5JrjhRPREtmDUgxzZXFQ8lCxfbcIMMILmX2IPcFBFPnem
 jxbIrGqcN+9EOPlDAQ1crC+9tx0X9Xt86v90IRrldazLehmKKbHBlbCjIj6NUA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=cyhUqk33;
 spf=pass (outgoing_mbo_mout: domain of stefan.roese@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=stefan.roese@mailbox.org
From: Stefan Roese <stefan.roese@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791186283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78D+8UorpTBtKyUpmQDB3B5Um7JGPNBDJG//Klz+904=;
 b=cyhUqk33oJXq3WTYYscpso5MEmPgvhh4dYTNiUCktWdNNSS22hKqyGLrl8McN0KdnJtyyt
 KslCES4w6eEhttlrBEJ6XEkILUK0ppFnalSev3b53OnZ4O4PO7DhWzQSP98FSwBJGzW7oI
 qnmJ38UVvtYYM2mRCuHIt+vT3rrGx/ukLrTZzh+Zv2uT/9Y+jYSJwQuLLkh6BgVYpCSvgA
 Iz6qhM8CpRyD2cZxBeHLzP//3gT6kyhyW45mLdPO79zOO45CPbMWdVXdVcGY8WQbdAsBoR
 LWZjioEiacTvfr9qlBnjr3ZxCGRcYc6z4CMWk1RebOfGm7nyv1aPAFMwt0yriw==
To: Marek Vasut <marek.vasut@mailbox.org>, Bruno Banelli <bbanelli@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: xhci-mvebu: use dev_err() instead of printf()
Date: Mon,  5 Oct 2026 09:44:38 +0200
Message-ID: <20261005074440.589817-2-stefan.roese@mailbox.org>
In-Reply-To: <2192bc27-809d-404e-b503-0faa27016991@mailbox.org>
References: <20260823104310.118587-1-bbanelli@gmail.com>
 <2192bc27-809d-404e-b503-0faa27016991@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3ac514ab4f38c35c889
X-MBO-RS-META: rjje34suczhyioizqcdcysesdxfhgqx6
X-Rspamd-Queue-Id: 4hyry43q38z8t1V
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

On 23.08.26 13:01, Marek Vasut wrote:

[...]

> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
