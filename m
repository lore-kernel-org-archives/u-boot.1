Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EA3CC6B0F
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 14:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E57E40518;
	Tue, 13 Oct 2026 14:20:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OHDkzld6JtYy; Tue, 13 Oct 2026 14:20:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F0614040E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791901236;
	b=db+70OJbxD48MB9eAqvs53nF4TccQK+VXM+SkIBFzRC/EyS0wa8wFDKgfzPjE4VfUplT
	 emHonMoxrQj4zOw0pk2Uq3vbXsrgzDD1c1Gd+Lk7Dh+3SW5/bgnDiHuiA3OBsmL/q6TWi
	 VMzZZolMTVk+rF7xLg2uEmAnZubVavCmICqhFnvPfY9HImDUidkisPXRBIHY0iEg3Z3gN
	 O7+ZsBnwGNZaM0ij+7c6f4/vtyCVwGBNy4Kjnc28sB/S3qUYZxitfYTuEmE04DzMkUqnL
	 FVVc4+IT6RT8EtAWLYx5stpeP39OHwBpbHO9FuCtDSZ51jLbGhm1gxy7JPKwR4T6Slg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791901236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J4nIehZ5nHgcpq5BADeN4kxS9PhW68Fp4Cbb44Y2QXU=;
	b=nalxWooMh/iOa1ibr4tw1Pr5rDpPRPKz85MhT9Bc6+IdkRuvIyNiFXis1ukBTjjItlC1
	 hlQ6+BWY3yN6cDZIpSlNWWiBVjbHOGwR1dWUwq3R1rco48W2Z6mHTbK8YI0sUs8xMISIn
	 Fu2PC6sbeK5eW2n4fNHQrKMv7yfS2TSB5NJllnrxYIBE2qXQ0l+5NW/bwmUGqpzlYzFQL
	 NU1PHjfPiHAw6+tMNgweLxRAjuuAWTPR/tk0BVFRxA5hy6pe0xSOUfjsBdvH41hTwDWG9
	 /C8SfMq1yfwv/ocj9Ew16OHwxBGoMwof3QR0Sr+PqniTQASMwVwTzGXGSH/Y149JCiw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791901236;
	bh=J4nIehZ5nHgcpq5BADeN4kxS9PhW68Fp4Cbb44Y2QXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GRN9agJsKnH06npKPDp4zyK7rtuEmdfvY9dNPxRVZLyS8sHGv6htJDzj9CPdmlLOP
	 6m6LK301IFb4JBZHvy0hgLGEx5OlSTihe86tZ5d3SxKak+jw9VPW9r3jtgc8X9j+tw
	 b5PdjrGs07bloaCP1as+bfHsPp8oW44KX8v/r05HRQcfRn3v6p/U6gsl743yQKLkOV
	 1Rl3/rXlISvIHb0AJbA4iasNLfKvTyUD5IHzJnhuxvid09raDtvQHDmPud7EEfx3yH
	 1IEPT4D2eRu2MrQ52pfJ4P4LaUdK+5XCy/KehYcuIZeE2/tLIxN8Sf9HBtbMS10nAJ
	 tMTWM8jPtL/Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F0614040E;
	Tue, 13 Oct 2026 14:20:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FC1ADE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21C01401EC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:20:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rEw-5X1A39Co for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 14:20:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 28AEB4010F
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791901234;
 b=Fb7E7AlsRgFhRzgUbthy/MpD5g7pv0aMVRekltNcYw3kMEEow3mbTHhelE0hmlPqRJLJ
 QO3qKnl7KFCECnjiCnspw9qneGSsYSrVPIiH+6s7U7CZhBu6dKfmsmchcok7sjVEt2Opz
 dvBxrpfctDA+bsgVr1xKRewSmY4mETem9OU+luHT+LP6fD6w+8mkHxRvkiNSaziCipWYG
 v7f9K0jFHXCT7sjcll5/QTC3WqzJDUXOQF4F+gjdHNI1Cn0i1Evwd/tuGTTzAs8bZKg6g
 QwPx3Z6VOHSlwNujYtt3at13IsYPxg32oGCof8eNkTbcPP7+9TJkxQc2dKkJs00Sg1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791901234;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=J4nIehZ5nHgcpq5BADeN4kxS9PhW68Fp4Cbb44Y2QXU=;
 b=rynutlG6L9yaBnblvx4CG7X5/NcHC9WPAdXtpOgPyv6PDS0AmqB2w7bdVWqZS+as3hOm
 uozgPrYBdPn5FTNprz+s1P0EHdw1ZHnuASRFHiitD/1HoT8EnvyMJQ9FeK4YIx9VF76zZ
 Fim0nW538b3OTw2+5TAu8gQciGV5KTIwoPZI+HU2Qzpj3PoUYnZ4j300AaujRW/1VdtBo
 cwKAuaqezufyyaogRnKW9G8kYjpMDCrvO23CxpVu/gJBoCT4FW/zFrjn9K5cDlxDJNbRD
 XRVthTaf9u9u+ex4ZcEQyHTedq6cHwvzZ3v9YlACk68R8BKrPTBGrU3ARB6IacfRCMw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="FGJI/ZMl"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FGJI/ZMl
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28AEB4010F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:20:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 80099602C3;
 Tue, 13 Oct 2026 14:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B698A1F000FF;
 Tue, 13 Oct 2026 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791901231;
 bh=J4nIehZ5nHgcpq5BADeN4kxS9PhW68Fp4Cbb44Y2QXU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=FGJI/ZMlpDmlAHMavkwKEsm544+3Re9zMNDovdWuNg7W3jT4iDnRskCXOSp0ZrXcY
 PRJCwi6xuDNpf6cKx+BHadcBDO7BSOQJ8IR0REsdepvqRFqKKY5bqgoLK6aDEJlRFr
 P8//uu1SVoxg2KN55EVefyzsE0T0hIVCJkaQ5iZ2VKZ4A5La9WCUAyCeaV1Nc6ksqQ
 4ssDdlvUeSGuzOOV1FDzQbpYHMdn5nDwOGS0snLnbaKK3CAQtL6/zCCWYj04vpH8zB
 +tkwVFOMQ30YKZMxjwt9h8T5nq8Xxy+w6QI8OSDGO3N7QjZn0qwlGRMS9hf0CJhje7
 wkEIadN2fbCcg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>,
 u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, Sean
 Anderson <sean.anderson@linux.dev>, Casey Connolly
 <casey.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Antony Kurniawan Soemardi <linux@smankusors.com>, Petr Pavlata
 <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, Petr Hodina
 <petr.hodina@protonmail.com>
