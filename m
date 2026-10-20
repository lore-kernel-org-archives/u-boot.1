Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F8606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rdcBUUCY;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=hKIgoHZM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D430C409CF;
	Tue, 20 Oct 2026 17:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rEM_B-tkXfnS; Tue, 20 Oct 2026 17:26:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2743D409B6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517191;
	b=rScVIVyGpnsGWZJfdIMr5b20cTnMMR5JLF7iD8VfmbIdtUWbDZwzOwCjuvmpx7wQCW1v
	 1fuAewCl5fSbykoC0G23+6qOgek0jZhJWO52wEluhCohsNl+LZl+IhvSRT8m3Ljk3LNT6
	 q9ay6wbC3czAN42X87Q3H8DUMq8apqGuuj/mDL72cHCwPuNQydLSlv2iJ2wujgyGwT3Ky
	 G5ns5SsNs1nzhhcEDK6+E48T4AdUxnkK30DFKlJ7SvAvZ7zoQPG+5Ve5d4omm0gJOoQvQ
	 XFHZsABttMQOI9n1kvI/4sSGKDWLJ0AHjOYk6jIXf6VMh75/wRYl2bQ5/3/XmCJXsag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517191;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YNIVvqgM3Q0TbTizxdlwp0d8kj4umwpVoXFVflZLY6g=;
	b=qay+DI+yCzbVycX2Kxq+R2mhWSAqW9Ancua0PnZNULY87l82oUoMO8oUHPKfmNHCxN4Y
	 /lq8tZ+GN6oTMXryV26DjQlsVW00EhbHlSvipVWtnuwsr2geaLCbArJikF/t0+bUPLye3
	 /1aKcVsFmF5bxxCyVRA7BJS9bloNPV6p8N8+8+iNKwkRQIvJ8qWKHW0/u7RtZHBvC+sM6
	 dy8oNdgC1kopxOFjjtzbdB1NbZCmyfYmAHUpFiJWFN1xeBJZGCe0vnp+nLN83PGgPjchO
	 mavme3+S3nnUrCnDeXhhe+t1nuxtpfdWA8x8HJy7FI8aI2x859GgauEkbvMzKOS1ZqQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517191;
	bh=YNIVvqgM3Q0TbTizxdlwp0d8kj4umwpVoXFVflZLY6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rdcBUUCYCvCqGZCOhnrve78jhT6kG/nB6cq95YBEcEbg3+ur8y/BQryOpQppqXuyW
	 q6fTXXJCGoihKV85hTLe8v4Os4gZzlybFoBErNho4JIPZr5Qu+XX2ZbqL0v8PBKv7S
	 4e2xI4tpz1pgtIuxQOLY99Iaasbg+qjWzZ6LDAyDAzHMLurkOjrpdcVIcDN4K6LjaN
	 fLMAgPKhhykyZaPwSLNxayMFdj2CaVjaB8AJiokXT9vRO9qgx7ZcQ2RX+1ONbVCtRT
	 28//fDzZG2tQQ6gezg0ypx4VFon6M1tiS7Gx4i0WmE2bsy7vAGxnE8riHmN86zLK2j
	 l02wxKKdd/oNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2743D409B6;
	Tue, 20 Oct 2026 17:26:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA716930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D061060773
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9mE5mpjSr1me for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:43:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB6AE6071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514588;
 b=dHNCp1LqZPv4XoQVYydiVgLWjjBClGxGKaMkEyHC8fbNCYBWSEAomZZuCLqIVGWrHsst
 1+IlRpXFIuHbzd3H9QVcyMhbOaRg02rcUQJGbs6ooj6EgxFKsMkSD30wSoAXOWhjnWwQe
 EMQqQHJubKCs67dqPPsF0xO6VDD6XXJlpqsyu1UasUsiNiXhcyEUfMh61UtAy7mXXPdL5
 TTCn66kP+WsFg7/FPtDscGbcITe7uGCsS9eQ5IZfFsYXIWW3kw13chzmEGqZkMI2UaWxI
 UYVWRKgLYqL4IMkix5VUOgkOSadpLHW/ospda7Tgbq1uwNnrEyHNfBrw/UUG5iR6UYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514588;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=YNIVvqgM3Q0TbTizxdlwp0d8kj4umwpVoXFVflZLY6g=;
 b=QMS+ncBJ9AOpR8Uq41ugbkHYi8wrWnhGr/U0E1K914E4tBqBjBL5cQd2Lb6vKY4g5wWR
 wi6zm3ZwWJ21XyqCWKfs5go2fRt9YSmOqsSEuhdu8wUSezPEP+QNdWOtPS/Ln7Dt2mfV2
 bSFBiePSN7j168wv33D2V2oMlvOQYclj75Jopu3X9iAb4my0Gw+klsb0xqORbvKFmShCZ
 /QmZOZNyva0CPNe+WGAT1nlQIPO17fgjmfzpi2PuKFP2FyZOzqp5bx7+sDzxOmnd8pSAk
 wDYPuwWVcVBKmj3oU3aLdb/NhOOHlVXwEGL4OwvEDwVtSWfMSDipS3XwQPT5wZpCRWw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=hKIgoHZM; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=hKIgoHZM
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB6AE6071D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:07 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so18190675e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514585; x=1793119385;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YNIVvqgM3Q0TbTizxdlwp0d8kj4umwpVoXFVflZLY6g=;
 b=hKIgoHZMp/51iA8OFkywRvr/hhAUphlBygivhpUQco83mzIV/gc0N02vKKWrM2HKfJ
 WZVNkjwPlwiYZRFKaPPDXDDGB21NynAAK82fj8qAM8L/w+8BCZ9pht1doDeagqzHugxU
 COkAiyr3JYJ0c9AtWw82hTA9QTg0Axti6PMQJY55Vc8HHzW+vuJacNO1esFAPTk6N0al
 DKeAj/urj3LVH0sQfRefHdfbvKWLCKQwPXkOsXZdjh/rEuapBin5T7Rwh4lgl3CGooSP
 k2KHLC+S6ArKm/CSjzxlIq+nHYzNDXhnI94CIZlcH3Jx50/F1/IosYR4swe46R036eKe
 /DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514585; x=1793119385;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YNIVvqgM3Q0TbTizxdlwp0d8kj4umwpVoXFVflZLY6g=;
 b=O7tGByDMDs2c5R5zD6YaKoYyDCm2m95HJNlCrXpkjnrGLCzZvHQVqUmhVAkzN4l2Nz
 jC35yxbKMaxh7tyeRnJI5Y9BKLSiuKzV0kEPSy8Z9Fnlujy+FE1fkjXI/z/x7fS/lB1w
 7fgFyTeHjMuPGdbx2q1dGeDOEWNrnKcQcleyQg9ldKWrhaNGA5fqDbBdDP4BPtXr/pTW
 rCu7GvM0WJZzTPbHzrFOyY8MjGUFALmWOtKz3sn1zv0rtgp7KjmdiFq3BKqgJWgHp6WD
 QwNJTtpoer2jbxQ+x5J1o0YFBHnXBHGLP33k/l63kYE9BlWR1RMOtjff1wiSRnf/gIvf
 12XA==
