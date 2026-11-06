Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04D606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZObid3um;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=xOasG4R7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2DA54093B;
	Fri,  6 Nov 2026 17:49:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKSYYaMXwNsR; Fri,  6 Nov 2026 17:49:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E47F040940
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793987346;
	b=QZ5/KEsaXZYNRSREt6dvv+ZSiyCexlqfK9bPTkE4bheLzTGl8cjeYUXjet36SDTccngb
	 xSByL94QexVVSwV7Vy2hazl8/mm4jQWo5ANgaysJ5yXCYYGU5X+WOXHWT34r/f3bvKZI4
	 IIPuGpuK4L7kQO2+2Yaj9pHs52eV4OaLrmSwwcdGWUQpVNVdMuGgOVj3Z006hAS2gMbuy
	 PpdtzW79Qf+5T9S+RZRe+JYsoWHmM8OVtu0EmAmVg0Hf5BinjphtVyxpB7jDMIMZlhVMQ
	 VOzxlcl1I2d3XRE9xBVteRFWZVPBqssts/zojyitbSo6lSnofCywIxtIHmdyrYg0OQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793987346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UU1v28J/IDSu43XmN2rySupdtH63MX5/ANn+fxB8Xg8=;
	b=IRdDYMvzWF/TK2aa3BdisyuKjrgPaeS1lJ2fPt7R8cJ08sl6dASWwLlEVl+8gggHYKl5
	 Q23CjFhWsz17U8tQpqjqhH3UdpTFMgZVXiPMImi9781hI9v6Z+0JY7RM57p9izdsZ97qH
	 R9et/LLYrHRIuRa8kofcv0znNQyjx6VOOblT5481s/WaS77bF5brGskC+KaI2B9GY/3De
	 ljAmUf1MzsDGnSOj3327nv3rqcSC+8RfK5xqyvPF6V63W7Wkmx6tJi+PHRVt+1s57kY9U
	 jZ3DMObe+U0d87pYdJa5WFX1X8wYvnTeWXxgAnwln//v34Sa1dTUsuf1+44KSvHNuUg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793987346;
	bh=UU1v28J/IDSu43XmN2rySupdtH63MX5/ANn+fxB8Xg8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZObid3umBvHIT/MUrZr4z3q+eOpMxKgl+Sxk/D/q+lD+JRJQFp00JJ410GmPrUtmF
	 y3XcG+5YofhSCwFXbaqoJkkaX1sDQ1Ck9wUtpW3PyND0xNnchDXypmDu2GoxmjpthJ
	 TG+s18txVD7WiDgbu9O+6BWQqRxaKT0fSLf8+QbRRz5fOWK5/uGSAhb/uR1X66tHda
	 AlaDWryWyjS2D+CeCE7O9fNBmpESd/FThnJ3N4o5fiK+I14IoOyPnsR05V3rVcicDu
	 kYB/7QK2cloV/+YZwu/0GBPKLfP/TyMhdIGgHFLBfy63WCkkVIGwiljO8ajBi0axxA
	 oHQ5tf2T2cTgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E47F040940;
	Fri,  6 Nov 2026 17:49:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EE052E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9BFDB403D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ylmfj2JHNbw for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:49:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 49D93401EC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=xOasG4R7
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49D93401EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:49:02 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so5959275e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1793987341; x=1794592141;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UU1v28J/IDSu43XmN2rySupdtH63MX5/ANn+fxB8Xg8=;
 b=xOasG4R7HdS4MibVRalnhy7HISAnClQ6W/DD9ZmP/tdQznnnuj1mmlG6zIDlz3v2FF
 jD7gM9BegQpsFNK0nYKzxhGRX/AaPfvk2Q5fd5tELBF4bGugYDVPusp5vbTs5kcddNZK
 Szm8lBDPw+utCcyFAxZ+HwXAZBDqhkDk+c5h2jbQH5AJPr3xfguwI46kob0+MzLuDqPC
 XKw7+qXuir3DVmC7vF2FWVgfFmjv5Vq9J/oB/4o7e0/VN4mnoLhqaAL4AefaAWReQMDT
 e0iphbb3W9BU3oQU0H6cNRlXECjk9IdRMMUPFDRlCLrEGEnbZ2VZYQWHS4lHqrVm19Dk
 htpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793987341; x=1794592141;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UU1v28J/IDSu43XmN2rySupdtH63MX5/ANn+fxB8Xg8=;
 b=UNYTxJWzz590ektHPjyZCcGjlMz3Zxa3m6Im0FTUuYkors/Hz8R8Lskhx+DomZJO8v
 OOHM3378H80PwYA3F7twgB+T2yGDosiFEXDaVizui2gwex2fOvffWUjbuMtXLXvP5FjN
 s1fkj0o8XwRm2DDz3qIqBodrgChfKDELM+5wS51n14V8J1V++KBdO4mzBlQ638/g75Kv
 CTQ94KFHQlTOPIxBW/YRAtARLIvI/SnNUxCDRfeukjnHz6xhUlvejGjuRktYW31ONsDc
 MavHlLWbZ1Ney4s4iaCIKnyKx6VZ4yc1SwmByRiK0wi98/TmFNUW93amaYUtrY3I9mxw
 6Kgg==
