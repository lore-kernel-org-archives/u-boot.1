Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86131606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A1B2qvRe;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHXW+UNL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 428E860DBD;
	Thu, 19 Nov 2026 15:25:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mntb9h_WuBhO; Thu, 19 Nov 2026 15:25:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B24D360ADF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101905;
	b=g56mKcowkBev1eb1WHDq6ViT1u5T3d1fwAqzuxIBCOD9FQ/pQK9/xF5hVFPJq+MEj1FC
	 QRXDYCzCyOpotcxA72LF8Snm+bPZFafN4fqk8ACAPZHw+OWPHrKrEPDouN8FeKi1PS76j
	 DX0zRbf0L+DRnOuU1E82EKtUPka7DV0V6RSSOV/CbtF3ryaFCI+I+cejGRoNZKDZRfNm3
	 9h87pIs/62SlbFwl2DvUug3LrOygHIWvxGHYJSSft/+CCO8r4VB+9wH8WjfsQU77spu3B
	 R2r9LCFEOok3YmwAYZ19OJkG9VhA/xxMg54Bw4Io3oQwa4HsI+UO8lCX1ZjtyPR9JLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NmH8ByQkPjmxvM6X8LkEPFyDUHAP+8VjshhUvVjzrPg=;
	b=l5oWRJwRAc55EeLmziZPPuJoRPYq+4eqdh0aki3zDwgUAb0VpwQ6ZvWkpE3lnihwAVrx
	 HqEaK8c93R19EQqXRMn/XSRQRfpzBG6e8aGns0TBeiIwd8pC/zqz/LZGzBBOGhXxGL4DE
	 uZaQAd9aXmYfZfu832PcxnqDPWtbR/w5MCgDX0H5pQkqxLYbD1qA7xGAGTcujwzQLyWdh
	 HQwZneIhApG2gCDmTzHAZ6rI809v9gwEpWfZ5qfYTWSYU2yvvaIW0ZgVzwSY7AtSrnFxj
	 fcmgnenjSYfVQa7pJLa0WJD3BIgQaiA6JI2okueHP0ocmU+cNBqYiJHmSWHQrMw3drw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101905;
	bh=NmH8ByQkPjmxvM6X8LkEPFyDUHAP+8VjshhUvVjzrPg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A1B2qvRey8O8+gh5v7oH3aXnYxbzxXz2FVIvReP8lAjBKvQ4zc3TQh3R7hT64yle0
	 G99NTC9n6sBvgft7GrxuKt6TEhTK5Q0URBHSlgmTZY0EJuazgssEeAwmfJ43OaR/M7
	 3KqsTrRWGXKAON+nBNcxW78MceiLKQ6/2yz4iuKVzyOA+ERLfKpM6q/hnscHaMCUOY
	 x4ZtSxR1zewQBB0n/4cpBlwWrUr5c9qNjmIyNc4Rids9c2JHtgHvzMPlEnhbAFAjwo
	 SYh8jY6ruct+pvURLSLeraE2l833OMKJQboK5DFHvVo7+b2FjkjeqaUKRdS1K3d59d
	 Y8dUMjjYzstDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B24D360ADF;
	Thu, 19 Nov 2026 15:25:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE12D465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C44EB40562
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nqYCAKnVXd1b for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:24:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AEAE740556
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KHXW+UNL
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEAE740556
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:24:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0458F43D4A;
 Thu, 19 Nov 2026 15:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEFD1F000C5;
 Thu, 19 Nov 2026 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795101897;
 bh=NmH8ByQkPjmxvM6X8LkEPFyDUHAP+8VjshhUvVjzrPg=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=KHXW+UNL3YPa+eyZoPKIRCRE6lrDHr1O9G9SaXkuTyGF2Vu8An/UztSTlKkXEr8Ai
 2+YjreHUNs+J+rVOk2T2Xz9UCJbRBoFdUgzLt1878R8jC1VNkSsFTnnz/TWtuf8vmt
 SWB0Dyb7sM71myPrUFhvUtB4cDQ/qfg5SzZAs053knJtQryc5+CjyezRiLW+u5E2pM
 qmkJkkNjjRNhtenVMw6fY1Xj9BmvHm+Ut8DBgtGQXvdvrjskzI5AcEw8T6JvgtD6hn
 9LyuNW6BrLccOmVLOyluX75Oj0bT7rZXekFIl3PrtEsyEPKrYnCiwCXpftVvJPLvZl
 s8lUD6UGDufPg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/14] usb: gadget: firehose: add the read command
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Johan Jonker <jbx6244@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Simon Glass <sjg@chromium.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Vincent Jardin <vjardin@free.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
In-Reply-To: <20261106-firehose-v1-v1-2-e7591c12fc65@oss.qualcomm.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
 <20261106-firehose-v1-v1-2-e7591c12fc65@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:46 +0100
