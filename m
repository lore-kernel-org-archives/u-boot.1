Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5536D11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 10:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07DAC84332;
	Thu, 27 Nov 2025 11:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BYZ2+xIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7290984366; Thu, 27 Nov 2025 11:16:50 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D6208432D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 11:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 82AC96013F;
 Thu, 27 Nov 2025 10:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38EAC4CEF8;
 Thu, 27 Nov 2025 10:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764238607;
 bh=bgai0aQND5Y1QaKB85u8XD+Oc6F6tBdTmCwFwRa9Fgg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BYZ2+xIQxAke44TZyzaeSA7qDpD48XVJgJgDbrWEBgEg3ZvBkiwcuQ/yWgkz6P0sR
 vSlSRwWv1q923f1/9m+ph59+t2EaT8YUtNfx2AMU8PL36B+2zkE3tafu2qoVnMRqHj
 6I0YCulo9JipadfIfLM0YoJDYuzHz+y0BN5t6T7aw7dUNB2Aw0PeW0OnrtErc4UTgV
 983o/sB/qSjTFCrqLFj+9VGQ3wJhJJnTSJ10UU91zqoOIzcjLdW/pUDKls+Y/t68C8
 6kO5BnS3LqFX75lW1djwwXLgX60PsXZfHHZmzs6PFOesrsg9VB79wN+6rdLV+OOkm/
 S5vA6aggAmC5Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de, Petr =?utf-8?Q?Bene?=
 =?utf-8?Q?=C5=A1?= <petr.benes@ysoft.com>, Michal =?utf-8?B?Vm9rw6HEjQ==?=
 <michal.vokac@ysoft.com>
Subject: Re: [PATCH 2/2] usb: ci_udc: cosmetics: EP and requests debug info
In-Reply-To: <20251125085846.507591-2-michal.vokac@ysoft.com>
References: <20251125085846.507591-1-michal.vokac@ysoft.com>
 <20251125085846.507591-2-michal.vokac@ysoft.com>
Date: Thu, 27 Nov 2025 11:16:44 +0100
Message-ID: <87cy53srub.fsf@kernel.org>
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

Hi Michal,

Thank you for the patch.

On Tue, Nov 25, 2025 at 09:58, Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.c=
om> wrote:

> From: Petr Bene=C5=A1 <petr.benes@ysoft.com>
>
> Make a note in an unexpected situation, e.g. queuing a request
> on a disabled endpoint, enabling an enabled endpoint...
>
> Signed-off-by: Petr Bene=C5=A1 <petr.benes@ysoft.com>
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/gadget/ci_udc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
