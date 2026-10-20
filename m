Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F19606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RdZVfLCq;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=9czQwkIt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14C908116A;
	Tue, 20 Oct 2026 17:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Ok4faesDlBw; Tue, 20 Oct 2026 17:26:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E04D81161
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517174;
	b=KhRTtjw6jDU+1xILHcgC2ThmM0prdpD3211J0YfpS8sbconDh6Wm0Hdrd13UVOZQvdMS
	 rMQeG5YPd4pc3ww8N1jWpZ3ONHihJSypRHcw4rJMGl9JUtJyMiAI4cGzXDDSjUp3qmt8w
	 n0TYv09J93CQfhrh6VMrpaaOFgN5Dy4p611kV3o4y2GJHJLsy3bSZtYoM/wmme1sxA6Lw
	 JWJJj3ymY/iDJ57VmuWkQ3D4xPELpU5bEGCxxzn0B7GQaeJ3gxF3MSPSUbNT8FpLK3Ro+
	 Q9oUhRJjSn6abo/vKnp2sRcgllO1L+kucRUeRHrxOR8yCZBrbi5VQetLTpmrIQkNYwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lAAQLQ/+Go10zgR+r2u29nnQx2GolxNmgNHz8oWQvZc=;
	b=KMKKdMbaLIA106UCPzJoAhGGDgTy5vee9glSBQKgIUoY2IjAto+LneDozGeXqrqNFU9/
	 TkxmTtIb/pk9ZfKn7QDo0gnPtuMVTgaqw1XX47b02fhY88hgSYzvcQpIgZenhhESwzDDR
	 qIz4ImI5z6E51F6jfeU00whS+TqW4rKQZOV/2mHVIgaFlhVaAiDrzy7ZpXbryRknuFuNM
	 oWT3k1NFmi6LxGkvv202/SeEfdYf/EH4vrzW8ly9YuXov6wWSYEtiZAQRFj8OLiO4qcUN
	 D9kObX4r71dBnaj8D9Sw40qmOog1fdxPsBWn0jlpRfawhu7TSgNRf5a2OFC1xWFCpvQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517174;
	bh=lAAQLQ/+Go10zgR+r2u29nnQx2GolxNmgNHz8oWQvZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RdZVfLCqLDx1xRVG4FFuByyAUcm66eWAekMz3twXF4c8vvKLXEbmWQnKdXVGAnT08
	 tclwM0asnaFAsJg+RAv4EiELI1dvldfNqIQgHIF9YER56kNhhHAav7iC6imR+MC1wQ
	 5tdfzOr0Et3HnM875dK673eCXP46f+Uex2NsiV9iKaWIo6b9FShHX5C1h7qzZUMtoG
	 /C9X9Btw4/2t92D6GZZsdsJ0Jddzr7D9Y47zz4gucAkfoexGqA4FiuUnVVw5CyTKDe
	 VDYDCgYw98tyyn6NqSJ8K+SG0gAq/rHCbGuwJJkIcVoAUffblNVkKf/f0iLw/TKLP/
	 IjsVC2H0XicGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E04D81161;
	Tue, 20 Oct 2026 17:26:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BFD0D930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A58AF4087B
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hp_81rsvtFRh for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:42:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 767C9407A3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514523;
 b=dTchNQM9W4irVeQEXi44rClQFhLL+JRF9DaQ3iLZ004V05hNIA9g9mmfEt3M5f3kLaBX
 JuYO6QoJAO8y0Yktj/g+weJWrJcUiaBKXFb5wTSsAQn8yKTnC/UrIluYCiXBAUgggP8g2
 6+gFWGT+dqoVO3+u3k6wFGlPXrS3U1ovwnIDug0U8/ibvw4R1cVjOm9Q6VRc89CkNdxS+
 yNrpnrcCNo7S7kElKBJFAi01mCuZBuCtBtk+cSm+jfp6G02lq1tcTcNhgofBYQajjTsMx
 vafDt8tkglQ7MdJYO6REEWcqATEcTA/Vr2iUAWbdjJRsxJzlpLnnpI+rEDTJIOa5X/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514523;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=lAAQLQ/+Go10zgR+r2u29nnQx2GolxNmgNHz8oWQvZc=;
 b=tG06LKm565wbh4r/o79OWdQS0UU0R9QfkxPnRlNLqf/jaP6oMgYezfXwHN8bj0XHlzEW
 bLgG3RDtbe4y2yTbkBfKjhc9yMt5iZ0tvDJ2kjPUI0SzJ1n8R6wJFiE2CbZS9N2r034L+
 0bqKRZRlsFK1b6c1gVaOxJNysL6nNoym2pPUw/fy8GR2P4wLZRWgAZz7c+11wWabgCd7J
 Mj2pnkzdQNoHuR9rMdC3mydjxA0/AsJXGdUYGGdUTHSO9ZJqKSWwGyIt5GoDa+pYHIL6Q
 EjxCgDNS08NQGXpaM9OF5Bh5mvwQUwIrjlOdJCwv8sJW9VxiTFTVoWEdmlRCyS8l2RA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=9czQwkIt; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=9czQwkIt
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 767C9407A3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:03 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso27994805e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514521; x=1793119321;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lAAQLQ/+Go10zgR+r2u29nnQx2GolxNmgNHz8oWQvZc=;
 b=9czQwkItVuH6XHDzBZl0Y61bPfcyjhemr/ACsYNlysWzennD5cJw9xQo2VBAEuBIa1
 jlW0IqkoCOAdK2amNsp2NXW8wSsFZJnE7CG3MxGT9IhLoeXG85PY/CHXwVakyNZ7Ma5Y
 NjeoXSBIbDQpB1C0kn8N8mWxxayVYWL999XQwV5YGEWUI8UCDVfRMxqWHlBB6Mzh8tp3
 DIt6ptIL08Hwk7D0fM7k8tqiqopEeMltqsjSBmyl7etKzOvnGrCGZC6EbNrKFReyCTKE
 3cBKmb4TlWYsp8kdl0kizZZBUC9UFZpxaYGcJy5au7kV+9w7qRpzIjgMpIV8+//JH59j
 Yx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514521; x=1793119321;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lAAQLQ/+Go10zgR+r2u29nnQx2GolxNmgNHz8oWQvZc=;
 b=gMdTcoJH10ZG3wntN/dsgm3LssKoDjaUEwvJXAE0YRpcTChfN6GKT7BVDzZyFJ5GKU
 +ztBsbhgytx7BbeQy8ZulroNPC8lkKMLHqkZ9qEhzgG+x406PH3OL7CG0rqU28tbjWr5
 VP2uCbliWmnHlkswexeYe6rhYc+l0/FH7oe4vhLC9tgffMyFPBCctWLtWHJuLD7bakGO
 SCEpM2vVr2UJI/Ungwv6fuVtpHcfQ6QHxyC6f+3h+v1IAULJAf4ElYFGk/3ZF0aUBFUm
 IeDCGBDbFcbouTBJQdu8DsVIyyoCn9bClaYJrPqZaLaUqGtkl/thztCgZ6fpRUnvGMpx
 R3xw==
