Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD20C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 14:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC4582ED0;
	Mon,  7 Apr 2025 16:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jCL+i+5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F1C582ED4; Mon,  7 Apr 2025 16:57:50 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B92F82CEB
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c173211feso1170869a34.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744037867; x=1744642667; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M525CRQLB7+0pao1tTKTle3HByNr7vHOU2vO2MGbB+g=;
 b=jCL+i+5tm6oPRqowqaWBT5zYRYivL68rHLEQV1IYeChgFhNIitYvDmhPhYW0aFj2jy
 Z8rf+UizFvFVgmLx+viLOHn9b+gfsFhJAmdg1KrA8EY2+DqVjAnpQsfi7oUSlXfqlj5p
 xl1sSysjzTxGGDo9UANghAwXt/JayolZ2gGhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037867; x=1744642667;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M525CRQLB7+0pao1tTKTle3HByNr7vHOU2vO2MGbB+g=;
 b=kXMm8573Tx9kVvQ2ul05mt2AbNtoXYTLqnzEiTVpoOvUjWK2vxmyFARcf8mhOrLw3p
 ymc1V65KJhqLfhdHrCa6g9LOUHiXVg51n+QpLCWvkqzMspowDIaSKU1O+oxy2Aq9xU81
 dl3YPb9MB0A/weig+muIXPi2LaRg5YzJzbV8/UATjwzUZbeZ7flTJezy7SiEbukhk5tD
 wiFbVD25pS/j+/prI+QLq7PuQlHHLDtfoOAjbq7hc+BvJfmqHVMxFP3k0oESBHhvE3q5
 M98oMmsz9+pFRijOO3JdL/9jbQh6pCXw8i2/fk6G4QQAEMavtzPsYNLOHIHlG48nxWf3
 +5Rw==
X-Gm-Message-State: AOJu0YylWx2LAoF/uY0rBxcqXB4K4A8VNbcQycqinIIzTheGEUOg9CDw
 JdFNb+RszBlmk4F6Zlgp4U1IEChEoqfYPk6nl+YU3vJ4EZk5haI7/RPbbacv9no=
X-Gm-Gg: ASbGncsFlZYNDlIl3G9ba9ONJFKeLwF73/PzJJMTRT+iTzBp+3nAOVBs/uMPqUBu7PA
 UbSX/qZUBpwKWdeceyBuhmtYl67/+qUmuyHBTCDBnYW7n9U7pEf1v0TbS9pd1r0T0w9EeSIZJmD
 7kz35MvfdF2aNifVycmkfBQuGb1El0hUlZgR+YHahopkSgw+AytpVQzPSHKnr5YoiQ9zGEePyUo
 +iLcReMLL7DaenMbhs6Ez6pydZnRpU3Hj7WKp35d0of3K8iwDQYhHQ0Yr3tk739mt4jOyWxIJvl
 h/5l3HenNv2EUfkESdQSYGaQkGCEMWtioTttpi35uT/uAcQCDUmjb6TCZ78E1e9P8vzWUmzxtpb
 QXbqc
X-Google-Smtp-Source: AGHT+IHi4f2hTMAlKf9cVyJzCuRDDHxF70MhfnS8s02ihSALaAc+un5pXKJ00/PpqtkwWE0ao56oGQ==
X-Received: by 2002:a05:6830:6019:b0:727:3a2e:2132 with SMTP id
 46e09a7af769-72e369563b6mr9454762a34.21.1744037867068; 
 Mon, 07 Apr 2025 07:57:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e305b641fsm1683601a34.58.2025.04.07.07.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:57:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250407064713.71814-1-heinrich.schuchardt@canonical.com>
References: <20250407064713.71814-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] buildman: update PyYAML requirement
Message-Id: <174403786613.1222572.513327676677554106.b4-ty@konsulko.com>
Date: Mon, 07 Apr 2025 08:57:46 -0600
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

On Mon, 07 Apr 2025 08:47:12 +0200, Heinrich Schuchardt wrote:

> On Ubuntu 25.04 installing the dependency pyyaml 6.0 fails with
> 
>     License classifiers are deprecated
> 
> Update PyYAML to the current release.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] buildman: update PyYAML requirement
      commit: 38b34711152937b124ba91f0519813c161d9d60f
-- 
Tom


