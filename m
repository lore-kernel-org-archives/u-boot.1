Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA49CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B656A813DC;
	Fri,  2 Oct 2026 21:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YXB7ZV5OEULz; Fri,  2 Oct 2026 21:32:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F2C2C814BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976732;
	b=PZkN0/4Eo/7TaOIOdMQG8dBVzl9ufaQu2rjuvThVjDw2zjIE+2c/rNGLeDmDlV+VvsL1
	 whY7EFx89mqWSW0zlYvtyhficnDDiV+NV0dEUMhkSXo8xiFsnUV77oVS1aOnEnthxylBR
	 ORUXcN+wSPyG3cP9DL56YuUTnd1wHctQRd8WZwu48PfbCem/IW49mUk2UUDF2ACQkhgT4
	 /WGvOBASOE/s357cEU31kARFeiInq+hNUwv1JOz8kwqnYvnaPC+nu3+la2blWyP98lDJu
	 q2gv2kinpSjeId/uXyKJCz93TCyHm7IkqqJeAtzFpf6T19dHaprAy26mWEWCDqs+ekg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1yxwket0wmY/LKSNhmS747nDDkTOb+xtme6/jo9Rs54=;
	b=j0L0SGqkiVPozX5wtInoTy09wjdH/Gly+bBi1MJN4P29dI1rwc1RvGlV/2m1vh6vYoFI
	 RyWNUMrVbTgZRMYsL85rJ4v88o/PXA2WZ9Smnxzr57K9jmOiVsV87dAIBPwWdGYsL7XTB
	 MyQAKOIYn5yVK+Rtf4hcjREeHiXCeIoDSxe1zAFOJjIg39ufFfBkSqpkPtznLOlia7mce
	 Jvpd5dj/vQn1zCE/n1ULFAEY+8Xw4bfxtGnfZKZveC6Gc3GfYK2BBHlId6uru+AOAmp0A
	 tgSlPlpF7FarESySZTxJHjZkqHkJ/Gm7mkm0FZL4eVgccrnamjtWo51Eg5+VaKTXorQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976732;
	bh=1yxwket0wmY/LKSNhmS747nDDkTOb+xtme6/jo9Rs54=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZwyUYssZPB9c7gUQyUUdICA1slXvuHvuDqqYpKcGz0LEKroggXUKN9GbOGIFN475t
	 7owQ8yLSbI5Kb1uTpPwG0qLMDwiD8628w7ZieqjZRRL9zG9YvHqHl0oBUi6Acb0n29
	 jBAlYFVNairzDgi6M5Sk0a3Izmx7WqKgWcrQlSg7yJK3Til7rpQc9KPVgcLNamb6fF
	 M4yy+wfVaFDaOCNyapduyTPeIri/DMAmnBReD/gkDMckC4dz+mUWb8EhOhyH9fOWAJ
	 LWHAjcZvC7qfCU9gseTe0QbuMsZLB6sFxKwQjRGJkWtkQvHpZXXeyg3ygnmm+pmhsK
	 yxUHhjxYSTnBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2C2C814BB;
	Fri,  2 Oct 2026 21:32:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 06559179
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E088860D99
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gk9FtfiC5nE for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:31:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 09BF26064B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976710;
 b=bR0jaG1M3dQUNBIb2W3JP2eetCdmJXm3djzp4a5Bz8XyrXRcSJYPTt/mRFPyDsmDUXts
 LbvjMMVHTDNmoV9z2ThGvMUZ5NE/ntVqLHkJqD+ZN2QyMor03/fMEmXhAn4taivMf9PP1
 mrla/URXGAh72sNVMUFqB0ahBT3gGejGG39KaZSlq68f5254Qt6soXeMW1iCKI36qKLNd
 rbb+k7iQ2pvf3ZvKEX6Esl3HDnjvcSgCzgQNP1OqiI4ekUYNzdZLvOGE6WiCWSiXsQc0G
 Dmyzc0+jHAFmaWEF99rvU/+Qf+72miQQlouDtcb7y+VlvfvriVy3ln8j2IrSsAK6WWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976710;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=1yxwket0wmY/LKSNhmS747nDDkTOb+xtme6/jo9Rs54=;
 b=L3UalarJ1cMTRuF8NJ5eLEG4ZftSzttJ81BBnhceZfYKMFEF1ncKPaZ14zILU0Slq4gZ
 foif9qMalFwO4H9f6wIV9VBxmq5r3gK3qg5cjYtccZmTI6xfr9uP19byhBS3kkFaguLTS
 HN4uEQ3uAvQHwrVi+BKJDVP1FQWRXmQIosjw/x4+lRupiSVkIP177MWz24K4AgvIohwBj
 VuQZJNXhKuol+nrh5NZ1h3sY7wJpm4NwQmZnoJpirCaINTHwGSR9BdEaPm8ZxPz2q8XHr
 wxfER8FEN5hpLjE3rtCXzjkyBpqkDFoSuh0YHdYTcID3xiqPzbTaU9A34+lnxX1/HFQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=LG95WObl; 
 arc=none smtp.remote-ip=185.70.43.103
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.103;
 helo=mail-43103.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=LG95WObl
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch
 [185.70.43.103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09BF26064B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976707; x=1791235907;
 bh=1yxwket0wmY/LKSNhmS747nDDkTOb+xtme6/jo9Rs54=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=LG95WOblTmSBlsnTXm3tibTFtWwA92lAenfVRcgSfNETd0zuMpMOqxFykGDYDYmAT
 nddvTzclWQxe7ahrkQxFnCXIwYX5jLpeEcIGML0Wbti6hj9iYrV48MSUotaG1WXf7O
 2AximPILAU6IKT+tAe9GdS9MMa5T59Yug7OqASPAbbS2PEE+DeiGBgl0F3u/VLLGSc
 mTi+d5jYf7CaJoWrbe0ytITyqNG0jTFL0g8BdzwVPNUmvMdcSlylfZyQ7zW14QK5e/
 P7n7dY9VdoxGUdax52Vb/XvYbB0XrX4PxqgNcUF5rH1eQl08e5C0luTSswtsklBVqL
 gIMRAVWQZfnEA==
Date: Fri, 02 Oct 2026 21:31:41 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH 1/2] spacemit: k1: do not require a PMIC or an SPI controller
 in SPL
