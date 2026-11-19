Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73807606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QmnY5Bez;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSS1eoE9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 476B940A29;
	Thu, 19 Nov 2026 09:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yPFQ3lpM1U9A; Thu, 19 Nov 2026 09:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 246C340799
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795080686;
	b=NA3nZW7AeV5fBG8sWyEUpGB9Hm3ITkWh7YG+N7IoRmP2wbRGiOsHUqqy7p6GzN4PGBqO
	 fs4d+okBQhyOxNYxisMTCsFkWA21Q2i3iiLTyPTHLLVytgSIHaYcAR485N1XMxemqboqB
	 Iom/hoTf665JcxO5rq2slF2c5dIXoqCmKeC2j5jJKHJsk2WyrRKeL69k9N3BYZy+wzNWP
	 y/mvN2P+2BYmFO4IHAFIiNtNLfir2NtugbSgs71f4RkOopUArPH5b8djFsXB1sih/sK+k
	 Q2VCUyHa/+UeIXtERPbAbopmHcbA41GojQOJdRM+zv57NOWcAtsqfCi41k5Cr7z7Ttg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795080686;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FRosFTyc7qXshWa+ME6kG0D+Jr5IZfoKrky/ZOoCNLI=;
	b=cid1lkR1QqBWoRS4N2CS1ddS44GQNVqqRc1C4KtQjej4IHaFTVmb06LfGgwc4en4L6up
	 OgZCnu6/C93oqd8sx+coHAgTdw17HfTr12VHFxiNmQ642VLyx8r/haw/00AUKiDEdmpdQ
	 8RNSCP7JYAzM96RAce08FCP3FtezVdjIKrDNSxxmFNLfb3mIgfqpHqJW0J5hcbMGdH7bS
	 Ozvs2KFFWuouchRxx/JhLXF+jyMdpZP2dsh3lmUIIlGBlrA1EKzRjgDipKT5dyFd63pN3
	 9f0B6+Quc820PJNxrD3ydTvPAkoZ6bqE+F5HNAjigXkhBM0qPx6DEVfAaBKJj3sXPYw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSS1eoE9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795080686;
	bh=FRosFTyc7qXshWa+ME6kG0D+Jr5IZfoKrky/ZOoCNLI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QmnY5BezgOnwW42N6H1CnGcT7HGus6GmUZrXOWD0jgp1xhdBWxXtpijRva3cuw73l
	 B8Cy1wDXtFwnZPT6tpnUSPGR9KPtWY4YsnGGyDG2cJZ0Sq6GobydGo0XRX1ZmC9t8N
	 vw3uope6iIjX8YyYePcp8QA68GgMnGMiI6U4Nn7zKRVBcArjMQLYrHl15oQw18FlBE
	 EtRoTVjoD9oA+QwS+ptpESmhhTqQvLDTtL/YIEXefxu89O37bh/IZUvceNPiiBUWef
	 u2vnPhTVykBWlzRdJ4uzgz4UbtnW/2E1dkJsuTDCxWTUXFbNp8JPfeOHHYo66I9QAs
	 D791QUVhENNlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 246C340799;
	Thu, 19 Nov 2026 09:31:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 416B8A32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3322940799
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:31:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ufj48KReGDsX for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 09:31:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E8C340792
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dSS1eoE9
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E8C340792
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:31:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A03B61FC3;
 Thu, 19 Nov 2026 09:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909351F000C4;
 Thu, 19 Nov 2026 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795080680;
 bh=FRosFTyc7qXshWa+ME6kG0D+Jr5IZfoKrky/ZOoCNLI=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=dSS1eoE9udvKOg9BO7NAinOrYpL5NLc48F4PXxL4xOMWvWkCLaV2JF5/ZwUu3jO7V
 S0U3OtwoTNGy8cgc532sTZE4P8hCb/74nsMH+oPQr8iiiXvY/7UPh1jSFJuQoZjrJi
 DV9uSv0ZtAQ49K2KNogV1Q1EmKmSYMUlxXTh3ab81zU8QSiWSrl/G70CtyuM0fqBRt
 rd159RhkO85RFRD00BFYldCmJmjYXd/MQJTR4XM7UMNddV5te6CqT4ViNkW6r5Lv6+
 Ri4Z2/s3oL2LlIktrlXyR2jO2bNR0Ab0P7eDmpKO7tbTiv/wdE4ob1LDsLVo1sUQjE
 dom1TtDWSIRWQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] bootstd: android: update the rollback indexes of a
 known-good slot
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261111-upstream-android_rollback_misc_b4-v1-1-47d17e8a5d92@gmail.com>
References: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
 <20261111-upstream-android_rollback_misc_b4-v1-1-47d17e8a5d92@gmail.com>
