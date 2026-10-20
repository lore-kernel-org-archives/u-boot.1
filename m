Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5D606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ksroG2+g;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=g5Y84my7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 190B9811A7;
	Tue, 20 Oct 2026 17:26:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DARQwv8Ovzgg; Tue, 20 Oct 2026 17:26:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48B568118D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517194;
	b=kWDxZa2jmWRidkzgVb2OcV4TVnP1Y0zhN71tOtl3oXZLwOEm1zXajMH8nsiaaMeO1P3o
	 btcS9YCT5/rxhibaorzar/Z4sp5EE3iYgwPbuhOfS/zu1/jQS5P34ymrJwvzMEkaMVFd1
	 xiYD8QkLNjjCd0gSTdkWCPJkP+6Kzp95qLDbc2E7FVLVnXYIHfX/bb1/9/hTl0ldkDPag
	 tuZZrMbA/e6Vwjf5BtPGF2c/iMNcz5xm1wiwMft0HnLv/BbUD+iTz82nci1a3G+W1n8kK
	 hrvIgFQo5xZWoxXHra+1XFpIhYoSeCXnMwkz4aQ24Wux4TZCmebYR+1JvHNqAi4g6Lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517194;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+Z0oeiccNqrdeBlIc33wwuRqfsDrlcBsYZxAxb3YcZg=;
	b=EFB1iNAaj6fdtB8s2djHpCcWxvO/jxQF7iyYRZpgo+QroD8ZOmMy7IcrThQT6g0vTpul
	 ZV5mag7nVk8/A54xvia1O2vzYStI31j8B8tdXFT7it106JDGQAittVtWn67cF4hySRom3
	 NaCbhgdNFF35GDhBliEd+87HLKbn0TrSXcizjPcvgAjqo8rzLfcOUiYMXIUrv1Uh6DAfo
	 uDR9MrEFQCgh7T5nwP3JM0ILqn6tqTB8Mgtz1/gVBDyou/JV5JYFELdO1GJjbgi/9U/pw
	 2wb3+GQC8z8o+nWpooin1MPe/Fa85jEkKBSVsXwzoWmujO+zczjOsSapzKdrFG5jDdg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517194;
	bh=+Z0oeiccNqrdeBlIc33wwuRqfsDrlcBsYZxAxb3YcZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ksroG2+gAH7koV/Ek9ofKT2u3dgoVejIftiph8mI/u6hK0pTTcdDx6nIdzmgM6nwd
	 L3PJdoVT6Yy62AoTZT9dyMhHqf8KUAQ9cF/74s0t5jOTPcv+D9FqpbJWITF/cHegfd
	 qzgfA77pDboEkZKadd5jCIHMYav2QlsOZDRhdk3o4XxdODdzD0TxPChFOcuMUQOhLr
	 6qmPBWUQhCIb++6Yi5gh5C5w2l9oqBqF3qS/dKjiULqOttOvuB/dkA2SeIbGEetDC7
	 mGzhy8HNxMmcjLiyRS/zGfVyyvOEU89vUwtCW8j1t4w8CX6P7gx87D22YdOGf4z0ZH
	 15dX5wqxkaBrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48B568118D;
	Tue, 20 Oct 2026 17:26:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F341930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 855A24080C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4OyFjoFe-UK for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:43:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A7C26407A3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514600;
 b=GbVWFqT5/Uckomww96FW8oYnFY5ciPCgQV7M/fs/hmykXpbp4pAQjkdCKEWjs1SuEdhC
 o0qJzq5lEthIfPrnH8e8pRBZvvUQECHguV1T33Sbtuwc8s6ygH/jgX9h6xuLFnoQ6/Kql
 nje66ITKVwf9kMIUG5sBR8teuyLTgE29AGE7coY7vPob8wfSAwsTtKYJXAJrjNAuN2Meg
 fMf+r2BvSAJ+IUv57CFp1fk0Yu8GMbGrzErAoje9JuHn6i9edbKGgqPocuJreR4DBlA/q
 ntpdLRNNzBpY83AP41l1lS7HB2fnK4BcrrtSBkHb+0lFKGk16xqHvcJzwWjI9dnkStw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514600;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=+Z0oeiccNqrdeBlIc33wwuRqfsDrlcBsYZxAxb3YcZg=;
 b=Op9gY/AEQgAHOhBJtnaNysRRpbFNNEiobeorU3FfaEXF1MZE27gPZuuzNmEC3f2JBW5u
 h5NvPLErtGXewVgSB8IRummMFS9mntuyXh1lzX+n2f/FymvvWtQvifJyRGYqlajxApdWc
 sdDZs1LGCwENYH2/TyGg2pp+CGrDb/6uKABHDkwR7FxjUyicurB4epJmZqGfi9jzvLJ4U
 gLAYsEfdyiDZ4gF1y1nLVt2CTzILcGjqssmKyGu4flpqIIqhLookTde28sGQ3jbD2/cjh
 7wVRcLXiNC1A0UUqgAkSnJS/uyCnt0ZbLh+8c6vSaIG/qdUU8cJR6Y0H+/SefCvH4VA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=g5Y84my7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=g5Y84my7
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7C26407A3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:19 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so21279465e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514597; x=1793119397;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Z0oeiccNqrdeBlIc33wwuRqfsDrlcBsYZxAxb3YcZg=;
 b=g5Y84my7NjYr/PQDmBc86YUOA6hey2C8bjIKrg4dTQvFHSCvlRfTqUiD4YjC4dzlsg
 lm8p+Q1uWG8yn+0q3rba6lxoRPk6Y5kFV5dBR/4RwU6+f5o4ZbYN0/wKtqtfXdMY8VDk
 jat2tbvQ+wgvsJ5vrdtlUlJpXnj+ETh0jSrdaMdND7hf0pCGsTMz0DugXKTwDNRQ4qSC
 SXG2ajELxPiy1G1nXbAgFdy3WNckq5Inddl7PQykgIhZxmZR2N27XN5uZg1Di1Qfuda7
 myrXMjv1gGjvfssPluCJdtdU7Jv9REpf3ssgeH7Fqjj/FH9dzWodQuJaXQijqGVCmfR2
 ttZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514597; x=1793119397;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Z0oeiccNqrdeBlIc33wwuRqfsDrlcBsYZxAxb3YcZg=;
 b=RRy2P0ztLojGAEzCjQPTOtVAYCk2KfDh+UH5CGNJPEKLTACiV/69fc4GOSk6m0vSqw
 WkAG0+1LUZszRoR5eyb2Lp3ReA+eeubAtQ3r8DKt+M01UH2Zwc8RfYMijZ3lkJWLvSXy
 Ycn2TmZ3NSg5ffICEgduq5vowbxDpAsQSL8njfMH87oLPQxQfYLzHXbGZvnKkiIDoVMY
 MeGnovyVe1gqAvoviwy7uBh4oFcwx/HwZG1lOQnP/rfIUd8fjsCF4lsjWsPzlTISteH1
 5e3wqPkin7asNwyK3LuREltew/nFiWWt0zMy5xTRZLhuaYX4MLKwNsIpR+7yjs/Vsxdb
 ZbUw==
