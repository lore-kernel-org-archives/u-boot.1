Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F2606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=07RaJqCb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bp+lINE3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECB9040820;
	Wed, 21 Oct 2026 06:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4hvNQ-ZfGAu8; Wed, 21 Oct 2026 06:28:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3DF884080F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792564122;
	b=RLQ2YAA+XppWcWid8V34nITRIZrYRdn495fXy+bmkm+TLYHE92fgM18uT/k9W30n569+
	 HE03J5eeocgYwayY9Q17ZrSWoWAF87dvrG0xcHiMtVN7Wbl0VrfRfAvAi1cwK7Kwn88dQ
	 DUoSjJ6gmMdLkj9nKglyJT3VotrgAgiBON+qqP1cgL4pcMwQgTSi0GO7eaj2PRKK7L04e
	 Dzo3wlF/LwPsFGcR8KeSHLUiX9Oge8ICDYhNX9/JVrVIhIqF/6wvVb1Mk1Yg9ppKa23Zz
	 mOl0F7XK5C20vY8p5owG9KOYbqTLrA4aaZIOSeLaoyZfeCPvYKZsPyN99/8ena6/nCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792564122;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=COz1ZXVomeFjBxBbMpORROiVIXT+M0K2CXWP+J6JMyM=;
	b=U4qSbFhdkkClsGvA1e/rkxITEALfZwZBc2fbkwsuZp9bD+FGougMqHaM5IkomShuHI28
	 9A0dqE1kK27bNQ2fw/t/vwuKmGw1JRl0xC0I+l/XVBlqJgZE/O/HvbUbg2gjxUGJnjr60
	 mGh3UppNV8lpxKzEfF6VvsMsbLUwGVY/fOjb3CAAMK4sNkVfaqQjNqxcOFmqoAEy+ZSHA
	 vmpNwiVpfwK1cYLql+MFfg+ell3p+TEsuWpXiBfvpa0mOy7zIbhw6fX71vfWC8guOudzD
	 OI/1lH5O4sMxaM7QwGHVDmlyeR2ZMjJVwSfvMFKz1YuFL5uJv+K/4n/QKziseXza7og==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792564122;
	bh=COz1ZXVomeFjBxBbMpORROiVIXT+M0K2CXWP+J6JMyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=07RaJqCbUyg2bv87ZBSVscpmQhxSmkppP6Z4LAbWgnEAWy6ojrdrhOQaUyx8sGPuu
	 5mbTPXkAQJVn3wAJf4BE1ZJuCsHIxEpgZhCZKKgxKRNY5O5BY4mniQtHbA6yBvioRF
	 dl6SFLIOMtAsZgIMJdAkmfIzPtLq0Jb1BtdGJGSK+LEkl9gFTWYZW18t1SIQCndaYJ
	 zy87KzhGHO7JByTfMW9oVCxNsB7l1Dmo7aL1ZfIoCbzykcqKT+Zn0ZVeyvsYdWG3ef
	 AEMo/TvHuzWSz27XA7Ucsrn0v63n8JDkJChDtsc+jttm/I5geCPHupxPMEJarNS0cg
	 Kzwx5AiKtO2Rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DF884080F;
	Wed, 21 Oct 2026 06:28:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BE5E33A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4407809B7
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:28:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xlNYteCZv3fG for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:28:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EEDD780956
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792564120;
 b=MN0KsCdcab8UVZ6mG4659B0bSqZIu/nmhuewlppaqm/6WjVYMyJ1l+lW4nV3eCFMEgM7
 qA2KO+zYwyti4jz3UnE2leAouA6Te5c9fY8Iss3Y9CScfcnK3FkcgRqI0Eawzc3IWZIOJ
 ikTcBYlTzcfUg+a6rQMJ023iEgs2W5f2ZTAlEy21Vt4BpO2vVcATteeufThuxAcsrBQsO
 Yr6g7c3DdPRAULpi/rwM6lk0Lan3LOcHLlr2d7LTPuRrLWhcjjNvp1mczQQ8ChIAhZbPf
 xucg+TiA5+ENFFLlnNBLXeFUyycD78M8eLiMzqr9pJnyvKMaMkdKcSfQLbfzkBN/eQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792564120;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=COz1ZXVomeFjBxBbMpORROiVIXT+M0K2CXWP+J6JMyM=;
 b=oMc3kxkC3RCHHHtQr0MoDWs2KzDQNalXYmXMxd+kKz1DIlbIKlLXshG+vqe4E3y3OorR
 J1ttHAjp4GTiE45zUg+e6Jp7oaiT1DrjpS+H9yYphkJ+3Zoc2AvpkR5TG+UVu2k/lRm95
 uZVUtsz3wia++9Iwfu1Dxgpmeyj8P8P5r0gmcHpRh5hz8WP7eBoRn821FHJ3IpXD1qy2n
 enmqah/WYHOS4rFkJNsTWuB7fmma3LXlJ5HcR+0Irx5AAo+Mh6PWDEm/7AYds4xUEWZDS
 YJJAAA+BbDsMw/lkL5qxE7Xw2Wg49B5JWCN0e9qtPO2UjFMp6vG3ksXE/9IzvBgz+CQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bp+lINE3; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bp+lINE3
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEDD780956
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:28:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A326760142;
 Wed, 21 Oct 2026 06:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDDB1F000CB;
 Wed, 21 Oct 2026 06:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792564117;
 bh=COz1ZXVomeFjBxBbMpORROiVIXT+M0K2CXWP+J6JMyM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bp+lINE3EkAIV2gklAVbKzZQJkaJ8Sac14NSRAgnz3xv/JFjcIYuCkmGY9Sf+bAP6
 M3czjH327XydrhcQKkm2s8Rfy6EBHDukPUMEAJx3ppfTkQRDwH24kcQXlSGg0NaL7Z
 fj37IolMzMtiXB0Am21FmVLUNdhxTNXPmkz7PyPrRBlT4kKYTCquAiZkPQQsfNrCkr
 Ngmoi9KzmoLK4fb36XSuscUDRB8cY6oF6FmRi2VxJQ4Vtodvn8Xw8hfdGXEbiSdBvd
 +3oniri8n4VlzwnLqSUb1LYtBnvncJQP4wV0sPP4L0A1qC3XqMlRguy6Z5fvzFvbRP
 oILPcbUnvUexg==
Date: Wed, 21 Oct 2026 06:28:34 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 4/4] configs: spacemit: k3: enable eeprom tlv command in
 main app
Message-ID: <20261021062834-GKB65567@kernel.org>
References: <20261019014044.698294-1-e@freeshell.de>
 <20261019014044.698294-5-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019014044.698294-5-e@freeshell.de>
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

Hi E Shattow,
On 18:40 Sun 18 Oct     , E Shattow wrote:
> Enable "tlv" command. SPL is not yet upstream so this is only in the main
> app.
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  configs/spacemit_k3_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
