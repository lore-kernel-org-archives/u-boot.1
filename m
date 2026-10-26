Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1F606A337
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dWsoLd4E;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Y3OqFC8M
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 922AC40732;
	Mon, 26 Oct 2026 16:51:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SnV-0Ms5FH-3; Mon, 26 Oct 2026 16:51:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D45E440722
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033505;
	b=LNaF3TKvqQ/SRZxThDwXELiUlT9sxrj0Wx9w0iQsNtSKEewJ6WrVMxs7TcX1Y9WR3ztx
	 WP9oTdlmrfrEBoXF+sbbBh94ww/CL+w98c+jNIQT21VddFPha3xaJpm8dOht9sIdnGrf9
	 aDLhJ3eX/BYHDlsziFyI+CdHkTILGTeZOnts1WEoK0AeEiv3ur8nFwxZfccPE24iiNTHJ
	 mLq4CUaHBoDDbAnXfaEEdxksgLBFuqD5zYhGAo6j1cOYd/hCrYhoPxbFjKc9y8hiYG2FF
	 w2rECKOvEXq/dD/cHqk/cAzY1yLE8Tm2rUcRXcx1x7LQPTQayUReMhJW1mhSxdo5LRQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793033505;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gAt9YY8fx1rkCAnwisp+0WQRSQ0tVh95zTCEgcmoi00=;
	b=fKT/6G9I8jKQSFTg5RuvjVTUQz9qGYfC0VyoWdGYB6WOOH7zwyd1IQdWUSaI7GrIPBQg
	 9jv+dBEhfSSkrLJn/QtZkj7bHHCARCDaocOLR5DUvKOZi0NBsosNRfHBn3Qa3Ddl0BEZH
	 mcoymEA2Rpbk2u+iZoDjuoT23VraFENn2cUv3VC1uNVe8VOz5p1ToPlOl0E+DWZNBj3gu
	 p/FposwznhiPw9O1m200jdZHgjzgaazhj08v2DqfUS/pMjJRXZQgCWsvYXSAEr0N/+H89
	 7rekwDLms3CxRAL5WKQOjXh2Ez4tf0yPT0BQPzCGrLE7YLoHg/JQxAlJPIpgdpUtztA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793033505;
	bh=gAt9YY8fx1rkCAnwisp+0WQRSQ0tVh95zTCEgcmoi00=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dWsoLd4EtW+iTXH/j08o1226bQHoG7svYx6CFY6lkfgWDGcFlXAJaTrvquIOhxpcf
	 ucbVEBLw5zWkFsXnR2x4g5VmKcObhVsIKXXoQokXUfUtcTQoU3V75VfjRVfZd75Gq6
	 Op6WnuFhgan3OLmCdgHm/nCuHn9YehpwiOODJGZ7JERDiC+BRe/7eVEN65nOKQTAEa
	 RW3NcPpdF5CwYP3D4G4dsIQYAwIde1U1MiaVuz97OhBc8hfxDn9fnIRZoT1Wk03fS3
	 xCQzNx7zjSBdSw/iHIrDPeD0rayFVNWCNXvhhBZM8K4+/wIakzILj7UjQfnXrB8VE/
	 VjSuR8JdwEE2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D45E440722;
	Mon, 26 Oct 2026 16:51:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2344F380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1503860603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JAf1-YT3zIxg for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:51:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B904605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033502;
 b=hVBES01fdhv0yGCy18zTRi3/hYS+sFEjiTMprq75OBijWwZ/K1KCrvbrybiLQVPGWQkX
 61JVBdHlTLOpJFk6X8T3CL5SysFcc+APV8tgvPNevewvGPqakPfYOtwTVcyh05WXIQnj6
 RMtgPoEQTVHKQKIKGpkZu/0V0NRwqivzYFjERyOBGbg5xCQi9vX2uqC+CRUZWdT0V29PV
 4zV3arhMWKEjkk7+aYqwHaLPSAZWKkeSRzb3CztaubYypvukYJ3urWeRgZ7nLuyQ43ufX
 bclyOjaZDM3DMJgXNbnk8JmYjgXCcsSwSYOC/fGRKBSSEUBCsZokwuAXs8YGw6zpK0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793033502;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=gAt9YY8fx1rkCAnwisp+0WQRSQ0tVh95zTCEgcmoi00=;
 b=FfveyARx7YnqXCii+RQLVly/J0hmzWR3l6xvCJ0CGwwM3BWUUsxfVQvfyrw8vCk4ZdJf
 kYnQ1fOyRwBRDnpPCj81Rc4ryqQn3rbMe3KBVm62W8kLpFqN7/Dohbl2b+YEnOg1XEmRa
 2mrQasPNRLPlq4Uh+8cZ0lHSvLwAA4lHrQvDNmMUtoQKw6i9iURTgWTzxhC81L8FF6Fqb
 YJ8vYHpaErQBOtruGVe/AKZRuQd3dfZ/VFeUwbT4Er+DdoiELN3PToQMYGK4yF64DbNJL
 GfPCiu6yYdPqEKFfDMwJJI6U4+NaR4QIda+C1iyfZVqk/yjwWW/oZDMfdCBQQbgAFpQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Y3OqFC8M; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Y3OqFC8M
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B904605EB
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:41 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b21cf1a580so3968544a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793033500; cv=none;
 d=google.com; s=arc-20260327;
 b=PoOA/3evkbiSo3rU3MqJYyuGhCml9QqMSt7Bu7Y968buPl27ngDmCCIvyL4CSn+LkP
 QgzLJ3LZVJ1brJ849y5IymRyvAGwohxW2GHUg90847q4jnNBDYOw4LLMpKKZ+/vGyL7J
 Z8j96WS7RffDRhHS3LJE7M8gReBNp9IAG8dD1RerVFXUwlKf2Q5LrALJpx9K1Ha8kAUq
 KzKgFrjl7J0CROkR+NeKU5k9YlCe6qZSLQ0SZaiQQG3Lu93EVBHJBqeW+GAy8wAhe1DK
 k3ktHWq+GmBuNADes2XT0b45c4kjC95ubp5akSvcOKwnjkV/3eiaUoTbv+PpPvUg7JcL
 sxLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=gAt9YY8fx1rkCAnwisp+0WQRSQ0tVh95zTCEgcmoi00=;
 fh=ZN9NCPHJlCiuGjJpDjtdhfY64wa+w5kDy4wXJG24+0E=;
 b=GWEZP73Hxk6rrXtI3AKtuSjH7z35OoKgaO9AM6u3Qn146+JQozmKjX7pjiqbUGqAms
 HEFM6uidjktSLiRYBuOiaSq1O8y3M36qFfwow8BtCOrdhbjz6lEMJsTKeCmMl31JUwwd
 aBXa0tlZW0Zk95GpWaKM1vr8l872RbnWwRDmlKn9hDLHQxH/ZhwrAtcflGyxSmchbOhS
 Q3AGwZ7dplykVEpPsDsSgJG5+BWzZUiAuXZ/a96w6xuuzfdnG9HxLb5MJ8IapmRLLD/Y
 wInWBBCaNWFzuVppVQhBBnIYVFGbu46EWPPWAZRwlDfwRR/t0o40dL+rF8moTV6g/r9Q
 J2HQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793033500; x=1793638300;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gAt9YY8fx1rkCAnwisp+0WQRSQ0tVh95zTCEgcmoi00=;
 b=Y3OqFC8MzV7wooUpcuRQV5XaCivcQxHFVUwE2zYewEcIPh263bR3TkftnHcL7rRUqa
 TXd6icIe7iVeqjvVmLrgaf0cZE1jF7m+qPhnj0/PQrPBrxM7llK2MD2xeWjzYG4J1vGN
 8nCCVYGm/uYw9IdKPbYna0TlL0ZoJrPAtZBwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793033500; x=1793638300;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gAt9YY8fx1rkCAnwisp+0WQRSQ0tVh95zTCEgcmoi00=;
 b=yRTxBHiv+EBfivifwKHCfybe5RF6mvCI+vdhcqqezQXTaiSo3QxTdjRq7aK2m6/1rs
 Qf4tRhqRjecNqepCjwSIwoE3fX/J7Le9rAkZaXDMQ1CCZSM6dlPMIxBq67dQXqK/S3Vd
 b2CRoGa8wCuUSDIXxA5bkn9S7ECs0iFOFUlHGAyCPUeTwxJSCkmGWnn7Wmj8+Sp3VzPm
 6V9tJOiTAvMB2xkx6pfm3ok16bI8tbgj+2fBRvjIYkh2mUAzMg5eGE4t9oev6VCCqxk4
 L47C/iSr9HFMaVOznEtSUi3VTmaqXJWzonOytIVGvOiFbXSWEpbNAbn//51IERiHzHGK
 m5lQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSdfK5SYaI+ImrrpqsX8JjCKZksZnyBxqMVC3H7L5xGmQkR3gAzNns3d/HVuesISMzwANVcwA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJbLpcRCo/IMAZakoapbJJuB0WYuoYgLHi0LV6iZo/JBOL435OJ
 lOO0ZPJ49U0seq36VwHzmhyyxUo7HSRuguQ9/OXEw/+XPBpJpck0bOxFpQsdWUfeCJkkrJDyaLX
 AKnkDyYHCWvDVfjtdSgsQZm/SPAqSdJqvsMqbmW4B
