Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E52606A320
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vECn9TqS;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=srdmCErp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94523607E7;
	Thu, 22 Oct 2026 19:41:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WsU9ynH5bTI; Thu, 22 Oct 2026 19:41:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7B0896079B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792698074;
	b=n9IXCUjBXaUc+cQ7J+V0ikmAD9Nczxj8+Q7uI4kEfltaHkDIpVBJtnO6Pfl1vcSy9eQM
	 SM7Gu0adlmuLhsAzlPuaJGXfwgvyEzZRxmvbI1ONtpkwzdoyq5ZhspFZddVihDJ8XajYz
	 yymPQX3zG2dBaYl4gYLI2IZD1Qy8KWvFUX5MSlk1lul8a1QCVs9vTdQo9IJD3+dRQ8vNw
	 JcP61NSi/4t98pbKJ74O73EH6d6iRyTJE5nR4H618xCFzehJQXb/jdnA0gvOOqVlZZrMq
	 av/eB1fpB8NV/4bDttiJFYe/cvUlhDpxFUZSMYp28V/Y/5Dz4RK3882Vg8rjCq/GeCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792698074;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lRN3k44P9o4ZYHgQJI3KpHj+LCu/BviRmCCIB++Lr0Y=;
	b=W0+ZSBVlr3CHmOSFTTz2qSARKN4omFrjrNehuAi+a68kyjQIModaFm9aBr0N7Gub2/1x
	 9zQQ7CQLOMsT8TuHnaL44L8AGSpFH/pRG02+Y7l5MPyAN4fq+UOLSkJU0kLmvoPxlCkP7
	 qJfOsu4zwxdbcb7DPoOBJfSqJp7D+t71YuxGD0k5wJnRMq2ySll4sSn50VASpYwPmv4MH
	 FmRs6gRnebBR1vc+fmddtGpORMqkSPWcQ/auoUmuqOTWMJugRxhg4BIb57RE/Ah4y/eml
	 dSTF+UlNvocNFYdoYfmmWm7E6h3q3JpC4TIsNX0FkYis3RFVYcbeeVGssv8y2XDHW4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=srdmCErp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792698074;
	bh=lRN3k44P9o4ZYHgQJI3KpHj+LCu/BviRmCCIB++Lr0Y=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vECn9TqSa1jyA8ZRBQtK4ZwYCc0lfHqgKeebjXxHKBqyZs4fYuvfNMhsV5Ser4IYJ
	 FZJ3lnvEh6Hz2h87wdM+sQxzpZtlB1gqBEBrW4cy9EnBKCPzyceWBZ1dR0LWYYpZ9v
	 x3FOceEybcObpmgKf/0vYa/s2orfYXvDY8EkRBvQd0JOAb96hRNK9aKN4SZhALVhuw
	 +mRu12ABfm3Fsp019nNtvKYy5yssez5BJV/BR8Duiq5MlOq4pZWtLGJNtIxmgZPj2o
	 eYGfb+40G3MTSH/+oMhvjyLzLgoolhfUMe/CyFjmbQwxl5tQs4GL4zXK2ZTt2WzUdB
	 sYKGOVRyk8DCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B0896079B;
	Thu, 22 Oct 2026 19:41:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 399513A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B54F6079B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DwBE724bLd-J for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:41:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3BD96062D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792698070;
 b=TAYfTel94HB6p6YlMYRaWj8znp2dbsWwOY/KpQ0icAr0HNTuXDtAiahhwMx3mx9lm0HT
 NwJ83DCgubGw7b0oLKDthLg6PRjP3jmvzZ7H3JLovsqW1T58JiRX6ozoeiK4rVbSI8bb3
 se7+XjR5YANC/UE7S5RaT5pkkc89/ygGxAH4oGImecYG4NKMAzWKfu9sj+S2ES7pYhoHX
 7/Y3l/gf4g+jpudgJoGxbZ8/qs7xTS83b2yksPwREXu92AZ7jf1DqPasBOlWtAYxQGaFe
 fMurUWChNA6QsyMIsZ4JJfKyyf5up0r54BvQ58pYxfSWgDDC2kexwDS2ebC0oJR3eIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792698070;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=lRN3k44P9o4ZYHgQJI3KpHj+LCu/BviRmCCIB++Lr0Y=;
 b=r45yryxS88KYLIClwlvjICzLHBUldfWb2ApkM5PYYr2t+zjTqPajVWwqL8HOCthEu60o
 oW7brP7FTx5KKqDUS5GK7KPh7z02d42VQz1N/NEpJgudmxrMIrOs7N0Bj+TAev9+VwQe9
 zJ67QquXhpg9oMRO0B0dwRKx/JRq/Z60whn4Elj/8rni0hux49pODGDYPqREG45dF9XKq
 Iuq35aOWfqhfcM0rBMCDgJICaO/iX6heaVflB8vaHm89Zduu3qllxFsUz66N5q44LinKw
 7M1/1TUdrjclpjHxOlnYqj5Zv3M05z4QB5NPGec5IQelulW6Yhv7FRj0xb0TGQ5ECiQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=srdmCErp; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=srdmCErp
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3BD96062D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:09 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso1402915e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792698068; x=1793302868;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lRN3k44P9o4ZYHgQJI3KpHj+LCu/BviRmCCIB++Lr0Y=;
 b=srdmCErpfUH/ps8jfEpIubL9h7PiliuUOBZ4p/vUwI61Sowi2oI6RTJjHNmkpyITNq
 NRwWnqPj18c8wzakxkmAqPhCg3ll5HApkt0HE2xL2HB3l6C91CTPpTnA0oDfNSMd3Dgc
 064crv9KIgFkM9j45DBMOPz8uCYOl9KLtt/vxoaJtUcMyGRhLOWdp/R8wsjCxUwN+Y2K
 81pV2UemlZAZkipIkpkbU6MTEyx1DUilyeK/2L457kTx5F6HzU6uehjemYshFDOAj6X9
 W1zQCZN2yKjpRiNjbi7emAINHygF7swVdnd+Uy4yHKMAbvKtEFi6ZxxDAmrCQ9zQzNnG
 d/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792698068; x=1793302868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lRN3k44P9o4ZYHgQJI3KpHj+LCu/BviRmCCIB++Lr0Y=;
 b=CKnYBa8N6Wts2z34qUGv18zE3n2F2lXwuTOKyreHjMmF4qkCQPgseGRPjmYXuePruy
 6p3DZ4yihEbiBwxbmTQj3SgIIMO+2DI0anfUvPZp5kwRQNeFDYwcNcuYyY5L7dc6naTm
 C9r3fuRjFBpvrAMTiDCnTccofDM08xj9c83fx97i+cDbqTlr1LdXc6mK47WrKbsgWmsQ
 vj9omxRC8yT9EEu3hWN7G3QMJSuzgWKSY2Ocj/rxjO6Tj+Q52XV7SSRXCfIIcrcdA2LA
 vaDPMk37l2twB4HKjULYe6WtjYI4QbINQTC7YfJP4MKjAHP3lscT9nVXb2KhJEnBEz0O
 aBtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfoBmavY2wt/MIk3KdKiiCwfmo1H5VF7y83DPZZh8WZ/LRsE5vtYGlDtHTjZPUdsV6rWId74I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLh4/4cY9KVJeTXzUBk5um+6hwLnm+xC8l3hhIhfZzq32T1z15P
 Ax+sCUJ33QxYHzgmGisukNEQKGRT0mV2g2FL1NKxrvAXUgSbWMwkn71r
