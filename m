Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC08C624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 02:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BC4C6089A;
	Thu,  3 Sep 2026 02:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id feDt_DNTz0_Q; Thu,  3 Sep 2026 02:02:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1727560834
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788400966;
	b=TXawxzSCJ0+tihso1aboFt8Ls1SDP8H6Kq66D50XntkT0Wk4eTbPYg+EUohG5p6vNtYO
	 yqIWUUJQRtsWgwY++eoq/FCuUilRwNuyn0AytUd/f1gMPaHjmIlFtVsvxOwS17g4qDwwd
	 QIByaH8q8cGu3TGjfG9x8CyB7uw9gQG05xX49ZexvAbGSpLy86lyy1avRjJS56auZVaRl
	 C/pnaVSUK1wZAuc/5ocuK4gk/eUJ/VzFUSJlsMp97Avv+cc8zeNHaHLQidkI1kgR9+l76
	 YiaXDJzdRQzn8vWnnRFefB9SAyY5ygzf2fgI+dgu+XjhNJZDE0A0sPd5sjsnF2HUGuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788400966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6vwKT4WgWySPKj9CNhnUtB2ut6EXUeueKANsvGdf5xE=;
	b=kRcfayGXtqlSv4qDrdUZZuj85JS1dYS1J0f/xcXbCla/0HiYZfS8QvMc+lHlRfX/6HZg
	 A9CUGfS/Mb1/ag7w0XyhStBV8u0UCpqDtGyo9nUhO+t331gST4/Ko+wPOwKc2GfPE3Q77
	 +a3qPLUrA0TYreRV72in0aMwMtpZ02o1Sngua4dkdHJYn53yhoihDXWJfaQPVNwzYrU9Q
	 JrqPUYHs8m3PI71U5jS5Nz3/FtcBviDS5r5hoiYdLhRvO1xAwwbhlmQrh2Gwde+iUfFgU
	 dS/zIZABQ2S2mItbp04+o+OsF0prkAaETXleA0fjVHzBgx2wMBR0bU96mDfppytebbQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=O03ivWaH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788400966;
	bh=6vwKT4WgWySPKj9CNhnUtB2ut6EXUeueKANsvGdf5xE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RTmn7ko21KpsFaT5fMdEoCUdmyvuewtVVgoGgd1/pjmNowzu1vYdku/v/B2wMiZPg
	 huMpXr4oKLMkGXuUmYoICc4hgopaIgGyOEYsXWvYDvVkravChRhKKvSbdsUQcnS9jk
	 uJN+TvNbJodPNXGRVCrNy/7hAIkeqfYLNbMmxhoQ6T2YaX6zPX5nLGddAVlWgVhP1m
	 fu7htEF/welkV2sdT945jeIbpALWHcOU+2ayjU4BNu2r+6MCu57IAGJjR0bxooXzMY
	 71kSR6Q0Fv+gZiFk0cFtT4gP1KMkIAM42ZylH0/yeR58SCWzDpcFXcAooCAt/xdmz/
	 cEGYAaTpWgapQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1727560834;
	Thu,  3 Sep 2026 02:02:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B50A82FD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 02:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 92D3860834
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 02:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yruW0704OPs1 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 02:02:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C7DE06081D
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788400963;
 b=nqlfR/R6dpjDKsIWr9Nd05JaoR+TaxluT5J6foAoyctzp2usywhLDRoJdFs9l4imI1no
 qp/bvOk5uiAP9GMpcyTgxesDynlTIcxHNvtYQaqtfCfZTw4ONtwxM2zpDy4lHvRVCY6YR
 I67KM0G4xLJrE4Xdf6EvzNF8giXvuQSCszn3EJyaL8AplKqsPZUI3IzvUAemHd+ETbyiY
 tPG6s7LzvDl7Z5JM9jnOd11FqL/Vn0rtZBlsk1YNEj2acR/IFOrG9sK2wYQG13uja2mZw
 urERySQXn6+67vgrDIc4D3rX45Q0LJd3zk+Nvsxk23G7xA+3QTFoSTF/RaWYGNS04hQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788400963;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=6vwKT4WgWySPKj9CNhnUtB2ut6EXUeueKANsvGdf5xE=;
 b=naTsXkPLmjmzCaZO6VpGZbzlzJiQaTNkpQf5izNqLusq4WJ2MVXdWyc+LdoQ+UFtjM32
 jIKXdZabOm2xWZ8XzY+R+5E5DbEWEqAPhO3d7VHHRQ4VGlrILl/V4K5ZHQjmKUvC5F7uc
 VGI8gzeqUDM+U5qXqwv1TBrlF2rQUQnM86nxlDbuJ4Njdioh3azT9sF8QuiA2kQWmFDuh
 LJfHIiQ0oPR0ktuvf/uo4qxTPujcD6RJk15SIO4zyug27u6qqiVBGGx/bW48pRzlQgkyl
 lLeviINVTF8ITNUrFIgbpl/8nl2dLkaYcfjzP/iopKuQrcTbWDiPZUgdGyUAAvQMDow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=O03ivWaH; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=O03ivWaH
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7DE06081D
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 02:02:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 13E7311C8C0; Thu, 03 Sep 2026 04:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1788400954; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=6vwKT4WgWySPKj9CNhnUtB2ut6EXUeueKANsvGdf5xE=;
 b=O03ivWaHwooUpFPTPGq1e5K0qax6yhmxKjddrlvGkqYhFXMdGo4fd4bMRfuZy4MeFmVI3R
 iFM+lwzoTe0s9JpV47VxLOARGJy17gLgjtwOY6GoKc9jqWo6p4OG77JU2ql2lVxftBbRmA
 rUjlHCC6E+YzdelrR5nwVPuekAmbvDoaImQL1sAfmZBM/LTEvn23+wVh8ge7vCXO2gvwgS
 ImOEQ1JJU6Bud3MKb5NnKs6nXLGovIXCIFteffoeeC3/xCFR0vzkWXivFC8NqSFkVufyb9
 KNJ2YHBICZlo9Odfy+d0vhkcq7zE33hfK4lMfgsrRtzU5JQdHq84aC+X+L3B+w==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: gadget: f_mass_storage: Synchronously tear interface down
