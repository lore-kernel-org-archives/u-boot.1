Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034D606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 04:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QMUt6Jik;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qbh3hkzn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA03E81113;
	Sat,  7 Nov 2026 04:42:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQPNbeeEyXpC; Sat,  7 Nov 2026 04:42:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 37F53813DC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794026568;
	b=nkaR8+3qZrx6PW6JC7efl6xM4eoEJIHaUk4bHPIRWy1A/uYTdC8sFjU7D2MgYHPtbzri
	 US3A6e5rBXqIqHv2iXWgXQJedrrHaCpbbP8rlXcrCENIGpPxqlRu1Vr2mR4mFMNylBky9
	 +z3a4o9t8Ddbw4DnRUppAD1NHQuBHCXY18nOr1IbL4+qwK2JSQJjx8irzm4PaZ4ijZ1oj
	 /W/8CggFycJE1g2WNYUvyWysVnNiCUVLN+HYoc0TW+j2/ZXrhRBhtggE1MVBcLl1esTXI
	 bLrMngv08psGp/pJTvnHVLfER9dbr4PegtyeKL8eto15zKAPYHR5PMprY0t+gQnM/YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794026568;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uWF0QAIoGent2qp+ddW0lCRAH+fPacTn+27LN+0L7u0=;
	b=g8o9mw78trocKbM+HTOcMH/VYIsr2PNyW2Fv4ZaoH+lD+LEdKfaYM2pafTH7QZXXujLY
	 U7TUKJTdpGh8JfFWh4npPsVFZhO4ljTg8xqtU9lw0bsEusB56FQ+8z0WCiItvqZCxQpjK
	 P1VkhiGSFR+23adQRMKcvJFwFDrIRZ8CVuRYhnWlh4aqC6jpBCj8WCtJDl4+xHwYDW+vs
	 WB6MCLr1xh9gBXDJcBCJZ/o73VhqSSaXH01Jjg7fN6WtnQUSPqqmbJiC6H0rTE/UKOOCM
	 PBetOetSZK2RNRcKHjJXz7vtnM+1p1aj4webPZ8NmZHwNnomYrCCYPZItgBDWosSQbw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794026568;
	bh=uWF0QAIoGent2qp+ddW0lCRAH+fPacTn+27LN+0L7u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QMUt6JikICUfBuOBu1oeye9iBYrbTDXJLbY8mpvmgGHDwejPbOOzZFQOB3uOpAjdh
	 oZ7fOczyYxR2aC1+/fqF5QahuwiXW8ekAvMncKZ8gPWa9ZKCUDsF0E2JhxAOc7xxOT
	 RQis4djmA/RzF+dWTh4O5l8xy9TT5JR04UXO2tJNWWfZEDUTG+Pg30BIfgwgT2Gk5X
	 RPnv51FXLyyvGDI6+yPMhnmUUywboAQo06azCYxD1+MiRE9yvwJMX1rvlt5nMlOsRw
	 wktV8Sj9Z3FJx0+dTFAaiXbZNF4UlDLzf7b0dKWZY2gv/gk0ddWiGtmZ99FRVZyeyn
	 qUks099Z3qLhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37F53813DC;
	Sat,  7 Nov 2026 04:42:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E122235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FCEA60AAE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DiYEttKahnNx for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC0CF60AAC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2c; helo=mail-vs1-xe2c.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Qbh3hkzn
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC0CF60AAC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:58 +0000 (UTC)
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-7cc53938a8fso770542137.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793999757; x=1794604557;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uWF0QAIoGent2qp+ddW0lCRAH+fPacTn+27LN+0L7u0=;
 b=Qbh3hkznYUtSN0uDryersS0EQ1WrjP7hOrM68gjEwK4q1+y/NkZDAKG/C07/1VHVPW
 6/NxzN3Oir3Lf+q6h1FOg91fA6TUdbM9+KlwRIr/raEl3xZqPDa2kNRHQuIgq97l4t4C
 oYb2wsr5oWE3CXAJcR1ACET8rzumvsjvQlyH3gF6KYw5U3e3fgtSQKFXOkQlXfIjpM4n
 EtLWFwlG8I9ufL6b4xOEgbZWUs0l+tqdiB+COm702uPW9phavSX6Rf1R3hGQ8jirlHLc
 wZ02U9uRfbiJ0izXyKX5hrBWZOLGpq+SnJoLEALGSSCrnuWIuugIjKqniVelJkbZ9KfB
 8J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793999757; x=1794604557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uWF0QAIoGent2qp+ddW0lCRAH+fPacTn+27LN+0L7u0=;
 b=fGMKG+pN+ZgxPGjSoGe6asSM/7iZRARkePKJCnjepMV2h7Ou+OjhSOeZle8ZX2+SnZ
 t2nAa8jlhkrC1ZKG4EH5v1LhFxDlj1X3xB3uko8ZaT0RfQ6gAo49Zsa0Y3nS0HCjrkpU
 yUAgLERHIJukCv6lXMHLcD6E4Si/P1tNIuXdttOpMtHCSpz+zftTHEai43kRXKxkOiZ3
 1j2hE083LHBqN0PEqEc9pTCMv+EcRQZx1m30ml/YMNkvls6i+5N9J5cgWSUiN6ruMc5u
 633vUqwRO0duXW39a9ST3ErCfU+AhTwJqQ1DnW9Kx32QCduZic9r85zbaj8o06SJfqzp
 aAvA==
