Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19301606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xsYCWv3L;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QkjyKSsf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C67C240A16;
	Fri, 23 Oct 2026 00:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lor7H-yv7ttX; Fri, 23 Oct 2026 00:13:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB6DC409F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792714391;
	b=k6Us1goN2RjsTUwvwHMbbBU4sPcXSjVBDffifCIkMNdcHO75beN7I/tmAqkJFyHalJW4
	 gmSa9POMQTKMGLvSrRjmzWJ5veP2ZIqIpZ9e9cjOBvChwdQAcBmn8Y/4tMkHcDWaT2Qmx
	 XYdFAorXL00DogKmJQsiLnE7cHPSUhiyGdMA6Fg//PXkWdEYlWEmF0c2PPtbbz3WXyZrj
	 UOtmbo4m+sLzmAgQPEJqhJpCV7U5uw5+7uqHBS11KFU3/ndfpS5GzqXE06zqAqhfpwVCZ
	 +Z8Do0w3Tns226WAw3kiRNI801pHbL4xZOhweBjqPMqT9fJZC9+NgWEi7/PKrBXii4w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792714391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=C1HTQwY6YLzwBrr6E48gH5sU+21ZVroFSdTnBHEgtgQ=;
	b=LuxpPemqbGIl0DrDLKT2mi9o2NuT5KzTfVggczvSfNG3eF15PJG0dzZIVMpMK5Seycyu
	 ACWmEfD19tnWQtTFXi6lw9qaYFnzVEKgq4Q4FdMJJ37KB0fM/EE7P0zx/AcBmMjgUZcIo
	 SQXoZx4TMbzzxXJcc1zKh9XZHfm/fHIrCWFOX8dVkkTh8zWeel3II7HDgBV1rj0eYFiO2
	 DLoCuT8EM/CxgTtnbp3Sb+A9igDaEC8/8MfPJEazzogY1/rzD8YiuMEfDMZgzVknUvCuc
	 Z8/UF/u7APMT5ouZ0IWJC/yngT2BUV3K+xKN4vfF4+d65iVslUAjU8FiraXTPhC3szw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QkjyKSsf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792714391;
	bh=C1HTQwY6YLzwBrr6E48gH5sU+21ZVroFSdTnBHEgtgQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xsYCWv3L6iOLMiU/+blDw/dspcoUyiLTJ07fy96lg1Zq9An/pzMQKHhcEKKXNmoQT
	 YYJMZjCC9zhdd0ax5w/8WifuCk+UFX5XW1vnkouOJBarTAPTNQ/PxgLRm2darncUCx
	 ONsL4sohvBmsx3OdThWa3jNYonwDbtyEQNoxZTM0Ia4E3uuY4HnLNDlJ+AUeL0HzDX
	 x+A/QPlk+vcXrmah+qyWG3cjEJRYkEmL5acG1pjAxCRC75A95Rh+1v+9a7/PXMd1O2
	 kGAJhO281HmNJzY0KuLFqD8qNBCWcEe08ccGH4JccjpZFNF/JVUZi3lkr861XkMvhG
	 8CWQApz8ER5zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB6DC409F4;
	Fri, 23 Oct 2026 00:13:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E36644D1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDFB5408E8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id APxoj9XYdIVx for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:53:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E5D7540889
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::22c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792713217;
 b=jkYYJwSUxKfEgeLOLTnB9ULEme+8RBv0WWiTVgNQZmk4JtzFQ/ntuzdGRTEbQ7n/iD0F
 b9qZw8NKjF28n5b34Emus4/JHDErsOCmW03KfmiEvvFuqCDabYFDc6sXT+4wXI1JxisqY
 gPSvSU3VMdIKysyl9rThUUM6M3MQ1xx2FNb+S3GgOFy+Uk31Yuz9H1r75pLfHb1TWF8va
 3S7Ew0MbJ3DeimtqTPrvjJCpbr0aGOqjWoAZ94V8WSvj0nv65o16HbF0Pmh379nXROX4x
 YE3kNjBbVHTQJ7jz4mwTDRosebcTnLB+/NSR2k2ZFFKx6VjjOMPYug1XhkxujdIo7Ig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792713217;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=C1HTQwY6YLzwBrr6E48gH5sU+21ZVroFSdTnBHEgtgQ=;
 b=L0rww9hqc6nRnQz5AInYWOxzhf8kl57+X4vQhH/4SrUtdPX+8pU2YHM8IbprGfl0B6G2
 SwafMWenLfYvFlctK6jWmYxp8uEEozzN9rhrqXRugEvq0pUDb1iXCyU16CYBoE2sWx4nN
 2M1rKtbjMW+OXL6J+m6kSVxUPp/YVxLGJv1DOK2ehc18H8Ik8lHG2xxub3Y7Mt+VrZ9NU
 B3kc/oZTDetHeB3sAdDHWu6XBwUvMvwjyFsqZM2O6u6vrNDttfhb7zvaxHlqJml7J7t+e
 5mPSqBs5TaElP8KC1BDO85O9Bo5O+6Hao9LIjO3Y3mRFjxB0Yg//Uw+fTAPTr9wGAbg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QkjyKSsf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QkjyKSsf
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5D7540889
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:36 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-539a57a0b1fso177367b6e.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792713215; cv=none;
 d=google.com; s=arc-20260327;
 b=B1omms2a31aHn/Ux44nPJGPuUUjPtKB7+yX6xa0vaNI7dCJ/O/mcM73tYl0a24Gmzk
 GuUiGMJzyvkS2o+fEgeAO05HnTWq5kcKoZqR1DvbGLVxPk4u2cSXQsuTZUr0HSOG0aB+
 PqO8CMYOy4tmsGemC8ci20FHjdwdIJDmT7tMmZoehTjLWi92kDDZHa8L9WgVtnZnwUc2
 7CVjZLXPOjdDdkDnuCDyJV9FVlSBmTMSHww59oFu5NVaqt7c+Aa1Ia5gbo12TvwsUkIv
 zGW1Rb/daMhedf1GECDmOFocj9FvINf1u7o8HRnyr45EP+fKwQkIsRL6ffWSGRioUcqV
 Y1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=C1HTQwY6YLzwBrr6E48gH5sU+21ZVroFSdTnBHEgtgQ=;
 fh=u4xG2KwCOaAX3LACWiWdBW7foS+n2V4JX1MkoNaREaI=;
 b=nlxJDrVTGD95NkefP4EkoTm5B6TjJ38DfF8uAFil/h6Mx9xr7wO0TMcgK0GskD6EFN
 qASTrq2kxKAtIDWybDMVejpG/CfHJgT6P0LuaAw5ymX6ZcQChBlau1XxbCk8gF0AtojB
 k9194oOzyKJd8qno431+Jzl/3VtMvYq5QvPYEiwoJgQar+L/HKdZi0jT4Wn6MYEelbA+
 q8rW2dmZlQmy2MuGbiqjN0JZD7NsYNQBkO9o/D4DsXmSaONpswNY+c9VAGn3M+vCD8zR
 QwSYaWD8iQczHGp4of+vOACqBjx6ILl7MJ8ReQ77gp81b7EvTYn6GDhVvefILDpx4iYc
 nohQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792713215; x=1793318015;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C1HTQwY6YLzwBrr6E48gH5sU+21ZVroFSdTnBHEgtgQ=;
 b=QkjyKSsfuD0zO5Zwh1UEr6We9/ZeOk5UMRbe1Pntcm085NF9O+WwngLCdfO89smhh3
 MLgPU8T0NyWxA/Ihpje3otwFHruZXu2YwnLCQJSPdG0F0LIIKC2u38K5yKPydHUqnwRh
 H7crFzEsUfvGxDPt48PWSpZDfrnVXYeWfzcZQfQ9rt5U4nwv/pEHXUE5gVScpAYTZUD2
 n9iXmB0ArGBLp3K80vvqQSsowU9qBI314djt+y+Y2g2GblgFxy1wPKyCl0FzLhWvK8/F
 C9JwNqPF/UlJGg79YTpns76hIODxHigfknjUqKyRbROt27dK+vj57vBR/PKdTXrn/SnD
 bdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713215; x=1793318015;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C1HTQwY6YLzwBrr6E48gH5sU+21ZVroFSdTnBHEgtgQ=;
 b=IoETK98LogFHKaGru9MMTNDIM+K2cP4vnOwfHtBVopSf7PXn2gSTvNqwnu8eD7i4S1
 hJ/bsQ5S3WFNDY8TIyjAO1fnZS0NO3XcUN3sHk/d7ral9xWDcKu1b4cnfeC1Zvno0fre
 olmx9M/gD8DAx/48HCZhfJX1WuEyta3OvWV118wNVqnh6X64qZlJ3wkC6URqotdETbvc
 3Ko1dg47eAAUErdttQHNTl3GB0RhPKhaINtcg4f2e4YlQjcK8jTRNPL7KS1lFqh92d8B
 WFdrmkZwH3JhFGxYUhB0UL2WU1wDj+m2C5SMi7Ohkhb7J7AMXWweF3G7PnI2f7mP2rnS
 eZLw==
