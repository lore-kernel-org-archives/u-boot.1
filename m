Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2633EC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 14:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 020A580EC5;
	Mon, 17 Aug 2026 14:18:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id egfj-wFXuQ-n; Mon, 17 Aug 2026 14:18:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD2A680EC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786976319;
	bh=lVH2Be5od1rYcYPDNlTNOrhm/I41NBcrdbl1ww7OYwk=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=S4RgvzWMgZFUB7Aj2dAqbGz2d3J2ItqVnqXUPOsJCCdu96sQNjJj48qsqQ3qOnrYs
	 Y+kyx05Fdx6JEwU7UhkMa4XPMKm6uuyJmxlABHv6WKU8f08lXJ+Rby8eM8J4/TzW6w
	 +pABcW/4bt3S/wflMFL/R3OB2RrpCdCZcubFlEepfeg2cbDy0FkoYFWtccsIFv5mh5
	 wIPMZoDvYLcSzREhYhHUujbCBhdcNaMNSvX1VsBP/j2FVJeQpFSNal4gFkDCyeitjq
	 VC7C4AWDoNLVO9jEIhETkoM13db5t86aGwE2dgB1BKApKQcO6myY/atfqFFI4wITfX
	 t/ID9wtXo5a6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD2A680EC4;
	Mon, 17 Aug 2026 14:18:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 86EA0147
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 14:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D6E2606A9
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 14:18:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IYC7TqiU4zGp for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 14:18:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 53EFA6069F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53EFA6069F
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53EFA6069F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 14:18:36 +0000 (UTC)
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66c711b7f2aso5059218d50.3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786976316; cv=none;
 d=google.com; s=arc-20260327;
 b=UcaDWqc+HNiibbwUyLmhzRLDoMLntCYCZtwB3mEw3kSlEaJVXI1V51egHHd/cmrxR+
 tvoqb2kDV7+6zK5BoYdZ2DZ2170XW/HnG0cYhIw2cjgGnsHdxIuS7SN33K2cvd+cGnLe
 cv0AtQLAe0nDLtK8nu12TcYT4z2Hbp03YUSQXiJmI2wnr3PcZdm2zOxnJKqfspT+Wb+b
 1zEBCw1ilEfsU472wmTKWaB87s0NnLQ8+jBPf0eFEYYQRJfvrIpkVhuGXPigT6SbOFvZ
 e2mN0eV44uJrKYYKICySJiu1LXExIBwpJySQs9v4Yj4C7cs5cUDNg/Ghz6u1fPU7dobY
 oEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lVH2Be5od1rYcYPDNlTNOrhm/I41NBcrdbl1ww7OYwk=;
 fh=xa53t6eSd3qJViWAK5PzgTCOh9s0VmebQL9hVAwhHEI=;
 b=rMUOYY9oKMmygqdq/quEe8tiBOfi5Eyt5e23mSGS70kyM1rQp1YkiMfV+zdLvbLK4P
 SEKY6w/RUqZBLzUSyfYA6VKlBh1lCHEOQdDluKEJ+D+ICEb8S/oT2RTRIOcpcbB03a95
 qAb2NmshdnUnLqjiPXsbHtDBnan7yV84Q6ZKcsbt15K5mU27Zd0fr0YlCRGJTpzKikOA
 32OTKCmUN5FnRg7Uy0iOHUQxASnuN4kpq8KYTm7SDIF9PHRv5dwrz+ViODRn7JZOdu8R
 SD9C706EKfiLFJ68MoH46Lw0PRkKLqZ5/hT5P+63mwJ5wTb3yFkCScxcEKZLZGGaB6AF
 +7Dg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976316; x=1787581116;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lVH2Be5od1rYcYPDNlTNOrhm/I41NBcrdbl1ww7OYwk=;
 b=ZmovpOOrbNMcuf1Z4cOT3CTZOCq6MhkEH1hOmwXNv+Vj53xePbHGw/+4ksVl3v5Tl2
 aNbNFnPZKrVvvFh6/qgBWGwVUuspSQq0iqumWdn3zRdMp+MZVnV5Z7IRKABmzyziDq5e
 lJkpdf0kK7ZV2Lbr9c7YJPS2PsgMUb7QKetcqqFrXVcVhOURi9eKvQ4GLIctNyPhRcMP
 248UsrNBQ2/DQ+hWK+0vUmvk5BisuwbA1yR9O0St1rb2WibANJ/qU0ONQzo1uUvPNkMb
 1/jGytQoMUXnWviY4w7a9IlPf83RLPeUlIBK0UdY0yV0WW9nwF8Qhra1aHFB3NZVAAUt
 TiXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSTGajxDIrPygE5DcbnkoY9cArYbX26LhZpXrH+lBoWdLtonibJPuIKBd5vkIUtQeYEbUIkBg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxlJEPVbPusjeDd602D3t2tEQI+nHdpo6+ZwpUjrr698peE4Uq0
 X2aQqNQieiXWjsBCu4xXPUB2Te+lNAMsmCtT3WYkc6CSggib7mBSQCHYO676242DemFt+mAqTMr
 H/5SHfz9wZa29VknTVXx7gZkBp2x3yxzutSkGLdQLDiGvTEINdsfGvPU=
