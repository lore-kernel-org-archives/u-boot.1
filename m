Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A65C531CC
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 01:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A56040AFC;
	Fri, 24 Jul 2026 01:02:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TplOTzz9eYwV; Fri, 24 Jul 2026 01:02:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E4A840AE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784854939;
	bh=Og2s935BT6zWRCj+Yxpb66mctpTRFFPm9y7eGYa9xrE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VYZyRatsqjZKLHI25LN6/7kERwWTPxGR+67Ln185BszE/EAEVnwuaJ2fBdGfwrf8T
	 bL6aqdNHpRDsBo7UBFkjs7Bm3VjuuJcJK1pupTSeTP+f8Su5cV7cFIofa83cFNeQTc
	 GhZbkEDK3QcMklDE03xL8+TbKuP18n4OcZl3OxZkms75uXLD8m1YsjlP5ewt/vRMQK
	 dgLvm6BzpmnkMqBgH0t/3cqBZIJktBRqpN6yXKPrAyxX98ktCAd4PGWxk0EPyC48Yt
	 5vN9uned/QlZGz4m10Yr/RQZBXEfDHs6yO50a9IQGmZUT/+2iYsXQnjK6imhwfkLXQ
	 XK39DGNvmLsBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E4A840AE7;
	Fri, 24 Jul 2026 01:02:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C0C62E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72F5640AE0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vhfSCx-IUnzD for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 01:02:07 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 31A8F40AB3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31A8F40AB3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31A8F40AB3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 673848494B; Fri, 24 Jul 2026 03:02:05 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E80F803F6
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 03:02:03 +0200 (CEST)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4a483a552efso558986b6e.1
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784854922; x=1785459722;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Og2s935BT6zWRCj+Yxpb66mctpTRFFPm9y7eGYa9xrE=;
 b=OSZowmAq2VeWBiHeLyswBpHTjRpy5ywrb46lIGIMflmw2LmRR1wcCb7ckRCYmyPcqo
 MlCw1opWLnMYP1RqZcAdLMCUWEzPUfSVVc5OZU9ltCk/afmPSAtBt53o/u9FvEj/K7G0
 ZvmD1JP+/CpEVjjWuq8VlYLJfRAkGRbLL5jfqorPbaJIRNWyLOCKIlz1wT6XP1EBLmHR
 DGlOu7AKfhh2FJQFuCrfgeGLIS78AcGKN4hZDwc4b5wsQVL86GagQvO/3OBCl6dUYhJJ
 UVecbTXoXHELxDgOFnFuqMa0IxSDkfl0y1wdJox3S6mw+k6mRoNkjcidU4igprGFMR+T
 x/kg==
X-Gm-Message-State: AOJu0YxUYtsRSA+euKhKxFfgP8hFJ7McqXtLOI6ggkarZfObBiRLX3rx
 ltVGlx00NUeDu40+kpyTc8Pnv0SQZQoLFzgAr1i0y234/ak6LlNXpTsHVj/kfYiED0hO9fjj0WE
 iW/Ml1TI=
X-Gm-Gg: AR+sD12lQTy43X9WjvczCDIaU64dsTbwe6LVaw71IqiJR6uD01k/6Sc/5T7lY2fOMu7
 yBMa3qV4rPc3wkrK5R43nvEt5RHiq10wl82eBFM6GWt/Z3BDDvoQ3xJYsAp1NuOGzQRd9SAm/yG
 H2m6+iBwjCvZEcDcUQ9bpwfs8G1tbTjYJ0eUg+TpFtCHfVhYn9PNDzUyooxV5VtWMunkrRsfuPu
 pZS2yOtu3Wt5bx/dMoSpTR/vvokhaiozJ+Zw3DjZLGZ8w+W26wXasqot7z0UFiAtSIKFUh4cTl0
 OZEWNjLLNZire6il3R55735hpm08hzQevPClx3fuDjXg3ogKSfpUzvQZ9CVH4KG0yPIIc7qh3ym
 VRiCl51IoeH3gbwFDU4UfYhiDABrn9Zj7iLskmB5Kd3HNrN486Ozs3FuG0KljWJOEcOmMsPjfsK
 4lqivzot9PXgJsJeqGMJsCCNswfXDsfHKhvlEJSZZxlCJ7XwIxuJPCPGP3NaMW9dlceC4+mxnuT
 tihCDP+IVgbCmbczw1i2R5Afei+rh6mRt5U
X-Received: by 2002:a05:6808:6503:b0:49b:9a35:f725 with SMTP id
 5614622812f47-4ab354c1919mr3042444b6e.35.1784854921879; 
 Thu, 23 Jul 2026 18:02:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0c7a01bbsm4196177b6e.1.2026.07.23.18.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 18:02:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <clk4uaks6k2ljuzyobu4e7m5dwxgsdgtia5jfvhmargg2x4qfe@3f2jmjmsknns>
References: <clk4uaks6k2ljuzyobu4e7m5dwxgsdgtia5jfvhmargg2x4qfe@3f2jmjmsknns>
Subject: Re: [PATCH] cmd: pstore: bound path formatting with snprintf to
 avoid stack overflow
Message-Id: <178485492072.3246206.9845063442049127456.b4-ty@konsulko.com>
Date: Thu, 23 Jul 2026 19:02:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784854922; x=1785459722; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Og2s935BT6zWRCj+Yxpb66mctpTRFFPm9y7eGYa9xrE=;
 b=XuANMofCv8kPhvnUDJpzTFe/kFumx0HV4agiCxZRF8opX+K6yT1FySBESXsHQQrWX3
 Dip+hmFwepZBDuzeThx1gewBwt7VgedbbpBnCYJO8tyZk7CswUgEMvQS7cUXt9N4E8hu
 IUPn0QnLrwB4wDq8JFWIhbMauxPXP4vABT0Uc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XuANMofC
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XuANMofC";
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 10 Jul 2026 20:52:59 +0530, Naveen Kumar Chaudhary wrote:

> pstore_save() writes four different filenames into a fixed 256-byte
> stack buffer 'path' using sprintf() with "%s" fed from argv[3] (the
> user-supplied mount directory). The U-Boot command line buffer
> (CONFIG_SYS_CBSIZE) is typically 1024 or 2048 bytes, so a directory
> path in argv[3] can easily exceed 240 characters and overflow 'path',
> corrupting the surrounding stack frame including the return address.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] cmd: pstore: bound path formatting with snprintf to avoid stack overflow
      commit: 0ccd0a939d7d20c5a754a88c52450533932851a1
-- 
Tom


