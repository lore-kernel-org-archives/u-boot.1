Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAC8C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49E4A80C8B;
	Mon,  7 Sep 2026 08:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iYIpzRHvrm3s; Mon,  7 Sep 2026 08:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5DC5D80C2D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788771067;
	b=c4gX7oKIhkKio9LFpKH2ZObhuxW4YPZxtYJ2oIfT+Bl2fMB8kQi+DlTrJlM+89G2DWZD
	 Y+61ykCvT8sKhuil+XHipqypewDqfE4IbrxnuYUbTHY4mCSKuaboCBx7UQ7bfpu9fx5gJ
	 AWiSV1SbTezfUaiXUVuk3Sftgfv8ExDWE5nB19/rBDAdhQwk+19KUDSsXwYZW+Qdg+kOR
	 +8Yt8t3H4Or7eVWwOh6eelhTOaocLvIEPLmpbi9t9mVCjQqrsxfkQXac6IsFebDbSH0OO
	 jJQ0CyaLpKusGRhIpBE5S/cK+78JgISdA691phe0eiLJjwqgM+kmnaTpmfB15aoYbaQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788771067;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WjuT2FB7/zjSs8Pcw9F9xHQv9JRRIVGAl04qdP5IDdQ=;
	b=HVKSwf0Fza/vzu/SN9lruYFoWKj+S+0U+BOHaJ6d9eIvpyO317jOqOAQsAT1Cb+rQ50N
	 mkdRyQaEGU1jFnwtqvvG5VXMIyeCUTFhMvU478g0poI+UjltcyU+urCwmGUQY4juB4gwk
	 SOyLMORjpkxe+8W3NKfm3ZMCvDtptHWsFKjOUZNCoyv0me0pSdq2JMtKyKX8v6SzqbQgo
	 AtrzV1Oi6E2S3s0JNF+roQ71OsjjOlJ6aVxUQB5FBPdl0bAu0k9LqbK7/DDTXe+Ts7zUA
	 G1wCsOSszsZddGoyyOFuLyt17ienZ0TxPnvmjCEK9EgbMZNuwJcBGrpSMnLnOnWPiYw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788771067;
	bh=WjuT2FB7/zjSs8Pcw9F9xHQv9JRRIVGAl04qdP5IDdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rVqMOVMaXVv7bakK0QVCltGfUwMzokRazjVbACTCaXfoAeSNnUHVzPjb5pLTA2WAp
	 lDBVGNFMOa/0J8Q0Bw+AZr89h1rMpCqaXhR0zkxEDBxd4dLizvolb5HGBEJpliSNfR
	 n8MwRIkpRmJ/vpLNEvKkfCzQd3nG+MIUz/QXevavJMYowop7laOvk9BIVDSzYTwTFc
	 KBMijjRX/AnuYKHWfuVaBy2T13AUIBzU5ajB+oDdWLnVzs+EU/dJDJHQi0HIEQAHWd
	 WRuXef5SD04IZqLMoFoGgr5FKrGTC02U1wuJ5OzvYp+mFDzMsdW+A5SO5qJZjaFzhL
	 fyJhSrXDY5BOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DC5D80C2D;
	Mon,  7 Sep 2026 08:51:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BCB89CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D2A4605E6
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JYtOAi9JFj92 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 83508605DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788771061;
 b=VnodVFIM659oXNKyArGG4GbV3DXhy4117hV+WaC0m3W8SdY8pluOQkvlPLr8ezErRcvX
 8dlI3Thq2gMQtQwQ8/of9LqrW0c2amFTiX/gYtrH/nVlUN3sZ0OO2+7MMvDAE8nLCLf20
 AthmzSg8CaEW4J605Pm2JQquTXDJ7qI8L4K2lGf9P4x7OF10wibX/BL58Vn2HsMjSU+FW
 csAAJdyHyF+Y3qcH+H9U9sEig4E0LlJh7n2j2YDS3CdJRwZzB+g89SK9Z1qDuQ17M4e07
 RF3IwVb/ZsLm2V1HTdjBF4PFKLCtd2mi4iyxRrJATk1rfyqcTu7l30qk8dyc/0H4Obw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788771061;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=WjuT2FB7/zjSs8Pcw9F9xHQv9JRRIVGAl04qdP5IDdQ=;
 b=r7bdbnbXev1/OqwiROFBtlRIhknRwkQ8AZ6D6WSD3vAUj/wTIogYSVGlpbkTFoq1U/FP
 QcN00tsr1l4b+xjjAPtmYBofYboQGAesBP2+vZjHUdFPkcXq0vCUZ0JMF5zVRh0toYj7F
 H9Ke2rQkaL8hyDqXrt95OYDh3jHPm3jJmSj7/VxhvzccsiUCFkTwNMA34xclAEbKV8Zo0
 Ipvfr3eLdzaMZvUrQ+my3UOAo1NAEV7EAhByxuYVFNsElGPshTB803T/IXzFlmjFkHmtb
 NqnTm4+goUY4zGY1Mu1y+5Rqa3yfXBwvbftQAs8HZn2JUcs4I48Sj30WPPtI0Bc0mGQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b="DiJ/egfx"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=DiJ/egfx
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83508605DF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788771041; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=K0JJbUtzqNbZhwUiaoDv8RqpGgZh1QatoVdMyWtg0cBZXhnb6nvoBaaoP8hhHqHIdgXz9xmJ9m8orkkmlRMXC93jEaxRBUBLvecbtlKJl/85q0FxnXfUpf3Sfma2LZMsBJuwitew74C2o/4aY+j4ZyThQYpTGU7Hyo74FkXsJNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788771041;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WjuT2FB7/zjSs8Pcw9F9xHQv9JRRIVGAl04qdP5IDdQ=; 
 b=dEscmfaXbyhKOTPDRyOZgfPsP4AtN9CISZcdSEIlats+IrfnbKgyutx6hq4TX9GKDOmPASSAcs+kvEUaTMJkQYuC3ZuXi8kCBIksAJS8wcPTQvXj6G0kSKrlgR2XxMKt2XmQOo4QYqj8Dy/UbxlGWq0/Hgp7kHN4g2kdHqpECxI=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788771041; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=WjuT2FB7/zjSs8Pcw9F9xHQv9JRRIVGAl04qdP5IDdQ=;
 b=DiJ/egfxBPl7qUG+tobuLWI6N/rA2Ck+cdsoqHIG7MRRCINa35l32MDl2t3e7WTv
 yicta99FXStUGJv2pXohTIjyNCCRXy/MdVk8BU3Y4WKRH+PP+LMCI/HoM925PuBzd7V
 VtuxuysriFPEHiLtp34hXKscFcAnmbQ6iFQaWRGk=
