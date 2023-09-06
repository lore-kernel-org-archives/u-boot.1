Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F90DEB8FAF
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 10:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3C9B86682;
	Wed,  6 Sep 2023 12:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Nu66RpAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF1C88671C; Wed,  6 Sep 2023 12:47:40 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CDDB866A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 12:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20230906104733epoutp016f6f2216b5b2ee53c35896c5a9e04a1f~CSYbFicEd0185701857epoutp01X
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 10:47:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20230906104733epoutp016f6f2216b5b2ee53c35896c5a9e04a1f~CSYbFicEd0185701857epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693997253;
 bh=IO5y8/gLTEhmJKtKaQg2AUJ9fQwYXGfV1R8jeNmXy18=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=Nu66RpAHt8wWEyTaaTRqb3EwE3Hq3J+BMG6n0ttveJFbn1NWsjVVdFJdCIw4aJ4tN
 pSAJghUyTyY0qrrxippAe3xg6EexpxJ92dq7vJryQ8Dupe/B6MorpcXRLm8hj1rZBw
 0MZ4hnYiDIWieGTUN/RqeZiaWwUSrROwK5DFFoWc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20230906104732epcas2p403deefed86868c8201361cb388ba252a~CSYajX46E0179001790epcas2p4y;
 Wed,  6 Sep 2023 10:47:32 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.89]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4RgfGC54Snz4x9Py; Wed,  6 Sep
 2023 10:47:31 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 97.9F.08583.3C858F46; Wed,  6 Sep 2023 19:47:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230906104731epcas2p49865f564160c83e33f87308c49dad4e1~CSYZX3g-Q0179001790epcas2p4u;
 Wed,  6 Sep 2023 10:47:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230906104731epsmtrp215217f3051cdfa654fd6d18948f9d519~CSYZXG9Kd0383003830epsmtrp2W;
 Wed,  6 Sep 2023 10:47:31 +0000 (GMT)
X-AuditID: b6c32a43-6f7ff70000002187-89-64f858c3e3c4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 EC.53.08742.2C858F46; Wed,  6 Sep 2023 19:47:31 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20230906104730epsmtip2d2b303d9d07a4124990e1a946c92901e~CSYZFzBYl2309723097epsmtip2e;
 Wed,  6 Sep 2023 10:47:30 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Heinrich Schuchardt'" <heinrich.schuchardt@canonical.com>, "'Rick
 Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>, "'Yanhong
 Wang'" <yanhong.wang@starfivetech.com>
Cc: "'Simon Glass'" <sjg@chromium.org>, "'Marc Kleine-Budde'"
 <mkl@pengutronix.de>, <u-boot@lists.denx.de>
