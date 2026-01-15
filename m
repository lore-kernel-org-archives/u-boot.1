Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7361D41149
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 09:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E716803F5;
	Thu, 15 Jan 2026 10:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r8Y/CMx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0297836A3; Thu, 15 Jan 2026 10:41:47 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B7A80325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 10:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4801bbbdb4aso1445015e9.1
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 01:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768470105; x=1769074905;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oSuqfYRzHk2ixmJsbZ0Lp8y0FQS6xheDw3ciPogWLFM=;
 b=r8Y/CMx+I1Y3wl1Oq95DZTuAdsPRK9XMfG8EKYjCtieN8e1FlTY0Gn/yRNoXw9/j71
 V2EysKfXQvxe9DrXG4QXkJuDsTVHgaue6Ndjdz/jK14AuBSIpMWaAlkIkCW5II9TAq2t
 RSZb8iTY999IiwIAgxpjHtJG1P7eRhL0Nk5cgplg3gF/iwhXwLG45noh3O6YXNuI0+wI
 QJHihFKaFWsw4FsKjrBifsY7vyT51iXsJ10PqCpukaNb/PeIbQfsXUDSmYFIdAyY5mqd
 pHvD9TpPkB8Nnnp2FkKRX6AK+CF9xgz75Ww0mx6nVT9f7UI59eGvPSljT6ZQjCe4vjVs
 KpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768470105; x=1769074905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oSuqfYRzHk2ixmJsbZ0Lp8y0FQS6xheDw3ciPogWLFM=;
 b=Ledc9B97Y8ezsXC3LdWdKGFkdkjlGG+4aMrkE/2fU3q4mIMla9KDC1KQcnEvNcxnPd
 q77+nkqnUtA8WsHT6uCraYq87y+5QCVowOJ5i4K2TFn/hf4B2ZJUYJiiglBvyVScQhbm
 Cbs5kEXSlJIC11R+U+qI8b3FtbI/+S0a2RGuoqzq/SxCIRxHes6xtgW4oMt+Ang0r9x5
 F2MKecCbWvDhIfoji/tKyit3DVSPrigL1ATfFsevVyciA8+AsKwyF0PkZwUJQE4HV+9Z
 N+5uchNN2WHILSx3olLPAtxbe/2eTsORlxh8FDWaFvxmsNcjJ/SHwttGwHb6cH1YLeQ2
 O7hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxfxEA+gwI+EjGfUSJ8hbZJbYq9gVO5fbYWMJET7hJ6wWwfMdCpbxDFFQiLzDGyT9KAfUPPIA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2fJ+9kRvkhVOTAtJHcdd968c236NZWLwGWmHum9wNF7aBJ1M+
 /8lpqUs3ACxGYfNzREmTb8Gf5RscceIgvVuy0d9pOiLn6KqdO46WnpO9RFnmZm5ewss=
X-Gm-Gg: AY/fxX5XTMTgI54ofQxJTzUAAnjutlapGbbNKdsojKzbnsWr0sFalEMfIWzRsa2KqML
 byZiICFxTE0WP068x1p7WrNEkVWUhkla+vWCj3TfKDE2pHJ2MHlL1Sw8n4YW53L7KI7hrWb1Fux
 6vNSDlRA76y/WXOys3aJkm79/TR+jWMwz6SuKF48fFvbgAfIUL1pCEiWa+vwu4rHPnO/JLAvCBc
 7Wyhiybvqfzj4GwUgFC+9vHQo9NmDzJGPtdC5g/ZUpPtLH/9jD4OuFQdnUaO4PMJYH62JwGWed8
 vINWXoMeJIkB2Sfa0QhcA8TbnBd2SY0Kfq0KzzXzj1F3P/9syP18CVEgBjHtDEJAArDwOZU7m58
 hm+ujT5B2ITjPUXd/1yu2tZsfkEANDW0xxiT+KIf5wuIZNxFHkCT+belv5t3PVHsE5aNNIk8SYy
 2LboLz62wnlR7XRqgMR2wdcgbB+wPXc0hYSje8gecRicI/i1EY9ntqJ549Hg==
