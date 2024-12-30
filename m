Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763D6E77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 08:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B376B80583;
	Mon, 30 Dec 2024 09:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="l04qG+86";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF6380584; Mon, 30 Dec 2024 09:49:51 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD19880570
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 09:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECBDEFF803;
 Mon, 30 Dec 2024 08:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1735548588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOK1f6qXl5YljLTFLIb13QKfR/vYbHxnJLcLjttrHOw=;
 b=l04qG+86QXCTNmG++hZBupYqt2X0YS+CBwJ+i0zESr1bn972/oAvnriq5ZN0pYn5mbNcnH
 +Ia3+c0rjb40icBIERkbnic+MZ6NnJajee0goII3vDXAWagHlp9wPKrDupKsGA4kBllm2S
 xEK9+Pj7NYrRCK0mCAhrTRPMC3cw6ylwPS/hDJ+ZG4YST9h+d5P35e7UYjLq1P0oZirW1F
 QwaJHICIPd5bwWdY3X1mWX1MJyitril/E14Je2y58tjwQWThNjEigj9CPaYrZ8Lw9atB9O
 1WXrUUjfS0KMYgFo0G0FzpZCBA/xxDhUjiIM9L6dF3UEDkRHp/d1WzOA1JPsWA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,  Tim Harvey
 <tharvey@gateworks.com>,  Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] tpm: update descriptions in tpm-v2.h header
In-Reply-To: <20241224220049.26629-1-heinrich.schuchardt@canonical.com>
 (Heinrich Schuchardt's message of "Tue, 24 Dec 2024 23:00:49 +0100")
References: <20241224220049.26629-1-heinrich.schuchardt@canonical.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 30 Dec 2024 09:49:47 +0100
Message-ID: <87y0zx8sic.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

On 24/12/2024 at 23:00:49 +01, Heinrich Schuchardt <heinrich.schuchardt@can=
onical.com> wrote:

> * Provide a link to 'TPM 2.0 Library Specification'
> * Remove outdated comment for TPM2_NUM_PCR_BANKS.
>   The value 16 can be found in the current standard
>   TCG TSS 2.0 Overview and Common Structures Specification 1.0, rev 10

What about including this in the comment rather than dropping the
comment entirely?

> * Describe some of the structures in Sphinx style.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Fine otherwise,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
