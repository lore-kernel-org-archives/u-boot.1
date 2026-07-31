Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8539BC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 12:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47F1960BA1;
	Fri, 31 Jul 2026 12:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rCiEUo5xbgvp; Fri, 31 Jul 2026 12:40:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A754260B52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785501644;
	bh=NzPh0sMKyyU8MljZi99TSHOrv1mImDEVRi3QBHgfBOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gq9TNl9JEyo5656LIZlEuD79rkV6k+ClGCDYe46jQQqr2BeMiG3d3DnfjI9ZLTqVu
	 WXTIvZPBk4NqXMlQUGtSRRE0NxTXohFOKnoYo2Nvi6O+tkKKLyNlIHYuUMqiiqtx/5
	 ZAU+pHb3E7x8e8FL6oiOh/bm1Fu86jV/me4hFn21jNrQcxZbyKh6wYoaiqIuUEqXqZ
	 /u8CKLr8u665FmyymYR9+UA+QGLN074awsZao9sauUrck9dqlEk7B7dHZl18aJQ0wk
	 eugTrRRQnarHn5UeGd+ygGPbJzB9ER6Tf+B8jOOWB9uvvar54aF2R9MNJACwyO2JF8
	 NlbHWSa7/e5Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A754260B52;
	Fri, 31 Jul 2026 12:40:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A632D36E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 989F54047C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B15uoxqF1WhL for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 12:40:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B201F40471
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B201F40471
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B201F40471
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:41 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so1254655f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 05:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501640; x=1786106440;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NzPh0sMKyyU8MljZi99TSHOrv1mImDEVRi3QBHgfBOg=;
 b=AxBSvmbPlleOHIWOFVq0YpdOJOlUq1YcqbLcSh5s76wefbBp0SWIJkov/EfSpwFVq0
 tgXYjAGjk0QfemQfELgQXehErxpMUye0g+NTubqZ5idGnpbTH9d1GrqUg1y42ua8P8dK
 3+nQzKknlS8gRCtrM5ypgAWO4lB9gNKkdBvczT/8wX0yA78VX9tX0icE0IRYkCZ8jp7+
 LjMIsCoXcPgEGOTreUzxs9nbyncf8lRaJFJPClKl+PtwLI7LG4X6Q9QPSMl5tm2Y+YrJ
 Fso/pC9w8tuQJoKdPpMcfECUpMWnjQkhd310CDH5SF0YoPK/TDLaLfrBL7b7172DBfrl
 nl4g==
X-Gm-Message-State: AOJu0YzdVhDVdw5Ch4GvlohbpXuVZKg6lO+TsnLJbI2yo/050ebXJn37
 wsillEq4z3c5pMPVlz0Ylp1jncNlwRQ78OD+txn70fT6qw9WKTSJJql/knLtyApYZJs=
X-Gm-Gg: AR+sD10lEytkxrl+GnrkJmHnQiMdUCA8ns7KUNWtHURAnEm3DKbDIySpthU8CjNIO1A
 sZ/Ah7pFM8aEsEqkoF7ks/iIB8RgWw8eFGnwO5btbnIBzPM2qH5DnXLkUUqwstMOUtJCo4Ys//h
 ZpI2T0GBCCvcxlwVU5TshZDyfm80oHDAU/i0wcxCuklPssviWj4MaVfmqCbvv9J+TlTwKEimxAI
 FXmk0Ms/rNbiVW85z2x2BWCccnvFnMipndqf39muNY4r6jtAR1jeGR31hFw/OF02djDorKP+RFF
 IXLmXCQHzs87k9jHDn9gcu1CIfwvkmEEQR50mye56AsHXdfDwQ/Hb3SBLWmrQBFcvrnaNlSI7Ob
 8W7v8Th1a0LgUw96XSDPNM4T3otupBYsX4Z6OjZg+gJaxOa3x/Ae1Ie0/cVliL6MnGPPRFkMul3
 5opB+jpbe4swXXHEs8xo7idZmFAmKJAKQQnSE33LICfrBHwzhXyXpVsztvFTjrGrHoGXK4PhVeN
 u00dqVezdcEn8F7v3/Vv8ZOLXJ7sNdag2Hg1ZDPt3j8T8SUhpZy2AYcXc2z8n5e
