Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A3606A689
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rrKQ6Ucz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=B1Z3qxb2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71E046070D;
	Tue, 24 Nov 2026 09:53:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6LwSR-hSEkTm; Tue, 24 Nov 2026 09:53:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34E41607B8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795513991;
	b=axdShgT5zTdOIQUb244rpVFHZGiOtwMW21iNZ+AcjGTTqe4eQr0CSRErbHtETC7HuR7x
	 TfX3kIMf11hG4GUZyrZokhM5Yn9zrzNrL7nk4lhnSACL2O1HpOe0x9gwNGxqRc9EWaqsj
	 4HWZ8wOXtMHYLejyZaIOg5H8/GZkJrWIc5IpABlxl2WVRfN2N9v7j7hozL+ymsOCV2/hO
	 qm0hyXFNwvJKbOthWGl92iSpgkav2sStn48g4WZEjDjthb25blyLLMXbwtgDmBj5sbt3X
	 bIt2zZwzoomfOOlZRewe5umJS4ASmj6IZHarlFr7p9/1PuXFJV7drnolji7kGIyi3bA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795513991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vSTS93C9LIB8loWFMwE4pCfsyl4mLk/W4kot59wi0Ng=;
	b=Ry0ECqs3t/jNl8FgztURDWjsZ4qzrd3cNbKhDuw3HHRD7fSw+YhkyB925eWg/lsst0iC
	 sfGDqzdEz7CLg842Q4DgzbyU7cxY1fuvZEh/olv7jyriyZwCDFDR4VVxmpQkbzTWzD0yD
	 ohS1MU3i4wp9yCJ54u9nPeWv1kKi9qDM7Rn3iUCdGWG5j4QKpEzxI6gYjGcqNelaP3Q0g
	 RKwYdOxuS8WYhc3GM3RVNLZHvyOqdR8rXmi2VYxBix5qo+A+2sHtUHjoh2cpdUA00ufvd
	 fB7mJbWlzIdevaXtPvFGOW6U7ImtGbcRxKsqXfvU1oJ4bYTKKqcCUYJCKwx6FeiaBjQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795513991;
	bh=vSTS93C9LIB8loWFMwE4pCfsyl4mLk/W4kot59wi0Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rrKQ6UczNSMCAxCi4nVsKGIyABcQVwSk9E/e1to/d33Q873zijsGK7yi5RoJv+A29
	 DRlt0obpCb5VY4GbHiRizwgsoeBSv8R1H1rLkb+tJazTwKqSvyJnVL3X9tAunQfoYL
	 9QfjYsC33aCH+J8d7KWlbMjvsPWR0B5qPVodjLtVRVilA8asGt2gdOa4W0Alqi7jUr
	 9vBRfkaAyVZW513v4/tIymw4+E4XsE2SLX+HwFk/y5OLSnJkxLCKKB2aY1wQdZR2QD
	 ML168sQ6VCAow7ehJxakVxOB4H1y6J7NWz25iG/fTy7RjuqawUQsREXv/fI1zxZc3X
	 Nn5bWVQrMAiag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34E41607B8;
	Tue, 24 Nov 2026 09:53:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 571203C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48C46807EB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IDkEVyilO6A8 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:53:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD4C980F4F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=B1Z3qxb2
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id CD4C980F4F
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:53:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09749143D;
 Tue, 24 Nov 2026 01:53:03 -0800 (PST)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.0])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39CF93F86F;
 Tue, 24 Nov 2026 01:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795513985; bh=iaxwtO8X+eZ169jTSkUuOnTXXp4vQiEcDua1vjIGIfU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B1Z3qxb2tCaNSTCz+2xRAVrGGLpOKP5GvwIoBYoxL8QIvXHoMI4sGyeQkEscUkXFR
 GUG7nQl9S352bN4yxkKmZUtPLs+U7JWk7RxiZR7MaxxtphCVHK5S2uA5OT2fArJc0o
 Sw1hJ1xfxEMLj9ucxtHbbU9M7kVDP1/q+DonzJ74=
Date: Tue, 24 Nov 2026 10:53:02 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/2] efi_loader: prevent set_variable() to record
 append_write
Message-ID: <awVefiAgZsYR6fWU@debian>
References: <20261113-append-v1-0-4cb63d522562@arm.com>
 <20261113-append-v1-1-4cb63d522562@arm.com>
 <6e9c726c-ef44-44ec-91c1-267273ca8f4c@gmx.de>
 <awVPT3B3aHx4Btsm@debian>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awVPT3B3aHx4Btsm@debian>
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

On Tue, Nov 24, 2026 at 09:48:21AM +0100, Vincent Stehlé wrote:
> On Sun, Nov 22, 2026 at 12:55:09PM +0100, Heinrich Schuchardt wrote:
> 
> Hi Heinrich,
> 
> Thanks for reviewing. My comments below; I will send a v2.

On second thought: we do in fact need to pass all the attributes to
efi_variable_authenticate(), including 'APPEND. We can thus not remove
'APPEND early in efi_set_variable_int().

I think you need to take the v1 as it is, please.

(FWIW this is exercised by the python tests test_efi_var_auth3,
test_efi_signed_image_auth5 and test_efi_signed_image_auth7.)

Best regards,
Vincent.

> 
> Best regards,
> Vincent.
> 
> > On 11/13/26 16:07, Vincent Stehlé wrote:
> > > If SetVariable() records the Attributes bitmask with the
> > > EFI_VARIABLE_APPEND_WRITE attribute set, this attribute can be returned
> > > later on by GetVariable(), while this is forbidden by the UEFI
> > > specification. [1]
> > > 
> > > While the non-TEE SetVariable() already makes sure not to record the
> > > attribute when appending to an existing variable, it forgets to do so when
> > > appending to a non-existing variable; fix it.
> > > 
> > > Link: https://uefi.org/specs/UEFI/2.11/08_Services_Runtime_Services.html#getvariable [1]
> > > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > ---
> > >   lib/efi_loader/efi_variable.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > > index 9923936c1b5..8bf2c91f3f9 100644
> > > --- a/lib/efi_loader/efi_variable.c
> > > +++ b/lib/efi_loader/efi_variable.c
> > > @@ -384,7 +384,8 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> > >   				      var->length, old_data, data_size, data,
> > >   				      time, &changed);
> > >   	} else {
> > > -		ret = efi_var_mem_ins(variable_name, vendor, attributes,
> > > +		ret = efi_var_mem_ins(variable_name, vendor,
> > > +				      attributes & ~EFI_VARIABLE_APPEND_WRITE,
> > 
> > Hello Vincent,
> > 
> > Thank you for detecting this bug.
> > 
> > If the variable does not exists yet (var == NULL) and data is provided
> > (data_size > 0), you still end up passing around EFI_VARIABLE_APPEND_WRITE
> > in unsolicited ways.
> 
> At least we are sure now that the 'APPEND attribute does not re-surface
> from GetVariable() in this specific case.
> Is your concern that we risk passing the attribute to other internal
> functions, such as efi_variable_authenticate() maybe?
> 
> > Should we remove the flag from `attributes` directly after setting variable
> > `append`?
> 
> You are right, this is a better solution overall; I will send a v2.
> 
> > 
> > Best regards
> > 
> > Heinrich
> > 
> > >   				      data_size, data, 0, NULL, time,
> > >   				      &changed);
> > >   	}
> > > 
> > 

-- 
Vincent.