Message-Id: <179510188628.516692.16057590684584254221.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5909;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=TlTnl1urH769NAHs4c2/8Jw+RaTgyOWiHx2RdZ4o7/Q=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/xTEK3a9ka+IyvtgorxSJEVV8xMYTVHPOb5bp
 UF7rtscpKmJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav8UxAAKCRAZDR20Zk4Z
 NTnkCACRJIOapi4uLRb/6Ab+FdbbK9h8sNh6D+PA3BI6tNjntwQTmBT22PgJ716kmGlz8af87W3
 R2IGi3+wMVq3C2/r+qGR90bODVX2ZvML77KDnLCS06Loi6DPnzuLcJCBzUCzIMMFUqozW9QZ2fh
 MOl+ACzCTOjjesaTj4188zHYOHI/aI5QTzwG+W2Kz1zfqm45zZILDUdX9+D3v+fUMeCsI4M4WWL
 QEn0Qf14UEiT6QTWyY1KkdOCifCeXBLseS0KgEFI1Cksa3S5WTug2AmiNG5QlkDuJn9VcYgPV9E
 lAuu95X5ny8mPSJotuLY2JP6m6EjNm+S1IaXxO9sCaX+fz1i
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

Thank you for the patch.

> Stream sectors of physical partition 0 to the host in 1 MiB transfers.
> start_sector accepts the NUM_DISK_SECTORS[-N] form of the XML files.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/usb/gadget/f_firehose.c     | 106 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/gadget/firehose_parse.c |  67 ++++++++++++++++++++++-
>  include/firehose.h                  |  23 ++++++++
>  3 files changed, 195 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/f_firehose.c b/drivers/usb/gadget/f_firehose.c
> index 460216a2bf81..4be8d3ef1ba2 100644
> --- a/drivers/usb/gadget/f_firehose.c
> +++ b/drivers/usb/gadget/f_firehose.c
> @@ -439,6 +439,66 @@ static int __printf(3, 4) fh_log(struct f_firehose *fh, bool err,
>  			   msg);
>  }
>  
> +static int fh_eval(struct f_firehose *fh, const char *s, u64 *val)
> +{
> +	return firehose_eval(fh->desc, s, val);
> +}

What's the point of this helper? It's only called once.

