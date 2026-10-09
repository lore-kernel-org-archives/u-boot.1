Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3792BCA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 08:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0E3D608AE;
	Fri,  9 Oct 2026 08:20:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQ4Kv_DHyFuZ; Fri,  9 Oct 2026 08:20:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C79BD60892
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791534015;
	b=mXgTMaAkAre5KAXaGaozI33QYcoDkIuB+gngZZx/eSWINi9i33TWsVKo7BZx1o5HVDSE
	 AWaNFR1Erk6OieUi9T5DkdkaJ/dpLywBa3xZTZH6b/3BEt32/R1YEyw+VVIOqyPDMd5lO
	 j671yqKjRJWdqjgpdYky1fwOsVW+ryLPW3HM2fgn2PyJMkMS3+UHSgkaqBWLZhnpq2rHL
	 DqBzdrhq9QUiiDKiwACHW6qUPU9Z4UNiLKYj1bb9hfEe9mxwSXfwZQyccUH9DHYsANAws
	 n5wwr2TsouM/ntbjzmdv3Rz+1+9/KdjPQIMqn92FfPj0vgsO1ch3cy8HNgL2dGo0NEw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791534015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YWxYbcKQDoIkPQ1KUwPcNn2IvzNCXt4c1J/cnpJin2M=;
	b=n1mHg2fVR+cH1JICQAUBIJF5o9YT72DY06wqpOJ6NsWHo6Cs2qplpNoe3OH+bw0ehVJG
	 tJEAU8we76Uv0l28dQ9WY/yYnzZ/skcN9132ac2tZv7SuqS/N+qH9zeh5kTm5mNIXjl5f
	 ktbwNcOfZIwNJM1Yl6Bh+29PZYurrA3EU2J8y0GtCRMt5nykhGHvi4pfHNvOCaOAYpWrr
	 wobbX6tyu3jKGezk9Ysi3CC3u3qHk7fDKVhTR7oCgEsS7it9W4CzOXZAcXVEknOACSO2q
	 veoXwbaIqZknqrKW5VVX8MqSXq/AVb9p09Dc/2MDmiafVLYiYxUOC0U8fXzcr3wgz2Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791534015;
	bh=YWxYbcKQDoIkPQ1KUwPcNn2IvzNCXt4c1J/cnpJin2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lo4gYdzSYYekYc6TvV70mLAnpP5MYzaBqVLbe+zDTIc/CPDAw+StFnPm6SmSxO+lV
	 QYICicCNRqf/QSDSZvc+4zwBKt6hJPghJN0BvtTiSik17qGq37h0aCJFFn3wixBJIW
	 3ZvCLZRLkS46+RXo/uZqKvrUVkH7+BMgCsGI2tfI8vGJJE789t1tdTdxjgbYQlu04E
	 Vl4UAID/IcukEASuz/fuaY9Q51BASbIiHzJLI9F8RWvkjWGgVEBXJeDwxTPl+Qf00W
	 XnkNQvPO3NFtoVr3y/HveHGTVJACoAvn6K5dv/wK0jL2TYgELzFtKBNkBnueEtzKH8
	 n2nxnrfDOto4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C79BD60892;
	Fri,  9 Oct 2026 08:20:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EA1F228
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6CD9B40080
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:20:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RV_ciXWIwyie for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 08:20:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1E85440061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791534013;
 b=LftnzJWXjB5WqfP3mNak1n0jss2t3OKMdqq78hEvgzzN6/pZmzcd3RZBd0xloznuHyzk
 ZP9ADlMKKkY18Jt6vzbMxRtQoLkorWPFKMWzNVoQubK2t+usLwNxM5OjtWXu8QHsZtXg3
 qed1CplfFWe1MGFOq8kxvGSNhO4YzBvDuh8DZRGFhruTvROpqta2RceJd9O+NefqBw92p
 F12NPbCYontPrP+bki2ItTIb2r1NDlCaiUM+DXJci++8JsVnWTClcANd5wWKJHOFrb7yf
 RLVkdyt3hGhWmF5fTcYlqjEHLpjrAdbyLmBNauZ619fY1Yt6jUSzP4vUW6iLQPgvZ8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791534013;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=YWxYbcKQDoIkPQ1KUwPcNn2IvzNCXt4c1J/cnpJin2M=;
 b=d2CGeJiVhzkWQxsYTygAKQOOqBkNhaFRY+QoRhaR+tJ7LEoD63W0e99W0QuPFIivx1Wk
 /beIRF4IOnTCIDLFd1xRPW0Pwknc7eOJ9VBxhzcZ7uGQaWKlqFYU9DjvKgehxeqW6/Fai
 IkUbXdbuh4r++yiWyufEUmBLtvSht35xbrLXRhpdpCotWOXUg9MQDGXTbF1vHtjcuEDuw
 P5QmfsneFv2KXdAiTNDgMvvsBcGugyMcNuOMd4NwplQ8ICaIKDoZ8yCRPLv1Tt8pW7pN/
 IVndj/zpxD3rI7m+2vFuxI9yW3mF+WimTubHoZ7y78n5Rqr3wcQaKGPk6pVEPYsygCg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mluW0KRp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mluW0KRp
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E85440061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:20:12 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8726acc5eadso31592377b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 01:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791534011; cv=none;
 d=google.com; s=arc-20260327;
 b=nALO64GQVL8pOezGWe75fJuICANoLoMA5idgq7kz3D6P/ZPZLRnkgSJlemqqBsOnwC
 wYJAFvU8KSsCatnyZkk/ERpv6VyQDSy1de0iX+fdjFGVOxiF0Amaw2+Td9RBB0QR6AkY
 KIBHOcxXnNxiMO2g4T/BWlClvvOssXx5oJjO7yf5pF7mIR1FPIvHlT4XMcR/jzDsaH+1
 MCJ526/FiTg9TyDwpevtG3xpgOExqCV1QGy22c8ZKQhDdywN+BiLx8ybMgbFsq1UQzo/
 eMdWxbar07HmYrMm22bUtNHl7D6MJQbU9slLIXBy18wX9w8xM2MRygSC/MA+fEQS05K7
 Rolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YWxYbcKQDoIkPQ1KUwPcNn2IvzNCXt4c1J/cnpJin2M=;
 fh=dBPtYC1TZ/qisQKccqrPk+ZU1k6U81Ut+AAudAfs85g=;
 b=URIPUqFvMkmwJhqDSMvsRYtlktsV7qhNrzpjX6m5ZtMvYfCUU0Tmolqpd6tnR0Qs7S
 eyQnKekJy7CVPjsC9hsxcqbIGPLRToRbU0CDxxzvll3Nc77q39bqQqTm7tgAGuRLZ0KG
 iUqGOXBvimwgL3SXZnQh3ld0qqwE0bm2C3uUPh6xA3a9ya++ETaExaBhrdbNOrcusRrM
 8W2gy/on1sNTrkqEIwGkjEFpyf23t386NseH/iuigxwks1vPj4SDLMWPnM1Ez5hDKrEM
 zwPUPUhAPcLR6M17gOQFWLecL6pmkoyeOG4AgKTYFc4BGKsCyi6ZHghcdFPxnJp8aDuJ
 yX9A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791534011; x=1792138811;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YWxYbcKQDoIkPQ1KUwPcNn2IvzNCXt4c1J/cnpJin2M=;
 b=mluW0KRpsk03rHmGsd1+c7ceiwEO7TkV24O2iRtzEwedkReFcF2/mDcTXN+HJ9MAYA
 HvZ5mnaEY09WCXsDSDDzpUhyqqK0TsnQfdu8Becl/EFiB/DkLdgLtSO3pctWpKswk/qN
 pZR49u6u7eKo7B5MNnTtRttMk5p9tdpTZhe6+8m77ZS0Wo7RcopUwFRK+3Jpy7nezgky
 gU4upaoiEamDHWRHrP0NuAO7XeYGzOsKNKBeKZsNaeug0UbdyymOEWmukU1uQ5fplbZv
 YsF06mduCm8aNrUdLlIYABpL3HBa0y4n0aEt448Z+C6IDLaAszQ5ZbWG8UKRGEj8LJAo
 mBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791534011; x=1792138811;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YWxYbcKQDoIkPQ1KUwPcNn2IvzNCXt4c1J/cnpJin2M=;
 b=LsSsyVU0zx/Cssel/R859L67XNtJphealO30QxyFs99k+zjtk0pjvROwGCdQ3P6a/a
 QTorjLbS2PLGl+gBYoktCtFVxIukouXN8yk+UcOT8tcEFzUSLjv1YMlC2Goyb6zfJNA8
 Xkot7Jmbh8ayvDhRaO7NAodkoCM2uhSdv7lBSptyvfqNb4NQ7OmjneqqJNsktFEskEMZ
 Yw04Kx2Oks1wbdsNdPHqtQ/fI3MrvUIr+lTVID/xa7/GtDJ2u9XndPk6FUx5QZ2xbgHR
 CcyH1nq9m6W6v0+mOdd5UjBAK6GvYRLOKdM9G2UC09sA/0JyAOxd7Qs4HtT34VrkxV/R
 vvSQ==
