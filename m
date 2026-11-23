Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D7606A32A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UKzFmkHM;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OQZ5kRVR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E75748097B;
	Mon, 23 Nov 2026 10:11:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gLQ5K01p6if6; Mon, 23 Nov 2026 10:11:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40A6880D7A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795428712;
	b=DxM7m1ZVA85yKDnC0s1Q4DS6f0LC1eysDjWPw86ik/gywMiykhvU1bOVYSohbKotw5xo
	 3PmKLFGq4T+vJxMqqDu/2qEWdfWxjM2aVSO0EkMQf9yVsunNUdfRs2zt59xz2sMDg4ldw
	 U12gKAb+xlr7qmmSASb/EevyCow+aAwX8AlNA2iKVSw27/pVo9e4VrhUfSfHvmv3WRhng
	 VJ0NUJsbsJCBla9wXDbhGDZFIGvjA32A3lHDCwBxGolkVT/qTz4z/7i4nqj4Gagl+Run/
	 23ISnJaazfKqU+ZppQXGS/3DB8LgKfFq3tEnMgJDLxtKJkFdI7CIEh6HNL7jXdzUPNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795428712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L6C0KHvVWWZDEKWyNhNeO6NXkMc4oUqYlSVsSuS+VNA=;
	b=cBnmFJgFveynT9PlQMWMjzdLtlJPnkYlSZFZjoi749NHRi118h7NQIlfgDcpC07rzruZ
	 85+pS9FbsDntOpJc0Dfok5WhiXhExg8kSN3iawnT4PdAU/5LzSbotPQ7s2GzB/N0eHxaI
	 EHjywxY+VOG8wDm2y06rW3csWrhNPae7hgixTNVXOa/Ahk2wEgBK9pOQFON+FM4xRvCB1
	 jM7NzL8QgmdoEeneZHWMEZAcEQjpZ9t526hCwA1zVTLZ53LsQl4zYgYJmEcZ4fr7uH0T3
	 l8ZcU2zSwqDD5f/9IIeq7A5hAKrnYWFc+eXCXHZ2mEefwgO6N+aFgWpZOBE52QdDwow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OQZ5kRVR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795428712;
	bh=L6C0KHvVWWZDEKWyNhNeO6NXkMc4oUqYlSVsSuS+VNA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UKzFmkHMjXaDJmpcDmB0hGAlShxW63j8uSs0ULUXc8lv1qboLFA45nUa3qRpyFxIs
	 oXMgqtnsp6UvllYRg+MJ/GXV5N3wn7D3+seuLaE20h6wUNDgS8PLlhMeJDbcxCa+1W
	 5vLTFndr3q684FMCQ/8Bd78WGXkeEBbEmL8X3cQ7kxYqHt6MthbguQIPHp7DPRzBnF
	 r6+f5H+NrbUnFJR25s+yOakfuDluIhieHSL5j30lXE2WDj5UpN6HQyC5R6i7ogltqd
	 eWXxTv9iV4pE6fPGQkI3Kx4ROm3ldTa/aa4kq9qr0RdHNdxQSc2XqpdguIFMHJxDRw
	 h3KKvV/KlWcmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40A6880D7A;
	Mon, 23 Nov 2026 10:11:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AF264260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A09EC80D7A
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:11:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SkzMRPsulujc for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:11:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B0E148097B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=OQZ5kRVR
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0E148097B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:11:49 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so2344532f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795428707; x=1796033507;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L6C0KHvVWWZDEKWyNhNeO6NXkMc4oUqYlSVsSuS+VNA=;
 b=OQZ5kRVREb8/u/GMUKOFNFOkeb5Jt4YHLzXfzsXkXws2kRL6kMgPPPthg6mdk9Vo+P
 pRmx9v56st771VAjqPAmFCldIPJw/CsoFx/i7U+ZJ2ochnk03m6fMhgtI0ydWDngWmR8
 lqW1PCiJqG47ZUUEl/hNgkNOOWz8TEz129bGgasGkEGlIrLC3JvP5A60009ojqK/wImS
 MUNtbV8y3bTzisrDYKK64CjUHfg2TdZL4C5fbpID8+B46AxxOTUO8SctpvVACPSKgPUJ
 578y14lzd0jQtknPRpKzgKNrdhUXDF1o4p93xK3KEqc9+e7rMa6VEKKJeeAgshlaiQeM
 iZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795428707; x=1796033507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L6C0KHvVWWZDEKWyNhNeO6NXkMc4oUqYlSVsSuS+VNA=;
 b=gbKTvhJ++XA0awVGXLknwC7WHsmOLz9YYQuf7tNOf7rWoPYJBNruP8xbFaMvp8pE6I
 ft5VVI3d+shSqm8YHB3I0/sm/Ot9/thLTUJFNBYitFnsTLX2/WuTkbi53Bq5eGv3Qvt3
 SpKYtxQ/uaIZOEx+7rxryMVTjiHYy3UCBDWQIm6NtxXVlWKqlOnuNd7D+g14ZGNoOgjD
 4Od6xR8hFWyQrQn3gKm2yNHIRT6l5/qsrWqSL91s+TW2ZmMb71Fq2xjM16nF3ZJxCaT2
 jU9dXzrPEJ0+ou1TXSxlzj8sGN0U8xXp06qpFuqr7sSyDV3LrRZOfaCAQi8BRcP3fjqD
 LGmg==
