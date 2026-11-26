Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F80D606A682
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R58wIfVy;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Hb0MwMbz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BA4860AA8;
	Thu, 26 Nov 2026 14:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XJPndNPGq1XZ; Thu, 26 Nov 2026 14:22:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5930460A80
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795702924;
	b=VYgHLdkGMWffffPLVZ5pP0WtujTDrib4NyprGhe3elu5f5DdBlaSzwqo6SKqhbW5xl1z
	 lGOxLpB3c2r9gaJ56GxHtdGOd70nG+eHamsJ4ixkkUMUaGHlSWMHemwUVoarO0vxXYiGb
	 PfcrkP4UTIOmcLx4vtE2ib16RFzvO11l8cB5kE68pSL1vqN2Y9AQSipGVzKlPKGGIubEZ
	 ME2D5avC0h6uA7ULKmw1g54QiAxenVo85SW0tzB8jl5eoupoVjISeG1VV/U3DRyhXaqA8
	 OyShLV+sUR5TFpXJD4dpfjUNDLHFXzsM1P+WIwW7jV+1b0Eg2ZWMgZ3sepdDOqUzdIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795702924;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wH105ps8sNtopN3SihTcB0X8bKJT+2lwZV1yRig+5Qw=;
	b=ZHYTyt/B+1L/JtkOlY1BIUSzOys/OViBTTx3D7YMv3B4CWUkLWEAMmpS/q4Gn6+FWBJf
	 VxTpwXEDOLHmkViNdNergZfY6pJYh+qsRH7ts1xQuMWKMCmzvZQ9+XHeTatg4Vml26oTS
	 jhPUNjXzbT7YZh1ZV1AR3bnmr9PmAl6FAWZ6rz78zX4tWd+r0cLJCU4yClYX8e+zOKHDG
	 /TWhsqHH4BGWl658KmuJZfEvEnAezU8LLmuw0OJhjCdK7AXOOqqrJemANCpplUi3+GjSG
	 GdzGp7dJIcdBHPVWX5aPnkN7tJ7rBJyKuZiSBzW56iDSIwT3KP8i8nzooglPy/Jobcg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795702924;
	bh=wH105ps8sNtopN3SihTcB0X8bKJT+2lwZV1yRig+5Qw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R58wIfVyFsN0RIPL7reZMmNg3kK613aVEZRH+Br8uYpcbe1Lu8WqrtHep7LQjwFaw
	 JQCmbIw4ZcrvvtfBrZ5HtMbCIRoM/YQsRJuwMfdGoqRvYgxlPjm19GRMweuMRZ5O3H
	 rEZfLPHgZKEJ6gx0TxavWZoCS8v7AriEzTffSxt24kh6eWvMWYvgKlcZsHdfKz8kuR
	 yIi2mj2ApAsXZOYVGybbjewPg5EmPz6uAWO32tnKCwNgEqV/ww/n9osDds/xfYmBIR
	 mVH2mPZz7eBCAY/Mmo3gBCza7kPE1L8lEiIoT5YvUsBLry9cHuc1EB4+TyWUvB7l91
	 ry1GJyFUTuOpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5930460A80;
	Thu, 26 Nov 2026 14:22:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6DED325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9144404F0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id is13dPWbhROc for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:21:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BFCCD40111
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Hb0MwMbz
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFCCD40111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:57 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso50580595e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795702915; x=1796307715;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wH105ps8sNtopN3SihTcB0X8bKJT+2lwZV1yRig+5Qw=;
 b=Hb0MwMbziYwjV4kj0q/U4FU8VPJ6fie4KbxOWpP6a15jyrPYTkv/pHvI9P/GJBHvfk
 ExXoYddL/TdDTW8KM2OsqvC9ZsW2THAgF8YPJR0aroPTn0zEyT2L+XBaHZtlpjLdeW69
 Xm2VBv0ssmy+JoxFN155IRFuSXzpKj40oX+1z8C2lNGNq12P5m0cF8EKbaF6GpFGV2lD
 qq3XIpmM9RG5so3wV5PhagrT0q/ld9Ga1e1w8Cly7RShzg6J4Z4TMJbej8oSn1zdRr34
 7Rcb8Krud9E1AEPwOEE8NVnQA81hvD5bnwmWq1FoNpNPMMxLUdHRVsTjPj4SjYdgz3H5
 Gq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702915; x=1796307715;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wH105ps8sNtopN3SihTcB0X8bKJT+2lwZV1yRig+5Qw=;
 b=lpzr/eTlrx4WQXPYyV+WK6Ly6fiTpvy6idqjCTH3gfSRPcbysk+SNZ1mqh9CvS6+f5
 0TG7whRM/IvdsXImqTO84GBkq7pG+4g8hEn/EneGFPI07WyyKWIkvrqe0wJvTIHg8Ybq
 5qlebs1nszPUZuIXoy7HmJ3KPW/0ssH6zSiU6TTF69jyHQuJ/6gu9g8GKE9Sin+So28c
 Ih9Meb0934gX9p1QoJVHMQUktK7ZNSZSxuN2UM55mlz2d5GRRnzMUvRrBLlSv/0aGzXM
 pm2vvpcB59+Rb9OD150n72KHcklsEv8As5xNtKwWwiic2YokoR4n6ZBHEGS7/3Yd2SXd
 2CUw==
