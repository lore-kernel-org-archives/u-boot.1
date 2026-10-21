Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0FE606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ymdTAnGk;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bH2KOanT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF39940699;
	Wed, 21 Oct 2026 09:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pAb0hstOsW1D; Wed, 21 Oct 2026 09:08:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D012B406A0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792573694;
	b=AjZyMdRq9/88/PLYMtIKfVbJR/L4i/uVp1N2OybtKjYLyT5BG6vQ518AdLQCqsDbwwep
	 jpXhYOxp7JeR5uXTGH4K5PDqqdKMlyqzhDrqJ9VtmMp/5tbuv16i2g++qP1wuVQrmveok
	 bYx0zK8jfNd2VuWOk1atKVaWFkr8z7LgTx87cHsIEOzcyunHedDsWYNAOH0Al+Qug7nCc
	 Ln+nw2OTzeAfQsNkqAB5E7qMNGrygOca8MVu73UIflcg5m/Vkp1u5y4WA0AkUXpNS5vsr
	 0RzdfhEc5xnxrBVRoCb+L4OUidYeWmntbPTISk9s3YRak6p1IxRs8QFwl53s+NBfsKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792573694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=z7Sw297lJn1Yk1rM2t43O4tpnpHP/ungiN1nAswcvzw=;
	b=pJENPAxiOrscWNt8gQvpVkmqqq2jKrlKEwBFh1MKUNYwXFdMizCjtgwsPO0/REnudJnQ
	 jUvbOXI5ZGnUCaF2IQYlVtrWeVjtLJf8C38sBr7sGmpQ/4ldXHBlgqDGgznZU+BaHRFZZ
	 TykyWHMjxoFnuN/IpiyJhmNp9D2nZh/ETZAsiYHGYGMrGlPOrDEBwelUOWxu515Fx/aAg
	 ym6om+1vBMVqkCfrOz1NvpablVYn24WUTVN8EtBQkJ/kR86PoN02CzzKYwOFBJoArEfhI
	 HWRuKSN3VrxX6oIfKrBPQ6PoF9vL9IoLU1AIaVYkX1WK+pKVlQbfKMYuIKcgwliphNQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bH2KOanT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792573693;
	bh=z7Sw297lJn1Yk1rM2t43O4tpnpHP/ungiN1nAswcvzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ymdTAnGknANRPKSpHZ0pZq6H+fuFJ3M9D2leEPwIIIVhSWZ2/oR1gJ64XHOnmYM2v
	 n4lYqWvivrpwIPJaGlKp7sxaEp6eKarCU9aKFR72oSOXw9xSN5yU6v3+m2r5GAJfe2
	 WvxWAIhWQ3qUYY6A2ZkdfQfoct5UafanTsSOeRy+mvyvmIYf9Na7PJ+pDelUFVPCX/
	 ZQRwoC9oJeqb9MxTPK6uUIGEg1ppioYemLk7qXZnuaGU9I6yxIHJQQRn1bIZXFGBRE
	 eMFwdQEPPrdpMMa1WP5x9/yDOsONy25r3HO8iRxPO2M8gCzTG4Cse4p6+HdPnPuHz8
	 rcsGhPQ9Twoqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D012B406A0;
	Wed, 21 Oct 2026 09:08:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B62F2A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D8CE406C6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gtndZRTciCcI for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:08:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5BE6F406A0
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792573692;
 b=nC/cnKNLx0hKerm7e7VgiNeikNCVilsL9gFGwaAAtI6RWbxoj51ExQD9yqtqqbLHsYjd
 2E+qM77K9udafs83I8edgqMKh0kQWCvZHJuwCNhwcUXiGG8FeFsOaXsp5q1m/338ymr7W
 1A/5XXQ/HaBQvL4SAEwj0hOI0qn3u4GRjmCIU3iycKnXLt31WXJm76Ug9cBtrr+EjY8JA
 VVy1w/SXy55MyWlrzx/bHY3Uu6U4WHzV8CZJLOsAIDZhnYPviKOUze2DslpOANF0V4IWn
 V6owoQqc7ER4Xcc4QW5+4cjkAc0I8Ou9ryQ3VLWf2dU1TDbZRjUUV/iD6KJpCLdn9Cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792573692;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=z7Sw297lJn1Yk1rM2t43O4tpnpHP/ungiN1nAswcvzw=;
 b=O/fDn5QtYkNf8vHe1ieEQx4G0cKanjlwMhsxB+LfQxvSMYkjLx4rn+kJZ+aUjyZdH61Q
 RiE9ZqYbG7F4v72B7A4oSC8nWmc6u4I3ZVS+m35AQWsftwl8cJ8l9tQrSHwD0BXwVDREV
 Sq7Sg6yRLN/Dg3MiQsTK+/Dgu0GUbOT+jtJ6g+S9vbLRsBMlJOoxQwMLIOS/Pxt1vWEEr
 stAR5+sGUaYAUapjW4ptEdFdOFXB7ZMEtqZy5EGvX3JrfG9jGihtsGrbl/jEc8HEj99gN
 c3nUXFfrVJpgD9LbCoTT6ZxTb46Tpf3CZgYsIiJ1gaAZxp1LHQkoVbal1A693qM6fTg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bH2KOanT; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bH2KOanT
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BE6F406A0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:08:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C17A360098;
 Wed, 21 Oct 2026 09:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0299C1F000C9;
 Wed, 21 Oct 2026 09:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792573689;
 bh=z7Sw297lJn1Yk1rM2t43O4tpnpHP/ungiN1nAswcvzw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=bH2KOanT29PZRhX6RxVzcd8judkKcABCwHM8220RvEjuTSQeD1dM9hklXYHZwYnNO
 4fVPPH9orvtiAFMt2dUIz0cTazTvaHEdzg4lG5tC1qunLyTeAB/JYpsDtytQSOIayq
 nvRATSrlxljT1aPS1czx8/5Uo8N5ZUuTQc/6CBfuxI6tcF89XH0zdUl9mMTko8+3W+
 M4oUyuRhjKR51RNwsM0bsHjnTUILdM5QTkfKekAkMPiDS8z5LlTh3xvxY+VgnYWk1J
 oDNHuKDawcERjPuXtmwcCGNO6bkVVN5V2gPepPlijhagq5OzMop7aHxUDuwTdldkMy
 eZlhKs4kvX+Ew==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, Jan Kehren <jan.kehren@emteria.com>
