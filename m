Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F411606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ajaylVaF;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=gQHNzcKt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E422880F40;
	Wed, 28 Oct 2026 22:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IHydp0m_1u8S; Wed, 28 Oct 2026 22:01:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E95380F1F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793224885;
	b=fxVbqZ/zxukXIjwNjaoGfLf55f3hFlJ7MtHX/3Vq6Ugj02Rwz+IPGfWtCvvSGAguxsx5
	 Bx9j8BU22nwLDBNEUbjX/4ELqgv+o1X/5tOXxZAu8wwWYSMOtkcMFNlrEUf8WKgQ62fYS
	 HEHyhczrJbNR4FHDQKb/jBRLl7ABxQtKoiM7j6vOFUbsjiBRR1jQjbSbS1wv5Gv1lIYaB
	 jn71RE6f82DPAk+h4lJk0yFXdduItl/e7YSF3NvD3L//6phduPboBYvyXWR/Nh+vk8Rtl
	 x5N2qHwxEPvjaswCleBA+6pUiR5qTrolzL0vYsMzmLHMsLw36g//8HL7WWOsu0da7tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793224885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ad1XrtAmABm/yJqbAcUtG84aqbAFh7psTGpM3cKtrPU=;
	b=sIxVJkx40KihV0t6uyWucztyZDto9/fqnUCV0ae+aVr70ImovlFqg+2uHFlyMB9qNAtP
	 KXOZGQymT99KVTwK2V9amAwsaxPYgxS7NLez66WXoYjjBD3gjtBbf9PZWHoc5AOFZsqY3
	 BPY/CngJQO5yuAxBGx1DyS4rrhCGxPkao9vb47rIf0l6VnLyhUgABINQPk6VyGFb5Uk2U
	 6HwG7dcLkzR7aDxI9woD+fXoc3U/kQHDr6T4DXAsnO/X7I/AOWiJGoHwmeGI7W/nGBXYW
	 BI65fSN35zmoZJDdSlcDqCJclvXFRwNaM9lYSk63DDt443guXSjOK8re3F3m+eK5kTg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793224885;
	bh=ad1XrtAmABm/yJqbAcUtG84aqbAFh7psTGpM3cKtrPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ajaylVaF4O3LfWEY6sy8ycZSOmEa6XAUOL6fW50AK/OPD73VeI5RcXANoGbgC85FZ
	 hMCrYNFqUiWx/+jThjIXN47ObfO3iZAcXmhALKu1ZRQSRXlNe9BcVIY9qJeo2QCMj9
	 fm5Bai+4URaaurOZwElCAh/cAMeXe2r69dM+PK3vtXAGYRSx9tCRO3LlXmHcHvFQ5b
	 qM3G0VBxXTA1GN7aL2HBOw6nIrJftsRiStDI1C3PiIPP5xm0/BFWjmTzKvRSUcaazg
	 JmphNqIOFEGae+LUY8Ba+teP2KXRqL5cQviOZKY1fimBr+Th1fqtjC/SWGDjLWQgwO
	 29jYgqZdqh6pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E95380F1F;
	Wed, 28 Oct 2026 22:01:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0055F2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA508606E6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNRz6zPyYfUE for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 22:01:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 909AA606C2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793224882;
 b=PTPzARvDLYUB3EI+K+zOcLn3a1sRd9uGdvUWVskwixErzx7d5QkzAV/KUNxZhw3FwU8B
 /j0y0ODiTgsf6pex5VZA5S4yPo6FUR2OnL0ISXb6PzWxqYloqSSXDLndxP6V13ReRYegS
 W2q1n1acH8TZcPkqgM71OaiyIU9oirHzKe7SdCpS5EUxutdWVwxaQhlIJAp+Ah/Gfpaus
 EMzTcfjcsaoWDvbjM5fu4X3EuLmwNn2fH7mKdB0HH1HsWhBD3UtavqgVTLRuQRMLKQ6Fl
 bhYrDGg5Y7etN1UN7DDRR0cwzaxs98rSQJjSOJWZ9x2P8XOQvrdY3WJwsnKxz/KcEIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793224882;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=ad1XrtAmABm/yJqbAcUtG84aqbAFh7psTGpM3cKtrPU=;
 b=Xayy3yx6lcYzfHVEkJcZJhi4smp5ADdupAJ7j63C0551UEpXpuCXvdEZHDnPXunoKijZ
 EATX0T08nCj1aag2vnBFTGSHrqoiIZpcJnREzdsvDOGHXtnCDngjnWn7IjyMd0FPqqUoT
 euk3lp3FUdB/Xxggk5TqV+R/GMxhW9tmse8mEExtxCs8768FxUAyvb/3ICc3sVQgm+gHD
 iXdV7c0jIGcwUdlWnrKzQkONrcKFWWSfvQBKwpBMGIDUO6sGk/n+cBDexMnEreiZaGBwP
 Z5z3laQUeLT5Di7RRGdjCyFJ0MAlVZIN47+5MrssTeNMltg1KJM/iTo8Ipt3xcAjPWA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=gQHNzcKt; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=gQHNzcKt
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 909AA606C2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:01:20 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b10d24345dso14689147b3.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793224880; x=1793829680;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ad1XrtAmABm/yJqbAcUtG84aqbAFh7psTGpM3cKtrPU=;
 b=gQHNzcKtgRB2DpqJXncXkPPfiWWv2K0Q/uPMYWJYPj6tkkij3sEHwxd09Em0fv4k0x
 un9a8M/1VoHcbgJ5II0HmbAMM+Qy3vD2AEblsYuf5xRvk1RY61nm5qNMiVFi4kdk6vYf
 D80w5dV90IDDO1TRV/dmxXrK6boKy3an2KSSIpwZstt7xtAH36tGmMxLXEFp7Hge86WL
 MnVj9Ns20PvY20CUtiW4moq74NvwEoN7o3nl+xwU66i2qy4CaWZ/jzi7YW8l48gBFajg
 ptJLHUQLM5zSF01/Ch+uxFwcKD0QDOqImAA69xtkE2W9SUed7OSl7i7H+uFdNlUc+ZXX
 b8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793224880; x=1793829680;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ad1XrtAmABm/yJqbAcUtG84aqbAFh7psTGpM3cKtrPU=;
 b=CdOpSFjGm444rcxv1QY8IvnHvbDlsql/8jM/YJvq0bkUqa6HrG5HPRBEmnHPSfuOLW
 s3QPKQ0SjYu9nV6khNMUma2skpbM7RpcTpcTLxligk8rd+6B8AadZmuGv8fqxyiJqoU5
 1uipp4mDMNUdQFF6BGYd82Sn7WOSAdnQJRwU7XFdRIY0xDM7UFS15xr4eh9YnlOCfJD6
 bX3RkeKcW+nVg0deAWej0KoheJ1Y9ujgDutAJm+oR7E+r31R4DMEuPpEqcibEiXfs+Ov
 TyUAY2dzPlY7+26vt9AndIhDXHdzeGfJ7QOvjlXsJygJg9A/F+EtWm1LDlrDVoQPI7HO
 as6w==
