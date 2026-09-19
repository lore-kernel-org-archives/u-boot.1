Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8E1C982DE
	for <u-boot@archiver.kernel.org>; Sat, 19 Sep 2026 02:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FDA781239;
	Sat, 19 Sep 2026 02:04:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7u4w6oQ3Mvc7; Sat, 19 Sep 2026 02:04:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A327780DDB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789783456;
	b=XXaQW4zgXTmeLmy/g2f26+LLai5h2cLWsbvCi4ATVjbGHafSALLQZ+xLOTk3voqukA0J
	 CHTb9l/etZeOkOgtrCN6RZyb8HPl2j0jNaeyzrnZ1u6MCb+oCsQhk8q0dZuOu8Y3paNjl
	 EflrFKWTyVioN/Hiz09NKaFVA76jj4+F7jaqA4w2iR1B/GRl0+s0HaREPpeWFPWqPGuGh
	 abFicgsxKCKg9sc/OD9TyGjPEqkBdomqx/Uk9SkNugxdgOgyyaBMBLxxO4wmbBotvzszQ
	 ytSsCN5XJp17lz7pJzUPRBemXnffN1n4JkQUtW7P5DmNuOi0cUpTsOzUfuspjSUaGCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789783456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CNyHi61qmq+dLRxiuVN40d97vEFgoW7bG5F7EX0qIHM=;
	b=KMBqZwafqitW5u2bL9LSbGcAg4obIdn4oJZ9k3mnyx4t9oWi4llu7Z8rSRuAIKUfXMcq
	 KW6CbenmxcN1NjgePaoLEWGjAYiFtwtjAHdjk1wRxqQ0jTA/+qkCgjtkcU6BGptkFM7FG
	 5eTx5Vji1V/IvzjsQ/LwZt+ucE3i5KnlJk9Gk/RJkL0o9bFdcmYR11qVYoJe9HDkIF7ZS
	 pwkUJnl6uFg92i49ur699kWB3oPSxcJyPEqDwGk6oCOktcR9Q5qwXsc9ofMpuEMuPLBXd
	 OeT3alqwvrA/EjjBfdMsL43zmZ1IDxK4abQvFeQ7OIDvCAWqZfrpSoNA0FXRUTHTUYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d3vFSj9r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789783456;
	bh=CNyHi61qmq+dLRxiuVN40d97vEFgoW7bG5F7EX0qIHM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1JbozmpCgXuYfOkveM8C3owaxy3pna0pge/dJxGbqdKnlxL0O9fhHUuQxODquHmiW
	 nrepEhUfbCdpnuAK0Cnv9fs0IDZXKpmO1vkqPhytpkGhCKakIw9iR+ebl+0Vrh33AO
	 NURn0WOaKRwjoq/zkxoYW/lmpQ3+aEVbe2zgzcokCqszoqEvPaP4Es7AhSFR+1ioda
	 sghN1DldYyszTqe/3y6pkbbBfJxHloIuM2dJnzz7bzMvxaOLgRjtorcBSvK8GYYVHI
	 bdgS7HgxEpAVOqPSoobNB+WA/AxkjL6ji2JB7zQMXoOqhI9e+vQ3mPXv0uu8FAgeKL
	 QY1CvZZVMoRsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A327780DDB;
	Sat, 19 Sep 2026 02:04:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 049A6362
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 02:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E022980DDB
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 02:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_mC2rZUKhFs for <u-boot@lists.u-boot-project.org>;
 Sat, 19 Sep 2026 02:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F17D580DD1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789783454;
 b=mvnYKU+EtSlw6Qed4Hn4j4hh72iHFHrYvfNAFJSzDp6dRu5v8cMs4DZORVT83600y+wJ
 KSkJItE7qadnUdIC71d9vt+FVlc99oZcrbiQfuKxuEbE+XG1AfGorIIRhk6rJFmPNIKCi
 5ba/EBi3a8c+EybGMYx7QE/rpOI+MN8hjt5QO4gQpY18rUjSgslpxew0QrwsSQw8X3A6q
 zvbIHfwR4kWUqQJtrMGYIDNhv5oGYi/PTXK84k6m6weK65W91Lq9LxGQsS0MqT5tRylxC
 03ZguJlvOovY2fyRzDDUV3C+gtjoIJrflJVSDY0gchUCLId+kr5SyBV+kD5gclhSWEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789783454;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=CNyHi61qmq+dLRxiuVN40d97vEFgoW7bG5F7EX0qIHM=;
 b=pu9SHXYfwOO1577lsEP3kEJPZRf+UuJzayRUbOACLtaV/ggq6oZ0d04yq6oy3HwzpZrN
 hi72NGx9HmRA0r75D/+tHp5w4aBfXGaERh8WgXRL0KZDUrq5iPeI2M1HeLjFo1BWQdL9D
 /Y+UbO/RQ0AtS/7/zOZwKpEp+0jsgBa7205E6pVrpjyAX25+AexF1Q62hic0ppeQlRfqI
 /iexyy+QYarIBSCekdV7lZvVGIbGL//Ot4YTjzKq44P6kiBNdguhEUYGZreuWHxnjrZdx
 XnWWSPeVFrpTsvt9MY6gxTemBh1mqLVmnhxbVkFFyLjI3Y0Zm+OMJE3Hi8pkrybkgIQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=d3vFSj9r; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=mibodhi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=d3vFSj9r
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F17D580DD1
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 02:04:13 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4aaf2ecfso1195323d50.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 19:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789783452; x=1790388252;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CNyHi61qmq+dLRxiuVN40d97vEFgoW7bG5F7EX0qIHM=;
 b=d3vFSj9rLll2svr2UtSWvo5B09pn2kMk68+ZgmmcJPeH6fMvTvVzYqpjIQZ7YbKML7
 iJb1iQoNT/rTuMB4Pm1Q3CMPXkTHT0dKdz8f8c6JZoEdKV4wueDNnU6QFXsVYsAcS1NT
 VynEPYdtJuBM/QFbPJjXLvwdtLfGq8g863qW+HhM5sAFX4p/EDMCVWwdkg3G4u9vraSK
 piH1Z/gYzr4vP1kh+dG2svp/gIKgIkLkUIR9pHxkgDkbKwFbSAqi+7VYA7/l4AzqCHJL
 IdeKWQJuzt7vvH5iitPLnaDWvgjaCBNZMpX0eLY9ync4U3oybH7VnG933kIJPFOK1yNH
 HZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789783452; x=1790388252;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CNyHi61qmq+dLRxiuVN40d97vEFgoW7bG5F7EX0qIHM=;
 b=gBPLt6SxJe70Uu0LPTbxYW3kxvpS+s8QRjVRZG2DOShthX8GBVBJGVyeeRYMD4N8uN
 XYvXdn9dPFt5uVLqtTYt4fJ/O59hQyPSmrTY7z1dK7j9DLVhWIwm44lT/vmfgfJxQ+8M
 d4RD39Uep5ZBxFIvCQHbyQDzV/gSnRTHIHKGWc7XfD56azKoFeSdDZ2B7mkVpNrRFVDZ
 YFv8WNwuIjS5GYbA5c5vkILpb+YePw4GSwwVOHXq/A42gzi1ITuKp4u7ZsMel5Tc2tuo
 Uei96hPFlw9wKs3BWLoa3rV1o+ZKimCNqt8F2oXGZSQRs6hcf46Qkln5E72xnQOGM/dj
 xRGQ==
