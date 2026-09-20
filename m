Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379D8C982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E912940AEE;
	Sun, 20 Sep 2026 15:48:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9jDlkFi0uQja; Sun, 20 Sep 2026 15:48:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 282BE40AD9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919338;
	b=er4yu1s7jl/4WTz2A+J6tFmESI3H40WR2DlR6oryKKnJ5dejctTMy+bIFWfXlyXJd39b
	 4CqCitFDxIh7k7mmJuB3PG4DmTU3KWaCq2nolkd/mYv90HuI85zRIxdBL4t8mw6VoSAyC
	 YKeND/NLIujEp+Pi2k0XYfnzr7aFjCb4mV+14W5XAZzmOvOAjbtQpJPk9svgeSISeXa6A
	 gaBn5wC9vSb8OpIle/q46Lpkshm2M27eYqE3dYQt/IvC9XiCDGpmLDGtLwY+7tSoPZKnE
	 DF1qfVkMUzDJfIQasID5JyomCMuUF1fAsHpJOs8yb8WuUSIbB6woTGh+qNKNVc4mJwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919338;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qvt4DpyAyVGq82iTZSAzBfxsC7dv2LfqsxJ6aYD6DBI=;
	b=qv8lBcKy8xhJaTwUFmwC7MdIEqE6U19SjhVS3bh+8pJeUrFxxVOXZWAPr4g7gGcf++ho
	 OzRP85AC7YS6cFCfyGY+k31pV9BD9UdVlETijIxCWCDwIIGOXvFgqPg9XMzKsYfNoSopL
	 dZV7g0C3Llv/5i+l2M9ScSHH3ak8q/3A9CYDeOmnau7BQH/p3L8Rk8PxV0sPxTZ/Wrkqk
	 EnHdofWDjqVQwMTau+345EJSYm0Tl9/kuGzAlDS6huXKV22OsXlwKMCeE89cASFl8hh1S
	 GKIf6VLwvT2K/q/YpVba+ZFRrcWEN8xSxDol1Uvl9s/oUAttawRBVMp3XkV1AoMPb9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=fail header.from=gentoo.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919338;
	bh=qvt4DpyAyVGq82iTZSAzBfxsC7dv2LfqsxJ6aYD6DBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bovcdTVj1BXzXihZi4a9N51VhP8rcrWclfpmokWcny1j2akFeIwlZnj4546vXYEtG
	 B21YrgfANO7q2vbtRUy6AwGyIWK6+Wv2Wi+1NSO/juQMRmUV8qPBLy0iFQb1FUBzig
	 AUQhNIc28hQcinY9n+omEL2h/0FVZw9JZRhOXbeqhLmsUtvmg2AfNffMeDhDe2e2h0
	 buoYC9cNghVw7es5v7rzY2d4N/37hqI2abl9mBpexIh6jHw5sAw0BaamxssbF9nmFJ
	 dwGm4sSDY6Z7eyRtkEV4w7nlm3yI3m+gYFGMrRnW2XYUnKLa1mb5h2ynoJJB1fhUQT
	 zF7Sv3F7TmofQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 282BE40AD9;
	Sun, 20 Sep 2026 15:48:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EC7A3DD
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 01:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 40F0440A94
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 01:28:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9XFSg9czWtvK for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 01:28:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AB98040A93
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789867705;
 b=EaEliTZ3K1PXX++0HYGOMfT5RvWVap87MhkTdDShJ0/y9pnpd3DpyDjO5xnGwFDz/k8/
 vYOM9vMVa4UaK4OSZRBZhuBLY+UWjhKO2qygb2cElp9nBdZTg0hJ3a5QXvcugrBjhVSPQ
 cytLPSJ9/E9s/KvD9GtkWvoXHASM4dNol+oacD52KgWWXzinHwVCH+ZVO8iu0SiV/pPw/
 RGdQtzOTv1ljTTEmuHFu8aPrfnL8koQ0By+Tmkwa6WHqsJpNYLkrYqoxPdsSUmcY7rl4C
 NeknfYV+rXH1KX7taRYGguS1yUXztJ+eq90v5ToubRCqMxk7LWTJ84TNLCIeDZqKLWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789867705;
 h=Received-SPF:Received:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=qvt4DpyAyVGq82iTZSAzBfxsC7dv2LfqsxJ6aYD6DBI=;
 b=ZOp4qNXq/uVZu5pJuZVu441J/9kp9G6lWVezvEOUYD+8lY6GW4wZHSJFfES/9i6E7yqo
 Ddl6rI/vI3Hr/dZOQjb5jiXqyXNplWJY0pj/XmGwCb7PwrxYq2oDf6z+RGdDCs6SjyCpH
 e8Eb1Aobiy64j4AYMmMHw1IEJANCo9aaDiTgn0rr7ysRnJdLDQSPYNcm9VIom8QCSFuKo
 U0AHHzPj/4D9xZHgFae3b9A4SQSgOXSerS5W4b+etfmzVE+m/FYy8LFg7BoXQdQwQt+H2
 ypby/VhCJV7a2LoVHFFV/U+r6xEgL87mWKhlIRPGUw47cMYN+fdNpGHH/MUHtqB9EFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=fail header.from=gentoo.org; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=srs0=isyi=hm=gentoo.org=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB98040A93
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 01:28:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 92C2B60136;
 Sun, 20 Sep 2026 01:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEECE1F000FF;
 Sun, 20 Sep 2026 01:28:20 +0000 (UTC)
