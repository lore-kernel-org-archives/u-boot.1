Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE1BC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 16:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77D8581703;
	Tue,  1 Apr 2025 18:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="e71ZN2Hj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F35C8171B; Tue,  1 Apr 2025 18:30:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C94801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 18:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1743524973; x=1744129773; i=xypron.glpk@gmx.de;
 bh=LvVHKgz/gujk10bUturnewm07ETbBXREEmlLD1cz6Y8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=e71ZN2Hj1s+gBqeazJexmgUvfalDGecNSZ7pH+42OUZjeKdMcXzWGfzGMqvVkiY8
 5HbzAvRUgd2xVM5iyPMG6O4lARtbQTbgRtO17kKU164MxOiXMVkY/HBNLcrsixc2F
 PjzwYG4aWVpw32kDzjH178H8yH14nhpLjqu1k3tOSJa2fhfbPjLsQrSQfSBQK6OH2
 VHv4se3MqXOCgbqOpSC1i1mpjCQohZyh8d54VElpVQ8vSiiynAj+toAzzjwh0UmNW
 uzn/BGggNjVcz8hDwvBKJ6BaQJqd7WKfsj4OgFBPnxq5NB+3Ihe2GnB85Xx7KoDlu
 1/Ink0gIZJxcCXWXeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacSe-1tOx9z2qqo-00fgOw; Tue, 01
 Apr 2025 18:29:33 +0200
Message-ID: <7e90eee8-990d-4f80-b918-a53f1ef30e22@gmx.de>
Date: Tue, 1 Apr 2025 18:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] scsi: Implement get_blk() function
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, joe.hershberger@ni.com, michal.simek@amd.com,
 marek.vasut+renesas@mailbox.org, cniedermaier@dh-electronics.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250401080015.1470999-1-quic_varada@quicinc.com>
 <20250401080015.1470999-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250401080015.1470999-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rw9ZhTcykMf+YwHGSjebNH/S9vLmyUG62NEFsqUEfXFBdYoJEmY
 1f9CxeEZMiIjxL6TDKVWEdsDMzewMvMb7ZK+DKJxG/nQzu/EZ9YiK4ZoAzmxZqf9G1md+N5
 78aZU+mHQHgMwLHAN9qYzgJVEdFHKAVy0KwWCC5BVygyLTkkoMfCu7C5O1hxZkFj2a2LTz2
 XIEGlNk4Rl3Gulb4jApOQ==
UI-OutboundReport: notjunk:1;M01:P0:oB9wDFMNKe0=;JELB/1xqvrx3f9wu3qUi+G0tSpm
 M2JX7B8L/mgiI9j/fyfZLwR4SplyUbkKuHkM9+PblVYHwlHwxAbUqRjb+Exn49Wae/0uu5YRP
 ejNoIxUFVLGNENSZvnwiTJafR6RoCvNtMBZxPAoejqJHzEscXv9xvbRu1Bye5wHGIZ1a1j60I
 4Z7uvkjIuD/IvrMFRGL0ylf5HwOpwKlkPs+x2XrUrJXVoyAgR/h1TXP2H3cqZvDRLj05nQKUZ
 8XXWJ+KqmhTqGEjokZtkZJhA+RqxWf2ArCiMiTGp18z4G99T6vYIb5wGne7YFtVRUt808QkLT
 SgDcNyfSPdE9cTfeINbPEPYoi9BBu28BhnTyAR8xcA2QgkcvG5GKohsFWpbd5VQfLgXsS1LDy
 zrjZIx04j/GRC3kCEul9/tFH6TPVi6GAUvcDZ68vSjkGJ4WnVzKlT/pQyB18775RL61OGtUGS
 nMtls/W8qcxLYDKt4GWax+mcQ4lrzWJvz8DYOk3egasKkgwt6VxL3FIpapMyU0bo4Xo34f1IS
 oA5i3cPmmfNbpIcewqBOL7CTPFB0zuxtsUUQvWCeQ91AY2qavXU0k3XR1lTq49WCqAp9LaXpm
 MixKmsBZKmsoZmeyvAySxsB1X9YIzVBCRmZHN2ZnKuSxfy3CHhFvxnVpDF1Z1nq2vsn35zQwx
 b2LJpdYW/8EN5V+vbRCLvNU7S0p3+MoSgdNPwxmpW/Wp2GDfMyV9WrX0dR6QaeSvGRpbrE3aC
 kQKAdj4T6t+XCDja4N1ZJWXjbqIVWFsoLBaloAUNTUHyu53uDGgA5ruEuw0BWrf5KxwSZjUxL
 tSFr7/ZaO/1g1zqq7Jw6jMfv8beHZYF1GM9i2ik+rW5rgMle4IO6vymNZRlGlNcj0KzVm2vMv
 SW1t/yd7bHD4H3ffoY8MRdpxBLAU1imxWrPoMYru4l2Hc2Zlel7ZMup0nLQYMrJkRPk5+st5E
 Hf8g2soTnLcWwLs6sr4QYI6djr80ihC5ziTcDWJ5VZUCohZmjpBkeTqyM6haQal4C8uLxUA7v
 3/95cYsE6U0yiDiKzdZFKu8858A4Vhhv66LHX5V8YkBtmZqF/+zXtQMj0/Hhnxim4i0949oJC
 5LLFLhsWsEkQQ55GZDnNq67nNCzRmqegEqM93+awUOTOG5JnV5jfptIgUUz9+pgCL0d/FzYr6
 RXCBURSmFlsLUaIvdDKNRAKO2AqYKwpI7veX4z1MrmUNQYJA6N5S2Sy3yDpLb9N5d3oZNwOt3
 bupZrmOC9HehH40pjPGZf8rsnXMxrVFW+Cc2Ujav3KtQNNn/u+5TbQAlKw6MyA3/EfgctecSu
 /aJrUppVp61b/1CQ+c6RNGn/3bqzIhDL6EnfWIz0ad1xY9xpOc2/Yc0wNqqyYftSpllN20WSH
 TiuulQvPLigkYv3BwAa8iwkInXxT9qQlNKOKcxSDPHxJNhk42N1oM7ulhIQhY2fJ3u2LidjHw
 dBFHEx69ZWtM9ydSgTUfzJb70e8c=
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