X-Gm-Message-State: AFq9FYImd/i5YPX4cnbwmc9lfvFYiJVxPDIq4blVLrM2++0h/G8mPMKZ
 H4SgmnEcFeyTUM/y6PTt5ng1EuOHjA5yLA81HlYcVtrrXIpZBrCPq46bs+K95mfXrE93cVtcz0o
 PmS/xJT8brDn8UeIQNVIq+PfwpL8Yal9pbbFEhoWNXA==
X-Gm-Gg: AYBFou3OjjSz8hVh39ln8CzQY5GNF/WUGpLNBIhrF7eSLbWC8BnCPuqGyeLDlNsOdiT
 qqR5iA5BjgnwxUrpa5tnLvRY43eFbB6hS13UTygrChNrAp+ONzTvX5rwvA+OWiTTqZP/jH5h0Qc
 wu4cZmGXkqMoLfNY0Ram9dmFKePGYIf9RQJrKEuywhzQJAjnNKc+ecsVigkzc4u2dv47gvACjJN
 tFFmH+oYsLtk3ZQY9hIbxjfsIzwPFOG1PHFsudem06LrZyHoi+wdKPQ8F7dNC+B3tR4nHucL9kH
 EVQ3+Xy2C6Y9XygYti1V0JnFzkGgGOBg1IrSxgIvuuTKUnAVQ+CxDkX35sw2fmwUcgryewYSAiW
 bptYPsSqGRErUpsyU1eS3GDYVMBpyVwxh+n67VkIoS4B1298HVeevePZFayaOC7WRox0Znoa2k1
 c9j9o8buArZIB/K4z6K5HOBTXXcVyTjyoPYRB32yyJrEmZfUvelYZ7d7O2PaCT2XalULVJmiIFa
 JA5thf2GBs/4MFWZFqkoepwuV3h5Ud35DdpsjrLXFGYXqhKclDL04mZnsYA/mJANucuhLIxbh3F
 ymIIkoyfD1XIzD9DpMiDIjmknCBj4U4JZ7u9C3TxpD7JF/Hz1r0V7pOLOJwp146872c60Cr1OKY
 bdRu/94eGAEjfnyDcxrwPtY2HzKjic3lEO/eRMCGVV2c7R2jYFSMt8A==
