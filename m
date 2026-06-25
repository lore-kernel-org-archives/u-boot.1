Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A62BCDE007
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2CF2849D1;
	Thu, 25 Jun 2026 14:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="iSi6HQit";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1034847C8; Thu, 25 Jun 2026 13:17:45 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B82A8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 13:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=herve.codina@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8508AC5CD50;
 Thu, 25 Jun 2026 11:17:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 20E695FF03;
 Thu, 25 Jun 2026 11:17:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D2D71106F081B; 
 Thu, 25 Jun 2026 13:17:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782386261; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=SBn6mDXRFPsELbRSp9+xtHhiQx2WAS/VZZsh0hsBVUk=;
 b=iSi6HQitDU/btmXA+4jfNxdtsH8kXzVGayIq/FD0bw7SYmtYs4xMjD5Z17ldcWU3bDOTti
 TWV6mDcOUYdZKvwGlf2KiMxfLsw5xIg4GQp9X3AuHP5FUdHdtoULT3kEj9jLEvJr2NGe9k
 ehNruFkoPLPN0VPfzLKE7ZVaXKzGSXZqHPkNmDpU1hMbo5v6ykhfWGhIEoOfrg7ktIUD2/
 RCI1IglKoZNpJx9ZT3fkOvwseSrFPYTbRV4QTJP4JXzo/Q9AiG3MOgtd8bZjns48QeWo4U
 sN+qmnScQIbsKpYozCG+E3OGm+U2jEXgYM7bujhNx6o7TwjMFD3h5y0pDe9X9g==
Date: Thu, 25 Jun 2026 13:17:30 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Kever Yang <kever.yang@rock-chips.com>, Peter
 Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, George
 Chan <gchan9527@gmail.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Peng Fan
 <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, Stefan
 Roese <stefan.roese@mailbox.org>, Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>, David Lechner
 <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH 1/2] linux/list.h: Add list_is_first()
Message-ID: <20260625131730.6464dc03@bootlin.com>
In-Reply-To: <20260625-rzn1-usbf-v1-1-0e1a38f7b82c@bootlin.com>
References: <20260625-rzn1-usbf-v1-0-0e1a38f7b82c@bootlin.com>
 <20260625-rzn1-usbf-v1-1-0e1a38f7b82c@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

Hi Romain,

On Thu, 25 Jun 2026 11:05:25 +0200
Romain Gantois <romain.gantois@bootlin.com> wrote:

> Include the list_is_first() kernel function, which will be used by the
> Renesas USBF driver.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  include/linux/list.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
