Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8953BCA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 21:24:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50A1E60B2E;
	Thu,  1 Oct 2026 21:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TmAV6oY4y4Hj; Thu,  1 Oct 2026 21:24:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9D79A607E3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790889888;
	b=BgHe/8kp82gNiysvh5nHyPd/QuuaKS4VWSZWa1rlHCZMKPjLGCLu04rHbhc6pfBPC0gS
	 NkqrP1Pe0BWbRgT2UBsPiU5bif8aagC2zRmvwS3FxG4zMwdZk3bwhJaRA66K45onf3r/k
	 I7JOH/0s5bFN+L5oAfb4i5F55L/VZeFZdrtqUIU1uJkNwp8rXIWxB2VkV0bJsd+jn0J7l
	 Ed1moqkJ0So1yIrA0keAG9AnNLJqNjFLM8hWs/VCnYIrqTm7NQcbMU8ikom9ZK7DhXNyb
	 wBUfINcwZfbhmjm4OTD+4QUf0iAASn2DZ2D2d6beG+sy3Tv+uQS3J9KBACTfq9XIQYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790889888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QLzZBoGdw7e5o/AE0N/TchedyfIZEBCS92c/NWTvoC8=;
	b=Lk4QUTgQ5yzbat6lXEwA8QYRMYadA/RIyC3E7BrHemgTr1KqoQkKeKZeqrHyPnjxZJ57
	 eMWLUPtjfSw3O2Z2cbZeP2vsyyUFY13g89XdQ7jhelL4bNq0A3rX0xsLpM9ntdaSBakbF
	 J5Un+DP2ra6Doea9YRCu3DnB1vkJ4cWtFbt280XZlMokekmbdc0leB3l+qV/dX5ymUnnW
	 NdD5ey2KrG0wtr6J9a3CDz8rsmNZb6BntHVXhs6MkJ5kjymZkQ1PC+G1bzgr0cYBX5YRp
	 gV7BuvptEK95LfNBhoqeberRwKRmElZQ0Qjk5B+96ihElbZQkvNUDbZQk3b7FkotokQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790889888;
	bh=QLzZBoGdw7e5o/AE0N/TchedyfIZEBCS92c/NWTvoC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TwK+5si8Y+UVxdI7FNtbSA6oB3h4u2D/FtoQErH5tLXpDPYGwkLO/OQMS/NWp6PLw
	 aLNyzNVOWzDtof+s+2CBlqzr3Xmnx/UfRajUEig4LLlqZG1HrvfU4bFk9X1xne3yTv
	 qOs8rk5dg5sdOLR7pkDshQ4vPt6wZa2Zcb8a3j2xozkeJ44lOsO7SmgmT9VMtlIFwy
	 j2naYRJM0Wmruw0W9YIMjy642w0wIBH6ADWPWB9hokeUpoEdAF1AKMAbkDhykXLmE+
	 WobaiFICnIFwfFu6bGTQ4veS3UVNiiXgv679CGs5yBqnlfv32L50/v4+P7izYS9Lsx
	 f1/VBZQWVN/Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D79A607E3;
	Thu,  1 Oct 2026 21:24:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AEFD22B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0150F810B8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkPhhbz5Faea for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:45:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 66D9E811CE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887514;
 b=fpF4+Shrkd8Mh/ZmK8ZT8rUNgnmCiDACR4AkeoZCsNS6VyoLAWNJPcGOxmvD+LK9BuR7
 GQE6ApTC0upBdRmxDw/icQsLJWSa1QfRSNM1m3VG4O08rfgxbSJMCxgQULX9Tp7jClFV5
 h1H3QEjhqm2D9+TALhQiHenR0Cj4NL748AA/bywFMD4qA3OnjDEh7ys1KchO/7/k51H5M
 zzmfXglq0TO5Jn5y/BcGc/TE7X+grCbqfTrDpBD7ht/lIKzSqu9d6ppo5wDf5bDCDnK2z
 sr7o3+AKDXdDpQ6XkCKCsjY/2WVIzAbAgmNMhP07eySn264WsYnncFr5zYd+pxlviEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887514;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=QLzZBoGdw7e5o/AE0N/TchedyfIZEBCS92c/NWTvoC8=;
 b=Ovj+98ka3zBQEHhwC/cVGjKZljNb5rCAaspkz5/GEMchJRNjQM/NWFKcPCPr2o6nW5ht
 yViACO2cQJy5sa5FcQgqm4NynW9sdrspMXSqh9pUT+yT4ATlNaOnwbpj9qLuqm1MtgnsJ
 DqCoiLZK2ek0JstqIxkh2g8GcAZZFvW8yRJAIWv2qC1Fccd4PxA+e5/ciL2tYnl+ueHsh
 DQr6v0eZsxuDbRIxzfF7mo7IFRxC00xVt8yE5nL4Vizk3jfKfvm7rSF31C2gZQrXp9pVS
 rIUW5j67jqK+hv3+qsOzrtpXXKYiImhrND3glK96CvCGM8IjTGVBDswy80XMVQx6yYA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pBnm2DcE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::2a; helo=mail-pj2-x2a.google.com;
 envelope-from=lqing2013@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pBnm2DcE