Cc: igor.opaniuk@oss.qualcomm.com, glaroque@baylibre.com, sjg@chromium.org, 
 trini@konsulko.com
In-Reply-To: <20261016072640.772964-1-jan.kehren@emteria.com>
References: <20261016072640.772964-1-jan.kehren@emteria.com>
Subject: Re: [PATCH v3 0/3] avb: Support verified boot from non-mmc storage
Message-Id: <179257368745.20546.3580352840105565065.b4-ty@b4>
Date: Wed, 21 Oct 2026 11:08:07 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Fri, 16 Oct 2026 09:26:36 +0200, Jan Kehren wrote:
> Thanks both for the reviews, and sorry for the CI breakage.
> 
> v3 keeps "avb init" lazy, as Igor suggested.
> 
> Patch 1 is the rename, unchanged, with the tags from v2.
> 
> Patch 2 is new:
> validating an interface name without resolving a device needs a
> name-to-uclass lookup and the block layer only had the reverse. Say if you
> would rather not grow a block layer header for one caller, the alternative
> is a static helper in cmd/avb.c.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/3] avb: Drop the mmc naming from the block IO helpers
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/cb586487116fa332510a68a37f7f2a0b6f1652e4
[2/3] blk: Add a name-to-interface-type lookup
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/d98f3bdaf8c576917968b252caa20c278d3832db
[3/3] avb: Take a storage interface in the AVB operations
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/09f6362327c0f69e3d32d55d3b01f0f48f6d8a33

--
Mattijs
