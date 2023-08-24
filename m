Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D8CC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 06:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A6F86555;
	Thu, 24 Aug 2023 08:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hXiz40DR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A4786551; Thu, 24 Aug 2023 08:57:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6936B86543
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 08:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692860245; x=1693465045; i=xypron.glpk@gmx.de;
 bh=BVms8dds4GNx+M8Id4BnTkA5O4ncil0yJCMAJ7B5kDM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hXiz40DR04mp8LucJWsSSlbeE8q4wRLZERPfq7mUTTlfo+htOfi4NRQnjVjLyXbbwGXQ7kq
 C5CpuGFFmEmvX/FRfr9T4MbhoTF+1mqsYwmFZJVdN8XJRjDI/jfKFv81J+eTli0Gi45wEYSqW
 VEb2H0ZwHvCrfkCNDTrQioKTLxpbCc7Rlvt/xLrrrMZS1Z5iWnoDHb1CRP1jDZiPOxE2hwhFL
 pznZNBwCtaUahNy8rvwdablyE1fzU+MeffmHAqcnWMWKwy8Qu8sJVc97nb32wTkxIHjXTwtDn
 yhpBnrVmvy8LQR41lEzyB3EDpIBBlrtydTFU60S+LpD/sJEop+kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7iCW-1pd3up15zW-014jbt; Thu, 24
 Aug 2023 08:57:25 +0200
Message-ID: <90d33dfc-1085-f402-e428-63b323db152b@gmx.de>
Date: Thu, 24 Aug 2023 08:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] efi_loader: support boot from URI device path
Content-Language: en-US, de-DE
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
 <20230823083721.1318097-3-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230823083721.1318097-3-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HvesJlZRkQPxyYJ4RZ4UvsvBTRJMzb7L6cDp0uIGhIzhAAY+v3r
 +vjDZ1HZ/zflDAsdmX75yMihdzMY/8sGFxTj1XN3LjvyVOxolD5IuZFxYSzkE+cstQWSoXc
 ij8NDN4ponPLZXRb5LWryF4lJZLCg7tnRvEpEBfNr7BU0InR5NiQEBkHvkVFnctv0jbRQXr
 U8/pOTvfql/+zgceZwSqw==
UI-OutboundReport: notjunk:1;M01:P0:ZqIW0D04oXs=;O2PM+i3YUwtASvyOKiDBya60HNT
 YAZcXLnHxggbe5SHr1lgBVxilGtMTD+koTr1rDbJcGa6crNmHsBDtSfk7LN8ikq8WlzshzWtb
 B583h3rOfqaG1ifm9FCvr8J0m42ptVD7/1mPRfOB55U3frKSX+ZXqlco0MJFFQ35AGya13u5n
 YIoAOlNAhsihTyv95VwQCc1OrpDBCMpORYT0TQGBkr9sZkAhdvDa1nD2FghbhW0KZfrA37VDu
 tVG/Lf6z27FxTA/6DbUn65YmHQ9Fr0FXnKggTt9k8pjejfBY7KnJiXtrApmRMa9FRPK7DLU87
 LgwJy+WYCYuClUFmoiial9f1z9cqhz8G2zW9RA/Me48G/veXFvddltiwpiq2CsKxq581k4I3u
 bwRsp/Mws/oXe0gWti/KXkb5qMhBTSHHkSI1SYhu/CXh81Q1HGrZ1fytlJttM/CnWJmVKwkv7
 3I6cqomMwnM01lht7zFwu0caTJwgYP4Uy/NLh9ZJjIJPusRgPq1ZcLP8EW/bl7sP+I03tEwnM
 X0rhD0v47GWIwnJna56j0T0dRBcsFSq4gFRZj/9AQzQZZcZn+vLbz/taTytnfztMOPyiSPBQh
 I8E5u1/yrWqmDUEP9YmCJpp0XvV4aFiRvZ0FRjW6+hA1CPxRMMaX9i0ZfNlT1pkv4USdtEBCA
 zSd/x0CXE3OyQzAAgvIczichoWg79OQh8uOyvWwMSQsRgfUIDAO+scb5twvG7J/2e11pOARA/
 t2zQAj1h16o5e3gY2qKM4fobYHY/zviguc6rAN7eQgemptBtQGuE8e1fDPanEDRfcncxHvzoR
 5heuSX/ipvXz4JuOhU65lMUbGYd5imEx76jRKc2i7/iPraCSCj6LWQY5ud7sLMKBYbLt+9X9Y
 jao9rAOZ6M8tpfJ70wSCR+1lsOlbPCVu+BpDrb7AIWyX0JlPEfq0kJT0FLzeSHwrsDZ+hZuL0
 aY+YU14dbXcNur1VcrdFOZW0KYE=
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

