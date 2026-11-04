Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B07606AC3D
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J9NwPv4Q;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=oTW1oEJC;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=p00N/71b
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F70781228;
	Wed,  4 Nov 2026 20:42:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5MetYKV2xp0H; Wed,  4 Nov 2026 20:42:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C8BD7811E8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793824959;
	b=e1Won29eiqf/tbE0Y/LxWRu7wHagblr96Ef3+1NxqkQWSjbiucoN/7Aaoueg6jpRJDeI
	 vcZh0aRVVqRRuQO0OwsW/UnQYx39CKUOUNMN2C8RwWBSZ894VXbqPRs2BoQEm0dZY0bNO
	 lZpPmKg6gjhWbXa9zKzrZTndIIZXVZ2yp/sl49wwRFoPmXQZY3xmFDyk7Xy3PqsrvC9Lu
	 cMoOG8ZmFafoAwWUpTyJE6nRx/eYsiqjsJNlhfXUuGonmBK8HWJ67XQys/XIlt6i8UP16
	 FTIIhTt/3PbvAdtVCYXRlhC3muGOcxl16w7HmYmsSfMhwGz7l5hXcywSpVomV8GpuDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793824959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6fObagBeNScC20tP7Ccdt8LX4xtp+tmDQaj83C8ZwaM=;
	b=HVPyK5qK++EhRED0lhPNqBs7lEfr1cLFkq9eSLOjXwXL+JiLbJZvEPJwQ+/7yOmNdhp9
	 k4/6BCRvVJNgWeOoXQz5w/z4anjsDh2w1978ZJcnyfhsqvyWYKOX1fcl2wwDjs8cinxK4
	 hmx4H+nZIyJP2M5ri88TAzbffT+1eiPkVysT/qjjYFMVdS64ts0JfbCG6zDyK0LYUnsFa
	 Q03Ck8EC0Nf6qV7+BRtXyGiUr9ZPmiTR9rFyGgrDnzDedJ/SYR6qlwFRJBUIpYISbLUWY
	 hvF8z5xVxdsyHp7+J4UUl2JM01GjVduwdL90V+x5FCoUM7C4tEdvu6m/5oWbr6DvfgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793824958;
	bh=6fObagBeNScC20tP7Ccdt8LX4xtp+tmDQaj83C8ZwaM=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=J9NwPv4QX6miN9oL3DZHy9yZKWLY/lbVWN1ThQbJSZJI0czYtRcWnsPs1yvPJdQyN
	 rJJ75JuaUiBvNT+y8pWq1NRkz5HENYIDpFMlgy9MA04erLKr21qUlCHG21fgIHh/Ea
	 0ZnvSzqTB4mv89JRh+1wzu5phNMlGsNjqbGWxk0K0a5f8ycUMJNjr154XzIOt81lJn
	 Wl1ijKTFjPm9szBjoaw10TcDE5cptBczWP2IlN+jgUBdivHooj/zJG5Wx5XDlPLjU6
	 Xu/jorSdhp7yJeyQbZDull6tvAz2ao4OlMWvs8Hzi4Wbr45u4JwMi+1dStLXsDzX1/
	 yAu4W1cAp5fyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8BD7811E8;
	Wed,  4 Nov 2026 20:42:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9074BAFC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DFC24013C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Axk4xvx38z4 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 20:42:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E515C4008E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=brads@mainlining.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=oTW1oEJC; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=p00N/71b
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E515C4008E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:42:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 515C284828; Wed,  4 Nov 2026 21:42:30 +0100 (CET)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D8CB83E76
 for <u-boot@lists.denx.de>; Wed,  4 Nov 2026 21:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brads@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793824942; bh=6fObagBeNScC20tP7Ccdt8L
 X4xtp+tmDQaj83C8ZwaM=; b=oTW1oEJCOahzKf71n5QlCOdRSdB8PxlgWyWPVdnAG4R3dgpiPw
 Dn/026SbvcFUb8PqZ7vkAHiAilC/2UkScH2jkEbwce5mLB9X9EX81OLSEpTrzoPwrNc1Ear9t7P
 4udT92bb7ScKj010dau0Rt7eE1Tc8SglTVeINV6N4rAkCvNoF3n7dmWwe9W9UBWvjOm9n7+SI3y
 0bdab+eayqWfDpmUwMY6Z39dsCa0N+U7vQ2bUaGs0iygGZt+Ea32c/EJyGixx7dchnMojXwE62r
 2HAzdWxBDUVTgYmyr86QVVcXTcjb9g6c451E17lyTwxxqrIZaWyFL0Ui9mHFMtKzViQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793824942; bh=6fObagBeNScC20tP7Ccdt8L
 X4xtp+tmDQaj83C8ZwaM=; b=p00N/71bFlP4otqn9D8E9g11XrzrqVQH8jYSvx7fLZYD3GLbj7
 QMujgGxJtJDhXeZ2clskBOVfT9S5w3vvWUAg==;
