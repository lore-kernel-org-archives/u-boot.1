Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A76D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 13:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FD8283AAC;
	Mon,  1 Dec 2025 14:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S6ZXddUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6220182C7F; Mon,  1 Dec 2025 11:06:23 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B45BA83A8E
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 11:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso43129225e9.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 02:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764583575; x=1765188375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fl+gxhVU9ZqonFGD23UXv/OTsDBsoNvjGopaDxdNYtE=;
 b=S6ZXddUHOm4AGpNE+v4oumyG5X9QhcxQBm0H+H55aiakkOWLq9hpoZDrWPO4wRTrHf
 G+xtcH+g94NkExe0YkUienvpX09ASifI3n5xwzllslIngICHeBsOb1fS1OYH5PaD18DT
 uIrYhdRp7mUg+P8E4H93bsXDltyXMHu5HR6aRH5lra07pyPD9ehER5MPZfR3apyOkL0v
 A3oa8FkFRWr8HypU1P9aWewmkApCh2DmZAuLf5AGTDplfS4TazUc0ynsjtoKqSt17Bbh
 9CO4/LMEQoGOKJl78nHMTyKprczU5TumXdb2Y2sUNAGWW3JKTjWFO5xlEwWZ+QHy3Jx/
 VGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764583575; x=1765188375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fl+gxhVU9ZqonFGD23UXv/OTsDBsoNvjGopaDxdNYtE=;
 b=jXRqPFhCIwjJIAWw9X8dYjqo0M1xJibnvm+JcQ3OYV289U3j1DdyVJR0APMoNTLJ61
 kdFMLjSlqG9ejSrHMe+BqMbKyWOBfgVv0QjnSGPkzeqv2odqB9hvjKPz9c1apJAhoNtC
 8KSBu57v93rQ94QYSN5lzebLf9ZCA3JsWta4qusBdOhyq/N4gVMz2e873TwEtpXh7PGV
 uaTYFBGbEWdF9vsQ8/EI89GYLM1IRcYJ/cyuh3dMWkSxZ3IKM/D/whUtiQ/n0JpoLq5h
 9IOdbmSOcrVlyxfCybKJ/RZ28YXB8p/dTazqaQr4awew+wFIphW7klNVVtx2asLunMb1
 pJRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv/UdkvzXBOr+czafMJtrDcvQctroAYC5CmFbDMfYaZftMOECvaMbRu0ygOgcys/UjixlPRfg=@lists.denx.de
X-Gm-Message-State: AOJu0YwK3j47VYSZrogM6muQIXeTrHhGYVtYkPEI05/bMjbh4SaCal26
 TEqnneA0t30wG9J9kbHIaZ2GqQR1K8u2M4AnBtsoWyqrqoCM6XbWF9Dx
X-Gm-Gg: ASbGnctZdqbBUnw9hZfaj0rxjaEEJgiYedOqFW2Yp38peRh2k+jnH8K/tnRtD75UrvB
 oLMEGJ+A+vFK9Uht0pAo7JxEIGijEgInHwfw1cra2CAXOZevurQcDvD91pF0Y3LmBKcgtiofeid
 0SGgCMKhmfG0OyCJJhkR8lgAXvHbMeVT5t82wYJWMKVrfQuLsJBBZkZfOEnurNNdKWxXN9h313M
 nNkS22JcERxNkkcjLi2Mnhp3/vzVBw2OGpn8wRI2Y0eao9PvyQcHaP3QpJULbvHdT3/F7ONIgmC
 LaXh4qYRTPfmYqjIG8EyJ9BHEIZ1amnU1Y31IwBCaA6qmqSjyGCHDrcvQfmhfom9Nb+VP3ZjuWO
 2Z7QlHNlwMNSKYVNPODU0UhpmIUJ5gXGGML5kKGwQuBcmuD6Iy4JcDMs+ZKcG4QN1NhnKK73nzM
 2wtY1rXDfsB7Iv84dIfFUez9NdDzipNbZ9r3d4HOAdM1dR5Ea8TsiB/MX6dWWfZ1jD9NsXe2kFO
 2TvELaNB4qWlg==
