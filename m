Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6A4CC6B0F
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 23:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F98080C50;
	Tue, 13 Oct 2026 23:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aNyhHGMnw0Gr; Tue, 13 Oct 2026 23:04:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B8C3080BF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791932658;
	b=NYd1WYskjpvSO5pBw3djmTaFU2KjM/4p6C0R2vkxh6s1jtvWjFqVZDAOnrf3hVMjQ71n
	 jY47JNT9P00gc+yRW90FVnNUA9UjWej+l2tSCkGGFuuE3QsMtLMxdIom1E00WWKIYuUZ9
	 VNq+47JQDWXbwQLv8yVyBkSIa5j7rZ7MZ8N/OnE6XJmL/aBMXZhWxpiCFLG+wOzkyYVPY
	 49mHjG97Ers/QKw8W6pIsjWRl9kYsWBqMRt1u4zlrbN2/YWG+DZUONKbGy+2SIxekNwQP
	 js3WE31YCeOkagT4/8goPmkBnmBrZwat1XITWT6bgbN+mGf15pieLUW5zPrTEwJpCuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791932658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bD85RlMlacC9zlq/JKaW/vPc/7RUdj0M7iLXnfN8l9I=;
	b=XgoUHLuW0ghWhptbztgCU+jgcOmNut2VNcI5k0Ftoq64PQavnBO/kSYL2BXb5bQ3qH7/
	 8v6GhIjiVE1IUX013j0MjnpZJ21Ugju1fP1076XOxgNFHfBWv+4rq4KAgCiucPxOhTTRF
	 5Clb+PjuY/n3jtdm3+odBmo0jlZXy4CJjY9BzN7n/GTftQqiNtJg+Le2I5LvRjddV1uvW
	 VnIFzR6zUBcZRfN5mN5EpvlxPiYWSxi0+DYY5uQYj8RGH1SXpfzBUuuiZBM1/MlYCvlPT
	 z+ix1bN6XafOkhco7VI4gAJUKtgMgM+NqWq3a4gS+dl0Z0rHyJSxtkWvl1/+UQsmoWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qnIs21FS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791932658;
	bh=bD85RlMlacC9zlq/JKaW/vPc/7RUdj0M7iLXnfN8l9I=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=StJ5kFf6Sc/7NXhNV6N+11/0smT7tz2NVoAhpLKakJuNkx43W+WX0OJMewBRoEOad
	 pCc2y3/csw63QEMJK3jfXNFhNt2vV2zydDZvWgOpogskr78zoIS/5z4zI3FRu9fnGF
	 Ylbjf4I/a+UxR00+K3hgRaaerQ7zoeAUPasDXT/IfnI66VyniV0typWT7wZkmY89CZ
	 ef2sWHRHgiNHrl+YU/dGi7TfJU2WFTW6khdN5znlfBZi0ovlCUNSHP8DvYjhIG7yJp
	 AoPhZTdK75s1inECyt/gVDAI90HH83HaNurqXw3aUzVrYPGz/aPcn0UFKE9gIfinID
	 SnlxAnyQCTGOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8C3080BF3;
	Tue, 13 Oct 2026 23:04:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CFA52AC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 23:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E78E80C25
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 23:04:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mlPZ6SmMYrQz for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 23:04:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5303280A83
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791932656;
 b=tFU8ZGEtpAax2OKml0p8P1d1Orr42/rT56wd7GWKzpq8tItSXj6EivOcYQA14QdRANsT
 ZG/ytbLaLUc0zAMmSZusz/JkOK/v/52Ux+hD9riNbp57kltznl0wUbBewyyiPboEjNwKR
 Jyac4RSdqgz6oWNB4B4hIb/I2tj7E66CcCpgh7tF7xmGSZNJtQh1mThShAkn0s1/wMeI/
 b9kKYKynyU7Fq97coA8NsPUw+tr0oAYN/kFLVd2+PyKWlEFPlWfz+naLkmgyhlSOhlOBR
 RdbUbanEGt9DZJ2L84270PrZPT9P5KaPBVIzOgOhVdpDZDrrOdJAe+utb4hf4SK0Fbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791932656;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=bD85RlMlacC9zlq/JKaW/vPc/7RUdj0M7iLXnfN8l9I=;
 b=JQEhXuC1e2nRL1aQ6I8zDqDJ4q29WWT7O9aIDqkuuazpOMkP13GolhUVG/1RWkMMqPih
 /3Hz6IC+wxKYmQRHOpaXvBx/dBK9lDYu06F2/f+E7Y+HvdPPKiTxdpvPgiekKP9UE+hL5
 BPLpi9fUX1ijsWb41rF6zoGciSw7932dkwcGNpH+zq5GEHiO3VecOc/DLHLUZGJsiJEu/
 v1kPDCplN0dGYyZUCH7bWFwe6J3c1SpS/XB1V/FnUzWTOfzmFyJN+fOUp3O6QhjUD5f+N
 csor7MYLTYuwp1FJgkFLnTp+Bm8n4wtBDGhVcWqT0JTHuHZJ/FHDJUi+Lx9bvxTps3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qnIs21FS; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qnIs21FS
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5303280A83
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 23:04:15 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6aa9606ddadso319025eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791932654; x=1792537454;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bD85RlMlacC9zlq/JKaW/vPc/7RUdj0M7iLXnfN8l9I=;
 b=qnIs21FSGd4Qk6CwQGQdN4DatpbybSZ8JaOBdW4asQNoyDMgqt5tOKSRpdYU9AOhUA
 d49A3kT3eyQqiaN6BNe9a05ZvyrgONbnWPOmdqvxV2KVH3jiCBfCWicHKnWEO/pMkeaK
 nUjUfX2+1l6J10Tf5v42Kr6WsVR1eqVe1dCqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791932654; x=1792537454;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bD85RlMlacC9zlq/JKaW/vPc/7RUdj0M7iLXnfN8l9I=;
 b=u7pS15IBvwdCduCiJnvi+n3Tlb82zncb8nKKBTngEhgf59nZyoGdzmXpsqfE+1YiLr
 pYX2eieUtlbNGAj8hS/m/fGEGGaUcn8cONi+5sD/Q7Nl0VvNWougSXoSmzZyoRmouWfm
 6IYoUhN3D/l083jMAoM2UNBuY/d9rPwj2oqV3KzqADf17zplIi9d8P15UwilRj5Uuf6x
 IU/qXyhhAEJ3I+c3eNAqeSRGXvsp+Ot77NU5X3nDbykpAoyxgpd+LKLDWEFuR5O6joWr
 JLNsxrgaYF+8lWEMj9Wx3iHK2KRjubSW4fNX1wglNlYVTy23uRxtCJTNagsmxYtxF7XM
 ti+w==