X-Forwarded-Encrypted: i=1;
 AL+hErEM3RgW3NweP+pe4x7zXIRcEnAudDKgq6tnoy9eBi7/4RPrFu/LPritOCDD/sLP3JAGDFKbhBo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/dmC+9PvmXetsPaB9kty+CAkIJuIoFCZEIrVKjlCP1/03BlC6M
 FTNa9P7Ag3srxDwxIMIsCSAIKBwn88SNvhtPPrIcwXnHAnimrBBJQ0+WT8E1fEBR
X-Gm-Gg: AZFdTZeowpt1lna5d8OKsAusDqvwHuinKIms11YpInlIzh0MN9m7FalYSld1MclYJbo
 zNXpYJvL2jrfAdahcYrSOxjtpA08VNCkmYg8uB2n+f2PaJTELey3RdXTTuRHs3ZJxpHhWNtd4Ba
 dROlNoEklJ/1LG0OTXA6whcA2Jo6HLAAZW73t9B8g/4egxKEwjJ/fYodKIQne56XPY624DnKomY
 KCsJ4zPTBRoGwn5eYeeQl5vdDsh/YqU+pvhFSbfBqWbMDYPsSotqFVhnsHsG4pD74Ke3wVU4Zub
 VRJ6MRUpRwf0d2fd+dJK6SDQJBUb1iO6CKd4e8ZZ7P/YIzhxCZw4PDrQrf3wBbiblHBAANcM6hG
 kHRNhJeLPg2DnnGKjtGIhT09LTyLosiOpKpkv0mbhQlORv62GVT1JjpIqhE51qUz0w5m5nAAKIF
 Kdt5DGaX9KwK4zTMmVlHZ0skrn/PNman73ZucWbb5CD/GqbHOvu7f5Z4v02ybQ15Uv2n1QTH53K
 7Bk/ZgL5Uuz+CyyHAhRafCFQB8I5DGBE0rBSAjQUxjf8eCJjttwT2zvP3V8eTi39XobE0UaG2wI
 WULJg8ToxCIRs0DvOuopqlnGzEG37xt40R4=
X-Received: by 2002:a05:6000:4b1e:b0:4a7:150e:cfe5 with SMTP id
 ffacd0b85a97d-4abb46bc772mr19422391f8f.42.1795428707227; 
 Mon, 23 Nov 2026 02:11:47 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b9add26sm21534978f8f.44.2026.11.23.02.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:11:46 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Franz Schnyder <franz.schnyder@toradex.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH] arm: dts: vf610-colibri: name both modules in the model
Date: Mon, 23 Nov 2026 11:11:45 +0100
Message-ID: <20261123101145.816388-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

colibri_vf runs on the Colibri VF50 and the Colibri VF61 with one
device tree, vf610-colibri-eval-v3, whose model names the VF61 only.
Since U-Boot prints the device tree model instead of the module name
from the product ID table, a Colibri VF50 shows:

  Model: Toradex Colibri VF61 on Colibri Evaluation Board
  Toradex SoM: 0013 V1.2B (00131201)

Name both modules in the U-Boot model, as the device trees of the
Colibri iMX6DL/S and the Apalis iMX6Q/D do.

Fixes: c19981ab9acb ("toradex: common: Decouple board sysinfo from the product ID table")
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
Tested on a Colibri VF50 on an Iris carrier board, not on a VF61.

 arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
index 8c3b86c201f..a4dabc69428 100644
--- a/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
@@ -4,6 +4,8 @@
  */
 
 / {
+	model = "Toradex Colibri VF50/VF61 on Colibri Evaluation Board";
+
 	soc {
 		bootph-all;
 	};
-- 
2.56.0

