Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7185C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 12:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0323E84A5F;
	Mon, 29 Jun 2026 14:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PXts22pc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0543A849F6; Mon, 29 Jun 2026 11:16:24 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83312849EF
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-698587a1335so1287069a12.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 02:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782724581; cv=none;
 d=google.com; s=arc-20260327;
 b=Z+qub4r53N0OqtYD8d3b6L6186muA3loXxXQvJbtaa574QFhgOynid577rCxz+jF6g
 Kpr2bfWJHHRvA0+kE5WRa3BRi8xz+Q49miJr/OIm1Dx6oxCCJ0H7eQklAu8sYJD7pzwK
 aBkZOgOLlvKIpH/r2vaS1BfOK0IqliTYWv9xnXbBT8frDF3Ha/ATwj04SLE9OTCeStao
 vTalw7l7D7qAvgGgNzWZsFD+t8Yh4lrSZPpwyM5ccwaPDyTMh5Z5QdUiQgJxSdY8KEi+
 BFXAz4Wdz42rO8nJ7Ta97STFxUMnv+w+y+SuG24LMlo94OLZHruUFq6Y3uB6KgQqzWVs
 YeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GrOFJ9InOWLKt7/om4xM+LdSkk4Sxzhwcft1m9DXWmw=;
 fh=1w1hAR7ttZ04alXP0m4TKFlMMT2BW/d+k5N/6L1rBTY=;
 b=lWKnVK70QsBmPl5FPELfShfc0M4pfZHKrPYunWNrORcmsB4cVBavZ0FcNI9D3fnoUP
 TPy3ELB1S2mkSGcU6jFTks2gL/okSpIFrEhYl7dCqzxCO6JNDlfn8PYL5GPBnKvxsi6g
 GTqOK68N5PV6DaCPYIfgpmSVMRxYQ2k0qCljqHb3vI7wpvWij7tsEWTcdInGzlenVCqN
 9CUa/+ch5rU3m6Fmm9OD8H2QTn3cs81/nNpWCHQGQa8ctSo3E9CGd+cOohuH4jcOe5kZ
 fdKn3MR4a5Ea7CaXsQcGWDLoHBNP9cQbCN3OeMKbASec81evyoe/Z8UQDJK7dzqAky3B
 v6Hg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782724581; x=1783329381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GrOFJ9InOWLKt7/om4xM+LdSkk4Sxzhwcft1m9DXWmw=;
 b=PXts22pcQyCC4AsGicSCYWdiqToRg3I3V9eaa64OVYLKli7GfqMlY82VlX9vBvVbxu
 XkwPFEH5xxztWhRr4yS9p9L4O31ygH9LLDuGnPkq/QusIWriO8mXTmMmsgLsJeJ0ss5v
 lAMd6n0QjvNNIbzJhVQaa0GJhTExoaiXeYUx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724581; x=1783329381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GrOFJ9InOWLKt7/om4xM+LdSkk4Sxzhwcft1m9DXWmw=;
 b=QAHLK/QYupRW5FWVYrHeGiCJecS7b3zl7NkvHgPwRdncNb0Dj1HK+Z2X2J11aujkcy
 q4J7HODe3UlX8qX8KAT5SPFNNREE9zUIjyMjHXaLU9DwHY4snE8h2bcgy+yUqZb+CV30
 6whdm67xa23gcsJ7bx3tHvXECj/h/VPewrO2Ea6ClCOqBnVHK8hZgdxZGVPHsN50cQsS
 Vn51k7fIbsTzbyeBYvcwUCvYldPoaJLnCM+nBzG567YZZOCJKErAG+2za0QkoVKB6FEL
 IyDjxPbqkjurrNudC8zxPrWEZCWh+T7iml6rbNziye4bUJUL6bw3iBUyAyva5pl7h8W2
 d5mg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcmU/OTRvEF/X8bVCOBf/CoVEcLqGR8UL3v/Aq4WQrPskjE4hVmRqbBG4iRFgttoLiGF4kUhM=@lists.denx.de
X-Gm-Message-State: AOJu0YwEy62ORWpOX4zNP60iS4yzCa8EG1wgw2dqoQ7nptV0Cnu9Q5+P
 3uyEFnp9koaKV8G1yj5LxPHDKSgZ+0K16aPs/k/gMJRgbX+YwaCjgsbZ3bA3GneUYVO8hgUAZ19
 Dxo8aD+yteIKigKZAgUpBKkntG5YhmhCAc6/SPSYm
X-Gm-Gg: AfdE7cnx7hCM58od/6oyL51NGuEQDFDSMYBIAymzywZ5LZYf8ij5PSRVtyzPG9g3U8G
 QZhvcrN+cmS653cjvkqJ5Kcmw88+ENV6mMPtxb99bo9ID3NhtbIzU4IBdlNPUxrDlEg1DN2p7E6
 vQ8YaGZzjPLeKvPrvLk0issRqkojapkUirUac/Oiy60GcYBVe91LQom1QwBtGFB93LDnBV6hYYa
 3kFnoVhgRRBJPzCpnQq/j058jqPh9ruhUVA9XGZ5LT+F3fV5+UvLgK+AroFxmbUPBRKqugWI1Or
 Rtn2DlHk
X-Received: by 2002:a05:6402:50d3:b0:696:565:a9e7 with SMTP id
 4fb4d7f45d1cf-69810a5d31fmr6083519a12.9.1782724580944; Mon, 29 Jun 2026
 02:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-6-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-6-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jun 2026 10:16:03 +0100
X-Gm-Features: AVVi8CdEd78r86w7RCnB37xMEi46nk_yVLc0ZU23AghVjqPhzD5UOYOGX04dU1s
Message-ID: <CAFLszTi2KF7QE=WVRcExAAGOnLdHzVUH+pXTpdsTF6aLu=hx4w@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] mach-snapdragon: Add PBL shared data defines
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, marek.vasut+renesas@mailbox.org, 
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com, alchark@gmail.com, 
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com, luca.weiss@fairphone.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, ycliang@andestech.com, n-francis@ti.com, 
 mateuslima.ti@gmail.com, jamie.gibbons@microchip.com, 
 david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 29 Jun 2026 14:47:37 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-06-23T06:47:53, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> mach-snapdragon: Add PBL shared data defines
>
> Add structure and enum definitions to be able to parse the information
> that is passed from PBL. This will be used to identify the boot medium.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> arch/arm/mach-snapdragon/include/mach/pbl.h | 58 +++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
