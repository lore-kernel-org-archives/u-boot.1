Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2006606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aWvwIiYB;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pqmcQ/g8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98C3C4071D;
	Mon,  9 Nov 2026 21:48:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VBJudoEI96Vn; Mon,  9 Nov 2026 21:48:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DFDE840721
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794260936;
	b=kyGKQnc5+GjqyPdgqY1CAYf3xezUb34uuOwOVT5ByOrp5yfb2RvY77S19OZw1lUXr7EK
	 vUlzRPocVCFueeioyTf0HbSeEXCU1/ZpRhS9iGy3ku5YDJjbkFcVUSudq9zmUhJyYg+sK
	 zhk7dt2l+V6bWjWwgtb1uTILd5pbbKLc6fQZLoW8acVR5S3OQfYEsFS3lbnFgMa+hwyab
	 jq/2g+DSOTNfRMvE8CxJYaMQSFne6lWcH1lt+p2wzubAZm4XvVJTKfiBftxLuQCkUP/01
	 uZjYU1vL3nluYX+wQTmzxiDCHN4gSBU1r1sSIwEcQZrZWrNaQltoy/u/myTDTIF8MOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794260936;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Pk4HXmH6trg7ZxlxJ3oJPcH43ML9bVcyt1wHTwJ5rZY=;
	b=fw9JeqY4FnwvYxi/njMIoayXp3H7CTjrVSFpZmVlpsFntjULOW3jl57FReGWFkTKEDMr
	 qvGsVHYvaMUwTMiZo56OH5hNBltgTKbaH/UhQneDsBL6uRNdzOM22OwrlF3xSwD+LSOuz
	 2XAi9olIbpTAPsDzNEsMcD0pwrVd/pLjBQ5UPsQiSVzqFHo40hfTIINx8/xI0zYEt0BBH
	 dSPSbWquu/3dPXrEP5yP+UpCLqPNecfWwX4X/kuZ84tJ0JH1+ZstPLYfs1XURvk8nNU2R
	 GK6N6PcY9fLG9L4ClZ8L61WGu9tbqmP5FgNIC8yWtVn+oG6KAEEpuZzzGPSzc0bTTLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794260936;
	bh=Pk4HXmH6trg7ZxlxJ3oJPcH43ML9bVcyt1wHTwJ5rZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aWvwIiYBJi5EntG9u89odVHYi+T6K74k1VhsUgqdAIIvKcVIhFd5352YNp4ZgvXuG
	 qGNzxgGBzinX2CTZpFFjV3o+fqurp2TNjFI3C9ztp1p30wUd+Nud4FJ2ryzVeCWDPe
	 a+eZEIsw7iRCvdM863af2pxkdv6Sp7C/ZVH7NnXksmgbvFiEOvp6hNIRwXtmLIqYZx
	 YFPXTnt8e7HWz1Rj2vjSCbgjqyku6WcPft+WND2Xtw6fpcG+DCTAGjdf0VWVyBPvZR
	 pbu1fRPD67rmLrDMqOzbB6gRwXzuOs4HgOfUnpVFZGbUt81F0mmLyk9pXu6GY9VLro
	 V+02sqVSsdu5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFDE840721;
	Mon,  9 Nov 2026 21:48:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 47829388
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D0CF80F1D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3xgO9Z7RqqMM for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:48:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 414C480DCE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pqmcQ/g8
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 414C480DCE
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:52 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so842381f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794260931; x=1794865731;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pk4HXmH6trg7ZxlxJ3oJPcH43ML9bVcyt1wHTwJ5rZY=;
 b=pqmcQ/g8niUBIBxZkXsbrEJ0yBVrxHIp3mf45gPvkcGSQCdld2xDalK/SB+AG30i39
 o2w4LnZAxZbtpZCYKtoJI6n28kUPyP03OwnC+AKBkHWqYXTBtlpUTJx/wTc6NbitLtpr
 yFcNOj6YlthOnyaYhEBNS8UXPjIYaMJa4nwg5AVjwclIiqMyqraeBf8ORktEKKG5uSXe
 GjF1TTHST/tzjpSidjRPhCeWsauwnE3mxhuCgWOL0lxGft/061CPVOhqEskvuU75DT3F
 i+WmuDKcIAdKyNsm+PySpYlt+HXEUraoNlUPaJW6XQDqdk6jORLLnIhvdht9L0/7VaDr
 9j6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260931; x=1794865731;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pk4HXmH6trg7ZxlxJ3oJPcH43ML9bVcyt1wHTwJ5rZY=;
 b=xaZ/F/7PIsocdba3n6vQRHvST7JhsvWEWlDCxJFtKSGgidsvnYkJK7Zz039Ky035pb
 KlUO+ooshf7SqTo+e79a7szJqfur7cnJ2FfyXKSMIhR3HnOQNjEgJBMbGB2u2hBwWZRQ
 4nzqPh7eYd6xAzXZDg7fpb4B4TsbS0sEXHqOkuPQYnm4FnBnEuZS18yQ7FQrsNQxBZ4+
 LV3gUBZLpJ9NB+RtLlfoyj5uHHT5V5G3i9Qx1vu1EfttuLKe2qnB2oMnB+wp4MRdHowa
 zGRvDLuw7Cxu1tkqtFqjbtEJI48NF7U47Tvvy/xyzWEgXmvdsTvr0qBUvnIoM6si6Wx/
 bMhQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFmXXBsO4r9M6v9LvrdDzR2LXBnL9sQMUyaQqfJq0875R479Rr3CTzsY29gk8a8ekenPVKkjMc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Q/TUkKj6o58C+PKhq244tn5U8ShA0eXjXKkisyapsfNyANLGk
 gJx3YR8wTBg4BbsdZFbOeQ/2RcJ9JDrFGPSpyLg50MVut1nlv0IYRZP+YtMnI9vTbps=
