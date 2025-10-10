Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8687FCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD168436C;
	Fri, 10 Oct 2025 16:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bBFaC39Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38E0A8425A; Fri, 10 Oct 2025 16:22:12 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D544483F7B
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3478C49164;
 Fri, 10 Oct 2025 14:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A903C4CEF1;
 Fri, 10 Oct 2025 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760106128;
 bh=lo1lDN3YFtNYyxb2VhEzw+pl+FoY7DKEUyFZQTYk6Zw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=bBFaC39QNfjDc4OqMCRct0G60kJ4rQ51lSKyi02xJg87TiurUxqZQCRy8mXuGHtjz
 BPQCyx0yABH1cQvNnF253UPyKy9VPfzTRpPfat2pVUGL1HCqSAhC+BDODRHJu1Psi4
 X8/tUyQbDukBz6Mi+RxyZD+xb3DYeSMsfSFXp7TM1LAohc0lQCHsyZBdZPvzkR6GkR
 0PeLTnSH3T2NZ6xvz490/xSoGQ0nCEz1aVvqHsIOlxgEMJ/DeHIFcg8zIW0wIYnMU7
 U5sRb6XkYqoos6dheDawP0K6lFudBv1NqjO8Fe2PNYXuTZq1XKt9zoB5NoCkjKspCG
 v0le3XbX3hrNA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Frank Li
 <Frank.Li@nxp.com>, Fabio Estevam <festevam@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
Subject: Re: [PATCH 00/10] Enable USB and ENETC on i.MX943 EVK
In-Reply-To: <CAOMZO5CPQNJhRcZVOedcHfRq0j5pxf3T8rkRmAgQGmCddMNJaQ@mail.gmail.com>
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
 <CAOMZO5DArO=XT6NjUheyL5-ec-s0WxW9PxTNEBZ6QXvdGVG=9A@mail.gmail.com>
 <c5f7315f-f5f0-48ab-83f4-9472c1c37fd7@mailbox.org>
 <CAOMZO5CPQNJhRcZVOedcHfRq0j5pxf3T8rkRmAgQGmCddMNJaQ@mail.gmail.com>
Date: Fri, 10 Oct 2025 16:22:05 +0200
Message-ID: <87qzvavnua.fsf@kernel.org>
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

On Thu, Oct 09, 2025 at 19:42, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Alice,
>
> On Tue, Oct 7, 2025 at 8:27=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.o=
rg> wrote:
>
>> I don't think I ever received the entire series, can Alice please resend
>> it and CC me on ALL the patches ?
>
> Please resend the series with Marek on Cc on all the patches.

Hi Marek,

I checked the series and it looks like your denx.de email is CC'd on the
whole series: Marek Vasut <marex@denx.de>.

This is also what's seen on lore:
http://lore.kernel.org/r/20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com

If that one is no longer valid, maybe we can consider updating
MAINTAINERS?

It's still listed for the USB entry.

>
> Thanks
