Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20DCC56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 20:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E84C80CA3;
	Thu,  6 Aug 2026 20:39:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2v55qAZkRS4f; Thu,  6 Aug 2026 20:39:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2EC480EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786048793;
	bh=hJgcZU1PZgi4SxD5kTJZjQkzBtQWULBs7XIeKnbGwgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tUp7xbCfTiuqUOf5fwMKbSxp1Cb3InLxhqE8c43xmUUx3DlSbZOtvmBpl45qlFz4V
	 n2LQ8fzUXQp8HUj5KfA8kmKCeK+oU6qSOs56xHbINPInQYtYqKFRoJzcvN0/D0soEY
	 Mwz2p7EoV91Jdu5R1efqU7HNg4I8ZxGiuQrLxdhfCOpGzNUcdQ+d9TbjFd7EJW6XzK
	 rI1P1jC1ajFfOP1yB/UaCZ5aNzpWEkWWrESWlOYDPgmi1daUmu8Qs1UmuLNHxCK+ps
	 XbrbFVk5+zSmIiTyXKfgNmPNT+/h3j8UELjHRCbgmXXbwf5FhOf2LAIpbJbhuiSE8+
	 MTOB6WqcvBSWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2EC480EA1;
	Thu,  6 Aug 2026 20:39:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2786D397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 195F5605F7
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:39:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jk5CmLWPXapI for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 20:39:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 51F0A605EA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51F0A605EA
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51F0A605EA
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:39:52 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-43bf9548df4so1737467fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 13:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048791; x=1786653591;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hJgcZU1PZgi4SxD5kTJZjQkzBtQWULBs7XIeKnbGwgU=;
 b=ptGVU40O2dHB9mw0NG+E2clVbgqv+IMGJMw0egoHZWaRA9GamW1DSqx7qVoUYOnzFx
 4avNFBf0UJPaHyWNyM2jJY2Rm2JkUjc/6/0oOkttVtI1QcPsLu3S2ewGVEbstlVt+pPz
 uzgJQ7JxpYSBDOBkjerY3ix9lbhzlnjD3VDTPZXYe5N0rEEUPemi9EUJkMT1aguCCmdM
 i0kwqVRYcUK5B6p1SpRNGqhnPSjqs3O9IT7PvylFOsL72TyVoFsqFBiQrctbW19LeCo8
 L3GkkeHXYopvIBeLnE/esDAVBEBpGEBSmYlVDBBY747tHstPTT1Ves+Rhs+fRLNJp0C/
 KiGg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9YgI/L/k9eI54De1AplFqbqFSnibZAvEOuW6giS045wTbrPBrHPeGN6k9hrWP9hkfhe/GbdM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzRb8P23BYWjOScMpG9r49emHqU3mrdPXistqpfI2HBAU2XIXZL
 hWCKzDbo6MnpVTZ+s+veA6dpGD+JO4SGATMUmKBK/MScTyCQ/DywWqcW0qBzVN4Q/As=
X-Gm-Gg: AR+sD11n6xFvORmszpndpV19BEvk67a0zlV7jhXkvRYwygNIMcv27sgp/UAjOFehiD0
 mr/T4QATraVXPO3BZmQILRFvXS9mgWhJUsOUqqELTKC1xLMrRS6LntpTig9tRLSI2cH09OGGH/d
 5TtHmUF3dmhwB5XPqYh6qajqdjYHxVFhlXYwFfLYUyeTMtQhF/GgczxdCxBwvfY2Cw2E8cn7N4p
 trtHB+I5k+9yPo3iBhyy1ynJ9XLiJ0RoDrENi3sOV2fRTHKbb6+iHXDlyroLCH69NfDwxWK2FAP
 pcpt/iNCf9swRiQoI5W9vOMgfL5H73Vn4vPL5RSix2k/ghvt8fPx+gBfLsqxYfF54G+PlVgpyoq
 qPEmjkwiogFlXP8vxWoArTVy7dviH88iomYhGUS/9CZfqpwQhoYeaXMj1or7PpJ3vIMbhhmZK9p
 tryZvcssTXxhbcYRPyDOGi7bVKdPRuegAyVpljLC3hQkaMrwaSMvEhaLTN4emPii76Ej4+/iyuc
 mhpZaYRRUTfqme6c0aZYGUXWviBHPFOjTTLKVTbK41EoIzQgszouoAx5X1qapUbgPUDx9XSkWWy
 XL7wmnIckA==
