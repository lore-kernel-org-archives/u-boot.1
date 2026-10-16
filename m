Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54439CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 14:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14183811B2;
	Fri, 16 Oct 2026 14:34:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IthhwLbEjgQg; Fri, 16 Oct 2026 14:34:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F64581214
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161273;
	b=hRLxYeGKceVhCc00Ctygsf1SIBLjzugYsJ3fWjb02ECb0kbgYFLTC3gW1Rb4tkSBDSHY
	 7CFkCnqmJHk4u0qPrWkDnxv3yORHMsi+33ZfFJ0qLg1CCXo5PeFEmpw0SzqmTThA5uWf6
	 2dNB+FbVFnaxCx3pRk+6xuRhVfmVLNsdRBDMzXLnIhV6Cp9aY9zxwEoTKsfF4IypwNzAD
	 rtb7StSPL2MSmWguOcWaGEpN5GZf3IW9YcqzTyL8ssy2XD+l0gMv1GLz8LETUt0PTs/9V
	 uHBrir1x+bUa8e9J/FXO8ZV4FNuwOTU+9+jw8lJC5HPQ+MztRorvFg5f9txAkDiPyIw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792161273;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Wk/pILSoFEeYL5w+RJ6JtQ8w9hsS1hxoBQMOQWO1R1Y=;
	b=klD5gbtLoos8RNRHnkh9KIOqOjnXSMmkMClioe5PC4pqf2L3ZAzL4CdY1UOgaWF+d2Zu
	 +nKchScEwWRgAsUEq2SkLUxcS/aWrWvLO6QTkIyim5xUNeCDNos2BikGF9YILXfw6UGQn
	 h/rPiN+1vMmm+CGAqBS3WVb0SdT4YtctmH6DwiWZ+svTdPSPqgNDUBLGESO7mNRzGnuE9
	 Fa3qVZWIUxrR2QKv4mmYFBkZmXogqEann9c1Yu8/c5c+hV8QYVefA7k7Wb2MwgBXAtUr/
	 4dLfXlW9czl3OHM+CSLWoDzDE+mU3r5vLh92+5Bvnjsyi7Dkpp/xKUvoKLPrY0Jy3EA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792161273;
	bh=Wk/pILSoFEeYL5w+RJ6JtQ8w9hsS1hxoBQMOQWO1R1Y=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jw6S6s5GdOerhIKUjAnESEwPHMHSRHB41dcop0AznKG9Er+uvO19Pj4vfifhWB0bj
	 m2+lANvmOVrz4uDYfY1RDZAnw7CMV++VD53b9wHekzMKHtSlAwhFxg3Hqf03wAoZqo
	 dFcJjCim0LENSbOr86yBwxMHXwqRZB90pko0sSbrYVEhqpe8GpigF7RRrt3VoROZbO
	 AwqK9lDimO+P0MW+C1fabyvTwYt3777tHEitjv/nC3A1nvDWuSq3Jjt4XG5dC3up33
	 +idTM7otfUnlt2TmEaCnZ/dii/jFxdd3Dep/2sQTqei82UwfHkyzD3GSUIiXX/uHXC
	 fnJjr4OqSdfnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F64581214;
	Fri, 16 Oct 2026 14:34:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC993255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEB8D40A08
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0JjRm1N4nkU1 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 14:34:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2EE4D40790
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161271;
 b=fKxIB5HDLTk0flUd/TY3K6Lxs9yrq5Z+f4wVPascKXss0A+pu7jQT2rhRJaAOIkoK9HY
 XHTm9/6I+h6PtodOljGy+xfhXTs9r9PPhPf1WOWe35fWWknrhi88kytAhxqdQbO7NK2Nj
 fW19YB9dKQuUns4TLyUrUULaYzGs8xIywopN0I/xhJO7FmvI3fSf+M4mahlCM0QzDqvnl
 D9cNYFVtSoW1Tel89HKsJi/tNNqEpo+rH7Hj2XFmDR4uFHHpsTvuuUyN9ENtOjnJrlnvC
 bxmjz56ZHUZSGKXST4YLtNt7HREFJ2gaTZ40OpyXgVYXpPaxdB2ThTUi7SxwXH5i9uQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792161271;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=Wk/pILSoFEeYL5w+RJ6JtQ8w9hsS1hxoBQMOQWO1R1Y=;
 b=jzYrD+Ckd11YxAsb58U3ocprejtWVxTv1LaWI2raKEro958HLc9FlqgPh7W752G3pxlE
 uTS0+BffrwJ9pm6U7Ka1aH1McpiDzNpsMSIhiL8LnSsZOcrlYxkeXQPs/NNb3Ate/JU3t
 ARDX4T73YNt1xoiGjarsK5o5Q3lGNUUkt/LYo+An6yYWUrm9ZAIt2KyeAe5nAHVwrL6jd
 2+23bUN/IzCrX39penbFNnQAva40T2XVdG9k5wG65NFyRdTv+Wm4agoL9ZPDmBBzrat+1
 IsfH2RI3llXAB+5awV0eFGROO/V8kIZykiesB1S/PDA0w2JRRTyq6E5Dsmf1xXGEbSg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Lv9zvrDR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Lv9zvrDR
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EE4D40790
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:30 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so43787a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:34:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161270; cv=none;
 d=google.com; s=arc-20260327;
 b=V7gMBoQulQ/0GKMS95jlgEzpRFmro6+qapRnFvAvWMGC/N2rwBz/sgEGp3gZTXSv07
 2tqsFxq/e1pvuJajWIftd0GVOC4pExStFS0bXUHWMB0E1HVEQmJ9nNnXKWP97i+9tfSX
 dXU/1XWz9IzWNUUoZlBCjggEE/44f1GqM4+rsi3Zmk+oGvBmtBoGIXJKsjlhWdxzyTke
 k8jLTs5rzHcW08otUyZCa6UYK2BJGX4ZwWWwy2A3vZd0YRtfwfN7eZySciu49a/BlRzJ
 1MHFuxScKSFKQWLxFGOnyvb07zkumOnri286IcoVTin7dCd3W8B4BKFq0ZF6gAKDpH2R
 WZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Wk/pILSoFEeYL5w+RJ6JtQ8w9hsS1hxoBQMOQWO1R1Y=;
 fh=2cFhNF/fat/AbGBMqCUbxRvGS7A6XUUxep478/GCvcM=;
 b=AYj3mN7I+T51t96uYVSjC+v3sRvRsvcE9y6IdUBvfYx19KNw+HSnwpzzEdA/GusPYh
 D/+0DI4Ug1R+TqQg/Fa3DVEaRvGI/d5cW9TXfYm5LXJ8k8q+Y26yZUqiUhpWRUrbymHG
 Ed1hKHZPZiG/DpAoqiUpc9ubtDVsCoP2NWqD4Ux4A3ndjX92RcxJ8dhJ8tYa5nMuI2pL
 kV5t7w2bIoPrh1RZ6S7zUOvYrLdzMXcV7KEI1mBsPNpi0LsB3MhCJBVHjXdwxURdSBJB
 JJyYBXs+Ie474qHpefc90+qwe7i/Rz40V79XSM003atdyjlK1CdsQNWz4vPwwuzd5BvU
 Qx6Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792161270; x=1792766070;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wk/pILSoFEeYL5w+RJ6JtQ8w9hsS1hxoBQMOQWO1R1Y=;
 b=Lv9zvrDRIN8KIFRbkIEMTNAy+hp4z7KMMbpQWdqspzCxImT1sFaE7Vb9QFbS1tuC6s
 qc0FYn0D2IjDY9g0BtI9vZp6ZSXdzmo9PcvhvYqMB6QEBUOADFAOZMWQSCZUgicyelm1
 M0AmJ5uTytDQocj+QMYBFq4uVPAsM9opNtXEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161270; x=1792766070;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wk/pILSoFEeYL5w+RJ6JtQ8w9hsS1hxoBQMOQWO1R1Y=;
 b=YkJbjR+LgjZbaO2bROG2d8HTyCGtCFba2r8oRP6a7YpgwVQDGqoQNxMPMeyD6H0sTn
 njxT7j+gDMLAefo43vFa9KTtEVm9RmuaEuh6EcHVnFTctqRDZ29o7B1dKIdAU9KaJ/0h
 CbSUsnsPTjRQTeSTpdYoAdzQjbUmf7GPTTU9+NYWyj89QW4ejGhi3LAmIp+XnqEPC8Wq
 a/zG/WyLMeMiPWQpr8S6IM9HMOOv8n7JL/Gw0Coy9bYa5fqFVmCSpzY0uJ6maLAjFJrO
 XPqz2UjxGfD3B9Jln04ptfudFXDVTfpcITGWXCWHz4shJGkNdVcT6L4B9L8UokZnQs4n
 PE+Q==
