Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC4606A33D
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OCz+fgcN;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Ew2/SJN/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DE7B80E29;
	Mon, 23 Nov 2026 17:44:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L82Gs-yfHNnP; Mon, 23 Nov 2026 17:44:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 61FE880BD2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795455872;
	b=HvV++RKz0uSd0It+wdxIiFRpObd1v865We3dOzO3p13FP+nTZAZsCKdqT+auDDV1TmgB
	 mwBr73/Y5PLRg11Qiq0X6dQkJIJb+BzVB/q9AENOC/nHKLp2Meb3UX6XP6uOfMkMRfiZF
	 t+GIAfYrwo+pOrqM+ELeD5QmaWxhcbLk3ujauCekhMAzkFyNs9PEXRNBm8N28Y4MzODyP
	 vJQwwHPtedTD9xHLTlyAnDiRsoh3eYTtid7VcQtMlIzaTVd9xYhVhOQrgu/wYBWkKDVLd
	 lXtQCBY/nmufI5p8jGoUm6FpGRhkjZ/c6IgNoAP4mVJ9PR8DDhJbPLyHMzq5y4oGs4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795455872;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=15Wwrs3veWHabDTDkPjQDuMTdnZWL8DjfoaUOF3z9lI=;
	b=KIuBcIU5yLVPp8Pt1nldUqMCuoe4PYktgy6ZRx9xZs5hzluw8yyiig6KTc41rGl4JueR
	 ZJvYhN9fE0dhAiO1pxulBxCCMnfuXo+0qXTe8ihd0JyuFVXME303K+AJtRlnpjbFJnB8J
	 iXaTbZ0dQtqKn3bA6tF4pAMnzla4dOIPFrsK7Xtre/12qOOf2s6+iCkBPurxhDmc2T31F
	 ec82yYwdmdh2T0Snhc5jjhGPhH1knrYWk2812OVdtL9OkGtYdoVwzYq4V7uS7baDkszoZ
	 mqH9myz5bpqLjf3/9EFI6do66i9nNumBmt90Gl2Y+n7Klc5nkC5SPpWy/n96SkGFnuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795455872;
	bh=15Wwrs3veWHabDTDkPjQDuMTdnZWL8DjfoaUOF3z9lI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OCz+fgcN8FdsnZEGvPXUZF/73nFvqVnUuVh7wh13Xkr1mSBtwIB6/ccdSyd9SSO3H
	 MWBJbtbSxrSvgOLEnbZTjbYwujg0RX2YUlKho7icIumJqUEqjQ3eCQaUXB9eSLYsZl
	 vb6kJ4LZEccDOuzuIU56KrR3XuzUhmM0SQ3LLuVE17kPKUWrIMf01/x7SLe4ClyB3T
	 FRLPabOIoYkYKA/KapI+EiTSqOoNtzQUBjXSsZh0aotivSBsX+ZtGtVbT32kuJOUhd
	 4UA8SMqoUan+eI4Oj7UDCg5zCnqMV36Rmr9KTm8IaHI0bmx57gbAOlnptK66SMaAQs
	 /dT/Qe5SytLiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61FE880BD2;
	Mon, 23 Nov 2026 17:44:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E5A39759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB66D403A7
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qhlEFgNA-zh8 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 17:44:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0172240368
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Ew2/SJN/
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0172240368
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:44:29 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-862df509d48so2886851a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795455868; x=1796060668;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=15Wwrs3veWHabDTDkPjQDuMTdnZWL8DjfoaUOF3z9lI=;
 b=Ew2/SJN/qkhotxFc6wBm9gAaQQMJ27cEeR0WyAfUkQfYezl9jXb3JF33S2/e2WPTIc
 S9tdzJm/Jn4Q/FfBbtfyAKT3f+bsGTQt6NdPaT58wWueVHD3szozOXO+jm2hMsEGHVjx
 QuaODp65WBooNkWcnUiiH6LXmk4LFbmJVKoS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455868; x=1796060668;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=15Wwrs3veWHabDTDkPjQDuMTdnZWL8DjfoaUOF3z9lI=;
 b=cTq/oo0Bh+G97u8kafEqI4OFG1jP1HavfTq5Owwnrhwl2rPzMygI//CYaHRKsXgtHa
 unNtpM5EJQr17BetGTlpt80w3OnVZvnwrz/LPfdrjX4HvHqz2XPVdawGJ2sMbxuM2w0L
 6UZKFTdYGdF0jb+dUrwceSGth1BnHPLgsfisCuFO8dZ/ATfZ8QQFIQkof4nDpDgAEOG6
 deIn8WHiNcNLwsS5AVTYpmotKW0H6w/9im1R63LV7tCDckGA1hEg8cpDxDc2Vj+Q2FG1
 TUhgnGm16CwLccc7J/tTySYeMBkgE+JXKMCV/xuVay9a+Y5fpifiZ9pnz7qHP800x1oC
 flwA==
