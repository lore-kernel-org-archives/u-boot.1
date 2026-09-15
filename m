Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4202CC88E7F
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 14:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7F8280BCD;
	Tue, 15 Sep 2026 14:29:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Izoa91Fjeea; Tue, 15 Sep 2026 14:29:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4734D809C4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789482588;
	b=L8g1m7PFHKukQ9+DlGOIiV3ASOO1f5HbyIrHhvKDFG+3XlQHI3Ez+YsR1hAKrDWSfyRh
	 Bi3eTp8/f4WlVoFsBVanh9TjuIDKyXVjL5Xsl9B2t3RN4iK/ARo3RriPMv2nYf3PbZjB2
	 Fz+r61pugm6+LLb388M4wRJ3e/3+LMPETb7riQL+OED6Zl839W/JPauuckJ5PRWEcX9Lx
	 G6oW/CH0tFk5rkKvtsfWRJN+gsAgyYSeHwbkER4RCpID9Ix/oplZAe2doV+ORv0QK/YzK
	 MgWhTYy32z1JAvyHwNwsojTfJnYX/9mx7JKu6JeM1AaV94RwUXOxm8vR5QUk2pacGUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789482588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6KjkbPW/paiGvRtz3gzKUGX6j6BYkIZyQcinNCjIRlE=;
	b=BpLFpI+8tQd3sEJ+qSysxtKnUgQggO/JErlZ0+PFUJsLLa4EaTH0RMwCE5boLQPs3uvO
	 ZG5Leg5g8kXu2C+Y2z9+WAxK8vgFBkwgtnoHdgzM/V3D4AZyv+2n2Q8LMVyJk6IbM542I
	 k+5G0QA/aDc7XEsLxYd9YgcSAA1AAoVep5fSd2PLkjfMWXFOTUF4o0n1l6rqA3R2TUrUM
	 VZzTmkA7XDDRsq46DZUGm6LpT52pAO4tGL2Ico5CVF2yh9DvI+nCKQrYbF0X+yicfIVgI
	 fd18G0Tt5mZwwkiVl7+cLZSovi471lZ9ld3IUgFHvWmZbCG0/EtFNp/JkiMuTlLpMPg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789482588;
	bh=6KjkbPW/paiGvRtz3gzKUGX6j6BYkIZyQcinNCjIRlE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1CA9ptgylZuwcr0KgkjeVG/IfnRT9cAlBGRxitU94jmkEPuBrINgb0OpuxxAeo4YP
	 NdTqnvJBqCWTP6pbl2eZKOCx4DM9GmWCTvYHdTNnbze7UZCb63BWm7KzbbQV9L3QRx
	 3pYyGJentDPqa7aDR6b0YCW+MXakxKKkSsJJ+Wf+RBSarr3WZm4U2RzDpIQOl2pxWy
	 JoagXHJEH4rTlv27XSgdBP2mpK9WxU81W+32nb+xa1JdolKMxx2AeoNoIAAcvOFRtf
	 Gqquu/qzORpEFx1FbvDWHXbmjYmFeRTAQHZN+yxkmi4HeTSzyC2eFHY2GNYz90KI9/
	 OKasXJJGhFNeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4734D809C4;
	Tue, 15 Sep 2026 14:29:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81EDC493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7370860689
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lYRWQqmMNqaW for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 14:29:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5AE486066C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789482585;
 b=Wb7Nygb6VJyJJ1knk9lk4Ny38tgUlSidl4ibX4Iu2oHz/G0zFEM6TIV6ysf4YCNoefnW
 nHDWB9lzJW8+m12SZevkti41qXmvl/OCjaN5MYiBHuMBqCPWegorFktR2u9Cljs9kTpA7
 dAALlLnzegTFAqTvdA2x4bN63dlyAkCawQYPw4iGwtzgUzKJlSOTNTQKm85logCL1p3ak
 QS5FFw9BnxGn692plaBc0pVg9ZOtxydZlGJwHV5ogc9rU9LW9MlzAaHYvSsSRy2HXNrEJ
 ccz4q9n12X7QO9Vnh94po1aP8dRLRtvwxALKp7oM4f+GIqgMZKRlPj02LP/QCJmkOtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789482585;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=6KjkbPW/paiGvRtz3gzKUGX6j6BYkIZyQcinNCjIRlE=;
 b=gjQNx7JFrZcZjNYf5hj+1m26R3NS/fKLb2rhNX0Jl+5sfrSwEHt+A4pzW7eLs9rB5tcO
 i9Ka/yO36qxT7i8j5dsxxQ5fst2yoLPM7UmTdGFBAgRLh6jicuj0x/WrD3CD2qgukEDXv
 hooJaS/6sPs1/HhjWTzWl1gkbvhmlhqqZUIJEzm32GX5TyWEFdmR2K/hlA+f2Qsz0NEKp
 2QRod8Ijr9wblEVH4NyhO2DVLgVfV+JyjII2DK5tU4kiO6u508Eta6qI9ahDHfpoEZfuo
 BvwiJwzqxuLM4iM0kgFaLzVbP3677ui/NFr0LMVsV2EAjwhsD0c9XM5xccr9B1GQQyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="ilIAg/Ut"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=ilIAg/Ut
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AE486066C
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:29:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20CDB1516;
 Tue, 15 Sep 2026 07:29:39 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.129.53])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 892693F7B4;
 Tue, 15 Sep 2026 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789482582; bh=2/mXbcewDErauVGx1qNym3sWzvTKdDcvFxvVMKiCmPM=;
 h=From:Date:Subject:To:Cc:From;
 b=ilIAg/UtZrO1LU19ffdmNWmsRumzYGN8tfKROEe0amkehYCQeE+TwIq/LRPs+IgWd
 sapfukeCloenwU1UQuRzDSH1jwmJsC/0tfLtQdCNU1MBBBC1woU/+69iarF8YeuxD8
 RMhpg2Q3dkeo8OyjeUooFf2CI9ge3uqayCGedPX0=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Tue, 15 Sep 2026 16:29:36 +0200
