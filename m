Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B771094474
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 13:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73CD83AC5;
	Sat, 21 Mar 2026 14:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nfh/i01n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 405FE83FF5; Sat, 21 Mar 2026 14:46:43 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E3B80050
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 14:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-41c420d1460so79476fac.3
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774100799; x=1774705599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWYNte/1/BvFuyrla2gEMTDzd4KRNPD4dSaIz17pbpA=;
 b=Nfh/i01nPXnDPnNsbxcz9RDImkP48tAszEEVRcUuv6FViW+NKKI51vhCeaqqTQ26fg
 lvWVdf2C1FlYLBlmDr2JYzwXsWqrYEo1nto6BebB5OnI9eYDAnFJBVVlt+Iwdj9aIjjr
 pcy8Kr/9LfkN5OmKzL6fDG3TqJazaHvFCGjDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774100799; x=1774705599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KWYNte/1/BvFuyrla2gEMTDzd4KRNPD4dSaIz17pbpA=;
 b=BX+emVTDF0KwTEBjtPRTlIDRqqG2FzFqT8JG/UlqLDTTMATiQW1XlKIgKkR5F0uQ2W
 bYKzoWd8FlgAgRDYaiaW3qmUWSQYy7/gCaFxRUkv7B72m2mY9ybFWswc5rp90iABidj4
 jJvLmAexQx+D5kIHBCVTdISqwcseGtB2BegXi+vE0TsWruov6bWMXJfMOW0q6UExO02p
 ezYHarQKn0qRekm2iPMsEpIL0na9Rh36TOXbiSuSYyAtuxyb9lc2aT0mOogExbHxYOs6
 jElMLGVZ8VEaLNPe9NgqdDaBVG+nC2VgbetO2n9u+q2LmJ2QDEQaZMpn0aFod1aTadwK
 NLTw==
X-Gm-Message-State: AOJu0YwMqoMHJFj+KBAOcxIn+tzOOqxUvTtGwGiJA/SIcsRHHC2c9QFq
 iJnbe+h3HLgCICobNS4wRNXbNOnEVadNkqBL8o7GOYrBF9H3l1twefhdo6O21nV6vr+9FZKAIc9
 iGG2PFw==
X-Gm-Gg: ATEYQzxn43kz02fYNp5FJgEMogGAGLjkkRrTTHMG4yqhO4epPayZ9fO5Am5GzdCWw/n
 TNUoGZnfRvD5GK3igQsNLMs8UYuIrs3Moxuemuo2O5LesjSP7HmTwwomPw1OD19p3+7W1oHDz1A
 KH6qlutA+MrWamUVhlJUs4xQqr0YD9u51TT68vzycYLFG+nIO01uG8QZRIPvsMOFJ/U9cadcSUO
 iHDKvfjShDZNRY6S0rf8rdUukY3FDIqx3gH+DEjDtG03xs6YztSBoew4huH27CjM/Aaw3UW9gtm
 UD5BOVXImZOyCRDXM4eFRK/61WybY2782SwcCJrBZhLnL8f9WnWdG1gcXO7P2f6Ixdoh9yopfNL
 m+ZEQCAyNGZ9S6YGFxoTT/Si16AAmiGJ1hlD0AeMUXhq0lwRtdABrW2EC3pOejOXB06bana3o5t
 Tal6hRMF18ey9HeZB7og==
X-Received: by 2002:a05:6870:c0d2:b0:417:529c:1b20 with SMTP id
 586e51a60fabf-41c10b29fa5mr4159820fac.0.1774100798823; 
 Sat, 21 Mar 2026 06:46:38 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c148a5ca4sm4947257fac.3.2026.03.21.06.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 06:46:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] dm: Fix linker list alignment for ll_entry_get()
Date: Sat, 21 Mar 2026 07:46:24 -0600
Message-ID: <20260321134626.516665-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321134626.516665-1-sjg@chromium.org>
References: <20260321134626.516665-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

The extern declaration in ll_entry_get() lacks the __aligned(4)
attribute present in ll_entry_declare(). When the compiler sees an
unaligned extern reference to a linker list entry in the same
compilation unit as its definition, it may increase the section
alignment beyond the expected struct size. This causes gaps in the
linker list array, which the alignment checker reports as failures.

For example, sandbox_dir is both defined and referenced via
DM_DRIVER_GET() in sandboxfs.c. The compiler applies 32-byte
alignment to its section instead of the 4-byte alignment from the
definition, creating an 8-byte gap before it in the driver list.

Add __aligned(4) to the extern declaration in ll_entry_get() to
match ll_entry_declare()

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 include/linker_lists.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index 6a018f175ca..470dcfc621a 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -284,7 +284,8 @@
  */
 #define ll_entry_get(_type, _name, _list)				\
 	({								\
-		extern _type _u_boot_list_2_##_list##_2_##_name;	\
+		extern _type _u_boot_list_2_##_list##_2_##_name		\
+			__aligned(4);					\
 		_type *_ll_result =					\
 			&_u_boot_list_2_##_list##_2_##_name;		\
 		_ll_result;						\
-- 
2.43.0

