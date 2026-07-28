Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BCFC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 697C1608FD;
	Tue, 28 Jul 2026 18:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vk3666pUnInx; Tue, 28 Jul 2026 18:43:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3FC0607DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264187;
	bh=k1fIS76xxU1Bh2uh5bvDdKTwutgXcPlyQ0vpsfMrmNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mTs64oLs/M6oYGQOdH11EcDX4Gq9GwA3pkl8JV3rYbak5STXFQFcAls7Gx6j6+2au
	 YU6H2k0nWtd9mVM7XHUIzlDBld9mTW6dWqYvRulmhKF0nmu/x6VYxqmk4v+sEbs0Fs
	 w0QYuMVcIrF+3vow1t7Z7KBkQDFLs+7A7OhZXJRXmLTjYUat1hXibYhXph5SCZ3opO
	 oiPg/UAdvBS53v9vvvMXjZv78Ys8Pv9EiJXRSqChUaHWVL9V30TIp6f0MnKPCF5J/8
	 FcP5e8HaFtwzBjDQJac16KWRYfiedAKVDdeOpJz/+pn2oL/QbVMEuh7IAvTD8GfAYr
	 1rSqX827vTSmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3FC0607DC;
	Tue, 28 Jul 2026 18:43:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 052AE490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 02AF540394
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dMvwSGCexl5V for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:43:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 297F44038E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 297F44038E
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 297F44038E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:43:05 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba3e6so120668a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264183; cv=none;
 d=google.com; s=arc-20260327;
 b=jiduZAP5dlU37dcADXuPlXwtG90VjG97zY6aS98LXB+LgkQswhaS/678iW44k1zQXy
 PubhinRlG6NIjvMo+CHhtAB4ORenKrAAFvGKc1+4298EmP3Fv2UexEuGm73s0HjSW1bF
 SIK/4UGxtLH60i7d2DZ+yN1wfNsMXpuRANpG2egSJFIewk4En7eusUalHIL6pL8exW6p
 JLI98MzL65YqeaSuNSfbN82EOqFg4kzA7IsEKNQxaAesIFoXyw1GoFbs801NVusbEAAG
 rYe6xZxvxTzGwnwUp6rfxDxIQH1V68Cs0QRmK93eLW9EKnsgUXTPM990mgQPfPsZi61N
 jVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k1fIS76xxU1Bh2uh5bvDdKTwutgXcPlyQ0vpsfMrmNE=;
 fh=3A/dMI2fMAPwNBntNUL542bI1nvKJAfW1Co2LgWuA8E=;
 b=nUV7a2BxISU5rtNO8+QLj2dYBBwwhT350uq8TwT0Cdtuqljs616Q5XbTWm/6hBZE6V
 iktR8Wpe3xnOIh+Ieiz5DkwJRfCwLvE/Jce6VMoXlH+oy8Myidy+RLBbNMFawHShz1nD
 /h/Pd7d0Hvq73sGUhNxVHcczAwvtJnLbg86MtIBZpTZL/FnLlZetlNEVrWue8vFTkWDV
 L9W5IpolgkBuSC4V6kUEs5vrvdu45b5IuUHxNhJFxCFMGtZMtWRXM8o2sVA/HaLoKtpi
 FrExVZjYGXR5JxVsZQzxMBjT0Ha8r2n72yyJcuvGHvsSxOE76yIka6ZGSsUsPnZyrfQQ
 biKw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264183; x=1785868983;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k1fIS76xxU1Bh2uh5bvDdKTwutgXcPlyQ0vpsfMrmNE=;
 b=Ph2eu5ASAlS7py32clc1nDVg+rHKsA2n4Sq5z6KpivKIK7v7Jw69JvKCAXZLIOMu+2
 cJS3pOFIvvDgK9dWv4GnMeNJA5zZGvK72Dx4lMQIAhUzedG8pFjkcOmLh6/0MiJKA44X
 zeo/i8M8tscKTLTCKr8QR8lYgmpt2InW9OqhbWw6Ft9u8KukPg7ienmXKZBMxmC+kisp
 sDswem1uWXMRDizGyr1i+CFAx/2JZyv3gXEEMVSRDOxgeHzMs/t0UCDY14iXivguEoX+
 zkbbUK8lV7hs1WptVQP9+Yarg3WhnrA7MuxmBza/TTlxyVxnTFKJ4F8uS6qyj89dG9I/
 bxcA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtAOc4QdPfJsBqiMMnkH1Lq6eXv5W9nh8eRORuBrNZm2txAly5bCNPFo9KQAbhQlieQaPrxXU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzdp/JxPabeymx4QixA/Yv0asfGmE+aB9ZLQsSdVzcsTqeS0Oqj
 yNDVAbhTk1JHwS33kU0nea1jdRQb0JhJ/5pAXij5k5XPBpOO6osyCwyxIYhIJCPe/Nnjwsf6hUr
 4rramntoydhCia403j3HixESm6dzPH5fZqsOT+JlM
