Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B6606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rP2jSkbE;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=MiYEcoMr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D73680FC1;
	Wed, 11 Nov 2026 09:18:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7rPlpsuqpra; Wed, 11 Nov 2026 09:18:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 113BE81168
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794388713;
	b=aut9ZmMsxKh6vcMSKN5m8etS8gLuT8wTuoGA1BTKnasib3nw3DXS7YQvorcZ4TvB+cab
	 HuvCdgcGyNbr1iEAvNcGqY6osXXvQLa442g2RI9RpPuNvjGZNuSyPxPcN8SuPXLTGfK1b
	 9YWc4y4snE6L6pjmi3GNe6YVrB+0pHzRilB0i8gDuqz076Vyrn2hGxZ0pzlNVzgNB45T1
	 jVMe8UuQOj+rgEOtaR0ztPk6EKqaYIINKJ6eJLvbz6KRPUiC/lUIPFLD60R8re3sbOnpu
	 qFNT/j9gxyjNsqPrXDrXK3gLSN3erBr3N2yXIvFLDst3R3wk1Mp8eG8f6TJKeGyM/ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794388713;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IGYuxqG/EhLe7hQ9qaocH9p9N+DwJ655j206f2jEVZE=;
	b=pVsQjPfhkTIm5lengACj3QMN4UAefeWhcQn4YBReF8EmlsQ8i3JFCnHoYK76d8LHav6g
	 Q9PArQsJpxGdNUslqCh/pBn+/boC0hGFWgMzXlxYPhyIft94hClvup4GeTewE30nkubWH
	 4paOKoYIHQJx9Fgo5riycjFKBdsLe+DXbhZm5mVYb4q3pNeSFfOPaFMAZptDh489AW+xT
	 C83gtsPdGIP3VbH12+nBlVIlMp0E19UKRUWQYqFyCRmPg5305LvFMIvd+4TxthLXYSjcq
	 YB+VVjKdoT64Pa88iTqQRhjE+rR5MS6mfghoHYJWxWcbBuUDGwadSnMoGb9UcuO/plw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794388713;
	bh=IGYuxqG/EhLe7hQ9qaocH9p9N+DwJ655j206f2jEVZE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rP2jSkbEhXrsXPxETXhwPNFVWu59Vgb6DWEGiYNh3ElPietPjOAyZIa4lPH+LE4r7
	 g2c9kJA3YxpUdopTexzfP9hvYLPI2FWRtQIJQOR3sRv6IqRm5U4wM0+KUfjY84kwKJ
	 PbrDlX7z9VdETSylEa2/+9now/dKDAHNV94aA/8/ZmuK7kwUl/nNsca1wqUUoX/zv5
	 tRTZnQqJFTHXpaIJgya2tLoavGirSw19B6f8XLnuqKX74KaKoQnLvNJB4UeNcXpB21
	 TXsorc5ufAqo6E8bqc0jS1S8wWp4VLJ0jp6bSp5IUjTvhhxGj+NGkNGgpM9BHNGrix
	 iNFslXe3kS7uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 113BE81168;
	Wed, 11 Nov 2026 09:18:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FB1A731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20FF5606ED
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QMGwqPwApEQz for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:18:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 85A4460604
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=MiYEcoMr
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85A4460604
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:18:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 43DFD10DADF; Wed, 11 Nov 2026 10:18:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794388703;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=IGYuxqG/EhLe7hQ9qaocH9p9N+DwJ655j206f2jEVZE=;
 b=MiYEcoMrwPQfUG+mq5Ex07rThAlVSJ/5RwqRLzKporlhpnRiR7LTlA1kju2EpxWUoWzkwh
 OuBKr2xiKBwe7acKbRJ7G9dqJ0FN7JrTNY2J/ciCbVfJTY2zDIYxLeYfAjyfqh2dmdg0Aq
 1JDnGSv4rkVaLSyDJgb7jzpv0BsFJ587JEq9XJ4svHKlWOqN0kxny09tjkBdvfF/2PVAaO
 Zq0+DJOEcJyvU8f09mfF+9k174yXrnCfO/bAt2MlCWOeAYG/BzZOiFzQEWpUBbMAPdvAuq
 qlH8I1fWhSYNob60sx3ab5MdIG+B136vo0WErmY+hhMLuTI4V16gPikB+oZ9Dw==
Message-ID: <a9da75fc-eb37-9897-6f1f-f98f934d6b6c@nabladev.com>
Date: Wed, 11 Nov 2026 10:18:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/6] mtd: ubi: validate data_size in the VID header
Content-Language: en-US
To: Ana Bobillo <anabobillo3@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Kyungmin Park <kmpark@infradead.org>, Tom Rini <trini@konsulko.com>,
 Benedikt Spranger <b.spranger@linutronix.de>