X-Gm-Message-State: AFq9FYJ257YSzMDNQfzIHAgQ8sFad6RkqvJYUvqLtWml8FfZl1mpPU8a
 HkI16MOYoCGbkQnDa8bx7nhFRSbRs9xY4NDBFkaWiEWln/XSa9vN5q2zjltjvOBMehE=
X-Gm-Gg: AYBFou1z4W3PcFLPcrrnDx4nYkNUguC4bDJ7k9nsAw5oNripwBbUb7G/8riNmYDrz1d
 jRKGZNcG0pI4zOne33raOnPMJh1LGKInR+LPWaFqaf3pOQDaRg1Q8d9eq92SGKngdO3WIhpHMqP
 S1niXDUIwMtgtUDrLcPR2d8RJXKlCCk5A/goIYIak1bfymV0LSDlCgFcfLiGCJhRbzNe4Ao/8nn
 9GnmIdrn1jngJp/7ex65lx222lUZ9m1YWKSXqnQyHH2GClgXyAsA5eoIGq507dpAdKWCQJjm5Cd
 TX9uB6DLREXnUmcQ0quzu/piVK9K+k6tyDht+rKv0ildi+sdDdAIl2WCB2CUmlzM+zcXp+7G+AK
 aiyDUX62wpEmddjLURf10ZlY47eM8N7HfE4pI6NA1yI8n24GnoiSwdf6nz5kggA7qwi5Yz+KAKv
 d6IYONwANYClbs6C/NvKo1v/pHszmT3GAPESM23isioIwlBzqgEzuTI8ln3lHC935JiC5z/s2Hs
 1dvaPTMg7s98/RHqgvfbiq84LUx30eal93MoMXhV3VQfmbHX87U/Q==
