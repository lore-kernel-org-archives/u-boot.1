Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDD1C79FBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 20:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7537F60BE4;
	Thu, 10 Sep 2026 20:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bNryKGi4e9YC; Thu, 10 Sep 2026 20:03:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6841660BDF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789070603;
	b=seRYiUqiuiXsrDR7yLRRDhMe08cC3z1SX7RFXu9/lCnwXTUxKxCYQSbPgiPMtO8JC6DC
	 VyodSUf8Kuf09FqW+P8N7JlHas7jkjKS8pTQdimnGL4guHYCzxFtyx98XTpSSZvPVSrck
	 RyY19lO17u/YyC1CcdCGvu1OTuHzVVXW8Rv71rovuP4kfXrvxoZLIx0BEXB12LjSInJh/
	 sMnONJmXW0XD8Dw4FrWUcad/SxZ7hb08HkG8qkGDU3yWacbB6eHj99xeKUWKRCgF7ZILu
	 4SpxQvPWDxbs8gvwY61VLWJuAMJ5LuizO3CvAfCMalXtKSAkdjBNJdJIrAq6yiKqpWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789070603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PNUAE79CgL0bg0JitWWspForQHO7+2IYjl1M4AqBRyI=;
	b=B+67K1rJIa+c8OUNAkjCAkUzryYtweSx0NCpzK3Kb3w8NlEyvsh4kbOKHEE+lTYwxC2i
	 Sr2XReuPbeHGQbyiTKoV+QMVxIIJ/Nv0wyTjESHE6Rky+1fQH3xjOUa33KaMCWSaP5rsW
	 eeGswIyfgVSknLYkbd6Cd9r+cgTjc/DSPAzgbYnp+kCVrW7kB9cwX6VD4zCfLEWuC2Xd2
	 fT4suT5LyhqeGa5eorceyqk4EDRxeGW/dAjHLod+WN6RYaKrZluQoPdDgv3txsLQ9NbFm
	 sz53lrFwq9cBrj/sJAZ8ZjuFH9ROToYe1y+wPzGlXLKb9Uasu+wV/XKzOccIgT9oeOg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789070603;
	bh=PNUAE79CgL0bg0JitWWspForQHO7+2IYjl1M4AqBRyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K8RNIeskTLdYcyGu3DVmhSXTLGJqGc/n0Fm/7asY/jkzRvlIbWutM3I0gX6tGLZQs
	 cJs6Nu6A8ymv+aJaHhkOEipyY0yyACoPO9XhTRv9G/Q4hiEmu4UNtmiycnVWrPrYwQ
	 z8PYZjLav0ElAHcnkjqr2KphN6wycHMVo4ni/3Ywc9pE97cZ0QnqqnZDG3WtJvmIU5
	 /JYVfwWcywW4UNgpOB3LpsAZe78QJp8tuqK996ozwxdduzP2VThHfG1AN4vUkBpDAd
	 qfGtHw8C7pEMUHyY9FdtQzA/riaqqmZBUM/7/MYzhl6JXBCkIlFa/FQEZ2vBIg5ZYB
	 QJSbnRR/xQngg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6841660BDF;
	Thu, 10 Sep 2026 20:03:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A242814D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 820A881007
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pjgEDsuz1ubN for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 20:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A0F1A81160
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789070597;
 b=Axr+e4eAnOy3480FtCQTzP5rqdR2NxaD4mInKGkhYOPHwPvlMxRoht7nfQpeeabfWtS1
 FXjnZ0zlcUb9fToKNpwJh1jWrGS3iSKeugtD0F4Kh930mjSzS8Y6Ub19ycYqAPwzICbi/
 BTcFg7+ujVFd6+i3QhbBoQqA5hMy7Y9jubbqtmHPf2M/TxyOJfI/D9TCgLzY2vkd480lc
 1+I+72vwdCv5Qpha4iD91b5Ra/Re9Ok7K7dWiwQvr6Hn4fQzS9yaH750KHGp1Um5H1EBC
 gyjoWp0Hr6Yysv8eIV5oQDuO10NUJx5Llbk6/oMceEQrWDdxbnjBUv6sh4E03GIF+Vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789070597;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=PNUAE79CgL0bg0JitWWspForQHO7+2IYjl1M4AqBRyI=;
 b=LlCkzUcXrhtX5ypkeAyjB2omatdCN26oA6cx+/RKimYIySADgflHnkD3Tl9hW6Zgh8nX
 y1qFWu+wpozqvjou72aAOYDDbFePfMyTEIf2qr2SWvcVTp7HbxUtqW3v3th2NWkHb3vb9
 koM7xZbguJljPbV9qs1HsGGqusHVEiuaRP4kDSTD/K8vR+BgDiUZyrnmEtDxH0G6q/Des
 0mzLP/lzLQ5ScxR820mXBBpn825VuNtS8+29SLxu6enoocvu30zUYuEiLsj26WW+13S8s
 NYTctb3H137Lm6msrOdWk69qZnjjLV9VcsMeOtoNQxfhCtX4dfsshzLaq4V2TIexuQA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SoPz9hXF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=SoPz9hXF
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A0F1A81160
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:17 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4c27f0df6e8so165260b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789070596; x=1789675396;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNUAE79CgL0bg0JitWWspForQHO7+2IYjl1M4AqBRyI=;
 b=SoPz9hXFWUZAzvblqHoU4oLt2m1kRYKVWbMnplge3NOxxM8J4B1J7oBToWldpqdl80
 I7rQjkYzZGJkOGS7oPHq3z7pQG3Kow6f8DXeABGzWrRgxmqxiar816lSm4CwWuNwxKmM
 7ieQ5vyDIpwht2s7yd+z2AXt4BZs0LK96F574=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789070596; x=1789675396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PNUAE79CgL0bg0JitWWspForQHO7+2IYjl1M4AqBRyI=;
 b=Yh698ohosYSuCLRSGR8x+nZg0vhM4dQGJcpoa5QwVE17yJbKJFwgHM0tyHRTMAz4BB
 7T7JgcIvr3rELx54rE/7KV8Q48SANHTp4aS4JkhpkK38BOOr4HAp4LGRh0A2KrpxBTvk
 tFP5GLs6yEs2p8hV1AlwxAcPFpy/YipWzqysNu38M/nu/lFLH5cRGGd9wcHJ6NDKSlgj
 MlTfOCEMKwFA2eJyDbNv6mCa4dU0cAAanqYBdt3PO7hCi7x/UMSu/R1rV9yjby8alMSv
 yzW2Cp0hIC4q6Rhu2F6Fm5rEdGOFRxfuoOeclMNhqdPYS8RAJcyu2M72HuaR4ZO0bSXb
 PhIw==