X-Gm-Message-State: AFq9FYIMtpTzx5gHh6BfND4kffKgcRNl8jZZFC3T+KLOmvceTBTLsZDK
 WS8MIBhEhQWX1P9aZcHbcMPKzMGQzpH4cpeb/3lF9hCu12s8v8sjIspMI7BIVbIXt0vMQ/6NtNU
 1fP3oBks9wPDJ6EwUKgV3hpRc1dObBTCVwha3
X-Gm-Gg: AYBFou0n1+hE7maQstHpf55cuxEJCWkbiIYPKQPeWm1XGpEhXt+1ODFX4TCsNbbZBXq
 HGaIMqEMHND4P22g0OlYcHyziFOT9449NClI7Agdncn5yUBKch8A64z4SK/wlxAUk6DEriWNTL6
 am0lMtMS4qF7vI2Ru8np8XHjRI786Ler2fX+3GIriU7sz0yXRYXdliYpGssJXU2q2uSRDjL/w+A
 YjOPsQw9DF5ouD6635WsReL8iTiJYtskYst6vxO/n7GDbBcLzI1SAGWNeHn9+s/yzYNO3Fk/vaB
 BBVzaHvZj3RMikl5IKWPlHzfiQPIh9oo/tbrl4joNKugZv841Wo+Up07dy6si5hcN8UVo65lRrC
 YOTSX8SnvFRStna9yVlDS/nGs
