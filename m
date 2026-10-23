Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B3E606A323
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1NbknaK8;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iNmOGEjC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A8566068A;
	Fri, 23 Oct 2026 11:37:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VowW7rx6HJkM; Fri, 23 Oct 2026 11:37:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B1CFE60671
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755459;
	b=CAwEsMz/5XmcuhTm7oD1zk6XFzMVRf8SOcP9vCkgLO97Sf1WlVFdzH7As1UpzuspDQqe
	 rA0ki6wx3q0qaKIfcBKwNmeIMtehLUKLuWBi9LKtgBC987d+uUhLALOC+8XlIPDbtZGD7
	 f6i1TJzR73/GtMoeAK6bUrnR+jDukvAJLiUHF9r0qAp5hKg7pl99xDCdBizrtz5mTfs71
	 znQwqmlRwGpumKykyq1hrxnGbE2gyJBlyhAmUFuD1gBYuneCrbhlpBPJNALUvJYvu/kId
	 RPcUDwJczXC000Pnh4Ezocx38WeXmtXEKXenYbBwFevKhrV6+uJQonekgXrBRfWpWpA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792755459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vuNkCAiVWEmy5Jc52+CW1TizQMraOMVCH0SQO5pDM90=;
	b=LhtACOafc/gfYd7bScLdEnGflNqz0hTUmyphcbm8te89PPby6qRl0yty8JrG90e54CzV
	 VzzHkVe1fi0kTkyou9CuA4FYJmk5fgGBzy3zPa54jEFZaPungN+GZ3WT5/cnDIZZLJ61Z
	 tvclKpSLvdNCMsTknWd/k5+d0YiVaB9Dzj+Ri14OAOxDoLpJH4B29RSMog7DSK0ENE2qE
	 Zqx4n02dS1sGUHhFQ3AJIIMg9yKXoesu3JAXLWDu+aRuc1A/KLRipRpeW/Rfe1lCA7Gzw
	 mfpaO25JujJjfm5n6vTvf4uXqQtFmckalJMkCncfRnrxjVbPh6YUrskQzrUY0bPvPDg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iNmOGEjC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792755459;
	bh=vuNkCAiVWEmy5Jc52+CW1TizQMraOMVCH0SQO5pDM90=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1NbknaK8v0xP9+e6ZvBtujgdBx/u9XCUlrgSHQnBP+gwQQa3fWJsXm2RDsyiLkjiX
	 inTtJU/SeB2PvHF0dxXhIXVLrdHLuGxT2TS7AYXjuc9i/Q+vm5BEK8WdAXwxNhsA4k
	 Lp92lmnO4u/o38CHTeCcdedw87SsSRLc/Ujjo4LgvSO30y+LtKOszoCJMcvcnasqOc
	 QxoejCH7vLZbmXx3pytuakIsL/MOrHlqCVXdMIpyUmt+sFh+bplKXbNQiWIcQmJS+b
	 s1+/97XlzGeOsHflRBQ+zQywl+OAHvcR7V+VjibwodRMcUeVnWFANV7OSSUtxFCK4T
	 06LUgSo3WDaLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1CFE60671;
	Fri, 23 Oct 2026 11:37:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D8DE33C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE6876065A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hLDUNZmaD6p8 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:37:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF2F560639
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755457;
 b=cSuKw0Bdds0iZWdZ4arb1rPl2EUd9A50mM2URljUrFi/QovK3wGamt3DBRzHqqAmNlzX
 Lid8GhYZlvS9rlSZaxajOOI9k5yGj8/bhK5I3s0YPQ/NsdIRvWEFcGKd+LvpVdorTkVYm
 WMHJNaJrwwiyGb+0IZg2USVYbGpLOwlOkbaOzxQ+GMPt278qWOphuzrgVMszCSgAffNcQ
 kR60MlNvUpjuXsyFXwCS7xuTtP4mGNVxuRBKDqDlItgRZ0vYMJBq0IbMfYeg15BZ/OvGf
 AkThtC3LTh76LLTh39lGMAlzbt1JaVt3g4FwqrH+5rJw039kKzg0srVEouRnd7V/qoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792755457;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=vuNkCAiVWEmy5Jc52+CW1TizQMraOMVCH0SQO5pDM90=;
 b=KK9dlOFHLctg1/oZgZCp+6Ppo0kWWEp1CjmPHKpi0GpmVbQU3WZ41iCMdldHAyPrdsrK
 23Gz7lQB9m3GVw7TiRfEIqaG7ZFWqaw5AllcPStVUGKzRyApCz6umxuQdB6XIWV4XVjMm
 mT/DZeDRYfTl2coiZ/s2cWugW8aITDniUchXMGX3VyRgVbg/hJhu8ocwmgiGzKPAjk5SA
 elx7Xv939NCYjLlexGENQXeHX2yIukCN37Fg4bSn8uTKbNvda3W7ZnQuvTT3wikD0C76L
 lwZ1H5L0gYVpD+Tw6cZNyuNjUHoX+Gg2elL80f/y9OT0WNlEjkQHq/ZfYxu9NwdPjHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iNmOGEjC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iNmOGEjC
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF2F560639
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:36 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so1177133a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792755454; cv=none;
 d=google.com; s=arc-20260327;
 b=p0RPqRh/DWAmMmMfH8rwu6BZZKDpHEwaftfVoZXhgWvk9EZmPnM3GuEEBfhf2yLMXY
 dvTD+CVwsLd1c2wdWIWj3j79067gRPCmFXohMIKR4vvvaTRwPrbe5h31uFhlbUnb4qfR
 F9bQnTwS53yXz4lyjl7vmDjg8q2ttOI4XR895IS3arF0oX5G435NXRy/CTgir0Vo8ubq
 RC+IYZiw2dAYOJsKVmEubpDyzPantYo5Q07p+z9rl+JRnvJ38JQ2COTP2NiRahgjmajp
 zXgQjQHhEA/iN/mjvOmXvrT0lOHFsvYFHEgEbDj3wcJYQdj1/k7ZY3NThJlWhinE/qft
 OWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=vuNkCAiVWEmy5Jc52+CW1TizQMraOMVCH0SQO5pDM90=;
 fh=gdrufOv8d+ewsxSa8Sq6e4MWPoRI11LOccEbmRPuBq0=;
 b=XgoZS6CQ3Ss/CiTUlP6o6vd6cjSjUEQxJGDNb9UUU+CwcZKn1dovK23rn+6x/1iE9Y
 /Tf4ft8kdlxp3gc+2r7tJY0BmABk7DpRvWvlVN7paQs398qlmJjilmzT7uEOUUD8LgGf
 IPYRxVfK7tAMz0/bC+CrWeevKMXDa8z8QD4qiUbobYz1Ovl44uBtvEp7eBn3Off6c+m2
 BXdH0WVGVCiLf3xzc4Fy0yZoNlgpkdQ3UiMx+8UngthwvyaxeLeibmonqD6wDOY+RHp2
 LmpWkdtAvL/HveY4ClFoQLNfPgrglNQ3uV7JeTQbj2y8H6xAcJ9UWcxFxNvZ5eQGHIU0
 6Bkw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792755454; x=1793360254;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vuNkCAiVWEmy5Jc52+CW1TizQMraOMVCH0SQO5pDM90=;
 b=iNmOGEjC1C8EMl/c22PeyuOE/BY1AbHZWPkWLVah6veZMPbRotlxagczjRPOgDdse4
 +zlUzONlOB21EjOZDiXFlhipH4hDqLC9reOVewm68J2SGn0GPaawMgdGIGNZ8ENs561L
 Gz9UZYdCUKt7CA3jcoQnzhE6Wx/UN3sK9XqfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755454; x=1793360254;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vuNkCAiVWEmy5Jc52+CW1TizQMraOMVCH0SQO5pDM90=;
 b=LutHrgQvML+1+Fyj+W2sWdmK7SDA17IXVCWs+JtLIHcYjb1G9MCsYmjyHMLpcfu4UT
 NKFLu092sBqBzSA6hVnwyjks6A5ledsYPRCbfxo0pxVbWfZ1qC2TWPL6bCiN0Uvmvlu4
 yRNRZRw1M9JDLz9RiUL0JbWkYlEjgSRzToCT9YclVHYVsOUDfPiXRi5pRmMZxvLIjokj
 XjmJXNi1eABUiuckAD9/uk6py4TVm1TQ1II3CZSYtq0ju7S70UTHlQ9NLiNeiTLtgcmw
 h39vHICvCeLeSAWV0tNH/ZZqBz5egjgOZJBU+hOMlJgGxQE9KrLfVq/tRva/fev5OqIV
 aPbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNN/9djOBVDhFqsYVWTeAZ4Yz9PgETflQu19hWyHH55x3kBwrRrNr2FwDoM6J/WxqOZ/HGL+s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIG2jWdUWRAKoibdaWtOLIjlsERSwm5lDet/lDaFEKMnPt1SwLZ
 JpXWPqa8MSoxrYDNanNIdhCUIOgaCBC48z/coz9GnA/8s5eKsB/bja0g4hHaA/BJzUOrVUG5PlF
 z/y855vLBXk2g27umDcp9f2GGl3cvPpo79SYVLiQ8
