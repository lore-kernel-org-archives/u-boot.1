Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59957C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C83D1877B9;
	Wed, 29 Nov 2023 19:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZNxDFydl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6C9877BC; Wed, 29 Nov 2023 19:15:19 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3159870AB
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-285e54f32d3so7705a91.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281716; x=1701886516; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwA3A7dHOxpmXkB+oCDpmKPuHT1sQ+2Ye0H16n54pN4=;
 b=ZNxDFydlpLLWH5fwEdEtG2tmmkeEll/NuOOyvgNsn7j+1HPKXNIIzr5l7uvKBph+NA
 g3lVgCP7UORB9Pv/9hR1TnLGS0NYqwO3msumIX8MR+CE2leI58kKhT5y07SOAhTQ2xB/
 ItkZIMLBhq711PYe3gxHbgeXLIw+Ommt0fafT3GGCVZz8KvdU+quCvMrw6D8UumPS+6+
 9P3w2P8Jn5mCagtJOkZMoqC1CINxBo16FJ0L3sYHWzg2QROOjwi8/8+tfiq8vUb4/XSB
 WOvq4lumQH3kE2pyuc//QWHDrvlH+zOLxkLw5O3beheRHCoWlcsuBKmSl8IeR3XoFlWJ
 ztOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281716; x=1701886516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwA3A7dHOxpmXkB+oCDpmKPuHT1sQ+2Ye0H16n54pN4=;
 b=f7AoGT0js1h5rsldsrKzXbiH12gIArEt5NKwDILfetkzpm2TvGoY41b/4ou4yaU7ip
 GMfk0tsvzN0tLt4rA3k1YAeafNBRssOnk14T0dgPg/RZACzvppg8k7/NrFd0FCNKPQNE
 HftpaY3zAzhvJRoQpP4SzaYaTYczSLj7nLmea0kohOsK3BtyegOCMnHhKRqJ+w/v+TDh
 rnbLHu5wSTXx69Qs/VUGwITpZ021NAoRVKK9QNmZIWAzC1PBVLy1zDL9lexsXbBG9z2N
 I7KWAxiAga2alnpicGCYA1xAcBO268v8oXB8I2B875+Fh5AhJmG4IxwQ4+1q7DumfIJp
 yM5g==
X-Gm-Message-State: AOJu0YzK/GdyKo5vgKyfWxALcGZVc/u4X+WczfI9QggiawYLjC9Of6Jn
 8iV5kl3is9RCxQJEHYxNa7l+iZoFK/G3Xj4l+Q8=
X-Google-Smtp-Source: AGHT+IFI2WHLzlyZ2aOITKYOHlu5ypwusmOcP4oGSU+a1X2XbVrYFMTDggJc85GXXiyFzS00G4VYAqN2oMbnJIgyJ4c=
X-Received: by 2002:a17:90b:1dc8:b0:285:71b5:7b7d with SMTP id
 pd8-20020a17090b1dc800b0028571b57b7dmr19689702pjb.0.1701281716034; Wed, 29
 Nov 2023 10:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20231104163243.117404-1-marex@denx.de>
 <20231104163243.117404-2-marex@denx.de>
In-Reply-To: <20231104163243.117404-2-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:15:05 -0300
Message-ID: <CAOMZO5A5_EhnqE9OY--aNvC9bFRs3RsxGicuKw6Da1H4AzknrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: imx8mp: Enable TCP, IPv6,
 wget on DH i.MX8MP DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Nov 4, 2023 at 1:32=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable support for TCP protocol, wget, and IPv6 on this platform.
> The former two allow users download payload into the U-Boot from
> a web server, which may be more convenient or easier to set up
> than TFTP server. The later is enabled to future proof the IP
> stack on this platform.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
