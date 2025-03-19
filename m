Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDBFC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 09:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A998129F;
	Wed, 19 Mar 2025 10:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=arnaud.patard@collabora.com header.b="iIuuESoo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCFCE8141E; Wed, 19 Mar 2025 10:28:15 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192C281101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 10:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arnaud.patard@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742376490; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TOTTQGdsr3s8lLF7oqIyaBKK0zpvaKJt6Y5ncSBGyeYEv8cGFfP14MhklWeUjOvOqVjIjrK9WzozFjQmBIFFHG9w4Rt2SiD/v5H5JECCaMc1d3vedsq/6xg85T1bCTJcwhh4oNJzXBDUxeNF9H4dg995Ayn2GQeaWXAt+qHNqSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1742376490;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=yWs8I7FgtvKl88BpXCdYqxBAkM4I1Ne4lh+EknA9iFI=; 
 b=keR9GdLvh/icNZIlS3xlwN5sBdZmnK0PPG7gDADkJHftf23z9yk7u4KJNvd7myPZGnLEleOcA5US/MB66ZpBUR/6D9D4o3a60wxJaSxmLz9n09iztHUQTLvzAlUi35HjN1QQr07//6mTv46Qh6D1PIk3nvU5Ms6eoZkz7StaTe8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=arnaud.patard@collabora.com;
 dmarc=pass header.from=<arnaud.patard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742376489; 
 s=zohomail; d=collabora.com; i=arnaud.patard@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=yWs8I7FgtvKl88BpXCdYqxBAkM4I1Ne4lh+EknA9iFI=;
 b=iIuuESooDgUoduIqL8vZQJACbiIbgetnFjPKfZIFaFdlEWTT6l6UblJeKDwy6+Th
 Pc7r7cUkNV54mGOwX+KMTFBlP6zuw4Ii8BO2E8TJsX/j5c0ffw/xfDk0oWUnzyK00LT
 D7RPuSADdOwkpe5y+how4qECu2wAvLtm1N3uIk6E=
Received: by mx.zohomail.com with SMTPS id 1742376486847236.5994665871458;
 Wed, 19 Mar 2025 02:28:06 -0700 (PDT)
Message-ID: <5d76a7d1e26fc86ed5854197779d9a10fb7e8db4.camel@collabora.com>
Subject: Re: [PATCH 0/3] Add support for RAM boot from maskrom mode
From: Arnaud Patard <arnaud.patard@collabora.com>
To: u-boot@lists.denx.de
Date: Wed, 19 Mar 2025 10:28:04 +0100
In-Reply-To: <20250220231358.432367-1-jonas@kwiboo.se>
References: <20250220231358.432367-1-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-ZohoMailClient: External
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

Hi,

On Thu, 2025-02-20 at 23:13 +0000, Jonas Karlman wrote:
> The BootROM in Rockchip SoCs will enter maskrom mode when boot
> firmware
> cannot be found in nand/spi/mmc storage.
>=20
> In maskrom mode the USB OTG port can accept one of two custom
> commands.
>=20
> Initially a 0x471 command to load TPL into SRAM. After TPL has been
> executed and it has returned back-to-BROM, a 0x472 command to load
> SPL
> into start of DRAM.
>=20
> This series add two binman images that can be used to RAM boot from
> maskrom mode:
> - u-boot-rockchip-usb471.bin that contains TPL to init DRAM.
> - u-boot-rockchip-usb472.bin that contains SPL and the normal FIT
> =C2=A0 payload with i.e. U-Boot proper, TF-A and FDT.
>=20
> These images can be used with rkbin tools/boot_merger to create a
> loader
> image to be used with rkdeveloptool or rockusb tools, e.g.:
>=20
> =C2=A0 Create loader image:
> =C2=A0=C2=A0=C2=A0 $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini
>=20
> =C2=A0 Boot from maskrom:
> =C2=A0=C2=A0=C2=A0 $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
> =C2=A0=C2=A0 or
> =C2=A0=C2=A0=C2=A0 $ rockusb download-boot u-boot-rockchip-rk3588-loader.=
bin
>=20
> Or directly with tools such as rkflashtool or rkusbboot:
>=20
> =C2=A0 $ rkflashtool l < u-boot-rockchip-usb471.bin
> =C2=A0 $ rkflashtool L < u-boot-rockchip-usb472.bin
> =C2=A0or
> =C2=A0 $ rkusbboot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin
>=20
> This series depend on the "rockchip: ROCKCHIP_COMMON_STACK_ADDR
> improvements" series [1] and the "rockchip: dts: Create a template
> for
> the FIT" patch [2]. See [3] for a branch with all depends.
>=20
> [1] https://patchwork.ozlabs.org/cover/2050003/
> [2] https://patchwork.ozlabs.org/patch/2044607/
> [3]
> https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ramboo=
t-v1
>=20
I've tested this tree tagged by "ramboot-v1" on rk3399 and rk3588 with
the generated u-boot-rockchip-usb47?.bin files and it's working fine.

This work sounds very useful imho, and possibly easier to use than DFU
in SPL. Any hope to see this merged in next release ?

If it helps:
Tested-by: Arnaud Patard <arnaud.patard@collabora.com>
