Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A62D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FDCA83B91;
	Mon,  1 Dec 2025 17:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RFWaC+Q9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EAFE83BFE; Mon,  1 Dec 2025 17:03:39 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A420183B81
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c704bf2d9eso2101322a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764605014; x=1765209814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qKkarEeREqKq/xW8T+oPbxbNi+o2zLm/BZFnTi3655o=;
 b=RFWaC+Q9dwhxzwGSQYGWUwJBYKDOI0O1/96WmnGbApTSxB1NaEslM2LfN/0ZakOZhG
 j4PVbLX5xrbkhlLzRyJXdxrFbHkobqof4e/cIThXyiMdxR8JUzq5NRgU5gsnfxJyNBDu
 U7mzYAz6+wugHTsBI+dIPQhkxIQghZisIpt3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764605014; x=1765209814;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qKkarEeREqKq/xW8T+oPbxbNi+o2zLm/BZFnTi3655o=;
 b=Sz1WeIejU6qIUXuIId2wKyWwVRatUCaVQz6b4jBZjQAcSdHGlJrJP7rHnDLzFyqzFp
 ePXwXc9BDuMd+tl2akmMM5T9hHkeNd12wgI/7ZY4X7Yh5i8gO9E3Q1qIVrc+Y5RsElbi
 KT/Jp1bUiVmuuOm/kwsiI/4UV5N8R6uD+WedDXa6TkikhHSM4X27cPg3bX7kjow5Iqyy
 ae8xh0kvOi3qMTJe228qSUrqd+mlXkVyjbo/lBaC1uM3NgJiObk3xI4pkxko4sHTWwAd
 LgQsvEoEqZd104irpMNwbrgLhJbY+hf1rD6M9SR30ybb/1xhEFSktAcckixt5IGh1aBW
 sgkQ==
X-Gm-Message-State: AOJu0Yz6ybbakDnPa1pWJsTPKzVgISpl6dcizqynvN85tXduqIt0VB94
 +CEaMGoBtqMkbMv+RJ1ZIalGzMsBLYc3rdZQsR930q9NvtwMivw2YeSHDGFA3eFO/ciGZLu66wV
 Ov7J5Xg8=
X-Gm-Gg: ASbGncvxm967y6SWdfoSkOOV/Tg9XW+M3PUxuwKR3C7vmaoT/LqXRBpiemISUqp56WM
 iLOLn8AgiemhrEM7lZwwGhu4iva5z5diJK+RdNthe/NifRV1kvxmh8arCgJ9QAloqq29rWHLHKT
 YiK91BHsqkXyZiAs0A4xGa4omdVjNaMp4of7uPZ5KYLkPvB6h1LtDPcNOqa8SWz4X8vbOA0HAb7
 NAg1xCfFQdGN5U6A7cnU9slNSFezIMZw4lbOW48xXDjbs3QIhdudB9qn47ZPukWgZMkke1GBp7y
 /t3F5M6R9speIcp2n0neWIqXeoBR78UR4hgjsL9/vnAUVDV+zX4ascPu0lYuauF8R9fUsrXX890
 pM5gmoFOA5IKQJ/7g2g3+3GPPGoB9X6K9o32FCKbEd6u4K/XSe38VTX4608ZksF1pZT+3HHU00p
 G8zFLJt+fB2rs7z3qn3JQLdOYwzaab7n6zYGOY2FwNRBJXzcnY
X-Google-Smtp-Source: AGHT+IEt71REKFStnwVd+Vtz/wuEW0hN1e6z8RDmUAJPOG6YKCYdWheABmG/RBqM7JSGDsx16KK0MA==
X-Received: by 2002:a05:6830:4191:b0:7c7:827f:2b6b with SMTP id
 46e09a7af769-7c7c44a6342mr14117730a34.38.1764605014283; 
 Mon, 01 Dec 2025 08:03:34 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d811asm4708061a34.1.2025.12.01.08.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:03:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251126215200.3887177-1-trini@konsulko.com>
References: <20251126215200.3887177-1-trini@konsulko.com>
Subject: Re: [PATCH] Dockerfile: Switch to distro-provided trace-cmd
Message-Id: <176460501362.1117748.16811529377658015069.b4-ty@konsulko.com>
Date: Mon, 01 Dec 2025 10:03:33 -0600
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

On Wed, 26 Nov 2025 15:52:00 -0600, Tom Rini wrote:

> Now that we have moved to Ubuntu 24.04 the distribution provided
> trace-cmd is new enough for our needs. Switch to installing that and
> stop building it from source.
> 
> 

Applied to u-boot/next, thanks!

[1/1] Dockerfile: Switch to distro-provided trace-cmd
      commit: 116e5a8466b11e9978404209951c017200a3f05d
-- 
Tom


