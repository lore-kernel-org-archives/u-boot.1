Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2F606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 03:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y4Q4J8us;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTJm1XRc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F32D606F5;
	Sun, 15 Nov 2026 03:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cjQEBzHcVjHj; Sun, 15 Nov 2026 03:50:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A5377606D5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794714640;
	b=LxPjCuc1Pt6p9aVjYGdiW13QHLn8VfM+6CSQKC7BpI4KahSd2/Gp3GfxD4KR44tKF+ME
	 5XZgXfHi++mw6u2RixRTK2UWV4psW4x/9j0Cn27nuV+b4SmOx4+c0XO2jAtQasCb3w+Wt
	 XQnLPPulaN15USAvRO/kvwG3gx/Y/+IAL8qnLWdgK6x0FGwxWacIlvAawDEC1iwaWOyUf
	 R7J7QxnnRYjufpwKXUkRr5b9Y4POZ2JXhp0tHCDJy0dzP3Hf+l3UMwFvstjVHHzIl4s8l
	 XLruBqB/itzH4H0tIMM4Qp/5bs9o1kNsssTuHxRLS9CfdLxYck3T17GvRPzrAnIHaGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794714640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:Errors-To;
	bh=tG0BbysG7C8Nd5wCC17HBgXM//q7ZYVBbLOWnuDg/aQ=;
	b=GqoonkyMlGImlZcHEoNrbVWyYBg//BF3iYzhKx+YzNj6XrZ2kY77CSxvzx/xQghj8COf
	 /LKPZ9sNhy7wA4DHk64n6fL6Sgy38r2YORRdjDgHP7eWJy7c95sXxQ4s0Qk0Aq2earX4/
	 Hasb/KBHI4AOQpcvle6t6oV+/gck2guQtR12dyF67sGetsZXcjvwTGAfNNeE41UK2y0Xq
	 lh/J5qJIYe6uVyZZEfJ5wvGR8LskEMzq0etY1U5J3CASnnoZxtKelv49TRVN96YSdBRdW
	 5WmGynxhh7p0BENJ/hEN7IafSrMy0vm02nU3o5UkZiHdfFbrjzvpXXnfjLA3NIDbliw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794714640;
	bh=tG0BbysG7C8Nd5wCC17HBgXM//q7ZYVBbLOWnuDg/aQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Y4Q4J8usv5Gr7DPoouFUxu/lC0Idl6AcwbC0/OzXPZ5W6jS3oO0jNMTzyS4kBb+jw
	 Y/DErkjCyMnSA0P3oNjOI8cDg8ZqUGC/CvQuMcwNZxO36Q8haJ9H1N6cuFyxnGpeTc
	 wRK6qER/kk9WVV+v+ny2qwK7cu+DMH/F5+L6N4Y5VLOJHcIJ+sKZxJtWfjU+A9W3pU
	 NVKO1sUvy8NJFZOqDd5SjvFo/VgJdBaPT30jnKWqALXcKQN8HPo0NNR+i2nEzoIgeI
	 smMDEHV5hz7lNR+NQGVgUZqpnDcUFIzxHDmZDGBpmlNOnC4sbidIUlvNd8ZWhOg1Dr
	 jAm4MF7v1etvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5377606D5;
	Sun, 15 Nov 2026 03:50:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D6BD7109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BCD1040079
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:50:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jIqPKPvQHCp2 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 03:50:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C051140068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=mTJm1XRc
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C051140068
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:50:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 564A443DDD;
 Sun, 15 Nov 2026 03:50:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C34171F000C4;
 Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794714634;
 bh=tG0BbysG7C8Nd5wCC17HBgXM//q7ZYVBbLOWnuDg/aQ=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=mTJm1XRcSK2oWc/F5DyWndKbYPR8ZJrBx+32dptKzyhCURIWiGwGJOeGcWbgmJGOB
 +BI9KEmzdG64kn9Em+uizbuPoa9CsIDdfmzAsoAN+wEV/cHHA3HOCWo1UrgLKL1QGy
 FAu8NSdj8I3wCGgTfl9urTuYposjemt2bI7C8PH6Cp6cwMKH37z9HmU+ceyjUVFRzS
 TjnAgmVV3Y9Co2JNrx67S3CNXQEQpSKZomnImLatSxtfmi8EFTVPIMQblGjdD10bG/
 hhdKAACC8/U91Iv72jLKJGqSfo0CMQBn0Bi8a7DIBg2v878KB46MRmDiiEAFlncjB7
 TJy0a/ka7JAJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4385649F59;
 Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH 0/3] arm: meson: odroid-c4/hc4: Wake-on-LAN from suspend
