Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB6F606A319
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Imd79gT9;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GYa40tOV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DAD780E09;
	Mon, 19 Oct 2026 17:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jiO3nAYniNEW; Mon, 19 Oct 2026 17:04:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C63F080E0B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429458;
	b=Op+/8mxLQguyYWYMXHerSmG+jAX/6fAlVuiWWwyf1ndpAQ62OmooouvIWctSw++XBd1Z
	 7cymtgUzIz3vn6J5P3fbty5ry4tUpFquOhAboEOzZPlEARY6n+kxHl/GZlNwdnoCVnTS2
	 Crz62Ft2UkH1XcSGmyF1lueP3zIet7qbXKKezdp/ji9RYzLKGx32yfe9hozFqxJ4gpv+z
	 89EhJyONYbNDPV7qp381PIUreE8kcbdh+QdwGLP05leVYUXs9Ll+dZi2Ui/p5pAF8dXfm
	 EeMy4FukZtmtl4DFWZ9dESRbqt2ElP0JmQW2BwB60e4akXG2fHosvob1pbunLAbbSPw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792429458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gL6Ql+CgTGLP+AbtgwwUnSRUX/8z/y+rL97eh0b6tHc=;
	b=a+Sb90F/u1RkxjnS8rxQz9JntRshD4d/ljqjaawvWc0pjlD4AIlfPbudY6xEaJnwE5y3
	 r3f1ZWqYMjXsoK+V5tu6B5JefD/tfAhjwHCuF9W6PfqqBsKxRazajSW0Moilx03lJd20b
	 xQiLmAO1w7aoWJF8ETg1eRUxDdCHZcTFRF1R6aru2e1p8RP6LlLb+f798yUJF8Fe4Ala6
	 Yz7vozY6wligBMKqI5+n98CW5bGEnjY6rknRqxEdI9gLJDRDLHbWNVAbGrOy/aKV5qU66
	 vJEnUOr699Wz9QtYzJb5LLTyn8bYpdVH1QudooVgOxol9LbMbbye3A55o9XMlib3ROQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GYa40tOV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792429457;
	bh=gL6Ql+CgTGLP+AbtgwwUnSRUX/8z/y+rL97eh0b6tHc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Imd79gT9qnih4TXRyoxVinGwqMpwGITKGYfaO/3oAGMRt5q9TsqehbYAh2UUIcGw6
	 Kb4s6RwNaI4zYAwzzj4nEHXFhEeD8DnpN3DizcxcsET6ShmcEmLmxtB1eG4tNUZ9W7
	 oNfhA3XExIgtOrt0r6TDh6pYhRYLd8a8l/7SqqNojobANMArfUEBWdd3CkwE9yoSp4
	 TRAgfXeXWeAZWhYkNQb59/p2QhD7jJfOFU6pmtxOFkxHPw5A65RsYHJpAeze32hKmg
	 iUUINKs3bvrPa/hsYX4lFNWNCzp2NUvIEzG+BwtZ05N+XBlSb1GJUIg38Sn0OFFU+P
	 vKy78nDVjuLhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C63F080E0B;
	Mon, 19 Oct 2026 17:04:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E3B0F23A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C959980E0B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KAQPVF50mrFh for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:04:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFD2380E09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429455;
 b=qq3aoyYcyYDPeQr40w8YxlDMR+RKQUjvBd2pRv4YYst/o48f6Tje5ot0JHM+JlUaymjD
 IJL/7BQw8iCBbCQhWfBWjOggxSGlOFoCmXUMtTYir8mBXKx9d+FSQRCiviHE3wn3toEI7
 VCC5bDOHxVT41cnJYta2Up9A1P86PhmRd7cuDxglZFB0J8MEE/UsL/oodJMPiFxiVk2wq
 YZQAOFUJvyla/LsUdQMVsSaaJiDz1KROIxz10d8q9xX5WidUt49QKAXJVlSdRdfVI8/cc
 XZ0Z2csZCEM0CeugbQZneBaVPqRBu4R63VqJbeHoj1ZY3mQ16KIuGceTy0Sp311YMOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792429455;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=gL6Ql+CgTGLP+AbtgwwUnSRUX/8z/y+rL97eh0b6tHc=;
 b=bG4n4ry344O+LwjOQBK8hsahbicJwNw3MXlX5rg6WKq7+lVk21w+zhQNkcoTr4NuxD3x
 WwjMpnLZLTkx7DrWXwt5XaNQmZDQBarIaJfngGiBONjlguH/nmr43zWLQl5XyDwKB5bdf
 9ibwPHHrf5gCyLfNxE08pVfkAgdYUvxg9mD/dpxelifQD7O6Kq/1LE0BAPqqzxl3lHLH3
 7esX2NpwlXQJys/nPXpREE8PExpcv+4qjD52b7gq9dAf92qhknDoXTb9DuxRJzhRxF/ob
 TG91FGrU3GdB5GC1JtPFqLQh7vxHsaEpVzYObamMS4g7hMyjygmNS1KDVGNf7/RF8Ug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GYa40tOV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GYa40tOV
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFD2380E09
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:14 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso2694845a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792429452; cv=none;
 d=google.com; s=arc-20260327;
 b=sT6xq5GR5Y64O+ILmai6N3XQp9VusrUBSBkrcU66f0mBDbmUfFXiIAeVqUJMfV8wlT
 rqpvwS59rpXZocH1T5+Vn3mB07vr9Deniu/t1St7vILszA5Ss7+kTiU10nkwA8im9CMS
 jSGusNCgIDECzmdJSsUpnwnmiSzxgi4brvE8Iep7S5kPiPprBiGYycQHLu4w0pA1WWa5
 9vJNgOSu7wOGpzE6voGPKUJv2z1lUi6q6B1ygEXdJ82e96KZYO131Sn9iNUiaBnQEqIN
 +QOq2Cfv3ue9x4Wj3PdRTU+4Fj3rbD3F7xXFBP9YCMHcW+21elolcu+C8UgbpPsngUnF
 9eRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=gL6Ql+CgTGLP+AbtgwwUnSRUX/8z/y+rL97eh0b6tHc=;
 fh=sJOgQRMvFtrm04UfzvYV67DzPWSXuzSPiZZ+dzZlJ/A=;
 b=MjvmcvtSOPwxtUDP4cCQxhJEDjR8GmNBC5jRRTY6Z16dIcTaonkRvpf7bID7cGLxRH
 iA6RpY2BwPaxDu7PAt+W6HuOnnGGaTOOGljyZXbbc1oc0q0BTC67eEaLi/U75ijTqAGJ
 gEYgL3hHVe1KARwLSZSvaPOXQVqqZACpo+Vrv19jm34Ez4TWjuYF70I/8ilxpx3uIKNl
 m+361VgAjYg2yHD4SbfNuRJvIxY7BV1ei4lj2G82OTrh43rQmNmK3432JJsmgeLqws+m
 Xm4x0ixmNBqaULQv6IxzEL4qJX0VfaQ0r2ZPT1LGupbPaPRUOZOB6uYOE1Nh1c2gQvdh
 g6ww==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792429452; x=1793034252;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gL6Ql+CgTGLP+AbtgwwUnSRUX/8z/y+rL97eh0b6tHc=;
 b=GYa40tOVk33/wHKQsDzYTlDifFMEvJElcEkJonIg0ZchBGLEtCDsuoirhQ9bYhwPPX
 Yux8EgmrM87bLtGk57p11HpPc2ZlrCxNgig8AB7A2nrNbht78ElmVNzxbBmwi6lZPT/Q
 kdhpmRoGCSZpmtw3hE2wBNnKfggk2dE4i1b1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429452; x=1793034252;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gL6Ql+CgTGLP+AbtgwwUnSRUX/8z/y+rL97eh0b6tHc=;
 b=JhRhrlRW8YzwheA+zNm9eBT1486hp61JAesv+5IyLs+ihVJ8qRzPsilVHZJOE8RA3R
 U4kJnIizUeXGNhkVvOVFyKQK++pOYJO7FL3nqYXtA7C7K+4ccIkF2u1FwAAp8U5Etlsm
 Zdtv2qhgVGdJHaUBdZZGFAcGHRvbAA47c0BdDrG8aBnKBHsstGv3kyFRw32WOmtGBnhp
 QwgweUZkY7fNU3s+Izk4QwsH15GzSDmM9Rof5xxkl5oXfUZDgrLlytBh8SYa/Asv8s65
 pnRflGO6t8i7ir25gfk2nWSgesni/0S7dgo08GICVdelHms1VyKMvR2ixHyjb+FKZad4
 +ZIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUgzOAC+2bgnqCsmvmffW5+xisedFSQ0j9BXVMRg9DkMR7pWPzYIqn2LRFxMNybho7dfRt+Tc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLquJsYy0QBnUP0Pjud7Imwl7PmxDlUp1oL4EZjeXN8W5oVOkon
 +7jVrsmIzZneR8dItbba4c1NT/qvhaRT+bZ0d+02gqT07qeWPfGIssQGvTC9sABbowG+TKFhq4j
 nz/sq4UXnzYx5cAXVQ7vIM8ZCo+JHB4ADXYR7ma2l
