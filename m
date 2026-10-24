Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EF7606A31E
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bdDiNjAD;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nq+7ahwp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A44E780E48;
	Sat, 24 Oct 2026 07:08:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t1LYRMnCNQn0; Sat, 24 Oct 2026 07:08:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED51780F3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825726;
	b=OUTjTnUTdOO2Z/ONYsewvJVvQTZPd852hBwD8toGl9UKXZk2z5KkgiLiCWH4FDrNNknP
	 eHa7f86Sw8oZmqEs4hQSQmcdQeY86eyJBXic/yXPdnNFwLi7q2s5jBEILHmxq0qRkiA+5
	 LYEhMTgGqUf3sQnXGcJ4ZJ62kMGtAdw9qgVRPX6Kjl04iUjSncCg6cxu0w9T/9iZ1BFTb
	 bowWSWBH7I0roavsJBDTj9C+tUcKPFAeVvGRTyfXuMYmk9LxlPTKF5wIHwpXSxPIgzFGW
	 uarzdFQhwFQ3KhyO/k0V8VKXRCpuUxDM4N3ICyKX6L3WtJs/gMhdnESaU1NfYBP6owg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792825726;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OVzWEpbsxEhdiJmpNfkSAVheCyI4EGxN6sbJUaXFtZk=;
	b=lPTCiraly4BrzS/WbrujI4vHx89TpPu4Fhe3Qm1GfP0s0KXDPK8Y751pAMG2KHJ6QMQp
	 NC34/CVNcgPKG/zyFQRoJwlJoc8FE0HdjUF4h/FczCJSYXpkwYnftUC5Q4I1J4n7iFU9L
	 PlvP24Ut3jdt4id002cebcXckWTCkGSXt8orMJqAdyQFgiJnpwrGRcrwAP2zDt5larKor
	 bLSK33AUxmM8BQoA6LbW/i6J7VI+jf6aFaVNqVm3cjTQMBI67ZhdkrWuJ2majycl4igf7
	 hEAGu+hi6qnHGqvRNh2uGngXy3IiW/9HQrpvlD4w4JhMKTdSNQLBs6tklwFa+8V+wQw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792825726;
	bh=OVzWEpbsxEhdiJmpNfkSAVheCyI4EGxN6sbJUaXFtZk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bdDiNjAD1bXXnc0D7MtZuj2vlmSM5b3tWpO1Bd9qTX7CQWK4URA4SULUaeLcpZIQD
	 ORaE8XNKRPe/CIiAe5Q/0SQ9kQTGQMd6URqBZtohkniHKrtzLD6rd4cXe2xIG5Z5RX
	 5Qf1ePsX4vI0BcOBz1S8kfG0P9k2nqMvZd36YQ6+3De1wBQL72HL3V7z18I/70VLpR
	 wAeFamgvolQHwGemHn+Wtf/jkxhEOKB4xKPD/p0ZG81XoPJRwzL317tlJ5IwVLu+/j
	 /3GGxr5me+2ozlsFb2S6Yq3E5QQyN8IyWaEVPGFZVOWGwWrFAObhfcLihVjFsd//zB
	 6bMWo29aS9QRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED51780F3E;
	Sat, 24 Oct 2026 07:08:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FBFD43
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32B5160A6F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1XjsuVtG6pKj for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8999C60A59
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825723;
 b=pUDtVPu4Zf3y2qo93lJtP8CTr+SjHXafIn2wW8lYYYW8+56+g5fo1KIwUl3DqBxzpK6y
 KPxViLgflcAdr2DeW3w6VSnHOz5yC1FS5sHo+nDx79GQrakOg6EIbJiCSzYRZJ/vvCmkl
 FUc/g4PkM5CNWYMpf982jHE5+LJLoYXvB3onInu9qtblK4lMJQpK/aGAbcV2Hn8+9dx62
 xL4UH6OiCF/w5R/4kaPHywJiJPeqHoxz6wHAdvV3L8lAubYXN98C3yLfNLj9RuqLGUVL0
 clfRkUe+Ov7buJwI6vqzwlBmMdv2gYbXHeQccnPyAvKOQZ98puSfs2ttLGlFy4dle/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825723;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=OVzWEpbsxEhdiJmpNfkSAVheCyI4EGxN6sbJUaXFtZk=;
 b=Ex2of7xhajQ6x3E2iBYYL4RrGc/uqzNb/+1Zp/+tLuz2SBUBPmYz3ob0hsDvzIkecixY
 5dMyXvCOYPk3SjbuPBlpfk+7ybjC5KB45qAOxx7gSJDzCO5WUxvO2ktkSn/fSfept9VYH
 WurV+axk0Fozv9EPtPvTzLYrtaAJhnXwiWVWM3Phts90tPAVIUx/gaBri9Ps0N+/nEv+Y
 KgiGpHMZNfi3c5zwMkGg+P4v+XA+yAffQV9eZ8iAHRdV8tlcHs/10fAfoMSDmvXA4GWQ5
 nOWGKGm3FP09funlZrEmo5JJ/h/5Rsn+DFK3NF9KXQVjzYnQlc4CfDltTtqVn2mLpFw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nq+7ahwp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nq+7ahwp
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8999C60A59
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:08:42 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2dd76b1361dso8581425ad.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825722; cv=none;
 d=google.com; s=arc-20260327;
 b=B6Qhd7vzm2RQ596+lLms9QdFQkxt4LEicyqyEA7gzhMRih2n3CI1y4fRuVhGCFICSg
 673couLRuvqN9Cl0xOyyIWoyLf0vLV/YDgGPwrRIYWAJQaprRIaOUf9sYd4WAEIy15CK
 lDetPea+gavDRPmhVQJerRU0p0F9xcZ6nLhptbj2Htrzf9ICzlvsi2MYI8OoAfXAMe6/
 Kv9vvTfxJHW/7GBHMo6YlNaOyxde4QBHzSfffsVwT91zvJB2M8GQeCB44EEbcgOXJRr1
 3DBPLklG1E2sT55Jyzeudl7R431T4k68yUU1e8ovPTIw4NTzynZHVb4PHsWmKfmk8ejr
 wdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=OVzWEpbsxEhdiJmpNfkSAVheCyI4EGxN6sbJUaXFtZk=;
 fh=JpTsc5Gowx0wT6RWEVCv/klKL+xP9jcrJudSEyfDBZc=;
 b=lphGjyzBzRK0JPUI4l7RP3a5wpopLeeImsLMwKP4DHcb3P+rN/k9WQvbVTuk0VYBUy
 IY2ucaT8sskSlaCD36SiFxjXhRojDj2e6PjKU5IxiUbXf7lQEVg9speb2+/YuqSWqAdr
 MWJIviX/vBPncs4Iei1tUKHkHJ5nL9sR9pJdepggUg7oE8Orhl5O0h3Gr7yoKGRWnl7F
 HkrgBL2BeKNJ/mK9FVhFREAD2SJHZmffdaKQzZXcT019dL7tsZR5rnBqGJPNur/i0SjI
 WbkVi9tNEHtVavTjqKLyAG0rSFj/Y7PNjWmDUYnT7FilcdY53IVZ/FyZV5tmuTnC2P9x
 2Z9g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825722; x=1793430522;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OVzWEpbsxEhdiJmpNfkSAVheCyI4EGxN6sbJUaXFtZk=;
 b=nq+7ahwpOv7QH/o+hPQpvemVAYmR6o7jR3uC7jOekL4YBlC95ldMhf8Ek4AD9v8pPT
 nKhRK2vb4yT1YFhvtaTY33rLLEPGATbP4NiSKI9P9iVWV1h4wVxt6GAT00pdqy9rukqC
 nK48ET5REQS49KwVpR2yblz7yUES+8oINd3Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825722; x=1793430522;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OVzWEpbsxEhdiJmpNfkSAVheCyI4EGxN6sbJUaXFtZk=;
 b=vKVVl6dlhRP69qfjIRr/5ArgP7ancZxf1c2jCCGpEiiCxmmojIQUW61/ZLxf8HHjYe
 jhJ00Sr+MyigNB2VB8n57zNapcw308NXepCJWAX81VtnrYZSedHUcmQK3diQjaQB1kDk
 s4sRfGPmxfQbfQ6HQ2vBQ0fqRYBCCqTcPC9Q0hRF6NdNANO6Kr/vaxom7uIV4/38B25y
 ag/fPKWUmo8keTOf3mQ0shnKgrzLkMg9E517toMJgR3aHQ12uATD/PX3Qsi3XWhyYxoJ
 wFVqsI5O7vLeAcy0csGy4uhaILNqN5v8tSvsiCpNC3QvnAUF3A3X7X46P2RvsTL57if7
 1f+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhGhFm2lskBTXCRUQeQzipNj5KWijanOJ9an5/sjrQb9JknlNEnxxNAeG3/FBiq7LhoroA0oc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ2LdqXzlQF2OywkgxUtjx+2zjtkHxTgzYSxWb7UvvsI9hfyhzc
 YJ9llEjNA7FmLTXYHUbZSFCp4XpOZx60/YSNagF0IJO0kSdR/gzEU4WkAHAVvKw1VEc/9R14YM8
 /fzNQv0VfgK5E+DcVU2j3jDZ6euPg7Mid/4EOdiJaTpHKVF95gOAutw==
