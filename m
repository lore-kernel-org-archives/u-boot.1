Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A62606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uWE8ZLKm;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=b/PF+cNA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 167EC4084B;
	Thu,  5 Nov 2026 19:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vD_Hc6heCD9o; Thu,  5 Nov 2026 19:03:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 533B240858
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793905403;
	b=BluIE7yc+1SpvReCEmvyPTAecYLLM99HpKEvFuemv0AEvcpv64xtoTf6TSaox01bqjAC
	 Y251NYUzW5kxlL4udQ3JqYNDx7BpDcuMSx79rUYkWebudxjEgku4/Y1lqAlvRSq9NR7xs
	 PwMmQMFkfqO6OU0gMngXTYg7ljqZ3gbNggjuRefYqyhBQ5yYDtVxuesgjYie4bh99Cy0H
	 kf7OcX8X+kSfWmNpoWkyKpJ5K9RPXGbsdjZfqIyvNT1A8ea1pB8UMHuPRA1RNr+OkryGC
	 5n8r1yYpxqkPUUd2EcTT39gZdaDZIdBZcf+0Uvmo6bHvE5moVr1hwuTn+0B7CxJSqDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793905403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WqURZsLJFGNrYmGJyPaj/EUrePAx6m9j8ZcIlEdGEfQ=;
	b=svqUuxKk7tyfJUbwdbDo2v7hmVFFeAOMw4y5jdhNL73TGKaVE+NUqONDqPE6w6c25d8R
	 26+kAV4peGmUFr6hSIJbsu5gBNuga9NK+/057KKDmsMvY7xDdTNvzaBurEyLhTxgvGnxl
	 3YZNE+I9bVzvS+tbET+mVIb+C9U30Q5CRwOm0cbvW+lDq0mkL0tmGitLa66kGjEjpPMGS
	 FKa3xbPopRGqpcCXjnQ9Tj8m57BGcyi/W5/QUKLuJZkMe4MVA72EsjDByIDHOzs5FgqAG
	 496qCGAPrMMoutVCR2G3s9+qNadIaztCrmTQ1DXdcyv7Lk4pQvPEbO45O+PPYl5++zg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793905403;
	bh=WqURZsLJFGNrYmGJyPaj/EUrePAx6m9j8ZcIlEdGEfQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uWE8ZLKmu7wdC+hR9yGbXwYhoLkIgkVL7P7bqNzvjO3IC5lNreRiQIBBfSWxmND00
	 3KO9bPzAxiisPAUi1mrIem9eI/1eu6bgEvb6LHsqdyc7tIYLc9GtzBqhBXJODXDPKg
	 JrZGzL9xFwYbuv63XoteDd1ucYGbzirfTfw4CkZoDi5ZopAW+Mmv3vmqmMhu1mqeiC
	 NaLJ4SjslqOTkS+VqZwNqAPjS2UckvjUpT/U66OcqUwo3MCClT+BsW9WRvWwDLql9u
	 q4rUcHvXbqxPADPcO5gf/0vSj3S5rlpyCAHQjsV/RmTimtYslzZsiRpe8QVYppN+j/
	 XizWgJBMLL8jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 533B240858;
	Thu,  5 Nov 2026 19:03:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1591B7E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EA8460884
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z40E-OJT1zq3 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 19:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C9D7560833
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::3;
 helo=mail-oo2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=b/PF+cNA
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9D7560833
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:20 +0000 (UTC)
Received: by mail-oo2-x03.google.com with SMTP id
 006d021491bc7-6f436312596so932932eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 11:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793905399; x=1794510199;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WqURZsLJFGNrYmGJyPaj/EUrePAx6m9j8ZcIlEdGEfQ=;
 b=b/PF+cNA/XXGkbFaHa9n/qMWvJe+srlsourSzrQxVQTU6VI4MZXo1LXCJ3DTOl56Ky
 VxGeVrfNBJAMg1Pt4ChiY+s+ZUVaXtX6uZyGqrkdmuF+wot10a0nhB5ABmZoZjifq4Dt
 sayE5Rvec64P0kEh3rBrp8jboegVtJTuMVjuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905399; x=1794510199;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WqURZsLJFGNrYmGJyPaj/EUrePAx6m9j8ZcIlEdGEfQ=;
 b=D3tgdWtfoh9k7jAXYxs6wuL7gJ6Lpkg+82xOqeXprQwo9awhADsEepx90hAp+ex/aL
 IKRj3qgFnfG1pV/4Iq6CAxPqQAeWvViKh9sa5omAUpR4uJoyCs4tV7uzKliX3Fozwr2x
 2asmtMk78zgF0TjcCvtA11SjxQvUZ45kcSvXIylm0yan9+vxOg0JKnO7hwdiZ3YNJSwZ
 9LOyRVEpTIYVysa43glTPoT/84ckr8dKTjnHApQssUAHpiC5LM8/ADyvb6heGXZxffyJ
 B6C0OqWMakLdQ0L0z8pImziaq5KzIX0UIqC1C+hCCWNbBHIdfWI7iR80wa8UpNnrnEDD
 Yrww==