X-Gm-Message-State: APuU4Z8fpVWf6ZZzX9Lf8EZls5OzWDyaVuDqgtVRJ5V3UxmZjXQRmfWh
 TvG9NKTvALYZhbD1O/AZuLSVVi5PVr5R4H4NlfXdevyJUXWgvlF0Zg81n9yPwRGKaOljES4Qe6q
 nxVLJUTOWdg==
X-Gm-Gg: AYBFou0yGE0cr03DtPzi0SS+NcSexlc993At+UBt4kt2E646AFEE/6M8xuxiRdKaGq2
 x2qy6W/EXCR3Yz0OM8VymKLRVn+PdGtJOJl2aIfH1HuDjmhOuxz2ZIMae83jfJtpWReo8om2qAR
 5eYKOOXF/uUzlz5KhGXe9p0/W92w/VErYF5w8BJQbb0pFhvd0LV/eQjlaKBLK1lbUyBjYYnCjSE
 iseZNzeboW4+Y14kX7ycqKkcjokGOTrhIunYSt/VpEEaxy7tJiBx3ukoYMHWN4E5dkmJu7NjbNN
 nkKA8mrJj6sWm+7AtDfs4qJD96X8ieKTkfH0thdl1v2j8lGJGbq49HaE64kB+e9Rze0CND688Nl
 gj/L2wAix8vrZRaXfnj/SbgvnWPkH+kHSzA5fwpQu2WfGi1NoqtV1g1a251AWI1XvP6Xmz4WUEw
 X2If8VEKM6dBh+slSOo3XeWlvWeOC31vt451yMFNKJjuyYf9EeiOSnnp5NKjBk/ToAhuVZBsLc6
 5G4AEXsbrVPoSIHYLv3VoW7v56t4k66LMVasDEa0GZqYSoBwGYAbBMzr2cdN6uQUSAySTrf4YMI
 J8dUaNLfh8jpJgz6DDoV1rapBGmxJJmlnlNuJKP+BEjOe1kZYVZsG16fUJdOUdIIQrxPa7oMWWV
 jDZYQOLhDpw==
X-Received: by 2002:a05:600c:3ba0:b0:4a7:a5db:a93e with SMTP id
 5b1f17b1804b1-4b6db1c5f48mr64344855e9.4.1793987340936; 
 Fri, 06 Nov 2026 09:49:00 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b5725061e1sm169119935e9.7.2026.11.06.09.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:49:00 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 06 Nov 2026 21:48:45 +0400
