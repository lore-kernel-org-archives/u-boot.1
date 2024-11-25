Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8760AD58D5C
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 15:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3ACF89532;
	Mon, 25 Nov 2024 16:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rkBDXREH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4AD89A42; Mon, 25 Nov 2024 16:00:47 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF296893CF
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 16:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732546823; x=1733151623; i=xypron.glpk@gmx.de;
 bh=eaMwjciySSVo+jTdj6Tni1J2t5/sLeePulhDtdZEu+s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rkBDXREH3G/oDtXgo2VNlmSPZEocJ9RjCuX/3U3kFG+7cDry2dESqisLvI5B47bh
 zLznJWzbABKY90yE1OGcpTVFSWvdD8rH6Zj6DNSuxw4YrVQBoUrJW0nISmYZPozwL
 al9DCkrX0olVazu81zdD/6Mb9BsRZ7fXCUvdSMmKwiI9NoS7X1v6BEqQ6+AD6KYKv
 qo9bFWLAcOpCiuI5lHTWAAS7TOwALbVG22HawGUk/zJR6DMoyYgXrhx8fMAiKVnmn
 3dhtqGws88ZPERvofjoR+o1XMdgBo44qDzgWWVZJ6UKXlSBpPO/nehGpSEkmH3pbd
 H7BrropRurZV76q7pQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1tWIXi0Ywn-015zvu; Mon, 25
 Nov 2024 16:00:23 +0100
Message-ID: <1c9ce568-dea5-4ea6-a85f-7a3df0b9b8f7@gmx.de>
Date: Mon, 25 Nov 2024 16:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/14] efi_loader: device_path: add support for HTTP
 device path
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241125005814.236669-1-adrianox@gmail.com>
 <20241125005814.236669-8-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241125005814.236669-8-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2osqPP+KPXzMvjgEXdZWUuX/8nnZtm5dU4o/UdUPjLoMQ5Jvvbb
 Rq+U3kvEABTnSY2DHMKTtKhFRqN3iE/5waq3MKX90VtKuH7Yj0qoV/r8sA/EUPgbjnajjM5
 UiCMYwXRk5iBPkEY7VObkgk0+Xfw455pGrfOgbQXqf/AHwCxl2FTk5ppoRQrA5CEkvSULMu
 MNjaGJsnTQTAH/CjuNFCg==
UI-OutboundReport: notjunk:1;M01:P0:b8KJ4Y7gwV0=;PDhje51wAbo+QXoVy8snYmld/Hx
 CNOdQu2d8a/A+ZVNMHCALV7xr5IAfRvIZMF0RbFpIWRARhh9SVqrA1z9OpN3gvTrRln8yPkIt
 Z8XNlF37cJtlKZv+dmj3WGprO65BFtcrIU9zq2tNu4vwsNu8aNstftcngWzwcCESczHINPych
 eSP85NpLJNi6A4Z8rl1w+LuYiadA6bA6wUF8QWDO3hkCPNBRSEgGPAw9NjHceHooizvCvArpu
 WPsnsgTmt7ly1h18CjFiZtVhAwq03aP4SzpGrmYle+sPaU4tXk4wAM/nYSL/0ScHLxg8MJwEp
 IpJVoHFECtCPyeCyg1g0gTb2ltg1dH9feIFxvl2yZ2uMFUwf4xonUC1oK9pxh0nUfVmixfSww
 H+foomRig6PKqon3ouuXqKMx6ISAVsDgWYbYmiE1GjW7WwP46Mf7NSYSLAfs4dihWvAi37ulP
 Y8sVuV9AdCkQcVd50NSCRA3ehA5wqfJTcFxymC+EVFViXK9zjuB7Dm7XEoaHl4MVPYO5j9Gn0
 bR8JG6yLoQzHuW+q+CTxX+vzcOkqs/f1zJY57vyFc6F9vhJf/s4aGzzJWcH04QpcZDfS2xZqs
 d4gb3Oz1rz15R9aCdhex+doTZJ8xZNFCKY8pR1cfkvKsDHMKsyYwHSu7WVX/EO6GgPV35e1MH
 igBMs8kMBCv6UORAFrWqvOg/SLHQNgjzZhJObfzXMsACsDU9qJRkhGjj1Wy6+P+jZxER96YOg
 cZSb4VV/SIxOzBaPYsLEqc5LRplu7eITGYURN8Q/XZnktvkOkzLqM596d8LkcB0aLlGGqTFEp
 Ug3I6fjXviSfZ8JpmpCvI9Lfc8qlzqHdQ01aWzV2pGRnffuYNHEHjFMVX9oU6mBWwRsGqBQBR
 gTAuszHZ5cnhsROolXfpUim4ChPAMyGJq6rl9FwxPn5NROO+hKXbIP0cNuPf4TMzXw8aNQWOR
 DejY4WrDkDeN6oOiTvp7xYmgzEenLzL0be1q63hZEvRs15BJnYX3qsxkR+q2k2RZQAMqtCD2b
 ETmShVhY6WclVo7iVTxxZdKLZ3BIWmdMRuu5pKpGuuG2g5KR0ZlvQ4SiMlCeaK3/XbHcRiJ2u
 SmAZo+Zu0V0SHc8aE1k7yjlA2Qh9JV
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

