Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351BC606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VJU2kF+o;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=L3Y5BcuR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10C3C8112A;
	Wed,  4 Nov 2026 08:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3Js5EV3huga; Wed,  4 Nov 2026 08:52:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5404281177
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782349;
	b=BCEqWTHqWgPFBffbJCJtPyebnI5k4dS6m8U7Vr4x7Wag/hODL9BJKVUTIJxgCRzYX3ht
	 HeSDnuVLwZtOD59JO2x8YCp8/rHhUF3G53GBH8WfZzlSjrim8RmWCcwMZ/j2zTQBWGycw
	 Gy7sC6gcweEuNcHnEHJohja9wywJ9QgHH+4a130D7bT1jis1lkLeJR4ccYENdZ34O2tds
	 qC2EkjFDJFsi7cKUEJYrGYzIqa/W0hQNWg/LIu/zNS/Ov6CWIXgPM378w32PViQYhU3Ca
	 /v7Qex/bSaM7JzhN3EFloREEc3ninH+Iaq5gr61biCztTL7xXPu0U5BYApf28Ql9gQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782349;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O9q1Q+HTNdJdp3ct4C6C6H1jdTejQvKcayQa52/2TT8=;
	b=l2WTfh3vpDDVFXtrPaJwNvUjDCgGOwuDz7FgQxpiNMqFk5BCkv4DPfL+lgkVGPbalO8L
	 WNzJOZWkXvjHYNw//OGLFCCPXmIJ5snwic+0ch8LjNeoxNL1N0t33Ex+jleW13t26uvoK
	 hvKrLfpafy+T+z4Zmq16iSMlFw+KsBxY3dHimtGfw48T21xgH7PqQeYeblTJY9YYfmk+g
	 iYY0mP4ucNZ86idHBHzfOqiUSqa5fgpT6+AocaZZNDzFoITtO4EuENpy2n6lLUSOEu2JJ
	 h0aff83+73Ow9DTtpXT2gfQutlMAtiA6u9v4lTCXhxx6nposUEFw+tVJ3n2xDU5KPkA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=L3Y5BcuR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782349;
	bh=O9q1Q+HTNdJdp3ct4C6C6H1jdTejQvKcayQa52/2TT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VJU2kF+o5AMXPjFQYPACuTQhryvusgAZXZ4XVhHmrEbTs4PSec8b6L5DNSkP61Ju7
	 j+ve3yfnLOZUui4AnIS/JXwAtfPi6f82lWtZabmSwK9M089nbhXmgChbjwXA7Tmk3l
	 bO2jxXEFFODOickn31KrmfXRrWQrdi3+lYz46YSd4LGy0DdrKXd/7Kz5fFJIpCo++8
	 NId7W35EyAeiV7ANx4vHaGTK5DU5p+TDHtf6YQWSDOWVsucAtNFstOeEOr0rFRCoHx
	 cqU0XUV6ILy7LSZGESLjHk9LV4wsQQLXBeXx7VeF4ToNN4bORag7A2IE01ExDsPz6n
	 762Wn2NQJyLhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5404281177;
	Wed,  4 Nov 2026 08:52:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B39342B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9994A8113D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Coo1y4F8Hwsx for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A120E81164
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782346;
 b=GtbHTMDgyKus7qGsyXtdze9alkmoe+lXuKJFNwro/rrlJyrfrfdlXAedkmAQyoQjkYqE
 sYHHzeLCG3zHbXtAdBpfdCYqLzEzLwsNs2Mi58p4gEEdm2Lw+KmOmnDTHmn0NH8CIjOA3
 e+u/SnltzYzmTRoFI5B25+/qObDtHrK1q0MM91k3LdfTiRNc6fiSpbM/xl2nfl4QnrA3h
 5tQzxCPNgH9luHz4ypVNMVg74LWbYq315hwyIkWEwaEreOefEuo1cfCVa8J4GuzPxwgPi
 FMAAtBbwQ4YB/CsJhuLa9MddWbhNk4t9f/+seQJ8NUd64ScXeo04sRrtv2A8DIfeYbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782346;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=O9q1Q+HTNdJdp3ct4C6C6H1jdTejQvKcayQa52/2TT8=;
 b=lb9m6w4T4VVt/pzXDG/upxIPwTJrkLnEA5CHo+TFrncUrxt8AGLK09eX75x8ge0NSlSo
 0Ir91Z/a343LG/sUCDHVu1Me6bEeoCmRW1v8P1PczSUjqMkJ1+uf4Y/RB6vGVQlOef6AA
 nzxhQat1zjbACM6fhrYOVUSckKrwWH/5WSqrtFXDsdp8eVJdO9JgqC+Hv6jcpaTD3qTme
 4Owt+k+K4bLe3qFXjAt2Y0sJerUXEJhnlau6OGRMqSR0Is+LPIeMudAVEs8zVO6O1wgy5
 W4OztFKBG4t+g2zGQTlFzV1eSCMZmenl3Cd2GISb650SyM1w6DCNs0Uf+rZc8Z7IlBQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=L3Y5BcuR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=L3Y5BcuR
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A120E81164
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:24 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so9401995e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782343; x=1794387143;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O9q1Q+HTNdJdp3ct4C6C6H1jdTejQvKcayQa52/2TT8=;
 b=L3Y5BcuRZIOqVGkXRKJlq2+CPPQIx5MZa0a3GIJC2ggYFQyzaehRAVur5bAB0v3are
 eOGsLfgcPzA/uB2IFpdiYLZcFBAHpEjndGgTuaJt/HCs39ksg9kDq+18K9NNUUp4fPL2
 TKJG2rcbFLQgV/PEOheDyKDXpJRcgY9nHBx+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782343; x=1794387143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O9q1Q+HTNdJdp3ct4C6C6H1jdTejQvKcayQa52/2TT8=;
 b=DZPxLhe6G9YJReQhihm8ZmnNnlKJ1PqzdzAgURTjswKiutgMNT8meIzKL4qdVTrgvS
 htopM60p0kTLf75KW4CANzbik/RDmh7GtCfM+ViG0slgA/lpnMF+kF8GMiqgJKO4CEvK
 6GbS4+DId7TjwlAIjGvPKAKF2SLrv0dBZmsTzEIHddGK+cxfaQESGDjtS6pRMg+WHsL2
 P3La4Ibi1oPpbfMk60GZelchjzTFFT6v0jmcfEvwMPk4/2v0kBy5CL03zInoz+SZsed9
 ElSZrBPa7TIalUmnLTVTlvKpp8tF4VBFV6ecBZOlx5epTp1fwS6z3ykZHo1t/iXomeP+
 GFoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxymmQ3cZXasyJqj9Sk1sx2zdz64LZsZ1hsOqzRWiqCLFvtjxklp6TeRngEX01/lCyX52DvlqM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+4n67F1JW//Nd5C0VhcQ1PxVRWXuD8p6ClCsYPmH1cVaPhVome
 vucXdVaxqNbHDPLoeSh/jQm/XucO+3K51Pnf85/ypUK9TuFgib3aut+S8FnYqSrsuyU=