X-Gm-Gg: AYBFou2oQDPBg3PbqtYgBD6GDI6Jjfjh9TZ/oKQGZW1XZgBb8UxAOsgMFsHWn/2ObRo
 H+EOrLdXSqJIP/HLPo8VXxJQOCHw9NzTU7WawCkHnANA7GDNDTU8kV01bA/n9lIlMXv9xb3jRM4
 BMRr47Jx5i9+WU2VSyuK9O5ZPQRBE4q9rYjA9CDh5l5+floT5YSqjhMnJqOjyrcAoHynF5wTT8m
 Ct8pHOoggGA2vfha2xE2++RiiNEJrS32/tQn2NTxrhkH9l74WN+zFktEEHwY1vsYvqDMZpaU/ja
 EJB6VngG85qSiBKaDnBT7qCdzyMm9VZzrWaRJP+VY6v3kXFwr5F3gBwcsoUsH21cQi9W9Dn5OIR
 yJRs4PTgwapoiIpNII6VWpWeUjGtEaHX498M=
X-Received: by 2002:a17:90b:2888:b0:3ac:b44c:2d84 with SMTP id
 98e67ed59e1d1-3adea8966dcmr1197207a91.13.1792825722246; Sat, 24 Oct 2026
 00:08:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:08:39 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:02:48 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021104356.2084625-1-fiona.klute@gmx.de>
References: <20261021104356.2084625-1-fiona.klute@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:08:39 -0700
X-Gm-Features: AclHuK8zUYH_E-IVPVnpoowzGycKLWZfPvLJtrzakbeOg1nQ3LKM0oGMBGiFg78
Message-ID: <CAFLszTjus2hdMB5USpwmAmNBB39R+xOvmtWDGVDSF-JDQt=QAw@mail.gmail.com>
Subject: Re: [PATCH v3] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
To: fiona.klute@gmx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>, 
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-21T10:43:56, Fiona Klute <fiona.klute@gmx.de> wrote:
> doc: fix description of CONFIG_ENV_WRITEABLE_LIST
>
> CONFIG_ENV_WRITEABLE_LIST only restricts loading stored environment,
> not runtime modification e.g. using "env set", while the Kconfig
> description implied otherwise. Describe the actual behavior, and add a
> note in the documentation.
>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> Reviewed-by: Marek Vasut <marex@nabladev.com>
>
>  doc/develop/environment.rst | 7 +++++++
>  env/Kconfig                 | 5 +++--
>  2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
