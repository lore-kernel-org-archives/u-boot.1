Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130A0C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C370960846;
	Thu,  6 Aug 2026 21:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7V63IOg4m6fT; Thu,  6 Aug 2026 21:12:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D11A6083B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050767;
	bh=ueHQbkKOwVGL/HOqKsT0FgYshLD6InXga31Pmeq73qs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kG5t7VXiG6BHmASYPSAgrY9sj0MtBNUr/+0zUYdp+QXd+nFEJKFfn+MvHTGakz08s
	 OiLXi2pVkz0aMEmTTXNGFT5lCWOzVMy6r8onIS0hwPGsJW1McuFuGISTV7NQJpouO1
	 ziH0WEse9xLQk0gNgYQCQbLm7iE+r9UH4QGnL4e1bWu/+DTdeUJyrHRJ9Yc/kcU+0r
	 6VyjtekJS6N9AWznmhKCx1MqpfJelNyZTAEqO0mem21FszXIA09BHxS+hDEXh1fC2B
	 ZrRFHjo7W+rmfzhfEuTuSYPxV3iGAjPHmohqHOBU5gqdiSBuB7tH7L0OE22hu4bNJN
	 gvWNLKQOsZoXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D11A6083B;
	Thu,  6 Aug 2026 21:12:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 912F0522
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77966402C6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iETGuhgvvYOa for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:12:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 758884022F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 758884022F
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 758884022F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:12:44 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so4393583a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050762; cv=none;
 d=google.com; s=arc-20260327;
 b=SkqNAtLUDntDDZ4Ht3mRBdB6Klk+4IjF+RSZg4+xMkrCUc3UFvSLkMen4efsf2Isms
 4VCk3eIk2W3N8j9st+JhMizqq702iLAXkwKdiU8puOKf2ZAsYv8wUY6CuEC96DFGW1At
 XhHVr6RYd3p3T57AnI9GF7iaH/82oHehDMreT66SLeaD9/ngwYyqdSz3zc3V5dt+eNxv
 c95jnHEuulaHzDzQpnimHwRogtDuixfIPRCE+5rJfsv8F/RqS/7VNwuPHIKhZJS+FjA/
 yJYAMSin0kn3gi/B1fuoXq1OLWR8nRlhBlu7xDYUC1P6GpUDxRumCdCfb/VAlBvUSo6k
 5lpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ueHQbkKOwVGL/HOqKsT0FgYshLD6InXga31Pmeq73qs=;
 fh=Ye9d8c9UuIgjdEYE5AmpFdHtipkFyQbZju95WIBagdg=;
 b=Yy6DUS+oPKNp/Mezncn4z0MrnR63IxH+AK3kFDmkUshPfXonRzqs78966BjoxWqd1n
 YtO0MxN/4X3YmymVXa/XlELLb2N75HMAoS2zg6lM9gRjRQi0YIBReLgsL6w1o4kDvQYG
 Gdi3uRzOPMEvU3rkzNc4Sg6Z8q9vHVw9LSLCnFDNJXu1wP6gDOW5JAVPeug49aecRNTp
 tupuTm0kzwkhdqYzaaHB6rI18mDdsLPnQbyhlT/JLbugDXhbEeViw4GIO2f0VoDgmPWr
 y7SfmvaAL/9+772BXiScGBMzh5inwp/5Dhx1e7nDK9A3dy7WfpUuFs/H6jmGkP0MJOyk
 WPSQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050762; x=1786655562;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ueHQbkKOwVGL/HOqKsT0FgYshLD6InXga31Pmeq73qs=;
 b=nm+funFR43RE1ryfdIwLRGzO4PsX9iFyz1QwHzLaQtK0XMZ3PHSCfMLU4O0FIXvsRO
 i9KUdV2grxa90SYS/zk6kBeNGg6DhkK5KxIZJjxlTmhLeyakFpuJDlaWkWEpQyPir1dI
 7r3C6zJfAH1UCcs8fgGAWxFXKmg+w/7qjhUbLqGgYEG/Zoamuc7vLAfvwBPy2aObBtb8
 iG77gfj++yMANzsoaLRyznIs2xJ5aUxdFpui5He/VPCK5bCxdt5UtX8GtB5gd4o4Z9IU
 HSJGz1TpnDiJJV+dK89xuKx8tizKiGwT7xrpM/ibvwIzF4QaWFWda0QgrLgZd2tC/+fO
 ggVA==
