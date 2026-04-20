Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B025F5A8B6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C275584390;
	Mon, 20 Apr 2026 21:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tdjr8v3c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D846184376; Mon, 20 Apr 2026 21:32:32 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1DEA84347
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso542695066b.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776713549; cv=none;
 d=google.com; s=arc-20240605;
 b=TgNkIL+R3tp2dQFgSfuQhs99WInAJG2j5w5C2LLIDysjseTrO0/IbLv2lnt813Tm1H
 xPvt/biW7O7k+MjyEWx4p+WnBnn+d2YUC9HhWh+2/Bu+5p7TOzRqibk9yjfSH8DreTvH
 P9eFL2hV/cjSdTtcHcePvytoQGgtk49s5j+RODMpCL4wtG1ycD7QC4igsO/Iz649o9de
 QR+y5Oiczx3Lf5la6X0bEQLrOwh+jNXAqfiJYwVzE5JcOJid0TqQDNTov6yPHZ9mIfX2
 Ubl13pNUdZadKBRVwoRgvDxPP/uIBiTwCmLd57yzFTh4jJzrvGtxbNZwA3WGG5ziriJL
 qifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6o95kJwdMrtAnSvaJoCNPyYqgiEcDZmQxU8A8lU3B9s=;
 fh=QQJE3IaAeunPHumA5bQT00HUdZQapHaeCUQ1zQOCaEg=;
 b=UdejOn1VZhFldW+7SukBFI5KvoNBOg/r6N/N82+aN8QOrMqOX6+8zOdad4SklHm58g
 hqK/nrPvVfJL604qbfKK7P5fkkti2GrjXq38qPaL5ZnxuHNR8O599g6YQ/KQxxYMPp0s
 XRVG3PbCxdlUiwPW4iCUaXUVxhlIH5mjSCMjpQPKDjUz6WjhbuOzapHAAZ0w7d8Wiiyz
 V2HmYc6QpwGbUK6J1RCvvRbT9WgucPsSC6w1bhIG0/NNM52pr6MKDrBTpl89mGMmqMYa
 CRV0/qC6hnMy+9vQZ6ka2PvgNg2bn+GzrO7IT1hXq6W6ZVYwbh3BpCjlbiMX0HaPlbCN
 jvpQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776713549; x=1777318349; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6o95kJwdMrtAnSvaJoCNPyYqgiEcDZmQxU8A8lU3B9s=;
 b=Tdjr8v3cONgRp3cQfYQYz/7QU+fYYAvWfe+nQzzJHi6DMyNaYXS2Y09+L0dd6f6w/A
 EiY+8LWYDd8e2SHIqQSdnTCRUNs2LeoHDPJuV3MOPom+YItebyecdwXNmeg+HCaVb2o+
 suCNKkATQC+pc4P4MV7MUIW5U53SC7KQjQV30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776713549; x=1777318349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6o95kJwdMrtAnSvaJoCNPyYqgiEcDZmQxU8A8lU3B9s=;
 b=JjjR0JMpVYQH/j8UIbrXSNYmwiozA5a8dmaBPTe+vkMtsjtYnhi35KqIhZjFD1jhMz
 nP5eSuN6ZeFCQ5Nf4gTCJc1/Q9ActxqAf7x6cGxD+unA3ZwtDCZvINE2eLPE7KIgBdYc
 S1ico1dj4/CwyQ7WX45KWXx38h8f2nwNkt1PN7fEyaBJzYYbwfcxE98Ul2mnen0Dj0od
 5t9fXbEa6D0KpzcGGUjEbzcg8QC5tM2IR7Wz5fav+gSuTsBL1Q486/RpV2jsgGb8s4lS
 ZgruCUOEKxS3knw/gtT819cnG5rGMyhitf7GBU19TIVIwhm6877plTiUh1oLWkxLA4QX
 1rlg==