Received: by mx.zohomail.com with SMTPS id 1788771037766115.06585715109043;
 Mon, 7 Sep 2026 01:50:37 -0700 (PDT)
Date: Mon, 7 Sep 2026 08:50:24 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Iker Pedrosa <ikerpedrosam@gmail.com>,
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v12 6/7] doc: spacemit: flash on K1 SoC based boards
Message-ID: <ap560PSIq5GenBe4@pie>
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
 <20260906-m4-v12-6-89eb5a8f879d@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906-m4-v12-6-89eb5a8f879d@riscstar.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.762.58
X-ZohoMailClient: External
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

On Sun, Sep 06, 2026 at 05:11:08PM +0800, Eric Chung wrote:
> Add document on how to flash images into eMMC of K1 SoC based boards.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> v9:
> - Add to generate the partition table of SD card.
> v3:
> - Add document on how to flash images into SD card.
> ---
>  board/spacemit/k1/MAINTAINERS |   2 +-
>  doc/board/spacemit/index.rst  |   1 +
>  doc/board/spacemit/k1-mmc.rst | 271 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 273 insertions(+), 1 deletion(-)

...

> diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.rst
> new file mode 100644
> index 000000000000..0be5d5fa1c39
> --- /dev/null
> +++ b/doc/board/spacemit/k1-mmc.rst

...

