Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E25C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FABB84832;
	Thu,  2 Jul 2026 10:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HBua82ra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11CA784CBB; Thu,  2 Jul 2026 10:31:04 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC67846A4
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-37fdee9276fso1612842a91.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782981060; cv=none;
 d=google.com; s=arc-20260327;
 b=aZE73YZlGQxBShKD1bZkc/XI7fAwx6suYcqRkV2J5/1Nlku8VLFd8oP2m8T/xJsoi6
 N+87AQM7fFFW1uXaVIoDnPPvsvPjUy+pcpx0Y/Ji/Lr+6AdLyK3KHvA0QNfNU8vwwBBE
 gS/wy27mZWfOPMILS5Q/LHVdtva3N0k8h8N6vO5zVbBgFoQqPRPZLKm5niVZ3oUxw7/1
 X1bq+rAD02GQgjSiGcdRVmRGG9Fy2hUglcw7jkQkvtgDbGDZHaXWHvm1G7Yl9Lhn2mt8
 2dHKg0zndotlEhTGt2IbpK6O2ScTuqggeVNcsRmZ9aYsXSMvRVYDwLFOhU6CE449uA49
 H1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uDY1oHvlMkPW0r3k4y6o1l/2jmQ1FQzVYilwGpqZBng=;
 fh=MhAo4QPuXEC/Rh971JORz4rq3nvFSJ8p5JStjvc7R4U=;
 b=SSAirgh2JYhnCMx9dvI9T2xMHHnnEGxcHS3A4XeVpJ4+cX+J6U0KC4T3CIA9gMHEwb
 C6KIosgTY/dHAt3hVSbbrf7LkzOrwInUd8PAL0uZKlMBwxmR6keIuoNgjc1eHfGv6ldU
 o3xTt78Dx+hxUVP6DU8y+ibFai1QW9dUdTPwtti9bAOpR0MxQ/lOb1uo+Fyra/FR7fDT
 yzVaUTDu0wlU2gZrmTMhY8/AasGT+RUlt85PPvLTax11po1yuLf4G+dvGEaI5z9PGulU
 nbVzq2dh2zvw4XZPkjo8e30jbCl7RmQ/C6LpGVvY3jsE0FeFOMmeQxBY0hV1xhwtlbH6
 1nfA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782981060; x=1783585860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uDY1oHvlMkPW0r3k4y6o1l/2jmQ1FQzVYilwGpqZBng=;
 b=HBua82rad2WtAavDY3BTUl4ttLs9bUxQ0I+TzI3ubtcba6fOhW+LDM+JfdXCKR2VZI
 w33BMWIP/XpRy3vil7VNm4OUpEN9hS8FYf78StirOqkTNqrLYl6TtJcyXQkZfGURHXsX
 j1mWFidRnmQCcmgY4hwlsXi+4+cpjGPWKxNcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981060; x=1783585860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDY1oHvlMkPW0r3k4y6o1l/2jmQ1FQzVYilwGpqZBng=;
 b=dBatNzHkCbW0JvnD/Q4M57NQhVVU6bPBw5IZbW0Jw7UuQhKegeuxXI09tzZEu24ZAW
 gyoVwJLZuGvvndSmpQ3EkWr9IambGaFHGvaXEkSIPb0J8YFAEo11PNNG6GBGCM7LNSNI
 UCRhvk9RDCNhz/n0cRR6NJeYOBjHwaapli/NXhVJmqnZKDEh/fFgt2HRteGFzKs/nsnz
 yaXA59xDQLV5hIzH+mcCN1mh/vN1qDgJf/JnkeN8OiwqNMBWdRF9NSDHVSSS5IkiBbk1
 mnA7n8/m0imoEnuvWdJ6ubQvekJG2dT+sHuYPLCBGvawFhnMm6S0A/ULZt9yKf+N2Jsg
 vupg==
X-Gm-Message-State: AOJu0YwD/VzNL91MNz11SVFYpZGuPul9ORGcJYnE2IULv365NfDsMiXW
 rQ1kueQNbCG5fOdlYj6T2qYSi7k/5i5rz4B9GnjNV8ecY066eFGzml5RP+BwIfWYj7HrxBC7DF+
 e1uJJKjr38+13+wsytcJoJ4sUrV8FzOFe/CCKVj8PVeOvaIaPwEpQQCCh
X-Gm-Gg: AfdE7ck41U6P8Z3WUXbGvgFCfAA3jxS0/eBLdY2Vp+7ImRwazQiBrgxS6hd7ENt3PGs
 4yO1z4ml6/8kwfWZzaojGkmBf+lx4JuhNGJFahZq9rU7C3NGI61DEbghK1+7Kb4MQJ7lkOBt2Ib
 zYT1Qxlew4tLigsZFurvU+vc5BjaFnPfZd+J1kVksHGDcfBtFfUNBVAP2zVf/Tpa3tC78JYrr/N
 ltOPoYsGEesj14xr4dHpMHnUAnrejW5S2Q2eMZe4u0b8cgNdNEwmFwITfGcIYFe+JZiUVnApg==
X-Received: by 2002:a17:90b:4b09:b0:37f:9ce1:cda9 with SMTP id
 98e67ed59e1d1-380baa8a214mr4454003a91.31.1782981060147; Thu, 02 Jul 2026
 01:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-4-rv@rasmusvillemoes.dk>
In-Reply-To: <20260701171535.906272-4-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:30:02 +0100
X-Gm-Features: AVVi8CehMJsrZvRnVpxJaXIpPREP2wJekBX1gmqbImQ5NWT4bidDiVRdmvr2R1Y
Message-ID: <CAFLszTgmifnB2jvddUq5SY__MWJvTsS7EsSvfETwUKXNZV7dAQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] string: correct documentation for strstr and strnstr
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
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

On 2026-07-01T17:15:27, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> string: correct documentation for strstr and strnstr
>
> The len parameter for strnstr() concerns the maximum size of the
> haystack to consider, not the length of the needle being searched for.
>
> strstr() obviously has no len parameter, so remove the copy-pasta.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>
> lib/string.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
