Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C151606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=scYycdBv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=OIkkmhWg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BE6B607FA;
	Tue, 24 Nov 2026 10:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIdaofPyuci0; Tue, 24 Nov 2026 10:41:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4AB53607CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795516870;
	b=JpyZcPh/HHm37y7pIz/zRZQ3XhlpU4RxBUHXtoP+aPcfoJoQFxaclkcwmmATqCkbxjfr
	 OL6+dxLWRXgkyqKG+NcrhD6gKb0Dcm6pdccFVOoI3jr49Y46uBR841JEiJgg1HygUtBEo
	 4CTpBEd0S6uTd8lSXSFPJbzHd2mGYb7AIej9crED//lMn4UovV3CpMcL3gmpx9V4xNsUT
	 TgKksJXLZWldj+Xl09uBFLMFojG4n5ae/NUVnU115JwwiDYuuIm7rVk8mww5pKWbWFEVN
	 GiWeRubHzMubmWHlpRc+yPkol9OHcry4oIPdUDNXw9a6e7aW2BPnAv5fzAF9MxLCZpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795516870;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Pabq2Qvlq2t2toOyDP6ushKMkLdd28fGkH3i4aVJ5xE=;
	b=bgNlb+FD3M3ty5tDwLgtBbvqeZKe/1h4PU84ZzCbRtRz2hPWgJ+6lRGITGTpIvEq1/mr
	 uYgWSW0zybC3A+rKsyuinvjnhD5OeM5JhJkK1kjhzrgfpJErrfzL4Waq2kIrIbxHbKAdo
	 GWBjp1gt7QlIy+NaEzLLqlnWgTZeuqwQePTxYrm5DRj/39rc0NDjxN9ACXnDxthxw4Mui
	 6cpIQpCMhNHzPNoDvRGNcC6+IB31mJ/IUJvE5eZpJac3kWXC3dHw/FXDvZSr/dfEKQ9m/
	 u6mJtfp7S7I4eX/h/edKFeg9Ymw2YleA2rJilxeU0BXOA7KEpL1rshnTLIazz6i/nkQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795516870;
	bh=Pabq2Qvlq2t2toOyDP6ushKMkLdd28fGkH3i4aVJ5xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=scYycdBvZziG8VJlAz3ihNa36X/X/EzHYdyoPS8C1Wmas+/l1MkzIQa/Q7NIAwjVR
	 2fTLktnPso80CFRUwe/VeLYuF2rUTOiLBpuJFphiqE4NvLqsPUSBQJzcKxBF3RNYYu
	 AKunRDCw2ZOnjmLghzbBPhTl+BEjogS96OeIdI28b1Z6ugKdBCpyBQooHL1TmwwRHa
	 mTzI+KtDVQsqxbEWw8T88/E26Gl+gH7Ho7rYw+0SwMYI4fqpzeVNzLlh2iMVwug/sQ
	 pqEm/00GqPX1rsCJDgIegw8rae/navdvo1NXH8WLBqIfbZJuErmnw7MY3GQzR3j+5o
	 8JPCWPfvlSGqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AB53607CF;
	Tue, 24 Nov 2026 10:41:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F2D17D43
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6AD180F52
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:41:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kqh8PyL74gB1 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 10:41:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 96DE480F65
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=OIkkmhWg
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96DE480F65
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:41:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 210FE339;
 Tue, 24 Nov 2026 02:41:03 -0800 (PST)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.0])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4507E3F632;
 Tue, 24 Nov 2026 02:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795516866; bh=pFKLrWE1BL042Ig2elJSoXeI/evWpNamQQsTcesIbRk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OIkkmhWg4g9DuR6GhSzrm7ojXi8EsO2j47ogG6Z4QOb0kmq4j01hxm+3VioHAtjLP
 V7POwx9KnNVDK6rE8Uux0awtP3B5OiavM1DKgIJpfAZl0IRsIBH4ajqW9JZNHoXYFn
 eODtB1DNzgaBmP8TtWIERyEgPPuJoEeUh9ipOnyw=
Date: Tue, 24 Nov 2026 11:41:02 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/2] efi_loader: prevent set_variable() to record
 append_write
Message-ID: <awVpvhkAxqCApKzo@debian>
References: <20261113-append-v1-0-4cb63d522562@arm.com>
 <20261113-append-v1-1-4cb63d522562@arm.com>
 <6e9c726c-ef44-44ec-91c1-267273ca8f4c@gmx.de>
 <awVPT3B3aHx4Btsm@debian> <awVefiAgZsYR6fWU@debian>
 <5bcb7614-2ffe-425d-8b68-ce001bec3ae9@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bcb7614-2ffe-425d-8b68-ce001bec3ae9@gmx.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 11:10:53AM +0100, Heinrich Schuchardt wrote:
> On 11/24/26 10:53, Vincent Stehlé wrote:
> > On Tue, Nov 24, 2026 at 09:48:21AM +0100, Vincent Stehlé wrote:
> > > On Sun, Nov 22, 2026 at 12:55:09PM +0100, Heinrich Schuchardt wrote:
> > > 
> > > Hi Heinrich,
> > > 
> > > Thanks for reviewing. My comments below; I will send a v2.
> > 
> > On second thought: we do in fact need to pass all the attributes to
> > efi_variable_authenticate(), including 'APPEND. We can thus not remove
> > 'APPEND early in efi_set_variable_int().
> > 
> > I think you need to take the v1 as it is, please.
> > 
> > (FWIW this is exercised by the python tests test_efi_var_auth3,
> > test_efi_signed_image_auth5 and test_efi_signed_image_auth7.)
> 
> Your are right in that efi_variable_authenticate() considers attributes in
> the signature check.
> 
> How about EFI_VARIABLE_APPEND_WRITE in efi_set_variable_runtime()?

Hi Heinrich,

In efi_set_variable_runtime(), the 'APPEND attribute is indeed cleared
ASAP:

   527          append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
   528          attributes &= ~EFI_VARIABLE_APPEND_WRITE;

This works here because authenticated variables are not supported at all as
you mentioned.

> Furthermore efi_set_variable_runtime() returns EFI_INVALID_PARAMETER for
> authenticated variables. I wonder if that is the correct value. Would
> EFI_SECURITY_VIOLATION be more adequate as we don't accept the variable for
> missing capability to check the signature?

It is indeed not easy to choose between "invalid parameter", "security
violation" or even "unsupported".

EDK II does seem to return "invalid parameter" in a similar situation. [1]

Best regards,
Vincent.

[1] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c?utm_source=chatgpt.com#L2675

> 
> Best regards
> 
> Heinrich
> 
> > 
> > Best regards,
> > Vincent.
> > 
> > > 
> > > Best regards,
> > > Vincent.
> > > 
> > > > On 11/13/26 16:07, Vincent Stehlé wrote:
> > > > > If SetVariable() records the Attributes bitmask with the
> > > > > EFI_VARIABLE_APPEND_WRITE attribute set, this attribute can be returned
> > > > > later on by GetVariable(), while this is forbidden by the UEFI
> > > > > specification. [1]
> > > > > 
> > > > > While the non-TEE SetVariable() already makes sure not to record the
> > > > > attribute when appending to an existing variable, it forgets to do so when
> > > > > appending to a non-existing variable; fix it.
> > > > > 
> > > > > Link: https://uefi.org/specs/UEFI/2.11/08_Services_Runtime_Services.html#getvariable [1]
> > > > > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > >    lib/efi_loader/efi_variable.c | 3 ++-
> > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > > > > index 9923936c1b5..8bf2c91f3f9 100644
> > > > > --- a/lib/efi_loader/efi_variable.c
> > > > > +++ b/lib/efi_loader/efi_variable.c
> > > > > @@ -384,7 +384,8 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> > > > >    				      var->length, old_data, data_size, data,
> > > > >    				      time, &changed);
> > > > >    	} else {
> > > > > -		ret = efi_var_mem_ins(variable_name, vendor, attributes,
> > > > > +		ret = efi_var_mem_ins(variable_name, vendor,
> > > > > +				      attributes & ~EFI_VARIABLE_APPEND_WRITE,
> > > > 
> > > > Hello Vincent,
> > > > 
> > > > Thank you for detecting this bug.
> > > > 
> > > > If the variable does not exists yet (var == NULL) and data is provided
> > > > (data_size > 0), you still end up passing around EFI_VARIABLE_APPEND_WRITE
> > > > in unsolicited ways.
> > > 
> > > At least we are sure now that the 'APPEND attribute does not re-surface
> > > from GetVariable() in this specific case.
> > > Is your concern that we risk passing the attribute to other internal
> > > functions, such as efi_variable_authenticate() maybe?
> > > 
> > > > Should we remove the flag from `attributes` directly after setting variable
> > > > `append`?
> > > 
> > > You are right, this is a better solution overall; I will send a v2.
> > > 
> > > > 
> > > > Best regards
> > > > 
> > > > Heinrich
> > > > 
> > > > >    				      data_size, data, 0, NULL, time,
> > > > >    				      &changed);
> > > > >    	}
> > > > > 
> > > > 
> > 
> 
