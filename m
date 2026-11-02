Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330D606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FRmO8DjD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUfKJNjB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB1FE405DF;
	Mon,  2 Nov 2026 05:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0dBlB7D9Ptk8; Mon,  2 Nov 2026 05:32:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF1CE405F1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793597558;
	b=JZ+Kwtx5xL0SkCb3lf3TXbzvrUAA8fV7hlzHWQX3fM87n5ahv7pJkRCZGfE4kOdQKPHR
	 bh88hdd9TZ/2nLO5Sze7HT45FsMxKAVvGwuc5Fsf5g7RzH2J6rwxIbr0xUmEpZESmlwPf
	 cxSTBVXWWMMjARMnhoftnnBwW4kflZs3uVJm1NoSUETBEFY7g4IYXjns2tFDYyWg/NAhU
	 6v6ig+hhAsixnZP6t0wUYw8fNpTnSZ5881ZW28siGqrJPBzL1RYAM3l9TsAxs48LwdRmX
	 Gd6lyCozVZi0AIJHh2b2kUaHdzPF3frfdrKGWTYitL6Jw3wMx4cuDHt4EqNpAZccmZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793597558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s5qzUNermFuGJpvVxLqisDJDqyOwF4rivPpJF4e//NQ=;
	b=Lo6+s70VESIAWGBjrtuHQRjj8J1oEWWHS1ytT0EPHyO/Jnp7eVI5JS+WRfcqsfMt+gRZ
	 wEpAz1WD8/fdsRQWEg5ufruzrD/na/Jnshxb9MGocmje/6RRH0OdMpObizMY9Hm6BuNm8
	 htPzYCENjZdZg32d+17Bj9fb4fYwN5F7AwP4OlM9ksFsTIqcx8nGj7B8QbgQ/swd8QlzT
	 JcDSV5gAwMMFXjUn3IQGzABkoQnwf3+WNmCZtCKdNqdaipluMkWUaOqdfGFaWllENd90C
	 /uaWMLLkML8UwGNlXgvFcE9iQ7/RiL35c293Ss1xepOvwT6t352klXRLdHqpSxlGZjQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793597558;
	bh=s5qzUNermFuGJpvVxLqisDJDqyOwF4rivPpJF4e//NQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FRmO8DjDQCdi2PF69NHNAgX5hM36CwjtWY+5q/M1wFXMVzHXFdPcjE1USZoyxY8cN
	 6oYwbKRsm9f1wk4skX7WP53SZy4WA0PP9VzmZ0mxTLAB1FwiCiOgjDlDWhKDYosbHN
	 CHy/xpQXU4agV/pL9RW30qYMuj51RViGuOHh7o7dySJpSmLFOa0Sj16DCdyXdvlDFq
	 xs/QzUWnBURlntZVs56Fkc9NKMD4XF0HUQIPDA72zpL3uR/OSE1dPwpH8fCwyNCniW
	 D1mVPvn+/la+wrMNeyFxjfv9V0bzkI4GtbB4wjRZ/QkYrBopUogJl10srJk6FD+OIX
	 3JSiqusB62s2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF1CE405F1;
	Mon,  2 Nov 2026 05:32:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54BD1156
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 04:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50F4080D92
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 04:11:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id po3ugAEqrTHX for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 04:11:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 874AB80D8D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793592708;
 b=Tk6bbEd5TFiWz6yLCHJBYpcBbxggGyUtS7pNsxKAjJHqsdZUCmm7ZJK+Qel5YVWO3cf9
 GIMgw6ETMQ9YsLU2kKTBcx+4XGAjC3KgABlaWgbFV+HvAzJ8kT2GnRG7F06KnHcj9y28E
 L9DSlUMYj6g4PqmFV8HGNGgNtaoshZDlawqRS5AbgSOXfvZSjQr0bmJJKfJXmCy/T12p3
 DKgIW9rN5S8rOmzUaMnE9rbaM4taAUCSP3zk5kVNqzjNOEgcNqxiXpQMiJK6TmKO58wJU
 pwX5HZPjNXiyoFKUj8fQegcNhD2oAnQEK4AAcDGJkmLB73VLAJoCDvsrckmKSFTmhqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793592708;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=s5qzUNermFuGJpvVxLqisDJDqyOwF4rivPpJF4e//NQ=;
 b=mPOuGFbiEj7SHEFcr0xs39NGtfewLukCPlZuCnZN8w+ityeZJ60AdVzOcgeXO/d68k+j
 TOHJqWiMyMZztxpTxZd29j6zThuBKNHUUqg47jEdWUGP7wB6n6cLyZ/nkAPbWmHhajmp2
 ZyNeL6qfhCIxrvn8WWETu/KOirHNrsagWAA9fxNcZqg/xZPjcacbuqF2O4OxFJpuXjZO2
 gSuE60ITXzSZkCBG1WpvbUKkGam/2D6i0mwy+IzLQmckJIIe1dfbXC84rK6+p1M2/vunG
 KImiZ3IPW1Jnbq4KsfrOF0NkvZoJy98OdZJuQItfbu29Y8HUBevW8Z3Duc1BCAwx4EA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=gUfKJNjB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2d"
