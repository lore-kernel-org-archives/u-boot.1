Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FBAD2ECF6
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 22:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22280839D5;
	Mon, 19 Jan 2026 23:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C0gxh2WX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6975D839DF; Mon, 19 Jan 2026 23:40:46 +0100 (CET)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8EF88389A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 23:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2b6f5a9cecaso691429eec.0
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 14:40:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768862442; cv=none;
 d=google.com; s=arc-20240605;
 b=gMy18nFpVNMwaBv7rn04+FtFU8NlFjU2g4GsLkYRsqvGB26bBNiKV3wLb4Zgt5Rc00
 3hem5kpJ7l2bHouw/pOz/Iyr50S/NsGqZbfvRfceWnJMjr4tKCUK4AOUwyW8qMyKcRA+
 uwSUl5l8hpXgO1H2DWSUBrQLrsp7gru2/XzCHYniWaXLF9/0BdKmKMmBl8Oa6uP+Pq2Y
 Jw5O1HTtdT65b8458vHzE8C2K9ogL2JOZ4YEVuyYumb8rXKPvJjaH1rpdFQxDjC3vv7T
 a6+H3bTmFEHzAiSWBhiNFqkQGgj6Vs+R68SIboLse9FfrMp86GiK8Mqlmpfiv5iFOtCQ
 Qm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W/Q/joT/iX7G1m+PIJeRuhc8gLUd/ygOC0xe9qp/WEo=;
 fh=Ewutybw8YU7t+NSfVsOvqMG2pVX3z//lZTKxXXlc2Bc=;
 b=XHFbHRXov9XuCd/QMjBDftl83wYLXahUMUKQuJfgJ+4f5DaGmq1wElZHnfX/rX5jvU
 o0AMdFXe8UkrPyHBaZMf0OBohbEvqm7WecrmA/yqR5Yvzi2G0BMmvmoS+qb9Ijip7LEZ
 drWFm+Kaf93dGuTPTDKraZzaCw27YAXDe5yA88Nwbof8Gl7SID3L6G/GoZzueKQwBbOd
 nWw66nsqXue9izQ9VuBui9cPFTRS/T2jfgT+GnLCYAtdnUFG9LDfJyfpkcEKqW020Eqm
 pxNL38QheskqDtr0KpU78qqfV2FOHJuq0bVpulhdKJLIzpGFMIP6uEufn9sYyYHzAZg2
 0Kdg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768862442; x=1769467242;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/Q/joT/iX7G1m+PIJeRuhc8gLUd/ygOC0xe9qp/WEo=;
 b=C0gxh2WXb5MMTIGrUfIqIV8dXxTPbwG0nGaGcvzaWtSJB+eRcNcmlI7VyPbqvrh0q3
 GaujQ37Q/DyAGt0g2pQmzrzWgF52xNFmRVAf4XRpHfMWh0k/YxmuUktvzi9adX0PzOX6
 WN+tvdV1snRcm7NuvcHdnL+5hIIu28d3PgDzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768862442; x=1769467242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W/Q/joT/iX7G1m+PIJeRuhc8gLUd/ygOC0xe9qp/WEo=;
 b=vkp3P5pc+s4oRR+ETdYNG4407IDVAd+YPcsHVBp+gV2HkpOQUjkTge2qxrg3n5cW8d
 yyDjKW1G2b7vB27VSzgvdpL2Pw63uFmFD+m3ZuNILAegitDHjEYPrspIssEbjKpyMqpQ
 OnO0M9Y3St3ETYly16IpI4S8DebYIRbJGMi5OGxWZgg7zqotKCHbkuZMsCu6U8rV+szt
 i8b0SACof8AFWda+VpLM1nDym0WNWydryg9ye8mgxg2BiWGZJqxwEACbdVWFXwWd4/B/
 Yj3IzH1dVlPDAj8u1I9ZTfblt2Umo5dlmojaRRUOV2zJd26osGzLoqZjydCxAzcAq2Hg
 IMCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2qpe6BJDtAXcs5tvc9EmwiE7hHvi/vFsn3QH7JXfTx6c+Cspbl1nLi9ZqXHBQ2aeaty5Bkcs=@lists.denx.de
X-Gm-Message-State: AOJu0YxRWWrv1bqkrC/gv9ncJRKClavJQtwFIoa8kHSab1x/Czye70ng
 viGu0HZeP7klrxAo88DvIwBpsPlBCSMq9EWE8z0ouKqQJtUUEhRq65+TCzD0IRd1jET4o0qwdGR
 HciI6ncM+4pzXIfa61AqpM9DYssnvyUxu19uX7d09ZA==
