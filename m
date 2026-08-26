Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D936C61DBE
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28B0F80B63;
	Wed, 26 Aug 2026 13:02:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RoY04IwaX3hW; Wed, 26 Aug 2026 13:02:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749322;
	bh=V+OFw/Yu1PIDo5BCt38pl1Qr1iKP8w0cAJF3AtcLt+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CPdRSRp1X1kqBgg+lT+kZIPF60JbYMadVAZxdKEO5Z1t09M23QOsJjCyNXXqQHqR2
	 O6SmqTzhq2gUPqQbbYBuPXZxzNf2fCPLepdvXrKusgLRgbvP0hFoNV6IHTfygOCFPq
	 s86tvkbrnUnfNmaxTRJbLRK8PTmKTZbLkKFZ08bXZw9hMra5m94We5OYaxG+4BcL2T
	 7Lhd0HHy14oe+7GUNNkhtkEDaXWWT6KaEVoy+b1PEDfXxbUTpoZkaDj37MuuCZCjEf
	 IoS7hZzqGZ+s1w6KEOU+Kd80vEN6TDYPWovtKMO6OoNKGw4V/jk9FRL+Wta+Ieit7N
	 ZwcYt0V7kBcnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6307580C2D;
	Wed, 26 Aug 2026 13:02:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C60339E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41FAA4055E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZYxh6UXduQ7w for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 08:29:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PXfenZXx
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDB4640556
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:29:57 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c1f1f5631f8so5805966b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787732995; x=1788337795;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V+OFw/Yu1PIDo5BCt38pl1Qr1iKP8w0cAJF3AtcLt+c=;
 b=PXfenZXxRuo9B5yHro4UPZYNhWXa2BoCmQOfYIlByCoKYdvnCA1Dm1+Ij4i+BF4v8j
 WOIoIszaJk0tbvDK3fXFns/78+NOCZwP8RUnl9dC2CIBCmPSa4o268k79gaske5anVTe
 DpkZ40P8FAjyszRfFX8qFkNyHinT/vmb0lgVah1u+6AfcPU0/VI18FcRy37DfXvpJPBx
 L4sUMPfbNFB7oHp7mch+FwB8ejupZMv6wGbQkyggYtyBRgfyZ4uK48crYxhV9F3z3je2
 Jv3d42e4QaHy6jBWrdesXPfh5eaJ3c9+qdzA2ZPOFiuzG4Ka3B6cf7MbDQaGSaJ7pyY9
 sVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787732995; x=1788337795;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V+OFw/Yu1PIDo5BCt38pl1Qr1iKP8w0cAJF3AtcLt+c=;
 b=W2gNPgnb8ukORV6Bp3/p6MVqKYbSSrguU+7TMZJzatLxzIYfxM7BD1NC7u0kYgQoGn
 LNlv0nsTP6cjAOtHDc3d6AftTUa8G3xT52B0zPwrFiepB924G6s7uRKTyV9OetVaoiHU
 7IZZBLwwZj/OtTLfMWwy+fZb4cm40V20QoYu5yWuIAw/lkQ1LlaUhrtITatN1KYHp5tK
 3TTFEyKEZh/xQZBk42ShC4ZeFiGOit2/F6/7E8y7ev1059ucfQCDU9Zor2Ycymz04osj
 QDcddy0nps/R9iOh4J6KfvzNmjEpqzIGCumi+8QeRhfFnanve3bwEUPQ7pe4RkGsERf5
 eRDg==
X-Gm-Message-State: AFuF++kO2lqvE4S+NjQeQBxymWdZMp/I+/ywOTme5mMHjECj8PcH3aYF
 PrCIYZp38+W06Z4vP7PP59lhBquK/x4le0+/vD5XsPQukyi058dTcc09pvzkhP8bRSnXjK4ekmD
 m4/k9
X-Gm-Gg: AR+sD1042RS6ig7QcF5nnjRQOskpasU4kxE3c9n/rrD9QntwPcrU4s1OZaFiQddaZN4
 DK4X9m7HP+DtXlwNtjXHFMToXFIb4Zf7sV90GYG+JH0o1da1VLyvf0qpizy0IGnFxbiAH13yxHM
 JNSDIoyImWw/EQX8UirWayF3kT0c42sIlLfPWByBlW4wk+3HAjL85KDXQvbmb0cFREW2ftUJ3JT
 Fy7wQm3/Ma40kJV7T+qd3iem3yjS4kcbgOeg/GqD+uruFfz+FSWIOjjjWcbFxAu6xltsRMzZSyN
 yRyufPiQK/G80iV9Zzth3LB/O7+S7QI3gdzUNl5qs0ic1m6Ir460r1zLhgJD1sGQUtAOHTerovX
 sWh0y9n+s5+8WmjTN/y8eei3MHIngAm0vd/TKiZXRCI0ewTIoVyji/ed+a/Ho1McjNKUkIefSoN
 pIImuNUGDKN0FU6d9mMGMXMrotv1wx74y3GTkKF5ROjYTWKrE0m3r+S2EQjOJhlViJJ4QsFKnN2
 dcSpSYl/MBMoejwZta9rA==
