Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F02C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 07:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108CC882BB;
	Fri,  5 Apr 2024 09:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dnYIxjvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2899E882BB; Fri,  5 Apr 2024 09:16:33 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE831882B2
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 09:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-343e7c20686so191467f8f.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712301390; x=1712906190;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PgPpVmvLy7Kg0tG3W8WKTYp5GHZkripSEn6iBZes88M=;
 b=dnYIxjvAMnc2od7GvGBMwb5i5jnzfoo0TGkvAc8Yzs3s7j7pCabjcHdqZRCVg/Lv8H
 1b/JWdNlTeDK9qxzX2rkVx2J02lsaHZ6JjEEyfJK89Vg8D7shKnNI3vT6HhB2dzm6qeE
 8YvfJAH95Bsp9dk1hKCVTm3NbNfeVrK9GqP3ZGK1ycFLqqEUo7G6oIWMIEXMi+w+JyTn
 IhgOT9xRb1/qtAPgBUCuKCYufZPnpBynnnIqedKMyrvjU7OBmPQAz9PysbFayXwxLRbh
 XwXTvQvhzJGOTLHBkuHFBhis1kCQKhMFa+xEVjcYjnlnvy4xt6B3vajeF3W40H9Q4KQ8
 z4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712301390; x=1712906190;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PgPpVmvLy7Kg0tG3W8WKTYp5GHZkripSEn6iBZes88M=;
 b=fTi4BxnVw1a4xj8vKrXbhduBSFM+HIqnQTfsEbSsbqY0LnuIxLVCryioVn79iLzeMn
 XevAnGKjGp5oDMKL5b45Ao/SsG+3lo9rbR7eAcaSke/NTE+II0wrAi0x1xrnCjafA17O
 D00PLhUal87L+rAhp6G1KR5XUGp/+zQBYEUkyxweEk076rI3IkIvshozkzxKi6J6uIao
 7sV6Dp2xX9X4etSjYDPYr7vSwhJIOS/wgzURirUWliDwdXBOA/T93dZrIRWPRQPHm41U
 0nDkKeYIDLeadR2RhEdvXqaYbQgfaIlnovniOvQnTZ9k4/2ZtdXD1Ut3c+/zhH6INzZh
 Oj9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI+YUQYYXa1HSTzzrAx+ikYIAUXE5wiCJvjiFiFGkBSrK3mxKyDlVe1ycffVWVeJgaYL5pxzdJou/DrJtkVhVkvG3//g==
X-Gm-Message-State: AOJu0YwhqxKaNy3+ywIMuYz1HcgAU1T1hYPvWE+dNnc0IYm6D/vxMwss
 YkV5iAp24i6jBjT+rhm+UXEaFm8lCys6q6VRPqgG5Zyn3iZjQ2ItLdujBc+R/BU=
X-Google-Smtp-Source: AGHT+IGC040YPKSjonltCAGxgjYeh4JEjEx8Md97EnXzSv9hL9lmxB0TBEILusVT6wNwkLgSwMqmDg==
X-Received: by 2002:a05:6000:b0f:b0:343:97c9:528 with SMTP id
 dj15-20020a0560000b0f00b0034397c90528mr443852wrb.64.1712301390198; 
 Fri, 05 Apr 2024 00:16:30 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 s7-20020adfea87000000b0033e7de97214sm1287674wrm.40.2024.04.05.00.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 00:16:29 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitrii Merkurev <dimorinny@google.com>, u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, Cody
 Schuffelen <schuffelen@google.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, Ying-Chun Liu
 <paul.liu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 1/4] virtio: blk: introduce virtio-block erase support
In-Reply-To: <20240306185921.1854109-1-dimorinny@google.com>
References: <20240306185921.1854109-1-dimorinny@google.com>
Date: Fri, 05 Apr 2024 09:16:28 +0200
Message-ID: <87wmpcffeb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Dmitrii,

Thank you for the patch.

I'm not the virtio maintainer in U-Boot:

