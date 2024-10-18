Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D75ED3C541
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC7389143;
	Fri, 18 Oct 2024 03:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bho1CwAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59DAA8918A; Fri, 18 Oct 2024 03:57:54 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D03C890A9
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c5acb785f2so8788106d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729216671; x=1729821471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KY8I6ACah6uRulBtuWYPphxLfcVXqEhRhiQwdQQZtzU=;
 b=bho1CwAzUlHJy5fzS4NjRmHW5ga0109cM9Kba2CqzQKc0S9i77avnbOJbUTnUmoLsP
 p6bSu+YtQH76kKEGFlZJbcfOg0Ea0TfuAqxtBpRfiQEpGkWMWp10vzuvEg6ipsoP4KWq
 w3baMUppPb4At7LgjUDnMsFYYsRUpfF77rjeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729216671; x=1729821471;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KY8I6ACah6uRulBtuWYPphxLfcVXqEhRhiQwdQQZtzU=;
 b=oBfGF7G68ld92UbH55zjrjiBOY+FoTxJHc35q28W6PZOQZwrnhTjg+w+2t+0OHaORp
 7zLU+wEb1kNUT2Zbsvxki8KgykvKihTHTA1wTV3MLpcOw/RBPaFUGZf4go7p+kU0op0H
 m1YojwS26eQpLSeYGtJe7CY5szvF1u8sjPtkYOdcpnAngJd9o2f+BCUzwPLdmUBksfDr
 Kmjn6mkiKoy7UlfugNKI2CvFr5yywkx6JIPW0Egm5+fe8xrUI5vEAucJdIC8lXrwYih4
 VTbTT6DMEYyUXcYAhaWX8mkj8NeBawZw2xWy6qunhU6SSDejz17H720a5DGQ2BtPPwPc
 xSVw==
X-Gm-Message-State: AOJu0YxqPEZs4HZRVZXDwt7gA50YtOOcHLMHvnJboB6h0F4i/CMs6QzE
 iBrf+SgX74VToAtr0KLUdB3gwTagDahaTZWj76TaOWYGAkEDma/Eqv9i5HGW6BE=
X-Google-Smtp-Source: AGHT+IH6hqdfNmxJWnPt6mQIZX3MTmfrKaAwkiOM+rDyexSDuVW0VJJQP2mzx9nXE+hdjY9WZO+OYA==
X-Received: by 2002:a05:6214:5981:b0:6cb:c508:809 with SMTP id
 6a1803df08f44-6cde15f1412mr15798806d6.34.1729216671260; 
 Thu, 17 Oct 2024 18:57:51 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde1366ac3sm2332156d6.113.2024.10.17.18.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 18:57:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, 
 Prasanth Babu Mantena <p-mantena@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, u-kumar1@ti.com, 
 n-francis@ti.com, vaishnav.a@ti.com, s-k6@ti.com
In-Reply-To: <20241009145703.1970034-1-p-mantena@ti.com>
References: <20241009145703.1970034-1-p-mantena@ti.com>
Subject: Re: [PATCH v2 0/4] Cleanup dma device in spl and move dma channel[0]
Message-Id: <172921666897.1016776.17238364765005507326.b4-ty@konsulko.com>
Date: Thu, 17 Oct 2024 19:57:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, 09 Oct 2024 20:26:59 +0530, Prasanth Babu Mantena wrote:

> The channel allocation and deallocation for dma copy was happening on every
> dma transfer. This is a overhead for transactions like NAND, which does
> page reads recursively for complete data.
> 
> So, moving the dma allocation to probe and implement corresponding
> remove function and cleanup dma device while exiting from spl.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


