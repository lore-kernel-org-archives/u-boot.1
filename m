Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798E606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w/szqLqx;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ORUPUmln
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C5A740809;
	Tue, 20 Oct 2026 18:00:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9qo0GZrZqY22; Tue, 20 Oct 2026 18:00:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76B46406F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792519201;
	b=e9dhB+QEs8fECbqCh62HkLZnBcRqIKTVx/yYfX8Wm5hEjJRTVHsSkuFAn0843jmYaoza
	 q7dSPSwwpF97zBUIkAsVuxsAxNLpUV9CgfKppsjAqec2f78cxUK/wVeI83rAcWwlYdvsc
	 9Gw8dIr8v862fjYBhiP6I+4v3lCqSSOuOzWsSUDn4cxopoHoI8JRMrk32JfzXfjiPBkwY
	 IFz+m6wFko6rX0ZqUEsJvx0ciJA1qAsTZQQ0OyNxHo9VQmb2MdtYa621KdmG2b3+fWrJV
	 b+qUToAV+jUow0V6NL0oKPh/U8O3XdXLlKlELLfDL2fgvr7rBeQ3t2cRB31r7Jvo8hA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792519201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6M1nTEqu11leLoD7EDU1U8L/uh888I4EZtMZzwbRfZg=;
	b=s5HitEBl9DSH4g12I4RrLR4f+vwheUbfGVIgUhNjiz7bwS49qrN1wmRodeZ3T7LqaEZm
	 l1d2eSyFhnPo4fBN2tM7SQIaKsWe0Crz+2te0Ssg/f8wKL8ggFzlWBlRsrTdXSIZ0Gy+g
	 U1RJu9+iUxiRCPWDx4H0sAmtkrnGRxtefk2dbN0mM4uwPe0rb012hIdZ0gWTYWWw2GWX7
	 LeBBOlC3TlVBZdWf+7WtRVwXPkoY6OmN+sm475GAHPpR3RbaJPSlbhGsvTOEZFiui/LRO
	 pierxwuIWzvu5aF5+Zed0jNJanH2hs81qrEbSU9V+po52MiinhxnSAC1h/YBrKFfoFQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792519201;
	bh=6M1nTEqu11leLoD7EDU1U8L/uh888I4EZtMZzwbRfZg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w/szqLqxL4ZMPzRengCxL8Y/CtF/76i/6bKXxDw03+WJ3GvQaQHAn/YnUGZwHXQzc
	 QA7b9YimsJ/oUX0twVC7qyrWXADO21pTSVdUFWoKDjm08LK/5ucFYvLGsSWfh/uT7E
	 lOZKeMlK+IR/Z7Lo1gosToYJ5lwVFRmeNThGGVKexMAZ/xoal1Q++rO5s12BloB8gx
	 vCrE4hHeYLnvCii3OpEdExetEjb40Muy2CNqTNeOohgh3nTStogxwO/qE/cb3wobsJ
	 Q8jBoxaPsQOIQ5V2Aa5xvvz+bO8C+7rdpHyrPi8g/PoVKZhDpPEoxrCII+y1k2/3CD
	 KBNRzPIMhix8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76B46406F5;
	Tue, 20 Oct 2026 18:00:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA78B3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB22C6079A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UDxCv6_U20aB for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9FAB660719
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792519194;
 b=GO9A1pQRN8HAOs7rELUcgD+skpHbnBTV83tK38G6n2+KUtne/6+WZmbTb3wHl+wsWkyP
 Y+H8LaMtOxo07szKcSe7+FqjqdZJJV0qgURp0n6xaguNWQJCAvxT3Y+3cCgB8iJ6FPYSz
 kjD4gh1mstobv5FgPY+M5F5wVeWT/hrUpxNgT0Vy8f766rDM5K4S4Wxt83LitahoIq1U0
 ngGMiXS88jfV90s9WFlmhWZPONMpWk9UA3grzLKkpT5pdjBJioXUz/2r/A3tbmlQlZo8v
 aA9Bzu4+jByeYjBomDsRCAPzSzkUtvltGksw0wEiIdypFTmk9EiaCRIka9YyGqO4PnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792519194;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=6M1nTEqu11leLoD7EDU1U8L/uh888I4EZtMZzwbRfZg=;
 b=aZs+81O2n4LhT21JobkU4OJ2zEoXFn/AoIdpNNc9RYmcc6t2OANob+ugeuJaDP/BW9Aq
 C272WsaBA560PTI1tSpdnSJ0YEhuNYuLLElTOVUR6E4OZ82swW/p4RCO6jsPFtwhHq4Ca
 Qub7viKEIZpCnX/i9dVTPIXpJoov7DUGhw945gQ3XDG4FxXzkvSSNisEHdXzqMAA8rT/v
 SQz4rdRnfnqf5gIlqarsbL8BM3mR4sbRO+7iF8oUmEPdt3XoL/ZkyE13+PIMXvpYufue6
 ymY9orjdpKx03KFXSrTry1bHgx12LPiERsP/Ds0r6vAoaT+t9suN1mR/09Zay4v2ISQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ORUPUmln; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ORUPUmln
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FAB660719
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:53 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so169657266b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792519191; cv=none;
 d=google.com; s=arc-20260327;
 b=jSyhKCxBeY7sthbQh/YZuuiIjFmEI/Vldv2USEF9gJTBclNeby818JLxLKHq4ethUm
 WJXdi9IKiQ/VA0TQAuasotP5Xs/F5i1xnbfCYHG78/nPLjPEUgsRSx8TBYsy2O4dWPFJ
 B7Z4/D56Fuz4o0AmONaZ3g0vnZ2n44tgnr4uvwGlVPjwDYzHy/1/zr2eEtuoj5HUHLpg
 edtwuIsjruBCPUKBahOCMFMLqjXKFFqHIHNaIKHAb6pE/K67yAUUJfQt0K9Ifw3MjCkn
 iLsH+eu8Hd2iO1yUsx3ja3CB57h3inGmfXe7K5FkTNKo7hCyr2nxUqIF3ruTBuiDNCVY
 4t6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=6M1nTEqu11leLoD7EDU1U8L/uh888I4EZtMZzwbRfZg=;
 fh=Z98iJJAqvw5Wc/tQkeniw6jCkpkg7czAKKTnRfLDd34=;
 b=NcZSmFJlJHRNauri6aiZV1iiYuG63NWRELedWynxzHzh+SkSuhEjYK24hDQNbHlQM8
 I1eT4UqcytMpZ/Iqv7uyKmwyI7aLpnThKa9yg+C9GTdFybIdEr7iBqybKC/IwuyU6Hxh
 IEXUIiz8Z2JijgQuzEYLCRIavQCJ6nlH5Up5YH/NooPwkzGB6n8sqHjS5kry90SJMJHN
 kQkbZYdudHf5o8E2pIu2TJtY1fdSdCuv98ysJhUm7vk+rF8KmHGFmDULkCnD8tbxxRS6
 lhJJg133znKAJ7W50Pi+PdKQ+2A03d+lKYjrknBjdV/6z0mf3VDWQ6c+YU+GWJAM1d3A
 rqeQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792519191; x=1793123991;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6M1nTEqu11leLoD7EDU1U8L/uh888I4EZtMZzwbRfZg=;
 b=ORUPUmlnqGT1fFK8D1E42SVw5vWqQYnyvODsZdL7gNoM+tfvOEdZwZhuVl6M82pYZc
 JoB/mk80G1miXzhx8XiaqOfZh+QaIknBmxT7NKg0EuFRXjLKjj02K3dRtX5dvjvlIBYJ
 nWzng47wyj2M6ouxmBTwVLr+5mfmjB20Ffp00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519191; x=1793123991;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6M1nTEqu11leLoD7EDU1U8L/uh888I4EZtMZzwbRfZg=;
 b=ipaeKnKPG4dKEZJaZK5abupEYDQQXkXk05+StCqg9m53lmVApgm4kYQU8IVznE2qrA
 urtMvi7pDEjnNBTKFCfxicP9rOm5CqKEIQtxEKqFN7PnKsBYH37Wy+aY327Y0ZqjUwjQ
 Tsf1o5ESb7NihNlqjRpP1hn8ZQF4OQRW+QlF1qQ7uunIh56YxYYoAjFHDVLZ4GYiOmLb
 gul3faDVH3ymDRRcI5R2UH8R1BV7PinYjnjbv63kUx1IDhr/2hM9GJW6mN5ETDLO0aub
 gr8OBDA1icYNe9w1E33K+U/c4oLiRtKH0VDA55pZ+GqVofBVf5uwdUnm/+5V9+2E8MhP
 A/Yw==
