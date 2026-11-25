Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E01606A32E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UOaOOiwm;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmtfo/82
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 972E8608A6;
	Wed, 25 Nov 2026 12:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DNEgB7ynzNl7; Wed, 25 Nov 2026 12:43:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B3DCF6088F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795610591;
	b=WZPOwYg1m6nGUpkjsiT7e/F9tT555MAqdQq2TZS8FPEDVhPHRATROK9fPRTYhTjvRRUw
	 SdenWacQCI629xWMWvK1vIEFWvo9bOWMXZiJq4s+qSE8tFB5RJkeef+DFDdShPEVGmqJR
	 dlsmDrKseaiX4HeDgauWjUfCzwSQ5PNQctrUjaf/HjYl29gxtOjPtkotj6uNcWPsNuIq9
	 8yYxos4KzHspmpqFFVTIVACsxgLVaBBwYgHT9NlQogjNnC5MwszrJrWK7NzA1HFoqGnud
	 aJmZcS3rdCLSeszCBz7DwuNq68a6cNL/6NOLdTEDMy45PZSMITvJWNDhgCukCXewF5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795610591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=C49vS/Al7l33SYN7twzz9Qk/hUst+FFoZ0xVaRrzVNI=;
	b=H8GMHFfOXRZVbC0E4sfINVXXMsN6/PSWNZ2/Ns0RPt4/itMcvKTjxtww5ZGJdBC3u8g2
	 mlRHGIz6O/fxF40M/+6ZpuFtb3rSyiw6/v5G318Do1iyQSmglFq3DdFlomaXMjW7CC0u2
	 qPeSi/W81C5KTFaW2m8oT7Qh+XlrbSi9xUmX1aOT4JgCn/i/6RMEwnTasnnBJ593uueBR
	 605O0oA9Yaixjvrrkwp9Tut8Zlksq2kGcXCXnr9xoe5UHXN1Ub5TApoR9QN1Ee1yUa6rG
	 ekl3MClB4rcf7rpiCaFFo5+3vXfZO4Aat2XSt+TlNFnGjIcgMuxIK4qJOQLgKY4jKIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795610591;
	bh=C49vS/Al7l33SYN7twzz9Qk/hUst+FFoZ0xVaRrzVNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UOaOOiwm0JwJcySrl0L5xkQC+wcTHyJSMOyCbbqpoNZjhVfyRk0Zo6XPFYG7GrBXX
	 rLZJn+tIjzVz9/uApLtuO2epQp4QFH13ZDqci3HtF615mcg4kZkCmbqbse+BITE8MB
	 Vgbbbdiz1vF+++Nim03+wPlGWrrkJVlb9nRP/9XZQk8SCs4cw6CsoSkhibhEjKpRNP
	 iU0aGg1RGweWwaG8cntuh11lGiEBO90CGZOB2umU9fRAJBalSAhrrjNMlcLOhbsfk2
	 ldztTegWvQQEsD5+7P6IIu8KxAoRGGAju+EXSJK9vXmgvpCaZXjjBsj2QTe3FrSk1E
	 qrJkjkgdEgn6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3DCF6088F;
	Wed, 25 Nov 2026 12:43:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 89CE122B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8780A401FE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YcPmtW7mIGMg for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 12:43:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A825C40116
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=qmtfo/82
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A825C40116
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:05 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so50109885e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795610584; x=1796215384;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C49vS/Al7l33SYN7twzz9Qk/hUst+FFoZ0xVaRrzVNI=;
 b=qmtfo/825lvU5ELzDKVXqtQExYFaL2rOQpCy2r0FUnQteNmGF5kF91wiqdc+qp9gZI
 eR1AuTh/25KTZ9uMYT/1dgtGZvAAwpz2bWjomW2gYyyR5OUtVGbm/wqwZIH7GmZO6rsi
 yHdVq/+hrK5zq0hZotQOZAAAcIyHEtdoOooWbRjC9zEYMyE8Pg6lvYtrVWqxY7oYfLNj
 jokwmnedq3KgVb690zMnCW6V/5Rl17NOheiC1xI3LaYxypAY9KIj+BCgS3fZPA4op413
 QlGDAqS+g5ifkf9bfUIyWzrvIKvUbSnWzhcSP+JAegN7f7VY4Q48BHgdGPUvajGtR6+W
 qWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795610584; x=1796215384;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C49vS/Al7l33SYN7twzz9Qk/hUst+FFoZ0xVaRrzVNI=;
 b=bqaETH+RByh/Z4X4TcfDs8VebtCwfEuC+Dx4M5E9U/EVvRbghs6tyaj/BNz1vZY96v
 clSLFskrFjs05MAXcGuL5OJMoRaM+U9Z9+SbCN94/HBXHZiKawgDmbip8THJk1l1Z0aG
 tcwQ+uQRPAYhegKH/v6OVp9j61qFsgrI9RYNpPONUxoDdrwj5XdK6BoL94UWdB1Rt9XI
 Tltx3xX4aSY0JG5tPzptfSpwIpvqc6UUOqn3AEu7ljh/MUcTelGhu/huvynEx2wMYjWb
 s0VopAmLVjr5gWzGX+p9o8OL65WE5WjAp/hYVnFiAtyjvanqVcK58rLqELqXZUv3tLf0
 DxRQ==
