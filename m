Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E93C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 15:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBBE8122F;
	Thu,  6 Mar 2025 16:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rIxEbbSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFB6811C1; Thu,  6 Mar 2025 16:41:17 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C9DA808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 16:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e60cab0f287so537443276.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 07:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741275673; x=1741880473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=risZbhdo9DLHuoxkTswifLii3eTbeqldHV0MuQlVCSY=;
 b=rIxEbbSO7uT2H74vDDJ3QZI6mMu51TDSSm/HCkBfL6nvtr2p+lrgQxPowM5murLVRs
 WAUQmULEkhymskPy6LbvoAK/NAC9mH6PLFCHFmRcNrcwuFQzi6UWqK6L0G9SAxnIvJCH
 NwbERanlq7I+3EJyzHPy88J1W+EKDE40e5w5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741275673; x=1741880473;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=risZbhdo9DLHuoxkTswifLii3eTbeqldHV0MuQlVCSY=;
 b=aAcNtH2gDzI3XdvSw2OpM52Ky9UBGlAh2lHsedZKUlwfMT+CtfmHthtesgqV5pdveY
 zXwjGAfzTn1t3VSV5E11VWLuOanZpruYVqlEtqMcILS8yjkDOI/KO+4CE8Rsrb+PJ1j3
 IYpf4kPpKqOqcG/SD3P7GA+RxZHOa/oMEttmLWDyud2JIGLIDUjS+z2B75nMUnaTlaXx
 CDccG6Ew+DLRd4z9he2qsjrbY1RnwyTyfuhoARcKkxWL65NErZZ9vpfwcPnpWbYkOOsg
 Lrn4Zzjb2wxS8VHSBpu5UUmBcz8CBemRd9EZ0ywu10gOe5pwZxUbCGawet36fBX6iGum
 ks7Q==
X-Gm-Message-State: AOJu0YzpjjS8ERLT4HLQ9CidoDRMHuvGE6ua4IyZAmSf3tIdBsOr6qJO
 nAf17/UwaUNaVLdhxVD/fZGnlfThKqrW1afdXbZjcZNlNekLjcY+J9HOw7cenJzy3OP+kMrBIhf
 O
X-Gm-Gg: ASbGncs/bGKgOeRvW5l9F2+QMdVfmn7um0JfV4xDIc71BpMqtcgnin/klShaI4q0Dp8
 WsKcVo2zQUxhHpb5c5KSbcPKErn3WVD2jbbc8IVLeWSfkcmSWDV3GAk2MeLedV04GDLfbtrY1oD
 2lMwRUp+wyda9DM8cf/Z3JALPisiTYVN6b2lmj+FOQtJiF0/hK0GARHh22SRs+iwf6wf9okEd7G
 fBZQTLsLneAjKKnhkeUeLpZSDHzVnbpDN0kIn7KRveOdRV8FYinGjen8dmqW77zSsn/1aRk2Ir8
 v26eZGR2WWyPOwPY1ZkAkhEUvOAjw8onkpEztXkqhQdQ
X-Google-Smtp-Source: AGHT+IEBhM4wjeOrPYyYYlHokMNr3fiSU4VsRb1IZADXF+iAAOlp7NUrDiY9mKhXgl6i1S2rQ8VAaw==
X-Received: by 2002:a05:6902:2308:b0:e60:5d76:f7a8 with SMTP id
 3f1490d57ef6-e611e37462dmr9428992276.43.1741275673196; 
 Thu, 06 Mar 2025 07:41:13 -0800 (PST)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b842f58sm348755276.22.2025.03.06.07.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 07:41:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <5195ba6f-1633-4b14-9567-4626ddbfe60d@monstr.eu>
References: <5195ba6f-1633-4b14-9567-4626ddbfe60d@monstr.eu>
Subject: Re: [GIT PULL] amd/xilinx patches for v2025.04-rc4
Message-Id: <174127567240.3636414.2877647135882922941.b4-ty@konsulko.com>
Date: Thu, 06 Mar 2025 09:41:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, 05 Mar 2025 17:52:16 +0100, Michal Simek wrote:

> please pull these fixes to your tree. Especially patches from Padmarao are must
> have. One is fixing issue around using BSS section before relocation and second
> is fix connected to switching to LWIP. 4k MTU size never really worked with our
> MACB driver but old ethernet stack fallback to 1.5k MTU without.
> 
> Thanks,
> Michal
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