X-Gm-Message-State: AFuF++lbGL1BFhNtewvu7I8HP0NjnovSr9G/7/486io1V37V6d0lZ0PK
 naCIux+tSA0GBO0bWd+vspEVfjMx8F5pciuW2w8fyFCrdBP/7gaJU6E9a6+WSifho2klzvxzm2k
 v3LeuL1/oMwiM
X-Gm-Gg: AYBFou1BynVEMQfRO1d1MRQdzPzIvOi+rdmYGaEaeqwjK6hcIHVQ7Elb/jS1hH2cdF7
 xxgVwpb2WVIbJY2SUc1mivIS9zqE6uSJ6RJHRxm5wiat3/cdVF0tz+ckZaJM5tbXnL62UUrKnFt
 PUimyzASKtE3sFAcw1mIzk/BIIBOAoD/ohQflUBqUc59UvTcTn4dWZQog83T8ZMMJNGzeW8O+/Y
 iZJ+LRB6d/DzTye4QhmbO5U/pUjiZYEZLAG73emMF2f4+bhwuNFRbnhDZLM68uh2BymX2JU6T7m
 bJInIlFNPvkLJFvVfkwBMuuxT2xHtBb98DBM9GxGmLWtgTmCOilTORncpHnT06EL2uY12DiPNkf
 P++A220SNtBnew7KKXTssl4cMZburn5stX8JcIeqCHleuehyfE0NAHO/+TCTNuyQan8di0VGs29
 SuqHRMHF5dWOeC0dK0Q65avvcovNCYdweiedDFDCWERaHkRAxGuv19K+o+t3rpNu+uOXa+9Syoe
 mecgCHN5h/5opcHDM9YM3K+ChDZXqUKBGeo4aPVjd3xwIBf3czAmmu6/7bb7M3cX0Jk6xRgpfSU
 AbhFCMd11Q++lBCD+3nilfUOnLn2h/ZKLMFU4fbvfIar
X-Received: by 2002:a05:6808:120a:b0:4c3:1005:beaf with SMTP id
 5614622812f47-4c319a41297mr452210b6e.15.1789070596428; 
 Thu, 10 Sep 2026 13:03:16 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c331bc937bsm208357b6e.11.2026.09.10.13.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:03:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 3/7] MAINTAINERS: rockchip: Use N for rk3576-nanopi-r76s
Date: Thu, 10 Sep 2026 14:03:05 -0600
Message-ID: <20260910200310.3503830-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910200310.3503830-1-trini@konsulko.com>
References: <20260910200310.3503830-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

As part of the initial discussion about ensuring MAINTAINERS files don't
reference files that don't exist, one issue is ensuring that newly
introduced files get the right maintainer. In this case, add an 'N'
entry for rk3576-nanopi-r76s so the maintainer would see any new files.

Signed-off-by: Tom Rini <trini@konsulko.com>
--
Cc: Michal Simek <michal.simek@amd.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3576/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
index 79cf9e97f70b..baae63fc7b08 100644
--- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -13,7 +13,7 @@ F:	configs/nanopi-m5-rk3576_defconfig
 NANOPI-R76S-RK3576
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
-F:	arch/arm/dts/rk3576-nanopi-r76s*
+N:	rk3576-nanopi-r76s
 F:	configs/nanopi-r76s-rk3576_defconfig
 
 OMNI3576-RK3576
-- 
2.43.0

