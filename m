Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D2AC5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 20:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC19840705;
	Mon, 10 Aug 2026 20:53:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yVMHXVx5yTzO; Mon, 10 Aug 2026 20:53:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D16B2406F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786395217;
	bh=5iZwP77wlstULlfKpIU5BLPsJU6SAxgA33hvOA+GzPQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SlKQEvtornXJYU4ul1AK0DOU3RLL3IVTEvZ+IL/3bY1rk3aWDOnEApskxC4un5M2S
	 fA1ivU3ogOSnMIuNWmBz7c+V/SxWfjlLE3x4WKKIgwxpZcFNP1CV+KZlDW32Exu+sv
	 JPw7WkqlHJP3nSYfPq5S+j/916l/vq3Sg5n5m49RfoXRCIvX4xka1DtCnMTokdX336
	 nhqzQ/5kscEgMlROdyzjG7lPxRDvuX/lQ9yNwY+iyBPEjMsGFkLjOAj5a7B3dy7pg/
	 BiBrFA8EshQezxp6hhsiwB/Xl3rBPZZglXbHiDyusdb9SYyZx8UZGnpnOTairah+0B
	 63rxO6h48uptA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D16B2406F1;
	Mon, 10 Aug 2026 20:53:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C3A423F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E112406E7
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nif4tYmedwok for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 20:53:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F1084406D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1084406D2
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1084406D2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:31 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so2412005fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 13:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786395211; x=1787000011;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5iZwP77wlstULlfKpIU5BLPsJU6SAxgA33hvOA+GzPQ=;
 b=K2gnBzBAQjU1BYEh5ajYyUq40Rxu94q/pOEZLw1yW1gy760V8TjJciPnzJQqfe2KX6
 4X8fxjIlwMPHh03Ql1BL4W7ZpREmQE/l4G5CjAFqVJYbeMNUKhhATBTo1PYjiZMh/vS8
 VFO7KXH80ddH8kjozUmW5Qmz6CEJPGMUWsI/bau9j3LkKMuoFt67WzgfP60dcpJ7l3Nu
 WmpvZtWtFqflCOMM4BtCShTljfyQhxwHgF7yRhcKDFzjStIEiqKSTnX89YIF8Ws65fyW
 PflR1/EB8/RF4y3NsDnEvZWA2xPzx7jHk/uW4SJMOwMQHQ+agmHpvuBuQFyrujxxW5Ni
 hL1Q==
X-Gm-Message-State: AOJu0YwRX4hMt4TQ8/kM8kq8PJW1VttsILIkVZfs6o4wt7D5WyTojqCA
 uArBgaMR6cui1eqsuAtZ11Gprmata3LA2ki0+R0+PplNrR9hzEGsmUIKimz7QKDXcY5BQm01SEs
 c7IbpsdM=
X-Gm-Gg: AR+sD12uUK0ALCiSjfrXWGcatGiWPKPMQrJn2vsWJpovJ+Y2pslJrgtb1IfwqcGASpK
 qnsxKGr4erT3uXpR09K2i5h2EEa/vrrUB6qHHlmcyotq1DxWmkggrj0wH3x9xK3lfCWezmEwca8
 IxmfBTXCLQqyPgyDoPrPRzBPtrHEln0phewMjs0fniM1wyE+l9pO+ubvjI1CuFtSH9pL5jX5Ot7
 rivkSDZQPQUsRgXscKvNdA8sYyMcVIgS3fZWY+RLHgzubn/zzN+ngA1cqwbQm//RaG+AsC9X7eV
 /EmrrBn+3ncy5DkKxGrjiAoQX7OCM5SyFrcXXFGTUPK9llQpN6DvnWpT/+Yq602bhuzg3rszGi/
 PW43lPo+xeYKVPCpUzeTUwovLgO57+bPPnXzJkYgjU7lDFwJEgzGrBLPNiPJVt6vMhcCPYQ1hTI
 oeB7mfOVHbKeIpP/Q4t05m56ieA/tffzfHbrUi0q5KAGAP85qOhxe87UjCDq/DHDFXZhCHsCNUL
 wzImgDajcgtdQ4GLHvlIC8q11LeSDMUxCswg5xprYB1EcUyD7nyHKU+n5egq9DLJA0woCy1JlJ7
 P5afiba4
X-Received: by 2002:a05:6870:1401:b0:447:559a:29a0 with SMTP id
 586e51a60fabf-459ff0d7418mr13196351fac.0.1786395211027; 
 Mon, 10 Aug 2026 13:53:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a76701sm9061652fac.5.2026.08.10.13.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:53:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20260721194828.398524-1-marek.vasut+renesas@mailbox.org>
References: <20260721194828.398524-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] board_f: Call initf_malloc() before fdtdec_setup()
Message-Id: <178639521024.1450255.16734759763947956211.b4-ty@konsulko.com>
Date: Mon, 10 Aug 2026 14:53:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786395211; x=1787000011;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5iZwP77wlstULlfKpIU5BLPsJU6SAxgA33hvOA+GzPQ=;
 b=NcFkRUFj7nPPpMhKZB8d6ou4eJTx6R+5FlhD2HtZop461uAdGM34i22M2PKeKkYG6E
 kzzeaE1cHfGQXNuzJfSCyw2bszwV0QEzRiM6vAkhskSLJxtG+LMXY/whbQl9SO25Oz0R
 4vNnArniyPkF+DIEK252EhmfoMOiU1rbzA2ak=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NcFkRUFj
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

On Tue, 21 Jul 2026 21:48:02 +0200, Marek Vasut via U-Boot wrote:

> In case MULTI_DTB_FIT_GZIP is enabled, fdtdec_setup() does uncompress
> the compressed DTs in uncompress_blob() using gunzip(), which invokes
> malloc() internally. The early simple malloc is initialized in board_f
> initf_malloc() call, which sets up the early simple malloc limit and
> offset pointer in global data. Currently, the initf_malloc() is called
> after fdtdec_setup(), which leads to malloc failure in fdtdec_setup()
> during the gzip decompression, because the early simple malloc is not
> initialized yet.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] board_f: Call initf_malloc() before fdtdec_setup()
      commit: 8da656ae6a9778ffe111c4a3b6a7795b2e7ee6d1
-- 
Tom


