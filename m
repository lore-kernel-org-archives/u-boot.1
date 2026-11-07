Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A8606A336
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iMvfxI9O;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=n5L+mYKM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5BAB8164A;
	Sat,  7 Nov 2026 14:33:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y-iVR7qJuP78; Sat,  7 Nov 2026 14:33:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 092AE81657
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062016;
	b=iOYy4+FnrqvM9TnzX6d4jT0tmQ/teDaudVDEFFeH8C4J2/YNCkREhkjOuYPOq9zPvws2
	 jVthoXb4sb+bb4PmZE0xr2SQekckJaPpXAA4oj0KKBKoiqOZssjDvukcn1kVQl9/aO5xM
	 z9pNNpyoylTH1BcKuo2OfQz70ckslevMOXN6DCrRuxOX3PaqjIaAFa426PepFvs39gXjU
	 1cmLX11clhsCWp8GQ5jE0N4rcigJ+0MU6kEC9dUVX1s2gZ6Hi8to99z7N7KmAyPQdBKfl
	 yJnLzoMLarYC+nwbzAg85nLoe+2uaZcRtiI+LJH+2+tujzCh9Wptus62tUlOCpNq2Dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TLyDVx5+qOEWNjt+9b/63homw9iZDzAWs7dhmtutSn4=;
	b=dl5Y36KRwzcXanago0aeq51llCeuauhNgMOz+zkShXxYg3od56SDDUlWUPRsWHUYihSk
	 5iRloce5eXxnAAxMyu44XCnqfYy3hQQRdEH6dKmMaCesGwpQ4idlgECiQ1nPmbk+ZSIOg
	 S0v3BkKKssd9TCQLRc6MI+IvHcFHBXwOiwWoYatxg0XgUQONG+oOAqSIFRMunvLISZTZW
	 1lk3GJihiHz17CJDaq/bjJJvuQzinJNeStxjiPg4izQz6bOXsJ6wQmTKwvJVdMlZZk2Gx
	 W5GdYNMUbCe5p2doF7N3/mZPPlQLQVfFYi4oPqCKplXkNvbBYYLo3rMSfM2TsuRTDhA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062016;
	bh=TLyDVx5+qOEWNjt+9b/63homw9iZDzAWs7dhmtutSn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iMvfxI9O6DKz4XWDJHwTtl5+jwCxhi0lUAtUGmNkVBW+BHA2/5ZXyEI4/1qIl5cZb
	 /vEhAFuk055zg6Alh0XzARpazhbIps/lZV3kdy0mU03Ne/aE/grAmsp0PuYlJPTXY0
	 GN8tD/XiGy/7PtkvECbqttsY++JpvzOL+kHQgU0w/86FmZdWiurwhPEK+cqx/VTjFn
	 2PlGgdyf3AE8LLIhHr8aj3tvIOXWeQQkcreX38k3wSA58Dap/UI622YYGTu+wErxku
	 6WI4Vejoa/Mqk3dETwKqXJGvfH9KEPJYuqoF0Kn6xsQNE0UfYM6cpjO2ICC/r5dyix
	 xxx5hgllYOuww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 092AE81657;
	Sat,  7 Nov 2026 14:33:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E977211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3452F607DA
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6xvcDW0LYfzh for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5DB0B607BA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=n5L+mYKM
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DB0B607BA
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:23 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-492f6b7f70dso914074f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062002; x=1794666802;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TLyDVx5+qOEWNjt+9b/63homw9iZDzAWs7dhmtutSn4=;
 b=n5L+mYKMbfZfrolOK0aqnIWVgQ0RsHE2MinrTfH2czO+rWn5FKxzSY+C01eSs9ipKz
 WHMGyQZs92XFdev0ahdTVZ9woM5f86Ye9N9aT0v3HtpBNT1QJjuPzCXxj147JjHfXvrJ
 B1XfJXm/FpzAtSCRO1RljiHMR64v/jlP/8WX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062002; x=1794666802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TLyDVx5+qOEWNjt+9b/63homw9iZDzAWs7dhmtutSn4=;
 b=LA+W6bzZUxkza9W9NlaMY/S/vhz6sKxd0rucc7sxX3VnluVSr2WFrAJgNOpFIhAthx
 m23kTabz490VnZ+s2+a5KLGUmkuvrpHJRM0/7ySZjjFy8Je7UGEqJp5B0n2yNjHRWW+t
 3a2sIWek3DKuPdI8d48kmD7pzp+A0+HVjuWmsFIIzEWqvro9TcZpo86WfoP7CddhVbn+
 IHT4dgS7f62vOakMdcgzx0dIWdBxfBWF82gxo+VmcYe8hLHPFoLSOTrd98NmhUUzNycd
 dU/vviIrRr3bq6MnWMYaTwNCpIIvhSSthcCi+hAMMlqqqnJigk+FLO5vF3A4BAkhUeXX
 hiKA==
