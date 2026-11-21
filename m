Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9B606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zv/bCPSb;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=EnD6/dGI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 550DB40E01;
	Sat, 21 Nov 2026 12:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7NrY4b0tkWT2; Sat, 21 Nov 2026 12:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A315440D7D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264529;
	b=F31b0PD7eTIK57Dxyyc4sA9TkFODmTqrLRh9uJquwYpk+7ZIl3btHS4uasNTELx3Q4aK
	 sZjyp8xi18OndodeLRXZgu8lerP1c/HdogRtBaPUdC6mTExddfbcuH1N79Sld0N/OOWrk
	 UkutYV9Dx1vxr4da186J9jMCwgPdg/UFLtz5VTD+qDc/l802CDfR7J3w03QRKaSsVSa7E
	 ZSROl/pCgGQNrOSDU9tZo9QOL/q8Ce0YpZpYNTBVqYZTepyTa0g5GzQjp8a1c+CRyV9tV
	 +bAfER577bZnGZpvCoITwcrGxilRGaGma0RJa6v78TJgfBjDFXkkJFVe0H4d2B0MvWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wR9k5LXAW3WgvphEwuUyr1K+Mr2Emkj3HV9kkuYPGFM=;
	b=VAsuBKur95k0NebvN4MFBOr09RRNHtl5x9MsgXHpRdH80/7a5m4+r96e3IuSuTwF0/37
	 pYVPBihh7HWhPONdMOrTYEmD3JSjlHsvuAuH/+oL4oiRdV6OdvLPHZKq2i06qaEjARDwp
	 WlCjhsp/nHX9Zkke7L4brV6eaGtwmkuI8v9iBadMLQG9GtjVFG8/npMRQsaDT8omcd+VP
	 Mh1ZncnbWHYHwl41bc4zhQLay3PUxD/zjgGLf/srAR931QznOongbkc6TwnWp4K1nX66n
	 q1x1DP9MGI/A3DTLeq6cD12SLYCAJImFsp8cNG4tMGFqo4zh2YAXX3kOk2ecHFq9TWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264528;
	bh=wR9k5LXAW3WgvphEwuUyr1K+Mr2Emkj3HV9kkuYPGFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zv/bCPSbxMcFWiHpHKqmf8ONZVo+KY7+D0sevuqif3S5rK6FhCODG07jkEu1chHEh
	 FohaS1jchYMx4Q2zSMdksBFPVoIuUvwl07DB+REQLNl4dpreJEs6Q1J67IIee3ELcd
	 MAEr5B14Ux9HpmVyMWYXSnHOnP3sITZRH14tnGdsI4Mumz9uoso47eN+cVYRXyjbOX
	 XoQ8gTL/5rOR+0dLOWmoaT+1Fj5arg0ZOilznFYVdJ8nRQIeieXApFCpiQn0e1xdnG
	 9igOrL0rrdyqSZQogir6S703SN1Yo7Q5/i+DdtnbMXQUL0h5EKuTbMm2S6Nv5eYJ0j
	 hW1TOkN7hF8EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A315440D7D;
	Sat, 21 Nov 2026 12:35:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22E4D759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 126076065A
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0QT97efYVmbW for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 21468606EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=EnD6/dGI
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21468606EA
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:22 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso12759815e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264521; x=1795869321;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wR9k5LXAW3WgvphEwuUyr1K+Mr2Emkj3HV9kkuYPGFM=;
 b=EnD6/dGIBdUtwRHi6QyiydTxnqnFOOdRUoQk6Cwa7jXxJF/cAzBvwAqHOVKS+PuGq/
 uFvY+rKWFQWH7uiq/gVt4eALbGPIz07tSVZlG7DnKEiIaMNLH1G95vu1BvRU8CVMQJ25
 Y3pegOnlho2x8HyrVUMMzCOFR/qzSfwMk3WYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264521; x=1795869321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wR9k5LXAW3WgvphEwuUyr1K+Mr2Emkj3HV9kkuYPGFM=;
 b=JS+o5t9aVADXx4305p7lYf87sltiaQrmN3+oVJDdySPx6zwA9nHF89Mjd6yeRqXDQT
 mKu3Mc0agXBmJOEGWAc47dZ6JKr0161yscZVe2OrU41wXV0MbGNFUJHwKuqVYPjQYxRD
 PfSQYZoQbr0Zm/EhHT6EKMXy++yX5vqGmBWkp8eTG/SMA+udLhEKZIR7s5OdefdS9Dk3
 pJHKU7VUqYLogHpAIc4v9wltAtZwGfQf/1P++KudpyZpvnIxnF/0v4bMDQwZsglo624S
 63MtWHqgRhas5XOT/Nd6FBBuO62I06uPB2RFyVBlKisTKpbvqqcw8whl5CuHGMeRNrdj
 B51Q==
