Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC14CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 11:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB30240D48;
	Fri,  2 Oct 2026 11:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1cW6p7i-dvYG; Fri,  2 Oct 2026 11:26:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 60BED40D19
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790940362;
	b=Pbn60Be8RYatXpQiyQq0l42uOWQvbP2MZ1sTk52kA6o8jPf+0FXLZmR4CWNKZEi4cP2A
	 DKKEBXjgp7eRhTKz4XbNSDERCLGYLiSBHdmNDtyqIkzmPAOdomLDU+B6q3NGKGAGT5bBK
	 iuPUEw14BZJD0MXgDxhaIznw9aBSBwjCv136xHvgWVcmrETsKQC6ZChfWZLYCeOXaBXve
	 /XV6is2GLGGc0R7vgBAWLz5yqaP4tGQqRhx4Pv8UPt05wtdOB51Y0ttSQa3rwjBzIM8Y5
	 CayyT5dHNzTZE9ZiwXLI1pmxK5kUUSubNmLWRaF3Doeb8+0Cdoik5ofSM4RLNhFP/ww==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790940362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/XZA3VEGe17k+QMa5VmS+A9BWT4/WhTzGoIclHm/IKY=;
	b=i0sjDoHA9t4Ewic9bxgzvNkvzjAVvr08qhDqYh1iPhY04ndYDQgWhML00Y2KCTi/Zyr3
	 xWO7MOJdX1tOgbk/3TY4x1jbcRvoPICvGDhG/Us+I3TPuShpQUOIXysCy18Ojnm0Jwtxg
	 H2jQXgkEWNPHpzl20uwuX5hllskGGQGTP4LAqyljCxGXIOjuXdJjYtfjBAPEvtMdtmo9D
	 k1e71k3bbL2V5/ACaBlctUiZE+Ozs3Ll0rX39rngHS6Sod/uM95/sj7/FvYiwHEeqLswq
	 ItWX2Kmm3954hFhSDIfuBzcnH/nTW6HHbgkaDZva8eNsoncV8vL7ypt7odoq4nwe0kQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790940362;
	bh=/XZA3VEGe17k+QMa5VmS+A9BWT4/WhTzGoIclHm/IKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d11TMkDjalZdcgU/Kd2OFjdWuw7bvSUlfUWZUjqL+ELeBOkEDmNA+9Y3h6ULZ2iSF
	 O2VQTlOFW0GqAHv6W5wHsbMOg34TwOtwqb/uLDKYtVCe4srgOZEyY92KmhGy2MBcac
	 /4qG9ddmNAouTo0jobF49tF9VeAzwWIWKr7qft5Q8ljeESnFxX1sGCUBZaIIOEdkPR
	 x4k/1I2CAUu05mKwVeVoCB1VcLJqa7HyJT4gUdwmsRLmZsuVGU2Xwk4XIe1y6K0Lur
	 smnozj5h6MQ/4zxBLfeMJlh+tobgRk0J+v7t3M16vSau7LhmwOMj55Q46AV+j4J53o
	 ZJijHTWXNFaRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60BED40D19;
	Fri,  2 Oct 2026 11:26:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5812534D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7F6C6071D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:26:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XfkFTmUty54G for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 11:26:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 76B88606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790940359;
 b=CqctoIWP3/7NIj/MfyiFThN5UXuijLVJvNhcABERGtxD28EfjR04cvcvqaHMf5RGNRUY
 cLfmrGaIOCnXwS5EA6XxPWpDOj3ME4u/xMo+KDEVL688V4Zg2BClctZwEzQETu9K+jzUw
 uIffhoe6i61feF/TCA2plp3PcvkgWUr0hgqPwLIW2TxK7vtQcUozfLhyyCw6ZiONGMTIZ
 b9B09MtCNGh+vtoCMzVdjohXZe4VBKOhz7BpRJJ99Or4WnF9kdzmB2EyG7nMqI0GybU3t
 8QiZ5KaiGMAmylnY7EuKt3WSB63ULS7fRQIZPvoGiNyokC03L6FZRyPicoYglHLUO3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790940359;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=/XZA3VEGe17k+QMa5VmS+A9BWT4/WhTzGoIclHm/IKY=;
 b=K5M+Rj8o5Jp2izdJ7jMLwPkRo7NIUasTi4jBJdJL31Gtaf/pEzMDqyjNavr4ESHxVMdB
 IWxcMZqDb2P/8doRUfdm1TQe+6q6imnQbkSn3p4zKFUy8nDYOtQx5ra5wGa/Ah/p/t0P7
 L0TXoER9VxZV2OjWGpvgY2SpudUkrIdd3Jw8ER+R4LbEuNjauaN15uFiLWq7/LMakf/UV
 uwTwzXXbHOA8Knkt7oYl9hXs+OelodVpCTWOJR43JB/1opl6DlSbuv/928VMh3nFg+L88
 WbLRno/l4R3jxE602gVRrjwKkUvMkifn7FWqmm4lu455W3h7u/8zzyUfy5/I595kddg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sDRHgynS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::c;
 helo=mail-yx2-x0c.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sDRHgynS
