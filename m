Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F576D6AB1A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 01:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E358407E;
	Fri,  3 Apr 2026 03:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CHSYM7L7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 490D38382A; Fri,  3 Apr 2026 03:02:54 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A764840BE
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 03:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9c04152730so218673766b.0
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 02 Apr 2026 18:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775178172; cv=none;
 d=google.com; s=arc-20240605;
 b=dfn3p/gDPN4vsVg8fKHBT8Qz6U4tWg2LvaxqIF/4Ov2m362FcAZZ9YaVs+KK9sQvbp
 oZjv7g5tYd4iEykoLCRu79qJqU3RNJhs9N+/iPtcOk/gTxnMrp9340Shg2OERzx4u7Ts
 yq5HQLxNtgA5sfhd9LGGPj4EM+QEo6Jyr9PncSlVA8u83qq4jGqC3RDGIKASXvwxciZh
 8o+QYOIlGBzi9xy8++uv5+eMAp1OwfLtHVYIG/9rwI7GfjsEpMafHGMBHAf3jYbZTh0o
 ckbZL4ILvUT0qE6c8mtrD74izm+KK9w7yZpt9OJ/lMvbNcVH8PRybFABE2Ln5ELgDVmE
 D36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KehXyKg65TuodojFq9Of/fnliFQ9A60GdBat/gTpFAA=;
 fh=rTilkJYT+OGucwgZmqaYrkAlQaWkjOIKQhfreKCPYAA=;
 b=JKrf8ckQ64bKjyhGgXZsakEehfcCEbdRGGnnNJzQ57wlTI5kgXPwXV6sziRyAZB0Mb
 UkmGRFJRQaq1xTTs1x97k6wLY4gAE0NYm0UhjMX4o/6CjV4FbwSs0MqdQz7iVbbSj5i6
 M92oma5j3R1Mjwv60eXMT2vw/0GfxAFUxN88rkMa9pVl/toSY6V7TlcRrWjVQ+X1eXSZ
 Jo/mP7KsCoE4hHOHIUuS5pDf9PnJCwfaKRfbRUCkA9JlNqSsf/M7k05RNRLXyjRCYh8a
 zCO90osBM1/cie0ZZ5ztNduZBPNhMEXvRTPysAk1XrQQLMcVmXujROEltsY5ORhyWSjE
 KsNQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775178172; x=1775782972; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KehXyKg65TuodojFq9Of/fnliFQ9A60GdBat/gTpFAA=;
 b=CHSYM7L71Et/9VFgaa7HTDFiqYDH9vAnMCP2vTlf1tS17BYzu29vsWfVt8QKHx4m3/
 /fwEOFCdWTJG7t6Vsq672Ue9sivA0uD7pXiS29tL1R7yxuVbfQisJ6R58WUZ25H7GAo0
 1gH3D/kg0oEwk2VBvv/IUsm1HeQOAHZ78te4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775178172; x=1775782972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KehXyKg65TuodojFq9Of/fnliFQ9A60GdBat/gTpFAA=;
 b=de8hdr69DhmJvOpbt40YeQKfNfP/uRSNYqK8QFedmpL9r35pcnQSulUjPwt+sQJ7MS
 DAUrkE9ghuckJjelxWqIja+6zpbcSa1SMFSIBLuh7h2PheqPYdQOE1PhkzMDUWswH29B
 anmMdI8pgArxeaM7Mpfs8Of+96+4Cu9uZ+n0TDCzfBNc1X+f0vLfTqPnPz8PkkXQBIeU
 l8pgcq0pqo0RRhvuMEqsnH7o5i5/qptP03yTSZ1S/SAPHvETMIKGEZ7c8FGmgQiJJULw
 XuC5T0u0BqSVWJxgWuKn9508RgZcaX5P5BWNsz4yo+ZMQGxjHt8oTEQD522ACOdhC1wO
 nNeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+pxPKH2rQiumMPMFMJE6bCSop06V2ok47/c7hS9H+KntIuJa2q0bDNz/A74rfzIz2ed9dN4g=@lists.denx.de
X-Gm-Message-State: AOJu0YwF8COcvqZzn5X7uEUe+RG/IZXnrw98+vvqfVM3qMR3DABj0ORZ
 8+T0KIZ6uToG7GEZ0KL3u0TNlzIUnsZvS9vfe05BmFEycqk1ZkFlEltl6H2+2Ke9bJOKs5dELIQ
 Mi3nDYzHbt2VQDgT0sP79o8SWMM7mEufsqCXAIa1Ple974YeM8fw=
X-Gm-Gg: AeBDieuRgcSPbN8j2WML78MogVnplIiBsaQZNgg9CumnAtSCZH/FF2/a88K69KWMJLU
 4Q1Jf6pDYabnSvCHHYJoUktlMYct4cynlkELOK0HB4FYqCfYW3cJstHhf6YjK4HLqr3e0Qjjl7y
 1ce61VjPfdfJ4SauwfIriM+3juZkXijC4YIYhrn7XF/PYuMIwxUcOnW4WxmTMJLRZpysnG5M41j
 3h8hSdgVH6Ick7U/uJGBkVAftdCQnTcpB67/DOeWfiJ6nZJHrzhXxUSc0NM2vuTBwWgoErTAUPs
 0SwPYw==
X-Received: by 2002:a17:907:3d87:b0:b8f:9bea:ad6 with SMTP id
 a640c23a62f3a-b9c6744d907mr43642966b.18.1775178171734; Thu, 02 Apr 2026
 18:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260402192431.2421155-1-yan.wang@softathome.com>
 <20260402192431.2421155-3-yan.wang@softathome.com>
In-Reply-To: <20260402192431.2421155-3-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 19:02:38 -0600
X-Gm-Features: AQROBzAQ7gmqtYYPO7rXhnAmeKOlHRGZZnMcaeH6R1VW7s-dlGl89Dak3duxuOU
Message-ID: <CAFLszTiXO2hTmsbJ8cp1=+cCdvdrtnWFDvq3QohgS4YS6UL3Ag@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] binman: collection: Set build_done on referenced
 entries
To: yan.wang@softathome.com
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org, 
 alpernebiyasak+nodisclaimer@gmail.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 paul.henrys_ext+nodisclaimer@softathome.com, 
 u-boot+nodisclaimer@lists.denx.de, u-boot@lists.denx.de
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

On 2026-04-02T19:24:29, yan wang <yan.wang@softathome.com> wrote:
> binman: collection: Set build_done on referenced entries
>
> The collection etype uses phandles in the 'content' property to
> reference other entries. Mark each referenced entry with build_done
> to avoid rebuilding the same entry data multiple times.
>
> This is important for cases where rebuilding may change the data
> content, e.g. due to timestamps or random IVs in encryption.
>
> Refactor GetContentsByPhandle() to return both the entry object and
> its data.
>
> Signed-off-by: yan wang <yan.wang@softathome.com>
>
> tools/binman/etype/collection.py | 8 ++++++--
>  tools/binman/etype/section.py    | 5 +++--
>  2 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
