Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07E606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1MPshXMK;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=cIYYiKDf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35F8D80E27;
	Wed,  4 Nov 2026 08:50:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7JXlWUTo8zVU; Wed,  4 Nov 2026 08:50:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7111F80E09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782256;
	b=cpFEDEULmCE1SjuBlsqNQip1EWNi3U7285zlNwmrf2raxNfzO+LrdtB3zCYrTZtwBQTh
	 Ob3OPQVex62eDXEBubC72LH8b/Z4QR4nWbqIbIG+NzBIpZUkBgMFrcp8cy5ZycUfulIWn
	 0XvuM3pBj8iwuo2RQktRpJZDTFhOg+i3aQmELtEDbzqC5GOlq1r4jkZIwvJrxJWXb7i8V
	 pCOjcaSxQqYzzrAQ3HNrIwt6+6Av4FHd3myHNS28nwPFksocTaK5+ByV5MPe7beHWUltr
	 ++3VDBHQkmQSMndJhVl5UvdYm1O7sYA9exmg2m0ZZcu77JcPvlodk3EHTzvapeLQiig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UDktq5L5fNdpPu07XbSXwRZRkKiph6ZEjA9j9XrelhY=;
	b=TxSVJ/suBu+jYnMFo3GTAXpYAaKs9sj3MKILerwuau9b8yiqYtSXeuzleedK0uaGb+lC
	 y0Vs3hwAZ9lk3FxJUE3ncDQHznZvCSzuYn9nT1lqW9GIkJk/sFooZiSqUmaL7veBs3Hbp
	 COGcJmf9mAo81DQAQYCbHAyTpOC7lxaRMNYXdKrgVMCQb3zGDPXr8eAAOuhYgaSEhb3On
	 dGLgCA6/lX9APr/0pu+2UMQrToyB9Up7nGtCZzsFjw+oHg7Z79D0ug1QyrcAMyepcOAvE
	 u/Lp3KWL551Axy1QrlhXhDLh0hHttx8U1Oh4K2+9tqxMK6zqBYAKkC6rFErSHATp68Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782256;
	bh=UDktq5L5fNdpPu07XbSXwRZRkKiph6ZEjA9j9XrelhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1MPshXMKbNBqMpGiu99lN/FThk7GAXwliuhH6yv8xRb7abS2IMST8E8LbegMRwSqn
	 1qfrm5ESjkBB2fN17+/RPl3wZ2muvjMCilO03yaEJWnrPyDFh74UFnDDrJyBJRsn3P
	 pwYBzosFteBU3ZDLQG8Ym2hQ86WL7KQvj6xtGsrTJrgICfuotuVpGzpZR5bGDPyZz8
	 ogT5nv3u0ndK7lo+u0DJtXAoTTJfEJfYoClJ7VfiZovsc88OImkrfrcTT44YmBWXx8
	 2WlhOJQyOQboPDtK0wCAct9C5ENEeOraPmOpEIWpMuSeFHLIgyRqS1txZw/Q+zDJql
	 Ol7EXNfuEo9IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7111F80E09;
	Wed,  4 Nov 2026 08:50:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C51F2AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AAE460728
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzpSyo1uO_a2 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:50:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34C54606E1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782253;
 b=UqYb44NEy+oRC4QoEom725dH17p+y6vD8CmVm3kQJRiLkfem3Iz6x6Mrr+tddE9KkBLO
 bED80yIxv9ZL/XPWEqx6nQkSv8tH9usrjCfx2bs6cpWDY9noyUyjR77x9ihuCdu5bUeM0
 /XPebjRRjjGHWtCIVpaFonnNIbAk638cBRdj4KRSKCfDtOs6BCaC8qTFYpSi3tQMtVzp+
 JIWEZqP91gFdesszs8K7wDtBR4hGxWoqYj8yNL/3SJ+ylQokr0vmv2dA5gOQo7btARZhF
 BvT/SSTU5c1hlVUmIp3ZPLmOcBL6jzu1wxYeenkegVqoMCs+kA2ITkcPYUTw9S0oG6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782253;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=UDktq5L5fNdpPu07XbSXwRZRkKiph6ZEjA9j9XrelhY=;
 b=AOWZiabAv4CBynr2ucqvnLPZmr+j4EAmdBvte30FESfKDNgqOur+tw0cN+AhZmfTprE6
 6d06I2Idqn8VMhvHRI3bcyy2TV9Tc7CtW8C+4Q4Wd6vT1RWIkAPWEpBgotZPzXXTgam83
 PU9+y2lD3gpN4THj/Sq9JKMk1Uw5rq97nXTZZQ1fQn9C6h4rdBnyhUsYeB/bXzojKL8+e
 XdbFiQSsjNdHpqqJkB/No6pXFt67L/MKg/vGf+PS/fXEmJUYtn4foCz/R2kfRKrVbOR3F
 +esEO67zlKk3cpwL9z7E3jVKCvYiUrqEbFLisneIkfAEy3+uAWKCODJaxt8MA37R/rg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=cIYYiKDf; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=cIYYiKDf
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34C54606E1
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:50:52 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so1848045e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782251; x=1794387051;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UDktq5L5fNdpPu07XbSXwRZRkKiph6ZEjA9j9XrelhY=;
 b=cIYYiKDflrfmQGZT9fjkpP6oSkxdzCRNOPG9FZcieY7uj67NMFM2yvnI7XmJXEBNxm
 eYasuzJ0W/HVk5crC6qjiQH1yOOExDrsPfbDm6Grnfi+KEuXQij4GcXjeYJqbTyAfRKH
 sTMqtRhxrwWXy7ZW39kW5+yoZyg3ENiS5mSCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782251; x=1794387051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UDktq5L5fNdpPu07XbSXwRZRkKiph6ZEjA9j9XrelhY=;
 b=1BM83PR7xBLXxo683GB85+0s9XPh3i8WTCFvLyCyah4bK9d8asa3NRzY019rYGZZFX
 jpZC3RcUpaD7rBv9pGYqrYR9e/8d6fERVnk6r8WnCh8L6MsircaAVu7vCYu+8uvm4FzI
 Oi0gK2QA0EpC+f4U/VyNSc5AyL7Wmg3byotFDbNsVO9dKn/gGD5GWdjAmucXvQRIGZTh
 Gds3w7lGziPDhy80TsoGQCFDvvBz1SJhDvgmGo0+DJT5MoJdUB8llTQjMc2S2CERwXPh
 ipVWWpjdgUiMrBvOkeM3TthSyPcIoawPABwjXSU23hjzua3gFd1gM0aYtzndSiZCqDm/
 Y55Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByD5+/LNJ77zbP20jYcxxBtYnFwu8nae1SG/F0GE3RdFIeZk5LSODVdIF4o96f2HCF2AAe9pag=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+zWn/zBPbYUhGSb2xrcAOhUVIC0heXCLq7TQ84/X50NizTTdO2
 3Zvy8WL1XOowknBaHXycNlT2EYzPzNXX1deSTP4BQ0Z6mM3FirbdWuD9lW+ERJFlmpo=
