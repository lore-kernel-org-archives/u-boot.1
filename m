Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1772A606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bpuy91+E;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=rhcEDEYI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F202480F5E;
	Tue, 20 Oct 2026 17:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id opOY8mlrfIux; Tue, 20 Oct 2026 17:26:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B7ED81090
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517163;
	b=tbMDTvj26uzE6KSI0dAI7HXSLq710d0yNmV9BxXqZyw1cGzS+KVGIHf3NJCnLKa58hSb
	 PS0rtO2u/T2rGMpIzIX8MGZ0VB+KbRG5mzmD7A4wEOpvmabDfFiIb1x5UAdDeCvWtta5l
	 AUHkCUXmKgY1Nvm1yL69pWeuaU/eA6ckedzjFJM61NV9uNoVROyWTIqi4mlQ8OnOxAMVv
	 /wn8dyd4KYbyKucEWJQG50tkIWcTsLR92EJQbti9HfuTSurm9Qzi2DOAwB0rqDaDLNpqV
	 45J2JyRIAsYFxBL0UTmSQJf0IHBqRVBJMIO/ZvUccE48gYefY294mBQPAzfpgKKBWTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517163;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FBwNkxVEavEMEwji30VFyWopuGA4b7mHbg5Opr7fFUo=;
	b=Hg5GzPvxoinks9wL/HYl67vSdW8/QIF4fcST2CApxpaDRITjAFHdO3nRj4NP5R/+xe/8
	 PewTu5yjHa+ft+b8fZL7zEcebrIqYUPQhRnU1aXKQJj0ps4D0ielCBweVk+Y0cFCsCHL5
	 lVdJyFvSxabiqy1QY+OaXmjQdXho8+8OfNaCsOfSKy5B8PFu2o2+mq7G1g5lftwkrOXlV
	 KvQ44Thi7IlfqqDmIBJ50RUqsU8UD/vFyOsZG2UaP2xC6GUUDqjh9gGonTAIzusP3C4eF
	 6LmbqwQTYuuV1lg4aL2Qq7WBojJP2ZJB4mfPHkgNKyA5a/R1VA/uXztMYMamMmQ3hYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=rhcEDEYI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517163;
	bh=FBwNkxVEavEMEwji30VFyWopuGA4b7mHbg5Opr7fFUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bpuy91+EvoItuyJeIwi1HgQ0zNUQJN6HtyHp4yZn0F7cUDTp3XphpY5esbK0y2x+e
	 Wjcjat+/yHNTS9MauAyk7NksabcLxnLBxSZcgjix1EsU8LsRsKPFGa6Llm+libhJ/R
	 pB+hQsTAfmfDkZVgSYZ9yj7nyIiPAjxq8ey2BQfEMsKJ9Szr6CQDcjAWzArLi9rUhH
	 KOzsn+5JJ55+oSL+XYjEMuyyq9RF8/rBGZc8QpJc+SdbNR6ZFpLXKOu7nTN4n168R+
	 ymo/H2WdItFjwgpVDBVlbX4fNlRI6EO0CpPlG8qMti/xEz8j5Tfoaz1cMh0jCZOJTV
	 z9OL+BPKwLd3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B7ED81090;
	Tue, 20 Oct 2026 17:26:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 87AB61AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D0E881103
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KeMklUHpTyPh for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:41:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71EF4810FE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514486;
 b=meYeW2YrvwuC8azz6bMyj7ppoQ1AxZDpg7sfHMaYA3Y23ty1JH9XcVGHE7kcV76O/ubd
 tVaMNTQaP8VrZkOIsOiu72yYREqDQIT63mTlFTKLNJDaHd3h51QFLmg2m+mFhoFs+XyZX
 qMKBohnWe0rzzFMgT9xFgxRz4cpkRV2MGfvvlV0Y3IhLbiu0OqzOPAhxDofP7GGeAet92
 DyaL9xYnm9cuVv7Tt0KJhtu4gAdpiqUYIhWGkjHM57qIUOSAG+PqIHGhhn+5ckvjwCZ4A
 ezaRjvYWm5IoAwwZNilz+PKn1fYcBF6GoLca1MclBADBcmF+NyaVrFQHKLpYAqiUn/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514486;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=FBwNkxVEavEMEwji30VFyWopuGA4b7mHbg5Opr7fFUo=;
 b=tbSsAHOHq9y6K0+OmN0bZ/2ubFWM+B7+Sc4tO5a9g2eW8ID1KgPDnjLIICP43EwI6cD+
 Wy+2iFnki18f9oSjNqShMIL5MmhR8JYLrACAgKPA9ZrvbzPq06zpxZqggIWR5nMIZDNhS
 BLkkklRuV8CPfQCSUJuJaYREJP0lHycLqYwsYLFb/oxtDd3sBuFkI/m/ywIM5AFnJn2mU
 ylK871rAHCQLUX0zNuA1dkO58DPKwk8UWOX7orVcheyaYjchiE5kEXCGfDmsXlCl9BFK+
 0rrvi6OqpfYN7d4X+kwNPyTx3O1fiuHqQ4x50igzOS55geweVXIbaucZdZLy0YCBW/A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=rhcEDEYI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=rhcEDEYI
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71EF4810FE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:25 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so29883695e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514484; x=1793119284;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FBwNkxVEavEMEwji30VFyWopuGA4b7mHbg5Opr7fFUo=;
 b=rhcEDEYIUYdXng7zDFNjtgJIaboIKHJBsXO08WEWPHPM+yLneqZllxtK0Aa4flY6qU
 a7WOJlJ7maFUMRKhFWPAZr0BWwg46CpkaniottagbtZfcLFj4lqwiKvNOWLu1l4YdL/b
 lvU0Mg6C0Nf+zfmTwuonTTboErNZinR1xMPK+ZOAO+UYLJ42kolU6Fkie90AuNaAXcV0
 UcL6R/BkYh/9wHgoiGTLuS8iXDIRPj5PBg4DE2Gg+MDAU8k4JikHMioQHHKjUzJB2n0R
 UKztkhgukizpVLDWQ8b4Ob50zkxDQ44J5xJwdSlILurwcsxWLw8QH/JokO1HsnNPEhYG
 YIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514484; x=1793119284;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FBwNkxVEavEMEwji30VFyWopuGA4b7mHbg5Opr7fFUo=;
 b=TyyXeEaDcnO0zJnDMva1bUXbxdTmn5T0H4+C9iJA18QRY64cusdZ/3+aKbw5+atuJS
 /Gpuyw1eYsBzWlm17+YoXcaDhZTKPBJZzqa1O5+n7VL66ynSOtwBYwhghGIL3KA//x7K
 Vy0Ke8LjgLcDAFLk+EVAiLSctdm2JxXmAA1PAJc0c3RWCIjBDL5DZOBCnpMoaQaTTdmP
 qXmd2CpIPkE8xUd3IsFAIzx6bEA7E1X0dleWKCDNhZHt2K8NGlvAYlcK7UZKDolFgbMw
 7jKvRpoE034HyznG1DGNVmg5Nc0UToKAFPaZxX/BgNYR/9U5gYB9Oo/tSG1L6sFSyABW
 qSwA==