/mnt/work/upstream/u-boot/ $ ./scripts/get_maintainer.pl drivers/virtio/
Bin Meng <bmeng.cn@gmail.com> (maintainer:VirtIO)
[...]

I've added Bin to the Cc list, please include him if you re-submit.

On mer., mars 06, 2024 at 18:59, Dmitrii Merkurev <dimorinny@google.com> wrote:

> Co-developed-by: Cody Schuffelen <schuffelen@google.com>
> Signed-off-by: Cody Schuffelen <schuffelen@google.com>
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>

I'm not super familiar with virtio, so I've not reviewed this.

However, I tested the sandbox unit tests:

uboot@db354723333a:/mnt/work/upstream/u-boot$ ./u-boot -T -c "ut dm virtio*"
Bloblist at b000 not found (err=-2)
sandbox_serial serial: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19


U-Boot 2024.04-00137-g075feb52299 (Apr 05 2024 - 07:12:35 +0000)

Reset Status: WARM Reset Status: COLD
Model: sandbox
DRAM:  256 MiB
[nvmxip-qspi1@08000000]: the block device blk#2 ready for use
[nvmxip-qspi2@08200000]: the block device blk#2 ready for use
Core:  286 devices, 101 uclasses, devicetree: board
WDT:   Not starting wdt-gpio-toggle
WDT:   Not starting wdt-gpio-level
WDT:   Not starting wdt@0
NAND:  4100 MiB
MMC:   mmc2: 2 (SD), mmc1: 1 (SD), mmc0: 0 (SD)
Loading Environment from nowhere... OK
In:    serial,cros-ec-keyb,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: sandbox
Net:   eth0: eth@10002000, eth5: eth@10003000, eth3: sbe5, eth6: eth@10004000, eth8: phy-test-eth, eth4: dsa-test-eth, eth2: lan0, eth7: lan1
Test: dm_test_virtio_all_ops: virtio_device.c
Test: dm_test_virtio_all_ops: virtio_device.c (flat tree)
Test: dm_test_virtio_base: virtio_device.c
Test: dm_test_virtio_base: virtio_device.c (flat tree)
Test: dm_test_virtio_missing_ops: virtio.c
Test: dm_test_virtio_missing_ops: virtio.c (flat tree)
Test: dm_test_virtio_remove: virtio_device.c
Test: dm_test_virtio_remove: virtio_device.c (flat tree)
Test: dm_test_virtio_ring: virtio_device.c
Test: dm_test_virtio_ring: virtio_device.c (flat tree)
Test: dm_test_virtio_rng_check_len: virtio_rng.c
Test: dm_test_virtio_rng_check_len: virtio_rng.c (flat tree)
Failures: 0

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # sandbox

