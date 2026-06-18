Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66617CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 23:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDCC84671;
	Fri, 19 Jun 2026 01:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="CkFxQmzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60BE9848EB; Fri, 19 Jun 2026 01:53:31 +0200 (CEST)
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8548460E
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 01:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1781826808; x=1782086008;
 bh=Y0D6sVi6+VqzI5WMixgK4FcybS4oZVkKmU1K+0bopck=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=CkFxQmzMZhLSUDnN957AxGb4Xk38iwpwel0tnH4KeJvp8Zs2dCLIRK4JGQOx7vNJL
 bSE7WqqjM+xX+dWdWlg/oDm98Xgi9DWG17xyOUxVW05cdKA0S0+hYCgdCHE9KQV7J3
 9DIBILqNRjEBrfsArpOMmZtS4LZdPdzn9+0db10jXKw1aDGjfVUl2DG+iqf8NgW9aE
 1Q7XCH2croLofegDlSDWcGglGZb1MqB3DMkKMSSGIsk51IbX4IJ7vNdCtBBnWJgoo8
 NYg3PHT3OvTaeKDVwnVTc758Zk9q7FVr9UwaEyKwdvp8FKfdFiJUtI45SZJzW3z+LK
 GvIx2K0pTUnCg==
Date: Thu, 18 Jun 2026 23:53:23 +0000
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] doc: android: fastboot: Document halt behaviour
Message-ID: <6zjo6pj8iO7TsStZIhljqTqhPIHy225E4-AVp-uL5CO0a_JRgO7hdwN5JiGBfKnm8cOcFt6arN1DhXoyVdZiVR4-DZUfOIKmTd7tVcR0bJc=@samcday.com>
In-Reply-To: <20260615-fastboot-doc-ctrl-c-v1-1-f932dea17c0a@kernel.org>
References: <20260615-fastboot-doc-ctrl-c-v1-1-f932dea17c0a@kernel.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 14941845201b45bd02288d8a23e7c2861d70beab
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

Hello Mattijs,

On Monday, 15 June 2026 at 10:29 PM, Mattijs Korpershoek <mkorpershoek@kern=
el.org> wrote:

> It's possible to interrupt the fastboot command from the U-Boot shell
> using the Ctrl-c keybinding.
>=20
> Document this.
>=20
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---

LGTM, thanks. I added this patch as a dependency of the v2 series for
introducing CONFIG_CMD_FASTBOOT_ABORT_KEYED.

Kind regards,
-Sam

Reviewed-by: Sam Day <me@samcday.com>

>  doc/android/fastboot.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 19e2ee9d4074..818b8815ebdc 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -212,6 +212,11 @@ or initiate a reboot::
>=20
>  and once the client comes back, the board should reset.
>=20
> +It's possible to interrupt the fastboot command using Ctrl-c::
> +
> +   =3D> fastboot usb 0
> +   Operation aborted.
> +
>  You can also specify a kernel image to boot. You have to either specify
>  the an image in Android format *or* pass a binary kernel and let the
>  fastboot client wrap the Android suite around it. On OMAP for instance y=
ou
>=20
> ---
> base-commit: 1e80ee41441c612f05787a93bbef4e6e422e29d1
> change-id: 20260615-fastboot-doc-ctrl-c-3fac73518cfe
>=20
> Best regards,
> --
> Mattijs Korpershoek <mkorpershoek@kernel.org>
>=20
> 
