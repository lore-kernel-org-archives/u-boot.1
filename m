Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEDD606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pjK+2VfY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V/qlfocm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2432440A51;
	Fri, 23 Oct 2026 22:31:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r-XqGnQe1AoA; Fri, 23 Oct 2026 22:31:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6866D40A6A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792794678;
	b=SMXgw5X4DL+YzFw3WLBm0xOkZ2uM9C58r45PJaW6pCUcHGkgfygrG0K7LtKNHBGh+VUV
	 UoEBthl0xnUW+NKxXqyUPFDt+LroFCM86wZdY8s3lzrmNQATpAPiGXJ2SHcxqfB13oyfy
	 qiah7zeurAQdT4mhJmTX5PqS0E/vhy4tUtqDE6FnTEo61SbvgAOg6C3OEvi2iYqjH9zLs
	 v1FaxtuTb+n1DNiu902w6ZRT3eKzmXksg39Uf91RFDLtA7MkwZKVDqKp5pq+C9uCShUti
	 mxjGmgWM9YWIBGi88CoGgjCU76hBuOmq0f2s1iunn+wwjBSuW23yPWwdwgp4piKWtUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792794678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+98kgI4Sjqx8lgjMGRrKZJ8IeE3GzDeP5GHdxUQZtMo=;
	b=l8daVvThGgyTtfXjd59CSfVATQ5D6n5rgipdVcRE8ooLRLk42Mu10/1WfdcR10a3FmJP
	 CEfjug48HTUk0ShaxgYFXd/+UG96HFkLFRzRi9XIDi0OctOPgaF2sq3c45l0fn4xLhi4I
	 PxNKUPeFTGl2VO326S+gCdJcGUq7ZAWx3tSF3XRojkA3I1HvOvW6fYKe6WJS2WfPzlJ3q
	 SGQKB9Q5V654O5YUXEGZjlrVIhrvQ/BbseZkb792ae7mzB9L6Mw3yr2scuJj4+x3aGJOe
	 noIfr/ID6y5+mdZxQh9yVUzJrTqkmHqWfEHzZGvVB0mR4tiQtFUY4ch5dVOLViYLBKA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792794678;
	bh=+98kgI4Sjqx8lgjMGRrKZJ8IeE3GzDeP5GHdxUQZtMo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pjK+2VfYu77NX837UrNZPftfoxByxJ3+l4VU3BY1IDY2TPLgRCh7U45Uc5dJlvT+P
	 lJxLgEzvditap9Njg51qGX9WZJOdiMt0/ITE1jxmWue1+TKvAjRUqru+nydR/6AuRu
	 muso8iKk1jBE4Yz4RuNiyECprOhIAmuWiGlUMXgTBiNO22hvxjhKeKzS356z4bHBmp
	 WJzI843RDCQ+R/iTzIgHb4MUNMA11LzVlQnNG3P5w3ZbogaJfjEtSsb/LGGR1f+JuU
	 x9ZPwZqIu0Q5htmDKNWI9I2393GZakUbCoCB0zeanqAiIhiIzDv2Sk5YBnsq0JKpyc
	 MCUCqmx4hf1qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6866D40A6A;
	Fri, 23 Oct 2026 22:31:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5308D79F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44B3E404A1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:01:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id grj1oUjCdEjR for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:01:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 37DD1404A0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::12d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792792901;
 b=NwPyGlEJjK9WDwREMyRNrFVezCZBcCNhn9kA79mFcxrcAluaJltqDVAzp7jtOx2z8oa4
 xHAx3jz2TsLMWRA9ycNpJVMt9ZAh/dRVx1F94F4114EgMZt7r3MJkLu9bDR4MU9PUhHOo
 GXcjnarRekwOyo7pmtpny4RcoIdY4hqkizi/asfnyAoH4Jiyh6mlgvAKhKDP/oWBNOsmt
 qk5lR+nZHcbxLcs8VIQRIl+EgDzaOS8om3ATUoqwHPL528NKSj7gu1jU4rMoe62dJRgJb
 YLkB7i6H5WKxWj9kLsIkBakMnqhu3xhBEhc0z8HTzN+sbVcZHkt+iziYb/EHJYd2Udg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792792901;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=+98kgI4Sjqx8lgjMGRrKZJ8IeE3GzDeP5GHdxUQZtMo=;
 b=ipW9QRe8vFE1/91lVgkL5rCvXBeV5j6NpUTODhoASSkGVAU8R5X2c51rcJST0VzbPoIV
 wHgI2fZvmUReD8hINaTQdKehcgIgMhfor/kqNVm1JoZptvVXHSogkRxipnCZq9az8riUK
 UFgtkf6Z0n8xg3pfKrE7fuLS2mJu4mMphNKy16ebvdYA3xryVHzca3OvICdv7WqfUE0yG
 UUtPOV5fhxeX+7P+fn6nusWZfMxnk/4hJzSDtJeZkpEXyB5SG0htrEKpYzYR5QDr0Z6sI
 sNenAEYg3TIRgIZiO0LP0tuKBWWu5IrcG5/UIyCii87Ij68OHwE18hjqRS5OMMQ+cKw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="V/qlfocm"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::12d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=V/qlfocm
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37DD1404A0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:01:40 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5bce4e278baso1825184e87.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792792898; x=1793397698;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+98kgI4Sjqx8lgjMGRrKZJ8IeE3GzDeP5GHdxUQZtMo=;
 b=V/qlfocmf7GBlnKFsXsaupIVmOZTYmIzJ7urMUixe2mrEuUgZhBPoJ25R2qGwFahk6
 vZgrVjy6MlvwVUNVlY5/mF9VDTnZpUKEqZgXb2h/J+P5RzlmpHA90qC6fGsOgcESGzoN
 T8EQUPtvL3gz3S09YYbgX8DZsDtwovXVO+XG04Vf2t2NmPBAEqOqKHKn5pdoGEywEhWv
 x4l1Cq6BRermp8AGfFoJs6hDng3/SfQsFLPC1F9fOoVxmnAvPCN91giVoWU02Ri7NeP0
 WYABwYzEGXZ04/WAn7qO17/RymWCyQUfhGtzEXq2IpID0w/t4hmZo7WBq9Frq9szrUr1
 Vbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792792898; x=1793397698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+98kgI4Sjqx8lgjMGRrKZJ8IeE3GzDeP5GHdxUQZtMo=;
 b=fXcZ/036/+NZhdSx5VGezWcVz/FpCZiyxf7G6px4dzIxEku4QNGx0HIfuFjQnwon/1
 GUr+83Spnmb/LSx9dBZPD6PoyBmjQTgGissYVxCkSmLSB5AqBsdv0weA4KClfBxxQtyL
 A02ryBu/1nwFV+vOWsF1108kIelFlyDMsdhWs5Wc26wE56elfiOPfIP6ZnloRgAC/RRE
 DKWiVb/cqs8VhFsXBw0q5eEJH3vDQv9MmR5RD0VGVkbs31rtOe1oSiI9l8kT5BGsckVn
 rZABnp6Tc+1bER8qo3i98qkNbwJk1KkTDbHyQ95iQZsqRjilnwGvpZT7QHt65i5AmNst
 B1tg==