X-Received: by 2002:a05:6808:1a0a:b0:4e7:bbc9:adf9 with SMTP id
 5614622812f47-55be80bd62bmr474672b6e.13.1792713215616; Thu, 22 Oct 2026
 16:53:35 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:35 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:35 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
References: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 16:53:35 -0700
X-Gm-Features: AclHuK8JQwVG16Ey3Uv4JcLSQO7jW_r3ORFP7oyiPdnwJcIyxcKiBjR6lE-UQaw
Message-ID: <CAJnxHsjtsqbRzM5F+PW_mn0pYVvNqHg+K-H46Moph7GgfOwTEw@mail.gmail.com>
Subject: [PATCH 2/6] efi_loader: capsule: check the capsule header size
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: multipart/mixed; boundary="00000000000066c3cd065e76926e"
X-Mailman-Approved-At: Fri, 23 Oct 2026 00:13:01 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000066c3cd065e76926e
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--00000000000066c3cd065e76926e
Content-Type: text/plain; charset="utf-8"; name="0002.patch"
Content-Disposition: attachment; filename="0002.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 84afb06828b272ce_0.1

T24gdGhlIGNhcHN1bGUgb24gZGlzayBwYXRoLCBlZmlfY2Fwc3VsZV91cGRhdGVfZmlybXdhcmUo
KSBpcyBjYWxsZWQKd2l0aG91dCB0aGUgaGVhZGVyIGNoZWNrcyBvZiBlZmlfdXBkYXRlX2NhcHN1
bGUoKS4gSXQgb25seSBjaGVja3MKaGVhZGVyX3NpemUgYWdhaW5zdCB0aGUgc2l6ZSBvZiB0aGUg
Rk1QIGNhcHN1bGUgaGVhZGVyLCBzbyBhCmhlYWRlcl9zaXplIHNtYWxsZXIgdGhhbiBzdHJ1Y3Qg
ZWZpX2NhcHN1bGVfaGVhZGVyIGlzIGFjY2VwdGVkLCBhbmQgdGhlCmVtcHR5IGNhcHN1bGVzIG9m
IHRoZSBGV1UgbXVsdGkgYmFuayB1cGRhdGUgYXJlIGhhbmRsZWQgYmVmb3JlIGFueQpjaGVjayBh
dCBhbGw6IGZ3dV9lbXB0eV9jYXBzdWxlX3Byb2Nlc3MoKSByZWFkcyB0aGUgaW1hZ2UgR1VJRCBv
ZiBhbgphY2NlcHQgY2Fwc3VsZSBhdCBoZWFkZXJfc2l6ZSwgd2hpY2ggbWF5IGxpZSBhbnl3aGVy
ZSBhZnRlciB0aGUKY2Fwc3VsZS4KCkNoZWNrIHRoYXQgaGVhZGVyX3NpemUgY292ZXJzIHRoZSBj
YXBzdWxlIGhlYWRlciBhbmQgbGllcyB3aXRoaW4gdGhlCmNhcHN1bGUgYmVmb3JlIGhhbmRsaW5n
IGFueSBjYXBzdWxlLCBhbmQgdGhhdCBhbiBhY2NlcHQgY2Fwc3VsZSBob2xkcwp0aGUgaW1hZ2Ug
R1VJRC4KCkZpeGVzOiA4ZDk5MDI2ZjA2OTcgKCJlZmlfbG9hZGVyOiBjYXBzdWxlOiBzdXBwb3J0
IGZpcm13YXJlIHVwZGF0ZSIpCkZpeGVzOiA4Njc5NDA1MjQxOGIgKCJGV1U6IEFkZCBzdXBwb3J0
IGZvciB0aGUgRldVIE11bHRpIEJhbmsgVXBkYXRlIGZlYXR1cmUiKQpTaWduZWQtb2ZmLWJ5OiBB
bmEgQm9iaWxsbyA8YW5hYm9iaWxsbzNAZ21haWwuY29tPgotLS0KIGxpYi9lZmlfbG9hZGVyL2Vm
aV9jYXBzdWxlLmMgfCAxMiArKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvbGliL2VmaV9sb2FkZXIvZWZpX2NhcHN1bGUuYyBiL2xpYi9l
ZmlfbG9hZGVyL2VmaV9jYXBzdWxlLmMKaW5kZXggNTRjMTE4NzM2Y2YuLmU4ODM1MzE1ZTg2IDEw
MDY0NAotLS0gYS9saWIvZWZpX2xvYWRlci9lZmlfY2Fwc3VsZS5jCisrKyBiL2xpYi9lZmlfbG9h
ZGVyL2VmaV9jYXBzdWxlLmMKQEAgLTQ0NSw3ICs0NDUsMTQgQEAgc3RhdGljIF9fbWF5YmVfdW51
c2VkIGVmaV9zdGF0dXNfdCBmd3VfZW1wdHlfY2Fwc3VsZV9wcm9jZXNzKAogCQkvKgogCQkgKiBJ
bWFnZSBhY2NlcHRlZCBieSB0aGUgT1MuIFNldCB0aGUgYWNjZXB0YW5jZQogCQkgKiBzdGF0dXMg
Zm9yIHRoZSBpbWFnZS4KKwkJICoKKwkJICogVGhlIGNhbGxlciBoYXMgY2hlY2tlZCB0aGF0IGhl
YWRlcl9zaXplIGRvZXMgbm90IGV4Y2VlZAorCQkgKiBjYXBzdWxlX2ltYWdlX3NpemUuCiAJCSAq
LworCQlpZiAoY2Fwc3VsZS0+Y2Fwc3VsZV9pbWFnZV9zaXplIC0gY2Fwc3VsZS0+aGVhZGVyX3Np
emUgPAorCQkgICAgc2l6ZW9mKCppbWFnZV9ndWlkKSkKKwkJCXJldHVybiBFRklfSU5WQUxJRF9Q
QVJBTUVURVI7CisKIAkJaW1hZ2VfZ3VpZCA9ICh2b2lkICopKGNoYXIgKiljYXBzdWxlICsKIAkJ
CWNhcHN1bGUtPmhlYWRlcl9zaXplOwogCkBAIC01NDQsNiArNTUxLDExIEBAIHN0YXRpYyBlZmlf
c3RhdHVzX3QgZWZpX2NhcHN1bGVfdXBkYXRlX2Zpcm13YXJlKAogCXVpbnQgdXBkYXRlX2luZGV4
OwogCWJvb2wgZndfYWNjZXB0X29zOwogCisJLyogc2FuaXR5IGNoZWNrICovCisJaWYgKGNhcHN1
bGVfZGF0YS0+aGVhZGVyX3NpemUgPCBzaXplb2YoKmNhcHN1bGVfZGF0YSkgfHwKKwkgICAgY2Fw
c3VsZV9kYXRhLT5oZWFkZXJfc2l6ZSA+IGNhcHN1bGVfZGF0YS0+Y2Fwc3VsZV9pbWFnZV9zaXpl
KQorCQlyZXR1cm4gRUZJX0lOVkFMSURfUEFSQU1FVEVSOworCiAJaWYgKElTX0VOQUJMRUQoQ09O
RklHX0ZXVV9NVUxUSV9CQU5LX1VQREFURSkpIHsKIAkJaWYgKGZ3dV9lbXB0eV9jYXBzdWxlKGNh
cHN1bGVfZGF0YSkpIHsKIAkJCWlmIChmd3VfZW1wdHlfY2Fwc3VsZV9jaGVja3NfcGFzcygpKSB7
Cg==
--00000000000066c3cd065e76926e--
