Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092C606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gEo41cCx;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iE/rFDQz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DEFE40AAE;
	Fri, 30 Oct 2026 06:13:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2-Y3tNjyYZLR; Fri, 30 Oct 2026 06:13:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D6094072F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340831;
	b=mFFqrZhRm+KksHh87RmtcoCLLkJ2lZOCs/pez1B+0jqkJChyR8B4EdLF+gnsS0vx2fBQ
	 HzrQ9CdPiu8JbZ2P5HfGTcaV8LIFt6yh9rmx9FvlxIdnpgO/mycQVFgpOUNQ7SZrkYsEM
	 k/giYh8jhNLagNCnVwg/DN6bjuZR4ttEKMzil+FXBiaf5X2wro3NUnQ/AaGy5kEnvjsiv
	 DkmJD6fJ7Q55+mdR1vNUD6kq56gKXlwEANYeKrl6OnSgmklOMLRAG/p9E/M1GtvMdzflX
	 RZrI8ORDlF4iNcWovyKixwAMs9nMMj5vTX6heGjsaDUGIpP8TwCne7NObK24YFp56Lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340831;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GqE9hm8kc73UDc8cB5FJ8a8T8qU+vHUnG0s9sykywXs=;
	b=F94HYXP3uEhqJDQDArrIM/0D4Mrj5LBTua48x6o1/bLYFg1xuOmr8dagPj1hMucTJvtV
	 CcceSjytvfB2QvVVag2Z5G42v20sRL9L4wtQhnhlvB1nIOuLiaKd42xnssTaMTJeTSa4o
	 6IXtpyx41kbgbm3A/x4zUdoeOrTdiCyGcwx/oxJZ9JaDFCFeq0ZCgtIcbO2mGMbKDfgvM
	 1mHa6Wp6XMTLqJmGE1W8lpvCRwX4BwGVNdF7ApyhGdp75LuQXvunX6KUN/lGN97AjXlqK
	 5RY+iA4zWzYzzDbYnrCBfEIERAyoVDsGKeigSdR1Oxyqhm+ydENJAB5ycofQjVh5dZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iE/rFDQz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340831;
	bh=GqE9hm8kc73UDc8cB5FJ8a8T8qU+vHUnG0s9sykywXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gEo41cCxdyG8rWGCEq0f0EhKGGoC8FKUhjc0trScHXbqBXgpdDZ9XPTMoE60GxJNg
	 aM/olFchAJ0jDlpIgQjj+bnCpdE9Y6ZyET5ezLuQ9pRBUDQwGX/10xdvgxetP/ynhO
	 U+MnRL2yCGqHg2C2IcJWBeEVSUVonaoc+eDrGe269n2ljOe18kByQoR0Wjd1lFTN6M
	 XMJIBmbClq1PLahbeVju0pZe4Y9fkreeeaHHTMa/98axlHYVK7qYxlRM6UuxV47J+/
	 B+uJ4eCcVcrOeS2st6kYR+Mh0riXZ2VpiAdaB2TMeSUviRTxlGIlAUoA6wNsczxp2S
	 emezXkjnVVM7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D6094072F;
	Fri, 30 Oct 2026 06:13:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 63CE1712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53EA94072F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UPqy81xAXwGY for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 470D3406EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340829;
 b=o5PWYmw+zepNnsH9FMLOyI2ANmgdLKQuDd6iNgi2SMxiEVp6+aiLEo0uI8O5ggCZcBbo
 M6eZuha++B8nYzQeXuAJ94MvR4ThPAFHxK6PrToC5bnNOUFkdydiPkNVouVqDAKF/CL4W
 5HYUVJNwsnG+MFKvzzN/p7UHL4ZJLU1CygfX9uHfCcLoQaIyYXgQ4Z1ammz1savOdrk//
 rFoJhlvJ9TjEflphMf1VBSdrtlVrIBe3TkPnOz0c9ArmnIDh20LXigbi6/EJbiQUqIDnE
 2ykI087xcYS3uSRhvywJoGUd4yyFYopg4y763a0eJ2LNgZJxpyuS03sIGbBtCJugIdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340829;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=GqE9hm8kc73UDc8cB5FJ8a8T8qU+vHUnG0s9sykywXs=;
 b=QXXQpfzUWWZPeFRoXRe2PY8KoKlzns4vUvPCE5c7HMGuIIwzYlpXXUt87oI/QXClfmGC
 we43NLRczG9XNxVe+LuJL66c0Y5BFxcYe3ZrCC65HihiB8yyeY+aziD/Ct4o4YO5jfgBu
 sO3w9q5Y0bOGOIDpfanvHZZEpJpXP0RUK/grWN0D/mpiq6F52n39njX1ji6LwTWvoTT3F
 nR1tAFWNsXZ5M18dPMQC8OwGwyCZTqvjfC2SiBO3KxP84t21okV4G2FhvUCXRa3VZv+mm
 d+91NnXu4UzmHpdMgW40RsAG1TTzoQfmhN8UYWKGy0u/AOVdv91Z4wHrC7rGsB6oQgg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="iE/rFDQz"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=iE/rFDQz
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 470D3406EE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:13:48 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so256636f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793340827; x=1793945627;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GqE9hm8kc73UDc8cB5FJ8a8T8qU+vHUnG0s9sykywXs=;
 b=iE/rFDQzaNCyRcBd64N1pTUllA+kOST9BsOX3nhm3kQ4PiYWPfSFT2DHiWsGeH9taE
 ERtAKZkdipmIdWeI31kni+S71JSiH+qMZ7Yrmq9zTvQ2IHjLrsS1lgFalNNJFMl3BC0L
 PRvrEm86Y3YpJ1KhxtVKZCVBcC+r3IyeSwPUbnFcAoEMnqJMziKmEAODPNO9UEbvxN9q
 yWOb+hqYt+A2RnW5hXtqlDlosMJ++wAHQsJbzxfZAr54bWUVopmJnjCY+r5GEIdh4TFg
 NbhCJJbX4lShR6VUojWrF+gXehOmcPiIS8yzA7CFi5zrm/vLltZRJjBLYx8FZJwKsfVo
 rq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340827; x=1793945627;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GqE9hm8kc73UDc8cB5FJ8a8T8qU+vHUnG0s9sykywXs=;
 b=pSPNAw3CXkDTEhh1iLw55S1oMX9Jw3t5CP5NzZuWfwDVoc5A/h9ai7u95FiS69w8ex
 4VGqkZBpMikDX8VoTOTdT7A/kYCgJ9BWctvs18XQ4BvsQiQmjL3sa4Z60FNtEsHmnBUq
 jQsAOBQyWtnsQlHtnKqTy/MysDqsT5c1tcTOrQoSPw+mjUtyENPmQ3guusE213aSiqvX
 iX4S8tRrdho/zJp7H2h7oZxIjLVSg4g2dxaGA2PutAvqtElhmbmsD9OfiWvelwrLWFD8
 vODOAnHcrvmVHRdE+eDxRsH9wkC9TrbYiHoj2+S0zxNkwczv0w7Nwsz4WBb9XiwRlTKa
 I+/Q==
