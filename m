Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E4606A31F
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SOpcmwyh;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=fyUMMjb8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADEDA60AB3;
	Wed, 21 Oct 2026 17:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uyXsYzAouEzF; Wed, 21 Oct 2026 17:11:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 157F160A5F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792602667;
	b=aP+XKro5AU8dDO1jvjnRFytUnavmTanxWylTb9x1H0YV0rpPHKC0ulhtMNV+toGJl5lM
	 neEOzZ/vH1dWLvTXIlT5oiNl/fbGskc6x3cse8B6YKJUp7spZrfR0D/RDAHqAq7Jult4D
	 xonhnfiB0jgb8pOWb7NbEku7Uw53p3MKl4lMxYo5M6rcnESohmn6YumMCOKs/nXR8U62H
	 GHda2iOIIFerHuTaVVmF8xVygM16SqpPrELfdvZSfAuVSY9jGYWb9RyWVYAbzLi55WAB1
	 fzt3MtgWlX42hIO9Q/i4PJC6mmVsDgzP7zxc5jNlCxF9FlQjaXKQW3PgCgiMUBNbMxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792602667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sFxnVO/s+oovM9cfDD8/ePYXFYK1UjfbTKcWikHtaSs=;
	b=oTZ1jOCPcOEJleeDO3cNrjzUhqHdHhS3ByYgtOD/MWagvIYE4sH8sgIP0JLfJmZDt+ic
	 4/rDbW6M/chXGglGYhpk6izHXlZ71mn85tfUmcrTyDF7x27Wrm3Vu0N9Nsn62YeKmSWB7
	 Mp3rqvGu/vYjYXsKbRl59V/Ho71bjxJrlu9IQgq8sIJI3A+8b8luwi8BiPtNt24H5UMZV
	 0fTgFsFFRbwc0okuD5tfXzdZu+kJiQTYm6Jsjj6085A2T4yA7Rbr1ti1y7BlIDTGsAjxc
	 W4xPfi6ETV7140mFtwZY6ChS5KRdD8Jty7kwL5sUUY9yjfqX5+9Awk3jTA37m7ussHA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792602667;
	bh=sFxnVO/s+oovM9cfDD8/ePYXFYK1UjfbTKcWikHtaSs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SOpcmwyh9hQ2FlAbITC8J5b/vkH8UhDxK1/Vbp9JG2SGIu6dzqSy7PR7YMdaSjdyn
	 9zOGb3XT+IEx8EHbJIfuujI1ojFBnQSKqja/7M0M+O/oBRPOOpxQr9D2BfXGyepdVj
	 kz90zTrnPgJenIKFsAVjUMdZBAg17IwBNs5G/XeYgeqCZUg7OH3N/I11O0LMPuGRvi
	 xBadnvEVR8DNz2vrmjqJ9q3IdmK//sdkVOY3PWRm6JTYPQmMM79Xo49rlDgbukmN/A
	 HFu/pZ5VjPWO3Wm3nH9nQr099eZZITbQURT1BeXiDQmGG/XsuqFZSP+k3xdlo9uoGe
	 NdcPILt7/kJHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 157F160A5F;
	Wed, 21 Oct 2026 17:11:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 66C64769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5887B80DD8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JWgvdQdBIqNT for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:11:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D0E780DDB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792602663;
 b=fKCdP7hQq5O8tbliXHSuY9fQY8qJtrLSHc5SHK5BVfSxyst41E/Zmf2jIJaKOwpKl2kI
 xfiJXX5KQ5lB6uOWUS2kdJTyfy5MFWx1jKWnX4TzXuHCW7kjW6iff3K6Z98jwY0RmKlE8
 2ZoOFN/LU04iKHXVFMmZVAVM2nWcFZDlT2fECZIVXqn3pS2EYiuTIo34ftYN6QNQQEj25
 NhjSRwGukqkfm19D7amMC8ePGQn2qXHDDbQsjJsbvjZEnhshAjTsEfDvWVjrJat9Elyci
 gpUfzzKe4cs3UCY2wVgFZVbTL4RYzM9XP3YUuNGMMCeCyb/uY/bgOTkX4PE+PiJ8/Ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792602663;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=sFxnVO/s+oovM9cfDD8/ePYXFYK1UjfbTKcWikHtaSs=;
 b=IqEwt0swPBfaHIPYSp0LOmO3E1VgeunsyMF0lt7lReUOgfxKINFdxVgSzBm8waICMeYk
 NxvjPH+UARL2RrOZl44veVBymuEUgampsK51X6lM083eXbFjN0l0Eoveb/SOkYY4pWjI8
 lHNc4gcV/zMhsqaghFSi/UsLCKp1pvyfX94vm+ThjxnNK7FKpuXLZ/ia6ogVZXn5ljfbS
 k4bJNxhgkBcsuWJZXUGNWxChtenvVb6DY4/iw1V0dwvM9ig9HfpC1iRz3KgvfdMW3lSvY
 Xs+RIwNTWpXbMvdQFSdJxvz5ktq4Qhf3Bq6mqFrKxd8VSnxRctA+vt7aegvPhZUOrkw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fyUMMjb8; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=fyUMMjb8
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D0E780DDB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:11:03 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6df5e315bd1so536200eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792602662; x=1793207462;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sFxnVO/s+oovM9cfDD8/ePYXFYK1UjfbTKcWikHtaSs=;
 b=fyUMMjb8K3T0KQWdQe41BmJPICh5C7ytNuNPO++yHmdec5KvVJUEPZvJfD2akRqWa7
 Ab9FaADqYTcxZRawnuJF7fkd6TUEmD2xRpmOMFbQvMQAcqhXlu5Hpkdh38a8iSVuagkK
 yRNjlCeyfKDZgRrmbkVhID1jDYJw8Orl+wi1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792602662; x=1793207462;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sFxnVO/s+oovM9cfDD8/ePYXFYK1UjfbTKcWikHtaSs=;
 b=11xP+bOZQ3nl18W+fuLKHAC2Ib3bs7RDGVcDiTwnbIVQv4foNN9/RLey4sFzLFuEOD
 QfawcFg6TGYC+SoRkZEbyqCh7wQD9SZYp2xg6/92l8r9wYpsQ/rs1vjWC0NSukrjG+li
 D9lOW0LXtY4+HQ4kvYzdmLPDQi3T/3g9euKJoyWIdi4va6dJ+ayB0qlpf6/dhfojYB/p
 UxsS9tErfMQ5FWuyvZdw7mxJZ+lVmJ9j8+xF4IDan4Fz7qwiFnnIKQL90pd/5F8vrDYf
 Buawegc4xvWgXVhN/jQOwgQroFZ0yNSprGe0lb5YG6znzz3bWMmpcTkLtSszVhHUDHgz
 DMPw==