Date: Sun, 15 Nov 2026 03:50:29 +0000
Message-Id: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAUs+WoC/x3MwQpAQBCA4VfRnE0ZLOVV5LAYTLGrnUJt3t3m+
 B3+P4JyEFbosgiBL1HxLoHyDKbNupVR5mQoi7IhIoNjjQerd6jTibff0dY0c2NbLkwFKTsDL/L
 8y3543w99hJQ7YgAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=1f4rcOl0WM800WyLDxnBIBr8IxSjl/eCc4sHv9kkPzM=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFk/ddiuS96ttw9rPKzyclf40SWzXmvxdnk55F86nLng1
 oFbp6ubOkpZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBEAhcy/FNbrSm6/fGTqy9V
 p29wPagU+Zi3vYM30XTCpbdxB+9Nby5gZPj13uGZi4RO2p+/4iVhGko7lFU8Zx085/h/yaMjZyq
 3f+MCAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The BL301 that Hardkernel builds for ODROID-C4/HC4 wakes the board on
the Ethernet PHY only after the AP has sent SCPI SET_USR_DATA for client
7 with a non-zero value. Neither mainline U-Boot nor Linux sends it, so
a magic packet does not wake these boards from deep suspend.

This series sends 0 or 1 from the DTB fixup, following wakeup-source on
the PHY node of the DTB the OS boots with [1].

Tested on ODROID-HC4 (U-Boot chainloaded from SPI, BL301 built from
Hardkernel's odroidg12-v2015.01 with unrelated RTC alarm changes, Linux
7.4-rc2): with wakeup-source a magic packet wakes the board from deep
suspend 3/3; without it the packet does not and the RTC alarm does.
fdt boardsetup sends the expected value with the property present,
absent, and with the MAC disabled.

Client 7 is an extension of this BL301, so the option is enabled per
board, for C4 and HC4. The N2 BL301 has the same client, but I could
not test it, nor C4. The G12 device trees have no MHU node, hence a bare
helper rather than a DM mailbox driver; I can rework it if preferred.

[1] https://lore.kernel.org/r/20261109-hc4-phy-wakeup-v1-1-d98784ecac88@iav.lv

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Igor Velkov (3):
      arm: meson: g12a: send SCPI user data to the SCP firmware
      board: amlogic: odroid-n2: tell BL301 whether to wake on LAN
      configs: odroid-c4, odroid-hc4: enable Wake-on-LAN from suspend

 arch/arm/include/asm/arch-meson/scpi.h | 17 +++++++++++
 arch/arm/mach-meson/Kconfig            |  9 ++++++
 arch/arm/mach-meson/Makefile           |  1 +
 arch/arm/mach-meson/scpi-g12a.c        | 55 ++++++++++++++++++++++++++++++++++
 board/amlogic/odroid-n2/odroid-n2.c    | 31 +++++++++++++++++++
 configs/odroid-c4_defconfig            |  1 +
 configs/odroid-hc4_defconfig           |  1 +
 doc/board/amlogic/odroid-c4.rst        |  9 ++++++
 doc/board/amlogic/odroid-hc4.rst       |  9 ++++++
 9 files changed, 133 insertions(+)
---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261115-b4-meson-scp-wol-a41de6a7e053

Best regards,
-- 
Igor Velkov <iav@iav.lv>