X-Gm-Message-State: AFq9FYKaXwGV6DLWM/ZKzP8BLe2peqNgfvRc1h1iF5QAR5iAiBaaWq/W
 RwwoaUNC3BvSwYdiRhA9SQZsSAXHWdgnZqMt2BZ0F7kjQsmz2cS65nh5zMKR0lK9EWg=
X-Gm-Gg: AYBFou0hGMhJ2bRhcwYmbJtT5ZsPgA+PTDDbJsetcRkCU0XBIttA99EiH9i1P5ToHs2
 A6JBQo19gBVK55ytvK16bZS9Sokvwg5VVJmhWo5FSoqQDK6dDMc9A9g+fqXGnc+ds0VjFh20zbc
 1s9cdiKnE3sMow9qiMDRFZfTr8/7b7CANBqChmvNdjSCDwNUhUqZ3mEirSQKRenpghnXazr1Rbd
 /66D7adjWnnpT9TF8EdA4bVR26lBobkkwWRaulb3ya+rFTHvxuqMFf3pDlB5VR7Bd0oXHwhZnBU
 QAg9amGj5TAtL1eZylwjh1mCa5g7mA65sesaNMONsg51E3VPO+MFzfRnDaWX8hENk45rxJ6bF4h
 kkDyrfNR1hOGljFBc7IU5xGv8sic5cUpR3Qxu/kd2iyBOOqcoCyAgXgw8O94nnVZRSw5syvxAwy
 5PFcN3A0k8bvsofpeXg0V54+C8xAo0D3Nmx96bnY+9Seg1OyWApPDb9UPKQ7h6qQbsMhc1gUJsJ
 9Um4IqDgjp0qq3fQc8bPZ3HZHVWVPeyXwI/lW8ujAQfBwSBQ9hVZw==
X-Received: by 2002:a05:600c:190e:b0:4a1:90d7:88a8 with SMTP id
 5b1f17b1804b1-4a1d76106c0mr249581925e9.25.1792514484028; 
 Tue, 20 Oct 2026 09:41:24 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:41:23 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:48 +0400
Subject: [PATCH v3 01/23] boot: image: Keep the image-type table out of xPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-1-6647aa23ade5@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=alchark@flipper.net;
 h=from:subject:message-id; bh=egIJ1F5VFrhTWy16+F7BTTRbROARKQlRuJEbvQ8qy5M=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7lyadu0XEljfn6TuowrBRM8G92uKO8X6c/VtzlgF
 3zZfX5Ux0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFO99TYjw3sLkf8s2ctaVHvy11wJvvl/vRHXvgPbpObbprUV6E+2O8Lwv8x1fvB
 796+aFUZbrAJqnPiORXb+sl28+cLajoMZubN/swAA
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

print_decomp_msg() names the image it is about to unpack, which drags
uimage_type[] into any phase that links image_decomp(). That is 650 bytes
in an arm32 SPL and 1266 in an arm64 one, spent on one line of progress
output in a phase built for size.

Name it "image" there instead. U-Boot proper is unchanged.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/image.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/boot/image.c b/boot/image.c
index 185d52ba492f..8a031aab0c1b 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -416,9 +416,14 @@ void image_print_contents(const void *ptr)
 static void print_decomp_msg(int comp_type, int type, bool is_xip,
 			     ulong load)
 {
-	const char *name = genimg_get_type_name(type);
+	/*
+	 * The image-type table costs up to about 1.2KB, which is a lot to spend
+	 * on a progress message in a phase built for size.
+	 */
+	const char *name = IS_ENABLED(CONFIG_XPL_BUILD) ? "image" :
+			   genimg_get_type_name(type);
 
-	/* Shows "Loading Kernel Image" for example */
+	/* Shows "Loading Kernel Image", for example, or "Loading image" in xPL */
 	if (comp_type == IH_COMP_NONE)
 		printf("   %s %s", is_xip ? "XIP" : "Loading", name);
 	else

-- 
2.55.0