X-Gm-Gg: AYBFou1EbuuNax42MtVslxSGqSDretThQxESwUok0UrKN6pIwCWlDza0A1Ak96OXhYX
 C/Y4VKFBinAL5C/3WEh/HHnhOlN1flCs3O7Dc+Fu6gQDVdOF7UiO+w9FH1MpGIVunJ+Xld+2RQQ
 ocL5NFipopsPfBqEdcCNqKsN253VjP1F0TuEypOi8SVo+XuSVRV5vmbKahnfceAMtgI1JPpMkqE
 KTFUgXej2v5WwndVnk74NrQCWqlE4eD29um6KXS8zPGt9by0RWoa5AV3FxoIIzLzW8bSp7RU484
 VDqlKytLafuWE/aGDfbjENn6VlVAG47/G6RqnShjElhCEjoTL/8Pur8JgGClXXGhfR70WJ4y5hr
 /9wwCXpmc+gHF+p8JxnKnwNgE1RYBcliTmNo=
X-Received: by 2002:a05:6402:658:b0:6ac:8e1a:2b6f with SMTP id
 4fb4d7f45d1cf-6b44311ababmr6038913a12.12.1793033499602; Mon, 26 Oct 2026
 09:51:39 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:51:37 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:35:16 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:51:37 -0700