Subject: [PATCH] usb: gadget: f_mass_storage: add SuperSpeed descriptors
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ums-ss-v1-1-ad215bcdb735@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMz3dLcYt3iYl0jSwuDRGND01RDYyMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0Acyonf2oAAAA=
X-Change-ID: 20261106-ums-ss-2980a315e132
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7038; i=alchark@flipper.net;
 h=from:subject:message-id; bh=fuFl+qvJLUPO5ysYcaa9l7aPkwMohP39KpZoQuIskE4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWS9E+balt7UVOBlsZ/vR9DxV5/my1wR/Ljqi0Vs+wdr3
 QuL5k5N6JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqveQY/orkrss/N083S/9GfE32CZ+eZaxzt36QzFRc4Kz5/pWjuCjD/5xU+8X
 lySyHDvQa/2u5dnlugCRj9pO/Gr4y01r+tgQeZwUA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The mass storage function only provides full and high speed
descriptors, so a SuperSpeed-capable UDC that comes up at SuperSpeed
reports a device descriptor with no configurations: count_configs()
skips every configuration without SuperSpeed support. The host then
gives up with "no configurations" and keeps power-cycling the port,
which makes `ums` unusable on such controllers unless their DT caps
maximum-speed at high-speed.

Backport the SuperSpeed descriptors from the Linux mass storage
function, adapted to the U-Boot copy, so that `ums` enumerates and
runs at SuperSpeed. Leave out the BOS and device capability
descriptors that came with it, as nothing references them.

U-Boot has no config_ep_by_speed(), so set the bulk endpoints'
companion descriptor and maxburst by hand before enabling them.
Otherwise the UDC sees a maxburst of 0, which DWC3 turns into an
underflowed burst size instead of the bMaxBurst the host was given.

Based on Linux commit 4bb99b7c82ba ("usb: gadget: storage: add
superspeed support").

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
CI for this patch: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1872
---
 drivers/usb/gadget/f_mass_storage.c | 40 ++++++++++++++++++-
 drivers/usb/gadget/storage_common.c | 77 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 20c094b0d96f..7cc5998cec7c 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2219,16 +2219,29 @@ reset:
 	common->fsg = new_fsg;
 	fsg = common->fsg;
 
+	/*
+	 * The UDC programs the SuperSpeed burst from the endpoint, so
+	 * hand it the companion descriptors before enabling.
+	 */
+	if (common->gadget->speed >= USB_SPEED_SUPER) {
+		fsg->bulk_in->comp_desc = &fsg_ss_bulk_in_comp_desc;
+		fsg->bulk_in->maxburst = fsg_ss_bulk_in_comp_desc.bMaxBurst + 1;
+		fsg->bulk_out->comp_desc = &fsg_ss_bulk_out_comp_desc;
+		fsg->bulk_out->maxburst = fsg_ss_bulk_out_comp_desc.bMaxBurst + 1;
+	}
+
 	/* Enable the endpoints */
 	d = fsg_ep_desc(common->gadget,
-			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc);
+			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc,
+			&fsg_ss_bulk_in_desc);
 	rc = enable_endpoint(common, fsg->bulk_in, d);
 	if (rc)
 		goto reset;
 	fsg->bulk_in_enabled = 1;
 
 	d = fsg_ep_desc(common->gadget,
-			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc);
+			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc,
+			&fsg_ss_bulk_out_desc);
 	rc = enable_endpoint(common, fsg->bulk_out, d);
 	if (rc)
 		goto reset;
@@ -2649,6 +2662,7 @@ static void fsg_unbind(struct usb_configuration *c, struct usb_function *f)
 	fsg_common_release(fsg->common);
 	free(fsg->function.descriptors);
 	free(fsg->function.hs_descriptors);
+	free(fsg->function.ss_descriptors);
 	kfree(fsg);
 }
 
@@ -2704,6 +2718,28 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
 			return -ENOMEM;
 		}
 	}
+
+	if (gadget_is_superspeed(gadget)) {
+		unsigned int max_burst;
+
+		/* Calculate bMaxBurst, we know packet size is 1024 */
+		max_burst = min_t(unsigned int, FSG_BUFLEN / 1024, 15);
+
+		fsg_ss_bulk_in_desc.bEndpointAddress =
+			fsg_fs_bulk_in_desc.bEndpointAddress;
+		fsg_ss_bulk_in_comp_desc.bMaxBurst = max_burst;
+
+		fsg_ss_bulk_out_desc.bEndpointAddress =
+			fsg_fs_bulk_out_desc.bEndpointAddress;
+		fsg_ss_bulk_out_comp_desc.bMaxBurst = max_burst;
+
+		f->ss_descriptors = usb_copy_descriptors(fsg_ss_function);
+		if (unlikely(!f->ss_descriptors)) {
+			free(f->hs_descriptors);
+			free(f->descriptors);
+			return -ENOMEM;
+		}
+	}
 	return 0;
 
 autoconf_fail:
