Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A61C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 15:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D30B81428;
	Thu,  6 Mar 2025 16:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B5crbKPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A5C8129B; Thu,  6 Mar 2025 16:41:20 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8545808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 16:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so624803276.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 07:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741275676; x=1741880476; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cvuototgiZaTshJz7okJcCwzTqxzJr0b0n5yvHLuCf4=;
 b=B5crbKPUs5OXXOdUEP88TYtD9IB4KHtH0UQltT6hdseWdc3YkdfVAcZ0XitSt/smF4
 0HmbUPovOZBQ9MMl8Ra1sr9LdN887petBnFKjhVgF3FiY0Flrkh+XeRChk8YBX1bgq4l
 tYgeBI/9Efu/DWVOUGM0gsY3OmzFUoxdITeoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741275676; x=1741880476;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvuototgiZaTshJz7okJcCwzTqxzJr0b0n5yvHLuCf4=;
 b=mgnbTZrwXg1pk7S3IQvrfZSVjSZKRjHhhPpxlwNpQ8hPJyPEDlcPT/9wTXsv+KEqgs
 RtO+lxjteHnE1erbw4CIJpBG488gVX+RmX3fHrmdcS/8SfzDgFedy6BPQj25ssOyYqp3
 Lt5fCwWuWa2t91AX/ip2WctqYTi14c3/M+EBnT/fiM3vDOqH+uLUVaD/LuBEHDCpHBZ8
 I+NajgdkkX95OcMRX0RQ3yeZyF1XE+oeuiIoztPZtVc7L86WDsbfAsqcjdFFezbVPif5
 gffiB/yR0hzrp6y3QoSnT6aUO0z0BcZl9r+l616Ebdxc8meShmeF3eqwVqQ1/qloUsmy
 Oghw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmIGY7DVihmCVErAe1YeXHu+wMRIhLANfwa2lOc/7zCVc6z0prKvI86+CBmhKN5xm7zgAhR+Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyBlh+ja7WW3W3RNCnj9//0X49ttZeqVHK28hLQewByo43ksQVP
 SN/M2Zv1om8CZXFtX5DAtf6ApBTZc//ZXfYys5w92RWmsfd4Ay7xxkGvG2lqqQkyG9serTcZzUS
 m
X-Gm-Gg: ASbGncvSi1So2vDaG9KWF8Oa1RL+ZcAPhDfXQKWuLtLx/A4OIpaPAoQfn6VIa6BGi3I
 kBdNBcHzDznDIzBJ7kvHvjgYQZRtvAoR7DknxllL/JzRjujNlYQauGfIzPqMTR34xGA49eV4gCy
 OJEZJZIXZ0PAMcesPzno20iFEF0Sevs3NZnfnl6YA9Uw6lRBvbsBz7zyOjy86Vm4pzLrWJ7TqwJ
 Z3JPBk92qQXP3VksxmKVNRUBqZe2EuAax2ni6JrCpCrsfJdgBsvUu8o2knDSp+P9ci1oGhGV4H1
 q7OTGz6vJzipay7PqfjYvrzr9FD8n2VHk/vKnumWBbvT
X-Google-Smtp-Source: AGHT+IEk73klnbaYinGZWG/BHWYBn+df6Hg6hkQ9U1ls0jerW6qDAIJbZ5uF5OVhXixb9ERevsKm7A==
X-Received: by 2002:a05:6902:2986:b0:e63:3e41:656d with SMTP id
 3f1490d57ef6-e633e4174d7mr4849485276.15.1741275676676; 
 Thu, 06 Mar 2025 07:41:16 -0800 (PST)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b842f58sm348755276.22.2025.03.06.07.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 07:41:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Joao Marcos Costa <jmcosta944@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de, 
 Andrea della Porta <andrea.porta@suse.com>
In-Reply-To: <20250302182931.15519-1-andrea.porta@suse.com>
References: <20250302182931.15519-1-andrea.porta@suse.com>
Subject: Re: [PATCH] fs/squashfs: Fix memory leak in sqfs_size_nest()
Message-Id: <174127567578.3636414.7625053013133006171.b4-ty@konsulko.com>
Date: Thu, 06 Mar 2025 09:41:15 -0600
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

On Sun, 02 Mar 2025 19:29:31 +0100, Andrea della Porta wrote:

> In case MAX_SYMLINK_NEST is reached while determining the size
> on a symlink node, the function returns immediately.
> This would not free the resources after the free_strings: label
> causing a memory leak.
> 
> Set the ret value and just break out of the switch to fix this.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fs/squashfs: Fix memory leak in sqfs_size_nest()
      commit: e22b2d778106256b44e8ed32e6ad7a5d8fff3ebd
-- 
Tom


