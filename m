Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62B6C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 20:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45FFC4069C;
	Tue,  1 Sep 2026 20:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d5sClc-ZsLpB; Tue,  1 Sep 2026 20:01:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788292901;
	bh=TVvYy7TfWnylRNcWYQG9A3uQILYhe8hkU3TKnv003K8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dcc11N/KNSNoBhQpbOuR8YO4K6hplAiM7QQWim7xdq2ViSE9dgXiHh3oL1tTPrvMT
	 yCgWE1VnI941i8CTt0BqbqdwyBwaYCgcPX3B4GwFRadY+H+SkhN9bv/FNe+6yJorTT
	 SDPomgQy/F37ScTRVOsrVismjyuncvvkQjZxRp9SmJ85eLRAS8IGUtcbDGg8HCcqRj
	 ei6BX1JV5V5Cs2hSvEF2dbzxHuJSiQMToT0BS/kcPgDJ2xhiw+/JRExzqGWbuTWSSc
	 7RJ/vM/M00m09v9PeYzGqZshHfuSZTJ2SO0lD40aJ7GYCm8EteHW/QhTpx/el5lYM/
	 mTAzmJHK/mOqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2414940462;
	Tue,  1 Sep 2026 20:01:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB6691DE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 20:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D156480989
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 20:01:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WV2G4p6L7t2L for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 20:01:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EC18jjse
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA75680987
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 20:01:37 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6b13496112cso183681eaf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788292897; x=1788897697;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TVvYy7TfWnylRNcWYQG9A3uQILYhe8hkU3TKnv003K8=;
 b=EC18jjsecEiwX+UapihlWtOn7yKQTvYWn2wjjzFGuWYHtJ/RkVTMNZLDIv24VBpK/w
 HsCe6jvh4L99mV4zT0QS8AE0OUvdQB9E56u7t5ZeIROFzsQFxePFbFmDwI7liFHaH2vX
 czhA/3BYPIPeO5nu1CdrAR2ddvb/sMv2sHMmkBipuwKWg6vLX2Lmr3HeeiRUanKSwekj
 ZDESI6b5lMznfz2yjCSO5i5ChSFngRsxdvFcXZpY6GyyuJdMEkde3fyLqpkAkilQUY35
 fQx36lbafkwdTBlbpblaVfKVjXT0YLsrYI2kiqOHOf0BQ2UrwnEiYVImed+sc8znGR4j
 jQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788292897; x=1788897697;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TVvYy7TfWnylRNcWYQG9A3uQILYhe8hkU3TKnv003K8=;
 b=guR9bTLHD6aX5Ajf8fFj19crswYZiSE2AWWaTzqyp7crza+HzhC7vqDIjjecZKbV2w
 78WfzIMM3fD3BC/xKDAQteS0G5Z/wFIvcRVgFzqYH4ZCqq1gEkmkjn3s6htBSltBp8KR
 kFyZpi2rhv8Y/u/ij96QNKMhZxztG8tDUjtSmbNWXhnNZoQZVI2BTnGCZfzRH7o7IxBY
 0tmjbnXT7SYLp1BmEBQEw/0OJfRqvwefivxW2zdOImcq6iqO+RKEbRAwhcA419XgZJxC
 AX/yuUUaEuWzztluNah2dmyXLJ43vTNyIFzgHagVY+j5aKiXeVyofsCMfhaqSe23i1zL
 nvnA==
X-Gm-Message-State: AFuF++mtfirNle4yqcmyL1UBKlMVFNaWR1gKijMHbEKYDyc44R90sRP6
 tXpx9X7AeGw4+YonhmciJ+vs26SyKT+gKrDJQmpzynlUgAfrS1ubUw90eAaayoCMiLhyFCSHr1c
 blJdQ
