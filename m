Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1B0FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB7184686;
	Tue, 28 Apr 2026 20:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k6cnUu4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27FB28468B; Tue, 28 Apr 2026 20:18:58 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A9E8467F
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so1937315966b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400335; cv=none;
 d=google.com; s=arc-20240605;
 b=Nvs4fsgClEfHXJCIVAcpFJMlSchWcxlSwvAq8vdp4/EwS/9IyxsBAMFvYd2Hs79Lup
 oLOINp4mWx5GPVbjOOM048IWOHxJGcKn+Q2u28W744R64qUaS38funY69YdYTligoHJU
 A4bMDK28Mp+5GvJOJwg1I1Xv8Nms4aSKWYWhSiXQp7rrW/JX4GQHBXbbedRdt6d3Djo/
 buo54FwUhAT/qsZuU5b3A/7Zhhjne8UREdF+OFOCT5G78P7zdZk8WRpxp+CQiYlJhnN6
 TDl1CCEMPm15c9KfROX5qRBF4oGGGiQkbKRDau1LHwJfgAB6peBuK7KItBsrOed6cweG
 3WGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DPl8QXStgdaY/Qx08CT86mKN4XwM83IDIULAxJEdELg=;
 fh=FSZLg1kBZKtmq7hkO96s8J8bywdf/NrVlQg027zGQAY=;
 b=Vn6aE1ZmVfVoJ16nJ5BRpHlFPFy0vdVEgKvEfU/yAf6SZ8A0U/pYLgHBzL8CQjQWo8
 xmISXk2pn3HFm24J29wRrpg4KfWcaYeqS8pV8qKYhh+q+f08ZJexXQPuJ5NVVM/7v4+V
 895YLH98KyWfMI3GlV2rbdDwRWRZvolhqixkll16u8rLCgnI3lTvQ1DnXxZwXf9X1m61
 hq738oTpykC26BEqy2BQ15LZe2bbmj0R4a6ItpszdWRcycNVi4OIqCuH+IN0BiqcUjd+
 WkYI7InjnKSSn2rmQq7MhncbMy40hG45YRRIMGTa3mSQ6vS1l4maisRtUpAPOFMgzYJ7
 W3kQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777400335; x=1778005135; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DPl8QXStgdaY/Qx08CT86mKN4XwM83IDIULAxJEdELg=;
 b=k6cnUu4QvP9C6dzgebmATjnS2t/3oV4s5SfkfHqnnnH7Du3UeL8dX4e0BX7jzg4mwt
 cG5L0BvAQhfNmuAuXmXH22CKziDEOVyN/+7YK+Vk4yfoM40UQM7wb4GEjeGnkBHRnQ8d
 PVHFODj9i9ijkpEeSfXoC75jTAm1BskdbJe10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400335; x=1778005135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPl8QXStgdaY/Qx08CT86mKN4XwM83IDIULAxJEdELg=;
 b=TB4W9vqpPscbFFskc/yRc+fOCpsYSaDYsqYk0w7NAkuRAkZ+PK+J6UIvDmdqZMeRI4
 b6dJ/ZhiMzf0t5nGRd3Eg9unklvVY+psjygospuJFMSruDRsPSuvl50axOZ4SUeVJ2I6
 J5ueFXmhOCjYjpfbXwn0i6VLAOy7RTpbSueRyqqQQ0rhDfZ8tKHQ9CQqA57JzsLybqq3
 yapVsLdE1ejwmgHL6yCC1ime4WkxRBRIMNbdHglyFlo2+NPqaV/9LPf0M/leRmJkE4nZ
 dg+kdi62TWFeBBh3aJofL1DahkBnjtEVMKCBrwLmFO5DAbhKBiMgrB7qOWkwnV4kZ73l
 lTog==
X-Gm-Message-State: AOJu0YzXhvjc+YKWba7FpxKH4hh2Qp3nDjbMpvs/CNnbXSb31I29Wokx
 KxS0upXg6YxWV5RPCcM2vve2O/45JxwxmwNFgg7g+4Icem63wNehoEIc2TMYe/7ztUtCFQi04uv
 wM2ynt9bYGihupOoH1fGigQRJYzqjnZs6sTB73049
