Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013BA606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XBrePcm+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tR3H9Z70
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D02D860AC0;
	Fri, 30 Oct 2026 06:14:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1SjdCJbKuWub; Fri, 30 Oct 2026 06:14:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11A4860ABD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340843;
	b=MoRTbTvVQLXAf1/k5vbrJDa1ztGqwOPLrdQ0oLfX1LDqPxA1o5jZS5Xn8ma1DKo09Uqp
	 +j7GpSMZNBWhSEOW+XL4DWGwNx0FDGJBOJo+OSx+QU218KvUW5VGE0F05Vv6zt2K8qlOL
	 iPys2LN95aayz+4uJcHo8Imq/PSLLDq63EQmLw2MxePVyFWL8DHtMuhzLz+aTZvduEJu4
	 7EUkB/VV5VuZW/tGVsJKEzpBr1rDWbt0g3/5G1Tx6yuJ+9Tlnd7DVEw2VYbfl62BUI9GD
	 1Ki01ZqiihLVUGZLjp09ViBWfXs9GrYTnAgOjxk7BWY8Twzhnz3CZtDKr66sKlMXC7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340843;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=X5MDk7d8nfyhqkyeqaTZfQIbcdOocsJYfRHP5hoOZ40=;
	b=OWX2q6MHIxZD8Bzzf+aViS3bsXGCgZ5ooxzRuhivVYF2z0W+W2DdmhwOZXo15we/WmfU
	 V4mM0Y7VtJvIna6/QKbCgdWyDZFZhxmWBE8wP6fy78l+l2xV0QaMQ8Ix3wyal5ownfTGn
	 00PFmBFwFMBo9B/DK/vWLsdvyzlm+8w6tcg2azA9M5iIzI6nbGwFXL4shcVEasQzg8Bs7
	 jj7xTVpCmxbhNIXeaQKg00CHVYgsJoLqR1OCufAQMkZE9sOaG4dLDVAZEcBbXFhY0Jxov
	 an6kvKyZSdBAdY6MXq5xZ50eq2XCp6Zl/ou8TwtQwILSY7ZqSYUGfD/fJXbkCboIYog==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340843;
	bh=X5MDk7d8nfyhqkyeqaTZfQIbcdOocsJYfRHP5hoOZ40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XBrePcm+mipQGS3vukIV13vmuBB2sBqe1lwZ4Ja2m3BJhQPH4txadUQuaZmLdHZZA
	 JuQftjW6Buc4SzioJVsBJL15bwSJpu/m5u08m9Cd/YXeps50CPd3kzZzVTGxyFcgAA
	 FXCs9VGsYEvc3eIk4cpHVKlukJzoBQYnbFhp61lGJaR/Y1iDE86WS8VDmfz/tO0JGk
	 2RB9qfaik6k5aJ3RLftlM2kV8vvx+4xTRxQIN/EcTbdQEpkHUdYS86FxOaH5pG4hBf
	 izgygjR82LnEBvr8JqmY+q01gCbqtwVQaMBRq1jZrWYvHF0cEbQE2FGvKHk0ry/OHd
	 k9WyclfwO45hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11A4860ABD;
	Fri, 30 Oct 2026 06:14:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 752402C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72AE64051A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rS-xUfIAIfXf for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:14:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8D6F2402F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340841;
 b=EwaQNR2tHMG6HYdflDMhp9I1YKoMYthyxAd8tkdiX0HV6anvlUoeHuEqxQD+GP0z2Wwi
 f7qG68TjSNSXxPRXsQYhYndiJnUuFWIbrkw49VSz3r7tSZXp2hORpDraqAkB8OXfoqMrB
 tR9mt0MigUsET0jLNoR3QVdhUH2hkPJ4ZnBTfbREzKaa1AKCjfT5RUcGpVkFTjTAGgxnY
 3YgcYJ+rcTejdWUBcmz/nu6d1t5216ccUGEXTPZpnPbC1BcobrS0rnisldaneFsIUOpbv
 xDv+seAWGXS93upHmMbUqKs9OlMXinJnAZMl9CAgBt3tVq5BSqe1gde+gOiO39GT1NA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340841;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=X5MDk7d8nfyhqkyeqaTZfQIbcdOocsJYfRHP5hoOZ40=;
 b=lbfA0pFGKCQHhN1NRU9y+x5LIWkXeqvAZiR+Lj0Ymbl31Kyo6MA+3VUE03FybVVeV5Bo
 jw9oKGRUPwe+svIFu2vW7MwRi54J5mdNwYiFnPnBI1c8pALONQZ8zBWrJcU/gnDa883B1
 NvYzcAyP3zn1UDuusf5F2Bv5fQHxbX84lYAAFBlRXWjTg7H7J+m+F+65AWHpzIXYIiYZR
 szHhfCgIa3vDEskU/7OefBT8eog24OQy0XlNNHzBOTSgd1UmNv5RX81Qlt2TPH8HMzNt2
 eFJc6+k+Lsh2vn/cmIcf1LmDj0PTfYvok6bDdrG/VMhL94XvB1erWPlfYldAJD+roxw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=tR3H9Z70; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=tR3H9Z70
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D6F2402F6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:00 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso1677205e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793340838; x=1793945638;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X5MDk7d8nfyhqkyeqaTZfQIbcdOocsJYfRHP5hoOZ40=;
 b=tR3H9Z70aRDgWzx9k+D/zFSX8LATeT7x7aHQdoqbFQylML/U4lcFRYZnqsNBP5TvjA
 Jxq78dp+FXLZNuueoBL8HmzMzQtcrVCqhu55PF7jq3OXHWTY3GkN548s9Eo4cK5gLtsS
 uSoaQBD1Nv7WwtIhaJehC64QkM/8+d1DdqjypfaAhr9EXCc82nzAYMg2jhtQ3BJp6HHP
 UtRcuX7CTHlNm0QoCgXTcCkQ+9etCQ8RDH/D+iT6y31V2G+VfGlicqxERAbRhq+Qg6XW
 IgxDq7LFPOSGz4oSG9mDEmgSTw0Y8IUax4TvHacaIsbhgeVtzmGoJcBglPrwuyo1yXDg
 /AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340838; x=1793945638;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X5MDk7d8nfyhqkyeqaTZfQIbcdOocsJYfRHP5hoOZ40=;
 b=q8FVDYWSZM0K3/9gLVzM/BqqU4hpjYt4DRTimw70FnIg60Yin0mNGfs267RtEbKIAO
 dcGNbslwz9CrDfAaFMIkWd3inP1kYBsnfU71vKG6/egO2v+pZrAmH3koMB3rlUpAYdNg
 kgosTLVKRoxiSZV9iqXllAcPLfwNQEFbgb3aPZDwSmvQXCIMKX7oMVgfDYnztndRGuUq
 Hr02h/s6dOjeHXKt/fd1ot52aZgESIm/3o4gW6j+1Gjyksz8LHGdogc7PiXMdpXdnPyH
 eKbZupPicwLG5Mv0IMze9CM+b+NfmhHNGqXIPOdhYWB5GCswOqoCA3S992Uwnnepv57c
 eqUw==
