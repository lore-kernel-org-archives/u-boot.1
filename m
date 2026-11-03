Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36CB606D824
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=crYlDxBY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEbupjWP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CD9E407D3;
	Tue,  3 Nov 2026 16:13:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b-p-WNuyRNX0; Tue,  3 Nov 2026 16:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 967FD407BA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793722396;
	b=n6p3TQAkrkccUHLi7kTqArZMu2Eng5p55mmxv9fa05Zao90JB4a1GwWmeSeyFviplT5/
	 hY3zjAi8+WMONQB/6kqRn5tQfnBTdif0N0gPZKjbiuSwZRoueQSnnSt3s9NZWHXr8eWG9
	 ubdWzAOvlQ8O08HxW4cYUFQ48cLyhkWA7ban7DGSyuB3Gp5UK+pYYHZ2zYtQs+wT/YqCf
	 XzO7q2fHh2JHvPxGwnxJd0lfim5R7tUUKkCk8w35XbB6GriTZj03DerAW8d/Hnq+ITCvR
	 yH0bDHA/jDJkZZpIEM54Iv+rDgi0Um/zeeM3wFLgMwR82CRoT7wkbHPaDMFtG0iRvAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2y3JlKepvPLXc/EqeWiA8AjBNFsxnHmMBdaD9D0rcE4=;
	b=s27tYy4yUB5GcWx6/CAp6dMCDydot6xU1HS2871d7eBrBwLVIcAyoDW7x/OPz2XHRGLf
	 elC4i2NSIZhnewigMjXaaxQMqjlF9Xz1dIhHIOps+gwzT4srkUUwPo7vfkIKCaiyBBjEp
	 sHnrr1m3wH+zZZvtGy2wcO+Kmsu3ATVv9dZjmfbpCRKkb60LvjtiZw/TsXVvl0w9+m9gr
	 MIXIoPtUFVhr8NwuS4kbEKevnftV7lT1r+Z9Gy4AR3IvmHW2sJ2d8uX4NK3hLu6wuWZ0J
	 9UP/uENX6fVB6omrkjv3+wJcEPfnInNVRJmYAzIok4VMPEQjD1WP7AcygsT6QzIJUEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEbupjWP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793722396;
	bh=2y3JlKepvPLXc/EqeWiA8AjBNFsxnHmMBdaD9D0rcE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=crYlDxBYbwBdJmB+KL+PojFw0vQjtDCBeN5gljHp7VfDwYRHZwc2aWqwjeZ2DvxJV
	 3vqYAY45BZphqtLUNZdPYX2O/KfSEVavy3HNri69hCsxiBEuky8PiGpdvr77wi1Mu/
	 WP2/0Qs1BSWnyLAUtD8eYgyo+xm6M07Gzchb6HgakHY79DBgEdxdRj7MNpc5oMysQW
	 i3FzNG9tdVHPGzwFq91laVgAgj4qtv3JxZRiSY13gLoHVRQWz+OrtI7Qz4PcD2w9cl
	 FLYgNHnVI1c8oIzbaRMdkJsmcoElY5uzMFhvel0uScPCXIJc2NzrF1Rq23saJbDodq
	 1CJiOhoZqWfYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 967FD407BA;
	Tue,  3 Nov 2026 16:13:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC9DF4BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCB0A4079D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id duI_ROM3F_vn for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:13:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AF6EC40799
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793722391;
 b=DIR8A/ZM0JQ86ZO1FasKGxv05ij4p++2HtpQqZHMiHN+NNMjwtOgX81uDEzmFAhhsgCt
 94BFp3B2n7rbyR3zImzX0t16BMyg9M629yglH8CAdajlALY724aCONFlCoySYjBVW8TD7
 fRwzpbc4vsN8HUopT2JGvC7ehBiXFm4n3ZOv3KN43ZGEP1BjvThSJezgGt2Uy+WZ1xP6T
 MFQtRz68ibozLsk9+oaH1E/EQx7rdDsaXLDKHYWmx1HhVMOjmUZJCTn0Oie6J/XkZgRnF
 fSz2RmEZcBUX0mfuZk/c5CkSKd9nuMWV/EWd7BaIeDVsfUB2ZfuzEjcWklv7oUs4A1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793722391;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=2y3JlKepvPLXc/EqeWiA8AjBNFsxnHmMBdaD9D0rcE4=;
 b=ZFIm7Aan0A7700HmWAyG/asXB28yjuL1FN1bIPCbBI2XhwgJ+OaoZ0MCRt4yI/IE+btu
 +xal4PmsItNvLGT/Ci56YY6u626RDfnsEE2kvpd/EjPm5WrJ6iei3zSlXHsrX7UNWKKdy
 VHRJzkvOib0ulXcm06u8Slah5BZVXxqw5YF1pBus6B9w7T43/ngKOjv17VfE3g5vybJJU
 Ijrf38Oiqt7/auXk4bHZkT/9n9ZvGfhv9uWhvLNz5QallfMr2RDOqtHQbMFP5wmhE+jdz
 x5QWcDTgby/Zyg6Fq+/n45VgE65XZt8uwxX8Lplu52I5gJ23PeMHbXJr7Qjp7rOWpJw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=uEbupjWP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=uEbupjWP
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF6EC40799
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:10 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so30320825e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722388; x=1794327188;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2y3JlKepvPLXc/EqeWiA8AjBNFsxnHmMBdaD9D0rcE4=;
 b=uEbupjWPyIQi0VUHFUxpJQxyKe2yKVbnr1MydiJE6BG1l6oE2YVaWQXaJaNR5NmsY+
 yPFyBmXPSNUDR9/oQ0Y1y13k4Cjc4wpZJ2Z6p0JlDOr1HuCbOzSSbNq+2824Pkts55Y2
 hm0YaIILpgpxWhh3UB0gifCujTTaZSscNKRywUUU0wti8io/IcbKb6S48ynOrCCVZj0w
 6HHilM5qQ20/Cqr9n+0adw2QsNVfQYoCX5QVrTaLUk0VCAySQyfG1ev4S0nkHsmesGYS
 Q1yUkhTmqFQBfT34T+AqchKV0LKm1xbWR93mUs1jSD1LDZys3rcpxaRR6mCmdqoc/aHc
 cY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722388; x=1794327188;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2y3JlKepvPLXc/EqeWiA8AjBNFsxnHmMBdaD9D0rcE4=;
 b=YwTyLePFRQZ6jfDyV3CoSM+ewlJ5BTtOXtcs56aFBBWx6AaRCa0devijxVSTOFBCba
 CLXM2N2mkWdbbrLlHmA4+tkyv4X9dc+73psnKzCFX+S0gAwPNLeUxwox7FVceR9Iy9CN
 hY8JfQC0TvFljXI9K2eb2VYVUspVMf7TyTe98zacBvDpIcHvQ6Qeckz9RGveixp55IdO
 +g26FZVIQOuPd6vJCXbnqLDTvKXSNY8RoEOCu47aIVh/ThulmPcZlok06OnTfrgT0+gB
 LPCFNZhazB8uXSQe59LSK6spGfs9zUA6dxjhTP6r8Mw0A+F6ba2er3EoYkq1cvxe1HUz
 MZ2g==
