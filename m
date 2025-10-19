Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACE9CCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 13:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3B28206E;
	Sun, 19 Oct 2025 15:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="boEX08RK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 675708206E; Sun, 19 Oct 2025 15:06:18 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 865AF800B6
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 15:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63c21467e5bso4897179a12.0
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760879176; x=1761483976; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=conHHhfFs6GQX1KI0TNE5TF43B8SYOQJJD1Zumrontg=;
 b=boEX08RKwWu6zMazjYMtploY/VEAuSpW+ay3MSiidP1Cd84T5D7ZCL4DiV+7BAvrfJ
 UfPpnzraqnPdtbHu0RzlGKfZ9amlPTl06Vz1srR4ON28eKzOpKcXcW/cuCDCb+jIZP0w
 2om/XRQLad3nS+cp3PH5B9r7CiFtnOFAexYLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760879176; x=1761483976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=conHHhfFs6GQX1KI0TNE5TF43B8SYOQJJD1Zumrontg=;
 b=bWTfIM+ndLDSMtYK47CXRgXeoGlzkzxIS28BcG5PxoU+kjgRudKPIknZHf32WjVV7U
 zfXDPWaUG6iThmOSHLRqKg3umQEdvvDj5zbykxbUyc7/oRbtqSXqopgrHauivlJB+jWO
 idp9TEoayc8BYYS4va333uXg/9c3zEEafkB7SDO9BaTPh7V6wSBifeB2eWW8dPJWp1/h
 swS57vg7eUjJINO1fdpN9OoGWdvoMxLHcHQ/UpMnCl7gIvp+2JFA4FOqVjTkDMHMXLkq
 7g1eQWmVATKnCic0+/zg9FIWlUcObCMBZiB18tbEUY9tVg5dVDuSYvE36EU6p0INzXFm
 6wDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDwUfct6NjAmZAdAv8/5XygkFjKjSMVrQ7K9R9QFJZbD4/kzJ7hSbQdMOVP+js19EVTbxjw6w=@lists.denx.de
X-Gm-Message-State: AOJu0YzIh8dtfnu2lGBKNOW3anDKj6hCU8ukYa5OlhyOduiKwlDIY/2v
 /oVhcu0DzLGLIfBMdby+qOH5jTtrkQkAzNrvD51bq4/Vd/mOiPMJYgxF3LpozOkLzKufde08Yz0
 aP/GzG/QDZzbyaQ0Hd//W0O1923OkSqu1liKf1Jwn
X-Gm-Gg: ASbGncu5q1LYtsLqg3MI/yjW1xqttv6WKVyEcmk8pB0BQiEWrcPYK7XHM4CX390zi5y
 VbPx0wGk1uhGFZmpbPkS8yGteb9c5/SXAY3b4epe+Es602XoY59DxtBhQRwK5+hOioMJME4Nfvs
 w/hBR9yvmZu0HJLpyqEVrKFWNXSAQsSJHMq+pBigJpzjSXX6g17kg6E1EHQCW0iqXjzG4ER8P/0
 3JLhAKTYd0Cu+sMdO3IlqvTLU6XgI00gZv7RS5cFfBMW6BIspp9QWIIEMM=
X-Google-Smtp-Source: AGHT+IEP0DKVipFLsFaWmn13TklILXejIUxGOgiQ8eqgVTOusMxALM4uACE4N2hqOOx+c5J8k+2sybDIQO49SIfkZdg=
X-Received: by 2002:a50:ec97:0:b0:639:dd3f:f265 with SMTP id
 4fb4d7f45d1cf-63c1f6cee8fmr6661480a12.25.1760879176014; Sun, 19 Oct 2025
 06:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <20251013-feature_sysboot_extension_board-v3-14-04067b7422a5@bootlin.com>
In-Reply-To: <20251013-feature_sysboot_extension_board-v3-14-04067b7422a5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Oct 2025 14:06:01 +0100
X-Gm-Features: AS18NWBJOjVaNcRTxWswMLqW_sgktJ5VyrIUCJD5Zjp3HS8--iLjxuD18a-OSjk
Message-ID: <CAFLszTizYDnuMbzGnXCXTGARpuweHXgNbBqpZVT0vtEPBxwYFA@mail.gmail.com>
Subject: Re: [PATCH v3 14/20] board: sandbox: Convert extension support to
 UCLASS framework
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

On Mon, 13 Oct 2025 at 14:33, Kory Maincent (TI.com)
<kory.maincent@bootlin.com> wrote:
>
> Migrate sandbox extension board detection from legacy implementation to
> the new UCLASS-based extension board framework.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>
> Change in v3:
> - Use U_BOOT_DRVINFO.
> ---
>  arch/Kconfig            |  2 +-
>  board/sandbox/sandbox.c | 28 ++++++++++++++++------------
>  2 files changed, 17 insertions(+), 13 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
