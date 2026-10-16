Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770C1CCF2C4
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30AC140A83;
	Fri, 16 Oct 2026 21:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OnRJU1ophg_O; Fri, 16 Oct 2026 21:47:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C92940C2A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792187239;
	b=cesWa/Seqky3n7UespphupHSLvXaXn2M+6kXuVNid3crbovb09Lywj0tPBIZ1Bmo3xUx
	 ox5qs+WW4fmYsM+mtN4Nt6NwLhyO21ilvxY/OOpxVcfpX2UFwufw9sRrzF0IANoDoryTY
	 c2+cSMAo2oleOuAMN/4fhv+QqDKyOjzqOhoB7uaD5PlqzQ9ByaYrKyVcLDY2T9N/M5mZe
	 xGq4wZSi4x/mStl/uBpXQnFgHJUK3rQ4vntT3Pc2dq5fMFMpg55DOk90I7+Q6z42fyCZD
	 mfJqE/V3IfyHV542OkCH0FUXMWuR+rf51N88eRudMn9yfdd7h7SaDnJlU7SMUSxvhsg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792187239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=skN0nj72+UbmMHwePLOt1cbAKj7guEEdHwDjODPucXc=;
	b=hXxb02z0eWvzxVeHLQ+WI/ExksVZbuUR6S6cVne/Q5mL3iUOZQV4jOCQ3XRzHoj96Wf+
	 tCRzakrNK43mqj42oIphyGvIbuIS8PWi0vPeGbeqNk/wD0+ZK6J0Uw947FoioJE/hUEJ2
	 CEdW15F7emoRgQIbraQu+NAf3EhYqDUJiki4YWBluLZPx9MoevNtfFGL3QSPxOkAXC9Rs
	 FNDN0ncQ+YkMSpV5Sm1hDcOMeJQJRR3Sag7n2U757Ke+Al3LBEbFhQoGrQi5GEbW4s4eU
	 Y2wHOWZPcg/QQTMOSEjIe83mGlZWjMY1fmvvBpk/43gpQFOerT50tkplJ40EYOdyAWw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792187239;
	bh=skN0nj72+UbmMHwePLOt1cbAKj7guEEdHwDjODPucXc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQPo1kZe45Li/aW6mCmY6y1ASvUQ0NagqK5rw1VJ480mZC7NdHIKqt1OqjZN9nrVe
	 ov/DrDRQy0GpWISlM1YDpuuZlqXDn+bfGA4CK24VBEehix9bS1ntWgB8xo5He9nAnL
	 QQviP91JOwMT8irxXkxDqRHVqC/t5qm4VP86II2QkJ1XhILzH5QjEP10zs/3Z4VhGs
	 DlNbLUCqA1CDE/XUInSrGekIm+aHQC6aEQ/nm7AlwJhsiy18mpto3OijC+D+I5G/eD
	 yU3pEwn/vuAkcBG7ybl3jg16Z8ZvzGuxWSfcXNKiWyWRGgBvR5tb1XXVDUFmuhq9HP
	 nUUCqACAPOPGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C92940C2A;
	Fri, 16 Oct 2026 21:47:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 507301DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E51E60902
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:47:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vz_rD0BZEZZ5 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 21:47:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 590BD607C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792187235;
 b=A15tj+4kn/M4ZSbXGTLmg889dAvJoP+5uPVwJPCqFExDtdzuQHmvscs9AoRRFCwEiGBn
 VXa+c6rgDACadwkKTB3btENLd3s1MtV+LL8kjvKi0KMn6dfIQhHDqKtToMOGkMAOpnpJX
 ikGTIOf94edAJEGUBOKisC+egDDIZGonPdxcXOivzv5kRzr4O4HEM4bDlkU/g9hTaj22r
 4V5oKl7kHaNyiXPhNRlBtcdOt7Af+y+XksGH5l3Vf3A0nwcAbVpZ5mwlA/yJOeYDB5s2I
 gMzi9cH4PcplRN4LIexHB0Zud8NucT7i34zOgTPgkC+ePWTQFAsSxeNBLNGmVSN7olQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792187235;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=skN0nj72+UbmMHwePLOt1cbAKj7guEEdHwDjODPucXc=;
 b=N5p23Gb0fL9Sd6aD3LcaPbf76XyflsOfV+/RoMV0yfT7AE5yPJwoJlUjkdc3WVjZMJj1
 3KwCyLnWb0dNG2kuuq9p875UEApm32tDFRmh7jgln35Z/MgfHs4fbzHLqqSPiYRSD0aAb
 sqHjumm3LoliAHArQre++FasUKBqJDXQBih2+Ua/tBNRCQ+GjaEE2WnDv/D6wf6lLQ649
 k539Ug5HuMai2ajfP/mFl5t1mTRiKqb4ofgdPEaRXcTqR/MSnK08QhMZ7p8Ew6XLACKsb
 xfrKoKE10D7Q4dz1HaCzHl5Q6fLPTbqtIsDnkunmkHq+hULD8rOIWRlHqJsm9dVl1aA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gmNOeuhF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=gmNOeuhF
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 590BD607C4
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:47:14 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c350db5a761so55276666b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792187233; cv=none;
 d=google.com; s=arc-20260327;
 b=BVSqgpPmwYuhW7v9Z5cHFkuUHLaaIuFYjfLEOSsbZUUTLauL1lw0ivRWdrE5i406K1
 tFrqRxT6XYsDpz9xgp3mmHEcV5G0mpynhP1jMnlLo74CrP5Olgsa5sNDSYgdAyeLAY4L
 hqEH7HAr0aq/tlJjf+QZG3h/zVxQFADnorufPlTQm5mDDmvM7XnoRmYFMEa6pblX0Og0
 142fa5uxTkG/pJpe8qbgtDVq/KaE9r+Vz66qOrizupNCPWZ1euiZ1uWrzVK8wCNsl3tN
 qYoAap9nZQOAFrYsRZwtSbDkCujMdhV8OkO+bB1AWTK+HtgxtQDy6G8Y6EiPmC2IVy7/
 kUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=skN0nj72+UbmMHwePLOt1cbAKj7guEEdHwDjODPucXc=;
 fh=yoAMRX63C+2C3kPsWrTA80wWFnNVpxFEeCHJbsl85mY=;
 b=IcsIiHHDS/lVVQOkzRzV9lCvfKmGWc+hNGdt3jMXexjCJC+MXzQEBEy28p3HXI7FQE
 zx8XoPX2hvgSUnFYbXDgJjrHMPVk+TGPF8f24jDWJEkGoPPEiLB2wIQs2k3UXGpUDz+g
 EZEGln6DWwFy/V3p/neNWZfnVOYEmJHxa0nX5ZDzKxa0VcZ0uEOnBDwo4sm93vNCQ/lu
 Bd2S6AFmhpxjCGUoTsO8IpMVaEx4AmBZ9aFlZZeNfLsiRKlntOLXgk5yREzKGYu7PipK
 /8Re+QTBqLonRkv5JWsFVK0uFtJc4xVWaWJRmiZvN4mbD6QzemO1ziS7wVDfYk/Rxpbk
 XUsw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792187233; x=1792792033;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=skN0nj72+UbmMHwePLOt1cbAKj7guEEdHwDjODPucXc=;
 b=gmNOeuhFjKIfSZysLtGGuKCUj/s6aV9Fazff4fM/+GTIUoDlandA+slqSUBKN8xCAY
 QVF4BJG/MDXv3a89jUWfLxWixk/zF7pawVcik/UMaTAwhrtJJAWN3L66X7VcJTSVzICU
 aNQrfrqPtsSrJuyPNDBP4E9UuaALqpTUTGLlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792187233; x=1792792033;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=skN0nj72+UbmMHwePLOt1cbAKj7guEEdHwDjODPucXc=;
 b=vj3ON5X05VbsrNlYxOltjQYydWWign8qld5T6Xk3CK3QLPiHwNhrz9+PIxAP03Z/+w
 XJD3tghnh9igTRe2TCkysFl20u2NiUQJyTW8Ax8G3yOwMf+TP7nmUPSiEiBcn+QNDs1V
 YPrY/4ade3Y7piLngpKOKVZbEcfaF/kGJa6x7ETp+LZr87tMkoAsijgRhdnISTaEvFR/
 DcXsyq3JHJZU2RN6ylWC2q2627C/GHJPjtBx3+4jjgXW/6aLvVFANkI2e6YtpZUL9Bfx
 492a6nsPfyLCF08Yx5ZS3hKZSPCpyERF6QKLNfTYeZ2H9hWE0ke9ULysRwRnpGCuADyW
 xkcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzE9Zj3kbcjNGboMmUvc8Hjwi3H75TTcDSfFRYSMUfGAlFpqXLzrS1yErmBNVJYdbAgDxZWFbo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKkx9d5zuGEFmGkhARaNluBQnAOg2GfbkdyrgbG/VABUvYAJ7Gs
 r5wY4sG/OWk2V/BGoULgokZB+0Rruw5py9pwgbPAfyaMhO7OcPIWi6UiwknOp6jV8Bem9om9Yc7
 kBCTYyDiqNcHu5aL/r2+e942Er9BU/1MvwrN4kAgM