X-Gm-Message-State: AFq9FYIEA2n3y+rYybuYJkKPWFl1tmIln6t9tWzUzS7Qt6G3wQ2OsgrC
 i+p+YmLvzKPxD21a5T0K2X4K047bD2F2qptgBwv4io8aJfVLBEMg1teoZz78oafKW/+wcTpZa+X
 sXjR3G3IQ/SvlPFno456j8sD3OMODHMdlja0frEI4
X-Gm-Gg: AYBFou0JO3hQm2IkYQnWWvByySvwdppFdCigdxfbXjwOzgVAGVlMjuaquQSJ3R2MTlP
 tom/X+xUCZY3CYaPkEB5+gM2QaIZ5cBWEYVUhW13It/O3m3ya2lBK2gERfhdYMbPadPClCf35w6
 9Kc2sPXf3K8P0jq1Avfo5ryz6WA7GsSw4agW7eMEOALfEV52YM8I3bBDQ7vHuVWf7kRCCYyhIyH
 fHmOlLaO/RElM7j1lVYcwiLQAcGQ/6E1gsC0lNpniapzP27yQShSVWGNm40ATP8GyLSYG/1xTUw
 nYhBBuc7WhyoDsU9OuU/V04QNNteAxTrx1OmolixCDy33FZehiqB7Co7dOvB2AoM
