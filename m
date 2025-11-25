Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7368CFD36B
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 00:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC62B83F2D;
	Tue, 25 Nov 2025 01:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ArfM5v0Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1AD783F30; Tue, 25 Nov 2025 01:18:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032F083EAE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 01:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764029886; x=1764634686; i=xypron.glpk@gmx.de;
 bh=EGiGr9ySQDhAkP/fhw25H4llS8W7IC+TD4YU9V0lwvs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ArfM5v0QiSUOq8FXV98L7BJYc56ksdHKzxNT5FvBoruO9iV+RbnxR7qcdVE4h9ig
 S/63F25ujzCWrzI5kOP2I1F+uhi2pTSZMnvjctVsdshf1ZBnQCvDxC6poTwgaL3k5
 m21Rl/f6Bit2eIT0kUrZfAfwh/DgSwZwzJwwl+grr5ji0nUqeYhMfWQ0EnnkjAMrz
 A8naQeoRAgOBAdn5kLC9Qizhc/AN1yzR+qnDMWXD1jQ5jnb8RsqSCg58wXrKnTcP7
 mbCn8rBvORpmi13Wovf8V+FfLOEB/DVi002iNYvDtLI38qViZK/dXTgpjHYI1O0fz
 b/jpi31B/GcOOJA8WA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fMY-1vUpca0mxG-002fRK; Tue, 25
 Nov 2025 01:18:06 +0100
Message-ID: <e4fcea1e-9374-4049-9453-560a2603cbf9@gmx.de>
Date: Tue, 25 Nov 2025 01:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/jffs2: Make depend on !64BIT
To: Tom Rini <trini@konsulko.com>
References: <20251112211942.1429056-1-trini@konsulko.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251112211942.1429056-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Egkf051L9YV5GumhMxKDo9Z5RkvzzsNV/SsZKUgbnNfdaJ2BVUu
 8EDtbqG+h7TYLEvvIvWibkGS8azi01pGpdrdlBeelhwL196W6D0KHkrMWeBYM2vVExR5DZA
 BR20LrNMf2ZCHdjoaBBHwIHh8jR5h5GNJgfRX6hyDXUCRG5Nb+R+geVMo0VIUQ/j0fWVL8v
 wFu282as4l/n7U6hBtT5w==
UI-OutboundReport: notjunk:1;M01:P0:hVydazHShLQ=;uUUlxlGBBIOkHBVW5og2qTPKIM3
 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
 qIsXOdhp/BH9ImSao=
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

On 11/12/25 22:19, Tom Rini wrote:
> Building this code on 64bit platforms leads to warnings (and so errors
> in CI). Rather than rework the code, as this is a deprecated filesystem,
> don't try and disallow building on 64bit hosts.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Linux has support 64bit ARM boards using the JFFS2 file-system.
The JFFS2 filesystem is actively maintained in Linux.

Using uintptr_t could overcome the warnings.
But it seems that map_sysmem() is needed.

U-Boot seems to have a restriction that the flash memory must be mapped=20
in the low 4 GiB.

Best regards

Heinrich

> ---
>   cmd/Kconfig      | 1 +
>   fs/jffs2/Kconfig | 1 +
>   2 files changed, 2 insertions(+)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 5b9c13d85e76..278c6eaf0f3e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2912,6 +2912,7 @@ config CMD_FS_UUID
>  =20
>   config CMD_JFFS2
>   	bool "jffs2 command"
> +	depends on !64BIT
>   	select FS_JFFS2
>   	help
>   	  Enables commands to support the JFFS2 (Journalling Flash File Syste=
m
> diff --git a/fs/jffs2/Kconfig b/fs/jffs2/Kconfig
> index 3bf01cd03137..dede59ee3362 100644
> --- a/fs/jffs2/Kconfig
> +++ b/fs/jffs2/Kconfig
> @@ -1,5 +1,6 @@
>   config FS_JFFS2
>   	bool "Enable JFFS2 filesystem support"
> +	depends on !64BIT
>   	help
>   	  This provides support for reading images from JFFS2 (Journalling
>   	  Flash File System version 2). JFFS2 is a log-structured file system


