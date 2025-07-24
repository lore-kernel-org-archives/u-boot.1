Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1FEC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 12:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26DC838AA;
	Thu, 24 Jul 2025 14:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="eTJCman1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D203F838AA; Thu, 24 Jul 2025 14:54:11 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DAE583898
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1753361641; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gqG2KnFNA/177UTuZVg5/ax9jco/lsPq8DObU12aQn7O5z3bjbQ0IItJ4wpSwJiZ13zqyuvwddvTr6svgQ4mkDotLdOPYqbzURtIImRMVCK83I8O6OGyyWf5CCgq2i4PwP7Gb7l00mijOqnlrfS5k7XDq0rQJnGyP2fb71+p0ng=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1753361641;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wrTkPoT/oKgGK+rq3Eilxsb8Q5h/dbMvaTNTnNDe1M0=; 
 b=Q/83oaP6eNVdvxjcs8jxtMu0sBNelmKJLq+RBEwsxh5CIZ79h+pjw4n9hQYTpjUXWyGqJFW0JYuhWhEVYTyc2IjoV4zxegWmjBFeFwponbmXWgldHbCu3p9u2DuOeptHJKmPqO0o9TmgxHM8iSQR63bFqwKvNPrbEaHmHtZXtlM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753361641; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=MIME-Version:From:From:To:To:In-Reply-To:Cc:Cc:Subject:Subject:Message-ID:Date:Date:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=wrTkPoT/oKgGK+rq3Eilxsb8Q5h/dbMvaTNTnNDe1M0=;
 b=eTJCman1pD9x1vQN1VbYV7q3qJEPG2bFlhjRDeYnJHGyDOBv6bngdsAZY0eZVt2O
 AE6otT1Bys+w9Hlb3hVPYVs0BFD0GV345xIjd1aJOmvhAotW87MYpDSOZ97tRIEMp0t
 XYpyxkWUUdm2G5KdWyfec+RegD5poioTLSENLrgs=
Received: by mx.zohomail.com with SMTPS id 1753361638123607.544490869297;
 Thu, 24 Jul 2025 05:53:58 -0700 (PDT)
MIME-Version: 1.0
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Patrick Delaunay" <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
In-Reply-To: <20250723170913.1.I20e0e3d5851ea2e4a22b20be372800fe059cc2d1@changeid>
Cc: "Peter Robinson" <pbrobinson@gmail.com>, "Marek Vasut" <marex@denx.de>, 
 "Mattijs Korpershoek" <mkorpershoek@baylibre.com>, 
 "Patrice CHOTARD" <patrice.chotard@foss.st.com>, 
 "Kongyang Liu" <seashell11234455@gmail.com>, 
 "U-Boot STM32" <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] usb: dwc2: fix reset logic in dwc2_core_reset
Message-ID: <1855311d6ccd0f78.fc55a2def266a393.a3bb5f06dd850306@Jude-Air.local>
Date: Thu, 24 Jul 2025 12:53:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

On 23/07/2025 17:09, Patrick Delaunay wrote:
> Use GUSBCFG_FORCEHOSTMODE to detected the HOST forced mode as it is done
> in the Linux driver drivers/usb/dwc2/core.c:dwc2_core_reset().
>=20
> The host polling must be executed only if the current mode is host,
> either due to the force HOST mode (which persists after core reset)
> or the connector id pin.
>=20
> The GUSBCFG_FORCEDEVMODE bits is used to force the device mode (for
> example used on STM32MP1x platform) and when it is activated the DWC2 rese=
t
> failed with the trace:
> "dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout"
>=20
> Fixes: c5d685b8993c ("usb: dwc2: Unify flush and reset logic with v4.20a s=
upport")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks for the fix.

Reviewed-by: Junhui Liu <junhui.liu@pigmoral.tech>

--=20
Best regards,
Junhui Liu

