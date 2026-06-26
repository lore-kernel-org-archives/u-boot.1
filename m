Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A2CC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 15:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A023A8460E;
	Fri, 26 Jun 2026 17:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="MKM8YL8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD928495B; Fri, 26 Jun 2026 17:18:52 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC8A8404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 17:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so7884335e9.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782487129; x=1783091929; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mB5+OHUIEPSbf8N1FunPva1gTx/Axh3cdH+BX9B+jDU=;
 b=MKM8YL8jmfwa4HF8TFt2+TB6vaD5uzcRytNcrm8/wCgz3jECWdhbaLMWaHUkBL+b6N
 l52jNj6UYVCzPxJ7jOW7L1gcXccbuyt1HLYqgjK1iLRO8joRkspyrizkslWGUR1OOwou
 w5+TOJUOhe2+PF/M+ID04jCDCR0zQSZQSw2Hb47PqGV5JeEarjy/xQeeIKt64Prq6UC2
 2JsWQGX/6HJTiTU22j8vgRaaklyNu6rehazV91ScmEry5AW3k0WxqfcNu3O2nWmi/0GA
 8e+Mllf4e8IfE5KnE1j7mdsbNlDlqegEW+9IR54/kjDCPJ9zN/VUrS0qrS9DPbGgQVJi
 qNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782487129; x=1783091929;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mB5+OHUIEPSbf8N1FunPva1gTx/Axh3cdH+BX9B+jDU=;
 b=coX4X0+kFwcKMUcmN41cLr2JsnphUhMgqPdmUnIb8V5P8ctd92/utG5J+wxJS9Yk/R
 YQ+tlV7DJ18T4k92coPjs58YdDcQaNq0uFrao0n79mO6M7eIm8noyw/3MBILtPMFyUcd
 o7DoGHu76cXmgtJ/M2V7kAfKZ8BeM4FF4eCpfZK8fY5Rm/CTkzLln+6zHLTXm+24HKld
 cdijT1qAaEB7qC078nccb0BWxist0VxD3IUaE5oCljsoRSPRoWZSxjDEQJTnQTKI2RMu
 5uxo4095lQW+PaTVADeFm2ZTQdoUtrQIjRANQUeCCIvfm5UyeBi/eNRziSpY6gmujsUX
 awOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+FxcQwb8J0tygJhW+K+HG9kKjc4qd8Zmp0wh810k5iQzGQ/fX6sLEVKQQL+jrxB4gT5bbrMU=@lists.denx.de
X-Gm-Message-State: AOJu0YzymWcRuOwbwFz665HGvQXoO3WRzjcLI3GQOYp+JlF8jijChYO9
 BHTb6/4ud9QBWoR532E+BsC4eiazzcqs42yYe6s35pdwvdR0yWvcaGaaTRnUURjfglazjVsmmk4
 1KEiSNQ59Vw==
X-Gm-Gg: AfdE7cld+jXk+tdTYo+RXHJToTaPy1ToxfJCYQ+ei+pGHmnbQYsfRNOPwvzP4ANdQoe
 qtmoZLa4GipNFgF9uozCe+OBPCz9g3VLz3UlgJq8xzLax7EMy0XQWGwPgel/7EUwxdKKlvooe8p
 laaeX1us8qvJWi3MZlt4crExrx3MxVY7a7EyGvFosvWRPqpCzHGuVpHdqKV59PWPxhYnAgTPaCm
 m6Yj/QKbvfxGvH5i87JbRPAllANbFtR1k/T6zK8nxtaKNFwStUR72Pwsj75Cnls3G0pR/LXeoqo
 r7geZw64l8AYB1t5dicjzEKsT9ufsu4PJmuABdqurrAkRTT1Upt98s9573LISAGCS9HJtj0OpFF
 tADG0v2vbf8yrrdXCUNUG/V5jMMJxsu3hn5pZhuqlFOpDJENizzgPPoa4vhKIZSRPL7SxuvGdml
 IXIpdar1R1ATbhqsJNxWpEFXlZJsrIzg==
X-Received: by 2002:a05:600c:4fc7:b0:492:3fb5:4697 with SMTP id
 5b1f17b1804b1-492668628d6mr104155135e9.5.1782487129411; 
 Fri, 26 Jun 2026 08:18:49 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d998esm24860736f8f.24.2026.06.26.08.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 08:18:48 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 0/2] fs: btrfs: add support for readdir
Date: Fri, 26 Jun 2026 19:18:20 +0400
Message-Id: <20260626-btrfs-readdir-v2-0-7dd43f72d1b4@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2poyhIqu/A/Doo9Bxhgg00o0h
 H+X4trlSc49d4FIwhThUiwgNHPkcdgADwX43g53Uhw2BtRotMFauSRdVEI2BBbVOLK+sr5G1LB
 tJqGO33vv1v44vtyDfMqRbPQc0yif/XAus/evPZdKqxBOTWnRVWdTX7snTxPJcaAE7bquX08Fr
 Fq+AAAA
X-Change-ID: 20260625-btrfs-readdir-8beac3ac5220
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
 u-boot@lists.denx.de
Cc: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2041; i=alchark@flipper.net;
 h=from:subject:message-id; bh=o5Vpn06WgK66yNZF07Aer8lYugPgnyShzwRVpTapXQk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTZzfB9L1IWc3Cmn/i089E8E6zrYm7yl2tYFh5u3PsyQ
 HJRs3hBx0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFPNV8rIsOQ7Ww0bi/6hqftPtT58Fng/2XZNiF3PIesUed8/zjMK2hj+yia9cC0
 Vjp3jpfPwugH7s5hnp1SPFrRsahBvUBSO3DSfCQA=
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
Changes in v2:
- Cache subvolume id and inode number instead of looking them up on every
  readdir call (thanks Qu)
- Split out the dirent type conversion between btrfs and U-Boot filesystem
  convention into a helper function (thanks Qu)
- Drop redundant check for XATTR entries in btrfs_next_dir_entry (thanks Qu)
- Remove btrfs_ls and show_dir which nothing calls after the second patch
- Use container_of instead of type-casting struct pointers
- Link to v1: https://patch.msgid.link/20260625-btrfs-readdir-v1-0-dd781a2b3965@flipper.net

To: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
To: u-boot@lists.denx.de
Cc: Marek Behún <kabel@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Timo tp Preißl <t.preissl@proton.me>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Yao Zi <me@ziyao.cc>

---
Alexey Charkov (2):
      fs: btrfs: implement opendir(), readdir() and closedir()
      fs: btrfs: use fs_ls_generic() and drop custom implementation

 fs/btrfs/btrfs.c    | 199 ++++++++++++++++++++++------------------------------
 fs/btrfs/ctree.h    |   7 +-
 fs/btrfs/dir-item.c |  76 ++++++++++++--------
 fs/fs.c             |   6 +-
 include/btrfs.h     |   6 +-
 5 files changed, 143 insertions(+), 151 deletions(-)
---
base-commit: 19eafbadf20f56c1a24abe6b5e8774e776894261
change-id: 20260625-btrfs-readdir-8beac3ac5220

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

