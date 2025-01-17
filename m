Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE60EC02188
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 07:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1678070C;
	Fri, 17 Jan 2025 08:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YWkW5Eck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFBAA80713; Fri, 17 Jan 2025 08:29:07 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1BD480312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so309997566b.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 23:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737098945; x=1737703745; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KsdD74zLbBm1Ui6/4/7b+Kv5yjQuz4+ZxWkOJO+lcks=;
 b=YWkW5EckUe7KpUg8+lSlZ+NgcYHFXTp6BiHlyIVJAELs3u+4H8oMhMRywW60ZwOKz1
 J+7lWYUiIHDGDKVoh1LFqaVv9N5YSXRg9cb+JdS3bDirrGgxgDm77KvVrrajuqYpAJTN
 DCpNEGMcimgjIQm1khWitlmRbSfurdAQlPE6+36WELB7k99QGLWZPprOIBNwRH3Oh/wW
 FJM+y/8twrTacX9vQf0VLWtQvhFLif4mX40eHMc3kK4YjKmxCplXyagkP2rpoiYlz0g+
 etEzzRyIM49P/ckC831z+t+an66/0yC0pFxbfHPjY7mUJUggcm6s0jjEYYIj7YqNw9cP
 c6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737098945; x=1737703745;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KsdD74zLbBm1Ui6/4/7b+Kv5yjQuz4+ZxWkOJO+lcks=;
 b=lxhU5KRYPpu56tOy3xcmEtE7SypSgfivcLV2bRl3oNyy5i4CqyMd/zKJiO6V0E9l4j
 8hGUpllConip7/B7r7GSpQKHEkhSRJnZ42HRaYwsNej5r59u4emYBEbuFaK+0wjYhNsI
 UD34B5LxeA+8eduHiV7Ow1HbYlYftbyyyraihic+q0Ai8lSiNFJHDYimH/kMROZazDX/
 H1gkLwVPn/xB6XYb5tglcKG83I+GcgnMnMSEBAsLiaZqiIhVaqgQGN9/qh/iZJT5yDwQ
 PcZxLb5pMVyZPFA+fYRu8HSfAfRnXeCO5P33QlBOIUjjWH7h/NAi0/+AsXMZk8Z9Vsiu
 PplQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1BeBfykfEZ1NseJWwZDuS96EU69HDhIV0TkihnBshB2T/ZbiQsjPc2HiBnTIKrd0p4Y/GNUc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxy6PwxHHPZaFeHkIGX3jE+EMM4LYlNwglPYT7zUB1xPLKB0gid
 lNgZ2OQGm/aTnO88WKL9deEo1zbXdyAVPe64Gy6aYxbUXTG4oaTGVHEKk5OMFo8=
X-Gm-Gg: ASbGncv6sMBwS5X9EDC5Y+Cfs+6n9klAId5Z+3XQsomhANR3t4JDzkVcCC1w8wgqstG
 EHTbF0HYiLSmJ17NhB4QEPDj53cSv299ltfFC6dnwROOZieT0k3CXcAy0Bl/iH1UTc6dubrGMtU
 f0sVV/ii3Gx9+1aOBMSnE2bhjx+mP0+e35gho6fhzqdRQG/+TTGTb6ard03CsLwF2mX92RsNE6k
 gp5iKskIT8YzYxxJzwKIIh8lx4aoGfzzVuc25y8en+qme8yfOyAIcf55TiEUIlyRZBTK26Qe3g=
X-Google-Smtp-Source: AGHT+IHwq2NvbH/5g4lON131bEhIr9XkoD6ph3+OohCTcx/b/4JAn3h1bRPL3XWMWyMPO57YzxeY4g==
X-Received: by 2002:a17:906:d54d:b0:aae:bac6:6659 with SMTP id
 a640c23a62f3a-ab38b190d52mr139239366b.7.1737098945089; 
 Thu, 16 Jan 2025 23:29:05 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce2105sm125404866b.67.2025.01.16.23.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 23:29:04 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/2] Clarify DM_FLAG_PROBE_AFTER_BIND behaviour
Date: Fri, 17 Jan 2025 08:28:55 +0100
Message-Id: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALcGimcC/x3MQQqDMBBG4avIrB1IIjXqVaSLqH/aAYkykdIi3
 t3Q5bd476QMFWQaqpMUH8mypQJbVzS/Q3qBZSkmZ9zDWOt5XoNK/PGu2wQO8YDyJGlh33Ye6Fv
 TWEcl3xVRvv/1+LyuG7N+nFpqAAAA
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Cc: Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=896;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=MXgZrY6Hpy0u4U8v55fWqr+rG4rvMx9ktCSg9XCEQqw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvQutv0KrCunJslMco+oSKk4cSvWyedxvqmkwtI90fPiX
 +TGHsnuKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABNJcWRkmKWw5VJC9uKXsrv2
 7empOOo+udAx+uuy102vmUTfqgZkuDMyTJovuDKN9b+g7jdBVqcFp01CX5jZN7roWoZ6Lm+a//B
 2IgA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

In Simons series reworking autoprobe[1], a discussion came up about
DM_FLAG_PROBE_AFTER_BIND, specifically that it wasn't very clear where
this flag should be used.

This series implements my suggestions made there to clarify the use of
this flag, and fixup the two driver which erroneously apply it to their
driver struct (this does nothing).

[1]: https://lore.kernel.org/u-boot/20241120153642.861633-1-sjg@chromium.org/

---
Caleb Connolly (2):
      dm: clarify DM_FLAG_PROBE_AFTER_BIND behaviour
      drivers: remove bogus DM_FLAG_PROBE_AFTER_BIND flags

 doc/develop/driver-model/design.rst | 6 ++++--
 drivers/mailbox/zynqmp-ipi.c        | 1 -
 drivers/watchdog/da9063-wdt.c       | 1 -
 include/dm/device.h                 | 5 ++++-
 4 files changed, 8 insertions(+), 5 deletions(-)
---
base-commit: e3f716fa2d58aadf53928475ee7e88eb41cb8031

// Caleb (they/them)