X-Gm-Gg: AYBFou1vgatOXyHHelVnjfygfnAHWiEjAE3wpNyZoeEBFJh16sTkrcGZxsvr2yug5sA
 BTz5GtmNQeOPdDSnVMGuwdihwtBII7lACbvNqlSjbSM5/z2DZLddY/2Bs8nc5Ss5KyV7gIV0xEm
 N/vFZJ+FckQMHO8zLgjOfXRfgWHuoa72jhtFyXo1eE1rXeT7jhBYfjc0ht3i9NFGEcbRxyH1qPs
 7/0ehB/j4c6JpgxWXpMCdDRiBRuttpbyJa8zXgkBtj5pCqAe+hmUjkvJJVYBjqzY086dUwQuKkM
 G4SYjsVtWl9qwVmlKfA53RlIjYF/y3guQluseToJLc3F7ntMv6349A90RhgeN/3QfrsSINRDQno
 qiWFgbX3pJmyqjoZcMCRBUUuXLckJfA7awRPmnnW9189o1jT+IOOdOGpsWiedvxzIcrVKvNAhKJ
 muzVGgexqF5eYgA5oT2qQSAkoEwuNB4+/uQXamDS27H4lFtWd6W/gMm2XAdfOnzHLdi/VZVYg33
 NuprN1uWL8vsEpkKk8Yu+dcJRZUYlqJlgJcSMVd4vLE2oFxR6/VlaGnwC7B3xAn8jW9iF8XBuHM
 R6lbArIWrCOLFFWOuE3/pioInzKP+ztdYlvufLF0GXnH3U4rRqCIPADGMoUw
X-Received: by 2002:a7b:cbc9:0:b0:4a1:efba:511 with SMTP id
 5b1f17b1804b1-4a211f0493bmr721105e9.35.1792698067367; 
 Thu, 22 Oct 2026 12:41:07 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a211be8f79sm3185715e9.14.2026.10.22.12.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:41:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v8 2/7] misc: fs_loader: reorganize and split to FS loader and
 FW UCLASS
Date: Thu, 22 Oct 2026 21:40:37 +0200
Message-ID: <20261022194049.670889-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022194049.670889-1-ansuelsmth@gmail.com>
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In preparation to the introduction of variant of the FS loader,
reorganize and split the driver to generic fw_loader UCLASS and
specific fs_loader function. Create a dedicated directory for the loader
and move the internal structs and functions to a dedicated header file.
While at it also drop some redundant check and rename some variables as we
are updating the code for the UCLASS rework.
Doc are renamed and updated to a more generic name and for the new UCLASS.

