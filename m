Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B895606A32A
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aETlRzau;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SXAbx5nv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B46080FB5;
	Mon,  9 Nov 2026 17:30:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eilV4uIPO1tR; Mon,  9 Nov 2026 17:30:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9904A80DEB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245418;
	b=MWI/Cmuc7HvQ6t9Afte7F/f5TUuq5TsXFZAr2IekhWmMlqONbaqlpejxF40hgMnJgnfS
	 kj4r7PGPYFrOcnLtL7IJcd18wt4fJhYp9Tr9CujtM3c+CLpFNWV8QembJ4727MHZyvRJO
	 OKIJjoWDwB2f7HTSVhavRbSbTdt8E/fowTgAiQ2QL6V2/kROcVbb2Pe7BTVPT6e2bf768
	 gYDx2GJoN4vqaf7hlGpktErxZzWfcU9I4IiSCgPLSDvnKbohlPblNSWFEfL8geygIINTh
	 sU8IMhIXd4spMBsK+uJkfOBrspyVq1jusCzxJ7Cp2MPTPUCYIJbwFN3/dICeB1MXbhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cSBkFrIMpTXLNrxXSlmHpwhhLwk4E1AdzOJSLAHU0SI=;
	b=BrQk6j3SzWQ2CRDU7mRfRwo5CZpjlmbnmLRUwa6wWEt26ABEQP7kSbJuayPC0zPTR7pY
	 WFv5SLUUqmU9SMm0Cmxxll+GZCXd3wFrXOTITbpJYcX9g2Zw4flbdHryK5kCAbSpQK7tM
	 4Nh01uMPMmBE8Rl790h8Orim4DMRlMHRRz4RMNfzZ62ccpZPPqRVoo17Xk0QwPHcvjh3s
	 3Mje5aAXMHYvSv9eb3TBSQpmf94dlGpuQqhCLbQ9e5yLZ96nKeIK1EnS7WVTSp8YGjQon
	 eOF32WXAXm6I5rQaN9RpcaE5/pFJjsy1hyUYyRLb7wDJ2BsOI9Ad3tdjT1VEZpeYzqQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SXAbx5nv;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245418;
	bh=cSBkFrIMpTXLNrxXSlmHpwhhLwk4E1AdzOJSLAHU0SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aETlRzauP36vjhqZlIuUqtZ6jt8EXJs+RaPsVaMfIiZt59lGKiCZDp8a0kU+YTTqM
	 mF4OcaeXO9oX3LnxjI27mHW3EW5KfnPMq4sLo/RQj4U+DntEFMaDr6Xv68ZzE4qT/D
	 rVS92NMw+w61rZC1aqk71moD8p1D/qMxFjpOVFseaptJAklEUdEYYFURTtJDPcgDnN
	 dvFyM9nqq9VPNWOw5T2OpzWKHN9VLqfROman3/LWHwbKaqXqrNYD8SZ0t9yeL8eA//
	 NkGZL79xdrbcHlRQQzI2+4Y7GWqSxJHB1Eoa3nlnC2aN1vy92Yw3Rmvowfy/3qxceZ
	 mlK1y1Qw9CGYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9904A80DEB;
	Mon,  9 Nov 2026 17:30:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 35C9428C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18D1A810DC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id swi8WXkLfvQf for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:30:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4698380DEB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=SXAbx5nv
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4698380DEB
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:30:15 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so769641f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245414; x=1794850214;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cSBkFrIMpTXLNrxXSlmHpwhhLwk4E1AdzOJSLAHU0SI=;
 b=SXAbx5nv6Ryyitx4FpU6Ai39+wZYHCZzdZ2xCMxLn4QyvbZvjgcp7zOLzXBDcZ1PR5
 cQrdi0DwlRpUABwFVt2FOrugVdRNQunc/teYupxEsHLbJiafKCzZrztxwRQnmZKIsqmg
 vxP47nSRn+7ACIGrn1NWOIlG0frTrfPPKWUcWNvUF+B//fsfm2E6r2AxtTDsVpGqSa6R
 yBWObIo+fwxOpPsxlZ7YDLSiDD97iIipYrI2hNb6nS+1LO+9J7ycc7jA+6B2bDrDU8xB
 5lllrhDuWdQsJ+FLNhhukZwpen+gCDyE688KvwjC+jtVKewneajJAQM7btzj7L/pX0xc
 FMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245414; x=1794850214;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cSBkFrIMpTXLNrxXSlmHpwhhLwk4E1AdzOJSLAHU0SI=;
 b=fIcdzMlUnThPi6WW0U8SN7Q6pgln+FffqR3nb0WSNdHm0CcPekbkaSqBfJTeaTKt3y
 AQ/6JSlh/JHV8ZffNokOMt/SrnvH7+llmGEctPijPybHnkscg4woqcCixWMgtxrLkaZM
 qmJGfxnyL4K5azF1s0KbPjVAxQ9zl0pS7lnUAgXTg7jvcOI6vKj30f9aiy2DchlCJoKc
 Heor+I2vfJQlEWDu3k00TBqCNnoxvjCZstRhiMh/cEqrH3BALa6FacekCVvnanr3pqvd
 YmeMGNpJ6z1CDMGJyZGT37b73Yx0vdIUZ7T90QQ4E0l47Aoug25TPMT0DSzIQokR5D7g
 QBIA==
