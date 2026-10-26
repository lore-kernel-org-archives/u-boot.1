Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07798606A33D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0De27zNK;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DcgKXQbJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D18A940665;
	Mon, 26 Oct 2026 13:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tENJu_tAcpU0; Mon, 26 Oct 2026 13:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1B91540651
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793020744;
	b=pzZ84Xwd0QntpsNNrCeCG9eN1dhTyf3FdPWEvmPvpO5rd91rQVEkyXuwrB/rxTBII479
	 5sEhEUf7UyyYejYAfhsTE2nsN8KJagvZPZwIdXyFg4IjIw/jopwx8/qBUIEyyQ/YIbO50
	 ke9lEuf5aFilXuZnJXL7cOescd722uMnFsCrD51cMzwo4v5qO5PkFiNJWR0hFkfcB8ZAh
	 B0+4XbwRl8uWG680zQVKVh/7+tdFZGU/lQwXCUFDsHss2kgk+bl9h9/QJcQAZCzUaG0En
	 z7yTDhoXNCU1go0C94vtjyd0DT9ImiU0tr5/Bb2P3hSRXm4cnPJtQfXkjXDRSBjqDhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793020744;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kVtrIjFSOvwkuz2H+Qs9IIFJvn7j39drHdcJWi/yZx0=;
	b=tCVxOAea/5HuWvhXXeowy1HxOzfYCezMzdBFn2FdmkVyXlCPgmdJPtiXgKexmy4y9+/g
	 f4qmqmGK937RS0abhdFTLCKeH1shjUGjrqxQaa45KW/PNfYXrGO08Gng1LSwqk3D/5oeG
	 wKJrApX2PHqGs4S8q/W8mnaA4vbGOdNpwUOmMewZK6nCUZA49QmP4Njb5W0StYFT7qCKf
	 z1D9DFmSwjMgkKy+qTT3PGHzlvo3e2ecWyi71LtLsEsppkjoz5Kc0ilxjM5nByw8XZYWQ
	 EwxxDUJN2Tf9lUC6c0vKl3/rDTWExBczBHBJ8E0fDThaxrvVOf7wcpgQHY5MZdtT+rA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793020744;
	bh=kVtrIjFSOvwkuz2H+Qs9IIFJvn7j39drHdcJWi/yZx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0De27zNKh8pugZRXAvIG5bF96liBHKHS/YjzV4LU4a1jESWskogHbu56uJKzETHMu
	 wTMMfKnprfqJOs5AzKE9FRzAUrucwhMUEfdj5WRMtZW6YSL+5Et1u6H1KcpCa5+TCw
	 yoOyNcJcFVj4xzy+82CSHQqFNlrCoYDs2of7uiVJXxQvWRICERc7eI2NNV0IBdJnzT
	 2OpH2qFbUfCUixyf6/N74VdSdG6FEjkgt5lZ91Y6iBQqU98iJHtcMd96/D2XvGvWzr
	 0vGMBny/AA6keD8A9IhgHeVZEpsERC3pFfBisXMnrdf7Vjb1iQkyMMibcjboD0wDd7
	 A1YMIShnmJa/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B91540651;
	Mon, 26 Oct 2026 13:19:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E1E1279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0014960612
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KyDBJwM9yemo for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14DAA60603
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793020742;
 b=cSsyLuOI/0wyjF1hY7AG879S0Sdl9k/5xzHgogKHPfpCxTGCbFpkwTxEipqszwpJ2Sdf
 8JgvXbCZ1pdlQtX/isNyo0sCE0OrYLrRtRW6bAn57Rc1OtSRDe2za8fX7yzJzE0yL2QO0
 xjrFjdYlipc8NOzd3oBEdIL+H1c3OwCwaOXwr7lYM10wjetE7ywTWvnUXBghe0vhP/o3j
 btJJ1COjL9mkFwNCjT01L8sCPL0EH27KD9DqqZttNCHMsZ8LBmsUR+l4YVtRBk3sBHcXv
 H1CimW5FE7+jhwsyNKUcEtlJEw7m0y0x7mmZ/v+y6D10kworJr60zJYGhDJSiFv9aHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793020742;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=kVtrIjFSOvwkuz2H+Qs9IIFJvn7j39drHdcJWi/yZx0=;
 b=D52lew8Rq5KkFVKhTNFmwVu4D0423fM3YXljJyGoE6Xr0hb1THJPoBJ8qwva8+uKZ1bb
 50i3o1xYdqO8tRdSrxifBlX58RL8hx/OJGFqTz4Yy9MFBQgNXjRds2fdI6O+O0jFjv/F2
 eXSbD8v4/Mhv32n5eAjZ78v1vxfWU3EricBAQwH9IXxvI3uItVYbF5xOeKEY4twCQaVn/
 OUsnBng159cuPcNyPEx7EW47WI5YrEW6wyq5uK2A6H2C9wNUF8K54qU1506iY5XO8uZ0T
 /e7DEBBU6Vu4fNzVL5Q08mzf0Ta3ab1vG2gofhiQbcpQz65tySlzY1apmo2m0ec3CVg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DcgKXQbJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DcgKXQbJ
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14DAA60603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:01 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so18991825e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793020740; x=1793625540;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kVtrIjFSOvwkuz2H+Qs9IIFJvn7j39drHdcJWi/yZx0=;
 b=DcgKXQbJ/5YMvaV3p4RcS0Bb+AI69LpidKPOzOoduTYsGekrA+a6nqn/bMI4+dVOD8
 Ph3wrrbKx3UQ6NEhmYJ0uxGnk1klnrf79+jl5+5c1Fa7/Cst6QKVCpsTE5bwoPair8WB
 0QSCaU/eknYbho+P/HlBD1S+Ft22BjGvRXpFHYo+5TQnq7rW4asw625TW5Ic4VffdNmh
 a05Og7K9ZTgsnJ4DgNZz/oIEQk8bMaEzyDbzA/V0slaBn4h/b9wsnUKWMFHkjEjGfk+3
 na1V0K8em6YE8j4NGxEUUGM748rNFizjEZNLRKW3N2phj6wD6uGGpHlpi8YsEOfKKLAe
 p1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793020740; x=1793625540;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kVtrIjFSOvwkuz2H+Qs9IIFJvn7j39drHdcJWi/yZx0=;
 b=EYAi8cEkgHhfHuXZ66MdiKg5yI6wLNHSB+yWOsaBfe+1XrtztwIm9xwLbAlEBQqw+A
 /WHClyqJgyxTXLlfvGs/qO9Ypfh7eMnYD1JVy35SkGtVl2JifNGjftKE/9eXemyNyubA
 zMo2rSWojWBVgTNO9ZmQXTMqYQAhhyTilGyFx0RKwR5ZTgZPc/RubTZhnxzVVDmzGFd3
 POUKbvO+hfED7ZLJiNp526lELLlLhhPlLaWVBW0YA8ZqU84+6iHKNFD3cPanWOiON2K5
 BZSXin9RUMb54RzAA1+mO5FH22g7vofJl852ChTbdj2UUKzHbTGvgZ4HWKCfpiB0Yw8V
 xBQg==