Received-SPF: Temperror (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2d; helo=mail-qv1-xf2d.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=gUfKJNjB
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 874AB80D8D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 04:10:44 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-91c791d5460so30359806d6.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 20:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793592641; x=1794197441;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s5qzUNermFuGJpvVxLqisDJDqyOwF4rivPpJF4e//NQ=;
 b=gUfKJNjBhfyT2AAINiOMYZRkINHlBCyjPZV4q8nTDwskkkMj3250s18nt3cCj4JCaQ
 Vc6RrMj10bpPLs/pzWQtKg6y7R20Xve6tYivJ63sUBcArK6yukqm1vpfTIyYJH9Rrlxi
 UCbnMfzrPJNjXXtMWoXnFfvGKRdX45dYMildR4JBqcrhG7xKJrTVTj29KGOaR1e0RUbV
 F7I3fxCU6CFeVnuRn21W4DlctgaKkr7KbX6kTf422Avi9nJJdlw0GN4C4JqB3LpnxwVU
 Ur/qhX2eMxkdKUIkGbQH/IZd5tQAMHsKMSkX6TAZ15kdY54fPE7yAam0qW0C5vAVhUDg
 IKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793592641; x=1794197441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s5qzUNermFuGJpvVxLqisDJDqyOwF4rivPpJF4e//NQ=;
 b=btVBlPUfNRHJFC6LOsNvPA9FT0JW4gl5UIu2RL8S8XjytuYrATrpMeZg9UbsRk9bAD
 d+40VaW4QjH83updiqzu6yUNf0CjyFsoL89carXIfjbNNa2C9OF8kpC0ezdmGBcgJzE+
 X7iINlB5VmAjuDBNCABYihX6IlxkLVUkTZ6azZxhx+WrStI/khfASKuDZxDixnOoF/Lm
 jl5KYfqdT/aJHJ65FJ4q/NGXwi/YPI8qGR4RYycxibEx7jHFtGlxdIYXX+WuE21dyftv
 hFd/jMQh5pmWgGWdSn1seMduRVkBgUV//aXpFWdl6BJk+IMkau7nGpOpQqyXWCC+aeV5
 SccA==
X-Forwarded-Encrypted: i=1;
 AKwUvByL0eqZI/f5woOAH1rGDCr2+pnX6fRAyWY1jioo1deFEpKtF0WFWB1fQHmNZXMwnksXWrJFqhA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKrJqKE6gai9pCRjJiEFc1vpDPRhr0AiNq87Qlzw5RU2DPi8BWd
 ZEuEtWt+EFMd7lt/vaCJochBdNA78v+b5gfcRQDANMMHU7+vof+OIXUg
X-Gm-Gg: AYBFou3jeW+hOdU4ITFrPKY99p8uCMgOPgY5u08B5APskQmv/nhVrQBYXKjpuglY+KK
 7E6W+u1e68aBT+ngcfqIboa4QYI7tBKtPwdM+ccOBvTqcq+421ozQ1DEpun/HENwN0nVD/Frbvy
 p7U2SbDMKyaDFCoJeUO5Lh5AIyGG9uo9xBkOP0mecONX3RiBfSFKfYgzHg5dmH/PJee5aCEeYp1
 mF675gSaDho6+i9nAyZ5OXaZ0C8VizK7AGMSjqaVY7WHk+een7QBmB31DxvhwdW6ZhjF7xgL32H
 8uJb0o4fQvNe5LBkrCLPlJoqvf3oo8w3+5E52Vy0qpW4N2sUjBCmzbAM4Z/zo+ZL1jjuBher/xe
 jCtUARCW7WdJCKtegwTIhuty2gHehEVFlRASvwGJtz8TK4vS9Z/HWWr0q35LdYXSQ+9zv634PYc
 paauF82hw5O/G4pottKGQMYPdLK32om0vC6VjG8Et1GBhbLmJstc8w9EwVX17GUXO6pS5VF77Sc
 dZEhC/mI+IXhwZjwatTOeqspWIhuzbG5zcpQw2TfBSGnxYmv4+l/kI5Y0hB1VuSufW7H3r+y7NZ
 FDXnGlwxXmJFfsLehGjkvHdNFOJ4s0D3r5zd/kZeIOV5b9qidNOA
X-Received: by 2002:a05:6214:3987:b0:917:9337:e8b8 with SMTP id
 6a1803df08f44-91ca4a070a4mr159343086d6.6.1793592640836; 
 Sun, 01 Nov 2026 20:10:40 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7e23b0bsm81014326d6.2.2026.11.01.20.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 20:10:40 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] efi_loader: unload image on security violation in
 efi_run_image()
