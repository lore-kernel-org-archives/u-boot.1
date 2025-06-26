Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96929C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 15:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C8A82DA1;
	Thu, 26 Jun 2025 17:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tJnltWQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E602682E08; Thu, 26 Jun 2025 17:46:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F3182063
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 17:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750952806; x=1751557606; i=xypron.glpk@gmx.de;
 bh=INS/8uszbe0XZsEfxp1JPcNauqnEQITKANISGc8SK/M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tJnltWQ+N0iO2SvSIujg23welksmNWqnoxGSx+NdV+jHoY+zUFsPPOPiHGmwHkB4
 Y2wK2oYmupqtwFEAz0H3KXWZBnLqdQ0IynN9gVvhTMj2T6LK9VIetCR00/rIRZKhA
 AxGwcco+xhDlxmlwdH2HhsWE27i52qEl2Dgs45cwbqkuCf/sBLRXb76fluvL2/pvP
 X7EkTXPBqkgk5ALukjp9fBLrJvURYPM2PeKK0ISo6mVrOD5r4tFZ0nxvUaBDAJebV
 vfy8q2S0KMOCeWi+bQGJzKXZvUNkOCmYm63y0n6AYLwkE35R0RD0fUm31xNEGWWwx
 l8UroBLrmlWjjjJbGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([46.114.111.195]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBlxW-1uaHNp3EbM-00ApIQ; Thu, 26
 Jun 2025 17:46:45 +0200
Message-ID: <361cddab-cf64-4a77-84b1-4852880aa229@gmx.de>
Date: Thu, 26 Jun 2025 17:46:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: ufetch: Initialise size before first use
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250626-ufetch_fix-v1-1-025afdb85dc2@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250626-ufetch_fix-v1-1-025afdb85dc2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oIBHVJB77Q+uY2glUqLL3zduuu4h08IXJrvrHpf8X9kiFQUxqFL
 TGXfO91shQI8WF+EK9GBQKUJ6EojQUbqVzM9v4VB+nz264roccZnGNwpjmoXOZPsjjhVEEc
 mvEJIbfVofbTuRStzoycVh0/dPiw9DA+6qhAYgil5n6xqM1jjMK4Xik1z5C2Y18eJbDa/NP
 mFH2Wtx7wQKSnQJEJA6IQ==
UI-OutboundReport: notjunk:1;M01:P0:2xfYxfK0UMQ=;Y/3rRvnxsjpe2SpgrtvEjzPN/ab
 +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
 wrLIZLGtmclkBixcQEUGhsYp6CqFBI/Y=
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

On 26.06.25 16:12, Andrew Goodbody wrote:
> The local variable size is not assigned to before it is used
> for the first time. Correct this.
>=20
> This issue was found by Smatch.
>=20
> Fixes: 86d462c05d57 (cmd: add a fetch utility)
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   cmd/ufetch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> index 46bd16824e6..bc5db08eee1 100644
> --- a/cmd/ufetch.c
> +++ b/cmd/ufetch.c
> @@ -93,7 +93,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, =
int argc,
>   	const char *model, *compatible;
>   	char *ipaddr;
>   	int n_cmds, n_cpus =3D 0, compatlen;
> -	size_t size;
> +	size_t size =3D 0;
>   	ofnode np;
>   	bool skip_ascii =3D false;
>  =20
>=20
> ---
> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
> change-id: 20250626-ufetch_fix-54b741710142
>=20
> Best regards,

