Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B77C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 13:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF52780EEB;
	Fri, 14 Feb 2025 14:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bBx+OX61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB38801CF; Fri, 14 Feb 2025 12:17:14 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBAD680B98
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 12:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51EBH963013161
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 14 Feb 2025 05:17:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739531829;
 bh=vg1/A6T8xGl8VtbKqQ0D6exuRb+fbgEKvpW01qsScHg=;
 h=From:To:CC:Subject:Date;
 b=bBx+OX61GmrYxqwCLrBmuxHfs+3X1jk9en2kfjv/LX1BNszXsMMsE4dgaIg2rRNBW
 bqUWHsliJmch+tz4ZSCFl0VWLi04TeqXM0bh0vid0me/MRfvz9CTTWkjFndBO2NvjU
 wCBzRSQJhDwxGMVW3DSFBpIh8JdtOJZp+Rik47Pc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51EBH9GP081264;
 Fri, 14 Feb 2025 05:17:09 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Feb 2025 05:17:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Feb 2025 05:17:08 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.72])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51EBH8qX048588;
 Fri, 14 Feb 2025 05:17:08 -0600
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <seanga2@gmail.com>
Subject: [BUG report] spl: image size check fails in spl_load()
Date: Fri, 14 Feb 2025 16:46:55 +0530
Message-ID: <20250214111656.2358748-1-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 14 Feb 2025 14:11:32 +0100
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

Hi all!

I was trying to implement falcon boot on TI AM62x EVM with the kernel image on
SD card's filesystem but the following check in `_spl_load` at
`include/spl_load.h:95` fails to -EIO as per the latest commit [89d3333]:

	return read < spl_image->size ? -EIO : 0;

The check seems to be comparing the image size gathered from the header
(spl_image->size) with the number of bytes read form the loader.

From spl_load.h:

	ret = spl_parse_image_header(spl_image, bootdev, header);
	if (ret)
		return ret;

	base_offset = spl_image->offset;
	/* Only NOR sets this flag. */
	if (IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) &&
	    spl_image->flags & SPL_COPY_PAYLOAD_ONLY)
		base_offset += sizeof(*header);
	image_offset = ALIGN_DOWN(base_offset, spl_get_bl_len(info));
	overhead = base_offset - image_offset;
	size = ALIGN(spl_image->size + overhead, spl_get_bl_len(info));

	read = info->read(info, offset + image_offset, size,
			  map_sysmem(spl_image->load_addr - overhead, size));

	if (read < 0)
		return read;

	return read < spl_image->size ? -EIO : 0;

During kernel build process the header size is computed including the BSS
whereas it's removed when creating the uncompressed image. Therefore the size
of the uncompressed image on filesystem will be smaller than the size specified
in the header. Which leads to failure of the above check.

From linux kernel's `arch/arm64/kernel/image.h:63`:

	#define HEAD_SYMBOLS						\
		DEFINE_IMAGE_LE64(_kernel_size_le, _end - _text);	\
		DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);

Disabling the check leads to a successful boot directly to the kernel.
Therefore it seems like the check is non functional as the size in the kernel
header does not correspond with the file size of the kernel image.

Regards,
Anshul
