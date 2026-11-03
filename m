Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF98606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pDs8uybP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=ZICw2/ec
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7EAB80DA1;
	Tue,  3 Nov 2026 18:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FG-uCXVKakd4; Tue,  3 Nov 2026 18:08:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8FAE80BCD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793729333;
	b=FRLjxXg4u9OiRIOlh0aBWtjQysjcwwPQ7rQCI78fU351jUr3Uw/VnRgmtlyb69s6NsmE
	 5ySJJKGah69glwThYp9m+NIqrj8nG40ky9id8CWVXPF3EAk2qCiw55UUlfpWWEdtOf5wt
	 JtYQRVO0ky4CXbb8Vc4LjkWWjAJWEjcLYBtmJeEfoSG6dWnLxTLTJsDU+RYEmCNp5Ttz5
	 6b+u6kFNK8K8jpt6t1LgU/rPxPwhqA+JFxsTYJuiJxBSkVLcG4uTuNttqzoGZ2vgXt+EP
	 oNGwGim0yW+2tutjYLydK2E1Db7JiuyF/5f0Tv1iLZT36ssWXXNovJ3GRNipOm9HkQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793729333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KB8HBCeTO3iYLcuKEiAvitunFeMXTVmwhNWd0liJuW0=;
	b=pn/CsK/fFO2uvTK7ohmx6u6JmfkaPVLXJyguVylMfPduFiwJpiw5DSlL3knfAGRFAoxw
	 ghcdjhtbesNHzgkTwRYmZwP0l1yfODBdpDTiW0uaZx8hDZs2xHP+WpnuABf9rBsBpYqwC
	 bNid34Xwg8Hlsvpgkyx7qZ5eI+RgDP34tNnEVgtBS+oR5zy4wR39l/TNofDekiN2GxdxR
	 CrDaCaptlFmcSjRV/PL87qKxU8od+IV65Ii1n5zoLhR5wSYtHHH/NGFoJvkAuMpGayDVt
	 LHV8Ibm377p70HBvO6j3j/twkRkhTc6T9G0SQ5Lk10aKIi/V4NGsl/sIiyJSunhLTZA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=none header.from=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b="ZICw2/ec";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793729333;
	bh=KB8HBCeTO3iYLcuKEiAvitunFeMXTVmwhNWd0liJuW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pDs8uybPzNnmkitHnq+0yHyNB+lZPa+nLRc6MHVDnwQAPt/I+Qv9WnY0JOe1uGYa5
	 nUzgj8+6pxWOKK4l8uyMydU5OfYUKmsIi5v3LWJox8bGXHH7EP1V+h3Vvnk+ePeZKM
	 sjyUSH2x63FKTZLcVSpGO8dOxu58JfEJi522xhTPgwcLFBP9sbpIO2oVGWkmfjx4Mm
	 5XQDNi4kcpbUYSGu4yPpxRJsTs3pgXYeotF39Jrpy6n36O/LiRElHbyoyRLsdDbiyM
	 bsGvQCMKoGpWgNGsFShMwOAlFe+FRGGbOPCqksksEp3wurPYqo8Tz3AkqleR7AocUK
	 5C35JUc0YnNyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8FAE80BCD;
	Tue,  3 Nov 2026 18:08:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1933B784
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F34D680BCD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:08:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WnxCQIDNG_Iy for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 18:08:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC44080BB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793729330;
 b=fcielhMpBmElt/qJL55WNeRM0+cRItcnICMxUoihsMvvVL5EPt55Jm3PeZZigzVKSBbq
 jtP4Pca4W2UZqZIVhX+4UxelTwGnsfmR42tCsNdu2gKBuU/evRHQPutU6D8qYj7pjGyFN
 4vosAgecPbJTTgjAEqINbR2yIZOKcxdp91GVh3Q4Un6DD8MZxB7Gjeog5w+Ro6BbpG1JO
 KRuGUQEMsKaRhSuyYonn2/thSZwfw9EtAHx1HtY2ekE/l5mV1scIJfMLQkvWP91P8M2BL
 VwMMmfflj1rhd2fOYoTJCnl6c/IOUU3aMmKcnBwNYTn3yG/iwEUK4VVHfutDzw+eGhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793729330;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=KB8HBCeTO3iYLcuKEiAvitunFeMXTVmwhNWd0liJuW0=;
 b=TOVNLl4JYUH3noNNMuqNuJ9hAG74eRE3czBRLn1MC3VQuYIZ5aSqRXOneZU7vZF6X148
 GAIfb3C3QrLg00BkgsAMqBYXu1aTbYFfFBpUgIMU3xBhcLJopufYgOkrZrESew4/FOO95
 z3Gs/gCX6ZLm9zJPM47EccX9WL63AMxBg/eGEXUPT1lwFbtY8QgEARloNCZLzdEZ5OAVU
 AHQwvND4C8hCBbEFK9Ua0L9KF+yBAxRGPy/tUNz7Y9x1fjmAqA3PSrh40n7GIlPdw602j
 J8MwzKj1lour4z0b/3s8b8MJqQf7H+R08Ji1vJagcUu4C6PyaqQ9lgTsYt7u3lDD+LA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=none header.from=iav.lv;
 dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho
 header.b="ZICw2/ec"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.15;
 helo=sender-op-o15.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=ZICw2/ec
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC44080BB6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793729295; cv=none; d=zohomail.eu; s=zohoarc; 
 b=gp8/QSJUBbeVutleMhyLqRIB+PPwFmVF/ql0Vr9Vw2Mj/Uod9uaPJ4KUB6l6nSC/6UuuJd0u51oXvP7CoD8ncXS1P8R1yrYZgiaGMGWafJo3gq1o118uLWkkcYfzbGyeNVaxR0PuZ3HcVGf+3r9iOPaezK4a44s2KW3e4AP26HI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1793729295;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KB8HBCeTO3iYLcuKEiAvitunFeMXTVmwhNWd0liJuW0=; 
 b=Rb9Z9BNNWT2QcVOKjAoNBl3BsANyEOwJY8bbsw6v6aaBrMQhTi8Fzdj8nMCVW2rq0BSmN0IItpBkZnbSw6q6vzgeXAcLT8FxPS95KJX6cSwGc3ex7M7I9nuVpKpMN9eagPeAG8ml9uZ7CY083zZw0xYd+Cg8b47tIm/fJ1KXQuo=
