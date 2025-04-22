Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9BDC369D3
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 13:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9736D810EB;
	Tue, 22 Apr 2025 15:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g1/9D5wz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA4D812BC; Tue, 22 Apr 2025 15:58:46 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46944810F4
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 15:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6062e41916dso279135eaf.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745330323; x=1745935123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PzATotUCBTGTGWC2+snzofddcDSlyb/f02NyeRdsT8Q=;
 b=g1/9D5wz3BxqcatIJYIuC+zDzlcMeDd6sDJLkcFMTQslTQZMglXbS25M3VGqLw+Z4E
 AcpfZ1dHZjLD3PskzdwHcDCsEDDHaXuU9x5W+haFlHqFElevi7Jn7UY0Qn0FZCYWFbR/
 Sm4jil7Tnni5x2m9NKjCyxmKZa2oQBAc8dnOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745330323; x=1745935123;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PzATotUCBTGTGWC2+snzofddcDSlyb/f02NyeRdsT8Q=;
 b=smTYR9u3x4OWd+cShuWv7WIIppzt5i1DI9FUoOC6LFW5uceLTxmevmjUakdQs7NS31
 t+WvuZkH2AHvm9pwfkD+r7fFlBKEucxly9aM7IIAV8k0QrUaOM59/s6bAS6GQnHIEiNI
 2YTssFyNM1naQcmiqwM4QrcLcLAuNKdUHkcIEtVOuqMDg5DfKLH6rn2y2L+WoG1dXlQP
 8tFzSmkb3pJ7jRRbOObG+Vp8VB2mrW2CP5spcOPCxlZHFRlMzN44HUUG0NgxylIQTTzq
 4p+1pZQyKS9vKUPo5i73E/W5JRFdt4BdwCl5hXWUI7/Vx/zgx5jk0tOqntnJhVFS3QfG
 Ckjg==
X-Gm-Message-State: AOJu0YwQDZni3aaQo5w+09XU1KH/GwEms9e/+yOKfcmPYGFVin8giaD4
 nmip8pHGY3Hq7y/PfjMxC2w1KbdMPiG23784oBWAv3xGGLB/CLZGvonh+TTFMuA=
X-Gm-Gg: ASbGnctSp7Mi2pYznA89oNqkbzLrqxdpjwBB1G1Npgs9Jvww1f0igookSs+3bqTxCGN
 LD1HH4DrkoCXd8+/MDRzf67w2OrhcslTyGD7daEpHGXcqyGQYwprHDy0oqr7V5Az7mj8dBQPqu6
 0FkthWIv/ZZb7Z/+jZnP+Qu2obcZFM6f7q8aBMWgZNmfNeVMFxNMQbAb+heQm0FpDB/YsVOyzwp
 5Ek/wRCCk6nghDcbcASVBUsNKcx0YNeZv2qyKt3vZbNw0XuIg0WKdUrbEFUczGW5fQyQNwd47p0
 W5D8psPOP6pdveK6VBrs+gF7chcNEXHOHmhjlCXLgaAtuPKudZK53oO2vc3uNvQEuxx3YhugiG9
 i8hS15t2Yq+Y=
X-Google-Smtp-Source: AGHT+IFS2oNbJ6w5Aoj/uLNewgmRCEH/5LTIwCt9gS1BiNyfyQG4gbzwxuPp2TloeTAnraufxdvmoQ==
X-Received: by 2002:a05:6820:208b:b0:604:6e6c:7229 with SMTP id
 006d021491bc7-606003dfac1mr7583813eaf.0.1745330323099; 
 Tue, 22 Apr 2025 06:58:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff69c9c7sm2094443eaf.28.2025.04.22.06.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 06:58:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <20250413085740.5953-1-marex@denx.de>
References: <20250413085740.5953-1-marex@denx.de>
Subject: Re: [PATCH 1/7] fs: exfat: Flush node before put in read()
 callback
Message-Id: <174533032198.481060.18232055894178381831.b4-ty@konsulko.com>
Date: Tue, 22 Apr 2025 07:58:41 -0600
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

On Sun, 13 Apr 2025 10:54:59 +0200, Marek Vasut wrote:

> Make sure the node is never dirty before being released, flush
> the node first using exfat_flush_node() and only then release
> the node using exfat_put_node(). This now matches the behavior
> of exfat_fs_write() too.
> 
> 

Applied to u-boot/master, thanks!

[1/7] fs: exfat: Flush node before put in read() callback
      commit: aeed1373724e862acec9fda972d352c9241ee901
[2/7] fs: exfat: Inhibit "impossible" print on write to bogus file
      commit: 21b04b3d72cfea587a8b616410371a191768c5e7
[3/7] fs: exfat: Rework exfat_fs_readdir() to behave like exfat_fs_ls()
      commit: 01a8121b7daa68767fe88fa92d436b95a1662bed
[4/7] fs: exfat: Fix exfat_fs_exists() return value
      commit: e168a57c3532487b24348351f71f9f6ce7d671ee
[5/7] test_fs: Add test -e test
      commit: 1761c298afd53423377fad95ebce203e46c084de
[6/7] fs: exfat: Implement trivial 'rename' support
      commit: e5cbc3d2874ff5ec80f4a5c92b5db61769670d5f
[7/7] test_fs: Test 'mv' command on exfat and fs_generic
      commit: 6696f144279f9ee588463ad645e1f0c9b555ba84
-- 
Tom


