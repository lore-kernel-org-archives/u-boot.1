Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCE4C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55F424061C;
	Thu,  6 Aug 2026 13:23:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hgrCTVRhuLHe; Thu,  6 Aug 2026 13:23:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7516A405AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786022634;
	bh=RC8qKKaOlAk+yUmzTbzBp2JdeHn9L2tZEKPyM4aIT9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wsKSObjEn8t7h2/7wJ5lugh6FPtaZ4Rbykgbq0KcOn786gRASAH3H7zqAxsqj/X5G
	 gzXmf/CFU9TWHq8ISx+5NVE0urR68MI43odxmrLgxV8o0ntVldyjEdXPRWyFOlaYwj
	 Spigmq3l80NAPVDbW7ypDJAauslr9LSA6jj0X9Encq6GiLEQnCALUMFY/Txn+Oef8S
	 kHdDZHeoUYS3pOOXF56b62zxx5eZivx+L5DpsIXOUuQHvIFMj8qPMTq27oYBmbNbx5
	 ayJWTxC/Yh5kxA/oRQzdT6mnEIufedoN4RSWFv3M5P1ve0xtuU9V7IbiKjyHtgU1/W
	 bKW4TDUNNlo6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7516A405AD;
	Thu,  6 Aug 2026 13:23:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 05DFB218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E07FA60763
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:23:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oRGZWRBKrK4J for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:23:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3CF18605EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CF18605EB
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CF18605EB
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:23:52 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so673046a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786022631; cv=none;
 d=google.com; s=arc-20260327;
 b=lQjrCgVmpfqY7uNg+UfwsKJ0kM8q/Bz3O/VrhVPqAxhdGDrRq671pze5C1C9qslQAE
 ZMvsotrd5PZrPz452JgjJJnaNvP+lqM0F2QV/4pdfBgA3Ze+YPHKZLCwg0c076EUjUcD
 4pUdMgn7EL8z19nKaY0OD2rM0+66ZVCkCQLiMWOZwSQAD5K8quf4klI9zTnXu+oaJjW4
 UkIRckJyohmsqDG3gziN5VwojR1DBq+chNWXlZroL8Z00x875QXXs1sbtI2Rf6ybCcf0
 hDg5hK3IgFaWg927Q+COkjTffONAzxMI8H+0b8jE1+iFGcOwoL8bhEG6zEcspg+PW30N
 IOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RC8qKKaOlAk+yUmzTbzBp2JdeHn9L2tZEKPyM4aIT9w=;
 fh=8TbiD9fEG91wSNsvqqOput+PpnqsIRDXX+RXlsylxJ4=;
 b=S4z7eYHqF6aJsnUSNsTtLmQV2Ov3o1qK3ToPnlyncCUjjLwTkjd1/+JWHF7T+XP5MH
 EDH8lJfwCq1LdTux7oYXl/+19QH70JZhIoS62BulGey+IDVOIk9ncmZC2T1sO7gJU3EE
 OoGDdtyab1qx8MZRPl9nQqbsqSwBaHo9Q2XGBNpTDWHR+iDiP+KmOnCGbFMJwBDOswPG
 VL/kD2JGAJH4C75czybC2cCRNRfLbzxPcphTnF4k1maxCz1C+VvoSzp0JLsjX3BnopsJ
 PqKZUI3wtsV4NNwCzhZuZacEyXDhflkNvAX2FaOjhkwNTIRjVq+5yvNyxUuN5rmVX04e
 pxaw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022631; x=1786627431;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RC8qKKaOlAk+yUmzTbzBp2JdeHn9L2tZEKPyM4aIT9w=;
 b=r0RCXPUlqtrvM+BVlSNTXBZFQ/EG9NVQdQ1t8EQltPlgwHiXDgjjPk3IKEDx+uENyU
 uK5GulVRf1jV7uzZzsScLnf+Xk+OohvXhEJa6t8i6NZh+aqmPMzPF6zB++Nmc/0zkX70
 UCLMj7TsztSXUSVdVGCzjuja/H3FMwWlbfBZYXn2YY6XE+d9WTXS9bOgyViGR5eiMzNo
 NP0A3Ntw+C9UxYdl1VJvsCCVmHksDG5NEsjWa/D35wF/OpEydUb/7l3qtkbjGe9tvZWW
 +pVxuZD2Gn7/ZLKW2wL65O/vP+P2e6ohb1u0sKA0tkk7duwPa03k9Cq75c34LSThrREI
 lR6Q==
