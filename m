Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E42C3600C
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 09:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8553E80756;
	Wed, 26 Mar 2025 10:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=arnaud.patard@collabora.com header.b="RMKpT+6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 638CE8083E; Wed, 26 Mar 2025 10:32:43 +0100 (CET)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09FC28070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arnaud.patard@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742981556; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V6R1O+jp1ZXsnOXC3/uNVXBOS93A1JPk0g98n3gn58TLsmNeazyAJhMZ+IuOZnoqldhIyoLgtt83nGrm9lI7BzEbLu8dwnQ1BeyLpBTkV/BNQA98dLvugq6+Hui+mTuvZ3gmLsVS1v7nyePHRgyNCGR8ZWaN1inWJfec8mYYn9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1742981556;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0+KGOUGpefw0VEqA9MMFh8gPNi/TonLQMHL5+TaI9mY=; 
 b=BywMR0xnDgvQKD68RzarZdf5ZhTX6EDdfqn4l0xf8qcvoP2I1dlVcR905eLwcrqq/sNiSALGy1VSfGvZ35kXHRLh9blXCiKWzaTfBq4x3BcIUuYKas6MZQ9YAUAyTPq+6ulDcvLB6pvWRd6PIZ5gqtLFNtJft41wntR9JKT0q0o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=arnaud.patard@collabora.com;
 dmarc=pass header.from=<arnaud.patard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742981556; 
 s=zohomail; d=collabora.com; i=arnaud.patard@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=0+KGOUGpefw0VEqA9MMFh8gPNi/TonLQMHL5+TaI9mY=;
 b=RMKpT+6JJusj+Ly5JCpWfyxl+JPZPm7LtIQqjEN1Q0GkwpWZ9uhpErDKJB6o74Oa
 bSjD2rNcT/rNNdb1vKcQ6WBAPAyVAy/1wpMYHz+m+sHIHzGvFVpxMDBvEHskoVq7NR2
 PWoeWj6Ns2oKNgcUtxDfViAX4r/0FueUNRYo/R2g=
Received: by mx.zohomail.com with SMTPS id 1742981552411671.97887445812;
 Wed, 26 Mar 2025 02:32:32 -0700 (PDT)
Message-ID: <7096d92a85f8880ec5b5f1b31f9767f5fbb48f6e.camel@collabora.com>
Subject: Re: [PATCH] rockchip: Enable usb gadget on Radxa ROCK 5C
From: Arnaud Patard <arnaud.patard@collabora.com>
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>,  Kever Yang <kever.yang@rock-chips.com>, Tom
 Rini <trini@konsulko.com>
Date: Wed, 26 Mar 2025 10:32:29 +0100
In-Reply-To: <03D6E89096614725+95fe243a-7bc6-46f6-87cb-7dab45145985@radxa.com>
References: <01020195cdc6e188-48dacf9c-cfa6-421c-aab3-61d989bc7c78-000000@eu-west-1.amazonses.com>
 <03D6E89096614725+95fe243a-7bc6-46f6-87cb-7dab45145985@radxa.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-ZohoMailClient: External
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

Hi,

On Wed, 2025-03-26 at 10:25 +0900, FUKAUMI Naoki wrote:
> Hi Arnaud,
>=20
> Basically, the Type-A OTG port of the Radxa ROCK series is intended
> to=20
> be used in HOST mode (unless there is a HOST/DEVICE switch).

yeah, I know that by default, it's intended as host but it's not hard
to hook a cable to use the port in device mode to use the gadget from
u-boot. Having to patch u-boot just to enable it is not very practical
imho. I would expect that enabling the gadget driver would make things
"just work". It is also easy to forget to set the 'maximum-speed' on
the phy node to make it work.

So, is there a way to achieve this goal ? I could have put the
modification around tests like "#if defined(CONFIG_USB_GADGET)" but I'm
not sure if it's a good idea/practice or not.


Arnaud
