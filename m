Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4023C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 19:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F81388A99;
	Fri, 23 Aug 2024 21:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cFecP/OL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 698F388A99; Fri, 23 Aug 2024 21:16:22 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D5488A39
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 21:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5343617fdddso2994438e87.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724440579; x=1725045379; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwQtlaPFwPj4DQH9vXoO4t+Flxn5qe7SPxkt9eMIR2Y=;
 b=cFecP/OLAG0reJD5Rnc+HYYyOI+W7y533xRgK8NKX81x3RG8o16r1K5XuZ7zvLMLGb
 jnKlXiE5gqEnZbyoWwwqWPzfhBYdiDLDp9uZBuOIFWe0iXOa3MDPLvOZd4mmSP2rwUEU
 zy+OZAIJwx5sbihrw9MN83EIWP8T4+QZDD5yIsyt4HEgkzaG+266lkRLIkCpfGe1/0E8
 mGAwsbP+g2v6Dvu0nSHo/KExed9CjjPC8wB6WIs3wi2f3vlwDRo5heoGgQb9uvGZksOE
 CObsGR339Ylo1LWs7vtSLhjf8INVbqslz81Lceft740qW6didF0cCIT+Ac6eS+uyya/a
 hNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724440579; x=1725045379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwQtlaPFwPj4DQH9vXoO4t+Flxn5qe7SPxkt9eMIR2Y=;
 b=e+XGw6hIR0sdyfyNzcTzureeV6bi2bpxv1lH1y5XAT6nWyxwOVYmRrU8eCVKOpcWL7
 mPi2uC0sArvzPzt7OWpRjD0sEOSXRDfIKRhKD2SwnId2dezgTVvIbZgGY9BlJEbauTYT
 +tcAhnE38rewC8eib27s1cpLS7hH06ygnR7ZtjJk/4xU8pnUKKUuEN3Lk2AJsdVumogC
 TLZr2abL2SoKUE3SPs/QKLPCCkB98baFKTyYIYXESrF/PpvqhrES1N+y5P7vY9yn969T
 ScDUHhc0YLY++sSGz4K0vRa3blJ68/drsElbfr38niFIIq+AMF8CkE/KReC5DadNelRa
 uP4A==
X-Gm-Message-State: AOJu0YwrdzFzjKSYkJiX3OVT5v8x4S9xNqyentu6qpESVbKf/ONU2U8N
 I/RalWhP8DyH+ySutNgyH4N/Nb0uneRs6XQNV4Uy/rTp8VCbKoU/6kpA6mXKMzbn2wHimRV+Z9f
 W/MGbPvfkw32gK5/na3QHyl+W45sbWg==
X-Google-Smtp-Source: AGHT+IFnD4gktjvV15+CpNxZdyRGk9N0T6WDlXVCa+qpxkfanUGiQFTwQQW69zQuwaR5KaMtZXbV/QQV+eP3uyQ7AeM=
X-Received: by 2002:a05:6512:138e:b0:533:3fc8:9ab9 with SMTP id
 2adb3069b0e04-53438852315mr2763206e87.34.1724440578479; Fri, 23 Aug 2024
 12:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240813121217.2279187-1-primoz.fiser@norik.com>
In-Reply-To: <20240813121217.2279187-1-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Aug 2024 16:16:07 -0300
Message-ID: <CAOMZO5CUUHvPq96Dee+nb8of+x+M9CkdrzMA6ygVqBysQJ_e5w@mail.gmail.com>
Subject: Re: [PATCH] imx: imx9: Set correct critical temperature
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Elena Popa <elena.popa@nxp.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, upstream@lists.phytec.de
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

On Tue, Aug 13, 2024 at 9:12=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.co=
m> wrote:
>
> Commit 3233349fa6e2 ("imx: imx9: fixup thermal trips from fuses")
> wrongly set critical temperature to (maxc - 5) instead of maxc.
>
> Fixes: 3233349fa6e2 ("imx: imx9: fixup thermal trips from fuses")
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied, thanks.
