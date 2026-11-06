Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A516606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ShKDOmNX;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v3FGpUVW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6B6B60D76;
	Fri,  6 Nov 2026 21:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CoveQ5fOiUBP; Fri,  6 Nov 2026 21:56:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1FF5E60D94
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002216;
	b=AOgSiIfu73XpqiLU0ZDLIjggpy4au5YkYmph2fdF5mIBaqXRAxW2ct0PSKHIEp2zndoc
	 XTZFrEMhUGdFx+mu0SD492GQhPuPjFoCOWzXrnm7x69+b1AABLqm1aMYgKtKAJfla99cQ
	 W7FOgx1zLW0j6EUKsLbmuyc6XN84w9E54U1ROpiWc894p1Sj1inFyydzHzVWr6pb/ajNl
	 mXxiqOZ7da4ZmOi3ak8lLO28dUtiGdtEV/rzVk4+7RJIOpaMvL1uWTm4eW7B63CpCyHNt
	 WNptZ7Wf2y4+FusBIzJvv1CuXWBeeUXHAZefjzwj/H/qywdFbnXx0OAt+T7WzEgJNCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002216;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/Wfy5TqtrKhlEsWlOdvG5ozxSyAJIllWBB6DPECqpSs=;
	b=FmIZaR5we1pOl9Vm9PLGUcbRQ6y8uTuoCAngGnhfFd4vui+GlZM+QYl8bKKbwdXZSnx3
	 RbEEbsmF1CVwARMsp8YkyzCurD+VKSej1oEx6pR2ZzmD2wQhgQ3o47YbmVhCoY75Bxz1C
	 CE++G679Ruiq1mXDikf+gG4B11/46PIgCwB9yflCy5gUnjDeZeLe/A44j+grmJNdUVqzl
	 nBgAVyxDV0D8yIXmBjh7tOqi8b0TNk10HazeGrIWjyFVDNmgeYcZb1cHx3iTJXT9vPjEb
	 H1ypiqY0MUwJfAfeYE6z0lLrXVKH+PLw7yC7R3Gymy14QQA092Pbc3A/utTwGjnwhaQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v3FGpUVW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002216;
	bh=/Wfy5TqtrKhlEsWlOdvG5ozxSyAJIllWBB6DPECqpSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ShKDOmNXOPXfcoeInn/ALWFahW7H+E7p4phXHqheYtvAZ3qKKxoAKN5bLqSQ2Xd2B
	 hSDjGRyquInxW2eXQxf1k0+LmPQ6CCnsoMNnmWu3UAXmoxKzQtB9RzB9TNZrJVwc3Y
	 CwXPbvJzEax6hcvht70WaeSiCn7NBx4ms4eaX2+cT/3hB4APs7YJgrWTp6s19KWtUA
	 BB6OdHXlVsdfgn8gGa2r/nd0TpCyiKrWKKpkO5iagDv/xDUqZLuqV8SiD4h8uXmoWH
	 NnJeFFDb+AglF9OtBPkewd6G6FJ+PK7VpG8shBBbm0YI7VjVaIEnlQtYwLUhZweJXL
	 dunHoP0knCFYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FF5E60D94;
	Fri,  6 Nov 2026 21:56:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C7AA31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C21B60D94
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T3-S-79SWH2B for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:56:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 480DF60AC5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=v3FGpUVW
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 480DF60AC5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:48 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so704723f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002207; x=1794607007;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/Wfy5TqtrKhlEsWlOdvG5ozxSyAJIllWBB6DPECqpSs=;
 b=v3FGpUVWwvPaRZ01FAQMfbYWalXzwNZn5XJgZIzvnN2CRD/0+ooJgXaqjlyp5uI0QX
 gDyNL8lW+WvHm7SBYsQG8D12ix1lDbEH6lf3eegvwn/As+xVRcDhSHhB39A5c8/znHWQ
 3p0VcPnKds6+fIf9fnffmxo/XMZMq9rl2s4KTv9JN66AQGCKjKOv9WpFQgUSCiBrUCTB
 sxc+mknqGWP+LF72HHZ9F5QGms+1xIHpurdc7xDoVbszbzKHKLjrWn+YSUGCsA7icYdc
 2opvM78THxX+PtZ5n8Dt44o3Ui/8vv/nvm/7Z7UgjJ9fpT2faRIRK6vJzpKrJE8jiQyu
 X2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002207; x=1794607007;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Wfy5TqtrKhlEsWlOdvG5ozxSyAJIllWBB6DPECqpSs=;
 b=2y6NsGBmk2iPKhEID4WJ95M0TXGSBrvUDE/NMUkQfFIHCpIKArhR4tGtlyQptdeEZU
 U7pFogYcVC1ECjxzUKVu6hAU9clCtAhVLGeQXbY+tFSpwQxP/K2v8yqzwHa4HVhJF2+M
 5H4my/FOQXIyEpSzlbm+ijaa+a10dZ5YOxp9MO46L5VBJYZdpzRw0G/SqEKxanNckQBv
 bh6ozx0ydgsQECUNrxdypRNMWj3BHe4ZlcrWWDy/kTuu0chWh9LgdPxKQurcr5DTnjFN
 P3nDWn2qpN7uq8y66xhQ0c4PwdrtTvQ5UBr9b4S46MtChi4+UUQWsNCFbwZgCevKv/6l
 O3tw==
