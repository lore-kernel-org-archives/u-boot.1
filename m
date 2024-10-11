Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCB8CFD37C
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 12:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC22892B9;
	Fri, 11 Oct 2024 14:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EJq9PyA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E962892D3; Fri, 11 Oct 2024 14:33:56 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B45258929A
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5398f3be400so2242496e87.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 05:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728650034; x=1729254834; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ptKaSfYMfxwKB7T+P7Dbt68P8Z/tvtY7JbUy03KsLqY=;
 b=EJq9PyA9ReMK7gTFM+svWBX3pxLvaX4+5vc+5vVTOlIlvsHBTRJAfPLvORkPb4ch7K
 1n0D1zNG7ETmo5GeLP3LSCUAsTOeb65/VYLaGZhkCEGm53DTVtbi0JLLO8lLUgoqZwB9
 wN+cKbtjCUyCMdd8aYO3+jaZlyEp0uB6pd5dyTQoZPpx3ThcVa2BHpQaxmCPNcE2aPpk
 Lxuji7jzLi8RjM4oyd8wHjuqiVAYt5aWlMILiJuYnG6ymHVimnAtNkC+8plq6UeaTRNE
 O/wDA1TTA2HdyriySrG7AnggQlU3IfWFQC7cHVomi7rlR+VS5GbVQiNIXevTXSTQxBJ+
 5bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728650034; x=1729254834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ptKaSfYMfxwKB7T+P7Dbt68P8Z/tvtY7JbUy03KsLqY=;
 b=nxyEp8Bfqy8/vbyAmd2UBMal9V/zBHx3elSHUR9pdQSFkM1FuAb3XjdTisoS//Krcg
 fe3Jg7mY57p5XM3JqXZmSeoqNKeGOWTLj5xpH3FuGY6EBrVY1Uw3jURIfpSnrjRclwAg
 ZC3lFAulchsg236pSyz0w62fhZ+kaXD9lEEwjj4DR18cJxFf2FWmRM0cRHXe5mFM9LVm
 wngjc5/BSIPt8yDpLt9Lz+Oqlz/mhES4X9SI/OKGluocr+yWaBeOCAfsEDkK3YqB5dbP
 JgpQX5cnhXGut9iBvlKh7GGBqUdTSVbCJDua8lxNC+I3KjPOECAilNuM5Q4MdJBQVJk6
 Z0Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiKdmwWyAz8BGiVhxOQiLkvDdZ/GddwJdanK+3w7kHSSuYBV0epnNwTpww95fDAp9jYvCQ2DA=@lists.denx.de
X-Gm-Message-State: AOJu0YzJ+FR6YQ5PhZFNtAejVSWLQnBQgmRH6Vk6H+fnAZx4WKmjEKxg
 KF1VtxzJSLJEawfMgs3s5CiIGuOgMc82OHHIqSj8U0S0m+6UUzgnd2zC7m2RUFzJaxVLmCBEm0o
 x+0bThoznIkWJG9iK7AEB86Rcdt4=
X-Google-Smtp-Source: AGHT+IENQR5gCflujL5Huwm0QYPcrdKgKtFhgAre6sIlzq93MRztoVUl79VvuRjCzKQ4AWRBWvhZ4yXrQq/P4MzQivU=
X-Received: by 2002:a05:6512:3ca1:b0:52e:e3c3:643f with SMTP id
 2adb3069b0e04-539da3c1c66mr1197547e87.2.1728650033594; Fri, 11 Oct 2024
 05:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240920063204.1049202-1-martin.stolpe@gmail.com>
 <20240920063204.1049202-2-martin.stolpe@gmail.com>
 <20240920081625.z3fwz6n7o2zxd4gf@localhost.localdomain>
 <CAPHZmLbcfMVOydp9jCY0mWKdKPePBp+3rfttMyKbHT-CbB7kjA@mail.gmail.com>
 <e27aef89-8038-9099-58ed-b927cce54579@ti.com>
 <CAPHZmLZopucK5uMwENuF83pRMLYR2A5sC7fes4-1JXE4jX7=rw@mail.gmail.com>
 <08a38499-c36d-4bf7-adcc-d3f547f3afc8@ti.com>
 <CAPHZmLaVVSckGeqU09WMy0s4rGA-w6pQ9ObPuh3SBf8uTBaD9Q@mail.gmail.com>
 <dadefe22-2662-ddd1-cace-15d70f632232@ti.com>
 <CAPHZmLY7UHGdsdKtEDCL2xRpBiPuDS8Hc-roGtt1+5F3zZnAnQ@mail.gmail.com>
In-Reply-To: <CAPHZmLY7UHGdsdKtEDCL2xRpBiPuDS8Hc-roGtt1+5F3zZnAnQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 11 Oct 2024 13:33:42 +0100
Message-ID: <CALeDE9MeiBg0yTYxN_O6KwHkeqmvD4N1gd0FTfdT=ydNVNg2Fw@mail.gmail.com>
Subject: Re: [PATCH 1/1] rpi: Fix build error when CONFIG_VIDEO is disabled
 for Raspberry Pi
To: Martin Stolpe <martinstolpe@gmail.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, "Ivan T. Ivanov" <iivanov@suse.de>,
 u-boot@lists.denx.de, 
 Francois Berder <fberder@outlook.fr>, Matthias Brugger <mbrugger@suse.com>,
 Nikhil M Jain <n-jain1@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 11 Oct 2024 at 13:22, Martin Stolpe <martinstolpe@gmail.com> wrote:
>
> Hi,
>
> Sorry if this is a stupid question but what do I have to do to add a " Reviewed-by" from myself to this patch series?

Just reply all with the reviewed-by and patchwork will automatically
apply it when I accept it, I think there needs to be a new v2 of this
patch.
