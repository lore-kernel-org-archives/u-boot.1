Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9D4CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1193C60844;
	Fri,  9 Oct 2026 19:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fYFp0o0JYQKW; Fri,  9 Oct 2026 19:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B314606F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791573965;
	b=CqvZkQ29Ics91SRZAI2GOvX6OKYq5R21YTHABsdzr62e8vZTQ+jyiNUZYALgylMwShK2
	 diUFg6aiW5ncCx1S+zFyJ0DWmVpmJi2F0JxCgrRg3nqia/Tp48uZeEuqVDggHL3I2+ykl
	 ZroPWyOYfcNZ+14IOf9RPix15lINHRKy8ruw1lfpCArkLYFTUF8uMXwWG7Xbgtw0uMG/G
	 HvfK6J+MkUurXnRYXUDMlwEhoF1NNE1rZtjOvF/5ifZtILUPSuTVVwNqgRo+HodVlgdi6
	 UjoyntonKAtrhLnTwKBkE8mJwu6lzUpQH63Ro9vgBa4vcrhD6EUFLMY2le3PHYrxfsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791573965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yVP1pUa5YzJFKg9VOljJr12r4xoEJYdJK5ZKSw7GytA=;
	b=doO/lh7AIp4Gz6pCJJ4ORk686/QlppSfO4wNboBeu5tHbpQP23NrtX73nUX/1wbylTtu
	 E/m1sIUKn2M9b5xzYMTkCrrlnU4YfwFz0jZtQggcWWoLp+9se8qH6bcSiJY4dhujtj0tG
	 SugfpN8a7iHZ3roOP7PQBocqtj92Nm6UNTVDbJM2x729cj+n+9euhF2kTQ9uXZAdy0I15
	 5wBCL4cPUPBAszpao5C6X1rkiRGADVEIBhJDucjJ6Pz8sHtoMsZvclAxp4BH+PvR94NIb
	 uPsERT9YXEGxJoJvcPhcSBGAkhxKQ/0v8C4PAmJfdRlTvZl2IJUlUMz3cCPEEHCxG6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=I11FCSdb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791573965;
	bh=yVP1pUa5YzJFKg9VOljJr12r4xoEJYdJK5ZKSw7GytA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K0Jc7Uytdi0hcQuMgjKFsvnDB/n5TftpmLWYLnRXviNFNP9EZqrLO+HdTqnDbhepR
	 4/fEcuSbi+RXEe01Ds9IDYBmDgYKLwAqPetdeBl7BQp0Vg6qDwt6Qxe+Sb/3w8NhNl
	 Kfn6P9MPmsqATqLc+yNf8CHp5lp/4sWPSb/wwgr3LDxUAFIaBSrDgSHkkMyOOLrNWS
	 oZvf3Yw2/CQScH9sCffg7bUT0UWCpVf98fcSvWyArdNOk+UTg3nH7ambAXt6h6kf9E
	 nG5g/4I6V8EA3KFBnn+5UL10wcnRV7Rxetvs2gyk3NilD77nRhYF1R7Dkd2omOl9Oe
	 jdWiD5WQwV/uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B314606F8;
	Fri,  9 Oct 2026 19:26:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF4B513B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4725606F8
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQj82bWWxYgF for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:26:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 62C846066D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791573963;
 b=YOorg4oKr3Xs3gE7RG6YAwy/sLTQz8Spw2kH50MtlkzbF4dowJoyfm7BsCKN7rXiW/Di
 jIn9b9x+lZbPfHBtXVUBUyW4rT76CdtxyFuVWHSqOkwkSu+Qa8M1c9vMhw587FAJQSXuP
 H1ZyIMYkMAYUcao4Hs57AKqnZ2YDSaJrGHgWqA4uclFg1nzowYPWMcwTmxyH32afVItc0
 aHuNwCXZKeRoI5aZgnC7AKvFgp/XxiYoy2ongjgw5VUaA72J0bodQDflcRvxrPyl4AQDf
 DsOOTUvE5xw+yFb0kX39OAmH/xJPBh793aKBFcbXdDFIKH1SdXsD9PFoP+jDhCw+0eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791573963;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=yVP1pUa5YzJFKg9VOljJr12r4xoEJYdJK5ZKSw7GytA=;
 b=LNj6GZeqhRAMlOXgIUoIz15uXJXoJCP6gssCWMnnzHVwQywf68xkRdv2iCm8/mHJZWBI
 gENfKG8gq6ltdghdxKxF8nrIUCNVpC/ooR5E4eaGnckfghCL0XM+4yUPGPw/8NSUCu3fz
 vvBaTR1Tl5rJLgWEhhRIYMZDoPrQYRRwGv9FlzUZU+PqAIfVsquf7eb8eQdX/Mxxex9kz
 8OROZFVLQS9tdg+6suifzBcBpBRaV4GXMLFrFE1Mq9ZSy/wQs0Tvmc6ik1NgovOBRgDiD
 keFumFZ+XtHZXK9Px6IiG4xqpvzNY+EBB5MfAj90HO5KaeQylNGf1HAB04CowSG64uQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=I11FCSdb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=I11FCSdb
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62C846066D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:26:01 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4f9b643b13aso119002b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791573960; x=1792178760;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yVP1pUa5YzJFKg9VOljJr12r4xoEJYdJK5ZKSw7GytA=;
 b=I11FCSdbhM18x3RKNMIeYQ+hTC+6tfPiIKitPjGtMMhyyvmlzftSd2WCnvtCrvcSwh
 x4NAGSg1MpUkXRH5/RDyqoKflRkro0FvV/7GjoqYU3rA42pu/wEGvFCjUnuCwgB2O3nq
 M5CiEO5w6Z90I3MWI5vHNAMLD/T6Oe6jKG1gJYBRffw91t0MgxrII8WrOStrQr4IqpG7
 RZD412utu+j0k2zlbIIiWNeNM/wua6QvXCP/J0IeQx5Jlq8zH/mpXfYYZYCJo4vXtI7j
 NEFP/kUnLom9gFNackBgQTxG7/niURnsvAEG/Sv5vSKFh+oEvRcGciWlNz+sOJI3tadr
 5DVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791573960; x=1792178760;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yVP1pUa5YzJFKg9VOljJr12r4xoEJYdJK5ZKSw7GytA=;
 b=TweqEI6j8pi7To3ztgYmOPYJSCvgWmQdtkb+T2mr8I3cafNyCys6IJbsGy0uIMyP9N
 Nda5/HuB2GpdhEUBms7PUN+vqHXNw462QyHMm5xavMO9flOC8oPUnPev2hM9E1uVGAg7
 diJr9Y+X1G8ebbVGfZCT05t9qcUEiTrf/0rVP6lX5b0Wcj59cC18OOuLXKkGsiGGP1qE
 w3kKKGv2pDgVY9eJf7fxRE2M/jRtaBoQVmQpYAU+laPnd64bRh0yBliB9JsY4vPO34R4
 SDPpOViaIPCrj3Qhos5C1roxvZKgmi/fQTqPcmlDyyFFbx7SG73eT5b4gvSIDon3AO6k
 fVOg==
