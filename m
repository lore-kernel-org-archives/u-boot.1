Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F3606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZMc5fVSj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k29soFTD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB08B605F1;
	Wed, 28 Oct 2026 12:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLM9iTGnSeUY; Wed, 28 Oct 2026 12:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C10B60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189596;
	b=DQELAd+QP0n8+Nv2F46LyvzRiwbDbOvAhZibjT4mQ6U/OnfBJkAyxAfqiDFHPMHiqtK4
	 oRt5mJKwNTarmEKF42Ck+P35BnRQSm8ECaJ8ZbnY4YhmZyMdJ5tDgh6piLqy8m3PFfR9d
	 pUArfHHS1CoPvxWn7xVbXdDS0p/0ebyzaVfEr1IDnB0KrwDQG+jgj4ITg45MuIcjC3Fey
	 tBKYlZOjuXNd9G8++oRo/cb4wYtUlR3x/VhSzf8rhXJLqIYYQkG0umDNxxbF5/o1Q/1It
	 GltIGG6Ry51aEFvOS3aElu/v408CQkRrfToHhREg7jn8h41PxQGxXXOCMVwINxaKEMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189596;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NDCpztJRG2JS+LgoNQNJiL5nfJosyWbmPvGLpIxD7mY=;
	b=QdkeAh998xCLqGb5C+SGMwXMKCDAnV82d3yzITD8lX4SZz6tXjmuVrfrW5jOWWWpxubi
	 b0QqNFfQgw6GA8vyUEz+uG1+O7txkljjUA0V3VnPX9rAQas9QG2pZHoGLHN5pyITpfbK7
	 rI/9a06r1gQv9q7ZiexSPhuqHMzoxWGBCTCQcMzFcA+0BI9raFHcBaKpOGFW24SiDySVD
	 ooyDeLtRfiiptpu2U/c8TyUwpNQW2MyzjsXgHoYtmYVUDXtsoSqLJfC5kyd+vXAabmcRg
	 zXKJH7osMZIoKUyp1/dJ52G+oZXys5Nwgwnb1ARDfJbK8aXgphgC9LwV8pQeGQCXNwQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k29soFTD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189596;
	bh=NDCpztJRG2JS+LgoNQNJiL5nfJosyWbmPvGLpIxD7mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZMc5fVSjUlmdYTv3tQs6ffVlvnwJzAYgPW+x6g03nq5Fp8l54hw9/XmR4jf7ClXp+
	 3XTeLwmyL4+UPmtmwMtgnOqZRPwaiwFhPxNqrpZV5U7OP/bKT8Eh/h66deQeeI2Xd+
	 cwidCF8P04EgJT5G+pncLmEBR/gsIxAYYCWG1RLO5CwW+2xUhGRwAhQd4V2EmiLOar
	 YDXhN9zKgc+R4rSu9FBcTKjLwZES35/Inx+OoC8V1bh8t6+IZsrEITsc4rhuXfPGbC
	 Yd+X3Gyq8wpLonxLtcdNIK/LEBbyAHgrvxqV2ZS9iqjveDFJg6PsLDGcjh5whdACJg
	 FU7/Tkt0hMhSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C10B60600;
	Wed, 28 Oct 2026 12:13:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D7A6972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 499F9605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HXJj7q6y3eOZ for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:13:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 649E3605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793189592;
 b=iQJGzIZkfAJlOakTpPNmshj+Yn5iyNpp4omDUvQgXBnPdkyftXMFDYG+F9NDHkWv4ZDD
 7c9+zkDuxvxpOavV2kIQNcZJzMVuWc4/kDPOSt0unte200yuyPvHxewRiWYhDoR2hVNUU
 zU+7jA2IMkMjEE1OJBDI6VhmKFyFyORl6hLWx12gP8tbzUJlOcVYicb5ZzPNfJYmb6kD5
 zIuHZ/oLD9EAKGI8LIFFoCrvC1mHBx+qsz5GtXuYMXd9g02NK2O0WcLJd2DLEgW0MnTm+
 1DHn+PzqbawyvPNFbOIVclZMXwPnGgTtkF+VLXwy6Vmt0MYIJCIpC68nKbfUgJqEOqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189592;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=NDCpztJRG2JS+LgoNQNJiL5nfJosyWbmPvGLpIxD7mY=;
 b=KEjDmPNY+umualtaCrqgFLu8mSibbREPn8MyAg4iP21kO/J+4FTb5LVbeYqKiWPl4Ebn
 LgxZ93gBFqehT/Us4Lo/hgYH2pqruGJU6TkNHOJHFrdtR9+lSssoyQPLlhy1n7DaMNI38
 liqhHXi1jbL8o5JE8kEhe1IJLJBIApIXng+o/fB7d+kP4gXBauroo+Ud8Rf9UnIQAKvBf
 jTA12UrIGIBDj1UYxBI+zzU3cUVgf3/c73kIQkiXVT89/1hi4WCO/Ey/3mZvOJnYzVBHf
 tjWibutvq967kBFpeLZ1AIYHARHNf3NQ8KQb5ywJHGVg3tvfJGCEte+yCbN/6EsHkGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=k29soFTD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=k29soFTD
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 649E3605DF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:11 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so421864f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793189590; x=1793794390;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NDCpztJRG2JS+LgoNQNJiL5nfJosyWbmPvGLpIxD7mY=;
 b=k29soFTDqjV8r75eobCMDrnBVSvclOfpbh5EUQujTFZzUNmZQ7h2FObXZ1gWrccWMt
 O8LAY5hOBkHktaYw+c44KfqiPr4NlWjHSrxmFaimuYPM+UP8YYrvqjJJB0gi/8By7CpA
 3bMlu1kgS5EjK1g/uoi+3pdMH2fbYww2zBzcxM/U40qQfyT+pUZTBWuzTApQ2yy5I3XR
 WGaKJ1RAo0E7kfw0DZOL95krDIUuEBWTHNjcu96FXXrGUUem2rHGyw4Bi6qc/YRTvuRi
 RgPWcnqMq3xt66MysMsS+QBfxXHWW6DCuz5GqkEdDftUvrwBfjNXEdwWK18JXIubNZ/Q
 hNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189590; x=1793794390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NDCpztJRG2JS+LgoNQNJiL5nfJosyWbmPvGLpIxD7mY=;
 b=CKsufUfwHn5ciBc0WUYKGmI1GW6BJJXo1enwH/4ImpkpaBt2dwxDoYtaG8uT5Yp913
 eZbh9qgyz92fev0AGU+j3batXfGsx8qZ0qiDZhspf59lbHOGYV8Sp60yqwVejFzMzhjI
 sODSd0n7VPHub24e/BPbg7UFi8UwDoYJvdSALWfEhmEjGEtE/S49qSalaOhw07/UA0n0
 g3Un6EIGF/0USpevfhAdGCq/vumpf52mRpad3YLXPU4sysmnXggM3ULfI9GQBWmLxQDs
 Y/zjyVQKkANWpVwcby4WDxG96qZrPDNzh6pc4N9iy1P+LOe6ivTZS0L6cHkIjsuDY4vS
 BX4Q==