X-Gm-Message-State: AFq9FYIksENuaXjA1spZlhy39fByAn1yHZJM2u/53fin1TzLnTg7Vy8u
 1vj41jtDNtT5BH9T8hM/748BQ3AJELWrCPP4ocs1iOaPyrs0Gj+syDUR0Xuri02s
X-Gm-Gg: AYBFou0657da0u2LqxceF4FHRb1/syVjYMoQW4rrDNGIUORM49YLgbO1wCxdUo/t5SK
 /7fDakalo6DIo0yznHCQt2EvrJsi2N8//DwaYEc/jzNqGVPakNBTDb3h5KnrjKX+4PjuS11RqOB
 RwD/kRG3mxkpDhCDK45oC30DFX6RMjfY5Ur7GVmlyBm+hROVt32nr1C+gWLK3MA6bhdD1e99VXZ
 06OSKH6pzYp0mZ/4AuZ4OGpcxFHbra6RZKHGMsUMwILCNE8LPbaXvWE6TBvZiDMEBLRmkf7Z6ib
 na9awyUaHJJqsKDA+8lIU6WCg6DUYE6lBI7oIABqEeM2ZpkZRt3ZwzSnA3XAtzgU4InDH+pD8Kt
 Q0C1FlsL9+XmOIkpjwx+NmZfCIEFnwGWfJm09h9mZkIhxxG5peBGTHg1pjg0L8MZPfWzw7evgpd
 hRYbOE9JO2TbsU4Z1iPVROheL7UOQ8tcHPXTkLp3vXDJCaLKrG5MbymNVyYp/85qhjRb4queHzK
 r9VVlWfqQNCOZhButAieTgeYfM1Y7cTGBor4qVNIpfSoPM6fGcnFmeoVw==
X-Received: by 2002:a05:600c:4704:b0:4a2:190f:cf6a with SMTP id
 5b1f17b1804b1-4a35acc2ea1mr116724145e9.35.1793020739805; 
 Mon, 26 Oct 2026 06:18:59 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a74d7f18a3sm16705645e9.1.2026.10.26.06.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 06:18:59 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND 1/6] efi_loader: capsule: check the size of a capsule
 file
Date: Mon, 26 Oct 2026 13:18:58 +0000
Message-ID: <e8c55302-bca0-412a-b4a8-b51e8f44f642@gmail.com>
In-Reply-To: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
References: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_capsule_read_file() compares the size of the capsule file with the
capsule_image_size field of its header, but does not check that the
file holds a whole header first. A capsule file shorter than struct
efi_capsule_header makes it read past the end of the buffer it
allocated for the file.

Reject a capsule file shorter than its header.

Fixes: c74cd8bd08d1 ("efi_loader: capsule: add capsule_on_disk support")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_capsule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index a77810fa15c..54c118736cf 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -1190,7 +1190,7 @@ static efi_status_t efi_capsule_read_file(const u16 *filename,
 	/* fetch data */
 	ret = EFI_CALL((*fh->read)(fh, &size, buf));
 	if (ret == EFI_SUCCESS) {
-		if (size >= buf->capsule_image_size) {
+		if (size >= sizeof(*buf) && size >= buf->capsule_image_size) {
 			*capsule = buf;
 		} else {
 			free(buf);