X-Gm-Message-State: AFq9FYLCUMon4Z+aFPaLvARXwAr/X9H+7HipwJR2Knap2hzdN8lLf65G
 HLxooCxoK2iDCQeSS2riy3GFcILDa3JC1KiAFuTjoCwJ2kDiYmatDCR0/0OTj2kPaAY=
X-Gm-Gg: AYBFou1FMBPEclQV3nRtxUC+YYkCrT4Enr5cH6muu7bextba6gxIZRZjl/OWNrSM0ya
 rKWCDurhThvlE92CgJFd6+W49pALXHM+zLNtcsZ4PKDURgaboVIgnIYdwrcUNKP4zqo3Kw9+xy0
 ygwR1D1YtjMeOB26Dk1vziN2alkLfBroIy3YL/C3KdVg2pJjcaguTTBeacv4uE9gN5YnQKYpPaG
 fO6wXgBd//8PRvHsIbrZOe3W1oE+BSNWwwshGNT2H7cGUqFMJ8DBa8cwafTKh/XwWz1Jt8ssjQb
 +WF5aqvMF45/8Ug1ALLpj0cqXGaKnGWuz6t3uV60aOjWeOn4FWzBgRbjwL7R8MPEO6WeB78qHNF
 sNW+THd530kNIXxgzCUWOZPP147PkkdwjYW+6HYPbm1puGo46w4/AXIBhRMVcgXCei8tEIlyT92
 KGPAZ21AithxTF/dVkcQi0N004NuxVugCF+FVRYjGgcR3Z0SvEEoyHWrckqh+Mo2I1hBHjH8I3/
 VzMwq9nb7NI/ujT3x2WmfZTweEv56cI6F6UdylSn4Is7qNe4IBsWEp+3ixs00+vJP3kxiO32ebM
 hU+DcTXAEdaB7mfClHwh/ftHzRwgVDiZBiDAC/4JdJDC3Q5yBTXHDrflbo6he0DBvJqhM8ZTDj0
 CcDunuWYmmaEcEH/lpt2+
X-Received: by 2002:a05:6820:814:b0:6cd:3fdb:fa68 with SMTP id
 006d021491bc7-7094194aaf1mr1655059eaf.83.1792602662279; 
 Wed, 21 Oct 2026 10:11:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbc7d9b1asm2683971a34.8.2026.10.21.10.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:11:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
In-Reply-To: <20261013074336.85242-1-pepe.schlehofer@gmail.com>
References: <20261013074336.85242-1-pepe.schlehofer@gmail.com>
Subject: Re: [PATCH v2] Makefile: Pass -static to the LTO link
Message-Id: <179260266152.3262409.1521621704021661985.b4-ty@konsulko.com>
Date: Wed, 21 Oct 2026 11:11:01 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 09:43:36 +0200, Josef Schlehofer wrote:

> The LTO link runs through the compiler driver. On a toolchain configured
> with --enable-default-pie, such as Debian's GCC, the driver adds -pie,
> and links that are not PIE without LTO, such as the SPLs, then get
> dynamic sections. With Debian's GCC 14.2, imx6dl_mamoj and
> phycore-rk3288 then exceed their SPL size limits, and turris_omnia its
> u-boot-with-spl.kwb limit.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] Makefile: Pass -static to the LTO link
      commit: 343472c493b0d2b6177d469dce12ca451c0da352
-- 
Tom


