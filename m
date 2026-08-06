Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23641C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6816C6081E;
	Thu,  6 Aug 2026 21:01:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TMD5cLq4a9XS; Thu,  6 Aug 2026 21:01:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0A25605CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050072;
	bh=HaovFAst5KvozDgMM24zApuBJdvlbsvy2YFPKMTYiRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZYeneVlyI7NdQ/3KA4jl8A/YRAfZGgZZ/oKYbgPryy6GrsxDoFlJWCKcYCT5FveVR
	 TSJqjBFB/7l+n8V2tzgUI68U4JhWWpzsBtjq92yK0W68aYTs/oq7hvrF7MmQyluWhF
	 iP465kLXMd/3r9917O0ARNEyZfYkGr2PFkvialGY+j/suCUNKYArQQoxhBp/Pp1QB2
	 vtc75zj3ROjRGRMeCo/xCGFQvH+PNO69koFrEH8xeoyaMcySs0Ku6LVr7o4MF8wxCu
	 Yw07NzXguIujOuLVxMdNpuxA/18WBUbpDyM/n9EDkUbyT0/mA4m/OA/LO2G2epwMjx
	 WWh5Sp4jdRaZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0A25605CA;
	Thu,  6 Aug 2026 21:01:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EF7D9282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D588640226
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:01:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g4BtQXxaWe9R for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:01:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BC4C2400BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC4C2400BC
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC4C2400BC
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:01:09 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso3992057a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050067; cv=none;
 d=google.com; s=arc-20260327;
 b=ESvtiNot3gsPFCsvNqGKzWOp790NDGCv7sc4aVPTiVqg1WO5/+SHFBk/nqqwkkx7yB
 g8SJJew2tZTxdest8F5dxSqiaSuJztSF+rnqzWhwe/PKJcwZY6tAxkY9hAwvlJdb9ygY
 J9ogziMYmf9UTXAEvDZF0hPapVko6ignGFfPZORSZfxCjQ8he6bC1beNkyb/U5EJgOEp
 EEGqk7UzeyBZHtk/k0MbAemj9OIh7/b4G2/ik1o1BQFG77ET7oehbHdR4SuosrFjn5B1
 ySZZk4GWeZPtGNaaUiZ0SE2z5/m1YbGbGnxISuP5HNsZsY6J0DSiq9MuhkRs53FwQnwG
 hK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HaovFAst5KvozDgMM24zApuBJdvlbsvy2YFPKMTYiRI=;
 fh=7xxvTH2sQtJt5Ay+3iwadnldSn0Fw9o87gYzUPDaOIA=;
 b=WRI9oeGV3maF36srnlolmsM6W9e6jMkiqLlyATTSh0+xjNLNdJZA2zH0HH/r0vlQVs
 Kde0xtD0WjHKDsfEt6jF/AhD4Sl0R2+GE9W4sE937a6j5e/AudwKyEyt9yMsYHvRtdgf
 j0bzvi1bUUVnsR6sfSHfifqhwX0ouPBdduCkg+H+G9wxFZjDEuBMXGZlmZ1UmprdqIHD
 kw0VEqbl8CeTRfomORv6XoLDp46II7qGgwGI5Vro2Ct0NjNUKHtrMmF1S/k+0Pysg7k/
 JtmKUtzZt+l/zU1TPN5yZ5SoRNaM78TgVby3fZD3G3BG9xp9oupYDjxjBkrFGTPG1QaN
 K+XA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050067; x=1786654867;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HaovFAst5KvozDgMM24zApuBJdvlbsvy2YFPKMTYiRI=;
 b=VbGV2/LIXsPKhcCWK44EwI8x25dmCNPcVaF+tcT+WeEQnrfjU5AhU3KMvMUnGseYJZ
 NVSoWXnbFQLQbJotyYeowsz8SHKR4RThoRwOKCrWl/pT4yB2RZcrNjmI2PV1Cdg1QfuF
 oysFCnWDImjYi+zDYThHVNLZId+w59A3sLPWx4pSIhwGtsuU4c/SghXlo9co8+F/6/Ux
 hGZr55vVBwANS9acQeXGztWh9PqA3Pc7XreTJ1D0hvjNdz3mt7FJZqhKxW2XkmLzu8EK
 wmqrjSwYzOfBVAj/B3bSev7hIVXa+byANt5D0SUwoofpbHVU9ktabLb7zKqxffTXqQX7
 SbiQ==
X-Gm-Message-State: AOJu0Yy5DCOJ70vB6kOHWFe65YGILRGM7g0wZJRRG0tDGNcs0U6pnf11
 Ny6jklf0O1LqPB1Mch35l9Otzpc5jomc6Gm2SOn+1w/CmkMWdBfDQv3q/7GXcQ+SvG359T5G/xk
 M4u1VxNcRokeD4u3C50OserIyJfxKk9aGzTK7Dsfu
X-Gm-Gg: AR+sD13hN+ED7ztej1BaHSFNoYjZiEsvsXQOrp9pwwWFsg36nE6zigL+l7bJflxc3Zg
 1qkT0cNbmrfL9W+XWOZnaagSlgU2tzG8TCOx1fgJIebrgbRSaFn9kRKMT1oFB/gTtyA+uUfXUYC
 uYEeWCt8mzUELcZgRs30HasX975Ih7DoUwxuPJcbmrGDKseAjo1+LcDZnm6f9lDlh0h24B2KuWS
 f7kjIF5X6K1TSmWo86im6lFqP0ClUpwjxgrcPoVv6d4jSulydpzWUHYf/GLOfJsgef4Yk1xoXQh
 h2uzfmhgwj7cDNCXRU75lwOeLCIjZAyGHsH3Z28XCKk=
X-Received: by 2002:a17:907:980c:b0:c20:3679:a2e6 with SMTP id
 a640c23a62f3a-c2039b4bf40mr873190466b.10.1786050067606; Thu, 06 Aug 2026
 14:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260806133724.336755-1-mehmet.fide@gmail.com>
 <20260806133724.336755-3-mehmet.fide@gmail.com>
In-Reply-To: <20260806133724.336755-3-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:00:54 -0600
X-Gm-Features: AUfX_mzgtnJBnwWJxdq-8P8dDrCCJORwMWE2C74Vl6X4ZUYtkb3DPWdAHjtqb3U
Message-ID: <CAFLszTiB56ePBVEwLYjPZ0na4KNNT=dXqCW-UOWWh_oB7hsQwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: cmd: add a test for bootd
To: mehmet.fide@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050067; x=1786654867;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HaovFAst5KvozDgMM24zApuBJdvlbsvy2YFPKMTYiRI=;
 b=PjoUqzaG0Qabv3W533CVV9y2VwBuPNOsh9cfWFqx+IoMiSkdlWxVpH+CUhXVf28eAx
 qkq84lvom3Ic2U9DFfH9QYoJksta5Fq9cA2bvnzlfxFdybc27HngeWb9UaTK1u9rlBAK
 br7cwNtorIw1DaP0dNLmFfuxk3b+qYSq+7K1Q=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PjoUqzaG
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

Hi Mehmet,

On 2026-08-06T13:37:22, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> test: cmd: add a test for bootd
>
> command held in the bootcmd environment variable, and the return value of
> bootd is the one of that command. Also assert the recursion guard in
> cmd_process(), which is part of the code bootd carries.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
> test/cmd/Makefile |  1 +
>  test/cmd/bootd.c  | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
