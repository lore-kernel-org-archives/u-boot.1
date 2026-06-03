Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAB2CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 04:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6544840ED;
	Wed,  3 Jun 2026 06:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="GVJXZfQ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 716E784837; Wed,  3 Jun 2026 06:57:23 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787A683EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 06:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BBD54116735; Wed,  3 Jun 2026 06:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1780462638;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Qac/HXopnkC7ZJ+m+pPkqiEGMJhgI4xuJjw5AkpDvHY=;
 b=GVJXZfQ1UkPMynv2VG5dl8YYvj8ZjIPMC9WmmJQJuDilhqkrwVjuR79tHWzDHycZxTKSmL
 dzDasfb9/HQ4+NGcsMNUK3K1VSv33EMGte9lQc7U0+nzGGU/gkPbTp4kwEyY1Y3U+klu8d
 0lILuyuAY0RSXFMNcOvnvj0y+nu08pDcrs1mkNUh81Z+en3pHGIobd+HsUzwTd/fiS1uKK
 GVXSlDIg8I8X7tLcwRO3QHgKFVIpaLP8mqRB7lDKtCFSKHsNYxXANK5KcQybU6AUsiN3ov
 JZyQC7ok1MAU8koQbf6HtucvTgcFA9a4x1rT2BOjctAfPkfoPNfszK9f9uEgpw==
Message-ID: <9e3611ff-55f0-4a04-864a-935e6c7a3623@nabladev.com>
Date: Wed, 3 Jun 2026 06:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
From: Marek Vasut <marex@nabladev.com>
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, fedor.ross@ifm.com, joao.goncalves@toradex.com,
 ravi@prevas.dk, ping.bai@nxp.com, ji.luo@nxp.com, qijian.guo@nxp.com
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
 <acfe5311-2ec4-48fb-80bd-55c11931b377@nabladev.com>
 <4phebvxijyyk5yd4p7omjlup3iotsqgp6r3kt5aiwgimwg6nyp@hnl3qq4imsf2>
 <4dd5cfbf-18d3-4411-bb02-c746611ecceb@nabladev.com>
Content-Language: en-US
In-Reply-To: <4dd5cfbf-18d3-4411-bb02-c746611ecceb@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/2/26 4:11 PM, Marek Vasut wrote:
> On 6/2/26 3:46 PM, Simona Toaca wrote:
> 
> Hi,
> 
>>>> +    ret = spi_flash_erase_dm(flash, offset, QB_STATE_LOAD_SIZE);
>>> Can you please double-check whether "offset" here is always aligned 
>>> to 64
>>> kiB (SPI NOR erase block size) ? If not, this erase here will fail.
>>>
>>> Thank you
>>
>> The erase size of the SPI NOR should actually be 4kiB.
> 
> That does not apply to all devices. I assume to align this data to 64 
> kiB offset, I would need a replacement AHAB container?
> 
>> I added
>> a patch a while back enabling SFDP support, so that the erase size is
>> parsed correctly and this does not fail. I only enabled it on U-Boot,
>> but if you are using SPL you should enable it there too.
>>
>> The only reason why I did not enable it for SPL is that there seems
>> to not be any defconfig for iMX95/943/952 for booting from SPI NOR.
>>
>> Trying 'qb save spi' from eMMC on an iMX943 EVK (with SFDP enabled):
>> u-boot=> qb save spi
>> SF: Detected mt35xu512aba with page size 256 Bytes, erase size 4 KiB,
>> total 64 MiB
>> u-boot=> echo $?
>> 0
>>
>> Without SFDP, 'sf probe' reports 128kiB erase size, not 64kiB.
>>
>> I also do not see why I would check if the offset is a multiple of
>> the erase size, since the erase fails gracefully.
> My understanding is, that the erase operation should erase the QB data 
> from the SPI NOR, not ignore failure and keep the data there ?

It seems that on iMX95 B0, the DDR_DUMMY offset is 0x76400 (aligned to 1 
kiB, which is too low):

"
$ hexdump -vC flash.bin | grep -A 1 ^00008000
00008000  02 a0 02 87 10 00 00 00  00 00 00 05 90 02 00 00
00008010  00 64 07 00 00 00 00 00  00 00 00 00 00 00 00 00
           ^^^^^^^^^^^
"

But if I add the patch below, the offset gets aligned to 64 kiB at 0x78000:

"
$ hexdump -vC flash.bin | grep -A 1 ^00008000
00008000  02 a0 02 87 10 00 00 00  00 00 00 05 90 02 00 00
00008010  00 80 07 00 00 00 00 00  00 00 00 00 00 00 00 00
           ^^^^^^^^^^^
"

This makes the "qb save" work reliably even on SPI NOR, because the 
erase block is aligned to 64 kiB instead of 1 kiB as it was before. 
Maybe we need such an alignment change ?

"
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 3cea536b8e8..09446142646 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -9,6 +9,13 @@
  #include <image.h>
  #include <linux/sizes.h>

+#define roundup(x, y) (                                        \
+{                                                      \
+       const typeof(y) __y = y;                        \
+       (((x) + (__y - 1)) / __y) * __y;                \
+}                                                      \
+)
+
  static int p_idx;
  static int sector_size;
  static soc_type_t soc;
@@ -647,7 +654,7 @@ static void set_image_array_entry(flash_header_v3_t 
*container,
                         /* if at least 2 images in container, [0] and 
[1] */
                         boot_img_t *ddr_dummy = 
&container->img[container->num_images - 1];
                         if ((ddr_dummy->hab_flags & 0x0F) == 
IMG_TYPE_DDR_DUMMY) {
-                               ddr_dummy->offset = img->offset + img->size;
+                               ddr_dummy->offset = roundup(img->offset 
+ img->size, 65536);
                                 set_image_hash(ddr_dummy, "/dev/null", 
IMAGE_HASH_ALGO_DEFAULT);
                         }
                 }
"
