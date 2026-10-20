Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190EC606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NImxwGmk;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=GFHvkPb3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8E544081C;
	Tue, 20 Oct 2026 17:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jG1vIEYkv6_D; Tue, 20 Oct 2026 17:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 23BC94082A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517165;
	b=SgZFHoewtN7SRWPyBOTVwexGoRvLjwexxAX8IY1CeZk4+Ebou7kbKgeXinpNX191ta/Q
	 GFM8dSGthDLM60PAUXti0kQUsZRSeFisM0w6IWMLqQVF6+z7JUNl40mZXi76KI4u5FZJY
	 D8GlS8TG4727jBmdjhLLTpSjk5oTwcDAdr5KfgHajhFrc9HC8a+up0R+gRPJMobpPUDIA
	 AeBK/qot2+23WQvHowwbvsmiNAYQsNehY3e7P3GMzmahgHpt3aAV5ojrpyU2HObitHjHn
	 wlsOdjGZydCLuTEb1D2Kc2y92S0cBfgFvZD86DdCKH5G4CXjFHbH32It9XUcQpPRXNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517165;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=reeCo4rckAlnkkMaeAuaHlfMIsYyXW8WpYOVJpkqN+M=;
	b=MHkb7rhADfUYg+vtIWEW9GJ3my3k3fSEQk0xonuKTosAZ+vZqcU95Hdpp/Otm33zXPJZ
	 MzwwofP7rKWc2fbBZl4EudsFDaKuT/EbLZ1a83T9E0uamOd1wzUvSya6pmRda+123eOhX
	 Z7jWCQSH1e5IV5uWz15qNA03wfCFr62OM0rTdmA13Mj8fk2M/0GECM82+3yGcMV3V8UmK
	 RYxoEiAsHBbXMeR/ESBN7h0dvu8W6lU2hZzh5aU7BjTOlNDuDLHCTr2wAlpWtTGPzMug1
	 pOdCmbCNfP7oo849frac0PtXaU6UVo+SE5wpLi2ORTGphQAgUDP4O9l/zSUcyymfSCA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517165;
	bh=reeCo4rckAlnkkMaeAuaHlfMIsYyXW8WpYOVJpkqN+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NImxwGmkeBMP0VWQVcBEnJOQqiXRX21sjdkeGIzWJFjHKUqwzZcYrYwEmgc//cwlJ
	 F6W3wDzMSdHALtTCHkmEpU7tETyfU39Mez2fY5T6HmDp+qZWHrFuJ+opF3Z1/haZpR
	 mLBDgWHL2iUWn9m2i45vGfnFaD03w9+4vLmeHQ4KP+xUVD/UG4LeKHr1TFMLL5kb7C
	 n9gNPXHeceAbhbKDMpHWpSiYcs3P2+Bi6lNfvy2ZxaIdcFDykUuYsfWcQmaDhTqYKB
	 MPtyTfCbCFgoYPa85KbXHHDBkYzCb+BGNbLUC15FpRvXompc11NQS/JP31tngyuXKx
	 kCev/Sd8nSGrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23BC94082A;
	Tue, 20 Oct 2026 17:26:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 646D11E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B1E7402E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w1UNZlXuKf4U for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:41:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 66ABC400CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514492;
 b=UlLJRZFVRMyvd/jEOEw1sBvaIrJY4fIjikMOa/yTK8Qvw1OuWmwkKNO6wneW7B/PMIEe
 j6u/CrpBj/Bt2eLNH3tkn1lL4iuoET4BsWQGT65RqHVq5xdHmdS44tu6ySK2EvFxngZiz
 s3jMJ6Lxb+udPL6VV2Ai5Kvl601a9TbHDWOi7dBlxGsSIxcRlO9/Hr0j+RJSsv/k+/QVv
 mqiHRVGYWS9ITorbVw5ivanh/V1WyYHMFh4DdhCvoPvaSitojSA/ApeFcCE4ll6GtBr4H
 WkqM6eerWgO/1Jo/4jNDddRkmGNCFrxYeKnjC9xfXPnIh+m83kwMzPejqz/aurPH19w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514492;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=reeCo4rckAlnkkMaeAuaHlfMIsYyXW8WpYOVJpkqN+M=;
 b=k062qQVgtOBIwVwLdRbfT60oVI2ZR61cHCNCwqJ6uVE1/biQDAJAGsNhH9cExlChHVG0
 zZS80U04dkkn3iik18/HZeAjf2bdQCoNSA9nwD5EGuwN2/1RNaYIxj35MV05KQI+gGFUp
 6oUt5eQUOO0HbFTAcbpDOUiXGKMFgEQ2K1s03gVP7zr+FPlpNiR517rlr/Qcpf2CSSMMn
 MwEBWFC7gf1szzaz5yhXJfx/k2L9UkOzKTcu2OXNfJPeyzinPeKtn/w3zfepc0cvT6dWi
 DCOB7Ht7XcgoVe70EvT93+fYyC1BQCbKD2pHcnm0B6iO/Ld3zQZpXBgi0VVFPT4O1nw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=GFHvkPb3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=GFHvkPb3
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66ABC400CD
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:32 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1fa22006cso4630655e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514490; x=1793119290;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=reeCo4rckAlnkkMaeAuaHlfMIsYyXW8WpYOVJpkqN+M=;
 b=GFHvkPb3MwX97Bh9Sp/ObYwslj0MHCbx6F2AEP1L0UjOSGjWZvL1OgiNvKrZ/oShlJ
 973JDGUAziHMFQ874pis39Brt9F1zWgp4S7Zz47liczzmmbHnFJzjHtlpHKqXOdoWiny
 IOf0ykScwKyMqgHovkxh2Kn42c9GdNfOeGQNXOswvMLWFZT8saXqQ1QoEmwgQN+0cBjx
 kkQMpnX7Ck2oSExkaOvX2LSrRgIo/zw/GSIW+jEo2/8gcNfe/DLnSUn7hgRwCN0G3tt6
 ZfXWadgehRXkil4yDqOSbyAjmpCOiKobkXOLffZdFBMZndLSCJdjd+zePKH5IcsJzPu1
 4JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514490; x=1793119290;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=reeCo4rckAlnkkMaeAuaHlfMIsYyXW8WpYOVJpkqN+M=;
 b=iippBwq/oM+B4DHSKKyNcwkV2RDbMnsCrq+4Rctcfx1GjyOtqBH1l2xPE2wGvMA886
 17XLdtvpYjDtyBM9FH0UiX88eUGsi7dP2OF50CVXT984ygStkgiRGEqH+SKv4zPDBPQj
 NrDVWAgYlOzJYeDYQxNoUgF838To0bJ3PlUUqIGuhhJnaTIcTucKeSULdQtRmrFhyjzL
 bM/BasV/WMcUnc/rFc0PBXEaYZjz8C18dX/Ss6YmJw/eQEku8vRHnpY4dXwQAcCUT3iN
 7Iyy13GSNdgMfkC9ZuvW3E4pZc9yKIuk21tGyHmuZw2oZYG1NbgcHiMOC6t/5ylzBUT6
 JKiA==