X-Gm-Message-State: AFq9FYIAUxEj/Cnac82EVbc9NVmLJYiG0eCTwZ6nR8ESQcbX6YnigUQ5
 CZDbyMfcyCF0BcMT+QXKJKfVqXyTp8Bp6CAEvbUN1BDykkQ8jniW70sa1nzYdbRNEcr/Rs1ubE9
 Fcxajiz4=
X-Gm-Gg: AYBFou0iq3lRfdaW/ThHhQgqSzZhBHJYSXsBeoosMjzS1hkyYR+oVnDaqgzMWkZ+BUX
 CQwbd5GZVFr7qwCX6qrKKSB7AGXNiF+RLHaq1/47tNYMOWNVOgvHCbHfcZbhBr7VjwYUPYnu1Bm
 rLqqATVzs3juJ1Z+MLpa6SNPUzqE6E4oqMjrLivsKDa5Yk7SSO/hupftKr3A07Mph7qby/UeWtE
 50TF/mk1rBKNPR7K9m8+RnpMeqGyJLazIHEH056U4B3Zw4rwCeu9VGaWVSNmE834kp7uUyPCsdE
 WjBKKFyTye9Ls5lBT0tW3XqSI9HdEtWQ265TGL6gfLdAyCcRK09HMo9CyZWpSHlVA6FMVg/D6wM
 nZZQB4CmLWSIr8F7e6BXrd3FO9pzQGpRLn5g66VmvSvyK9XZcibfvf935XF45YVArCnBOxnam9k
 IavcuS+IMyVPyq43s6c7jKOXPj1GQFLzt62AvNx+GyRW5GVRYRRJk9S7aV5l3UOYXh7S2mQa8qI
 F5qcHMS38S6Pj/VcDCMHduSHvpYYOkisa7xyKGcNQ/KEQ5009d8jPtf++GLxYCsWlFhI2gNkSqe
 7OLjpVX9ouHwHn9Z/WNur6UNvXQNj+gUn5+VBLtO96ui4nceFKmGL6RKcgTfdw//fhxlalgn/g=
 =
X-Received: by 2002:a05:690c:f07:b0:8b0:b0d1:fc47 with SMTP id
 00721157ae682-8b1b5ea90edmr27535957b3.60.1793224879766; 
 Wed, 28 Oct 2026 15:01:19 -0700 (PDT)
Received: from toolbox ([2600:1700:220:59e0:bdef:eb5b:e06f:55c0])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b19e64c780sm35864947b3.43.2026.10.28.15.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 15:01:19 -0700 (PDT)
Date: Wed, 28 Oct 2026 17:01:16 -0500
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/3] riscv: dts: spacemit: k3: override reserved
 status of mimsic and maplic
Message-ID: <alg7jxkvt36hyizau2ory5w3u4vxpxxrdakxbijc5vayxfuu5w@gn4rhdoofozp>
References: <20261028184526.1887640-1-e@freeshell.de>
 <20261028184526.1887640-2-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028184526.1887640-2-e@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 11:45:05AM -0700, E Shattow wrote:
> Linux boot stalls when probing peripherals unless OpenSBI has the
> enabled mimsic and maplic nodes. Override these nodes so Linux can boot.
> 
> Reported-by: Yixun Lan <dlan@kernel.org>
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> index 352e85e7de87..278b36acc79f 100644
> --- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> @@ -3,4 +3,8 @@
>   * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>   */
>  
> +/* Override reserved status of mimsic and maplic for OpenSBI */
> +&mimsic { status = "okay"; };
> +&maplic { status = "okay"; };

This should be fixed in the DT in linux. I guess you could carry this
patch till it is fixed in linux.

> +
>  #include "spacemit-k3-binman.dtsi"
> -- 
> 2.53.0
> 
