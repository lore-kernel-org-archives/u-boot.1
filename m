Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF34606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xl1VXcav;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aoICYbf0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C6D381148;
	Wed, 28 Oct 2026 14:49:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q8k0LH-kY0GQ; Wed, 28 Oct 2026 14:49:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C36C9812A1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198902;
	b=iBsJhNH/Qw8pF4HbRU0fbuAvjhnaG9uHqSto0MDYpygrJURZcSgZWuJ1xC+0kNtr/AIm
	 MC2NA1OAsEimyiGTrPC+pFPg6KUtFuMi5YFfC5bHNPjuhRzLGpXyBpEyZDxHGA0fIMKpF
	 WWPM+wceatJzKWZYagzU/3fTd8TDF0G96aeThnEQbYhz8IWM7TvX6cYMmICfjFFaRWQWe
	 DsdNNmj4iQW7zzxbE4e7woEIk1obd9h778EZfYwVKDvCY+iz6MFPL9F5jVM5HSeL9OXzX
	 blARq+WQhK1aEEgrpJvN5mkyzLk6frq0BjXceBTx4Ofivr6W2n5WqH4Gu4POWcvcsLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198902;
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
	b=S1S9OEt9F5ALGVoOhaRr/7Ic5nqjBOkzxFQbRycDoz3fpQlNjjahLPFWgrMSxsJl6EVN
	 qY2cxs8C09F9CbhZzAtYg2mZVEK1vzMuXIicxcWKEjRHb19doqpAHu5WpT6q5byyXGynv
	 Glvv02Uj+LAbehd2Sa3Lm3jVT54wBnsO2YqgE+3YppQfAnyEtq24nQjbvQjhPghq+L4Ha
	 H/y8cRqWkgzTCbfCllPiYubCOLvoKCgVoUgczN5bjQpjD1KEnq0aINP7E+EfR+qFtVqoS
	 a4hDH6E2oJ0aqcVyIarHCEMGDRCcvnXy+8R73NSfw5zW4QNZupcSt4gFk95tL0np0AA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198902;
	bh=jW1pbjEEQkaQ0p678KvJ/NLJkIvqesFGhHQ/4zZSBZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xl1VXcav1MZSdO7yWoTOsKhf7yyc7mq3YTlXFt6l88SVk3unped5TBW28DDeOrYfp
	 6Ya91abImtGqKMe0y37rfIpX/WpNK/sTfkrGzgbH96fsOyXWaZvYGY8bAwPv8IOppd
	 XgTJ3xRuolletcufoOTyqfSvhvTm8vH20hrAGRM2dZGtgpj6NtOgumnJhwoxoDtg6v
	 f+Bi76aWS8con0MHxxbKk2OikRrSIJvhrTLnHKA1/idn8xHFPoY/fYb5ycX/2b5fqb
	 pXTCg/pb4KQp+hle9lW2FhniRHWZTjS5qxZAn2vJvk6TaPQ7ASj8ArGMZw8PApS45n
	 Ym1rRSYLB309w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C36C9812A1;
	Wed, 28 Oct 2026 14:48:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 568B6235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D2AF40557
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oy9DXf3y6OqM for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61B8840550
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197017;
 b=YEon0XxxDKw2GI5biCpwEzsPH+/X6Ep0Gbwft5u9gs0SnZp55V4kdSWd3Qc1CbkudAy2
 K4+6wHAYkVEEHjOsQ3r4eyHrT0K8H9EFxfcG8gvfPLlXb3gwdrw7xIQ95nbitiQmEP7DD
 R5w/JaA7WU6QxTjPMjW3zZPObgM8DV9ixzgvGIF9F8JqKJuQ1Trq122aR5Hc2KR6b38zE
 +0G2LKgm1XsE+eU5th3OGtTsUNNjZqNpjp0OCGoKyMLbnxzm/iD/QSiimrhHaSFstsV53
 JHoPJDTWeW6T/l3Yy4ONW/ImLGOVAFE+jjveR4n6962Qz5Ias+/UDaDu+pVxtB4kgkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197017;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=jW1pbjEEQkaQ0p678KvJ/NLJkIvqesFGhHQ/4zZSBZI=;
 b=RPUI0DEPl14R98KE+YQL7/lEWiFhU2XxRkKtTw9U/0My0gS4uDXFogHw4rxQTkTof0Qy
 tPSfcVr63qr+uxsgvpfAMcKHZRt2F2XK6n+2Rh63C9p+/GWp64vmNezkZMSB3HPaJQNgl
 VmolX1nr/OYHYbcPDy9xv95xKXEAwPGLFr1/LSmz639BF7J1y1n+cEpNWiBdgykC0RYrf
 h3U0iGCxFaEKcetrA7xQbXEXd5X+GR4Ks6CgCxtZXT2/QiorTJ0pXv2RoBYD9nmnkRecL
 +Imr+qnlKsmPXacG+pwovY+RVqtHrVTHKz2hfVGQOONaKbUf6ciizUyqa9WZHg7ZYCA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=aoICYbf0; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=aoICYbf0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61B8840550
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:56 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c3fae9338f0so10664266b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197015; x=1793801815;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jW1pbjEEQkaQ0p678KvJ/NLJkIvqesFGhHQ/4zZSBZI=;
 b=aoICYbf0CJWCKqyu7ZTxrxAU13U6xK5sioptBmnZ3myN1YOup1Rw0uS6jDa/UdVn7u
 0+cozjcFuSDgup5Wpj5RFeKUfGqDxkrIX6q/A5BvsvmHOkybbYToDhlzxDBOJhWZnnX+
 Ddw296RTE1e7v+Z5NtfUt/GUjORM/s/VXNo4XNiEfPQKb5zfvFOTE76k6heuzYs3FLaE
 wrzMg/0sTh38MdF0Sfr2AFxE4Ew7q3jkTi3kbZ3Uyqe/eF+uapxN4VkP09STeHJJJp6s
 Ofb0wREEC949G8V1maGygfdIs+q6wyrx2eMQPvsqu1VIGe5+2wlGBMBtwQKvSJN/VuPq
 ub0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197015; x=1793801815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jW1pbjEEQkaQ0p678KvJ/NLJkIvqesFGhHQ/4zZSBZI=;
 b=kVKucPliTR31Tnu39pkbunW1jwmqI8D+/2hMwG35FHJRns19ZmJGKNROu8ni9vGNpz
 +iGy/l0Yn4l/ZXrWVRVu+yP8IN7cmW/gI3gxhq0OHN2wqGbb2+eIjSl8lnzW6OYFWkE1
 qm/0HbBsg2COOxs7DqyHXoWKu+2XLWhCzDdj+SrmQXf28MCzqsJrkVvfOCKfjby5CRfZ
 Dwilyrnc8h5XPZetDIeQPFLa9ARHDGrOMCam3GUxv0foil9dFUndXiMy3VUM1/M9vI9B
 LXni9mnBcQRcAtxIv8dW69Lgpl9arHqQQkYDWLGtlFEC3modqKxKMWsEGtQlp9RwQuDI
 ukCw==
