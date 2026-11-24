Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5A606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=abY47RwW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=d/eHfiYx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AD1040779;
	Tue, 24 Nov 2026 08:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QxLQ7ZFZx8T5; Tue, 24 Nov 2026 08:48:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17AD840675
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795510104;
	b=aaXpwoi/m+KXyaTm3OqaRfjq0x/0yMzCdWeWHNJO3jO/QRzVjoeebthzNSIbd1s7M5sL
	 h4//wWRpiA6nlGcGzY10jetz/N14arw2CD8VaVDwMXW0dKWkxnqyo/XPqv247RoQbWLbe
	 7T1WHVidh1Pt6wzuCuOZEG1yicMA+CJvN5OGHQnhZkXtszmmEW+EniRV8nnPzFemPTQ+Y
	 ESdUZZDjbM/TYc1Xo1KFhhhnl/MONQEPjsd8q0MCBc/jIo9fo1yQyCCt40j6lD+Lu+ra6
	 LXACCNUJxZ8Xu9JrI2CDpCVQiayVU2QbiX12Rtz1SgV0bI9cClrhbHBYrKeQjqHzDBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795510104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KxTGRluoj155d9kBpY9rHbEJnyVI8nlCIwbXWzF6ckU=;
	b=d9AHYocpH+x525F6p0sZHEtp85/ST/FsDHGbnIi/u+YM3vMDTft32fiZ8jhjxG5uv/2f
	 wbsSCTzLdPtYvnMX5kZT3TvJo8NHuofHNs1ThZM207NC0IhC90XF3YDLy6ellsuEgOafd
	 2D0m3BU89T8BOYxrrVrmculT/T6sgStqDUsEVu84dMwYjeVPZhDGvoJtJmElMmCn7ZFiX
	 wbLjGvqM7sU4fx1t+MfG5kK0iKbl6gybf2pA31nODtrYC1mF3VUd+WfoDHPDpjLDWlQJr
	 acDQVMMEyKPaVA+D7+jwhR+T2i9iALRdlXDlxyRDLCps1Ul7FRXdVYZYPTwDEBJGILA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795510104;
	bh=KxTGRluoj155d9kBpY9rHbEJnyVI8nlCIwbXWzF6ckU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=abY47RwWMqV9m5+bpFyyVNUrPP82fwnDvOgpUXUIjxP/q+npraclu73DmMdokkarG
	 5F0F4439C6hmGkFJxCrwjDB8cs4KiA+NHRZ4ZvKkMvaI8/LNmh/syamYpxDxI9Hc1U
	 uOhbHJ8nlb4iPrAthv06TcZHb3unAWMnWssZJYHDDTWkb/CeabLSMLSUOn8Ho0JSdW
	 3YD/tsIimsCSy+paMXl5WRL0CdL7QuQk5M866rdjbQ7FmArucCymU3gdgkIwX7B/al
	 SXA6ghqOQsrPkDNVDmPp7gDCG2sZp6VI+14yRV1ZO3MMsp4C3kw99uUOy/Psm8Ejdj
	 0w6Rjnt+VdiQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17AD840675;
	Tue, 24 Nov 2026 08:48:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1884522B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 091FA607C7
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E3sj_htbEOy2 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 08:48:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B634607C3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=d/eHfiYx
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B634607C3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:48:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 279A7339;
 Tue, 24 Nov 2026 00:48:16 -0800 (PST)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.0])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53EA13F632;
 Tue, 24 Nov 2026 00:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795510099; bh=6sOO0MeqOkHNrqhGWp5Biw8kfcH6GT4D5kx1h1nzsRo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d/eHfiYxFONiqkofn+c+n+FztJV1w+b/s4PGP6HpQ5OxU+c8p1bkggoBehoG4wQRn
 XyzAThqtEZC7jCT8qfOqFia/Kh6Q1h6wJuqhUwFfe79qYZ7nIFABsP5ViFiIV3Tbut
 DKNRtyyIwdxutI8jUb730cBqFmCEPwxrvr38eb/A=
Date: Tue, 24 Nov 2026 09:48:15 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/2] efi_loader: prevent set_variable() to record
 append_write
Message-ID: <awVPT3B3aHx4Btsm@debian>
References: <20261113-append-v1-0-4cb63d522562@arm.com>
 <20261113-append-v1-1-4cb63d522562@arm.com>
 <6e9c726c-ef44-44ec-91c1-267273ca8f4c@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e9c726c-ef44-44ec-91c1-267273ca8f4c@gmx.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 12:55:09PM +0100, Heinrich Schuchardt wrote:

Hi Heinrich,

Thanks for reviewing. My comments below; I will send a v2.

Best regards,
Vincent.

> On 11/13/26 16:07, Vincent Stehlé wrote:
> > If SetVariable() records the Attributes bitmask with the
> > EFI_VARIABLE_APPEND_WRITE attribute set, this attribute can be returned
> > later on by GetVariable(), while this is forbidden by the UEFI
> > specification. [1]
> > 
> > While the non-TEE SetVariable() already makes sure not to record the
> > attribute when appending to an existing variable, it forgets to do so when
> > appending to a non-existing variable; fix it.
> > 
> > Link: https://uefi.org/specs/UEFI/2.11/08_Services_Runtime_Services.html#getvariable [1]
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >   lib/efi_loader/efi_variable.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > index 9923936c1b5..8bf2c91f3f9 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -384,7 +384,8 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> >   				      var->length, old_data, data_size, data,
> >   				      time, &changed);
> >   	} else {
> > -		ret = efi_var_mem_ins(variable_name, vendor, attributes,
> > +		ret = efi_var_mem_ins(variable_name, vendor,
> > +				      attributes & ~EFI_VARIABLE_APPEND_WRITE,
> 
> Hello Vincent,
> 
> Thank you for detecting this bug.
> 
> If the variable does not exists yet (var == NULL) and data is provided
> (data_size > 0), you still end up passing around EFI_VARIABLE_APPEND_WRITE
> in unsolicited ways.

At least we are sure now that the 'APPEND attribute does not re-surface
from GetVariable() in this specific case.
Is your concern that we risk passing the attribute to other internal
functions, such as efi_variable_authenticate() maybe?

> Should we remove the flag from `attributes` directly after setting variable
> `append`?

You are right, this is a better solution overall; I will send a v2.

> 
> Best regards
> 
> Heinrich
> 
> >   				      data_size, data, 0, NULL, time,
> >   				      &changed);
> >   	}
> > 
> 
