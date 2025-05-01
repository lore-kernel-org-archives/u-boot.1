Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6E1C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 20:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82485809A5;
	Thu,  1 May 2025 22:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oPW959Xh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA3F280FDE; Thu,  1 May 2025 22:59:12 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC3FB8070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 22:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c173211feso369273a34.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746133149; x=1746737949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L87vfB8gKDJGxbK92+R7pvJQUu7jgyQ9HFU+e+sn3lE=;
 b=oPW959Xh3u5nntzjL6HZKkTMS7J55u1/zW8DcC1zn3PkHP2WmkB7sB9fZ15GpY2BBw
 qtQdy8hu9aRqUV6KBk9PquV+UUXCWJIBbe2yPwrKZv2pWyRcWfBHp/smGeZsiPoB1vlD
 eDJmYz3hBNQO7jH0PBgfF+6kFhwujULJ+m4M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133149; x=1746737949;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L87vfB8gKDJGxbK92+R7pvJQUu7jgyQ9HFU+e+sn3lE=;
 b=ud7LTtUU/qkrW8mf4SrWBFslZ4GZrunPEbXbIEwJ5PWwtqKNfB0sXXGreNJmIKb4tA
 ViELlXJNkD8gtKwywdySuKbRRje8wr36ocVN7moz9QJnWu1NoPt8Lr1iT+xU+EkNAlaQ
 IFhxKatD095su3YjU+Dg5/kIuMkz8Z6ncZ24CM/zv+w78S2Mm7KSXRpwBVguUUc2LN50
 YHxz0c5ThPSzo6i9CzY4cVp7hFOZwrycCr/rfyIl1cE2P1N2Ig+RFIw6EfA19cyhxuAK
 YU00NjCVcpUtyWB/G0xVd3KjisxArPtvCuMrXRLvBtU9+Jaa7pW0GOwYBJI9XoRWOwJB
 yeKQ==
X-Gm-Message-State: AOJu0Yxc8jaH84hdus+oqqBidLSW9kvV1ElcliWPqgg0G1n5t39Q03d4
 jpoNMEF92KbqkSJbVJIx8VXXqt0raDYmaclTMa6zudpkBmci3b0qj7JsVEBIqD4=
X-Gm-Gg: ASbGnctTa3qwtb4XuiovwNcOEuOoNsvgBVQMuD7cjm7hOVQsq7aGw8RmeSlcDJWWUJU
 R2DVcc7cKze2U7lS2foCP4kZo8AOvj8ePDgLMWmRdYhvG4qNZ9A9lX23SI1zKOH2bv9kiu10Ie0
 Ju0CwULvi5CNlqrs8+Ed3XuJ8zfGszPJk6wvlfAgwvNL1EJgp08XIrMi5lWJbtFDmk1r0smAnWT
 62tZ1XALuLDwee/PwKJwgPdJgkDfXeDksJtaoAks9eGE52wXVX8W2QRTzNToQKW5d77uUfr4V/5
 L9V5Lxdrf8Ml05RXENgwvR1cnZDIJDMu7MDRTFFysQWkS3GBxPPISWWuaHm5QfGpu5gxLpS1DPs
 M
X-Google-Smtp-Source: AGHT+IHrhmc08Hg5PpHElENmf+Ms8QKRH/fhGQRKHD8zMd0nDJa+yBmxmv9bGNO+Qci1osCOmMCiWw==
X-Received: by 2002:a05:6830:6115:b0:72b:9de0:891 with SMTP id
 46e09a7af769-731da1767c6mr260670a34.13.1746133149526; 
 Thu, 01 May 2025 13:59:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d34da29csm256306a34.42.2025.05.01.13.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 13:59:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>, 
 Adriano Cordova <adriano.cordova@canonical.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <62949207-e59c-482b-b629-94a0e61c454d@gmx.de>
References: <62949207-e59c-482b-b629-94a0e61c454d@gmx.de>
Subject: Re: Pull request efi-2025-07-rc2
Message-Id: <174613314844.2090677.17191857313630649541.b4-ty@konsulko.com>
Date: Thu, 01 May 2025 14:59:08 -0600
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

On Thu, 01 May 2025 18:16:18 +0200, Heinrich Schuchardt wrote:

> This pull request fixes the "installing EFI_LOAD_FILE2_PROTOCOL failed"
> issue.
> 

Merged into u-boot/master, thanks!

-- 
Tom


