Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CEA60A3836
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OVAn5crE;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HKGfuzjk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CECED8126C;
	Fri, 23 Oct 2026 12:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aQI0jh5vsvfT; Fri, 23 Oct 2026 12:17:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F28FF812D3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792757851;
	b=sYH/e+C1cPWSgguCsi2jzFhQIkXodoAvoj7EcswWsFrk3b/FpxHoY+j5+QrRFbXPWq5m
	 twc48fXEHZK3i/UOIBr6coJcXeEOJxmJbH547OkayKLe1T7fju/QphidxBOiMXJumECdk
	 nIpfYbo1+04BfRYhhs4aQPUSpBwXzebda8Ww6UqYSMM3tgmrSsuLYLki49XZRlJJ4vLJl
	 Gk/cfI8KDnEkyoDI0WLYKlxOGJgANJ+akFUj4LDdJ4miyRC9MrEeR/MeGSuRqsD5qBEn/
	 Smj8xCSI9SZ5Sbt1bVH0nHpXhELCbZPDK4TtMIJmm1jRyOoX5CAP2EorsIjlW8cGFPg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792757851;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qvYaesFfCjbYUimsTkDnUnj0T7D+hTLPhWmUlY4l4gg=;
	b=EOCwRwuVZ0R6Bl8jqXVjzA2T7GM11koCV2ABHrTdo1Xp425jui7ARMswmb12afZXdNhV
	 1+8w25WBNZDaSDIQLnw/AnI9m1vcy+RgofUCm+Q6F8JGrzugwfHr22j7OvrbcRJqApIoG
	 w6sOqpoJa2ZRJY2No0YWsK4OI2Mo/WOOhcAnbKqr7JveOrKCTeL5p04PjO6iGwPFOvyOO
	 r3K85tUPuHX+MfeAiRR76UrHXJTh6AAlU1HltZw0L9LEubXJwUAKKLwia0iHMyHLz3FlN
	 /GnhbLW3/PtuQKaCh/NjP+xEtzgpqxjxh9aAOsDiuAN9yU56XaqB3yQs+jVI21E5o3w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792757851;
	bh=qvYaesFfCjbYUimsTkDnUnj0T7D+hTLPhWmUlY4l4gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVAn5crER48/Yif5+BrHfAvGw4a86KCqQce3hvLb5gj6rf5pFMP91/GVjo0MUk7/s
	 /1PqftB+xCRjBkbTSChzhFcISyOi96wh2yQbBtgiMv7t+OuTOld0LiHYCC2DLB2mVg
	 Xv2w6GMAo80TjLxye1/lXAs4SOAh0uyTi+pHHrlvK8j2GQy2CC2Q950uapZzoVPb+B
	 vyO5nXrVcNnzrvuVcyu137hxB+w4ChJNSZJJ3jDvWyoTw14JNqzq7Jnvv5YfAYKTuR
	 oO7iorEFH3QcF6dM4lxb5/lzc6+ZbtVyOt4mZTKDl7+XXJPOa/Uu/s927I/gcvfarD
	 KNH7hIJWH6WgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F28FF812D3;
	Fri, 23 Oct 2026 12:17:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E022235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F7C16065A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u1jfx0spLZxS for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 12:17:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DE786068D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1132"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792757848;
 b=RHS5JLcrJdUMdG2BTTkONixF1ooRXheOQB7SoYD0+iq0wBEpRlO4JEt+eqgj2YJfyXMb
 jvpqM0gy4yyfg/6Uoijvh2FPwDmuHKqI8PJLe/8FtWHv00HWLQ2PPRfuLcODSQ6SJ1XsR
 lV5lnNn21UsnJzejfqmpDQOK3S8EPswgp4S0jWdl0lXU473SK8t4eD+yI4KphAgl7iwUE
 dCw3OAH7rr/qwqAhVNpCJsvJyONbpo5HGIlo0hBfdaX+VI/f07BTihoDycYeZuB9GTZT5
 a/Q3JBI1jqeO5SwactWPszJsRVt1Sxan5E3U69bYDSecx3+5+0k4xIv2WvJWyCF3gmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792757848;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=qvYaesFfCjbYUimsTkDnUnj0T7D+hTLPhWmUlY4l4gg=;
 b=CtvJK9uAZBbIznGfmv95dWBZbvdsQLvJ811Znj6Sgd9mpAdrRdjF1VxShl+0TPjRjtg+
 QYT/+9kAsP7FUKMOvVWWX2ZfJ2CwE3VBwtgQdJ9wqVbxicwQLKtdOgWz7Pk511RtquZyY
 Zm5XevhVyPJ4N2c2KiNX39gdpj3VibYQuzlx5iHPGZFQ9T2nGABSmAetx5ZuqAU/YZx8x
 09fN6f8yq/KEJKNGHJvoxphz60VLySZl6I/xlaD6tLabwE60QEQd7SLGoM0+pw9o61M9c
 IB4O2v43BQQFkLKzVf0nXju++Ww0RPbEX0wJz+p52rnzMfb3re8HVHYdP4iz8pqFSNw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HKGfuzjk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1132"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HKGfuzjk
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0DE786068D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:17:27 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ac525c1f05so7424337b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 05:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792757846; cv=none;
 d=google.com; s=arc-20260327;
 b=cmMOuCP24Lq0JKfrcmkzkJrfKSp4NHZ897kJiXq0hwbArtfKW1rUNGoazcICg+fvmO
 cklrevba4b6cI3tSYfo8qqWoFtJEz8fbyiUhAXZBO9GwlG4AFl1vqXqsiMRibxiTs6Cm
 +7vD+eF3EdXfQBV+K4rO6x32R+H/9W1mEeMC+i+npm4bcgbLVncAGaHOV5n9vEmW4VVx
 ydqKJCY2u/O0xRGfZLC3LxX4GCBfEABbVXLdeeypnWWeTmUlM+J9CM34HycGX+Sz1n3K
 /FazyTe5k25RjXBAKMjOfK4A05ln3Fy7kDdoAzkXR1YAGJnv9AWyuOfzRnA/Z0NMI2Ep
 US8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qvYaesFfCjbYUimsTkDnUnj0T7D+hTLPhWmUlY4l4gg=;
 fh=+zv7FyzppT2ufRQjQfxjov2i+hGK5twUOgak4PBWBLw=;
 b=qNvRhX54GrVX8rNThAs6MaiBq11RFdf2PhfXrvqWbtGjV4dOj1KZLstPeZdgAf21mk
 e1aYVCQvJZ2bRJ092jUVm78T6r8t2pwQYLgKxZG3AeLJBIrefzozSJaKlBltEk/YOYpp
 jKyx1r/2JOnJJGXNzcO8UXyDgLBUKlPwCmXMqMVrzPImlc0VEeddlWfj4K3vSrXUXD7r
 uYGuEs7ptON+/2d+bwgv61PfldmnwSi/gENMnP+I8HETSmHuPAg4kHMxxB3luWSh70JR
 SGjxKUPFpL/bG923no1c+HPlIdDH4yZBR/AwESQ9UmbitDqYhHOCZZiF9SGoAClRniIr
 TJvQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792757846; x=1793362646;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qvYaesFfCjbYUimsTkDnUnj0T7D+hTLPhWmUlY4l4gg=;
 b=HKGfuzjkwvn2oi7ojlmpSVOuzKdeR4zmLEpK1H2xAoYmqdEn83y4tSevNzbEefnn6w
 OqCT3le3qgDqcuhY/fwPGTbmlWJdWePWdg0lkTycYFOWGvuhhYOmEfV7T/VV2Fum9WJN
 zabdBQq3Jp3FhzDMXrm6/tRxT0SMcK7sUmUZlN11eh4gB+eVofnEYaT8M7NBO9UrQWYB
 6qR9tjiC+veFT2I8aJQyL5laizEP4MxxbBhE/9hxQEm1su5bpHdVCqW5xKin33D+Kgvy
 fNUDHJYdZKpenP5pcVe9L67futHmtKQNvyqJ0grtZmM2ZPJIkhVtBI5WvPo1PpALeGLB
 dlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792757846; x=1793362646;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qvYaesFfCjbYUimsTkDnUnj0T7D+hTLPhWmUlY4l4gg=;
 b=E50XsHSvlffv00SvL2H0wYEf+FYGebffS70oWlj/NIDtptHXdUYXPGLCQ21TjzRnLr
 InErDtUhDfcBBk5/guNIS0uQDFPNW66wFziMao1T8ghXVEDZ12RoV/HdOQ1eJZ2O2Mmt
 uNs5H0O5iCNY0YZlR7aqHR3ASzuZ9f5lkFea2rHyGpphdKjYQML2ysHfSWoxLwU1CiCe
 dVJHd/BPrgQpslRT/E5R9kHKis1/T9UzIOl426N7R8v0mB6tAhgPN7mGOvI6vN2ro0t5
 52/RC2MgwnB/UjWO+DmVXf8eUJhFFMOmBJDbnHFQfYC2B+rnLKrTHobfHkL+5LvrnJA8
 aJZg==