X-Gm-Gg: AZuq6aJABnM1qFfhLf+QDyHh7Cu8TgdQCywZ0Utl2UMCDTOgk+df0MwuRw7NxffVh+t
 liNfaPnc9ZNtrA/9laVR6DID7UsSFUl7Gq95Kjaveol/7vzt20cMczwzSgpwTOoloQhN/8kq4yB
 p7SUL0urAnI4+ugWlbzp3FZ0thsjt1wDx/VDz2dZN3aYXRLkt8s3RLX5jGf7BnKTcbEYE9mOdWa
 HOBK0gEFhKyo6vjl+eisWdD4+86IDijk/RTdJreQPURo+9nU6e6j//nZ99KE8XjIBpS/8yCMHon
 /tHCYkU45DNoLF35le1z9QXAtQ==
X-Received: by 2002:a05:693c:2d8a:b0:2ae:5e6b:dc41 with SMTP id
 5a478bee46e88-2b6b3f05f04mr8027941eec.14.1768862441642; Mon, 19 Jan 2026
 14:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
 <20260119223305.3022690-2-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260119223305.3022690-2-mikhail.kshevetskiy@iopsys.eu>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 19 Jan 2026 23:40:29 +0100
X-Gm-Features: AZwV_Qgg0akhkl2xPQ2jBSydRHlKgt2sJoIey6B458F0SIW_bO9EwRvg6A0k3Jk
Message-ID: <CAOf5uwkb+bsXsdt9Wn7a2fJRHXX5mOkMGZxifSTY568rwnq8KA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] disk: part: fix partition search boundaries
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Mike Looijmans <mike.looijmans@topic.nl>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Weijie Gao <weijie.gao@mediatek.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>, 
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Mikhail

On Mon, Jan 19, 2026 at 11:33=E2=80=AFPM Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> GPT disk partition with max available number (ex: /dev/mmcblk128) can't
> be read/write from U-Boot using read/write command. Here is an example:
>
>   =3D> mmc part
>
>   Partition Map for mmc device 0  --   Partition Type: EFI
>
>   Part  Start LBA       End LBA         Name
>         Attributes
>         Type GUID
>         Partition GUID
>   1     0x00001000      0x000013ff      "env1"
>         attrs:  0x0000000000000000
>         type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>         guid:   5452574f-2211-4433-5566-778899aabb02
>   2     0x00001400      0x000017ff      "env2"
>         attrs:  0x0000000000000000
>         type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>         guid:   5452574f-2211-4433-5566-778899aabb03
>   .................
>   8     0x00158000      0x0034bfff      "apps"
>         attrs:  0x0000000000000000
>         type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>         guid:   5452574f-2211-4433-5566-778899aabb09
>   128   0x00000420      0x00000fff      "fip"
>         attrs:  0x0000000000000000
>         type:   c12a7328-f81f-11d2-ba4b-00a0c93ec93b
>         guid:   5452574f-2211-4433-5566-778899aabb01
>
>   =3D> read mmc 0#fip ${loadaddr} 0 4
>   Could not find "fip" partition
>   ** Bad device specification mmc 0#fip **
>   ** Bad device specification mmc 0#fip **
>   Couldn't find partition mmc 0#fip
>
> The error is caused by invalid boundary checks. This patch fixes an
> issue.
>
> Fixes: 43fd4bcefd4e ("disk: part: implement generic function part_get_inf=
o_by_uuid()")
> Fixes: 56670d6fb83f ("disk: part: use common api to lookup part driver")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  disk/part.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/disk/part.c b/disk/part.c
> index 49a0fca6b89..4923dc44593 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -674,7 +674,7 @@ int part_get_info_by_name(struct blk_desc *desc, cons=
t char *name,
>         if (!part_drv)
>                 return -1;
>
> -       for (i =3D 1; i < part_drv->max_entries; i++) {
> +       for (i =3D 1; i <=3D part_drv->max_entries; i++) {
>                 ret =3D part_driver_get_info(part_drv, desc, i, info);
>                 if (ret !=3D 0) {
>                         /* -ENOSYS means no ->get_info method. */
> @@ -709,7 +709,7 @@ int part_get_info_by_uuid(struct blk_desc *desc, cons=
t char *uuid,
>         if (!part_drv)
>                 return -1;
>
> -       for (i =3D 1; i < part_drv->max_entries; i++) {
> +       for (i =3D 1; i <=3D part_drv->max_entries; i++) {
>                 ret =3D part_driver_get_info(part_drv, desc, i, info);
>                 if (ret !=3D 0) {
>                         /* -ENOSYS means no ->get_info method. */
> --

Perfectly agree on the fix but still I prefer to think that things
start from 0 and not from 1 and move up to < part_drv->max_entries.
Do you consider the amount of change needed to make a more common pattern?

Otherwise:

Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>

> 2.51.0
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