X-Google-Smtp-Source: AGHT+IGV0zLjkW7PukLf7s/rHeIkVdvQOYROwnKevxJNSGuQxeofuE/nFvyvHTf/JmtNorLpArJ8mg==
X-Received: by 2002:a05:600c:4507:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-477c1136a43mr332035855e9.33.1764583574902; 
 Mon, 01 Dec 2025 02:06:14 -0800 (PST)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790adc6f7bsm309292235e9.2.2025.12.01.02.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 02:06:14 -0800 (PST)
Date: Mon, 1 Dec 2025 11:06:13 +0100
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Prasanth Mantena <p-mantena@ti.com>, 
 Tom Rini <trini@konsulko.com>, sjg@chromium.org, alpernebiyasak@gmail.com,
 u-boot@lists.denx.de, vigneshr@ti.com, n-francis@ti.com
Subject: Re: [PATCH] common: spl: Enable Instruction cache after relocation
 in board_init_r
Message-ID: <v765jwkuyzy6uiu6khy2vtvyhjeamvyu3ekzjaditldu4x6doy@grrzrdpkf5pe>
References: <20250317064507.1702120-1-p-mantena@ti.com>
 <20250317151318.GR2640854@bill-the-cat>
 <20250325053420.4wuenxmlnqsojuyt@prasanth-server>
 <n57czo3z2lzyarh22y7oien3b6vgyum5lt5z7xe2p3rrcktxpp@qmdmk65aagng>
 <4684aa54-db50-47de-a565-e529bde793d3@ti.com>
 <hkcauyeizj56liomndagywfj54u3qpm2i3ameo5oyt2ja2mnrq@kluwp7dalbma>
 <15b87b7c-ad6d-464c-8654-f8b31cae525c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15b87b7c-ad6d-464c-8654-f8b31cae525c@ti.com>
X-Mailman-Approved-At: Mon, 01 Dec 2025 14:43:25 +0100
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

On Sat, Nov 29, 2025 at 09:56:44AM +0530, Kumar, Udit wrote:
> 
> On 11/29/2025 12:54 AM, Ernest Van Hoecke wrote:
> > On Wed, Nov 26, 2025 at 06:34:15PM +0530, Kumar, Udit wrote:
> > > Thanks Ernest for reviving this patch ,
> > > 
> > > Changes in arch/arm/mach-k3/common.c seems good to me.
> > > 
> > > but common/spl/spl.c can not pushed in generic way, I can think of few
> > > platforms running SPL w/o caches on.
> > > 
> > Hi Udit,
> > 
> > Thanks for your prompt reply and input. I have now tested this patch but
> > with the enable_caches in common/spl/spl.c dropped, and everything looks
> > great to me. I will continue running the tests over the weekend, but can
> > confirm that this change seems unnecessary to fix the issue we saw with
> > sporadic boot failures.
> 
> Thanks again Ernest,
> 
> Ideally, I prefer to revert commit sha 52a86e69e20.
> 
> Adding more TI folks for any objection on reverting sha 52a86e69e20
> 
> > 
> > A v2 that only touches mach-k3/common.c would be suitable. If you
> > prefer, I have a patch ready that we can send. I don't believe much
> 
> Unfortunately, only change in mach-k3/common.c will not be enough to fix the
> issue.
> 
> we need to clean-caches at board_init_r stage, and which is common code.
> 

Thanks Kumar, I'm assuming the issue is that there are still a number of
instructions executing after the SPL relocation until we finally disable
icache in spl_board_prepare_for_boot?

With 50k boots over the weekend I can confirm that, for the AM69A with
our test setup here on a TI AM69 SDK, the issue did not occur again.

I agree that we might need to find a better place to invalidate the
caches if necessary, but commit 52a86e69e20 was necessary to not have a
1.3 second delay between the A53 SPL and A53 U-Boot on the AM62 as
reported on E2E. [1]

[1] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1217839/am625-boot-time-between-a53-spl-and-a53-u-boot

Thanks for your help here.

Kind regards,
Ernest