X-Forwarded-Encrypted: i=1;
 AKwUvByjVkL0kCH/CuZQ/Rl+6ULZyUAsDFGOlrGYd9jg5GLTrwoSgeudvzGoeAa1M/n4YG7c3nahkGU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIV3QM8SRHFuqOhpWUFXiSTlYFMOJheQD51DtXEXAxpIzKFwchw
 cEXAHJhlU+3JrYFf91yfAC4VO51PLnzrXXQ/opjCyS6UnxTRj0BdhdYv21KWUXQDn6vfe8rDSsv
 yL8kGUMHbH/H6YekR8/cWWuRaXwqcO+uFOapXB4ak9Q==
X-Gm-Gg: AYBFou3YPgdGLCUuqFwEA3gbTJXKhffnWsC89SFvmjaoFzwoqu5UeSqGQp9G9qAN+tm
 rEeFwNtrfCS9lcUtI7CGUnEQvuF+DoK3vcx/vfFhbhAljqWq9yNuXuXVpTd9/ARrlHn7EasF2hT
 iEh1FyTVv6oQErjTNLlDarStsaz3c/7F3XEp+7dBvewcm6biIO5k1QL48GFdqGgjtBHndQ0bLdE
 edzoFrycUR9/w7dDXgccjPbHfYSTv3ylOsYPOvcluQiQ6PSwhoLlg+MILFPu1snMNKjsLTjg6VA
 Nm4u6ququX5KAZIee2gGc9BEX2FzeB6Dn/EcTlfSbIhseNHNumR2PC4m2hOWhdeYmSPVcTosr6a
 zSsyNscqScJ0X84M6hkQZNXrxnG5QOM2qu9RDUHSJ/9C1uK7MUkF5bqJT48q+OoMe7g4venavXD
 kpvXb63PjLmN0mBAojmlB/nePJMOru08at+T1o+o/NQT8JAXOSKQRJbaplew81oj2OIE7KEpHsk
 d6pdJn6laSp2YU8f/Jq6hS4UwDSp7Z5VW2HyzZ7Q0DsJyxgOAurh10ae0kdnwFG+g3sPyOtEecn
 mxJNDnSAaQX6Mykd3v2xBFYe6yr7FR68sEbaEpJITdERsK7Z7obj1RNtsDaZCKHHWXGfmJHNL/y
 3mK9wVIcowCu85FefSQKH4yBNumul5ucujDJauKPvvx9fjJT5478k1UTtNZM3qbb09KbFg0sMlC
 DimWij8f/f+TL05h8ARk8tHkfgqYD2sKo2tCg=
