Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01993606A330
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y6JKvWuh;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YUWjDU7l
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35A31409FC;
	Thu, 19 Nov 2026 06:52:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ioGPiarmhTt6; Thu, 19 Nov 2026 06:52:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34547409D4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795071175;
	b=AAI0Z+ejP/7w+ICi4fM+dFC9thFshjC9C28ZvDAN0ElQp1FntB5AAbmtBMs4Qp8i8DPU
	 hcMcGuUCeB43Nkh2t4Ywji5vAi2zUVCKqppJxONxR/C2kpyAd+saVou0kj5sM0DpH8mRH
	 ZSX9N2bMe4ywOjjXUeZ+INJYjKKE0IPP6owjrB/FbKCl/LXhqPoC7sEIe53ycW2HO5YFX
	 5eUiCWMTxslPXHf1uElGG5pmuLnvI3nJeOEzdIdCs/eau8MtbU5e6ZAzoZmUOrPurOgxb
	 YD1Sh+EFjewmPJXUNmuY8EgOES5asF0sNZkG2TlTZcT1K7Fsk1ysU7ongT3fBB1z0iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795071175;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pS3si8S+c/QsvtPoTcqYCRz8sKATbyPRGbyBG3G9WDw=;
	b=Muh1/F+bLw1bIC4nI3Vrt+McrxQC71pEekphqcSVbcous7hUIAB3UZZtg+upRXX+RvKT
	 ef0uXlQZkAhvhtRZXmLKGDStmxPiolwzgHN8kOM+/G9M5pzqX5I8hnse9Oq3Qsp8k+zLc
	 cwGFmfE6LrJeqbtfSoOejzCNT7CpI9eDqOq03jrqX3KKWrdi4Itnn80PTNc2f9fott/zx
	 8ldPW9a1GN0vdjnfXxQGttQ5/pQI4rCRz0k9PPQmuk9oOPucwo26gXK3llZugzWpz1+VC
	 E36C6J9OI0GicKhMx75ld6VwvKTqGCHC93evqyTnJaaApmDcOC/FhhZWV4yx1Kdua5Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795071175;
	bh=pS3si8S+c/QsvtPoTcqYCRz8sKATbyPRGbyBG3G9WDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y6JKvWuhoB2PvFw+mBQZ7L+SNn6cTtIjha0/A7Nmk/giQV95QNhizxq+Y+afgexac
	 /8d9kYY3QPuGOdCdyAYZFdxsMVX9SEkrml7iXAtltoJ1yv6HJ47zAL71CBEt6gwPpT
	 QC97cKXCCyTQ8fQkWs3IKE6tfS7YML+umPj0TZZcqEQeICWEcPvnDVHquqYkPfNDih
	 iOHjLoxfCxyTaocnG5dO9fJOUE6486+/+5F081BLhFUWUUeLDBQj+vpbcGYP8lVgQA
	 hdSW2CJHgdhUBX13xBVstpcm9mZVSr5T/p1z0aRF1bxhbayDzZiIOVI6UYvi2levcA
	 7cRQN5YgQckqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34547409D4;
	Thu, 19 Nov 2026 06:52:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D23C70B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 03:07:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42D2160AC1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 03:07:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jHM1DQ79Qmgf for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 03:07:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 36C106069B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=YUWjDU7l
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 36C106069B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 03:07:41 +0000 (UTC)
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-14394530ec6so2729622c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795057661; x=1795662461;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pS3si8S+c/QsvtPoTcqYCRz8sKATbyPRGbyBG3G9WDw=;
 b=YUWjDU7lFtm65dxRF8TcGD833uXDJp8X7N/1gi2c5L/tdsWbHOeTI2dP9LZY2te0ne
 91JMJcRfY7/V1/8GJGfb0HWotSpmvULTM8+l3UZfwnrwJ7lA2QFS5tAwerNeguDE1RXM
 zwB59Ui3fJh+tJGx4de6oUyyniH2Ro+06FYiWKfAJC6GqbI3GcjaUrmJ6OAle/XnZzSz
 g04JNGyEDqcjSxwVdZSXg7kRwmIcw2tzafh1vj4E9ehe+/9f/W1lghp4C2gL5PqZeLbj
 YTx62F4oSK1J3yNcKM2wpWEGyMpdAV6G7YkbGp61ooZLez+e9qdvCrSUgI3k+QdgGznf
 S4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795057661; x=1795662461;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pS3si8S+c/QsvtPoTcqYCRz8sKATbyPRGbyBG3G9WDw=;
 b=TgT9WIyS0T4F+aHl1ntalk4bZt8MFkRgtYLISd2Y669KJBD9QLvsZKI2hir9idwgIA
 v/d9yiWZsn/fmY9QoeA0pecH/HFn+Uvy1+ZKk28/96gmk5Cg9Yogv2nhwT6vASVh7G5G
 9mMzbG8mbiWR1ZXKM6IDWSkYxOdmaSUQwk2Ka1PPKzI3c5kXrJ2XW/2vfP1AzVGIEuJa
 RuPGh6LDkjW98h9kdIzIsFbONpyMdQTuQR/zpxRnmreNvbAu7QM8wePau4ek67fJ72F1
 LMO7AhapQIhpR00kJTMO5ldM/LcRQNPJdQ1E+Rv3d7hMgmL7uufGNJ4+9npEhbe5jWup
 jTdQ==