This will permit to reuse all the property and logic of FS loader
with container that are not exactly a readable filesystem.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 ...irmware_loader.rst => firmware_loader.rst} |   6 +-
 doc/develop/driver-model/index.rst            |   2 +-
 drivers/misc/Kconfig                          |   8 +
 drivers/misc/Makefile                         |   2 +-
 drivers/misc/fs_loader.c                      | 328 ------------------
 drivers/misc/fw_loader/Makefile               |   4 +
 drivers/misc/fw_loader/fs_loader.c            | 176 ++++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c     | 188 ++++++++++
 drivers/misc/fw_loader/internal.h             |  91 +++++
 include/dm/uclass-id.h                        |   2 +-
 include/fs_loader.h                           |  47 +--
 include/fw_loader.h                           |  19 +
 12 files changed, 494 insertions(+), 379 deletions(-)
 rename doc/develop/driver-model/{fs_firmware_loader.rst => firmware_loader.rst} (95%)
 delete mode 100644 drivers/misc/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/fw_loader-uclass.c
 create mode 100644 drivers/misc/fw_loader/internal.h

diff --git a/doc/develop/driver-model/fs_firmware_loader.rst b/doc/develop/driver-model/firmware_loader.rst
similarity index 95%
rename from doc/develop/driver-model/fs_firmware_loader.rst
rename to doc/develop/driver-model/firmware_loader.rst
index 630daf636f18..2d11a74d5e2f 100644
--- a/doc/develop/driver-model/fs_firmware_loader.rst
+++ b/doc/develop/driver-model/firmware_loader.rst
@@ -4,7 +4,7 @@
 File System Firmware Loader
 ===========================
 
-This is file system firmware loader for U-Boot framework, which has very close
+This is firmware loader for U-Boot framework, which has very close
 to some Linux Firmware API. For the details of Linux Firmware API, you can refer
 to https://docs.kernel.org/driver-api/firmware/index.html.
 
@@ -87,7 +87,7 @@ For example of getting DT phandle from /chosen and creating instance:
 	}
 
 	phandle = fdt32_to_cpu(*phandle_p);
