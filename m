Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADF606A334
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WQKQkUlg;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XlvrtjGy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D039608EB;
	Wed, 21 Oct 2026 13:08:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4pijSyI0Is-F; Wed, 21 Oct 2026 13:08:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A6C04608B7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588094;
	b=bx4sgGOFNIUi7xDOocNPRk6KJwYz8VM4knvKQwIEgD8njIf0sj5jaACO//O+XcBLTu5f
	 7GiDRRXCu1BqL6lf6GF8tldGt04TPLw3TcNgIsMUizVWGmENlwbcxzDR3ixo2cM9rhyO0
	 Tr62Foin5IKevfPp9PPQgcAG6Kwh1vd87Tpsvr4NP70JDV1f/PBJ85zs3Oh1rL70biVlV
	 DxfIqMwf+WGZDeuzFR7WjZFrpaBPIxq9QPNiQYSKleETade88oBTx4ZAozb4Rom6divn+
	 MwShs0aKKgMY7gdHXIX1voSS1Gz8I4fh8ciFwcYp6H4nc7P9b2Pm89LTJSq0KKXxpzA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yYwYymlhEqiRs6DBKTN2s/UP7DeIuRTvj6NXwGrOnkQ=;
	b=C5VewGJ2gvpazNSVEcW/mA3nEsaHR3QUNrLax7YCFh+qwor8Cv02eFPWO4gdk3+xsg1U
	 F7iT6JjEiUJ8tEPdCmHt/7+tIdx8na1FrgXU4CpVz3axVM/1c06ryUO4F4PVp6om0tt6p
	 q/09Jmce8ajLZJTEISTfeDP6K9k8ixng+Pu9uadQ6yUjLwObH/YHcrATqYTRzfUUyF3vs
	 6YS1oIXcH9kKUq4rWsOiU+VWLfCdQxHvuVItj6drEfNYQF/0JKeHRSqfP+/sYihVVphkf
	 UPjayXiM+AS13OyRl7wDwb9FjlcZao+D1ZnXuLijTz4SZr7ZoGFqH5ew0cvGmFmy7LA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588094;
	bh=yYwYymlhEqiRs6DBKTN2s/UP7DeIuRTvj6NXwGrOnkQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WQKQkUlgX9WWnNZB0l7vc902FpSOG/uOsE2u/3AWKBn6E6y/jUDciKZ3ollsQEzmj
	 TK5ONtB6sS3llRcrxU3ob51MSz1UKrZ7QEhFDU/xfPXSFqFbrNLHMIUzXYo3kkzunE
	 2jDD/56wMjz51Xn8/QZmJa9dhCeWyZESsiFHCpxcXVP5MqEqGOfdOnAWy++thqcdtx
	 8g8YOpSbxuZNzItstszqF4JOEtiRWT4GwQrhg069EtifiD99wlinBOqWXjpa+RVQly
	 Rf2VI7oe2b1L1dERxcgQNQ1dsvsLWDjxkXEvOJKfNgUHz63f2ShgBGD7TO33maF5S8
	 lY2I66eCCrHbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6C04608B7;
	Wed, 21 Oct 2026 13:08:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0284C930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCA97408B3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ElsIWLLHg_i5 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:08:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F4B840866
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588092;
 b=F0qi9qNnPKgdX4xCwVEhWRdP6S3YrMGBlwmO2TvhzEdCWTU6Qqz4TThwMCmb7A4o5UYf
 ziIj6rQulnjxW3pRGYQ/+3Ngif+a4FB4zLOLK8UeA/Ew7FDub6YTo3kJV8kwUOIOgGgJE
 xRBV0QBWwu6WEZafoLUca7qTSjsptXXK/af9axxI2QovSHXTVXvH+gdXUrRc2fw9ybtsC
 4NnHppH9/BzZZRwLpEeM3UaCdf+hB32NaBqvcnWOjp6vjPsOzw7PYF7Ej4rl23zGG0ZjC
 knSLvEGLWkIEqMl7txJ5Qb5zw8l+risf4Dp0alaxQxM6fnhHod601vcym9jIWUERMfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588092;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=yYwYymlhEqiRs6DBKTN2s/UP7DeIuRTvj6NXwGrOnkQ=;
 b=QG86wS6jqOS9fBKqQvbEnz64dajmndUTb/omaMLtn3aNtxFOQV5fBsUitMadN4rV7mhM
 GSkPSCirImm42Fybbs7MFbNhm9PP+XO2W5H82vyich+NDEGr3IfoKjzQyUSeqpNxkVkRK
 4dmB6EIHb4U+U2t9A+7/3ecAQ7j0H/XyMfBNTK5eigyESyAFYwzdeQWanKqVXw2gtDcgZ
 rR1rIHn1pUvmvRsQ4qEwFFSKi122JieZKl7XgigMBZ1bZGHWRZeP7xRVYLmAv9eIJg/QC
 GUlfj7u301RVChEnjT7IaX2F+B6bVkZiX0q+KOzewviGMv0B7VSZvJOh4Gnc3VG2F4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XlvrtjGy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=XlvrtjGy
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F4B840866
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:11 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so743860a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588089; cv=none;
 d=google.com; s=arc-20260327;
 b=VDqb0MmMEJAjrYfu18QVwJWF4vAmOxd6IsRQtPvft1fZ+z73HSzod5pAaNu8Bw1k8G
 WI7Ny3LDKQJnyYjGINRsgtsRdXIByICRY3iDIteXDqzS4KMa1AVQuCGicIjpkMuQibK+
 IlD4zvsMnLJ4dfPTib2FH8n5NnKsDKfmxbVXKrsR2ZY514FpyhlIWEt8mhu+PTkhshUJ
 5SGoR8+qcTvn5WbccElCuRZr3g+ZWWE2itWCDjdXSx5xuHGP/uL6dKoPPQleafVWJQrl
 +GesnLt7J9Xhof7SjTe1ocjPPfkdoi5kAT4PxkglV57abXBzbg+JjCr81hCAPO72zqNd
 o7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=yYwYymlhEqiRs6DBKTN2s/UP7DeIuRTvj6NXwGrOnkQ=;
 fh=rDOkmCQJ9cozxuZkgmyNWj5k0ThXnY0U4gnSEgE31/k=;
 b=D24oQkZOpOBm2QQxeozqBj3JOIchvsJwurCw/sKGFZNkYv/mqWdmIuC3gHHZA5LbMy
 t8+Seg64FfuRPDi+BkUPdwOarfAI4VmoZbBBQHhaC0Aveh5TOQ5ZO2L+ZN6ls8CfZzeI
 HJwSMb9DvEnhyeRhLhCfY05yruAYI8JqdeqiADS4cnmQ/qmpM7eH9Wq0jgYbaTeFDkWG
 ZKuAzWwX1SZptAlzrrsXEhcsT+2BDILLzyzdQoSQ7NDs1DC4TuYY0spNDy7LKA1Z7GCT
 UTW0t2YVwkxzPRo1wTxdV/YB2tUNDWnim1zubWKi8XvwRIXmg50imx56wpI5j/AWiYQw
 S77g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588089; x=1793192889;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yYwYymlhEqiRs6DBKTN2s/UP7DeIuRTvj6NXwGrOnkQ=;
 b=XlvrtjGyaHnYZkxv8WQQVMHdekAli1xNiz3lRR+yyToaH5C6liECGytlfPAunSWJZy
 ddWoFkNEaKFoISaGBXqHEVrOe9h9Ayn2E57qIYht+w9uQZWQeMisiWAB/IJolusS4yBu
 SIGm93kkrgTFUdVuIcITc1UwnGkEalg1fNb1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588089; x=1793192889;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yYwYymlhEqiRs6DBKTN2s/UP7DeIuRTvj6NXwGrOnkQ=;
 b=P7Yd9gi4n+WVrwA1dva9CHgdRwv3L4b5xKdggDQp3sJIvzEYLwPLe4C9S8wkUHnlwa
 8RYEQWl1cu+NPYe0w8Mg5XLi+z5L1tvYLs80UE+6VDX7XdPAqvurIx38VM3gl8rLxsjn
 4zXgGLn5zgwgT3azoQvc7uYXAuUzHFTVUT/hKoDrT+zwLtd2EWd27jCIe5vCZG2KPSyG
 a6655vZYnvh5Zq4Gwkhz0WKBkcwDmnykrC1ckbF0kgA4+kk87Zgee4+8zqQBa4tDXA5C
 SILO3zmBq0OL6E5fBk2ga0f4pwGMG6Y8qQVkMWThjMXBY1wuiqBviFUUXqf240qfLXyE
 7LJA==
