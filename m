Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2719CA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 702E36064B;
	Fri,  2 Oct 2026 21:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xQw-kApKFPcJ; Fri,  2 Oct 2026 21:33:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B38A36065F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976832;
	b=aDja0EfNT+QJv3Pp0VXW0IBgnLEFHbc8oMZbmqRbdvjrW1PvgQFTMzWTd7XoBMONI7mK
	 OxRyudwBUrQ6oqF7hlsg/ymKKQ+CE+bNbYiDCrTkPOPAzrzx3Dw8mKeCACO+X0UEsFXoB
	 WNnpJaHpKq2xH3qmcHNiXu4GqaLtkPJIBGhstz6sosM7iImaZzwnU9iA9vxPVhE4wJBBa
	 Cy5qvNo/jrT8Tp26qyldv8rpjA0e+zw4AT6LVVhXbZeYoqqY2k6KnOt7vljj0YqAX6PLd
	 XawS4rP2v3TJU/kSgi/jZyN4SFSrzMGXAlt+Kf+FaLNt/kzRV5IesYp1Ap7PwQg7xNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976832;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1yxwket0wmY/LKSNhmS747nDDkTOb+xtme6/jo9Rs54=;
	b=b8YYrn5xiNavtOyIaT7xjZzGIZVygUta79yIerho6PTTFqBSKU1fWpswyY92aGkA3KeU
	 lAqtNJxZOCZ4xWrHT8gmNboqWuwhJm9AYWbZwC5n1RGcr41neUculUPCU1LIaVLszmWHI
	 RvKRI81Z9G1xXSIvU8eOV+WB3PXq/wcw1SWJgB3++BmABxCQbS+Y4xMWVJEsWx9wYXAGo
	 7aIqTtd9tTOWXy3NaJDEzQ4O9suS2m4qzyZP+CdNmlxBAIWwVZ5BHHCqfDaSiwmUq+MST
	 v9vkjOa8XG/43G4n2ADBMSUXZMKm50RBtypsMBWL/JkHsbWF67Za3rh/VAGjuY7l07g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=PFHI9ZQz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976832;
	bh=1yxwket0wmY/LKSNhmS747nDDkTOb+xtme6/jo9Rs54=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tXm57X9Q3farl/lyzjvM48ur1oF1RULGGAqckBergZ2iBZvkYHguGr9mt9lTRbPmG
	 77ZdAkiaAujaDaWaSuyXXbODO+58nc5urIjLP+eVvYdNUguqp5Ww57VbrrwUrOg3dQ
	 AEw84lfDcfaieZiWEHAqiC6VST9DQ0bg6DRPpJztLmYTlzBgRwDnRLbclGYjJxmnx0
	 s5FWWkpRb0yA9bmKWHPHRfRuv92iCaozDVEkXPDa4O4R101M4UvXKR0Wwsey02BJ/d
	 LsfmY9H+MKj0Xl4+eUDQmAzOq/6Zzz4mHsZFbdyAOsGkpSIJjes1C4Z3M+qM3iUqOG
	 V18DnVsG/JOdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B38A36065F;
	Fri,  2 Oct 2026 21:33:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 960DF179
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87BC460666
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mbl-wyx4FifV for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:33:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CCA876064B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=79.135.106.28
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976790;
 b=ZFM/Zaksk15wfLoClk6nFHS3NmhIEVxqAO0na7uHtsiKyRjGoU0tQYDNJLP9JuXUb2SI
 BLXe1+A9mkxAqWmQFWDLIOl50ZHrGYvkOQW9w1VfwbWKirPUcYa3FPjBDcqX9OUoBC6WK
 Nlc4kR1w+Jl7fe5FdthC+fFS0h7rf62aWmyCKcjc4JAn3WvDCOFMmadY/XQIRlh6KhJ0E
 2aKGWvClasb5PnsN2yJAlxd0L5uwyz4a/AP4MSboTMFf5pX/1hXxC6Tkh7+wHlQMyDiOd
 lMwc1vMfeJQs2l4qhsXkbqoMNEyK2zsaKPjcxSzeB93INW3kcpRs0m4+cWHURbZdwCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976790;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=1yxwket0wmY/LKSNhmS747nDDkTOb+xtme6/jo9Rs54=;
 b=QQ/uENXQ0/eng/ZphpS96IETm9IwtQeeWNglkbgTTUgSEUKIZtk+vrC2D6OzaLkxKazd
 OHB8Kc0In9V+f8FZHd3lRxwLqcjBD06aAujXNMZ0p4ln1uXFYMyFqT12T5CBf7zD32hl8
 MSohyXr8I0b59SmO74EIdqv/y93ZPhMOiCiPcvR57Viy9qvfFPgJcl0/vw5wdIk3YFCGt
 KwvZ32tzIACpXDMPsBT6tpXp6OGyX/nuRrWRZPpfwx0DBgao9MzhQgaXZAUr/Ol7ByqoP
 8yZFVEk7LWVKTN3omBPNOoxHSNazhj6R02cU2+tXW4aLX4u8BSTDgB7iUAK13Jfcp1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=PFHI9ZQz; 
 arc=none smtp.remote-ip=79.135.106.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.28;
 helo=mail-10628.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=PFHI9ZQz
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch
 [79.135.106.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CCA876064B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976787; x=1791235987;
 bh=1yxwket0wmY/LKSNhmS747nDDkTOb+xtme6/jo9Rs54=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=PFHI9ZQzN2dcVfHmtNYmIvZURWGis/f+vo/Syt5W99pMiDm5jcb1TfqR/+vl6AAtT
 whRcrMW0w4AH/s65UUYNIzN4RelkyVpXcUsV5AjA3jlrEthx4uD7puSxHCgxMGCByF
 e5+C03H2WCppVJEuRUikNIt3MUj2+RZxya6WeFeat/FJiBEcnY5kkVPQUa5byyGFqc
 5g5Yob4ZpZ/qOC49b+WVveKmFuS/4QjVapiwlSgYdoK6/AkSN/XMkJTRmp6oOY3zwl
 Zx9o52dkJk1KtfP4Q67zX+GY+MhmYCWZbWXm9YOiZXa7TjG+upX3LKGm9J7k0UHaze
 1Z9RCccFtJVeA==
Date: Fri, 02 Oct 2026 21:33:03 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH RESEND 1/2] spacemit: k1: do not require a PMIC or an SPI
 controller in SPL
Message-ID: <ca6d36aa511c453032d723005dc427f4d6889216.1790976767.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790976767.git.DaveWK225@protonmail.com>
References: <cover.1790976767.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 372043d79cd4514ed063eac8ebff030a453ecae7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:33:50 +0000
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