Subject: Re: [PATCH 1/2] dfu: expand ${...} env references in dfu_alt_info
 before parsing
In-Reply-To: <20261004-b4-dfu-alt-info-env-expand-v1-1-700eb0e54b61@protonmail.com>
References: <20261004-b4-dfu-alt-info-env-expand-v1-0-700eb0e54b61@protonmail.com>
 <20261004-b4-dfu-alt-info-env-expand-v1-1-700eb0e54b61@protonmail.com>
Date: Tue, 13 Oct 2026 16:20:28 +0200
Message-ID: <xhkdbjynl7kcz.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Petr,

Thank you for the patch.

On Sun, Oct 04, 2026 at 22:48, Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org> wrote:

> From: Petr Hodina <petr.hodina@protonmail.com>
>
> As dfu_alt_info is read via env_get() it needs to expand the ${var}
> references using cli_simple_process_macros.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>  drivers/dfu/dfu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> index 90d8b45ce8a..fa074db242c 100644
> --- a/drivers/dfu/dfu.c
> +++ b/drivers/dfu/dfu.c
> @@ -6,6 +6,7 @@
>   * author: Lukasz Majewski <l.majewski@samsung.com>
>   */
>  
> +#include <cli.h>
>  #include <env.h>
>  #include <errno.h>
>  #include <log.h>
> @@ -178,7 +179,20 @@ int dfu_init_env_entities(char *interface, char *devstr)
>  		return -EINVAL;
>  	}
>  
> -	env_bkp = strdup(str_env);
> +	/*
> +	 * Expand the dfu_alt_info here as it's read via env_get() which
> +	 * does not expand references the way hush does for a command line
> +	 */
> +	env_bkp = malloc(strlen(str_env) * 2 + 1);

Can we explain why we picked strlen(str_env) * 2 + 1?

Is it an arbitrary choice or is there any justification?

> +	if (!env_bkp)
> +		return -ENOMEM;
> +
> +	if (cli_simple_process_macros(str_env, env_bkp,
> +				      strlen(str_env) * 2 + 1)) {
> +		pr_err("\"dfu_alt_info\" expansion ran out of space!\n");
> +		free(env_bkp);
> +		return -ENOSPC;
> +	}
>  	if (!interface && !devstr)
>  		ret = dfu_config_interfaces(env_bkp);
>  	else
>
> -- 
> 2.55.0