> ---
>  drivers/virtio/virtio_blk.c | 91 +++++++++++++++++++++++++++++++------
>  drivers/virtio/virtio_blk.h | 47 +++++++++++++++++++
>  2 files changed, 124 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
> index 9581058286..225b65c4d1 100644
> --- a/drivers/virtio/virtio_blk.c
> +++ b/drivers/virtio/virtio_blk.c
> @@ -19,30 +19,82 @@ struct virtio_blk_priv {
>  	struct virtqueue *vq;
>  };
>  
> +static const u32 feature[] = {
> +	VIRTIO_BLK_F_WRITE_ZEROES
> +};
> +
> +static void virtio_blk_init_header_sg(struct udevice *dev, u64 sector, u32 type,
> +				      struct virtio_blk_outhdr *out_hdr, struct virtio_sg *sg)
> +{
> +	const bool sector_is_needed = type == VIRTIO_BLK_T_IN ||
> +				      type == VIRTIO_BLK_T_OUT;
> +
> +	out_hdr->type = cpu_to_virtio32(dev, type);
> +	out_hdr->sector = cpu_to_virtio64(dev, sector_is_needed ? sector : 0);
> +
> +	sg->addr = out_hdr;
> +	sg->length = sizeof(*out_hdr);
> +}
> +
> +static void virtio_blk_init_write_zeroes_sg(struct udevice *dev, u64 sector, lbaint_t blkcnt,
> +					    struct virtio_blk_discard_write_zeroes *wz,
> +					    struct virtio_sg *sg)
> +{
> +	wz->sector = cpu_to_virtio64(dev, sector);
> +	wz->num_sectors = cpu_to_virtio32(dev, blkcnt);
> +	wz->flags = cpu_to_virtio32(dev, 0);
> +
> +	sg->addr = wz;
> +	sg->length = sizeof(*wz);
> +}
> +
> +static void virtio_blk_init_status_sg(u8 *status, struct virtio_sg *sg)
> +{
> +	sg->addr = status;
> +	sg->length = sizeof(*status);
> +}
> +
> +static void virtio_blk_init_data_sg(void *buffer, lbaint_t blkcnt, struct virtio_sg *sg)
> +{
> +	sg->addr = buffer;
> +	sg->length = blkcnt * 512;
> +}
> +
>  static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
>  			       lbaint_t blkcnt, void *buffer, u32 type)
>  {
>  	struct virtio_blk_priv *priv = dev_get_priv(dev);
> +	struct virtio_blk_outhdr out_hdr;
> +	struct virtio_blk_discard_write_zeroes wz_hdr;
>  	unsigned int num_out = 0, num_in = 0;
> +	struct virtio_sg hdr_sg, wz_sg, data_sg, status_sg;
>  	struct virtio_sg *sgs[3];
>  	u8 status;
>  	int ret;
>  
> -	struct virtio_blk_outhdr out_hdr = {
> -		.type = cpu_to_virtio32(dev, type),
> -		.sector = cpu_to_virtio64(dev, sector),
> -	};
> -	struct virtio_sg hdr_sg = { &out_hdr, sizeof(out_hdr) };
> -	struct virtio_sg data_sg = { buffer, blkcnt * 512 };
> -	struct virtio_sg status_sg = { &status, sizeof(status) };
> -
> +	virtio_blk_init_header_sg(dev, sector, type, &out_hdr, &hdr_sg);
>  	sgs[num_out++] = &hdr_sg;
>  
> -	if (type & VIRTIO_BLK_T_OUT)
> -		sgs[num_out++] = &data_sg;
> -	else
> -		sgs[num_out + num_in++] = &data_sg;
> -
> +	switch (type) {
> +	case VIRTIO_BLK_T_IN:
> +	case VIRTIO_BLK_T_OUT:
> +		virtio_blk_init_data_sg(buffer, blkcnt, &data_sg);
> +		if (type & VIRTIO_BLK_T_OUT)
> +			sgs[num_out++] = &data_sg;
> +		else
> +			sgs[num_out + num_in++] = &data_sg;
> +		break;
> +
> +	case VIRTIO_BLK_T_WRITE_ZEROES:
> +		virtio_blk_init_write_zeroes_sg(dev, sector, blkcnt, &wz_hdr, &wz_sg);
> +		sgs[num_out++] = &wz_sg;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	virtio_blk_init_status_sg(&status, &status_sg);
>  	sgs[num_out + num_in++] = &status_sg;
>  	log_debug("dev=%s, active=%d, priv=%p, priv->vq=%p\n", dev->name,
>  		  device_active(dev), priv, priv->vq);
> @@ -76,6 +128,15 @@ static ulong virtio_blk_write(struct udevice *dev, lbaint_t start,
>  				 VIRTIO_BLK_T_OUT);
>  }
>  
> +static ulong virtio_blk_erase(struct udevice *dev, lbaint_t start,
> +			      lbaint_t blkcnt)
> +{
> +	if (!virtio_has_feature(dev, VIRTIO_BLK_F_WRITE_ZEROES))
> +		return -EOPNOTSUPP;
> +
> +	return virtio_blk_do_req(dev, start, blkcnt, NULL, VIRTIO_BLK_T_WRITE_ZEROES);
> +}
> +
>  static int virtio_blk_bind(struct udevice *dev)
>  {
>  	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(dev->parent);
> @@ -105,7 +166,8 @@ static int virtio_blk_bind(struct udevice *dev)
>  	desc->bdev = dev;
>  
>  	/* Indicate what driver features we support */
> -	virtio_driver_features_init(uc_priv, NULL, 0, NULL, 0);
> +	virtio_driver_features_init(uc_priv, feature, ARRAY_SIZE(feature),
> +				    NULL, 0);
>  
>  	return 0;
>  }
> @@ -132,6 +194,7 @@ static int virtio_blk_probe(struct udevice *dev)
>  static const struct blk_ops virtio_blk_ops = {
>  	.read	= virtio_blk_read,
>  	.write	= virtio_blk_write,
> +	.erase	= virtio_blk_erase,
>  };
>  
>  U_BOOT_DRIVER(virtio_blk) = {
> diff --git a/drivers/virtio/virtio_blk.h b/drivers/virtio/virtio_blk.h
> index 8d8e02fa2e..b37ba264df 100644
> --- a/drivers/virtio/virtio_blk.h
> +++ b/drivers/virtio/virtio_blk.h
> @@ -17,6 +17,8 @@
>  #define VIRTIO_BLK_F_BLK_SIZE	6	/* Block size of disk is available */
>  #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is available */
>  #define VIRTIO_BLK_F_MQ		12	/* Support more than one vq */
> +#define VIRTIO_BLK_F_DISCARD	13	/* Discard is supported */
> +#define VIRTIO_BLK_F_WRITE_ZEROES	14	/* Write zeroes is supported */
>  
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> @@ -65,6 +67,39 @@ struct __packed virtio_blk_config {
>  
>  	/* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
>  	__u16 num_queues;
> +
> +	/* the next 3 entries are guarded by VIRTIO_BLK_F_DISCARD */
> +	/*
> +	 * The maximum discard sectors (in 512-byte sectors) for
> +	 * one segment.
> +	 */
> +	__u32 max_discard_sectors;
> +	/*
> +	 * The maximum number of discard segments in a
> +	 * discard command.
> +	 */
> +	__u32 max_discard_seg;
> +	/* Discard commands must be aligned to this number of sectors. */
> +	__u32 discard_sector_alignment;
> +
> +	/* the next 3 entries are guarded by VIRTIO_BLK_F_WRITE_ZEROES */
> +	/*
> +	 * The maximum number of write zeroes sectors (in 512-byte sectors) in
> +	 * one segment.
> +	 */
> +	__u32 max_write_zeroes_sectors;
> +	/*
> +	 * The maximum number of segments in a write zeroes
> +	 * command.
> +	 */
> +	__u32 max_write_zeroes_seg;
> +	/*
> +	 * Set if a VIRTIO_BLK_T_WRITE_ZEROES request may result in the
> +	 * deallocation of one or more of the sectors.
> +	 */
> +	__u8 write_zeroes_may_unmap;
> +
> +	__u8 unused1[3];
>  };
>  
>  /*
> @@ -93,6 +128,9 @@ struct __packed virtio_blk_config {
>  /* Get device ID command */
>  #define VIRTIO_BLK_T_GET_ID	8
>  
> +/* Write zeroes command */
> +#define VIRTIO_BLK_T_WRITE_ZEROES 13
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  /* Barrier before this op */
>  #define VIRTIO_BLK_T_BARRIER	0x80000000
> @@ -112,6 +150,15 @@ struct virtio_blk_outhdr {
>  	__virtio64 sector;
>  };
>  
> +struct virtio_blk_discard_write_zeroes {
> +	/* discard/write zeroes start sector */
> +	__virtio64 sector;
> +	/* number of discard/write zeroes sectors */
> +	__virtio32 num_sectors;
> +	/* flags for this range */
> +	__virtio32 flags;
> +};
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  struct virtio_scsi_inhdr {
>  	__virtio32 errors;
> -- 
> 2.44.0.278.ge034bb2e1d-goog