X-Gm-Gg: AYBFou162nuvVdq2pg+6xIqG82eBGemOwo16BPMjqyEJdz+9qqmSqcQMW9fv3fUmsS3
 b2h3Dy+rzeIjo1tcx0qZtJ2XmHSaKjRfgixYZfQ2YnJnKJzRqmc2gK4vCFTo+jGPtBro21Y9JPO
 LWBxFFXo8Al5xAZxNT3SmSqTxWVhO+VrHQeDh/Z17hxAR+MpCIW8jnL6oIkQegoRtuUKpuEwr30
 gkfzXEqbIPJco2d7gy7YNDeie6N8ZsAShU0wOfpiE0avf3gRMJ8n6frbeoyBQ+d//XvlGCA7V1H
 LwoxVxMjylc9Wvjq/n3A6/bOwR3NJGftsxQzwrNavAAYZzKPtMsmz5BKIkMlxkVnJZefSB7fj2r
 bUILOXu8AhArTqJ+KYsGFO/jlJsRH1xj+zbU=
X-Received: by 2002:a05:6402:21c3:b0:6b3:b84b:683e with SMTP id
 4fb4d7f45d1cf-6b3b84b72c7mr3395474a12.45.1792429452208; Mon, 19 Oct 2026
 10:04:12 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 12:04:08 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 08:20:18 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072526.2277530-4-mehmet.fide@gmail.com>