Message-ID: <ca6d36aa511c453032d723005dc427f4d6889216.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975598.git.DaveWK225@protonmail.com>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 8cc8c4ceddf53ceade7bfca7db04ec05707ffdfc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:32:02 +0000
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

pmic_init() and nor_early_init() panic when the board device tree
describes no PMIC or no SPI controller to the SPL. The OrangePi R2S
boots from eMMC with its rails already up, and boards that boot from
eMMC or microSD need no SPI NOR, so the SPL stops before it can load
U-Boot.

Log the missing device and carry on instead. If the SPL then has to
boot from SPI without a controller, spl_spi_load_image() reports it.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 board/spacemit/k1/spl.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index ef23db62d6..96ee4449c4 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -301,8 +301,16 @@ void pmic_init(void)
 =09int ret;
=20
 =09ret =3D uclass_get_device(UCLASS_PMIC, 0, &pmic_dev);
-=09if (ret)
-=09=09panic("Fail to detect PMIC (%d)\n", ret);
+=09if (ret) {
+=09=09/*
+=09=09 * Not every K1 board describes its PMIC to the SPL, and on some
+=09=09 * the rails are already up when the SPL runs. Only boards whose
+=09=09 * DDR bring-up depends on programming the bucks need one, so a
+=09=09 * missing PMIC is not fatal here.
+=09=09 */
+=09=09log_info("No PMIC (%d), leaving rails as found\n", ret);
+=09=09return;
+=09}
 =09set_vdd_core();
 =09set_vdd_1v8();
 =09set_vdd_mmc();
@@ -412,9 +420,15 @@ void nor_early_init(void)
 =09struct udevice *dev;
 =09int ret;
=20
+=09/*
+=09 * A board that boots from eMMC or microSD may describe no SPI
+=09 * controller at all; that is not fatal unless the SPL boots from SPI.
+=09 */
 =09ret =3D uclass_get_device(UCLASS_SPI, 0, &dev);
-=09if (ret)
-=09=09panic("Fail to detect spi controller.\n");
+=09if (ret) {
+=09=09log_info("No SPI controller (%d)\n", ret);
+=09=09return;
+=09}
 =09udelay(10);
 =09ret =3D uclass_get_device(UCLASS_SPI_FLASH, 0, &dev);
 =09if (ret)
--=20
2.55.0


