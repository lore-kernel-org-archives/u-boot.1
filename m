Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84CC606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kqlhQMOu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=fV++fqg5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7087D405C9;
	Wed,  4 Nov 2026 03:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkz-RgVp5LZ7; Wed,  4 Nov 2026 03:59:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 616654057A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793764785;
	bh=0OGGpoK075L0leywjynhg5Z6i+Ai878zNue2tbox9Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kqlhQMOuSMCYK+Gy/LG81JAgN5F/f+BY0583q28lDujQkculbk8phrbKiJw68pYxD
	 03bma2tFSGBa7O4dubEYK5nUj1Kl+2/Es8OBQQGY73LNIPVPd6QKrKwYbqzPbl1omM
	 795mWJFfdCG2k0CubRzpZE+2B2EqkVa1El+ZJiI5c9wzSrCymaFJsL9fQ8iSjVEP4U
	 fVmkZKt2H9y6QUAyMLbIIbKoAhrrk8mL7u/09iuZYJDby1ew3hitgBHMGc1VVmAdxX
	 jfKBryWiNRobjz2J1n3r7Kx0JBDVbXsxlKD2nSTn+STpZxkG+0r1E7CQosLSekykMv
	 kWBnLryS4qw8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 616654057A;
	Wed,  4 Nov 2026 03:59:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3291E9C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 03:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18A6060686
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 03:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9d3yXOWaZPpg for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 03:59:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EDA476066C
Authentication-Results: smtp3.osuosl.org;
 arc=fail smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793764782;
 b=q0CpekcwiDW5PGDzr8AISEo/Sam8WSro5fECQBCrjxEvXGkP8SExWwySwUkA1Zk3zr95
 hXfHFmBgcHLnbftyE1p4qzn/89BZC1KQkqTtbOJKYslBMSV/5DHE+IjEL/L4+/8v1Vpkr
 z86Yu3QIrxHYLJ8nshutAC1jLYT9xtVF4lh4rwh1dlvHzA4/+uianJvLwkWYRA/1dvTXb
 MQq4Lm880nJNtRC5L+HqDcAUjeXQ4PxifckNIJKQJcqJaiDmtXBVsFb3VMDehJyD7/qGg
 0hu80Jbb104nll2Ybo7tafGMcKpK3c51xi2ujJVRgkevHeLIN7uEuyTn0LKAnoL81kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793764782;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
 X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=0OGGpoK075L0leywjynhg5Z6i+Ai878zNue2tbox9Pw=;
 b=GKzt2j5lLjrD5ifPaKhi0EHbLpCZmS86tBnTQtWJYl8JwCgPzCCcdChF9cvCii7zLLj/
 6ZFBeavMKTJuDt9gnQ3rKotGWItW2w/Mdgjk363Mp7WnGnCmkne38lDEDc+8scp9z23zA
 hN53/x9dlvNqB3+hQvSWP5WXFaToAvz2M75o+crqT4KjcXxY+35+Hnp2KnkCTanVW0DMJ
 vStUwFrp9M+MDkE7aUeDcceZPkZOCyYV935G4nLkdFpJOXSGqqY3vKyH/hcloBerVWMf9
 cvUICGz+ZVrxPSJ9xZ9T3OIFSRK8OeEUjVM4fQ6dRw0OhV4ZSO1lYwEB+mcE4o079FQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=fV++fqg5; 
 arc=fail smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=fV++fqg5
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDA476066C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 03:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793764761; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jGWCu/wedO3Dgxp732KBRRygTJ4tCSuOZ8wre0MQthdr+vkPT95S77iA8ISSCLTlXr2iw2xlpjNoNRsPJ1LM1KOxBbrp0zpNXTStb5lzCfmzomu9/l6WX3RGcIM5mdajt0H9naHXkDzExPkKHOQ+U0+7VwljOJVFUjYVt0ngM14=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793764761;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lVyvl0sj4HjwomhD8KbIPT/nr8myTeplnYQCET0gzeE=; 
 b=YDKGmh30qzPfVwGQRdE3QbhdTHo56Qq63SwfisOsbCuIWi6Pc6vw3qEYFaN5TIddV9T/ZqZuxVK8kf9WHeyt0XmVbTs/q3P2lNDHvq3PVXlUWqz8L4//YFfW58rlHotmKqmzLBV/eWX7JWWQIWM3vbYYny0196YtH3guK+PE6dM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=fV++fqg59Br8K6gRNfEJxe8OVB4aPljilcngZi3enkcxBJa3LZLiuH2Qxnk4IS090yoC0E59UUyCyRnQG412JhiLanBJpBfEAe1Jz9GNRM1khyuPDXuWLzSdpnV6GJWT0XeA4/WvyBsSresGb5wtNOzvjWBTNtYcr733VCGcNsU=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=0OGGpoK075L0leywjynhg5Z6i+Ai878zNue2tbox9Pw=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793764760769279.64611376131745; 
 Tue, 3 Nov 2026 19:59:20 -0800 (PST)