Date: Thu,  3 Sep 2026 04:02:00 +0200
Message-ID: <20260903020231.1278473-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

After fsg_unbind() is called on UMS teardown, the fsg_main_thread()
which also invokes handle_exception() is unlikely to run afterward.
Therefore, any exceptions raised in fsg_unbind(), and also exceptions
raised in fsg_common_release() which is called from both fsg_unbind()
and fsg_common_init() fail path, will remain unhandled.

This leads to a problem where FSG_STATE_TERMINATED/EXIT handling is
not performed on UMS exit and the do_set_interface(..., NULL) which
shuts down endpoints is also not performed, leaving the endpoints
enabled.

The CI UDC driver does check for repeated enablement of endpoints and
returns -EBUSY if an endpoint is enabled repeatedly. That prevents
UMS from being started after it was exited once already. That is,
running "ums 0 mmc 0 ; ums 0 mmc 0" on U-Boot command line will lead
to one successful and one failed UMS session. The later session ends
up triggering fsg_is_set() assertion in fsg_setup() and triggers a
panic().

Fix this by synchronously invoking the do_set_interface() from both
fsg_unbind() and fsg_common_release(). That makes the unbind behave
as intended, as if the fsg_main_thread() ran after fsg_unbind() and
handled the outstanding raised exceptions.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/usb/gadget/f_mass_storage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 7eb667c130d..76ee08dc5e8 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2565,8 +2565,8 @@ static void fsg_common_release(struct fsg_common *common)
 {
 	/* If the thread isn't already dead, tell it to exit now */
 	if (common->state != FSG_STATE_TERMINATED) {
-		raise_exception(common, FSG_STATE_EXIT);
-		wait_for_completion(&common->thread_notifier);
+		do_set_interface(common, NULL);
+		common->state = FSG_STATE_EXIT;
 	}
 
 	if (likely(common->luns)) {
@@ -2647,8 +2647,8 @@ static void fsg_unbind(struct usb_configuration *c, struct usb_function *f)
 
 	DBG(fsg, "unbind\n");
 	if (fsg->common->fsg == fsg) {
-		fsg->common->new_fsg = NULL;
-		raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE);
+		do_set_interface(fsg->common, NULL);
+		fsg->common->state = FSG_STATE_CONFIG_CHANGE;
 	}
 
 	fsg_common_release(fsg->common);
-- 
2.53.0

