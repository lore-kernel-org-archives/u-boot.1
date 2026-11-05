Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E3606A328
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VHzN3ryy;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=ArV7pGFJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5550580C5C;
	Thu,  5 Nov 2026 01:45:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zZA9j2smHv71; Thu,  5 Nov 2026 01:45:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A10D380C41
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793843149;
	b=gZU6thaKCEPLcYaldC5jel/5YYJDd612hnykS+qpAmtKZSvcsquq0EKVVjSa8IbfsNPV
	 xm5DXZRAAzDI9ZBGrb2xiNZxRlZt8cne53hRrBDZIF+p4BSN/mXapHIpwjXTwO+J4gQ9t
	 FLNK9V+dMDMIOFhZkrDk5ZGxH0o+UcwkEsM49MIQpI+HfNrvvia/zlssmTQjzyUG257DB
	 O95x2pEw4sg+MU42uevCO/gFQSbstzGL6IXYfzp6SoYABOdD9A3GnUbSp/Z7i+/aTeLvo
	 b+z8BuhWaqMdxl9TPaR01Ad5UYnHOW2mYDW/tbai7CsSPkhnnBrGhIWOJIDQf8LNzzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793843149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Nc5thbh6/kpnQGDoba2xCbXKRhMvoODo93TizwOjjpU=;
	b=dQUzPRabtimgKv7UFmKHm/rGFBhgbcco+Zhh40kao4r/Bs9mwL0mgk3QNYjVpvMw+uwn
	 PC6TjRPGZMiJgXLsSyv1jnOvwUGt4DmXkWZBdB5difvyb18qudPMuFPTS3eoO4x44XEOy
	 nD1Ld/P3xK7ODhY/Uc4IXJG2E+MzbSstz6B0TYlsg0fLUR9jdCU73esT3iTANnFMHImD5
	 zH/Fwv5eZZnsGvazuvV1PtvIZ9JjgSke+EpvgWGyzkIPBPhu1zV/NhLpvILKscIMDr3bl
	 D4ivUikloPSChr/Kezexm6FVKOxAz4APEmmVwQr19TcG7tieAO941EKB7sakX0EggvQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=ArV7pGFJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793843149;
	bh=Nc5thbh6/kpnQGDoba2xCbXKRhMvoODo93TizwOjjpU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VHzN3ryyXj8dU72tTgrVjoQxyB4pBjhRoQw993/y3eluRONNP8DpOvPNIJTKJbxE0
	 UjuCxNw/+aAfzOooQCVNzg/cwuq5Rhf88GYY7+IOJwN68FyVcqGC3N/aF4ZN8oJaMl
	 DWTMFYRFtLi5McGKSWlGpiKsU87KdnXH6hPVE2KcVZN5KFC1NW/tFr1hXuYjEi+j+S
	 uxVA4JafGbAzlWXZQPwfi0o7+5lrWP9UOZMMDBKo/molKpX97po5RX/ok9pTg97WbZ
	 DKGEVvIYXSUiR25+/F6c8glUTYkjC+3qKCAN+YRLyRDsBumdWlOzpzWfPxQXeXy12d
	 B0YZx5CuNCmCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A10D380C41;
	Thu,  5 Nov 2026 01:45:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F821362
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 01:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40A3880C43
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 01:45:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_1TSHEfFcHD for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 01:45:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2082F80AFB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ArV7pGFJ
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2082F80AFB
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 01:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793843108;
 bh=Nc5thbh6/kpnQGDoba2xCbXKRhMvoODo93TizwOjjpU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ArV7pGFJ3NdF/hppkFHgfW5ccKTA7cv66G+PKOwtVPlITvZ17r7Es7lFFQsvhL5bd
 uyp+OazHewVTOza6jO7P1/E8RsDEvatoUHfrmXg2xH8qdJDgzAuxRI/wbD1CP03yNa
 Uyb1Fj5+9XCgCX4T70gmBzREiVkzoKLLe0nR5wfciEhVzHLZWJmnsFKarYrtLqDCe2
 0W2+74YC2135Qx7DUlP8b9M0GgdsOegndyLyvTlc7pDDZH5y5oWpKqoz/gqoJfhcxN
 EK+cO27nSDxyzO28PuWuL2k0TQO4H0q/sGUUTwua+Y2LpQCqn4uOTUtdUJkqUsjfQS
 t6900fCjyKqxw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0EF8BB2203A4;
 Thu,  5 Nov 2026 02:45:06 +0100 (CET)
Message-ID: <7115e35e-c5f2-45ba-95dc-759bc7e33daa@freeshell.de>
Date: Wed, 4 Nov 2026 17:44:59 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: spacemit: fix the greater-than-or-equal-to-zero
 comparison
To: Eric Chung <eric.chung@riscstar.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
References: <20261105-fix_cid-v1-1-e44bc1da8900@riscstar.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261105-fix_cid-v1-1-e44bc1da8900@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 17:27, Eric Chung wrote:
> CID 661178:         Control flow issues  (NO_EFFECT)
> This greater-than-or-equal-to-zero comparison of an unsigned value
> is always true. "retry_delays[i] >= 0".
> 
> Since SPACEMIT_RX_TUNE_DELAY_MIN is declared as zero, it causes
> Coverity reporting the comparison issue.
> 
> Now remove the redundant comparison.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> ---
>  drivers/mmc/spacemit_sdhci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> index f5578f38bdd1..3e0e7901b59d 100644
> --- a/drivers/mmc/spacemit_sdhci.c
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -473,8 +473,7 @@ static int spacemit_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>  			    final_delay);
>  
>  		for (i = 0; i < retry_count; i++) {
> -			if (retry_delays[i] >= SPACEMIT_RX_TUNE_DELAY_MIN &&
> -			    retry_delays[i] <= SPACEMIT_RX_TUNE_DELAY_MAX) {
> +			if (retry_delays[i] <= SPACEMIT_RX_TUNE_DELAY_MAX) {
>  				spacemit_sdhci_set_rx_delay(host, retry_delays[i]);
>  				ret = mmc_send_tuning(host->mmc, opcode);
>  				if (!ret) {
> 
> ---
> base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
> change-id: 20261105-fix_cid-fe26c76c2c51
> 
> Best regards,
> --  
> Eric Chung <eric.chung@riscstar.com>
> 

This change does not make sense. We may adjust the preprocessor define
at build time in the future.

-E
