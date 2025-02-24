Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26933C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 09:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85EC880079;
	Mon, 24 Feb 2025 10:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="a70P6ycO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADB2805C3; Mon, 24 Feb 2025 10:17:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B29680017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 10:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740388654; x=1740993454; i=xypron.glpk@gmx.de;
 bh=F6CPjawswveIAhHVyv/tnbm40R6wKB6Su866PyzMH50=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=a70P6ycOj92oRUrIkkGbPcuIQX5yY4F6ydycyyfaFJnH+DwhcaHKer0T/XOa3Ph+
 ggU0g4SP3k0j1DEHfMjVd/arle/LR7+mdnJJ0DbmDz2EdF7aW0JxoYcxGanR/kQNd
 Skl3FHqkCG5xLh4MouWaye3+DB2MOggk0+R55gY/yPXMDiHxHVJMjHhQ1gE3TprHp
 tSwODmCIFz1CIaTP/FwJGGG9QzpOfrZXqmTCv4HZivli2GhfGGYeEvHxwF0KbqbXz
 OqLpTtaUD6MdSFqy0Oj/MGuHmUbzMo7fm/eReSnmgepmE8lidpuU0cIVUDH5an140
 Wqik0h9yErvpyEi1zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVN6t-1tv3Zy37p9-00O9Bc; Mon, 24
 Feb 2025 10:17:33 +0100
Message-ID: <e92dcfb1-c1c4-41f2-9a98-b710cfee5170@gmx.de>
Date: Mon, 24 Feb 2025 10:17:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] makefile: Fix symbol typo in binary_size_check
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-12-CFSworks@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250224055524.1334929-12-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8QSzD9qBGcrlPsm+AkjzZKerDP5vHVH+PRBdz5ee1NbeUJxjRm2
 +2umcvdUE8FfqTUyZ4Gqm9/n3wU2G9kdEhXzipbFk37IZst0dtaP2zTQ6Drl3fYtptzWK7c
 S0v6Jd3/IqVtFKizP9B1eytu0W2uzhx+btb7ZoUtrooDaEqYr58qGizz8kWU1cSLDnXzcrh
 r1S/HAAV1C8Newc0y8EOQ==
UI-OutboundReport: notjunk:1;M01:P0:7sHhc5+ZS3c=;5Xg9yfnr39mS1br8V04JkdrFAIO
 doLseaZJX7iQsBNeoU60mNXNOj5qZ/peD3GbVGOe8xUEzl1U1s2ZBjtNmUF7GGlGSx5C71nel
 JeIatWvIC0T9Qc8vSTcTD9Uq0/YOtfB4jkj4LBHRg+hC5VGNX0Z5uINE/UvJB51SgWMoipLS2
 nCC8lpLUwOC+oNrSsk8d+8WTDftBdVKuEoxGGPoD20ueCGCOKbaMn9G33nJCkitPDk1qVOh2H
 rE5mbEzkjeeIKgc8wjmX62rojIKBjTp9vDWHFn09Bux7q2P1GExcEsIPGIirXubPrZPGtulax
 3zD7x0KN9hDP6HgCsMPeTNMQSe06juGdv3um2qTnrnx7HVZNXM55j6cevAnga+eAdm4mK+h7T
 T3ydU+sDZz3N9SEjGnBaOVqD0bI6uxGhfI6OB8rsGSBzU4YN3NCi3dh9FMs2T6Xbt0KDEj2xY
 wLUacI/3xmuCDGEUv9aLJn8JQUf5Trl4S9PFP7OBs6dd3xdNRHefAZjOoAw3fqFpLSR42Jm+p
 5CXLLKa/ZzgUbHyLXq87mTe/umkp13iKKaN/i6RBDlGGvT5m8yLhi2KZzvpzUgRoEfzv0perN
 gR9dOy7BpT4+UCTHfILarTG+wcCq4Vcnz1EIchS02h0tq9t89mMXvVmYJmmhuf7baYNNaGjX5
 is58+dKB333MP6MV+gFjsD++giR6z/v+cYjob1Vfjyw1Ub/u0q0jOzZKVkcUCumD1dF0wIXGJ
 jjmHzq0OHlTd5Q0s5kGZHKz1dYrQfXlZKx0UuDHx/AswBbg66g3sCdbQ+WZOcPKzejee91HFp
 oJuqWkDVQEga2J4ZBF4sTmmVbVrarIjk32GzLtz8Z7XRCw/rkKuNIyD5OZSISsyd9v2b9J+DX
 ZB3xqh925IKhkFcQDiJeJE+0FkCh/l5FJTPAJCpqQBduuHsiJvF6bH6VlBTqQePZ28u+/Ufca
 Mj1dIjlDOoJ1ecDpz/MSzUIy4+wZ35D3LA1paVUvr05XrzSSrH184ZYfoVPxQSnUNaOGv8hQc
 ejgkNPBPuWF4rznVNVivz0k/vCDXB8TXlWzJYe6okXHw3fUUbmPxFJQ5jt1FIm5TAp7utVVAM
 k8RyUG80I9MmLbyhZfB8i4ZPe33VlI5MZnofcgaHvrjcG3PFnbmITFgDzNtoCfAJ7A+3YuheG
 6sFwEhcU3cNkxoowTkm4HKSe2xjB7svsbzc2IyvWWmjq4zKWoEVlYodZneIm4VerUM9S+GHbE
 gbVyWKvTmNFR1Wb+XksokS71jEEC4+KyN082YkmlojjWtXjpzMrO1vaQ1ZpV1+5k+7+lCIli5
 zIzYo1OZGAjaLqxVsuh7xrwCDl1K1K8KRoyF1Q2DYEEPTynvi9YPhCfJwCvO/tdUBkzvBaZNB
 6pwJlKcHJo/UVAf1C+mkd5byHPyQirNR/DyhTQO06+3egBVNZRqUrF5wGX
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

On 2/24/25 06:55, Sam Edwards wrote:
> The start-of-image marker symbol is `__image_copy_start`; by searching
> for `_image_copy_start` instead, this check can accidentally match
> `_image_copy_start_ofs`.

_image_copy_start_ofs seems to be the only match for
git grep -n '[^_]_image_copy_start'.

Can _image_copy_start_ofs seems ever occur before __image_copy_start?

>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index b32606b69f5..a9194b46ae1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1314,7 +1314,7 @@ binary_size_check: u-boot-nodtb.bin FORCE
>   	@file_size=3D$(shell wc -c u-boot-nodtb.bin | awk '{ print $$1 }') ; =
\
>   	map_size=3D$(shell cat u-boot.map | \
>   		awk ' \
> -			/_image_copy_start/ { start =3D $$1 } \
> +			/__image_copy_start/ { start =3D $$1 } \

Most architectures don't define __image_copy_start so this code looks
broken. Please, provide a solution that works on all architectures.

Best regards

Heinrich

>   			/_image_binary_end/ { end =3D $$1 } \
>   			END { \
>   				if (start !=3D "" && end !=3D "") \

