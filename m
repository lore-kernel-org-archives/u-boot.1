Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705D606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L8oy6PaG;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=f7mJQaRD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 914C060A48;
	Sat, 24 Oct 2026 06:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2zhr4WGnqMCR; Sat, 24 Oct 2026 06:33:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C721460A59
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823609;
	b=oDxpO7kFsKsC+rx2NZaGUohIPoCsqNIFwjtSYlLkJx3BmjFs7LAulk+H+KiSWbcunKGx
	 +QABfcPJr5S0KmBD4Ld8Ks5Stlxx8iWLpWe1cZPDiUZjY9yuHxD1e7tht7zJsDmHWbpE4
	 5vm6NuLb2Jkb01ZYu0bUNgCpjSFG3hblqH4BSzh3qDBh6P2nqOm1g7uc6iU0yi7HFzu6V
	 556KQocOughlSse+zqKRTym9RzrI/kIw5uoso+hcmkRgbsdi1la5ibCMnIj6cQ9xI3D4B
	 kKACQ9HvomZ5SXBNYAi0xZDUKO9MpG7pW1sw1qgmEKGxUScj3LW71HsrcNpdE3O/T/Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792823609;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9BJtXjaN7KsbCHk356eY1pwcuo9L8X2B87woV4XS9aQ=;
	b=Qt9b5WwzMw6/lllDWVXbBFvBdPkrr9SJHovY4zJ/ugWI8BWXXFMdWo+iMXi7FRTLabw3
	 +qPt4fyURU7TJNSP4SeLG7y8qHEzePeeDdnaHeYhys6FwYHtVkA6toGNyU+mg++wzGnzM
	 4TGuXh3dfoqP7S9VsNl1bJvk3azIu1VTuf580v2Mw4TncNHeYiGqj0SmuqciyDQSVaMvw
	 G3//d3oOXMh4jf3INNG4SMB2h/AcNYv8hTzpaMraSc0lgglVCb3sMH7/pnE8bNRZGaGJv
	 ET0wJ4d8oPny7mUFRdLDfJd/KpeD9owZ+mb+9ehQNmp+G7mC5eN46wojg0HAQNOxsSQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792823609;
	bh=9BJtXjaN7KsbCHk356eY1pwcuo9L8X2B87woV4XS9aQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L8oy6PaGBuLtKsWTuAQm5fglHgOv9Dfc2syBhWikDLk96jYKbKOG7EMHxa0jQnkAx
	 tUv0QvYzJMFRjWL4eOPWUheOfn28HuUgD6fASItFdiP6NMdpmuBVDD1yNZe9M/bsFG
	 31DwJFScxkQvK9ZsS6KTWtCLE/mq+PF5QAD4p3IMMV6sSS26MMQNeR3ZIrOUq11OGU
	 Gd2+sylsATMpgyQDgRzgRLngITxgOPVvZ7PF2p+IHwpcKaOQijejKU7mbIDvAzYYKf
	 klpT/MoG1zctpZqq/KXylZHST3KMOi157TMOdkBjEvoA6QbBjvuIvJUSlEZDoEGq0p
	 iyNNRzBLVysHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C721460A59;
	Sat, 24 Oct 2026 06:33:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7207E4D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56FC28162E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ZGgrjK_D3NS for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6AD88815CF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823603;
 b=ItNNtDnSTtxIY1IyyHKa0cpCsc30cYHBuGeF/uykde0eTcTTlHBYz47y/HKTnlc15yNC
 4OVrK0s7513zCif/mHQhbOCk3DmqiR22V+MeVlXhEEB5DV1BkO7AKLukHgEVR062++j8c
 4s40tWm7mVdBRMoERPj0SXNVIJ9eYWHKVuYhur+7jUtzXjbQ6+29ypa8WqFcshJrc0xX3
 ljLlfRDUR+pkDmIiMZgQEthwW1J5uUGUCKCp7+HnqJz9TXmfVr3fe+bGZItWOXFXMvKXb
 P+f1aD3KoppjwqDzt958ETqJa0XywfKYLDzCLKZTwCIM+bDiEs7zF+OFnnOAemvOXxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792823603;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=9BJtXjaN7KsbCHk356eY1pwcuo9L8X2B87woV4XS9aQ=;
 b=iZ9clIUJvoNoYPzYdcG/6B/bnj97ey/oh8DMfCom3p+lsnx+zlIiyYvn8vfEkGL9vxB8
 xqOTbP4evz685719JAGmY1B2S2ELT0G/Rp3z5hFKU7G4ipb33kMr5N31QtB7gzh43Y0Mf
 Vz8b48yXfBuHQVpj1EOVaGgnBKvItn6ebhCVLZTm67R0yfIw2NdDdDErGwhxLQWHGVRb+
 38flMHrZTUot5VVs0ymZnQspqsRw3/NZ+GYC6mWIk1kTfruXjnf5STQM+lNltGrLkrXRo
 5VrF5yWymbAZDMf3QWRTiBxBPLohfMlho0amlawjH2j7N9DG59DOVLKmwOC6sYOn2ug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=f7mJQaRD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=f7mJQaRD
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6AD88815CF
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:22 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so2193030a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792823601; cv=none;
 d=google.com; s=arc-20260327;
 b=Wiqv7F34U57FxHyx9HYft0UtCh3bHT10HvmOKpKm0cfF5gu0Znt+X38SJdyD3VohPG
 q4TAjOMuOy2ZYaeWOJzeHTsWH2vEiy7WKrgymdtzNUM+1g/ajdOsh4RBHr/tIw8PEvjh
 Oj1zoKkxmbm9lfNGpeNCeue2jGhDBHoYFrfdZMoLVC6gxCHpUqoZlw4R4NrEcZE2No8e
 75DPy/pC0bpZro3+3Rt/dwcxFUlPuIIOs17LR3U4wcZw3grYSYFgQFluTxpyeDJDNxUH
 e5gXoYu6kCP1c8pJYc4FfjvHty/IVqIPThmZ8FGPbCqdYyszfOhWbeLtQHSNEELePmQ1
 o3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=9BJtXjaN7KsbCHk356eY1pwcuo9L8X2B87woV4XS9aQ=;
 fh=HnXSJ8VjrzbdiM/Q6+J4R/OiiD9MBxg1A9NXO8vorZc=;
 b=P4maPojHt2fO6/p9OZBXtflnIJt4i10TCdYberKZbRElORfT9ywihINJ83HTvXdXz5
 bvlG4AQ9UWXyiXIoikAETC8DYDBJvyoGOxQ3TSThEcDXTYcD7MjWzPWrZsG7QJBukNpw
 5LXce2gH1gzykw2K0CBj2byqSUDyGRmNPA6AhlUPbKIDxX9//aOISXmtqLTASDhyf9+r
 eXDp1Jjy8UlcXzJKDfWDoPiQQo8ekmavLhGYD2/s6c9mBSJY5AAAbj58NgGioKClKp9h
 GHIsACekggY3YKSwn+190D1uK6zlz9bLbu7IprVnbJF2lUXMTjT0rfkH24NnqICmTOx4
 rPWQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792823601; x=1793428401;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9BJtXjaN7KsbCHk356eY1pwcuo9L8X2B87woV4XS9aQ=;
 b=f7mJQaRDFnieLbyedzM2yjteU3OAHc596j3UFMZeZFDvq2RIx0djKWNqqBnGaJYB0a
 c3sjAJYFbPGfks+p99vqSI9osFv8bGduhoYxCOoDfLBXdbpS0roUdfKGpJSiDVms49yI
 5H6ulmyGzeXvVUzqIQJfXOevjRcF+NFTekB4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792823601; x=1793428401;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9BJtXjaN7KsbCHk356eY1pwcuo9L8X2B87woV4XS9aQ=;
 b=wA7FlUG0mr9TnfVh81fbvP2Bdy9AOQi/SYLYwzmnZyjbDkCHYNP0jakuMGb3B+lDrT
 eXD8AP+5qz7Av5okFsFKyoqrYTq4om+CeDe9+Vpo35UjyLc/MtQqoXmulJy1nN+EpjOp
 mp2yrkzx+morMZzkuO3fQunsDLRaWPPVz6EAoSgVUIShmHzGeHAti2Rf2kiPA+WQOux5
 Qt+rn/0O5dSEI4jlLFgblsFWseE1n/BQZfSckMWmaDn2Bsj/u1x6nlWdCagf3E9PtcMK
 Vy7xfaNvSGRYQY7GkLXN7wYlKCNL0tx4Kr+wh5Jh03FRO0RqqnKuGNFoNnW+uj3YVbSX
 OxeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUXvbcnCVgEEseRPntTzQwzzIMfLSBhoZRpUuz9JtbMOmmvsRQ5IRtRgKPDz6wM2R03mnDbqA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI+J6Xsh2hUXqVslI92QmuJ3qNQxxUG9wY3Sw3vhlu1SnegRNSv
 6ZWm5gpQ2VnEM0kYT5DqaMSiclBlOtTQ3IHBJ4sXqDMM5Btg6kB/J4N092iunjWyQU3URF1NStI
 nLg3UWQf0qv+met5rE1XGxysoiRCWi6zt+v0FTm8S
