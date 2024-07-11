Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3339C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 20:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FB588276;
	Thu, 11 Jul 2024 22:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LauECsp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1136C8843A; Thu, 11 Jul 2024 22:31:49 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E5487DEB
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 22:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-585e774fd3dso1810210a12.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720729906; x=1721334706; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4xhNN6OsBdT/8lIKWAWD113nAeRcCaHJoeWi6Obhchs=;
 b=LauECsp1ou4ieBGUf9yKReOnbrNUiRYoXF8zy+UR+bWfhbFlAcDiLXwb5rfQ1Fd7kw
 KRUss8PLU7NS7dy8y065BCRNxK3R1Epgv39TE0FtTpLQOR7zD4lQOrHlga5Lj/kYzCJ8
 DX4+xulUdF26BLUgQ2KYYglCdsE2RlLsAWlPz19gRdOyQYTRzNIx+VZ2IXwTCyJ/6QJp
 Wt0HWlDEgq5kzhK/tcHGQnjxjbHanjbYvl/Jh5/sUi5vYn/Zg1IbiDqykVzYRyV+uP+p
 Zo+iTG4ue/SP648rhFCXahi5CyYsvu/FS2aaVB/Pmq5V4AdOtDwcFebirHnHtfYfJXz+
 OuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720729906; x=1721334706;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4xhNN6OsBdT/8lIKWAWD113nAeRcCaHJoeWi6Obhchs=;
 b=aLyIHuRDShz+q37d+V+FEHyBrbjg/aD7Dl+dlCHs39e4H88Vr8WE8jZNBHgfV+g4YH
 K+6vFEHpz+dLVxdlO1JIWzA89Wz3d5lb5HtguOSjbdxXeKL7zoKGTacDr/+u4p2Wpt2o
 V8FBFSv4NLBbD6uPvaq9u4T2GpEyrqhDHwNgFXhJd3JiMFDZzxcA9vtwfrqUNDLivAgG
 l5WKWCdG7WkFqYwhe5erTlFmCPdqZ2swlGOdshMcUZ5urSpwqdPYWpOgVK9RBLE+VExq
 owebJdELgY5iURaRmiU+rHQsbuBir+tCmDISC+jaiNKcMG0ggmAyrPFT8bLqcZMmXUKK
 8TGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQWLUUtfvgZpGIaicCuZWdoGMC4QrXVL3Bpm32KHZD+BvYbZ/56AGtkxOx6TqpEjD2JG2KGPL2gqGXWNyPlzbSMCM+Tg==
X-Gm-Message-State: AOJu0YzfGOff1aGNeKjQwHzpNebhtRE255/X3GRZki/o28bLHCDn0Lho
 MhVWf+NYBDvZXObUInTJXhXltoq9LqaQjwIbOVZq0p65FLq7DAIIMeTzN3iIiPDdH+QJxG+sHgh
 gc8sdhr17Xz7rpKGxLZ84WZoXeUgpl8q+
X-Google-Smtp-Source: AGHT+IHdV2jXNdygouE1agXiTiKmcmyJjOmUphJOuB92SVZnOKGigbV3W8IZpVpR8WS0FrVXjz7zWKw48HQwLef1ndg=
X-Received: by 2002:a05:6402:234f:b0:583:a39e:f469 with SMTP id
 4fb4d7f45d1cf-594baf87a01mr7290311a12.17.1720729905532; Thu, 11 Jul 2024
 13:31:45 -0700 (PDT)
MIME-Version: 1.0
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 11 Jul 2024 13:31:34 -0700
Message-ID: <CAJaLiFzx140yJxPs=x+1Rm0+j+xT3cXBN8svqaq6XW9_D1CHyw@mail.gmail.com>
Subject: env: CONFIG_DEFAULT_ENV_FILE and CFG_EXTRA_ENV_SETTINGS
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Phil Sutter <phil@nwl.cc>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

I'm trying to move some envs from a board header file to the default
env file. I recall that the envs in CONFIG_DEFAULT_ENV_FILE are
appended to the envs in CFG_EXTRA_ENV_SETTINGS. As you mentioned here
before:

https://lore.kernel.org/all/20220810170439.GJ1146598@bill-the-cat/

But it looks like envs in CFG_EXTRA_ENV_SETTINGS are completely
erased, and then the envs are populated with what's in
CONFIG_DEFAULT_ENV_FILE.

Did I understand the usage correctly?

Thanks,
Tony
