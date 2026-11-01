Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B71C606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DRG+ygJ0;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=O/9zybis
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FCA7405CB;
	Sun,  1 Nov 2026 21:26:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vaMwkuTkmbu; Sun,  1 Nov 2026 21:26:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72BF5405BF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568390;
	b=IWZFyNbsiaB7TEUWk6KnbZ3kXex3imSDb9b/UnJeoLL7x8f3iI57KSta/5ovfZz86jnr
	 H2r5BPGc+BW6+NYb8HT4rIWvvvnK2UQwfGjXtUC4juY401JDHBog+o34jl7mkSB0AJCyH
	 zir01mbmhFMk8Je5nFo/8KZyJzVMAn9/Z1fwF3a0kpAHqSrRBGIzeMgYENQhpVaF17bO/
	 bFAdfNyLMTDZbqnVJgKN/G9QuyhxuF4jN9OFyN+X5962IKVitaPPtCFyaRu7mp5NlwQ3e
	 x/VYh8DhNhrXmV6rejjNHB0Sv4pSzNFG4YqsBBG5T0dl380iejMzJes/18bDZUv/Q7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568390;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vWs21K7sSB+7TdqXghr3YC8dnisHhPhmGyEZ0rIBP0k=;
	b=QlaGVZ37DUZgpdYdYYSKFkcNzCR8X3xyv1xPvaDucZ3YGtVPcjFPHx49qBHeDY2UthAF
	 b2+HKCMMvKmQ8tCsqW3Fd0sOVVZbSk+kJ8lvLk5WVH+5nR8D5omq020DkP19nwD4OQTbP
	 5ykuaWTHRyKD7rxcp5ysGIslLJD3Eyn0HcMif4StZUj9zSuaUVCQn/pirIEYR4uhiDwrf
	 AztldPyD82jtgawcX8ZJ1YW/V1ex8qQV3AiiOLbQgun7aHqubSKgv0ZsAb3RQSWx0JHnU
	 s51zXEjnukTEWz878uVOrVEVqX5+X2aj5t4kS6gVw/K649ddjuAjVuxEehCTXnRq8bg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568390;
	bh=vWs21K7sSB+7TdqXghr3YC8dnisHhPhmGyEZ0rIBP0k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DRG+ygJ0tXj53BoG6EOu9Um988HaGmqydhyNOsPBFhwI+AAipVbfQfrySC7nk5t/N
	 XlK7+/wJnRjAwFU4FnUkVY1d2FsSl0GJbvu8TP8fIrOr48c4XRAtkTryZB/qQARMre
	 /Ci9Sg7v137GKklzfs4+aDkxtPP1dB2cBCyzg/th+omMj8jFlvIWOh/ULM9lFvETmU
	 OgpekAYrMNJInMy9Kaj64z3Sb3cD57toqPGX0JtEEh1OAPdJPTuNWxabA/JaKM8l9u
	 FGRATPnl9CHzWzStiBZIPS67hWm9tz/UHZBdD2YT9eYbBEDjczEDAtr/wzh3I9cdcS
	 UJcAUsKsGwVSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72BF5405BF;
	Sun,  1 Nov 2026 21:26:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 15C102AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF6AA80D97
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WuoHMk1A9DzL for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:26:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5BE8D80D96
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568387;
 b=hTRZ7jo/X74Q1PWZa8IEHwGCb7uA+VFk0+yVyK3CHlLPWYTp8loixqYUqO+uPVjvgjf7
 4X6XbM4pqtrFX4xkkbrYqK1/kGhP9ZsfZtaZpJFcqj6WYvZCm9KyAKB31hxqIhyusb0CV
 AooULzSZkMLYQ+92dAO1Kx2tg7wR5Wb4LmXVxfhMFj7iw4SzmSWhtfGK+DhXL9llpUqxq
 ZTF6zPZJWUpDOznXeRoBocRkEzm7TgpnRCnABuI6x4aDdgRMIfEZBnz4kUld4KZTekCCj
 Z1Ce6EyWhl+BQzevtolQutzTExCL9y7QGpQa6h4fT09/fQwWWmn5jhyMb6ZYuuXkg3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568387;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=vWs21K7sSB+7TdqXghr3YC8dnisHhPhmGyEZ0rIBP0k=;
 b=Ujg2Ly4bpXqhTEBmULg4RoOCr5sNjeIALKeNQQFRlfosFbHhoVJQcRabKl0K4FrszEZi
 0HZfmwvdYpJl2FjQanjUAv0IjFwZ80VU07Y/ntHhbYrUdovMXvv3LnKi4ERp5W88tOgLv
 ZEyLNBHm6SYpwFEg1o+Bm8sfNrDcY92WRPR8HlSVYR676UMM+g2Y31cqZPXHKKFisr6l0
 Vkgh9R4tq2BJQRRsBJaQ+9gTfgixRkJkfx7BJuQBJBlQC5JlJnnWuwc5ha4opUN6ZuPj6
 G2Id7fxRXJNWK09DFBEiuxpT7Bh8U9JUsXyJcWgfGcdbl0k6jPgWY+5w+fyYPOFbq8A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="O/9zybis"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=O/9zybis
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BE8D80D96
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:26 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-823e4047037so1827467a34.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793568386; x=1794173186;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vWs21K7sSB+7TdqXghr3YC8dnisHhPhmGyEZ0rIBP0k=;
 b=O/9zybisrc/VhCi0u+nCvlXTg7B75Ls0TGE/6wTXmyDwKjy2E2ik9RwZ6rTFI2Hz8i
 1cXwFKCQYNboqhbIfG8vEsjFIyXXiozN7mKP7D6UdaTMogrDtA3y6m5Bf4ty1gHGfTtf
 jxhsWcq7tFv652b7BYx8+uCjug+gSW//dhEqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793568386; x=1794173186;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vWs21K7sSB+7TdqXghr3YC8dnisHhPhmGyEZ0rIBP0k=;
 b=N9+xyvTVg0bBnSiNuWVj+UI7ISdCyGUBQ3rBLi8BxtK05+1ZA0eV20emPeaRMhllDq
 hPbyk/si8S96hIz60VDPsQM2GRIv6WONtjoQF+gCk4C7Lsr1N+Q9FJPdfO0QK92B5eD2
 QLd7YsUfntD2rWIn+hhtuJFf9/R++hLOn6Z0x4tRNl2/CSZ8pngtLK7V3Gu2dTRPTmrA
 bZ0M9IthiCVOdVb4gnycl2HA6smp4/EGqH6yModWeIL51yDOIuhAanbXMAD/gesyWXnd
 kVU7M3hVNEZByxsHQaOTFwLGA2kSQ88TVNKEQHiJ8A5noqyW/Humptbgh1gM9Tsj4q/5
 vLUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzANiIz9STZlo1JhCCSjUHmn9mKSHrQ6r2mhAEjbyeoqcpc921qQym5VP/dFfMmjqwBmCUyFVA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJfvURkPQzVaelBmCjS2Hayzsuua6UrNnjHCC66cWLmfXfUliAg
 /y63uLCuWTpAeKEKhCelP7OnKwEXrushAq9GqzXbD48O57z1x5vMD0Vwe4AS1HmCKwKEdYlVIBs
 pOqyj1mRvu3ri
