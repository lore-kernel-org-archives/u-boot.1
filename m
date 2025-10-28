Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0014BCCF9EA
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6740B838EE;
	Wed, 29 Oct 2025 00:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BXnzQYBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23FC483826; Wed, 29 Oct 2025 00:57:42 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1058836F0
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c0e357ab51so5985934a34.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761695858; x=1762300658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxOfWqAY2aWZUZ4qn46MgrxX9BnOM6oV1mqjg+KL8Gg=;
 b=BXnzQYBtWxZdGg8X38Z8HDKy+qEaYAa03xButBOxOmPUIcswTWd73keZL1FFmuqiDz
 B9PP9GPevT6q+mLvHAE6Nj9j8yN+cFLZXGMe8loy9E7sZ15PUD8SJ1OHdBPUJEwkxPdL
 NopL96eA0HReAfx53w/zxBmOGAmFfUme63TMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761695858; x=1762300658;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxOfWqAY2aWZUZ4qn46MgrxX9BnOM6oV1mqjg+KL8Gg=;
 b=xRFnzNuDC8QZ6cWE0njFBFoeV72qcqe08Yvse5A7i0tojBnsGJQP9pvs11yF3timui
 1fZ2DeGJqHlhoCmew/5m+UahSNhbBfPDM4uDTGGi/uFjtAZKuyOuQy7JhfsbO7LFbxa1
 WrVfL2OolYTnBYNFItDkzUyBfpHcWIp+Z16VjvTjAbqbV/96pFl52UPYS0TD58MbiQrY
 1/vx72jOkG9D0K+l7iTj8yCNRcU7McGg2HgZXGRILdZIB6y81CEYBrqLh5tlyw7gTjG5
 8TQGkfNPODMvqLLCd9/xeaaNifdrZidUCBFe5rASkG+vkpPj2Y1TO1CxZWyYKijYYwt0
 KEAg==
X-Gm-Message-State: AOJu0YwYwvc+HrguCCf8IqQmuoJSrM+HGuX1y+jjac56VyI8o35zO9jH
 SG9WQPSs7q8BR33/txy4JTuyhaxALZcUOdaI8955peZthc9j09UpINpHgq0DlAP5MWS7rnj9JBA
 QHcSCeLYM+w==
X-Gm-Gg: ASbGncu491sZ3f5gMyaTfarRQ+ll/jSe+/xOEZURPhSC5qcXWds76V+OHp7NIWtA4pv
 IBvDRwpulAeoKMBHZBbIPJKle6rYPAzE4iPWOifBSbi6WICKWpMgR4OfQKYTuV0qLq+PDsIFdwY
 jyM+B25/2S+cF53eYMk5QusTEgRd8qxiseQ50sm+cgz8YswOI4nM+Crlsltcp2hqIrXYzxnYAta
 QSWfdHoKiUpPXYiH67UMz9/QzrYPERL8yuaU2O6/HFaV69bKHyV1Vq4YFm/tZKLOcA67TNrRib8
 ura4x/ZXV5JZB3dhOKxPDPeRZZsxq2dGsN2WzGG68cUX88vUpctMh7Iq4xN/BW0vERzIhSB/YZ7
 7znDbSTw8RRxBkZHEuwrUQM/A59ijqJbfAQdshVos0L7TNbdS6j1mS4kHuiJl2VVItwpg+bcRKl
 pITKIIrfPLI3PNNM8Wrs0QEFCC/GX9kQRPeZlZZsniAhEuJuwk
X-Google-Smtp-Source: AGHT+IGyCnDYIhyedMb9GgOJhfl124clhq3GtVWkapAPLIA75sCn9L3BovMzYMbCl2v+8XkTWS9/Xg==
X-Received: by 2002:a05:6830:442c:b0:7c5:2c10:b6b8 with SMTP id
 46e09a7af769-7c68303003cmr691731a34.2.1761695858339; 
 Tue, 28 Oct 2025 16:57:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm3646234a34.25.2025.10.28.16.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 16:57:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20250718011418.1333739-1-trini@konsulko.com>
References: <20250718011418.1333739-1-trini@konsulko.com>
Subject: Re: [PATCH v2] clk: Tighten some clock driver dependencies
Message-Id: <176169585723.2287207.9949398075883368560.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 17:57:37 -0600
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

On Thu, 17 Jul 2025 19:14:18 -0600, Tom Rini wrote:

> A few clock drivers cannot build without access to some platform
> specific header files. Express those requirements in Kconfig as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] clk: Tighten some clock driver dependencies
      commit: f30b6d12da1db7df7fec7c5927354514f3dc16b7
-- 
Tom