References: <20261016072526.2277530-1-mehmet.fide@gmail.com>
 <20261016072526.2277530-4-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 12:04:08 -0500
X-Gm-Features: AclHuK9tMJsohFnuOChaH-e69oOtisBZrdjZyNugL9VLgKPP4YWRHk5ah2ydLXM
Message-ID: <CAFLszTgkKdhzJ5xb=K8EpCrcD_-U3XrY3cbppMRhT7qEPrAAmw@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] usb: ehci-vf: remove the code path for a build
 without DM_USB
To: mehmet.fide@gmail.com
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, 
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 mehmet.fide@screeningeagle.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-16T07:25:19, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> usb: ehci-vf: remove the code path for a build without DM_USB
>
> USB_EHCI_HCD selects USB_HOST, and USB_HOST selects DM_USB, so the
> !CONFIG_IS_ENABLED(DM_USB) branch of this driver can never be selected.
> It also cannot compile: ehci_hcd_init() calls ehci_vf_common_init() with
> one argument while the function takes two, so the branch has been dead
> since the controller was added as a second parameter.
>
> Remove it, together with the board_usb_phy_mode() hook that no board
> implements and nothing else calls.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
>
>  drivers/usb/host/ehci-vf.c | 49 ----------------------------------------------
>  1 file changed, 49 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