X-Received: by 2002:a05:690c:6610:b0:8ab:4989:bcc5 with SMTP id
 00721157ae682-8b07ec970bamr4146717b3.2.1791534011066; Fri, 09 Oct 2026
 01:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
 <20260914110106.1974894-14-harsimransingh.tungal@arm.com>
 <DLINF8X5LGMM.22DVNGKNPMAM8@linaro.org>
 <eca5e6ca-ef4a-4e20-9255-f7d20ebe0788@arm.com>
 <CAC_iWj+VHR_vGb8EYqR7tzLXihZLW586BjnjPsKswf9uDnngEw@mail.gmail.com>
 <55e2793e-33fe-43da-a509-8e64aed0c432@arm.com>
In-Reply-To: <55e2793e-33fe-43da-a509-8e64aed0c432@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 9 Oct 2026 11:19:34 +0300
X-Gm-Features: AclHuK_S7GI6-_HT0un63Gb6Ay7Z5E6K6Ja26u21r0QCKvlNZ72tnr-9H6rv9VM
Message-ID: <CAC_iWjKRo7Dm4f7FmMi15fELP9_A5XYmMmBtQN8q8qBFs1e+Sg@mail.gmail.com>
Subject: Re: [PATCH v5 13/22] efi_loader: enable TEE runtime SetVariable()
 over FF-A
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.u-boot-project.org, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

