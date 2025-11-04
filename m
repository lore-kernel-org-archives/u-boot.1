Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1AECCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27E11808AF;
	Tue,  4 Nov 2025 16:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tIBM72e5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C5008144A; Tue,  4 Nov 2025 16:15:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6EDC8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762269333; x=1762874133; i=xypron.glpk@gmx.de;
 bh=p7Z6gk9iEqxqVFD7s2bAEBUd59aAPZ44isqL68Mlyic=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tIBM72e5qrIdvB5fZO8WEVXY1zYELw7A7Cj+R8t+IU53VxjQ3ld8Uyp6yG/PPej5
 DilRr/C1uNlDcjw6xUXK2RgVhZEEjmowczzGq+qUs7GbUiO05D2ZQgv15m5Vzqyhr
 KJQ3MHqxunXNHjPXBw2MhB7bemYKq5jm5F/6nydmK/ZsuEDbOpbCRY6DFySvew3k2
 b5wVGgPEV1P2AMHcmq5xrqirG/YZcTppt6j4YjGJxnidpLAPTtvjPppWf+GuyljS0
 +pNvTJw4Orcq9vqSzbm7wXMGGssPVwkIjhcCPXVx5keSK0I7C/43qHdswbsg36Nue
 Skk5JMQizcNOIjg75g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.183.149] ([93.94.208.154]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm6L-1vR2P02V7T-003ODt; Tue, 04
 Nov 2025 16:15:33 +0100
Message-ID: <3e2517cc-1bdd-4e52-b35d-2463111e1ca7@gmx.de>
Date: Tue, 4 Nov 2025 16:15:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: bootstd: Describe the optional
 extension_overlay_addr environment
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.denx.de
References: <20251104104530.1064647-1-kory.maincent@bootlin.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251104104530.1064647-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PE+iRpYcXcPDNBIzaHoQwgNNmaxAZs1O+Qke9ZLbjmB9NWDLY+r
 fwt9djF+KTXeUxb5Q+J2iw/0hQYdRQpu2TlAI0u//e7ybAhkUB/kJA1r2W3uNv3maA8J9kf
 zoqixU5tskesXNo7G0ReOlZRTvCzqfICYGDBaFb0i5482921R57/2MODuaZ0Br/9NuRgk+B
 tuTOF2kF0pO84fAofH1qA==
UI-OutboundReport: notjunk:1;M01:P0:6f9ip1QZPgw=;2C/1xsXLqjKuisBe7gJEB8Nfu+9
 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
 XmK3ff1+xPaa2wxUTiaBmgONV4=
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

On 11/4/25 11:45, Kory Maincent wrote:
> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
>=20
> Add extension_overlay_addr description to the list of environment
> variables that can be useful during the standard boot.
>=20
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>   doc/develop/bootstd/overview.rst | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/over=
view.rst
> index 6cf3b48efca..d3dba2a3405 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -261,6 +261,9 @@ fdt_addr_r
>   fdtoverlay_addr_r (needed if overlays are used)
>       Address at which to load the overlay for the FDT, e.g. 0x02000000
>  =20
> +extension_overlay_addr (needed if extension is used)
> +    Address at which to load the extension FDT overlays, e.g. 0x0200000=
0

Requiring a predefined address instead of allocating memory via LMB is=20
not a good design.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +
>   kernel_addr_r
>       Address at which to load the kernel, e.g. 0x02080000
>  =20

