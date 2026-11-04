Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0F606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RxmJ6eLy;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=UGIcsKAJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 171CB80F86;
	Wed,  4 Nov 2026 08:51:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ly3RcvN6baO5; Wed,  4 Nov 2026 08:51:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1DFD780F74
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782297;
	b=G7go34kKwBEfsqEzmd0EqPnGyW3I1bKYwNvs95pFOMOsNi1hKOukmS2kearCVH86VbyC
	 ExGRcBSHfjZXXJh95SnpFDIYyGOHwT3SiIiKVf5XIdfmVq3fznNlDgxoFzU28O61XtBFM
	 4ebvwg7j8NU3gCM5B9Zu/aUlPo7P4rN210B3yzmNx/UhA66WjHaO99UAo42UcWLrD867l
	 kaqViO04iXZ0JSWsy60LS3+u307XajqmmgAOHo2tKQsYakJdXQg9P8nlzk10RvCn8qoJe
	 +97SxKY85fBBr1XuufjgkvGNIsU/Y3pZaT49IUtMmajlYcjY6uzZ0Km849934bxauAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782297;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hGCzFvjaIVuoayBh872Ljvj8YdiRJGIWwb4ttWkrYjU=;
	b=kERlMF6wAwhgRSKKaKQ20apvbVIqws5TB/hLucsqwkKFDZvGooZO2qdu5H1kv3YTlDJv
	 nk262hUxSOL2ek8BGw0j/55kZLsIYD4CBU0Zy3Iut1nY7JtNH/4IaARUnNJRTeTvT3oSQ
	 ncxJiVY8bPrc/87ye2aWZrODDhaULeui32LmTYdwt8AVya/fbUqceBSW2bMGGqvKyZ0k8
	 2KRcR8UkYA312FBy/cYGvi451W5l4VbBLU53qKnNHJbXqqzTyXpk7MTkTX8Gdx+QuXb7A
	 /SfZI248RrnhLEJHRrZurLG6+TUZ+tOXoPNn7eQiIp+st7FRzm2j6hEcj99PjKzAO5Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782297;
	bh=hGCzFvjaIVuoayBh872Ljvj8YdiRJGIWwb4ttWkrYjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RxmJ6eLyNCZwGlVyGmQCsbV6564oftaZyza+OWpXDtxJ/w8OFC47VllPewDZUSNas
	 lf/J3akF0mSRDZUBusmwTb6VPnHHdTJND/JlgCFHsODn200PkIU8sdBnsfmLs9h7d5
	 EuKkW+HnLqcAHCmcwBADP0orbd+s6rMru1cwU5eIqw9QtmWBjSViC4qi5dYzKd+foL
	 khF5pKP0hXwHDhifOBuzKiK+ImUlEDKCnmYbt6dQLvugDddb2ZRYtZDf0knasdeJ2z
	 HV9FHs6yFuEfhy2AbHYDqAl9GSBLt+YGHxtJXV4q7LnWKwTQcYXFyb2IDXlpjvONmc
	 e1JB6HcmOdR2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DFD780F74;
	Wed,  4 Nov 2026 08:51:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 82ADD9C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68DF54079A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGxmBFe5ijBE for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 566D34077C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782294;
 b=lYgg/NLHAfBHTXnw3bj8qnTepIOKgEP78TzbA2pXSnsCw9I0MkZMqVt/mXo17x+ye0nm
 knnnwk4QglWT+loo7rpbpRo5aRxZ+gg61EhyDZhhTUYTi6eUc603/IlpXYUdnE08aPu+q
 xO+5aWQuLRw4wsw4CLrKM8DDHCxY1PLFSqgr3N6tVQSjKg/RsTY+yXDsesyhqVqD/UgQN
 GmvSqPb+YRwPMLoq7BaKoLVBmPVxYy3f3EPBb1py3dUZluUFkNkKvHgkF89ebnO/VCMhZ
 vE7K88jh1XLcsFsuG36Kr/xJVVkkJV6lL0eu+rE6BuM8mFQfLWai6ekFtb3yiWX1e6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782294;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=hGCzFvjaIVuoayBh872Ljvj8YdiRJGIWwb4ttWkrYjU=;
 b=aJVmIMCFRr8Ba7PdxZOrOVcWkFyJu0WA2ng3RKD0rWahkj3v2hIMYNicnIM9DqpFWxMj
 hascWCDrla/1imLdPIXOujG9PCZBrRn0FCRaCaxPem4JYnE2jYd1FlvJYZSYpY1ELkNWX
 xyCQJbicPZTBL+kIOHcKrWJJd2AFCAfJ/FSZx+41dTQUq+Hp5YUItXC/Wnvq6CWElH+OZ
 YRgWLXQk61JMBHE59p59S0VTSI/eGQce8JM34TBpb9zC8wy4v2u8hSeOeO36DSAQhd/9d
 hUNzQSfHNUWEGJ48OQFaVYbRXmn2RNvTfJ3Q10IIbWF6by1vml4nTBNh8aPHZoVyyvA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=UGIcsKAJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=UGIcsKAJ
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 566D34077C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:33 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so3235395e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782291; x=1794387091;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hGCzFvjaIVuoayBh872Ljvj8YdiRJGIWwb4ttWkrYjU=;
 b=UGIcsKAJ4Zo2Km3GhrPccVaq0I+xiJw1tUh3+lNkfMrBLbd513BILnPCHgAVm9vwmH
 7e0l7WUmKGgaHCWtzO9LmY6b7AYpKx9DCx1qgmss+NhUOAB2HzGLIUnsiHIyEA+dEK6U
 FSnYI7ZWKiwA5a5d8qtKDoEv3CcyLVlvHfKY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782291; x=1794387091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hGCzFvjaIVuoayBh872Ljvj8YdiRJGIWwb4ttWkrYjU=;
 b=sLJuSVe/ebDuGqCJbqlC719pqpI/I4bzh/VCwzQjbc75kSTK1fQ5WF4C0f6IkGyvZS
 X2SXr698kQqYkkrqSo1Q+edIFHEcykJ6zdphYsOBjZILg6pQXCN+0RECpSpFl8YQQBXA
 gulTMJMF+w//gseKragIK9z+UXi5TXUk3V8JywsNSVkA3hMAJHpGfNciPxnwMV2ZBHl+
 SDaWQ4SE6/PqpBkPHR+ZWb63/KcPfNCOKyjCbCvYJRaAY/8tiivJEv18vdQPNYKC41QY
 3snsN3wtmW8UN550m18TBSc+rNmDQ/Mf8FS+pjOq6ApUfHKjYOfNy4P7a8lJgIMpS0B9
 sHcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXzlQYpgs3n+tm/g11twt/fCD1SM4Qz2lnWF2UsZVE1A1j1hW8uBZ8EixorPtB8EzTD7vq7F4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9+SeLKjefHj/zt2tgQOc3/xQsnyyhNM9mNC4L6E4iDMVgdhKUp
 sPeTsiit8YyDj5foFdqqjpfsvbp1K/XsDJsHMlvCiswVTWrH+TInN5LLDYJ02IPH0NawqZg7mVM
 7C8YY