Date: Wed, 04 Nov 2026 20:42:23 +0000
From: Bradley Morgan <brads@mainlining.org>
To: xjmps7114@qq.com
CC: trini@konsulko.com, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_spl=3A_fit=3A_add_software_rollba?=
 =?US-ASCII?Q?ck_protection_for_verified_FIT_configurations?=
In-Reply-To: <tencent_6C5B293C811C2C4B1C6DC17B52A6E3C87E08@qq.com>
Message-ID: <9EC565FC-9213-463C-A81D-F0F2FA38BE4B@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 4 November 2026 14:11:16 GMT, eli <xjmps7114@qq.com> wrote:

Awesome. Cover letter got kerplunked.

>A verified FIT is authentic but not necessarily current: replacing the
>next-stage image with an older, still correctly signed image reintroduces
>vulnerabilities fixed in newer firmware.

Yeah. I guess, maybe we could fit a (this is the version you cant go back)
flag into it.

>
>After signature verification succeeds, compare the configuration's
>'version' property (covered by the signature; missing counts as 0) against
>CONFIG_SPL_MINIMUM_FIT_VERSION and refuse to boot if it is lower. 0
>disables the check.

Hmm.

>
>Validated on real StarFive VisionFive2 (JH7110) hardware: signed
>version=2 FITs pass, a correctly signed version=1 image is rejected
>independently of hash verification.
>
>Signed-off-by: eli <xjmps7114@qq.com>
>---
> boot/Kconfig         | 11 +++++++++++
> common/spl/spl_fit.c | 24 ++++++++++++++++++++++++
> 2 files changed, 35 insertions(+)
>
>diff --git a/boot/Kconfig b/boot/Kconfig
>index ae6f09a6..7ec0bde1 100644
>--- a/boot/Kconfig
>+++ b/boot/Kconfig
>@@ -224,6 +224,17 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
> 	  device memory. Assure this size does not extend past expected storage
> 	  space.
> 
>+config SPL_MINIMUM_FIT_VERSION
>+	int "Minimum acceptable version for FIT configurations verified by SPL"
>+	depends on SPL_FIT_SIGNATURE
>+	default 0
>+	help
>+	  Software rollback protection: when verifying a signed FIT, the SPL
>+	  compares the selected configuration's "version" property against
>+	  this value and refuses to boot if it is lower (a missing property
>+	  counts as version 0). This rejects older but still correctly signed
>+	  images. Set to 0 to disable the check. See doc/develop/spl.rst.
>+
> config SPL_LOAD_FIT
> 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
> 	depends on SPL
>diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>index 46ebcabe..9dcc58a0 100644
>--- a/common/spl/spl_fit.c
>+++ b/common/spl/spl_fit.c
>@@ -781,6 +781,30 @@ static int spl_simple_fit_parse(struct spl_fit_info *ctx)
> 		if (fit_config_verify(ctx->fit, ctx->conf_node))
> 			return -EPERM;
> 		puts("OK\n");
>+
>+		/*
>+		 * Anti-rollback: a correctly signed but older FIT must be
>+		 * rejected too. The configuration's "version" property is
>+		 * covered by its signature; a missing property counts as
>+		 * version 0. CONFIG_SPL_MINIMUM_FIT_VERSION == 0 disables
>+		 * the check.
>+		 */
>+		if (CONFIG_SPL_MINIMUM_FIT_VERSION > 0) {
>+			u32 version = 0;
>+			const fdt32_t *verp;
>+
>+			verp = fdt_getprop(ctx->fit, ctx->conf_node,
>+					   "version", NULL);
>+			if (verp)
>+				version = fdt32_to_cpu(*verp);
>+			printf("## Checking rollback version: FIT %u, minimum %u ... ",
>+			       version, (u32)CONFIG_SPL_MINIMUM_FIT_VERSION);
>+			if (version < CONFIG_SPL_MINIMUM_FIT_VERSION) {
>+				puts("REJECTED\n");
>+				return -EPERM;
>+			}
>+			puts("OK\n");
>+		}

I would like to note that Samsung did this I think, well, no, hang on, I
don't know. Samsung when u-boot was used by them for their uhh DL mode and
crap like that, that the arb would be in uhh the BROM (boot rom)

The way to implement this isn't right ISH, well, it's conventionally,
"ok", but my suggestion in the way is to like add a binary flag, that like
tells you a version, sign it, can be flashed, simple, and then BROM or
whatever is responsible for checking, can say, oh this binary flag is
kerplunked, let's not flash it, too old.





> 	}
> 
> 	/* find the node holding the images information */
>

--- Thanks!