X-Gm-Gg: AYBFou3Voql9ZSo389pjnZHr87JtWP1Yp2oYAKCIni3Syf6aFP9XjhW83oG8964OGn6
 c9bKEZ/wpzBOEAYY4DMOdpAqq5cvV0qv1bH4OlY+mZ/vVDNVtMG3hlqqcCvqpo6mMV/qDGzSSDK
 0R3/l1azZLf/DS6xx1s8iPeYThyZF1qok6mi46I9Ends80hH+TjNvL8OD/GMoG8IiOYVHkSjTFX
 BQzr16103fozzzqYmAOMMzfCfReriQKuXYlot/Z6+Km8vvAG/AWWZgty2caQJ81I5wW0GmgqxV2
 NrICzJ1PZtivmhrP771B+IhjsaRuDGASgXXkodCsvmPZN68Za3p/FjTtaQNiY+2KV8D7Djvijg3
 rMVOaE1Tx+VkmjPlA3DnamYHwhJ9ADhM7dAAXhH0v6/HLhVlKwi5xVEigt/w6YilOb/ds3EiYWB
 w3sYOyvZQNzUbLBUGAFQlpeFJh+x0JRruoQrmIfSlext4nfzb20xS6FxReTOpeKC/uBRGFbd8gc
 nYT6rFsz3iDB1GCZ/kNjGg92P8qxwdh13Ia1FH+kSnKOcW4XFP5RDORWbpusOQC0onpFt1gsm6S
 LQ+N+ZNJ3wD1KMe8W/WtdBRpuLNuQSKejOTJV0FwBj055DUOLl5CQpcUDPXNwAzDhO1OkVE6dG0
 YjxalMHzd0I9uOx8Ii5SJ3nIXMjmG
X-Received: by 2002:a05:600c:a41:b0:4a1:ac66:6ac6 with SMTP id
 5b1f17b1804b1-4ac18c73d85mr337783105e9.26.1793782250645; 
 Wed, 04 Nov 2026 00:50:50 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:50:50 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 01/33] dt-bindings: arm: stm32: support Engicam
 MicroGEA-STM32MP257D-RMM board
Date: Wed,  4 Nov 2026 09:49:34 +0100
Message-ID: <20261104085036.4012238-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add devicetree bindings for Engicam MicroGEA-STM32MP257D-RMM board based
on the Engicam MicroGEA-STM32MP257 SoM (System-on-Module).

The use of an enum for a single element is justified by the future
addition of other boards based on the same SoM.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: c673bc61ca926f664905c63f1455c7f95858a437 ]

(cherry picked from commit 6655c9d906a8aea1727ddf748c0e8ea05216d56e)
---

 dts/upstream/Bindings/arm/stm32/stm32.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/dts/upstream/Bindings/arm/stm32/stm32.yaml b/dts/upstream/Bindings/arm/stm32/stm32.yaml
index c6af3a46364f..58a639f098b6 100644
--- a/dts/upstream/Bindings/arm/stm32/stm32.yaml
+++ b/dts/upstream/Bindings/arm/stm32/stm32.yaml
@@ -196,6 +196,13 @@ properties:
           - const: ultratronik,stm32mp157c-ultra-fly-sbc
           - const: st,stm32mp157
 
+      - description: Engicam MicroGEA STM32MP257 SoM based Boards
+        items:
+          - enum:
+              - engicam,microgea-stm32mp257d-rmm
+          - const: engicam,microgea-stm32mp257
+          - const: st,stm32mp257
+
       - description: ST STM32MP257 based Boards
         items:
           - enum:
-- 
2.43.0

