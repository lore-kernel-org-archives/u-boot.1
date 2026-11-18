Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BEC606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nh0dj/Ze;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rpw1/v19
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0796760708;
	Wed, 18 Nov 2026 17:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BVt-mu2ZaJhF; Wed, 18 Nov 2026 17:47:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E0B7606CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795024043;
	b=aNMtPiNnKHm/FKbUOiaZvJ3OkV0HbD7jUoc+NQy/ImsPM53CTQWXetcFrFfpLajFiZHP
	 hbDcLqqHI4WUCuwlSDeBqQPqe2Fi3ndtB+E91ybZOOdjyfuw/Q5DQsY4TcUz7sJtr1mUr
	 11U5pM2G8VIxlHlKSnJv82t3tUPZiOW9ojx1ucAY49x7FoHcyqvGt2EPRoO1bIeKBgkto
	 MOBEDwBfxcba7ZUu8EOFQ0UNSW9Hf8V89Gl+43e6HA+2GHKe/d6HVXkBGUAgiy+PsKl+w
	 NS9TiUJ6gtNPoO+w/WXmq6mwhdBh50GAoIoHuVXUgErk/cgMOFyVnoPeKAXQ2DGTRrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795024043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UvpdYRWi6o+wTjvvcFVxug4QM+NyNl11Nc+FaBed94M=;
	b=sizIPiZ6/ynTfrIkWfpfxlqx95yM3gidVe0/AjuN9rjUSp51z5MyOLaNO1oDo2nweScZ
	 0qanvui8XRCOSags8D9l0EPF8b3rdTzyuFhwxAnh5/enygv+LYZD4SnrAMvUJoBumTZep
	 wchZ4KP8g7AQLJUwbHzrpnrEsdy944o5EKTl0l+plq/KWXrk44pvu/4QBfjXwsi9SfCJI
	 RobbsjIsd1tgrF9qCS/h/PnXvS71wQfLx7qoa9mqAbldKPzVmqAIx4l+VBWr/K1c9xupa
	 qw0hDihB9+2/uQIp+gXwAtAXVbXef1KCHpyKy7vk4r6rOFCJi2XFV/OEcYboNGzi/7w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795024043;
	bh=UvpdYRWi6o+wTjvvcFVxug4QM+NyNl11Nc+FaBed94M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nh0dj/Zeatv4IZiMsSLNN4VZzJWl+OYt59dFcT2NomTnau4zAxC5sDzZ17YB2G7bN
	 5MDmd9ZY6+qOlgd9iZdr/4BzfJ7/C10vLCZINpz+jJ+TRiTma5vtEd6wa2l7vhl1Tx
	 OcKlp9PPsuxvEHGlGMbSNSyQ0X8c7tZLuSf4iKmwqSWnMhDgKjQCwmHy7qgg6FqIUD
	 dIt0QmBmlVqgQw+J2eJM2NzEaQ1RW9vm+p7tkcufX5/mjYurRaMUrq6ML0BFJoZAyD
	 MouLyuWtKe6gf3mlkhcAqgaGQMPodj9xrb2Aa+7Em+vrUPXHppz8uTl3ce5bDjBpLC
	 CkdaXtaKy6sNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E0B7606CF;
	Wed, 18 Nov 2026 17:47:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A4256A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 944F540A24
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4UdMYuWm26ds for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:47:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4085F40A00
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=rpw1/v19
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4085F40A00
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:17 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so9451925e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795024035; x=1795628835;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UvpdYRWi6o+wTjvvcFVxug4QM+NyNl11Nc+FaBed94M=;
 b=rpw1/v19EMBqyeePTQR4BxO66Wc0lQNrVB5RZCKfU+H73B5OR0JbBi14EzR1w1nrKu
 R4v9peOsR2ub907DrPIOs/aQKcbun+Y+qu+irIYT5eXcPRiIxZqfDUPgLqy1oYGSzHOg
 p6JLsqX9eJ3SYHkwjCCZ9DADCH2YTZjcZgpJNGgAWoLM1IwqoPJe9VLetYdZEEsEj/19
 6uhvMpcbhS4iP/RGhMzr3CFCXAEXvjQb5+/VoPv5PuIlBxo0wEUdb8XYkfKXScAPWmzv
 OxT5Tn0vQTEWI8R7jqA5xyAUb4qeMkS9OqqHHqMroytlVUU4vKsWcAR0cGJag/b2SI/x
 p8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795024035; x=1795628835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UvpdYRWi6o+wTjvvcFVxug4QM+NyNl11Nc+FaBed94M=;
 b=G9HZ5bc9s7R6F6OgvqRgocs/+Xqsx7wYg+RP9hYIN4RNCHveJq3HO9zXN4dwLbMQms
 RVr7A3H2XNpFRaKImDxCSR1V9XA2622cXyO1nN2zXH10SqahNgV0OQDN9dnhaU47TH7m
 UBUtmQ7fsTOcgbbWpNpug50+jmaHQS4AgAjHKjxLFMxRFxh1rIO/XCycIiEOtgU+YM84
 kDoP0tSYUjLBIn5jtOKmUNdAvmYWOpRIcla5+YNjsRUlxweyT+ABJg1j/8y7F5wW5kwy
 Oo3v/s6DAklq8/UY2RLCRDA/SJAuk7x67E9wxiMkpbCAoojwchaeCiI2SlA6zz34wtWD
 l5uA==
