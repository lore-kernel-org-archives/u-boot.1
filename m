Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA4606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aArhn8pv;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=U9TECw8D;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=vLvYpmAy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 110C780897;
	Mon, 26 Oct 2026 23:48:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MV5q1wiXLoID; Mon, 26 Oct 2026 23:48:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 46ADC8084A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058529;
	b=HvB8+OPhyf3UmHZ8U+0L6x4kebCEMuR03JtGlZumdR7BpZz6kXFrxeZ9Ff64ufnkZRWE
	 MxY2GVYnmvkdWddEbvHHroI3rTwiZRHaC04Yb/ecs/96l4Zk7N9YracxrCLI6TFe3TxY0
	 gmyN4rt/lqYrsgdgGpRXZ0lehVRMmzCIXYzWFCwEqZoFg4Hy9ImTknMsBLsiJUszOTvtb
	 dPQbaLsECL1O8DhizfvMdCKF4/oNYdIhaNcCHZVGJiaIJqNTKfFuILeSm2um0NHG6nDwl
	 sUmTitu7hgoz5CFqOCcxtieb4D9k9uq5oT49xxNEHP9J2aS5E7NuWcLzh8R6CdLST2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PrclW/lxg1rADtkxeIREIDPcQdpdVXMFo1lhehLkaLA=;
	b=m8ZM/QLPRzrD1l36+eseKQhH/1mbYPxHHF497F8J+dY+SisgGDG0OZouGoYeRMKWQ5dj
	 DcZSUTCfTvNWRYwdOsaTmxeCXZjn5/PtEvYOTlZbihdqRJq8cCfr5/LkXSWo/10uUw/9z
	 qidzLxlXBeu0w1kIpCkW1Mhxy3VwJleNhYDocSnDOzuihSGDxGnz6Gsjc/3N+dKIJ+X4B
	 tYCwypY+049bDQcQPLGKfSEK4xaLw2Hpa2X88M/Pwx9Wv/eSCSagGdIaHHao7xHFKxm+h
	 pvyRG3lbzlsxnwQ72XNJ8ZezVftkRA7aiEaMtDQ7qu5P05vG1SSVqtud1dQdFZl11Vw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058529;
	bh=PrclW/lxg1rADtkxeIREIDPcQdpdVXMFo1lhehLkaLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aArhn8pvNAUhFn7BlVRht6L+6o/v1SIEQfcfuRHWhSQ+xx/ulOA8qxvwY1eLoDIAa
	 SzUcwOi0pSyh1nwr+IWL0+zcodsJN86bg5ve5wzEJq+knQrVzrJdi7Mun0ADX4qC7l
	 sj/a5TRYmSXEhaNXTEYI33CuAcu9ylWXDzcqGYY9Au17IH4imUsaHPQ+F0/P3LUsLo
	 ebsSs54Tp5WIN/oirmDXD+j8XGb6IidxyXNRR/UIIFg3S84iOiJXBaAQJEJlhF5gPk
	 Bt6pGlk94+/bhY0sV/w7DsxI2GLP8WhadQ8XJ9jbbfHrTGHyVLitBh4TXWAYvrALQr
	 sK9hzARPj555g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46ADC8084A;
	Mon, 26 Oct 2026 23:48:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id ADDE0380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 947F5403B3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:48:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id CFHerO4zT7U5 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:48:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45204402DF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058526;
 b=nB98YG1gPWbiGOJG5DAukA2nyGez1QA0T5HbdRV0J9hOPyrLyCLJXw7LA+GYun7flz/i
 6xDsAfi/UAFXi2xBgnNhzDjTcu2qJSzjMs+AQIL1VwB+COgKhNt2qfWo6u0PVa4iWh96j
 KIm/4n+hcQXEteimfj+XWDbdli9gfoURcA8GaCdKti0/3fpZQ+QcVQXujewJpFTyRNxK7
 LsC2YuDt4befPlzpGFMdvvDLRjzuQ41qIj3bj1+JtANCnZCHjUp8aUSnmJLyedxsRfdNl
 D+JNK49wFlFgKp7WA/FJgzrAv2XtJP9FsJfEVH9lwk2lZ4R4/11DhccTjF72lsvaP6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058526;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=PrclW/lxg1rADtkxeIREIDPcQdpdVXMFo1lhehLkaLA=;
 b=QoVBzk6Jw9ePja37M7YTkNm2Yvyjv2o9fZpD2H6AMnwGeebyt2AG5mXLoH35PIEQj5Cr
 6mU+XXE/5fGJLb+d6xfquIbXcONvq/boScnl6pPeiC7hcP+G0m6CKnsIOweBTPuUrkWs8
 5osEMtvPqQ2rnf2Cb1sZfTxo7LE03eMmrxN1jGj8lcBMgsXVuHDiHgtlqKftHCjs3D5O9
 UgWRaaj755CVkKKrUpcs2Pj0kkVmPZHcjlTrb5TIFnIBFdCMJjPvGx1AJYQlLnI57QRHE
 T3BXFKCfL3RDCf+nsvCOOLKMLByp2PynXWfTtGUtR71PNjutBsW8wCYVtlcO1ZyGb2A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=U9TECw8D; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=vLvYpmAy; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=U9TECw8D; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=vLvYpmAy
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 45204402DF
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793058520; bh=PrclW/lxg1rADtkxeIREIDP
 cQdpdVXMFo1lhehLkaLA=; b=U9TECw8DELCucOFHJjRVV6eTIx26ery46L1B35lvD+JutOXTCN
 dGhF+AIPfRZryuUxj2SxhFUCczOTVVaKlHDChJNnACXOhAZvR9V2MpE6z4YUc4sj63mJ6yGilp8
 ZhvM+WcQLQAwnvrT47YYDaNlhYpbIFt8Y6YSOoerik/TLbg2OkklLQOKxeOVyCjXmWxNT+dYPXV
 KM04TCoolK1k6agFEKIF50SJwrzuNsbeE3m2QrWRPMhbiGpWHjw80Wp5s3nOiZofYHOu40V486E
 WasTCjlh5e7g7vCXeV/7xulbf29hmwu0JYzINi90iYvN+q0AWigEy5Vc2IDDEy0Hmxg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793058520; bh=PrclW/lxg1rADtkxeIREIDP
 cQdpdVXMFo1lhehLkaLA=; b=vLvYpmAyo3tqWWaafVR1u4V6P/XOai9lNZRPZ1OZmJikCFW0CV
 zdqKrZvRHBuA2c1pLeqSsldF6YTUsKsCu3Cw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Bradley Morgan <brads@mainlining.org>
Cc: Peng Fan <peng.fan@oss.nxp.com>
Subject: Re: [PATCH] MAINTAINERS: powerpc: Add mpc8 regex to match drivers
Date: Mon, 26 Oct 2026 23:48:23 +0000
Message-ID: <179305815837.10976.13659263182971059450.b4-ty@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024180047.8158-1-brads@mainlining.org>
References: <20261024180047.8158-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 18:00:47 +0000, Bradley Morgan wrote:
> The POWERPC entry only covers arch/powerpc/, leaving mpc8 drivers
> and headers under drivers/ and include/ unrouted.
> 
> So to fix this problem, adding a N: regex for mpc8 would be a good idea
> 
> 

Applied to next at u-boot-ppc, Thanks!

[1/1] MAINTAINERS: powerpc: Add mpc8 regex to match drivers
      https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/069f6e0a26d4
--- Thanks!
