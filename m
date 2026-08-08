Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FB7C5AD2C
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B2A7404D0;
	Sat,  8 Aug 2026 17:57:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37UWFRa51DeI; Sat,  8 Aug 2026 17:57:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F52240475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786211854;
	bh=sPct8yMZmC97pHDCIaDSD6rM7wdBHf8C7VUUxU6eKx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YLYJt32MtSI8HGFDCfiS7gM5mb7KUC6YvruBQOAuQKLvtL9RyNqMxFKx3WK6P3Wta
	 BiU5R1uqPe/33qf9u4T3rLO2/1WVFyXiFeEix4gTI94m1abaEyT7c5+fsvoa8cueH+
	 zeSIHK8Njm546BGRI566IBwkjWpLftzFwR6tmTzXOHrqIDqp8cu4/QiTNBYLyqpYel
	 SDQf8aQ6lwFQkyCwTILavl+qDnLQxIJG2JcMtTBcmlmjeiTyaEMh4kxtwShY7DMxY/
	 jGq2pgegi+SGkeq1py4zp9HW82swjQ5z0EdCDVnRRfe2zCWzMuQUkgE24pze5OmG6C
	 lZTviT7GRBIew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F52240475;
	Sat,  8 Aug 2026 17:57:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A9D0282
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10DAF60625
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:57:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uIKbnX04B62z for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:57:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4EE9660641
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4EE9660641
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EE9660641
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:57:28 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso676296a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786211846; cv=none;
 d=google.com; s=arc-20260327;
 b=KzAkZE7+PnRUpgtA63BH0wP9C0Vm3ixWwfqHg1QTSN+mrrbj6waWJ7OO8VM1SdccPr
 lbA5NB0lsbSa4P07ktHwjHjH34T8MyHMliAMJ4ypSblnQ7Ntjm+to2+iFq5wmT9frT26
 jmY/EsGWadDBP+RTfc0FD9F97Uiotrc1UYiHZS6LUmcUxyOjBryitu0eYAcTugd5CRnJ
 kmN+zD+PR07bYbhk0LXp2mfgqvCqyGnTyS92pB/eh9aBNf2Bd5+z39R4HnxVFjxjYlqD
 NhAd+dGeT9+ni9pVlbGgPF7A2NxTxHQ1e1CZ03BCKlZFGXV6aVezoW2tyOBkz9Tti4d8
 Z7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sPct8yMZmC97pHDCIaDSD6rM7wdBHf8C7VUUxU6eKx0=;
 fh=8TbiD9fEG91wSNsvqqOput+PpnqsIRDXX+RXlsylxJ4=;
 b=mbhoMB/wLQPNlB5kmvvrbEhtbq6rKco7hZPBB6Y9r7CmZTOH0yneWekw6woLA0vQbO
 e/hm5BE7SkkB+CYrZtK8B46do90R06cfZr6KIhCHkCOuWEjowiZmhKKIFvDZ19/JLEYr
 sKi7kZYIill9gqAKaT6u3PSuM+kxWLFes66hHbOgwLIqRjzb9jghEaW8R+J2tFb1xWBB
 hbcLI2vFSOwx8zEJEIyat/Ftr0FVLNFB6McbY1DWjcnN6mMmetpD63j6BXongDV7HRou
 zWrLBZCoHsStzZrt15bwRnqrtCHqK8R82KlwFFGqAs6xkEUePSeDmcur2Vp0dtuH4H3Z
 RFUg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786211846; x=1786816646;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sPct8yMZmC97pHDCIaDSD6rM7wdBHf8C7VUUxU6eKx0=;
 b=JRcQZgLgiinjzMYeJFnEvI294MHjbORqeOWbW8wJyN/0UEDi0z0S9VOK0L3tVuTq0C
 B5llitOOK9rrV5RQy13S8H5VTEzgCUrWUk6ob91FtHiMQ80epGJB43U+hj/Cgl3Xm/CC
 T5+331NThXtVYdzyeRjw/gA7cHh2xqxPdQSMnH7VFOxLSiV3S3tIiEUufArqmcUR4PvC
 8SKykQRpdeIQpJ2OczecgMo5ruBvJRjOoXvXsx5k4UPFq9PNDSjfIUv/u9G/im+vBDjz
 DrX2EEJzgx1p54ra/O9fTfL7Ry6b/tuyJumhBRgiaTcCgIHS3gxjNxDy/q6+L5pAFdSn
 Wa7A==