X-Gm-Message-State: AFq9FYIL0GpznSUmpCIj9ur7Zby6B6xT7p7nf8xdInJmM8WYj7VLF7VV
 P55BmiGuznzT9JCXddmJ402o72i/taWrstVec6RJoYSNnhtp9fra6kVGDS8om5AaYmaoNRi/wG9
 f1+YoU1Xr/EsmQcfIVi/Kk3qXVAmQAeGnM32DwdG7
X-Gm-Gg: AYBFou1TZ/ez5ajgDex/U4Bihsp1yr9YGFeH35fapMKJtLcHnuBC4hq2Iv8ISPaCqKJ
 PJ3fOUEuzc+p93pznRgX5opcYniFlEixXCDp536dDc87nY9IzZBqWzsQkHB/KbHcnkoLBPp06J2
 DHgPsMrg3cr/iIDBrFHsxxcVyxE5rkbHm+2iO/PcqdsPKiqqAPYy32RrpLSyqcOU9pWyurcQp5T
 q6+OjrAPWb7lHb95R3xhQEOE6abK8YvFJfqGYIcEkvH1/ov0M37qRHNeMNFwf39+rRLVAO/Kcxg
 cGPClmOwloor5vmSXJaJ/B5jDWmNlz4K6W+gMcBNCHM3aArJAWSlskGEW7zjG06dICkn1LCOqtm
 X9OYmmGWuGH56mFozVXyOxyflHTgUn1UBqD8=
X-Received: by 2002:a05:6402:320c:b0:6aa:f2cb:754c with SMTP id
 4fb4d7f45d1cf-6b408e97b5fmr1353659a12.10.1792588089425; Wed, 21 Oct 2026
 06:08:09 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 15:08:04 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 13:41:48 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013-b4-button-live-monitor-v3-3-3563b4d3ccdf@protonmail.com>
References: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
 <20261013-b4-button-live-monitor-v3-3-3563b4d3ccdf@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 15:08:04 +0200
X-Gm-Features: AclHuK_qzgpDa4_w17UbK1PqBEKY-esYz6FtB_Oo_zlamKa5r4aVUNou1-jWhgc
Message-ID: <CAFLszTiSqxm0u7o386mQ1xuaznrc5PSZ17qt3icJjvooJP81MQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] doc: button: document monitor subcommand
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-13T16:33:33, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> doc: button: document monitor subcommand
>
> Add the monitor subcommand to the synopsis, description and return
> value table of the button command page.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
>  doc/usage/cmd/button.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
