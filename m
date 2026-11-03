Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E5C606A828
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xXhNnqTv;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHRy6nha
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7292680DC2;
	Tue,  3 Nov 2026 10:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vsUSQF1k9Dv; Tue,  3 Nov 2026 10:09:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0A39809E7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700586;
	b=n5+bOxC8uyuwY8Vs8PGoJFfCTJq6BLEtR60AMbIsx7hM0xf8uSCY2izzTCfx5t9yuAk4
	 /3/s+LQ3eymv2rE1lBO1HOXRSDknhTMjs/Pl6D89BiAUxNyKAgn5C6OzeZyYnndCFgpJL
	 XjPq3XlAk+2xa3n/5/KXh+taW3pzyUPOOrtXWbCJgM8I0DQrBjTPyG+uoiRBZB2a96u6S
	 wHaUvXcIC9TphZimC+OrbwMGW+4arruBYlfxLgjJk7tlkc8bEfFksFsjADgbv1lvQXyL4
	 O7/ZJINzc9sKE1dg5K6fAjJ076+mthMjpDZ29S/G84j8IXThOoPXYL7i+TZi6ohg8sQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eTIXg/iJQBqBV1WX8n1ovrdcPuklgXDgJk3MW9n2e2w=;
	b=Jv+mSbRWuAXHYj9xcYf9Z4EAFnXmGz7OBQ6MCPW6wsNTWL6sOqXoKQldr7wa0Vt4rAND
	 rlM0LXcRE3kHEwMKhaDJDHzw4ooU2ldnGHeX0ezzceeIy147vm4akCI/KwK9+IkBJcY5j
	 JcbuBzt/TZp+pkgxaiYlFRX69Z0202cCMi4fc/rxNQ00wZ+Ymfb/YJPirybF9DhomFLDn
	 tz9QUMQn5arbsEp7xe8nB4pTc6B/UPHiTOal9Jkb0FWlnUr+TC4Qz0QZXfOsKd8ETTr6H
	 7nsG5RgIAvFmF7XbaWN4ABtKJ6+Yk/9cMrCVOWhDtbBK9jxtaJcGZiEyLxE0+IDri1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793700586;
	bh=eTIXg/iJQBqBV1WX8n1ovrdcPuklgXDgJk3MW9n2e2w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xXhNnqTvz1lvkz8rwMNLFNk1d54+60Hd4vyhkPHcDffa6zjh2Gm/l0A0m93dOg5cU
	 V6lhZoUfkmvq6BoOqhGHpQF2izTOi0TCRlPXI4h+9pE1idTEM0LLMW96Goqhkd7zsP
	 0MHumY8ptMYpUG4EUKanOfR2AzPvONzRqlMVyu1lHflos4yxWluVQTKohuoLjCrSNh
	 6xjvPCncNMxUkIWTOFjmITUTMjkrju5hTGeP3t7XQyG4m6JcTBkuHhXI1xAR+6piSz
	 7qA3KUt0KvPoZ34kmujNdKg9nfEJEtU5Ltb+wA5MLKXm4GUVngy4hE0f72YN8BHVaB
	 NcfjQGW480cRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0A39809E7;
	Tue,  3 Nov 2026 10:09:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B7963A15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CFCE40080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bq1Ar53LzNjc for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:09:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DA85D4005E
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700584;
 b=rjAK2JLhU++342Kha8q0956UomHfgMlmscTjJ4obLu+Pzjy/LAIHmEghamyhpQi6muMz
 gIQnNK7L3u82YwmqCqQrd74dSbMouco7eePY8nAthxRk8j2jAkOrpR2fdYheJDB6pMfAx
 zQ8m9518IJMFNBqJx4V1TZlxGncmdS3qVYE002bjmiDEp9/tAtv176FgYcwKsY5byZbv6
 /FUf+cURb5gmt2xMVs7Dvw9i5p9rafiRfI4OL5HRlG0DwhSSkHjCWVQkCZ3zfUiBXcJZE
 eznAYwzrmRS8tjvDLF0dr2VWlD52p+18sEiR59E3VtSXFPC10wT0Esjq/Ka8hGXp89Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700584;
 h=Received-SPF:Received:Received:DKIM-Signature:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=eTIXg/iJQBqBV1WX8n1ovrdcPuklgXDgJk3MW9n2e2w=;
 b=Bzc5JRgqMk0xpO+BtdaHlql3gYFeLIbzKV5sKaLDi1xZc6fMf5QD3hUO83M8gQiKXyqB
 ZrCfOHj1fnOt/1SGmmUKlC0IO4kEJtTzjRP/RKHAadaELOEoZ0Q/K4bEptXfR939L1e2n
 l+FJkzKfydLL5soQ3DNIn6Zotr2zZTbHGQ/TytjVsfX4oUcAK4glo89Z6HWXK71zfMMuw
 RuXyfyQF+o3xqfaIoP8Bf9+WaDdIqCixlpQBpXqORCFW7o6UCTwumCyJ6r7uvztC0AxfZ
 RKXKB8dJMR4RMDUpXpEPmYRELSbf6vuoKSnUURjdkZwuq3ulALWRNrYxESBCFj6pQyA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lHRy6nha; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=lHRy6nha
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA85D4005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4BCD6057A;
 Tue,  3 Nov 2026 10:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4111F000C1;
 Tue,  3 Nov 2026 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793700581;
 bh=eTIXg/iJQBqBV1WX8n1ovrdcPuklgXDgJk3MW9n2e2w=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=lHRy6nhaVmHTOEIBxj39ED0HktX2OCWHV1xvZiWl+u9fP49TLSK0LJp7JrAJngKVh
 ZwhNJ0lHOyKYqp/D9rPQ1zU2suIJEWCUc9imG9Epn+zKrXeu/3+G6B3qsnJkre2Fe4
 VNsHEtzyy8B8dz2PPc6ReV38tWwpQ1chGgdDzSHslp5F0MKh9o5ToZuxlbkzyX2ySt
 qM1Qj4OReDMZRAeBeSPzKHH7bAUl+vySaz4gs48StdNwcvKQamPOGRX9kr1aLpFmoM
 SaGSRkxqrrMt4+96oXTRbc6CA4oDJXIc/6Nf8x4f37aSz7dtO0CHtY0Izy3w38ddyl
 06K4kvqNA9ozA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] spl: fit: reject failures loading an explicitly
 requested FDT
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-1-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-1-d29df15fb9b8@baylibre.com>
Date: Tue, 03 Nov 2026 11:09:31 +0100
Message-Id: <179370057186.349126.13750066367082256700.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=uzJzZCgCpw5E3URFNc0oGfLQnzvHgmDM8v9ifdt/0+o=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq6bLeN+C/wq0egcq657em9QEba1chklvnk/Jfz
 Uhhgc5SFsOJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaumy3gAKCRAZDR20Zk4Z
 NeMjB/9aIzFLIHbguPDX030fEF2R5yYMxraowaHh/rO6YOVaom6HM/GReNjjq+m0VdvncGPTdFF
 Vov2eQq54NY2fSJ/8SovBKGQhz41y/BFxmy6rAkJeiMLRs5ZuJYhn1bs/rEos25Zi3Kc+qVGZzC
 WCBRoSeXEbaipUvcxWU6yHe4PM82MrOaX6QXU+fLwwIclxP4CK83SWKe+nI34nZGkZVSIRsF0wr
 DK6XY5O6vc70zclBeGdPasOJzQhzBRldFWOJQ9wOvU8niIDLrclyIknpqJV+cp3aJGVvyueK9DI
 F1kT35453rdmh0ZB9vHiUorN+zzmSWCJo6IWvzQPxW9wLTDg
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

Hi Carlo,

Thank you for the patch.

> A U-Boot image may embed its device tree, but a FIT which explicitly
> names an FDT must not boot after that FDT fails to load or verify.
> External FDT data is copied to its load address before verification,
> so ignoring the error can leave an unverified device tree for U-Boot.
> 
> Keep support for U-Boot images without a separate FDT, but reject
> failures for an explicitly requested FDT in both firmware and loadables.
> 
> Fixes: d879616e9e64 ("spl: fit: simplify logic for FDT loading for non-OS boots")
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 64e5f95546f1..a520db765065 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -491,11 +491,14 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
>  	image_info.load_addr = ALIGN(spl_image->load_addr + spl_image->size, 8);
>  
>  	/* Figure out which device tree the board wants to use */
> +	spl_image->fdt_addr = NULL;

What's the point of initializing fdt_addr to NULL here?
It's assigned in both cases (whether node < 0 or not).

The rest looks good, thanks.

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
