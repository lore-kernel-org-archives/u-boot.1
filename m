Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF6606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mt4QSaS3;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LxEjJq11
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC7F840A88;
	Sat, 31 Oct 2026 14:05:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kqr2bMObIUfn; Sat, 31 Oct 2026 14:05:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E53D3407A2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455558;
	b=YKujb88h1eZHRjHNpen0dRqqRqNyUbpT87u8koVv9kTjnw07hTzSbyXGJEeYwW+Ohav+
	 O2AVuJKLV7daKLZ/UnXACVyxF+yjSWewmLS5+SUTrB/S2Gztp8SjXfkAFwX2CnqHhB3il
	 QW++aGEDwm/PXNxOW/j1HKBkiiQbkGjltyUdDQfeBBVnzP2ZJZAVTKEnn4iEgnsokM8Ob
	 c6mKW/Ha0nfnICUE4UsZjaQkoL4Gefb3YtOfOzdZ2I3iY94vrfp7287QxhMSRH5ET0DQc
	 /UEJArcqowe0ycDxUzjzYlyudY+UCqWH8cGbyN0Co/quI7nCQ9+7vQhG4yk09PmUjdA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RRHbqjgEI/8fMdwRQLzrRYbS2nVI++8NynOmOlzcUV0=;
	b=FSIL4QZZvF5gfUdb7zjqnlwn+DKuiJKBXLel9U6WhqeedHJFjwqu1o7dFfC3WZCQSL5z
	 VMJ35Ye7FfO7rKVSB5pkT+nNQMq87rRXVOX+u7I3XrMHTTQ/yadWlE02SX2B5WsH3sNWI
	 Hyvy37xsOFs+IgMgWhroA/o4ZwWYOJrRdKOigEvYVDN22QddtBuHCydmsRyfC/JN45z6M
	 SGxkKbRVeToFLcJ5xJ4bPCDUoxBboaDQoX023iu94u2eBCGBVSvimi1IvSQtCPE6Cek3q
	 yrSFlT0aDRKyTFehwlQ6T9ecyqOLwdwdzLYwdsvWt7puO+Ms2ynM8hVaKGf0uqqF63w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455558;
	bh=RRHbqjgEI/8fMdwRQLzrRYbS2nVI++8NynOmOlzcUV0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mt4QSaS3yhgb8n3uhffa6SqYpczDCq5ZkWIj4a1Ule2z2BnhW8Fhd+1Qs5rAyN+bI
	 mcRay2BvJAoXxDUYK1kWvEXBlKeNHaWEpz01830/iyzMxRnH2DzQ6c41qgUALtlS4J
	 z3mNscV5OenncM+obewWQ72zj8ZdHNimU04FRQjSfsRdUwkafwjOu/kirAcE8ERnbq
	 1R7NrseaLzKq34YqYgMZdZtovikLeCtcSkeNQ20Q/DDFqcE5SD3VxL9A1WlpdxwKip
	 +OBj5UiSuIUqpfsQ6NL26BxuE5dTCNkWywSAeDAfCWXa9T/j6Bmwwn/qM689bJa3d/
	 Q3nwnNTYluF1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E53D3407A2;
	Sat, 31 Oct 2026 14:05:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 44415380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 345736061B
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k55Ksdpc2z8M for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:05:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4491960614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455555;
 b=M8wp/9CWdINnbU4FWS/OvU60YLtH3mHRWOoxWzkZ3kSG2YFN49nFtLf4Qm94VpR3o2O5
 vXDYefKNU43Oc9bItJZzYWx0zgJwIYluR8gMomR2LwJcQrqNC1/yEq6o554k4wI/PtJgB
 hG/sJ7I9+3BAnmGvEdH0U4D/LVvu4bLhExreHw1YjLBN2uTG1rshJkPDrhhGFqKkL37W/
 xtmS51h6fVr45ZscYUvKjG1Up4wOoBbvqYpOPAJRPezoQU1UybfzAuEdQS7GoMovpF0do
 4BHfKacCpTKMfsNAxqvKkZDFmkHg+kBSZ1jhJ8emJxsjQGHorNjeaX+hX7idPQZxWEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455555;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=RRHbqjgEI/8fMdwRQLzrRYbS2nVI++8NynOmOlzcUV0=;
 b=MqjB0KLFbVItifCV0ksiPMTxfMwue02wGKDA210KHToqFAhxgKEUv9Tly0Loo52wicgx
 hmXnf4XmlgIpJQTZaOL/sipJPYv/2D/0Y4VXjjsUArGkSu0OoC/bI6I7TfKy7TdffYjoh
 cINNXfc9PXR9NhJNxgH5DOWF+opDwav4brjHMVBrvLNuw0bbJBVJRbtmoqvxYqA/pX+gm
 2S+Z+vFc6uRlp7lLdiqeS/xoxF1GTH1LoVzvZty/Z64dKjSZf1i/VGEs3cPz9tjEndhlq
 v8neQ8ol36vcHdszMTIWo9ONC2FTKLWDmwy7VJ+0eeEPgvDMGlcM15m6M2HsS0X3gVQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LxEjJq11; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LxEjJq11
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4491960614
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:05:54 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b203527bceso2079393a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455553; cv=none;
 d=google.com; s=arc-20260327;
 b=rVYHO2Vq26Kdyx632dJbu5aFeubVS8yFdpwLFm4agoCYNIvzwbOoVCZqrH6/0prP8t
 0acltN0Y81rmDBQAYBnoFnf6stVESShr4f75HeWxXS5TfdapsCOWfNdgQQKyKYnI5A1Y
 yo/r8/aO0BE8j0lwVfqEoutrLZPquzfpOgczT5jlVAAQFArzYq3M46ac73jOQlQTRMsP
 o8rjpueAAe0PXaxPs1M0to/LxlBVpOuK5JcuzBNq6Kb5fUumtPUnAhh0t/jAECRBil6g
 qAsPc1zq/OCpK1CqCb86DCBfAkkRBs8qYSgaa5E1CBiJSqoydxnSLO7dJPdeUuAeDNdY
 JvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=RRHbqjgEI/8fMdwRQLzrRYbS2nVI++8NynOmOlzcUV0=;
 fh=hDaAgCvlUODuPyYy/YV5NMMSaLbMeCnCGc87TK0PLiI=;
 b=cmEGzCMadY0d4rmUwdnAfjH1tNDzv0VN3CadPjgcY+LRcPkr/IVrBEQCCJRkYwKzoE
 Bpi/9WH9ohKA1D00+SB0nZcvhayJH7tXAE2KBqdqiUahKYBM7yvEwGHNEvxKyZWsNTDM
 Yxu2a062aczHeNTvBXY05xAWb1pdMCKfcCWeMmXiagSG6D+d6ea9rONUCI4WOgfCyqCL
 5wABi4wKtucL7iES6bQYL9DQBZx8EmiE19puMAzYy71tJEkQH0yUJ2e6wo/AdwVRBODp
 nYWqfnAXnLFRCDxHPVL9sBU6+T+n9IDT/TDZKqrt22Ak1Q43BmSCk/Ay7NIpOLd9l6nH
 9DFQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455553; x=1794060353;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RRHbqjgEI/8fMdwRQLzrRYbS2nVI++8NynOmOlzcUV0=;
 b=LxEjJq11JgVaQk4Br+U/S5w++3pazO742I5TdG5P825uqoaTk12wU+Fy8uSxsenuzl
 q1URzg65G4Yj2Ozmq1tAMr4oRy92sEXWISIM78is8ZeRfusdIDmJA56i8VHUY2c2wWJz
 cnZYDX8plxoy/ZFYS8M4d0opirGE654CU9cNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455553; x=1794060353;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RRHbqjgEI/8fMdwRQLzrRYbS2nVI++8NynOmOlzcUV0=;
 b=yNC4J7Ei8wSirIIGy6c06aTtzdKGflDr/lVfq7K/bXXrfM4EkjJoTYUK1czV6/9McU
 y+M/j7Rofct3PgsTatFyjsJHqkfqUsJJyvDnVDAspDH+hgYQmkBu4UVXok4/j086vZhl
 Y+7n8kk9kNOl0cE7bA7TjncwEB4oSZX9RzOiwWeSbrm34BE74fTpQqkS/gwYzLiSSu/K
 t53+nuby06R2w7xe/DVvUI7/2MnvEiwviBrblLhZSS/SFrAO97T3ta21YfdNQF3CKbHL
 4JsyapTAqMNR6sXRdNK3EkTofDktpb53yLyt/zZY24fGArV+rSXjg7nnSF0zIXgPDBFx
 y2WQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByz7RvgmWXWJOKg0+VcsxUyQdNQQaUYlcr+WAPwa2Ux+Cxe1FdRQjMywz/Ix925jb+uvZOUZW8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK6rfsvMcwo/jZIoPLboO+VIraEro8Q8aR4Xh2su1WmFsbKDBFO
 FDiy+cGyhT+XJbDU1YE+iMwKJLL6viGH4qn9Dnvylk4HbdvEelfBnD5DO9ZBZ102goF7nd1U7QZ
 S8lZ/LGhiGefkLqWbtbgMxxaMSNqMZbwU7laTAAeV