X-Forwarded-Encrypted: i=1;
 AL+hErEDwXbPp03thVXAo47O5tiqAtAKNIldUfcv8L3GhbrnjkMEr2pHdJvAQQvhsyFILN+cYnCGzlg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8R8xNg6ZhknDnx6NiTuRU1dghEJFuKARIUKUNehpOl79X0e9YP
 7DvB8INSLvCWHAcxU2h6Yo273UpLDfDH5e4KpRT4GgQ3hIeWj6vyt2IIaYSkWhBMgSAO4XO6+8w
 h7pFSlY/msSPQ
X-Gm-Gg: AZFdTZd58M/7fQO3wN3+vaTF7ba5Wh2qIf83tm+NkqOfP/BhFFQ0o1K9HSYduexV2iG
 9+SgP4kdtRxL94s9aiUx6S767ime7uKvZZEoJ9FTzyVzFd3u3XP9FuEMaD92/SSvyeSBj40EDkS
 NjQSa5etXi1MJMF0VgGZBt8y8JkJlvV8s2fZqcs2uZ0EISd321K8MsRPDUOc4LbskInM2EEpNW+
 5qqQirs4n4oxmfoI2XJ51KpraGHfO6TXlvL5rihq9aRoE5hy6gVmOMA79oRfhartjYRs1h/Wx2j
 T9j7RhVclIlN7x9MG+u5QVHWNOswfpXrAkzPTIHyJKt58p8WrbVz/+kV7L68lLKlX0f+R2tkH/E
 zo7mss+5QBzzdvaOv9Xg6Yc5ET4NV7fxfxuDUzTWY5f7Rj0klx6omVZmhAj+0/F1+EkGWH+x81L
 SfN+Np3+Q3PQt9IrbiOl1C79mXpOtZnC4RH9YoALr21gR2tlb6L0uqEOuHJZKgKaI2ZIRgN8XnV
 eugJhYbyB3yq3mcREQ+MAnZDnppQpESoX58sbQIiyJSkz+mgGA99xWjL0fhCGU0xWUvqSVTctde
 CHpPTY6cNheSFKjbHywW1WfCXYcYwE5TZd5sAjE2/cNL6Lw6EZR1ejY/ucAI4wEksyb0+ob81Mq
 dyeIMHAcr+03GZExAbyp6a4Qj3ThsYqHhiiPyn+ybaxHVJumXAPD0we3eBc88afQQKhxx/RPQET
 czuPKQYhnxJ42Fmk3H9X/8zd9cQChyvQ==
X-Received: by 2002:a05:6830:2b20:b0:862:a53e:6f51 with SMTP id
 46e09a7af769-86315674c60mr9999363a34.11.1795455868324; 
 Mon, 23 Nov 2026 09:44:28 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f3964sm8952425a34.14.2026.11.23.09.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:44:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Yuho Choi <oss.patchbox@gmail.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <5409a437-7317-437e-a9a1-4077762e8fe3@gmx.de>
References: <5409a437-7317-437e-a9a1-4077762e8fe3@gmx.de>
Subject: Re: Pull request efi-2027-01-rc3
Message-Id: <179545586730.3435953.10497718839446496852.b4-ty@konsulko.com>
Date: Mon, 23 Nov 2026 11:44:27 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 19:57:04 +0100, Heinrich Schuchardt wrote:

> The following changes since commit e578056c766d653270b14557c2a9d8daec414c17:
> 
>    Merge branch 'main' of
> https://git.u-boot-project.org/u-boot/custodians/u-boot-sh (2026-11-21
> 13:03:34 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