Received: from mail-yx2-x0c.google.com (mail-yx2-x0c.google.com
 [IPv6:2607:f8b0:4864:41::c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76B88606FD
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:25:58 +0000 (UTC)
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8ab46253999so46180957b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 04:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790940357; cv=none;
 d=google.com; s=arc-20260327;
 b=gENCf1PHlsWObpCFJekA0a3w89dhpiB1Gv0H0aCP/hQ2ojA1ale50g8QtnTOKOsL4E
 fwlxM+tVG7U8HVfG3PhenLhJxbGtRVKlrXSELCsuHWDmYTxvsqrtYLBvPhWOa66UHHgE
 ousmsZqDd9+9IcEirYstlk3Y6ReAnfD62hm3nu0w8yvbJq2Fw2VOoXMVNHREfRgM3rIm
 txbfx8KAsSxAfzobcNVQMdV7kQ7HLHM0nAgpeMvXSPhIJOQ4rN1iNwQr1lP4yVDQHQQM
 /oribiQSuuj7kGYI2ZvjrTnjVyHP/UGMOfEdsM8FUkaezUjodrtqO5rm14ks0TjHmZVz
 eSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/XZA3VEGe17k+QMa5VmS+A9BWT4/WhTzGoIclHm/IKY=;
 fh=lfFqgAHmeXyPYtVc3raXXc0t9xB6fh0Hwyo9AWxg7PA=;
 b=PZPC4X4IgyE6ya0ASzoAnDVBd9z+65OhdegguXnBW7ct8K0QGv8zOMpLnJQt08jJp4
 qET5xttwBQLiAoL+30VWfVX85VS5eu8XZSQNK9+WeZVmyXeo9gBtr0s+IF2pRJGqDvvb
 z17YI94s79T7+Lkld6UWAe+ZRP1wkzI2lQnxCmYFIb9b+xmIlIKLgIWbOcwi9HL3kgKh
 YDtxirpYqbH7yCJrny3nnGl/79uEX7PcSkWc26292PpIWCXQs4+sUM7CKpGOPIoZr0CB
 K9nHqDTg68ynJuQo7zB7Ah4Yh88vxa+MR+qif8DiL/0YGCmjIW1o20pfHUsfazL9mMwQ
 G6dQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790940357; x=1791545157;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/XZA3VEGe17k+QMa5VmS+A9BWT4/WhTzGoIclHm/IKY=;
 b=sDRHgynSOxPrDh7Czyx4RxReXNpR/zZVTkbJKzPdAfK1iFE/8IA2uz9vxmy+o8u82e
 OeWjni6m6hBNH963VDfOBEYx6eZgkgiYaxnmgbTj4Nb3k2s6HpDv0qSY3Go6nDYbZXeZ
 v7a+F1GBaj0LryHFUYVZfsTMpHAjCMv8hdaHqhnT9/6cW3SeEhNsZViX8al7LI/nEoQq
 bO84nTvsuQxfx5UDS1hJHSg552iq+xqEUvRmH17B62gb173VoXKFIModr5T5Ary7Cy4i
 +SRDO88lOrMOtOJU//I7ZpXOTQl+IZtc2lX7bp9mtdwZhVkOAHyAC/tAokR++g+8E/Kb
 4UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790940357; x=1791545157;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/XZA3VEGe17k+QMa5VmS+A9BWT4/WhTzGoIclHm/IKY=;
 b=mZtKUk46RPhCPXp6JvOsJGLeZ9nlcCdGOwTi9G02s5by3mCiSaqgSz0lsLXPNIRk6W
 kqMsY5HmI5E/drP7LEKDt13y4r4TIUBH19pi2J+Z3T9zQThJHbmNesPFIZJWFHYQJMw/
 0SGeb+RcP3KKc7elBnlMX6dRR22Sf8qHrnSMWE+DYSy0qo04DufAbM8YKgziQl7oyKEH
 xZYcGC44Xq64e4ZbVrOopbSAO/wabK5OwH+PlX8MbXDeyV7Mu+HXKqCDbdgVv0k5msNl
 joX81FyZMdniJrX7Rl6rCU3BVcK9qH/xKpcaTtpXJGx10lcBeF5tFNFIRpSQnH1PIOHC
 Di2w==
X-Gm-Message-State: AFq9FYLdBPsCfoRkN6e2ug3V5yngAOf4gCmpSY3DLpqIqasPiB4Mwpay
 Bz4HyPDx0W2WT4GLYekgUhWgDW4k9wOc3Dx5JzhTVSRfvNNf7l2iAMonyUPXcVHRocO5LUG6O/n
 xFRpodLDa+dpUabUx1p+FRsdAW1Uq6VpUJ6bReg39kw==
X-Gm-Gg: AYBFou0ABjNQelcy2p953srh8+Us9H7fxrDwRJ1+hAs7aNUuqpdurt6CMBVnrNtQi7G
 nf+NV2dBWTTZB0k2nVoLT2+qQOMfNBkTKJTYA45fokm6tH5A11JcwXCsMZBPpP5WZQ/STSS5Waw
 lpP97upRoAOewElFPursmQasCLa9g7mX61pNG6ZuiDRZ4twywIaCIixoDSKgm2Fwi3/XtsBZxPF
 M1WjjCcojYGwnT2y8xRxTVwjE5W93h9d2NxQs/Ig+s3I3m8C5mS4f13lgEF3XUkfWWEmJT5TlmS
 DyRylI+UWAyEGzQoDLVvuo4X9WO3MgxX0LtxJdIqvKQsLl36cuNNg4bszZdo6+MSEAFz1SJlZew
 Ni0XJdxb6kII5OsiP02dz5ZuYpilVgT4LAcFFRzFWHxt5YDmg4Fs+R3uPSNV2gi8MRp9GDL6SLb
 mzL7D0OCVqohqtu5gyJIEJyRFxPhkDUf9kgD1+NiHItsYJYhzIkvXjaI7KFbXjzox5Sx/loJoEE
 VyRS9ML7dlBDeCfWHz0zI0s9RHuTlAKb4ArM0d7g6wuOVR+bbWQJqrPAkQ6D4Th1EjK6VAdPlJ+
 BKhDWwXojfCcrnCH99gKtTxMjIYcJQPCJEqqG4dy7WBEIkW5Um1b5XZyU+ghmQ+X325CuDyFGeq
 +RpDVxKg9iuTmGqsIE4IZxV6jnZAADw6qGATwuCuoQBWiA85lcxO8gw==
X-Received: by 2002:a05:690c:e1d8:20b0:854:b86b:d206 with SMTP id
 00721157ae682-8ae394a7bc1mr7228557b3.12.1790940357390; Fri, 02 Oct 2026
 04:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Oct 2026 14:25:19 +0300
X-Gm-Features: AclHuK_I2fDa_eRtB6I89dXKK8kIjtOP_a4qg_iT7NBYH-Kg2WtJHyFg0WtcNZs
Message-ID: <CAC_iWjLEhgPKU7CmZ-vuZMiLV9KtAQZ5-EV24bxyabd92PknCw@mail.gmail.com>
Subject: Re: [PATCH v6 00/24] Introduce Firmware Update Support for Arm PSA
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jens.wiklander@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Davidson kumaresan <davidson.kumaresan@arm.com>, 
 Adam Johnston <Adam.Johnston@arm.com>,
 Srinivas Kalaga <Srinivas.Kalaga2@arm.com>, 
 Alex Chapman <alex.chapman@arm.com>, David Hu <david.hu2@arm.com>
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

Hi Harsimran

On Thu, 17 Sept 2026 at 20:18, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> This patch series adds Firmware Update (FWU) support for Arm PSA
> Certified platforms [1], enabling U-Boot to serve as
> the FWU Client, with the Secure World acting as the Update Agent that
> manages the firmware store and its metadata.

Since this is only applicable to Arm devices any chance you can get an
Ack from Sughosh who has worked on the initial implementation ?

Thanks
/Ilias
>
> This implementation adheres to the Platform Security Firmware Update
> specification [3] for the A-profile Arm Architecture and leverages the
> Trusted Services framework [4] to interact with the Secure World update
> agent. By delegating update management to the Secure World, U-Boot
> handles only the client-side coordination, invoking a well-defined set
> of ABIs over the FF-A interface [5] to deliver update capsules.
>
> Key features include:
>
> - Generic, platform-agnostic design.
> - FF-A-based ABI: All interactions between U-Boot and the update agent
>     occur over the FF-A interface, ensuring compatibility across
>     PSA-compliant systems.
> - Multi-payload capsules: Support for capsules containing multiple
>     payloads, start/end markers, signed firmware images.
> - ESRT support: Capsule payloads may be signed for authenticity, and
>     U-Boot can populate the EFI System Resource Table (ESRT) for
>      OS-level firmware management.
> - On-disk and standard capsule handling.
>
> For implementation details, please refer to the documentation [6].
> Testing logs for standard and on-disk capsule update flows on
> Corstone-1000 FVP are included below.
>
> Changes in v6:
>
> * As suggested by Sughosh:
>   - Addressed review feedback by separating Arm PSA FWU from the existing
>     normal-world FWU multi-bank implementation.
>   - Moved PSA FWU code and Kconfig/Makefile integration from lib/fwu_updates to
>     lib/efi_loader.
>   - Dropped v5 changes to lib/fwu_updates/{Kconfig,Makefile,fwu.c}. PSA FWU no
>     longer extends the generic FWU update path.
>   - Made CONFIG_FWU_ARM_PSA mutually exclusive with CONFIG_FWU_MULTI_BANK_UPDATE.
>   - Reworked PSA FWU trial-state and image-acceptance handling to use the cached
>     PSA FWU directory from Secure world instead of generic FWU metadata.
>   - Reworked Corstone-1000 active-index handling to read and validate FWU
>     metadata directly for kernel setup.
> * Rebased on master.
>
> Regards,
> Harsimran Singh Tungal
>
> [1]: PSA: https://www.psacertified.org
> [2]: Corstone-1000: https://developer.arm.com/Processors/Corstone-1000
> [3]: DEN0118 v1.0 A specification: https://developer.arm.com/documentation/den0118/latest
> [4]: Trusted Services documentation: https://trusted-services.readthedocs.io/en/stable
> [5]: FF-A interface: doc/arch/arm64.ffa.rst
> [6]: Documentation of the FWU for Arm PSA support: doc/develop/uefi/fwu_arm_psa.rst
> [7]: Arm PSA FWU logs when used for on-disk capsule update in Corstone-1000
>
> Testing:
> The implementation has been tested on Corstone-1000 FVP with both
> standard capsule update and on-disk capsule update flows.
>
> Tested on Corstone-1000 FVP:
>   - Standard capsule update: passed
>   - On-disk capsule update: passed
>   - ESRT entries verified from Linux after update
>
> Testing logs for standard capsule update:
>
> A trimmed standard capsule update log is included below.
>
> ```
> CapsuleApp: capsule block/size              0xDCF56040/0x867B5A
> FWU: Updating 4 payload(s)
> resetting ...
> NOTICE:  BL2: v2.14.2(debug):lts-v2.14.2-dirty
> ...
> U-Boot 2026.07 (Sep 08 2026 - 15:59:00 +0000) corstone1000 aarch64
> ...
> FWU: System booting in Trial State
> ...
> Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0
> ...
> root@corstone1000-fvp:~# reboot
> ...
> U-Boot 2026.07 (Sep 08 2026 - 15:59:00 +0000) corstone1000 aarch64
> ...
> FWU: System booting in Regular State
> ...
> Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0
>
> corstone1000-fvp login:
>
> root@corstone1000-fvp:~# cat /sys/firmware/efi/esrt/entries/entry*/*
> 0x0
> f1d883f9-dfeb-5363-98d8-686ee3b69f4f
> 1
> 6
> 0
> 6
> 0
> 0x0
> 7fad470e-5ec5-5c03-a2c1-4756b495de61
> 1
> 6
> 0
> 6
> 0
> 0x0
> f1933675-5a8c-5b6d-9ef4-846739e89bc8
> 1
> 6
> 0
> 6
> 0
> 0x0
> f771aff9-c7e9-5f99-9eda-2369dd694f61
> 1
> 6
> 0
> 6
> 0
>
> root@corstone1000-fvp:~#
> ```
>
> Testing logs for On-Disk capsule update:
>
> A trimmed on-disk capsule update log is included below for one payload
>
> ```
> CapsuleApp: capsule block/size              0xDCF61040/0x867B5A
> Found EFI system partition on Boot0001: OnDiskFWU
> FS2:;HD0b:;BLK4:
> Succeed to write corstone1000-fvp-v6.uefi.capsule
> resetting ...
> NOTICE:  BL2: v2.14.2(debug):lts-v2.14.2-dirty
> ...
> U-Boot 2026.07 (Sep 08 2026 - 15:59:00 +0000) corstone1000 aarch64
> ...
> FWU: System booting in Regular State
> FWU: ABI version 1.0 detected
> FWU: Updating 1 payload(s)
> Applying capsule corstone1000-fvp-v6.uefi.capsule succeeded.
> Reboot after firmware update.
> NOTICE:  BL2: v2.14.2(debug):lts-v2.14.2-dirty
> ...
> U-Boot 2026.07 (Sep 08 2026 - 15:59:00 +0000) corstone1000 aarch64
> ...
> FWU: System booting in Trial State
> ...
> Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0
> ...
> root@corstone1000-fvp:~# reboot
> ...
> U-Boot 2026.07 (Sep 08 2026 - 15:59:00 +0000) corstone1000 aarch64
> ...
> FWU: System booting in Regular State
> ...
> Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0
>
> corstone1000-fvp login:
>
> root@corstone1000-fvp:~# cat /sys/firmware/efi/esrt/entries/entry*/*
> 0x0
> f1d883f9-dfeb-5363-98d8-686ee3b69f4f
> 0
> 6
> 0
> 6
> 0
> 0x0
> 7fad470e-5ec5-5c03-a2c1-4756b495de61
> 0
> 0
> 0
> 0
> 0
> 0x0
> f1933675-5a8c-5b6d-9ef4-846739e89bc8
> 0
> 0
> 0
> 0
> 0
> 0x0
> f771aff9-c7e9-5f99-9eda-2369dd694f61
> 0
> 0
> 0
> 0
> 0
> root@corstone1000-fvp:~#
> ```
> Link to v5: https://lore.kernel.org/all/20250926141351.1755829-1-abdellatif.elkhlifi@arm.com/
>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Davidson kumaresan <davidson.kumaresan@arm.com>
> Cc: Adam Johnston <Adam.Johnston@arm.com>
> Cc: Srinivas Kalaga <Srinivas.Kalaga2@arm.com>
> Cc: Alex Chapman <alex.chapman@arm.com>
> Cc: David Hu <david.hu2@arm.com>
>
> Abdellatif El Khlifi (23):
>   arm_ffa: Add FFA_MEM_SHARE support
>   arm_ffa: Add FFA_MEM_RECLAIM support
>   arm_ffa: sandbox: Replace the emulator error log with debug log
>   arm_ffa: sandbox: Improve the readability of clearing the X registers
>   arm_ffa: sandbox: Add FFA_MEM_SHARE emulation
>   arm_ffa: sandbox: Add FFA_MEM_SHARE tests
>   arm_ffa: sandbox: Add FFA_MEM_RECLAIM emulation
>   arm_ffa: sandbox: Add FFA_MEM_RECLAIM tests
>   fwu_arm_psa: Initialize the update agent
>   fwu_arm_psa: Read the FWU directory through get_image_info()
>   fwu_arm_psa: Add staging ABIs
>   efi_loader: fwu_arm_psa: Add set_image() support
>   efi_loader: fwu_arm_psa: Allow keeping the FMP payload header
>   efi_loader: fwu_arm_psa: Skip accepting payload after set_image()
>   efi_loader: fwu_arm_psa: Disable trial state handling
>   fwu_arm_psa: Add FWU acceptance mechanism
>   fwu_arm_psa: Add ESRT support
>   fwu_arm_psa: Add ExitBootServices() notification handler
>   fwu_arm_psa: corstone1000: Enable FWU support
>   fwu_arm_psa: corstone1000: Read active index for kernel setup
>   fwu_arm_psa: corstone1000: Notify SE Proxy SP on ExitBootServices()
>   fwu_arm_psa: corstone1000: Set Boot0001 for on-disk FWU
>   fwu_arm_psa: Document FWU support for Arm PSA
>
> Emekcan Aras (1):
>   efi_loader: capsule: Add runtime capsule flags checks
>
>  MAINTAINERS                                   |    9 +
>  .../include/asm/sandbox_arm_ffa_priv.h        |   21 +-
>  board/armltd/corstone1000/corstone1000.c      |  406 ++++-
>  board/armltd/corstone1000/corstone1000.env    |    8 +
>  configs/corstone1000_defconfig                |   15 +-
>  doc/arch/arm64.ffa.rst                        |    4 +
>  doc/develop/uefi/fwu_arm_psa.rst              |  154 ++
>  doc/develop/uefi/index.rst                    |    1 +
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c     |  285 ++-
>  drivers/firmware/arm-ffa/arm-ffa.c            |    4 +-
>  drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  108 +-
>  drivers/firmware/arm-ffa/sandbox_ffa.c        |    4 +-
>  include/arm_ffa.h                             |  128 +-
>  include/arm_ffa_priv.h                        |  153 +-
>  include/efi_api.h                             |    3 +
>  include/efi_loader.h                          |    3 +
>  include/fwu_arm_psa.h                         |  422 +++++
>  lib/efi_loader/Kconfig                        |   53 +
>  lib/efi_loader/Makefile                       |    1 +
>  lib/efi_loader/efi_capsule.c                  |   45 +-
>  lib/efi_loader/efi_firmware.c                 |   32 +-
>  lib/efi_loader/fwu_arm_psa.c                  | 1616 +++++++++++++++++
>  test/dm/ffa.c                                 |   73 +-
>  23 files changed, 3458 insertions(+), 90 deletions(-)
>  create mode 100644 doc/develop/uefi/fwu_arm_psa.rst
>  create mode 100644 include/fwu_arm_psa.h
>  create mode 100644 lib/efi_loader/fwu_arm_psa.c
>
> --
> 2.43.0
>