X-Gm-Message-State: APuU4Z8+WSCEWf+cwiVH4bLIwscCpaHjeh+Q/D2M674jZ9eO7DQ/nkfZ
 SYwlMm4vppTHP2CHvEvgqqYggOrGI2l1UAe/h0k7ULa4JS67LcPDE3zOW+1eY9PKYNs=
X-Gm-Gg: AZFdTZdZOJf2VCxiqnIZyPSGHvxRDM3NJwobEdqg7Zi0od76MaJMp26AukkX8ZP6GYg
 TRqhmL4gCZ3JMfZu8KLNiTHXd5qMRDc74tocAzMITc0nrHJwzrMy8zeF3L+xAKczTdGrGrfNtSG
 hs2UAM70GeaZ1RQ3EWTu3d+3A2PEqDjyBiFcBwzCxx0qMWJqGLTkMmIJsPdE7FoCqcktyJU1Xvr
 7FuFijq22QG38syFA+GAMSlXY/DU6hy0fUeLOYXLasNAe+l3yHBm6d55q+W0nP6o6j7c3OQ9UDN
 uQVSCWgpev5r4zSyir9xLvnI+sORrv1rQFWUQz4cAztnduAU1Q/1jStuAi/oxBv1f4Hn3Sbf6XD
 A9XjI8kBx8RJLTn5JE0/uh29LUglL+Vye2u4AdntMvkN60MDeUp/QWvxbonaauPFIrIRfanL33w
 8d66bFwcieRTeRpQvGYB+eDEqFhNqeVq1heh/l12lntvCyHdFuowooTwOHIdEA6zsiWn9RjIy8x
 B7kHBti09ip3+3IIFdxH5YhQeldud3fIGDKNKbuGiq46bWPyX2uFCGEgkRMnmBR0h0H8Dfza2C9
 GGcsJXY5MVqTB0HyjVVhvZuwihlrWopsjQ5WPbcUE75z5zrZAu8=
X-Received: by 2002:a05:600c:3b91:b0:4bb:7e4e:de53 with SMTP id
 5b1f17b1804b1-4bb8881059bmr516280055e9.12.1795702915354; 
 Thu, 26 Nov 2026 06:21:55 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm387647325e9.1.2026.11.26.06.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:21:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/5] riscv: spacemit: k3: set boot device to SPI NOR
From: Guillaume La Roque <glaroque@baylibre.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Yao Zi <me@ziyao.cc>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 E Shattow <e@freeshell.de>, Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261122-06-spacemit-k3-spl-nor-v1-2-33beb921011d@kernel.org>
References: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
 <20261122-06-spacemit-k3-spl-nor-v1-2-33beb921011d@kernel.org>
Date: Thu, 26 Nov 2026 15:21:50 +0100
Message-Id: <179570291086.2502540.10303285258263029393.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702912; l=276;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=NQiSxmuLaTSFsHE9ebMQK0jZxVaGkOoFTynwtRH62cg=;
 b=F2zrdI+k8g5JFOVS89tI2x9z0aJy2jfPdC5yqmxmx7SGFwqgdDUEwVuqFeurQZ5UH9WT3xiGa
 MGlijz+3e8wDC6OfSFj7U3vdTAyUQ5122QY24uBhY7j+xqras28G0Fp
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 02:34:10 +0000, Yixun Lan <dlan@kernel.org> wrote:
> Configure SPI NOR as the boot device, so it's able to boot from NOR
> flash successfully.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
