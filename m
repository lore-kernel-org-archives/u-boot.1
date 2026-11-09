Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155DB606A326
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MKEd6EzN;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QNA7v1jm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E64AA608E0;
	Mon,  9 Nov 2026 17:29:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xnrf5jWdXnIL; Mon,  9 Nov 2026 17:29:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3AC6960851
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245388;
	b=T4/ZSbiTsNX9aypU3Dr5RePNcVO/IwxkFhB27RM9vF1grWsgLREM6goY3HwOE8z+ggJi
	 q5SmrGUcsDKjATM+r0jbIZ2NnP16StDLslgBrpejWIk8MTj0F0PBWEjPXx84Hl+EuNvgq
	 Jimbf4wrpuIhzRyD7mq2xcoUbeeMezQugC9zGjsHD0SZe490mfWUOZEAAQqk4cqZYGXBx
	 2IEVeF8xw55OMxU3bQ/dpDnNqcAIZRcHhS+xCLx/8/mcVHFIVyUIiluyKqx7BVDXNVmgM
	 +q9aN6pTczDQZtF13h0724ukH1A/2/2ft0G7LVPXLcoLxk0bzP47+i+1Aa0zw2lasJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QYjoNXp/nXp4VvtPgeDCoRWCRURzf0sNSBK6vfQn0bo=;
	b=mXAu+5g2NH/xOLUrFc3zVQNUSq4Scx2LfNEs1YBBzE1pKoTU5V+H3DPw+BsS4JPvA4a/
	 RzdIq0ZNzcAoWbmej9JzuSxEzhYdo2SOb23je29ZV+2s1+GjF5XrOhwKVakhZ1rA4EcHf
	 JLaCneIqMix3yldbu2Wzq7VUVcAr4/f2PId6vRxO++dCrKYYg+kh5fiLR2wpFQXcUFW9v
	 QLJAjeodIGy7sY3wv59Pt85AoCfDndnUXFWAIwXHFdlxGDlPiFRjAOF4DxYMyM4BITra3
	 cQBRwJnYaez9v9Ycw2qhxLMYjiRDp4lHTBSZoUo/ADnv0a3Nd6p4KWa1NDHPGhmubfw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245388;
	bh=QYjoNXp/nXp4VvtPgeDCoRWCRURzf0sNSBK6vfQn0bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MKEd6EzNx89lrZfzU2xhbo3FRBf071tYgQ1oJA7Cr6xnZ4AyE+poe50yt2pfcgqdp
	 JZvpemAVdQ4BX8J9rWz5Q6Lfl4950gT++k81vNGTftJp5hdamk2XQwtj4IldpTe7Fu
	 HXoF1VYMzLqnteO/2kHtskoWfXQt3hzYnWwzdtfOmmR25NXdaXSV9jdC9vnNexU7H8
	 C89HhidHI5USkYOZMmrLQ6LDwmfcPYz/QKAJ0PxNR6aw9lLakIEBJVou1YOJ+6R5cy
	 4vUm7wONCofEb23/e/G1jvT+XFInQt70hTlDYbnRmv5JenslIu8GRn+0JLHGmFdedC
	 f3bf6/saeaUSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AC6960851;
	Mon,  9 Nov 2026 17:29:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C05073AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B28E88109E
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id prdKnW8s_EM5 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CF6BD80FB5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=QNA7v1jm
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF6BD80FB5
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:45 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so10898235e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245383; x=1794850183;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QYjoNXp/nXp4VvtPgeDCoRWCRURzf0sNSBK6vfQn0bo=;
 b=QNA7v1jmUN6IdryINNE3r+x5RAUR8Eqy7iAWWk54dt8s1CQVHecgd2SieubBgh55AK
 2TMk4L3s3Ndx67t9N89mH2ytk/HcRz2s1eBJ5NRzucOgJChcsLtXducHHalLekY8fpYy
 387kg4jmrIFOau48mdpGPdQm9UIPb4ODG5yzuzVLDo9yRTE65lHVP6rJmhZygPT+oQrv
 lwa1mJ05w3VV4XEV+HeIVowt/fciRiMbuwGm5A6BWDhifJnPCA62GtI9R1Kw4NnQdSI6
 1uUDwLuBztcJRRdvOTVlGU10S4FRr3E6VhMtu17zwkD6/zyYVZ6rGNbNMveNH9AkE6L9
 ufZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245383; x=1794850183;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QYjoNXp/nXp4VvtPgeDCoRWCRURzf0sNSBK6vfQn0bo=;
 b=me29xQxKojjpiEV7ghGY+eBcXM8Fm6KDIyEr0qJzxErpHMhiWdT6m+Vr/E1dR8ywhj
 xsqAnurM0I2jNlia3e6i8zLwi7ArcIoW0q/qPF/0WSH22VZ7p1YR6pf1GOtuEpQZdbsK
 068mb/Srae+LhbB4LldmNk168BY92qvuGOZQu+pirZDe25/hc8pq0hfpXacZ+f+KAqGL
 vmgRUe+nY79ovh9MDF0a/ctuEaRi550BTeMRGGQmwr94b6t44+3iwk8kO1AAVAqLuE4Q
 rYYhJtEEmhDV+gBAerhNQkVb7vqvUEhcWApya+VbU5Yft58Spo9gwenIksWeEkQrmn4H
 pMXA==
