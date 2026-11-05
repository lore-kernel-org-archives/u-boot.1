Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB060A260F
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jGEQy8AG;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CatwXch9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C54940607;
	Thu,  5 Nov 2026 18:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DXWRY4lcnIVn; Thu,  5 Nov 2026 18:56:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3CF8B4055C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793904968;
	b=YynZYn3uvTAOLB0j5egC2vljzFigy5Z8z+Xu3eDWqxSPvwDvuTJYu5R/7jXQiN0derSs
	 PkOmLXqGrml5FMUYxI7561r8cx8DvSiTTDI7Y9/dYndaPyV9v19wznsy1FsKCxBa233sq
	 Pmdv84J3vl1Gm8Vv0JobqHaz/C9kM/J+TZL/kxFcSzM+ld7srHOdclYfJ3iKJjvIGvb1w
	 /SeWH5sIuUNHTHhDuOXVaVaf/RwSJ6U1ncTgum0xpbb+Xc7GMt1gltZXQTw/PLAgPfRlk
	 WUvLmmUws1pd2oU2VsF7S6wcdttYO+Ce3DZbxvaZgOZH22GuQardOQ9g8jnaGK1WnEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793904968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wfvIbQPQer0zGej3vS5886QLeGBeVsDg1jyMjc68YoY=;
	b=b4VE6NTPWErUSmBjyqNv30whbf9VU6+/+Oi7hM29tGsu1Q7f7QkCECNc4z4fLETGULcW
	 /fdnvp3/ccI3AL5slqzq0ULg19AwRpDAU7vjmR8Il4kbGd7nK2QSerUq9hJes6F/ouNt6
	 +sTbEX7aiIvHQdJXtdAHiB0lSDDM1kKOrgAwVNhKhiEy9wsvs9XAwSKJeAoaRLjQqGBL7
	 pky66xlpO9D2lNZAube97sWXx1lfKKltOsCXAgcX1F+IbjyM/KRI3UEpYEqk9Pq40kYFi
	 /0uvHBKHOoQIq7Tz1DSZzj9JuFlJniBWFc+jBnQ2dhn9qQDq6erS9lesERRSSHeFhSg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793904968;
	bh=wfvIbQPQer0zGej3vS5886QLeGBeVsDg1jyMjc68YoY=;
	h=Date:From:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jGEQy8AGLDTz82P/MOQ5UPcORYjfuy/3TBFj5NISVgr0Hu4wSjDqxRTUdtY1yH2X1
	 OqcIpjmKrXcozPzyy4FiTdqj45vSzL3bikbvxOTHTWAbFMV6uqtZTAWcCYVTggngEb
	 XiATm6v7Kl6dZHsBVc6fER87A1Zc88QCxe7GZcMWc/ziDvnLhRJS3CZnPp0rAqbtqX
	 y4JrAxpuk7RwGn5bjZC/LS93JyWEN1DXgoR98x2HfFQwsD7wm2bSAFyenqHG6A2ZMh
	 z20UtDEVKgjD7ggKkQdAyX7Hjfc1BDshSIeKGNRkhh8O0oThD2kGWi7FKBO2eG2qWE
	 b4qoi9jZdaEkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CF8B4055C;
	Thu,  5 Nov 2026 18:56:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BB48931F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB6D040378
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YuFW8Rsf6-5n for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:28:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D3C8440363
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ekovsky@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CatwXch9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3C8440363
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793899728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wfvIbQPQer0zGej3vS5886QLeGBeVsDg1jyMjc68YoY=;
 b=CatwXch9UBtEok0v8LWt1w2tpCOphwC0+SFQCNXMxf+gQtmiQNn9qGcAjjo6AnLsSk706R
 8uoUSfyL7VPBAY5IlsFg9FRW65lkFyk+sCNi8y+VjgJrvT0W1qRvpJnj0MW1kFwjxeJoMQ
 EPdQCl5P2O4/tno80iiSOxbx+AFzueY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-YN99B8vKOOGSZgl_NbFhBg-1; Thu, 05 Nov 2026 12:28:44 -0500