X-Gm-Gg: AYBFou34ejLPN/iIHN+WgwZQj+3K9m97+kkl6j+HONgFY6/W5eXPeo7WRS3uJnDYqs1
 OGRAulSe9RFh2UG19Qy/l1P5AgyUGsqpl61lAOkT2xDtNPoDjZ6NZ4iU1SfSJkcaJB+bE5yplNX
 wFs/gdZbVopSZ9BOWCitnEWQyFVjtUjoaAwI6SOhzUDo2TGVEz3FwZMuy7JUsjAvLjP3ZuRC5el
 mH3Jj6VgRg1I7WWPlq1Nr3X6tSL88++cK5Gmh2cI3gH9qYwxU1LaK34JsrNUvZT5d+xGxgfYXa9
 W55OJKXWLVKaWfDXUnZ33shqvAEOtSxTFBcVpLtUJp6/YedE/Gr+GTQNIuefsbjtDNVyQGwvfAB
 8cc2yb28O7+B30KZL5Y4B0zP5oQciRo/7flpwznh9IdUdAIK5MR+SfVxaIG2Jf7XlrAIQLKE5vS
 kHRjZouAg6kFpqsBv5YjGkjD62IpVmuULWUZKGM+oMa9bhOI0BZLM5RqBk6KDsrP5B6JxQCu1HK
 hYyjoBSSP6eCRpBDKinMYTMy/Zy/hqxNwTRGKNgAjR3xi7gsK6/Jr5AF4MqoID/oCNoseNapTxE
 AavV7Cm1xD+o4h33IVzumc2v3CPtTialhaPkz1eLdVXBZOFJnf6VRVu8Zc0bUIf4Zx3KJSDCbW2
 da0k9zKjn4dfFwnuqzo400fnvUBi8gVhbUb4kfvvgOuEbLlA9hPfCNK+PSxgek5gZwKWX9KcDDN
 FJlfnBTH3XgRfnnang4J6rgPC1T0SNHikS+cgDlDHjCVoYrdcwpM4=
X-Received: by 2002:a05:6830:6809:b0:844:ec25:c7f2 with SMTP id
 46e09a7af769-85d363bea96mr6275525a34.13.1793568385757; 
 Sun, 01 Nov 2026 13:26:25 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545bfebsm7405744a34.4.2026.11.01.13.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:26:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.u-boot-project.org, 
 Fiona Klute <fiona.klute@gmx.de>
In-Reply-To: <20261021104356.2084625-1-fiona.klute@gmx.de>
References: <20261021104356.2084625-1-fiona.klute@gmx.de>
Subject: Re: [PATCH v3] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
Message-Id: <179356838449.224230.1621297608152676145.b4-ty@konsulko.com>
Date: Sun, 01 Nov 2026 15:26:24 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 12:43:56 +0200, Fiona Klute wrote:

> CONFIG_ENV_WRITEABLE_LIST only restricts loading stored environment,
> not runtime modification e.g. using "env set", while the Kconfig
> description implied otherwise. Describe the actual behavior, and add a
> note in the documentation.
> 
> 

Applied to u-boot/main, thanks!

[1/1] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
      commit: 397e81859325b063ac942dbe977e145ac6fdbd38
-- 
Tom


