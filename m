Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB82C2A079
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 09:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7358283A9F;
	Mon,  5 Jan 2026 10:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fIF0Q5hm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743F583AB7; Mon,  5 Jan 2026 10:12:04 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF0A83A3B
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 10:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CE00440CE;
 Mon,  5 Jan 2026 09:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D304FC4E694;
 Mon,  5 Jan 2026 09:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767604320;
 bh=1fjpVmayugVsmjwn4uQr1ZqzQVEl5Le5mCImEpwmvEg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=fIF0Q5hmOLe8gCIqD9jXOEzksL/QNQ/Cv1/+vFGoQRpY52fbdlsRkWCJw/N6QojFL
 yUJNw9h8jcIESz4yMiKYruq52ziR1NTpM5aS6rrmmazdisVdG71wRFJqSw7BUqPUiZ
 n/q7wmHDYC0pUaSI8FccpJDt7vYNiJrtdsmrkitup6D+MYtNBz/gUxYGqJiBGpeokT
 HgVFu0eo4m5P8XoPERI0ru51Ew8bJ+ctpSx+PzjculCJnPUsO7wPRh7clxcQ+zUeuc
 bqY9622Yvzd2H6PXBT6fzsOwU+ZpKi7MoD4uEiA9GYQOmgQYJ2/RP+6RKtXPNrqxbs
 4Pgj00daEUNpA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: =?utf-8?Q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Trimarchi
 <michael@amarulasolutions.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Anshul Dalal <anshuld@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Andre Przywara <andre.przywara@arm.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Simon Glass <sjg@chromium.org>, Hrushikesh
 Salunke <h-salunke@ti.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, Alif Zakuan
 Yuslaimi <alif.zakuan.yuslaimi@altera.com>, Sidharth Seela
 <sidharthseela@gmail.com>, =?utf-8?Q?J=2E_Neusch=C3=A4fer?=
 <j.ne@posteo.net>
Subject: Re: [PATCH v2] Update links to doc/develop/falcon.rst
In-Reply-To: <20260101-falcon-v2-1-75896535ad0f@posteo.net>
References: <20260101-falcon-v2-1-75896535ad0f@posteo.net>
Date: Mon, 05 Jan 2026 10:11:57 +0100
Message-ID: <87344kh19e.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi J.,

Thank you for the patch.

On Thu, Jan 01, 2026 at 15:17, J. Neusch=C3=A4fer via B4 Relay <devnull+j.n=
e.posteo.net@kernel.org> wrote:

> From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
>
> README.falcon was converted to ReST/HTML in 2023.
>
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
