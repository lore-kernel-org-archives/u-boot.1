Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A88D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3820C84284;
	Thu,  8 Jan 2026 18:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VtQMQiTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6CE684158; Thu,  8 Jan 2026 18:43:10 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A327D84284
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-bc29d64b39dso1396102a12.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767894184; x=1768498984; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ub9GicRW5zf1Fn16vHImmfJM7EEnlmvXQmNKh5d5sE8=;
 b=VtQMQiTbiifyI48VdaZM/RDzNyZ0fU/zKAPBStoSa38+6lE1v6M3Kd0TS3jgV3vQjv
 KT9DUG15R53pe44R/fmDWQl9DgH/NdS0S6KYUp7hnqfcqgWtIlIUtATBE9jrubp2GJuC
 vzeRcxRG6oDIGQI6scgODCzallm/8lW35i140=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894184; x=1768498984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ub9GicRW5zf1Fn16vHImmfJM7EEnlmvXQmNKh5d5sE8=;
 b=nIie6jCHx+cOgiutX7YcsHSva8mYf0J6xGIVQyhoTRv+tkY4HwhjbghUSXZlrAi9o1
 ZAEE7sr7WNQLaTHibCch0axuZnFI4QZSDq+dw+5hagE4spYdFPunRFn57jg0xcB2D9kS
 I6TSlndGAlzem362HyacngMG9EqG2IHd9TV0NP90gW7OS3aaisGHdEyhXv0X8yaEXDcl
 PhSsRNu7FeeMKeQtUgK2Xx3qSxak6K1UY2IXstKgp+pUpXEJszqSSFjAxur/Bvp2PCGF
 BwmCNXik71ifOfvT8HQJMgxyDe+mWSLK6j+r+/S7JJ6neZHBqqlYFgN2PAqSUOrlFbeV
 nZlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw5u9P2+g5VK51ObKQ0S/ShE1B3rF9PH+67YSzbJnmBE8ohhX3OR/y+BRyBh5MAEBv2OAoi+Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+r13AJqy4SgcaNwuUO+lcfApcf9Fh62FjxfibQ4hDV99Cz3IX
 Qizk876rWE6/zkCYilR58TDEj5MUvLq5DJBEC1oY6fgPZqZ3wYzw7WmRnwFdp6Z9iYJ4LF6M7k0
 COirukVESXm3BTuRu8kCzGdvVj35gt2ituj4KGdIk
X-Gm-Gg: AY/fxX7chiZnBY7VgMThtioyKQiAPWlvfBPKhKy8Wfz1AMBfaBS1LgR+rGJg6Y2NC4t
 J7/AMD5u881sUuACFMXsrVdDNTAVdCbqRElwqIZIMdrNOGvZAVupLs/73N/sRKw5KCytiDCSjAU
 HhFh+Y9tTf6hzo0aHvdESW18lZDH9/E9u/L+vw6bQzCK1NcgFpLiCHhlsrJ9IaBNI+WYxn1LWt1
 KsPDu9ZtjFWr2IYWLwLWnGm4Io11vEpV1Ee9cJb8gk5+CIPU0WI0TlCnLQu4BfzJIu6/A==
X-Google-Smtp-Source: AGHT+IFnflDpD9DOSJb767uDhY03EWGY2CQbTIwUTr8XvEYxOb6cEf6psQqByf0NHGdQJtdCwx+3qVqvPgTa6Q86JFg=
X-Received: by 2002:a17:90b:1c07:b0:32e:1b1c:f8b8 with SMTP id
 98e67ed59e1d1-34f68cdda94mr7303139a91.26.1767894183921; Thu, 08 Jan 2026
 09:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20260107-pixel-config-v3-0-02a25e3fdcfa@ixit.cz>
 <20260107-pixel-config-v3-1-02a25e3fdcfa@ixit.cz>
In-Reply-To: <20260107-pixel-config-v3-1-02a25e3fdcfa@ixit.cz>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 10:42:16 -0700
X-Gm-Features: AQt7F2ovEmzD0uC85jxDhHARbdqf6WsxbvEbD7S7MNPCQg88M6yWKIzUPWtNJAY
Message-ID: <CAFLszThwHMEb6A+=Rp4S5RNxh3-iUgkznSufKv1H2ne1E53ThQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] doc: board: qualcomm: document Pixel 3 / 3 XL
 support
To: david@ixit.cz
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, 
 Petr Vorel <petr.vorel@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <petr.hodina@protonmail.com>,
 Matthew Croughan <matt@croughan.sh>, phone-devel@vger.kernel.org
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

On Wed, 7 Jan 2026 at 13:28, David Heidelberg via B4 Relay
<devnull+david.ixit.cz@kernel.org> wrote:
>
> From: David Heidelberg <david@ixit.cz>
>
> U-Boot does work on Qualcomm 845-based Pixel 3 and 3 XL.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  doc/board/qualcomm/board.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