X-Gm-Gg: AYBFou19St9tw1PZLK+tSBDzt5JkANmkTN6M525EifWUONAs4Kt/WNbGjvVH5cvvgnO
 ErSH6POPFp/vn7x5D/sm/C/8NiOKdRBB7gmiFKUWCXSzphup9OdQ1ILaoely0nUrfFwjuVMvjYc
 SQAJeHR3jcg5ZDkLrzgS0WGfXLrqyQIjOoJJh0Mcv17mrZHhvj+ZEsqx/9C2zWQ9tYkzuuHn5GT
 jzFvoy7Cpp9llVkQ0egU9zLUwF32PyWHJ1WpRqMIoDfd4IZdT+KhZCSep28f1YZ0AtiG+a2QMp1
 4VUaQSSbw3XXD/sKOiI6z2zSZicUfTDx0V44VeGotJ9kYcldNs8zeqOh7rB89QlwTKYbdAl84PU
 PsEwqa2M/wADMsO3QiO0QZplfxJ7ZM0foeQzziPzIyWNHKnWCbIubE3iJ2iKBwNgpmUHQtGsSiY
 PNDtyT+miSIB5yR3H7Wg3laWZZntlfGDbTUN0Ql/b/pNU+BAiJwsHGIOmNeUj/HytlvK1wiORIp
 TxhPEP5oKVt9a2J8H3WOr/c26D4L5fuB1MZv/l4IuaIej0TWtewCoXfSpX9Oy+ogZHRtyoVi0eR
 Br+KsoiFu+5fvIra1eKiFODHLGoEJQy0CVgiQ7ODFdOUcjVauZXhtcMNmS79HVcTvk2kTNcGHrX
 p0Ko38brkvycx2zlGa/4k8iVwT0eDFT5yqtsfc2OKtIsivTOf
X-Received: by 2002:a05:600c:4f55:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4ac182dcba3mr387160365e9.17.1793782291271; 
 Wed, 04 Nov 2026 00:51:31 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:30 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 13/33] arm64: dts: st: add usart1 pins for stm32mp25
Date: Wed,  4 Nov 2026 09:49:46 +0100
Message-ID: <20261104085036.4012238-14-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the usart1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-14-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 2bb7d85d7a644e20b7b9097a966acec8edd5c7cf ]

(cherry picked from commit 99b28029f7153bab8e870e9510470d21f6722f76)
---

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 4e570e2e5157..d515e44832d7 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -766,6 +766,39 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	usart1_pins_b: usart1-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 8, AF6)>; /* USART1_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 10, AF6)>; /* USART1_RX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	usart1_idle_pins_b: usart1-idle-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 8, ANALOG)>; /* USART1_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 10, AF6)>; /* USART1_RX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	usart1_sleep_pins_b: usart1-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 8, ANALOG)>, /* USART1_TX */
+				 <STM32_PINMUX('B', 10, ANALOG)>; /* USART1_RX */
+		};
+	};
+
 	/omit-if-no-ref/
 	usart2_pins_a: usart2-0 {
 		pins1 {
-- 
2.43.0