X-Received: by 2002:a05:6000:41f1:b0:47f:96e3:5322 with SMTP id
 ffacd0b85a97d-47fd33839b4mr3555437f8f.7.1785501639713; 
 Fri, 31 Jul 2026 05:40:39 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm4493682f8f.12.2026.07.31.05.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:40:39 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 16:40:01 +0400
Subject: [PATCH 2/6] disk: part_efi: Add missing endianness conversions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2192; i=alchark@flipper.net;
 h=from:subject:message-id; bh=lw2eo768+j8YoiyrdRhrYRND7OLjKnj2L+fkG0D969w=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlTN8VtegDZ5joZbk8Pu0Db058LGMxfBPrnujOFrOu9
 udcVpmGjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKb6Rjwjw6+AKe/vFfFNa7mybsb9HAfm2GvLvpckbbD4Kb6NyW2faxcjw8T2mu2
 lXye2Wdz9ud78K5utwiS9lIkff4qcOGIX9lLrFQcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785501640; x=1786106440;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NzPh0sMKyyU8MljZi99TSHOrv1mImDEVRi3QBHgfBOg=;
 b=VEfRCpvIaPgtZsWVBHB3jDArnzuJ7YoK8c2J/ZUZ1JUsastBc7GqIYStgWgopiJdBg
 QNcp6clKFxeYBOF95KS6k/Icflp15CkH30Jb5M71jj+IFlFmxu9iHGVrVk5qNgwE1eje
 YxArcJDTjD7WzM6E83jIUG6vAROC9IcYVfQNoDh+8EiRmbWjoZSM0OQsuBCKrIiVWluP
 E6EtPPo35e2ccBxwD85/038qvyu7j3+iaF7U73JN1VkpZ0klv7Cg9pAijVQS3u+UYcWU
 IQENMzi9M4cEEB3zdyA65ZScKtCnjGnKdzVap1ow4249KyImXGCfnnfh+4ACML4+bZlf
 BVjw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=VEfRCpvI
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

Several GPT header fields are read without converting from
little-endian, which is wrong on big-endian hosts.

gpt_fill_pte() takes my_lba and partition_entry_lba raw when working out
the region a partition must not overlap, so on a big-endian host both
bounds are byte-swapped garbage and the overlap check does not do
anything useful.

gpt_verify_partitions() compares the loop counter against
num_partition_entries raw, so its "More partitions than allowed!" guard
never triggers.

It also swaps gpt_part_size, which is already in host order, having been
computed from two le64_to_cpu() results a few lines above. Drop the
conversion rather than adding one.

All of this is a no-op on little-endian targets.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 disk/part_efi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index af311867a285..062389c3af0c 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -462,10 +462,10 @@ int gpt_fill_pte(struct blk_desc *desc,
 	char *str_type_guid;
 	unsigned char *bin_type_guid;
 #endif
-	size_t hdr_start = gpt_h->my_lba;
+	size_t hdr_start = le64_to_cpu(gpt_h->my_lba);
 	size_t hdr_end = hdr_start + 1;
 
-	size_t pte_start = gpt_h->partition_entry_lba;
+	size_t pte_start = le64_to_cpu(gpt_h->partition_entry_lba);
 	size_t pte_end = pte_start + gpt_pte_blocks(desc, gpt_h);
 
 	for (i = 0; i < parts; i++) {
@@ -851,7 +851,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
 	gpt_e = *gpt_pte;
 
 	for (i = 0; i < parts; i++) {
-		if (i == gpt_head->num_partition_entries) {
+		if (i == le32_to_cpu(gpt_head->num_partition_entries)) {
 			pr_err("More partitions than allowed!\n");
 			return -1;
 		}
@@ -877,7 +877,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
 		      (unsigned long long)gpt_part_size,
 		      (unsigned long long)partitions[i].size);
 
-		if (le64_to_cpu(gpt_part_size) != partitions[i].size) {
+		if (gpt_part_size != partitions[i].size) {
 			/* We do not check the extend partition size */
 			if ((i == parts - 1) && (partitions[i].size == 0))
 				continue;

-- 
2.54.0

