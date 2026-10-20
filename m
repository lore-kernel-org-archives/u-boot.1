Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5FE606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CnPpcoMz;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KU0xqVSm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C940960822;
	Tue, 20 Oct 2026 07:41:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9IasQPRtqKt; Tue, 20 Oct 2026 07:41:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E8FDF6075D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482088;
	b=Ww18L3OyeLnLluymzRrZPq6Sl0Fzss+6nylEhdUPy25is1ZVJEJUxjBHYECS6jJxffa+
	 7/1ibqasQ2LcKW3E8gBj+WjfdVIg2uZ08DQM7iSGQOPmfvnhPR/jSNYQfnAdtwWmmo1Kb
	 DwO5Keoru9Re1fKmbB6qVBmC4cRlfmFybKDb1gEQTExw+WR7yBXPezcarocZTPSGMVTAy
	 siJL8mDRuLUx2a7JWobzA7NxOB63xbwaq84/eijVjN3bVFl1GjPiRgvtt92ZIocetYgkw
	 /BV/lCZy4nreq/RnC2a1bg5r+sASgdHkAa5LuBBQs7L1vDNE1Jldgd8LbsidglYMZ9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792482088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PSXaB+Ve8DuWPzh1fwA8uaAICMg6XQCew2IHMClGubc=;
	b=o6YkE4b7uqQiHAQubq4krsJdkEmk9SZm4/7XfppnDDN8yhCKIy+Oa4VTYuYtxvlSDo1n
	 1c29XiUjphhPKXmbT5Gpc4ZOeJsEy/KIWz2sTheCJjX0fJX9viWqRua8e5WkmIFWuGYis
	 rJ3WzOahjgWJHqNkUxlLDovza/mt2pQm/9Db0F+hUprGcolVXKUyQ7dHHOIXuTwAZgHuN
	 E+gjxVr6ye1kStSjHrWn5yodtP6I7o3XYpOW0ueRcRmmCXd5fNDZVU+4DYBLKk2VqATkB
	 8fqaeEbAhZF/ymnvIY4fpOUVBOtwZ7VEdil0GLtO+vaXRLHET728qLumosSyolwatgg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792482088;
	bh=PSXaB+Ve8DuWPzh1fwA8uaAICMg6XQCew2IHMClGubc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CnPpcoMzyeJDexF3nPqpdPwwIoKS/mCsmPIIhR4Z2A7FQSMKbqXE8k+3kbQpj3967
	 71lohPaulYgOdNyBS+7bmDJGgwYPm+RVNFdYG2oTFAzRHfx4sWiF3eW/uKUuwqy6fW
	 LHBFQKj07/pAJaHjnmsmum1i2q9Ngd7bdNnoUDcnmvQmvQeizmTRbPzlD2C7CbbS4S
	 +KVaurRlaqHVO/uCVeGiFgu7a8oXi+aD7j+fBMBumf4XeIfkO/34ZZMtxOs3rPFfY4
	 K3YrmEOEICNNmW09vYqAHvEtT78lpfj1bv1Iz5lHvVCeDFG1WldFwwroxY59c9V+Bt
	 l5NWjIbBsWBeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8FDF6075D;
	Tue, 20 Oct 2026 07:41:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1361D23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 056E940817
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:41:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xTrmXhXhyOSz for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:41:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3938C40812
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792482085;
 b=oyo5yoSjo3NMrAthOciUy/DBV00uTqjwtpK/l/3JxMQ56fkJ4Hk4zj9RbBRV0FE964pS
 eTQXYgJ1Q+wJaUDiR174D82Qj08mzGxR5+/LZsOe62esrHh3aQt++jeFpFZhKHLe7ZdDv
 cYRQrpNgNrgYPbx2HgbNjpM62AGGDJxUvG5tI/nbt8GvrlijOc8J3xBOCQC50sjU2oxG2
 W2SposONlj9GEzBPZdgapsUa77IOxTK0P+EgNti9fs76nyefuW6vp/SSeJtDlHEjZhHJn
 NfG7bc933C0HEKhpnGOeEB7XBYHwYr48BtLeAmBNk+sDKfhjvmEmytGKXu3yQJyPmAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792482085;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=PSXaB+Ve8DuWPzh1fwA8uaAICMg6XQCew2IHMClGubc=;
 b=iDme2Ood0MqhqERjt2V7dDBoh1oVsR5n4Kyet4//JL4u/vaes0h4I1rVSMh2Ij7uMNb0
 Zd7YikJDekpaQThJdMpFfEwLQZT215LbTrHkqp1PXV1ifeJy+hR5MiyblGwUsGxa4dJ69
 0PqLrFQ2nFXnT3Bwh+9rzyPUYgynoae2vaJC8uYGbVfXM8dY11n8q7q5LapLkS8JLgSq8
 UTKS84nDflhDamzOOGQK3UyNoynx1GGdIHSEpxNGd5jm4bc/55tyrCaTo1RGcln6zPjI3
 oXWNeIyWp1Y/xUMIu1dYca3dPJFuUhMCJn4d5R6DOHOTIe/m9GJyQVGKopCLz/fk7xw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KU0xqVSm; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=KU0xqVSm
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3938C40812
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:41:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7E2F60DAF;
 Tue, 20 Oct 2026 07:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0201F000C5;
 Tue, 20 Oct 2026 07:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792482083;
 bh=PSXaB+Ve8DuWPzh1fwA8uaAICMg6XQCew2IHMClGubc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=KU0xqVSmDbRhMbAB2MJyIHlKwRaZq6H9tuOqfGyZcKMBIiM2sfnmHRd6MfaZWqjFp
 fBK+B3aqbWN20rlK1CfaUi1a+G4ivGmhjhO4EGx7h2du4nYfb3nErm8dT5F96CmjvJ
 QNNWpVaUV2znL+7e6sVnITqhcKL9LTYF0WkgiKq9tNgsiKhfIvbNeSfvhgsCL2a69d
 dVbPGZJKI6osoDtYk2brolYEeSvcm2v7+7JTCHpOBLRRkaBnNnkJRoWMrEp+yMLhz4
 KG+rxYzVlfK7g8Zzf1754TlXoHs5KTL+I21o4MgtoDg0M7UnwCm7tHjrQF6NwTYjAz
 j5klv0cQSXCsQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Shahriyar
 Jalayeri <shahriyar@byteray.co.uk>, Quentin Schulz
 <quentin.schulz@cherry.de>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/5] cmd: avb: add lock/unlock commands
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-2-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
 <20261012-upstream-avb_lock_unlock_b4-v2-2-87460a24e559@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:41:21 +0200