X-Gm-Message-State: AOJu0Yx2YofZ/M8m099XUqQGNZu+JZoYNXMocih01z3oVKRcoy4bgMwz
 4mUgT0TrW1urkFcdjrkrD+Zjvfkzpod0s06c5PCk1G4KI/HqLfDXxz4dALfioCswTokXGPRbWTT
 202XS61VGVt9w3M2qmuu5PC6rc8Jar4rZQQo/CDMN
X-Gm-Gg: AR+sD117g86K0TVC+B9vmkwnVjS+6zpxwpKswVNE9rNzNwDQdSyp6bD9PtnDV1hUphv
 6GMmDuL/NdVCm3GxfzbsGRDMqVeGVR+4xieATHfcQNm8FAP0uKcoxAhFKpIOYhx0G9GV7TSIMmh
 UUaKQmlMVMWThb+siiitoYljzElHMBdDI5rte3vTQaWzasNFjh7cR4UmYbcE62oGRN5Ik1kmm1Z
 zvtoHTnK0CEWGcInuqbjbEk4gUmUTfHxqCqf8nG2OxR+utiWbjDVR16+H2ZvAfY6SzKLPGsGp5N
 B3akCCz2O8mhdQbXJvDeefTI7uwXZ2qGsclGO5+k/bg=
X-Received: by 2002:a05:6402:5d4:b0:6a1:b0b:bc2 with SMTP id
 4fb4d7f45d1cf-6a14f126950mr15039250a12.10.1786211846047; Sat, 08 Aug 2026
 10:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260729081218.550465-1-pranav.sanwal@amd.com>
 <20260729081218.550465-3-pranav.sanwal@amd.com>
In-Reply-To: <20260729081218.550465-3-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:57:12 -0600
X-Gm-Features: AUfX_mzmBSqpxZvj6j2QI01TLcjQXrNDzCMzig6070nvrrQQhIv_v7itD1aA2qA
Message-ID: <CAFLszTjM-c2VqVtR7m=4xBSjTJDiwje9j40ZL-Jt02kHEjDjGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpio: cmd: warn when a gpio offset is already
 claimed
To: pranav.sanwal@amd.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786211846; x=1786816646;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sPct8yMZmC97pHDCIaDSD6rM7wdBHf8C7VUUxU6eKx0=;
 b=P2pz+wgcZUJq4MnI+q5YyjCaRjA5b8almt4X6dsZaVvCy06zAvAEDNHNBPs7wYfJve
 BERxh/HIcOpMwjSkVFse0rY4BDpXAfr7eLPrSpAwUm6zShXFZODiGkdBtcNVdbkcfvz0
 tQZCaUUAvtWV7cPsbQ83mcVdC3r08erL0IrZA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=P2pz+wgc
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

On 2026-07-29T08:12:14, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
> gpio: cmd: warn when a gpio offset is already claimed
>
> The "gpio" command silently swallows -EBUSY from gpio_request(), since
> a pin already claimed by a driver or hog is a normal, expected
> condition for "gpio set"/"gpio toggle" etc. This makes an unexpected
> offset collision (e.g. two consumers unintentionally routed to the
> same underlying offset) opaque to debug from the command line.
>
> Print which label already holds the pin when this happens, using the
> device/offset already resolved by gpio_lookup_name().
>
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>
> cmd/gpio.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