X-Received: by 2002:a05:6820:168f:b0:6ac:9729:670d with SMTP id
 006d021491bc7-6ae96fe3776mr7935617eaf.33.1786048790854; 
 Thu, 06 Aug 2026 13:39:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02b9207e7sm553720eaf.0.2026.08.06.13.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:39:50 -0700 (PDT)
Date: Thu, 6 Aug 2026 14:39:47 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>,
 David Woodhouse <dwmw2@infradead.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mingming lee <mingming.lee@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 4/4] configs: mediatek: drop no longer needed PINCTRL
 options
Message-ID: <20260806203947.GC165443@bill-the-cat>
References: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
 <20260803-mtk-pinctrl-kconfig-cleanup-v1-4-fef1ff69d1cc@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GTJThYKzSrYnidCG"
Content-Disposition: inline
In-Reply-To: <20260803-mtk-pinctrl-kconfig-cleanup-v1-4-fef1ff69d1cc@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786048791; x=1786653591;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hJgcZU1PZgi4SxD5kTJZjQkzBtQWULBs7XIeKnbGwgU=;
 b=sDdsyXG6o4PCfDquB+PTgR5azPDlLkDqOarP0ICu99W5tDb/tBZ1ngNxqSG5mEPD2f
 DDG8jHeOyDLh9KGyXg4sX/ZP8cbjrRWJjA15/7dVw5bN3LGaKqqT6hy3H5moLx+TPTuQ
 rZIUppNTG8PEDkyPohEKz3OWoeswaMCc6hlZM=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sDdsyXG6
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


--GTJThYKzSrYnidCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026 at 03:57:07PM -0500, David Lechner wrote:

> Drop CONFIG_PINCONF and CONFIG_PINCTRL_<SoC> from all MediaTek defconfig
> files. The former is always selected now and the latter no longer
> exists.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  configs/mt7622_rfb_defconfig               | 2 --
>  configs/mt7623a_unielec_u7623_02_defconfig | 2 --
>  configs/mt7623n_bpir2_defconfig            | 2 --
>  configs/mt7629_rfb_defconfig               | 2 --
>  configs/mt7981_emmc_rfb_defconfig          | 2 --
>  configs/mt7981_rfb_defconfig               | 2 --
>  configs/mt7981_sd_rfb_defconfig            | 2 --
>  configs/mt7986_rfb_defconfig               | 2 --
>  configs/mt7986a_bpir3_emmc_defconfig       | 2 --
>  configs/mt7986a_bpir3_sd_defconfig         | 2 --
>  configs/mt7987_emmc_rfb_defconfig          | 2 --
>  configs/mt7987_rfb_defconfig               | 2 --
>  configs/mt7987_sd_rfb_defconfig            | 2 --
>  configs/mt7988_rfb_defconfig               | 2 --
>  configs/mt7988_sd_rfb_defconfig            | 2 --
>  configs/mt8188.config                      | 2 --
>  configs/mt8189.config                      | 2 --
>  configs/mt8195.config                      | 2 --
>  configs/mt8365_evk_defconfig               | 2 --
>  configs/mt8512_bm1_emmc_defconfig          | 2 --
>  configs/mt8516_pumpkin_defconfig           | 2 --
>  configs/mt8518_ap1_emmc_defconfig          | 1 -
>  22 files changed, 43 deletions(-)

For the record, I don't object to these changes, but they don't have a
direct function (since the options in question are still enabled in the
end), and they can conflict when I do another resync of the defconfigs,
which I do at -rc times. The exception is for config fragments/files
that use "#include" statements as those don't get resynced.

--=20
Tom

--GTJThYKzSrYnidCG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanTxEwAKCRAr4qD1Cr/k
CoH2AP9x/mjsNdJpa9xl/930NZQomanEXMCfl+RSxK8NllCvBwD/Sy13JaHgESKq
Mj/gr0n/wU2GPO2YLcH8EtVlp0q6ZQM=
=/Myi
-----END PGP SIGNATURE-----

--GTJThYKzSrYnidCG--