Message-ID: <xhkdb1p9k6cpq.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

Thank you for the patch.

On Mon, Oct 12, 2026 at 22:25, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

> The OP-TEE AVB TA stores the device lock state
> (TA_AVB_CMD_READ/WRITE_LOCK_STATE) but U-Boot only ever read it, so a
> device backed by the TA could never leave the unlocked (orange) state from
> the bootloader. Add avb lock and avb unlock, which set the state through a
> new avb_write_lock_state() helper. As documented by the TA, changing the
> state resets all rollback indexes.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  cmd/avb.c            | 40 ++++++++++++++++++++++++++++++++++++++++
>  common/avb_verify.c  | 23 +++++++++++++++++++++++
>  include/avb_verify.h |  3 +++
>  3 files changed, 66 insertions(+)
>
> diff --git a/cmd/avb.c b/cmd/avb.c
> index 6f8df7ecb6d..5e45975d349 100644
> --- a/cmd/avb.c
> +++ b/cmd/avb.c
> @@ -522,6 +522,41 @@ int do_avb_write_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
>  	return CMD_RET_FAILURE;
>  }
>  
> +#ifdef CONFIG_OPTEE_TA_AVB
> +static int avb_set_lock(bool locked)
> +{
> +	int ret;
> +
> +	if (!avb_ops) {
> +		printf("AVB is not initialized, please run 'avb init <id>'\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret = avb_write_lock_state(avb_ops, locked);
> +	if (ret != AVB_IO_RESULT_OK) {
> +		printf("Failed to %s the device, err = %d\n",
> +		       locked ? "lock" : "unlock", ret);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	printf("Device %s, rollback indexes reset\n",
> +	       locked ? "locked" : "unlocked");
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +int do_avb_lock(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +	return avb_set_lock(true);
> +}
> +
> +int do_avb_unlock(struct cmd_tbl *cmdtp, int flag, int argc,
> +		  char *const argv[])
> +{
> +	return avb_set_lock(false);
> +}
> +#endif
> +
>  static struct cmd_tbl cmd_avb[] = {
>  	U_BOOT_CMD_MKENT(init, 2, 0, do_avb_init, "", ""),
>  	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
> @@ -537,6 +572,8 @@ static struct cmd_tbl cmd_avb[] = {
>  	U_BOOT_CMD_MKENT(write_pvalue, 3, 0, do_avb_write_pvalue, "", ""),
>  	U_BOOT_CMD_MKENT(read_pvalue_hex, 3, 0, do_avb_read_pvalue_hex, "", ""),
>  	U_BOOT_CMD_MKENT(write_pvalue_hex, 3, 0, do_avb_write_pvalue_hex, "", ""),
> +	U_BOOT_CMD_MKENT(lock, 1, 0, do_avb_lock, "", ""),
> +	U_BOOT_CMD_MKENT(unlock, 1, 0, do_avb_unlock, "", ""),
>  #endif
>  };
>  
> @@ -579,6 +616,9 @@ U_BOOT_CMD(
>  	"    and print it as hex\n"
>  	"avb write_pvalue_hex <name> <hex> - write the bytes given as a hex\n"
>  	"    string to persistent value <name>\n"
> +	"avb lock - lock the device (verification errors stop the boot);\n"
> +	"    resets all rollback indexes\n"
> +	"avb unlock - unlock the device; resets all rollback indexes\n"
>  #endif
>  	"avb verify [slot_suffix] - run verification process using hash data\n"
>  	"    from vbmeta structure\n"
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index 09f1534c3cc..9231366d5fa 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -1056,6 +1056,29 @@ free_name:
>  }
>  #endif
>  
> +#ifdef CONFIG_OPTEE_TA_AVB
> +/**
> + * avb_write_lock_state() - sets the device lock state in the AVB TA
> + *
> + * @ops: contains AvbOps handlers
> + * @locked: true to lock the device, false to unlock it
> + *
> + * Changing the lock state resets all rollback indexes in the TA.
> + *
> + * Return: AVB_IO_RESULT_OK or an AvbIOResult error
> + */
> +AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked)
> +{
> +	struct tee_param param = {
> +		.attr = TEE_PARAM_ATTR_TYPE_VALUE_INPUT,
> +		.u.value.a = locked,
> +	};
> +
> +	return invoke_func(ops->user_data, TA_AVB_CMD_WRITE_LOCK_STATE, 1,
> +			   &param);
> +}
> +#endif
> +
>  /**
>   * ============================================================================
>   * AVB root key digest providers (selected via CONFIG_AVB_ROOT_KEY_*)
> diff --git a/include/avb_verify.h b/include/avb_verify.h
> index 66655aab871..d2136b2ce02 100644
> --- a/include/avb_verify.h
> +++ b/include/avb_verify.h
> @@ -45,6 +45,9 @@ enum mmc_io_type {
>  };
>  
>  AvbOps *avb_ops_alloc(int boot_device);
> +#ifdef CONFIG_OPTEE_TA_AVB
> +AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
> +#endif
>  void avb_ops_free(AvbOps *ops);
>  
>  /**
>
> -- 
> 2.53.0