X-Gm-Gg: AR+sD11XAl4pbRu9ccZWkOHiENaYx92RqcnkMDbyvgBdyoYiTU1HH7112LVS5PqR+c6
 SRNKcCiTGSqtkGZgwAgltsaPp5CGO/UAQJHTcvNsD53G3Ltn5NvDiOgXsTYadPN8oLg79Hf5Cb7
 ci9MrcVzVIhuPg5ahxijIdQWQd1spRCZe8+7RfULkOGP3npshrbQs+MTbWYaGZvBvLxXJFc3FPh
 X6KFEBfZd5mIVbK5xNF/u3RTINw6f5xL+sZeRIAxjSJk4jUn0ho5o0NxFLGPh1RN1rTdNybNqzi
 MJTXkJideFoaYAAL5QxS2It5cqdNxoDSu6H8S1Pee7CNWldL0oiWIS5SDBx34Cdci7uRhtNOQYi
 F1q1ES1T+xa/ltkTxz/2GZQEZlafQCw6gJcAD6jRJxpRgNCAWIvHEaLyRS02N5jBnucBoZABS7k
 sh6P3FtXHXGq1a0aeqtldbwEAOs41GGW8SlBqiI8lq1xQpPmTndhQcxfo4hI6Vk06/Ow==
X-Received: by 2002:a05:6820:222a:b0:6b1:6f3d:2069 with SMTP id
 006d021491bc7-6b372d65befmr8003152eaf.10.1788292896884; 
 Tue, 01 Sep 2026 13:01:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:523f:532b:33f7:89e5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f32933b9asm905150fac.9.2026.09.01.13.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:01:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
In-Reply-To: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
References: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
Subject: Re: [PATCH 0/6] video: mipi_dsi: add common
 {generic,dcs}_write_seq helper macros
Message-Id: <178829288532.2485046.3695217578342081182.b4-ty@b4>
Date: Tue, 01 Sep 2026 15:01:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ehWFAywS5qHWzkSe3Do4iJmh0BAJ5p2Cv0Z8lci2wWo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqly8Yjd07gL1uwbOCbLHC4fLaiBd86qRsjU3eg
 Ra8HmaJR42JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapcvGBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ai4wH/1ax11O9/xPSRMI97PHDcPQBLkteuu3914fttrv
 t83XhPfrUdRSvNzuKGuBTgZR2UAJmT3teJuNULKZ4Inj67vZDnAYw8vvGsHj1Xutqhg4tI7QKag
 QICc/5v5C/zi7mCaIPrZlJulPng3x8oJuPniprhowTO+uuH1kzrtjK1pm5gvBYpCDOxBllxGjfS
 Pk+b62o2VIjOoDWgqNyGWNiPojMt8a2eoC/NUWQhRAMsT/veMNDFTtELyO0tHugaB6HQr14nQql
 dIUCHyZvsmHtOrjVzNv8J7dLj8ciZLrvKtobyMuMQ2/30IFdvt8on4AEqLSBCjO+jofQ4nsqVrC
 J9dA=
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

On Thu, 06 Aug 2026 11:27:06 +0200, Julien Stephan wrote:
> video: mipi_dsi: add common {generic,dcs}_write_seq helper macros
> 
> Several panel drivers define their own private write-seq macro,
> which is a private copy of the same wrapper around
> mipi_dsi_dcs_write_buffer. The Kernel provides mipi_dsi_generic_write_seq
> and mipi_dsi_dcs_write_seq for this exact purpose.
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/6] mipi_dsi: add mipi_dsi_{generic/dcs}_write_seq helper macros
      commit: 65a0f61cc4ebd398cfc7d9cbc48913a9d981da0d
[2/6] video: panel: hitachi-tx10d07vm0baa: use common mipi_dsi_dcs_write_seq macro
      commit: ccf2a3046fbe0a7e30bd28c5c601893b793f68ea
[3/6] video: panel: lg-lh400wv3-sd04: use common mipi_dsi_dcs_write_seq macro
      commit: a42498e1ddfc9cba1f343434d26ed14c2a19d9fd
[4/6] video: panel: mot-panel: use common mipi_dsi_dcs_write_seq macro
      commit: a8798cff1ab7fbd044686d418c93b938ff3423ac
[5/6] video: panel: renesas-r69328: use common mipi_dsi_dcs_write_seq macro
      commit: 09b4522931bbd1b5579676793ca0208da415b3bd
[6/6] video: panel: himax-hx8394: use common mipi_dsi_dcs_write_seq macro
      commit: 5448ede10499428bdc5c8acb4809defc8555712a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