Date: Wed, 4 Nov 2026 03:59:13 +0000
From: Yao Zi <me@ziyao.cc>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andrei Lalaev <andrey.lalaev@gmail.com>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH 6/8] board: sophgo: milkv_duo: enable RTC power and reset
Message-ID: <auqtkRJmEyJqGhKF@pie>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
 <20261021-milkv-duo-spl-v1-6-ee7618860237@baylibre.com>
 <auoV_97xdZB8MLlU@jpg-duosnb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auoV_97xdZB8MLlU@jpg-duosnb>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.744.82
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 02:31:51PM -0300, João Paulo Gonçalves wrote:
> On Wed, Oct 21, 2026 at 09:54:22AM -0300, Hiago De Franco wrote:
> > Let the RTC power domain handle shutdown, warm reset, power-cycle and
> > watchdog reset requests, and stop the board from powering back on by
> > itself after a power off.
> > 
> > Without this, the reset and poweroff paths are left in their BootROM
> > defaults, which do not match what the vendor FSBL configures.
> > 
> > Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> > ---
> >  board/sophgo/milkv_duo/spl.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 52 insertions(+), 1 deletion(-)
> > 
> > diff --git a/board/sophgo/milkv_duo/spl.c b/board/sophgo/milkv_duo/spl.c
> > index 8b2dc2756ae..97681e5a61b 100644
> > --- a/board/sophgo/milkv_duo/spl.c
> > +++ b/board/sophgo/milkv_duo/spl.c
> > @@ -2,7 +2,7 @@
> >  /*
> >   * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
> >   *
> > - * PLL setup based on the Sophgo FSBL (https://github.com/sophgo/fsbl),
> > + * PLL and RTC setup based on the Sophgo FSBL (https://github.com/sophgo/fsbl),
> >   * plat/cv180x/platform.c.
> >   */
> >  
> > @@ -13,7 +13,9 @@
> >  #include <hang.h>
> >  #include <linux/bitops.h>
> >  #include <linux/delay.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/kernel.h>
> > +#include <log.h>
> >  #include <spl.h>
> >  #include <spl_load.h>
> >  
> > @@ -52,6 +54,25 @@
> >  #define CLK_DIV(div, src)		(((div) << 16) | ((src) << 8) | BIT(3) | BIT(0))
> >  #define clkgen_reg(off)			((void __iomem *)(CLKGEN_BASE + (off)))
> >  
> > +#define RTC_BASE			0x05026000UL
> > +#define RTC_EN_SHDN_REQ			0x0c0
> > +#define RTC_EN_PWR_CYC_REQ		0x0c8
> > +#define RTC_EN_WARM_RST_REQ		0x0cc
> > +#define RTC_EN_PWR_VBAT_DET		0x0d0
> > +#define  RTC_EN_PWR_VBAT_DET_PWR_UP	BIT(2)
> > +#define RTC_EN_WDT_RST_REQ		0x0e0
> > +#define RTC_CTRL_BASE			0x05025000UL
> > +#define RTC_CTRL0_UNLOCKKEY		0x004
> > +#define  RTC_CTRL0_UNLOCKKEY_VAL	0xab18
> > +#define RTC_CTRL0			0x008
> > +#define  RTC_CTRL0_WRITE_MASK		GENMASK(31, 16)
> > +#define  RTC_CTRL0_HW_WDG_RST_EN	BIT(11)
> > +#define RTC_POR_RST_CTRL		0x0ac
> > +#define RTC_EN_REQ_TIMEOUT_US		100000
> > +
> > +#define rtc_reg(off)			((void __iomem *)(RTC_BASE + (off)))
> > +#define rtc_ctrl_reg(off)		((void __iomem *)(RTC_CTRL_BASE + (off)))
> 
> Instead of hardcoding the bases here, could we get them from the DT? The
> upstream cv18xx.dtsi already has the RTC node (rtc@5025000, with
> "syscon" in its compatible), and its range covers both RTC_CTRL_BASE and
> RTC_BASE. Also, use syscon/regmap in SPL (CONFIG_SPL_SYSCON and
> CONFIG_SPL_REGMAP) to read/write the registers.
> 
> Just a suggestion though, I'll leave it to the maintainers to decide.

I'll second the idea of handling RTC stuff in its driver, and I think it
doesn't even need being configured at the SPL stage, right?

...

> Best regards,
> João Paulo Gonçalves

Regards,
Yao Zi