X-Gm-Message-State: APuU4Z+RIlU2DDKsP5kAyhqBsepnlqfCbZwyuWsGK/kKy/esAOc+5XPt
 apxr7NtlBft+boZOe+r5WqhW3NErVgLFeulW26ewW5roiP/Pg4qrsCbJ2S8ztlO3a/gOwin0ODn
 Ahf8f6rAveKYlOSGcbJNbsRCJ2K9J6eo=
X-Gm-Gg: AYBFou3K0LXkALLWhxpG4cjgOuLu8k1OXHfUFecaUEATmn18sIoN+v2PKezJsu5aDA7
 9k8Xuh+mX5jQHZEixcliH/AY4WJ5UJVQLwyAgd0X1C7Xl7Dtsqqx9La4HJewqOWNlVuupTjG7NC
 0kC9l2UWeHqkrmHFC+R+HS22NEZO/1WV3V9TUymxFrVu+IAAqs5ytNkd5H2jnYjg38qUIocO0jo
 +6fsBoHyrgvKy8rvLYBsBrOnrrRUBuNetuGWdU6kFZbjBWnvWMgFDpbOOHvPmybcrjKGClLURCy
 F0Ufjp/uKMlQ1djl74lDlGLlmrJLiRsRs060K25coZqf5bAAwcirHOAFZ7pLI8rr0EzYZ7OjvFr
 7KTuOvRVbgFsGw3belMTDsupeQYpVvFJ9zrCi
X-Received: by 2002:a05:701b:4250:10b0:183:7d42:cfb5 with SMTP id
 a92af1059eb24-1b543bcd686mr4256018c88.19.1795057660704; Wed, 18 Nov 2026
 19:07:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015-b4-k1-emac-v2-0-41143fc5aaa0@gmail.com>
 <c22a9401-abc0-414e-bec0-26e78e26691b@gmail.com>
 <20261119013052-GKA156439@kernel.org>
In-Reply-To: <20261119013052-GKA156439@kernel.org>
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Thu, 19 Nov 2026 11:07:29 +0800
X-Gm-Features: AclHuK8Vfs64vMDvDt68E5D4pVWob1dihfjPxFY7PhcTkY86OMUmY4NK-UMgoII
Message-ID: <CAKyUbwXakbBcTnZoEo8d9pOC7fWxh=YatOyDyZTkE-09wN4nvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: k1: add Ethernet MAC driver
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io, 
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Julien Stephan <jstephan@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Eric Chung <eric.chung@riscstar.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Guodong Xu <guodong@riscstar.com>, 
 Dave Klotz <DaveWK225@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 19 Nov 2026 06:52:53 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun,

On Thu, Nov 19, 2026 at 9:30=E2=80=AFAM Yixun Lan <dlan@kernel.org> wrote:
>
> Hi Zixian,
>
>  For title, suggest to put spacemit keyword, as
> "net: spacemit: k1: add Ethernet MAC driver"
>