X-Gm-Message-State: AFuF++m2oMT9PtO6amCHhECKKYxIhUyBc/0ERjx6rxzrwlmKTYssgcKL
 AKMyKLgNjBODMxJSt/EiZ8KU1y6GFrTbzvSC4V7juvxLDhT8x7I3fFEb+DgvbZPkar302ujpGaw
 UCOwA
X-Gm-Gg: AYBFou0Or4JoQfPPcQ9PJ+MVYkb0u8jx5Dm/TEdF3dWaXCtplt3Hg2TNVDB026zfV/H
 In5oYHduFviMWTbPCYIHagHLLzxkq9EgL5in5I4by0AHsYsgWCdNHKW8n/93Fval4AT52DXJ67L
 prDT638Kogx4NBolmJl7tQFCo4mMUq+LXjEXxMJUQQoc2+cr6aeu+tvyRVRVVz7BUy2TgiREkiD
 Lw4ze9OXWHeKgGgY8PD8SXuwB5J6ocJVQwdqJrcdWTBLzY3ovPZpVYnMw6wPU9I43X4RbQJuwmJ
 YzpBGlQFV197R2PdWp6EHG25IgP7ithRHz5TNRQoBVS4UipKpCCIEactfniH+D+TH4hkij63+lK
 96RsLLv6yHJg1dO1x3aqQnoC0SkCocXhOC3Hcf0y3fgjujjvzJT5pa5XUL87eq+wBo6+tPQTaDR
 Vw5vFeeVuOn7hclgF7nRmfMzGSNpTx01ZlBJWbL3VHHe8HT6+mNxSOLWyF0g4/v3LzINtnkJgo0
 mk=
X-Received: by 2002:a05:6808:514a:b0:4f5:1202:9d56 with SMTP id
 5614622812f47-50c56de8578mr2381132b6e.55.1791573960433; 
 Fri, 09 Oct 2026 12:26:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe916sm3144798b6e.1.2026.10.09.12.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:25:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@nabladev.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