X-Gm-Features: AclHuK8KN1LN1pWyEa4O86wBVCj7Jwv0A7rKdu3h-7qyIKTwsfXj2np2caw4bvs
Message-ID: <CAFLszTifyAjp1ce-Gb=Kp=qciM+1__3QsLbj4WhXBm1EQyE=OQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/6] fs: ext4: check on-disk indices before using
 them
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-10-25T13:04:03, Ana Bobillo <anabobillo3@gmail.com> wrote:

> 6. tests in test/py for the cases above

Not quite. The tests cover patches 1, 3 and 4 and the range check in
patch 5, but nothing covers the triple-indirect fix in patch 2 or the
(n - 1) / inodes_per_group change itself (the last inode of a group).
A sparse file reaching the second entry of the triple-indirect block
would cover patch 2, and replacing a file whose inode is the last in
group 0 would cover patch 5. Please can you add those or adjust the
cover letter? A follow-up would be fine too.

> Simon Glass's "ext4: Add a few overflow checks in the writing code"
> series from last year checks the block size and the table sizes in
> ext4fs_get_bgdtable() and ext4fs_init(). This series checks other
> fields; patch 3 adds its check next to his at the start of
> ext4fs_init(), so whichever lands second needs a small rebase.

Thanks for mentioning this. I'm happy for this one to go first and
I'll rebase mine on top at some point. Or feel free to resend mine.

Patch 3 reports its error with log_err() while patches 4 and 5 use
printf() for the same kind of message. The ext4 driver mostly uses
printf(), so it would be worth picking one and using it across the
series.

Regards,
Simon