Received: from mail-pj2-x2a.google.com (mail-pj2-x2a.google.com
 [IPv6:2607:f8b0:4864:39::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66D9E811CE
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:13 +0000 (UTC)
Received: by mail-pj2-x2a.google.com with SMTP id
 98e67ed59e1d1-3a4b4770191so1616849a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790887513; x=1791492313;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QLzZBoGdw7e5o/AE0N/TchedyfIZEBCS92c/NWTvoC8=;
 b=pBnm2DcEd/8ZIef0UkkuSAHwivqiYNDTd+GV9CeMYRSGn/gPgUgeVYEAZyvg48cOP1
 R0xlbomrqF/9+Lj2DZtS8pp/VP+GyURUrbwzeOS8KnskonNfJ1FqE9xeqeAsu5LicuDO
 m2JrErw4SwTALGWLh+K8cdxOvknJWZ4Uf5bvbLhp0zblrruHQMQqs1Iln1sjRrr0zjz7
 +R+3ozi4Nfa6bqKV3b9rn4gTuUVDAT+ZoQn8M4hH7tNvHg5sUE0oCNhW595PBkbBsALX
 9DHwziS8EQVX0XlOp7fsUOf7sXJieb6bdSwdjM+qQqZLZYY+dyEN9ZXrVwCvni1KMVmS
 sk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790887513; x=1791492313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QLzZBoGdw7e5o/AE0N/TchedyfIZEBCS92c/NWTvoC8=;
 b=Unqo6MNahcLWzqCWgzYBek1M2Gi4KSEd2SBzZ/6mzm17PcQavfY113XXLyxGSdaZ0w
 shxQG1j1uvxxempXKm5drNLSrug+B3T04LJ32omy3It4EyBYrQAKXVgDK9uuSB276RLF
 t6j4BcGyD6+O9Oo8z15dAGtELsdKuvVCxSWklJqC4cUcaRGeN3Lp/s1k/1XQleJovmGP
 nWc9705m5r5l6gNC4V0qEl2pUso0XwdAn8b48OmI9R3dE+cKZvGZXh8sQuHGrFE5uw5Z
 b66vHveoHFRaf9MKT6y4UIUE3kKQJuGpXYQEYGDJQG2nWIK12313VnksV4mP5Dscuutm
 /9eg==
X-Gm-Message-State: AFq9FYLccgNOEuP1UGZ08C6ek9ss8a6mzHzBVWND0/J9yX52QYeGGKoV
 wykB44lR3xGYuT/NDfQT6KXdezSLbPBWnK8kwPdr9evkTh/PSsM1Iaqam0++uPVJVu6Vhg==
X-Gm-Gg: AYBFou23SDYQEfpsD+x3tVY1VsSUijhNgkC0URX3pNtJA7D4TkcQCoDDb27/aOTWuQv
 O8dCv7MGYpBeqgD5/CDGefUP2rqFtrAh9U7lqBi1Bv9SlzksKnKufXkFwOhd3qx4VkBKfsPgOCS
 rvNc8P3K8JP6gHgOuqaV7OrrTl62qhZg1sqoblThQArwqufREc8KMgdkIsHy3tnbc2o5eQ45tyu
 p0RI/AyYp809wppJcTVyiDF+T0OOA88aCtj5XHtlGQxikpRdqlDad0NdcT6Y2LZwwVPRpW0YruV
 SRuOZmTwq/lFzNkqXBi83mWCvK3SxnCPSEwg47L5FDAxdQIADNz/9PAk891zcLCMImaqccs9Qbc
 TBlNDmlQM9x9DdfkRgZV6BFNfmVJN09ZrmezE12SsBzIuuAgs6yBl7EVM/RROzuiOBT8iV0gKYv
 lbc3KA0tEwqxu2AomkmUtM1nhsVWV9f7b8gnXBVX8mNpC16lpN3MsTdoGWIh+Rw8TO5WLDqA+c4
 JP2oCXy5odqPEcmnflQFGANp5HCqk1A5aT5GQ==
X-Received: by 2002:a17:90b:1cce:b0:398:990e:1587 with SMTP id
 98e67ed59e1d1-3a6ce5a1c85mr652763a91.9.1790887512797; 
 Thu, 01 Oct 2026 13:45:12 -0700 (PDT)
Received: from localhost.localdomain
 ([2409:8a30:2e86:1710:20ae:2ce4:794c:d830])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd634734sm883877a91.17.2026.10.01.13.45.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 13:45:12 -0700 (PDT)
From: Qing Li <lqing2013@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Qing Li <lqing2013@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/9] cmd: Kconfig: fix pstore documentation path
Date: Fri,  2 Oct 2026 04:44:47 +0800
Message-ID: <037367f794aa4ef08e4066bb096848110d70bdaf.1790887323.git.lqing2013@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1790887323.git.lqing2013@gmail.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 21:24:42 +0000
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

The pstore Kconfig help refers to doc/pstore.rst, which does not exist;
the document is at doc/usage/cmd/pstore.rst.

Signed-off-by: Qing Li <lqing2013@gmail.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 7124b961dc2..049f6397a70 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2600,7 +2600,7 @@ config CMD_PSTORE
 	  This provides access to Linux PStore with Rammoops backend. The main
 	  feature is to allow to display or save PStore records.
 
-	  See doc/pstore.rst for more information.
+	  See doc/usage/cmd/pstore.rst for more information.
 
 if CMD_PSTORE
 
-- 
2.50.1 (Apple Git-155)