X-Gm-Message-State: APuU4Z93sFmpkAUlyOEf1qU5G6/LbSj4kJGtL2JRrNGqvDwQY9hAqBt0
 HMAJV0uI99YSZ6ZfyeEXb4xv1kcTnwhBXl9ds1Ax3m8wvar8/BrGxw4HkVstPZ+ydCCOzYdXj36
 L6VKgoXq8hA6Uwow=
X-Gm-Gg: AYBFou1hH7lPZHsNTWeS0bulpOjKlP1sDtiq5MNmd/xb4VJk/gNF6kOC6BpCzCJIiLS
 zDpna37y5WziaDTN0+jTPznzQGgD394NxJ2fE+rdAzzw9R/WveETMixZW5FpABta0pvayUrpTTI
 tROwy378gGqa7QMJpMGNaww0YYz4fvx6GgbCErQaVsWuuzD+uyGDOsl7ZD0bv0JcCx9Ifckpf9o
 I96FQY6+O03+uQ4OxEdIaKReJkJA0b8aSJDMDJywaoMIn4VqNj8nj4CAVjmBo9WAx25sntbIof3
 gHb9QTYTTj+GO69RCLblJvCua4qkUDa6tBy48Zdtgsi2f0WbVrs7IfVE8ZZle7OFTRODz6N8tYh
 trGsWGOSBkPeL+LRtJN38YQrw+Ov6YNg1SMdgHyrCBIa9DAu880ynmBv5JGyG8pjonEyNkdYYxW
 BcbiCBmC49ku/sUtOs9UO8IWBdTH60sYifJRfyEXGuqoPy46FEVH1by32wj1zLBzp8OnT9vSi//
 keELV36qCGWsnWT9IVGM++0F9dn2Yhm7q4I8rwVBMvjBS0t02GU4MTtNGBg9wVn+Lm98qM6Fs/v
 wgPjqUY6RSnzydhQ5MxKePx5SUt4S/vbgWnFWAMDxXv9T/FkLx0p6Po6Dyx6bvYzyCR45n7CMg7
 xhKzF9aiRc6tp6RwIJRNFvNVI+JHMt1T0r2ML7daEEYOd5VkJymHmmdtR+B/fKXFYPTGXdfV3WY
 pVPjiGuDAnPrAsdT2mh0xWXp4p3uKQFQ==
X-Received: by 2002:a05:6820:179b:b0:700:da68:7396 with SMTP id
 006d021491bc7-716e791d4e1mr337192eaf.67.1793905399125; 
 Thu, 05 Nov 2026 11:03:19 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1dd2bbb3sm93385a34.18.2026.11.05.11.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:03:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: u-boot@lists.u-boot-project.org, Christophe Leroy <chleroy@kernel.org>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261104164500.pr.u-boot-ppc@mainlining.org>
References: <20261104164500.pr.u-boot-ppc@mainlining.org>
Subject: Re: [GIT PULL] Please pull u-boot-ppc-main-20261104
Message-Id: <179390539837.1843724.17489735877203273060.b4-ty@konsulko.com>
Date: Thu, 05 Nov 2026 13:03:18 -0600
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 16:45:00 +0000, Bradley Morgan wrote:

> Please pull the following PowerPC maintainer updates for main.
> 
> Highlights:
> - Add my tree to the POWERPC entry:
>   Records the official PowerPC custodian repository URL
>   (https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc.git) in MAINTAINERS.
> - Add mpc8 regex to match drivers:
>   Adds an N: regex entry to ensure PowerPC and MPC8 driver directories match
>   properly when running scripts/get_maintainer.pl.
> - Update Christophe Leroy email address:
>   Updates his email address to chleroy@kernel.org across MAINTAINERS,
>   board/cssi/MAINTAINERS, doc/git-mailrc, and .mailmap.
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