X-Received: by 2002:a05:690c:6987:b0:8b1:4267:3ebb with SMTP id
 00721157ae682-8b157d99739mr17460367b3.42.1792757846103; Fri, 23 Oct 2026
 05:17:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022235602.221357-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKOd0LSgJhAxDE=emrzgn7pW8CygaSCPSvkK_nyzYD7Lw@mail.gmail.com>
 <81cfd720-f3c2-4807-9fd8-867d465b755f@canonical.com>
 <CAC_iWjLPxJ=TV5RtG0yGLSuDyN2GxsVPiJrHE_k6OCKSEoX3Zw@mail.gmail.com>
 <4ce18a5c-45c4-44a8-815d-e54df884499f@canonical.com>
In-Reply-To: <4ce18a5c-45c4-44a8-815d-e54df884499f@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 23 Oct 2026 15:16:49 +0300
X-Gm-Features: AclHuK-R8OH_9XT018ZAAMvjj6kNkDJQFc94b2d3TPavpvSYDKvrSg5l_DNgWZc
Message-ID: <CAC_iWjL5WdG1vxMtJrrwFtj_oq1LHQxg-SrcBQGTfHOf-dNnag@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: fix HII GetString()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

)

On Fri, 23 Oct 2026 at 14:57, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10/23/26 13:39, Ilias Apalodimas wrote:
> > On Fri, 23 Oct 2026 at 14:19, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 10/23/26 09:25, Ilias Apalodimas wrote:
> >>> Hi Heinrich
> >>>
> >>> On Fri, 23 Oct 2026 at 02:56, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> * Add missing parameter checks required by the UEFI spec.
> >>>> * Return EFI_INVALID_LANGUAGE if a string does not exist in the requested
> >>>>     language.
> >>>> * Handle querying the string size with *string_size == 0 and string = NULL.
> >>>>
> >>>> Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
> >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>> ---
> >>>> v3:
> >>>>           Update commit message to indicate that parameter checks are added.
> >>>>           Correct a misspelled variable.
> >>>> v2:
> >>>>           string_id == 0 is not used by our code. Return EFI_NOT_FOUND.
> >>>> ---
> >>>>    lib/efi_loader/efi_hii.c | 34 ++++++++++++++++++++++++----------
> >>>>    1 file changed, 24 insertions(+), 10 deletions(-)
> >>>>
> >>>> diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
> >>>> index 90dff91e5d4..47325f7d8aa 100644
> >>>> --- a/lib/efi_loader/efi_hii.c
> >>>> +++ b/lib/efi_loader/efi_hii.c
> >>>> @@ -910,41 +910,55 @@ get_string(const struct efi_hii_string_protocol *this,
> >>>>    {
> >>>>           struct efi_hii_packagelist *hii = package_list;
> >>>>           struct efi_string_table *stbl;
> >>>> +       efi_status_t ret;
> >>>>
> >>>>           EFI_ENTRY("%p, \"%s\", %p, %u, %p, %p, %p", this, language,
> >>>>                     package_list, string_id, string, string_size,
> >>>>                     string_font_info);
> >>>>
> >>>> -       if (!package_list || !efi_hii_packagelist_exists(package_list))
> >>>> -               return EFI_EXIT(EFI_NOT_FOUND);
> >>>> +       if (!language || !string_size || (*string_size && !string)) {
> >>>> +               ret = EFI_INVALID_PARAMETER;
> >>>> +               goto out;
> >>>> +       }
> >>>> +
> >>>> +       if (!package_list ||
> >>>> +           !efi_hii_packagelist_exists(package_list) ||
> >>>> +           !string_id ||
> >>>> +           string_id > hii->max_string_id) {
> >>>> +               ret = EFI_NOT_FOUND;
> >>>> +               goto out;
> >>>> +       }
> >>>>
> >>>> +       ret = EFI_INVALID_LANGUAGE;
> >>>>           list_for_each_entry(stbl, &hii->string_tables, link) {
> >>>>                   if (language_match((char *)language, stbl->language)) {
> >>>>                           efi_string_t str;
> >>>>                           size_t len;
> >>>>
> >>>>                           if (stbl->nstrings < string_id)
> >>>> -                               return EFI_EXIT(EFI_NOT_FOUND);
> >>>> +                               goto out;
> >>>>
> >>>>                           str = stbl->strings[string_id - 1].string;
> >>>>                           if (str) {
> >>>>                                   len = u16_strsize(str);
> >>>>                                   if (*string_size < len) {
> >>>>                                           *string_size = len;
> >>>> -
> >>>> -                                       return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
> >>>> +                                       ret = EFI_BUFFER_TOO_SMALL;
> >>>> +                                       goto out;
> >>>>                                   }
> >>>> -                               memcpy(string, str, len);
> >>>>                                   *string_size = len;
> >>>> +                               if (string)
> >>>
> >>> This is always going to be true since u16_strsize() include the
> >>> terminator. It's a nit so I am fine fixing it during the merge
> >>>
> >>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>
> >> string is the pointer variable passed into GetString().
> >> The value of string is not changed by our implementation.
> >>
> >> The UEFI specification allows to call the GetString() service with
> >>
> >>       String == NULL && StringLength == 0
> >>
> >> to retrieve the length of the buffer before allocating a buffer for it.
> >> We must not call memcpy() if string is NULL.
> >
> > I am not sure I follow you here. If string is NULL, aren't we exiting
> > really early at the beginning of the function?
> >
> > Thanks
> > /Ilias
> >>
>
> For String == NULL && *StringLength == 0 (I forgot the * above) the term
>
>      (*string_size && !string)
>
> is not true and we don't quit with EFI_INVALID_PARAMETER. Instead we
> reach the loop where we look for a string matching the string ID.

But in the case you are describing
len = u16_strsize(str); <---- len is 2
The next if check will succeed since *string_size is 0 and we will
exit with EFI_BUFFER_TOO_SMALL.

Thanks
/Ilias
>
> We even have a test for this in
> lib/efi_selftest/efi_selftest_hii.c:766ff.
>
> Best regards
>
> Heinrich
>
> >>>
> >>>> +                                       memcpy(string, str, len);
> >>>> +                               ret = EFI_SUCCESS;
> >>>> +                               goto out;
> >>>>                           } else {
> >>>> -                               return EFI_EXIT(EFI_NOT_FOUND);
> >>>> +                               goto out;
> >>>>                           }
> >>>> -
> >>>> -                       return EFI_EXIT(EFI_SUCCESS);
> >>>>                   }
> >>>>           }
> >>>>
> >>>> -       return EFI_EXIT(EFI_NOT_FOUND);
> >>>> +out:
> >>>> +       return EFI_EXIT(ret);
> >>>>    }
> >>>>
> >>>>    static efi_status_t EFIAPI
> >>>> --
> >>>> 2.53.0
> >>>>
> >>
>