On 8/23/23 10:37, Masahisa Kojima wrote:
> This supports to boot from the URI device path.
> When user selects the URI device path, bootmgr downloads
> the file using wget into the address specified by loadaddr
> env variable.
> If the file is .iso or .img file, mount the image with blkmap
> then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> If the file is .efi file, load and start the downloaded file.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   lib/efi_loader/efi_bootmgr.c | 213 +++++++++++++++++++++++++++++++++++
>   1 file changed, 213 insertions(+)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a40762c74c..8b20f486f2 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -7,10 +7,14 @@
>
>   #define LOG_CATEGORY LOGC_EFI
>
> +#include <blk.h>
> +#include <blkmap.h>
>   #include <common.h>
>   #include <charset.h>
> +#include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> +#include <net.h>
>   #include <efi_default_filename.h>
>   #include <efi_loader.h>
>   #include <efi_variable.h>
> @@ -168,6 +172,209 @@ out:
>   	return ret;
>   }
>
> +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENA=
BLED(CONFIG_CMD_DNS))
> +/**
> + * mount_image() - mount the image
> + *
> + * @lo_label	label of load option
> + * @file_size	file size
> + * @handle:	pointer to handle for newly installed image
> + * Return:	status code
> + */
> +static efi_status_t mount_image(u16 *lo_label, int file_size,
> +				efi_handle_t *handle)
> +{
> +	int err;
> +	efi_status_t ret;
> +	char *label =3D NULL, *p;
> +	lbaint_t blknum;
> +	struct udevice *bm_dev;
> +	efi_handle_t bm_handle;
> +	struct udevice *blk, *partition;
> +	struct efi_handler *handler;
> +	struct efi_device_path *file_path;
> +	struct efi_device_path *device_path;
> +
> +	label =3D efi_alloc(utf16_utf8_strlen(lo_label) + 1);
> +	if (!label)
> +		return EFI_OUT_OF_RESOURCES;
> +
> +	p =3D label;
> +	utf16_utf8_strcpy(&p, lo_label);
> +	err =3D blkmap_create(label, NULL);
> +	if (err) {
> +		log_err("failed to create blkmap\n");
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	bm_dev =3D blkmap_from_label(label);
> +	if (!bm_dev) {
> +		log_err("\"%s\" is not the name of any known blkmap\n", label);
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	blknum =3D file_size / 512; /* TODO: don't use literal value. */

Can't you retrieve the block size from the udevice?

> +	err =3D blkmap_map_pmem(bm_dev, 0, blknum, image_load_addr);
> +	if (err) {
> +		log_err("Unable to map %#llx at block %d : %d\n",
> +			(unsigned long long)image_load_addr, 0, err);
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	log_info("Block %d+0x" LBAF " mapped to %#llx\n", 0, blknum,
> +		 (unsigned long long)image_load_addr);
> +
> +	/* TODO: without calling this, partition devices are not binded. */

%s/binded/bound/

> +	blk_list_part(UCLASS_BLKMAP);

Why would you want to display all BLKMAP devices?
Please, avoid unnecessary output.

> +
> +	/*
> +	 * Search the partition having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> +	 * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.=
EFI).
> +	 */
> +	device_foreach_child(blk, bm_dev)
> +	{

You need to check that blk is of type UCLASS_PARTITION.

What about images that have no partition table but only a file system?

> +		device_foreach_child(partition, blk)
> +		{
> +			if (dev_tag_get_ptr(partition, DM_TAG_EFI,
> +					    (void **)&bm_handle)) {
> +				log_warning("DM_TAG_EFI not found\n");
> +				continue;
> +			}
> +
> +			ret =3D efi_search_protocol(
> +				bm_handle,
> +				&efi_simple_file_system_protocol_guid,
> +				&handler);
> +			if (ret !=3D EFI_SUCCESS)
> +				continue;
> +
> +			ret =3D efi_search_protocol(
> +				bm_handle, &efi_guid_device_path, &handler);
> +			if (ret !=3D EFI_SUCCESS)
> +				continue;
> +
> +			ret =3D efi_protocol_open(handler, (void **)&device_path,
> +						efi_root, NULL,
> +						EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +			if (ret !=3D EFI_SUCCESS)
> +				continue;

Do you expect multiple ESPs? Why not return the error here?

> +
> +			file_path =3D expand_media_path(device_path);
> +			ret =3D EFI_CALL(efi_load_image(true, efi_root, file_path,
> +						      NULL, 0, handle));
> +			efi_free_pool(file_path);
> +			if (ret =3D=3D EFI_SUCCESS)
> +				goto out;

ditto

> +		}
> +	}
> +

ret may not even be initialized at this point!
I would expect EFI_NOT_FOUND to be returned if there is no ESP.

> +out:
> +	efi_free_pool(label);
> +
> +	return ret;
> +}
> +
> +/**
> + * try_load_from_uri_path() - Handle the URI device path
> + *
> + * @uridp:	uri device path
> + * @lo_label	label of load option
> + * @handle:	pointer to handle for newly installed image
> + * Return:	status code
> + */
> +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *=
uridp,
> +					   u16 *lo_label,
> +					   efi_handle_t *handle)
> +{
> +	efi_status_t ret;
> +	int file_size, file_name_len;
> +	char *s, *host_name, *file_name, *str_copy;
> +
> +	/*
> +	 * Download file using wget.
> +	 *
> +	 * URI device path content is like http://www.example.com/sample/test.=
iso.
> +	 * U-Boot wget takes the target uri in this format.
> +	 *  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/sample/test.iso
> +	 * Need to resolve the http server ip address before starting wget.
> +	 */
> +
> +	/* only support "http://" */
> +	if (strncmp(uridp->uri, "http://", 7)) {
> +		log_err("Error: uri must start with http://\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +
> +	str_copy =3D strdup(uridp->uri);
> +	if (!str_copy)
> +		return EFI_OUT_OF_RESOURCES;
> +	s =3D str_copy + strlen("http://");
> +	host_name =3D strsep(&s, "/");

This could be "user:password@example.com".

> +	if (!s) {
> +		log_err("Error: invalied uri, no file path\n");
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	file_name =3D s;
> +	net_dns_resolve =3D host_name;
> +	net_dns_env_var =3D "httpserverip";
> +	if (net_loop(DNS) < 0) {

Why call net_loop(DNS) for an IP address like
[2a00:1450:4001:812::200e] or 142.250.185.206?

> +		log_err("Error: dns lookup of %s failed, check setup\n", net_dns_reso=
lve);
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}

This logic seems not to be EFI related. There should be a network
library function that takes a URL and returns a filled buffer.

> +	s =3D env_get("httpserverip");

Why should this variable be used if host_name is "142.250.185.206"?

If the host name has no DNS entry and is not a valid IP address we
should error out here.

> +	if (!s) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/*
> +	 * WGET requires that "net_boot_file_name" and "image_load_addr" globa=
l
> +	 * variables are properly set in advance.
> +	 */
> +	strlcpy(net_boot_file_name, s, 1024);
> +	strlcat(net_boot_file_name, ":/", 1024); /* append '/' which is remove=
d by strsep() */

On a single IP address you may find multiple servers. Even if there is
only one it may not provide the resource if you don't supply the host name=
.

It would be preferable to adjust wget to comply to RFC 7320 ("Hypertext
Transfer Protocol (HTTP/1.1): Message Syntax and Routing") and provide a
HOST: header.

> +	strlcat(net_boot_file_name, file_name, 1024);
> +	s =3D env_get("loadaddr");
> +	if (!s) {
> +		log_err("Error: loadaddr is not set\n");
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	image_load_addr =3D hextoul(s, NULL);
> +
> +	file_size =3D net_loop(WGET);

This looks insecure.

You must define a maximum file size before trying to download and use
lmb_init_and_reserve() to check that the buffer is available. Otherwise
you might download a large file that overwrites the stack or U-Boot's code=
.

net_loop() must check that the reserved memory size is not exceeded.

> +	if (file_size < 0) {
> +		log_err("Error: downloading file failed\n");
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Identify file type by file extension.
> +	 * If the file extension is ".iso" or ".img", mount it and boot with d=
efault file.
> +	 * If the file is ".efi", load and start the downloaded file.

Please, don't rely on file extensions.

Inspect the buffer using function efi_check_pe() to discover if it is an
EFI binary.

mount_image() should return an error code if the buffer does not contain
a partition table or a file system.

Best regards

Heinrich

> +	 */
> +	file_name_len =3D strlen(net_boot_file_name);
> +	if (!strncmp(&net_boot_file_name[file_name_len - 4], ".iso", 4) ||
> +	    !strncmp(&net_boot_file_name[file_name_len - 4], ".img", 4)) {
> +		ret =3D mount_image(lo_label, file_size, handle);
> +	} else if (!strncmp(&net_boot_file_name[file_name_len - 4], ".efi", 4)=
) {
> +		ret =3D efi_run_image((void *)image_load_addr, file_size);
> +	} else {
> +		log_err("Error: file type is not supported\n");
> +		ret =3D EFI_INVALID_PARAMETER;
> +	}
> +
> +out:
> +	free(str_copy);
> +
> +	return ret;
> +}
> +#endif
> +
>   /**
>    * try_load_entry() - try to load image for boot option
>    *
> @@ -211,6 +418,12 @@ static efi_status_t try_load_entry(u16 n, efi_handl=
e_t *handle,
>   		if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
>   			/* file_path doesn't contain a device path */
>   			ret =3D try_load_from_short_path(lo.file_path, handle);
> +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENA=
BLED(CONFIG_CMD_DNS))
> +		} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> +			ret =3D try_load_from_uri_path(
> +				(struct efi_device_path_uri *)lo.file_path,
> +				lo.label, handle);
> +#endif
>   		} else {
>   			file_path =3D expand_media_path(lo.file_path);
>   			ret =3D EFI_CALL(efi_load_image(true, efi_root, file_path,

