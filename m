Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CF1E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE72804FA;
	Fri, 20 Dec 2024 05:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Od/KBcdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE986803F5; Fri, 20 Dec 2024 05:06:37 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A858037B
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso238848366b.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667595; x=1735272395; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NYkRLmjpdcq4Zk/7IY0VrTNAo2POpidhqmit2VyPVho=;
 b=Od/KBcdxO/2Apwy+u5r9bh3nvJpxyk3tfRTSN4n83PSB9yVSOsY60NF3fFotJMLRz8
 /BIec+QYil7o+Y8abeizSSn1GHwx7toK20yLhEx24xbNLUW2z5oC1m1y0M4R+Dmjs2yR
 z+xWdI5Aq1kv478G6t3rYRv3bNnFHCd/oaSIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667595; x=1735272395;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NYkRLmjpdcq4Zk/7IY0VrTNAo2POpidhqmit2VyPVho=;
 b=ZzFq7zv1+/k63pQ7AkTfr4fPqv8yBmweSr3YbgPxVp39Nb26hoKOiAjmk+NnkLoYx8
 2f07t2DXPVOj4X8965oNSrnQx0CJNZV7fZ/wWIR8QkWppYVtscdElhf6nUVhL6ZWxx7p
 7pRBVPKYVsePpDW0EqCGAPXrjMDGrvQ4G0e48RcoHPvcAGTWY0BolYRrdre2pEGS4ozz
 gpJGisTX30USx7obDWGcKdt73M0p7dfpDGCrnuD95iZz2zs/17nJ6susU4tiFLZdFfWO
 oiuJCXZ35Whq4CeFq4Vs4AiMArKY2ZZln0W1+93LvRnbbcksz35I+FHCfgv+2EbPi6vZ
 UcLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8ZBeTNdCtHni9Ek9YeYxQ5sjR9X03yXWNxF1H84R5IShmTO8WruqqsFYLuCWAu8RJNw+2KN4=@lists.denx.de
X-Gm-Message-State: AOJu0YzxRFL6YPHFKb2iXZlnxw4a/WrsHtyUCtKs3+LiWFk2xqd1ZARQ
 d9dOtHYjHQgprZwU7cpSHvN7S78nHFpUWA+iNsxT3xWiJGAZSrttj8hVuvgdl2o6Fz6Q2oW4qn5
 DpaJhEcUdw26uzFXtdkzdqrPtGXk5TnKIKa9K7sFsab8L7EU=
X-Gm-Gg: ASbGncu51T6V/0YMht2kULN4UBfBRP3BYtxjG1oX1VeVtuBYAlrKtKuk+jUDbEWylMs
 LkvI4Uhu5kDsAevdgoMT8VOSgmDGBOiC9KjRyhnQ=
X-Google-Smtp-Source: AGHT+IFRNvwqgn6Mz6XjhKqgRpwESs+RKEl2x74cNBUuY0ndyO36iSQsOZ3lGciIXYM12L2AAWefr+o3/UHGSOLcvBo=
X-Received: by 2002:a17:907:1ca2:b0:aab:a0d4:ec8e with SMTP id
 a640c23a62f3a-aac3368f9a6mr96133666b.59.1734667594994; Thu, 19 Dec 2024
 20:06:34 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:06:33 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-12-sjg@chromium.org>
References: <20241206023626.2456858-12-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:06:33 -0600
X-Google-Sender-Auth: G8C63rLPxFF_S67d4O1sBROtPkQ
Message-ID: <CAFLszTiCGLpnkuyoz8qxmOH5W3S5ETwiEqwv4D5i7giTzcicOQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/46] boot: Split pxe label_run_boot() into two parts
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
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

This function is quite long. Split out the FDT processing into its own
function.

Add a function comment for the new label_process_fdt() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v2)

Changes in v2:
- Rebase on earlier change

 boot/pxe_utils.c | 100 ++++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 40 deletions(-)

Applied to sjg/master, thanks!