X-Gm-Gg: AYBFou1UD6KksiSopekohZzTKunqcpEivC5aM+BRgYv2EupVgUceEu8oWHnpP2Rs4TB
 boIiyPj1ba5zJExHpZOXVODK1TCFaAEmgaIRQDoydbJA8RWBJWyyomTxuv71CCMPeMrlys6ssyd
 ZFSJk2oL5z4yRRlz8TwyrlZZBpBlmEpDtXd56JFVfO/9UxLoeiyM5vJufVq4BkuZ0M+pkTe4XA4
 8IBLaMaNQxBA8VswE/wSDbqIC1N6Ct6dL4NnMeYQQUln9dwyA/rsDD7/5lza6pq1Cc6dbwUfMjQ
 pb9hzWfoxom5Mr8yq1TKtoOri7mg+fjrbICcEil+yw9qZXsMa6KoGY0=
X-Received: by 2002:a17:907:c008:b0:c3f:dce3:20d5 with SMTP id
 a640c23a62f3a-c419e53bfe2mr88565566b.22.1792187232717; Fri, 16 Oct 2026
 14:47:12 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 14:47:11 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 08:55:28 -0700
MIME-Version: 1.0
In-Reply-To: <20261014190631.2232208-4-alan.tseng.cs@gmail.com>
References: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
 <20261014190631.2232208-4-alan.tseng.cs@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Oct 2026 14:47:11 -0700
X-Gm-Features: AclHuK-nk4kYH87guZqqewcL265peDrNXkfRq6ju2ByY4tauK2KKOQ5OxBXrPUM
Message-ID: <CAFLszTjdBkJUXKA0A7kOHDHn_cWANHW7_Q4xJJkv-mni6maeqQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add entry for virtio RTC
To: alan.tseng.cs@gmail.com
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 2026-10-14T19:06:28, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
> MAINTAINERS: Add entry for virtio RTC
>
> Add myself as the maintainer of the virtio RTC driver.
>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
>
> MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
