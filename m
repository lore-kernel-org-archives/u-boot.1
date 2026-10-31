Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892E606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OX3MuRg4;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QA8//TeQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFD6F40A82;
	Sat, 31 Oct 2026 14:06:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2jDkBAufMVfA; Sat, 31 Oct 2026 14:06:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D82BA40B01
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455561;
	b=rayqYt3yaZTs6Crc5sjBNUegibhfaxE5sNUYBUf+9QZnz9cOUEWQbSZyY1+jeKRYv5Il
	 oPN2J/V2pbQrRkLb1AiMMkwxU/iRI2I3+K013ySdsjKPArzmAjhnQVURt+I8Qdtrfy4Kr
	 uMnznt+Qk1txQ4fHDzxEWCHLutZoHc/KDIg6w4sP3Q+ru+zt3Wp3a/EU9lJ0b+/smGR+g
	 1zsPj0jH6LP8VIHTauycjRAP6gCMFNQGDSmOIE91aE+yt9jw7xGtekylw2Pv5VrEt89t2
	 e80yxQen7Qo3ObdA1CArT//nKG2wCWDic1t8j3l3W2NhLmtxOHikRQP3zUIaooGD+Eg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=u6RBdCFZMrNsDIqv9G+f+lOU/6DqddBctPvnKC2qQzM=;
	b=CmYwtNUBHV8uTFJkNLlHFcvcF2U0R37xAng9pDnKEYxVtSJecZyJVI2ii4R94JkkQh1N
	 QEdmaAQHpRV0qGJ5NugLBoj39gnMaP+83mTzt3wC7nHKWzoUOofDPKDapRz1zlWY2+rNC
	 Oe9AwUKJYdXssUb4N87BmbwgAqb5+SptrJwQKWZvlq7iHt9n72cUC1yWd6OKLYl60UHeO
	 js4u5VFFItiko0BvcPTKebUpoSq0LxBgG+ZEwbRIT+j9Prrk7q7A+nAFeOtLktPYSbrHH
	 XD34CUjzleOxN93cW/YfgTCkuwPZn5vEWYPUx557mgfoUcDT8tOAPaWjS5H9G4tvj2A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455561;
	bh=u6RBdCFZMrNsDIqv9G+f+lOU/6DqddBctPvnKC2qQzM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OX3MuRg45u1o6c2Itwrq2yXegDbzl/fxondw0TIRi742wqm0k6Ks8/W8qw5WF8PyM
	 I27CJzXpz8xcTLGVsWe9OoyMrDmGonktIPgC/BwSzlXu9O3lD4kG46osE/6iOvSMJL
	 YqY1Std8avKPywgR6tRZyjEt6QwsAWSSFVjRKl2kpH9EYDzlFdSski5bPGvH+iQZrh
	 W2hCXA6Anl33HS6BC14gGoYTiQZP3omOITM/ywCPGscNim2HYNMYBiMMHf9navOa3h
	 w7dC/W792R6bkw+ROVjZQSxtpbwzTUXtcZVZ9PvfFenqddEKAj2YMerXyImDhnRXuk
	 7SDwusZEFUx+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D82BA40B01;
	Sat, 31 Oct 2026 14:06:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 99FD1411
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BB336061B
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:05:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8TBJgWAyM1jN for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:05:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 99F4860614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455559;
 b=Q8ubcHD9ZgZLJlN8mj1jg0eCeAN8ajDMgKrbfsAUoSWi4zRIPgIRenjTHgBzCB0E56jc
 ps70IjvyP7xFEyLz37YdcTZlKShwnIynNCKd7Vek4k544h0hJvvEbXJGPhvlEF0XHB6aM
 jTiVB/iCbPNxG8D7mokQIevBCI7QVdIoAm4isGdBC4Fxh4lg4fNQN1Z4mxX50d19V88Qv
 59QVoCf9VbcCFXSEK3nXw5840nMssm2wMLukidt40g8sSG/tJ58fV095MPFyzjPTivopU
 uueBCZK6Dx9GcH9iBUq4XFq8+m9rGqxubwI4TxWUfZLcNJCGBndSUh8ZZe+6BegipEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=u6RBdCFZMrNsDIqv9G+f+lOU/6DqddBctPvnKC2qQzM=;
 b=DP9PjijpEyKlyIuUcwPbv4DmyzMSeorZ+wtd0osVYjRIBF6j6jGK5xpGNYvN2L7n9Eaj
 RakMoItx1jOOD9lf3X7koRGL6EjqtRhaQzbQrnWPKc9kNp63LcEvI9PsL90GBgXz5Yo1w
 gbmycW/E+ACIO3DgxMbVQWq1pX6AGqoBUiICRXreTkuUpPkHJ0ZNr19rl1FCEwyL8HsED
 6tGTvfj37N+Dv1Fd3GnXr5HI2+qheR9lKApFinaJX3GAQ4BPE6s20NxnkuhwQFVfgvTMH
 ftvR/iS5fvTXOvfuW5vjUDZHtLrueG3ToxhSGno7wXVRjzx0pn0lparlcav7wDQ2zTQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="QA8//TeQ"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=QA8//TeQ
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99F4860614
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:05:57 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b1a86c0316so2105352a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455556; cv=none;
 d=google.com; s=arc-20260327;
 b=Hf40qwkIR5L4E20YufI6ithStqYvoHMQC1dscV93egZXX2eZ4iPdcwUjPb0lPG6yYQ
 r9/sBO8akubLd2KgjXzl7VVa6jnHTtMEqxNuHLOxNNObQyrhOkXcIJgks34rAO9/6oOq
 7/NikGRhNxP68jBlpT1gY6PAJi5y3PylJZpGrQtRDCFeQ6Mz76xOQG1K0BIgjr8cIDeo
 fJWVoigkxLj378oPfG8WQg10CZqSnVy8qFJ3aLe/3OQA4dyc8jPhsbwj/9o7Yc/kTPeU
 osE33ILJdRZQ2wIA6Qzd1meMDcVBdmT5emtLMQPhHYmJnkMQxjaGqWsb2rYacSryH4zY
 ZQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=u6RBdCFZMrNsDIqv9G+f+lOU/6DqddBctPvnKC2qQzM=;
 fh=q4UtTlsQOlSccsIX5MQ5WG6Kq6O93bNp3TYypsN+Rhw=;
 b=f5fqJynO3stq/63EMNrRgR2JmTFHI4WGOENJn2vHUFQEKA7XP0YeKMego6ETQ51s+S
 YyxohvrmJtdH0rz2W3JQ2Q8dzw+pO1kF3G3KcUmeGFfRgK5IzFdCAJK6t26JqPol1Ep/
 bivXlKnwfqQR/TSW8DRz9z5S8u/CredQy51t8B0kV4DW6oiguBb5mFlVTjBcUu72ZoOW
 wI+e9sh0f8C3qj8fspWYrQwX63MYgP8hTdvaVrzo9aLN0KdTTbOLFzD1qu4JaUpJzcdt
 NQnKzN0ZHaWdY/IvrVNUfFMqqK5TAfbcA1wLBFVi1k1gx64K0t7A3pnsyKzCAAn/eiO1
 cmzw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455556; x=1794060356;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u6RBdCFZMrNsDIqv9G+f+lOU/6DqddBctPvnKC2qQzM=;
 b=QA8//TeQZsvZ0iHFldsIFP6cWTVa4YHAzWGfN8/xwAykY4iDcdTkaFX1j1Nk4dbupE
 0vFvX8T3rBzrjXxoMB5ZKVSoXr/JS8/E9x7LtXbiBIeAXSaI3Ruj4WNmaCZzlfhK3ELd
 7w+XC5q3+MHkHefQyM88bTyvthv3DPjMyhiAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455556; x=1794060356;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u6RBdCFZMrNsDIqv9G+f+lOU/6DqddBctPvnKC2qQzM=;
 b=mJFyya0yH/c/iD/dj7OAni8Vz8AiciRloWJR/BXBd/Jl5NBprIas49PrHXmlwkKNJP
 347sOPRljxg4Nm6YvB1aBw8r5pJYYrtpRlvWfQVa9DzCM4KsCP1YW3cEQQe6L0TorFrk
 iCs1RRcF/9OaxTsrU1FgEVk6zbBfZtwfBP32VYrLQ8syC1BZ6AhgCvAs2hwMdzc46ha4
 dj+mL5cZ4L+L6HYyoWO3am/c5QQ/HpVcqrtLxwis9AkxhnD5djvjDiLjc3/XAV/cJOhN
 Meq4gbA3Ow7aVEuqo+HUSMHHph9l1y4KuHjwT7WeuVVX5Sf7nunuOZeYgN1S06h7euX5
 rLYA==