[...]

> >>>>  /**
> >>>> @@ -1129,7 +1262,7 @@ void efi_variables_boot_exit_notify(void)
> >>>>      efi_runtime_services.get_variable =3D efi_get_variable_runtime;
> >>>>      efi_runtime_services.get_next_variable_name =3D
> >>>>                      efi_get_next_variable_name_runtime;
> >>>
> >>>
> >>> All the get_variable*() calls used to point to the function from efi_=
var_common.c.
> >>> By changing this you are breaking the runtime case for OP-TEE since n=
ow we will get
> >>> EFI_OUT_OF_RESOURCES.
> >>> There's no easy way to fix this at runtime. For OP-TEE the kernel mig=
ht replace this call
> >>> with an internal OP-TEE call if it's part of the firmware and announc=
es it can provide
> >>> EFI runtime services. However, the default uuse case, which we don't =
support SetVariable
> >>> at runtime only needs to keep working.
> >>>
> >>> I'll post a script next week so you can replicate and test this in QE=
MU with OP-TEE etc.
> >>>
> >>> Cheers
> >>> /Ilias
> >>>
> >> Hi Ilias,
> >> Can you please share the script, so that I can replicate and test this
> >> in QEMU with OP-TEE?
> >
> > https://github.com/apalos/efi_optee_variables
> >
> > make run-fip should give you a QEMU command line. You just have to add
> > an OS image to test.
> >
> > Cheers
> > /Ilias
> >>
>
> Hi Ilias,
>
> Thank you for sharing the repository and instructions.
> I tried the OP-TEE/non-FF-A QEMU setup from your repository and it
> exposed a regression in my current series.
>
> With CONFIG_EFI_MM_COMM_TEE=3Dy and CONFIG_ARM_FFA_RT_MODE=3Dn, Linux hit
> an EFI runtime paging fault when booted through U-Boot EFI. The reason
> was that TEE ExitBootServices() path only installed runtime variable
> callbacks inside the CONFIG_ARM_FFA_RT_MODE path. That kept the FF-A
> case working, but it accidentally stopped the non-FF-A OP-TEE case from
> switching to the existing cached-variable runtime callbacks.
>
> I tested a fix by keeping the FF-A/MM runtime callbacks only for
> CONFIG_ARM_FFA_RT_MODE=3Dy, and using the common cached-variable runtime
> callbacks when CONFIG_ARM_FFA_RT_MODE=3Dn. To make that clean, I plan to
> add a small separate commit which moves the common runtime
> QueryVariableInfo() and SetVariable() helpers, plus their shared
> SetVariable() validation helper, from efi_variable.c into
> efi_var_common.c.

I am not sure I understand the plan. efi_var_common.c already has
callback for the above, it calls the _int variable for each service.

Thanks
/Ilias
> Then, efi_variable_tee.c can select either the common
> cached-variable runtime handlers for OP-TEE/non-FF-A, or the new MM/FF-A
> runtime handlers for FF-A runtime mode.
>
> With that change, the same QEMU setup boots Linux through bootefi and a
> small initramfs, /sys/firmware/efi is present, and efivarfs mounts
> successfully.
>
> Does this direction look reasonable to you?
>
> Regards,
> Harsimran Singh Tungal
> >> Thanks
> >> Harsimran Singh Tungal
> >>>> -    efi_runtime_services.set_variable =3D efi_set_variable_runtime;
> >>>> +    efi_runtime_services.set_variable =3D efi_set_variable_int_runt=
ime;
> >>>>      efi_update_table_header_crc32(&efi_runtime_services.hdr);
> >>>>
> >>>>      /* Record that ExitBootServices() has been called */
> >>>
> >>
> >> IMPORTANT NOTICE: The contents of this email and any attachments are c=
onfidential and may also be privileged. If you are not the intended recipie=
nt, please notify the sender immediately and do not disclose the contents t=
o any other person, use it for any purpose, or store or copy the informatio=
n in any medium. Thank you.
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