X-Gm-Message-State: APuU4Z9SoJCJirCVvOSBGH0q6EUTN81hArvIVVYOhIGcSgbTeYgWC98A
 ivvy4DmBWUBpKg2GQqbbTa+h1SzNGoZpeeLLJHNG14DDoW8V9ABlHXgnYjlaj79f8WFoCPrZKdR
 X1DWy
X-Gm-Gg: AZFdTZfWPDEGuPuld0td2TtDfAkkt3Obip9LUIZIZG0abgA25NEsAjvszjsENZRqEwq
 mKN2W4drp+s+wMMEwAj6y2geeBlxroHHuxW5SidccAUBqeWJJS1ea757Q5OSu9cpsvlv7ZWiKbr
 xj3GCyYS+LKik/f8Wdent+y1h3PDDWsZJzGpedPBCJzOcoaGJKqMO3DPuLiCpfRFoALK2gcfwgI
 26Fh+ujUA1yQs3G4mT95fHyQGwi1z7IGA2ghLMdLERJzZ0VEaF4FbICcMpTipAxKKye4kDnRDMW
 r3IrDx5XxUrBDOEmzJMCwGVBE14vL/hzJDU6zcDIlEP3/CcTe0LeDckb0oPLP48dwkV2RURew+3
 PaFaoMGyvqefXQEAxXFDEZJV3ql1QkDYNWl12eqkRMJiREFGQEBv3YqoVjzL9UhwEA/l1a+Gj6V
 u7gBqjVdzJ1kxMt3XsWxUwv8L9kBLMjER5I176hIuESnA4AZcQZREUV4xC8bA4DjHCwY179UnRL
 Qkmaz22e2ghlQt7xF3Gr84Rm2vm0j99TqIta+k/gY1L7lSDAXyitf09nnfBwdpqfZsl57G00c2S
 7wvcOoNcn19abDQG0KORpYmPk8QTAaovV9Ubxhfy366gmnNq70m3e7K941qZrKfdtVyBViIdwJ6
 1xtf7R8YjhaE35dZ+4NC75cGGG31NYj1oSltnYSYwYfbfL6QYQXuSs3yN0FGO5MFpuNnyRpgu8t
 NFtHNLTouzpiGBSg36ZlziFR2qCQ==
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3b3 with SMTP id
 5b1f17b1804b1-4bb8881eea5mr138695565e9.27.1795264520944; 
 Sat, 21 Nov 2026 04:35:20 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:20 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/25] video: Enable DM_UC_FLAG_SEQ_ALIAS for display and
 bridge
Date: Sat, 21 Nov 2026 13:34:03 +0100
Message-ID: <20261121123451.2471185-14-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Michael Trimarchi <michael@amarulasolutions.com>

To support multiple display or bridge devices, enable the flag,
so we can assign the req seq via DTB alias

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/video/bridge/video-bridge-uclass.c | 1 +
 drivers/video/display-uclass.c             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/video/bridge/video-bridge-uclass.c b/drivers/video/bridge/video-bridge-uclass.c
index 599090141e4d..ec2b43002a74 100644
--- a/drivers/video/bridge/video-bridge-uclass.c
+++ b/drivers/video/bridge/video-bridge-uclass.c
@@ -156,6 +156,7 @@ int video_bridge_set_active(struct udevice *dev, bool active)
 UCLASS_DRIVER(video_bridge) = {
 	.id		= UCLASS_VIDEO_BRIDGE,
 	.name		= "video_bridge",
+	.flags		= DM_UC_FLAG_SEQ_ALIAS,
 	.per_device_auto	= sizeof(struct video_bridge_priv),
 	.pre_probe	= video_bridge_pre_probe,
 };
diff --git a/drivers/video/display-uclass.c b/drivers/video/display-uclass.c
index 85dac12a197e..1bf45a8e5d29 100644
--- a/drivers/video/display-uclass.c
+++ b/drivers/video/display-uclass.c
@@ -78,5 +78,6 @@ bool display_in_use(struct udevice *dev)
 UCLASS_DRIVER(display) = {
 	.id		= UCLASS_DISPLAY,
 	.name		= "display",
+	.flags          = DM_UC_FLAG_SEQ_ALIAS,
 	.per_device_plat_auto	= sizeof(struct display_plat),
 };
-- 
2.43.0