X-Gm-Message-State: AFuF++lesxmC7nL/k/Uc+k0v3mcwrvRiCdEpD1qRmB3H943B17p9nLWM
 Z6JTBeAouSrIW43XFC5oRq43F4xMbW5j4FVmv12FeFqolazd1misiJp3
X-Gm-Gg: AYBFou0Y5Noa+ivpiZqvDUgg8/EVfZPVIxTBgdY4v9D4RTX+tln2BDiiwcZSAguGmzq
 O6NPx3HKgF9l/a5YYd81JoG5igvH65CmzEA68WPg2uV3y2vMRfCp3ydTGaz5ZmIZ1Tk57Ag/4nT
 Z3EGOzjXq0rhOoM88eOIi/qiTG/8pT6/vcCE8tay65/l+e7eMh4sKIPgxvVG6W/5Mp22VMNqWal
 d84OUbtNTYo9Da5B08uKx7FZSRSoWb++HHtWXbiG0CmqrrALutq56sOo5MHeFumZ8TV3F56CUAj
 npdy3SwcQ42N0RQjSD4oXlVtOkM1oODBvFtAa0I4iymdRt+5gLy54WyixkbWjPPg1q6wtathmdS
 gdDCi3O1IPjlQC51lmzqn9s2/AiLbchTPTv4k7rwOmWNNYt2p7jWDBj4qa2GiTasl170gIRWgGG
 KOdUS8el/agU+bOfAiMVKJ7XvevYo+U/VoZx6tUnIPqH5io90IdQn7ipIRsSqFRISV+sooq/NM8
 Z34ghR4daq8yf9D1JvnXakhzgzskW349ZrIUzI/qMjMWh0k7DaHyHjl4UN7
