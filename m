Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34305C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 10:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E20C871B1;
	Mon, 25 Dec 2023 11:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kLB4ZkkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A2D87480; Mon, 25 Dec 2023 11:31:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A5286FF4
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 11:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703500299; x=1704105099; i=xypron.glpk@gmx.de;
 bh=tliLEcPoVM0uwu/eOaKy6TqxvNuNMv4oK4zsVqrZdnc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=kLB4ZkkINqClnu14zUSTCv6aV0BJoVIdQkKzsw1YamydraqG+yugvpubTEVA0YZv
 UR4FPJR9XUO/FCZ5CkfR2rEQXCy5vX4fhomckebh+mwFgu7IeFfmtN5Om8QPof13A
 8sX/3hM3Mlc+CzEE7COdgARoe3m4uWvNzkZpGOiR969McBBnXnNJnD993yCXqZFb0
 oxk1bHyI+lATevzoEPlyf2jqwqQhRP6rkw7AfdP4FnMVoP2L4IqX0LyeWdZASzovl
 Lklg9xsNKBH/IcOotHTD8zIX4g/JP9C8sPVoBVMKN3u6H/evZ3pi5UQZAlw6f5zZS
 2oZb4wgF0evYBH+3/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.136] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9UE-1r1HtH0L5w-00s58Z; Mon, 25
 Dec 2023 11:31:39 +0100
Message-ID: <4a113752-6a6a-451e-a142-42fcfb0993a5@gmx.de>
Date: Mon, 25 Dec 2023 11:31:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] efi_loader: create common function to free struct
 efi_disk_obj
Content-Language: en-US
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Takahiro Akashi
 <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
References: <20231225044356.626900-1-masahisa.kojima@linaro.org>
 <20231225044356.626900-4-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231225044356.626900-4-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZcVwkWkzDvxgSv4xJebLGQmm3kMVJys1nl2IyLfW3LgKnE7Upff
 pbIHu05UWpflTYIgk3heoVCRVuZmfThhBCrDOFiQB1X9bQ9QfJzSo0JDhM/5Fex7unaRmEU
 vL/ptBttWcKUMG0dqlYF9agAUSrCNbdIDkjyqb4pYmtu+Z0xGW6PqyT3QftbnV31g3wwtw6
 jNOYgKqB4y4lU+u5MYPpg==
UI-OutboundReport: notjunk:1;M01:P0:93Vr3TU/6tc=;vVVSkLvcfV8Uksvl28CwvHQKPip
 p4xGldTkgb91+b2f9GuP9YYrF6PvmeeAwm612636tFPwVrb0WbL7IfjONorU3IyuK/JGq6jc8
 zni1tO4bjdm1facr1gyrPKmzjV7S0Ax5vCQOmWtZuZWLjwKCDGrKN9kCdNAJr1m+xV3F6VILd
 5zlJVxCma7ObLKfBRs3itSTM0mC/JKbTrpNBIVrBNZmg387jHJByAVWUC9YI5+1aH1VJVd34h
 G1N+0Fdxe2EgFdnuFAT5Sd2RkBhCj0o5cN7TQ2+Y6uI/VgEKESN16xADKKRcqMRIxbPPIQpMI
 ohfTjBFjz63gCXY3tJDRwcRAKRxuU9EqvxOuk8YAJQKSjeYZEVgM5fs/7gqcWw3+aAC2ZkKVO
 uDcZ/a/PMPaxuNo78Qm6ileqbijZ15tr6KtouoZq+QZU18zXukutC+gcIN/soHZs/3wY6P/rH
 06mRUtFJcHQmsJNZbIj/8E6yGbC1gqomO6R2iNpk8iAOlPENRpRa7gGBpMq3gA1LnUaKuXOk4
 cu0y9KT2BprW85CcNygb0+BPn+RVvmrybVCUbArD7J8+Ax8SkGUxdrXb6C0lUGvBT30fYvcBn
 ssdUBfXYgYGbyWh3x+3l+bKMWjsnyKZOgniY1u7e3ulxkIQsvdO1HbD0P/UwkWjY9hhWjEG+d
 wVCKIxF1n35PvP9/0infI6a5lihdizj+3j4c4e0id0kCv/OK4KbYJhbDMME69Ws7jRQmEWxWU
 cgWd1gGz+CMXAAqa2+h1FqIx8jou57BPlvADcGWppRHjHc5jZwVvhrDCFlX5JTTDEBN/15e2S
 s7OgdrCEpvvzIW1822yiG1MRfvtuVd8ckmYolBUe0MlhwxXKorLkv43wFU5NaPu90dEx3V4J7
 SSo5sjT/0QwrSSRhwZdcQzSDRbD8YIGThIDyE6y8TDx5oFXa0ch1P4jMcC/cdXKJmjCJvI5YR
 xPLFwIsPCfZwIummuoqu0PYV6Oc=
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

