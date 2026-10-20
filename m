Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13219606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KJSAh5oc;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=EIaOXWbw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFC8481118;
	Tue, 20 Oct 2026 17:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TcF6aAe9S0uy; Tue, 20 Oct 2026 17:26:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2314F8112C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517184;
	b=jz0lbQxu5uXYKqDO2/aguOEdY65HarWGXKEMfQri2HKuXxilvLX1vK4L9hlvxVvF2UjB
	 tL73fIK7FTJr5x+bUHwj/89Il5ZowtgywnZm6fA+XfqkM7g1Nw72zrYdr4kQ2qc9dx3Qf
	 A5qTJ0p81VWhdl69ETk1uaVQxbBCsejsE0CLExwhumPOCP/1Kkd4T0OuNmtpCaZ3r0Ao8
	 xaHAcx5Fhhf3Nk241yc7Ech8eQb6Xqrwb52Gh+ZlqPwxfGmbnyQH1HUvGtKfZaA4llsuv
	 WIIpQxRcvKY4C+l5L0K5G5quz8QICplmMuTUcwrA57lDStpnqq/0IWT+UkvEoY9DaiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aZAIjxz1snfefXTwgj1plZjiaOf0H8Bcm6PMriO3jvg=;
	b=cbg9T/EZ4xuPp9WelDLii01NZ4CE1U8ZsOj3Vs5Rpq8A6fF9jNPh81FXKCU0diZh8dDB
	 XzFfe6NHMQ9nICK50Guw2bKDN5KVkyXfnKupVw2VgRjilSj/c/BP7KnHu531Is/T7pksv
	 DvBZ2pwmqQzdjxMIwI2Hg0P35zgmKu6G/WKV66Om/dBl3x+IfJ5lqhcUrmRCNG6CuMUT6
	 feipSNO7gr0Ola2469NfZibcZXyDzt8fNFkEe+OrfwBTLlObHsGS9dHxgo2X0jeUek/QE
	 BBJWGQJPgogVVU6+TUqmeDUDpzNM9IT/P4iTz8Y/ZpZbMp7sL95IcwQsjV4+EFcF1pQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517184;
	bh=aZAIjxz1snfefXTwgj1plZjiaOf0H8Bcm6PMriO3jvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KJSAh5ocXVb/ZO4xLyte4QmSUC7TFU0WbL6XvtFdjGFZd6RmdmVHkroHtvsBK20QR
	 NxJxRYnSX9d+TSrUQjXksd0YImE74K5ZsPl1nrAPkWtGph6HmD/CUnA3GOrLPeZSaq
	 10s2CevQ6pgfjR2wjvApLp+D6rCvkaNOVlpyxyYviNNfO8DOQdVIqpkeo9NNTKIlGE
	 rPIrjc/zwGVz1Z8HmVKKBrGZjLoycRLbHlcu5b2zptYfhhJe3/vQx+rcdKrB5Eyjuy
	 BKPk+w2quw29PbWorak3JkIavKey+phIixy9eqGrizXVG/XxfxiFgosFwKpa5WFMKs
	 C9eMDTyWbestA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2314F8112C;
	Tue, 20 Oct 2026 17:26:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 61A89769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52FB1400CD
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0zjuzl_ABHup for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7116240060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514562;
 b=fI/MhDebQWaXjU8CAT42d3AOflMbscC+vajU9M76c8oQPNjtcX14ladyjqmz9yS8ueqP
 AGiEWWmJ2JMl0EwfGdF4eDG1V/2ew+R1/PlpK38vWBp8zC/I/4/q2AOXjSkimzw9PvV9l
 u3IX3YnIwCTqB7bJ0B8F8Iz6RaK2Fw9HSa8piVAemx1LvBWN6SO5wwydUelg1l7pp+iY6
 UIqCDV5EJC8yhS59ik73VE4QZ3NL7jBaSwSZbjD4SEzC2u0cPdjCL5hWRjmOtZ50cuUnB
 0JsFErbsvspmPdNJMzQO1WbXCB+mUuSufA1OO86vnVoQV6xFvnAOJ2lwfkOeMgZedQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514562;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=aZAIjxz1snfefXTwgj1plZjiaOf0H8Bcm6PMriO3jvg=;
 b=IFPKEFy1OpBuvFzYjiEZtwXf4RK6/S/IIEsQiD1sSmbBl34GaV+5J3BW327QEfO5Ny8V
 i8uBn/AnCSjLbynig8IEnLA1QZ+WDNLKlFJIlF9hm22iPSeQfIDQluf3Bd8pQBvGGjghN
 GibTibM6VGzzS9rS4uilJZvyubAZWdGiJqgZRasi4Wizoslf2iRBDcsG2m20IcV//CDXN
 rIn7N7c2sIiJfiTejxXrKT/gQs8rg3t3JeN92+eI3O2mfHZSf7iDtnPMSoghcWZtazGTU
 JHZOG6urTWxfHmDiUi1tIbwrTO55sF3LEulVO/0y1wdg6Vxgrm9ErdijVoZCs2bGH0Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=EIaOXWbw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=EIaOXWbw
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7116240060
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:41 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so29895215e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514560; x=1793119360;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aZAIjxz1snfefXTwgj1plZjiaOf0H8Bcm6PMriO3jvg=;
 b=EIaOXWbwRxrB0QHQ/YdJVCpmFSUilC8/M/zwV6QVDpONK8IRTi4XkAf640Zy5EwVQz
 byTAq60PpS41yARPEtS9J19cn4noQ/vfN3eAmHJKnsKVWe+hQQ45KjweMFpyktO3zD8v
 /2ITflcPd4Fya6tU0VXPA5qL6rsZvECMxVgS6nG/UhMSmVOu+s2Nn5DlJHkdVeF2sZi9
 CKiV8r1+A+uw6MLMHVfF6QIYXRoXTYZEKEwHHkCNyQGkNy09cEkcD7j8YMPSKOqq1adR
 HoBGK+inBUmtxP5RR+LKlp20zLTx5HyZ+UPYddi1B8mg8Wp6Obi50MLYljpoaQKFCKw8
 Otsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514560; x=1793119360;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aZAIjxz1snfefXTwgj1plZjiaOf0H8Bcm6PMriO3jvg=;
 b=zjToxnruevnZGbM70ml6qd7PIaguvsMudzEuCiqIMM7oakcsLWXsY3y/WBzR8JwkiE
 0xrct5gZ1q90k+vEI0Pi5AqVWyuWPHNngFxtk+FHYBdH6jT287UtYxRQVqgiKg+/zmTz
 2VVWgOOwj1EOT/yCbQLZjcWo02uOP6bINRdsFd02R7+e0iDam0pwAWrqaHi9dGqoVbd2
 5mELzmO69u1v9zoNJM6QSQgdgIgvuqDhbDiZPhobdsmvyDLvlNTFkuuaA036FGMcfjC1
 OUrGclgpIvSuhf/RtCFpp51QLC9q4iHJZ5BdvQajRGxtj0dt48XwcebbsDlPllJdaoX5
 uZwg==