X-MC-Unique: YN99B8vKOOGSZgl_NbFhBg-1
X-Mimecast-MFC-AGG-ID: YN99B8vKOOGSZgl_NbFhBg_1793899724
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-702f2edafaaso2604199eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899724; x=1794504524;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wfvIbQPQer0zGej3vS5886QLeGBeVsDg1jyMjc68YoY=;
 b=mjRCjO6DBJZiQXq+jY+r6Z3YBZdmHvBdukhAAwiwZzw0uLIF5noXW/Jss1Rcy6yVTu
 YwgA3C7+/cf+J6EseEDS0ztvALP8gap7aT+072w19dV2I8sjPUIkaPYtjPrC9knc8aut
 BwrLyemZcSdN5e2r67X5/FV/sXIWOcyVNPb9U2WEU+GNuqBM4QfKn2ChC4QrDCamnbhM
 ZrV/hgGdpEgcMlNyIBmQpdawCfMKF5NU0BF1wHAjp5NLDadoM4x8sqMpL0hz5ehY3YLg
 QrQLi4CRJtoabqNMpXIw+ZkOJN9FfLVCMrVdcXIm3cymauI41XONQCJ6WhytJyMtCAKC
 QsMA==
X-Forwarded-Encrypted: i=1;
 AKwUvByOn8sCAv4qCNr8VCfmtwDtJERrSiTTbreFXT/yzwMNctm9FFeHSuRBt98oLSAUpgkVTfBNk00=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+R7TbjR2kyQ7n8qbugkRe/iLvmWfxRbJQ8UsptHaodcM0d8mXU
 rwyLzqhijY921FBjAn87uhHmdNlcU4XJbCpjAQZruD/X1vN+OEmHSVZQlXJtPOcIeIwhFmRIDw/
 ap7U2nlEuBgf8hj1mi+WQtXLmfwotbj1WvVBahL3684tpm9fd1vqrkkAC0nR88RJQBA0Yjw==
X-Gm-Gg: AYBFou2fPrl4b7hW66dG9CVCosrPj664kUXEk4JFwyGELFkfZtH78qCkYTm2Fo0X1fK
 MCG0fQZd2MP8KDbdisaBG8uoetaRyW/YdDUoDdAxaIXZ1uucWKFoVLTBSHOY4pfjYCjlZMl3O7Q
 4Ell+MCH3sfpgmc9+ZZiWfB15kKOIihLXCo9jEuYmRBk9dUcYLUyg1A2ri6F9KXWCAclTMY+/6+
 9eb0GHtQf+75tunuhaiNxV7igLQin8hGpqV/DOKXo6w3sUN+I3FeI24c17meXe5/n0kssutrRSR
 gC+exTapCAByeruovKeJEhJzmQvf1uUdbFOKgskXrEoCJN+xYuXku468VhF+30uHLI9EYvkES9u
 inJ6E8hi+72uValsMaHwWO6RrqAlmA1QY1FbDkLzdqQ==
X-Received: by 2002:a05:6820:2d05:b0:701:795:4ed8 with SMTP id
 006d021491bc7-716e79fee91mr152550eaf.67.1793899723989; 
 Thu, 05 Nov 2026 09:28:43 -0800 (PST)
X-Received: by 2002:a05:6820:2d05:b0:701:795:4ed8 with SMTP id
 006d021491bc7-716e79fee91mr152516eaf.67.1793899723336; 
 Thu, 05 Nov 2026 09:28:43 -0800 (PST)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4acea680d38sm5321395fac.15.2026.11.05.09.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:28:42 -0800 (PST)
Date: Thu, 5 Nov 2026 10:28:42 -0700
From: Eddie Kovsky <ekovsky@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Bastian <bst@pengutronix.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: Re: [PATCH v5 0/3] Add support for OpenSSL Provider API
Message-ID: <auy8yuTSE4QQDR2l@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <CAFLszTg9qSuGq9CHuQWBmGRqQVxT5yMbf267p+eNXNByFy61ng@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFLszTg9qSuGq9CHuQWBmGRqQVxT5yMbf267p+eNXNByFy61ng@mail.gmail.com>
X-Mimecast-Spam-Score: 2
X-Mimecast-MFC-PROC-ID: 8Sl_hiolCl48Kx5-kNaLS5EiXPcDtjMLnlu-aLA5uGE_1793899724
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 05 Nov 2026 18:56:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_HEADERS,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/31/26, Simon Glass wrote:
> Hi Eddie,
> 
> On 2026-10-29T20:13:40+11:00, Eddie Kovsky <ekovsky@redhat.com> wrote:
> 
> > This series adds support for the OpenSSL Provider API while continuing
> > to support the existing Engine API on distros shipping older releases of
> > OpenSSL. Build dependencies for local development and CI are also
> > updated, while the final patch adds support for using hardware tokens
> > with the Provider API.
> 
> One thing I'd like to check before this series goes in. The provider
> path does not accept the same command line as the engine path. -k must
> be the full 'pkcs11:' URI, the key-name-hint is ignored and -N is
> silently dropped (see my comments on patches 1 and 3). So the same
> mkimage command works on one host and fails on another, depending on
> the OpenSSL version. It would be worth keeping the existing command
> line working with the provider if you can.
> 