> +Chapter 2: SD Card Boot
> +=======================
> +
> +
> +SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
> +==================================================================
> +
> +This guide explains how to prepare a bootable SD card with Bianbu OS for
> +SpacemiT K1 based boards and how to replace the U-Boot binary on the SD
> +card with a custom build.
> +
> +Prerequisites
> +~~~~~~~~~~~~~
> +
> +- A SpacemiT K1 based development board
> +- A microSD card (at least 4GB capacity recommended)
> +- A card reader for your host computer
> +- A Linux host system (for ``dd``, ``sgdisk``, ``lsblk`` commands)
> +- The Bianbu release package from
> +  <https://archive.spacemit.com/image/k1/version/bianbu/v2.3.3/Bianbu-Minimal-K1-V2.3.3-20260128183217.zip>
> +- A custom ``FSBL.bin`` and ``u-boot.itb`` file to be written to the U-Boot
> +  partition
> +
> +Prepare the SD Card & the image
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +**1. Obtain the release images**
> +
> +Unpack the release package to get the image files. Replace the ``FSBL.bin``
> +and ``u-boot.itb`` with your custom builds.
> +
> +**2. Identify the SD card device**
> +
> +Insert the microSD card into your card reader, then run:
> +
> +.. code-block:: console
> +
> +   $ lsblk
> +
> +Compare the output before and after inserting the card to identify
> +the new device. It will typically appear as ``/dev/sdb``, ``/dev/sdc``,
> +or ``/dev/mmcblk0``.
> +
> +**3. Write the image to the SD card**
> +
> +Run ``sgdisk`` to generate the partition table, then use ``dd`` to write
> +the images to the corresponding partitions.
> +
> +.. code-block:: console
> +
> +    $sudo sgdisk -o /dev/sdb
> +    $sudo sgdisk -a 128 \
> +        -n 1:256:767 -t 1:8300 \
> +        -n 2:768:895 -t 2:8300 \
> +        -n 3:2048:4095 -t 3:8300 \
> +        -n 4:4096:8191 -t 4:8300 \
> +        -n 5:8192:532479 -t 5:8300 \
> +        -n 6:532480:4726783 -t 6:8300 \
> +        /dev/sdb
> +    $sudo dd if=FSBL.bin of=/dev/sdb1 bs=512 seek=0 status=progress
> +    $sudo dd if=env.bin of=/dev/sdb2 bs=512 seek=0 status=progress
> +    $sudo dd if=fw_dynamic.itb of=/dev/sdb3 bs=512 seek=0 status=progress
> +    $sudo dd if=u-boot.itb of=/dev/sdb4 bs=512 seek=0 status=progress
> +    $sudo dd if=bootfs.img of=/dev/sdb5 bs=1M status=progress
> +    $sudo dd if=rootfs.ext4 of=/dev/sdb6 bs=1M status=progress

The bootfs/rootfs part aren't U-Boot-related stuff, so please omit them
from this documentation to keep it simplified.

Then the only binary we need to extract from the "SpacemiT release
package" is env.bin and fw_dynamic.bin.

For env.bin, I think this U-Boot port depends on no specific environment
setttings? If no, please omit it, too; otherwise please provide a .env
file in upstream U-Boot tree, and make it the default environment to
use.

For fw_dynamic.bin, I think SpacemiT K1 support has been landed in the
upstream OpenSBI tree? Please check if it works with upstream U-Boot.
If no, please try fixing it, and then it's okay to stick to the
downstream OpenSBI, but you need providing a guidance to build it from
source if possible.

Then you could fully omit the step of downloading the "SpacemiT release
package".

> +The SD card is now ready as a bootable system disk.
> +
> +Understanding the SD Card Partition Layout
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The role of each partition:
> +
> ++----------+----------+------------------------------------+
> +| Partition| Size     | Purpose                            |
> ++==========+==========+====================================+
> +| ``sdb1`` | 256 KB   | FSBL (First Stage Bootloader)      |
> ++----------+----------+------------------------------------+
> +| ``sdb2`` | 64 KB    | ENV                                |
> ++----------+----------+------------------------------------+
> +| ``sdb3`` | 1 MB     | OpenSBI                            |
> ++----------+----------+------------------------------------+
> +| ``sdb4`` | 2 MB     | U-Boot binary (``u-boot.itb``)     |
> ++----------+----------+------------------------------------+
> +| ``sdb5`` | 256 MB   | Boot partition (kernel)            |
> ++----------+----------+------------------------------------+
> +| ``sdb6`` | 2 GB     | Root filesystem (ext4)             |
> ++----------+----------+------------------------------------+

...

> +- If the board boots successfully, the new device tree or U-Boot image
> +  is compatible with your hardware.

This sentence looks extra, please drop it.

Best regards,
Yao Zi