X-Gm-Message-State: AOJu0Yy3VCPFQxm3600qgwZ8UqQWE24VhMNI24o/BkPdn/gyz2hImqHL
 3+DyeKwWG4ovRtLk/ZBmMfY14JpIvYvFOXrNHrg1WPYbK9Qz2O4fznUKhJ2YTRMhHyeIISsH1tv
 mstYDn85N+Ud69zeggQ8EFzuazQnR4xewZJVTJOPycdNi1qYPfj8=
X-Gm-Gg: AR+sD130nnueod3OEvP7T8/Lo4iBzvEABbm3IZjujpM3zSNGwgDDaqwjT6tTUXCBDfN
 qcERmTH6Ho4ni9orSp0FxpJV4eIrfV5Kmiz7sy0mZ4IVSB31pfljbaXV018PUH+5v/9GDA3cWRS
 Cvmp4c6blRfSK9mjGOzsuwmxvHWDiSURblxUbwsL5pNzXZh8lO3V1NW0jnpL3xRphwypZE+ZpTL
 +7ztZPxMKT1J/6bYvInQpHg7R3D+sz66fC7d1y9maKY6VC/Dd+hfi7lgJ1QiePT1sKvXUz5sMA9
 zG9d47/IuWcpTwuzjW6qBtqwsCYrLWF4tWa6BuoYf7g=
X-Received: by 2002:a17:90b:3c0b:b0:38f:1a29:7a82 with SMTP id
 98e67ed59e1d1-3908976cd4fmr1918108a91.6.1786022631366; Thu, 06 Aug 2026
 06:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260730094817.1937340-1-pranav.sanwal@amd.com>
 <20260730094817.1937340-3-pranav.sanwal@amd.com>
In-Reply-To: <20260730094817.1937340-3-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 07:23:13 -0600
X-Gm-Features: AUfX_mxU8vUuhaXcrW4rNYRo_6Qo8ueGSrma4aYAFNNUibkcMN1TWdRu4wqqsPQ
Message-ID: <CAFLszTg41Y0eBvUrnGddGENsHQ+cB2yh7RkpVbDnKSTA7MT=Lg@mail.gmail.com>
Subject: Re: [PATCH 2/3] test: sandbox: enable GPIO_DELAY
To: pranav.sanwal@amd.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786022631; x=1786627431;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RC8qKKaOlAk+yUmzTbzBp2JdeHn9L2tZEKPyM4aIT9w=;
 b=aLBXSfoF2ta6EoCXK9GrxYwwp4Jp6+ofQKKEvWvm/G3vrLCGTCv+FzXz2Ib0M2BZ40
 kMGgiqczoe89x5gIZnp59cTXkJNusXDo3jQ+BBSdXuqf9DouergsPuqjvybluzpptF/t
 mo36FJb/jeODhw/2YGwyF6owkRPwK19f5Gq+k=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=aLBXSfoF
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

On 2026-07-30T09:48:14, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
> test: sandbox: enable GPIO_DELAY
>
> Enable CONFIG_GPIO_DELAY on sandbox and sandbox64 so the gpio-delay
> driver gets sandbox coverage, and add a gpio-delay-test node wrapping
> two real GPIO lines (gpio_a 9 and 18), along with test6-gpios and
> test7-gpios consumer properties for use by an upcoming test.
>
> Verified the existing sandbox test suite (ut dm, pytest) still passes
> unchanged with the driver enabled and the new node present.
>
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>
> arch/sandbox/dts/test.dts   | 10 ++++++++++
>  configs/sandbox64_defconfig |  1 +
>  configs/sandbox_defconfig   |  1 +
>  3 files changed, 12 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
