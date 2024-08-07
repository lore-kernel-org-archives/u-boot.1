Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E96C49EA1
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 01:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D171488B09;
	Wed,  7 Aug 2024 03:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gwZu5fUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D4188B0A; Wed,  7 Aug 2024 03:27:26 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2445C88AE0
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 03:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722994042; x=1723598842; i=xypron.glpk@gmx.de;
 bh=RQoVFGFPpYQ/Jqtcls1TJ+mCm3WMcnc1RiXz/MW+ncY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gwZu5fUNcOr+UIet8vf7DmHhbepakGzoyikReGnewGgyEaH0e4JUzXOfQx96Ywp/
 vMs2PgNhg/amSSzkKCvLe368MRUEUOT56ziasmo1zdNelomwh9WUTpBjTsDB548Yv
 q2kmniLHKkPvilrWYvd3a2np64yby+9kRT5VhQrTPv6m6X64uGk7sKWwe6ppQg7ml
 mGDHeJKyEdL3QEfUVsbdq4dnaeiHLC5Pxh4SXgGGblveusx2RjzsKt0zLONS2Vr5p
 OdcRrnoTEzuO+SThOpR79XyfoUJ6VwEwIP2VDFtYyWDqujVQAhNydrudzH0jHnc/D
 br7wqEKH51E4KggtSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTABZ-1snHfi3V0B-00Ur3t; Wed, 07
 Aug 2024 03:27:21 +0200
Message-ID: <1fbea795-45b2-4226-8eec-50647ce06d32@gmx.de>
Date: Wed, 7 Aug 2024 03:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/39] Revert "bootdev: avoid infinite probe loop"
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tony Dinh <mibodhi@gmail.com>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-32-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240806125850.2316956-32-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZSsd2C0la+hECw2j0yW2ocD7wZDOSV5MnO/04orjVSpA4zKNeCQ
 zlemioPpGn5DcLIMcUBZVQKhgXa9qdPVvo86IQhEXiJWtYArtDUPpVmDADwGTcA1e10i08i
 HeiN7ClAq6eHuwtKeo+Lvsouoz3tPF4FkklUzHV3mTkTFnqpsVX21ijkE0SjEs3bLmvCQe8
 u2w3w3CRgGeRxPuqk3gzQ==
UI-OutboundReport: notjunk:1;M01:P0:E/3E+s/inXk=;Ll9n+5hrF3aqkj8cibNDSieetRC
 cqYFIZEGvBmxmGqeERdzdSPz2XC0OUeLCayRQtVPUJruVtKTGmyK2GDW7oFjYh/IgCkdo1U+A
 6PpP0C2jeNtiwI5DDq8au09zPQMsHrWwxj98tssDQSom1CD+NCeAHWakKEnz4ocKIPGzrngsP
 zWR/E7C4lLNcfJQ2tHBavAwPgELIV3+KWJoRPNq/aY2UfuaZX1WqmLXe/PdfPaR/dXIz3CHRX
 uq4sueLLUnghWRDksVOnKTSEVLpdnaygOeaK+5aQdJHnLOShgxEna41K/OF2C//TQ8yo3Q6HS
 4SQ+BWv2dtas7jL+xwOZYqTe44fRbPbOPatWWpeWl2Avyy6wGiOcSqupoTn6nY4rLv5E9WacY
 M26ykhQnTjjnyO1QfHLapce0NdxQhVooz1CbMhtPpJE4OywGXHovbOwq5spTR0OODS67jWIaq
 0jsE4YF4nsMvUQfYeq3RqSOJTNA0hmsBcf9rzJ+9SCe4fW40sJaAq+Ty2SiLmtwFfeKU0ugu9
 6H8WCu2aqN6/pnPPfmNSg5j7XxcVJD+5VZNSzdtBUHTYCmxjK9Xm4tU5y/MaU4CjssU9lspIj
 k+o1WdOsUuINpmm/GHB3aUVRdaL6icRfF3sXGIuVP/r95mngM6E0dbrpNAuJZt8t+b3yfXWiM
 5bawf9iJVIDBaL78TAO6lesBDMlIbSAe3mmmlz7Cgoj+zQFjL7YLRRFwoH4eoR32Yvifz1Slc
 B+L+E14CH5lMauij8sPMWG5K7Ju5pmrgR7GfzkrGrjNo65v4sdSbAi65QBfYSEgXfW6tDLfWO
 5uQI3jjjzKurdZS3Z/l67rnzqbBl76eEkEU7SUBYXpF1s=
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

On 06.08.24 14:58, Simon Glass wrote:
> This turns out to be insufficient to fix the problem, since when
> bootdev_next_prio() exits, the caller has no idea that this really
> is the end. Nor is it, since there may be other devices which should
> be checked.

Please, describe how the original problem will be addressed.

@Caleb:

Do you have instruction how to reproduce the problem?

>
> The caller iterates which calls iter_incr() which calls
> bootdev_next_prio() again, which finds the same device and the loop
> continues.
>
> We never did create a test for this[1], which makes it hard to be
> sure which problem was fixed.
>
> The original code had the virtual of staying in the loop looking for

%s/virtual/virtue/

Best regards

Heinrich

> a bootdev, so let's go back to that and try to fix this another way.
>
> This reverts commit 9d92c418acfb7576e12e2bd53fed294bb9543724.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   boot/bootdev-uclass.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> index 7c7bba088c9..15a8a3555c6 100644
> --- a/boot/bootdev-uclass.c
> +++ b/boot/bootdev-uclass.c
> @@ -632,7 +632,7 @@ int bootdev_next_label(struct bootflow_iter *iter, s=
truct udevice **devp,
>
>   int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **dev=
p)
>   {
> -	struct udevice *dev =3D *devp, *last_dev =3D NULL;
> +	struct udevice *dev =3D *devp;
>   	bool found;
>   	int ret;
>
> @@ -682,19 +682,9 @@ int bootdev_next_prio(struct bootflow_iter *iter, s=
truct udevice **devp)
>   			}
>   		} else {
>   			ret =3D device_probe(dev);
> -			if (!ret)
> -				last_dev =3D dev;
>   			if (ret) {
> -				log_warning("Device '%s' failed to probe\n",
> +				log_debug("Device '%s' failed to probe\n",
>   					  dev->name);
> -				if (last_dev =3D=3D dev) {
> -					/*
> -					 * We have already tried this device
> -					 * and it failed to probe. Give up.
> -					 */
> -					return log_msg_ret("probe", ret);
> -				}
> -				last_dev =3D dev;
>   				dev =3D NULL;
>   			}
>   		}