X-Gm-Gg: AeBDieu1/iTFPvu1YHL0/1Idl6075sHjoN085re7AceVh6MhzQ27abnJVuHlaKyUBVI
 09hShtn8KdUncrX4tekMN56hghxY5g13WyrwUzs7NFDNFB+zQjo1Z3huFKd6BiMEF2MDIOTLU1j
 xKtmbgovyDR4bMDuke9+wvHDO0xjDEvTHMCNlGLBLJBHt23X0OqFT/CmSnZdEF+mfvr0WplAsvw
 wVm3S0GBjp8Y5aSJ/8sYxjNSGM0Ciz+SyGPF3c3S5r3AkHwfEn8YsqOo4Yi7iGKnJYJymb80Xqt
 /hl6fIFqS4a/Ggoc
X-Received: by 2002:a17:907:e146:b0:bac:6d85:255c with SMTP id
 a640c23a62f3a-bb801bce7d6mr176655966b.21.1777400334809; Tue, 28 Apr 2026
 11:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
 <20260427-fb_gpt-v2-1-9e7fe3c1649a@oss.qualcomm.com>
In-Reply-To: <20260427-fb_gpt-v2-1-9e7fe3c1649a@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:18:42 -0600
X-Gm-Features: AVHnY4If9Cs7KEYoc175YfIk6wqZmbNHZBSvc_kxvbPcbLgraIquDcClKH89xbo
Message-ID: <CAFLszTjRoWbfF2tTt8zzsu6UdWU9fkHzn24WZ8LgDx8Nn+hzyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fastboot: block: Add device selection syntax
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Balaji,

On 2026-04-27T12:06:41, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> fastboot: block: Add device selection syntax
>
> Implement device selection syntax allowing users to specify the
> target block device using 'N:partition' format, where N is the
> device number. When no device is specified, the default from
> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID is used.
>
> Modify fastboot_block_get_part_info() to use the new parsing
> function, enabling operations like "fastboot flash 0:boot boot.img"
> to write to specific devices while maintaining backward compatibility
> with the existing "fastboot flash boot boot.img" syntax.
>
> Example usage:
>   fastboot flash 0:boot boot.img      # Flash to device 0
>   fastboot flash 1:system system.img  # Flash to device 1
>   fastboot flash boot boot.img        # Use default device
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> drivers/fastboot/fb_block.c | 53 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 4 deletions(-)

> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> @@ -133,25 +172,31 @@ int fastboot_block_get_part_info(const char *part_name,
>       *dev_desc = blk_get_dev(interface, device);
> -     if (!dev_desc) {
> +     if (!*dev_desc) {
>               fastboot_fail("no such device", response);
>               return -ENODEV;
>       }

This is a real bug fix - the old test could never fail since dev_desc
is the address of a local pointer - but it is unrelated to the
device-selection syntax. Please split it into its own patch at the
start of the series so it is easy to backport.

> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> @@ -124,6 +125,44 @@ static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
> +     /* Override if device:partition format detected */
> +     if (colon_pos && colon_pos > part_name) {
> +             *device = simple_strtoul(part_name, NULL, 10);

simple_strtoul() with a NULL endp silently accepts anything -
'foo:boot' parses as device 0 and quietly writes to the default
device, which is exactly the surprise the new syntax is meant to
avoid. Please pass an endp and reject input where the consumed length
doesn't reach colon_pos, so a malformed prefix becomes -EINVAL.
dectoul() is preferred over simple_strtoul(..., 10) in new code.

> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> @@ -124,6 +125,44 @@ static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
> +static int parse_device_partition(const char *part_name, int *device,
> +                               const char **partition_name)

U-Boot already uses dev:partnum for partition numbers
(part_get_info_by_dev_and_name_or_num() - '0:1' means device 0,
partition 1) and dev#partname for names. Reusing ':' for a name lookup
means '0:1' becomes ambiguous on boards that label partitions
numerically. How about '#' instead, to match the rest of the disk
layer?

> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> @@ -124,6 +125,44 @@ static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
> + * @partition_name: Output partition name pointer (can be NULL)

Just to clarify, the kernel-doc says partition_name can be NULL but
every caller in this patch passes non-NULL - the NULL handling only
becomes useful in patch 3, so please move it to the patch that needs
it, so each patch is self-contained.

Regards,
Simon
