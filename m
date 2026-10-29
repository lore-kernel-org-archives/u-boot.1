Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDE1606A331
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=luo7KS+z;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=FIGtYUdz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B34780FB9;
	Thu, 29 Oct 2026 16:23:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NkPN_dtRyd3n; Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8ADB180FBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291012;
	b=LStK80oEt45bDoMcMz1aGQa4RPtm4khfmA2iyOT/IVNYvA5Sg0E8zTRxvIjyoq0MYaA4
	 r27QI4lMHyjRe4fq7Czh1sy1xkIBAZLhA/drFWIAM7455CjkmwbndEnGJ0uQKgZqcaan+
	 P8B1xn8s5zkndjlDUdONZLsXSv6UYoaoWJPFBnsN9MSUg14e1n1nxNeBW1XlHntp7wzku
	 socv3E/gcC+Ar5kBmm0z0jYaAe5LZv+5Ht/b8oEyL+kBi3EWLaAfamPD5qcxz+lo4YFFB
	 /GwioI1JdRYfgNniGtZTaPMLLsItExsjwLrx/H+39XeKiv5eorJWa3koXZHWHSLURYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s5s35aho4lcr0EnHB/EljuP3dtzJcSUWBS8XdIjabDw=;
	b=BB2+168ka3Eplufqr0zfaK+CwugCQ7U6SteaTsPiiTwlHcqZBlKriHwRZ89jYgiUjvkK
	 i7cObKMPYy4YzYPPngyIL0pjH0SYlj+gCw3pQwgOxn6u8zKZ/p0/TRvo98A1vYTIhUl0N
	 h0yTi3InnKhYInQwOiCZPEHUWr5KE8s2948b6ZRMLrWd1BwkEiF/p913BCCSyZEAc3M5O
	 saYn6mT+9SqTrlzJ23cvJ0vwTlCkMJQ2l86A8Hv0x8jcAYvQEL9V86ccsY+Q07j2/WVQi
	 QmPm5XgIWDmn7Qrjv0ukRVP8XvE9VQz8BIzHtt5vW+8dOF3WLQHFr7VQ3K2wt1pX5bQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291012;
	bh=s5s35aho4lcr0EnHB/EljuP3dtzJcSUWBS8XdIjabDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=luo7KS+zjFkZXlsJLUdy49eJ8aeyICy7EijOXW4myXd0jbz/ssm7R/nO86YpTgghn
	 ZfuMzSI2uGbdY3pyKfduhvFEDRy/WUdfVW6SMWhDjV299lmXBBgWQUhdc6Rc6HUFwy
	 JhEApby5lOKa1tqTBlyoouG+g9K2PYmxpFgew+vgxziHRRs8BybXZ8zuIpTzni7MW8
	 Egm2h6MXdPH+P5ziNIKcCtxhGP3iFayN5Ie3sgLVyLfVyZapi0jZ6jxVd8mmTRqLJz
	 DpgqE/Lt+WdR50wgolzseHDc2DyFgDSBzaeSxuQamv1tUPygXrjmo9+FFoq86iel0k
	 xncH1lc54iCAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ADB180FBA;
	Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 553542E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 474EE606C4
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ls4w3KQVPEcM for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:23:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81954605C9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291009;
 b=REgfbxPdrAroRx49jIYGZmRqlaMYtshjpYPzvZxWpHCsMf8dK1XySPp93oeYm3JmU0Rd
 IMC1jT9DE/d7ZErVIDFHDFMi6Xyk9aO/6rn/1U9I9ygGeZ79iiO11mmoAjNLYFRm+4A6t
 +bcdNu65Gsnn3VnPmywBvWyFIDeWzbVJfKp8TSmkNU2otEZu81X48MbRCq4grAGra+OFB
 JzxEyPTy99R2Noy14WCKfC+JSKlNSMucWet3dMfxXB1FkabLYN7E6G6PZ5Bt4EoAfL0CQ
 pfn1iDZwkjphGk/6c7QJxOCvByIWRCpz23wY9PxRJqoUK7Loa87XGFM3ESqydKAxAOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291009;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=s5s35aho4lcr0EnHB/EljuP3dtzJcSUWBS8XdIjabDw=;
 b=om+EFpyF+FTIqzA6GdItBSF1t/czmmW/G7KBB/8cmgwRFGMaCRzU9lVCx66zUi6Ii4Ox
 M8IQPESKvemilAZJAzDJvUrto4GFYCK4dkLZSxFSo40WqFBLXUumcc4r19PPOpiCa8/Wz
 aZ1OuNxkbsbtWrM6F/F6NDFa1DQ3L92KT4IxIyaba38VtD1gdrSSQ1fIdbgfMajB7Znep
 wU8cX/kS2zyxKIAfIP/D69Q+c3SIE55rXola4q9nLVAfOUYs7jolRUwPhgW205Hg1ChU+
 d2PPpwSEzvES2BYO6yYucG7CeQXhW3XAePRKaUhGZG4Vr8KPOdqf4rYN/zk2otHwnvQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=FIGtYUdz; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=FIGtYUdz
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81954605C9
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:27 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793291004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5s35aho4lcr0EnHB/EljuP3dtzJcSUWBS8XdIjabDw=;
 b=FIGtYUdz5LQAG/ThmFbphcM9sC0S29RwYxUEqmc4de1CrEXlr5eqI+BGGjyYEe9atZzl7z
 QTVVdheRDffDsRDLMzZEIye2Yfp7J6AOLh2qwwIGSObIbWDB5MqWz+oac/gYbyV+iLveC0
 7IMMTHETksdAYVrbvWq3ydxYDQT0bRnBNUa2wZdwZcOYm9Diobzz0Ih1nRWnXSk9SeqdeG
 oXmomu07ctrjQXwxHZzPXyzZPMO9DlwLenJo6jBaBbcyxFGAsu4xtbOQeKF10mlsCpWZAw
 JAsXSkpaaMLCKEZt42XCuncEIoMBysEgHzDHxw9A+v3DykdzRPVSuuULHw2gmw==
