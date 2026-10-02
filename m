Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C623CA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E530814BB;
	Fri,  2 Oct 2026 21:32:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PL-2geHzfjaw; Fri,  2 Oct 2026 21:32:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1F9E980DAE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976734;
	b=kqHa6bw0LPTzTxzAW1DuR27dPgDaHQebypfrpk9FsaaOg9qQT2bSwaHE7GUsvfYiNWd5
	 stcc9SAbiAOgG/wUu9fCV9Tr3KRaiS6bLCDyJWCOiPmyQnYqo6cu6YdiL2h89PBOtKT3o
	 aMVouTWRNJKQoZbZ4z3cPvP7Ko0W+ex6CkGdFewFYqSxmDVm1sughSFj7vX5L6UfhQBSP
	 hjI+HSo6kMjtqA48c/q5Xmq5h2p28m2GyY0IDJJ2ju8ADYPq+6t1QLH9iVNcY5Z5SGLcj
	 H02G3ngmSW1dXkILEA5Mn5CV/vRDadfZGJiA/ettlPzrZxdUlvLGRmEmJABlJlV54wA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1gTy9i+7J4jFY5s6fMi/sYUVuaVfesKxz5Rtr/5yvto=;
	b=lSk89Ry8p6IZQjVs9qEs5JpnDLz9R4eyXUpQ3ghZw7JxJzIkQJp829+/RK6GImBXbeXJ
	 qZlbODZtVTiW25HcOcbjWF0Faw5Bb+zbdQtuHINpsfhH/Ifio2DrLYPvF7akpsFqnS+2N
	 UBljqkvjCM4G0gNkWTPzK+N3RAs2SBtL6XxXbXh8Hi8HKl93vtEatRHLHf6bNnC2FUnZA
	 56sZzl+utbVa/e0rhVfsnxQGIJlxk4LBlIS6tEt63ZmzhlSvLKMgTdYbNDhoJJl5OGeAp
	 rxi9R6NH+mrlyn6nCWway7k5d+5nkyR76UmMX3DDO9QOHXjRAybLYhXAtVeUO7F4Q5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976734;
	bh=1gTy9i+7J4jFY5s6fMi/sYUVuaVfesKxz5Rtr/5yvto=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z/5KTCImXEzayvC4KB4IgjbN/Yo/BaxtwR8U4GAMh31HDaf5XbdB7Yr3GjxsBd+HP
	 3KbWBRtZBb7WKES5nhnsPIChyKnANMi6xduKIops9bvf0BJHdV3bFNjTDfz8ahYr1i
	 V4t1so+xnNj8DVWvGuFwIF3lLImEYMGRapyt/X4GyK+EVcZ76z7By7L4X8TQSgCHOR
	 +D8M95e7kRyhoDatfRziohvcta/95riLZp5rGEkd+QGQwofvxNRFDenY19pyjjGhwd
	 tqa1f/+2iolULng+kbuOqQUn4rldJrJv1A0Ftwxwlhr78YXDm/YKwfASbZ9HCQ0fkf
	 1er6kEX7PfMlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F9E980DAE;
	Fri,  2 Oct 2026 21:32:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF54D34E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95D7940590
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U1UyHUtweIXt for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:31:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3380E40585
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976715;
 b=JGv5WjObKvECeqceVnEvaoH6/lyJglBqEyVOEqTVaLXT4E6qSDZ2EwMieb94QNCTaDfx
 S60+LBbRuE+LASfkobbK7Hlk1O0cBQJznoZN0LzjM2Xq6rXropjXMS/f2misKT6kgjoZr
 h6sEpEo5D5JiQY1tmmKScJtkAEEtEyufOKW95+Rz4sony9tY/8VCclZGGrW1YbYAyt8Sb
 87wWSlJ0qv5gGmosEpw5X3mYV707rr0fm2Am8xAp/S3hbENE94KVdaNBC4/mAANp+NTh5
 WvNT6t3TdbqMJLmzEdP7bUfilhSrPA2vY8YOj34RGMFPq/YG0Q+09VUHCcbmpQ56FWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976715;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=1gTy9i+7J4jFY5s6fMi/sYUVuaVfesKxz5Rtr/5yvto=;
 b=NQkUT7vF9tOdK3fJ/1SmLez3gXkdT2bOMjBnrSJQGE5nqLQ3A0RMjvfdOrgnWUmJtpt8
 b87oubMlDS+NAjNcGLcZSFA3s9kYwk7173Pm9xjOTJ9WNsmuUqpRJFWp8DtrXCVk3q1y3
 jX6enBEPYrHqQ2CQ1f88p799/X70hg3eLrsidtv3ubZsOQBc5/XpaQOMeGJbT6piCZyd3
 t8ADM903xW2Y8xoQAfJTVn/nDPfRjcOgx5gWA781BRMlU/euSQP3/P18ZfJjgei26L3yW
 7KsHHAHSxozOTuMW2oGvMvclGKEksSpvmGEiuFpH45SPeoAU1ENz/o62/I38sVr8vVQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b="SWjrK/IV"; 
 arc=none smtp.remote-ip=109.224.244.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.123;
 helo=mail-244123.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=SWjrK/IV
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch
 [109.224.244.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3380E40585
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976712; x=1791235912;
 bh=1gTy9i+7J4jFY5s6fMi/sYUVuaVfesKxz5Rtr/5yvto=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=SWjrK/IVKtxULy67Qg+xhoogqkJRuG4fcVK9BNbu2ul3/wbJgnn6m5vrNhRvTjqBc
 K9rMTAmRzMfcF1PH6rpG/gwXTSbxOd0c0qIJnUNG24uLUs+T3UtKA9kJXKxuflmAPx
 6aseXquhuVZ/bCtseLREZZP+IRVPcJeM7vnN19jJfWsYVYlLaXwkJQGDfHXYUzeGUS
 oxf//Qp9BI8DpiRYG9UJQVN5B8L8kUoDM3Hbfqtt5whXW54XBM6W6UngC9SoLox+/m
 FrZ0IPuC6HErzLgAeUqSYIaEjjfI81Vca2ldEWtFiEqMclyfHRFXCRCGxc2M+xLTWw
 8J6HKzoMADF+A==
Date: Fri, 02 Oct 2026 21:31:47 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH 2/2] spacemit: k1: fall back to the other boot devices in SPL
Message-ID: <f492bf72faccb8ea1b91b77e2a28a9ca2caeb40a.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975598.git.DaveWK225@protonmail.com>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 42385d79c7567e917f394be579bd8639fc9b074a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:32:08 +0000
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