X-Gm-Gg: AR+sD10XF7DWOFRtl6aP6DIiEJRg3HLz/RZy6I67vpEh39kItKpOcTOeXKOmnUDJNRJ
 94efRgTjnmujFemHHg5kSnDMA1fTiX/ti4lDkvQrIAN1qyp6mQu27wXnKjahsY+6xNSO1LGyAu6
 y2SSqpXaWNRIdFivdg1F4Pv5DZlZnPsdVi0Go72mRMYtvw+wnjvWl1V9l6FjDQG9zLsaMnu4hId
 bB4z6NlpEyCduDFcVDXDcKKOoOa0lIS4PidzWAvJpCaERiX8EzdvD4sSNz7tVi7cntwbFTgii+t
 o3pBbuZO39dAcfGhT4bZiqU7H2sm/CIOZFnzdwbUALechGP/ymAT98aQtFAb1PfxnZRjGS7ajH4
 =
X-Received: by 2002:a05:690e:1913:b0:669:484d:fdc with SMTP id
 956f58d0204a3-66cb9e43bf6mr328955d50.30.1786976315647; Mon, 17 Aug 2026
 07:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-riscv_iommu-v1-1-793cfa421ab2@oss.tenstorrent.com>
 <rxsu6crqaqxylns2vw5trz4fzsis5w4j36ovh5u2fp3ajj3k2o@oolpt5ilpoxc>
In-Reply-To: <rxsu6crqaqxylns2vw5trz4fzsis5w4j36ovh5u2fp3ajj3k2o@oolpt5ilpoxc>
Date: Mon, 17 Aug 2026 09:18:23 -0500
X-Gm-Features: AcwNN1X1Q8oaE6ejvwCA-FsWpDKuWxPDTOYn_9SYkuqgbCwf8UIqa5f8cjTztEc
Message-ID: <CAEev2e_=TojrBbrfD0ZTEGJvGS7XUA44ZruOL5NfUPmSHE054A@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add RISC-V IOMMU driver
To: Tim Ouyang <tim609@andestech.com>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Leo Liang <leo.liang@sifive.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
From: Anirudh Srinivasan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tim,

On Sun, Aug 16, 2026 at 7:20=E2=80=AFAM Tim Ouyang <tim609@andestech.com> w=
rote:
>
> On Mon, Aug 03, 2026 at 03:06:12PM -0500, Anirudh Srinivasan wrote:
> > Adds a basic driver for IOMMUs that conform to the RISC-V IOMMU
> > specification. This driver sets up the IOMMU in bare mode so that
> > peripherals requiring DMA in U-Boot can function.
>
> Would you consider adding support for SPL?

I don't have an easy way to test this. This will have to be done later.

>
> > +#define RISCV_IOMMU_DDTP_TIMEOUT          10000000
>
> Although the timeout aligns with Linux=E2=80=99s, it may still be too len=
gthy
> for the bootloader stage.

What value do you suggest? Seems like none of the other iommu drivers
use timeouts, so I'm not sure what to pick.

> --
> Best regards,
> Tim Ouyang
