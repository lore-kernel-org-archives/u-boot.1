Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1988C4167D
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188B68791C;
	Wed, 13 Dec 2023 21:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BH8KVFGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31CD487914; Wed, 13 Dec 2023 21:39:40 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0272E878DB
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a1f8a1e9637so877607866b.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499976; x=1703104776; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0KnZBKXZ+hHxnjy7eC6rPMeh+n96RB2pTtqSVUWoKzQ=;
 b=BH8KVFGbWbTYJru5vt4THxkAzy/2Nm5r4LL6XONdJVMD29OOsGQJOqSOQE3e5P7G+x
 hPpA0RFCzFLlcXVxn6TqWu941ddFFgOnw6968xwM8eSXaRKokeo7Y+PsOqvorOzrTWM4
 nDG8A0n+5NQ/3TWK2oXNkFjG5a19+IjspmqD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499976; x=1703104776;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0KnZBKXZ+hHxnjy7eC6rPMeh+n96RB2pTtqSVUWoKzQ=;
 b=Jb+E8FP5Bo18DxAuMiJwruyfLHF68EhfuH0jRqFvfzchCZ7mbvgBKKASh9rijNiBS3
 Of/Q5RGxiPCMwzrrs/qof7xAYPTWH9ve2KPdQktQ1JMfE6cCdA2+ODYm6YElft6eQDV9
 abw4/J6YtZPq0f8836VBRJVIrtBP4lUb4y0JwOX1RCNh+v45ZArmJ3yfYLaMDHotfs+E
 /LglrQbGsZbSdiQ3P6dUWLEqkv4/wSNgOnCcUNI24eQ+5zlfGxJOaVC0XhLtIdzWkTPc
 JCuDJ07zEUBgzKeD83VF/ztbIusJFgpDrbjaPrEtWG1xH7kbM5HAcbwUF37NyC8K9RsL
 HPaQ==
X-Gm-Message-State: AOJu0Yw0nJgqWbFdJ/ETGdz0n7CqSpWymn1pMQJ6V8EZ4ssr1kntrrYZ
 UM3LbuA/mf0V5dFO3YoikRdZbOEb95pts+he5EZ/2Q==
X-Google-Smtp-Source: AGHT+IEGiCYeQn9819dJ0f4F1ZfDtNGi/Aj/Kpq+IyWUpHRA5ZGAZMkr5u8wNaEJ/l+6Ygq2T7ZMKt7N6D7Ub4g4aYA=
X-Received: by 2002:a17:906:1c9:b0:a1d:1fb9:da08 with SMTP id
 9-20020a17090601c900b00a1d1fb9da08mr7137422ejj.8.1702499976340; Wed, 13 Dec
 2023 12:39:36 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:34 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-11-sjg@chromium.org>
References: <20231002011553.463514-11-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:34 -0800
X-Google-Sender-Auth: y2EIg0PiKqxFSIweIcuvYK6XgSk
Message-ID: <CAPnjgZ3+OT4+=f+06+gqwi7_jsthYgywoB9EQBr7E-H8KWQuhQ@mail.gmail.com>
Subject: Re: [PATCH 10/34] test: event: Only run test_event_probe() on sandbox
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This needs test devices which are only present on sandbox. Add a check
for this and skip just this test if running on a real board.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/common/event.c | 3 +++
 1 file changed, 3 insertions(+)

Applied to u-boot-dm/next, thanks!