In-Reply-To: <20230906100803.79812-2-heinrich.schuchardt@canonical.com>
Subject: RE: [PATCH 1/2] tools: mkimage: Add StarFive SPL image support
Date: Wed, 6 Sep 2023 19:47:30 +0900
Message-ID: <000001d9e0af$8933c3f0$9b9b4bd0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLgXrlp9FI+RP5glVKFMAjsQEyxagJT3zI+Arjfsnut2DoakA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmqe7hiB8pBuu2KFlcaLzJbrF+0RQW
 i7cvzjJafNuyjdHi7d5OdosfXY8YLR4fes3kwO6x5/QsZo9ZDb1sHrMbLrJ4nL2zg9Gj/6+B
 x+2zvAFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6Z
 OUCnKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0M
 jEyBChOyM55/28lYsNSx4t3ri4wNjHNMuhg5OSQETCS27nzK2sXIxSEksINR4sGPDhYI5xOj
 xMTV69kgnG+MEnsfTGaFaZnS9poZIrGXUeLK/s9QLS8YJaZNf8kOUsUmoC/xsmMb2GARgV2M
 Eq8vvmEDSTAL5Eg8un0KqIiDg1PAXaLxpAdIWBjIPNKzF2wDi4CKxIebZ8BsXgFLibWtp1gg
 bEGJkzOfsECMkZfY/nYOM8RFChI/ny4DqxcRcJL4NeMT1CpxiZdHj7BD1KzlkDg6WwfCdpFY
 enA9VK+wxKvjW6BqpCQ+v9vLBnKahEC5xI5lSSDnSwi0MEo0t+2BqreX+HFzCitIDbOApsT6
 XfoQ5coSR25BXcYn0XH4LztEmFeio00IolFd4sD26SwQtqxE95zPrBMYlWYh+WsWkr9mIbl/
 FsKuBYwsqxjFUguKc9NTk40KDOFxnZyfu4kRnEi1nHcwXpn/T+8QIxMH4yFGCQ5mJRHed/Lf
 UoR4UxIrq1KL8uOLSnNSiw8xmgJDeiKzlGhyPjCV55XEG5pYGpiYmRmaG5kamCuJ895rnZsi
 JJCeWJKanZpakFoE08fEwSnVwLTfYWqAx5MPnu0fz/9Xb53cwnxKouxBlfvBh31+BmFOV/+s
 O9G5l6/O05tL+E3P0/WGTw/EfZY658AvOTORc91d9qIVx154HeT6Vat30G7DtUiusM4flTN3
 SR6KEDoldV93wYznJ51uPWdg+H6lOG/xmphN/z52vOm3+SvrfG3i6k13azYVNkfIvLm9dWZP
 sqRCR+mkysKKkt3Ly55Zz54f88TsKkM1g6//fCb1SYd3s1jeUC+9z9v3dqJo0LvP8a8Mjxa9
 0FbSmFl1s8hml5FfY+G0Kau+ndHWPCh3JLr/c+WvffxvX55Yd2+DxQ2e1vJLPcEFtvNSlh54
 mfJrdWK/J2+X+py4T7aMh1YlyEsqsRRnJBpqMRcVJwIAoR/Gty0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSvO7hiB8pBvdPMFpcaLzJbrF+0RQW
 i7cvzjJafNuyjdHi7d5OdosfXY8YLR4fes3kwO6x5/QsZo9ZDb1sHrMbLrJ4nL2zg9Gj/6+B
 x+2zvAFsUVw2Kak5mWWpRfp2CVwZz7/tZCxY6ljx7vVFxgbGOSZdjJwcEgImElPaXjN3MXJx
 CAnsZpQ41b2MBSIhK/Hs3Q52CFtY4n7LEVaIomeMEsv67rGBJNgE9CVedmwDS4gI7GGUWNN+
 EKybWSBPYtaz1VBjLzNKfLy2jqmLkYODU8BdovGkB0iNMJB5pGcvK4jNIqAi8eHmGTCbV8BS
 Ym3rKRYIW1Di5MwnLCCtzAJ6Em0bGSHGy0tsfzuHGeI4BYmfT5eBtYoIOEn8mvGJDaJGXOLl
 0SPsMM907+xhg3nm7oOX7BMYRWch2TALYcMsJBtmIZm0gJFlFaNkakFxbnpusWGBYV5quV5x
 Ym5xaV66XnJ+7iZGcBRqae5g3L7qg94hRiYOxkOMEhzMSiK87+S/pQjxpiRWVqUW5ccXleak
 Fh9ilOZgURLnFX/RmyIkkJ5YkpqdmlqQWgSTZeLglGpgCth7OOnZrLXd2S9S/8i4dGW3h4lZ
 X860lywWvaM76WZf9uT+V7fTMqRt/+zpWaqUUs6bbqtfJOzY5pb0kN1LzUzdMd+w7d/9QrN5
 DyIs9gif4OPf+3lPXW3Y95rIPvcI4wt7495Ob2HOFj4z/X1CwJarn2Jmck2o8Gfyazt0bwdH
 /+3IiUbcW3NmqMZ/MRAQ26IpcW5KKmdduNyG4zOTV4ZM26777OCUyn/b7vkYCbrlLX2sWPiM
 OYbB9VQv2/sww09zdy6Z8rhK3ZLb++SCW/ckdzdVSH6cfpOz75Od7KbdJU+8Lh54JvM3WWLp
 H77MVfefmvzwE1G7m3ts4hb2RsdIRZVjExvuKEf2yBsrsRRnJBpqMRcVJwIAmvnvNTEDAAA=
X-CMS-MailID: 20230906104731epcas2p49865f564160c83e33f87308c49dad4e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906100824epcas2p2e6073e8f64231f96953c92f665122c28
References: <20230906100803.79812-1-heinrich.schuchardt@canonical.com>
 <CGME20230906100824epcas2p2e6073e8f64231f96953c92f665122c28@epcas2p2.samsung.com>
 <20230906100803.79812-2-heinrich.schuchardt@canonical.com>
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