X-Gm-Gg: AYBFou3f01Zt7pQB0kizN0c/qOw/plUgO0hy/tx1C7Cqsr9bGiMxoWFyNc1Tloa6dIK
 ku4xOiB5l5OVxBt9ZAi5sWIqyyMpp37f4cgk9BM5UoXTgCX50esyPgGtGxMX8dP984RI1LJQe5H
 RS2ucCuh1LuaCKZjYHaUFoLa/g/1F//TOnYzngstTbAogGKFbZykKHWAPhDrRx7he0uCKDZzuhZ
 VcGa34fkAxgL60c4A3WJ0w4tA0yfbJPHaCSXnk45e7ZpQyvhn4Q8iSSpb1PQRVxGM1gjdfCygCu
 XA8sXkJq8Z0Zo5Ehr8vMIevmCTlAQWM1ZAmkhjoDpHruOgY+gwakRTeD9e9knrCjfirPozOGZO7
 jSRQgKT+1Jig156ppOLMUKDGSZBqT0sSrKRQ=
X-Received: by 2002:a17:907:d489:b0:c46:a607:6922 with SMTP id
 a640c23a62f3a-c46bdc10c78mr107374466b.25.1792823600783; Fri, 23 Oct 2026
 23:33:20 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:33:19 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:59:17 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023090611.778581-3-yan.wang@softathome.com>