X-Gm-Message-State: AOJu0YyDxippkEFX8tHTstIcemd6yOl/w/iAGI7fRVzhMNQfw3GiQENq
 U3++LNLjxuvAvU65qbgbKpKhGhWjRVV2X/ImSObb4KHXIsmDlGCkyfr402MeQ21WELaDBSoWA+C
 J19eS6g0gDGTlTD8kk96cGb9nDHzQ0nB7Z48S+3fn8mbs/dRbmJd7eg==
X-Gm-Gg: AeBDietosKtx+1iiyapEZfL0S8IXIpYpcmH2mh4Ekb9qKsg3Jwvj6wjOQTZUcj1CLcN
 GLm3T8Wp0ka6JzI2QX5mlwoxtOE7madPMl8ABZZWM2/DyKWiPYi0QsL3tfHOQPhttoOymkqGNoT
 A1dLo4AeulWJW0uBbnMfKqVMv5JE8toZXiGQ/tHEf5qds4/xqSbOyf98KqWEb1R1GcLe6CAZoak
 qzKnunHMuSgfBp/GV7qwQPo6nD195Q5SlRHA8JpgmicbaJEXHspkufCjEKlsrrX3cyXYQipMOQo
 jObIFV3T0xHjdiq3HeYn
X-Received: by 2002:a17:907:da16:b0:b9c:afde:9b59 with SMTP id
 a640c23a62f3a-ba41bad0086mr753835066b.8.1776713549326; Mon, 20 Apr 2026
 12:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776392312.git.weijie.gao@mediatek.com>
 <f0024175a615b0217cb3f2181d7957a9f59b9ec8.1776392312.git.weijie.gao@mediatek.com>
 <CAFLszTiVYt0ShOO83nT7UqZSW4Z0ZpP3goooOkeNOTwYGq60nw@mail.gmail.com>
 <7a5fd195af42407ad79de05235beabff083b94b3.camel@mediatek.com>
In-Reply-To: <7a5fd195af42407ad79de05235beabff083b94b3.camel@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:32:15 +1200
X-Gm-Features: AQROBzCCSBrmgXEpXOdLAee2_kgyJdm7T89O4aVkZgWhZhlIOh9xuzMsV0RLrg4
Message-ID: <CAFLszTgMDj4+MuvUZuu8AcPStt8ZArkYFFn4PXNnV5sMSqEnsw@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmd: ubi: expose more APIs to public
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de
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

Hi Weijie,

On Mon, 20 Apr 2026 at 19:19, Weijie Gao <weijie.gao@mediatek.com> wrote:
>
> On Sat, 2026-04-18 at 12:47 +1200, Simon Glass wrote:
> > Hi Weijie,
> >
> > On 2026-04-17T02:35:14, Weijie Gao <weijie.gao@mediatek.com> wrote:
> > > cmd: ubi: expose more APIs to public
> > >
> > > Export ubi_detach/ubi_create_vol/ubi_find_volume/ubi_remove_vol to
> > > public for better ubi manipulation used by other modules.
> > >
> > > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > >
> > > cmd/ubi.c           | 10 +++++-----
> > >  include/ubi_uboot.h |  5 +++++
> > >  2 files changed, 10 insertions(+), 5 deletions(-)
> > > diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> > > @@ -47,9 +47,14 @@
> > > +extern int ubi_create_vol(char *volume, int64_t size, int dynamic,
> > > int vol_id,
> > > +                       bool skipcheck);
> > > +extern struct ubi_volume *ubi_find_volume(char *volume);
> > > +extern int ubi_remove_vol(char *volume);
> >
> > The volume parameter should be const char * since these functions do
> > not modify the string. In patch 3/3, env_ubi_volume_create() receives
> > a const char * and has to cast away const when calling these
> > functions. Please can you fix the signatures in both cmd/ubi.c and
> > ubi_uboot.h to take const char *volume.
>
> OK. We need another patch to change all existing functions with char *
> to const char *.

Yes that sounds like a good idea.

Regards,
Simon
