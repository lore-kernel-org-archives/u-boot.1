Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21054606A322
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gEOkK5vS;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=tYbCNQQ4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E88C8607F6;
	Tue, 20 Oct 2026 05:40:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dufpoQ59nA_i; Tue, 20 Oct 2026 05:40:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 50436607FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792474825;
	b=Yt+Y4So+zICmZAi5Eeg23ca9i3/28f96ZA6B/qi010BUTcql6xM6FX4lL7etN2QAWwBO
	 43eQoje21nZTfb/cbcgoFIA8x2DtBKOm8VJH2jxJjwCJvOg8QV9187UuAxyyoG/MJsiB8
	 +AFWhO5LkDvivSE6NTcFYJ6nL3l/1DrgVHOYOHYGm4zBqwV7E925+Y9YDBKn2vd9w+Xwo
	 NoAEA8KsUXjsBtSlYevgvfidHnZ4vZ6n2iIRfOIFDAZZBEdmcraKbfviBzuO6HwvbVcEB
	 M3r55MzSGwywT7jXeRKknhQ7V8m/Zm6VZDn71nDr+ZIUZH42ETPt8p/8BbW7NoU8ZKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792474825;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DLGJowT+ZXD+Le3ypxRFfuGnTq9vpy0QhGgBlQoQYRE=;
	b=iutC0VUhxNlntYyTg7bHo48vBaKfYg/9ECzjRaCtJfBmCxtjn83/ITe78DW+1ylUocrX
	 ZYVErJJUl91sqxIb9nEWXaFta5tnGX526jbYAzKDa385DIR2Lq91d/O4KhCclaLv4ZzsE
	 VomzojpKvO5l7UqQg0l4zVfjOqkryzkivlOa74Dk/lJ2wBEParf/h7X13eVpuuJRZNX7z
	 d9s1cJquA9w8Pbc6LB4MlswCpCj4b+bzWIrnL3QaXKP/WwPZ3BGT82i1axr7dJt5vcxbU
	 46WOcYks345HsQSFYufzkx+/KtY9kBUzAMuUSZbpW68jhOpX2EViRJuoo5JnFZqpSCA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=tYbCNQQ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792474825;
	bh=DLGJowT+ZXD+Le3ypxRFfuGnTq9vpy0QhGgBlQoQYRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gEOkK5vSRO9zjKu/Dysj94VjCjTTQCXf1r4MSLMqDZCJIeZpY+U27DPFQkZQcK2jG
	 NQG9KOqQnO35qMi+2Ig9607baig2uF3VXtxPhVBoOtw9Hs1Rc7ha1wfm40Ttan8afL
	 QaFDVHdN1qTp745l6+DA3h30J+QYTIEazUXP9FnhEOhtuMXkFccpoIozB76JGhlWPE
	 Za8I9QNQsBXkECliKVufAjHwnSqzeF/y7qy6FzsT6ovE7pGxwyka4112dxP5uG9FBi
	 ULJ/QrKVVEDiekULaBQyrqolv9qAzBNnFl9N6VxyMpxa3aus08Buj398yvhTn62Og/
	 ccHIS/S5KBINA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50436607FA;
	Tue, 20 Oct 2026 05:40:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CA1CC23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB86A607FA
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:40:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o22euHKBW8Ss for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 05:40:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14DE5607F6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792474823;
 b=LoBjzNqMq+ZLnnNvEvMFQKXCqRXtnSqeCNjLJ01FzWWTGI3N7E/x1p0nGjjY37XFkOWK
 OGnFJpG5RGdrmmiiWZIUZhyJ9IxBMsBcmHLJ/yrofAfnTsuuINC4HJgODJ/kJJTdMPRZv
 Rych70UtzAC043EI850jDRpYcMuGiCMxOVJnawPASZu0XZR4bZ6JQad/NF2C0z95AwYIY
 7TeFHb6JONYDCfIeBQvqzaLmJUIl748rgEZgtDUKDKV+lbw87R/VQZo4gUtpnJoLTOaBB
 eIK4P0cddUqb87PuGiGhjS7PD3D0/xRR+cK5baxjEhkXNz1K6JOcGMGRx92mam3uYug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792474823;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=DLGJowT+ZXD+Le3ypxRFfuGnTq9vpy0QhGgBlQoQYRE=;
 b=idtnGGUU/4+0We7d/g0WHHMBAgkm/k8GpCQ2CmfaB3d4XX9Vf49Jo7DNZQ1jCx7Msfxm
 ndQjF/vBbGhqrp/EpysBP+Q4Ye64heQGF3pb/uLV/1no7RQg9OqqorT/Qza5aT+UoiKKo
 Cqa42XQYTsxmdpylUktD5upSSLZCs4ouR/NrGo9uaFDMq2RO/priZULKIAP96nlQfDvAB
 7xz7Qdtz3Sw8XQcjOu9kEnABZj/afFZGCneTJA5zEw1yOX4ybZhF/cEZyBlUbARnmDaMU
 Ag16UEuYWJ0sFbAkUjMtpB8OKJ/EMyFJ0io6GQZGeeA2sy3uuDdOgRjv3jP/pOQFV/w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=dolcini.it;
 dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=tYbCNQQ4; 
 arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=tYbCNQQ4
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14DE5607F6
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:40:20 +0000 (UTC)
Received: from francesco-nb (93-33-91-197.ip43.fastwebnet.it [93.33.91.197])
 by mail11.truemail.it (Postfix) with ESMTPA id DB1D61FBBA;
 Tue, 20 Oct 2026 07:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1792474818;
 bh=DLGJowT+ZXD+Le3ypxRFfuGnTq9vpy0QhGgBlQoQYRE=; h=From:To:Subject;
 b=tYbCNQQ4tkoA5TjXgbEUx2Vs4483JLcZ27H0gzA0sqG/vdZj62EYJiCmX6+1A5+EQ
 GnlsOn94WHVQ/d/AD4DimEaY69zgeltJQaYXzncHV6IgeimLMDMSArVzOukQf1uDii
 YB5Pt9dH57ysDyhAWfmc+QSXMvEti+oGNeOteXfHbdUcKcCRWh1SudlUNQfjKq7h8K
 fVn18p/+7lhdkeEMSZYF0Gb7SOm4Va0Qe+jr/MLPBpuv8ufv9bcVwb1OKVXzYbmfGP
 EPzPh/QVjjYzFmhhxMjnUyNbjqfLWtTJVuqqdDL8fJgMje55a1jBX17uvtpogUn+hE
 eQ4nfujIMmT2A==
Date: Tue, 20 Oct 2026 07:40:16 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com,
 stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 2/2] imx: mach: imx8: fdt: support newer GPU0 bus node
 name
Message-ID: <20261020054016.GB6592@francesco-nb>
References: <20261019125930.111608-1-eichest@gmail.com>
 <20261019125930.111608-3-eichest@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019125930.111608-3-eichest@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 02:58:53PM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Mainline Linux and NXP downstream kernels starting with 6.18 name the
> GPU0 subsystem bus@53000000, while older downstream kernels used
> bus@53100000. Because of that, the industrial GPU clock rates were not
> applied and GPU0 kept running at the default 700/850 MHz instead of
> the 625 MHz limit of the industrial SoC.
> 
> Use /bus@53000000/gpu@53100000 and, if it does not exist, fall back to
> the legacy /bus@53100000/gpu@53100000.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