X-Gm-Message-State: AFq9FYIqMOY1IL/m4osk0IlVWwDgRW731ChT5uur59hor2xQWQ+phaho
 eW4frp+1SbGXq7zrygCM6dDiLJCCJh3JG1RRHp5rdyS4fHqJmxQHbICGwvl6UAAtL931arLKpmu
 YCUbq00K3AvnI
X-Gm-Gg: AYBFou11StCRJU0QDAxVivPbBZ6E/O1gfYfLOhN3Dt5LMW3A47aMoMiMFJ29eKGoB8h
 Lsc4aHG4hVLEgA6DZEifYgFBjhb4zZhvyHJbSri4MKSFKBIb1qgjkktZk+FtyzOi8X9nGQ3vr42
 m3n32RwHvKmlxN+nqOsa/sQaknx2z12bq//HZFPBFp4m7owjj5cgCLpkOzAvPJwgjorubre4fLJ
 5uOqVQKIiM+GBRxGJHNKY34QlBjj+yEHiI25bxOSghOWimDfJsuCREcUd3wUbmLqcCPW73RJ7hh
 aUdVPPT73boKB/zzk6X3ErrOJeW2akVqPV5N0mQEYA2d65pq/bU0r9fg9qXQxWIYrg0pt/mTfyj
 DX3zg9XnZgpFjyDVKJWMW71xC9eaPniERJ6VZofQGm2EVDJRkVdWI6wDG//h/RFJwlnNP2A3dvd
 LNmpf72oTH3V+1oimVyHBx65nC52zsaaOLg6+yTNWa1uTytzJluxSRvZxcOYoDs+YSJDJ1gqoYw
 9COuVwnLVrX86L196TwGfXOiI8xqkpH+ndMlU7iLib8szWfWBGema2JJrSqtgU+4IllXCNaagm9
 5u4KFEiifDyY1qi35w==
X-Received: by 2002:a05:6820:3511:20b0:6f2:b633:9616 with SMTP id
 006d021491bc7-6f2b63397b8mr5246309eaf.16.1791932654314; 
 Tue, 13 Oct 2026 16:04:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a6df881fbfsm823329fac.2.2026.10.13.16.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 16:04:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20261002073357.382228-1-aristo.chen@canonical.com>
References: <20261002073357.382228-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v1 0/6] Drop duplicate macro definitions
Message-Id: <179193265291.4152299.9012972867348510354.b4-ty@konsulko.com>
Date: Tue, 13 Oct 2026 17:04:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 02 Oct 2026 07:31:50 +0000, Aristo Chen wrote:

> Six files define one or two macros twice, with the same value and under
> the same preprocessor conditions: two SPI NOR opcodes, two SCSI opcodes,
> an ACPI PPTT cache type, two GT-64120 register offsets, an i.MX8 power
> domain name and two constants in the video test. An identical
> redefinition is valid C, so the compiler never warned about them. This
> series drops the second copy, one patch per file.
> 
> [...]

Applied to u-boot/main, thanks!

[1/6] mtd: spi-nor: drop the duplicate EN4B/EX4B opcode definitions
      commit: 0dd3208056a818072479e792cc7bd0c0f74f413b
[2/6] scsi: drop the duplicate COMPARE and SEND DIAGNOSTIC opcodes
      commit: 08bf39e9f336a4902ce69f52a424f2b9e883a6bd
[3/6] acpi: drop the duplicate ACPI_PPTT_CACHE_TYPE_DATA definition
      commit: d8cd5fe59af14e4b5683446f10790ec460b6afb7
[4/6] pci: gt64120: drop the duplicate GT_PCI1M1LD/HD_OFS definitions
      commit: 968b1689fba3ced869c9ba04e0f3cc78357778f9
[5/6] dt-bindings: soc: imx8_pd: drop the duplicate PD_LVDS0_PWM definition
      commit: 45261587bfecb43e5976356aca86b38d26441bc7
[6/6] test: video: define WHITE and SCROLL_LINES once at file scope
      commit: 367c7098e7db4b47e7d690bf26bccf7036c9c1df
-- 
Tom


