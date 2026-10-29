Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8F606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l3mFzCH7;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEchO/1b
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4051B80F77;
	Thu, 29 Oct 2026 13:47:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iBCMqVt4IoNt; Thu, 29 Oct 2026 13:47:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F62A80F81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793281672;
	b=Xt2gvtaSbzpeRcAbLP0mCyF+//lWESAF04dz9kggpRd6m9wo/nCA6jrdl4hLwXwAIexs
	 WV8UVHQn0ifbsGC/p+BW0xixBf2nwfSD1Vw6yShaTDOWTcv762RPI6FpZSJQbfCpLYGIQ
	 6IBIXLkB5UfLcVNhlMz5SL75Ujsq9lVsqcm4AlAQOC4LBefMn9RWK/f/Y6/3jhVmo2SWH
	 BILj4sbj9bF5obW1C3sgxG9NmbwIv/s2AMTN1wPmZA0tfBjp1YK3f+GOEpb9J49J4OnGZ
	 vheZqlOcJ0tSg2n1PafkcTcUScy6etikU+s6hpn8ph/C0JArRyaadqxVsa9SVu2cK6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793281672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MnuFsTzP+5tG5Zkay3lRE8gLshKat6sFqs8lfgeiSnE=;
	b=WGrLlgoLrnxoA997ci18c4EI1JJn64oCabhs3Qcsq1Aa/VCr7HFByCUsEwM2RHsQeFZP
	 dRhnIFIYVh80aVAX+S2C/qACzhDwp7Q9k7qhSAyOmcI9pbFdTOgV8Q+xf/ctFI8Uxoyn6
	 XSgVpaJcmyXG4cTYtj9wX7VXUDLk0Il55LHHgjHlex2zbMwXsITs79R5lleKlnaKFwfRa
	 pI7HGScY84J/oCo7c0BQBjmJRTVlc20/CCGxwR4Dpea3HT4Ct64w4foIYnbMP7xhbZ+Mb
	 P7gFA7N7rdXV32psSGnJO1DPfHUM8epo/1+OMEhN16/fSTZlmxY59Mqy0yIEAUumxCw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793281672;
	bh=MnuFsTzP+5tG5Zkay3lRE8gLshKat6sFqs8lfgeiSnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l3mFzCH7TOSkdFeNNxAQDX7HE5Z2b3mWj+3YZdusMr123mAFeDylFsO0bR3WrJf64
	 6GEVy2zdPdzSwSJXOUto+llMeLb0OGurCwkau/AOPg0olXNb/8meptq+rgPLMWgCrD
	 SsH+Wcwm7LBaRvKWuBw2dhBRdzcy/YRMGwZkT0VUqQuUYR8i1cCE5KzgyjK6L9m277
	 YdNBgAZMAXPVCysFNNjGXWuUGRQp/bVltm/ZaO1Fs/KEzYm/Zm02MHBPXuSze122CK
	 rZ2u2f598QJUQg2jFcnxizLM7DghxLLuBikTXBNJ7AXVIH0Lai25rwYBDQW9x8dyYp
	 l5K6mpiiby8xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F62A80F81;
	Thu, 29 Oct 2026 13:47:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 27542972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D0DD40318
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w4OlgMeurSfp for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 13:47:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5BA2340024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793281670;
 b=oBTBJ4bHl6djSKydC5Y2q35GH+KnyXhGQBEnlIJvnnl+KF0Zf9VLaXeUGigvuaXs+yKE
 EUOVJM+zrn+l6VesdPbU3AUdc8tBP2VAbtCt0N6p2Sq7riaeDoDjPZFbCflXWqht5qG/S
 lEjQXQN8zZnaSLSybCN43e3R0Feyu/ldVEUIAtxUZR86s7DBN0iYb/zAT7YYkKuUcdyR3
 8IrcmCeeL1v9uKI38hrxg8ZIziyqJsBJjkGP910/rpDOk3Pe1nCMj+5Cqqcce0tjdhWF+
 5Xnp+yRqB0s6pVGqoXa6S56Q0/rKZYeeGISsTIpHyLcN6QAPc9XQwfzezR9lABLoavg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793281670;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=MnuFsTzP+5tG5Zkay3lRE8gLshKat6sFqs8lfgeiSnE=;
 b=VKdBCe/1aaiDDFLuE+RRnpfhufustOhQKRvWnwNSda0cKb1kAOL+na4686s9J+rDyft3
 CUMSD4c8SrRdpN8Do/3a/WXMrKXunrh1NPXJfG1zj3H0pFX8qePLWHpJ2UrTjsvBu8FFV
 yLV92SWceOyp/VC1+HYJBEQjOR+WuGF16qprQVe+XnEHq3Lo7qx3a64Cx1TBKrdUXrQrV
 Wsu0yDBUmdNpNGus1LT39NXRM/Of7NwI1p3fUvVcmBUvZ4U7ouE20KwVh3gmK3E/n5Usg
 5SWflK+Do8rqiKmAyxh+cuVjZm9cFDIaIJdV/n0shniiOKOkPz86f6UuHnY6GaZeIuQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="zEchO/1b"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=zEchO/1b
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BA2340024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:50 +0000 (UTC)
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-35c76e9614aso3029910eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281669; x=1793886469;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MnuFsTzP+5tG5Zkay3lRE8gLshKat6sFqs8lfgeiSnE=;
 b=zEchO/1bHhpglPZpZ4T06yDCOIodV1fYrKFNtQwsee071SV+zrSaLKqmNkaZvUMcAj
 JpzQOn6arYtcngQZ/JQcRiT7XqOqQYSGMsj5wvbvrCWUfv+hXNrRY6XWrKP4qzbTDyIe
 gBn+IT8ybA1P5gw9p8nV51RVJATc8P+Qiw5jpsf/ThUeGIe3A2c75pWVVsrXTPmq77xk
 l/HjSZ2WNmw8uxxNfEi0+MSCq3WehlvJSO9DWr12ZaQQCSsdQymiNkuriHBF6hq3Iv22
 uKWkHxG3uJnvMahA6NiUMs1rsFw7x0jn/A7WHLlYDI95PSBfcGZ/PJqM91ffOMr3Bhb+
 DiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281669; x=1793886469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MnuFsTzP+5tG5Zkay3lRE8gLshKat6sFqs8lfgeiSnE=;
 b=ej3MmvL7qs3Xeulct9XltWEhuV4WODqCUOlsQLwmJbZS3P8e6Kxkr12k0HRzXI1axg
 NlniuCjcjfLJl6LMe/3q/ix8P+FvDE0Z7cVZfrNdwsdZhWH/MSUDkVVpy3+adu2YISn+
 FtSX5spoqMLo+G0FVwrl9GNaLbbQTjM0w3vmm1VF3By1c+QolGSo0EBdE+vnAJP1J3fF
 ITneP8D0pXSRXpTM+qH7zhUlXB0Plh7QXQiDvukNWwbZs3MVFfGBZlEy3s6MeBZxK/ZH
 sGhsf1GhmKsOIcgN4mtXR4MffJOLbnxWsY0+xigV8dPAcEn9G65kMEiaIZvOUmAPormD
 sljw==