X-Forwarded-Encrypted: i=1;
 AL+hErHoIc0WZjSGCELFcoEL11Q2MA42dqZNBJzz+P2eDz4lU4vr6ZIwnMChJw6hWPOQE8EwXQhbxJQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z++cfylSle9IFMfC4c9XmVCJL7OKoAOMQIFBSMaOZ1ZEUXDli8d
 OCs7SMpYrzuDNp6TCaZaQgYbWq4dmSfyQVrF/wE1EKu7VukSf0IqUDMiLxRKzP7f5KE=
X-Gm-Gg: AYBFou1Emz6BQaAxAZvMupxoMvVOuCH+HEHgCt/GF0V+EhUCsoR91za+O5DvQjIce8j
 Uki0Ai38grwIfQyRwgqO7NkBvSnmXyIiDsWXG6ogQslnVkL532Xh1RxqnqbebzUmr7fkW8Mncl+
 L0rCLonN/SxqOXyQ6ox2wVjuhOrTJhbEm9YNiIrA0MOyUod87rA8JnLdMP1OR+fFE0WzGZkNBKg
 QKvWLtVmWk4hKD9z1TBVkFyUV5RauBXHG/VlWbzOOWGjHdA17+YijWEfJR8YMlGYIh1r7vEcF86
 F3bvpe165zHQt30DiryognRIHW2BfjAoejYAq7rXHrdqNlDZGQn41AH0OSGIi29kis3DeNknIJ2
 Sq3OSs1mASxwWU/seyt+vm4IjPbC2FZyxu3xEJb7Nt2SyhVgg2dFW/G6KFzPLR8aMFfEHSlHJ/i
 GXuV8MCqyaLx683KDST+g88lXpLkY5H5CCmXTMmKepL4NiJwKqar6A8QnP4DX9rjWlS02w6tz7Q
 bUCCqsn5ar0Vt2gNEIif03SBKwfY+ctv4s5Li+GMr4ZVYbnh/WKYoILq6RAMZQCVYvlJWCAOGkh
 8fh7YEr/5a8UJ6coRQvntJXUOGPPFilthWCj1bC5WwDkucCLj6/+ZXpIYgGzjf6pKu+2Zxp/xs0
 jQNY0XTSIW9K3lPjNyFI2brHm5ug+cNannIuftsaEQ3cUh0rEIj8QSo6g7xTiYw6jHNq76GqZF2
 dJ/wyVMEH3zf7TQwKNmhl1rFpKOQ==
X-Received: by 2002:a05:6000:200b:b0:48e:103e:846f with SMTP id
 ffacd0b85a97d-4927e553a40mr9826524f8f.9.1794062001987; 
 Sat, 07 Nov 2026 06:33:21 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:21 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 18/35] arm: stm32mp: stm32mp2: fix off by one in
 mmc_get_boot()
Date: Sat,  7 Nov 2026 15:32:08 +0100
Message-ID: <20261107143241.2236511-19-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The > comparison needs to be changed to >= to prevent an out of bounds
read of the sdmmc_addr[] array.

Fixes: a3be0ccc4746 ("board: st: stm32mp2: add mmc_get_env_dev()")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 board/st/stm32mp2/stm32mp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index 7bc7d2a608fd..f2575339b990 100644
--- a/board/st/stm32mp2/stm32mp2.c
+++ b/board/st/stm32mp2/stm32mp2.c
@@ -132,7 +132,7 @@ int mmc_get_boot(void)
 		STM32_SDMMC3_BASE
 	};
 
-	if (instance > ARRAY_SIZE(sdmmc_addr))
+	if (instance >= ARRAY_SIZE(sdmmc_addr))
 		return 0;
 
 	/* search associated sdmmc node in devicetree */
-- 
2.43.0