X-Gm-Message-State: AOJu0YxgmxP2TQdLk2QUPud0u3AnT/WY7v/TkgZ/hMrROgFu41OIz2Qu
 4R3cwxAK2AG/ywu4XShQvgE7PIiK+fQmZziOkszEAibPHZNDUayI/pfRHz7QnmnV8uYcWPs5P/n
 wrQPb2XRaYNagAxRxUkQP8qk03bpA4K1u2hOczo4zIOddVhh88K4=
X-Gm-Gg: AR+sD11Yc0olAB8f6PzMR/6Lj5nLzNCXGt/86iJ2dOstjV4lUuSiUUBcsOBwFGclYxv
 xtupsaHZIVwMdMwbMsL3HuAp4boAJdNDRUhoykvZECE67Jt0StoelDgOar7hfQXcahW2GdqySqF
 c6SOw+a6LSBr4F3xu4u8yhkVpmYVtOnYvVCVVphAoADd598LOWtcxyEPOl8DFgPKx0Uf562BAAV
 /1ZPU1uQfRAMOj1HGGdyQJOABl4A5v2XMRgdhM+0UJ7UnX2+QxvMlnOhi+rmAOZ1+h7XTtXXxbX
 PC9Voxaib3WPsGKPjLETEIYW30MZ5BsBL0Ss9HtINPg=
X-Received: by 2002:a05:6402:241b:b0:6a1:c908:1701 with SMTP id
 4fb4d7f45d1cf-6a1c90819c8mr1221709a12.13.1786050762338; Thu, 06 Aug 2026
 14:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-9-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-9-01746157643d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:12:29 -0600
X-Gm-Features: AUfX_mw92eNdLo3teqN84792U0TR9-QI_oGD9UjYsr0iRh3ESZxmE-vVFtxR0yk
Message-ID: <CAFLszThV9-uA_z_Lbpduov9tmxVD6m1dZbQQqiRfHo-aSayYGA@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] doc: ti: k3: fix pygments warning parsing
 device-tree
To: bb@ti.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050762; x=1786655562;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ueHQbkKOwVGL/HOqKsT0FgYshLD6InXga31Pmeq73qs=;
 b=BZe+H5XVm93ufJiCes54n0SjBkA1jyU+GBu0B/S7VxYdsfOUozozzukGDR8qRJNxGC
 vMV5o1Pv3sOsP9TsrpHoyBkASwKCi60mmIoQmeT2rZUkCVLp8smFGgnRvezpwdGouB+K
 4Li8QI0QHa+6Vvtm0J2vp8vqsmPcdhneTMwAw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BZe+H5XV
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Bryan,

On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> doc: ti: k3: fix pygments warning parsing device-tree
>
> A warning is emitted when generating the FIT image examples because of
> white-space and invalid node names. Fix them

Please mention what the fix actually is (converting the placeholder
brackets into valid DTS node syntax).

>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> doc/board/ti/k3.rst | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)

> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> @@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
> +       configurations {
> +           default = <conf-1>
> +           conf-1 {

This line is still not valid DTS - it is missing the trailing
semicolon, and for FIT the 'default' property is a string, so it
should be:

    default = 'conf-1';

> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> @@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
> +           conf-2 {
> +                image = "image-2";
> +                fdt = "fdt-1";
> +           };

The two properties inside conf-2 are indented one extra space compared
with those in conf-1 above. Please make them consistent.

> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> @@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
> -    /dts-v1/;
> -
> -    / {

Any reason to drop the /dts-v1/; header? The block is tagged '..
code-block:: dts' so keeping it makes the snippet a complete, valid
DTS fragment. While you are here, the surrounding examples use 4-space
indentation; changing this one to 3 spaces is a bit jarring.

Regards,
Simon
