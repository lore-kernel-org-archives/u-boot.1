Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F72C48BC4
	for <u-boot@archiver.kernel.org>; Sun, 18 Feb 2024 23:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C3587D55;
	Mon, 19 Feb 2024 00:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ECHbCv+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F4E87E9F; Mon, 19 Feb 2024 00:59:47 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE29887971
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 00:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41262ec677fso4261625e9.1
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 15:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708300784; x=1708905584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z9gfNiipB/pHMd7M36PNPLSObxiTmu8w4iSStl2HBH4=;
 b=ECHbCv+pdvJi7R2BU8/ra9LmOVYKhBrQtxhp9prQLVzU89wfP5TS1DtPcQ91bIPOin
 0yCQdl+gHr5YHx59hfM7Bxp40wmYiXtBWlarXNHNcN0mR2SoRD9PuZ2hJDN2ZuD0wnK3
 PBOQU7zovFNcJbd9qplyPGnJnviH0EdIDp3Dd9GleanvUJkCMPCE/nl9spewvNXUB+M/
 m1syuAB2+fXgD9VEzHkZ9qOSNreHDvWMi4ik3HMm116K5tiX5toK7u24TIomj5j3UGoM
 2rnLGCVKu/i63LmQXzEwQAV/eQnLvXZXJ+1Qa6AjZ9kqvKWUGgrPkEaiHs9TDpXLVu9m
 nMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708300784; x=1708905584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z9gfNiipB/pHMd7M36PNPLSObxiTmu8w4iSStl2HBH4=;
 b=UQichbeQ5+wRpeN9wDdD30qS3AmuwjRXeO9+zOX8z/NxUy3IuA5VYBms3xKUN9HUsq
 nfQ3ze1H5aHJNKhnMNQ00U3u24emWoEPVTEAlA+5dUn92oWQwG8m62bGT6IB+NrtVjPt
 1cuo+4Tt4WYQW8lBzZC0TxQ7ihVzNYEPS42zxaBP1XAlbNdfXh9oTblAZ2IIl3UEBXdX
 VQJUT5dlfBMTa0VEA+ZlSyYLxlCUO7mbj249+mUIjmQ0wShcMh4q8lLYaMOoZfGKE/gx
 rNlWQu35hKfSHqeCA9qYtM6bCFKC2p2PbOKDPglvSZThkb9Pmb9rCPtK5ddNAtEuf0td
 jRuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEfLdgfugrldyMrNuyDgnFCZ2gnf/E4Ir1m8bpzb/EWNWuJbblg+QFwpbqjUKuGYR1rTixF6xOJqHTsqHHS1jB/jkhMg==
X-Gm-Message-State: AOJu0YxH7id/Ih6XedBy5t4q5D9P05GRZPa5W6LZYvzVCbNT+RnPz5DH
 ItK6gfU+u5vnIv2b7PEkdtTtwbvnlKea10q3AGW9rlWOroJrdbR3
X-Google-Smtp-Source: AGHT+IFAAFShxe4qrIXyY913nXGAYZnRZU5vCnQ/HEUdPH36rhj2Tfwl6zLqgQbk3wEIY5qXTPmIkg==
X-Received: by 2002:a05:600c:4507:b0:412:6170:a178 with SMTP id
 t7-20020a05600c450700b004126170a178mr1971356wmo.29.1708300783970; 
 Sun, 18 Feb 2024 15:59:43 -0800 (PST)
Received: from morpheus.home.roving-it.com.com
 (8.c.1.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681::1c8]) by smtp.googlemail.com with ESMTPSA id
 p18-20020a05600c359200b0041256523bf8sm6854124wmq.31.2024.02.18.15.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 15:59:43 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 0/2] Drop reiserfs support
Date: Sun, 18 Feb 2024 23:59:33 +0000
Message-ID: <20240218235940.987876-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.43.1
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

The reiserfs filesystem	was only enabled by the ethernut5 which appears
to use jffs on nand for all default usecases (Nut/OS, Yocto) and doesn't
have USB Storage support enabled, but does have MMC. It's also scheduled
for removal in upstream Linux.

Looking at the logs for ethernut5 it doesn't actually appear to be
actively maintained either for the best part of 10+ years but I don't
remove that as part of this PR but leave it to someone who may know the
AT91 ecosystem better than me.

Peter Robinson (2):
  configs: ethernut5: Drop reiserfs
  fs: drop reiserfs

 cmd/Kconfig                    |   9 -
 cmd/reiser.c                   | 171 ------
 configs/ethernut5_defconfig    |   1 -
 fs/Kconfig                     |   2 -
 fs/Makefile                    |   1 -
 fs/reiserfs/Kconfig            |   0
 fs/reiserfs/Makefile           |  10 -
 fs/reiserfs/dev.c              |  28 -
 fs/reiserfs/mode_string.c      | 124 -----
 fs/reiserfs/reiserfs.c         | 971 ---------------------------------
 fs/reiserfs/reiserfs_private.h | 509 -----------------
 include/reiserfs.h             |  72 ---
 12 files changed, 1898 deletions(-)
 delete mode 100644 cmd/reiser.c
 delete mode 100644 fs/reiserfs/Kconfig
 delete mode 100644 fs/reiserfs/Makefile
 delete mode 100644 fs/reiserfs/dev.c
 delete mode 100644 fs/reiserfs/mode_string.c
 delete mode 100644 fs/reiserfs/reiserfs.c
 delete mode 100644 fs/reiserfs/reiserfs_private.h
 delete mode 100644 include/reiserfs.h

-- 
2.43.1

