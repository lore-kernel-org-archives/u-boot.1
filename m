Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A22CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A67DB83DE4;
	Mon,  6 Oct 2025 17:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2J0PZ1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC7E83804; Mon,  6 Oct 2025 15:25:02 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03A4083734
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 15:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danielcohen627@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-57bd7f0e5baso4668958e87.3
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759757098; x=1760361898; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VrMv3Ks13vNMkzMCBOwd4tAnYjsIuzEYI8TwOwkH0Jo=;
 b=Y2J0PZ1vCnV7ZKYxjesdq3p45AROjdpN3DmW7Fr63+HEP93lv/5xVQOias4plwdDWU
 9Ub3nTjfnxmrDlhzag25utWxe7wfjPmrTcmzKHo8ghJKdZjugsEd/hpDzi8lWYek4cpe
 9EJswdxobJOMkfOCZudofUTOTx3BWzhaTBJO8jTEWeWmA0VKmB04Xq/PhssC3Dy0ZKR/
 5ZC2J2/a5B4stFrYy6aBR/p7/DmF783KHbgiwdQs2Z/mpPV+Othf130rn1gbfSLrIw2E
 6WSC0C+sDaUMu0aqL3YC9OGcUmW2GWae+OqQVdvoCLpXpNhGhJdS22C6JZplJ9vuvRfo
 rOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759757098; x=1760361898;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VrMv3Ks13vNMkzMCBOwd4tAnYjsIuzEYI8TwOwkH0Jo=;
 b=fPaYANgApDU8MQ3n+UrAS/v6oU/m7oO9ikBMWcC2eiDlNSy61HvKkIqlihY2fhm9py
 ZX/41EIqXKKVpjHe2NT+2lX13e7U70yWeIjZwTOQJ7aiYsXsGp2jDnbGB/8n4qZD8Aq+
 +9Dk6uGmAWvYcdfbDeBm+0mLmymAmZPEqYNhKLTWl7rShCyAfgv+f+s+VpqsuG2+itt/
 9SLf1e8CMh9hKluB2lFa9HZnPPmDCx+xp2cYBRONMjXqsMg2AebsOQRQ9a7ehTJIkSpk
 qyu8gRlKe6JlC4CS7orwBq0Tp5xox4MTpVHPtdACOIYmi491NUoBcRqjD02lYNj4E+i8
 pMeg==
X-Gm-Message-State: AOJu0Yywf0VTuDnncNjghwUakB6dA9BIwAR2vevJcVfNqzXyQgTY/q7l
 FvI1/ltcKtjh5xhnwjooCQOj4FGaoK3FBittKY2kdHEpVQiyjV51L9DYvcoNE5MA8RnGRRsad5y
 LEHeomvPzMDDalnq1A1XI2csHzxVlOa7bNZiu
X-Gm-Gg: ASbGncuWTOArByuqECrkppgbWhYiOI4HI/K6LXuj4CBASjHT8AJ72cQaMvC868O62gb
 9be+AOEPfNzfVv2JiMQ8OeXtX26/d+gopDFHfmqufQsphO09111bDpYKCTmANvyvIqS2LNPJhgm
 pS7/uFXCQWoTl3rzy3S2/0HNjfhd6p/whzcxTK4uViyrHAdtMtDUlmHM0NOVdocLqdeN/6ZdnEx
 0jQTXAQ+W4iup924ink73rSR06p5Q/wUqk3xZCsHNqNUrKYGoKQNot5dy7flfGOKA==
X-Google-Smtp-Source: AGHT+IENGcyO/mRsmqQNmH0Q4pm3UsuI+L1A2l0N+H3qE86rHO8UoziacnbFDQmTV16WEcHh+xf3JTftCemtqKjEjCM=
X-Received: by 2002:a05:6512:3e21:b0:579:f0fc:46f7 with SMTP id
 2adb3069b0e04-58cbbfc2e58mr4016353e87.56.1759757097904; Mon, 06 Oct 2025
 06:24:57 -0700 (PDT)
MIME-Version: 1.0
From: Daniel Cohen <danielcohen627@gmail.com>
Date: Mon, 6 Oct 2025 16:24:46 +0300
X-Gm-Features: AS18NWDzW48dPUreHacFWYoLLFEeInxGIhxHb97ggsbawrj6AALRaA6tKzhu3wg
Message-ID: <CAG9uNBS1aMcoAfjyd_pvewGKFHLEJni=rifNAe0+0SCf=H5vrQ@mail.gmail.com>
Subject: 2 vulnerabilities found in net/nfs.c (integer overflows leading to
 buffer overflow)
To: u-boot@lists.denx.de, security@denx.de
X-Mailman-Approved-At: Mon, 06 Oct 2025 17:40:22 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi, I'm Daniel,

I found two vulnerabilities that could get triggered through the nfs
driver, in the functions:
1. nfs_readlink_reply
2. nfs_lookup_reply
https://github.com/u-boot/u-boot/commit/cf3a4f1e86ecdd24f87b615051b49d8e1968c230
https://github.com/u-boot/u-boot/commit/aa207cf3a6d68f39d64cd29057a4fb63943e9078

In the commits you can see the two functions have integer overflow in the
bound check before the memcpy, since rlen is signed int and controlled by
an attacker he can set rlen to a negative number and bypass the check:

if (((uchar *)&(rpc_pkt.u.reply.data[0]) - (uchar *)(&rpc_pkt) + rlen) >
len)

I also created a PoC triggering both of the vulnerabilities from a
malicious remote server, leading to a crash in u-boot.

Tested on latest commit on the master branch: 72f72fa

This is my first vulnerability report,
so if I missed any additional information please let me know.

Best regards,
Daniel S. Cohen

LinkedIn <https://www.linkedin.com/in/unknownd4/> | GitHub
<https://github.com/UnknownD4>