X-Gm-Message-State: AFq9FYJNiFo0d8LAjYKlPVWqIkl3AIwE400s1vyB5j6nkGkHcgbw1Rc9
 4ZNVkyY+EEpxqH9oM8NTvhMQAZOe/VOaAQrkfM4HeOazcjkK9Yak+PxmXclbT+e1yiE=
X-Gm-Gg: AYBFou3xpYvsr2Q04wBwetY0cPVqkRuaIlSp7ZofnBjX4y42yfzPfFIFYEdau4tKfOf
 WPBXeq5LLjts0CCCmqNjPxHfPN6Iz/hcJKxLMQ3+fPt6obUGrsvIf8xSdDXn0Z/92jw5GNw8Uoq
 XXNf4KwjZ40GNLLJpd4x7u+WpDz4zIg+z5TUcZL5LDUSGDC2PKSu6N0DGPOwriG9tNkB3ynwWNP
 V8pX6SExjqZTyGdNc5yD6zVm4XHj6DB8veZhUptRw6IgbUZS8nEqIaYEdi/6lotkydvktJIEbOw
 5CFBF6KHS05qGnYo62o3o3Uw8O3HZc4aTDtPB5nt6rBHfWWhbUQLDKWOzrLa92Cy9bxzrjYK0RL
 LjX92MKgiV4Akwly7IXHYdSpIgc3gY8o+WK5DeTQYBkbGkG8zELelCBrQD/dOeWQs8TFQMDWjYw
 fRwxJFqVFh/NAfAX96lwNHda8JzCXqk/QEEc5f/15bcXBhSHBsU6tPhLUe+fwRFacwahh2mpIY0
 bnevKCLgg2iAc21ftbK8XnGdJa7umwZh+9bKKK/w+5DwzZOCfvgfBSGN6bXxVYIbNYYQRHH9qta
 0h8i0M/UglWXOxOnVdBO8E4kfKp0KeA=
X-Received: by 2002:a05:6000:4711:b0:48b:123e:2f5c with SMTP id
 ffacd0b85a97d-48e6e5018cfmr3055955f8f.29.1793340826681; 
 Thu, 29 Oct 2026 23:13:46 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723fcsm1464961f8f.14.2026.10.29.23.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 23:13:46 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/10] efi_loader: check the NT header size in efi_check_pe()
Date: Fri, 30 Oct 2026 06:13:45 +0000
Message-ID: <b0084d2f-a136-4032-96ed-c4a03e392259@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_check_pe() is meant to check that the image holds a 64bit NT header,
which is longer than a 32bit one, as its comment says. Since commit
5dad05a0e61d ("efi_loader: carve out efi_check_pe()") it checks for a
32bit one only, so the callers read the optional header fields and data
directories of a PE32+ image past the end of a truncated image. The
addition of e_lfanew can also wrap around on 32bit systems.

Check for the size of the 64bit NT header again, without wrapping.

Fixes: 5dad05a0e61d ("efi_loader: carve out efi_check_pe()")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index f9a2d2df405..e31493d5135 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -849,7 +849,8 @@ efi_status_t efi_check_pe(void *buffer, size_t size, void **nt_header)
 	 * least one section header follows we only need to check for the length
 	 * of the 64bit header which is longer than the 32bit header.
 	 */
-	if (size < dos->e_lfanew + sizeof(IMAGE_NT_HEADERS32))
+	if (dos->e_lfanew > size ||
+	    size - dos->e_lfanew < sizeof(IMAGE_NT_HEADERS64))
 		return EFI_INVALID_PARAMETER;
 	nt = (IMAGE_NT_HEADERS32 *)((u8 *)buffer + dos->e_lfanew);
 
