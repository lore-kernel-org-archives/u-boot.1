Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECFD606A331
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NGc5PJJY;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pQi3rMlE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE62D607BA;
	Wed, 18 Nov 2026 16:25:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S2iLS5EKO1HZ; Wed, 18 Nov 2026 16:25:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48EE660853
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795019112;
	b=DowCGcjhA05zUvd6dbJJSo4ue4VaSQa748iyRuOeO2HbsMnoMCzGNkY1ndSnHpaixbyD
	 wbwd1G7TT7JuVKBVUibED+Ky4TxDXJRQLVdukuwqTDdfNsBhB71tglClUkUuiBa/jfZUU
	 S/sIhtFE6n9ejrC2d2YG6Ykb6U+Zj52zoPcx05w/PuVq1/lnffgi+yAc+15E3Ry1al7gx
	 VDFL6n4uqLFPcf12zoRCKMtDRnbDUkddL3WaBXgrUwkrFx2ZGe6L4jAJuPYWMx2YZVMrf
	 2wQxSxg3sUDu8yAIYYw0KFNE4KOiXgLViGsoJL0PxuT5NDqJFafQXupX/lUe+Fr6VrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795019112;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Z2vRVknH2HLng5CzM/fct2E4fmsfZdPHdw/RBb76udM=;
	b=i+WczhxyJXEvlNURni8EwRY+YmyqWL6si8WxHQe+Lbw00Rjnr3O8ZXadgptTjt1HmDW8
	 6R0NVCRugIiLL3OErwbaLHqobrMZx3YKV6Sbe55W7fy/4HEgmct9zbbsraF6I8AVE9GZB
	 kDzFnPGyFv7MhP+8InF3obWU9JxjWsMvdnNGQUW8R7JwqZmwGD2m32pCOxj3inQta+eQX
	 yE8EdgKHZ64NwosABwjBj/1MxdALOeLytLFBpbJ+PpYXaExJGn/1BFt4vLjyh6l72+OkK
	 0Hruij9TmIjQOYYI+DVxp/EVAplGaHKcPZVDiAIUjzFv9KVdLlTZpRNndtPEcjNpmlA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795019112;
	bh=Z2vRVknH2HLng5CzM/fct2E4fmsfZdPHdw/RBb76udM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NGc5PJJYN3FEcMNBPpwu6HUZXmWI8N3tHVoXpik7BNal+lr6rXqQkzkhCjkhLntc6
	 a7aU0N2MRSeUoyjTA6VHJGaOC+lB2soSX4COHsgA2mWD/WLZcCdhLq0vz4WA/psf5C
	 R2hBfa9hgFvTLZV0DvdcXcsyLsV4+GDTXWfDVsuFIHC62EijO9bpyYTq7cTmiB+3xT
	 5IHNSuyC6kM7u+YMgwFqjQdViECLM34WRQwugGXrxwGlZPUUYTiCZhzZVIrIx1Z0/T
	 eDMzZMiVChaa6ifNc6+rz5nmFZ/CKUqI2pMXw6ZC10sHmBshX/9rLhXXJMDnh2IX0l
	 lHkERQIdE7mJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48EE660853;
	Wed, 18 Nov 2026 16:25:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FD37977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35AFE40792
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:25:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KGycje5UVn0P for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 16:25:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2FCA4406D6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=pQi3rMlE
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FCA4406D6
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:25:09 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67dc7eb1442so1187600d50.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795019108; x=1795623908;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z2vRVknH2HLng5CzM/fct2E4fmsfZdPHdw/RBb76udM=;
 b=pQi3rMlE2iXwmjJCM3IIuvvR6FAvSRQPqJwxS/RjN1xYm4aG74VLRQDSbTewaWfvRj
 uen31LEAC27RiZwWju5xeXlRK8PwElcOSDf4v+5bbmryHoKjT/cH8/q+iZdOnQxCuAUF
 h2S8WYWK82bsINiU4RCUzH5xgGBJQ85eeGnDMitdOwz20GMBSOoaN+rOZ3KjIYwQ/sky
 akfUjn0+QxdlvY0d7qLbd3mwMCFatLf4my7Z61iEg5mJipdnQWyY+6HwyGKzqR/MK7mD
 DN1Gu0dY3tdGVCTY5PsP8V0pWKOxSoywXrp4E2uE2wy57iWqw4e1pqCsxvIDE5WG0DHn
 J8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795019108; x=1795623908;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z2vRVknH2HLng5CzM/fct2E4fmsfZdPHdw/RBb76udM=;
 b=YzCmF8mmn6SvWNxB8PvKgPTcKaJfQgwuUGt5oU7Cu3Z9cg/Z1LwU16fUF4KOM/gHTJ
 Es7D891eqNGjT9//DfRoUvJiDXY+FpDLo2LKB3MT/BKwzrq8wVCcP9m+/+ksijS+LI/s
 9ul3gSC/cvD/uK0/60peN4vr8OXe/9qs1zcWRQK02SM/nq5vtn113ru4g5+1WkQn6arf
 QKvMFr5YB5VL76FhRTCZs1qK4CuvwRUcQ+XX35523mqenYhxlaAOSqO8qnIDnmertS5u
 TpvVcNvxsFk9sGF2p12iba4OcIJTf5C3N4Q2buVqvhwpCcPAXr+KlCliTZ60l6SUYkSV
 pDdw==