> +
> +static int fh_check_partition(struct f_firehose *fh, struct firehose_cmd *cmd)
> +{
> +	const char *ppn = firehose_attr(cmd, "physical_partition_number");
> +
> +	/* qdl probes the other partitions when it looks up names */
> +	if (ppn && strcmp(ppn, "0")) {

What happens if the attribute is invalid here? for example if ppn is
"0123" how will strcmp behave?

> +		fh_log(fh, false, "ERROR: only physical partition 0 is supported");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fh_check_sector_size(struct f_firehose *fh, struct firehose_cmd *cmd)
> +{
> +	u64 sector_size;
> +
> +	if (firehose_attr_u64(cmd, "SECTOR_SIZE_IN_BYTES", &sector_size) ||
> +	    sector_size != fh->desc->blksz) {
> +		fh_log(fh, true, "sector size must be %lu", fh->desc->blksz);
> +		return -EINVAL;
> +	}
> +
> +	return fh_check_partition(fh, cmd);
> +}
> +
> +static int fh_get_range(struct f_firehose *fh, struct firehose_cmd *cmd,
> +			lbaint_t *start, lbaint_t *count)
> +{
> +	struct blk_desc *desc = fh->desc;
> +	u64 first, num;
> +	int ret;
> +
> +	ret = fh_check_sector_size(fh, cmd);
> +	if (ret)
> +		return ret;
> +
> +	if (fh_eval(fh, firehose_attr(cmd, "start_sector"), &first) ||
> +	    firehose_attr_u64(cmd, "num_partition_sectors", &num)) {
> +		fh_log(fh, true, "invalid start_sector or num_partition_sectors");
> +		return -EINVAL;
> +	}
> +
> +	if (first > desc->lba || num > desc->lba - first) {
> +		fh_log(fh, true, "sectors %llu+%llu beyond the end (%llu)",
> +		       first, num, (u64)desc->lba);
> +		return -ERANGE;
> +	}
> +
> +	*start = first;
> +	*count = num;
> +
> +	return 0;
> +}
> +
>  static int fh_configure(struct f_firehose *fh, struct firehose_cmd *cmd)
>  {
>  	const char *memory = firehose_attr(cmd, "MemoryName");
> @@ -480,6 +540,51 @@ static int fh_configure(struct f_firehose *fh, struct firehose_cmd *cmd)
>  	return ret ?: FH_RESPONDED;
>  }
>  
> +/*
> + * After a read error zeros are sent for the rest, then a NAK. The host
Missing comma ?

After a read error, zeros are sent dof the rest?

> + * expects a ZLP after each transfer that is a multiple of maxpacket; not

What is a ZLP? It's not documented in the main README of https://github.com/qualcomm/qdl
If it's an acrononym, it should be written with full words at least
once.

> + * all UDC drivers honour usb_request.zero, so it is a request of its own.
> + */
> +static int fh_read(struct f_firehose *fh, struct firehose_cmd *cmd)
> +{
> +	struct blk_desc *desc = fh->desc;
> +	lbaint_t chunk = FH_PAYLOAD / desc->blksz;
> +	lbaint_t start, left, n;
> +	size_t len;
> +	int err = 0;
> +	int ret;
> +
> +	ret = fh_get_range(fh, cmd, &start, &left);
> +	if (ret)
> +		return ret;
> +
> +	ret = fh_respond(fh, true, true);
> +	if (ret)
> +		return ret;
> +
> +	for (; left; start += n, left -= n) {
> +		n = min(chunk, left);
> +		len = n * desc->blksz;
> +		if (!err && blk_dread(desc, start, n, fh->buf) != n)
> +			err = -EIO;
> +		if (err)
> +			memset(fh->buf, 0, len);
> +
> +		ret = fh_tx_queue(fh, fh->buf, len);
> +		if (!ret && !(len % fh->maxpacket))
> +			ret = fh_tx_queue(fh, fh->buf, 0);
> +		if (!ret)
> +			ret = fh_tx_flush(fh);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (err)
> +		fh_log(fh, true, "read failed");
> +
> +	return err;
> +}
> +
>  static int fh_power(struct f_firehose *fh, struct firehose_cmd *cmd)
>  {
>  	const char *value = firehose_attr(cmd, "value");
> @@ -504,6 +609,7 @@ static const struct {
>  	int (*handle)(struct f_firehose *fh, struct firehose_cmd *cmd);
>  } fh_handlers[] = {
>  	{ "configure", fh_configure },
> +	{ "read", fh_read },
>  	{ "power", fh_power },
>  	{ "nop", fh_nop },
>  };
> diff --git a/drivers/usb/gadget/firehose_parse.c b/drivers/usb/gadget/firehose_parse.c
> index 89e47659fb23..ff99566eb40b 100644
> --- a/drivers/usb/gadget/firehose_parse.c
> +++ b/drivers/usb/gadget/firehose_parse.c
> @@ -1,13 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Qualcomm Firehose command parser
> + * Qualcomm Firehose command parser and rawprogram expressions
>   *
>   * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
> +#include <blk.h>
>  #include <firehose.h>
>  #include <linux/ctype.h>
>  #include <linux/errno.h>
> +#include <linux/kernel.h>
>  #include <linux/string.h>
>  
>  static char *fh_skip_ws(char *p)
> @@ -108,3 +110,66 @@ const char *firehose_attr(struct firehose_cmd *cmd, const char *name)
>  	return NULL;
>  }
>  
> +/* Decimal only: simple_strtoull() also takes a 0x prefix in base 10 */

Why can't we check for 0x prefix in this function and if we don't find
it, just use call simple_strtoull() ?

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
