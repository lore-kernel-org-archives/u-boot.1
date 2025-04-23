Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56065C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 07:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7538980FF7;
	Wed, 23 Apr 2025 09:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ova0eNwh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE3080FA8; Wed, 23 Apr 2025 09:07:18 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD19980EE5;
 Wed, 23 Apr 2025 09:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A4B544400;
 Wed, 23 Apr 2025 07:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED57C4CEE2;
 Wed, 23 Apr 2025 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745392033;
 bh=VlyzhhN4+vARZCB/6cGvvkl5fMAW9YzN9LGRXWetuxw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Ova0eNwh8R4oZk5JY91zRZ9Hvy3muFWYxquv/SAJ3+iQbJX99saTo7W3D0dMLv0GV
 mD9iuH5zNlghlN6g8lNh/6rjwp6LobB2UHfibHCB40XKIk+zbJDMv8PUx7D+ccHdkn
 uwrnPG/SfCod5PkYk+uvZ8zf2PDDRis+qB1gijjh15VAhwABi95YLsjjPBbpVWk3RX
 uG+OqNLCQMvP6Agc3iIzS2CbbqAkcGEb2p5rPo+TCrxHbzgUAglyCWOYLjtZ/3VLCY
 xBWJNmN1MrRrmB3z09FEXlhFCRNde+0WK13lzBQDJvmUov2un9crRghOoeSCFdkwAF
 0Vml5iM1UNalQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Custodians
 <u-boot-custodians@lists.denx.de>
Subject: Re: Maintenance of Python tools
In-Reply-To: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
References: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
Date: Wed, 23 Apr 2025 09:07:11 +0200
Message-ID: <87a587fja8.fsf@kernel.org>
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

Hi Simon,

On mar., avril 22, 2025 at 17:39, Simon Glass <sjg@chromium.org> wrote:

> Hi,
>
> Tom has indicated that he would like Patman to move out of his tree. I
> suggested on another thread[1] that I maintain it in my 'sjg' tree, so
> here is a new thread to discuss this.
>
> I have already done this for the qemu/efi/coreboot scripts as Tom has
> NAK'ed patches for those.
>
> For the other tools there is going to be quite a bit of churn, as I
> would like to resolve most of the many Python warnings.
>
> Given the shared source between the tools, it would be easier for me
> to do the same for buildman, binman and qconfig. I am thinking that I
> might try a move to allow Gitlab pull-requests for reviews on these as
> well as the mailing list, if that is useful.
>
> For tools which need to sync back to Tom's tree (i.e. not patman), I
> or Tom could do a pull request every now and then, omitting any
> changes that relate to pylint.
>
> Please let me know your thoughts. The timing is good as I am going to
> be sending out a new Patman feature in the next few weeks and it is a
> few thousand more lines of code.

I have a preference for binman staying in the U-Boot upstream (Tom's)
tree. AFAIK, binman is used by the CI and is also very useful for composing
"complex" bootloader images (For example for the TI k3 architecture).
I don't know a good replacement of binman and I'm afraid that people
will go back to ad-hoc scripts if binman gets removed from the tree :(

On the other hand, patman is a workflow tool that's not (I think) that
specific to U-Boot and is (to me) replaceable by b4.

I understand that code sharing makes it more difficult to only move
buildman out of upstream, but in a perfect world, I'd like binman to
stay in upstream.

Thanks,
Mattijs

>
> Regards,
> Simon
>
> [1] https://lore.kernel.org/u-boot/CAFLszTg7-yM0L8uuJyN7Jpsb1LbvOYO76cUWj+H719mfc97mMQ@mail.gmail.com/