X-Gm-Gg: AYBFou1La6nPf9pd/1zVrjT7L8McbrEOlXSzfoTxtWOvRu0E339zhbnDxgcCBBBAb0h
 gMZPqQhDpP8FtTLPs+/XfiTuuUz72IvYK4VeF1HDnxszXgOzQgwkKF/iwkD0h4kSQwsAn66ymv2
 63bA5CiOJCqPYrnbGCn5zFL7weWBiuWpUiyXUo6yGQ7wxsY0yvhpmoontquLMB/z/pWHFMi1qUa
 UXYEDjf8rCzY1L0hiDiYHG7uJkJNVdkllIBSt/6N/KTKkKb/bp6ZcS77HlovPjQ8lcWfJ8fYRb0
 j8aKG3y9PUqmbiw86rOd8j2gK0WXSPhUhdQviOXSXtMi183e31HC+3r/sttLIaBp6RPtBoNfMKh
 4pSezy7PjG0Tmc1gGp0kqlJ+22yHyBxW8DUg4E4UR9IGmPpJWYaNFAuzxOBVnHirAEbeiW3TAcg
 L2TduI2FoGMmoXW9Dm4sH0Sgealy98RSZLHGHf8ziNKmqR/vrIJD+QNv+h6aTMCpmJ+2oXrsDch
 q3+SFQfBJzQ7wFIVfvJTvYK1+bzOG+DTF5rKIbrAR0TJ4jAwKe4SmmkXkMlAtHpxljY5OzRHISW
 4Kuea6v+xpow0EU3f8U9HBs2bzFT+NYUmWmgXQq/LYvF4xSTxUW6XeIEWNWQBSsyOWkqgdziNFT
 qPsTtxSg7Va+TtJNngxznzcgxSHs=
X-Received: by 2002:a05:600c:4ece:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4ac169d7e39mr348846095e9.5.1793782343044; 
 Wed, 04 Nov 2026 00:52:23 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:22 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 29/33] boot: extension: allow longer overlay file names
Date: Wed,  4 Nov 2026 09:50:02 +0100
Message-ID: <20261104085036.4012238-30-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The overlay file name is limited to 63 characters, which is too short
for the Linux overlays named after the base devicetree, such as:

  st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtbo

Increase the buffer size to 128 bytes. The structure is never passed to
the OS and all its users size the overlay field with sizeof() or
strlen(), so the change is safe.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 include/extension_board.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/extension_board.h b/include/extension_board.h
index 0b9fb99ad7dc..f72db21441da 100644
--- a/include/extension_board.h
+++ b/include/extension_board.h
@@ -62,7 +62,7 @@ struct extension {
 	char name[32];
 	char owner[32];
 	char version[32];
-	char overlay[64];
+	char overlay[128];
 	char other[32];
 };
 
-- 
2.43.0