X-Gm-Message-State: APuU4Z9596B71R+p/7Bkb1boh8wg5ROgtfVTNOIiBozAkOxBC9F18voq
 NfF5Z+2fSVZ7eeZTV1f24iiQB4a30aonuJYdEklOakICyEPip6DV/FvRYJPtDQhe
X-Gm-Gg: AZFdTZdtqrhQKCNIZPMR32GswueWCI29htmF8iclV28jp5d4wTEUcbMIOVyQk3v6iwb
 G6Z5jc5cLKGJb/OvtSVeyWatdTy9k1iWVnfLjP8SjutFsuRf9tbrGAid0UlHbcWTRtz8dK5COWX
 RMgSHEe4tPN2O9npI/VAK41I0EZ657gXqZUMIciZHrTFxDR0DUg6oy5v6KoiUEv3AnFOMnI/2UL
 IXBz0kD6tQSMwJ4pQYUWSei91wyQOu2f6eRXAISaDOyaiHJEKI5dw+PKYRUa1Szthmlg5VbV6bZ
 oJgmVkPlY1lEscNq9GAflJHEPH5xUnFqGTYGgFPLifyUpVow2+PPHltBIlSd7BiA6BFwmn91Kq0
 e1xN11Rcg/sr2DTkEAq4u4IG1ifnfdaoBPSHI4LbcjNt9zF0GMn+YMdFEgdQWsBAMtCxGMgUBSl
 L5CaBWZLyxH5Ld+oX+pK7fn/AooMdRPgKyphjI0g2BGTkMTcYZp68RV+CxaVb98rQprg6KuwaLe
 uteHS9leZrlkqmDHTSYXX0DBZqFKzYiADdaU7X8TK4tKw3990CrHFuSLUqiC286VYfxnKP++rJD
 JLuPIX1Uk9mmzzQNAN8ALrB4WAxRUh45+Vzz4MRtXDb62CVNaVck5pJ4Gova4zgn1ODT0EDfG6P
 Oo0XloAhTo5v9vzfzPpg0Ws0s163oxqtq8fXtm4WdqSqwdASBqI3F4zvaBrAkqumdQeOdLqeMjj
 iBz/UJwpqGdNfzf+R7ItP6BMMrvUzR17ruJ5gBF1IXNNJpP/gTQZRZug==
X-Received: by 2002:a05:600c:c4a2:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4bb88807d87mr369579305e9.7.1795610584125; 
 Wed, 25 Nov 2026 04:43:04 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-7575-e1e3-dbaf-96fb.ipv6.o2.cz.
 [2a00:1028:8388:a84e:7575:e1e3:dbaf:96fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm536486045e9.2.2026.11.25.04.43.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 04:43:03 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>, linux-btrfs@vger.kernel.org,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 1/6] fs: btrfs: Avoid a 64-bit modulo in __btrfs_devread()
Date: Wed, 25 Nov 2026 13:42:54 +0100
Message-ID: <20261125124259.95636-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 32-bit PowerPC, GCC turns the u64 '%' in __btrfs_devread() into a
call to __umoddi3(), which U-Boot's private libgcc does not provide.

The shift by log2blksz on the line above already requires a power-of-two
block size, so take the offset within the block with a mask.

Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>
Cc: Tom Rini <trini@konsulko.com>
---
 fs/btrfs/compat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
index 4596b9d1dd3..e6784884835 100644
--- a/fs/btrfs/compat.h
+++ b/fs/btrfs/compat.h
@@ -60,7 +60,7 @@ static inline int __btrfs_devread(struct blk_desc *desc,
 	int ret;
 
 	sector = offset >> desc->log2blksz;
-	byte_offset = offset % desc->blksz;
+	byte_offset = offset & (desc->blksz - 1);
 
 	/* fs_devread() return 0 for error, >0 for success */
 	ret = fs_devread(desc, part, sector, byte_offset, size, buf);
-- 
2.54.0 (Apple Git-157)

