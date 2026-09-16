Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473B0C982C5
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D4B780EC8;
	Wed, 16 Sep 2026 13:08:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p8IGZR6GthK0; Wed, 16 Sep 2026 13:08:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 49D7580EC0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564135;
	b=WMpP9TyvzNPNzQCyRYCKwiV57Y7e7Spm+wb3kF6A4nEM/19wwIbMpuA7Vl16Xk2gMC3S
	 lACAUS3ZpUcmbKUBfrMBjIQlNIfiwRiXQG5u5DtmzyF0ikHon19Lz+Sqkb0uUlgbxMaiw
	 b4NggROij1dYK2Jo7c5os3Qxpc+kcTso4/C3fIKhY3EEFU+9EZM0AewFc76exyZf7Jnv7
	 8Q+BLQd76/B1N9VNaiD5i9QGe0SS6YlWkXLTvVR8PkLBg4DV6eQlbqacOm89lzgh9mzus
	 UYGrpV2xCQIyNtJrLhZp+vX8ap/9/rwiAJAxZP4iD9QY6Nx6jCl78jtfhrQ7oPzfqqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564135;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jW1pbjEEQkaQ0p678KvJ/NLJkIvqesFGhHQ/4zZSBZI=;
	b=SFtzAtWyKkjNIP83DuQV2k6GaFZjXaiyx7u1L74brHCBdzknXNGTsqcanxTpzdzC4P07
	 tAJ3g7NvyiDMVxinOJ+6fQh6eOCBPiep0yQKONsxWM4QhZmK69V2dn3gOH8MpVRFcexJx
	 AGDOgAAubgSFm2O9lI9P4kVN8KZS5wLYrFN3m9XtneJokwnowLmTuYRLBsaw4Bp+L/UKU
	 D4RxoO5TU321ShT6/zbCw//Ey5CKEPd3JPS2bVkMN4pTxumb/meX0eVxSEtK4Lhiov44J
	 n0aCYN+7gpi1UMQZwEhNT0+4Ok5x+K+X8D83MQexY9rjXLIA+Yabh1ehxb1rLQ/dVpg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kNARY0go;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564135;
	bh=jW1pbjEEQkaQ0p678KvJ/NLJkIvqesFGhHQ/4zZSBZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u7BZ+lsV6hfyeskDEviLiuOsg0Z9VVdD6uKi8Qhjgkiu3CvXcpeivekZaUS6izTo3
	 iHCr+EOmgR+936AOqpJUI8t9xyCyTsarEvpGy5f2O/CDQicyAXVur0SeedYWlulvXG
	 X/UL0pJ0gcEBBakq9pqZVq+x0sbI+v7zxRIsKPRXK8Sj3bb4XJ5DiLNZXJLBMYRCga
	 sbLFq9I7Y5K0iSNST3BLppJAN9GHhwqPYFueMdUmCb6qG4uzzmXfQMg6m8+/Gez24X
	 IXgvwbd4oTvkb4hARbkk0myPmmx+mCwhH6sJisG87kmt5SBzA3dT8akMOaEpcbRxFx
	 NzSGQvN9M7nDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49D7580EC0;
	Wed, 16 Sep 2026 13:08:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54FD724D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AE2380E42
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qvLz_9MBKYB9 for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:40:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 54EBC80E3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562426;
 b=Y1vtqGpmXKwSxWetZGky2bganW7FOKw6sLDbftCMxmX/4I99p6/mCmufBiufLGCL5OMy
 99eQsn2d7oEBnqGhUlJU4m0Xw5XWWASt65WoF/XtHvqGfaZXaQCE+hPCOxPr6dElRcKLk
 XqnT24SGN3kzmSGSl9kj1k86lmne2FD4g+BGK2wjLMLCuI7glwTnWJyEOYTL7oOS7JtCf
 40g7DDHU6jOsDlECijDAtDAgQd5VCbrq6ZJu6zuyZRR6kUzCaMpWUVs0WRogpt1gvYKGE
 uV3gFOy3TWG34EkZ6uIQDktoL/wrbVHeUOwot92NRgIzn6m6rV//UBWuLzN9wCThLcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562426;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=jW1pbjEEQkaQ0p678KvJ/NLJkIvqesFGhHQ/4zZSBZI=;
 b=b5uOQGv876on9tplsw5ZF4SoUG5Ti6Ojn6f8gvRDIxtoQ+taIqPcA8np8BxNCryA6bbl
 dk4QVPkDPiOTUTw7j+bme5uO86UB9LvbNEC0ED1cMNEZGulu66EN2Fa424P1xFrT5evQT
 MtOUlJ3k61kxtQrmgp4e+9MVgG44VVYyxEnUblHca0m/VXWCKFQ93dca20UvLapUAVNLc
 842/AbMA+mAvJk5fCzxGKUayxunHbT4uTFlRP8IgJk+8l8GS9DxdOwBM99Mu+JRlYCn+5
 aAvpDuxXx9fjvFsrfJJyKw22B6wxGQlBFOfhYN+y5+8RqYLQyDT6WVeSUeJjqmcmu9A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kNARY0go; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=kNARY0go
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54EBC80E3F
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:25 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2507a618e1so15791666b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562424; x=1790167224;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jW1pbjEEQkaQ0p678KvJ/NLJkIvqesFGhHQ/4zZSBZI=;
 b=kNARY0goOp7IM+o2J4ZwrZz7oiNYXJ6b5juGCwsGuFHdl94409ov3uPL6dER+Ewnqv
 F58dWJBG3J747DwbFDY/g66EZnpKiAviiiAIa7/JyHwufMGdDpzVk6p3h/gt8LeLehZ8
 qSMpQSU6lhHrrKfk/McekAwiseUhYuNeYmuk//DLNY1R1mJ0AaBjXJkESbUzzp3fF4kn
 7geFf0Kh12dnPjcdzJJNOqZbN1lmgH5Hm2FIwJvYZyDyZKWHzi0FRR1gEc4ZHgzku0wk
 nO4CcChEXL+HCc+2//Hzwe25LE3cFckyeNzDZiS7rLiAjH664OVG8iNISYIYaeoKJCeo
 7zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562424; x=1790167224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jW1pbjEEQkaQ0p678KvJ/NLJkIvqesFGhHQ/4zZSBZI=;
 b=POOrlB9Wijr4P3Z4EG/Fsqutz87aB6OR2aPvTmmbijl+IUpu9oznsQlvq0b6Xi5PTL
 D3iAqpZZWrNCif+C9k4XJeaQqU/blibJ6vYJj2B6ZzkSdqQdMeovcGCuqdJh/TiZ9QqD
 cXRJ7GmAKJFYXcOOmPqkbIX7WJtB8NivVRYrPAK43zxiO/kMXh/JuDUFArztqBadaRG3
 T71jecMoPdR7GD268Rhx4FTZTs5x4DoTQRh55MOgya0OPsgDSaUtyIa3VRCPNC1YWvRZ
 /PwRstpHXAMHbEHx2ITyG1zX5Y84fBIITZLmWJyb1KoM4aVB+trBNtk41B/FYg75VsTv
 VG4A==
