Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D4606A338
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sFVmkUe9;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=GKu15cel
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE67040738;
	Mon, 23 Nov 2026 17:44:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O10-LATaukJs; Mon, 23 Nov 2026 17:44:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CE1554040B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795455877;
	b=E+/yaYXAqZPf0Xm8xm1sbTe6V8Fyu82GgACDd/G+G2vsa/0xcILoCQ5I4awQC2Iv7+UB
	 Eh9+JsIzHLo9oqDAvcyy2XqY14IRiD8WeAjrZ0LlLYvAqeWKsbcdwSFuD2+PF1KR7ClOm
	 UPLl38iEuchNg14TNZ3essQ5aVThtFCfxpkHVxLRTRS9BIHPpjRjz1+E967jDbFZGTJcE
	 qh+zVvQ4pr0lSYVvNWMV9zI/Q5ac5j67nMy8LvtKGFLhX6RTtAXa2vgbmAFLVTMD8e15u
	 B0bSu4CxGY8PShJh3JNDcbagc9dPwoRhjfxd9TkaCPilG/2Hz42WlpCQ5qsO9u9HWPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795455877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GpLYKpjecm1pjBPLTdlJ/0ck1dtcPDf8ZsvoPx8UrPE=;
	b=O2ScWHsDi+5MZ5fbG6SeAPP97wS8yiormNqHgVKWFsIlzxHdTwaF1J+n70oATfEa2p/k
	 X8EUcIFfzCvRNVbTxAcEW2bqwUj2CCLzxBBPXvSLrDOxkyIWumDYez3sakAj340oZ4Vlm
	 xSPhGevgPDk8cl5YV9nrbRPlLqy0A9cvo3zdDqNzzF36wGsTTI5gdYcQLTtb+ltNdLcOC
	 4EMflfJU+Z2P7vlKJAvbz34+HgEibXeCn8cKZ4c16oEOZ2AM+4QDgq3clxr3+Bi1m7CHQ
	 Y4b/j+0v/DJInbOuTxRJnV1QGxi0zIeDefAIB8sCC2LRFOHfQa0soooOm696uU8RZAQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795455877;
	bh=GpLYKpjecm1pjBPLTdlJ/0ck1dtcPDf8ZsvoPx8UrPE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sFVmkUe9hxhLZEh9p4xXjNYz8FVOnB9jE+DJhMT8JvKdTyEVkZGJqZj6sRTdZSoFk
	 wKJaaFFSojFChICzoSUb2/t5nQT+j9RkXMP3brDDwPrtq4ODHJPi6mxSMET01nVNhj
	 YkFmgVNrKC2Yx2rILlriEE49DPGYUcFAmbyqqAMy7l1cM+HY4t2uD0iZcE8fKjj2JO
	 gc3WOuv3nnLGd1cyd9dws1hsu+aqlr9Zutwy/MGRfOvwpuauQ79gd4HkxGs3SRam3Z
	 M4HalBma0VfWc6dR5JnR9ne2tnwRr80xXkAVhXvk3Lm0ZWhbd5n/P1P5KhIFS+SkFK
	 p1SmnOznoEvfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE1554040B;
	Mon, 23 Nov 2026 17:44:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E163B3A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D36FF605CE
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:44:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hBfJZrpcXE4I for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 17:44:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF391605C9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GKu15cel
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF391605C9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:44:30 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-8629fc8ad64so2030167a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795455869; x=1796060669;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GpLYKpjecm1pjBPLTdlJ/0ck1dtcPDf8ZsvoPx8UrPE=;
 b=GKu15celQjdGHVaTNEyRsH2bpllsBKUsqzw0O6YYdAeQno853wRf6D4UNCS/ZOozV9
 KjsLm2DPRFdRzj4s4dLsfGIcAm+KaeZJkPYMf2ATSuifBqSok1iBjS8VPUGQBWKfwE8n
 OgBNHvSn49NcssHsN/xYrgLvay4TqWwdPtNRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455869; x=1796060669;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GpLYKpjecm1pjBPLTdlJ/0ck1dtcPDf8ZsvoPx8UrPE=;
 b=0almJJ1Hw15U+VP0wcd2wwDYhlrw6JhQKrgx6iRfULkGMDgWlsuVpsRGmPyRfdFrjU
 drp9a592bPvHNTcHcf+36v044c5QA28IrzbeMyUfYesjTaBhukqwV2ewyeZPSwUQboN1
 JLWcz2p3LHi1V4Gdzy+TcetwNLlyeLiuhJIivTHjRpGfiP8XVPypxr7yX67AwSyfr/VV
 mQDIIGw+77tZbDsYF11M5jhU3+3We9BLyU3G1wAKp/H2aQswTHEErBp+66GR7306KmcS
 0ol2+i06/N0gqexUNCLoydKh4xsIdaJ+YegwPDX+O0lXYcU5s4NlMgi5pSuMW8s9qrmW
 /Hug==
