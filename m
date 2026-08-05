Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321C3C55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2D53607EA;
	Wed,  5 Aug 2026 21:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Zy5iSBAfMcI; Wed,  5 Aug 2026 21:49:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7644607E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785966593;
	bh=JIIfK1SPEkMdvth2tLwuE0YsXr8m74o76i26OpHFmqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V1dPrfhhG04BLl4zjgsDr5Jnjh+N14DEckPD3WOp3ZbEAQV1rL0V9Vu/ZThWo40NF
	 G747d9M6ZgsiIuZSIVrX0irkTB7j/KLLTzp0rjGSVy15coyCI0uLMDGyRvY7hA30VK
	 BrEYs+GDd/kciq1tIMO9ggRCV0tgedJ4Q+sAVYX9aYjE7xqxHEQiVV5pLc3GGLwwvq
	 CvVyqZzJ72kKsU2WTHslES+mgNAB/JyGbirrqb1mzvHxeeHRvXKmDwmITO8abm5CYT
	 jgZBpn3cuYs/mLef5psJNsfziSclbMKxCrOVzsDYcPXjEpDSbdSPFTPx2tNAzBec+F
	 3TvzpxKIAUCig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7644607E8;
	Wed,  5 Aug 2026 21:49:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 53BB610E
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45F9380DFA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:49:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ny596leTf5Ev for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:49:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6580A80DE8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6580A80DE8
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6580A80DE8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:49:51 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso540454a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785966589; cv=none;
 d=google.com; s=arc-20260327;
 b=otEE6jZxQNQn44+Gml1C3ANcDdfPywkEMss+8N+3MbrzYdSJ/NEFWpNqKyX5uoBRq5
 /yzwirEpsq1MMeoYvzl5iN6RDpND3vpyTAsoV7rvhZHalpnfRcH0Vwl1TXNKyJeboOSp
 OkSj3ZyGNZcY+jDD3shM0k6/FtK2eXJooYKtEz3xHy2dhVcdzEkX9kALl/2uwd6SuecV
 9xiqKzS+W/eJy3CB5EV3kAWqo7vkPR/TLqYsTzEGlAcaB/McEGmsdSQfBp05t+n5IlHb
 uUEwRgLpdbTPsKWimnCHOfeUswtjnYmYKZUf1Nfn7Ai+e08XGxuph+KwCrjHkkXgHFII
 Nv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JIIfK1SPEkMdvth2tLwuE0YsXr8m74o76i26OpHFmqc=;
 fh=eybldZBXeZ25kcSUWgn0EFj7euTPyUYAWUYWgJkJ5MY=;
 b=J2PCbPso1Sq4LiZWBmBVZa3J6a1s40OkraY8RaEzxEtcKNuW1Ny93KBRFAyAXigIRD
 nqCRn9Wy6vuw7C+XJDV0JD2XfvUtUMMCZMHvOqnQaDT/enSQHOaV82PucOsi9NmdphEX
 59U2Opo1fLOu1wjU39mUOUpqL28wVSqkjCUWA8IdxqFWFJEoxs0VwXe/Kgmusd3K8Cnf
 RhNLw33crcJsg7f7Ba29roWujeFgv5YBwcs/ancL4gYV9wh4mlq7qn1I4SOt2NepGQ6K
 XzwZuYam08fSfiCZ+FRLxYEUi8s8KSPih8i/LxJAuttH6UImtVJ1tO1odbWSrSj01I06
 lszA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785966589; x=1786571389;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JIIfK1SPEkMdvth2tLwuE0YsXr8m74o76i26OpHFmqc=;
 b=Q98WV3Y18pfUFDxu1WfEjasF19wzkoAnh+l8+XvPMbKOfnZXV41ExwAGWfd8d/xAxk
 FosylZMPPUoR2PGYBOLyuME6n0n58HKcSeHilp/+qoczGsGwdZkExWUnxJTYBltJ2GaI
 FzLzw9UfG+ZnyCahhSdBKQhSiEIBtptAynqnr/oRM+uw/5mkg4RAHwcSvUGVmtryvC5p
 18YyDoP9SF7MPCxI4p743EozUDOo6v7M8KvYjXvaWdaTdJhPcWSXlp4kQ8W/XZcdesbf
 Tz7PASfd/5uo3JGZrGc3HH6Nmj+FxqLzYJxp2zv+qoDBx3kQ8dGjW76HcneUK0pTkHdC
 O/jA==