X-Forwarded-Encrypted: i=1;
 AKwUvByaHbpxKF07DqCLJEvNlCVSJvYDy4roxApmjpKeKoMM3LOBTyx2xVefc8ylmR+lI8WCgOvsitw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ3dfBNU9SIMaVj6AZbhgWID7wdL1NnLKeP/M8BU2HBsHztFSEk
 uMY2yqQ6quBEmHef+r14dbeAFyMHpUoXz83qqdT5DDLnoqE9t4zQlnhUPkQLfX+tpEDncLD9R1R
 SC2SuYsCLkUOGZ0A0DMzmr8eeYqVqt1Q/nrNpp+xo
X-Gm-Gg: AYBFou3jNa4Fb/zu0HQM694DpGpgv4rqR8QzOYBfKjPVtBWGiTA9P1VIVmMUEO2SzLu
 DESr9j1FULSEip+4bdDNiqP4110govujwZ/r/Sapp7QQKipuVo0akaosmniN3pw4jdzWFHa9tGd
 V1GpTBQb2TzWUB10CyTC87UA8aHqgEno0zzIcJrnL+V5CNwfe3gHnyAESCNhxmmQrdtwSv1siBe
 9yLPKtzNVifGx21yz2NItg5LI68dRKEE2t8q7gRxHzVxPxu+4svtTVOd4yGQIBp6+WBk7HHUNb+
 q3aZF2q0wurD86C2BDIGAkVyGbZSR8DMzy7ZuxXLmEz+W2CG04HKHiShBrI/rsmfaBftdgxAaF/
 +1oL/MipT+cmTzUaESBB5gsSd9A4gmD96w4MsM9IfAPbS/1ebSFzdBtvW+pobshRACFVdEzw=
