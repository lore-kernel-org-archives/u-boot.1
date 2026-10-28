Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A59606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ze5M3Elz;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YKilP5dg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF172817C0;
	Wed, 28 Oct 2026 14:50:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V0DgbeT7t_aq; Wed, 28 Oct 2026 14:50:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8033F80F90
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198911;
	b=TR91so33WOx+rBtXhnaDCfO5xVNJjj0hJxXr0A7MbclG7Hl6qR1R3E5tPBsDh3JxK7di
	 i68Atr1onvimXTOVm/5JyypY/X+7do4kqjJQ2Y0xElDysb6/fQooRTpVwIw7DreSEZSyi
	 o1zfYfBhUObj1FS9G9WX2JgC1lMfH2dMLo3CplOha9ToLdL7oh0qNXAx3G4g2rVDJ+zkv
	 NmtfiH55wvBOgoIcKIvoYgwyXxlopQJLqBTLpgtiCoWHGc4dp0t7MPY3Re9FaeLOiW8D4
	 Fq8srshRLNiVLUzqdB9ufxW5BIRSuuOXT8vIZGGBnfMcKDwHL+8yOj6u0bffQSYDFFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198911;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NFybz8NofQdPHTC8gvHENk0MWqshUbckm0nVoS9zqL8=;
	b=l8d/03d2LI3jCW7ONIJey7Wm2At7HXEzD5W/xL48jaDRcsdpiwr1ATVPf0BQqjM9xbwM
	 nnzNSCtIk0C/RNMnkdx/LBRJ1TwM56Ki1bKdYeuWVkpsooVrBxfVqwIGB2hHFY3FlGDgp
	 GTXuGY1gBg8eqa25+9i2BCmnte0ORc3lolu4HVcZzxZl+rhFy72Zms9IN4KKfZt/QxQNm
	 aWLPlRh50Ouw6+4v/5swuiJP3lcoU9r8+Xd6mxk2SgYupY+D2aJTis4smuo7biqOY+n4U
	 H2B/+CkKfz7qB6Ya58rf6oLRMK39OFYgouHCvbXCWKM4lx2COZ7wtmdE0qfzHlZESYw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198911;
	bh=NFybz8NofQdPHTC8gvHENk0MWqshUbckm0nVoS9zqL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ze5M3Elzp4ODkrLwWjC9MfBow2LuWWyFRYdruFBRQaG93yL4uh3nZlhIPPt7eknzm
	 EyoQHFWfzba8x5DAMkEwZIJIe8ndfqaOR3BrIHDlpe66iDD+1OcxJcctyl4eQEkA/b
	 Jr4SoGg/khu3lHAS4ZR3EzbYT7FGVlThBYEYD/ZpafFMJZVWdseYFL0P1CLV94bHgC
	 OQRIuKrA6EVm5ZIjdov465BsMgEbyya2vgO/q1LAvI66PwkrtYK5PD5y8ihJCDGNwP
	 yBdTwbdyZEuT2OwU0QjzWoU5s2UvG4dC8ak1WDiJvGpwXEu7Ckyr7AGdEfdWTRWMlQ
	 mOecibnl9HOQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8033F80F90;
	Wed, 28 Oct 2026 14:48:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 84966972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 771294009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v0yoilvYHB_q for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 279154008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197027;
 b=Jn6vXG8xYHJJhHjKkCneFN02S/FQ2GLKQn7twPKcJt9JyXbmj9XfwD212/q9Nu6uDxDd
 MfvwX74CE00jkO8YnFLgsk6XDm48vt7ez2FmnYr+v3x5pPoYBv65lfjrjv7+Ym/SlcgV5
 vEYmAgDwPpMILV6Bl4CCXTrFbevCdGhi2ygnegQNdGgwISxmJaN4vlnZ2p8lDQVE7ntuD
 fliHaogcwxKLnvUYy4WM+YjsLG9R2bEIxf/J+Juk+4n+skc+85bNeOeQnqrEVmjztiBbz
 Ui5lVPv+o8E37qvjER2/x2ZWxcW9wvE4tWoPh0MHrKwFb+L3xu9qeT9IBolx1nEoJgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197027;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=NFybz8NofQdPHTC8gvHENk0MWqshUbckm0nVoS9zqL8=;
 b=m4R+CImKkys3VnH0npoNzUzaSL+f9tM5WltFoBGRwnkoCtiX4L5GGA5obOFXU6Axd9kx
 E+eIrwFBhZ9NoMimx1Rz2LJpC+85LaK/xawTs64P3wOZ5Wp9N8QUL7DDE22N47SjHMQAc
 HfUu4U4KJh4e4NoBmumOKw/XtcR/rblVu4mjg1Ca7smG1RxUAN/fYFXdb+l5KX85OfBDj
 m7pldEz2sgXba8tvmDKskbhzagmwDgbj9LTkSHsc6FVufqjy1pFgo6/ALoMpAhMRmordf
 jIC+PlrKsJ4gGK9PduGjMFFElDI+xwmGRmSM3AVAua57njmU7d7FP0PcaRg4fMg7BDg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YKilP5dg; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=YKilP5dg
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 279154008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:06 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6aa046a99c6so236558a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197025; x=1793801825;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NFybz8NofQdPHTC8gvHENk0MWqshUbckm0nVoS9zqL8=;
 b=YKilP5dgMFQEOHkpaEkGC4KNiSa1sZVcb82byWQlCwWrX6H40LE5mSlp5KMriS6Arr
 1jn+R6tYEUTZJEKliPgoDELudYrOGY1KooYFStFaYEfbiMLQbCp91P/x1u8RvUiVcJNn
 bNlNZy7NA40UXhwIh7JZFeIS0HQWdxrsllRxYifyT+a+ex4uJzIuqGiAlSy5SowjikQm
 IgkKI2Sx1WFnavwEzBqPKzLUt8zrcvqJ9Ix74vN8pCOVdcJKdYDZ3ufl3GS8dXjh0vEI
 FybyrdYSVReC/dWXkXilvG1MChOxelYpqiKR5Q/4KGXNLOv+k4VYeY3ZhnnTl0bIHfY+
 QnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197025; x=1793801825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NFybz8NofQdPHTC8gvHENk0MWqshUbckm0nVoS9zqL8=;
 b=BReUkd5R9//48urkFb+GLNuHTYQU3C4gSdgEJHNahvjjOkmWuMAYB239kdtIKDiDs5
 NXGxvX9dBR5K1FUadhzZAD8HY8NWAcmvLo87SpHaooXTiWsV5Pl4AjZOmbyxea4nStb2
 cWhPpVp88wE42fr/nYOoo8If/hxqqwayt0H/eq0x0TTcaDxpMOmg6CGhLuJcgxIjRvRi
 vUlLqdncK1YPAY3GcyJttElaIvR/PyEdqscaAX8M3L6RZT8wjI0S9bd4Rm3p6VBaN2XE
 qt0+OoqRkYVM2YLn3HHLxrFAu62VUJ9NibJ3UniX8XfvZJNAO5cXyxmGEVbUYtjvoXTX
 1wbQ==