X-Gm-Message-State: APuU4Z8/TWk4BfGNRfvH+QokD4nS0xPDvS5g5qNieuhzoI/Dl7zDzbho
 +6enxN77nFh/PQ56TDyj1ybNKXhL1K8L2mk9CSNKf4yrFKmpLO/GeNaxgYOUDEEGiTntl/SefrC
 UWf+yF61twwOg
X-Gm-Gg: AZFdTZdIHjKuQzQJCNcmdOAhljzhow80kM/P1kNjkmL+MfbA8MM5n3ozd2jA7rYmT23
 0OqCdoJbdt/ZdZMEd6eZSA45pPhY43blCscv2x3kluZe+ebKIsdgMM3ozynJ7LQpTqBiMtbMzbk
 fUFxSPC9dJjm58Iq+uuBKyT63zPPSnyEvCUKJyTzzxDpbeU57LkNSwemBQetINVBfrz31P6Kmlt
 X8l1Me62dZ85dr8Rr7PrYy2hyh0f/mvVeGH1LHjZWtVNeI4VZq/SRgVKBWRJCspvqW7Ltswg5b1
 0zxGFOeeWaGBuNIpost3QJwGsNywGXYWsgBX0sCUAOT/y7+3Y1hPkBdHYp/7isTRhOvw2ithc2H
 D7uxUCfKguHGT1/6nrpCHv9nkaJ8Mpr5t32TZrdHUYjXP/bgOD/Omssf+pWQ3WOx57sWrz0P7+m
 j0o9D8d9E18dxCYM66P3wGiEl5CgZXBJHIFyl49rLzw62J6m1tYw3ix3owdHcx+Spn7CS0Y3TJX
 HxSPoOMZq2AuR3qKPMN0ymbCKv+UFLaO0Omxqnj8qrhP2C5z+//Uy3GtGMWNEjZvr80NrPLMy8p
 C63umFngxNQhXMJo1abNjJFu3gcfJY2LBKGN6XnH5YIOro51sxR1WBuxjOe13tEyBoWm3jcJvG9
 uOE3Fz1QNEhl4hm8fyNbjMUZEPEz1Lp2Ez5GhCEoZYBeVccyp8LGyQHjeH01s6QZYtYHBGrozDP
 o9QqQL36ZKQudZnxo3idya1BJxLO7+aP6xCMmg7SDinq8+HRG4fCDy
X-Received: by 2002:a05:6830:680f:b0:862:c9e8:5776 with SMTP id
 46e09a7af769-8631549ef6dmr11839103a34.9.1795455869588; 
 Mon, 23 Nov 2026 09:44:29 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f3964sm8952425a34.14.2026.11.23.09.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:44:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, nd@arm.com
In-Reply-To: <3fd86650-3058-4fd5-889e-099b56bdb37c@arm.com>
References: <3fd86650-3058-4fd5-889e-099b56bdb37c@arm.com>
Subject: Re: Please pull net-20261123
Message-Id: <179545586905.3435953.9282020859498252115.b4-ty@konsulko.com>
Date: Mon, 23 Nov 2026 11:44:29 -0600
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
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 13:31:34 +0100, Jerome Forissier wrote:

> The following changes since commit e578056c766d653270b14557c2a9d8daec414c17:
> 
>   Merge branch 'main' of https://git.u-boot-project.org/u-boot/custodians/u-boot-sh (2026-11-21 13:03:34 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net tags/net-20261123
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


