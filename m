Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F002CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7701605D1;
	Mon, 12 Oct 2026 14:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ubhJ0vysHu7n; Mon, 12 Oct 2026 14:03:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 16E9A60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813822;
	b=JDIKIsNgOnjeWO5Xu5Ko7upmhS3m/gdukx889slXwxDeUAmg01oBMN8z2bmv7Luc631b
	 aq5fn7upwT/y6Ff2Vh33uqfF946EUALD74jlERbGWP4WX9QTSiyvB/E+PgYT1wkMPdldk
	 XM4Sr1uXRt8zp/vUd7Fx8AOEXybFdHzdgP8CbPt81HGyx1gVF6piQeRgabfSYubXT7dWz
	 o41qaOROY99xY/iytd9AQ1gQBfP5dl/i4ZOiZq7E1s42BP6H6+6hFLKTTN9xl2FqsMIyg
	 Yrd1i8XO1C0WpdDi4O6wsuUPZtIQJTu0ybbbcC7LXK2l+rYjC6HMmJ1PE2yu+focOhw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/BHXIsa2OV5Sgj0LZ9XYJ3WRQrs0MZ43dH1bHWR8BN0=;
	b=Cn6FZLr3brSd3FXQWa0+vg/34C/7I0ceBzHKga2odnlSKQaCDMH3dVsiUc9PwuvaKgzN
	 qAu4G8/xD31kwMyaXxI4MvIR+ODEJtiFAPzvNKiHxRaXgQX/0ELPjcSYXErCljZQZVDys
	 pbVsot9MbLwnLES6XfBeDVD8awqvLB06mjZmiIGHTagsCj4qBgsZ94DLtp4BXQ5DGJrfM
	 V3jIXK/ipfe+TqaLiiYyEGHD0JRP4oEM+9NOaxgtJtv13Xjx6mB3OMPbi6E+QU5mG9rZQ
	 ZvIDm7l0hBQuEpju0IOsC8u/KSGcZAdznToFkOCw4mR60mIiVFc5e41fdNmCJTkE8iw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813822;
	bh=/BHXIsa2OV5Sgj0LZ9XYJ3WRQrs0MZ43dH1bHWR8BN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=te94B8ivZBCMeD7eZr2rCr93mngKM1aS8OyorTnuSsIaKCErX1LMEMaDHkqyQCPLu
	 rmiQqngGG7Z6wBRFRLXfbfespjqQFh0oIOTqd5BvSWkY0/u06fjlqncdHXuheBZ8zU
	 fvF9zUvH0mx4GwuZtpH/qRF3esowsYVmbNBr0wcBBdvjJjqMiHU+xStI/oOAUqQyiB
	 abdDns2n+oBePzaH8iZmJhy2GnveEgZjSCQUqiBwL3kdEMPNpeS6GiC52PIlFnjhMl
	 GcCyo0/7jmFXCBJt3XIV68PYQ51VpP4CGoRkfiRYtxmPcz8b9mhRu9JoAZu7Zr1+BC
	 f5KGvbNBzPhrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16E9A60600;
	Mon, 12 Oct 2026 14:03:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F38BB2E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9AD74064E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S_kZZIDaVDIu for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0AA124063A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813820;
 b=e/lIdk3GubYMSGqtk6ZV0T7LXNToryfb//qX23nVFWesW6y4Qj2+ToclW3UaC54k7Joh
 FFTZ/xcYcRYW6KCJSr+L3FPnuWZXslztFveNpX7CVEwQX+FxF/QmrhrOH2wUUZOf2sKw1
 DviyXgnrT+NlwRmbfBBd3XBc3A2oexy5+RB3GPJ2KASkB2BGQIEHwXmK7ZJExqgB6Q+my
 1nBJPq/G+yztKb8ei/Obu+zrpOGXssMde92BZXIIMSn75oRmAXZWnpACQz8SmpUBzqmc0
 871Jcra10NEGXJClgxfz4u3Dnjv/wrzJqgAHNGYKeMxdWo/WoHiWd8ql//16oZ0cQyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813820;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=/BHXIsa2OV5Sgj0LZ9XYJ3WRQrs0MZ43dH1bHWR8BN0=;
 b=DA0tp6wdrtK2BYOcDd1yK+VfV2MiCDH2BHA+fXvalZ2T137q86q1l6Xy3lQjUv1HCsOM
 uaZUZa0EMVz/0KUI5sWDeOS2zVV7Nw7z9gDz2SqFzR+SBCXBVnrMhLqhf1nrt74Bnk1zj
 clJift2iCNJfekqGxEw9+nzhLxBZ2J3Br/2nDkLEy7aVaxQNqSG7MXscPBYaHm0bPJqur
 +5/0HZIj+L5WmtvA57oLhyg/b0WYF41KOKUbC/exvFKfa6xm3QrJQWq2X5A5d24b53kl4
 ZjTzSQZVrcVwn59O+j53i4WfZRXHax165SXR9wf7JQexbhFAsTYhOh1phTPzs/OCv3A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="Ogd/RokN"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Ogd/RokN
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0AA124063A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:03:37 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso2267530a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813815; cv=none;
 d=google.com; s=arc-20260327;
 b=XjgeukpSJSMHWK3+VuKTrRg+BIbVkUtynF0qpjmyTQ1kunyn4s/rAnjw/ixuSR140B
 wcmjVSlbhKgl6UmVZ4tN5WU7elLm6e3Vzl7n/FmDic8d4pk5oiBCNPHgimUkWu5TtiTx
 ktCR19Gue76Liy/Vh0EJuZ7K9aQQBX2e+uw3/i7wOK4MFDHZOmfRrkANfwnLStOi1AuU
 2cEeyJ/4ihUf6zCcTuk2uFjDLZnBXlCCJ7DDDohb/VqpZvt30S78gdlgbs7d6FQg//ry
 bXZNIsNEH9xejeNd1RE7SqrobA5hdXXSfoiRYZhs7gN1ZDZJSQDDjlA3j2z/DMDCZs7o
 wIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/BHXIsa2OV5Sgj0LZ9XYJ3WRQrs0MZ43dH1bHWR8BN0=;
 fh=NieCVW6M1MUYnz9eRpPjF8pQsTNUCjYet2bF/SkPmyw=;
 b=qp8jRK3ikkQovvS6j9K5Rp4fSmzYIUdJJbQe16/fhDMY6VAtD161Bzm6tUJZl7Sl0q
 NeeZXPyVp09pgO5QSfIE/jjpKzebpJclUxYC6azzMTnCpIQE6MrGnD1+irreaoei2EUj
 vE9U2ZwmLGFiWM7V/pqBQ/BBEi6G0iVOmh6CE7mPk1+iX4XwioI0+0onKUbujBFazXPd
 xMLopRNdWAULhChMsyI55/gJJGIVXzi7wjSRySWAj2UKtVnFbGX956Jq9mTv04Ex0gPe
 6+K8i6//pxEkHQtC5vjRNvpDlyyX4cOQjiJdVUGBSmkbSQmME/ty3sARoTOpQJF9Pw9s
 gDrQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813815; x=1792418615;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/BHXIsa2OV5Sgj0LZ9XYJ3WRQrs0MZ43dH1bHWR8BN0=;
 b=Ogd/RokNshJe0smdoWwRzx3naf+t06lmsW+afEMSoHrfSnzhJ7g6OBHNhl+h2Yf2KL
 5IH7mhQV5HLa7Q25oCfiDDZW3vA1/o0q9iYYuCPIluJmou8TyF8zA6R4YAyGkG1ZDeIK
 kuYyuqg8unm4zPvjczp/URLRvzzSSmBMTv158=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813815; x=1792418615;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/BHXIsa2OV5Sgj0LZ9XYJ3WRQrs0MZ43dH1bHWR8BN0=;
 b=csA3FCQho0d8Tj9yxTYkmpHhODMDctJ1tsVvO2wnYmDKcTRday9fWPLsImbg1XCO1b
 30AIh3NysBDWGmNAOsizCG+DGhxo3hWcjq/+ASI6Dr0FVI/SmS4sJ5j9PbW/niHqoOXc
 0XKu9w+igttpgTHUpmt/UGywO+H48pVWBpdSI3AmQLwREKMN4QrKEkc3TbNmOSsDSGW6
 CuirmdnBvF2wooXsdyK5nTkEDWK3vuepoi51u2mwZweO3yN+vZ4FUvfK/QE9cf0/CLM6
 c5XmhmW6yovaMDSvIcbwlA7Nmgw/iKbC08UBAg8J+a1MKo6IDl/Huxz62ylhNIToNaTY
 vMAQ==