diff --git a/drivers/usb/gadget/storage_common.c b/drivers/usb/gadget/storage_common.c
index 7e4b542f7ce5..a89c7ea3e532 100644
--- a/drivers/usb/gadget/storage_common.c
+++ b/drivers/usb/gadget/storage_common.c
@@ -531,11 +531,86 @@ static struct usb_descriptor_header *fsg_hs_function[] = {
 	NULL,
 };
 
+static struct usb_endpoint_descriptor
+fsg_ss_bulk_in_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+
+	/* bEndpointAddress copied from fs_bulk_in_desc during fsg_bind() */
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =	cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor fsg_ss_bulk_in_comp_desc = {
+	.bLength =		sizeof(fsg_ss_bulk_in_comp_desc),
+	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
+
+	/*.bMaxBurst =		DYNAMIC, */
+};
+
+static struct usb_endpoint_descriptor
+fsg_ss_bulk_out_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+
+	/* bEndpointAddress copied from fs_bulk_out_desc during fsg_bind() */
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =	cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor fsg_ss_bulk_out_comp_desc = {
+	.bLength =		sizeof(fsg_ss_bulk_out_comp_desc),
+	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
+
+	/*.bMaxBurst =		DYNAMIC, */
+};
+
+#ifndef FSG_NO_INTR_EP
+
+static struct usb_endpoint_descriptor
+fsg_ss_intr_in_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+
+	/* bEndpointAddress copied from fs_intr_in_desc during fsg_bind() */
+	.bmAttributes =		USB_ENDPOINT_XFER_INT,
+	.wMaxPacketSize =	cpu_to_le16(2),
+	.bInterval =		9,	/* 2**(9-1) = 256 uframes -> 32 ms */
+};
+
+static struct usb_ss_ep_comp_descriptor fsg_ss_intr_in_comp_desc = {
+	.bLength =		sizeof(fsg_ss_intr_in_comp_desc),
+	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
+
+	.wBytesPerInterval =	cpu_to_le16(2),
+};
+
+#endif
+
+static struct usb_descriptor_header *fsg_ss_function[] = {
+#ifndef FSG_NO_OTG
+	(struct usb_descriptor_header *) &fsg_otg_desc,
+#endif
+	(struct usb_descriptor_header *) &fsg_intf_desc,
+	(struct usb_descriptor_header *) &fsg_ss_bulk_in_desc,
+	(struct usb_descriptor_header *) &fsg_ss_bulk_in_comp_desc,
+	(struct usb_descriptor_header *) &fsg_ss_bulk_out_desc,
+	(struct usb_descriptor_header *) &fsg_ss_bulk_out_comp_desc,
+#ifndef FSG_NO_INTR_EP
+	(struct usb_descriptor_header *) &fsg_ss_intr_in_desc,
+	(struct usb_descriptor_header *) &fsg_ss_intr_in_comp_desc,
+#endif
+	NULL,
+};
+
 /* Maxpacket and other transfer characteristics vary by speed. */
 static struct usb_endpoint_descriptor *
 fsg_ep_desc(struct usb_gadget *g, struct usb_endpoint_descriptor *fs,
-		struct usb_endpoint_descriptor *hs)
+		struct usb_endpoint_descriptor *hs,
+		struct usb_endpoint_descriptor *ss)
 {
+	if (gadget_is_superspeed(g) && g->speed >= USB_SPEED_SUPER)
+		return ss;
 	if (gadget_is_dualspeed(g) && g->speed == USB_SPEED_HIGH)
 		return hs;
 	return fs;

---
base-commit: 709a97a05df66e394f40d249105d0baade46f107
change-id: 20261106-ums-ss-2980a315e132

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