X-Gm-Message-State: AFq9FYK7hSu5MbV6Jvjx5Rsx/D0D0GlXj8qisiQWqKZnKewxnC56kICc
 zsY5v+vEMWDS/ftCeiMoElfjNvmOQW4ob2W9vRQaYl7Zwsr7dbrb3s8q+MzDlq18P/Y=
X-Gm-Gg: AYBFou3OX369EsYOKsgQNxCgF6w3yXtVNn8UX50p6uzXdZqP6XYTETQapJ61lBMPMR4
 Rl3nnHT11Bj43KngAfKYmrtvUhXq88JMlKf0tLs8WJM0gkuHT66kJCeAlEmHxjnKwK9M2kx63Lx
 ke9tpRSrmBS/K6Dlb5bTAq67NKpKfEgYr2nEN0XALCwOh7pm0Vtc/0EcbFsd3c8UAZM2yav23eQ
 TIr8J18/8IcDbaluS+GQQ6DP2ODq8ghC4/qJgASSz84S3wxA4h/fTskFi6GVHHBUMVlxpAxHJND
 mINTjtZ8yDWd7tg3t1eHk4E5GjaUhRGWaDgg6MgbJMl6N+9XAcElBajJ5RcEWfQ0UvIIRulLxCF
 isNHjLn3/4VIXpFn+JG3VtaoSXh+n3YFt04QshTS1nZB4L/dV8i62+Q/guTgt9RqZ3DsM9W4Jln
 szPPzp3nbAxiTdJZpy6NNaA9F/hqtaBf1HcgG6ZECb84KsyEEMI2ebQyV2n03Z4lR9941SHVfWq
 n80Je9PuLoWpUkU7onoVsfYySmD0q380DoOAQBcf2c6sz4cz6W4MA==