X-Gm-Message-State: AFq9FYLisHNAA4S0o91oIyXpOo1uuFXfabNYGtj2M/rH8aeqzEqgx0cZ
 WFNiqXQJhij3zOUmuOoM2JUV0VRLZavzVL1al/i+5Mw2SnHKPEr0N3+D1oDjy3+cTLEpLbwASTl
 uNZ1E
X-Gm-Gg: AYBFou1S8doM6fr0xdYcIl3taZYlgzFFW4jj/tCYsZsAlMKASpOiemv/pMGnCzhAFrl
 IChVaa2FRJDJYCnX15bQdUvZVpUtYNU1Ldsk2WsRYecKxhjh/b6edBAwW6Gzc8auIfo7uaUB4NV
 02ao3WdWuPS6MHhcPNOyTPyH2k3GAbpcFoADEha8Q248Z6nbzCjTDgaUEbeG6CDtVySG1zmqWQV
 p07Im8H7Ppo6Y7g4URAGnPXQie0mvJ+2I/DvjHYMEGuscE3i/gtCMKiYXHbkHSVaXm3/PShRhgy
 RcyQO+IVjg868yOadtTAwBUlOHnSbge5wruSkdnMPbIF5daAt5axMwJOXXIeBw/AGF57n2lq8Do
 QPuZno49wVRH5V3jJD+/fu53OpT2dQlGEi78bXm88sB4n1mJICPf5aLjvPtOVql5HQdJapydcd/
 Snek6yxObvD+o7gtc6mBDQA/l7oGKMWeCT4RB2eOGMtEWljNJ9Vgoav28ssbAD0zMP1m1ihw3aG
 KoZy5yIzBdE8PQrrHoC06fBzs9tyiJ7AAUob5l0PY19iVnXWpW6Hj32UcsLZAVZRsDNevia2nA1
 R8hsI+2Vcmu3VRt2jtios4nyXrmCyOsLX92Y37w+5dvT25uD+34PHz1M1V1fsxVZCG+LpeNBnpi
 CyzMoOvUw
X-Received: by 2002:a17:906:5192:10b0:c40:5ee3:8694 with SMTP id
 a640c23a62f3a-c49bdee7e16mr263663666b.4.1793197014982; 
 Wed, 28 Oct 2026 07:16:54 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630412866b.38.2026.10.28.07.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:54 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 14/30] usb: dwc3: gadget: flush and invalidate cache
 around transfers
Date: Wed, 28 Oct 2026 15:15:38 +0100
Message-ID: <20261028141554.3073545-15-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

