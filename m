Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4BEFD9E34
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 04:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F050183AA9;
	Fri, 27 Feb 2026 05:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=pdx.edu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=pdx.edu header.i=@pdx.edu header.b="gciLVszU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE1E083BB1; Fri, 27 Feb 2026 04:06:53 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 574E383642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 04:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=pdx.edu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cts6@pdx.edu
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79801df3e21so15609747b3.2
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 19:06:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772161610; cv=none;
 d=google.com; s=arc-20240605;
 b=RrYb07m68G1QFTTmN199Ed2FFhI0lkDza8ICpOg9ahWZ0fCSsfROR0DlNMUBjXwT61
 XUe2JO606vBaDkcRxj1dHSsPE9kRhntPP3u5I98LzvoPEH6WFKTdmRgx7/AF7LImNDlb
 CbTgSpD/SRPbByjXiw/DO9vVnWvRxByelaSQIncuq3/Cdx7jeXafNMut26Gd4gJ6LZ6V
 Tb8VOPgRo4poLx9oaTYZHUrfPxs2m6J8KVY/Crs6NV+0vydG5a7kOhK1X1BavQf5B1KB
 TSTYliPSMezfxq6UM0cNqSYzHTSb8AZpsA/Hs8sekZEIqERqSwIGxHJv1+gFeCw0iD16
 RAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Z2sGgCMDPkagnauKBPoZ8p6crNBjxEKaSb1BKHp1V3Q=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=dDeOBKVuWU8Pwo2QsTtVfoBnWaSuFpyNryLeDsooXPgBP1YsLFbPLSPcsl+JqpPHRz
 ukDJYASINm4zzo7S8UCMaoLLtfGm7s32uFHpTSd2m0BDUEOT8KVoXcmtdl6hE2b75PSv
 0qg3a1MLHDZnhlyUMqgDj0e2PdXUYz2X8K5X/fC1yk2XKAeBZ5z8TuPPoG+FdJ9Uqcpz
 tXvaXEBBqrXHcn0N97Y7X1J0LKiEDHfEdQIJTn1cO+BMECoR1TIx/m5a3Jj7ArwZ5crw
 oapaE21wsR6GNFlUMoEnv3Hzdfj2ziVE+fYtjuYdpurQ/U2nEZbc8Z0gjieZdkQNyPvT
 x2MA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pdx.edu; s=pdxgmail2026; t=1772161610; x=1772766410; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z2sGgCMDPkagnauKBPoZ8p6crNBjxEKaSb1BKHp1V3Q=;
 b=gciLVszUCEadAbwx8Q5vZDIylyqGYpSburz4qqpNgH1JoQueFgGRaRauxC4r/FDbMB
 MtLEXJ/I0CblkqfKKnWttQVJYRO3wEpuDdVIVevmqlWODZLbPlBOolPmToWWeMwc69uK
 bxgvq8iPtESxUIEDzrctHRdbvXSiU9QEhxCIKlL8B+DmK5+GRd13R7b2CcWYmk8GMh16
 jU86wsNSP0tiTt6W1ByOgLhGUa5GKkCyrQNtaGgrdokjdfpqTOV+gaP3Bxb4eexOba50
 Zs9FivPnxUrLT3sB8dfepuHNOl4LivB/L7NdmNGoaZRbvG3wNIrBFrGkgwCdS3TvS1XI
 gOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772161610; x=1772766410;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2sGgCMDPkagnauKBPoZ8p6crNBjxEKaSb1BKHp1V3Q=;
 b=mxbNX1UDVjiwoEmb/LB7zxyubn7cJz7JcxAcKXGviWB4yCenpnnjdxEgbk6K7w1kU0
 juhHfLl3WjaQ+yP+Xf8whoNnlrCEBaqt1Ikrdeh7xC3cHdAcu1HMFAr/Q/hXfL8+S/6s
 NZWj98S8gQ0QkGbJeypdvvzeUneo4dogT3b+8uO0FqzOhpZslcKGXimpr5AJAp6tFMrQ
 N+QgfBaSZL0RE662rSAVVK4wpNNqqJ5d1yeOOSm/qtP6F+oMwakDsBSLNH/rNyp30xmh
 t8zRVFJyHbOXmH2OjzJIO3zPtA+GgYqUhlL2Jhrfj6FhTtnPFAbaBpzWWTFhtpeM/jUl
 8uIg==
X-Gm-Message-State: AOJu0YxETvi7xdI9kDtWeotxw8sn5XYsZvQ4w8zm6xuWdrk73fVDpg9c
 +jQpDgwKSFG3dNAwrg48bOFs4nmU5BjB6FjG3OCIOl8aza6vzmmBZo48pSpNGkmpOwZcVZFEOqF
 Eg5rXFEzu6chdWjJ8KPJ71OTlvjRygJLV6MJ0JmKTnRarcwp/ZoeoYw==
X-Gm-Gg: ATEYQzxpL2Dfh/vFA2osDUp+ohX6dVMWoA+JAfaVOVnI0wIbsWRnrE6Ec+/rYQaMDUV
 0Ajj+U4T+lL1aOxl/Iy7q/ieB7RDuaVHxDGJOLeTIm/hpB9ScJCyW61jQ3gTOfmy+SqXBs6teXY
 brIduKJzfa+FOu8oPLH5ac/szxry8nVbItFru1O9SvzLWRhKeQ+rWy3ZsyXhrITuZ5Xat/CxMJ+
 XFiIz0zL+ojUmmu6rRgOShZPc9BqeHntj+mq2eqosT5ueFytcGEj8hevEJEZ/ldz6H6XbIZMNUX
 fRagQ74=
X-Received: by 2002:a05:690c:a8e:b0:798:4d30:ed84 with SMTP id
 00721157ae682-79885221575mr17152197b3.0.1772161609961; Thu, 26 Feb 2026
 19:06:49 -0800 (PST)
MIME-Version: 1.0
From: Cullen Sharp <cts6@pdx.edu>
Date: Thu, 26 Feb 2026 19:06:39 -0800
X-Gm-Features: AaiRm52tIzHWZqiUPeJSAY4qJJaEf44VECQpgR6VPtmRIHAbY_Y8NGswOGj4Ivk
Message-ID: <CAMXQqg74OF+h=PqgYp8Pfu88fV2SVJ8obriYqYQxN6yLVouS+w@mail.gmail.com>
Subject: am335x: error with timer initialization (ENODEV)
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 27 Feb 2026 05:34:39 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hey all,

I'm part of a club at my university that builds linux-based cubesats, and
we have a fork of u-boot that diverged in ~2024. When I try to boot I get
the error mentioned above. I see something like this over serial at
boot-time.

CPU : AM335X-GP rev 2.1
Model: TI AM335x PocketBeagle
DRAM: 1 GiB
Core: 155 devices, 16 uclasses, devicetree: separate
Could not initialize timer (err -19)

So far, I've verified our configuration, which is based on
am335x-evm_defconfig, and confirmed that the device tree u-boot uses
contains chosen tick-timer: &timer2. This was motivated by [PATCH v4 07/10]
arm: dts: am335x-*-u-boot: Add chosen tick-timer
<https://lists.denx.de/pipermail/u-boot/2026-January/608684.html>.

Any pointers or assistance would be much appreciated,
Cullen Sharp
