Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A349CDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A97C386EB1;
	Thu, 12 Oct 2023 08:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="p0bH98A4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF4D86CDD; Thu, 12 Oct 2023 08:40:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by phobos.denx.de (Postfix) with ESMTP id 9B25586E75
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697092752; x=1697697552; i=xypron.glpk@gmx.de;
 bh=94pJ7Xscl9eyB7fiVU2nZOneYPrej0I/G70bansmK4g=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=p0bH98A4M72zKjKRYjmHM29CdKG7znKM5DkA2de/3uzq2Hf8fJCwc3rvBfZwZwTD39LJjw1tyaf
 1LBxV7lKkZ0M7ak2yPREWTGiRYal7ljliPgysEGobniMdHYa0grdXsDJQ82lMyGC9qZCRQrwQLGxG
 z9cbHQFFI85xp1DnU5X7bFJtFIyvjK26UKHsKEA4jPjD0eeoAQ/Dl3ku2PyKRMuXTComFKaBGgQT8
 dsB1+IvQ9WHuW7aUqDjNKlwUcunSrN6/1bf0TG3Bimc6ky/nVrEaZuttzAXLQTUD2rcIyf0vnB6qH
 jXn4EzMaLe0/C6zgX4ivTzHl0ecqOsMY4crg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7i8Y-1rccn749nG-014kGV; Thu, 12
 Oct 2023 08:39:12 +0200
Message-ID: <d1014630-c1fd-4443-9a2e-c7ae2d029bf2@gmx.de>
Date: Thu, 12 Oct 2023 08:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/26] fs: Compile in sandbox filesystem in SPL if it is
 enabled
Content-Language: en-US, de-DE
To: Sean Anderson <seanga2@gmail.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-13-seanga2@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231012015626.3487451-13-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TchTO75hyfZR3VuXQ7oNcb+1VBa8KT6bNU57Xsfy6dA7zCzy+4p
 HGC8Pr6n2fS+LuTasr8CduW6WFWKotq8PKsBCUi+dYWQ4fAJzBMHxI8d/bWhhm0pw3zmnkn
 bo4gcOg8ymgkIRRgdEw9Q/D5JeDfkywepVCR/ia3UCUbwSmKq6rxV334eLN3UU83/ufBtRk
 RUtm7aEA8FRPKYz9J51Nw==
UI-OutboundReport: notjunk:1;M01:P0:uM7kwbQJgZI=;V5ShtKWws3mg9y5EWzO4e1q3EWR
 o5JlTOmdHE2EVftZ3Jm7rcHFuulUOXL2p0AWUkMTWG6Btsf4PTmROg1YMQgpNZ+tykwnCdyRs
 9ryLnM9xahMElE5unEuji+AneEcrz1aeA5gn7vT7wtncYTmW+mR+N4Tf5AxhwSokHcRhPz6GP
 Womo1gCuQ0E/G2kciXhu1cEbGyFdOKlRCgsgzrzQ17VSfi6DGgcFBvPpIpbd+TINYL6kFZ/wM
 nv0efmIPLYD5bdr8fMABLat3vCtcRgXcplTimqvDPD25z7GIGMX+cOtBlCPbkERNrgvTIVDId
 1uQ5SDW/i393q7bD4hLtoTTYps9Hd3Kt7nUHxx4fpnf1RZSwtdJANUmuYl1bF3nEU9d7bCGWz
 47PlSOQBriTGE+zXweeUprKz4zhjNm58XT//x/abkt7/7chti86Sw576Xlllqf+Mn9oP9g8E5
 CMaiJDvYWCuu0TXcujU4nyuVjubDl/C0PIiYz5TpvphbIkHPDx2h7STcdXiGk7Va9Zxe8z2kS
 a2wDFMTZ6Mo9nyjy5gocFU3KGG5jkWwLDhtbt8Dly8ud1m36AAXqKc2h+mQZhf5Q8F8ULjzb3
 y5AOu562xQp0qvEbfpmw/zKkBtIKspcyEd3ELLkeI4Z+7OKx63MV6eIZsPgXlWsvGIHU9UdtM
 0AHqNxr9VluycpUgyQsYsswCEga+w7bmm8IgjwSYdf3dixSD3kfG3PyolewkGmq2SnnkzTy/C
 8H0fVG/axOCPKPzkqDu3cUL5zaiKyBM6FerEPFLTB5cgvFcqZdsUkyuuvSiIeh/QZdxzRnhZ1
 OjOtZEcMAlDbHO7BarZELwgb0sZeIeZV+P8zUTHZj3J0hjvwN73IZySjtt4vQeAFbqPBcRD4Y
 VkafcB60oKURQfkzMGLt8NDubgWS9WqIPTeJeP0Doy7JmPPgAhpi5n4Qt1otXZ4u4osF9qL6d
 r9pG5f6ThCq+ptBvFhWl8ZyIWi4=
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

On 10/12/23 03:56, Sean Anderson wrote:
> fs.c thinks that the sandbox filesystem is available if SANDBOX is enabl=
ed,
> but it is not in SPL. Compile it in SPL to avoid linker errors.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>   fs/Makefile | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/Makefile b/fs/Makefile
> index 4bed2ff2d99..592c7542bde 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_FS_LOADER) +=3D fs.o
>   obj-$(CONFIG_SPL_FS_FAT) +=3D fat/
>   obj-$(CONFIG_SPL_FS_EXT4) +=3D ext4/
>   obj-$(CONFIG_SPL_FS_CBFS) +=3D cbfs/
> +obj-$(CONFIG_SANDBOX) +=3D sandbox/

Why wouldn't you use CONFIG_SANDBOX_SPL here?

Best regards

Heinrich

>   obj-$(CONFIG_SPL_FS_SQUASHFS) +=3D squashfs/
>   else
>   obj-y				+=3D fs.o