Okay, adding spacemit keyword is much clear.
E Shattow gave the same advice, thanks..

> On 09:45 Thu 15 Oct     , Zixian Zeng wrote:
> > Add Ethernet MAC driver support for the SpacemiT K1 SoC. The driver
> > supports RGMII and RMII interfaces, synchronous transmission, and expos=
es
> > the integrated MDIO controller through the MDIO uclass.
> >
> > The register definitions, descriptor layout, MDIO protocol, RGMII delay
> > line handling and hardware initialisation sequences are derived from th=
e
> > mainline Linux commit bfec6d7f2001 (net: spacemit: Add K1 Ethernet MAC)=
.
> >
> > Link: https://lore.kernel.org/all/20250914-net-k1-emac-v12-0-65b31b398f=
44@iscas.ac.cn/
> > Tested-by: Dave Klotz <DaveWK225@protonmail.com>
> > Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
>
> I've tested on MusePi Pro board with dhcp/ping, tftp, verified downloaded
> data which is correct.
>
> Tested-by: Yixun Lan <dlan@kernel.org> # MusePi Pro
>

Thanks for your testing.

> > ---
> >   drivers/net/Kconfig            |   1 +
> >   drivers/net/Makefile           |   1 +
> >   drivers/net/spacemit/Kconfig   |  15 +
> >   drivers/net/spacemit/Makefile  |   3 +
> >   drivers/net/spacemit/k1_emac.c | 957 ++++++++++++++++++++++++++++++++=
+++++++++
> >   5 files changed, 977 insertions(+)
> >
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index c057504cf66..7e800742fcc 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> > @@ -1123,6 +1123,7 @@ config MDIO_MUX_MESON_GXL
> >   source "drivers/net/phy/Kconfig"
> >   source "drivers/net/pfe_eth/Kconfig"
> >   source "drivers/net/fsl-mc/Kconfig"
> > +source "drivers/net/spacemit/Kconfig"
> >
> >   endif # NETDEVICES
> >
> > diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> > index 96ec6fb187a..935e4dda394 100644
> > --- a/drivers/net/Makefile
> > +++ b/drivers/net/Makefile
> > @@ -105,6 +105,7 @@ obj-$(CONFIG_SJA1105) +=3D sja1105.o
> >   obj-$(CONFIG_SMC911X) +=3D smc911x.o
> >   obj-$(CONFIG_SNI_AVE) +=3D sni_ave.o
> >   obj-$(CONFIG_SNI_NETSEC) +=3D sni_netsec.o
> > +obj-$(CONFIG_SPACEMIT_K1_EMAC) +=3D spacemit/
> >   obj-$(CONFIG_SUN4I_EMAC) +=3D sunxi_emac.o
> >   obj-$(CONFIG_SUN8I_EMAC) +=3D sun8i_emac.o
> >   obj-$(CONFIG_TSEC_ENET) +=3D tsec.o fsl_mdio.o
> > diff --git a/drivers/net/spacemit/Kconfig b/drivers/net/spacemit/Kconfi=
g
> > new file mode 100644
> > index 00000000000..c3955556853
> > --- /dev/null
> > +++ b/drivers/net/spacemit/Kconfig
> > @@ -0,0 +1,15 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +config SPACEMIT_K1_EMAC
> > +     bool "SpacemiT K1 Ethernet MAC support"
> > +     depends on TARGET_SPACEMIT_K1
> > +     select DM_DMA
> > +     select DM_ETH_PHY
> > +     select DM_MDIO
> > +     select PHYLIB
> ..
> > +     select PHY_GIGE
> I suspect this config option is related to EMAC driver, checked
> drivers/net/Kconfig, which affect some commands and miiphyutil.c
>

You are right, PHY_GIGE is not a dependency of k1 EMAC, which
only affects miiphy_speed()/miiphy_duplex()/miiphy_is_1000base_x()
used by "mii info".

I'll drop this selection in v3, then add CONFIG_PHY_GIGE=3Dy in the
spacemit_k1_defconfig for "mii info" command.

> --
> Yixun Lan (dlan)

Best regards,
Zixian
