Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16F7E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D1C8036F;
	Fri, 20 Dec 2024 05:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UMQqjWG2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE7080362; Fri, 20 Dec 2024 05:05:03 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D5B880087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so291099666b.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667500; x=1735272300; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YAMy8wzgovc2aiEQmbojORxKEN3uhqvoL9rVqbSHbyc=;
 b=UMQqjWG2cJL/o0BGrxahqfmoUYMpG2pxD+QKOcV43eSfVtvX2ivUYRBKqkMwp1FgGK
 MWtSK03DzAW0CzhCR/jifdC30+ZmulFQ8ByTJ9eAhpLCKL+C21bq7HHB0mRHsS2+n82f
 /FXPbCmby5s+rwnohyWdl0TXgPj+UqZ2J+5S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667500; x=1735272300;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YAMy8wzgovc2aiEQmbojORxKEN3uhqvoL9rVqbSHbyc=;
 b=xLYT/LOLvSwx/EPRw3TdYioPsuqAw6nyy3RZ0E32o1onL70Hz89IFeEjNOLhhflIa3
 8fONPLLm5sUDBCXy07M+xXzm0eI+sq6OrZgQbcgkFOO5yZriXk0zqaKnoZA0Ssw/B7em
 choQ3PBr85zI1Zy2k3S95lWpiBcpsfGcgDRhQaw26K3uiHsrj6rkXzl+iFVPXwykHDMl
 fRoeMpSvvI2KOU6o1yc5paRUpTsjvhdg5eK1D6Z4DO+qZuB3K3hsEERR71e42iHks4H9
 sFRf3A5uPW+E+razyDviqhUoG0ubjcnvjFqo1fvkKJDz1EZOSg33mAJuvwhs8LEZ6x5q
 RMtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe6jMM7Ddrp5ceDjZ2yGvzAaFutiqpVLu5R6AV/6ILh+HxeMntr1xsXVWMHl3NtIYiomUwVXc=@lists.denx.de
X-Gm-Message-State: AOJu0YyWRFVkMo77c0l4SkIqoq8EZ2DvzuYipvaElHZKyMeHFojBpCE/
 qCl1RbGcm7G6kGBsYSMNq8WM1Cu3oQkSyLH7sVSaXpCYpIZraYRcq2qG/gLTq6fJyTcjdO6YvrR
 h82wMiGCuzqOUo+24addnHhBimaX8J17Dsru6
X-Gm-Gg: ASbGncv/siaeONGXvRF6qOEz9KD0ILkXVVZVBG3/Kzfffpo+AdYk7x2sVNu1LhqAoRe
 app1rGYfJYz1Qikfqak4FfulnkFRKQhxkui5JIRU=
X-Google-Smtp-Source: AGHT+IEtmKr5vxgIy/gixdFtQ05nhKtUsjK3gZuP2wewoVB7tWnDPk49Gs5hxjsDq1MuU/73d1f4HrZBa+3rPvxgP/M=
X-Received: by 2002:a17:906:c14d:b0:aac:1e96:e7d5 with SMTP id
 a640c23a62f3a-aac337874f7mr92454566b.53.1734667500598; Thu, 19 Dec 2024
 20:05:00 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:04:59 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-44-sjg@chromium.org>
References: <20241206023626.2456858-44-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:04:59 -0800
X-Google-Sender-Auth: Tsv2JKVZZy7kwaKWkaR4NQY6zoY
Message-ID: <CAFLszTisuRvRe-oBQrpSrGZG26CsD52JFTDzKScra90e7NDk=g@mail.gmail.com>
Subject: Re: [PATCH v3 43/46] pxe: Deal with a missing FDT in the bootflow
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
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

Move processing of a missing FDT so that it happens before booting, so
we can see the result in the bootflow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

Applied to sjg/master, thanks!
