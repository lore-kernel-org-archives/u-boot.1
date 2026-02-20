Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B315C5B560
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 20:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD2E83D17;
	Fri, 20 Feb 2026 21:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XaqoyqZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4588583D17; Fri, 20 Feb 2026 21:51:21 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B20683A5E
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 21:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-40ee9b945d5so1511441fac.0
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 12:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771620678; x=1772225478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TwyUCmQOoob6z7wF2d4AH0AOGrenoBWuetX944cRxQ=;
 b=XaqoyqZIl6mJNkFTbs6GvsW1UWzN1vrqQ9EPbWz7j/ONlTWTyADqgFvPm9EIlNOn1p
 2sBuVe9bQxOVtIl9Nrw2NPvmMe2vvMZ2G0vvAs1OYKKYzvKCgDNpOH+zlCwZnFw1RrpI
 H1IQob/H6uY8A7/+i5Y0XYYrwS++MK0ENNSRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771620678; x=1772225478;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0TwyUCmQOoob6z7wF2d4AH0AOGrenoBWuetX944cRxQ=;
 b=ea0TakuPKRh+NM78urqkU8nG6PpEdRUhkKpNUBAWPxRfURVnBccTluX7uTxy5X8kxj
 wGUWOqAYi+xPhH4TlZAat6n5n3gPhU0gIF233gmsXPD4PbceNP2JZMNhy9P41/b52B98
 eW9R1BseS/5a6X0MVjkfXF/GjxsGMZ+lvk8JlXoJ9GQaDLdVEBBLWlkSTGYY2M8kT1dz
 BJlWmcdxM2CW6RmBN0JpAlipZYSOoij6mVXaCgaUiYB5qOXdmCE8mHlXCyP6RmgknZTS
 lbPlVQP4cnit9w4Zn7plnVSW5Rb9bizirvLIQPesPTwlYaHsL3En+2pGpG7RxBbehedk
 eNKg==
X-Gm-Message-State: AOJu0YwbzfY6XrqroWCb0dFf8wNZWIagp5MXyvenCgJ5zsfRv4JWIAqW
 KRyJM1FF2/poytj7MMz4JUgAEhLJHTT+kuSZlEXYPvM6j0WElXYEvrFYvspCxWpN528=
X-Gm-Gg: AZuq6aJNQaftjaHjohKukeL36CDmyWyHfgpSt1WlJaHsrtCEzhobDVpwujIlMgdecih
 /+rDuZrTWyAvslvroayrvO2FZq1L6mENIxeBcz3AjLjMLznBBj8aFoTktfR8pN7IgK1nCr77z1r
 rPza249BR5QbK04GbmPm3kd1xjBmEHSon6JHHRCzP+P8fuoK8irKc8imAHJPZgSegMEDYHz6Jwo
 nOGF8ju/tP0FdjAcCKxrY67xGPJBKnDvnfzVQj0B8T9nG2qNLk0KMZrCLJod4GdQPf0a8RUUUm4
 MdS4NXKmo6XqiKj268+iOjL7Ae11Lywa2299LLfvGqvGhC+CnAG8Zxqu2HadjzjaP0owI8LqVgJ
 xmT1O0qebNCgwiiM9NKf2i5l1iDYqp7ERTetzOlIVwBhdS0ox9+POZ2pHb1eXYwSLhZf0qFNRGi
 4dvCcEpief76fLE50fMcze+gyZUuq16U7A6NxIzNrE82f9uz9UUha1cY0xeCI4+MgW53BWc73zM
 qDzYVB+pZ3qJo3nWOYbIzqsRkEG+Af915oy/9DCnhO9Im9wn+wb8UGtgJCu
X-Received: by 2002:a05:6870:b513:b0:409:6ddb:110d with SMTP id
 586e51a60fabf-4157b0cf43bmr789790fac.32.1771620677777; 
 Fri, 20 Feb 2026 12:51:17 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cfed28esm525818fac.9.2026.02.20.12.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 12:51:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paresh Bhagat <p-bhagat@ti.com>
Cc: praneeth@ti.com, vigneshr@ti.com, bb@ti.com, khasim@ti.com, afd@ti.com, 
 sparsh-kumar@ti.com, sebin.francis@ti.com, nm@ti.com, v-singh1@ti.com, 
 vishalm@ti.com
In-Reply-To: <20260130143339.1401600-1-p-bhagat@ti.com>
References: <20260130143339.1401600-1-p-bhagat@ti.com>
Subject: Re: [PATCH] board: ti: am62ax: tifs-rm-cfg.yaml: Add C7x resource
 allocation entries
Message-Id: <177162067642.148229.2373245366757815576.b4-ty@konsulko.com>
Date: Fri, 20 Feb 2026 14:51:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 30 Jan 2026 20:03:39 +0530, Paresh Bhagat wrote:

> Update am62ax and am62dx tifs-rm-cfg with allocation entries for C7x
> core to match with their rm-cfg. Following updates are added for C7x:
> - Share split BCDMA tx and rx channels between DM R5 and C7x.
> - Share rings for split BCDMA tx and rx channels between DM R5 and C7x.
> - Add global events and virtual interrupts for C7x.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board: ti: am62ax: tifs-rm-cfg.yaml: Add C7x resource allocation entries
      commit: 587b1a56752f31c1060d39dd0bd439ff08ea44d7
-- 
Tom