I have not seen this happen when testing different versions of OpenSSL.
I've been using the test suite to run the vboot tests, which drives
mkimage. I've also been running mkimage directly to test hardware key
signing and not seen any problems.

> > The changes have been tested with the FIT signature verification vboot
> > tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All 37
> > tests pass with both the legacy Engine library installed and with the
> > Provider API.
> 
> Just to check, none of the vboot tests use an engine or a pkcs11
> token? If that's right, these 30-odd tests only cover the PEM-file
> path, and nothing uses the pkcs11-provider package that the Dockerfile
> change adds to CI. Since you already tested with SoftHSM, please can
> you add a test which signs with a SoftHSM token? That would give the
> CI package a purpose and would have caught the gap between patches 1
> and 3.

The U-Boot documentation states that an easy way to test signing and
verification is to use the vboot tests provided in the test suite. We
did discover late in the review process that these tests do not exercise
hardware key signing and that the existing pkcs11 uri parsing code was
not available when using Providers. Without an actual hardware token I
used SoftHSM to troubleshoot that issue.

However, I'm not certain it's viable to create an automated hardware
token test (even using software emulation). Both the keys and token
themselves generate unique identifiers. And the setup requires some user
interaction which we may not be able to automate. I suspect those
challenges are why we don't already have a hardware token test.

For reference, this is what the end result looks like with my series
applied and after all of the manual configuration:

    $ sudo ./tools/mkimage -F -N pkcs11 -k "pkcs11:model=SoftHSM%20v2;manufacturer=SoftHSM%20project;serial=1255c2240187e29e;token=uboot-token;id=%01;object=uboot-key;pin-value=1234" -K mock.dtb -r fitImage
    Warning: configuration 'config-1/signature-1': 'sign-images' is ignored; all referenced images will be signed
    FIT description: Dummy FIT image for testing providers
    Created:         Mon Oct 26 14:08:58 2026
    Image 0 (kernel-1)
    Description:  Dummy Kernel
    Created:      Mon Oct 26 14:08:58 2026
    Type:         Kernel Image
    Compression:  Unknown Compression
    Data Size:    100 Bytes = 0.10 KiB = 0.00 MiB
    Architecture: ARM
    OS:           Linux
    Load Address: 0x80008000
    Entry Point:  0x80008000
    Hash algo:    sha256
    Hash value:   cd00e292c5970d3c5e2f0ffa5171e555bc46bfc4faddfb4a418b6840b86e79a3
    Default Configuration: 'config-1'
    Configuration 0 (config-1)
    Description:  Boot configuration
    Kernel:       kernel-1
    Sign algo:    sha256,rsa2048:dev
    Sign value:   5d66409984c25fccd5e28b6b148b0804c3dcb9abcf2ba1fb16a3fc26e15fcece69a7172ea59c90ec6e3d24735fa22bb3e1a37b85e93a3cece462fad8370ae80cd9a38626907a3cf7fd7ac48456395ea55bfac9892e29c99e39abb81c7bae971ed612534092db804fc31fe36e58c2271e4023deece17c504d2cf5cfaade4de5dd582ce9d25bc65264f2bcad56d20d9fa7671ad50018c32fd13601046f3489ded2bc483cc22ef45299b05cb3bc4968f5339f3b296da3d00621a3762e84df3c5c166265041921481271d68d505690cd18e87ec338eea0cbade2291a5b14556966e969c6d69bb67faddfd532aa90e14a9b714de9bb57294bb6816fc6493f4691c3ba
    Timestamp:    Wed Oct 28 10:36:43 2026
    Signature written to 'fitImage', node '/configurations/config-1/signature-1'
    Public key written to 'mock.dtb', node '/signature/key-dev'

