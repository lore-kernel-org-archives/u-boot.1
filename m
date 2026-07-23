Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106ACC531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB37640A14;
	Thu, 23 Jul 2026 15:04:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dIitOFfrFLT6; Thu, 23 Jul 2026 15:04:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E25EF409C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819089;
	bh=h/+4LM9P3F7il96BphemaWQoYYU+6cPkExWQTLkjjp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mcdgIRGTxM0NokdDgMOSdVNZoshOkUumvczgob0bSJDpq4G5Y1TqHZf80okvFBnmW
	 AidlSkQZC+9SjgQn+zv+4jDG2bFr8bcPJ9lXEFqf6YmbXfQgZCj7OAdHaf0YSYuMg0
	 wqW70q7CZTpWK1HV/J70LW3xlVS6FXbTuU7aMGLZqPA2AeFSCpM8yjDZdBMpOkqH/g
	 0GCe4sNbLRNKrfdoFSvOR2XGA5Q5GfXjfvOtaZvn1ZMelmAq5QA5xOKQ2NNTJBkXxo
	 NtPGxscSl2EpmHLUN7Hu0+J1OoWXpql0gqH/uFDko0mqhrvwtvucd1jFiP2R+82pqJ
	 7i6+2BeBeKNAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E25EF409C7;
	Thu, 23 Jul 2026 15:04:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 06BF7429
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E091180CB1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQzfRb-Ewb9E for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:04:46 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E476280ABD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E476280ABD
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E476280ABD
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B319803F6; Thu, 23 Jul 2026 17:04:44 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B5E80087
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 17:04:42 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c1c50c1e29bso110592766b.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 08:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784819081; x=1785423881;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h/+4LM9P3F7il96BphemaWQoYYU+6cPkExWQTLkjjp0=;
 b=CwLuQRdolFjtCn0svunpxleAEfLihbww6XWeRnNX3zrVpXjd/63X1Lgv9gBjdKERWA
 H/0wfpxm6qOWTnknLFwzQLI1qLKBzgdnwTeoSSGezD9Bne2GISdA30bMElSRYYy+IMcf
 1ZzqXVWmMhcGodi9EJziT9qh3Uu4jRxnZ+z+e1dmKkx458AEYSO3gSFxYMUiWLuSW4RN
 EHXBMHYyd4vP0P5SsBVNf8xy6ei55ue/Lc13YGk6J0ghVkGmEgcra61MmSX7zskXY6OI
 iD0mbUBjw7HC1jAIEmoqu0b405hgc1/W7+SmDUtdbu3Crh5oVaSIqW3ttaPzBj6pn8i0
 rpzw==
X-Gm-Message-State: AOJu0YxbLcZzvZ+KGHQG/edLvG9SkjowdCrDzJW2bt98EMj7EWnEDm3D
 3UFdSflVUe30Lku3cRizfYN8huhH8+FwqWs31iMyYE4IuKOknY3SqGjFQwlY86bFrDs=
X-Gm-Gg: AR+sD127oDupb2Xgyr8ySdKBJOBZL+N67eU6oxLxa0hXPIGyzUFa5xCWS9zfTrn4GCC
 dJKhPYrw4lI17LHkLTVhszmBMvdrrnQ+af10BRAzNSXkkTAL08TD3vKgPw/HpDTrdOvoEqcmQdJ
 8MBNJps62OtvSTbabfKYTxpqwLkxaqs5rArfVTKTRakcgfCGxDW29a6NcdGR08y0m3jQ5srtMi6
 H4fka2JuKM03lWB7afs7k9c5HMWmjnBqBhurQNrcmSutgsLCWSN9eD5gWNlLzjemiMMi/x0aadU
 Ga6UdukLy4AyZ5FpHNqikW+LURVeVSKMo94F8wpVFwnvKIlhuEE0lExF8EebGyJf6PFSG7jtapb
 8rVUj3SD22+zrIlPc3Idxnf9+zPp2ha/qz3wf0RS2l2zQTaQ/DL18VOl1VfwDvMKkQ4ymoraMrN
 9KyaD/61jSFGylOvJYN+10Ow==
X-Received: by 2002:a17:907:d64a:b0:c15:deea:a178 with SMTP id
 a640c23a62f3a-c1c507ac77cmr156834266b.25.1784819081491; 
 Thu, 23 Jul 2026 08:04:41 -0700 (PDT)
Received: from alchark-surface.localdomain ([193.32.126.214])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32f1127fsm248769566b.55.2026.07.23.08.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 08:04:40 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 23 Jul 2026 19:04:23 +0400
Subject: [PATCH v2 1/5] clk: rockchip: pll: drop misleading fout in
 rockchip_rk3588_pll_k_get()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-rk3588-fracpll-v2-1-382d113f3a80@flipper.net>
References: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
In-Reply-To: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
To: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=alchark@flipper.net;
 h=from:subject:message-id; bh=VWDigwXp459/OMvyRauAK56LwIr699nL+XgbjsfB6MY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQl6Vavs19fevT+0tkbF2zifLhI5N2G8zGH7aQ9thusm
 CN+e7X2lo6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BIx1jHiIGLUwCmOoiF4X/Ul9iT60I0L0m0/looZ7/zhsVNcevFBkrf2qTXmpRwXQxlZOhaqWd
 V3eQo3KORan2ZLy7Yq2s931mdM+KTo5y/PrkVzgYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784819081; x=1785423881; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h/+4LM9P3F7il96BphemaWQoYYU+6cPkExWQTLkjjp0=;
 b=ve5hrscNw5J3ayjBcBZoqXgPpb9uN19MkNmCyCl9F1zJaYP+Tzmh/ZRNGCo35NWxFk
 bZ4crjYIQ8JD8/nI1S48AOnaO2uLS4ymwlu56nPWVgFQzhIQ3lhCt4j8N9HakxfZ3Jru
 jKvezKPMAk6qty1ym/3lfS++x76gZmDy6GnSWjXnAxQNtpUKtNApFYcL5Q1sF6K64/jm
 6MzxtUC+FbhgFCnfLwfWATFnJhLpnxS5rVzcyOPOApi7UHFO752awMLUTy2qu87bPFjH
 JkCeo9UrOtKV4G5XrPk8wk7nWCqvy/bI1ovulabUj8TsFcwRM5TYH5ybmnCVfA+e2GpZ
 AGtg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ve5hrscN
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="ve5hrscN"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The calculation in rockchip_rk3588_pll_k_get() uses an intermediate
variable misleadingly named fout, which is not the output frequency.

Drop it and inline its calculation into the k assignment, which also
improves clarity. While at that, also drop the redundant reassignment of
fref which doesn't change within this function.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/clk/rockchip/clk_pll.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 9dec40b1fe83..d0df3b8fb49d 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -169,18 +169,15 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 static u32
 rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
 {
-	u64 fref, fout, ffrac;
+	u64 fref, ffrac;
 	u32 k = 0;
 
 	fref = fin_hz / p;
 	ffrac = fvco - (m * fref);
-	fout = ffrac * 65536;
-	k = fout / fref;
+	k = ffrac * 65536 / fref;
 	if (k > 32767) {
-		fref = fin_hz / p;
 		ffrac = ((m + 1) * fref) - fvco;
-		fout = ffrac * 65536;
-		k = ((fout * 10 / fref) + 7) / 10;
+		k = ((ffrac * 65536 * 10 / fref) + 7) / 10;
 		if (k > 32767)
 			k = 0;
 		else

-- 
2.54.0