References: <20261023090611.778581-1-yan.wang@softathome.com>
 <20261023090611.778581-3-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:33:19 -0700
X-Gm-Features: AclHuK9XdaurfZFL1FLFkYV7oq-YJgSpC3A4YLpFK472psQpwJXcsOTafV51CX4
Message-ID: <CAFLszTjJ6hSXicqk0_qK1t1-kTvrWFK9Hsy8VEcsChWTcfxh0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] binman: pre_load: Validate file signing key
To: yan.wang@softathome.com
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com, 
 alchark@flipper.net, paul.henrys_ext@softathome.com, 
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com, 
 u-boot@lists.u-boot-project.org
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yan,

On 2026-10-23T09:06:06, yan wang <yan.wang@softathome.com> wrote:
> binman: pre_load: Validate file signing key
>
> Use integer division when calculating RSA and ECDSA signature sizes
> and reject file-based signing without a key-name property.

Please can you start with the motivation? Without key-name,
os.path.join() is called with None and binman fails with a TypeError
traceback rather than a useful message. For the division, as far as I
can tell the float values still compare equal to the integer key
sizes, so say that this is a tidy-up ahead of the signature-length
check in the next patch. The subject also only covers half of the
change.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -199,6 +199,10 @@ class Entry_pre_load(Entry_collection):
> +
> +        # File-based path: dispatch on signing algorithm
> +        if not self.key_name:
> +            self.Raise('key-name is required for file-based signing')

The 'File-based path' comment only makes sense once patch 3 adds the
HSM branch, so please move it there, and drop the blank line after the
docstring. Also, patch 3 checks the HSM settings in ReadNode() so that
a bad devicetree fails early. Doing the key-name check there too (when
hsm-key is not set) would be more consistent. What do you think?

>
> Signed-off-by: yan wang <yan.wang@softathome.com>
>
>  tools/binman/etype/pre_load.py                       | 16 ++++++++++------
>  tools/binman/ftest.py                                | 11 +++++++++++
>  .../test/security/pre_load_missing_key_name.dts      | 20 ++++++++++++++++++++
>  3 files changed, 41 insertions(+), 6 deletions(-)

Regards,
Simon