X-Gm-Message-State: APuU4Z84bJQvqJjXNYIj9wLTKVyeAPcpEjzWWeLBShztynH/sV8dW3Hd
 goKC0AhGNITs1PC9i1tsde6nEphWc+9ja9hNuiJksNFlstF0Q3SxQeWKKwsAlhiNvRDUEZLV
X-Gm-Gg: AYBFou1PQ68+KKPMc5RpyiJqUkyJLRTjxw7UIqy9P2pd8uhUotjn9XflDxnlyoD0t50
 JEHYHZZaTGC58cZxZJGRs5mGYfx7TO/D1ZNT72QuTh/ZFX+v2S+fNA4HH6l4oVBOS4P43j1y2Wd
 azZi2vap8H5UjYHWzIq9lr6LzmCoLbLZJk0lBwq8tfzFyDA/t83Kjk2tz+vE5mPgxU9JZtNvF4H
 VAR8a76dgZNWPoDggqC8e/vRRTOTuVLOfVY9F63eyGxIcncEjPqwSUZgSkWOdgFHZarvHh5UxfE
 pfZwfX9qXsQRp0fJifTRcOgEu/L/9OFEIAWHAvMmj5UVrQ00LTxP4ypCCrsukr0hcMbRVU7/SYC
 2K5f4pFk8wQxTHEXLDk47WrXIeue3Ea+N40pHR37WCQFuZJrmjS9/69mZWNQ3+XHafIOpx83c2p
 Y/7eYNRpXGREJVH37rDVxWbSeCIxl5sMgobRi7UU1+0/Eaa7U7O+OJMNmWFCtDlaXYR//eFX/zo
 uMQyHjZ02WWbI7TnEK0lS8XPWziu+jD2d5NI5WjKwBof42defxwoTCZDsMrrohFPGDx88juCgA3
 8iQk98KGdJPSUlK+T1dui+21bMKrHVo=
X-Received: by 2002:a05:600c:818e:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-4ac1932aa2amr303954605e9.34.1793722388383; 
 Tue, 03 Nov 2026 08:13:08 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a8d60bc5sm71939315e9.8.2026.11.03.08.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:13:08 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 09/11] efi_loader: do not start an image that cannot be
 measured
Date: Tue, 03 Nov 2026 16:13:06 +0000
Message-ID: <ef52b7da-2f83-4663-8633-9f97929fe9f4@gmail.com>
In-Reply-To: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
References: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
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

With TCG2 measured boot, efi_load_pe() measures each image into PCR 4
or 2. When the measurement finds no TPM, it marks the image as not
authenticated, so that it cannot be started. Any other error is ignored,
so an image whose hash cannot be computed, because efi_image_parse()
rejects it, or whose PCR could not be extended is loaded and can be
started without being measured. With the range checks added to
efi_image_parse() earlier in this series, more malformed images take
this path. Such an image runs with boot services and can start the
expected boot loader itself, which is measured as usual, so the PCRs
end up as for a good boot.

Handle every failed measurement like the missing TPM: mark the image as
not authenticated, so that LoadImage() returns EFI_SECURITY_VIOLATION
and StartImage() refuses to start it. A full event log is no error, as
in EDK2's DxeTpm2MeasureBootLib: the PCR has been extended all the same.

Fixes: 163a0d7e2cbd ("efi_loader: add PE/COFF image measurement")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
This applies on top of Heinrich's "efi_loader: handling of missing
TPM in efi_load_pe()": https://patchwork.ozlabs.org/patch/2335140/

 lib/efi_loader/efi_image_loader.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index a0879f18621..ef6ff055c63 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -1163,6 +1163,14 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 		 */
 		log_err("PE image measurement failed, no tpm device found\n");
 		handle->auth_status = EFI_IMAGE_AUTH_FAILED;
+	} else if (ret != EFI_SUCCESS && ret != EFI_VOLUME_FULL) {
+		/*
+		 * The image cannot be hashed or the PCR cannot be extended.
+		 * Do not start an image that has not been measured. A full
+		 * event log is no error: the PCR has been extended all the same.
+		 */
+		log_err("PE image measurement failed\n");
+		handle->auth_status = EFI_IMAGE_AUTH_FAILED;
 	}
 #endif
 
