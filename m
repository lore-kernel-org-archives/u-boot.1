Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD3BC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 05:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ECBC886A0;
	Tue, 23 Jul 2024 07:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="b5mBoyUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1DC3886FC; Tue, 23 Jul 2024 07:40:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B84D888681
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 07:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721713209; x=1722318009; i=xypron.glpk@gmx.de;
 bh=Vyb+niZTB2eSMMCCdkdVzvV5jueXffIYf88CN70SglY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=b5mBoyUCzZO3Wv4he8Ueq4d8KdiSGDMlWaWXB3LOi0D1c7UHekTMo9qBrLaZF1NS
 FcTtJXQzzo5nZ+6c9u0qmTZ8FcJzlAkCyvnMRw0LrRBAE3i0WiDur1Thx7/90i2xD
 7L95szQgzooFei/3WiSuJlTyu9zWEIJMen2iTvHToPOMa4ghaSmrnpbg8cgINU0Wd
 duBfO8AZyFbMNzcONyDE0zJabb2xISx7JV4GLzuuaC0mI9u/g7Mfam9KtFeoliC2r
 u+CPn8cjaTOhQQBjseEdnhS0c1+oWwltB7cEs+vmf5I/is6pdZhwJogPslbtr0hee
 9bCJ8ike9L3H+x+ltQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1rzbNW0DQt-00kS65; Tue, 23
 Jul 2024 07:40:09 +0200
Message-ID: <eca1559a-e34e-4951-b94a-215b6ea15bde@gmx.de>
Date: Tue, 23 Jul 2024 07:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: add /dtbs search path
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240722175532.184842-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240722175532.184842-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cc521xUB2ChTxZg0qlIn6EOnXgk+rM07WGRzM8aYNdSso8Z4e8i
 zJlUf9WOQ/earkqlwsjXqlLq0McF1xfOeaFxexK/hH/Gw6vY1g2ik2/Wc9zK8ToGIQeQ1uS
 Wxew6aZ6f/M0QqX8mDK9x90fDwHNKMvMEWmYSeF4LAbtHMRZ1QLRiYYpfZy2LOtpeWcXbJ4
 kjPO2Sd8qp/0a3keRnKnw==
UI-OutboundReport: notjunk:1;M01:P0:f363OeSkSkY=;XIBui/VWkZ3Anu+VkxfFSlSmy6p
 5/NPz4xJfRLJIOBCvFlbFxLqT2YeBwhb0JfLa2b1K4KLawPDGtNpqgc6Jri1TO4yywtG6uPN8
 sO3gD3OnWu8iBsOD4lMVlGrKDSnpHYecstDUhAzqpQMFq9AQpp/E1KD4aXMtgCA06BoCG3ttk
 qBdzIUcjmEMjedHmEFTrVSczjHmq/ItX7N1ggV+6MKRlTy649zHqOrZtl+b2ibE/qwhSpfEKE
 qZoJ2P4Uo7FA7K5/ivnCredMA1GsvXByftGCKAj7hmDsCua4ueG1Ab66LJc0rQGiN6t0yuFsg
 omS49wc0e1+BSmhuWOZhd9AAp0jVV5LTV5aeiuY1kyKtxzoftbTjl9xzckoksRopB+Y6I2XUz
 xHkFN7X3EWvH+IBRmxEvNoPiPQHn5kwJ00vsgpQPvtTH0WrRcuAQXjhTmGmBIAeEXLtl7evQE
 WW3inK+2jFjCc/bEGp1Ib6Uziu5J7RUUZYPbLu2BSqiMd9yQ6q2quZu4A2y8pitCQ6d3MjbMW
 LFr/qh/DXEy+ElDdP4C7AUiobw05wSptaWpGgkThtfShgDCoS6lhRtETGntcdlbgdl5ViMaN/
 mMlHgdbf2oVOSndf5hPwh8e4akCVG/Q0h/6gw3y42Powf2zqfSfGgQXHVmXAezP2M5XI7q6tk
 tYRzUPXLV/sGjxrt4fSBJuBF8hrdt5ce5ZFNtrY61vzkkkVIqFXvfHXkOGPYYEJGffovFG90I
 mAS7tUylAs/gkIK1vBe2p4WLvF1iCQiLh7o/htSzAU+pBrnB8DHAyvFhaq2ys7bHQ16hzHLmT
 8YgqfL2G+2tyrKOHY/lAn14Q==
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

On 7/22/24 19:55, Caleb Connolly wrote:
> Add an additional search path /dtbs, this is where dtbs are installed on
> postmarketOS and potentially other distros.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   lib/efi_loader/efi_fdt.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> index 86ba00c2bdd9..4777943b80df 100644
> --- a/lib/efi_loader/efi_fdt.c
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -42,8 +42,11 @@ int efi_get_distro_fdt_name(char *fname, int size, in=
t seq)
>   		break;
>   	case 2:
>   		prefix =3D "/dtb/current";
>   		break;
> +	case 3:
> +		prefix =3D "/dtbs";

Debian's flash-kernel also installs into /dtbs.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +		break;
>   	default:
>   		return log_msg_ret("pref", -EINVAL);
>   	}
>