Date: Thu, 29 Oct 2026 17:23:07 +0100
Subject: [PATCH 01/10] bootstd: rauc: Initialise desc in
 distro_rauc_scan_parts()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-main-v1-1-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
In-Reply-To: <20261029-main-v1-0-b5a878627107@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=Rp5QYPrhQAssT8cadoB4M+Tt+3xTqDpBVXkUjM3L4KU=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetx0a9T7xsvOmektsyZXZVy69q6AvcTW6bGMxg6mAn/W
 x7yoz6jo5SFQYyLQVZMkUWK3+K1rVmsj/yx6iiYOaxMIEMYuDgFYCJ1rxj+u+cyCXD0H+k9n2Lq
 dW+LD5/y99WX3TOOipvtPPW+WWXtf4b/ZX0JigkyzbMmSU7xslksskPjZu8t2/gdv9hWPXWMalv
 OAwA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

distro_rauc_scan_parts() only sets desc if the bootflow has a block
device, but then checks desc before scanning the slots. Without a
block device, that check reads an uninitialised pointer and may hand
it to fs_set_blk_dev_with_part() and part_get_info().

Initialise desc to NULL, so that a bootflow without a block device
finds no slot, as the check intends.

Fixes: f271b0627001 ("bootstd: rauc: Only scan all partitions instead of boot files")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 boot/bootmeth_rauc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 844df7576bb..4a3f05103eb 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -95,7 +95,7 @@ static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
 
 static int distro_rauc_scan_parts(struct bootflow *bflow)
 {
-	struct blk_desc *desc;
+	struct blk_desc *desc = NULL;
 	struct distro_rauc_priv *priv;
 	struct disk_partition fs_info;
 	char *boot_order;

-- 
2.56.0

