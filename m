Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ED1FD5322
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 09:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908C283AA9;
	Fri, 27 Feb 2026 10:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KCeGh1sr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67EA183BB1; Fri, 27 Feb 2026 10:42:34 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E7E683642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 10:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FAF243E61;
 Fri, 27 Feb 2026 09:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD011C116C6;
 Fri, 27 Feb 2026 09:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772185349;
 bh=ISbJafv8L7DPMmDrgwsRAyNBqGRN8eLNMZiwHRX8Ahs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=KCeGh1sr4Zd95zeCUDbQ5TV0qfwD2/lD9xglngN1GPLceyAjP/hMR/Pt+bJC54d8a
 +SVfp6Xo0HASP1jKv7dvvOqr6gviIbKCVNoYe9RLofSeZYAT7//mINywuA6gp+SAZh
 h4MMm3gjyx5WDNRRcCe0PY41vBkjZfGJE4Vu3hBcuGTmHE/w5KAFS6AW4zzvi+lTJX
 l6Y2xhuu+w5HAlzDsAxuedmpqQiLy5AWfKWv1FMCiyW9fuAgxWZA9BWHWBLSBGQDf2
 iqXE212vuBFyZRNr7lsPYcJLILPHFObTVBIKd+hNOl+q0socATsf2mpE+l2bVkUHAV
 R6gX52Rr1NmWw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@nabladev.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: Re: [PATCH] usb: gadget: Mark udc_disconnect as static
In-Reply-To: <20260224154504.85301-1-trini@konsulko.com>
References: <20260224154504.85301-1-trini@konsulko.com>
Date: Fri, 27 Feb 2026 10:42:26 +0100
Message-ID: <875x7i1q0t.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Thank you for the patch.

On Tue, Feb 24, 2026 at 09:45, Tom Rini <trini@konsulko.com> wrote:

> With the last external callers of udc_disconnect long removed, mark this
> function as static now and remove it from headers.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  arch/arm/include/asm/bootm.h | 2 --
>  drivers/usb/gadget/ci_udc.c  | 2 +-
>  include/usb.h                | 9 ---------
>  include/usb/udc.h            | 1 -
>  4 files changed, 1 insertion(+), 13 deletions(-)
>
