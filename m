Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2804E7719E
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 07:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B2A80141;
	Mon, 13 Jan 2025 08:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Xbzn+1Sr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB4D78007D; Mon, 13 Jan 2025 08:37:06 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7C518007D
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 08:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736753824; x=1737358624; i=xypron.glpk@gmx.de;
 bh=r66n1Vq6Tg1gD9DXAyRrPt5vMEg604RSj2QFcknvGHM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Xbzn+1SrG1CgCqbMUORH6r0iJXZL2f+1QQmRetiT4j7otNEjNhytH4IC7rKhBG/U
 cL7S9jp3aIl2MfpQdfSypvarNiDhNtvsypc+62O2eCrv//pBTItR/+6PcRymqH+J3
 HLKQ0HW1Dd55pLlLUbGRBq1QcQWn+ZK0Dlls91fvcoyRE/zWi1YAennf0Kg0YNYrH
 SX5p24c/VPx7Aftcq6pgSxfzwWT+HkF0go3qdRD2fsAziLtwCzfOivGhjasyiC1eP
 skZBHfiaggTjO/dQz1bKDgr8esAByRCJ6SZdzI3BI7gGWS/Tv7XBNXQN0ciiZpCAy
 r5yOpqiH/cHQUB/59g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95iH-1tSPlX1PN9-00wQb8; Mon, 13
 Jan 2025 08:37:04 +0100
Message-ID: <420bb6ae-adf3-41ba-a6a7-1553a1eabf81@gmx.de>
Date: Mon, 13 Jan 2025 08:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] bootstd: Fix memleak on errors in
 bootmeth_setup_iter_order()
To: Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-2-semen.protsenko@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250112034213.13153-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4WxLB0yuRB+oubVHvXViv2Jsb6yaxhRdzd5EwWuikYJP/f4rUo9
 8/KgTS4gsfQzPsAkFVAa9raRWorrYbLhE7LTBS5/zP71hVqRPvzJF3vtpp+UV1pIMQgdsSJ
 cH6ecFGCjYjt1L+E2NkwbMrwgs3ryXicwgc4EFlb4TU7s552/C5uApROiott/MqjC+pLcpD
 QUwrvnI69hcX0gZriE7kw==
UI-OutboundReport: notjunk:1;M01:P0:bAq6TemnCaM=;tt6yRAqc30NrWNU7LVAPnhHPn69
 lv1ct0BQXzvW7pVZzbn+0TC/V4OOY596794KGb6TtMr1ajvW5WgvaVW3EI5IhFd7NjLBjVs/+
 AmaWOHMj7Aw8I+b3zuboB2orhCZiawNLBppB8k/PWy/jvdn1nvjmVLO4ed+VG9vObNBkoUftt
 SfL/Yk/epI1moKn4wYdJ4GjXx3XdubVQpl6LxnKVzGj0VWVRf+UaMo3/cuCjq9+Ew+K9Zy/VZ
 f2/k/ku5j3TPZM+Q5Zr6gh006N5zMl6NkWsdMR0ZjcH9feyHhGDg+u3yCN+UHnoM99rv+FPL+
 9yKpqE1DLv38qAOryjCootHAw5hWcHWdPJKvDr89gB6idy4TWoktbl//1tYKlxvnxuSMRarTD
 Y+jnx7lZHxYJEybE+YmToX1MQ3vS1YDIf9g4BfACcnGkpcndUXQ/wY/qU8FR9wyvdYwwdFUxL
 vyMgWGDHFE7OiR14YgBFp3Sj+qmXng21M2Y9BMwQJE6I2SACnDjt+qg0xJbYutzzADu8psIGW
 MotqD0r+iRg38hGTmSNBAokxlM4AEaHBWQYoj9doN6t/HYU5HeNyxkKlIlEmi4G8jiA9f+LMQ
 1u5dlVnr91gCH78S7jxycgswiCzFajeRAkludd33OGz0ccvf6sRZ0C4Otl59T8jpkQ4YuN8+Q
 8daPYqj6CD0lEkD1WPt8AJINQqPjABsBzdbvDBhy30PRiGQOLFy02mWEdRT5FApiznFE9N4lE
 wkAwEEEMIjjQhTwmMZxgGx62RKwqUoAZXc0nQpOt6Snpc/XhL6Hsta95k6T3O65+J1+AugNLE
 lgII7yzxPKCjhX+4jKeRRtUwKKZ0ManxZoPav+23n20+Z0s61fzCLgjtTQACmePElKV5TtOBi
 3srFRPFEaf4s8aYuHsLcwzY0njGWZXZOXPXHW/5fJivLGbUTifT8HbJ0dlu/3tP7FBjNkZz5Q
 9LBAEN0lj9KzjRcLKSmRgxyolJ+RoaqQDNVKEM36RWvkA7Rl0r9jnIwdsGRH+atR2Xl1n8mUy
 jMJrkduIkDf26kAoFPgWvgJap976Fitehc0GKBiIq1OryUOfQ53mY8/O1qFTfFhuOFFulI25W
 hDfX3J6EZnXJ13KPyOlWy9b998wF6V
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

On 1/12/25 04:42, Sam Protsenko wrote:
> Free memory allocated for 'order' (array of bootmeths) on error paths in
> bootmeth_setup_iter_order() function.
>
> Fixes: c627cfc14c08 ("bootstd: Allow scanning for global bootmeths separ=
ately")
> Fixes: 10d16faa436c ("bootstd: Detect empty bootmeth")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>   boot/bootmeth-uclass.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
> index 5b5fea39b3b3..ff36da78d5a1 100644
> --- a/boot/bootmeth-uclass.c
> +++ b/boot/bootmeth-uclass.c
> @@ -133,8 +133,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter =
*iter, bool include_global)
>   		 * We don't support skipping global bootmeths. Instead, the user
>   		 * should omit them from the ordering
>   		 */
> -		if (!include_global)
> -			return log_msg_ret("glob", -EPERM);
> +		if (!include_global) {
> +			ret =3D log_msg_ret("glob", -EPERM);
> +			goto err_order;
> +		}
>   		memcpy(order, std->bootmeth_order,
>   		       count * sizeof(struct bootmeth *));
>
> @@ -188,8 +190,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter =
*iter, bool include_global)
>   		}
>   		count =3D upto;
>   	}
> -	if (!count)
> -		return log_msg_ret("count2", -ENOENT);
> +	if (!count) {
> +		ret =3D log_msg_ret("count2", -ENOENT);
> +		goto err_order;
> +	}
>
>   	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && include_global &&
>   	    iter->first_glob_method !=3D -1 && iter->first_glob_method !=3D c=
ount) {
> @@ -200,6 +204,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter =
*iter, bool include_global)
>   	iter->num_methods =3D count;
>
>   	return 0;
> +
> +err_order:
> +	free(order);
> +	return ret;
>   }
>
>   int bootmeth_set_order(const char *order_str)

bootmeth_setup_iter_order() is called when the `boot scan` command is
executed. The command can be executed multiple times, shouldn't we free
iter->method_order before reassigning it? Hopefully the field is NULL if
not initialized.

Best regards

Heinrich