References: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
 <7b51d768-91e2-4f16-b559-a30f1351fc08@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <7b51d768-91e2-4f16-b559-a30f1351fc08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Ana,

On 03.11.26 08:12, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
> 
> validate_vid_hdr() never checks that a VID header's data_size fits in a
> LEB. Only the LEBs of a static volume other than its last one have their
> data_size pinned to the usable LEB size; for the last LEB of a static
> volume and for a copied LEB of a dynamic one any positive value passes.
> The attach code then trusts it: when two PEBs hold the same LEB and the
> newer one is a copy, ubi_compare_lebs() reads data_size bytes of that
> PEB into ubi->peb_buf, which holds one PEB, and computes the data CRC
> over them. A handcrafted UBI image can therefore make 'ubi part' overrun
> peb_buf. The ubi_assert() in ubi_io_read() that would catch the length
> is compiled out unless DEBUG is defined.
> 
> Linux fixed this in commit 281fda27673f ("UBI: Validate data_size") by
> Richard Weinberger, after the v4.2 code that U-Boot's UBI was last
> synced with. Apply the same check.
> 
> Add a test which writes a static volume of one full LEB on the sandbox
> NAND, so that its VID header carries the largest valid data_size, checks
> that it attaches and reads back, then sets data_size one byte larger and
> checks that attaching fails.
> 
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   MAINTAINERS          |   1 +
>   drivers/mtd/ubi/io.c |   5 ++
>   test/dm/Makefile     |   3 +
>   test/dm/ubi.c        | 137 +++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 146 insertions(+)
>   create mode 100644 test/dm/ubi.c

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5052671740d..b2ced485702 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1801,6 +1801,7 @@ M:	Heiko Schocher <hs@nabladev.com>
>   S:	Maintained
>   T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-ubi.git
>   F:	drivers/mtd/ubi/
> +F:	test/dm/ubi.c
>   
>   UFETCH
>   M:	Casey Connolly <casey.connolly@linaro.org>
> diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
> index 2ec968c85ff..ee92a2be13c 100644
> --- a/drivers/mtd/ubi/io.c
> +++ b/drivers/mtd/ubi/io.c
> @@ -916,6 +916,11 @@ static int validate_vid_hdr(const struct ubi_device *ubi,
>   		goto bad;
>   	}
>   
> +	if (data_size > ubi->leb_size) {
> +		ubi_err(ubi, "bad data_size");
> +		goto bad;
> +	}
> +
>   	if (vol_type == UBI_VID_STATIC) {
>   		/*
>   		 * Although from high-level point of view static volumes may
> diff --git a/test/dm/Makefile b/test/dm/Makefile
> index 1b3a20aa932..29e3db05a48 100644
> --- a/test/dm/Makefile
> +++ b/test/dm/Makefile
> @@ -149,6 +149,9 @@ obj-$(CONFIG_UT_DM) += tag.o
>   obj-$(CONFIG_TEE) += tee.o
>   obj-$(CONFIG_TIMER) += timer.o
>   obj-$(CONFIG_TPM_V2) += tpm.o
> +ifeq ($(CONFIG_CMD_UBI)$(CONFIG_NAND_SANDBOX),yy)
> +obj-y += ubi.o
> +endif
>   obj-$(CONFIG_DM_USB) += usb.o
>   obj-$(CONFIG_VIDEO_SANDBOX_SDL) += video.o
>   ifeq ($(CONFIG_VIRTIO_SANDBOX),y)
> diff --git a/test/dm/ubi.c b/test/dm/ubi.c
> new file mode 100644
> index 00000000000..81654b33f1e
> --- /dev/null
> +++ b/test/dm/ubi.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Tests for attaching UBI to the sandbox NAND
> + */
> +
> +#include <malloc.h>
> +#include <mtd.h>
> +#include <ubi_uboot.h>
> +#include <dm/test.h>
> +#include <linux/err.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/string.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +
> +#define UBI_TEST_MTD	"nand2"
> +
> +static int ubi_test_erase_peb(struct unit_test_state *uts,
> +			      struct mtd_info *mtd, u64 off)
> +{
> +	struct erase_info ei;
> +
> +	memset(&ei, 0, sizeof(ei));
> +	ei.mtd = mtd;
> +	ei.addr = off;
> +	ei.len = mtd->erasesize;
> +	ut_assertok(mtd_erase(mtd, &ei));
> +
> +	return 0;
> +}
> +
> +/*
> + * Set data_size in the VID header of LEB 0 of volume 0, with a valid header
> + * CRC, by rewriting the PEB that holds it. @peb holds one eraseblock.
> + */
> +static int ubi_test_set_data_size(struct unit_test_state *uts,
> +				  struct mtd_info *mtd, u8 *peb, u32 data_size)
> +{
> +	struct ubi_ec_hdr *ec_hdr = (struct ubi_ec_hdr *)peb;
> +	struct ubi_vid_hdr *vid_hdr;
> +	size_t retlen;
> +	u64 off;
> +
> +	for (off = 0; off < mtd->size; off += mtd->erasesize) {
> +		if (mtd_block_isbad(mtd, off))
> +			continue;
> +		ut_assertok(mtd_read(mtd, off, mtd->erasesize, &retlen, peb));
> +		if (be32_to_cpu(ec_hdr->magic) != UBI_EC_HDR_MAGIC)
> +			continue;
> +		vid_hdr = (struct ubi_vid_hdr *)
> +			(peb + be32_to_cpu(ec_hdr->vid_hdr_offset));
> +		if (be32_to_cpu(vid_hdr->magic) == UBI_VID_HDR_MAGIC &&
> +		    be32_to_cpu(vid_hdr->vol_id) == 0 &&
> +		    be32_to_cpu(vid_hdr->lnum) == 0)
> +			break;
> +	}
> +	ut_assert(off < mtd->size);
> +
> +	vid_hdr->data_size = cpu_to_be32(data_size);
> +	vid_hdr->hdr_crc = cpu_to_be32(crc32(UBI_CRC32_INIT, vid_hdr,
> +					     UBI_VID_HDR_SIZE_CRC));
> +
> +	ut_assertok(ubi_test_erase_peb(uts, mtd, off));
> +	ut_assertok(mtd_write(mtd, off, mtd->erasesize, &retlen, peb));
> +
> +	return 0;
> +}
> +
> +/* Find the test MTD device and erase it all */
> +static int ubi_test_erase_mtd(struct unit_test_state *uts,
> +			      struct mtd_info **mtdp)
> +{
> +	struct mtd_info *mtd;
> +	u64 off;
> +
> +	mtd_probe_devices();
> +	mtd = get_mtd_device_nm(UBI_TEST_MTD);
> +	ut_assert(!IS_ERR_OR_NULL(mtd));
> +	put_mtd_device(mtd);
> +
> +	for (off = 0; off < mtd->size; off += mtd->erasesize) {
> +		if (mtd_block_isbad(mtd, off))
> +			continue;
> +		ut_assertok(ubi_test_erase_peb(uts, mtd, off));
> +	}
> +	*mtdp = mtd;
> +
> +	return 0;
> +}
> +
> +static int ubi_test_vid_hdr_data_size(struct unit_test_state *uts)
> +{
> +	struct mtd_info *mtd;
> +	int leb_size;
> +	u8 *buf;
> +
> +	ut_assertok(ubi_test_erase_mtd(uts, &mtd));
> +
> +	buf = malloc(mtd->erasesize);
> +	ut_assertnonnull(buf);
> +
> +	/* A static volume whose only LEB is full: data_size is the LEB size */
> +	ut_assertok(ubi_part(UBI_TEST_MTD, NULL));
> +	leb_size = ubi_devices[0]->leb_size;
> +	ut_assertok(ubi_create_vol("vol0", leb_size, false, 0, false));
> +	memset(buf, 0xa5, leb_size);
> +	ut_assertok(ubi_volume_write("vol0", buf, 0, leb_size));
> +	ubi_detach();
> +
> +	/* It attaches again and reads back */
> +	ut_assertok(ubi_part(UBI_TEST_MTD, NULL));
> +	memset(buf, 0, leb_size);
> +	ut_assertok(ubi_volume_read("vol0", buf, 0, leb_size));
> +	ut_assertnull(memchr_inv(buf, 0xa5, leb_size));
> +	ubi_detach();
> +
> +	/* One byte more than the LEB holds is a corrupt header */
> +	ut_assertok(ubi_test_set_data_size(uts, mtd, buf, leb_size + 1));
> +	ut_asserteq(-EINVAL, ubi_part(UBI_TEST_MTD, NULL));
> +
> +	free(buf);
> +
> +	return 0;
> +}
> +
> +static int dm_test_ubi_vid_hdr_data_size(struct unit_test_state *uts)
> +{
> +	int ret;
> +
> +	/* UBI holds the MTD device: release it before and after the test */
> +	ubi_detach();
> +	ret = ubi_test_vid_hdr_data_size(uts);
> +	ubi_detach();
> +
> +	return ret;
> +}
> +DM_TEST(dm_test_ubi_vid_hdr_data_size, UTF_SCAN_FDT | UTF_LIVE_TREE);
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
