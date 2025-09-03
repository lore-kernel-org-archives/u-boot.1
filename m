Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55874CA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 11:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2ABB834E5;
	Wed,  3 Sep 2025 13:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=karo-electronics.de header.i=@karo-electronics.de header.b="QHzxnI16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00738350A; Wed,  3 Sep 2025 13:36:06 +0200 (CEST)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F626833C6
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 13:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
 s=kas202503070814; t=1756899361;
 bh=npIMeF90gTSaCds7jfXvghJWYQJiNAM3Wcnvc2QV/2Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=QHzxnI16EU63wFMt9HPsHYU4fi1w4PE4/FZBS5Yt3VhnEQfLCYe0aId0LZObArJM1
 Wl0i6ntunDLg92sPvgLloEoEIxlusgXEa+1T88H9gE7oouJXHYHrnG9us5Dc0/4G1i
 Wcpjzzi+ICRXTrMUx2iTIAfK7LoMiGKhpsG/tSoMLIzBCr/AN/gGQ6wWOnIGkSZdmZ
 51MycT6GJLXrGe3NCvT+0dMAKaWPRJwUIt9TQCuAd5V0MGiky0tW9JDSfMuYjkaAwR
 BiTSS+VnHHDD33uCeWbylfOg+3U+Rh4P0B8E5sEHy2g4L9NYyIx14DdPplkjW9ffxi
 5R66NmfFhXlpw==
Received: from karo-electronics.de (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id 887BF7720026;
 Wed,  3 Sep 2025 13:36:01 +0200 (CEST)
Date: Wed, 3 Sep 2025 13:36:00 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini <trini@konsulko.com>,
 "Lucien . Jheng" <lucienzx159@gmail.com>
Subject: Re: [PATCH v3 2/5] misc: fs_loader: allow using long script name in
 request_firmware_into_buf_via_script()
Message-ID: <20250903133600.52169228@karo-electronics.de>
In-Reply-To: <038e8258c903367dccd9c7cd1adb51bcf2bdf307.1756885599.git.weijie.gao@mediatek.com>
References: <cover.1756885599.git.weijie.gao@mediatek.com>
 <038e8258c903367dccd9c7cd1adb51bcf2bdf307.1756885599.git.weijie.gao@mediatek.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: /
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

On Wed, 3 Sep 2025 16:38:30 +0800 Weijie Gao wrote:
> Use cmd_process() to remove the length limit of script name used for
> run_command().
>=20
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  drivers/misc/fs_loader.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> index 87acd385e23..6a6796c1931 100644
> --- a/drivers/misc/fs_loader.c
> +++ b/drivers/misc/fs_loader.c
> @@ -232,18 +232,15 @@ int request_firmware_into_buf_via_script(void **buf=
, size_t max_size,
>  					 const char *script_name,
>  					 size_t *retsize)
>  {
> +	char *args[2] =3D { (char *)"run", (char *)script_name };
>
const char *args[2] =3D { "run", script_name };
does not work?

I don't see any need for a non-const 'args' here.


Lothar Wa=C3=9Fmann