X-Gm-Message-State: APuU4Z8/gzObSa0Ghj1t5Oe2anAu/lTIPyhGDGeFWrD6JYVF+CzB9kbN
 88ywFOUowOYEgwOFpuIYOnTNc09+Vv0gCoNgoijcoX6MpyPinIL1cOUz
X-Gm-Gg: AYBFou0KZHWw60wXnHwQw3AZKUe/xdtpYOgi+oiehFz1+i6JWffYZsnO0V1J7Ylremg
 IH4RPZwVMyUNPHTdPumJ0YFj71I0xQ2NJF94PjwCWRxlMy3p5Un0VOR4gPm77XbdmBqYMgM+jT7
 NfMI6385UwkIp+XCqh8QpnSwPcppk65BJ58nYkLjOUVnw353vdr136Vm8CwBAYTkHugC6f/GbMp
 imCJxXPoCkU4a5zbb1pha2BHgJRQWe4EH9Iz4fxeVny3eYnDcGqYCXiFdtUkT22K7ZMMdoPVe8r
 sgZEsgui0xuWubVJej8+CTuapWwKKNoOBSqwiRi9qbRBbWKU0gRchjUCdNtBZSvqQkNbO6Qs8uT
 /saG37Svpnhf5UTj0d5bw9qXv11VR82711D+PqeC5jnVCPvogqCUvw7MzSbLz1UXYj2udzPk3fk
 Ww5zBrSHo9BFPtQx9c7+BbQatbKXwsKK5zW4ytYxwJVoo7pOcmshp44hit5PQBQLzNHw5oEj35U
 DcDZjacQuYcmUSrN4FccftFZPsorZW8Qm3c6/dbfdKZLNZeebHrJR2kq/XwlG2nqKTFmWgKRBn+
 nv2jTB3Xo9jsol4PWaxM2C6lhVN2Q90QzggFmj08
X-Received: by 2002:a05:600c:4f93:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4bb7da1c549mr70914005e9.16.1795024035550; 
 Wed, 18 Nov 2026 09:47:15 -0800 (PST)
Received: from [127.0.1.1] ([151.51.238.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65683d5a2sm6302789f8f.43.2026.11.18.09.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:47:15 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 18 Nov 2026 18:46:58 +0100
Subject: [PATCH 2/4] CI: Dockerfile: Drop $(CROSS_COMPILE) prefixed
 symlinks to ldr
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ldr3-v1-2-6ffe43aa8c6c@gmail.com>
References: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
In-Reply-To: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
To: u-boot@lists.u-boot-project.org, linux@analog.com
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Yao Zi <me@ziyao.cc>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Once the $(CROSS_COMPILE) prefix has been removed from the definition
of LDR variable in the Makefile, these symlinks are no longer useful.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 tools/docker/Dockerfile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 187320c26d5..5434343b274 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -350,8 +350,7 @@ RUN wget -O - https://coreboot.org/releases/coreboot-25.03.tar.xz | tar -C /tmp
     sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/ && \
     rm -rf /tmp/coreboot-25.03
 
-# Build ldr tool for Analog Devices boards and create prefixed symlinks to match
-# $(CROSS_COMPILE) as used by different supported platforms
+# Build ldr tool for Analog Devices boards
 RUN git clone --depth=1 -b v1.0.2 https://github.com/analogdevicesinc/adsp-ldr.git /opt/adi-adsp-ldr && \
 	cd /opt/adi-adsp-ldr && \
 	python3 -m venv venv && \
@@ -361,8 +360,6 @@ RUN git clone --depth=1 -b v1.0.2 https://github.com/analogdevicesinc/adsp-ldr.g
 	cd build && \
 	meson compile && \
 	cd .. && \
-	ln -s build/ldr arm-linux-gnueabi-ldr && \
-	ln -s build/ldr aarch64-linux-ldr && \
 	deactivate
 ENV PATH="${PATH}:/opt/adi-adsp-ldr"
 

-- 
2.34.1

