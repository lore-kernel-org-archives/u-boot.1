Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3E2C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6718B88925;
	Mon, 15 Jul 2024 15:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KY7nkLwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB5A88925; Mon, 15 Jul 2024 15:31:55 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 062CD8891F
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-79f1b569ab7so255336885a.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050312; x=1721655112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7p5AZvexUzYd6NtykW50+n8EZ/HFiXncAc1PpdFURsc=;
 b=KY7nkLwagXRrhkXHwW9oNRVC6vdEAKJmYU7u2mcUVm9Qx8J8dOjnGxc2x9eXF7QPJF
 Ai+cyrcR/+5WbrNNDZ1jLvtiN40/A4U9K89BzTsXKEHSLkxhfh2OipXlkh/Rak2M3gIP
 IXt8YKH/mYC+GbPIkuongWKutuiZrwxDt85fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050312; x=1721655112;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7p5AZvexUzYd6NtykW50+n8EZ/HFiXncAc1PpdFURsc=;
 b=fWHNAJ8AqYe2wCHApRx/JGACD4SslPn817stnH7N3DONRhscBgI6hQzPPsUnZ1Post
 ARxRKSbcupIp96isCEf+R3+Z3iE2V82uD9gGXkOa9cwJBoOA3YhyS4fH6XtiQRy0AELQ
 p4DC0H7tsD24CzJgj/qGz+umgYP9RxchOqn44W6tOuXuhjOLieJd9YUBlnr3/Exv5EV6
 neFdCzi+74wemm4aj0wVu8VvWsUq2ZxLm3DEwkjnPBI0Q5vT1FmwQ/zf6zy9D51SiMjA
 vDJkvvyuTdTlh6jMLTO2p4V32wyFbWSr4MNP8TqpYa9LHr+0xF8u7vNpBHalvUpf/KR/
 hvdQ==
X-Gm-Message-State: AOJu0YxG/Y4fgKzByi4akxWUAG61FRSZUrksjFJa77KHdwaFq9naldfq
 NisqoSBxtwxP8Ib8ZdmIqoFPHovIMhyLVDjViO1VnRHWQs534QT3LTuIB+SNiasutS5yIqRlFyE
 8cAKr1ljlezPhZJJeutFRk+ufwGm1X4vqxzB7SbJfF+Djqk8=
X-Google-Smtp-Source: AGHT+IGZslHN5Sa6uLzVVN61zmzUPL6mKFotZfm7aUtojtAr3OOnm81tAv8432TrUfe1+bW/QpJoDQS+xpdU/k4DbTA=
X-Received: by 2002:a05:6214:4018:b0:6b5:e5bc:15c with SMTP id
 6a1803df08f44-6b61bf61698mr232564646d6.30.1721050311787; Mon, 15 Jul 2024
 06:31:51 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:51 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTimUpUPdKycn8opcpKeXAA9JO1iVVbfnvMNfDfZp660jw@mail.gmail.com>
References: <CAFLszTimUpUPdKycn8opcpKeXAA9JO1iVVbfnvMNfDfZp660jw@mail.gmail.com>
 <20240604161607.1133032-1-brandon.maier@collins.com>
 <20240604161607.1133032-3-brandon.maier@collins.com>
Date: Mon, 15 Jul 2024 06:31:51 -0700
X-Google-Sender-Auth: rUpGrHa4OBeW86KATzv7R20v7Ew
Message-ID: <CAFLszTinMQRu96j3U6ji5WC-9eiJNG+x3S1JbPOk_qe4LPXFcw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools: patman: fix deprecated Python ConfigParser
 methods
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Brandon Maier <brandon.maier@collins.com>
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

On Tue, 4 Jun 2024 at 10:16, Brandon Maier <brandon.maier@collins.com> wrote:
>
> The method `ConfigParser.readfp()` is marked deprecated[1].
>
> In Python 3.12 this method have been removed, so replace it with
> `ConfigParser.read_file()`.
>
> [1] https://docs.python.org/3.11/library/configparser.html#configparser.ConfigParser.readfp
>
> Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> CC: Simon Glass <sjg@chromium.org>
> ---
>  tools/patman/settings.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
