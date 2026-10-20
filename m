Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E196606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IRL9pbR6;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Pi9Gs21+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAFFA6077F;
	Tue, 20 Oct 2026 17:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mHNwrEGgjg2E; Tue, 20 Oct 2026 17:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E47506075F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792519194;
	b=nY29Y51Nm5dR0H9ZfDVD24+7dmP4m4xfuaCvWkA4NaENnJM2mg2db0BKIHTm9bPDj+Lm
	 wzwwHtVh3/8nVf95X8wZLwVEAZvq2/2M3KN55CWY1ZAULNYEjZg3Jkp7aoIfm1dy5i2Rv
	 z8cC+aNiryg1VlQWQtu0dfsqTqu7aOs+Si9cg93UV1VUv1MxwyDohAwQ82uDUprQ7//kL
	 aJVDIAiPBlhu3dHBOlrZxcuAJIHnYzkMynK3+4tMpNCnmAFDopjYk6QFJT757O08IOd3T
	 W+3p67GOrwgmOC+QfVPatve0NE5FtKdNbqc+7Wmh8znXD2gQlu/ZRa59JtGEGNLJYHg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792519194;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gcA/s9EHOxxF0mo0yO+ZMqwIHJHoLmQzDqBdhG/kGsA=;
	b=msSIN8wE/Bo8jEnlhZIauIvGREVKlluVFZb0fJQzOLawN967PIJvijlq3Bsv+c2x7Y8n
	 Islwgf7pgKY/J2zeWPwR5ZQnlsn6BztQDU29gd6Ljb1c80qTG8hLyEAuZHma9MHtq1XuG
	 J4weMCGEi65wvvGWFse5KMLTiPEX5OHie+Fs+v7Km/VJjk2LhdlXKiy8YR32r9t5XP0qK
	 v5hEXbe0n0zrR2NvfuEV//5jwr+7Z0a/qYQrVJ3Q/zQAw+d2I/LYli8dhqchdUuEAuuXN
	 7keFNU+GUoOv7JtGk0NRWEGFvpzFVd2XN1l2VEWZh4ad8UDy+l7YXPOMwbfyRwMPHkg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792519194;
	bh=gcA/s9EHOxxF0mo0yO+ZMqwIHJHoLmQzDqBdhG/kGsA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IRL9pbR6Hxw0EhHDgLOK/SAuTitkV1+Nf1+m2fkOnQJOPZVjfbkVEUT6gqcNW+v2h
	 KXj3R11N8urkfmAgRNTR0s3TwD9zKYNDDfk6soqriJObc1zr5AlwcmNHIHWfEqu4YY
	 1FXDuDEHCifULl0lAy3nX/ITukN98xmeG7EEsjSqNj2bfHy3Cgzgkh2P13l108JMVv
	 4XV52UwW+HuyuNjC0zuGWjj6TGkWRYUaWLGAodV9UNtS1nXtUQq5gi2vJ5E/RwAC7D
	 pm7WXnYpv54gwp1oTD1VHR2MMW3z2py31SNTJapnhhRyYmdNwdQg12H1zZJ8ViJV0d
	 BvotzdDqL3+SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E47506075F;
	Tue, 20 Oct 2026 17:59:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A86101AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A16E8101A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hemt5bRszyyZ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:59:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A7E4D8100F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792519189;
 b=q1v2caBFVTGWl7Trfn8swkE300MxdYObMBJRytw0/SB9q9HWYC+zoDf+DnzQmIsLIEs7
 FcaDXRzuaHaDrAuEWC1yktapIKA50SRvtZqwuADsqXNcKgIa9Xws9JoU7Kas4FjCjInPV
 eWleE5Q/5V6TO1hcaL080CqWDjO9zj8gjBZ6K8gu7YMF/P5JPCgBFiBVlMTSXb/rYeku4
 jNndVZ6oxHG1blIHpuNzkp+b36rfRS8x7WgvbswnC5TlMOVVfrvBoyQX+BrN1b3TKsLo3
 Gjyc2kxaUpWMwOrxB2c66+zoSNT/E1Uo+5+Ldg0J6Ek2db7W/Y4PHR4hArbMLN3k36w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792519189;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=gcA/s9EHOxxF0mo0yO+ZMqwIHJHoLmQzDqBdhG/kGsA=;
 b=YfYk3xEQkRbYWe4nmufP/FzhgR8+r2VXPBpdr621JDbw0A28lpxSIiWFj7H7fON93c1f
 P7QVCLhOrt7Ehu/ycBPivFFSeLM9ClSjQTGEpP3jQdKP3xN772AHmsXtG+dpo2OYUWfNz
 xzGUQyAFCcVIqOGlVK9Z+Y62pEvc5WCOtUN5BdawrVVpOPJE07EnvyM6m19n1SQnIOg5d
 BS+/N/gHoEVCXu4m735Q0ggRk560COVKo15ZqV1xzvplx/dIXJEnpMXGGcE6+6H9xRT+S
 /haHUe4qWhQVNkI6sEjeo0Q7XVM7xjwXD391pfam6CRyVoNreqfuUZ9ffp1cXC0ePFg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Pi9Gs21+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Pi9Gs21+
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7E4D8100F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:48 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6af9a9451daso5088138a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792519186; cv=none;
 d=google.com; s=arc-20260327;
 b=mywF7APdO6H+7D/mhfx8nbrKnbYuzVYqn0Hsh6zlXsu08LG7LbHA2so+1X0yybNDfc
 dqMEfWyxkN9bxwf8sg1fYtdgWyOMlPJ+GTMfOk/s7ICfag1baWxQUnGtiLKsiH14BM/8
 jXyyHk5yrTT6+SKMPcFsgKfZYnCkUe1xZQjqg8EOMnfTKMIYaBVP/8dEU6hU616H+CUa
 2T2sDSHjPZjLhq222TWvkJi7epwC320/832w2C3O7xS+jz/Ci1hA/yI5AOaJp/7XePQt
 VDnYKiBMUP3+dh4gLj3U4Q9tO5JbJbq1l/uQXX6tbVI6S8Exo8jNL/KjLSzYsM8aSrsB
 nfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=gcA/s9EHOxxF0mo0yO+ZMqwIHJHoLmQzDqBdhG/kGsA=;
 fh=Z98iJJAqvw5Wc/tQkeniw6jCkpkg7czAKKTnRfLDd34=;
 b=Io0S81WDAFQvAIYtZBGgdAm4clgM89TloYV0JvOyWPEfbXIqdKx+Q5Lzt7BMhbCk96
 4BWO+EoXlRxOSMLSblIxhXr9/8rnn7CklwReHSy+aeDPMZZtllUWCaJjRX4F0zmXjZA/
 gSKYDrkjbF6YQFEdjywqorRpnLJztDC712TIfyNvQD/+KdwRC9CGCdmoV1DQAtzt2lBK
 OmD08kJ/phXrtqpa9fAaIonFuNgtcEjkVsIxXprFnDBBYms2W/b55qWNArJLroOttaCd
 KJnQs0+n+gpgA0XuVVEk+fPOgXJfZ/E1FBaw0yhPzDwdCFtTkGv+vrQuW916e8irNexG
 CFJw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792519186; x=1793123986;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gcA/s9EHOxxF0mo0yO+ZMqwIHJHoLmQzDqBdhG/kGsA=;
 b=Pi9Gs21+lcp7JBFXhzmsaMBKaJkT/MJec2XRcnsyw9XthxVrD/YGLbA8STEmmbR/BK
 cyBDV9heY8mc8LIQxd8NHxNCD7ZGQ9WjO1w8mDDewwU0WbxR+m5MF7Wbjwq20oJARsxn
 1GF2X3IVeoigvcjf1ZyKW4nDK5hJAtHhmNPbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519186; x=1793123986;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gcA/s9EHOxxF0mo0yO+ZMqwIHJHoLmQzDqBdhG/kGsA=;
 b=CsAjsL/RRec5faHCeF3AL50y56yL3CigFINSQvtnWxeLnH8ctyU5NsAD2bdjI12Xn1
 LF2H4J3l1oiU33l+M1xhDJof4JhWQpm9bxr9bBE5R+EvoQyRZmCZqOtReG6x1cU9Qk2q
 XQmzcWvT13CykuBA5FmysWnyKkYON96XI9fJoxGLaio059X4cJpGLlb/5ug3VK237Kub
 ibW9kR+XGKtDpqdf3l/SJqmdFv3Qm1oXjiE0gchiFjin6AGCtBxfjgifH0zIyEw+AMwi
 QxNHV6bJlBwoUqFra5nIOVKQkM8QgJmJ1GwwijumyLbpWQpXDzuNitJBZ3CfzYZUPgEi
 H3Hw==