X-Gm-Gg: AYBFou3Xz8F8KQqRHZgcGEnvzNgGTmgg+4wb+GaKYIY3ar5bAgL2kCqPGuc7Xd4OPiD
 daJOT4yxQlq/MyHyZ9a/109HS5ofT4ncENz9ved0mFhkeqyWLPsawoKZha/j+oj9xlIiKnBhAlQ
 XaJM+5KG/eT7Y/HWTwcO9BwmA2R4c3Pc0mvLuCPQAdkAA456K7G4d0ffY8X+1CfL7XOu4lImhex
 zk5/olSsDyvOVqreYn4Vri/skDh6uq4HctY1841tYdZXR4VsE19Yib/IIDL/Rqysm8snE3mHin5
 tPsoFnn9Oy9gnHurOx1uEQp5UtEtAdCiec0ae1NY2Kjhdr//lalVRr2qZc3goqT+QJUAyuHd4+E
 HxABL3kA0tchICiEylCmcnxsItKEoI7uv/Dk23zhnhZOBCiIaZBxrxLQExKDbrW9blp6AyxQ=
X-Received: by 2002:a05:6402:2052:b0:6b4:597f:9bc4 with SMTP id
 4fb4d7f45d1cf-6b4d4389973mr2641483a12.9.1793455552905; Sat, 31 Oct 2026
 07:05:52 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:05:50 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 06:14:29 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-main-v1-1-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-1-b5a878627107@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:05:50 -0700
X-Gm-Features: AclHuK9ROntZTgww2vRcRZ-szxR1quopwbvmGzp_psg3nLzb-lejHvROIUIzvqE
Message-ID: <CAFLszTgSyr_3AjNPfYZsr3wg+ia_1XEqbC1osi8bw+W-KW3rfw@mail.gmail.com>
Subject: Re: [PATCH 01/10] bootstd: rauc: Initialise desc in
 distro_rauc_scan_parts()
To: frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> bootstd: rauc: Initialise desc in distro_rauc_scan_parts()
>
> distro_rauc_scan_parts() only sets desc if the bootflow has a block
> device, but then checks desc before scanning the slots. Without a
> block device, that check reads an uninitialised pointer and may hand
> it to fs_set_blk_dev_with_part() and part_get_info().
>
> Initialise desc to NULL, so that a bootflow without a block device
> finds no slot, as the check intends.
>
> Fixes: f271b0627001 ("bootstd: rauc: Only scan all partitions instead of boot files")
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  boot/bootmeth_rauc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