X-Received: by 2002:a05:600c:1c0e:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4a1d7462e34mr261794895e9.0.1792514521421; 
 Tue, 20 Oct 2026 09:42:01 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:42:00 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:54 +0400
Subject: [PATCH v3 07/23] spl: fit: Decompress any supported algorithm
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-7-6647aa23ade5@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6129; i=alchark@flipper.net;
 h=from:subject:message-id; bh=QHGR9lVHeU7u3w/D+PpfXHWe3nkwEpMPOAraCUB+owE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7nq+xUGaZ37azb7H9Re3qmWL7R+QT8z394ajfeJH
 ZONC4K5OiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqlvmMDA+TA9wyA02am+65MLRvTy2y/n/o2vMiOwveyRWX02ZY+DL8Mw1iZrp
 W6D09/rXDd94L3TqnnQJ9I/bkh0w6p/Dpg/0ETgA=
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

load_simple_fit() open-codes gzip and lzma in two places, so a FIT built
with any of the other algorithms image_decomp() implements for SPL (lzo,
lz4 or zstd) is silently copied to its load address without decompression
and jumped into, causing a hang with nothing on the console to aid
debugging.

Call image_decomp() instead, which can handle all compression algorithms
enabled in the config, and will abort on an unknown one instead of trying
to silently jump into it. Bound its output by the max_size the caller
passes rather than by SYS_BOOTM_LEN, so that a compressed overlay can no
longer run past the end of its buffer.

Read the compression regardless of whether the phase has a decompressor,
so that an unsupported compressed image can fail loudly instead of having
SPL jump straight into its compressed data and hang. With no decompression
support enabled for the phase, a short-circuit path is taken to avoid
linking image_decomp() and the table of algorithms (up to 1.2KB total).

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/spl_fit.c | 78 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 8dabd819998b..50c4b269f700 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -6,7 +6,6 @@
 
 #include <errno.h>
 #include <fpga.h>
-#include <gzip.h>
 #include <image.h>
 #include <log.h>
 #include <memalign.h>