> -----Original Message-----
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Sent: Wednesday, September 6, 2023 7:08 PM
> To: Rick Chen <rick@andestech.com>; Leo <ycliang@andestech.com>; Yanhong
> Wang <yanhong.wang@starfivetech.com>
> Cc: Simon Glass <sjg@chromium.org>; Marc Kleine-Budde
<mkl@pengutronix.de>;
> Chanho Park <chanho61.park@samsung.com>; u-boot@lists.denx.de; Heinrich
> Schuchardt <heinrich.schuchardt@canonical.com>
> Subject: [PATCH 1/2] tools: mkimage: Add StarFive SPL image support
> 
> The StarFive JH7110 base boards require a header to be prefixed to the SPL
> binary image. This has previously done with a vendor tool 'spl_tool'
> published under a GPL-2-or-later license. Integrate this capability into
> mkimage.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/image.c    |   1 +
>  include/image.h |   1 +
>  tools/Makefile  |   1 +
>  tools/sfspl.c   | 174 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 177 insertions(+)
>  create mode 100644 tools/sfspl.c
> 
> diff --git a/boot/image.c b/boot/image.c
> index 5c4f9b807d..3a99d2e897 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -182,6 +182,7 @@ static const table_entry_t uimage_type[] = {
>  	{	IH_TYPE_SUNXI_TOC0, "sunxi_toc0",  "Allwinner TOC0 Boot
> Image" },
>  	{	IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Flat
> Device Tree ", },
>  	{	IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
> +	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
>  	{	-1,		    "",		  "",			},
>  };
> 
> diff --git a/include/image.h b/include/image.h
> index 01a6787d21..5f85bf84a2 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -231,6 +231,7 @@ enum image_type_t {
>  	IH_TYPE_SUNXI_TOC0,		/* Allwinner TOC0 Boot Image */
>  	IH_TYPE_FDT_LEGACY,		/* Binary Flat Device Tree Blob	in a
> Legacy Image */
>  	IH_TYPE_RENESAS_SPKG,		/* Renesas SPKG image */
> +	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
> 
>  	IH_TYPE_COUNT,			/* Number of image types */
>  };
> diff --git a/tools/Makefile b/tools/Makefile
> index 3d0c4b0dd6..1aa1e36137 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -123,6 +123,7 @@ dumpimage-mkimage-objs := aisimage.o \
>  			pblimage.o \
>  			pbl_crc32.o \
>  			renesas_spkgimage.o \
> +			sfspl.o \
>  			vybridimage.o \
>  			stm32image.o \
>  			$(ROCKCHIP_OBS) \
> diff --git a/tools/sfspl.c b/tools/sfspl.c
> new file mode 100644
> index 0000000000..428542d885
> --- /dev/null
> +++ b/tools/sfspl.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> + *
> + * The StarFive JH710 requires to prepend a header to u-boot-spl.bin
> describing

Nit: JH7110 or JH7100? If you'd like to indicate both, JH71x0?

Tested-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

> + * the payload length and CRC32.
> + *
> + * This module implements support in mkimage and dumpimage for this file
> format.
> + *
> + * StarFive's spl_tool available under GPL-2.0-and-later at
> + * https://protect2.fireeye.com/v1/url?k=d38f2235-b204371a-d38ea97a-
> 74fe485cbfe7-db3f73ac8e80b9ed&q=1&e=f143c01a-a53d-425d-a99e-
> dab4877e8097&u=https%3A%2F%2Fgithub.com%2Fstarfive-tech%2FTools implements
> writing the same file
> + * format and served as a reference.
> + */
> +
> +#include <compiler.h>
> +#include <fcntl.h>
> +#include <u-boot/crc.h>
> +#include <unistd.h>
> +#include "imagetool.h"
> +
> +#define DEFAULT_VERSION 0x01010101
> +#define DEFAULT_BACKUP 0x200000U
> +#define DEFAULT_OFFSET 0x240
> +
> +/**
> + * struct spl_hdr - header for SPL on JH7110
> + *
> + * All fields are low-endian.
> + */
> +struct spl_hdr {
> +	/** @offset:	offset to SPL header (0x240) */
> +	unsigned int offset;
> +	/** @bkp_offs:	address of backup SPL, defaults to
> DEFAULT_BACKUP */
> +	unsigned int bkp_offs;
> +	/** @zero1:	set to zero */
> +	unsigned int zero1[159];
> +	/** @version:	header version, defaults to DEFAULT_VERSION */
> +	unsigned int version;
> +	/** @file_size:	file size */
> +	unsigned int file_size;
> +	/** @hdr_size:	size of the file header (0x400) */
> +	unsigned int hdr_size;
> +	/** @crc32:	CRC32 */
> +	unsigned int crc32;
> +	/** @zero2:	set to zero */
> +	unsigned int zero2[91];
> +};
> +
> +static int sfspl_check_params(struct image_tool_params *params)
> +{
> +	/* Only the RISC-V architecture is supported */
> +	if (params->Aflag && params->arch != IH_ARCH_RISCV)
> +		return EXIT_FAILURE;
> +
> +	return EXIT_SUCCESS;
> +}
> +
> +static int sfspl_verify_header(unsigned char *buf, int size,
> +			       struct image_tool_params *params)
> +{
> +	struct spl_hdr *hdr = (void *)buf;
> +	unsigned int hdr_size = le32_to_cpu(hdr->hdr_size);
> +	unsigned int file_size = le32_to_cpu(hdr->file_size);
> +	unsigned int crc = le32_to_cpu(hdr->crc32);
> +	unsigned int crc_check;
> +
> +	if (size < 0 ||
> +	    (size_t)size < sizeof(struct spl_hdr) ||
> +	    (size_t)size < hdr_size + file_size) {
> +		printf("Truncated file\n");
> +		return EXIT_FAILURE;
> +	}
> +	if (hdr->version != DEFAULT_VERSION) {
> +		printf("Unknown file format version\n");
> +		return EXIT_FAILURE;
> +	}
> +	crc_check = crc32(0, &buf[hdr_size], size - hdr_size);
> +	if (crc_check != crc) {
> +		printf("Incorrect CRC32\n");
> +		return EXIT_FAILURE;
> +	}
> +
> +	return EXIT_SUCCESS;
> +}
> +
> +static void sfspl_print_header(const void *buf,
> +			       struct image_tool_params *params)
> +{
> +	struct spl_hdr *hdr = (void *)buf;
> +	unsigned int hdr_size = le32_to_cpu(hdr->hdr_size);
> +	unsigned int file_size = le32_to_cpu(hdr->file_size);
> +
> +	printf("Header size: %u\n", hdr_size);
> +	printf("Payload size: %u\n", file_size);
> +}
> +
> +static int sfspl_image_extract_subimage(void *ptr,
> +					struct image_tool_params *params)
> +{
> +	struct spl_hdr *hdr = (void *)ptr;
> +	unsigned char *buf = ptr;
> +	int fd;
> +	unsigned int hdr_size = le32_to_cpu(hdr->hdr_size);
> +	unsigned int file_size = le32_to_cpu(hdr->file_size);
> +
> +	if (params->pflag) {
> +		printf("Invalid image index %d\n", params->pflag);
> +		return EXIT_FAILURE;
> +	}
> +
> +	fd = open(params->outfile, O_WRONLY | O_CREAT | O_TRUNC, 0644);
> +	if (fd == -1) {
> +		perror("Can write file");
> +		return EXIT_FAILURE;
> +	}
> +	if (write(fd, &buf[hdr_size], file_size) != file_size) {
> +		perror("Cannot write file");
> +		return EXIT_FAILURE;
> +	}
> +	close(fd);
> +
> +	return EXIT_SUCCESS;
> +}
> +
> +static int sfspl_check_image_type(uint8_t type)
> +{
> +	if (type == IH_TYPE_STARFIVE_SPL)
> +		return EXIT_SUCCESS;
> +
> +	return EXIT_FAILURE;
> +}
> +
> +static void sfspl_set_header(void *buf, struct stat *sbuf, int infd,
> +			     struct image_tool_params *params)
> +{
> +	struct spl_hdr *hdr = buf;
> +	unsigned int file_size;
> +	unsigned int crc;
> +
> +	file_size = params->file_size - sizeof(struct spl_hdr);
> +	crc = crc32(0, &((unsigned char *)buf)[sizeof(struct spl_hdr)],
> +		    file_size);
> +
> +	hdr->offset = cpu_to_le32(DEFAULT_OFFSET);
> +	hdr->bkp_offs = cpu_to_le32(DEFAULT_BACKUP);
> +	hdr->version = cpu_to_le32(DEFAULT_VERSION);
> +	hdr->file_size = cpu_to_le32(file_size);
> +	hdr->hdr_size = cpu_to_le32(sizeof(struct spl_hdr));
> +	hdr->crc32 = cpu_to_le32(crc);
> +}
> +
> +static int sfspl_vrec_header(struct image_tool_params *params,
> +			     struct image_type_params *tparams)
> +{
> +	tparams->hdr = calloc(sizeof(struct spl_hdr), 1);
> +
> +	/* No padding */
> +	return 0;
> +}
> +
> +U_BOOT_IMAGE_TYPE(
> +	sfspl, /* id */
> +	"StarFive SPL Image", /* name */
> +	sizeof(struct spl_hdr), /* header_size */
> +	NULL, /* header */
> +	sfspl_check_params, /* check_params */
> +	sfspl_verify_header, /* verify header */
> +	sfspl_print_header, /* print header */
> +	sfspl_set_header, /* set header */
> +	sfspl_image_extract_subimage, /* extract_subimage */
> +	sfspl_check_image_type, /* check_image_type */
> +	NULL, /* fflag_handle */
> +	sfspl_vrec_header /* vrec_header */
> +);
> --
> 2.40.1


