Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E23ECA5FE7
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2579B81448;
	Fri,  2 Oct 2026 21:31:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KofxAcHa5Fem; Fri,  2 Oct 2026 21:31:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5730B8143C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976683;
	b=l+L287rUyaG6NwL/6gsCQhTiz0Dk2caQZpnKt6obr608Cz7sOaj1tPXo+bHUlt7mxY5z
	 m75QMZCR3yJqbPjYGzOBYpmqGc1i8XRDm4GavqsSvg9pTjeD7fu/CznXIRe6Y2To4UpzZ
	 m+mdr3EyTJjR+aLpSI0MmT8QgDgVK5vvkHaGpk8ANyz/Ysvi+8xjBRS9E03UMN1p66OwQ
	 PzkUuVMl+pjlWyrZww/iJG2fnc28kdkuFYTaTCM8m3DQxuThQ/6Dv5Y+3eG3iRignUev7
	 N0UMebDigiXigKdApoWTaSmRB897MaCK8DCyhLZjg/teJ409NzpWztlSMOo5gr68JhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976683;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WyTYy7qYPl9uOqU8ffNtR0pFUVtoDeCH54KLQ02zU/c=;
	b=IpqIviXJCPJV2mxlIaZweCvJXiLsxacJ5oAQT35hGNyZiM9cPj26E2eGqAeYmMIeu17y
	 Kax8PC92+R1577n5iD4W0zjRpX9INBCUkBeh9QIq2B8oBOPNoU8VXLjwYuDLEUJL3d4OD
	 czO/3PVVSnki8XL5B8Ye0eEShjpuCgxm3JOwd29GZ44rgL8fyPkLcnYdxvRPM9eH2b0jh
	 sdRDxk8aS+EWTF3ERhuN+oGDFKKDZJmgOJsaoT7SPvk4m4sJAjcl3krNz4+qMpk4541f+
	 NNV0CR+D6CiKqPQXvBiNGGXC6V2KYJMI5opjY4i/lTbxukaenO/46BxPu7lZpyzAjOQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=gjvAW6LN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976683;
	bh=WyTYy7qYPl9uOqU8ffNtR0pFUVtoDeCH54KLQ02zU/c=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rvGrZdG2+krnUoqLn/htkAqAopf9cU9H1BhXQmlMjQuLoFMHRNcUdrhsi5EvR4Kc9
	 XTQOBOVaQ9kEq4T2V/tBR+9NOVAU3pSU2my6KH+FFUHD8WIrI1cgbFoMvOg04cl/vg
	 vRCmMRHyDzrrtAH3Vv7RgNtj4wAgQ+WowHoHaXgHMYJeJ1WVN6mOg4zzmgm6l6cOdX
	 CL3fcwEL4+RuZdPdi42CCJ809bbFpiBJPpM9gHRI+t056Rvzw3l31SzNuQFImKy4Ba
	 qz6mQpqq0rq3xO9EqAPC3oHvWOAgLjysmB3YZpKllPE6NNwxIL2a2ZmNN6RiSIbSdq
	 Ca3pVRLIROGBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5730B8143C;
	Fri,  2 Oct 2026 21:31:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EE54282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C55A81365
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_UgcT1ADBTa for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:30:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4376181323
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976654;
 b=WoCw0xliKwOqCxWpPaci2pDM+1QcOpF9FzVitj0PRe32VSMmlzZrZ/uAmzEEpxtRBvsn
 yKr0wFsfDK5d/N+74hKFV7zrmDD+GFhQdqB2ZfpvvsAg+8fyofuUu8iXtj89IUmsjqG1g
 y/qmHpxwKhHGYJuU6e1nFLsdOu60KBJDW+2mBfSIcSpOkC/9+2sVyFMzlD3lZJHrpYWar
 uov3Ilm4t+8QwQuu0XklOZEn2uOpYTKW/nrlNsEgTvvXMbftZwrDtHyW66Q91e5lUDAqy
 vkJoErj+UY09uMg3Yw+/LugkWHveHBRmooCDTgac8pwYpIyamqqxRGiTVzsoftwT0EQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976654;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=WyTYy7qYPl9uOqU8ffNtR0pFUVtoDeCH54KLQ02zU/c=;
 b=ft3370z6stTpi524J6rAiAu4dMG2k8LJ+4QWH37Pt4/ZHaeDKJV4IB3u4op2oRxopCBi
 oqSUfkNbW0cKhPfx1LVBYT2PzeufOxClH5XHFssl6aHIVxqYQZl5HrTQsdVUwZ2VzD770
 t7WaxvlRIew0UXT7uPqyUuIy1gbT+Y6HEn6bKqKWnTcUZ0oynNFo1AE2ynmWDJ+B8mPAG
 Zy7cLP+gC81NUTcrmTBhoPqkUKmq8NyLmSseONy65EPZjwflsIPsu611rOt5g+PMNo0lv
 ldpdW30pnWwMZa9HNzChYCj9XWBTa48Zf7DrPa+q9XKkf4NGUm0i7LelnAlXfFSj5qQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=gjvAW6LN; 
 arc=none smtp.remote-ip=109.224.244.16
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.16;
 helo=mail-24416.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=gjvAW6LN
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch
 [109.224.244.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4376181323
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976651; x=1791235851;
 bh=WyTYy7qYPl9uOqU8ffNtR0pFUVtoDeCH54KLQ02zU/c=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=gjvAW6LNs0ZdDpxi0S6A7lvOiyYyPaDsQTTGzAxTGf6oRuxeIuW7qzAeOGoDa1mVD
 +r2720Oov5ZFUV3c/7F3p3Jk+78ztooM6v/ahANBk+pWb+VlfQ1BZcm1yzBQX4VXUt
 ANnzt7Q36Vs5QtexFwEUEYQ5IWUKsnqMaINWb0SiooCwPpCYxvx8pdadGGtD80Y/lY
 wszW358XrUdLxQGKOC1kH27rcRIkFfIwDIHKeIP5iozHZvB9N20r6UnKIcxUJ7o6dv
 VHwxGBrvF1YxvC2mBhoyYPbM5HEPdpVcl3AZw4ZSdAjHLq0tNReMHABwUH7wnHqoRd
 xW4pZaBzNbMvg==
Date: Fri, 02 Oct 2026 21:30:48 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 3/9] pci: spacemit: soft reset the controller before bring-up
Message-ID: <d1c78810bc9c32630aea7329250676fdb8ed21e9.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975598.git.DaveWK225@protonmail.com>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 02199672c3b2c4a563e091831793351a5d5ac80b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:31:06 +0000
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

