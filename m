Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A546606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h41VE+Cm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIBKA68X
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE4516075D;
	Tue, 20 Oct 2026 08:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8mKtnvChRCPq; Tue, 20 Oct 2026 08:23:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3039660822
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792484610;
	b=Q8R0jlLLid0A+dOXGyLdAVTY9MWWJjm5kzuJpt7T81hb2UyVWJdXDF4QGfNpYUuNcIvi
	 86BraV2ivJvGdaCZFwtHsVKzgfivdz0s4g9LeyaQYEwBYKpwPy8/2w++vL6d/cHdAR+9v
	 BVTlJ2Ba4xqp/aOFAPTE6YZmIyLJgy4UN4jXobLqbOOLbuj4upbHpcaTvnitRQ/M6lIwO
	 bImtR487m5i4I+FmAzePsEksKiwZqzRNMC0itAOmhTM4lLf9zRxz2v2F1Ua0Q+TVWsMTN
	 WYpehRXMlsRmGO6j76rQp6hFmAbULGnHNNmRnejI6f7G0CvCaj51lfaNR2Dgp45WX1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792484610;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MjBTsxmuNr5V6U7cx1QW9m/FNBP4LtMLdUlKW4vr1YY=;
	b=oNUm1NpqaDdLTOJemzEn3MAfdzLtRYG3yfjfiJ/29Vq32UrP5GZ94g56ENFluiOYcwzv
	 GBh6fithtrAVk9l8RgrB43Ko+1p5JjjVwGkvCGZscGvdB4jY6pgPSl/PXhq69mqgS92g6
	 DQ6gBLNOiRopscodImD2W72fLba6LE4sZR34fqTcejlekglf0oD1P6TvGMMWMZ/mU4ZEk
	 hmG21tv+2g84kNjDYrSXxM+qRR43kLNH49OBQ9edbEON/omHesmDSwgjd5d3xNYs09Acw
	 4mb28IDt2tvWGZdZq4ly2LbPz9ba5NEa5tk75Qfhe02uzZbGiw4twkvVx1GLi2bWCDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792484610;
	bh=MjBTsxmuNr5V6U7cx1QW9m/FNBP4LtMLdUlKW4vr1YY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h41VE+Cm7WMK0wJRRvFGWdgvsjHnD6kAFkpKqCHMOU+MTN0GT+H2EHeAW8LD7Fq5q
	 Qw8w+xIJIQF6V5kRbdC6asidX1AVbZ1csnLtOQLamqnJ1z4kn8aqhoVW0G0eazBRNt
	 Qbzgp0S+XSEkWkGesPb570EWXziy3c4OSyTRCa6cYsmeeRyDiZjsowwSzzVaGdnXrG
	 GUmMCTJFkwKTxd29koTAPuAkhp9J9lHE5/HE1+DDV3QVbOwNPMgUPxycJ5b3UP5Yha
	 rs2wQGEbYoEvN7h8jPPrxWzMuLBRRtnkkNVclXMYM6IoIjKbnU+n3PDkVtEsdTEpxW
	 zcjX+upBcFqvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3039660822;
	Tue, 20 Oct 2026 08:23:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 363A31E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F002407E5
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:23:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oYj95zYqYWJu for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:23:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 462CE407E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792484608;
 b=ZJic7ULTQp3TSavYIXgeILFkJ0ADJvOTer6HXixL7YwT638VzuDUD0AMoLtmGvlFA2Rx
 bgSN3ES/zhkydBc6FDkF3rt5LbgdFOHU8w1m695WwqnKANPLkc1lk/V0F08w3Of9gWLL7
 JiAsuwxx175yn/mL7GYtW6oBWGQcwmeWzxe05LqNg/TCpLCVQfTeqztK6o6t6HyFILFJ9
 La/m6gU9lU3RgxuFBry/OyDWK/bY4BYLsF3EjoS5tqUgYifHutcSvrMdd8Q46VRUHE4Gz
 n6YhbpnqOgJ3L84ecpbaEAj4OUeCDKeZJRpYlO2uBB5QK4rOSHr1xgKEM5jIDzJwppA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792484608;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=MjBTsxmuNr5V6U7cx1QW9m/FNBP4LtMLdUlKW4vr1YY=;
 b=eZsVPit0P4b22kcVl0nYTV4kLJcE6yUcovnx1dgfiCMYWwIDdCjzp0RBu0XqlLJdzJfN
 Ln4lBjbCIIgVUSHw9zuQw7EWp9KrOy5xtkMN6CzMvfm0Xnbn4IH4jd7kPUgnwgh/Hupc4
 YIrTE20g/FpTHUKHrhsBR+a4v67ZazzJ24RUWD4Kqrer282HSLb5yos5TKjnhDSrRsibH
 bfVga57/OIgvDe3KdVUa+nyYeIq+MjYFewE59zEEKhqkViHGxhBxHMGF/Z7GKRf7qqpKv
 vVOHRECH1H5pgJ3vxS/P+Rv/+KCSJnq01F3uUDSTgxb/teWIa0J7hAWt3BGJVrJtXtA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iIBKA68X; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iIBKA68X
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 462CE407E4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:23:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E1B1443B0D;
 Tue, 20 Oct 2026 08:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAE91F000C4;
 Tue, 20 Oct 2026 08:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792484606;
 bh=MjBTsxmuNr5V6U7cx1QW9m/FNBP4LtMLdUlKW4vr1YY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=iIBKA68XT27tBzc09s0gCpPcv2XiD6ejRXC9on1xcTCiet/bKv2cHCxI9BM6m2rgS
 aN5Vrep1P/ORlmY5eWylxIILKlMtoh4OhKI0IB6CLjUuLgxi/HedDFll9Cyua/yaHU
 Qo4HFJk460ovmejdaHX14uYmJzACTcLkfimHHSWt5lgy4oYgqMPYDR+y7xmuRZPNDt
 9WoI0qNJOq7MnxGVCXibf1BEldZQwxb/EMHEkvDZtA7y11CZZw2VDLklU9uTg/lt8y
 mCdf5wO2SarYrNuW382o4tg7kdfCpdzULIAoHdIoV5fkT/ig6VFZIcqf6OJ2s1tdMj
 6oW3UM2vqeUHA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Shahriyar
 Jalayeri <shahriyar@byteray.co.uk>, Quentin Schulz
 <quentin.schulz@cherry.de>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/5] fastboot: add flashing
 lock/unlock/get_unlock_ability
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-4-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
 <20261012-upstream-avb_lock_unlock_b4-v2-4-87460a24e559@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 10:23:24 +0200
