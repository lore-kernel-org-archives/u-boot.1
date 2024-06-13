Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CC1C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 20:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6FC88963;
	Thu, 13 Jun 2024 22:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UCNp2Sfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9FC888953; Thu, 13 Jun 2024 22:30:17 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D5B68895D
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 22:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c9d70d93dbso828734b6e.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718310614; x=1718915414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BReW5IZZmGqbtlK5XYOCCqMlx5KujHc5iRn265dyM98=;
 b=UCNp2Sfcp+2uO9sQOMipxBlqKm48jSusQJUbxT0O9lPMgDcYtQ9I32qLSw5XpyKTAN
 DK18L6C8j9e/jBUu6Y1QuLvUXi6UjZq0GaTbqwKDzVsd2HOGCOPUrSmO8UaqXEk9YEOR
 GKiklqPmYEhcdF7cJh7CpjggFUMRgphP+yiiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718310614; x=1718915414;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BReW5IZZmGqbtlK5XYOCCqMlx5KujHc5iRn265dyM98=;
 b=ZtcpOm+xi9lfPZXaF++fmEaZlOPPB9heJvn8P7Ip+75dMVnV/91wD79D96izywAOJR
 U9zN5PRLa4J3ofgN8+84QEgD+Oy3b+w2bokOoq71orTDcs/NY51o+MeBw/2jWyQTErjY
 QRUFjnL7WzAtHiD0wPovpPTFFvhE1nS+heuNOXh1ZwwBEYKbdLyV995GVy/Job89riSP
 d4CS0/icV//sJnvhR1LQT+xyC8bu4UgCW+2Mk97T3AChsC0mX6cZpLep7/5K2pta6vH5
 ha3pobWk1wr1iXsddMz+pixW0Syqch5z2GoPsqtii3djS+JuShMXk30oRMvMI9eq49KF
 32cA==
X-Gm-Message-State: AOJu0YyHDNYu6VIZqVupbMNUUXNz+BeJz9tvI6bBJL1QpRHvJmCZf6o3
 NUbTfDNcBpGEe4cAs47K0BLyaZAxJPFgGRf+rIQ8RiBA2D26TQszZWbuN3gwGjg=
X-Google-Smtp-Source: AGHT+IGGUqCx5TFvFFaxEEXbC0+f0tLF6JS+vlMS2pL39qQ6rM9/9bJU+0AmHJVaiSPhexGPbt2itw==
X-Received: by 2002:a05:6870:8a0a:b0:254:a778:6fbd with SMTP id
 586e51a60fabf-2584288f163mr873912fac.6.1718310613969; 
 Thu, 13 Jun 2024 13:30:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b641325sm330620a34.56.2024.06.13.13.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 13:30:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Prasanth Mantena <p-mantena@ti.com>, Jon Humphreys <j-humphreys@ti.com>, 
 Pratyush Yadav <p.yadav@ti.com>, Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20240604-b4-upstream-j721s2-ospi-support-v3-0-738aa77d9202@ti.com>
References: <20240604-b4-upstream-j721s2-ospi-support-v3-0-738aa77d9202@ti.com>
Subject: Re: [PATCH v3 0/4] Enable OSPI boot for j721s2
Message-Id: <171831061283.636971.11753895882895466393.b4-ty@konsulko.com>
Date: Thu, 13 Jun 2024 14:30:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 04 Jun 2024 11:39:09 +0530, Manorit Chawdhry wrote:

> The series enables ospi boot for j721s2.
> 
> Test logs: https://gist.github.com/manorit2001/6bb91885c608e3a8cb0267ab2c614781
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


