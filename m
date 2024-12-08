Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E396E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 19:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F11589473;
	Sun,  8 Dec 2024 20:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rYsJ7FFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 742E089473; Sun,  8 Dec 2024 20:07:52 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41CC3893D6
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 20:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6d07c7d84so50958785a.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 11:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733684869; x=1734289669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7po2dMMN1FGYhxSoJzWTAk9R/1perxqZNx1ifsQXc9I=;
 b=rYsJ7FFDw/JV6GcS0Y8hdDwlvSJOWwEj6dTMfqTRqm0ME79s+/bydDeBSg9iDBb2wf
 hikcJBZkHHCA7rBmCaTyiVrmZ/pFRK6PBNJiO0ik/gBZJWksuOVDW753CQLwmF/dFID8
 bwph2NFdOcOW/fS66I0/enQZDplPQDicET79g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733684869; x=1734289669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7po2dMMN1FGYhxSoJzWTAk9R/1perxqZNx1ifsQXc9I=;
 b=ohA7/4Iw2aUSneJawXEifusbxAAeF4f5PAIGW9uBiR2eDC5wegRDMxJWxJHvSvHAYV
 LFZ9B/5tcVepkQTaXBGffErV3u7pqXlFWF/+vtXRnwgV1xZPWAR0840VgzSv5s1Fcfev
 QZlZrqj+iHNDCEz/GHIp7ISPg7N3gZshb2rSRWrlDZ8bzgn0oG8dqCcOSpZDWtul0JhN
 lWCc6AOuki9QFhTXQrMXLLylUfeYGna9FnbSJ5EuOS81L7X0+oCpFTUbi9hBHkx99fxl
 ClI4vbG3eCBS60sLQrHD0c4Bko5xkpAetXR5Slhj74dfS4Qg3bGiXh1ftvXkKgFvGGTQ
 P9Lw==
X-Gm-Message-State: AOJu0YzWgxp2YoX1QDXGw6169oZm6zT9wbpu0y0Iyv9f43GBJYuA4hRD
 qlo5KlV1XvbPKBor0yz2kMtAGnc0QUL3Mpse0hg/Wt0U37JHPuhHI2NgWLnozQNlEeXu1AsqOYp
 5MO0=
X-Gm-Gg: ASbGncslrEMLFMKm+za+3kgWm9uD6gNmgp/9cI9aYCl+H7Hhn1cBdDt4YpFL8vbSy97
 6PpLfrbgy4Sb38V2j+vIut2Qi80fXImqEq0ELOsnOJoxuktOQPXGsPDCXTT/QfOvGF/ltIO38o+
 WGWUHLCwYJCmpsEC2PCrm1L5fwIfcA3O8wrbOReJQZ62T9dvNXpMh/x2j3N6bpWhQk76b+HeI64
 9SlkHsUr9rZCw1sh830UL26lY1A4Fw3S0+bqtFxL3LuaZOl2I4VwF+ns/Lv8BSb9aCXfb/90A==
X-Google-Smtp-Source: AGHT+IFKbo6M3om7C39S51kxA6i3Peh2fhYQ2EKkjAcOSD3XJFeJEZI91B50878drUR37rcPQwKrPQ==
X-Received: by 2002:ad4:48d4:0:b0:6d8:f7cf:a12 with SMTP id
 6a1803df08f44-6d8f7cf0afamr90366026d6.45.1733684869001; 
 Sun, 08 Dec 2024 11:07:49 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66ddeasm41154076d6.25.2024.12.08.11.07.47
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 11:07:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/9] Enable arm64 host support in Gitlab
Date: Sun,  8 Dec 2024 11:07:23 -0600
Message-ID: <20241208190741.4192601-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

First, thanks to Simon Glass and also Linaro, we now have access to a
few fast arm64 host machines in our Gitlab instance, to use as CI
runners. This series finishes the work that I pushed earlier and Simon
had started that enables arm64 hosts to be used for most things now.

The first notable change, especially if you use this on your own Gitlab
instance is that "DEFAULT_TAG" is now unused and we instead have:
- DEFAULT_ALL_TAG:
- DEFAULT_ARM64_TAG:
- DEFAULT_AMD64_TAG:
- DEFAULT_FAST_AMD64_TAG:

This lets us say that some jobs can be run on all runners, because they
are small enough that anything we'd connect to CI is fast enough and it
also does not depend on the underlying host architecture. Next we have
tags for any arm64 host, or any amd64 host. Finally, we have a tag for
fast amd64 hosts. What these last three are for is that we have a few
jobs that need to run on amd64 hosts and so we have to restrict them
there, but we also have now reworked the world build jobs to build
(almost) everything in a single job and on the fast amd64 machines this
is still as quick as the old way was, in practice.

To reach this point, we say that the Xtensa jobs can only run on amd64
hosts. Our targets only work with the binary-only toolchain and so this
is a reasonable limit and we exclude them from the world build jobs. We
also need to deal with ensuring the right toolchain is used regardless
what the host architecture is and that we don't use the host toolchain
by accident. Finally, because some of these changes needed to be worked
out in the linter, fix some of the general warnings that notes as well.

-- 
Tom