X-Gm-Message-State: APuU4Z8TW9XRl/Sng2EVDhT9HRufZoEW7viELpA4qVFlG5w3iyVPvjya
 g8tn4j55IDgMNGc2rRMaN30HnPXHFxeIHW+6VXVqoWCbVS1b0ptKlB9r99qWSY0RWpc=
X-Gm-Gg: AYBFou1h7Bm373i5SQYMvPqbHXB9iTvB5QoNRhEHjPcEpoekwHGGOd6vjfUDY4UTbAR
 69DXBYfnvitqjymExIXrCpMSrn7Nk/cZooaqTfYr/ONRyYCrzBI8u/KMn3nG6XchybPyWwDgF4q
 /IF4u4z+IpsmcdluUXlPaKvXbx9ZZyb1fEoLWpf29KNDWyefxz10dvGHSh4H3y3GzhLKjNqnXaj
 +kWQyLtxohYpi9VTgCFjOXbiRcSy8Hg69BDjgTniaJt4g/Z6QqqA1z+o7pLKaptx6iMbh4uhPTr
 2AtEoM48lJYiGX04zMK0cx6GQPYfkr3KrtEiZZEpoKpXYxX0YGctSJk+gx9b4oF+nF0W566EehY
 PjrtSPZfhQ0LYVlgldBgE1cCRIsmlw5vze1Ic2RPYujeJ2qh7qaIZcsFoCUWUeM11KmT6NJWKPy
 9e4r6ltmpcFe3Z4ampU08abun9IjTu+Amhu6xH0zwLhOyAK0sRN5m3XqiDNZcVKQhwoLFTulu3z
 uwRVC5qcwkcrzfcXyvvMICCqMRz33uYk0NPdPfycVPjke5/M/nWqprVzfh+C4JjwnMwEejYsyuF
 3gJaKjGx1MWcTI4wuK9brXwu8Ko/YvQ=
X-Received: by 2002:a05:6000:184e:b0:490:76de:c78c with SMTP id
 ffacd0b85a97d-4982ecf644emr283681f8f.9.1794245413567; 
 Mon, 09 Nov 2026 09:30:13 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f58sm155598f8f.13.2026.11.09.09.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:30:13 -0800 (PST)
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
Subject: [PATCH 11/11] video: tegra124: dp: Limit the lane count to four
Date: Mon, 09 Nov 2026 17:30:12 +0000
Message-ID: <e4322cc3-01a8-4a91-a0f7-fbcf0807a375@gmail.com>
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

tegra_dc_dp_init_max_link_cfg() takes the lane count from the sink's
MAX_LANE_COUNT DPCD register, masked to 5 bits, and link training uses
it to fill the four-entry pe[], vs[] and pc[] arrays on the stack. A
sink reporting more than four lanes makes tegra_dp_lt_adjust() write
past them.

Limit the lane count to the four lanes the SOR has.

Fixes: 59dd5aa8fa51 ("tegra: video: Add Embedded DisplayPort driver")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/video/tegra/tegra124/dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/tegra/tegra124/dp.c b/drivers/video/tegra/tegra124/dp.c
index 611bf2f81a6..22e9a4b15f7 100644
--- a/drivers/video/tegra/tegra124/dp.c
+++ b/drivers/video/tegra/tegra124/dp.c
@@ -664,6 +664,9 @@ static int tegra_dc_dp_init_max_link_cfg(
 	if (ret)
 		return ret;
 	link_cfg->max_lane_count = dpcd_data & DP_MAX_LANE_COUNT_MASK;
+	/* The sink may report more lanes than the SOR has */
+	if (link_cfg->max_lane_count > DP_MAX_LANE_COUNT_LANE_4)
+		link_cfg->max_lane_count = DP_MAX_LANE_COUNT_LANE_4;
 	link_cfg->tps3_supported = (dpcd_data &
 			DP_MAX_LANE_COUNT_TPS3_SUPPORTED_YES) ? 1 : 0;
 