X-Forwarded-Encrypted: i=1;
 AL+hErEHhDDE//Z1pZIUGY5AzxLp2FjaojES3JDtb4rDvI6fVq/a42Tz1C7kFSmzWGZ2nq4H7Rm6ksA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9phMF3PaLZYLwDRjQKLL7EKDcXy8YQ/LAieCPp3H7Pc9GdY/e7
 3YwaqxxqM9Xf6ySZKLT+Ja9p/f/m9u2gaWR22fTlXPUNBhX3ZsJCDXrawUzqr/E2gislOSFt7jM
 dJkKE0i64jtaw64orR8ANSvhGwz6G5uOpFHrdkzvNB85y6MCo+rzqVso=
X-Gm-Gg: AZFdTZfcTwLttOF2NQhTZtyRFQKQP1agZ8dmpIed9gF0k6zyQc0ocFIJe/Vk6JZrn4C
 lpmJ5PU4+M3bx4BHGGqc74x4a8KnNxkD/wLbol8HoOqwyltPb4mBb3ig62mK6G06MC3ikBLhKRW
 U3CSfh8ycVrhTTFgNe3U4BKbXuo0xkJQhHc+PnnG4BGpW8RZrGnmWsWdxPpMxFEZVRgWDg9bnOh
 t4aNyoS5VzAmuMHQ5PR8UcSt3KG0vEnqpUG82agFIYb7zyIW8QrwXVe0Se9vmpWPTxJxSD9kbk9
 /5uVamaQqMI78K23Sz+v7TnPzEuhx0nE2I5QFsYOE3wgTeVlARiB0U/lfB6rfitB2cX/dagacLU
 XmkV0XJ29Ib68H9zgw9maW4N9gi2RQED+pJTnd/SjpzoC/o5Vdn10LFWbNb8I2KZRNOopf7nJmH
 Ylq8OtQXRz7ZCt7s9ZDCI6t0ElcqsWUbJVJRVxBPQMtcfHVy0mqdE6zUdsREj7BITYr1B2Pzi1t
 Gy5TSPEqJ7pnSGRP017KxbxMVbaexe63lHLosF2ONZ4fBQJrIkFIN16FWHFghvC8ngN8Uyio+F6
 U08qRv3D6M3VvJfSd5fC/0UiaXck/1LmgnJlwRJEJc42nWjhSleivpETarsvfKohF+gC/Y9NVya
 beP+R5F8451/kUJWEYgCFRcrXWUQLFKPSHgZmexvesVx+SKkki0LoI/v4INAtVb5+dFoqZyWZIS
 8CFn9fi+b41GhTsebb31TSnGaJKQeIdgflKw3G9KDnZZcVjUtrNHE/CXD6ZRxYS5+F42kIPg==
X-Received: by 2002:a05:690e:1389:b0:67d:bac1:cfef with SMTP id
 956f58d0204a3-67dd3cfd3b8mr1756759d50.9.1795019108111; Wed, 18 Nov 2026
 08:25:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <2113981400.38169.1794275897389@app.mailbox.org>
 <DMYG3PDX1XU2.1CEBB4VRVJHNC@pigmoral.tech>
 <cdd58082-06b2-4581-abbd-0e585b928291@gmx.de>
In-Reply-To: <cdd58082-06b2-4581-abbd-0e585b928291@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Nov 2026 18:24:32 +0200
X-Gm-Features: AclHuK-_Wdm5F0mzia-rWnram136dWGsrEyjD6Ve45tefpMYqXE97fe4bjUbf50
Message-ID: <CAC_iWjK=P+qbzcDxPfGco6zBSS1DgxOkSAsDY8LLCs6YndXYXQ@mail.gmail.com>
Subject: Re: [PATCH] boot: pxe: pass the initrd to EFI applications
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tim Surber <me@timsurber.de>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>,
 Alexey Charkov <alchark@flipper.net>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich and Tim

[...]

> >
>
> Hello Aswin, hello Junhui,
>
> Function label_boot() is called by this call sequence:
> extlinux_boot->pxe_process->handle_pxe_menu->label_boot
>
> But also by bls_boot() and extlinux_pxe_boot->pxe_process.
>
> The description of 841abbc6d561 ("boot: pxe: support booting PE/COFF EFI
> applications") sounded like it would only concern network booting via
> boot method PXE and not other boot methods like extlinux and bls and
> specifically not booting from block devices.
>
> The extlinux boot method before 841abbc6d561 booted via the Linux legacy
> entry point and not via EFI.
>
> If a change of the bls and extlinux boot methods is intended, this
> should be clearly communicated.

I agree we should fix the original patch and intention. However, Tim's
patch enhances functionality and seems irrelevant to the breakage, it
just happens to fix it, although we still priotarize EFI instead of
extlinux for example.

I'll have a closer look at the patch tomorrow, but I don't see
anything wrong with it.

Thanks
/Ilias
>
> Best regards
>
> Heinrich