X-Received: by 2002:a17:906:478c:b0:c2d:b9b4:f4de with SMTP id
 a640c23a62f3a-c4604ed9efemr259310866b.18.1792519191007; Tue, 20 Oct 2026
 10:59:51 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 10:59:49 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 10:58:19 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072640.772964-4-jan.kehren@emteria.com>
References: <20261016072640.772964-1-jan.kehren@emteria.com>
 <20261016072640.772964-4-jan.kehren@emteria.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 10:59:49 -0700
X-Gm-Features: AclHuK9VWa3Rlko5YdwLKcc08YXMJ6-nV5Nv3OQfCpSifFUooZ9H-s78QIRoalE
Message-ID: <CAFLszTiRKgzf8kqS4dWxj5SWGp78j4eMiX5Q3dTKS4MT=CKx3A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] avb: Take a storage interface in the AVB operations
To: jan.kehren@emteria.com
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org, 
 igor.opaniuk@oss.qualcomm.com, glaroque@baylibre.com, sjg@chromium.org, 
 trini@konsulko.com
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

Hi Jan,

On 2026-10-16T07:26:37, Jan Kehren <jan.kehren@emteria.com> wrote:
> avb: Take a storage interface in the AVB operations
>
> AVB assumed its partitions were on mmc: avb_ops_alloc() took a bare device
> number and get_partition() called find_mmc_device(), which rules out
> verified boot from anything else.
>
> The user that benefits is "avb init", where boards already expect to name
> an interface: board/armltd/total_compute/total_compute.env picks between
> virtio and mmc at runtime and then runs "avb init ${blk_dev} 0", which no
> release has ever accepted. bootmeth_android gains nothing yet, since
> android_check() rejects non-mmc bootdevs through bootflow_iter_check_mmc().
>
> Carry a uclass id alongside the device number and resolve the block device
> with blk_get_devnum_by_uclass_id(), keeping mmc_init() and the hardware
> partition switch on the mmc path only. "avb init <dev>" still means mmc,
> "avb init <interface> <dev>" selects another bus, and neither touches the
> device: it is still resolved on the first partition access.
>
> Only mmc is started by AVB itself, so say that in Kconfig and avb2.rst.
>
> [...]
>
>  boot/bootmeth_android.c                |  2 +-
>  cmd/avb.c                              | 25 +++++++++---
>  common/Kconfig                         |  7 +++-
>  common/avb_verify.c                    | 71 +++++++++++++++++++++++-----------
>  doc/android/avb2.rst                   | 14 ++++++-
>  include/avb_verify.h                   | 26 ++++++++++---
>  test/py/tests/test_android/test_avb.py | 28 ++++++++++++++
>  7 files changed, 135 insertions(+), 38 deletions(-)

> diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
> @@ -29,6 +29,17 @@ integration in ``common/avb_verify.c`` and the platform port under
> +If the Android images live on another interface while the AVB trusted
> +application keeps its state in eMMC RPMB, the trusted application's first
> +RPMB request is also the first eMMC access, and it is made from within a
> +supplicant RPC. That needs OP-TEE to tolerate a nested RPMB announcement.

As written, a board maintainer can't act on this. Please can you name
the OP-TEE version or commit that tolerates the nested announcement,
or say what a board can do instead, e.g. run 'mmc dev' or 'mmc rescan'
before AVB so the eMMC is already set up?

> diff --git a/common/Kconfig b/common/Kconfig
> @@ -885,9 +885,14 @@ config AVB_VERIFY
> +	  Only mmc is initialised by AVB itself. Any other interface must
> +	  already be enumerated when AVB runs, either by the board code or by
> +	  a command such as "usb start".

BTW AVB_VERIFY still depends on MMC, so a virtio-only board must still
enable MMC to use this. That is fine for now, since avb_init_mmc()
calls find_mmc_device(). A follow-up could guard the mmc path with
IS_ENABLED(CONFIG_MMC) and drop the dependency.

Neither of these is blocking:

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW I had to get this patch from lore as patchwork seems to not have it.
