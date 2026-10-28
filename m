Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F2606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NDQxpygS;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rMKUvPHb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93F396066E;
	Wed, 28 Oct 2026 12:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZQrRTMpgOLA3; Wed, 28 Oct 2026 12:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4613606D4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189608;
	b=VM6JM3ZbpCODbGWFFUh9vUDBAMAF8nvjPNSproS0uOjMYmQqnBZ4bPe960mPMHxn/Sv2
	 95stoUETrhJvLvRJTm7gR++0lZ7/tnfq6a7ICYlQ8RtictrJZDWyQXesLeFU4QMAPjlX/
	 QE8zg2+mebWhwQ0AUzD3khyEPT7iUGpqjZzs3a+RVXnoqKw46cSdaRAqhC9pT3IaM+Y3N
	 faTDCH1+CVgDLaMidBOJZw0WmJWsKkMITqLjGRtNembHYg2hWSHgu5LCDE4pgnN3f9vbo
	 3CreQDQVCH8DFWvt+2IMw2Glz/ON8fFcEt4qkXb/rsljzhImcnUhCA4RXv/sfCjpg0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T8QQ4sa4ncJIt65ktNVlaLUZOHmzTu/Ab1vRYH+sZuM=;
	b=mH4JMuDImCOqM8atPVMlHvdf85tNLrhdMguBYBSPIIvmBL6fqtlyl4qPPEb8Gh+Zvvs7
	 kAZyOhL2jeqgSl2KZUVDE2tGPcvrT2oNZJygAFSuwDeJTCNmOBcFRikGaKPvqLFbSMkWO
	 IConAzYl1bZ9n2RvGltQzVodrt2kzU8byPqu918eAPwV6g86SxJGBXvL0RuHii58dsG9+
	 TLPLzd/aZqaBePVhxXWtHVWJDCQmW8FS1HYKZXbD/4HqIlACTvjYjDhNVUmjbluTUDwYo
	 DA3R1VGn9DTw4O5dRxqoYY8BeqvvxfXi9ovY+Qm5g/nmEpnkR7t4Gn9M55zoglH9Wkw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189608;
	bh=T8QQ4sa4ncJIt65ktNVlaLUZOHmzTu/Ab1vRYH+sZuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDQxpygSYhM1AqCWGL3wbhPs2cJ7pnvJ9XQCbFhAfH8REUkD8MsqovW2wt2WxLd/M
	 97FVJMV13++8zklorORleKj5h6vOiXxDAriA8ydHysLVn5aDe5kU6nmz1Bq1diG/C7
	 MZNhlADk8voCGV+2Nw7xdBc/XjWeeI3Iy3p2wtRQ7/XMaSbKa8oSnTBVZl97ThCB0W
	 KjBKrWOb+a4sJ41mnYnJExMz+wuYEAfmoyXeWNtrcnd7JVX9cc4R/pT3d8uFD+sto1
	 sKscZ/Kff3fY8S2QQld5SZiERbYLESKdwAG/ZN8qDFDlklUihJPsyobrd9nSH3DqTO
	 7O41PBM2812XA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4613606D4;
	Wed, 28 Oct 2026 12:13:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 90E2C9C6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7CA3E400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id stabOs2JKBdv for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:13:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8516B4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793189601;
 b=fQu55XraNFV0pu+/LnEnFoTcsYplDoppAMIw4OY89lp3upANlMRasnD9KNH1iw3HFEWS
 7LaMGYww4+Ni91vQR/CmRLlwy5cV/SYS7gpqMQKrO13q8OqYWEa8aTafABtovuKd5QkoP
 X95JrmUhseh5dZbG5j2JG+rczbY21qdo2jj6v/YuEr0i90tTo6Pl8X8tg0x8dLMPjvqWr
 jcj0PypXULfWSCY6Z1TWBPwqRWLqEsju6oOi57RQWCTeYQltjaD8+SI647U7cdigCCvWN
 AoB9lzRynnV59p3AQwU9OBM1/kNlHCiMv/u1Q+xFPIWovCeQ+qdCX06c8gc0liHUqag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189601;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=T8QQ4sa4ncJIt65ktNVlaLUZOHmzTu/Ab1vRYH+sZuM=;
 b=pX6XhiUzv3hZ75m6eyb+zOOh7lAwdU2Geczzh3sQ73HBZAMqXSpxS9UVa3IYJTTtKB0N
 /NrrOe5RdjFHGbHeAsWLH4W8oLPVY6kkVxIqW6I0+HyeMQ7v+46o+CUHn8uhEKeHz94fd
 3WH9I/2KeqeIj9EpfQBpgWdOqJarO5l33+2F/KzIt3NnFlcNYPuxQRGAYX3c+dFA7FrWC
 vVLt8X3+HIgEsPDSA5YWyYZzRL0hnIsEjcNaDsvBNyUPgwlNYYhSHv10uw6OCXM2/gMVA
 LP7b0EFr49RoNc/s8HGs5LQwS0EL+/kwp4nmt9wkm/V9f9aHocitFGI9Z8MfYHlmaRQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=rMKUvPHb; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=rMKUvPHb
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8516B4006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:20 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a218c463d1so5858005e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793189598; x=1793794398;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T8QQ4sa4ncJIt65ktNVlaLUZOHmzTu/Ab1vRYH+sZuM=;
 b=rMKUvPHbqs7e88tg8JU+Pbep54HQgD/6PTnhglfmzI375LZMC2gVDr8xg3+xrLV92W
 AEP52IXLgLBzgtMq3zv991ybDeftAXzGwosu2g/UXf08zL39DQG0cGSyZ7bnXmoYiW79
 Od0l/CZQldJk1cU4f9EG0LCwAXrCTW3jRB/2enHWcdBILP3rcFrtrlQ3bbj3UBnnU7iI
 EPllxBCESPvKn9vWxzSrRwh/7DMbmrjCbvlhduhHjO0U3UGEXd+fofjeGqm7mEI1/Bq9
 OvHqncLzoXhUUcmv5Y4ZNIR9Bdnu/K3sEyPYY6EDPd4gR96pcLzyayczmFtbOM0hrzZD
 KWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189598; x=1793794398;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T8QQ4sa4ncJIt65ktNVlaLUZOHmzTu/Ab1vRYH+sZuM=;
 b=VCYFDwVmbSC8s5ubwMfVixJWY1V6kBH2Eo8vXmVVQusChW1WKBStJ52/DpwoOwalTo
 b+fcQ5bAFktSGtNsnhimq60lvLHWIZJOl3xO2DO/s4HkvLNS1FzXpVvx1mU977Ytza9g
 28p84BcXXWQtXK5eTj6d9VjqF1+JR5BdsaHGSZs2OEKkjYCU2VMcr7C+awXXLrD7QP2Y
 FhsGazZWdNKiHCdM6O+5XeyHlQij8EvJydtckJ7RR9ai9umMQcD90M4Uuum2Tt9eRhao
 eU5VYvLejImUGHV30ql3sOssLw8yhltKZ//X2nSNh93Ale0cMlsw48jPEKiFFZGB65wI
 kvDg==