X-Gm-Message-State: AFq9FYK6nCVknfsH6TP1x3gcvR2RylCFvUefQQ3guGoK3miZn2eRmpuE
 PUZyHAFlfmqIMS/sU1MMBEYHkyZNY55EqZBinBkzNMQ6m0XCKmvWjgSCyW1PqzccO5o=
X-Gm-Gg: AYBFou0Ane7NyErZmo44vETrl/GPh+9KrfmT6vnf5QRbqKTj1ydU7Yp9CBXDCxMT4jc
 9HPfYI+HWLe7kFB1E9r8rTfswAwN8N4yjpbutqip9p5+l1KSL0GtCQRGpuDoGN6c0vwLJ9B8P41
 t7d6q1u6AjnGvKmqYs7HzilGEXrIH5kcCWn6valNZxBZUYHNhDeO0lOqDGlFw+hG8HtADTnUYYT
 rz5yPclGYmVh8cGn8Ma9N7CkhDXsF8l6W/TM5ClkZPHTKSL15uS2Qb4lNqXBWO8i9uxuTOaKz2g
 6dOkw5YbMSkLe3JPX5ugCYQe1HGc6MNaXAgK6UzVBQLK3NaBsBEKFxsgPbel0qs7VFs8k3Qf3HR
 Rpoec+gm3JXPFXk8dEfYbiz06vxfu2k1cHKPzB7Deu/AUZy9cv0sj4hxQu+K8fIBeIy/PBoUfAA
 xXlj/CUY+AFkMY2/JJ78jc2an9p5MySSmZjEWRdzqTwYErw3gI9mvc03lfDYXjLle6ygdJxR6G5
 YRUfsbsXciC96Bk8C4KA2bpO1lDyC3WDUmXuNqJdazTaWA9psMlydtOkxf0n8FTOthvnO0cNOW7
 0Sg0AepMIY+jq91FBMbOE907nJgID51rkKo3rMyiDdYE1e4S3wXwiQ==
X-Received: by 2002:a05:600c:6989:b0:4a7:6425:c274 with SMTP id
 5b1f17b1804b1-4ac150b38d0mr23475255e9.2.1793340838313; 
 Thu, 29 Oct 2026 23:13:58 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728f9sm1374848f8f.10.2026.10.29.23.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 23:13:57 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/10] efi_loader: reject a PE section whose end wraps around
Date: Fri, 30 Oct 2026 06:13:56 +0000
Message-ID: <5b986292-b889-4e1e-9e0f-9012ea225366@gmail.com>
In-Reply-To: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
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

efi_load_pe() computes the end of each section as the sum of its
VirtualAddress and its size, both u32, so the sum wraps around before it
is widened to unsigned long. A section near 4 GiB then yields a small
virt_size, and the memset() and memcpy() of the section write far past
the allocated image.

Relative virtual addresses are 32 bit, so reject a section whose end
does not fit into 32 bits. barebox, whose EFI loader is based on this
file, fixed the same in b6598389d46d ("efi: loader: fix integer overflow
in PE virt_size calculation").

This runs before the image is rejected when Secure Boot fails to verify
it.

Fixes: cb149c66342c ("efi_loader: Add PE image loader")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 35cf3cd268f..b15a662e5d6 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -1062,9 +1062,20 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 	/* Calculate upper virtual address boundary */
 	for (i = num_sections - 1; i >= 0; i--) {
 		IMAGE_SECTION_HEADER *sec = &sections[i];
+		u32 end;
 
-		virt_size = max_t(unsigned long, virt_size,
-				  sec->VirtualAddress + section_size(sec));
+		/*
+		 * Relative virtual addresses are 32 bit. A section whose end
+		 * wraps around would make virt_size too small for the memset()
+		 * and memcpy() below.
+		 */
+		if (__builtin_add_overflow(sec->VirtualAddress,
+					   section_size(sec), &end)) {
+			log_err("Section %d virtual address overflow\n", i);
+			return EFI_LOAD_ERROR;
+		}
+
+		virt_size = max_t(unsigned long, virt_size, end);
 	}
 
 	/* Read 32/64bit specific header bits */