X-Gm-Message-State: AFq9FYJqBrNwmowlMgoN8m+OQqmx3Cpw+6mPV32fCUjnFiXNUnmXIhlg
 cITJOmkWrEF0an6LlsJ2CvMUGOTGy0/CknBCjMcSsXbqu0XqF0k/lRf6aOytpDvT9Iv+3RcPv5j
 Y01qf
X-Gm-Gg: AYBFou2mtxjycZXWaP9qx7t39AjZFTmFbk5Vguo1ItQnAcDP90iOdrI1w16Qtm4zqEi
 DV+DeBChAqQ+Cek/FHhmIMNUElpxNFD3kCW7KshQ56YTuDE2gKkD7bMETbsScNOoJDFdyCuK/lq
 1PAeQAIzIaNcVQFb+1OdaJs7e5ztP1du0bU1EIYjv1o83nZVWsvJd3WwuvtK/gFy3FNUfjEw918
 BxSgdk7z4Jp9MmkeRy5dr3fuBxhagoYsL6d933+lMXeGYD1dfZ8UhXSqRTuAigV4E5MNVfAYtEB
 C94VAMY5S6E8lcyYeGZT7R2Rx0j9vSy7J73/IHlbvm5n/GuqnxxEykLFGogHMXQPKA6eoXG6iIb
 vIOqrnWYEFkZTzh179S4pSVgtA7QPuxRUuQFEwuX4esk1hChVFpDEC45exsPOWuoS0QeqE2uMc2
 xcGuUOTVttxjGt/YQct9RNBrvq3hjFE6C6DQI5fXxD+zQ7/4SBYRfKbIzK7g9sEP6FSdGZrpreb
 C1ELO2oDDIpRGKC+aRsJoxtxRTCGrp7i6P17VN7+hbL+QKSOenjj6BU6k4pGIlLLPmpsDIY7N90
 3GvxiY2rH7agxBRxN+Xud5cSw/l5gI+z3aWlVWb54WOBigL+Ho53XPOrrIg5B4VQuld2KfH5n0K
 /xCTK3o4RLw==