The probe brings the controller up from whatever state it was left in.
After a warm reboot, or when an earlier boot stage has used the port,
the link can still be trained; the driver then prints "PCI Link already
up before configuration!" and skips the link configuration altogether.

Linux's pcie-spacemit-k1 driver and FreeBSD's spacemit_pcie driver both
pulse PCIE_SOFT_RESET in the APMU control logic register for 2 ms
before enabling the application clocks and resets. Do the same, and
drop the "already up" shortcut, which can no longer be taken.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/pci/pcie_dw_spacemit.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemit.=
c
index 04b3161e94..b85de73ad3 100644
--- a/drivers/pci/pcie_dw_spacemit.c
+++ b/drivers/pci/pcie_dw_spacemit.c
@@ -106,11 +106,6 @@ static int pcie_dw_spacemit_pcie_link_up(struct pcie_d=
w_spacemit *pci, u32 cap_s
 {
 =09u32 reg;
=20
-=09if (is_link_up(pci)) {
-=09=09printf("PCI Link already up before configuration!\n");
-=09=09return 1;
-=09}
-
 =09/* DW pre link configurations */
 =09pcie_dw_configure(pci, cap_speed);
=20
@@ -133,6 +128,22 @@ static int pcie_dw_spacemit_pcie_link_up(struct pcie_d=
w_spacemit *pci, u32 cap_s
 =09return 1;
 }
=20
+/*
+ * Reset the controller, so that nothing left over from an earlier boot
+ * stage or a warm reboot (a trained link, a stale LTSSM state) survives.
+ */
+static void spacemit_pcie_toggle_soft_reset(struct pcie_dw_spacemit *pci)
+{
+=09u32 reg;
+
+=09reg =3D spacemit_pcie_readl(pci, PCIE_CTRL_LOGIC);
+=09spacemit_pcie_writel(pci, PCIE_CTRL_LOGIC, reg | PCIE_SOFT_RESET);
+=09/* Read back so that the write has landed before the delay */
+=09spacemit_pcie_readl(pci, PCIE_CTRL_LOGIC);
+=09mdelay(2);
+=09spacemit_pcie_writel(pci, PCIE_CTRL_LOGIC, reg & ~PCIE_SOFT_RESET);
+}
+
 static int pcie_set_mode(struct pcie_dw_spacemit *pci,
 =09=09=09 enum dw_pcie_device_mode mode)
 {
@@ -216,6 +227,8 @@ static int pcie_dw_spacemit_probe(struct udevice *dev)
 =09int ret;
 =09u32 reg;
=20
+=09spacemit_pcie_toggle_soft_reset(pci);
+
 =09/* enable pcie clk and deassert resets */
 =09clk_enable_bulk(&pci->clks);
 =09reset_deassert_bulk(&pci->rsts);
--=20
2.55.0