X-Gm-Message-State: APuU4Z88tARs7h24gKEI4kMUZdtJnH0ltUAI93vtQZy+ZcRjVy+9jo0v
 fF6xGrw0NnTrx5Nl+5G7SWVWoDV32AyCqGfCvMx6ODSV6m5lwq2jY20eUZnmFoQw4fw=
X-Gm-Gg: AYBFou1EIiH9SSK4xWkFHxuN0lIZyJyxNvdTotW/8yL2UoY/ZsAyewSEf3yqPTzYYxr
 SxHR8VzZHFqh4rw52CUKtUjbZax/txvTUz4IZEDjGXsORUA7uHiW8Fhlhwj3n/ZCcV2SESfRzdc
 z+CZ0/aAevhPNbUA78vjHH8TeUJ20sgrblLg77Bhe5SWLup/l+Y6xw11w2t+Ncu7T0pOsbw9VOH
 /FTWx3Le+IbwDCjrj9+nWTICO++4OoliZ73VCpi8UJ381wjjNe4dqnVLfKhwut+K2Q4Xb+U0jQn
 B1UsB7Noqr6NhuP4nopKYGXqhAAWGeWOJfI6Cj47oMwDjtU3D0LX6sRz2Bt/dY/lB7RBAZEmWHr
 rQvK1XZN9xwoN0F7Y9l6LsIozRmEQ9MCOSvG5vy4w3eaz+kf+Cm0vnc/vTqVhQoz43kavvPlTpd
 Fx54jN1JgiJEjIdkLQTVjckYiOrzVO7TtPppnPk5AjoC27//2iaQbQIahaXZZ1yUsR+5a5oygV5
 n31YcuHmyJL5K0pIrtC3O93rVPHQ5wz2H9b3FkoZKpz6v4W1pZGM0QpcNJup2NK5hRla65yYqi3
 0aC4mq682VXtcPNSw1oFN0nptGcW/EyXLNSl02NKUcUrY0J0w0RHhw==
X-Received: by 2002:a5d:588e:0:b0:492:a2cc:f2f4 with SMTP id
 ffacd0b85a97d-492a2ccf47emr6765846f8f.53.1794002206817; 
 Fri, 06 Nov 2026 13:56:46 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d6d6391dsm5905120f8f.14.2026.11.06.13.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:56:46 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 04/11] efi_loader: check PE section raw data against the
 image size
Date: Fri, 06 Nov 2026 21:56:45 +0000
Message-ID: <c997a5e1-d8de-44db-bd02-9b926c962625@gmail.com>
In-Reply-To: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_load_pe() copies each section from PointerToRawData in the image
without checking that the copied bytes lie within the image, so a
section pointing near or past the end of the image is read out of
bounds.

Reject a section whose raw data does not lie within the image before the
image is allocated, also when VirtualSize is smaller and only part of
the raw data is copied. barebox, whose EFI loader is based on this file,
checks the copied part since 552a54e4d357 ("efi: loader: validate
section raw data bounds against image size").

This runs before the image is rejected when Secure Boot fails to verify
it.

Fixes: cb149c66342c ("efi_loader: Add PE image loader")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index b21947e979a..c6e7d5fc599 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -1062,6 +1062,13 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			return EFI_LOAD_ERROR;
 		}
 
+		/* The raw data of the section must lie within the image */
+		if (!pe_range_ok(efi_size, sec->PointerToRawData,
+				 sec->SizeOfRawData)) {
+			log_err("Section %d exceeds image size\n", i);
+			return EFI_LOAD_ERROR;
+		}
+
 		virt_size = max_t(unsigned long, virt_size, end);
 	}
 
