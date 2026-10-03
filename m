Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5665BCA5FE3
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 07:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B4CA811A1;
	Sat,  3 Oct 2026 07:50:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OGjeDvpcvBZ1; Sat,  3 Oct 2026 07:50:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C4A7C80FF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791013804;
	b=T3A5uLtM7K3vUur7nquVCKd27M8ifX6nwOgc5+3CdIHVR1h4PxF3rWtDzo/bCqwyUZ7n
	 xfYVcnAB+Ht9zkPWehv8kPPLBJ8Y+ww0eiIluxqYri1NzrLqDG836UusQoYyIYOOw6dXN
	 vithsQ5+sTtqgCgvNoQ02ZUzb9xk1QJQis8zVVAr03WcOPXkxDXTSKNSd+0XtIHWcBCSF
	 mrXZX7w2C+NnQ12++krEqHn/FE6C94dBbqoruB5bB4D/CknRPQtddav/lADjvFIrQ0uoR
	 VF8J267yQxGkN4ODUYyrZBalx2yUnBqNjN/WR12I3I8GP1eBU27LG5Unk5+5015TlQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791013804;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l5X0TCPcTQFzzKIj9vahi5zJLr3G0h5IHZRzo+KFpK0=;
	b=srzde6ihM3EM7kjgNdRXVq5sRoZXEcx6ZMFMQc42MCN7W2WKeNdWl9YHxg6ib38QdyKq
	 x+reKgwW3pBbnglKPCDWgiXCV0cG5UOUlfjg1JzJ9mZ5o5jpVDXNwU5awfKyjz78eA6Gl
	 Ur6cN5sHnzDX5CYyyI3HfuVyccU6iIbtqknoJTc/I+Niv7VmuaklosYSCj6Slzo4TSxjC
	 5BF1Hut2bOiiCdc3WgXWD0GbeziX8XWWdLFGGfDVfjCD9+6+7bm/kk3s2nT+GgtoPHUYq
	 sgCbsOHkgHJQhN//fJF2vb78ddSaGQrDE/qwk59NxAShf2yM7hyHsxoRJYF2yKiT3fQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791013804;
	bh=l5X0TCPcTQFzzKIj9vahi5zJLr3G0h5IHZRzo+KFpK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EmGdMFklnOArXBLWl02aPHbG0XtbwIHSRmtZXMvELQLFthZfYr01JSHTOuWkGURo3
	 PMjlpc3kujZ3PegkHbJyyxfmSxWHFrUAs18u8vV4MOdUONP0hYb8e0qsX2hmgkr2Ke
	 Fy8FbVsulgBVyKYhNoVsVfe/Ib6ebgXlgrsOQR9DWjjwvgYG+L+b6MAIKHtmcKQI7H
	 OQMLVe98mE8UYCq5nakeSxodHEJ3ATLjzBegy47JhgKHdbNcc+gbeEKr2XnwQfdZ4b
	 LCS83iDafPaMCuuv1ULGm1SwwOgHj0dMvelu2z6K7xalcpdlcjgZYdgFmwjyWLIc2b
	 YKZ4GnVxJttAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4A7C80FF3;
	Sat,  3 Oct 2026 07:50:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 96CCF179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 07:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 909FE40070
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 07:50:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRgxorokOxm1 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 07:50:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8CC1D40059
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791013801;
 b=fpOzUImVDHORnVTjAaAwimnd+SV9P7vC6uakd3LFyucW1iOpRd3lt316XgSfvDQeiveS
 tNO9IM2ecin6hCRl4juKivdemAWwqg74OZcHQ4Vt07kDgWH+l4Pt60F7xwBvreRK0oFU0
 CNc8z9zQyLkRwrCumSgtHjwl/yei5am/e3YcAdWsFfNxBy9VcCIPw4rDtWZJBSBFkjm3N
 ZKtjYx6c8FVlyAynDNXaUAGWxZ48eE/umu3oTPime/MkKTTO3UR6YzQ8V9R0xdoUY6tT/
 bZCQScqVDpIHbht6rSfHwAfd8XPY+gRjKujVDlTz5fwb6gxXeLKL/HbJzznhS6n+YVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791013801;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=l5X0TCPcTQFzzKIj9vahi5zJLr3G0h5IHZRzo+KFpK0=;
 b=Y2fbPToUnhUHL7EhmYPAOxnmIxzgm9KxQJbVP4frOZrw/NdORY3DoBIWuSHJh3HDonH6
 dfGqpRjUZcM2yctT+ON2UxuB+U2/5MaLrSsQLnVlxesM7K2/8jwankN7gYsEDMMANRemb
 0lmonqr36ijM2qLdKj1WCrRgM8nZfBlSIBaZY4oBE9LV+6eUFI8j/1gnb+/n/KH/L+cx3
 sZDeX3Jl51n21+Ya0Ao3K0ZcM9m5AfGiyEtI0X9EhVGy+x47LF0VyDZWKMrlNg276rDUe
 xPtyX90YE/+efBiC4/935wCDRyE1rgTHK7pQzPsTH+RjPnrJLTtfbRvyQg6JjKZK+Rw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=iYWmNKZZ; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=iYWmNKZZ
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CC1D40059
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 07:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791013758;
 bh=l5X0TCPcTQFzzKIj9vahi5zJLr3G0h5IHZRzo+KFpK0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iYWmNKZZJntFn/yxw2as9eohzpvkVMiQhCrlxmMIn7mu33q2BZAJLIxGpHGqAdndo
 lBNzVaXhRUExFjaFgOeqZDvV1ukDvBGjSctJvIEd8LybKfYYvEAf7uO49K516xc8nM
 mGqtameCRkm7Xf2diu8NjRBH2k2EYU/Su6C7V2QlNRdEDPt2aGaN7Pb4NMzobEInX1
 d9zGEsRfj/HwIwfiglVvv1RP/vaFXznWuMpvr5Pg1VyEf9Dwvaha9L6KsjWD+1o4cj
 tpMCZn/0FqPgiNYGoS8UjR3B/RsQNVn1DANoMzc5iZRP/Ldpc0iDEQWfyg2N6G6qNX
 9/epz6ff1sVwA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B9C77B221EBC;
 Sat,  3 Oct 2026 09:49:16 +0200 (CEST)
Message-ID: <2dcd6f21-ea10-4986-ae3c-fb81f5d768a4@freeshell.de>
Date: Sat, 3 Oct 2026 00:49:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] riscv: dts: spacemit: k3: add binman node
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
 <20261003-00-basic-spacemit-k3-v3-2-dea68cd1bd7d@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261003-00-basic-spacemit-k3-v3-2-dea68cd1bd7d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/2/26 17:34, Yixun Lan wrote:
> SpacemiT K3 follow the standard riscv binman layout, which has opensbi
> and U-Boot proper, so include the common binman dtsi file.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> new file mode 100644
> index 00000000000..f1c1c3ee6fd
> --- /dev/null
> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> + */
> +
> +#include "binman.dtsi"
> 

Looks good to me. I suggest to introduce spacemit-k3-binman.dtsi now or
later, may as well do it now?

See for example of how this looks in files
starfive-visionfive2-binman.dtsi and starfive-visionfive2-u-boot.dtsi,
it would be as follows:

arch/riscv/dts/spacemit-k3-binman.dtsi:
...copyright comment...
+#include "binman.dtsi"
+
+

arch/riscv/dts/spacemit-k3-u-boot.dtsi:
...copyright comment...
-#include "binman.dtsi"
+
+
+#include "spacemit-k3-binman.dtsi"

With that,

Reviewed-by: E Shattow <e@freeshell.de>