X-Gm-Message-State: AFq9FYIuMIVr4Lypip/btJELA4wyDhc3CWm/rCXmYuQEO/AzYqCLFscK
 c7T/dt0sKUIQS+GAesNFOz3as/iYY1E+ld6VnPpyXtCOEhuFoJPd+VeW/T3e+w==
X-Gm-Gg: AYBFou1h4zJLxjvqiJG6V/w9U4Def4GYz/NNORANb0h+K8yy2eO4uM8P5EdWegnbBOT
 vJe/bM+G1rwwtUWxNr+m6FicgF2HYGR3w/iDGW/eSSVy2d4dVJYxMAU3Ov73R9sktDZWL6Vn6nQ
 wDtGHWQDExqY82GB9fC4/UO46/jPNW2wlQSjasXwc8t8h2C9PC3D0UdrYoOenCd118DsIh8yCzr
 WHVRQB6vmyi8+0HGhTS4zjhFctOh6jKajq0LksdkXPc7I+yHVH8FdyYeizzx9LZ9vOY9E+WWrS9
 MxbM4W7mg8JSzvhWwNZFNdkeyr2FS3rE6EK9EGJ6IZKcVp/FmXgAMFVOjSbjTDyDSIi1Eo8XkAU
 hJ+JYew/FAFgHI+Pgpz40uVCN4TjXAeth4UMmm2xgPCNe4U2QqgBycmfKUUTeeu9M81Yi8J9mMq
 ZASBry0CMGx36U+fnoe+TSeLVDnzGPaAS17p8hzPYM8V337twjvpIcf3Y3o5jVj9UlmpqAPQxb6
 2aHwAGnJf6ycrkz4a41bwR1jcSdAZy7h7yLafpe+baryBYzUrtBc60Rvh1vyq2oQ3qpSS+6r32w
 F198n3pjrsaq5/nWpRLqZbeap6Ifaw==
X-Received: by 2002:a05:6512:683:b0:5bf:adec:227f with SMTP id
 2adb3069b0e04-5bfb71fd6f3mr96186e87.36.1792792897858; 
 Fri, 23 Oct 2026 15:01:37 -0700 (PDT)
Received: from Thor.lan (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi.
 [2001:99a:a58:9b00:9119:221d:45f0:de83])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7d3c227sm8570e87.16.2026.10.23.15.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 15:01:36 -0700 (PDT)
From: "Maxin B. John" <maxin.john@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com
Subject: [PATCH] cmd: mdio: check argc for extended mode
Date: Sat, 24 Oct 2026 01:01:33 +0300
Message-ID: <20261023220133.1396280-1-maxin.john@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 22:31:16 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check argc before accessing argv[2] in extended MDIO operations
(rx/wx).

Return CMD_RET_USAGE if the PHY device name is missing.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
 cmd/mdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmd/mdio.c b/cmd/mdio.c
index c0a87087d315..1d73a77ece35 100644
--- a/cmd/mdio.c
+++ b/cmd/mdio.c
@@ -230,6 +230,9 @@ static int do_mdio(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (strlen(argv[1]) > 1) {
 		op[1] = argv[1][1];
 		if (op[1] == 'x') {
+			if (argc < 3)
+				return CMD_RET_USAGE;
+
 			phydev = mdio_phydev_for_ethname(argv[2]);
 
 			if (phydev) {
-- 
2.47.3