X-Gm-Message-State: AFq9FYJWPRaHXFxZ2OvsLdT6iIOe1ONA+Cpm9YyqmqZd1JRv2pQCjOJ1
 hxyvshlyiIqi33nJ4vgwuCcTxJZS2gg6tLXKGKDoL9Nu5Zsl5jxC2yXKPkcHOg==
X-Gm-Gg: AYBFou3xr2jiDV+QLo5vWDni32yjn7ufLNBPyKZmv4Pk0n7FylFPZjypW4dxJVDOLQZ
 J0Ao79CTo43YDmE6fSy3tYzbDTMYxuq8PVQaMyuW7sEi2aZ3UmUG33zU3svuHyY7vz5rCfVl9M0
 s9tmri3oP8xiBcy0SbYvpMqTGSRkqntO3OjJEheBkfa/Ekl4SFOkuarz5CvttMF7NAq543dfTIp
 OCcJKh7a5ZmK5nnSgNYg0n/RUgON2AGJNgIFpHnZaILEHGXw75+HYK3gbJvdBA5VDB1mRELy2VJ
 N1y+htShLGRBtTG0WWmtLXv5bpyQpiNtukblKxwYARvTDSbKEiCymtDRg6KJ0qfgmxladWTJR2h
 2zM66h+S81EVsgdGi3lpkwaKpEckJ5Cu49uhLkSUVfFzsSgUmytIIs9YC9BQlcUC/inRFUsIpgn
 pZ7787/8LQUqavDsULIID7yhOIW38OXa8qiAtSrmG/+SfJm2PuOBqAcIxZcRSsc6ZbMzRLyPd1h
 qYrgmDt/bBHqgP4OQRhUYhD0nMz+Ok3/6FQEwq9UjroJPmBeBUra7rHsvMuVYLAAkyABTTACWzB
 8OAPIkZX5+N0Vwtu3FwFFLCcIxuulQsQNZVtmxTkJDISnxW1Wag=
X-Received: by 2002:a05:7300:8809:b0:36a:1470:da0e with SMTP id
 5a478bee46e88-36a2044169dmr8928177eec.29.1793281669102; 
 Thu, 29 Oct 2026 06:47:49 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.182]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2390a812sm18032339eec.14.2026.10.29.06.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:47:48 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: [PATCH v1 4/6] gpio: spacemit: Add SPL support for K1 GPIO driver
Date: Thu, 29 Oct 2026 19:16:53 +0530
Message-ID: <20261029134705.3767-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029134705.3767-1-linux.amoon@gmail.com>
References: <20261029134705.3767-1-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add SPL_SPACEMIT_GPIO to enable the SpacemiT K1 GPIO driver
during SPL initialization.

Depend on SPL_DM_GPIO and TARGET_SPACEMIT_K1, and select
SPACEMIT_GPIO to reuse the existing driver implementation.

This allows SPL to access GPIOs required for early board
initialization.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/gpio/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 7f12e39dad8..3be6a9e54fa 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -457,6 +457,13 @@ config SPACEMIT_GPIO
 	  arranged into a number of banks (different for each SoC type) each
 	  with 32 GPIOs.
 
+config SPL_SPACEMIT_GPIO
+	bool "Spacemit K1 GPIO driver in SPL"
+	 depends on SPL_DM_GPIO && TARGET_SPACEMIT_K1
+	 select SPACEMIT_GPIO
+	 help
+	   Enable the Spacemit K1 GPIO driver in SPL.
+	   This allows SPL to configure GPIOs during early board initialization.
 
 config SUNXI_GPIO
 	bool "Allwinner GPIO driver"
-- 
2.56.0

