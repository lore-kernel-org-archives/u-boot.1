Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D915C5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF949409C9;
	Thu, 13 Aug 2026 15:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NdHSysN11fsj; Thu, 13 Aug 2026 15:57:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9026409A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636630;
	bh=srIR3i3vOgvB7u6lGi055bvCL19PMBN493jes1Pxyss=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BeIgZhnNrQodjdZP/6eT8NwrKfRSVkm79R+skcukXd/v8TSATpBmPCpHiR0ArAk9N
	 nOchnHQ6FA0TdJNA2yV++Zs1A6ICQm7LxsOFoQc7GorwSh99/0y2/zeJIsI/smmaZj
	 Kvm5GuP12lesy/yhUqkG1ywiovYgQQAWCDqVGXsV+njGtzijDZxWlhq9E/T25E7nMG
	 De3/V6+f06KhgTaZQ4Y816t/uQMG6UIkJbu46TKhR+Y1Pf3M0mGMle1eFs1Qhx2zY9
	 NkcrkTGhIxDj0eloMDZ6E7aC50ObfKBm3S127HmEKqgCC2fAo55JA6YZfTBet2If6m
	 Wd1Pi5vfcqwCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9026409A3;
	Thu, 13 Aug 2026 15:57:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AB9C81B8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 921C9409C9
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ITpRjYitofjl for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:48:53 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 49018409C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49018409C7
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49018409C7
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:53 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so163043266b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636131; x=1787240931;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=srIR3i3vOgvB7u6lGi055bvCL19PMBN493jes1Pxyss=;
 b=qUno3QYcmJhZ/ajqxmpdpAbsoQY7IbykEbCJMq9vqmG46BeaVjZNt0rmsvsIJmiD0H
 LkqszuHuw5AVpy3x1AK0H3IvIB+iDgw6jGrc8jjSvhJfgDQqfjOAKP30Yf1Ixex6D3Rx
 NoRDGmLY2PS1eNaRAWlAEwix1BKnXLlRgZHRfrXsw3Jt/GSLe5frv7cJ2waxC6Rtbb9Z
 odXQx/2lG6/sBGnOGRogYmiFZixQOYoDDgnd5q4CoKQBAPuo8F2/xTASSY7HwgVNFeOF
 GpY0PML1pGAtP84JC7bGx2n3lzFditzzfDKzIWFeiyb6XbT8zPZMs5eouZmvX0096xTE
 HFyg==
X-Gm-Message-State: AOJu0Yw5CUdOn8NBhFXv0k2iFE7YdE1SRToQNqLBHBpCBocgPVKeHw/5
 M+dSizIaP0AkxuZJi9CZ+hUg53DPE1IT9covMuYNL6Q/9qSpKGnvpvD0vFSeD/po6qQ=
X-Gm-Gg: AR+sD13mATDCAflOzTWTYYXcNjOZXZJHsTnlUN9y187V/inUPcArBmY0qIKbVGxImy9
 QjKyDRgzYRjSWsKAuZoy3Bap/eWz1GUWj3oNIJir52XwxoND2zX5LBk3N46SmFxlicgrKvwcSmL
 sX/oF8cEZbgOIr4++dPx6RQG7Aw0WfNUq5aQG0dY2F+IZukocT5lSEK1r+3IHVXHIij3qBc0M5J
 2JIy+Pt8kjB039IzF8FLHYChRboy95lR6EDkz/ga8KV7hOBLS9vMWLY0AdlW8ABZtakmdBLEi/E
 ddO55LDTMiVAG2XRUlFUH1rtWbEYuLbP2B5ak5TsMhn+5aL2WJIn4eH+mmJt4nllJaE0DxgdGWu
 V9LEReMgdvzYZaigfgnp62YuLbjnTPw6DzcPujkSdWlIVeBXKtLYC5CG3jWdN+Vqtjl2E1sJ0SL
 YvhXvp6O6SG9cJCGvaNZFV5fUpx2Xwiu/TxwiuPeo77hJVH7rbx5ep77RhorrcNxoS388qNovrj
 6pa25IL6cBvxqnELxcQPoh43eevnmD9Bev0pyAvPQbLoJlICWnJ