spl_boot_device() derives the boot device from BootROM state: the SD
API pointer the BootROM leaves in SRAM, the boot flag register, and the
boot strap. Not every BootROM path is covered by that. On the OrangePi
R2S, for example, the BootROM probes a card first ("try sd...") and only
then loads the FSBL from eMMC, and on the OrangePi RV2 it falls back
from the card to SPI NOR. If the detection names a device that holds no
image, the SPL stops with "failed to boot from all boot devices".

Provide board_boot_order(): the detected device first, then the other
MMC controller and SPI NOR when this SPL can read them.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 board/spacemit/k1/spl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 96ee4449c4..cc0e26bb02 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -498,6 +498,32 @@ u32 spl_boot_device(void)
 =09return ret;
 }
=20
+/*
+ * Try the device the BootROM booted from first, then the other storage
+ * this SPL can read. The boot-mode detection relies on BootROM state; if
+ * it names a device that holds no image (the BootROM probed a card before
+ * falling back to eMMC, say), the SPL still finds U-Boot instead of
+ * stopping at "failed to boot from all boot devices".
+ */
+void board_boot_order(u32 *spl_boot_list)
+{
+=09u32 fallbacks[3];
+=09int i, n =3D 0, m =3D 0;
+
+=09if (CONFIG_IS_ENABLED(MMC)) {
+=09=09fallbacks[m++] =3D BOOT_DEVICE_MMC1;
+=09=09fallbacks[m++] =3D BOOT_DEVICE_MMC2;
+=09}
+=09if (CONFIG_IS_ENABLED(SPI_LOAD))
+=09=09fallbacks[m++] =3D BOOT_DEVICE_SPI;
+
+=09spl_boot_list[n++] =3D spl_boot_device();
+=09for (i =3D 0; i < m; i++)
+=09=09if (fallbacks[i] !=3D spl_boot_list[0])
+=09=09=09spl_boot_list[n++] =3D fallbacks[i];
+=09spl_boot_list[n] =3D BOOT_DEVICE_NONE;
+}
+
 void spl_board_init(void)
 {
 }
--=20
2.55.0