X-Gm-Message-State: AFq9FYJkXHk0P5JnU6N3LD5QmeFBhooC8pYsWmOC4iHRwVLAAgkNwohF
 daJx2+cMM2zP/vEulNE2lGtkkRMKUTbVj3JoUMHqnN++4AywUAarEHdiKqryRSke
X-Gm-Gg: AYBFou3qKXiF/ELpy2egtvXpWv38XigWbU1L7tMw6RvGdGbTaP154PxjN7mcleogo4K
 i92OHaneQaq0u6BC6SDPUGmpHAv33gXqW93TCb5kAgwr/aPOGcYhV57PSWIR4PwE/X95j8ji8ty
 6dB+/GvLfoScubjm3UY2+ZFimhvRTTeFvQ1D4ACK7Mvm7cKofxGHXU+d6cWxYHYmHqw9xASsauW
 0iKeqMDXsauT66juDi6o30TGFWr3pR5TNtWnVXNy6HYc9TuE991Jc/MFJ0hHKCcC+sKCOsFf+VC
 1R2bTC9ZMeCN127/3Gk4xvd89p3X88iSJF4NJcDLvlqgYg++4F9Vrmc5ZiCcXFWav6yF1gJUj34
 3zlcuawps0pyjnPjLvAIWk2PnXP7mHjVP8v2DmAfppQ0/N+5RDdy57mTQKlfLZMMcgmt1+ho8X9
 +cguJLxeP3ByfyEn2Iy1S+qWqSVFVfRvasufoGwnCmgb3MTmDNVzNfEUPU4Syt70UQsMdDGcyH3
 FwFKj9t5PDaiZHoilV6GyCXLFh0QuE5CaXg9TdqNn0sApc8LoaAiwlAHSUkioABI86iI6cmhmyJ
 ejkONh3OJlm2Kc7DtsW2//o6zjBdYMVRKgLhD91mppvpgMeq5aqTs4eN8pHd6RFdEw1A8HqadJh
 PAN1BbUlU6RMj9xngLVqItDEgPnAemKyXrxMDJ27b3pxUPJ9ctNJ/J4ONTmAiNw6aSG99fSh8Xf
 Noe5SzBmaY9kwYNaGm58fliOQJjJw2ZjGGI9wGcNqUuZPoA0vYFT8dWSZxdqZArGGH52MFUyrHG
 w==
X-Received: by 2002:a5d:5f03:0:b0:48b:5e2:52c7 with SMTP id
 ffacd0b85a97d-48e5d567e90mr5288955f8f.8.1793189589730; 
 Wed, 28 Oct 2026 05:13:09 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-301f-0e2e-7b95-b045.ipv6.o2.cz.
 [2a00:1028:8388:a84e:301f:e2e:7b95:b045])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm28113560f8f.53.2026.10.28.05.13.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 05:13:09 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/3] tools: kwboot: Define _is_within_tolerance() only with
 BOTHER
Date: Wed, 28 Oct 2026 13:12:57 +0100
Message-ID: <20261028121258.572-3-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028121258.572-1-pepe.schlehofer@gmail.com>
References: <20261028121258.572-1-pepe.schlehofer@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Building kwboot on macOS warns:

  warning: unused function '_is_within_tolerance' [-Wunused-function]

The only caller checks the baudrate that BOTHER sets, and macOS has no
BOTHER. Define the function under the same #ifdef.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 tools/kwboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/kwboot.c b/tools/kwboot.c
index 6bef4610ff8..c03f0d6d63e 100644
--- a/tools/kwboot.c
+++ b/tools/kwboot.c
@@ -727,12 +727,14 @@ kwboot_tty_baudrate_to_speed(int baudrate)
 	}
 }
 
+#ifdef BOTHER
 static int
 _is_within_tolerance(int value, int reference, int tolerance)
 {
 	return 100 * value >= reference * (100 - tolerance) &&
 	       100 * value <= reference * (100 + tolerance);
 }
+#endif
 
 static int
 kwboot_tty_change_baudrate(int fd, int baudrate)
-- 
2.54.0 (Apple Git-157)