X-Gm-Message-State: AFq9FYJVRoaIsZpAIxUxej2Aq/18+s3iCcsB0ZdN6D7k6ocdNlmZGaJ2
 w7/UmT5hpDpxjETYOGco4kN10eIpA/F1qT71w3Cx53JwJ+GCLWh6g6LrGNx4afKx
X-Gm-Gg: AYBFou0imOzBHQoTl74H9o/oRC1a316tkK/ca/oqniaysT7Hiem/CmGhobaHKmPaS5k
 2gMrwxfgJFSgt1DJ2CnC12iSmCem41KWQAs4D/Jm0DwzXBTIhvbiXiAC19qIVG+4ZqTlVW5HAJt
 7RO9dNpCXesYjBxb54n7nlxSGVKb9R/Ymwwdd6lptvB84VgzMYnrP2ApTO35YG1ypFa2b1nxovq
 87hq6sODwpOkVkg2IStftdjwSUUrHvGZokBzn6NA7emAn9StLVUDTwmxjvnO58Ya8/YXuFnKeDg
 EY4voQBxDi7qz2HMW2URfVHJWZE3bcM0dXTFdl88TShHODdwVI4yE/BVT+65QAQ86XMi1ZcRjBG
 Y1MKYhkyUUIL6ubpeCoeLmpqtyNd0iN9Bcrr3q/Oen+sbEPFmVMRsozdPFcRxLfybW29Wxk10bI
 pGDgc/747k8M7GhzbACs7xi/rbqM2rbRYmBC14BWouSwzBVdjxW/U98AdiScqJtrSkqx8CmxSFI
 oD/E6x3E1utMbzRewX3HRUBNO5dEsttQetdrhzfkk46JNyQU1J9wl3DdhuCfYw9U6hLxielxosW
 0uok334HCtvcVArhfn2OHkalQDTMG/pU4vB53ul5SIm20IpCallVP0S11SqaYdqRt94khtHtvFQ
 MCVuz7IRZB2I+z6uMKgDMVFC0k6AGY30/qXP3GEZn0/jLcrNMqHfnhYJPF4AdoToUNkSMUS7/1r
 fYxeZOWlRxL/5jkz8TdfR5mspFcXYPEAkw0HHKlQTii/CBN9P+Aden
X-Received: by 2002:a05:600c:19c8:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4a966e2a979mr47113745e9.24.1793189597931; 
 Wed, 28 Oct 2026 05:13:17 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-301f-0e2e-7b95-b045.ipv6.o2.cz.
 [2a00:1028:8388:a84e:301f:e2e:7b95:b045])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97a093e86sm41139085e9.1.2026.10.28.05.13.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 05:13:17 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anshul Dalal <anshuld@ti.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Sam Day <me@samcday.com>
Subject: [PATCH v2 2/5] arm: Keep -ffunction-sections -fdata-sections with LTO
 on ARM64
Date: Wed, 28 Oct 2026 13:13:10 +0100
Message-ID: <20261028121313.814-3-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028121313.814-1-pepe.schlehofer@gmail.com>
References: <20261028121313.814-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

arch/arm/config.mk is meant to leave out -ffunction-sections and
-fdata-sections for LTO builds. Once LTO_ENABLE is set in time, and with
--gc-sections kept, that makes U-Boot proper smaller on 32-bit ARM but
larger on almost every ARM64 board, most of all on i.MX8M, where the
16 KiB alignment of early_tlb then pads .data.

Leave the flags out only for 32-bit LTO builds. This changes no image
on main.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/config.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index bce9a31e966..e9606e7c78a 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -17,7 +17,7 @@ ifneq ($(LTO_ENABLE)$(CONFIG_USE_PRIVATE_LIBGCC),yy)
 LDFLAGS_FINAL += --gc-sections
 endif
 
-ifneq ($(LTO_ENABLE),y)
+ifneq ($(LTO_ENABLE).$(CONFIG_ARM64),y.)
 PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
 endif
 
-- 
2.54.0 (Apple Git-157)