X-Received: by 2002:a17:907:805:b0:c21:8555:5f55 with SMTP id
 a640c23a62f3a-c250c31f497mr313826566b.2.1787732995168; 
 Wed, 26 Aug 2026 01:29:55 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88af72sm443921466b.36.2026.08.26.01.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 01:29:54 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:29:52 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.u-boot-project.org, marek.vasut@mailbox.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, sjg@chromium.org,
 Chintan Vankar <c-vankar@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v7 00/24] usb: dwc3: part 2, make the resynced code work
Message-ID: <ao6kAOgauISZ1-dx@monster>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
 <178765097973.1498018.5668901885485543636.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178765097973.1498018.5668901885485543636.b4-review@b4>
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:01:55 +0000
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

On 2026-08-25 15:12, Anshul Dalal wrote:
> On Mon, 24 Aug 2026 17:41:09 +0200, Anders Roxell <anders.roxell@linaro.org> wrote:
> > [...]
> > dwc2 with and without DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc,
> > musb-new and mtu3. 17 boards in total.
> > 
> > DFU is tested on hardware on BeagleBoard-X15, and on BeaglePlay by
> > Anshul. ci_udc is tested on an i.MX93 board with ums. The rest is build
> > tested only.
> 
> Hi Anders,
> 
> Thanks for reworking the series, I was able to get DFU boot to work properly
> and the usb devices are being discovered properly too.
> 
> Though I ran into an issue while using ums with your patches as the host isn't
> able to detect the connected device. With default logs I only see a
> '\dwc3-generic-peripheral usb@31000000: unknown endpoint event 0'.
> 
> Further debug logs are below on TI's AM62p EVM:
> 
> @    => ums mmc 1
> @    UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x3b72400
> @    g_dnl_register: g_dnl_driver.name = usb_dnl_ums
> @    g_dnl_bind: gadget: 0x00000000fde7fb68 cdev: 0x00000000fde5cdd0
> @    usb_add_config: adding config #1 'usb_dnload'/00000000fde83cc0
> @    g_dnl_do_config: configuration: 0x00000000fde83cc0 composite dev: 0x00000000fde5cdd0
> @    adding 'Mass Storage Function'/00000000fde5c110 to config 'usb_dnload'/00000000fde83cc0
> @    cfg 1/00000000fde83cc0 speeds: high full
> @    usb_add_config: interface 0 = Mass Storage Function/00000000fde5c110
> @    g_dnl_bind: calling usb_gadget_connect for controller 'dwc3-gadget'
> @    usb_dnl_ums: ready
> @    -dwc3-generic-peripheral usb@31000000: unknown endpoint event 0
> @    |set_config: high speed config #1: usb_dnload
> @    \non-core control reqa1.fe v0000 i0000 l1
> 
> I observed a similar issue on the beagleplay too. Regards!

Hi Anshul,

I could reproduce it on my BeagleBoard-X15. First I only saw it connect
and got happy, so I forgot to look for the disk. It never shows up, and
the host gives up after 20 seconds.

The resync dropped the cache maintenance in dwc3 gadget.c. The
controller reads a stale trb and nothing moves, that is your "unknown
endpoint event 0". DFU still worked because it only uses ep0.

With the diff below the disk shows up and 64 MiB reads back correctly.
It applies on v7.

Can you try ums on AM62p and BeaglePlay? Please let me know how it goes
before I send the next version.


Cheers,
Anders

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 028ebd9b9c79..fd0ae9e3e092 100644
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
@@ -1382,9 +1386,12 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	 * controller to observe the HWO bit set prematurely.
 	 * Add a write memory barrier to prevent CPU re-ordering.
 	 */
-	// FIXME wmb();
+	wmb();
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
@@ -4181,7 +4190,7 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	 * Add an explicit write memory barrier to make sure that the update of
 	 * clearing DWC3_EVENT_PENDING is observed in dwc3_check_event_buf()
 	 */
-	// FIXME wmb();
+	wmb();
 
 	if (dwc->imod_interval) {
 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