X-Gm-Message-State: AFq9FYKNUU1G1djAm7oRTJ9v3+Dj2nHXz3KT6ShTTfILgWHFOl+tlf6h
 6CNBQxWqTtb6jLmGFgU7e+JXHv0Tv/B7YJz6/HT653NVcepdef3uodFKWfrn4tRM9a1Cx98ACdf
 +y1eHVdc8Ae1Ke+J7/IFXa0mhlrCw4wNFIv++uhSx
X-Gm-Gg: AYBFou3+303vz2nQHWQLY7E/Mp4Lg6t+oIzk3Pd/W5ku19KmB77LJvSqM9UDDaRTqJs
 3hDi4cpzHg2SICvZCd+2Us9/Jqt7g3W3g/8r+Odp4Yiphopg3tdP1dS5WxvU+RavefHF0Zgo1zF
 6mn/lQuUx6meM+r/RycwBmpuxbcOdISLvEHgMBYWPanaztVopWVgXGCBzQqX/3iQ3h3piFN7oB0
 oM3p+GXcSNxmC5T/XyGXQAIAqHLPi0OuZsY5hndZXBpEBkWCclYsMRkdpf7ILXxa64hL7Ss0QMm
 I4tU5PkWeRCG3aSg8xO/tTz7xQSjZUVsqCUtMvFHonWu2J4OgYTfUug=
