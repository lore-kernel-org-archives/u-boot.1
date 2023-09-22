Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBA2CE7A81
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 21:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552C3865D0;
	Fri, 22 Sep 2023 23:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ny9zaVWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 732D0864F0; Fri, 22 Sep 2023 23:38:30 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4775E869F4
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 23:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34fc96995ddso9003285ab.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695418707; x=1696023507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NF1Fz+2oXnBHVhvQ2n0pJWhJ1VIlEuq/f+TQl04x2hg=;
 b=Ny9zaVWLO0ycUZQtoDixEHGXH7IYpddVtDMs9AF0XpJghBI4dwBlMIOIRlA8wlaEys
 M1lZyIPy6vjNndIu/S8CVIvSIomCua+NQoVVP48Re6JMqmYdFLunjH7gPob+zS4PQ0s2
 6CngreGC4UpIau8lbI5D3syNiSRWQjSzgoFH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695418707; x=1696023507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NF1Fz+2oXnBHVhvQ2n0pJWhJ1VIlEuq/f+TQl04x2hg=;
 b=uUrfZ1zlb8v5TS3Ph25QsGImOCJSnvHux9qNNdzHPdC6ck2KysJxxEzD9ceGq+o+HE
 VcGNZrTOOlS6zDp205VO2/s1mgbf63dCwSIlxGR551Vs8uziZCXVJxr7lsIbvVCfY9As
 5IYYieXMNOhL9N8jWGynybg6QJ+RZbB+p4oQo/ZZrVpgOcyp8F5tmh8IMMIXGilbBawP
 EZBKsph602+GEr+ZzKZvrZPiarcA5YzoGtIY3No/3ybPift1oibVNhWGQSeZtH1qZWyi
 IDYR1V2+Wf8m3i7nx+v6LFEx2h+pSECjyxI+NKmhyp0v9p+Zw1jVvDJ4Oiqfp5EDbUs9
 3u1g==
X-Gm-Message-State: AOJu0YyeXytreeqLKKig5jbXzfce76LtX00chjMmhpb894PoLIp7doII
 l1rxIsfMqKktW+4CwDuf3+RTnqjEN1mTqFhMC/8=
X-Google-Smtp-Source: AGHT+IEzbLqAvof8yWAkFbkSHywDC8r+4cWS1XdmfwIcl7i6bctO6qFKoNpPspEmeI2HzVNelAhiEQ==
X-Received: by 2002:a05:6e02:d4c:b0:34f:7e1b:a7a2 with SMTP id
 h12-20020a056e020d4c00b0034f7e1ba7a2mr848241ilj.13.1695418706872; 
 Fri, 22 Sep 2023 14:38:26 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:9fd8:298f:4748:f9a])
 by smtp.gmail.com with ESMTPSA id
 y24-20020a02bb18000000b0042b09bde126sm1221477jan.165.2023.09.22.14.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 14:38:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/4] bootstd: Add a return code to bootflow menu
Date: Fri, 22 Sep 2023 15:38:14 -0600
Message-ID: <20230922153814.v2.2.Iaa9b5bbab0f25012cfc68a803a9da83e71b19aaf@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230922213819.1886094-1-sjg@chromium.org>
References: <20230922213819.1886094-1-sjg@chromium.org>
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

Return an error when the user does not select an OS, so we know whether
to boot or not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to add a return code to bootflow menu

 cmd/bootflow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 300ad3aaa76..dbc47961a76 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -459,10 +459,10 @@ static int do_bootflow_menu(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (ret) {
 		if (ret == -EAGAIN)
 			printf("Nothing chosen\n");
-		else {
+		else
 			printf("Menu failed (err=%d)\n", ret);
-			return CMD_RET_FAILURE;
-		}
+
+		return CMD_RET_FAILURE;
 	}
 
 	printf("Selected: %s\n", bflow->os_name ? bflow->os_name : bflow->name);
-- 
2.42.0.515.g380fc7ccd1-goog