Date: Sun,  1 Nov 2026 23:10:07 -0500
Message-ID: <20261102041038.369162-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 05:32:29 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,T_SPF_TEMPERROR,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

efi_load_image() returns EFI_SECURITY_VIOLATION when an image fails
Secure Boot authentication. In that case the image has still been
loaded and a valid image handle is returned, and it is up to the caller
to unload it.

efi_run_image() treats this like any other load failure and returns
without calling efi_unload_image(). With CONFIG_EFI_SECURE_BOOT=y and
Secure Boot enforced, each attempt to run an image that is not
authorized through 'bootefi', 'bootm' or an EFI bootflow therefore
leaves the relocated image pages, the image handle and its loaded image
protocol behind.

Unload the image on EFI_SECURITY_VIOLATION, as try_load_entry() already
does for boot options.

Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentication")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Tested on sandbox only. With LTO disabled, gdb set efi_secure_boot to
true at the start of efi_load_image(), so that the unsigned
'bootefi hello' image failed authentication. Without this patch each
attempt left one more handle with a Loaded Image protocol in
'efidebug dh' (5, 6, 7 handles); with it the count stays at 5. A normal
'bootefi hello' still runs. Not tested with enrolled keys or on
hardware.

 lib/efi_loader/efi_bootbin.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 12db8f517c7..752400c0eea 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -184,6 +184,10 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
 				      source_size, &handle));
 	if (ret != EFI_SUCCESS) {
 		log_err("Loading image failed\n");
+		/* On a security violation the image is loaded but not started */
+		if (ret == EFI_SECURITY_VIOLATION &&
+		    EFI_CALL(efi_unload_image(handle)) != EFI_SUCCESS)
+			log_err("Unloading image failed\n");
 		goto out;
 	}
 
-- 
2.43.0

