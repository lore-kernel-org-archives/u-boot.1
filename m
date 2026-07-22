Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF436C44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE6AE409F2;
	Thu, 23 Jul 2026 00:52:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iOparvnWVOoA; Thu, 23 Jul 2026 00:52:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A97A6409BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767939;
	bh=33JMVz9Y3GKW7zEX821I2SZXZdbAZGenx1LPPkuCFMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J909+HzdSzs0YXe9EaTf2x8TI1cepcOnF5Gk0VSJ1bX2cD6L9frE9dZmRkvSXz9QN
	 BLN9DlQNSH9PSiOQd1GIIsSUcR46yTDs62TwzicZo+CesQGW2ioWjvF9jpJvbWB+5g
	 n/gYZuRh6xsbhL/uCjvIY61nncg4sYGNeC0Iz/rq9XT5LhQ2SBIVqyI+H/X9jSttp8
	 Z290CuDrPdKbhZiZ7cYMU0sPIgfd6jo9SqC/YWKgsyGXakab3Er9WYZ0HMORFeVFDn
	 wx8tHhyIEp3hZBrQXl9hO75igs910KHtrmzKojYUnh7wQjbBPhDNZg5n1h5j9piPws
	 9KEJL+vLSR/Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A97A6409BB;
	Thu, 23 Jul 2026 00:52:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CDD442A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 834E0607D9
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:21:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5xOSL8zVHONu for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 14:21:37 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3D26F607C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D26F607C4
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D26F607C4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:21:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182C8849BC; Wed, 22 Jul 2026 16:21:35 +0200 (CEST)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B24CE8495B
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 16:21:30 +0200 (CEST)
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-5bf94664327so4652095e0c.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 07:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784730089; cv=none;
 d=google.com; s=arc-20260327;
 b=m8VLJwzrDpSeTaB+63moEl+USmnXZ7JQzj41wb8CIJTm2W5tdxKavRdMaM2x6Car83
 sQYpFm0y80HGI0YUb3ijwKQlrDzC4c2UCME/2g6ZTYTo3mUMpwncyTzka+Apj19gbSO/
 2QJdNnZm3Bxldr8zvWuZIoq3/y3vi8B2PdMckLoXrpLcrtK3nLGLAFDXQSODV38Ij+/a
 4W/+bH30w8rqNaxtE9uc03ZWGHWgg0IZQgofXtO/k0XLsKDJlvNY3YawhgGa4HhPu/9I
 vgfdK/NhSXBWoLYID9QnxSwcsnb7m39PtuGYGTHRAA1c7EzaHly79PAPFYLDHdB5ZzOC
 lJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=33JMVz9Y3GKW7zEX821I2SZXZdbAZGenx1LPPkuCFMs=;
 fh=xaYwXkM4t5YFDbUDkt4aYRljMMobQ2lQaNgAMpPb44Q=;
 b=HEO9bskWEz/G+8sMCzkPYugn4tLkEFFlxto4+gzQNY9GDKsWXwzYiqPXVC3DR54tGa
 efYgtysfouRhdCNj8ejJszKLkehuSK0wkpli6NdAQPF1CSuvSjItGc7LJMY5Dd+wg5zs
 A2WBP726KJbxS6Ba7dc5GFllpjsCVLgvWvPByIsaeFg6ellFSr72Vwfi2zhQ5eC0DYRI
 xuPEItp8dReH4XFHDBREmLZqEzF78F7pGHGFJQw4nUSxpepwSc2bTMNxK7R6JUY5rxBp
 9H8GZxsmPKT1g0aSovlNnvxcn0JZlS1x4ywrK8Rm0BpkXq5+Vz+eQFLRwZ1+RM7ttlQA
 5H7w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730089; x=1785334889;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=33JMVz9Y3GKW7zEX821I2SZXZdbAZGenx1LPPkuCFMs=;
 b=TfKGhQ+HQ4Ih9jdEx0Y9flKHPkIyG2ppwFIqoH8uSN32bTo+A/JcYl8lpuYtYmEqyz
 Qkpz0+5sBmO6h6Iwqob5vH48Mit9iefRtKPqpi5zTqC0QCntjbEdDYSteClANkKynKJ2
 P4lLoaRAvFDahk0rx+tmA3OuDwuHXAh2pkunCX3KViKHI3qaLqy/tPy+wE5N1CpMfD46
 DjFEtMelf7wM5MwIslGiFMTFF0dw7j7kcZYM6w5Yj152B6xUJ5T5BciIzv/3YAGXENQh
 qE7wJdwEWqCdJL0AojcsQKxtW7/5KJjFNh+AONzSqTgsVf3Et50zembrg8KuHDSLqQgS
 QGSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWrHN7g3EW7AAO95QpoF9KkDalm1N3Gf23LwOyXeaaO2XMW7Z1sq8l6tLTP9+yG81kMfU+ab4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1bKPxxyKQhfDOQAEhuTp3X0LMBnGWNOycw/IDh0Nq8ChGkYV9
 VtqWDCpjJdDj+EnxQDc6KgOojJdxFSWL9AehhbH0O8Wmi7OawrRbFTeK+1FzRSSnC1qPqw7Zdt0
 xf+epKLlvjeA69JCY7f/rXc0ohWApxh8=
