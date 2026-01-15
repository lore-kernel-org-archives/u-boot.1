Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23D8D4662F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49A28388D;
	Thu, 15 Jan 2026 23:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EVbhOMby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0843080077; Thu, 15 Jan 2026 23:28:39 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D607B82BF2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7cfd5d34817so916691a34.1
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768516115; x=1769120915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BghNy8czZad84DCT2vd1uH4H0E7QBg2PixwjrpzclvE=;
 b=EVbhOMby1RFCpMNqoBSv8XKbg9ssOJkF6dOOaef2RWriaE4tJg5TLpMI713u+1YdOr
 CCKPzqkaXhPMdB44jMssMftEhhG1kLkWepMKPxt81+ehovCDc+wcWs6HNKtgbg2V/BSk
 Oyh5qpG8D13CqCxG/P+d+6XyWQe6olPcxOPS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516115; x=1769120915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BghNy8czZad84DCT2vd1uH4H0E7QBg2PixwjrpzclvE=;
 b=hPipC+VJ/PUVpBf2z7VAuk/EcPBBWXKAcbRWzc949aJJbKaEyMe+57cuAv3MwxG7pB
 WwkhP+sT1UdoPsVb9He+RgHUz0JokFQfpBTpNDM72D1XnbMf1uFMrJyM+lEdaGiYf1N4
 6E26G7kSbAQ1Xil1o8yGjHBlEzzgRK1LMpLOaixrzj1yolHCA+Gk7pZ2d48MTpUBYR+H
 3t3vlmqKFpoBHqY5a5fRijikxYMtDlNLACT8SzaOo7NaaVV8idex2K5W2IvqLHKypF51
 b5EO674hnYXQXXOSZbKjASrwJ8mUCSKor56mMDrpDP68UpkcGJC88wW0ABEiKx5MJ5J1
 IwRA==
X-Gm-Message-State: AOJu0Yx94RsaUVRSRw4Mm/kJDxidzP6B0R4gcsmv6blhe9Z5aDMezb7O
 o9vCYqbBGpYkyTEvDrqG3u1fTS1/kj1ObU03Do3UFzNUBg6JE++KMV+9geOKjxYGc+C3+nXOa7D
 AQA4SR50=
X-Gm-Gg: AY/fxX4XV0HG9npE5sgsI0nz99m0g8A/nQTBYmTlJ8BzF+x9bPCnMY6el2UN0uXQzjs
 js8YjvyhNZHYfFKTvNpOIy/POUTjdH0Ls2MwOe2wmfrzHv9rxKpyF7AFWhihEAR8i4kIH85Tl28
 qL0XXiOTeWbV1q0P4fF680aBFMpE4X5MwqquLbfW1dagzMEJaNVMNgfkcgFt9chTiouoBPU9ETR
 yJ7Qu3VqsC5KBhzZ/fftepgwNzt0PVyBkeIzhBYOD6z0u0zmFPucUmJoYzl29nA5zrttzUuVvCZ
 RmcZV3GOQ5Syitwe5Cvxm20pp2kEFD39EIsfWpHqVJRZxZWsWMdvQFqqv3ePgQrCulGhoKtxQKe
 SjA0nkwzQTLS0e66p94w8m7ZYPW4PKnth1SOS4Zf2WB8f0EPXQE8yRa7T7gPLLXDC5x8lGcOYPH
 Ct8TPRy+WkoNQuySrWrphiWSQuJb7HeZcnWjp/+YquOIle05cIvHZVN58RMe1DXEVLdf8SfKw7l
 7sIoz1gzJJRg3Gs3EV2FVFJEWaS4Jdek/tgi3YRCQ==
X-Received: by 2002:a05:6830:34a3:b0:7cf:dd63:3d37 with SMTP id
 46e09a7af769-7cfe017233amr260681a34.25.1768516115391; 
 Thu, 15 Jan 2026 14:28:35 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b5aaesm544074a34.31.2026.01.15.14.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:28:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>
Subject: [PATCH 01/10] Makefile: Have binary_size_check report only first
 match of _image_binary_end
Date: Thu, 15 Jan 2026 16:19:31 -0600
Message-ID: <20260115222828.3931345-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115222828.3931345-1-trini@konsulko.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

If we have ASSERT macros that validate the position of
_image_binary_end, our awk expression will report a string that causes
the rest of our check to fail with garbage values. Have it exit after
the first match to fix this.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 50737f938503..37cebd4f8edd 100644
--- a/Makefile
+++ b/Makefile
@@ -1583,7 +1583,7 @@ binary_size_check: u-boot-nodtb.bin FORCE
 	map_size=$(shell cat u-boot.map | \
 		awk ' \
 			/_image_copy_start/ { start = $$1 } \
-			/_image_binary_end/ { end = $$1 } \
+			/_image_binary_end/ { end = $$1;exit } \
 			END { \
 				if (start != "" && end != "") \
 					print end " " start; \
-- 
2.43.0