X-Gm-Message-State: AFq9FYIrRbeUgCy1gUrr4JDkkcR69S87q8Z2ja5qT+ygxrHnZ7ZmdeIR
 kA59AjFGyEpOTK+mMLh07XGcG2DlrarsRJIRjqAdFyqRHGRLRvWXQBgknwUw5ZyMPbM=
X-Gm-Gg: AYBFou0f2UfRdxLWfTof6PY8pD06vNiIn922ojprDd8pJ5FYkSi78i17BBgIBcjWwOI
 2oXLA/wxOJSN3rNAdOqEuHJ+3GSV0qepYPxVCCBQ2iut1xT/janfWJ9f4w332ntOct4rZrTFbGj
 j0j5s0/ag63/ZskGvj1lJTlthgtCrQ4Rzyt5/zbM0XK38l3aDvmIbHGUM6CZdGZ2Nh8SSvQM0+9
 KCkjrZ0AtfILj4kg5OqYnpC6Vtor/Av1JbTvxWHMlh/vUmJYGoIK5PxEYJyMI766ZCBhwtQw+S4
 uvwojpzBOgJK2X4+mJAo4xX7Cyab3yOD9T8nz7n2nJ7GSLK+vBXOjMoZMe92nsbDJqmo+hkOalu
 QJckrZ/Y8ykB39q7PBOxHdESqTc2FKEiCMi+6lRnODixao4o9dnrev3uBys8h92/cNuFL0SMvfN
 UgB/y9hgl/kyzZ725fAw3CHoB/BzXNzRPbLcDO4Acx0SVv5Gl4ikjjJ+Bn3Lm0KMzC6Zvdlnrwu
 2ptapIgVog6i8VfzGB1Tm48FyfJrbC9XZv+s6TcUr59jAn17sIHHg==
X-Received: by 2002:a05:600c:a46:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a1d7603dd1mr258643785e9.21.1792514560049; 
 Tue, 20 Oct 2026 09:42:40 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:42:39 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:41:00 +0400
Subject: [PATCH v3 13/23] sandbox: spl: Enable zstd
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-13-6647aa23ade5@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=688; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Q/wo1+otketXngJsIc+BsDUnkoMX6wUhUbn3nr8XLG4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7lqdfHcqWrJwWXrH/LqVt4r69Y9POM121zDmwZtN
 6wTnhgkdUxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVM1IZ/plwds0JSp6w+G7Ov2NPdh6z/7e9SPq8/qufmdNyYsWSPBczMix60qE
 TEOe3aXrqqnVa8zed74o6cK5GgWFH0x3vvRXXW3gB
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

Nothing in the tree had SPL_ZSTD set, so nothing noticed that it could
not link. Turn it on where the SPL FIT loader is exercised, so a build
says so next time.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/sandbox_spl_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 46036ea9f9eb..b8c51988ef5c 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -235,6 +235,7 @@ CONFIG_RSA_VERIFY_WITH_PKEY=y
 CONFIG_TPM=y
 CONFIG_ZSTD=y
 CONFIG_SPL_LZMA=y
+CONFIG_SPL_ZSTD=y
 CONFIG_ERRNO_STR=y
 CONFIG_SPL_HEXDUMP=y
 CONFIG_SPL_LMB=y

-- 
2.55.0