X-Gm-Gg: AYBFou0QmhgpBUxc8bKYu4fcoRqjnSCZqwb/Fmrjyfa43pqV3MuBzsR0cb/++i7Jg2b
 671HNNH5FKbpPTetUXatdjIfWV3ad1bhjcXfW74+TBU5zU9iJ9Gvno/NB8rqWqwOfpDagPpJ8hQ
 Bp8mnjcmj2X+1K4oA76fwsUVJzTjJlpL64Uqc/kWfOfOapk7luXDTirXRx3WFI6o9XcEqw3bb0k
 ABhTGlF/NCa5CiFG0gBO8JPQwfXnga1me1yeJ7naFM6RWcxpVE0muMabOZQYU/Tyt5kqiNhN5LX
 RCBPLswNoh/CMoqIg+fFdR/dNDDXyM0cdgxeXsamRA/S7Qt2gEp4hK+N888WwUYpcXJHFEgbpGY
 PKwsSI5B1dDmMM0//eqKx0XO4GS6llz5ZdsB52kZ6U1DGb1WhLTLu4e2e3Lj7TlP3OaMLAbW+oL
 DLRNmrzdjz6x0hvnz6y/djofNeJ0GYso4fgbTa/0QVjRmkV7mNz1yj5s0jJPZlIs+7o28uvrDWY
 5TTpTqBLl2coyVQin1Ih5dhG3faAqF7BUWP9Ywj9+an28juWzjMEIfJqJVoguaZ8CNc6D6MhJel
 S541H8zbS7Nx9gCc41d1v0F9RmvTYefy1YMwcPMj3/ClozwrOsoX6p7HN9HncLAP4KGLzYHMBDD
 ivROgw9oRBgKub3/83dQ=
X-Received: by 2002:a05:6000:2003:b0:48d:ecba:3cf8 with SMTP id
 ffacd0b85a97d-49830b9829emr1266141f8f.43.1794260930803; 
 Mon, 09 Nov 2026 13:48:50 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835f1772dsm1169903f8f.31.2026.11.09.13.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:48:49 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 09 Nov 2026 22:48:18 +0100
Subject: [PATCH v4 1/7] boot: fit: check allocations for decompression and
 alignment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-ccaione-upstream-fdt-fit-v4-1-5323cbfcc9f3@baylibre.com>
References: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
In-Reply-To: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
To: Julius Werner <jwerner@chromium.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.16.0
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

Loading a compressed image or an unaligned devicetree may require a
temporary buffer. If that allocation fails, the loader still tries to
map and write to the returned pointer instead of reporting the failure.

Return -ENOMEM when either allocation fails, before using the buffer.

Fixes: b1307f884a91 ("fit: Support compression for non-kernel components (e.g. FDT)")
Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned address")
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 60e47db5fb0..a9d86d124c7 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2487,6 +2487,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		log_debug("decompressing image\n");
 		if (load == data) {
 			loadbuf = aligned_alloc(8, max_decomp_len);
+			if (!loadbuf)
+				return -ENOMEM;
 			load = map_to_sysmem(loadbuf);
 		} else {
 			loadbuf = map_sysmem(load, max_decomp_len);
@@ -2501,6 +2503,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	} else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
 		   (load & 7)) {
 		loadbuf = aligned_alloc(8, len);
+		if (!loadbuf)
+			return -ENOMEM;
 		load = map_to_sysmem(loadbuf);
 		memcpy(loadbuf, buf, len);
 	} else if (load != data) {

-- 
2.56.0

