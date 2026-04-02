Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0331C1112247
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0220284056;
	Thu,  2 Apr 2026 02:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kRhbgOtL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9760F83CE3; Thu,  2 Apr 2026 02:15:44 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 040C780517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 02:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so43659366b.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 17:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775088941; cv=none;
 d=google.com; s=arc-20240605;
 b=UrPD0eTUFV8awIzYgHWbjMVflSUcG4C6m6OnVuq9GP3KXJ7mbYdEJYk8nnF2E3cpDT
 spoaqhyIh3Oht7K+I9KeHu3mFmTCf4hFhXJiYlexPmqI1ddYTpXkkM3Kfo209Lpwqvn9
 w5mVyn4U26vFemPmVRbiRt4fZgkFaOfTF/UKCrP2tQtwYQx42GeLwaZiODvCky50/NoA
 FL840aUbkKHpQGmX9RoFtAwHLRChAw4G7jUm4+Y/0aiiEFlKyzxocTC1TsNipidHzncm
 Pm5eWThd2E1Vq9U5FCcmadfpixfECiqq2LXDpMtKh60edzPU6aYBxa/gy2mWimMv6bHJ
 E1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T+I/SRLhePpcEpOAgBgW2EPqhwJZLlH7jO239dWqkZg=;
 fh=pNEDl0BQNvwLbCb3G4NzSeubuTA8HYaPwm66nyYdgIY=;
 b=bf3MGB9F6v0HxgzAnlqD26ttFRmjz1S+iiUn6ysKXBbT7EkUN7aaGGf4ZEywz4JQ0L
 Ngkjj2GXdgcv5N8Yyjs6Zk8nttTP8tXJV0G151vG4KN/RDLIsua2y8pCZozjAFpocodj
 eUxL3GEnrSR3z25R91diMRI9yDXsGt3iNST2qSTXYOc3Xk7GHhmL6r8P6tlwZzTYJwzQ
 atrLlsjM9qruKBMzxjn0JV0BYxgleQVOpnfE1IDXBBiR8MM+KjeEdxT4HSfF4CVeb8G+
 SDJwGeSq5FIkzr5EJd6Fm3BU3mH9EkRDZ9zEJcMjfzeo+r+nzGxQMITyNRy4fcr9tBxx
 8TtA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775088941; x=1775693741; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T+I/SRLhePpcEpOAgBgW2EPqhwJZLlH7jO239dWqkZg=;
 b=kRhbgOtLs6qX/mO8EO7075jcM0VG6fiSLO0ZKCXlGAT/AMacPIA3uKkiWCQPNC+V06
 g3b8t9G+ge+/cBMP4S6EnGJAqNn/IYXjAFBoIPP2XCb5by1NtviMNO684h6JzVgQrisQ
 8Oz9k7TxRSuLruYe/9DaRTx66PEend1UTw2xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775088941; x=1775693741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+I/SRLhePpcEpOAgBgW2EPqhwJZLlH7jO239dWqkZg=;
 b=qlyqs1Wr0IkxLfhnv4Js/u+5LOIuz6nXPDEnwFyYHe4NI+DkZdFfMz09GRNzo3tDv4
 if5qsaY9JvTznbk/niRcY0ApwcWoTW44EE9Eds+PnAvJdIwp+7zBvqIgm0eQw28j5Z9E
 6Qpo1AO1lKTZvVV0P1VH2Vs67W+mYE7DR5cjaZKgUBfICvm7zHV3nVJKAvostfz5RXgO
 5LF4DD8o5kpC0QrxWoqK17m5BYihtoN8MIsE45xChRnqXg0nw0uLTbC69lYhjrb2yuo/
 aGZ9OSltwvbTGqVmdsisp85yTfloNKqw/fEGChKKDVTKy8lLQ4DZlxdDNm6Vwr8HNEtq
 DKPA==
X-Gm-Message-State: AOJu0YwuTWQeovh1l5xhXfbmhP7ktRcx+JL7n+h9YGwlQairXG/yfGtb
 PFtwQ2h/fPcvMnu2dC5gwAdm1TEh3k+ZC/dUebpta08oFKOWF97HA3ILOgU2LJtLxZwdJFqk1O4
 OUqe9vGJzl833FDj27DGcRRQQWksi79wkhDKmxqIkoBu38B21bwRo+g==
X-Gm-Gg: ATEYQzxg+gBo7wjOGu5uDO5LAFpEN364l7PhTtare5MKkJFHKRuv+TvNgWo4yT8xrj/
 r65GnZVSubE4uEIUvMSqfGDrECltqypu86dhAQv7DWmNyPEF6fxS3tXYRc10n8xCSmzNGF3CZrH
 rRtSPJkpzl7K2/9HqZe5erXgxMA8O6nuD8OXvBqiP63IfjWYg2EPZb9ll1uLRS+qU3+kK8vw5QD
 FLnF4SCo6y91/cGiCtSJ02qjNMyEhAOqaJrcJJpFKTX6EqqPDgXT4FJzEzsgIx/d1pShRSAkXN9
 SS7quQ==
X-Received: by 2002:a17:907:841:b0:b97:1d24:c004 with SMTP id
 a640c23a62f3a-b9c1392294bmr400198566b.21.1775088941263; Wed, 01 Apr 2026
 17:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260401124128.178799-2-gregor.herburger@linutronix.de>
 <20260401124128.178799-3-gregor.herburger@linutronix.de>
In-Reply-To: <20260401124128.178799-3-gregor.herburger@linutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 20:15:26 -0400
X-Gm-Features: AQROBzCbf0zNzLBy-PWLZoDj-RPzjSPAqkbn7yTJNh7AzMGm5lJNmbZ7XMboygQ
Message-ID: <CAFLszTg_LiyHPYhQh+MTV5skuY0ORrPotOFQWkQSQvsBzjHTYw@mail.gmail.com>
Subject: Re: [v2,2/2] cli: flush stdin before enabling cli
To: gregor.herburger@linutronix.de
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>
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

Hi Gregor,

On 2026-04-01T12:40:44, Gregor Herburger <gregor.herburger@linutronix.de> wrote:
> cli: flush stdin before enabling cli
> cli: flush stdin before enabling cli
>
> Currently there is no possibility to flush stdin after autocommands are
> executed. If in the bootcmd the stdin is changed, e.g. from nulldev to
> serial, it could happen that junk characters sit in the fifo and appear
> on the cli.
>
> Add a option to clear stdin before starting the CLI.
>
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>

> diff --git a/cmd/Kconfig b/cmd/Kconfig
> @@ -47,6 +47,12 @@ config HUSH_SELECTABLE
> +config CMDLINE_FLUSH_STDIN
> +     bool "Enable flushing input before starting cli"
> +     help
> +       When this option is enabled the stdin buffer will be flushed before
> +       starting the CLI.

Just to check, does this option also need 'depends on !SANDBOX' like
AUTOBOOT_FLUSH_STDIN does? That option notes that flushing stdin
breaks autoboot unit tests. I suspect the CLI entry path might not be
exercised by those tests, but it would be good to confirm.

Also, please can you expand the help text to mention the use case? For
example, 'This is useful when stdin is changed during boot (e.g. from
nulldev to serial) and junk characters may be pending in the buffer.'

Regards,
Simon
