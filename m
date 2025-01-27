Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D5BC0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 12:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A17A81119;
	Mon, 27 Jan 2025 13:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U4MmulJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B7B48111F; Mon, 27 Jan 2025 13:13:15 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74EBA81115
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 13:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-303548a933aso40140481fa.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 04:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737979993; x=1738584793; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPLWwdYqXGr0bP4un1YMlk6cvKV4hFdXzTzXeLnXx6M=;
 b=U4MmulJtnOqbjF5adm12KY5H7ItdM0AoTxIKgpqs/YouG+AQ6T6yPvkkl9ZPjNfhZN
 xIhLdLJ3m4YoV4tWxQ9JGcfYE/hUztCKm0T0ITOHGVS2D8CSjdKpa6nou5mg5XohWtCN
 qzOYuUOQe3U8U394vez8p/h9kEsQJG+6MWJjWNsz2dKQ/Rl1IAhCNYHdM2VFQnwyf6og
 Qc9svLzi2pizj1p0xybKvMlHrpIbRYYEQHZZ0hwcV/Y1jZYNqNVqu++SFQ/6H+5UsG+Y
 ShTwU7hNF0bgzrSRD7W2Kj+wuhrPGKKVE3BcKjXJPXo3Kgm+Qm0NJ+a+fNbY2Ug/sMrl
 n26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737979993; x=1738584793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPLWwdYqXGr0bP4un1YMlk6cvKV4hFdXzTzXeLnXx6M=;
 b=jhsxc44iCA93oteyVXOTQXmalcbPpWYMa8E2ILBVywytp9zCKKoD3OQqu5cEuEgFqh
 SMdXdTJ3zyn+mfUhbu321EHFcvmDS69Qdc2nJCmEENd27jSmDZXiqXyZ9VE6vzu2E5WP
 N9z4b5mDidBcILxH8++PyN6F0iUlGZoim9TC35Er+9VPOwq7Ob6AGfPWjb9hxetrK6i+
 sDWdHTfytq62VyAmrfBtim083KUEIJgcAVgnUnMddXr4pEIQGKxGyBWstPzyT7BYp5Pm
 KbildRnqUN1UZ9JDqQwHCn8plYmb/mEZHJab46ZxEWY+6AMy8OrSnNeTojeNk+Bq1fwL
 U9gw==
X-Gm-Message-State: AOJu0Yzz8zvJeawb9adFmRQSVRUoj90pbCCPCsVBQ9HVoYLRTz7tZXXg
 pyvc6Gze7NEeUA6jD//ApaDpRieNyOhODJIS5yTAC9YZ+H3XoTzMslc7fRM2FfF12BM/mrwHxyY
 9sDBf8f6SAcRcLl/tiu6i8y7XR+U=
X-Gm-Gg: ASbGncu+6aSSETOt62U5kLaGlN0yvAK6kH3DwzDoZNwPQ55h3gkML0jypMziY4fTN0x
 ujRLVdqwx6IQEMT4hLzh2STVt1wUJ7TDgb0fKaXPjrH6J+9HdueoYcTwbOx/aBYvf65nWKiN1/2
 J6DEOozh1yRIm255K05Q==
X-Google-Smtp-Source: AGHT+IG7soGf+QjmV1gZQpqZmAFo76ZZaO7h71seOhF+I4oMZc+8yno/nJCfa/UmmA3j6KAGwP2eVEs/3clVKWtZICE=
X-Received: by 2002:a2e:b8cc:0:b0:306:10d6:28b0 with SMTP id
 38308e7fff4ca-3072ca5b4b0mr156955581fa.1.1737979992448; Mon, 27 Jan 2025
 04:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20250124145520.185414-1-marex@denx.de>
In-Reply-To: <20250124145520.185414-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Jan 2025 09:13:00 -0300
X-Gm-Features: AWEUYZkh6Eg2OncFkIBz38eaUGDlDonCd2xRJ30mjL9v-1qMSGON2C2KWMRHqy4
Message-ID: <CAOMZO5CSTDc2ck-rjLb2BdpJKiT8vfmT1WvDDURd0HoBtH6k7g@mail.gmail.com>
Subject: Re: [PATCH 01/10] pinctrl: imx: Push imx_pinctrl_ops into drivers and
 staticize
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>
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

On Fri, Jan 24, 2025 at 11:55=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Move imx_pinctrl_ops into drivers and staticize. This is preparatory
> patch for follow up pinctrl drivers which will not use this variant
> of imx_pinctrl_ops content. This should not change size, as most of
> the deployments compiled in one pinctrl driver anyway. No functional
> change.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied the series, thanks.
