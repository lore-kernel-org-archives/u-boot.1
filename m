Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178CEECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE296890BC;
	Tue, 10 Sep 2024 14:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DPQZ7vqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E0489069; Tue, 10 Sep 2024 14:36:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7FF488C94
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725971772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvKsVNsnMiSVMGhRrwbVyM+c4Eh6gk/39Vaw7SCvWgU=;
 b=DPQZ7vqESOjA90opxXxN9wO824DzRdLbM64tZRVthpZ3nIQOP6QOiX9cebKXP4TUUNWfHm
 R76n0NT+g0DFP16DQp8MnSgG+oiMwRqIga1oSo2hJvD10DNEcA96OgHIz3oFJrfiwq0Bau
 xSd1Ol+FG1kj0G2cXnrf3ehOw6MZzCc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-Rotr-QPzO3-PiuivU00U6g-1; Tue, 10 Sep 2024 08:36:11 -0400
X-MC-Unique: Rotr-QPzO3-PiuivU00U6g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c366f8b1ebso126392616d6.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 05:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725971770; x=1726576570;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvKsVNsnMiSVMGhRrwbVyM+c4Eh6gk/39Vaw7SCvWgU=;
 b=A3JAEEtgVcG4Sts2Z05MrooLsemsPZvqg5o82dMwAjq4GhacSZO+afucNkgpi7biyh
 v8puC6PHPGZoUUqowissFa0XaBg3WB0beeDRV4n9pisgHYfbglK3mx80QylMcjuNh5Q+
 gAgK2OQPusyiL2JukR3qMiptlrcbaWepoAhsjqXjnOR3geH3aUBIbeS7k+uEIcvYtLTh
 BjRpivM+VdFWFJyGNuvKZ8DvJ4SUXU2HJe7jd/6sLhEecErrLV9Vq+hj44WroqY/hgvm
 rK41F+4gXiWMryteywfj8mXNmu9jxtysq1E6aln8XINav7X4K7iexBCoOJ9fbUjz0Ygp
 TrBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPj/dgOpiFO0L/hl+w1mtOkHd6C4Npl0zfgnCcQQYVBD1o5OgYjIp0+4tui6OzyeVB9cT3RmQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyq+cn1rzejYcY0/99qMqMjL+6NNfIfqQqvNrCOVAhmA+prKHXU
 qXq+i01OpayLZTqOCu3Fw9qm7cOjsEWz7qWFMPq0a4xOn7MG2v2gcXgbkri9VGPx99erSjv/4Jh
 bhJsU+QCwLBRXiZlRFv2Li/xlMp6P3bj1nzjdGrRxM9DuTR2TkZs=
X-Received: by 2002:a05:6214:320a:b0:6c5:2335:3ec9 with SMTP id
 6a1803df08f44-6c554d69e59mr47966566d6.21.1725971770463; 
 Tue, 10 Sep 2024 05:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQmWfMVpn7l12SXUO0VDwaWjeK0Wpp25MUg+2gxiSXUdm4rFxS3uv2JNo0M83HtMX6t2Jcfw==
X-Received: by 2002:a05:6214:320a:b0:6c5:2335:3ec9 with SMTP id
 6a1803df08f44-6c554d69e59mr47966186d6.21.1725971770092; 
 Tue, 10 Sep 2024 05:36:10 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774795sm29608046d6.115.2024.09.10.05.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 05:36:09 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:36:07 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Apurva Nandan <a-nandan@ti.com>, Tom Rini <trini@konsulko.com>, 
 Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>,
 j-humphreys@ti.com, 
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH RFC/RFT 0/3] k3-j784s4-r5-evm: Enable ESMs and related PMIC
Message-ID: <zbj4zuhu2sn6bteabibim4rpleb2wskofcalz3elly7ufzkyl7@3hsj7g4r35ih>
References: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
 <a47a1830-9c06-4b59-8b44-2c376503bf91@ti.com>
MIME-Version: 1.0
In-Reply-To: <a47a1830-9c06-4b59-8b44-2c376503bf91@ti.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 10 Sep 2024 14:56:36 +0200
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

On Tue, Sep 10, 2024 at 04:21:32PM GMT, Kumar, Udit wrote:
> Hi Andrew
> 
> On 9/7/2024 2:54 AM, Andrew Halaney wrote:
> > This enables the ESMs and the associated PMIC. Programming these bits is
> > a requirement to make the watchdog actually reset the board.
> > 
> > Note, this relies on the linked devicetree changes to land in Linux
> > first and get synced here, otherwise the board will fail to boot!
> > 
> > I've tested this series (with the linked change) on the k3-j784s4-evm,
> > but not its sibling the k3-am69-sk. I'd appreciate at a minimum someone
> > to test on that platform to ensure this doesn't break boot.
> 
> 
> For am69-sk, I need to add esm node on top of your patches
> 
> Also, as commented in Linux patch series, boothph is enough in one child
> node
> 
> with these two changes , tested on AM69 for watchdog reset.
> 
> 
> https://gist.github.com/uditkumarti/e5666b5623c3a78e23548fbfcbe813c8
> 
> upto line https://gist.github.com/uditkumarti/e5666b5623c3a78e23548fbfcbe813c8#file-gistfile1-txt-L28,
> Patch added for test
> 
> Line https://gist.github.com/uditkumarti/e5666b5623c3a78e23548fbfcbe813c8#file-gistfile1-txt-L1385
> to see watchdog reset action
> 

Thanks for much for testing, somehow I mentally foobared the existence
of the am69 specific dts in u-boot :)

Let me incorporate all your changes and requests for v2 of this and the
kernel side of things too!

Thanks,
Andrew