X-Gm-Message-State: AFq9FYKLZSvRslonzHIkXFmIbwOnL71BsCC+nFMrbU1NnW1ordRuk+LA
 jrEEFn81BG1jfNpRGYe+etfNon0CgherqKaolYnVmAbg2O+x9I1pWfNIphPwoBOkcufPVNmgG30
 2p7c4vctDqweU6vlkoQ28zp0QYt3SUCO4Dg29WH/s1EUgiW2OZSJircIn
X-Gm-Gg: AYBFou3JxTchdDUwKdNInGzM4P9K0l5BazgjVdcA/7jGlF4slHfQ06MOxMECEnCN+Wa
 Qg3c4xfz34D8NwziOo/IneUnfqV8CNoW/3aiI5O0HvLkHCoaXxqT+kP9wjWPySVO8p/2pIXLtnN
 1qUTIzDH70BIsnK9heribJrxvRXB5FfHoQTf3YhJ+1HuOTvjrs5ZQTubIwEMa9BoUNpfEAj5iro
 BERr5gKKLYANLJk2ObIa901U8OqHLO56SZYwx92s+d0mkv3Nwsx5ki0VyOkeN5gNlddWZaSbeU1
 DseGD4qjzN+3iRnMNYe0WrN7t/tHklScp4PNdx4ZELneyq7WXHhDizA=
X-Received: by 2002:a05:6402:3228:b0:6b1:c5c3:9624 with SMTP id
 4fb4d7f45d1cf-6b1c5c397cdmr2042952a12.22.1791813815382; Mon, 12 Oct 2026
 07:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20261011070600.2788775-1-bin.meng@processmission.com>
 <20261011070600.2788775-2-bin.meng@processmission.com>
In-Reply-To: <20261011070600.2788775-2-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:02:41 +0100
X-Gm-Features: AclHuK_siNkuvhTQTit-tlr3EU7BnZ4UwnsMxXTCFIBMzE9yf4FYaFRO9Hw3Evk
Message-ID: <CAFLszThH326=6CEt-1mmJjm+w9HR+TnMTKoVRwqouPD54Gcm-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: cpu: Implement cpuid() through cpuid_ext()
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-11T07:05:58, Bin Meng <bin.meng@processmission.com> wrote:
> x86: cpu: Implement cpuid() through cpuid_ext()
>
> cpuid() duplicates the old EBX save and restore sequence and leaves
> the ECX input unspecified. This is unsafe in long mode and makes
> queries of indexed CPUID leaves depend on the incoming ECX value.
>
> Call cpuid_ext() with subleaf zero to reuse native_cpuid() and provide
> a deterministic default for indexed leaves. Keep the existing interface
> so callers do not need to manage individual register outputs.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> arch/x86/include/asm/cpu.h | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