X-Gm-Gg: AYBFou0o3xfiFeTM3BllDwFdzqFdu66O2Dz4C0wKPQEYZ8OZo20F+QWStwRp0CrLXeI
 i7qCqxgt6e0sZ4sxFfp3eQFVdpW5LJv/cxigfz7T+bA8jPfwMPOeRtGgMusmgPB2/+ZJfWfTdFH
 KYhARE1OmMKMOXFAcEuZhMXgrNVolVzVS9ZpYOTBAAs8CNegaRM892gIMfBzZ/Kk9qRhnoCVLzm
 YXC/LzCmqAUWaZKN9+xroU3fGx9w2qJzdhAzR2I0HvtzzE1FnZykgHExo9T/KreIZEW3qXBFwN7
 ilAIyXGQre1qESANTsKorhMxJMuphclA7LWvTnBNVFC7lxqsW3FDk3nd/6OoylcLprhbZEu15YT
 KObjc2cQVBLPy+vLPj0kkeClviAZAJmHwey8=
X-Received: by 2002:a05:6402:2058:b0:6b4:1701:569c with SMTP id
 4fb4d7f45d1cf-6b432b22afcmr2114057a12.3.1792755454272; Fri, 23 Oct 2026
 04:37:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 07:37:33 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 10:30:48 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <29d1a8de9b9e6e202372d4397480661782b1e238.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
 <29d1a8de9b9e6e202372d4397480661782b1e238.1792591479.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 07:37:33 -0400
X-Gm-Features: AclHuK_83hFUimWdk89xiP9hIjJw7jI3DcVlkTgNn7K0z3FhZvfwjLNKKtQ9io4
Message-ID: <CAFLszTiRVmSeOk+Zx+h=aiUL7LRBvtLPTSsNw3N_hcYLC_h8FA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] boot: imagemap: correct the lookup guard
 rationale
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Vincent Jardin <vjardin@free.fr>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
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

On 2026-10-21T14:08:59, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: imagemap: correct the lookup guard rationale
>
> The comment on imagemap_lookup() attributes the need for its second
> guard to ulong and loff_t sharing a rank on LP64. The rank wording is
> wrong: loff_t is a signed long long, which outranks ulong on ILP32, so
> the subtraction in (3) stays signed there and an underflowing offset
> simply fails the size comparison. It is on LP64, where the two have
> the same width but different signedness, that the usual arithmetic
> conversions turn the subtraction unsigned and make it wrap, letting
> every range appear to fit.
>
> State the actual reason.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  boot/imagemap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