@@ -235,9 +234,10 @@ static void fit_fill_image_info(const void *fit, int node,
  * @fit:	FIT to read from
  * @noffset:	Offset of the image node
  *
- * With SPL_FIT_IMAGE_TINY, only tell apart the algorithms this phase can
- * decompress, as spl_fit_image_get_os() does for OS types. This saves the
- * table of every algorithm, and the strings which come with it.
+ * With SPL_FIT_IMAGE_TINY, or without any decompressor in the phase, only
+ * tell apart the algorithms this phase can decompress, as
+ * spl_fit_image_get_os() does for OS types. This saves the table of every
+ * algorithm, and the strings which come with it.
  *
  * Return: the compression (IH_COMP_...). An image without the property
  * counts as uncompressed, as it always has in SPL. A name not recognised
@@ -248,7 +248,8 @@ static u8 spl_fit_image_get_comp(const void *fit, int noffset)
 	const char *name;
 	u8 comp;
 
-	if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY)) {
+	if (CONFIG_IS_ENABLED(DECOMPRESSION) &&
+	    !CONFIG_IS_ENABLED(FIT_IMAGE_TINY)) {
 		if (fit_image_get_comp(fit, noffset, &comp))
 			return IH_COMP_NONE;
 		return comp;
@@ -271,6 +272,38 @@ static u8 spl_fit_image_get_comp(const void *fit, int noffset)
 	return -1;
 }
 
+/**
+ * spl_fit_decompress() - Decompress an image to its load address
+ * @comp:	Compression of the image (IH_COMP_...)
+ * @src:	Compressed data
+ * @length:	Length of the compressed data, updated to that of the output
+ * @load_addr:	Address to decompress to
+ * @max_size:	Most the output may take up
+ *
+ * Return: 0 if OK, -ENOSYS if the phase has no decompressor, or another -ve
+ * error
+ */
+static int spl_fit_decompress(u8 comp, void *src, size_t *length,
+			      ulong load_addr, ulong max_size)
+{
+	void *load_ptr = map_sysmem(load_addr, max_size);
+	ulong load_end;
+
+	if (!CONFIG_IS_ENABLED(DECOMPRESSION)) {
+		log_debug("No decompressor for compression %d\n", comp);
+		return -ENOSYS;
+	}
+
+	if (image_decomp(comp, load_addr, 0, -1, load_ptr, src, *length,
+			 max_size, &load_end)) {
+		log_err("Uncompressing error\n");
+		return -EIO;
+	}
+	*length = load_end - load_addr;
+
+	return 0;
+}
+
 /**
  * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
@@ -301,7 +334,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	ulong load_addr;
 	void *load_ptr;
 	void *src;
-	u8 image_comp = -1;
+	u8 image_comp;
 	const void *data;
 	const void *fit = ctx->fit;
 	bool external_data = false;
@@ -325,10 +358,8 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		}
 	}
 
-	if (CONFIG_IS_ENABLED(DECOMPRESSION)) {
-		image_comp = spl_fit_image_get_comp(fit, node);
-		debug("%s ", genimg_get_comp_name(image_comp));
-	}
+	image_comp = spl_fit_image_get_comp(fit, node);
+	debug("%s ", genimg_get_comp_name(image_comp));
 
 	if (fit_image_get_load(fit, node, &load_addr)) {
 		if (!image_info->load_addr) {
@@ -397,8 +428,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		}
 		read_offset = fit_offset + aligned_offset;
 
-		if (CONFIG_IS_ENABLED(DECOMPRESSION) &&
-		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
+		if (image_comp != IH_COMP_NONE)
 			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
 		else
 			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
@@ -462,25 +492,13 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))
 		board_fit_image_post_process(fit, node, &src, &length);
 
-	load_ptr = map_sysmem(load_addr, length);
-	if (IS_ENABLED(CONFIG_SPL_GZIP) && image_comp == IH_COMP_GZIP) {
-		size = length;
-		if (gunzip(load_ptr, CONFIG_SYS_BOOTM_LEN, src, &size)) {
-			puts("Uncompressing error\n");
-			return -EIO;
-		}
-		length = size;
-	} else if (IS_ENABLED(CONFIG_SPL_LZMA) && image_comp == IH_COMP_LZMA) {
-		size = CONFIG_SYS_BOOTM_LEN;
-		ulong loadEnd;
-
-		if (image_decomp(IH_COMP_LZMA, CONFIG_SYS_LOAD_ADDR, 0, 0,
-				 load_ptr, src, length, size, &loadEnd)) {
-			puts("Uncompressing error\n");
-			return -EIO;
-		}
-		length = loadEnd - CONFIG_SYS_LOAD_ADDR;
+	if (image_comp != IH_COMP_NONE) {
+		ret = spl_fit_decompress(image_comp, src, &length, load_addr,
+					 max_size);
+		if (ret)
+			return ret;
 	} else {
+		load_ptr = map_sysmem(load_addr, length);
 		memmove(load_ptr, src, length);
 	}
 

-- 
2.55.0

