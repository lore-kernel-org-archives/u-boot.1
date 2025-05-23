Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19B9C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 18:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0439F8334D;
	Fri, 23 May 2025 20:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="lvCHNOx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F1A8338C; Fri, 23 May 2025 20:31:30 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 465E083340
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 20:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70ddcdba474so2369227b3.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748025087; x=1748629887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SZ0AtkRWuAOjzcPI8PLOi1UKI6NVK803N6n7tS2D87U=;
 b=lvCHNOx0IHGvUGpBnMfIKxZwW/dUOqAQER+FWvnxAKQ82zdvvdjtDiLsP9pXjnTsVi
 /ym7RllxM4x2ZfC+ccUpw0bId2Dml8bs53TDK1IVH/xZQAHAjdaHB7l/+RCzt6D5SIv6
 69yWjX88oh+b/2raRupeluhgn9r33jnWKFieVsxW9psVOaTPVuEO4+1IgUKakJRz9ChY
 Xxm+xyieMf+Dm6anvSO77p+jPqu7QcOyeaDbQMgBmCCpn5COxI/cQO+Lak3dkB5Yo+G5
 uQwxT4cBRN7cnz6FyRgHZuyA0oUkK9FLsnclrAK5t8P9SfHL9DkGc85rtkvMfRVMX+uo
 7gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748025087; x=1748629887;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SZ0AtkRWuAOjzcPI8PLOi1UKI6NVK803N6n7tS2D87U=;
 b=Ma9koe6/ab9rdpwz/voZu7zC29T4H4sBzzHl6b99nr7YGc+ueRjJZ3AOOBcW6sfxJE
 mYRSkPRoh9XRLJSLhgoMlGOQPI71XJ0Ur92Aiui3S6i8gqG4SIhqTDUCLTZuLXOyrQYT
 sB8dXshoaq5zNhQEoJ6DyzF8phhtKSgjeEcYgughape9zrW+bYgYetsdEJuLiaxbG2pw
 i3rTp7GkY4C3nHcP+m8chLHX1a43x3Brtth09XgBunlPXKiUrPli3MIXURteZj23VenB
 7pykGzuJKRi49DKkQgdHcMuVcayP7tFzsDgnq6eQep6dPL8bzMWhPx7Zw2w8TIKBtPQq
 o+6w==
X-Gm-Message-State: AOJu0YxX+Puw7PvvGi4yT3nABbd1uD3dPJtoowi4wzaZh+GKE/RAN28b
 jP/zcoffq9wsRb9iZI+c018c4X26wPStz+WW/JPWLsSvDfgPfqUqTpClsee7DAyVEXOHZuXZzwd
 cmgtEWIMLazun6arDARyMX73i2mANcO5u8FvgBoC4jQ==
X-Gm-Gg: ASbGnctLFbevt7xb/Xhu3Sq6uGn25xUVm+BJ5+bEkeGE/5zOqTWBtwprABl3ctfTHVu
 ySjTZjcAuVIVDqFit0flyaMhneZAuSTpLL1OtG5ge/GrFW+PuTJqZzaofQm/24v6VZV4PZJVASW
 ki5SjT0v+dcy0dS8q+U1iVFfuA3zk4tQVwVROwQyrFROG9YitixlRx8Q==
X-Google-Smtp-Source: AGHT+IG5zcn+fb/mZ28Bi8GRXowR9ybnfL3S/CwF/GO/tJen1ZHTzRPGDQmtuoudhSOV2qmr91DQWSuICi2lW4MV5i4=
X-Received: by 2002:a05:690c:4d45:b0:70d:f237:6a4e with SMTP id
 00721157ae682-70e2d996e2amr2089157b3.15.1748025086956; Fri, 23 May 2025
 11:31:26 -0700 (PDT)
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 23 May 2025 11:31:15 -0700
X-Gm-Features: AX0GCFvCsEe_B7b0ug1ZJlipX0vgjm6Yo0DtNXrUgzI8a9r9wDC7AQvxFjxg_k0
Message-ID: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
Subject: lwip tftp not working on imx8mm
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>
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

Hi Jerome,

I've enabled LWIP on imx8mm_venice to see how it's doing and while
dhcp/dns/ping/wget appear to work great, tftp is broken.

Enabling LWIP_DEBUG shows the following:
ip4_input: packet accepted on interface et
IP packet dropped since it was fragmented (0x2000) (while IP_REASSEMBLY == 0).

I tried enabling IP_REASSEMBLY in lwip but that seems to change the issue to:
ip4_input: packet accepted on interface et
ip4_input:
IP header:
+-------------------------------+
| 4 | 5 |  0xc0 |       108     | (v, hl, tos, len)
+-------------------------------+
|    10568      |000|       0   | (id, flags, offset)
+-------------------------------+
|   64  |    1  |    0xe25b     | (ttl, proto, chksum)
+-------------------------------+
|  172  |   24  |    0  |    2  | (src)
+-------------------------------+
|  172  |   24  |   21  |  251  | (dest)
+-------------------------------+
ip4_input: p->len 108 p->tot_len 108
Unsupported transport protocol 1

Any ideas what the issue is here?

Best Regards,

Tim