X-Gm-Message-State: AOJu0Yx08CLr7UEd8yCU4yItqqH31hd1sujlAaQDd/Q8up/+q4qGiroQ
 9hw+dHF9syEpCqXpNq9mjVNCGfS0RjrySCAV+qfNPm0JmN0FxxyHhIJ7WylB6B0hJoD03yOfxtH
 KI8YKBfrgNvCJnyDWnPy0LATe4OgSaSXZOAJBKCqD
X-Gm-Gg: AR+sD13OyC8LV5VLnMAcsrbipnDLnjC7ZSOXjgNz4nadd1MF59W2Qzbw4NAZ5UZ2jav
 dnICcyLNqWalkOaWijsNua7BaVZrBriMK/7eVnuQwN9ASR3tSdRo+mSjCUDMxuRImyu6v1BwBJV
 x55ptY7k44GFO5vDVhkrURCIvbjEAA1S1NaszTBKa6wMyX6XnlxTbaKWREYOIsiyD8+L4oWPWyQ
 h69VKEMZdc2KnnTwCvFhuGrAzIvAEuJUs/HWfGxKoqspVWzxdAnNQac0DeiI9CFcy90Pxrm8kKa
 esFF1eFZzTsInpgtcIXLh2oyDKkK/CLmohhb+K1WLAE=
X-Received: by 2002:a17:907:60c9:b0:c1c:2253:7744 with SMTP id
 a640c23a62f3a-c20580de181mr120281766b.16.1785966589442; Wed, 05 Aug 2026
 14:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io>
 <20260730-b4-fit-ext-data-hardening-v1-4-4a6b91e37b51@binarly.io>
In-Reply-To: <20260730-b4-fit-ext-data-hardening-v1-4-4a6b91e37b51@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:49:37 -0600
X-Gm-Features: AUfX_mwVRzB3jlfTWWjg0Znm5qSm8W3dVQOcirWN9NNee5TUoJJ9wH-OouvqqtU
Message-ID: <CAFLszTgsCJXAnEkS2eUWqwW9iE3Y7_XithnDQzaNiVnNr18X+g@mail.gmail.com>
Subject: Re: [PATCH 4/4] spl: fit: Bound external data like U-Boot proper
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Francesco Valla <francesco@valla.it>, 
 Anshul Dalal <anshuld@ti.com>, Randolph Sapp <rs@ti.com>,
 Binarly Research <vr@binarly.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785966589; x=1786571389;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JIIfK1SPEkMdvth2tLwuE0YsXr8m74o76i26OpHFmqc=;
 b=XZSlGOiTyGqGi6e3DrwGzlGthAiHdvDMp6hSKw1oZPBcIKjJD9UeWVMcppTyApu+Jt
 1pOc8iS2rNSBLb6m4x6HX5X4xCl4TZLsO68w7PKoqItG2v5xfe3hZ1ETDlA1wBq9fkxg
 pOiREhc9snJYxaHWz3ecVE6d3ac4L3uZ86Cbk=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=XZSlGOiT
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-30T15:03:40, Anton Ivanov <anton@binarly.io> wrote:
> spl: fit: Bound external data like U-Boot proper
>
> fit_image_get_data() checks that the external-data region fits in the
> addressable range and, for signed FITs, stays below
> FIT_SIGNATURE_MAX_SIZE. The SPL loader had no equivalent check, so a
> hostile data-offset or data-size could make the read offset wrap past
> ULONG_MAX, or the destination range wrap around the end of the address
> space.
>
> Add the same check to load_simple_fit(), using the block-aligned read
> size and the source pointer the read actually uses.
>
> Signed-off-by: Anton Ivanov <anton@binarly.io>
>
> common/spl/spl_fit.c  | 26 ++++++++++++++++++++++++++
>  test/image/spl_load.c | 23 +++++++++++++++++++++++
>  2 files changed, 49 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