X-Received: by 2002:a05:600c:34c5:b0:4a1:dc8e:edc1 with SMTP id
 5b1f17b1804b1-4a1dc8eee6dmr226076055e9.0.1792514585615; 
 Tue, 20 Oct 2026 09:43:05 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:43:05 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:41:04 +0400
Subject: [PATCH v3 17/23] test: spl: Cover compressed data overlapping its
 load address
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-17-6647aa23ade5@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3393; i=alchark@flipper.net;
 h=from:subject:message-id; bh=eY7JBugSLYFGPg8P/RDl9h1oWCa3XWtuv5gTx0NQs6A=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7k6v9Dz26cz0r6tu87I7qq68u7kqgOKBrG6IjeKL
 03WjVsQ1DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUR/kxMkxrnDdJ+WPnqgVXptjekcn+sVEvza57203BSIbDosK2wU8YGX56Nqt
 WHeWsetwyrfaeV8LqGvcYp/sPMoR2yzMcdf3PyQQA
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

load_simple_fit() now refuses to decompress where the staged input reaches
into the output, either up front or once the output size is known. Check
both, using the image a passing test loads with only its load address
moved: onto the staging buffer, and below it by just the input's length,
so that nothing else can be what fails it.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/image/spl_load.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index d7637507a249..45b1efcb89ca 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -483,6 +483,75 @@ static int spl_test_fit_external_oversize(struct unit_test_state *uts)
 }
 SPL_TEST(spl_test_fit_external_oversize, 0);
 
+/* Set the load address of the first image in a FIT */
+static int set_fit_load(void *fit, uintptr_t addr)
+{
+	int node;
+
+	node = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (node < 0)
+		return node;
+	node = fdt_first_subnode(fit, node);
+	if (node < 0)
+		return node;
+	if (sizeof(addr) == sizeof(u32))
+		return fdt_setprop_inplace_u32(fit, node, FIT_LOAD_PROP, addr);
+	return fdt_setprop_inplace_u64(fit, node, FIT_LOAD_PROP, addr);
+}
+
+/*
+ * Compressed external data is staged at CONFIG_SYS_LOAD_ADDR. With the load
+ * address close enough below it, decompressing may overwrite input it has
+ * yet to read, so load_simple_fit() must refuse the image, whether it can
+ * tell before decompressing or only after.
+ */
+static int spl_test_fit_comp_overlap(struct unit_test_state *uts)
+{
+	uintptr_t staging = ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN);
+	struct spl_image_info info_write = {
+		.name = "comp-overlap",
+		.size = lzma_compressed_size,
+	}, info_read = { };
+	size_t img_size, img_data, gap;
+	struct spl_load_info load;
+	void *img;
+
+	if (!image_supported(FIT_EXTERNAL_LZMA))
+		return -EAGAIN;
+
+	img_size = create_image(NULL, FIT_EXTERNAL_LZMA, &info_write, &img_data);
+	ut_assert(img_size);
+	img = calloc(img_size, 1);
+	ut_assertnonnull(img);
+
+	memcpy(img + img_data, lzma_compressed, lzma_compressed_size);
+	ut_asserteq(img_size, create_image(img, FIT_EXTERNAL_LZMA, &info_write,
+					   NULL));
+
+	/* The image as created loads, so only the load address can fail it */
+	spl_load_init(&load, spl_test_read, img, 1);
+	ut_assertok(spl_load_simple_fit(&info_read, &load, 0, img));
+
+	/* Right at the staging buffer, the overlap shows up front */
+	ut_assertok(set_fit_load(img, staging));
+	memset(&info_read, 0, sizeof(info_read));
+	ut_asserteq(-EINVAL, spl_load_simple_fit(&info_read, &load, 0, img));
+
+	/*
+	 * Just below it by the input's length, the input clears as much of the
+	 * output up front, but not the whole of it, which only shows after
+	 */
+	gap = ALIGN(lzma_compressed_size, 16);
+	ut_assert(gap < SPL_TEST_DATA_SIZE);
+	ut_assertok(set_fit_load(img, staging - gap));
+	memset(&info_read, 0, sizeof(info_read));
+	ut_asserteq(-EINVAL, spl_load_simple_fit(&info_read, &load, 0, img));
+
+	free(img);
+	return 0;
+}
+SPL_TEST(spl_test_fit_comp_overlap, 0);
+
 /*
  * A data-offset which wraps past UINT32_MAX once the external-data base
  * offset is added must be rejected before it is used as a read offset.

-- 
2.55.0

