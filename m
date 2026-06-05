Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4624CD6E6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 22:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 554AF84957;
	Sat,  6 Jun 2026 00:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i95QZSEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8125B848A1; Sat,  6 Jun 2026 00:07:28 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FFA484957
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 00:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-68d233bf083so3378218a12.1
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 15:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780697246; cv=none;
 d=google.com; s=arc-20240605;
 b=G70hv/lbs2Tq3a9GvaR1EBuxwvygZ1xerC3h8AzDCz8o/0ebbtp37zLjIdWcdQMbv4
 u4pwakiyOMbwIk7J05OAv0JZ8/vwvn3Jz8olR4E8WG7QTg8VCoDCfzirInOVViA2O2Gd
 QyE/OMCIYiL9fAIXdvovHpJoioC21RormUpiwfz2YXgsdDNzoMsU0vH6j+fNHQf3touF
 ArHsI+vvrQSn3mGazKAVpEbxJdboAqk/X7HACHZDdvD21gB27i7cbF1y23WPLXhM4Y6w
 6UE8mVRc3qKyFXKMKl7pdjwmyFr4aw7fPniJ7LpRjF0cm2vRcVaGwKgWAr09tDqRInPd
 dkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nGYeeaG56NlYH1+05NjLa/QX3hoItuwcpmhbGjiyhZY=;
 fh=0FOPMLHAzJg9G4W4+xF3vZMIljgl4S6tYZjcGVjwOAg=;
 b=iEjAtib/MsQyb6pppn6O4YiXHf3cPty3lPek62JCfGLB1ahXoPLesmhESlcX5yafGM
 NGoA6EjyHDtBz1guS2AfK8QgRkCl6YzLcZEu4s8XY+IPcXhVzFJEhR4U6BY+TX5Laz+a
 h0DSylXBlH/xVTaWbKxyX8A257Gmsy41hT+E1oMX5uw3znw1KoaQW56AdEEgetK8rsUD
 z78NjzazYPBC4MqHOUO3kkxf0cX6QWazTfPSnGI7XBFRTF0hXAjXgc02OSF5xpBU2pIs
 3y7ybXNJ9j/frdnJkFpz1NHYtqCLSgsCxQzcqfbZjojr3cNta2YzfFU4tYsHrvohYBD7
 kSvQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780697246; x=1781302046; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nGYeeaG56NlYH1+05NjLa/QX3hoItuwcpmhbGjiyhZY=;
 b=i95QZSEzHaMzZ18dlate5vwogYxdfkYeN2OuMMfBHcmgiMAzylbOPBKjW+NxZRrJgN
 WmyS+slS4CfurWEuFQT8H3agc8iP3PYuy+q7nRZbzCk6jWKxi2lFUD2NfTDy+C2f1twl
 bbdkkjhAZo8IHiiJrd9iAjH8zkjuvmFDwV1so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780697246; x=1781302046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGYeeaG56NlYH1+05NjLa/QX3hoItuwcpmhbGjiyhZY=;
 b=RmNBI4AHSXGoINpkE1tYJoX6sN/Ap8bgcXWEFQ4wWlzjEhNzKXl8bviKi1Q6yivezL
 IhYeEnkajsFYAqLIq57hyluR06ownvRMmrFVDtlMzCiIP9GDaRnCJsclxFuC/CZFsPe2
 WUQhpKS18LHrpIaDGoiBkQINE1Kc7hSy+yFI+j87GJfRA2iIreYpfxG+cVMMZydjTG7c
 /DG26Ed9FS9w34VSTNIfn/BXp9QUiIBNBj31m2buXMlz6vsrS41y3smL30bpIVai3j3R
 IeyOgqUm9h1PqUUdTqNLNxukHInlxKL4JX9wi87bYDFu1cBh0x94pCUbprlOoqxC5k3d
 UfZA==
X-Gm-Message-State: AOJu0YwP6l3Mon1g4NDgcqXI7Lrt0PbdaVvQk6eDiwGu5Fj9QgzE/r1H
 4loO55gux7/IIhFXpPL9afPiKwk63B8Xu0A8CiV3zhuQZGjVQsgVViqR3D7JzHVqeyUiPgYbMGh
 zj6bGyUX2urqVHjzaKdfmPnlg8Y2o6LkbMB0FwCSH
X-Gm-Gg: Acq92OEPiDIl4cpDXFsbAPyaq0vl8ObqaYFPvphbbn+axWmoDXXizyeqWm5I8R9+tp6
 Sa2lT9TJWFIzK97YqPadYrXyXQV/8rTajJl4YvyuEIWiVJs1S+izawX1D7mzmDmlW58dN8H9oF+
 C4OwpLQ435QOimtnGbn/qhXgtL30LMrV0o6gBfbi84W9Z/MxxdkcVwj6Z+XyXd+tEUmWlZvanQ9
 iwL+NmfncdnsWy6KkMYmI5hsu0O0MqEaHMH11E93TrPY66uz+jG+1B+qx8beriCcQwj4TWkqSbT
 3o4KJgXciuhQCE32
X-Received: by 2002:a05:6402:3213:b0:68d:4e6:7187 with SMTP id
 4fb4d7f45d1cf-68fa5258549mr2912530a12.23.1780697245950; Fri, 05 Jun 2026
 15:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-devfdt-usb-v2-0-a587ab36b906@nxp.com>
 <20260602-devfdt-usb-v2-3-a587ab36b906@nxp.com>
In-Reply-To: <20260602-devfdt-usb-v2-3-a587ab36b906@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jun 2026 16:07:09 -0600
X-Gm-Features: AVVi8Cc5t6zIXrFgPiF_MWqcd8plMv3vCSvs-QD-rIHsF1iTyEGVmZ7R228zGA8
Message-ID: <CAFLszTh-njbt1EnST=1Cm3d7VXSOY_UfBYsCi3x_aiUMyGbJkA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] usb: musb-new: Update phandle handling
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
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

On 2026-06-02T11:21:39, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> usb: musb-new: Update phandle handling
>
> Replace ofnode_get_by_phandle(dev_read_u32_default()) with
> ofnode_parse_phandle() for resolving the 'phys' and 'ti,ctrl_mod'
> phandle references in ti_musb_of_to_plat().
>
> ofnode_parse_phandle() handles the phandle lookup in a single call and
> works with both live and flat device trees. Add ofnode_valid() checks
> after each resolution so the driver returns -EINVAL early instead of
> operating on invalid nodes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/usb/musb-new/ti-musb.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