X-Gm-Message-State: AFq9FYKl5P8337UREzU4erFCBX6i1clGuvWxM75uj09FCx7Dk2siFqgu
 9VBlW9bd7p+MGdOytR9Ci3XDo6g7rfePrryfi3scQzHFj45Dc3zAly0CLtwo5frORPB6TcujAhX
 wcNFIPfOO1mTDM7BZEJnglofciYd52Nql3G1xhr41ztH6Lz01N0AUGg==
X-Gm-Gg: AYBFou3DCkgUzSfpPWm4XRso59bBwnkOn/F4BiLL3nHCG7rPOvR94kTMe5LHXdI+Rzw
 Rf441MWhdwSrXmX2TL3u9kR7RGJhuJBV5XG3rKTAPX+t5WzNxbwjDbamaEJTZIiWLobdgG0puzy
 eJlOHHxl105X2ShN3r4150Onn7vxF5AzI7+UuGHnSEEfySQ1RiwMbok/yZX1vKXYSlkte/V2Nlu
 gK/OeDMT4nMLXsto5UPIpJZT/7/54houYLGZQxN6NdHUdT9b/gRcbXSKht1JTfUNZYEhLbg5t6T
 S4aYW/SOfoACsYjJpT7MF1ms99P+ahO1NKoIQ0apttowLDH17gl6HQ==