X-Gm-Message-State: APuU4Z9qVUSNaKOVtvW23PZMwlswyo4kwxFVNeBCBmVgEz7fqNMx07Rd
 3C7wjojGaZ2gk/eyedveUJxRV4v0oSd0wVYVIlN+Lp5rtTAqmtIOOP1OyKmtJ3KP
X-Gm-Gg: AYBFou2qMpO1Os6A+0EUloIIUW2hTf+ClZlg4jM5GjUJHv38vJgNOxwa5chUpOHVXyj
 4GSvOkmmG/8Ql3nSlIYMD5zvqoHwbpQboTMF6GaztOaA7duMQok/D14kttCCtlI9suT4rVm8742
 oMYCvs22P9TYeiAU843Ys9ZZQCd7xZmlKtl+pr4YS6+HDHhag7RkilFWMpdSCenKL61qrIysn7D
 j/12v/aDmaPPM8xlUfEGTnZ0Fd1uIZoVpkanQ6QnOBd6l6G5fWR+oM6tHTwUAcSGRCDRgEhWf2o
 oBZ3jq8UbTebBWLy75iNbd54VdfUX7j93BR7GnsKU4nS7yJ/FyBsTbgG5QD8F+uoxMpcokkbQBj
 adc2STLxzPS8519bHKZiFvaFrs6etphUcyb2Q/+mVIQsFiI20DUQbcpFvNIGhRFxuy1mlJDwI0n
 J7+UiRxe2uyG+50zGPDzD4odwFFSKLRchTX6pMSHdPp5s/5R7pdkT6rlrHmkqwye1kBdhq7K7ol
 iUWl69FVAljQp0AAGnrnNjKuixBfzZkNeC807z+h7O44eOGgB4e5iFQIncmIivOuET3NIrpNdyP
 bYlt1tqcLASWcOunwR15MEEQG3JBOckz7rQdy84CfhrVagAbP+eSMLVYWNQT5+VxwWw=
X-Received: by 2002:a05:6102:f9c:b0:7cc:971a:61ee with SMTP id
 ada2fe7eead31-7d2a153f6e7mr2197695137.10.1793999752347; 
 Fri, 06 Nov 2026 13:15:52 -0800 (PST)
Received: from mateus-laptop.. ([2804:1eb0:a0:15ff:e3:543a:df0a:607a])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99bab48acb7sm2614087241.1.2026.11.06.13.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:15:51 -0800 (PST)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alison Wang <alison.wang@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>
Subject: [PATCH v2 2/6] armv7: ls102xa: Terminate CCI-400 barriers before
 cpu_init_cp15
Date: Fri,  6 Nov 2026 18:15:34 -0300
Message-ID: <1efcdce2c699ad4b57caccecd4d6cba9041dd897.1793999703.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793999703.git.mateuslima.ti@gmail.com>
References: <cover.1793999703.git.mateuslima.ti@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 04:42:41 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On LS1021A rev 1.0 the DDR controller does not respond to the barrier
transactions that the CCI-400 forwards before the DDR is initialized.
The first DSB in cpu_init_cp15 then never completes and the SPL hangs
before printing anything. The A-008850 workaround terminates the
barriers in arch_soc_init(), which runs after that DSB.

Terminate the barrier transactions in the CCI-400 Control Override
register right after VBAR is set, as done in the Layerscape SDK by
commit da25dce4aac5 ("arm: ls102xa: Add workaround for Barrier
Transaction issue") in LS1021A-SDK-V1.3. erratum_a008850_post() enables
them again once the DDR is up.

Tested on an LS1021A-IoT board with rev 1.0 silicon (SVR 0x87081110):
without this change the SPL is silent from power-on; with it the board
boots Linux from cold and warm reset, and 0x01180000 reads 0 after DDR
init.

Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alison Wang <alison.wang@nxp.com>

Changes in v2:
- Rebase on main, no other changes
---
 arch/arm/cpu/armv7/start.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 833486817f8..b7c883cab91 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -114,6 +114,12 @@ switch_to_hypervisor_ret:
 #endif
 #endif
 
+#ifdef CONFIG_ARCH_LS1021A
+	ldr r1, =0x01180000
+	mov r2, #0x00000008
+	str r2, [r1]
+#endif
+
 	/* the mask ROM code should have PLL and others stable */
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
 #ifdef CONFIG_CPU_V7A
-- 
2.43.0

