Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B93BC52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 05:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA1088AF4;
	Fri,  9 Aug 2024 07:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="N85E/gR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9779488AF4; Fri,  9 Aug 2024 07:49:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE05288BAE
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 07:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723182582; x=1723787382; i=xypron.glpk@gmx.de;
 bh=CqYNh4/w5hxTnbaYzHaZU3/wVI5TrqGZKT0afLwmM1Q=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=N85E/gR/28pcP3iwLl2Vf5HJ1WmzzMMSb9qLcQ95Q0AfC8STNDemKqp694qTK2MG
 3wQD+BQY+knkbQnBPPo26/Ll5+Xp/2cOP9O6fJzAai7xW0b0tSc7mKA/sdAZy+Pq0
 PFijBnpby5rsx8/u2mvpIL+GrPsb5+cPAw/Uk1f1C7Qtkbb235Vy66cwlBebxiGN5
 f6SxI1OxoJayPAU9DIwsjbsBQL1Xl6rHpf7oQaBQ2NV7b/SMS+sh6TJBLaRqK9o9q
 eFAu/kmYPBgme18T4IvjVHxim6aq+SfIoJR9HRa0xWWgMkH9E/ms3O8p3MGpfpn4E
 mhoaUrobYc/8c9Ga2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.164.168]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsYx-1sQRar0euF-00EOnz; Fri, 09
 Aug 2024 07:49:42 +0200
Date: Fri, 09 Aug 2024 07:49:38 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Anand Moon <linux.amoon@gmail.com>, Simon Glass <sjg@chromium.org>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] disk: add TegraPT support
User-Agent: K-9 Mail for Android
In-Reply-To: <20240807121024.11318-2-clamor95@gmail.com>
References: <20240807121024.11318-1-clamor95@gmail.com>
 <20240807121024.11318-2-clamor95@gmail.com>
Message-ID: <0C2B63EE-A95F-424A-9143-6A0C2164F666@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K2i/lfaHtoYhW5w5ajo1beeos2paUheTagSswW3AWyzQ613fseV
 VZLwdLmkKWSTMyVf6qvr3UpVVqmEnDb1bSA14hwQiZi1Ty5aqjbPrLMzllEyoIZy6T+UenX
 Fs4perZiFB/qtNgRmmsUYLRdgWSIn6F/qRe2TsC+tC0XrwV2bD4voYviYDrdp2R/EjWvuCA
 wb4WyZOMYE8s/gyBta1Zw==
UI-OutboundReport: notjunk:1;M01:P0:TKG3F4vBEB0=;p5x8c/DqU4uMnzI7T8N0qAZsn4z
 nkCFefwkCZWg2LEgpuI/wplZRSwEBwDR90eYpQNBSHyDz14k0exNZemXt9iOvkshsFH6EMOFO
 8+RDSQEr7YrV/Z+KwQyHbIfqlpLzXAria9yDVzicIbY/rHzOugPpSBaGfpXd0nJGOwS6kypcg
 WxZFqciYBIsOmHG5wVYlk7FBtF0zEFfQVBJ9IeCvAD4V9K1pKraW9lMmqdx3V9Z8CRTyrjUkX
 s1pEAH6dh53VQN69E27KS15XfBakkZclcMxtioPmp9BqPsgjNh73NXWLmSBlHhIkq6EZ52AsC
 0c/+VzvVa43LNzb79/nB2rTEN4kMJU6fU3JXn5PkCQPgqtOMtT+RxwiumxPTIe8NnrHz0GWyx
 DJELCSS5p98xAmzUTlptPK0/bgrRw4sxRgy2jcSp7vmZOpAl9DpuVKJa8OBwOeBaXPzZAuXF8
 cfDvDKGhda6Adi5kr0kQ7lO08b1FWuOm8dtyRdYxXnxQqQ1sZRkZkPkj/F2DvtG4THXfyq6FE
 I+QY5CmOIOsUHcasa3wzyysCRX5r/7I5sQCeQRftB1vxeSAk8czA9Tu/5UWj7veTcAAWaRZb+
 RV+l4e8c1lTFttxLwrbtpWINMAu+VhZhfb0IZnga+2ULqyFHEFmAcvqprXzTQXhVGs5Zc6HIB
 NFttBtYxDAdBcCTrH7x5cIsJPXzOwh2plxng+eSGRl90jUfbHrp5C9TEGvjg8W6cnOgY848fi
 y0VcCVOfoHEAbA0V+d66Z5CeYpBCnsC0y423ljXbM/gGbOXmmrqYTei1eVf2QPiuRPDaNVVyA
 BUWG772RLufJwefEKOfcJ1Ng==
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



Am 7=2E August 2024 14:10:24 MESZ schrieb Svyatoslav Ryhel <clamor95@gmail=
=2Ecom>:
>TegraPT is compatible with EFI part but it can't pass Protective MBR chec=
k=2E
>Skip this check if CONFIG_TEGRA_PARTITION is enabled, storage uclass is M=
MC
>and devnum is 0=2E Note, eMMC on supported devices MUST be aliased to mmc=
0=2E

Why wouldn't you use U-Boot's gpt command to fix the non-conformant partit=
ion table?

Best regards

Heinrich

>
>Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>---
> disk/Kconfig    |  8 ++++++++
> disk/part_efi=2Ec | 13 +++++++++++++
> 2 files changed, 21 insertions(+)
>
>diff --git a/disk/Kconfig b/disk/Kconfig
>index ffa835eb35=2E=2E75a849ec8c 100644
>--- a/disk/Kconfig
>+++ b/disk/Kconfig
>@@ -49,6 +49,14 @@ config SPL_MAC_PARTITION
> 	default y if MAC_PARTITION
> 	select SPL_PARTITIONS
>=20
>+config TEGRA_PARTITION
>+	bool "Enable Nvidia Tegra partition table"
>+	select PARTITIONS
>+	select EFI_PARTITION
>+	help
>+	  Say Y here if you would like to use U-Boot on a device with
>+	  Nvidia Tegra partition table=2E
>+
> config DOS_PARTITION
> 	bool "Enable MS Dos partition table"
> 	default y if BOOT_DEFAULTS
>diff --git a/disk/part_efi=2Ec b/disk/part_efi=2Ec
>index b1a03bd165=2E=2E350a8a6dc5 100644
>--- a/disk/part_efi=2Ec
>+++ b/disk/part_efi=2Ec
>@@ -318,6 +318,19 @@ static int part_test_efi(struct blk_desc *desc)
> 	/* Read legacy MBR from block 0 and validate it */
> 	if ((blk_dread(desc, 0, 1, (ulong *)legacymbr) !=3D 1)
> 		|| (is_pmbr_valid(legacymbr) !=3D 1)) {
>+
>+		/*
>+		 * TegraPT is compatible with EFI part, but it
>+		 * cannot pass the Protective MBR check=2E Skip it
>+		 * if CONFIG_TEGRA_PARTITION is enabled and the
>+		 * device in question is eMMC=2E
>+		 */
>+		if (IS_ENABLED(CONFIG_TEGRA_PARTITION))
>+			if (!is_pmbr_valid(legacymbr) &&
>+			    desc->uclass_id =3D=3D UCLASS_MMC &&
>+			    !desc->devnum)
>+				return 0;
>+
> 		return -1;
> 	}
> 	return 0;