ARC-Authentication-Results: i=1; mx.zohomail.eu; dkim=pass  header.i=iav.lv;
 spf=pass  smtp.mailfrom=iav@iav.lv;
 dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256;
 b=ZICw2/ec3c/+xBdE5PPcfKi5BuE+t67CqIYq2AI7ESc6NrwFf9RMYlnpVdPG3ugb/t9u6ot8ocaygqxMzZZ0vn4X34kpsJHaZikyv0zi1Rr/bHhV2dtfCahM6bs3yiPog7R+jT3K5GrorwWn2HEZ8XWWHrM5cBdyLmxBbNrGGCo=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=KB8HBCeTO3iYLcuKEiAvitunFeMXTVmwhNWd0liJuW0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793729293099760.5740200313933;
 Tue, 3 Nov 2026 19:08:13 +0100 (CET)
Date: Tue, 03 Nov 2026 20:08:11 +0200
From: Igor Velkov <iav@iav.lv>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: iav@iav.lv, Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Christopher Obbard <chris.obbard@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] rockchip: rk3399-rock-pi-4: Enable IO-domain driver in SPL
Message-ID: <20261103-re-pbrobinson-spl-iodomain-1@iav.lv>
In-Reply-To: <CALeDE9N5MB5NhLeyRiJX8TsaabLXpNCyFKu0sjoYufPaGiM5tQ@mail.gmail.com>
References: <20261103-b4-rock-pi-4-spl-iodomain-v1-1-8dfc34a5e2e2@iav.lv>
 <CALeDE9N5MB5NhLeyRiJX8TsaabLXpNCyFKu0sjoYufPaGiM5tQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

On Tue, 3 Nov 2026 at 09:14, Peter Robinson <pbrobinson@gmail.com> wrote:
> Shouldn't the dropping of regulator-always-on and regulator-boot-on go
> upstream into the DT proper? That change seems auxiliary to the fix
> for the voltage reset.

They are part of the fix: rockchip_iodomain_probe() calls
regulator_autoset() on vcc_sdio, and with either flag and min = max =
3.0 V in the current DT that sets vcc_sdio to 3.0 V. The I/O domain
then goes to 3.3 V with the card still at 1.8 V.

Linux does not need them dropped. The Linux DT patch [1] lowers the
minimum to 1.8 V; with that DT, autoset only enables the regulator and
the override is not needed. But [1] has to be merged in Linux, synced
into dts/upstream and released in U-Boot first, which is months away.
Until then a kernel with [1] runs the card in UHS, and SPL without the
override fails to boot after a watchdog reset or a panic. So I'd keep
v1 as is and send a patch removing the override once the DT lands.

[1] https://lore.kernel.org/r/20261103-rockpi4-sd-uhs-v1-1-fa394d2046e1@iav.lv

Igor