Date: Thu, 19 Nov 2026 10:31:14 +0100
Message-Id: <179508067427.516692.11077611451436557680.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5509;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=gTrFkUw6bEy48VLE4qskTBF7P8rWw4tgK6v+cNAf0b8=;
 b=owGbwMvMwMUoySu7Jc1P0pTxtFoSQ9a/g0/nM+4Vfca92bek+lBnz5eo7CcCwaZf5S6rOy7xq
 Puyc49bJ6MxCwMjF4OsmCKL3kun5dvks/YFC69lgBnEygQyhYGLUwAmkjibg2Eh55RGqSn2XDqm
 Xhu4H66y9Pl5QntNgJTewpfNy7J3aR2Su7xWlzfZlNlVMiNk6vbeKPWmY5dD6iVvybX6P7eqOvG
 jUzDqmDKvXc/WnZO26ar9flVve2US4/opvvJcUV++fe3XSNc2rLT9wjrzqUJySPRl7Smfvmsutl
 uzJklRLTcmrUhrcwurtplXGbufZc3Df2Xh1t/lhZutEp5fjnr8g/Wc0DfF24cNErdV+D18G9jf+
 6r1vfkpq61b/b6eP/icT1Mt7xnbg2/yb5KucP9wu2GzL+Oe7oTfhrlVRS9+LtNRqXOtfKCQwhj1
 +67mivkd9hv019p1hTOYiQtnnnvhG5/Gfr1XPKTs/LLNAA==
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

Thank you for the patch.