On 01.04.25 10:00, Varadarajan Narayanan wrote:
> Add a function to obtain the block device for SCSI.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   drivers/scsi/scsi-uclass.c | 30 ++++++++++++++++++++++++++++++
>   include/scsi.h             | 12 ++++++++++++
>   2 files changed, 42 insertions(+)
>
> diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> index 1ee8236c05c..c2e34082bce 100644
> --- a/drivers/scsi/scsi-uclass.c
> +++ b/drivers/scsi/scsi-uclass.c
> @@ -10,7 +10,9 @@
>
>   #define LOG_CATEGORY UCLASS_SCSI
>
> +#include <blk.h>
>   #include <dm.h>
> +#include <part.h>
>   #include <scsi.h>
>
>   int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
> @@ -23,6 +25,34 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *p=
ccb)
>   	return ops->exec(dev, pccb);
>   }
>
> +int scsi_get_blk(const char *partition_name,
> +		 struct blk_desc **blk_desc_ptr,
> +		 struct disk_partition *part_info_ptr)
> +{
> +	static int is_scsi_scanned;
> +	struct blk_desc *blk;
> +	int i, ret;
> +
> +	if (!is_scsi_scanned) {
> +		scsi_scan(false /* no verbose */);
> +		is_scsi_scanned =3D 1;
> +	}
> +
> +	for (i =3D 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
> +		ret =3D blk_get_desc(UCLASS_SCSI, i, &blk);
> +		if (ret)
> +			continue;
> +
> +		ret =3D part_get_info_by_name(blk, partition_name, part_info_ptr);
> +		if (ret > 0) {
> +			*blk_desc_ptr =3D blk;
> +			return 0;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
>   int scsi_bus_reset(struct udevice *dev)
>   {
>   	struct scsi_ops *ops =3D scsi_get_ops(dev);
> diff --git a/include/scsi.h b/include/scsi.h
> index b18ae37b861..1ba55516588 100644
> --- a/include/scsi.h
> +++ b/include/scsi.h
> @@ -9,6 +9,7 @@
>   #include <asm/cache.h>
>   #include <bouncebuf.h>
>   #include <linux/dma-direction.h>
> +#include <part.h>
>
>   struct udevice;
>
> @@ -349,6 +350,17 @@ int scsi_scan(bool verbose);
>    */
>   int scsi_scan_dev(struct udevice *dev, bool verbose);
>
> +/**
> + * scsi_get_blk() - Provides SCSI partition information.
> + *
> + * @partition_name: Partition name for fetching its info

Partition names cannot be expected to be unique.
UUIDs should be.

Best regards

Heinrich

> + * @blk_desc_ptr:   Provides the blk descriptor
> + * @part_info_ptr:  Provides partition info
> + */
> +int scsi_get_blk(const char *partition_name,
> +		 struct blk_desc **blk_desc_ptr,
> +		 struct disk_partition *part_info_ptr);
> +
>   #define SCSI_IDENTIFY					0xC0  /* not used */
>
>   /* Hardware errors  */

