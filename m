Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB40E7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D608767A;
	Wed,  4 Oct 2023 19:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LBDjXb8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E978764E; Wed,  4 Oct 2023 19:58:53 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA1987650
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9b974955474so20587866b.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442330; x=1697047130; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cuTns/7mm5cqCPEvNBA9Ai7kZlnuNVR/EsgrKUVxEI4=;
 b=LBDjXb8acXrtnPJZnzQXqWARdt9bSljaWBEwrOhtxq+et6W0l7HXLyZbM26Io2Cbmw
 mSidRIpUe8y3K68zSn8HjDLmaUZDB4zBqoIBSVfIE3ICwFsmxrTn1gpJL3zCKNYgGQmC
 SfbyzWNL987tAdjWZ9n4F823DJ/4LqZ3yilY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442330; x=1697047130;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cuTns/7mm5cqCPEvNBA9Ai7kZlnuNVR/EsgrKUVxEI4=;
 b=shw2ZXrEkSqvn0S+8x2eYkaQ52dMCVzrlW8pWY95ajtKisAesLKS38sI0M04VecdbP
 1JxLIGt2HOZHpyP7mGljMJ6HosY3APDsXzqFUeefGzHMdLbF2s6HmUXnF1gXbJ5MjuMn
 z/G+jFQlSD+P2Yn62B/vriO/QcoZ3re09n8GG0KyQwUD0+s1aYwlM0jh2JfC39l+3WSu
 4CMpE/UUOtzzXnoxxDvMzg4sr0Eg/Dn8t6L+Q12S/m9GqfOBLmf0BO4JEXzpFZltQtL3
 4TAX3zKDlVL77YZ/ytLQ5jC9+Rng2mYvF3OwrZmHmuaVFsf7r8J5ryjL9d1JqLrN7l11
 F9bw==
X-Gm-Message-State: AOJu0YzF+RTvYs52Coez4iVQu9msHIlrQ5V1cgZTtCPmxKpotQE9y8jt
 X2YAt5JYTN1CF+q2D1Wyrk0HptEr97J/5wVv+zmIcHgiJH7YJROF82c=
X-Google-Smtp-Source: AGHT+IHutfr02lpAeMDbveQH5PqFQGcEQ19eEWjp5orhmENmL0IWuf5gM5eQoCs9tWRg2WaTmRzLxej1/ofPQGLEhqA=
X-Received: by 2002:a17:906:cc2:b0:9ae:82b4:e306 with SMTP id
 l2-20020a1709060cc200b009ae82b4e306mr2636349ejh.62.1696442330406; Wed, 04 Oct
 2023 10:58:50 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:49 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-2-sjg@chromium.org>
References: <20230923194424.1739224-2-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:49 -0700
X-Google-Sender-Auth: 3SCa_Piyd7nXXe845M7CiwZ5DIc
Message-ID: <CAPnjgZ28a6baNkK63Mj+uKWdeLx54bAquRUCs9X1VxZ8ouYcxA@mail.gmail.com>
Subject: Re: [PATCH v3 01/27] moveconfig: Drop -H option
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Drop this option, which is no longer needed now that we have converted
all CONFIG options to Kconfig.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

Applied to u-boot-dm, thanks!