X-Received: by 2002:a17:90b:4c43:b0:3a0:516d:9f88 with SMTP id
 98e67ed59e1d1-3aceec26d75mr29218a91.26.1792161270058; Fri, 16 Oct 2026
 07:34:30 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 07:34:27 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:59:26 -0700
MIME-Version: 1.0
In-Reply-To: <20261015111328.1269775-5-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-5-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Oct 2026 07:34:27 -0700
X-Gm-Features: AclHuK-Y38rnLqnDxUXzfDISwPiQt8r89ZcBOoxJDgrkZoBJIRz3zGSttBT9nTE
Message-ID: <CAFLszTi=3eAX5QLuOxBmrWm8n9x4FrTXEBm1vMNxTmAyrmmjnQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] virtio: Release virtqueues after device reset
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On 2026-10-15T11:13:15, Bin Meng <bin.meng@processmission.com> wrote:
> virtio: Release virtqueues after device reset
>
> NET, BLK and RNG remove their devices through virtio_reset(). Only the
> modern PCI transport currently frees its virtqueues during reset, so
> MMIO and legacy PCI retain queue allocations across remove and reprobe.
>
> Wait for reset completion and release queues in the common helper.
> Keep transport reset callbacks limited to resetting hardware only.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> drivers/virtio/virtio-uclass.c     | 18 +++++++++++++++++-
>  drivers/virtio/virtio_pci_modern.c | 12 +-----------
>  include/virtio.h                   |  7 ++++++-
>  3 files changed, 24 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