X-Received: by 2002:a05:6402:2348:b0:6b4:d80a:3043 with SMTP id
 4fb4d7f45d1cf-6b4d80a3491mr3472263a12.3.1793455556048; Sat, 31 Oct 2026
 07:05:56 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:05:54 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 06:14:30 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-main-v1-2-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-2-b5a878627107@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:05:54 -0700
X-Gm-Features: AclHuK-uAuxkpHls2JgdZXDPmLiAtLkSs_015U_MbJ3nYmJ6US7Dmj7XsWgbt-o
Message-ID: <CAFLszTi8kS_-OpK_wOwW4m8AQkjVVMwVULJ+NTa9vUqJRmAhfQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] bootstd: rauc: Fix leak of the active slot name
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frieder,

On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> bootstd: rauc: Fix leak of the active slot name
>
> find_active_slot() returns a strdup() copy of the slot name, which
> distro_rauc_boot() never frees, so every boot attempt leaks it. The
> strdup() result is not checked either and if it fails, get_slot() passes
> NULL to strcmp().
>
> Check the strdup() result and free the copy right after looking up
> the slot. Use the name of the slot from then on.
>
> Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  boot/bootmeth_rauc.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
> @@ -347,6 +347,10 @@ static int find_active_slot(char **slot_name, ulong *slot_tries)
>  				return log_msg_ret("env", ret);
>  			}
>  			*slot_name = strdup(boot_order_list[i]);
> +			if (!*slot_name) {
> +				str_free_list(boot_order_list);
> +				return log_msg_ret("buf", -ENOMEM);
> +			}

The caller only uses the copy to call get_slot(), then frees it. You
could pass priv to find_active_slot() and do the get_slot() lookup
there, while boot_order_list is still valid, then return a const
struct distro_rauc_slot * instead of the name. That removes the
strdup(), the new -ENOMEM path and the free() in the caller. It also
means a BOOT_ORDER entry with no matching slot is caught before its
BOOT_x_LEFT counter is decremented. What do you think?

Regards,
Simon
