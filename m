Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF068FD9E1A
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 22:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E01D83AA9;
	Thu, 26 Feb 2026 23:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WmFkxkWj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B87983D1A; Thu, 26 Feb 2026 23:05:33 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5941583642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 23:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linusw@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 280956011F
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 22:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22EEC19423
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 22:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772143529;
 bh=3ZbTNTpqwWK+vYDoLKERNgiG+SUF841jTBKF67BW68w=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WmFkxkWjqDO1Zp9phJ66hkbVEWfhSwDv3B0ZpTxFb8WyOkqM8sMz7JAKqege/xEQW
 qIsNBfipZuQXB0b+velm6u+BlgWs7SNO7QAqSGw/QT/wRZhKtAAbpAXL+mP96/dgZB
 8jpPTjDsxD687TvaHMqyJMjIuG0pav7wO72qOHxSYnD6KDHRFzbSE3FzfBf083Rtan
 RsYmGvV77mozF6UEQBLBKhGlqItXsOYxWPm1GUO1CtZ4gwFlhr6JWup8hB/dhyNCMw
 JIRHyyahqxMakeHbLNEdou1JSpxx+6CVzVdnv7EHRozHhL2Rv1kY01vHSBtg84+Gwk
 DU4cbvOuxWHHA==
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-79827d28fc4so14185777b3.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 14:05:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXI/MsfXpbZxBzfhYP4ILFvORXGOji3LM0PNmAxxNlCs9lUcENZp8Axv/0QcTDJnj+AXYJtehY=@lists.denx.de
X-Gm-Message-State: AOJu0YwtfglhTj+lChM++3YzVOEHGY16u0UWsHYFPLMx71WQ2KJyvDIC
 atcINt/gIttTLjvXfgwNEImajYGcSyDZyntpv37ehQVcxXhUFRbUwlWz8NufXabatzt3n+wQ0Hy
 7aeEuAcwaRxxaR0p8eZbpHSSzpMf6vrU=
X-Received: by 2002:a05:690c:e34a:b0:798:6a6b:5b0f with SMTP id
 00721157ae682-798855a6876mr8033777b3.32.1772143529230; Thu, 26 Feb 2026
 14:05:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771856828.git.dan.carpenter@linaro.org>
 <62727b8bc822e07ad546d9e9fe4373a372a3f1b9.1771856828.git.dan.carpenter@linaro.org>
In-Reply-To: <62727b8bc822e07ad546d9e9fe4373a372a3f1b9.1771856828.git.dan.carpenter@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Feb 2026 23:05:18 +0100
X-Gmail-Original-Message-ID: <CAD++jLkw0A8ZUXFCQYiPHHwA8o4nspT+GsEHfNdsNZjwU94Qig@mail.gmail.com>
X-Gm-Features: AaiRm51tIPbcMQ8UIJZoGNzHAPEjgsLBBnwJnn2zxY5dF7yiLyuzWJc6fbcv4fI
Message-ID: <CAD++jLkw0A8ZUXFCQYiPHHwA8o4nspT+GsEHfNdsNZjwU94Qig@mail.gmail.com>
Subject: Re: [PATCH 1/4] scmi: pinctrl: add pinctrl message IDs
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, u-boot@lists.denx.de, 
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>, 
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org
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

On Mon, Feb 23, 2026 at 3:33=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

> Add all the pinctrl message IDs.  I renamed SCMI_MSG_PINCTRL_CONFIG_SET
> to SCMI_PINCTRL_SETTINGS_CONFIGURE so the naming matches the spec better.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
