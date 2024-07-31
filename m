Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B19DC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 06:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C1888955;
	Wed, 31 Jul 2024 08:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gPq/Mg2o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314B28890F; Wed, 31 Jul 2024 08:10:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4885387E95
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722406254; x=1723011054; i=xypron.glpk@gmx.de;
 bh=qbrF424AAqSsicWTghLIymx2tql5Kt4qIrJ57XasEZU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gPq/Mg2oEdGJ9alUADeNfrfjEByxe/3L+MUJmmhw5ELTPKYNGnCYmVEG06bw8k0M
 6nvad4xSl+EjxxTQr2pDuRF2u7LVMTw2mLpYOUOyEPpJTrodRsg+b2zQSibRgBK3Q
 4aL8krfVS58HXc1iWn54UdOKMR8tIdEBD2deKKGUEYUgjdLaU1BpJk3Hk/W+aScXt
 R5qR+jbVBh3DZb90ujIMqB0XpEU4eZ+Y8zlSnhX0Jxm5tUXi8Fuqzd/1nETrrsdqr
 uognTMOibGWbEIJA8Qtl1ArWOfZTqaAwWvvULUN4wVae3ZPw7Rbg/+//xDcs0KF6w
 0nZEf1aNFvjCgecVcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1sBTsZ0Eur-00zAQc; Wed, 31
 Jul 2024 08:10:54 +0200
Message-ID: <4e159477-4771-41a0-a497-16f3aa682280@gmx.de>
Date: Wed, 31 Jul 2024 08:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] linux: list: add a function to count list nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UeqfPT4bWCtZgOEOKP3oXD7lHy0WSrgWcN/8KC1f2ISOLycfx3K
 7u0nzpWDRdgJEqPCEzSmB0QyFUMnUlaCoiIlm4HbrlD2nGbcg/3rey0o5KkX9DocWvbLjmZ
 EGxqo5tVKE853Q68SvcY0OJrpznbXR8bN/Zte2HeeKc3anMns2BbSl/QmjG089JjsENG42Q
 FfiIxw1+Nj2O6wE+Lmk9Q==
UI-OutboundReport: notjunk:1;M01:P0:El3q3sgvdvU=;fIyGuvkY0goilha0IPYgf+4CJFx
 KC5f0pdKB5tpGhzPRbf85RpFDLgquSQGwYecEQVvA0lO29TdEdEGSmQ2HrqGWAjNq4o205+/a
 zT9L+DbpzPcLYfGHhw4p0vkQ+jRZzxg0NvIXz48i7XIeQ4MEwDIeeu1+DoC482dNoaGYaMJEC
 DHnmc0uBxawVk//zXhyotXYyb0WaKPPf/1KLnM8VSWVtZbJLXsei+gwBfjMoDMa0sstRflpOq
 gmEWsbCqS/dbksaVZRi9D357GkNbgd3vmcSoqJ8PGD5zAfyLnNXpl/Jp3MbY0FWeBkBMdoWPC
 m5Maqg7auofRQQ37kdaJrDOkIWPKmJVaneyy5e0rE2a4vvj8O6d2hnwVJkGP6GX/NljkjnnSN
 G0JyqfRiG6Uj+pQPJrLFBhTOg4dBno/IbEzoKj/C9fEmRvvtYnPiQwcyPWt+H0T0mi4qMy+ij
 SY5MW6hT7hdQN12+cSMG/vD/x4Wdkv4NHxFEAUmJ/XW1iECcloq6z/1jXTJhojq1yzM4NRqOV
 oF5BKqaiV+cVUq5LKNlEO2YUZK8FbNybaZg7h7TTXVoq1PUeu7RLq1MMRvP045u2dOFM406Fa
 3D7ECt0nEfsayIaWeajeYqH4m9WfCHWY1yhPHLuetLTMHEUsdP1MnjWYjkM0+WOfVPF2H/YiG
 tImbAWfMWKaQ3ExQCbilAK7fDXQAFyuBaegV1NkTjv5/L9lAQhj7XWl2UGMAHlZvSNPbyGJck
 Y6BwIZDOghoy8sj+zIR/wcDo2D17GvvGinFxG8NFhfPt4JPTZjRJ83hMbVb18noXQiV8H6p+3
 Wbd30iQbrDUZexTWLbmbaBvQ==
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

On 7/30/24 13:11, Sughosh Ganu wrote:
> Add a function to count the nodes of a list.

This could function could be used in lot of different code locations:

test/boot/expo.c:707
lib/fwu_updates/fwu_mtd.c:64
lib/efi_loader/efi_memory.c:755
lib/efi_loader/efi_boottime.c:2519
fs/yaffs2/yaffs_guts.c:4460
drivers/mtd/ubi/fastmap.c:589
drivers/mtd/ubi/fastmap.c:586
drivers/core/util.c:18
boot/scene.c:85

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
> Taken from linux 6.11-rc1 tag commit 8400291e289e.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   include/linux/list.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 6910721c00..0f9d939b05 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -547,6 +547,21 @@ static inline void list_splice_tail_init(struct lis=
t_head *list,
>   	     &pos->member !=3D (head);					\
>   	     pos =3D n, n =3D list_entry(n->member.prev, typeof(*n), member))
>
> +/**
> + * list_count_nodes - count nodes in the list
> + * @head:	the head for your list.
> + */
> +static inline size_t list_count_nodes(struct list_head *head)
> +{
> +	struct list_head *pos;
> +	size_t count =3D 0;
> +
> +	list_for_each(pos, head)
> +		count++;
> +
> +	return count;
> +}
> +
>   /*
>    * Double linked lists with a single pointer list head.
>    * Mostly useful for hash tables where the two pointer list head is

