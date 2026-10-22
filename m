Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A4606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cxjK28U4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXtlzKxl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F12560907;
	Thu, 22 Oct 2026 13:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m6xV4hb_ttxs; Thu, 22 Oct 2026 13:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 977D4608DB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675852;
	b=AHtToRuc3mEMsyWN6eFZz/x+Yi2XkVI7FM/rSlmvMMwYOJTYMVu8/CxaD/+K4sAPwKp5
	 kdQDpKKOI5kULvssWN+e3yXDYQ94M0Vee7af1ZNAk2WJY0wqKV7+PeWeCciJw1ggEGzpI
	 zi6+4jcdot3yLuiX4pfeyqXtlMy+3meytku3sqp4nbcOXbZ3hAhzWxS5meZ4x6zUDlT1q
	 MEO4jfkn4tLlFB2oAzwGsvWM5FQ+GhjpHloKEiC3cav3dOt5TJ9xJgL6NrnBYnIctD1X4
	 dGG+3ciGZaF2z29Tjz7jHBVIMm/KLZvOhk5zQTAdqn1iF5vyG0ddD5wksb4jdthW4Sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=80IEFr8Fe5+MAcYV+6iyrKa0AX9eVOkcvfBSQDyLvDM=;
	b=VXCE1zbZETiE8+c2FAI0j3SJPJ+Ax/UDNYZyeWbaFcoY0qhCmcWNjV779ISIqw2P83fn
	 fizegXrtP6MjkY4O9IkmtKXjzPEcjIBaVnKiA1lH83/4BXPEdvwiB7Mx6s/TWnHj9nDiz
	 wYLS6P6PX2+Mq7ebyv3NUddzj7sEqqCxMcqTNfGEKR5Th7XCbUhkWzoPwW/ocJSdyZY5b
	 41+BN6HaOcUNLKztuAzxAueIvUpbdOzBroVAnAoTi6vIzksa35PVA2afKgIzK9yhVDzqC
	 7sgP7hbhShnzo8mDh61j5INz0L4rInNGU2DFnrOQoELFaTGP0WWzvi1Cet3r5X+GGDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675852;
	bh=80IEFr8Fe5+MAcYV+6iyrKa0AX9eVOkcvfBSQDyLvDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cxjK28U4+NgBonL9oVtvlbCamNPIAnVvyFLFp3m5/F2uFWtKtTCMMcLs0IhDjPDCE
	 syXikMtpbvwTMUOeNx/Aw0pVvYcfxm+S8Umt6FuHfS87FSBxR00U69twVjO7fSa2JZ
	 Pxfg2k1zNJKRZSoN4sdR7nGGx4afU5ggZU0sLPOJunZLIA/8XkzwOW/e6u2/RgImrU
	 3KwXijQFZcjcy/0iT8wd3TJjxNrEWQ1lLzkCWXR33uFu/H8ueihPpwKAceKVMX3KOl
	 3IGEKczE3xKUKgu+YQsDsoKIYHw/B2rHNnutOlR6ntUWRml1gwLQ3GweT0TZvrNB/o
	 GuVAowlY8R1Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 977D4608DB;
	Thu, 22 Oct 2026 13:30:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 749F03A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66D7E40769
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Mq6x7kxeCKM for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:30:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 731CC40649
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675848;
 b=mGYmDmQGRIZFYi+nTUV/IBD0T8HdU0mgL4kR2lcKRekzGHT3IGzwe77SUzbudHnrjiSo
 qGO5P02fIzMvFigl8IFIn0/cCTmzUNUUTZETn2chrc5ppn5Ln2k/tjbSQs3IOs2J2SdA4
 HXKSnetC3zWMjUT/wKTmn0rpB1YNAY+lfODDwrWammp8Z7YvImXx/p2UyGcNB7j95zqX6
 iCQm5itY1dFJvZPWzc/D5rzPX7uLuvSBcqHNGa30lYKzQ4KAOy01tGrXo3vw4sl8RjgYj
 oAkfSvHn5ty/GxUmW9O1ikn0Jn4Qo/VJdWZTrxDuOQzsAvXKKE0NCe8YP+JmwNKziCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675848;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=80IEFr8Fe5+MAcYV+6iyrKa0AX9eVOkcvfBSQDyLvDM=;
 b=cTBwXSKR3geKcERzjeYFLss3hrnAuIgPFUulX7Iv5ZtlHeicNGHNfj2J5a7qqiYgUO3B
 dJ2JutanyDj43JobHIgG3Q/ig5wRsx6704EowNqn94Pmay+/aH7mn3sEMOswFOB0Xbc9z
 qIV341fJx1XVI2rh02V2OnEe6sfkn38fMrDMiGiSsYDgXK45+y2JihV8Gq0pa1l836+P1
 03kUf8/4nuLtn70CtX83kLk86SErC4pKnQmXqcQ6XDQeFI/0qOIlGpYV0uN+AzA6Z+2Xq
 +syTgXz7E5wjAonFOlgneWOZvQFbOFSL78U4+5hkOfvvj2/D1VIXePvoHCxfEvWzy3Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VXtlzKxl; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VXtlzKxl
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 731CC40649
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3964C60DD9;
 Thu, 22 Oct 2026 13:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE721F000C1;
 Thu, 22 Oct 2026 13:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675846;
 bh=80IEFr8Fe5+MAcYV+6iyrKa0AX9eVOkcvfBSQDyLvDM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VXtlzKxlxxlwBuggCoi9Lx3a6kmSjAeFcOWJ1k7yESmgiKJQ1EvbgbljNt1ApfS1O
 IdLTZO2yHGzU+RwhEktsYsTzqAqQJke8jl6u6USAEnUxb4AYq2HI2MLJ9/7Afz3R1+
 Ly+Mr9ZMDC0Ukx2GHbm6lqlVTXSt8sXPM/mOdop96r0xTIif4FTy4QSuzLXCWCmuH3
 cXiFl4L815txc4GfGSX1Ng9m52IzFXQAAQjr78bySeFSqFwyY9NyttISZ3pV6rP1iD
 gD7p5+KWjIcculWyl2ZGHaP2LJTGdwHrDYCvgWNFvpTHFKqlMS4iVeaM1PlqNHLhAa
 PMy0HeQ7/U1Fg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 22 Oct 2026 15:30:32 +0200