X-Gm-Gg: AR+sD11i9+iV13hA+PTGW1C+QHeNgvj+H9JhDk7bWjLijCcRWxLLpD+peG6LTptorKD
 JvucYv9w9a7jllpQSOAKpbE05YByCITFPJq7625EWoXsIZTyzC2IDGAjJXqvj78kAfomAGgOsWk
 kVll7ABAFHMHMVK27J/rkIpamDZ0Y87etWB/xeKG+kaLCGZyJxLP2A6XZsrc/mIiK70ugA7uaID
 DtH5jwqVt+1jcvqbNvaP7y97vs3B5L7MHfST5uWUwpojEj8e++wvZiwbnhs
X-Received: by 2002:a05:6402:27d3:b0:69a:9355:d1c2 with SMTP id
 4fb4d7f45d1cf-6a034aa5ea8mr2022481a12.42.1785264183310; Tue, 28 Jul 2026
 11:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1784601041.git.daniel@makrotopia.org>
 <9268873181e9be314113938bf98c7541aeade92f.1784601041.git.daniel@makrotopia.org>
In-Reply-To: <9268873181e9be314113938bf98c7541aeade92f.1784601041.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:42:49 -0600
X-Gm-Features: AUfX_mztVa69FScoop_CwhJ7wVyv1jOjASnCM_XL0m1OlazXpN1c4wv7_2pF2ao
Message-ID: <CAFLszTj0SP0+JFCWDxYw4wx8csdseGFWzeGk_eSN_f9iVb44pg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] boot: fit: factor out node-path collection in
 fit_config_add_hash()
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, Randolph Sapp <rs@ti.com>, 
 Francois Berder <fberder@outlook.fr>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264183; x=1785868983;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k1fIS76xxU1Bh2uh5bvDdKTwutgXcPlyQ0vpsfMrmNE=;
 b=cTOzm3QA2GXbSzWP3TtCs6KwRDqJRnyFmh/beAA6EM0GczYp5/V032RFjXoZcKIGoU
 V36cZMTBItwRxmK/4zpy+KUqAQvnUuvWnoxAfJ0J61+ST6ZcRPJ4LxkaBf12UIIvToFM
 ggVECJRe7Nc7PBiSsIpKHEuB0sIQgdObglI0U=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=cTOzm3QA
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

On 2026-07-21T02:34:47, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: fit: factor out node-path collection in fit_config_add_hash()
>
> Both the boot-side and host-side fit_config_add_hash() repeat the same
> sequence to append a node's path to the hashed-node list three times:
> for the image node, for each hash subnode and for the cipher subnode.
> Extract it into a helper, fit_config_add_node(), in each file, with no
> functional change.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> boot/image-fit-sig.c | 73 +++++++++++++++++++++++++++++++---------------------
>  tools/image-host.c   | 73 +++++++++++++++++++++++++++++++++-------------------
>  2 files changed, 91 insertions(+), 55 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
