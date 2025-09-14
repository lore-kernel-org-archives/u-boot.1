Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC51CAC58F
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 12:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55DA480B9B;
	Sun, 14 Sep 2025 14:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="RWNTlnTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59BAA82AE1; Sun, 14 Sep 2025 14:21:38 +0200 (CEST)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [91.218.175.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C2980077
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 14:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1757852494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qshQm6wdpNQCBQU99mETFn7xrf8l0nLSbNp4NcWs6is=;
 b=RWNTlnTNE29nMvKacAKj5WzwZ+cMo5kZ1p2F5EJcbJbdQvSBy6IKp/iCaLYVRunX0O/rK2
 QcECSRhwgQSwv77/IaVghRhgCPr9ER2BrvVplI2LqsXcrYD6J93RJpASpwAMHGxmVbb6Ll
 iIZ1x+RqI09Q+IqjrkzOmqMqX1Ngs93sj+A6cIJNBnLBhzq4p2W3KGaQx8NRI1Pi9Jkerc
 aQtPob/PDp2EHQ8uWcHInY3mfXzGoWBf483adJ5bvUiO2uBlnxXHhkL5S6iuQH24JqbeGk
 oCZ6xappzUgqbxPRl0TgAUOaJTkr1sE39BrItgP9gYc39PE6BAfy6eO/u7j46A==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Sep 2025 12:21:30 +0000
Message-Id: <DCSIP9YKO8EZ.8LUZKIEMJSWM@postmarketos.org>
Cc: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung"
 <jh80.chung@samsung.com>, "Beniamino Galvani" <b.galvani@gmail.com>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Tom Rini" <trini@konsulko.com>, "Ferass El Hafidi"
 <funderscore@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
 <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
 <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
 <3875c210-7d29-4bca-b535-0522dc615cc8@canonical.com>
 <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
 <20250913155100.GA67696@bill-the-cat>
In-Reply-To: <20250913155100.GA67696@bill-the-cat>
X-Migadu-Flow: FLOW_OUT
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

On Sat Sep 13, 2025 at 3:51 PM UTC, Tom Rini wrote:
> <...>
>
> The way we normally solve these kind of things, since they aren't
> actually configurable (it's part of the chip itself) is just #define
> them either in the driver header or some <asm/arch/..> header file.

Yes, this is what I did locally.  I'm waiting for further feedback
(on other patches) before sending the v3.

Thanks.