In-Reply-To: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
Subject: Re: [PATCH 00/15] clk: mediatek: merge single ops into mtk_clk_ops
Message-Id: <179157391636.1248553.16915107309869592365.b4-ty@b4>
Date: Fri, 09 Oct 2026 14:25:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2636; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=hxWXHpztr2v2ICgb1ZPBdsh5aR2xD0446/z+rnG7IXo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyT+912GDfgA0sQ9j8onsjMYWTK/hRyejT7yAD
 EEpMRyM2lmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCask/vRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmQQH/10qdB72RUw2rzcJbD76Qp6vjxXNUKfsLgSO/p2
 1RbEJ/7VNnfkPkS8oebwc0SywVE+aW0iyjYB0kPi+u/Hgqu/Qscj7a4ZMieOtlKZMlWR2PuOOP7
 x0RO6C3s6zF2ca8A9ah9Ehz3niwhVSuSFjGMAXD/YOy48/kuNOo9pKPP/z1WAriqD7sNUOe3xH+
 7AyvS8A5VLkhcdw0aHdP/aamdfaTtH8qaI9GtAvHpGOH+GNwqsvWS/NAJJsCQCpgK8mdl2/NxpC
 w6lqXcY/FYOuTKwXv/NarNcNOXPx1Zgsh6zQ7bLcbL+vT9UxvdbyFLbgnAXODdOFUwgzVLY8zx8
 oct4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Thu, 24 Sep 2026 14:41:38 -0500, David Lechner wrote:
> clk: mediatek: merge single ops into mtk_clk_ops
> 
> This is the final chapter in the year-long quest to remove duplication
> and increase consistency across the MediaTek clock drivers. Most of the
> clock ops now are duplicated code that can be combined into a single
> functions. So we do that and then consolidate all of the mt8xxx clock
> drivers to use this single set of operations (mt7xxx have some extra
> hooks on certain clock trees, so they are not consolidated here).
> 
> [...]

Applied to mediatek-for-main, thanks!

Fixed up the enable/disable parameters to be consistent while applying.

[01/15] clk: mediatek: add fclks_offs to struct mtk_clk_tree
        commit: 367d41c61a75e37dcaa0f3e42615434b478ff532
[02/15] clk: mediatek: merge the of_xlate callbacks
        commit: 16a16e613bcd0dac243e5937d58d9f23d25a03e7
[03/15] clk: mediatek: merge the enable and disable callbacks
        commit: dc814f155e21f949d3d35a502153b47d3a8f118e
[04/15] clk: mediatek: merge the get_rate callbacks
        commit: 812070700e7fac2b6f059c334eb5cf04f635c3ea
[05/15] clk: mediatek: merge the dump callbacks
        commit: 3b81c2a3c6cab081e393e01ac0589b1f864f8e30
[06/15] clk: mediatek: use a single clk_ops for all drivers
        commit: bda39b1bca72b9b471104415fe66d88450a4d722
[07/15] clk: mediatek: mt8183: merge the apmixedsys driver into mt8183-clk
        commit: ff3c69cabf189ea30ffe3ea1be6f750fa8a07e38
[08/15] clk: mediatek: mt8188: merge the apmixedsys driver into mt8188-clk
        commit: 193de6918d6537bd6fd34eb78f5f7bed9d4e4307
[09/15] clk: mediatek: mt8189: merge the remaining drivers into mt8189-clk
        commit: 1a8151be17a7ae4406653c5cffad9d20cd4fb91c
[10/15] clk: mediatek: mt8195: merge the apmixedsys driver into mt8195-clk
        commit: 01039780035638624ee04370650615ce7550eeaf
[11/15] clk: mediatek: mt8365: merge the apmixedsys driver into mt8365-clk
        commit: 57dc10d80f2fa78561033ebf326d39dcd8df51d8
[12/15] clk: mediatek: mt8366: merge the apmixedsys driver into mt8366-clk
        commit: 216015c98f2be9bd8cc63ac2262a331ee3d21712
[13/15] clk: mediatek: mt8512: merge the apmixedsys driver into mt8512-clk
        commit: f74fbdf159c1e15d48cf24335ada4aad0b77013e
[14/15] clk: mediatek: mt8516: merge the apmixedsys driver into mt8516-clk
        commit: 73777623b8e42dc6b474622aa15e5c720f8b6521
[15/15] clk: mediatek: mt8518: merge the apmixedsys driver into mt8518-clk
        commit: bed8b428c7349c714b546446bd7c32123f8c8774

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