Message-ID: <xhkdbv76w4w77.fsf@mkorpers-koolstof.csb>
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

> Android's fastboot client changes the device lock state with
> "fastboot flashing lock|unlock" and asks "flashing get_unlock_ability"
> first. U-Boot has the state in the AVB TA (avb_write_lock_state(), used by
> the "avb lock/unlock" shell commands) but no fastboot front end for it, so
> a device could only be unlocked from the serial console.
>
> Add the three commands and the "unlocked" variable behind
> CONFIG_FASTBOOT_CMD_FLASHING. As AVB requires, both transitions erase
> userdata (and metadata, which holds the file based encryption keys) before
> the state changes and are refused when userdata cannot be erased; the TA
> resets the rollback indexes on a state change. get_unlock_ability always
> reports 1 since U-Boot does not evaluate the "OEM unlocking" setting
> Android keeps in the frp partition.
>
> Tested on QEMU virt with OP-TEE over "fastboot tcp": unlock and lock
> erase the partitions and flip the state reported by getvar unlocked and
> "avb is_unlocked".
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/fastboot/Kconfig      |  11 ++++
>  drivers/fastboot/fb_command.c | 119 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/fastboot/fb_getvar.c  |  34 ++++++++++++
>  include/fastboot.h            |   3 ++
>  4 files changed, 167 insertions(+)
>

[...]

> +}
> +
> +/**
> + * flashing_get_unlock_ability() - report whether unlocking is allowed
> + *
> + * Android gates this on the "OEM unlocking" developer setting, stored by
> + * the OS in the frp partition; there is no policy for it in U-Boot, so
> + * unlocking is always possible.
> + */
> +static void flashing_get_unlock_ability(char *cmd_parameter, char *response)
> +{
> +	fastboot_okay("1", response);
> +}
> +#endif /* FASTBOOT_CMD_FLASHING */
> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
> index e8aa0e09aa6..92c8e702a0b 100644
> --- a/drivers/fastboot/fb_getvar.c
> +++ b/drivers/fastboot/fb_getvar.c
> @@ -28,6 +28,7 @@ static void getvar_has_slot(char *var_parameter, char *response);
>  static void getvar_partition_type(char *part_name, char *response);
>  static void getvar_partition_size(char *part_name, char *response);
>  static void getvar_is_userspace(char *var_parameter, char *response);
> +static void getvar_unlocked(char *var_parameter, char *response);
>  
>  static const struct {
>  	const char *variable;
> @@ -88,6 +89,10 @@ static const struct {
>  		.dispatch = getvar_partition_size,
>  		.list = false
>  #endif
> +	}, {
> +		.variable = "unlocked",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (getvar_unlocked), (NULL)),
> +		.list = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)

.list is only to decide if we need to display the unlocked variable when
a user runs 'fastboot getvar all'

In the case of FASTBOOT_CMD_FLASHING not being set, the "unlocked"
variable will still be available, but .dispatch will be a
NULL function.

Thus, `fastboot getvar unlocked` can still be called and in
fastboot_getvar() we have:

        getvar_dispatch[i].dispatch(var_parameter,
                                    response);

Which will call a NULL function pointer.

To avoid this issue, can we guard the unlocked section similarly to
other variables, such as 'has-slot' ?

Thanks
Mattijs
