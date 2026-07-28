Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D83C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 17:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C253F4089D;
	Tue, 28 Jul 2026 17:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RH0Igos1Kj80; Tue, 28 Jul 2026 17:13:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EDEF4409C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785258806;
	bh=vn3XiZSx9DfDuC/wPYKDT7Ze2+wtfHlN4XF9sjwKiTQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K0nrfXiYkMl2dIbb2Rf7UCoADrP95eZ5TMM62jUJaLcgMNhTyQ2kUdBsPepFHsql3
	 zQZsWrRe6utoJsf0asjtOiOAnvBlfHBAwET8vY6igqIDm4VM0Urz420EbY5ngavHKd
	 NmQLpyeNWiTgmqGYsDqmRaKmxselLGHnUekKPlc5jO23Rh9f0n2AwbHBBirCz4zWVY
	 xpSrFKjbVlg+riP9WiSckuQJ3j7dPeLM45vL+e0QjDkn0HcKtE5JUYdf3HJ67MbasS
	 UqpQoGKagFI0YGvWiElmSllHOR3EE1Syy2SPiw9v/LjusL6OdOEb/EoD1X9a4Ay1oH
	 ySr7uWms9hn8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDEF4409C2;
	Tue, 28 Jul 2026 17:13:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53B9045B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38FDB4089D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7GiJ_prAQ9kW for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:13:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4AD92405A4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AD92405A4
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AD92405A4
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:13:21 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6aae3e18607so53743eaf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785258800; x=1785863600;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vn3XiZSx9DfDuC/wPYKDT7Ze2+wtfHlN4XF9sjwKiTQ=;
 b=lwhkR4qI1tj3qaQCSd+iv/DCPGzeulITiIQowXPPpIPh1ZwXPJxUCvT7/luCWhwr7Y
 L/jWbD/LNlX9PbOnp7Gympum7ZIno5Hs5J6OHm+P8fHpD7qydi/MYJeQ+a3STW2DfdT+
 Zq9n7s52WY0i+zog0XbDSJ4xUa7jzi6Ftl/gChDQs5sA6zlbvppYeTdFnNr6ks+BXLR/
 zBsX1KT6SKXWIlNdeRGhY1PsB9P61WKAQYRfj2Y5wNRv0VBccNtUY/5nnUmab2kUZ8KH
 WunvsVGBFFd2NjgWwSjgtuD6Iiwhopb6Au06atO5qJ3vwJwJ3o1FuRX7AEHIq7iiMQHx
 hPIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5YOZrZEgw9o208qMCRpczntcmUNN+1UPZLSc1QIZHHB9dbip+H98kHXwW2r6+EP1kj/r4RLI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx/BP0u51cKeDpMfWgXoOaTsV5YY8Ca63wzr3u+/dhpfNJGDHxe
 +d9lMPo281uXF4SzKg6Lw+Kgu4cv2gwbjV3i21gj5ATGsnWKLyDra6xNTQR3TKEq2QI=
X-Gm-Gg: AR+sD13hTsg2laBGFzY4/mI405971B3uAhYbVCLiP8DksIZaEZOWPT7uj8WhOn/ztrt
 1W+lrwd+8Fq038hYDC5c4WguLn+RQ6AmgQ6C81O+d3i8xPkJSheMNd4Ibs3SSu1aRyaIyJxwDrk
 RF8FcNTv2+Nr8G7CRSYGtINjq0LRIfkG1WmKDhNpBw0LhoLb38H57ZmmuoOPDoaX1ZHZMvfRZcN
 te8Jocr/UWI+l5Zb7QEzq7Xrwo/5ebPmuAT/3ARawi06CkCHaNfz+vQm1MlF368Kp+CQ9drqwVs
 szz1tLx27FIk50M5xAx0UQxh5OHDvkYMXfjIbdcM4XpCxHPmbWYTfwUtCNntu+zujC3oJjZ11K4
 rTk2MhXOqHmlCsvNt0To3gedeojVa8KnKA9kZEsj3YqXKjHZBMUK7xghS05lpTkD+ZUKFMuq/Tx
 mixnx5NNkFjbT/tN2kSWamUtY2h7DoTPLbrK32W8mP29+vt2E+iH9JECJRnx1kgARzFswaLfcDi
 6lk5sL056WbfF1fZ1MZd0falg==
X-Received: by 2002:a05:6820:190c:b0:6a3:8988:5a1c with SMTP id
 006d021491bc7-6ac96caccafmr1698472eaf.54.1785258800649; 
 Tue, 28 Jul 2026 10:13:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6aca528b2b7sm2579eaf.7.2026.07.28.10.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:13:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hem Parekh <hemparekh1596@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <fb0a2123-60bf-4b13-ae03-332a780aaa11@gmx.de>
References: <fb0a2123-60bf-4b13-ae03-332a780aaa11@gmx.de>
Subject: Re: Pull request efi-2026-01-rc2
Message-Id: <178525879983.1614251.10086368503693324213.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 11:13:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785258800; x=1785863600;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vn3XiZSx9DfDuC/wPYKDT7Ze2+wtfHlN4XF9sjwKiTQ=;
 b=enEUi6nI/ypSEnWynAF1zcdlusEheUtpdXwhl/BRQXAOGef9D2KWzndt5Fy19a1Dpn
 HUULTGQr4bDbcM1TSNh7DGBfZobAVzWqscPA/Ssd27z5NFV36nAI/u2oWxxorD0YWNWo
 1zHAmYpPbmeTFlULaUxtDS6sJG4WX3yKxdYDM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=enEUi6nI
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

On Tue, 28 Jul 2026 08:26:41 +0200, Heinrich Schuchardt wrote:

> The following changes since commit b635d43bca429500cb8ef20aa151cb5773b9a8a5:
> 
>    Merge patch series "fs/squashfs: fix symlink load failure on large
> images" (2026-07-25 07:55:35 -0600)
> 
> are available in the Git repository at:
> 
>    https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-01-rc2
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