Subject: [PATCH] fwu: fix read buffer size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260915-fwu-v1-1-cc1fe9640334@arm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0MT3bTyUl0jEyMz00QzS8M0y0QloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0AhM+PvWcAAAA=
X-Change-ID: 20260914-fwu-24265a691f9a
To: Sughosh Ganu <sughosh.ganu@arm.com>, u-boot@lists.u-boot-project.org
Cc: Etienne Carriere <etienne.carriere@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=2/mXbcewDErauVGx1qNym3sWzvTKdDcvFxvVMKiCmPM=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqqVZV4NEXGlnEy/XHMMgftHRV8BlZaEezk0p6V
 sArI7xkdiWJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaqlWVQAKCRDLSfhWdqMG
 lDQpCAC5lnB4Adl3hPOko718joHwBAjCQ/vkIjhxpAL+jldpn76Qb5vBN6yDaGnB3px4oCQ1buo
 NKvvtr3CRURBkzUwAukKqGwvN+g7m+QyYFB7N2HjSqC6T+y4+cDbEiDd5DphCv6mMv8w0QDRLar
 /MMjue0PYc5Iu8SIv1hYC9D6u0Hn07ihlFwycRmKOmLZk1wbcj47JxZA8C4+i4GqSEWW5ygvvud
 i/3xDYFz7LNFYlG+/bwqSYX8iCnAaR09rJlymTfrr2UHs/SpmG2Hy0o3C8wmNULf60uTzBqe16q
 z12QSiA8/cpY5V7i6r6TYOuxeRjgX3PBg/4WtCnV/j1wvS7T
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

When the trial_counter_read() function reads its counter from the
TrialStateCtr UEFI Variable, it erroneously computes the return buffer
size to be the size of a pointer instead of a u16.

As the UEFI Variable is always created by trial_counter_update() with
the right size before any read attempt, overflow cannot happen in
practice, but fix the size computation for correctness.

Fixes: 7e9814cc6c1d ("FWU: Add boot time checks as highlighted by the FWU specification")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>
---
Hi,

This has been tested on the sandbox, with CONFIG_FWU_MULTI_BANK_UPDATE=y
& CONFIG_FWU_MDATA_V2=y, and with a modified fwu_boottime_checks()
function doing essentially the following sequence:

  efi_init_obj_list();
  trial_counter_update();
  trial_counter_read();
---
 lib/fwu_updates/fwu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index e9bb1b4fc65..24a8f1ce5b2 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -82,7 +82,7 @@ static int trial_counter_read(u16 *trial_state_ctr)
 	efi_status_t status;
 	efi_uintn_t var_size;
 
-	var_size = (efi_uintn_t)sizeof(trial_state_ctr);
+	var_size = (efi_uintn_t)sizeof(*trial_state_ctr);
 	status = efi_get_variable_int(u"TrialStateCtr",
 				      &efi_global_variable_guid,
 				      NULL,

---
base-commit: a44f46af0aa17e48572e0d46c0d082886ee353c3
change-id: 20260914-fwu-24265a691f9a

Best regards,
--  
Vincent.