X-Received: by 2002:a17:907:c78e:b0:c1c:6d29:8a11 with SMTP id
 a640c23a62f3a-c210a9d55d6mr322722566b.13.1786636130978; 
 Thu, 13 Aug 2026 08:48:50 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00b49b9d175e416b42.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b49b:9d17:5e41:6b42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c212378d8d9sm8151066b.40.2026.08.13.08.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:48:50 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v2 0/3] net: nfs: bound server-supplied lengths in READ and
 READLINK replies
Date: Thu, 13 Aug 2026 17:48:20 +0200
Message-Id: <20260813-nfs-oob-fix-v2-0-80993770518e@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETnfWoC/22Nyw6CMBREf4XctZfQUhFd+R+GRR8XqSaUtNBIC
 P9ui1uXZzJzZoNA3lKAW7GBp2iDdWMCfipAD3J8ElqTGHjFm6plDMc+oHMKe/vBmmlR15JzfWW
 QFpOnFB+2R/fjsKgX6TkrcmOwYXZ+Pe4iy73/5siwwrMQwrSN4a253NU6k5drqV25vKHb9/0LQ
 QlcP7wAAAA=
X-Change-ID: 20260811-nfs-oob-fix-31c433a22c91
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 15:57:08 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786636131; x=1787240931;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=srIR3i3vOgvB7u6lGi055bvCL19PMBN493jes1Pxyss=;
 b=lsof/r3W4MsYsbUPizefcUZN4ixv3hsh31SefrGE4ZVxshdpRSClCwIt07zNelVQFA
 Nkm/HELiqyIhKMqEcUf1EQkLh/wi6tn5s8imudMRhM0uudjK+NyMiPG8+XEUXyrz7JhF
 ffdrBIbLAnZD3BQMg/WI9JZQbwNdIYnpkukekvR4KKZqvGIHNqlPSf18VvvnMiLhr9d3
 P8k8mBrgPCb0lSRWgy7X9tnwgfAgdNLkZHmP7v1glLovRnVUDetgUF6L6s/DgxkAzgQZ
 fRi8MWDVBaKaMlWvcT8hHINMsbWLUt2ives22oq+LFUlR/xSbWKX51jxOzT4t8AfejC/
 7bOQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=lsof/r3W
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

A malicious NFS server can return replies whose 32-bit lengths are crafted
to defeat the client's bounds checks.

nfs_read_reply() keeps the READ length in a signed int. On LP64 a value
with the top bit set is negative, the bounds check passes, and
store_block() then hands a ~2 GB length to memcpy(), which reads past the
1152-byte reply buffer on the stack and writes past image_load_addr.

nfs_readlink_reply() has the same signed-length flaw. A length of -1 slips
past the destination bound as pathlen - 1 and drives a memcpy() off
nfs_path_buff. The bound is also measured from the reply header rather than
from the symlink data, so a large positive length reads a few bytes past
the received reply. A server reaches this handler by answering the READ
with an ISDIR status, which moves the client into the readlink state.

Both handlers are shared by the classic and lwIP NFS clients through
nfs_pkt_recv().

Patch 1 bounds the READ length by NFS_READ_SIZE. Patch 2 rejects a negative
readlink length and measures its bound from the symlink data. Patch 3
enables CONFIG_CMD_NFS in the sandbox config and adds DM regression tests
that drive nfs_pkt_recv() with crafted replies.

A reproducer is available on request.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Changes in v2:
- Add a fix for the same signed-length flaw in nfs_readlink_reply(),
  rejecting a negative length and measuring the bound from the symlink
  data.
- Enable CONFIG_CMD_NFS in sandbox_defconfig so the regression tests are
  built and run under sandbox; the v1 test was skipped in CI.
- Add a readlink regression test alongside the read one.

---
Shahriyar Jalayeri (3):
      net: nfs: reject a negative or oversized NFS read length
      net: nfs: reject a negative or oversized readlink length
      test: dm: nfs: add regression tests for the NFS reply-length checks

 configs/sandbox_defconfig |  1 +
 net/nfs-common.c          |  9 ++++-
 test/dm/Makefile          |  1 +
 test/dm/nfs.c             | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 1 deletion(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260811-nfs-oob-fix-31c433a22c91

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