Subject: [PATCH v3 03/10] test/py: android: Drop verbose printing and
 unused return
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-test-avb-fixes-v3-3-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
In-Reply-To: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=QfKlkYGgL6j485Kpj0X86iAyzIgERNMWRUbtdeXGdsE=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq2g/8pDEsds39RXElrYy8woQ5OoH0cPexOXzv1
 HS8BwSzBGmJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatoP/AAKCRAZDR20Zk4Z
 NUSxB/9Kmitu5bC5OXCvawahqPFzi/JwiYeo2ysxgdW0WA8tEYA2DYBsJyJi2gAfjE1bdvGk8t4
 kr2Mgvq2ft9NM6Oh+ls/mGyIMGpmj4P0A92o7tNhw56J6za4SzbtsovZ2iATWf4TKoN47lJaf4h
 SGBcqeqR2e5miLoHu7i19C2spgtSjtZDNPTsMbsxS0Gbj3TZm4oSgmxqy/9zfExDrLQUH7toh1+
 NiA65WHkCPTq1TfTm4XFKrhsYo9drDjk55XdUJjVN4hAeCUtOhFQ5uq/ejDGDIf/uVsQlgJeyaX
 yXIKBOTahzoi3/syO8+bQpZ3uh8+W889GeZfZjm0a9oFQV+M
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The setup_android_image() is only called once. The callers does not use
the return value.

Drop the unused return. While at it, also remove the verbose printing.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/android_image.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
index 3bea311586bf..8b536754656e 100644
--- a/test/py/tests/test_android/android_image.py
+++ b/test/py/tests/test_android/android_image.py
@@ -81,8 +81,6 @@ def setup_android_image(ubman):
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
 
-    print(f'wrote to {fname}')
-
     mmc_dev = 8
     fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
     utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
@@ -129,7 +127,3 @@ def setup_android_image(ubman):
 
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
-
-    print(f'wrote to {fname}')
-
-    return fname

-- 
2.56.0

