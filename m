Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEC1CD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 08:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A156180087;
	Thu, 11 Jun 2026 10:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NI59k9xz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99D6A839A8; Thu, 11 Jun 2026 10:09:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F8080086
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781165362; x=1781770162; i=xypron.glpk@gmx.de;
 bh=5TMPoJXZuVGqgoUfU93zCQ5q1z98tYlIqhWdrH9ty3U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NI59k9xzzx0DAq8EMy1WIRO6dkBO/5hBabhDUWuRUzzDGTiIoYb8s1jh31DPk32U
 BKGLCJjk0iwhAh/6WCGSitekghlAlUsNdXSq9K7+FFYNgZO/qVYEG465W40u83fQJ
 I7AOk1BFwyBmLI7qjn+0rvVIwIss86YTQvhcVInDoKX7XxWKpNhxkIgRRYmazYeC4
 rIguP9CQNDJOQfNRe2Wa1RTThb8Dkdh9Gp51nmJowJH4Ye96qOLA6T+g8PId1FJ/3
 3ZiuKnhuA/Dke5x0rzx8kOVndTllQ06nxu2irhPVePy78KirKc3zY1algR8k/NdaY
 nMxdzJepVsItFWIx6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5G9n-1xGzO308eL-011nXu; Thu, 11
 Jun 2026 10:09:22 +0200
Message-ID: <b3762374-45b7-496c-acb3-42c60f7e0590@gmx.de>
Date: Thu, 11 Jun 2026 10:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] bootdev: fix typos
To: dmukhin@ford.com
Cc: sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de
References: <20260611014843.3735672-1-dmukhin@ford.com>
 <20260611014843.3735672-2-dmukhin@ford.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260611014843.3735672-2-dmukhin@ford.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tMixHnS5Gyx20nD8Ajk0AWJefUvfNdbkUitIifq0Z8rW/Scyr5A
 p/SjJPdWmWX4OeOb1Cz8qD2zaMXADwwjScfwDfDRtrEIMwbHzZtPuevG44OvgpgM4S5XGOV
 qbq3KUuAUzBz81N5aQWjUSq7AVT/AkOvroDZrn6SpiC8y4kNV0Nn+ZGdIsZMvysYqq0m3PH
 FvXsN7JznrytArPdwYjuQ==
UI-OutboundReport: notjunk:1;M01:P0:vpR6JJX97sw=;Vq4+gpS8koa0A06+jkrIDbyZ9RL
 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
 Ko7wSFSnNkrrrk4Yb64UC+XtGYA=
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

On 6/11/26 03:48, dmukhin@ford.com wrote:
> From: Denis Mukhin <dmukhin@ford.com>
>=20
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>

Thanks for fixing the typos.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   include/bootdev.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/bootdev.h b/include/bootdev.h
> index 12c90c4ec1ba..14f8a98633b3 100644
> --- a/include/bootdev.h
> +++ b/include/bootdev.h
> @@ -30,10 +30,10 @@ struct udevice;
>    * generally very quick to access, e.g. less than 100ms
>    * @BOOTDEVP_3_INTERNAL_SLOW: Internal devices which don't need scanni=
ng but
>    * take a significant fraction of a second to access
> - * @BOOTDEVP_4_SCAN_FAST: Extenal devices which need scanning or bus
> + * @BOOTDEVP_4_SCAN_FAST: External devices which need scanning or bus
>    * enumeration to find, but this enumeration happens quickly, typicall=
y under
>    * 100ms
> - * @BOOTDEVP_5_SCAN_SLOW: Extenal devices which need scanning or bus
> + * @BOOTDEVP_5_SCAN_SLOW: External devices which need scanning or bus
>    * enumeration to find. The enumeration takes significant fraction of =
a second
>    * to complete
>    * @BOOTDEVP_6_NET_BASE: Basic network devices which are quickly and e=
asily
> @@ -327,7 +327,7 @@ int bootdev_hunt_and_find_by_label(const char *label=
, struct udevice **devp,
>    * Bootdev scanners are used as needed. For example a label "mmc1" res=
ults in
>    * running the "mmc" bootdrv.
>    *
> - * @iter: Interation info, containing iter->cur_label
> + * @iter: Iteration info, containing iter->cur_label
>    * @devp: New bootdev found, if any was found
>    * @method_flagsp: If non-NULL, returns any flags implied by the label
>    * (enum bootflow_meth_flags_t), 0 if none
> @@ -342,7 +342,7 @@ int bootdev_next_label(struct bootflow_iter *iter, s=
truct udevice **devp,
>    * This moves @devp to the next bootdev with the current priority. If =
there is
>    * none, then it moves to the next priority and scans for new bootdevs=
 there.
>    *
> - * @iter: Interation info, containing iter->cur_prio
> + * @iter: Iteration info, containing iter->cur_prio
>    * @devp: On entry this is the previous bootdev that was considered. O=
n exit
>    *	this is the new bootdev, if any was found
>    * Returns 0 on success (*devp is updated), -ENODEV if there are no mo=
re

