Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0552ECFD36B
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 00:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AEE183EAE;
	Tue, 25 Nov 2025 01:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GjkFo4MI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE3383F2A; Tue, 25 Nov 2025 01:00:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB3FB83E8E
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 01:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764028816; x=1764633616; i=xypron.glpk@gmx.de;
 bh=8BLKJFxm6jb7cQMO/kyJcEBmHSqjzos6VzGan3fU5lU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GjkFo4MI9EBpqwLzWFIJouG5/ALM8qIYx03AMJxQOx1xgR0OMfiHDgGq52cxap9O
 30NygP44Y6+K7qDMkRLtQwtqykjoNhMk6Tp3n4TWw6lTgr2YAKf1Oj79IpBDHW0fo
 7cR9+WVhW1OoN0BOkuEH+SNr/kx/2TRXyey2dS2GNy7mzHJmA8srleXQHMpzqonUs
 rA6f3RYyDKoi3hQUW5y8xkVXFcjJz80sb2HFxJAEoSX4k2AfqhgUwKdUVKLA95nrp
 IqiIkEnm22EV4GLZqQAfDvhAMaHfKfJ53wk/b56dMciF6y9AD2/AsxpCkFTqWTN9W
 aWu4F6TIoFrcqp2zUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1vcQcI1XGY-00UCZh; Tue, 25
 Nov 2025 01:00:16 +0100
Message-ID: <e7e19789-6c0b-4ede-b7a3-ad5002a7b9ed@gmx.de>
Date: Tue, 25 Nov 2025 01:00:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver: nand: skip BBT scan during SPL to reduce size and
 complexity
To: dinesh.maniyam@altera.com
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
References: <20251113030357.15397-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251113030357.15397-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lZV4pg4jTJ61MZb532HHnuM+/ChkINqKh/tOWz9B/whDpidht7P
 Mh+t7rGC3pJMVq/scg6PzehtE7ZB67V5g0Vn/hhxzp6xf7xz+LKdvTCqesYfJ3GDqqlT/z3
 /Lk2pxGWqwl5Z3+vUhecqa4eQs7jDk3Q+ZuUgve+uc7pN6xZqVtDw26mw07eEDKAVaWpIva
 KXIQhOMuAqb8hZkRClLjg==
UI-OutboundReport: notjunk:1;M01:P0:qFbmpYCHb/w=;jfNo1iMeaTgcWCHjAAC6YPYWpnl
 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
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

On 11/13/25 04:03, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Guard the Bad Block Table (BBT) scanning with `#ifndef CONFIG_SPL_BUILD`

Thank you for looking into this issue.

In the patch you use CONFIG_XPL_BUILD not CONFIG_SPL_BUILD.

> to prevent running `chip->scan_bbt()` in SPL builds.
>=20
> The SPL only requires basic NAND read functionality to load the next
> stage and does not need full BBT management. Running the BBT scan in
> SPL unnecessarily increases code size, memory usage, and boot time.
>=20
> This change ensures the BBT is scanned only in U-Boot proper, where the
> full NAND subsystem and dynamic memory are available.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   drivers/mtd/nand/raw/nand_base.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nan=
d_base.c
> index 48e3685d995..4dc2a19b8f6 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -532,7 +532,9 @@ static int nand_block_checkbad(struct mtd_info *mtd,=
 loff_t ofs, int allowbbt)
>   	if (!(chip->options & NAND_SKIP_BBTSCAN) &&
>   	    !(chip->options & NAND_BBT_SCANNED)) {
>   		chip->options |=3D NAND_BBT_SCANNED;
> +#ifndef CONFIG_XPL_BUILD

Running scripts/checkpatch.pl creates a warning because you use #ifdef=20
instead of preferred

     if (IS_ENABLED(CONFIG_XPL_BUILD))

Best regards

Heinrich

>   		chip->scan_bbt(mtd);
> +#endif
>   	}
>  =20
>   	if (!chip->bbt)