> libavb only checks the rollback indexes of the images against the stored
> ones. Storing the new values is left to the bootloader [1], and the
> Android bootmeth never did it, so the stored indexes never advanced and
> older, vulnerable images kept verifying.
> 
> Raise the stored indexes to those of the verified slot before booting
> it. With A/B, wait until Android has marked the slot successful, so a
> failed update can still fall back to the previous slot. Without the
> OP-TEE AVB TA there is nowhere to store them and nothing is written.
> 
> [1] https://android.googlesource.com/platform/external/avb/+/refs/tags/android-17.0.0_r1/README.md#updating-stored-rollback-indexes
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>  boot/android_ab.c       | 34 ++++++++++++++++++++++++++++++++++
>  boot/bootmeth_android.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  common/avb_verify.c     | 35 +++++++++++++++++++++++++++++++++++
>  include/android_ab.h    | 19 +++++++++++++++++++
>  include/avb_verify.h    | 16 ++++++++++++++++
>  5 files changed, 152 insertions(+)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index f2b1110aa24b..48745f2c2d2d 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -376,6 +376,40 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  	return slot;
>  }
>  
> +int ab_get_control(struct blk_desc *dev_desc,
> +		   const struct disk_partition *part_info,
> +		   struct bootloader_control *abc)
> +{
> +	struct bootloader_control *disk_abc;
> +	int ret;
> +
> +	if (!dev_desc || !part_info || !abc)
> +		return -EINVAL;
> +
> +	ret = ab_control_create_from_disk(dev_desc, part_info, &disk_abc, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = -ENODATA;
> +	if (disk_abc->crc32_le != ab_control_compute_crc(disk_abc))
> +		log_debug("ANDROID: Invalid A/B metadata CRC-32\n");
> +	else if (disk_abc->magic != BOOT_CTRL_MAGIC)
> +		log_debug("ANDROID: Unknown A/B metadata: %.8x\n", disk_abc->magic);
> +	else if (disk_abc->version > BOOT_CTRL_VERSION)
> +		log_debug("ANDROID: Unsupported A/B metadata version: %u\n",
> +			  disk_abc->version);
> +	else if (disk_abc->nb_slot > ARRAY_SIZE(disk_abc->slot_info))
> +		log_debug("ANDROID: Wrong number of slots %u\n", disk_abc->nb_slot);
> +	else
> +		ret = 0;
> +
> +	if (!ret)
> +		memcpy(abc, disk_abc, sizeof(*abc));
> +	free(disk_abc);
> +
> +	return ret;
> +}
> +
>  int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info)
>  {
>  	struct bootloader_control *abc;
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 6f7e232d2c3c..3d1e64aa2b41 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -8,6 +8,7 @@
>  #define LOG_CATEGORY UCLASS_BOOTSTD
>  
>  #include <android_ab.h>
> +#include <android_bootloader_message.h>
>  #include <android_image.h>
>  #if CONFIG_IS_ENABLED(AVB_VERIFY)
>  #include <avb_verify.h>
> @@ -438,6 +439,38 @@ static int avb_append_commandline(struct bootflow *bflow, char *cmdline)
>  	return 0;
>  }
>  
> +/**
> + * slot_is_known_good() - Whether the selected slot has booted successfully

nitpick: Why can't have successful in the function name? This matches
slot_info[slot].successful_boot so it seems more appropriate than
'good'.

For example slot_booted_successfully()? Feel free to pick another one

> + *
> + * With A/B, Android marks a slot successful (boot control HAL) once it has
> + * booted far enough; until then a new update is still on probation. Without
> + * A/B there is no such signal and the slot counts as good.
> + *
> + * @bflow: Bootflow being booted
> + * Return: true if the slot is known good
> + */
> +static bool slot_is_known_good(struct bootflow *bflow)
> +{
> +	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
> +	struct android_priv *priv = bflow->bootmeth_priv;
> +	struct disk_partition misc;
> +	struct bootloader_control abc;
> +	int slot;
> +
> +	if (!IS_ENABLED(CONFIG_ANDROID_AB) || !priv->slot)
> +		return true;
> +
> +	slot = priv->slot[0] - 'a';
> +	if (part_get_info_by_name(desc, BCB_PART_NAME, &misc) < 0)
> +		return false;
> +	if (ab_get_control(desc, &misc, &abc) < 0)
> +		return false;
> +	if (slot < 0 || slot >= abc.nb_slot)
> +		return false;
> +
> +	return abc.slot_info[slot].successful_boot;
> +}
> +
>  static int run_avb_verification(struct bootflow *bflow)
>  {
>  	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
> @@ -539,6 +572,21 @@ static int run_avb_verification(struct bootflow *bflow)
>  		}
>  	}
>  
> +	/*
> +	 * Rollback protection: libavb only compares the rollback indexes, the
> +	 * bootloader stores them. Raise the stored indexes to those of the
> +	 * verified images once the slot is known good, so that a bad update
> +	 * which never boots cannot lock out the images it replaced.
> +	 */
> +	if (result == AVB_SLOT_VERIFY_RESULT_OK && slot_is_known_good(bflow)) {
> +		AvbIOResult rc;
> +
> +		rc = avb_update_rollback_indexes(avb_ops, out_data);
> +		if (rc != AVB_IO_RESULT_OK)
> +			log_warning("rollback indexes not updated: %s\n",
> +				    str_avb_io_error(rc));

So this is ran on every boot? is the index incremented each time?
Sorry if I don't follow, this is a bit unclear to me.

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