X-Gm-Message-State: AFuF++mRadHoKdJd8WkPAq6n1WOvvs70nYnhB6uDPsBdcE2uOlP4Gs/Z
 FJRbeg3/rJJLaa7FKC2GGFHuTA2TV4Q3wFC3smSFfGJDAFCR+Z+PONEzwUpuLn+820qBEGydQ3U
 zaYGn
X-Gm-Gg: AYBFou3nr/oEvmJk8kvVLYJtdrUKJhwwnHqOx2G05DodHucOXAdB2ql3i1Ndr7vZLvK
 4F5VpcSb5YdqwSvNHZ/C9nDlUpn+LCnVwzXgPtXj+lBxx8BaNjE+MNQRzMHI4QDcEGdQSRl2v32
 weR4txl6+JcSUUkwZMBowVcguD9XOC9/TyO0vJCIO7Ibv9tEZrh2OcODxqAdGA1yz40IEdz7Z3R
 7De/TskWZIuis7DypR+KRYtf0g50FexUF6jJpOgjNMApDExR4Tstn+6OEuEF07gPz5q7MlDkjRX
 JciHy4aE5Ic2FZE/WPMhioi35qyDYepmKhjgRRRLXoSWn4QvxVjGCY0Zg5fXIWq9lkn6TNfv5eA
 fad/Am1eLvSyztOGfUgDHaq3K8429eT9VQ6Nc48oXQ7L+G68JG/e+QdWhpXDFo4PgJIjANVYMF4
 OB9iaNTtnfeQrE/hu/ovvrxbi/saBmdydnWaUape5TUeeShUyLnfAeSevEag7tLqmdFr53Ta8EG
 pciD7QtyOHDnqWHpc4Qzj6BKGBXHlVtfjjpHu10iY+9y0VIhRq7uRCx
X-Received: by 2002:a17:907:94d5:b0:c29:5172:c532 with SMTP id
 a640c23a62f3a-c29e544cf06mr186672366b.4.1789562423894; 
 Wed, 16 Sep 2026 05:40:23 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29e801cdfesm82430466b.58.2026.09.16.05.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:40:23 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 11/26] usb: dwc3: gadget: flush and invalidate cache around
 transfers
Date: Wed, 16 Sep 2026 14:38:11 +0200
Message-ID: <20260916123826.517181-12-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

Same problem as ep0, but for the normal endpoints. In U-Boot the trb
pool and the request buffers are plain cached memory, so the controller
and the CPU do not see the same data. The resync dropped the cache
maintenance U-Boot had here.

Without it the controller reads a stale trb and no data moves. DFU still
works because it goes over ep0, but ums does not. The device enumerates
and usb-storage binds, but no disk shows up and the host gives up after
20 seconds.

Flush the data buffer and the trb once the trb is set up. Invalidate the
trb before reading it back, and the request buffer before handing it to
the gadget driver.

Tested on BeagleBoard-X15 with ums.

Reported-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/gadget.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b3a371df3749..fd0ae9e3e092 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -228,6 +228,10 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	dwc3_gadget_del_and_unmap_request(dep, req, status);
 	req->status = DWC3_REQUEST_STATUS_COMPLETED;
 
+	if (req->request.dma && req->request.length)
+		dwc3_invalidate_cache((uintptr_t)req->request.dma,
+				      req->request.length);
+
 	spin_unlock(&dwc->lock);
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
 	spin_lock(&dwc->lock);
@@ -1385,6 +1389,9 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	wmb();
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_flush_cache((uintptr_t)dma, trb_length);
+	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
+
 	dwc3_ep_inc_enq(dep);
 }
 
@@ -3153,6 +3160,8 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 {
 	unsigned int		count;
 
+	dwc3_invalidate_cache((uintptr_t)trb, sizeof(*trb));
+
 	dwc3_ep_inc_deq(dep);
 
 	req->num_trbs--;
-- 
2.53.0