X-Received: by 2002:a17:906:18e9:b0:c41:3963:6f1f with SMTP id
 a640c23a62f3a-c49bdeae450mr227656666b.4.1793197024876; 
 Wed, 28 Oct 2026 07:17:04 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630412866b.38.2026.10.28.07.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:04 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v10 19/30] usb: gadget: fix up the function drivers after the
 resync
Date: Wed, 28 Oct 2026 15:15:43 +0100
Message-ID: <20261028141554.3073545-20-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adapt the gadget function drivers (acm, fastboot, mass_storage, rockusb,
sdp, thor, ether and composite) to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/composite.c      |  2 +-
 drivers/usb/gadget/ether.c          | 21 ++++++++++++++-------
 drivers/usb/gadget/f_acm.c          | 20 +++++++++++---------
 drivers/usb/gadget/f_fastboot.c     | 10 +++++-----
 drivers/usb/gadget/f_mass_storage.c |  5 ++++-
 drivers/usb/gadget/f_rockusb.c      | 11 ++++++-----
 drivers/usb/gadget/f_sdp.c          | 12 ++++++++----
 drivers/usb/gadget/f_thor.c         | 19 +++++++++----------
 8 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 04b85419931e..060788419553 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -833,7 +833,7 @@ static int bos_desc(struct usb_composite_dev *cdev)
 
 		/* Get Controller configuration */
 		if (cdev->gadget->ops->get_config_params) {
-			cdev->gadget->ops->get_config_params(
+			cdev->gadget->ops->get_config_params(cdev->gadget,
 				&dcd_config_params);
 		} else {
 			dcd_config_params.bU1devExitLat =
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 7973927e8a7f..13a20441419d 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -925,8 +925,9 @@ set_ether_config(struct eth_dev *dev, gfp_t gfp_flags)
 		dev->status = ep_desc(gadget, &hs_status_desc,
 						&fs_status_desc);
 		dev->status_ep->driver_data = dev;
+		dev->status_ep->desc = dev->status;
 
-		result = usb_ep_enable(dev->status_ep, dev->status);
+		result = usb_ep_enable(dev->status_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->status_ep->name, result);
@@ -951,14 +952,16 @@ set_ether_config(struct eth_dev *dev, gfp_t gfp_flags)
 	 * from REMOTE_NDIS_HALT_MSG, reset from REMOTE_NDIS_RESET_MSG.
 	 */
 	if (!cdc_active(dev)) {
-		result = usb_ep_enable(dev->in_ep, dev->in);
+		dev->in_ep->desc = dev->in;
+		result = usb_ep_enable(dev->in_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->in_ep->name, result);
 			goto done;
 		}
 
-		result = usb_ep_enable(dev->out_ep, dev->out);
+		dev->out_ep->desc = dev->out;
+		result = usb_ep_enable(dev->out_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->out_ep->name, result);
@@ -1156,7 +1159,8 @@ static void issue_start_status(struct eth_dev *dev)
 	 * FIXME iff req->context != null just dequeue it
 	 */
 	usb_ep_disable(dev->status_ep);
-	usb_ep_enable(dev->status_ep, dev->status);
+	dev->status_ep->desc = dev->status;
+	usb_ep_enable(dev->status_ep);
 
 	/*
 	 * 3.8.1 says to issue first NETWORK_CONNECTION, then
@@ -1314,7 +1318,8 @@ eth_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				break;
 			if (dev->status) {
 				usb_ep_disable(dev->status_ep);
-				usb_ep_enable(dev->status_ep, dev->status);
+				dev->status_ep->desc = dev->status;
+				usb_ep_enable(dev->status_ep);
 			}
 
 			value = 0;
@@ -1333,8 +1338,10 @@ eth_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			if (wValue == 1) {
 				if (!cdc_active(dev))
 					break;
-				usb_ep_enable(dev->in_ep, dev->in);
-				usb_ep_enable(dev->out_ep, dev->out);
+				dev->in_ep->desc = dev->in;
+				usb_ep_enable(dev->in_ep);
+				dev->out_ep->desc = dev->out;
+				usb_ep_enable(dev->out_ep);
 				dev->cdc_filter = DEFAULT_FILTER;
 				if (dev->status)
 					issue_start_status(dev);
diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index b6c11d97a62d..5f5400bab7ec 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -325,20 +325,20 @@ static struct usb_request *acm_start_ep(struct usb_ep *ep, void *complete_cb,
 
 static int acm_start_data(struct f_acm *f_acm, struct usb_gadget *gadget)
 {
-	const struct usb_endpoint_descriptor *d;
 	int ret;
 
 	/* EP IN */
-	d = ep_desc(gadget, &acm_hs_in_desc, &acm_fs_in_desc);
-	ret = usb_ep_enable(f_acm->ep_in, d);
+	f_acm->ep_in->desc = ep_desc(gadget, &acm_hs_in_desc, &acm_fs_in_desc);
+	ret = usb_ep_enable(f_acm->ep_in);
 	if (ret)
 		return ret;
 
 	f_acm->req_in = acm_start_ep(f_acm->ep_in, acm_tx_complete, f_acm);
 
 	/* EP OUT */
-	d = ep_desc(gadget, &acm_hs_out_desc, &acm_fs_out_desc);
-	ret = usb_ep_enable(f_acm->ep_out, d);
+	f_acm->ep_out->desc = ep_desc(gadget, &acm_hs_out_desc,
+				      &acm_fs_out_desc);
+	ret = usb_ep_enable(f_acm->ep_out);
 	if (ret)
 		return ret;
 
@@ -354,12 +354,11 @@ static int acm_start_data(struct f_acm *f_acm, struct usb_gadget *gadget)
 
 static int acm_start_ctrl(struct f_acm *f_acm, struct usb_gadget *gadget)
 {
-	const struct usb_endpoint_descriptor *d;
-
 	usb_ep_disable(f_acm->ep_notify);
 
-	d = ep_desc(gadget, &acm_hs_notify_desc, &acm_fs_notify_desc);
-	usb_ep_enable(f_acm->ep_notify, d);
+	f_acm->ep_notify->desc = ep_desc(gadget, &acm_hs_notify_desc,
+					 &acm_fs_notify_desc);
+	usb_ep_enable(f_acm->ep_notify);
 
 	acm_start_ep(f_acm->ep_notify, acm_notify_complete, f_acm);
 
@@ -454,6 +453,9 @@ static void acm_disable(struct usb_function *f)
 	usb_ep_disable(f_acm->ep_out);
 	usb_ep_disable(f_acm->ep_in);
 	usb_ep_disable(f_acm->ep_notify);
+	f_acm->ep_out->desc = NULL;
+	f_acm->ep_in->desc = NULL;
+	f_acm->ep_notify->desc = NULL;
 
 	if (f_acm->req_out) {
 		free(f_acm->req_out->buf);
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 9a2e98501129..4df2407fb666 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -319,13 +319,13 @@ static int fastboot_set_alt(struct usb_function *f,
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct f_fastboot *f_fb = func_to_fastboot(f);
-	const struct usb_endpoint_descriptor *d;
 
 	debug("%s: func: %s intf: %d alt: %d\n",
 	      __func__, f->name, interface, alt);
 
-	d = fb_ep_desc(gadget, &fs_ep_out, &hs_ep_out, &ss_ep_out);
-	ret = usb_ep_enable(f_fb->out_ep, d);
+	f_fb->out_ep->desc = fb_ep_desc(gadget, &fs_ep_out, &hs_ep_out,
+					&ss_ep_out);
+	ret = usb_ep_enable(f_fb->out_ep);
 	if (ret) {
 		puts("failed to enable out ep\n");
 		return ret;
@@ -339,8 +339,8 @@ static int fastboot_set_alt(struct usb_function *f,
 	}
 	f_fb->out_req->complete = rx_handler_command;
 
-	d = fb_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
-	ret = usb_ep_enable(f_fb->in_ep, d);
+	f_fb->in_ep->desc = fb_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
+	ret = usb_ep_enable(f_fb->in_ep);
 	if (ret) {
 		puts("failed to enable in ep\n");
 		goto err;
diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 76ee08dc5e81..b8dbc2a385d2 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2159,7 +2159,8 @@ static int enable_endpoint(struct fsg_common *common, struct usb_ep *ep,
 	int	rc;
 
 	ep->driver_data = common;
-	rc = usb_ep_enable(ep, d);
+	ep->desc = d;
+	rc = usb_ep_enable(ep);
 	if (rc)
 		ERROR(common, "can't enable %s, result %d\n", ep->name, rc);
 	return rc;
@@ -2206,10 +2207,12 @@ reset:
 		/* Disable the endpoints */
 		if (fsg->bulk_in_enabled) {
 			usb_ep_disable(fsg->bulk_in);
+			fsg->bulk_in->desc = NULL;
 			fsg->bulk_in_enabled = 0;
 		}
 		if (fsg->bulk_out_enabled) {
 			usb_ep_disable(fsg->bulk_out);
+			fsg->bulk_out->desc = NULL;
 			fsg->bulk_out_enabled = 0;
 		}
 
diff --git a/drivers/usb/gadget/f_rockusb.c b/drivers/usb/gadget/f_rockusb.c
index 77a89b47d990..60074109a4a7 100644
--- a/drivers/usb/gadget/f_rockusb.c
+++ b/drivers/usb/gadget/f_rockusb.c
@@ -203,6 +203,8 @@ static void rockusb_disable(struct usb_function *f)
 
 	usb_ep_disable(f_rkusb->out_ep);
 	usb_ep_disable(f_rkusb->in_ep);
+	f_rkusb->out_ep->desc = NULL;
+	f_rkusb->in_ep->desc = NULL;
 
 	if (f_rkusb->out_req) {
 		free(f_rkusb->out_req->buf);
@@ -247,13 +249,12 @@ static int rockusb_set_alt(struct usb_function *f, unsigned int interface,
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct f_rockusb *f_rkusb = func_to_rockusb(f);
-	const struct usb_endpoint_descriptor *d;
 
 	debug("%s: func: %s intf: %d alt: %d\n",
 	      __func__, f->name, interface, alt);
 
-	d = rkusb_ep_desc(gadget, &fs_ep_out, &hs_ep_out);
-	ret = usb_ep_enable(f_rkusb->out_ep, d);
+	f_rkusb->out_ep->desc = rkusb_ep_desc(gadget, &fs_ep_out, &hs_ep_out);
+	ret = usb_ep_enable(f_rkusb->out_ep);
 	if (ret) {
 		printf("failed to enable out ep\n");
 		return ret;
@@ -267,8 +268,8 @@ static int rockusb_set_alt(struct usb_function *f, unsigned int interface,
 	}
 	f_rkusb->out_req->complete = rx_handler_command;
 
-	d = rkusb_ep_desc(gadget, &fs_ep_in, &hs_ep_in);
-	ret = usb_ep_enable(f_rkusb->in_ep, d);
+	f_rkusb->in_ep->desc = rkusb_ep_desc(gadget, &fs_ep_in, &hs_ep_in);
+	ret = usb_ep_enable(f_rkusb->in_ep);
 	if (ret) {
 		printf("failed to enable in ep\n");
 		goto err;
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index cd2c282247ac..0bb386053258 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -625,12 +625,14 @@ static int sdp_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	debug("%s: intf: %d alt: %d\n", __func__, intf, alt);
 
 	if (gadget_is_dualspeed(gadget) && gadget->speed == USB_SPEED_HIGH) {
-		result = usb_ep_enable(sdp->in_ep, &in_hs_desc);
-		result |= usb_ep_enable(sdp->out_ep, &out_hs_desc);
+		sdp->in_ep->desc = &in_hs_desc;
+		sdp->out_ep->desc = &out_hs_desc;
 	} else {
-		result = usb_ep_enable(sdp->in_ep, &in_desc);
-		result |= usb_ep_enable(sdp->out_ep, &out_desc);
+		sdp->in_ep->desc = &in_hs_desc;
+		sdp->out_ep->desc = &out_hs_desc;
 	}
+	result = usb_ep_enable(sdp->in_ep);
+	result |= usb_ep_enable(sdp->out_ep);
 	if (result)
 		return result;
 
@@ -662,6 +664,8 @@ static void sdp_disable(struct usb_function *f)
 
 	usb_ep_disable(sdp->in_ep);
 	usb_ep_disable(sdp->out_ep);
+	sdp->in_ep->desc = NULL;
+	sdp->out_ep->desc = NULL;
 
 	if (sdp->in_req) {
 		free(sdp->in_req->buf);
diff --git a/drivers/usb/gadget/f_thor.c b/drivers/usb/gadget/f_thor.c
index 540b9f882378..210537d51e92 100644
--- a/drivers/usb/gadget/f_thor.c
+++ b/drivers/usb/gadget/f_thor.c
@@ -909,16 +909,15 @@ static int thor_eps_setup(struct usb_function *f)
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct thor_dev *dev = thor_func->dev;
-	struct usb_endpoint_descriptor *d;
 	struct usb_request *req;
 	struct usb_ep *ep;
 	int result;
 
 	ep = dev->in_ep;
-	d = ep_desc(gadget, &hs_in_desc, &fs_in_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_in_desc, &fs_in_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err;
 
@@ -933,10 +932,10 @@ static int thor_eps_setup(struct usb_function *f)
 	req->complete = thor_rx_tx_complete;
 	dev->in_req = req;
 	ep = dev->out_ep;
-	d = ep_desc(gadget, &hs_out_desc, &fs_out_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_out_desc, &fs_out_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err_free_in_req;
 
@@ -951,10 +950,10 @@ static int thor_eps_setup(struct usb_function *f)
 	dev->out_req = req;
 	/* ACM control EP */
 	ep = dev->int_ep;
-	d = ep_desc(gadget, &hs_int_desc, &fs_int_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_int_desc, &fs_int_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err;
 
-- 
2.53.0

