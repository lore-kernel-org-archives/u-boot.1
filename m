Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8118CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7121C84894;
	Thu, 25 Jun 2026 19:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="ZuTm7jBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32FBE8495E; Thu, 25 Jun 2026 19:24:52 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B37D18460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so1161065e9.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782408288; x=1783013088; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EmgDJGv65MnM3c/+XZGPyPCp0kL0XEvV2sMNImEwXho=;
 b=ZuTm7jBguhfybRgUp5SWwwaJS724AaFfkzdkLAXnlpTYnORFEtL4EtyTf9xsB3G+XG
 /fCtQ+55lafK8XYH6acpeSExzERAA1gHJFP7x9GROylJJ/K+1KJ1m2sbIBvNDLs1/1Fl
 hIFdi8pTexXNWubDFC55iqTkvGOWaPDPbNQvJYwK/tXWsRHO4zGu2NukJEdh1Kz0a70K
 Mzm4YjGG0Dv9356goE6jklHq7JvGPaRQr5UV9J7Lx0BTPbzgzeM4yoMMn1xEdsmw2qnv
 pU2v/z3gJInS9KBID29kvuY429VOGj4N0PlbSlDT6jUCosEQDuPe3EZUbHAVSUyL5Zl/
 7UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408288; x=1783013088;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmgDJGv65MnM3c/+XZGPyPCp0kL0XEvV2sMNImEwXho=;
 b=d28WoFhBNzuW3hTPNTZWut8SuizfwtqxAqWPkiG28bJdBdpY6a1DM0UY1H/U18rB/r
 5sa5eOANGzZOP8xoGgPOBHLRRdYRbm6mVchInUSPCDa9H0ib5MrPgn9z8c7RJjzEaHwE
 PfuXec9NHBy7qjwivj9l/HZR3/O/mpiYUveBDemJLbkIti9DBxX/NkkuYeNuS3SgVKRJ
 omanansyJj/lKb253o5tH7reDvcAJypEJFQ3SU5K9yubGV5a5MuFmYjy3COgHkjmKONk
 g8yMtmu8P/98SQkFXuMcXiu5Mla3qQZceLX4mi3iD3IDo3LzMUlmCrEEhXgSa7+MyyMZ
 crfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5RDhK3yUw1ZTZhoWcieu/OI7tVf8jFHHT0CeD1cC177mlOZTuuODU9T+WJOIch0cXaK1I+g4=@lists.denx.de
X-Gm-Message-State: AOJu0YwLXbC1yWINH/4VBCbzz8apmmzGeFBBPq5h4TM3Obz5AZaw3VsA
 GfN+d7NK1TFKdYOxVEirZ2/rS8AyXSMnoT0aqn97ElJ6lMdzcAX7IqUqSbQQY4Ih5cE=
X-Gm-Gg: AfdE7cnf9SI1+ibAdhpYUIjyu0TKd0VSz19T5aGJ2W60xDvkQUrXxPnvvVHpgSrwygG
 ZRtidnX0bdV3lQ8l29HL7n/J0mRZ1WRFBXIEe+n8iJc4i/BHIfQKCIMd30fo185TQnKZ+bRkV9Q
 Xum3QYtVfL0y6nFNaF6J3oLgwfPD+N5dVdJOpicFK07JxBDm/3y2RGEqEgkunSTnhZEDLHNNme+
 9cFr4iiGTsKkyB2w0Gp7hSh7/WDZTow1GK3kab1YbLAhXpANMVZEr/kMoXyKKA8IuP5EpzlCLiX
 mQHXAgQwm4YCMQYUfRVerfbS2TUIiE4WkPPv+P5bRhk2sD3Yr+XKK4qDF4Hrp8h5tcurVqPNPw4
 98FkPCNNyt8UhzSrDl/5RTRLoSttqUvMTGApD3pJnyytBsnPNoqWicvCn67xZJjBQolJ3V49JZG
 4zG9dcb0ZU0Z0+RQXCEIzsVbZbCmmtNA==
X-Received: by 2002:a05:600c:4745:b0:490:b355:9c70 with SMTP id
 5b1f17b1804b1-49266873f5bmr47260355e9.11.1782408288174; 
 Thu, 25 Jun 2026 10:24:48 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492697ba453sm2585755e9.0.2026.06.25.10.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:24:47 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/2] fs: btrfs: add support for readdir
Date: Thu, 25 Jun 2026 21:24:20 +0400
Message-Id: <20260625-btrfs-readdir-v1-0-dd781a2b3965@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQrCMBBA4auEWRuIIwniVcRFfqY6LqLMxCKE3
 r1pu/wW73VQEiaFm+kgNLPypw6cTwbyK9YnWS7DgA6DC+htajKpFYqlsNhropgvMXtEB6P5Ck3
 833/3x2H9pTfltk1gWVZYCBBOcQAAAA==
X-Change-ID: 20260625-btrfs-readdir-8beac3ac5220
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
 u-boot@lists.denx.de
Cc: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=alchark@flipper.net;
 h=from:subject:message-id; bh=DtzQnNIOLn/4ory7n62H7Pe3gnst10l8LhLOcppQ5Nc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTZpoTcYlmrubRiGvvVfw/y3n3+/8XE/9DvUn/WK7qsz
 U35gRfFOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhq742MDO+1AkraPW6Y/ksp3qLN8dix2d9zgWl/Fvd1vS7GEItmI0aGM2IzD9j
 Pzj9yq+bJt2VJp5RKZ7zj+M6munxv4UPZV8yzmQA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Btrfs in U-boot currently uses a custom callback for ls and doesn't expose
the standard opendir/readdir/closedir interface, making it harder to use
in generic code. One area where this would be useful is in discovering BLS
type 1 entries [1] on a Btrfs filesystem.

Add support for the standard interface, and implement ls in terms of it.

[1] https://lore.kernel.org/u-boot/20260604-bls-v1-0-4ce6d1ee4711@flipper.net/

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (2):
      fs: btrfs: implement opendir(), readdir() and closedir()
      fs: btrfs: use fs_ls_generic() and drop custom implementation

 fs/btrfs/btrfs.c    | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ctree.h    |  2 ++
 fs/btrfs/dir-item.c | 88 +++++++++++++++++++++++++++++++++++---------------
 fs/fs.c             |  6 ++--
 include/btrfs.h     |  6 +++-
 5 files changed, 166 insertions(+), 28 deletions(-)
---
base-commit: 19eafbadf20f56c1a24abe6b5e8774e776894261
change-id: 20260625-btrfs-readdir-8beac3ac5220

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