X-Received: by 2002:a53:b9ca:0:b0:671:3261:b0ab with SMTP id
 956f58d0204a3-6717fe44ad6mr1153167d50.96.1789783452246; 
 Fri, 18 Sep 2026 19:04:12 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6729910ba2asm708085d50.17.2026.09.18.19.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 19:04:11 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 18 Sep 2026 19:03:54 -0700
Subject: [PATCH] MAINTAINERS: Add missing file entries for some boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-maintainers_file-v1-1-f41050c42135@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIntrWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0ML3dzEzLwSIE4tKo5Py8xJ1TU0T0uxNDe1MDcxSVQCaisoSk3LrAA
 bGR0L4ReXJmWlJpeAzFGqrQUA/FdgmnQAAAA=
X-Change-ID: 20260918-maintainers_file-17fd9758744a
To: u-boot@lists.u-boot-project.org
Cc: Jason Cooper <u-boot@lakedaemon.net>, Tom Rini <trini@konsulko.com>, 
 Tony Dinh <mibodhi@gmail.com>
X-Mailer: b4 0.16.0
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

Add missing *-u-boot.dtsi to MAINTAINERS file list.

---
Note that this patch depends on this commit on the next branch:
MAINTAINERS: Removed files
https://github.com/u-boot/u-boot/commit/c062373ee7733209454d0e243696a439672c04e4

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---
 board/Marvell/dreamplug/MAINTAINERS    | 1 +
 board/cloudengines/pogo_v4/MAINTAINERS | 1 +
 board/zyxel/nsa325/MAINTAINERS         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/board/Marvell/dreamplug/MAINTAINERS b/board/Marvell/dreamplug/MAINTAINERS
index 6bad3ea78b2..b9262043e26 100644
--- a/board/Marvell/dreamplug/MAINTAINERS
+++ b/board/Marvell/dreamplug/MAINTAINERS
@@ -2,6 +2,7 @@ DREAMPLUG BOARD
 M:	Tony Dinh <mibodhi@gmail.com>
 M:	Jason Cooper <u-boot@lakedaemon.net>
 S:	Maintained
+F:	arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
 F:	board/Marvell/dreamplug/
 F:	include/configs/dreamplug.h
 F:	configs/dreamplug_defconfig
diff --git a/board/cloudengines/pogo_v4/MAINTAINERS b/board/cloudengines/pogo_v4/MAINTAINERS
index 35fd7858b77..460e95f958d 100644
--- a/board/cloudengines/pogo_v4/MAINTAINERS
+++ b/board/cloudengines/pogo_v4/MAINTAINERS
@@ -1,6 +1,7 @@
 POGO_V4 BOARD
 M:	Tony Dinh <mibodhi@gmail.com>
 S:	Maintained
+F:	arch/arm/dts/kirkwood-pogoplug-series-4-u-boot.dtsi
 F:	board/cloudengines/pogo_v4/
 F:	include/configs/pogo_v4.h
 F:	configs/pogo_v4_defconfig
diff --git a/board/zyxel/nsa325/MAINTAINERS b/board/zyxel/nsa325/MAINTAINERS
index 4a84d2437c3..a1c97fb4577 100644
--- a/board/zyxel/nsa325/MAINTAINERS
+++ b/board/zyxel/nsa325/MAINTAINERS
@@ -1,6 +1,7 @@
 NSA325 BOARD
 M:	Tony Dinh <mibodhi@gmail.com>
 S:	Maintained
+F:	arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
 F:	board/zyxel/nsa325/
 F:	include/configs/nsa325.h
 F:	configs/nsa325_defconfig

---
base-commit: 951132236b9adc592c2e49faadd103c6a355cac3
change-id: 20260918-maintainers_file-17fd9758744a

Best regards,
--  
Tony Dinh <mibodhi@gmail.com>