X-Received: by 2002:a05:600c:3110:b0:47b:deb9:163d with SMTP id
 5b1f17b1804b1-47f428b488fmr24139365e9.7.1768470104766; 
 Thu, 15 Jan 2026 01:41:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860:abb8:cc0c:24e5:51ea?
 ([2a01:e0a:e50:3860:abb8:cc0c:24e5:51ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af6e1b7bsm4809150f8f.34.2026.01.15.01.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 01:41:44 -0800 (PST)
Message-ID: <1004b137-d8e0-491c-9351-2ba3e073fc1d@baylibre.com>
Date: Thu, 15 Jan 2026 10:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] boot: android: Add bootconfig support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Maxime Fournier <mfournier@baylibre.com>,
 Eddie Kovsky <ekovsky@redhat.com>, Casey Connolly
 <casey.connolly@linaro.org>, Guillaume Ranquet
 <ranquet.guillaume@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Jerome Forissier <jerome@forissier.org>
References: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
 <20260112-bootconfig-v5-3-79b242159ac7@baylibre.com>
 <87wm1jdxiy.fsf@kernel.org>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <87wm1jdxiy.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

Le 15/01/2026 à 10:40, Mattijs Korpershoek a écrit :
> Hi Guillaume,
>
> Thank you for the patch.
>
> On Mon, Jan 12, 2026 at 11:55, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:
>
>> For android vendor boot image version 4 bootconfig is mandatory.[1]
>>
>> In the android_image_get_ramdisk function, after copying both vendor and
>> boot ramdisks, we extract all androidboot.* entries from the kernel
>> command line. These entries are added to the bootconfig section.
>> We then update the sizes of the ramdisk and bootconfig.
>> Finally, all androidboot.* entries are removed from the kernel command
>> line.
>>
>> [1] https://source.android.com/docs/core/architecture/partitions/vendor-boot-partitions#bootloader-support
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>> ---
>>   boot/image-android.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 163 insertions(+), 11 deletions(-)
>>
>> diff --git a/boot/image-android.c b/boot/image-android.c
>> index b9e0b3f68b0..c4a0cb138eb 100644
>> --- a/boot/image-android.c
>> +++ b/boot/image-android.c
>> @@ -505,6 +505,166 @@ ulong android_image_get_kcomp(const void *hdr,
>>   		return image_decomp_type(p, sizeof(u32));
>>   }
>>   
>> +/**
>> + * android_boot_append_bootconfig() - Append bootconfig parameters to ramdisk
>> + * @img_data: Pointer to Android image data
>> + * @params: Pointer to boot config parameters to append
>> + * @params_len: Length of boot config parameters
>> + * @ramdisk_dest: Destination address for the merged ramdisk
>> + *
>> + * This function copies the vendor ramdisk, boot ramdisk, and bootconfig to
>> + * the destination. It then appends the provided bootconfig parameters.
>> + *
>> + * Return: Bytes added to the bootconfig on success, negative on error.
>> + */
>> +static long android_boot_append_bootconfig(const struct andr_image_data *img_data,
>> +					   char *params, long params_len,
>> +					   void *ramdisk_dest)
>> +{
>> +	void *vendor_ramdisk_src;
>> +	void *boot_ramdisk_src;
>> +	void *bootconfig_src;
>> +	long bytes_added = 0;
>> +
>> +	/* Map sources */
>> +	vendor_ramdisk_src = map_sysmem(img_data->vendor_ramdisk_ptr,
>> +					img_data->vendor_ramdisk_size);
>> +	boot_ramdisk_src = map_sysmem(img_data->ramdisk_ptr,
>> +				      img_data->boot_ramdisk_size);
>> +
>> +	/* Copy Vendor Ramdisk */
>> +	memcpy(ramdisk_dest, vendor_ramdisk_src, img_data->vendor_ramdisk_size);
>> +
>> +	/* Copy Boot Ramdisk */
>> +	memcpy((char *)ramdisk_dest + img_data->vendor_ramdisk_size,
>> +	       boot_ramdisk_src, img_data->boot_ramdisk_size);
>> +
>> +	/* Copy Bootconfig and Append Params */
>> +	if (img_data->bootconfig_size) {
>> +		bootconfig_src = map_sysmem(img_data->bootconfig_addr,
>> +					    img_data->bootconfig_size);
>> +		memcpy((char *)ramdisk_dest + img_data->vendor_ramdisk_size +
>> +		       img_data->boot_ramdisk_size,
>> +		       bootconfig_src, img_data->bootconfig_size);
>> +		unmap_sysmem(bootconfig_src);
>> +
>> +		if (params && params_len > 1) {
>> +			void *bootconfig_ptr = (char *)ramdisk_dest +
>> +					       img_data->vendor_ramdisk_size +
>> +					       img_data->boot_ramdisk_size;
>> +			bytes_added = add_bootconfig_parameters(params, params_len,
>> +								(ulong)bootconfig_ptr,
>> +								img_data->bootconfig_size);
>> +		}
>> +	}
>> +
>> +	unmap_sysmem(boot_ramdisk_src);
>> +	unmap_sysmem(vendor_ramdisk_src);
>> +
>> +	if (bytes_added < 0)
>> +		return bytes_added;
>> +
>> +	return bytes_added;
>> +}
>> +
>> +/**
>> + * android_image_set_bootconfig() - Extract androidboot.* args and append to bootconfig
>> + * @hdr: Pointer to boot image header
>> + * @vendor_boot_img: Pointer to vendor boot image header
>> + * @ramdisk_addr: Destination address for the merged ramdisk
>> + *
>> + * Return: Size of the bootconfig section (including new params) on success, negative on error.
>> + */
>> +static long android_image_set_bootconfig(const void *hdr,
>> +					 const void *vendor_boot_img,
>> +					 ulong ramdisk_addr)
>> +{
>> +	const char *bootargs = env_get("bootargs");
>> +	char *params = NULL;
>> +	char *new_bootargs = NULL;
>> +	long params_len = 0; /* Renamed from androidboot_params_len */
> What is this comment for? Please drop it. It makes no sense to have a
> comment about a variable name that was in a previous patch version.
>
>> +	struct andr_image_data img_data;
>> +	long ret;
>> +	size_t len;
>> +	const char *src;
>> +	char *bc_dst;
>> +	char *args_dst;
>> +	ulong total_size;
>> +	void *ramdisk_dest;
>> +
>> +	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
>> +		return -EINVAL; /* Use errno */
> same? Use errno? What does it mean?
>
> If you agree that these comments are not useful, I can fix up while applying.
You can thanks again to do this.
Guillaume
>> +
>> +	/* Extract androidboot.* parameters from bootargs */


