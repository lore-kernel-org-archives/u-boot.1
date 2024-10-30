Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DCDD6B6B7
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 17:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1BC58921C;
	Wed, 30 Oct 2024 18:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XUjn1Cl9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E34388C8F; Wed, 30 Oct 2024 14:59:34 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2F488DFE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 14:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d70df0b1aso5141980f8f.3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730296772; x=1730901572; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DVrTTRA8Uvo4DS4KcQ9n1hdCDlGlpTS9pJJiJlJi8VM=;
 b=XUjn1Cl9ruLrLrwfLo1/UGoOSrfLZgUeDh8xO7f/xP/cozC+x1O+dTr/N8mE1TXTly
 JXVM6wlqAa7pSOyswGu8oYSaCKJY35PxpScH+4PktBgatG7SNf2NW7XKyFikdYsnp8SL
 FGcySF9TNOHoBHVJS7gkC9AQUv8KFsIIsqi+kU0VrjbxVoO0TRf6CiBoQJacPemLdxPe
 NpfVxl70ENtjgYnbu4L7qKem4T8xF3iS/eSHgP6SJMKUNFY8H7hxOIM0OcGx0Cl7E2g2
 6gXU+QaLIOYyE7SWhmxbWZJRFB8MEdDf6Ekk5usyVmhf+XvVwFSKyNMAQ+U2WTRW8ZjL
 CWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730296772; x=1730901572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVrTTRA8Uvo4DS4KcQ9n1hdCDlGlpTS9pJJiJlJi8VM=;
 b=hrPcwz3PXlwCfQZgg8YG5wQt1aX/qee7nQ8VJqD1Y1zLvTrob5RIVcpzJP+Crc3DhD
 3d5ugFuTS6ivL0NH4sgm5quDhVNGhPWPSh+oHq3q4bCnQof/UBKMnswf6mHteBvqNeb9
 cOJmf6fQ0GoLBlyQME4yfW+I9lcnFRRBhJ1h9gFgqbXT4MKF5Zn1GyO+G9m/XRgfh2ym
 oGtn3ihge1Le9ukXW2k+WB3EvkNpIESLvzttLd/L8zeGOY55NOPz3gbLHk15Luy4kDOv
 gK7J8WCgu97KZsAoW0zcv/HhlvvzlkIkOxvsp03kyU1HlManqdxWt+XvktqF0jePW8Oa
 JTow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr9L4jRubwdlJ0rGmKUiz9kZzMGNI8FM5nOzBUP7ktMbVbH/tF4Ioxp49+xe/8MNFQIKfd6O0=@lists.denx.de
X-Gm-Message-State: AOJu0YwD3/Op3EfyrH66PqlxrRRvsxEqeQuvIaqd9J1HFiDyU7nlauQ6
 n2ayVqMLPayzu4xe5hWJ9v9khkVpHL5vIHTrrTpIU5orQkvacI8n
X-Google-Smtp-Source: AGHT+IG5nVQL5w3y3PqBKZZYDEVo1fjq6od6AuqWhDXmcRP05W0jPMM/mh4JCas/SGVIBFxCXmXUKA==
X-Received: by 2002:a5d:6943:0:b0:37d:4e74:68a with SMTP id
 ffacd0b85a97d-380611e0f5bmr11031427f8f.46.1730296771808; 
 Wed, 30 Oct 2024 06:59:31 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:89e7:cc9d:3a72:92f3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b713f0sm15422581f8f.75.2024.10.30.06.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 06:59:31 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:59:29 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, hs@denx.de, pro@denx.de, sjg@chromium.org,
 vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] bootcount: zynqmp: Add bootcount API
Message-ID: <ZyI7wUHvStGwg6ME@vamoirid-laptop>
References: <20241029185814.7937-1-vassilisamir@gmail.com>
 <20241029191230.GG4959@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029191230.GG4959@bill-the-cat>
X-Mailman-Approved-At: Wed, 30 Oct 2024 18:20:04 +0100
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

On Tue, Oct 29, 2024 at 01:12:30PM -0600, Tom Rini wrote:
> On Tue, Oct 29, 2024 at 07:58:13PM +0100, Vasileios Amoiridis wrote:
> > From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> > 
> > Add support for the bootcount API by utilizing the internal Persistent
> > Global General Registers of the PMU. These registers get reset whenever
> > there is a Power-On-Reset so it makes them suitable for the API.
> > 
> > Questions towards reviewers:
> > 
> > 	1) Is the licensing of the file ok?
> 
> Yes.
> 
> > 	2) How am I supposed to add a maintainer for this file?
> 
> This should be caught already under the zynqmp regex in the top-level
> MAINTAINERS file.
> 
> The code itself looks fine, but I'll leave it to Michal to further
> review.
> 
> -- 
> Tom

Hi Tom,

Thank you very much for the reply.

Cheers,
Vasilis
