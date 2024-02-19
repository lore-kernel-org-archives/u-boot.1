Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2796C48BC4
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 01:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC1887F20;
	Mon, 19 Feb 2024 02:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BqI6fJN0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE1587F1F; Mon, 19 Feb 2024 02:39:51 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B67A787F1D
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 02:39:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2904c81f26eso551899a91.1
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 17:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708306787; x=1708911587; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqAT5r8//s/iZpvdQpCO3EMQaRBRLocjpFa9gH6AUWk=;
 b=BqI6fJN0V+KRGbqnzi28aY8aQP+OdnG9zL6ORkH81qR6+OqqFKZdRNUgkMo5ifSoPt
 eeJRJE7TCMSSEtOrlbxEztRGscAGWPCO4rWISTK9/WXN1Wf4FyOmfWPuEbZjTanjpjnu
 RnKsemxPDfdgPXxWko1MPWBvPSIOfOMOqlPY7mvJU4d7OQZhzmqVR6kLrVtsT6afr8Fa
 Fvw065KiEvIICVhtOAmCRtWOv2N/+gCbbIfhVbDnZfBzKqmniQuff64m4ikUnWKd8lI0
 8OBDNYRnzCpAnZcCgX7KegSRnSxGeWJnJI77l8MwvxhJSoHvtCgRD05RY7POe6mWJM1d
 7KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708306787; x=1708911587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqAT5r8//s/iZpvdQpCO3EMQaRBRLocjpFa9gH6AUWk=;
 b=kwnohntNzFi0ZZ/+s29wNSfzhh5L3NdjzYA/Ik/HDyESxEoSKWdswxBpX9Q3pDOeQS
 itbmknXVpztuxUdPq29fym2w1Z9JpWeA03IeIqruqABf89f2FQkCtJXmgVQLXwvkFqZ0
 UbXx+ZC7/wXKCVsfegjRuhrT+jiKDoJaUTHOQBu4C+fqQ/wvRyXRO+CjhHzquq/UCIyt
 lh3urZDdCztS19FjdkoLZJq/O4techJomHb/gir+m1pGxvIMbbWGumZFSP9S6mwzuXQS
 5lOWDJLhg2cDP6V9sMqgQgqZ6ajIHzv+CWiN/y7TyMaQ81hgcvRE92MxUzBOYZ5LDs7W
 FeUA==
X-Gm-Message-State: AOJu0Yx7e8x60MBkS8LW7k4q+iMHSN8LIi+DfgFHsa00QPXZu74Rg8IF
 xbcEafAaf53wkLiQj1hBnaOy72yzfQUWw+aKSf1F3Rcr6P9EKm9XmtBtzJ36q/z2yXVsfJkMbW5
 qZ6XvGY3T5FDUu8j9K45cgKvX/xw=
X-Google-Smtp-Source: AGHT+IFYjIk85VOgO+4++PfXlpsWUFB0D1zhK8R3Iyn/Mb35/O2nHchH4ZwqCMCpMh259P99rOrdx54GdeAQsKzSH34=
X-Received: by 2002:a17:90a:300f:b0:298:b2e1:48dc with SMTP id
 g15-20020a17090a300f00b00298b2e148dcmr6878450pjb.4.1708306786963; Sun, 18 Feb
 2024 17:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20240218211958.2849847-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20240218211958.2849847-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 18 Feb 2024 22:39:36 -0300
Message-ID: <CAOMZO5DQruTiaWMj4zv8gKyUJqtYqb5bmf7Z-Upc7k2+6yCffg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm: dts: imxrt: Add binman support
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Jesse,

On Sun, Feb 18, 2024 at 6:20=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.co=
m> wrote:
>
> Enable binman in Kconfig and in device tree.

Please explain the rationale for doing this.