On 12/25/23 05:43, Masahisa Kojima wrote:
> Current error handling of creating raw disk/partition has
> following issues.
>   - duplicate free for efi handle, efi handle is already freed
>     in efi_delete_handle()

I cannot see where this patch reduces the number of efi_delete_handle()
invocations.

>   - missing free for struct efi_device_path and
>     struct efi_simple_file_system_protocol in some error paths
>
> To address those issue, this commit creates the common function
> to free the struct efi_disk_obj resources and calls it in case
> of error.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   lib/efi_loader/efi_disk.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 415d8601ba..d2ac2fab9b 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -372,6 +372,19 @@ static int efi_fs_exists(struct blk_desc *desc, int=
 part)
>   	return 1;
>   }
>
> +static void efi_disk_free_diskobj(struct efi_disk_obj *diskobj)
> +{
> +	struct efi_device_path *dp =3D NULL;

This NULL value is never used.

> +	struct efi_simple_file_system_protocol *volume =3D NULL;

ditto

> +
> +	dp =3D diskobj->dp;
> +	volume =3D diskobj->volume;
> +
> +	efi_delete_handle(&diskobj->header);

efi_delete_handle() may fail.

> +	efi_free_pool(dp);

The device path may only be freed if it has been uninstalled from the
handle.

> +	free(volume);

The simple file protocol interface may only be freed if it has been
uninstalled from the handle.

> +}
> +
>   /**
>    * efi_disk_add_dev() - create a handle for a partition or disk
>    *
> @@ -529,9 +542,7 @@ static efi_status_t efi_disk_add_dev(
>   	}
>   	return EFI_SUCCESS;
>   error:
> -	efi_delete_handle(&diskobj->header);
> -	free(diskobj->volume);
> -	free(diskobj);
> +	efi_disk_free_diskobj(diskobj);
>   	return ret;
>   }
>
> @@ -570,8 +581,7 @@ static int efi_disk_create_raw(struct udevice *dev, =
efi_handle_t agent_handle)
>   		return ret;
>   	}
>   	if (efi_link_dev(&disk->header, dev)) {
> -		efi_free_pool(disk->dp);
> -		efi_delete_handle(&disk->header);
> +		efi_disk_free_diskobj(disk);
>
>   		return -EINVAL;
>   	}
> @@ -625,8 +635,7 @@ static int efi_disk_create_part(struct udevice *dev,=
 efi_handle_t agent_handle)
>   		return -1;
>   	}
>   	if (efi_link_dev(&disk->header, dev)) {
> -		efi_free_pool(disk->dp);
> -		efi_delete_handle(&disk->header);
> +		efi_disk_free_diskobj(disk);

In efi_disk_add_dev we have opened a protocol interface. We must close
it before removing the partition handle otherwise the disk handle can
never be removed.

To do this all properly we will need to re-implement this code using
proper EFI drivers which expose a driver binding protocol. Please, add a
TODO: comment here that closing the protocol is missing.

Best regards

Heinrich

>
>   		return -1;
>   	}