X-Gm-Message-State: APuU4Z/1o+CSBUjn2qNtvih7D9qsIBP6uKPRI6PjAn3PXNy4PvfgDNeA
 DBA348X3fTaZPGzUr1Pme+jydf0v6lU1yoKz3vE14DjNks45wes+9/1DiHwYfeAj0+Q=
X-Gm-Gg: AYBFou0EHwPtlyJG1x0kxgoEEGUHMEyexvzSr7WOhYT4lGyKBPH7vRRPnxwrf4GRtLp
 DD32PQIfGtvLwjql51TxK/nfsJyY12p07O3Lrxf32QmxlwTcghoHsvX44kFb/5S+QUYR8//M9Al
 ezTwVCDxB+RnOYTYEKWciL+TaayPSn0p7qCS1L8XS1ohtBWCgIc+i8x60MbKaMVW542fXdKzYnp
 Gn51qP638ds9klob0OPU9kVAqP61mQNikmXtac+VlVYSIQ8c50RXSzuTCAoNi9TjvAu9xVIMAxp
 USg8+sNaWphLsvqgqrAABiMaB8lULyLpaUAuNOtSbeQedIa/YLOGsyptmyzqxnyj1cQ+Py4ZRFt
 XQWfxUqrp+a8CSYfdjJcHXzM4QayEacW1GQwoGXRSQyRCpnT2e9vDmPGMawAbg/Z5hKcM+AyXhG
 C6AmwlIPXrrcbStoZ8BTPcqrSlr60wu7UUoqiUAaRB5L01zoFDJa3b91M5Sqzek5le8WgyH7YGK
 RIsodwMK/vxAAu/k7sRWkhCJy6sZnikwdtfEKQV/H3GnQZjBjrNeRr+hNgP6ZBX+6XveCIYsIpR
 ofhOCU4cEDJ/8YVjLTXN1faLKyGd8Fg=
X-Received: by 2002:a05:600c:4695:b0:4a1:702f:c736 with SMTP id
 5b1f17b1804b1-4b94d76349cmr94929965e9.3.1794245383347; 
 Mon, 09 Nov 2026 09:29:43 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe2cb2sm2388865e9.3.2026.11.09.09.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:29:43 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <u-boot@0leil.net>, Andre Przywara <andre.przywara@arm.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Warren <twarren@nvidia.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Subject: [PATCH 07/11] video: tegra124: Tell the display the frame buffer size
Date: Mon, 09 Nov 2026 17:29:42 +0000
Message-ID: <1ac8e3ed-6d9c-4267-9c44-8d63b4e2233e@gmail.com>
In-Reply-To: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

The Tegra124 display driver reserves a frame buffer for LCD_MAX_WIDTH x
LCD_MAX_HEIGHT at 16bpp, but takes whatever mode the eDP driver reads
from the panel's EDID. A panel announcing a larger mode makes the frame
buffer run past the reserved memory.

Pass the reserved size and depth to the display before it is probed,
so that only modes which fit are used, and the device tree timing is
kept when none does. The width is rounded up to 16 pixels after the
mode is picked, so a mode which only fits before that rounding is still
refused when the video device is probed.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/video/tegra/tegra124/display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/tegra/tegra124/display.c b/drivers/video/tegra/tegra124/display.c
index abe31e27d84..bae4725f064 100644
--- a/drivers/video/tegra/tegra124/display.c
+++ b/drivers/video/tegra/tegra124/display.c
@@ -331,6 +331,7 @@ static int display_update_config_from_edid(struct udevice *dp_dev,
 static int display_init(struct udevice *dev, void *lcdbase,
 			int fb_bits_per_pixel, struct display_timing *timing)
 {
+	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct display_plat *disp_uc_plat;
 	struct dc_ctlr *dc_ctlr;
 	struct udevice *dp_dev;
@@ -354,6 +355,8 @@ static int display_init(struct udevice *dev, void *lcdbase,
 	debug("Found device '%s', disp_uc_priv=%p\n", dp_dev->name,
 	      disp_uc_plat);
 	disp_uc_plat->src_dev = dev;
+	disp_uc_plat->fb_size = plat->size;
+	disp_uc_plat->fb_bpp = fb_bits_per_pixel;
 
 	ret = uclass_get_device(UCLASS_DISPLAY, 0, &dp_dev);
 	if (ret) {
