Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428A7C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3F2581273;
	Tue,  4 Mar 2025 16:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gi6AnsWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09F4A812BB; Tue,  4 Mar 2025 16:37:08 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A9881298
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac202264f9cso77328866b.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741102625; x=1741707425; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=opTsiV9eYkwEjA50OAOszfhE8gWq7kgBlWvGDL7cgnU=;
 b=gi6AnsWVb1WSDqHT65D7VGgDkEFFyS5u9swjcIvuSNMeWX2A8BDn0cofCddQ36zNCI
 r2ihTksZvG1FykA+SJoBFbJmASHvpHdw25czWh4kEmFG9g0skKmzIf9AWC6yUfUZHjT/
 /UTDPTPRLdREwRS5b5HZcKG8AQKwrfN4e6Z+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102625; x=1741707425;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=opTsiV9eYkwEjA50OAOszfhE8gWq7kgBlWvGDL7cgnU=;
 b=Q/J+ZJpDeL2sSsG5qwvx6gMuwk6ZQBl0CDhoAsx8Gezz90j0CKTSkIlgtETpKjGmVa
 YNlqqymLe6SIbIB4P77AJDt9thq6d5A1zQx1yKbEbMAIi4LKWiyyleCBJPYOKaW5G4gN
 PHAHiScfYtevXRBe5qkYWpUAWej6DrWxT9jDkT+p2oqGTgwCNpMAvIuBNsr94Exiu4Fe
 gI0sc+0eebFmZkkPgm56Kt4RMDp8ZEVfxpZIKAO5RPeBWCot9Al0VQ0dVE6ehbz6Szio
 ERgKTl2o2Q9lquqdro1/HLpsfZh1iHm7ping1oGKkKplgUW0FZE88o4X4By9njBosjpQ
 Kv3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvTVogScNuXAZC/k8/wNDVAxJb/qFMoj3hOziDawtmqRGeAVe1GMTH4ZwB0nfFXaThn2hGoRg=@lists.denx.de
X-Gm-Message-State: AOJu0YxImb7JUCmttX9/lqJowf/cAZhp6R0JXNY9VvKhJjkGAAM6v3mK
 MoZsVRJOsW/jh9MuJ6XKH1ih8iGhV/eT7L2MgtS/EqjOsQdJdJZsnIlhHFQ6atHzy1ttDjCuWbr
 3d3XpOiYThIbdnmFvHd5LOq8BoKuJVClLm1cq
X-Gm-Gg: ASbGncv0aLxtWbuPGKcQEG6mg7waCQqkLZzKOoPm0Xl+qf48ikRu5EbLcNxMTtroFpj
 GBZQzkjEplPr6XlGahKu/wyHrb7zCeRNgZs2JapCqNtBwgxMFSnocAWmmycRtOGSp80umtNHNll
 CP1QlvgeUADcONZmV94FlctLLxdBE=
X-Google-Smtp-Source: AGHT+IGl7Q1kKBavalVp3D1kjRg9jEKmfht7dy9tJwg02wJCJhXD9kONj68pJB2LfLUQQBfpNeximj2mlxQu0Vns/r8=
X-Received: by 2002:a17:907:1c97:b0:abb:e7de:f2a6 with SMTP id
 a640c23a62f3a-abf26835ca8mr2157166866b.53.1741102625535; Tue, 04 Mar 2025
 07:37:05 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 07:37:03 -0800
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 07:37:03 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241018030027.842749-6-sjg@chromium.org>
References: <20241018030027.842749-6-sjg@chromium.org>
 <20241018030027.842749-1-sjg@chromium.org>
Date: Tue, 4 Mar 2025 07:37:03 -0800
X-Google-Sender-Auth: os1I6wOnMWH1-tyTWSClZCBTmoE
X-Gm-Features: AQ5f1JoQREz2VzrZMscMnWVcR9HxPGb1CoIMzivaFj09mtqoLE4TlMtgKi0W92I
Message-ID: <CAFLszTighBAheHToYTjYk8RfAWE8cGyU_7sTfwMa6n1i=D7tMA@mail.gmail.com>
Subject: Re: [PATCH 5/8] membuf: Correct implementation of membuf_dispose()
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Ion Agorria <ion@agorria.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

This should free the pointer, not the address of the pointer. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/membuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to sjg/master, thanks!