X-Gm-Message-State: AFq9FYJR47knlUGOxaMOKBobJ+9LqKnfsO06OZS4Q8UWw0NfIE6C0if4
 SmEHx47Ghcv1Klm6DhEilDU/6cm0VUYYGIrmsFHU3eVN+cyvbykJt4lvGvKNITyAcus=
X-Gm-Gg: AYBFou2g19nuOsNuaWaNNYTYB4TziBod8ymL3LQZZ0G3jGmXLqwVgJgyxmV9bARxmBW
 f5CWJHQwYgrOJcMZ4+Ub4KenqVxT3sCihhh9wotnV23mVybHRHV8nQPQynrNPHoGIYJ6qkqFh7+
 aAs5fjn1vk3zeS14jOkup3iYxwFnih4OOmDmOl/0HSpPALgoOnn95y5ShEWsX2D5fPTzA2KYGi2
 AAAj7+TDfZtcIyRAqsb/JjmdSZy3aUKCRUzozrDqwKI3KcFeNjVwOKVooUDkjgvEwljSLFI6C+S
 foou6K5NErhX9/T9vP1CmrdXxA1DFUh5qULUjqM05NBoq0gDRbxMBhSXxfjVoJgaQ4rcq3MJ2KH
 GWUC+9D279n5J54ArH77fCwlj7m7JY6fUMlB9CELyduFtNyidC29i8cS/brX7T8oh6rYSx1q6Tj
 hxb73x4avqtDiEJKftesc35Hk55mR9G+QCSI/UbRaF8BxFeg6PRuxV0U1axwJiZT/h9JhguDlSX
 2pel6gg/xqDhk+3N0w0MunPDLYUzIU0OHKTi1CUZRD3VyA0dxYMhA==
X-Received: by 2002:a05:600c:8b6f:b0:4a1:6517:ccf1 with SMTP id
 5b1f17b1804b1-4a1d75fe13bmr219978515e9.9.1792514597245; 
 Tue, 20 Oct 2026 09:43:17 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:43:16 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:41:06 +0400
Subject: [PATCH v3 19/23] lib: zstd: Report a failure to allocate the workspace
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-19-6647aa23ade5@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=alchark@flipper.net;
 h=from:subject:message-id; bh=nRdwg/Kom0hvyxaY1hIJueJCc52YFhNYzHgqnYuxc1Q=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7laVmLXyqZVS2SVd0ezuMjc472XGf7PfBLjQjetZ
 AHWL8bRHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz14QcM/0x+WwqWCHE/87uvmXI2Wk0gSFIoN1I3MPBS9p+ri8IDXjEyTDnZvum
 jcSj34+1vBd0rlGVWXZg8LWvzXQO9faEXlepFuQA=
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

zstd_decompress() needs a workspace of around 94KB from the heap, which
is more than many SPL heaps hold, but only says so in a debug build. The
console just shows the caller's generic decompression error, with
nothing pointing at the heap.

Make it an error message, like the other failures in this function.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 lib/zstd/zstd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/zstd.c b/lib/zstd/zstd.c
index 14bde369068d..2c9f0fff073a 100644
--- a/lib/zstd/zstd.c
+++ b/lib/zstd/zstd.c
@@ -21,7 +21,7 @@ int zstd_decompress(struct abuf *in, struct abuf *out)
 	wsize = zstd_dctx_workspace_bound();
 	workspace = malloc(wsize);
 	if (!workspace) {
-		debug("%s: cannot allocate workspace of size %zu\n", __func__,
+		log_err("%s: cannot allocate workspace of size %zu\n", __func__,
 			wsize);
 		return -ENOMEM;
 	}

-- 
2.55.0