X-Gm-Message-State: AFq9FYJK47Eub1XQHAu4wvP1XmRHtB0n/nmgNuRRH0up0avctn1IfbO5
 fcT6AH0sXOuFxJ4UuHVqgUt2fh7iUxPeGG0jmSTTzleEauqTRHFs7k5KTwUjPZYRtU8=
X-Gm-Gg: AYBFou2ez6f6+cIp2sAOIdCwlY0Yj0XlcUzQ/umapXspY9lmyk9a7dqf5aVlXcBUWro
 1vJO/9EugUDbgWzsNOOsQmLjbLlssRSmTFnlDEWfP7ZgRviaExXYSy0TBLSEvfl2qc47nf56Mf2
 OyJsyWoaiFZ+kKTpMYsnnCGt3N3W8qWxJxDmlPFo1t6B8UYAFXnfBm8iCQh/8cTJyM0vtLKSZPZ
 FzcrNupLwahPz62yTrDujXRqmYHBBOXNsX9sIzcYFoq6CWHHofhed1nNLg3emdRUYn1WIcPzgjA
 6sOaVNQkzyq1G9X93EC85GyyYmHkzgPkf3/U20j13fPuZxwUuwJalMCmteojAK/ZECYG71M/NUW
 xXuNbZ+mMSI+cXhVCIsDKM0hKSWuAz8DdVTG6w/yw7ueoevmjbCmfFC36xhfEc/JIJJQ51X51PN
 JF+XCnPjLH98CbI4qHCVbulCdRN/SJSlhMiU560/cus0XJ3DZP2EalIN0H8+sVwmLwPlr3Gev4+
 16A9QhziHVByFnmUlKDvqBV0QmIKmKpgbzwKlWHYnuiKRAYJ8f/eT4=
X-Received: by 2002:a05:600c:34c2:b0:4a1:a45a:88f with SMTP id
 5b1f17b1804b1-4a1d76039d7mr224556075e9.20.1792514489900; 
 Tue, 20 Oct 2026 09:41:29 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:41:29 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:49 +0400
Subject: [PATCH v3 02/23] spl: fit: Stop reading the image type
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-2-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
In-Reply-To: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=alchark@flipper.net;
 h=from:subject:message-id; bh=5oiA4AiVE3q/KAYkSWW6T75XJj03IavmfJTWo5Qnt3g=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7lysxf/wW6hptilugIfg37e/JkRsSfKXu2046m+i
 eU7HjQodExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVwlcYGXoYvdYXVpVc4PqwJ7Bq34M9olv4lh3ZuHmS+/p1zWy9V54z/JUv/Lp
 o/bRju9YcK/V647/92/x3HvJTl7/bbp3saOhyNZkJAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
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

load_simple_fit() reads an image's type with SPL_FPGA, or with
SPL_OS_BOOT and a decompressor, only to print it in a debug message: the
FPGA path checks the type string itself, and the decompression message
no longer names the image in SPL. Yet it links uimage_type[] for it,
around 0.6KB on arm32 and 1.2KB on arm64.

Drop it.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/spl_fit.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 64e5f95546f1..bbf156f204b6 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -260,7 +260,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	ulong load_addr;
 	void *load_ptr;
 	void *src;
-	uint8_t image_comp = -1, type = -1;
+	u8 image_comp = -1;
 	const void *data;
 	const void *fit = ctx->fit;
 	bool external_data = false;
@@ -284,14 +284,6 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_SPL_FPGA) ||
-	    (IS_ENABLED(CONFIG_SPL_OS_BOOT) && spl_decompression_enabled())) {
-		if (fit_image_get_type(fit, node, &type))
-			puts("Cannot get image type.\n");
-		else
-			debug("%s ", genimg_get_type_name(type));
-	}
-
 	if (spl_decompression_enabled()) {
 		fit_image_get_comp(fit, node, &image_comp);
 		debug("%s ", genimg_get_comp_name(image_comp));

-- 
2.55.0