-	ret = uclass_get_device_by_phandle_id(UCLASS_FS_FIRMWARE_LOADER,
+	ret = uclass_get_device_by_phandle_id(UCLASS_FIRMWARE_LOADER,
 					     phandle, &dev);
 	if (ret)
 		return ret;
@@ -145,7 +145,7 @@ instance:
 
 .. code-block:: c
 
-	ret = uclass_get_device_by_phandle_id(UCLASS_FS_FIRMWARE_LOADER,
+	ret = uclass_get_device_by_phandle_id(UCLASS_FIRMWARE_LOADER,
 					     phandle, &dev);
 	if (ret)
 		return ret;
diff --git a/doc/develop/driver-model/index.rst b/doc/develop/driver-model/index.rst
index 8e12bbd9366a..b2d46da4e239 100644
--- a/doc/develop/driver-model/index.rst
+++ b/doc/develop/driver-model/index.rst
@@ -15,7 +15,7 @@ subsystems
    design
    ethernet
    fdt-fixup
-   fs_firmware_loader
+   firmware_loader
    i2c-howto
    livetree
    migration
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5f22bcb330ee..1cab469a3434 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -621,8 +621,12 @@ config MPC83XX_SERDES
 	help
 	  Support for serdes found on MPC83xx SoCs.
 
+config FW_LOADER_UCLASS
+	bool
+
 config FS_LOADER
 	bool "Enable loader driver for file system"
+	select FW_LOADER_UCLASS
 	help
 	  This is file system generic loader which can be used to load
 	  the file image from the storage into target such as memory.
@@ -630,8 +634,12 @@ config FS_LOADER
 	  The consumer driver would then use this loader to program whatever,
 	  ie. the FPGA device.
 
+config SPL_FW_LOADER_UCLASS
+	bool
+
 config SPL_FS_LOADER
 	bool "Enable loader driver for file system in SPL"
+	select SPL_FW_LOADER_UCLASS
 	depends on SPL
 	help
 	  This is file system generic loader which can be used to load
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 9ddbe9cd1142..f138ff9126f1 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_FSL_DEVICE_DISABLE) += fsl_devdis.o
 obj-$(CONFIG_FSL_IFC) += fsl_ifc.o
 obj-$(CONFIG_FSL_IIM) += fsl_iim.o
 obj-$(CONFIG_FSL_SEC_MON) += fsl_sec_mon.o
-obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
+obj-$(CONFIG_$(PHASE_)FW_LOADER_UCLASS) += fw_loader/
 obj-$(CONFIG_GATEWORKS_SC) += gsc.o
 obj-$(CONFIG_GXP_EEPROM) += gxp_eeprom.o
 obj-$(CONFIG_GDSYS_IOEP) += gdsys_ioep.o
diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
deleted file mode 100644
index cd4695b08eea..000000000000
--- a/drivers/misc/fs_loader.c
+++ /dev/null
@@ -1,328 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
- /*
- * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
- *
- */
-
-#define LOG_CATEGORY UCLASS_FS_FIRMWARE_LOADER
-
-#include <dm.h>
-#include <env.h>
-#include <errno.h>
-#include <blk.h>
-#include <fs.h>
-#include <fs_loader.h>
-#include <log.h>
-#include <dm/device-internal.h>
-#include <dm/root.h>
-#include <linux/string.h>
-#include <mapmem.h>
-#include <malloc.h>
-#include <spl.h>
-
-#ifdef CONFIG_CMD_UBIFS
-#include <ubi_uboot.h>
-#endif
-
-/**
- * struct firmware - A place for storing firmware and its attribute data.
- *
- * This holds information about a firmware and its content.
- *
- * @size: Size of a file
- * @data: Buffer for file
- * @priv: Firmware loader private fields
- * @name: Filename
- * @offset: Offset of reading a file
- */
-struct firmware {
-	size_t size;
-	const u8 *data;
-	const char *name;
-	u32 offset;
-};
-
-#ifdef CONFIG_CMD_UBIFS
-static int mount_ubifs(char *mtdpart, char *ubivol)
-{
-	int ret = ubi_part(mtdpart, NULL);
-
-	if (ret) {
-		debug("Cannot find mtd partition %s\n", mtdpart);
-		return ret;
-	}
-
-	return cmd_ubifs_mount(ubivol);
-}
-
-static int umount_ubifs(void)
-{
-	return cmd_ubifs_umount();
-}
-#else
-static int mount_ubifs(char *mtdpart, char *ubivol)
-{
-	debug("Error: Cannot load image: no UBIFS support\n");
-	return -ENOSYS;
-}
-#endif
-
-static int select_fs_dev(struct device_plat *plat)
-{
-	int ret;
-
-	if (plat->phandlepart.phandle) {
-		ofnode node;
-
-		node = ofnode_get_by_phandle(plat->phandlepart.phandle);
-
-		struct udevice *dev;
-
-		ret = device_get_global_by_ofnode(node, &dev);
-		if (!ret) {
-			struct blk_desc *desc = blk_get_by_device(dev);
-			if (desc) {
-				ret = fs_set_blk_dev_with_part(desc,
-					plat->phandlepart.partition);
-			} else {
-				debug("%s: No device found\n", __func__);
-				return -ENODEV;
-			}
-		}
-	} else if (plat->mtdpart && plat->ubivol) {
-		ret = mount_ubifs(plat->mtdpart, plat->ubivol);
-		if (ret)
-			return ret;
-
-		ret = fs_set_blk_dev("ubi", NULL, FS_TYPE_UBIFS);
-	} else {
-		debug("Error: unsupported storage device.\n");
-		return -ENODEV;
-	}
-
-	if (ret)
-		debug("Error: could not access storage.\n");
-
-	return ret;
-}
-
-/**
- * _request_firmware_prepare - Prepare firmware struct.
- *
- * @dev: An instance of a driver.
- * @name: Name of firmware file.
- * @dbuf: Address of buffer to load firmware into.
- * @size: Size of buffer.
- * @offset: Offset of a file for start reading into buffer.
- *
- * Return: Negative value if fail, 0 for successful.
- */
-static int _request_firmware_prepare(struct udevice *dev,
-				    const char *name, void *dbuf,
-				    size_t size, u32 offset)
-{
-	if (!name || name[0] == '\0')
-		return -EINVAL;
-
-	struct firmware *firmwarep = dev_get_priv(dev);
-
-	if (!firmwarep)
-		return -ENOMEM;
-
-	firmwarep->name = name;
-	firmwarep->offset = offset;
-	firmwarep->data = dbuf;
-	firmwarep->size = size;
-
-	return 0;
-}
-
-/**
- * fw_get_filesystem_firmware - load firmware into an allocated buffer.
- * @dev: An instance of a driver.
- *
- * Return: Size of total read, negative value when error.
- */
-static int fw_get_filesystem_firmware(struct udevice *dev)
-{
-	loff_t actread = 0;
-	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
-	int ret;
-
-	storage_interface = env_get("storage_interface");
-	dev_part = env_get("fw_dev_part");
-	ubi_mtdpart = env_get("fw_ubi_mtdpart");
-	ubi_volume = env_get("fw_ubi_volume");
-
-	if (storage_interface && dev_part) {
-		ret = fs_set_blk_dev(storage_interface, dev_part, FS_TYPE_ANY);
-	} else if (storage_interface && ubi_mtdpart && ubi_volume) {
-		ret = mount_ubifs(ubi_mtdpart, ubi_volume);
-		if (ret)
-			return ret;
-
-		if (!strcmp("ubi", storage_interface))
-			ret = fs_set_blk_dev(storage_interface, NULL,
-				FS_TYPE_UBIFS);
-		else
-			ret = -ENODEV;
-	} else {
-		ret = select_fs_dev(dev_get_plat(dev));
-	}
-
-	if (ret)
-		goto out;
-
-	struct firmware *firmwarep = dev_get_priv(dev);
-
-	if (!firmwarep) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
-			firmwarep->offset, firmwarep->size, &actread);
-
-	if (ret) {
-		debug("Error: %d Failed to read %s from flash %lld != %zu.\n",
-		      ret, firmwarep->name, actread, firmwarep->size);
-	} else {
-		ret = actread;
-	}
-
-out:
-#ifdef CONFIG_CMD_UBIFS
-	umount_ubifs();
-#endif
-	return ret;
-}
-
-/**
- * request_firmware_into_buf - Load firmware into a previously allocated buffer.
- * @dev: An instance of a driver.
- * @name: Name of firmware file.
- * @buf: Address of buffer to load firmware into.
- * @size: Size of buffer.
- * @offset: Offset of a file for start reading into buffer.
- *
- * The firmware is loaded directly into the buffer pointed to by @buf.
- *
- * Return: Size of total read, negative value when error.
- */
-int request_firmware_into_buf(struct udevice *dev,
-			      const char *name,
-			      void *buf, size_t size, u32 offset)
-{
-	int ret;
-
-	if (!dev)
-		return -EINVAL;
-
-	ret = _request_firmware_prepare(dev, name, buf, size, offset);
-	if (ret < 0) /* error */
-		return ret;
-
-	ret = fw_get_filesystem_firmware(dev);
-
-	return ret;
-}
-
-static int fs_loader_of_to_plat(struct udevice *dev)
-{
-	u32 phandlepart[2];
-
-	ofnode fs_loader_node = dev_ofnode(dev);
-
-	if (ofnode_valid(fs_loader_node)) {
-		struct device_plat *plat;
-
-		plat = dev_get_plat(dev);
-		if (!ofnode_read_u32_array(fs_loader_node,
-					  "phandlepart",
-					  phandlepart, 2)) {
-			plat->phandlepart.phandle = phandlepart[0];
-			plat->phandlepart.partition = phandlepart[1];
-		}
-
-		plat->mtdpart = (char *)ofnode_read_string(
-				 fs_loader_node, "mtdpart");
-
-		plat->ubivol = (char *)ofnode_read_string(
-				 fs_loader_node, "ubivol");
-	}
-
-	return 0;
-}
-
-static int fs_loader_probe(struct udevice *dev)
-{
-#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
-	int ret;
-	struct device_plat *plat = dev_get_plat(dev);
-
-	if (plat->phandlepart.phandle) {
-		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
-		struct udevice *parent_dev = NULL;
-
-		ret = device_get_global_by_ofnode(node, &parent_dev);
-		if (!ret) {
-			struct udevice *dev;
-
-			ret = blk_get_from_parent(parent_dev, &dev);
-			if (ret) {
-				debug("fs_loader: No block device: %d\n",
-					ret);
-
-				return ret;
-			}
-		}
-	}
-#endif
-
-	return 0;
-};
-
-static const struct udevice_id fs_loader_ids[] = {
-	{ .compatible = "u-boot,fs-loader"},
-	{ }
-};
-
-U_BOOT_DRIVER(fs_loader) = {
-	.name			= "fs-loader",
-	.id			= UCLASS_FS_FIRMWARE_LOADER,
-	.of_match		= fs_loader_ids,
-	.probe			= fs_loader_probe,
-	.of_to_plat	= fs_loader_of_to_plat,
-	.plat_auto	= sizeof(struct device_plat),
-	.priv_auto	= sizeof(struct firmware),
-};
-
-static struct device_plat default_plat = { 0 };
-
-int get_fs_loader(struct udevice **dev)
-{
-	int ret;
-	ofnode node = ofnode_get_chosen_node("firmware-loader");
-
-	if (ofnode_valid(node))
-		return uclass_get_device_by_ofnode(UCLASS_FS_FIRMWARE_LOADER,
-						   node, dev);
-
-	/* Try the first device if none was chosen */
-	ret = uclass_first_device_err(UCLASS_FS_FIRMWARE_LOADER, dev);
-	if (ret != -ENODEV)
-		return ret;
-
-	/* Just create a new device */
-	ret = device_bind(dm_root(), DM_DRIVER_REF(fs_loader), "default-loader",
-			  &default_plat, ofnode_null(), dev);
-	if (ret)
-		return ret;
-
-	return device_probe(*dev);
-}
-
-UCLASS_DRIVER(fs_loader) = {
-	.id		= UCLASS_FS_FIRMWARE_LOADER,
-	.name		= "fs-loader",
-};
diff --git a/drivers/misc/fw_loader/Makefile b/drivers/misc/fw_loader/Makefile
new file mode 100644
index 000000000000..f5df0db61c22
--- /dev/null
+++ b/drivers/misc/fw_loader/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_$(PHASE_)FW_LOADER_UCLASS) += fw_loader-uclass.o
+obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
new file mode 100644
index 000000000000..9923fb5e123d
--- /dev/null
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
+ *
+ */
+
+#define LOG_CATEGORY UCLASS_FIRMWARE_LOADER
+
+#include <dm.h>
+#include <errno.h>
+#include <blk.h>
+#include <fs.h>
+#include <fs_loader.h>
+#include <log.h>
+#include <dm/device-internal.h>
+#include <dm/root.h>
+#include <linux/string.h>
+#include <mapmem.h>
+#include <malloc.h>
+#include <spl.h>
+
+#ifdef CONFIG_CMD_UBIFS
+#include <ubi_uboot.h>
+#endif
+
+#include "internal.h"
+
+#ifdef CONFIG_CMD_UBIFS
+static int mount_ubifs(char *mtdpart, char *ubivol)
+{
+	int ret;
+
+	ret = generic_fw_loader_ubi_select(mtdpart);
+	if (ret)
+		return ret;
+
+	return cmd_ubifs_mount(ubivol);
+}
+
+static int umount_ubifs(void)
+{
+	return cmd_ubifs_umount();
+}
+#else
+static int mount_ubifs(char *mtdpart, char *ubivol)
+{
+	debug("Error: Cannot load image: no UBIFS support\n");
+	return -ENOSYS;
+}
+#endif
+
+static int select_fs_dev(struct fw_loader_plat *plat)
+{
+	int ret;
+
+	if (plat->phandlepart.phandle) {
+		struct blk_desc *desc;
+
+		ret = generic_fw_loader_get_phandle_desc(plat, &desc);
+		if (!desc)
+			debug("%s: No device found\n", __func__);
+
+		if (!ret)
+			ret = fs_set_blk_dev_with_part(desc,
+				plat->phandlepart.partition);
+	} else if (plat->mtdpart && plat->ubivol) {
+		ret = mount_ubifs(plat->mtdpart, plat->ubivol);
+		if (ret)
+			return ret;
+
+		ret = fs_set_blk_dev("ubi", NULL, FS_TYPE_UBIFS);
+	} else {
+		debug("Error: unsupported storage device.\n");
+		return -ENODEV;
+	}
+
+	if (ret)
+		debug("Error: could not access storage.\n");
+
+	return ret;
+}
+
+/**
+ * fw_get_filesystem_firmware - load firmware into an allocated buffer.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+static int fw_get_filesystem_firmware(struct udevice *dev)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
+	struct fw_loader_env_info info = { };
+	loff_t actread = 0;
+	int ret;
+
+	generic_fw_loader_env_info(&info);
+
+	if (info.storage_interface && info.dev_part) {
+		ret = fs_set_blk_dev(info.storage_interface,
+				     info.dev_part, FS_TYPE_ANY);
+	} else if (info.storage_interface && info.ubi_mtdpart &&
+		   info.ubi_volume) {
+		ret = mount_ubifs(info.ubi_mtdpart, info.ubi_volume);
+		if (ret)
+			return ret;
+
+		if (!strcmp("ubi", info.storage_interface))
+			ret = fs_set_blk_dev(info.storage_interface, NULL,
+					     FS_TYPE_UBIFS);
+		else
+			ret = -ENODEV;
+	} else {
+		ret = select_fs_dev(plat);
+	}
+
+	if (ret)
+		goto out;
+
+	ret = fs_read(upriv->name, (ulong)map_to_sysmem(upriv->data),
+		      upriv->offset, upriv->size, &actread);
+
+	if (ret) {
+		debug("Error: %d Failed to read %s from flash %lld != %zu.\n",
+		      ret, upriv->name, actread, upriv->size);
+	} else {
+		ret = actread;
+	}
+
+out:
+#ifdef CONFIG_CMD_UBIFS
+	umount_ubifs();
+#endif
+	return ret;
+}
+
+static const struct fw_loader_ops fs_loader_ops = {
+	.get_firmware = fw_get_filesystem_firmware,
+};
+
+static const struct udevice_id fs_loader_ids[] = {
+	{ .compatible = "u-boot,fs-loader"},
+	{ }
+};
+
+U_BOOT_DRIVER(fs_loader) = {
+	.name			= "fs-loader",
+	.id			= UCLASS_FIRMWARE_LOADER,
+	.of_match		= fs_loader_ids,
+	.ops			= &fs_loader_ops,
+};
+
+static struct fw_loader_plat default_plat = { 0 };
+
+int get_fs_loader(struct udevice **dev)
+{
+	int ret;
+	ofnode node = ofnode_get_chosen_node("firmware-loader");
+
+	if (ofnode_valid(node))
+		return uclass_get_device_by_ofnode(UCLASS_FIRMWARE_LOADER,
+						   node, dev);
+
+	/* Try the first device if none was chosen */
+	ret = uclass_first_device_err(UCLASS_FIRMWARE_LOADER, dev);
+	if (ret != -ENODEV)
+		return ret;
+
+	/* Just create a new device */
+	ret = device_bind(dm_root(), DM_DRIVER_REF(fs_loader), "default-loader",
+			  &default_plat, ofnode_null(), dev);
+	if (ret)
+		return ret;
+
+	return device_probe(*dev);
+}
diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
new file mode 100644
index 000000000000..0d95fac8f42b
--- /dev/null
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
+ *
+ */
+
+#include <blk.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <env.h>
+#include <errno.h>
+#include <fw_loader.h>
+#include <linux/types.h>
+
+#if CONFIG_IS_ENABLED(CMD_UBIFS)
+#include <ubi_uboot.h>
+#endif
+
+#include "internal.h"
+
+#if CONFIG_IS_ENABLED(CMD_UBIFS)
+int generic_fw_loader_ubi_select(char *mtdpart)
+{
+	int ret;
+
+	ret = ubi_part(mtdpart, NULL);
+	if (ret)
+		debug("Cannot find mtd partition %s\n", mtdpart);
+
+	return ret;
+}
+#else
+int generic_fw_loader_ubi_select(char *mtdpart)
+{
+	debug("Error: Cannot select ubi partition: no UBIFS support\n");
+	return -ENOSYS;
+}
+#endif
+
+#if CONFIG_IS_ENABLED(BLK)
+static int fw_loader_get_blk_dev_from_node(ofnode node)
+{
+	struct udevice *parent_dev = NULL;
+	struct udevice *blk_dev;
+	int ret;
+
+	ret = device_get_global_by_ofnode(node, &parent_dev);
+	if (ret)
+		return ret;
+
+	ret = blk_get_from_parent(parent_dev, &blk_dev);
+	if (ret)
+		debug("fw_loader: No block device: %d\n", ret);
+
+	return ret;
+}
+#else
+static int fw_loader_get_blk_dev_from_node(ofnode node)
+{
+	debug("fw_loader: No block device support\n");
+	return 0;
+}
+#endif
+
+void generic_fw_loader_env_info(struct fw_loader_env_info *info)
+{
+	info->storage_interface = env_get("storage_interface");
+	info->dev_part = env_get("fw_dev_part");
+	info->ubi_mtdpart = env_get("fw_ubi_mtdpart");
+	info->ubi_volume = env_get("fw_ubi_volume");
+}
+
+int generic_fw_loader_get_phandle_desc(struct fw_loader_plat *plat,
+				       struct blk_desc **desc)
+{
+	struct blk_desc *disk_desc;
+	struct udevice *disk_dev;
+	ofnode node;
+	int ret;
+
+	node = ofnode_get_by_phandle(plat->phandlepart.phandle);
+
+	ret = device_get_global_by_ofnode(node, &disk_dev);
+	if (ret)
+		return ret;
+
+	disk_desc = blk_get_by_device(disk_dev);
+	if (!disk_desc)
+		return -ENODEV;
+
+	*desc = disk_desc;
+
+	return 0;
+}
+
+static int fw_loader_pre_probe(struct udevice *dev)
+{
+#if CONFIG_IS_ENABLED(DM)
+	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
+	ofnode fw_loader_node;
+
+	fw_loader_node = dev_ofnode(dev);
+	if (ofnode_valid(fw_loader_node)) {
+		u32 phandlepart[2];
+
+		if (!ofnode_read_u32_array(fw_loader_node, "phandlepart",
+					   phandlepart, 2)) {
+			plat->phandlepart.phandle = phandlepart[0];
+			plat->phandlepart.partition = phandlepart[1];
+		}
+
+		plat->mtdpart = (char *)ofnode_read_string(fw_loader_node,
+							   "mtdpart");
+
+		plat->ubivol = (char *)ofnode_read_string(fw_loader_node,
+							  "ubivol");
+	}
+
+	if (plat->phandlepart.phandle) {
+		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
+		int ret;
+
+		ret = fw_loader_get_blk_dev_from_node(node);
+		if (ret)
+			return ret;
+	}
+#endif
+
+	return 0;
+}
+
+UCLASS_DRIVER(fw_loader) = {
+	.id		= UCLASS_FIRMWARE_LOADER,
+	.name		= "fw_loader",
+	.pre_probe	= fw_loader_pre_probe,
+	.per_device_plat_auto = sizeof(struct fw_loader_plat),
+	.per_device_auto = sizeof(struct firmware),
+};
+
+/**
+ * _request_firmware_prepare - Prepare firmware struct.
+ *
+ * @dev: An instance of a driver.
+ * @name: Name of firmware file.
+ * @dbuf: Address of buffer to load firmware into.
+ * @size: Size of buffer.
+ * @offset: Offset of a file for start reading into buffer.
+ *
+ * Return: Negative value if fail, 0 for successful.
+ */
+static int _request_firmware_prepare(struct udevice *dev,
+				     const char *name, void *dbuf,
+				     size_t size, u32 offset)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+
+	if (!name || name[0] == '\0')
+		return -EINVAL;
+
+	upriv->name = name;
+	upriv->offset = offset;
+	upriv->data = dbuf;
+	upriv->size = size;
+
+	return 0;
+}
+
+int request_firmware_into_buf(struct udevice *dev,
+			      const char *name,
+			      void *buf, size_t size, u32 offset)
+{
+	const struct fw_loader_ops *ops;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = _request_firmware_prepare(dev, name, buf, size, offset);
+	if (ret < 0) /* error */
+		return ret;
+
+	ops = fw_loader_get_ops(dev);
+
+	if (!ops->get_firmware)
+		return -EOPNOTSUPP;
+
+	return ops->get_firmware(dev);
+}
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
new file mode 100644
index 000000000000..9ff43e872554
--- /dev/null
+++ b/drivers/misc/fw_loader/internal.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
+ */
+#ifndef _FW_LOADER_INTERNAL_H_
+#define _FW_LOADER_INTERNAL_H_
+
+/**
+ * struct phandle_part - A place for storing phandle of node and its partition
+ *
+ * This holds information about a phandle of the block device, and its
+ * partition where the firmware would be loaded from.
+ *
+ * @phandle: Phandle of storage device node
+ * @partition: Partition of block device
+ */
+struct phandle_part {
+	u32 phandle;
+	u32 partition;
+};
+
+/**
+ * struct fw_loader_ops - driver operations for Firmware Loader uclass
+ *
+ * Drivers MUST support these operation. These operations are intended
+ * to be used by uclass code, not directly from other code.
+ */
+struct fw_loader_ops {
+	/**
+	 * get_firmware() - get firmware from Firmware Loader driver
+	 *
+	 * @dev:	Firmware Loader device to read firmware from
+	 */
+	int (*get_firmware)(struct udevice *dev);
+};
+
+#define fw_loader_get_ops(dev)	((const struct fw_loader_ops *)(dev)->driver->ops)
+
+/**
+ * struct fw_loader_plat - A place for storing all supported storage devices
+ *
+ * This holds information about all supported storage devices for driver use.
+ *
+ * @phandlepart: Attribute data for block device.
+ * @mtdpart: MTD partition for ubi partition.
+ * @ubivol: UBI volume-name for ubifsmount.
+ */
+struct fw_loader_plat {
+	struct phandle_part phandlepart;
+	char *mtdpart;
+	char *ubivol;
+};
+
+/**
+ * struct firmware - A place for storing firmware and its attribute data.
+ *
+ * This holds information about a firmware and its content.
+ *
+ * @size: Size of a file
+ * @data: Buffer for file
+ * @name: Filename
+ * @offset: Offset of reading a file
+ */
+struct firmware {
+	size_t size;
+	const u8 *data;
+	const char *name;
+	u32 offset;
+};
+
+/**
+ * struct fw_loader_env_info - struct for FW loader configuration from ENV
+ *
+ * @storage_interface: "storage_interface" ENV value
+ * @dev_part: "fw_dev_part" ENV value
+ * @ubi_mtdpart: "fw_ubi_mtdpart" ENV value
+ * @ubi_volume: "fw_ubi_volume" ENV value
+ */
+struct fw_loader_env_info {
+	char *storage_interface;
+	char *dev_part;
+	char *ubi_mtdpart;
+	char *ubi_volume;
+};
+
+int generic_fw_loader_ubi_select(char *mtdpart);
+void generic_fw_loader_env_info(struct fw_loader_env_info *info);
+int generic_fw_loader_get_phandle_desc(struct fw_loader_plat *plat,
+				       struct blk_desc **desc);
+
+#endif
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 7de9312cde7a..48f36e88fee9 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -69,7 +69,7 @@ enum uclass_id {
 	UCLASS_FIRMWARE,	/* Firmware */
 	UCLASS_FPGA,		/* FPGA device */
 	UCLASS_FUZZING_ENGINE,	/* Fuzzing engine */
-	UCLASS_FS_FIRMWARE_LOADER,		/* Generic loader */
+	UCLASS_FIRMWARE_LOADER,	/* Firmware loader */
 	UCLASS_FWU_MDATA,	/* FWU Metadata Access */
 	UCLASS_GPIO,		/* Bank of general-purpose I/O pins */
 	UCLASS_HASH,		/* Hash device */
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 7e16e0f70309..3c64efe1b439 100644
--- a/include/fs_loader.h
+++ b/include/fs_loader.h
@@ -6,52 +6,9 @@
 #ifndef _FS_LOADER_H_
 #define _FS_LOADER_H_
 
-struct udevice;
-
-/**
- * struct phandle_part - A place for storing phandle of node and its partition
- *
- * This holds information about a phandle of the block device, and its
- * partition where the firmware would be loaded from.
- *
- * @phandle: Phandle of storage device node
- * @partition: Partition of block device
- */
-struct phandle_part {
-	u32 phandle;
-	u32 partition;
-};
-
-/**
- * struct phandle_part - A place for storing all supported storage devices
- *
- * This holds information about all supported storage devices for driver use.
- *
- * @phandlepart: Attribute data for block device.
- * @mtdpart: MTD partition for ubi partition.
- * @ubivol: UBI volume-name for ubifsmount.
- */
-struct device_plat {
-	struct phandle_part phandlepart;
-	char *mtdpart;
-	char *ubivol;
-};
+#include <fw_loader.h>
 
-/**
- * request_firmware_into_buf - Load firmware into a previously allocated buffer.
- * @dev: An instance of a driver.
- * @name: Name of firmware file.
- * @buf: Address of buffer to load firmware into.
- * @size: Size of buffer.
- * @offset: Offset of a file for start reading into buffer.
- *
- * The firmware is loaded directly into the buffer pointed to by @buf.
- *
- * Return: Size of total read, negative value when error.
- */
-int request_firmware_into_buf(struct udevice *dev,
-			      const char *name,
-			      void *buf, size_t size, u32 offset);
+struct udevice;
 
 /**
  * get_fs_loader() - Get the chosen filesystem loader
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 35574482b2b9..56f5e3be6195 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -1,10 +1,29 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
  * Copyright (C) 2025 Lucien Jheng <lucienzx159@gmail.com>
  */
 #ifndef _FW_LOADER_H_
 #define _FW_LOADER_H_
 
+struct udevice;
+
+/**
+ * request_firmware_into_buf - Load firmware into a previously allocated buffer.
+ * @dev: An instance of a driver.
+ * @name: Name of firmware file.
+ * @buf: Address of buffer to load firmware into.
+ * @size: Size of buffer.
+ * @offset: Offset of a file for start reading into buffer.
+ *
+ * The firmware is loaded directly into the buffer pointed to by @buf.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+int request_firmware_into_buf(struct udevice *dev,
+			      const char *name,
+			      void *buf, size_t size, u32 offset);
+
 /**
  * request_firmware_into_buf_via_script() -
  * Load firmware using a U-Boot script and copy to buffer
-- 
2.55.0