On 25.11.24 01:58, Adriano Cordova wrote:
> Add efi_dp_from_http to form a device path from HTTP. The
> device path is the concatenation of the device path returned
> by efi_dp_from_ipv4 together with an URI node and an END node.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> Changes in v5:
> - Add function description to efi_dp_from_http
> - Check if dp1 is NULL in efi_dp_from_http
> - Use strcat
>
> Changes in v4:
> - Reworked an if-else
>
> Changes in v3:
> - Moved argument checks in efi_dp_from_http to the beginning of the func=
tion
>   include/efi_loader.h             |  1 +
>   lib/efi_loader/efi_device_path.c | 63 ++++++++++++++++++++++++++++++++
>   2 files changed, 64 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 612bc42816..96b204dfc3 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -872,6 +872,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_=
desc *desc, int part);
>   struct efi_device_path *efi_dp_from_file(const struct efi_device_path =
*dp,
>   					 const char *path);
>   struct efi_device_path *efi_dp_from_eth(void);
> +struct efi_device_path *efi_dp_from_http(const char *server);
>   struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
>   					uint64_t start_address,
>   					size_t size);
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index 96e72f72fc..1e512bf0ea 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1017,6 +1017,69 @@ static struct efi_device_path *efi_dp_from_ipv4(s=
truct efi_ipv4_address *ip,
>   	return dp2;
>   }
>
> +/**
> + * efi_dp_from_http() - set device path from http
> + *
> + * Set the device path to an IPv4 path as provided by efi_dp_from_ipv4
> + * concatenated with a device path of subtype DEVICE_PATH_SUB_TYPE_MSG_=
URI,
> + * and an END node.
> + *
> + * @server:	URI of remote server
> + */
> +struct efi_device_path *efi_dp_from_http(const char *server)
> +{
> +	struct efi_device_path *dp1, *dp2;
> +	struct efi_device_path_uri *uridp;
> +	efi_uintn_t uridp_len;
> +	char *pos;
> +	char tmp[128];
> +	struct efi_ipv4_address ip;
> +	struct efi_ipv4_address mask;
> +
> +	if ((server && strlen("http://") + strlen(server) + 1  > sizeof(tmp)) =
||
> +	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> +		return NULL;
> +
> +	efi_net_get_addr(&ip, &mask, NULL);
> +
> +	dp1 =3D efi_dp_from_ipv4(&ip, &mask, NULL);
> +	if (!dp1)
> +		return NULL;
> +
> +	strcpy(tmp, "http://");
> +
> +	if (server) {
> +		strlcat(tmp, server, sizeof(tmp));
> +	}
> +#if !IS_ENABLED(CONFIG_NET_LWIP)
> +	else {
> +		ip_to_string(net_server_ip, tmp + strlen("http://"));
> +	}
> +#endif


To make scripts/checkpatch.pl happy you would have to write:

#if !IS_ENABLED(CONFIG_NET_LWIP)
	} else {
		ip_to_string(net_server_ip, tmp + strlen("http://"));
#endif
	}

Otherwise

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> +
> +	uridp_len =3D sizeof(struct efi_device_path) + strlen(tmp) + 1;
> +	uridp =3D efi_alloc(uridp_len + sizeof(END));
> +	if (!uridp) {
> +		log_err("Out of memory\n");
> +		return NULL;
> +	}
> +	uridp->dp.type =3D DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +	uridp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_URI;
> +	uridp->dp.length =3D uridp_len;
> +	debug("device path: setting uri device path to %s\n", tmp);
> +	memcpy(uridp->uri, tmp, strlen(tmp) + 1);
> +
> +	pos =3D (char *)uridp + uridp_len;
> +	memcpy(pos, &END, sizeof(END));
> +
> +	dp2 =3D efi_dp_concat(dp1, (const struct efi_device_path *)uridp, 0);
> +
> +	efi_free_pool(uridp);
> +	efi_free_pool(dp1);
> +
> +	return dp2;
> +}
> +
>   /* Construct a device-path for memory-mapped image */
>   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>   					uint64_t start_address,