Date: Sun, 20 Sep 2026 01:28:19 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Han Gao <gaohan@iscas.ac.cn>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH] cmd: ufetch: avoid truncating storage sizes on 32-bit
 systems
Message-ID: <20260920012819-GYA335888@gentoo.org>
References: <20260919-fixfetch-v1-1-f1e8b54d8a87@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919-fixfetch-v1-1-f1e8b54d8a87@iscas.ac.cn>
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:48:55 +0000
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

Hi Han,

On 04:35 Sat 19 Sep     , Han Gao wrote:
> Storage capacities above 4 GiB are truncated when stored in size_t
> on 32-bit systems. Use a 64-bit accumulator and promote the block
> count before multiplication so 32-bit LBA configurations are also
> handled correctly.
> 
> Fixes: 86d462c05d57 ("cmd: add a fetch utility")
> 
No need blank line here.

> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  cmd/ufetch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> index d4b54f77b7b2..29ccbf654a4e 100644
> --- a/cmd/ufetch.c
> +++ b/cmd/ufetch.c
> @@ -95,7 +95,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>  	const char *model, *compatible;
>  	char *ipaddr;
>  	int n_cmds, n_cpus = 0, compatlen;
> -	size_t size = 0;
> +	u64 size = 0;
Although I don't like using 'u64' directly, but checked include/api_public.h:92
lbasize_t is 'unsigned long' no matter 32bit or 64bit platform, so seems we have
 no choice but have to stick with it..
	
>  	ofnode np;
>  	bool skip_ascii = false;
>  
> @@ -221,7 +221,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>  			ret = uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
>  			if (!ret && dev) {
>  				desc = dev_get_uclass_plat(dev);
> -				size = desc->lba * desc->blksz;
> +				size = (u64)desc->lba * desc->blksz;
you can use CONFIG_SYS_64BIT_LBA instead of manually cast

>  				printf("%4s %d: " RESET, blk_get_uclass_name(desc->uclass_id),
>  					desc->lun);
>  				if (size)
> 
> ---
> base-commit: 211de43d0f954a00a490220c1aac9db298287c40
> change-id: 20260919-fixfetch-d7aa5b94d9b7
> 
> Best regards,
> --  
> Han Gao <gaohan@iscas.ac.cn>
> 

-- 
Yixun Lan (dlan)
