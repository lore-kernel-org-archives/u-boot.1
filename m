Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23397C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 15:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3594982DA1;
	Wed, 18 Jun 2025 16:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hMuREbh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B851282E52; Wed, 18 Jun 2025 16:59:54 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F1C782DA1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6fac1c60e19so8807556d6.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750258791; x=1750863591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGDTPbC9lSlcOB+BKPkwzmjNWoqemIXA/4JVCKhvSjE=;
 b=hMuREbh59gSyC8OkUrCDxb9N5AzjkPZyqseTGWDdOGSnu1KlE/YkSx26SCm1PGXlVL
 1jh8I7Ky0R5+P5HZelbRIDViF3U2CX/6YmqN867xTbQuiLYGa9MGPh6AnNFuYWHK4S/n
 1DXfwmPO83SOXOYyexfuYwa9Fpolv7C/a8g2+Vn96B7rTplykNXbmxqU6O3Yw9/nHDQJ
 zhFHs0+LRdmA1o59oNsWer69B13U6XSTT0+ZuQMCB8jDm7f3NTwnapia3L2yEBWPGywD
 zRKAw8YE8sBFy5O5+HRY51Ic3mqoyjEg6VtFS1vfXEvnOohDHu/gT+4tnd00JnVq9ReN
 4gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750258791; x=1750863591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGDTPbC9lSlcOB+BKPkwzmjNWoqemIXA/4JVCKhvSjE=;
 b=Fh6Lk+LuERqx2IhHc4ntxLmFCfmoZ+wyLDaO2KAp43Vdh3gTNCpfcT80ylqOQkgkqS
 I3+XGrBPaiByWTwl2TcBC0mcjDHdSwjTFKQfuS/Ib+bQrqff8U7IcCTdB4D+eqmhhXnu
 vhUFlbfMUStTP6GuB8TrBU/4/q1ioyYUumQvDOy25rIm5c6s9NQamJ+tcbyvJBGPo1W6
 D9+szqe+s7/NTurXME1Djn14VdsfrfUi8iMJsY3/r4cpcFu+lBubEJ4F7zXUdAOhLIbF
 2bCxxZi0pl8KBTm95m6oBUEc8UihVz+x0gYfY/c6WJK8SXvZ6cYXc2Jn1Ab8Su3UHOzc
 +quA==
X-Gm-Message-State: AOJu0YxJVIF1A18YlIBeecfJI2xcjIyfcnBWLj4C5pGxDGXU8oqQ5uCt
 /4Z9zFVqu/nTM58k0KhUo75WwHX0QDHBdICkl4OIhNJ5g81qpNqtDsIeuQXw7b6+SUkMHv1QS1p
 1z2t2
X-Gm-Gg: ASbGncukVlh31hkO/BFFaDOXijE/lebnanlZQeWLxMtMWpP6k0wttp8Y2PGyg8afbAe
 eksSXdI6vbpXUnZkDz2aLng0UK14n1eBsuQAbA8WEO254EDX5gF1lxju8TAGeeOoEC62TI6dIpB
 3+z/agCIYZNd5Md2TvMnsqFFr5uuN/EOHs6OqXBM9LnRFtjduqx9T3MR+mG7aF8bR28uDm0Vd/M
 aYWrz+iYfBVGqicvRZMIo64VgPE1ojF/nGxPaW47MEQdmym2HdAs6mv6Y6rweNdEYiVytCTeeoh
 S2tZNWvcEEe70KoWP+d8usqRVaMqysgMRI8BJ+UWVH7u4aixuKbR6TW1zYdoUJVuFWQtSm69i0F
 B9mHpAvp57xbIub0WgwnNF7Jilo9Pk5BrsWckPX3BUEeOBaw=
X-Google-Smtp-Source: AGHT+IFabDbJus/OyJfi6Qddsz59REBpeQmqN5qFh97uQmXU6lcOCemLKteZAuVh0RVWY3vlo2yqsw==
X-Received: by 2002:a05:6214:3204:b0:6fb:2493:93b2 with SMTP id
 6a1803df08f44-6fb68ba8ec8mr40424606d6.11.1750258791173; 
 Wed, 18 Jun 2025 07:59:51 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb4d627a14sm44736416d6.68.2025.06.18.07.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:59:50 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/6] bloblist: fix a potential negative size for memmove
Date: Wed, 18 Jun 2025 07:59:25 -0700
Message-Id: <20250618145930.2652304-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618145930.2652304-1-raymond.mao@linaro.org>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
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

It causes a panic when blob is shrunk and 'new_alloced' is less than
'next_ofs'. The data area that needs to be moved should end up at
'hdr->used_size'.

Fixes: 1fe59375498f ("bloblist: Support resizing a blob")
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 488908f605e..550c0c78ffc 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -335,7 +335,7 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
 	next_ofs = bloblist_blob_end_ofs(hdr, rec);
 	if (next_ofs != hdr->used_size) {
 		memmove((void *)hdr + next_ofs + expand_by,
-			(void *)hdr + next_ofs, new_alloced - next_ofs);
+			(void *)hdr + next_ofs, hdr->used_size - next_ofs);
 	}
 	hdr->used_size = new_alloced;
 
-- 
2.25.1