X-Received: by 2002:a05:6402:27c8:b0:6b1:ba86:5f43 with SMTP id
 4fb4d7f45d1cf-6b3a818e739mr6866971a12.19.1792519186067; Tue, 20 Oct 2026
 10:59:46 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 12:59:43 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 12:18:16 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072640.772964-3-jan.kehren@emteria.com>
References: <20261016072640.772964-1-jan.kehren@emteria.com>
 <20261016072640.772964-3-jan.kehren@emteria.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 12:59:43 -0500
X-Gm-Features: AclHuK9HO1rMoNKY4Ura4ee5uQL3d245lYUa-Yv9iGD-5gYTFtzxBlRTrclOGug
Message-ID: <CAFLszTh-ScQK+HhtGkf4d97jSMYA6fqapiEp9RvDaGwthv7E=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] blk: Add a name-to-interface-type lookup
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-16T07:26:37, Jan Kehren <jan.kehren@emteria.com> wrote:
> blk: Add a name-to-interface-type lookup
>
> blk_get_uclass_name() turns an interface type into a name, but there is no
> public way to go the other way. The driver model block layer already has
> the lookup, as a static helper behind blk_get_devnum_by_uclass_idname(),
> which resolves a device at the same time.
>
> A caller that wants to accept an interface name from the user, and only
> resolve a device later, has no way to tell a bad name from a device that
> is not there yet. Export the lookup under a name that mirrors its
> counterpart, and add the legacy block layer equivalent.
>
> Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
>
>  drivers/block/blk-uclass.c |  4 ++--
>  drivers/block/blk_legacy.c |  7 +++++++
>  include/blk.h              | 11 +++++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
