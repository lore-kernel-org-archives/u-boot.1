Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D063CC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 01:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7C588262;
	Sat, 30 Mar 2024 02:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IeUJ1Gc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A3B88269; Sat, 30 Mar 2024 02:57:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D484A87D4B
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 02:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711763860; x=1712368660; i=xypron.glpk@gmx.de;
 bh=hJpX5rVj89bpHzIPlkIIvAFmvmbLy/pNzkT8O1m3kMs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=IeUJ1Gc/8/1oGlN+ql2glojNFRGLVnLdW/8yBWR5yLuqJWuG5i84n0/w26GzvW2y
 T89T4bAEqsw1K73EWqystHWJOCuayxB/iBybmg1M7wP8kcbkN7P3uYyRcoQSWkNZu
 fc2as2GZ3+3+ZIY9BvxrNJEY8RX4BCB7xTLkcnb+OmjO9cq09VDnREbwppilrAmdO
 29VIm80TPtafLq82svaJn87UjYG8FNuRkKjrZ4p96m04G2IKOYkcRyfGtBBYXSDKQ
 vEd6gddmWqTt6fNOFdF1qwYu5c3niJ4sUjHn3wUVQUSRoNuyMWpDHhpYNMUFBSZiq
 c8w9tPtwHtcKfXkw1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1rz9Pw0oQC-008nyD; Sat, 30
 Mar 2024 02:57:40 +0100
Message-ID: <08808986-a73a-4bdb-b1ba-5c82999e5bfc@gmx.de>
Date: Sat, 30 Mar 2024 02:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: fix newline in debug message
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>, u-boot@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org
References: <20240329142214.53895-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240329142214.53895-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yrV/Uq6ISy6wn3pS0KGz9tGNYUoceCecZ3Iu7qnOnLQJF8ayrSC
 I0lYY5MYaIsnfnrCNAVX1lxhlPSVXGHLupTTSQG4QP8zY0dDAYaFraEGE5TBYrqRsE6ScaH
 TRenA+6ELJSTfa8+fSxx64LLNrLnoY71gsb62smNrsPCE6v7EMCVkjhc8UEz/yRtrc2xrbK
 SlphZWXUiguAlqB88Z5KA==
UI-OutboundReport: notjunk:1;M01:P0:ejORIpqmtU0=;bMxSL+lfWKOZGNC2TsLxPlKjelI
 vHWoOMhmyIATe0oTwtW4HuUlLhIj75f4162qHNsnXWjtrTj8Dc1lvYiwrwglTkSDXPpUgS9YH
 VDzl7BBe51Xe1P9cDIM+vO/98VZk/1MfyInkFf1X/VuUHLoWHqYdMhYqYhxr6A3Xdza6Qn0Vb
 1VIeVx0EIFHPLY0ScIvKDcX6WgYhqNHznyz6fAHA+wm8s5ZUeMPuD6hvhjZaIUHnfqtakesxW
 2XPgjIq96Og3qu614XqdAR2IUk6FWoHfVxas4atfyvyD+h8w/OPSpD34mp4EthTDxmhaYamYV
 nmIqDhBXs4URbgZmMGUH+2prEWJvyjXxDPm6Nvu11UuX4Y6aT8dfknhWf8SfqSJTSmzmUfg64
 6ZAvkNzpBk5PX0sRTguV55YIofh+4RxIH5IyfHZcaTDkAMiu5kqHyKCWb1zcpB4cSHQiyk6X1
 J46ghCQh94ahz+WwLZ+6asNXIF7IXzq/9B9P9xSYQDnL+d3gMk/T1q0qrvWv9PmOl9Xd45MZF
 IjiwTmeqqMmnX8mEKEHuf8+UX4ztvvP9rV6RkgOsqa7SBaMtAaKbM1yGCmUQPsMAgU6lL2pLS
 tuhgCyKVpzwa8q+WkrWsMOIeuG2Sjp8UbKla4Sxnv4TSF7LZsE7Rk59sxIyInwTN1e8PpQtu3
 jDT2gR71ubThZbd/yQHk/gTdB2jHYqr1jz8TmQ96Ya0VRF9dhoi3BDpmdQ2TUB2+SEw9elmRH
 LiHY0xhgzyVkCyF/EWpsN7bQr85bYZ4TIhSH42mRzKkpcQl4mQw8e3ZmPGdkbusqG7KRLuxCr
 QWG5BdgIWn2oBNfGDAOdi22ysiajWqskS2KcKbrfBVGFc=
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

Thank you for catching this.

%s/fix/add missing/ would make the subject clearer.

We prefer to have a commit message in all patches, e.g.

    Add missing line break to improve readability.

On 3/29/24 15:22, Maxim Moskalets wrote:
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>   lib/rsa/rsa-verify.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
> index 1007b6979a..e1093ce1a4 100644
> --- a/lib/rsa/rsa-verify.c
> +++ b/lib/rsa/rsa-verify.c
> @@ -342,7 +342,7 @@ static int rsa_verify_key(struct image_sign_info *in=
fo,
>   		return -EINVAL;
>   	}
>
> -	debug("Checksum algorithm: %s", checksum->name);
> +	debug("Checksum algorithm: %s\n", checksum->name);
>
>   	/* Sanity check for stack size */
>   	if (sig_len > RSA_MAX_SIG_BITS / 8) {

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