X-Gm-Gg: AR+sD10a8lXCi7whAWcMFyFZlOLDAbIiRwKAw0f/iYsbk4ze3yYEtfyWQW+yFq7yXoB
 Wu6q2dGaFRoZ1vRKrWZ+TYnMu/UfmfVG8m1e2J6ggGxu48Lc1euTGNNk2gdK64eprMY7G+vQDyl
 yN+EqcZGHoS3886SexVu1WjUfxv3Cd6cuNJfag1AaKQ3Fkj3HgpLxRyznCD+QM202nx9eQh/LZi
 rZNwdIQpCM/XUuI4tvKypwwAFDU7c/V4njDBKxWi/q2k3X/vT9/6SxqJ2zyFiWBKuzC875vP0S3
 0xroQ2xbbJFx57wHg9RmUTH+2YwFOPmVXF95czIG1ARcfmQ0f/g+7K1p1Q0DvcpAdXZBGgg06si
 0mYKQ+G+aGlG6FAYYI+6B45S3CQ+5aV9a2sQ7lA==
X-Received: by 2002:a05:6122:3b8a:b0:5bf:6cfa:7743 with SMTP id
 71dfb90a1353d-5c1bf942107mr6759015e0c.13.1784730089262; Wed, 22 Jul 2026
 07:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-4-3c41f66d4522@gmail.com>
 <20260720233023.GP749385@bill-the-cat>
In-Reply-To: <20260720233023.GP749385@bill-the-cat>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 22 Jul 2026 08:21:17 -0600
X-Gm-Features: AUfX_mw_B6n_jxC36Glcf00IRiSqdB83kk0COiTs4X0mwQLtu0tPp330TOK4H9s
Message-ID: <CADvTj4qHHW6pvRENss206Q6-UG0RJOgftvYeZviaJrh6bcKLLg@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] crypto: hash: allow DM hash in SPL
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784730089; x=1785334889; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=33JMVz9Y3GKW7zEX821I2SZXZdbAZGenx1LPPkuCFMs=;
 b=qolQBiRIn6joUGzH7/HKaLdICiG13nExuX6c5GnTJwgVQkAQgUjtKaruTads5Ej3A0
 ETIE23VNhAtgxMIoyhNtmdYRStaW/DdCWql9ylCmfZb/4D6zQYtmCZ2VPnIa6pucvzOC
 BARYakhAVFZBytnXMyvPKSUruYRnC3s42/6L2QpbIPNKJXl33/V0BLD5y0c3w6jjwYwH
 NxT6yG3ElmYXVe0kHJVVQcMeSGHoBUJyB9mjhJ8L/AIT9pQdEh7z6eyTn4JwZUj03sIp
 ats5rJJysCmduFRtWfyfs4KPdeuh2jxNfU97Z5NXOhb8yLPgcjSNGPfbwbPnb3otYScq
 T0mQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qolQBiRI
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=james.hilliard1@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qolQBiRI"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 20, 2026 at 7:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Jul 19, 2026 at 10:13:48PM -0600, James Hilliard wrote:
> > The hash uclass is currently keyed only by CONFIG_DM_HASH, so SPL canno=
t
> > enable UCLASS_HASH independently. Any SPL code using hash_digest*() has=
 to
> > rely on U-Boot proper also enabling DM_HASH, and the FIT hash path sele=
cts
> > the driver-model implementation with a non-phase-aware preprocessor che=
ck.
> >
> > Add SPL_DM_HASH, build the hash uclass from CONFIG_$(PHASE_)DM_HASH and=
 use
> > CONFIG_IS_ENABLED(DM_HASH) when selecting the FIT hash implementation. =
This
> > lets SPL FIT verification use a UCLASS_HASH provider without requiring =
the
> > U-Boot proper hash uclass.
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v2 -> v3:
> >   - Remove the bare software-hash fallback scope
> >     (suggested by Simon Glass)
> >   - Document that SPL_DM_HASH needs a hardware provider unless a
> >     phase-aware software hash provider is added
> >     (suggested by Simon Glass)
> > ---
> >  boot/image-fit.c             | 50 +++++++++++++++++++++++-------------=
--------
> >  drivers/crypto/hash/Kconfig  | 13 ++++++++++++
> >  drivers/crypto/hash/Makefile |  2 +-
> >  3 files changed, 40 insertions(+), 25 deletions(-)
>
> The changes in here make me worry a bit about platforms relying on the
> current behavior (because of the Makefile change), did you put this
> through CI? https://docs.u-boot-project.org/en/latest/develop/ci_testing.=
html

Looks fine to me when I ran it through CI:
https://github.com/u-boot/u-boot/pull/1014/checks

>
> --
> Tom
