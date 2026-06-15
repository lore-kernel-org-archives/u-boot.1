Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E9ACD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 23:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AF8684895;
	Tue, 16 Jun 2026 01:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IAKKmtEk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9242846A4; Mon, 15 Jun 2026 18:31:26 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A02884105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 18:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-441080fd7b9so2360258fac.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781541083; x=1782145883; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x7HpjQHJrTb2IowHLyR9l9zctvIoSJifPvfq4ybvFCg=;
 b=IAKKmtEkG1j5emfnYx18aUJD+G4aLChv4fZVs2567DEo0oY6PpE/96wfSpXcqoEp2x
 p4+TOj9H9sza5MLx8vuaC5+7It9QPjZHJDPcC3Ueu6cob9CfYuzOyur32Ec/JvTEKNbC
 TEAjeJkYvtuSLF7KOwQPTOIzsKRBiQBSokgtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781541083; x=1782145883;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7HpjQHJrTb2IowHLyR9l9zctvIoSJifPvfq4ybvFCg=;
 b=O/L2wIa8vYDq7dHFsmfK4DJG53A3j875AF9L3UZz3pkJUlJb6s22ghTQYimNGmAuF/
 jGoCFp7FOd5coiR8IEH64Q9DVI0Mq8tPCtEMm3BD0qjWjv3VcXtVzNo7zqVBugsuSQAy
 tB9HVrwYXXUeJZa4rVYhOscU9opfH1ORqmLaVs8HW5bs5qO0REZo/d8vqANnpQOwmVe5
 xNgVfO94ZOWboX/NIS1FuvYLRM0zsTgG1EMY9PQ7E2WSeKDxLIIzvxDmm6E+5BBoR98w
 1IMMG3jUS3zjMaFHsKorViCJ6xgCf2c996W+l7MbvV4auBNP7/bPUq0fwEy0dE0nmaw3
 K3MA==
X-Gm-Message-State: AOJu0Ywag21k7/jlWeO6DaPyxlQyt+ji7nur1vQx/9kexdRHmBumzEmr
 Os4i/3pcCWqrtrCxZ1eUIinbRITCbLiil0pnOqmjsnMBeJTATnhwD5anO9eGNffGhtQ=
X-Gm-Gg: Acq92OGCeyAsDXa4HPD1BYPeG2gscfG4Tf2SLqYvlqjFGIomZKeFc1JLcLVZkY4gdlb
 ie6oi6NsS85rjPqsLaBBoWURpcgeikw9vubDRPgrf1fZk9aoFFSXZUdDhrV7+TrNCWx2p4me2yT
 ZKofyQEKP6jMHF9AenKFSemuxpdXcnzywpbSdrjmWGWux1rge4sQRuA+A0+pVuHK3dWUkJ81dYi
 IXhHdzv6d33lf2YvZRs7s2W7FGWwVIn5eNXYS6d5GuLK22Zaq1irWeRm2DffeROuhjLA8RMOGqP
 4TL013BbLxWca56XgcxWd5bZOSAPG+iqIhwaofRqfmZR9gGebet+L88RIt7M+KVk4sZ0BeWyhwm
 Pej8eSaevOpwzgxyJ4Xx3Fb/t7Yf6y3JKuyXC/ziuwIiNA8Za5tMTlQfjO0AFP98Zu7RBSCFJ9g
 iVKn/UoFP5I2x6jhb6Np9GqPQB5yXRqwfT/CSYKuNEmpyYzsp8TrpGjM/qzBrTDt2vc8ZM4BNbz
 OKaLEVaUHrZAG6Ts8RLSUhAF5cvUyXNSEFsCwJmXP8cRtsZc58=
X-Received: by 2002:a05:6820:1786:b0:69e:97bf:4763 with SMTP id
 006d021491bc7-6a0a422627bmr46013eaf.3.1781541083100; 
 Mon, 15 Jun 2026 09:31:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69f00d232e1sm3288055eaf.6.2026.06.15.09.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 09:31:22 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:31:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v3 05/14] part: enable part_get_info_ptr for SPL UFS
 partition boot
Message-ID: <20260615163118.GA382693@bill-the-cat>
References: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
 <20260615-spl_ufs-v3-5-360bceb29596@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J74+5klSzKoodBLP"
Content-Disposition: inline
In-Reply-To: <20260615-spl_ufs-v3-5-360bceb29596@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 16 Jun 2026 01:14:20 +0200
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


--J74+5klSzKoodBLP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:30:01PM +0530, Balaji Selvanathan wrote:

> Add CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION to the preprocessor
> guard in include/part.h that controls whether part_get_info_ptr()
> resolves to a real function or NULL. This ensures partition lookup
> is available in SPL when UFS partition-based boot is selected,
> consistent with how MMC raw partition mode is handled.
>=20
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.co=
m>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - No changes in v3
> ---
>  include/part.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/part.h b/include/part.h
> index 15daacd7faa..47b91e2043c 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -463,7 +463,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t st=
art, lbaint_t blkcnt);
>  # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
>  	defined(CONFIG_SPL_FS_SQUASHFS) || \
>  	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> -	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
> +	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) || \
> +	defined(CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION)

Really feels like we need a proper symbol here for some library
function, and for the users to select it.

--=20
Tom

--J74+5klSzKoodBLP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajAo1gAKCRAr4qD1Cr/k
CqFnAP4pQfWGJRvVCTTzbHhW3miZF6UK2b22qQZ1Yy8W8wOWDAD+OZvNYpovDNam
mCQiX2LFhfVyrAOTuxZwTEQMrKxUxQw=
=cq9s
-----END PGP SIGNATURE-----

--J74+5klSzKoodBLP--
