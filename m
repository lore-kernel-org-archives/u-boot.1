Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFA2606A321
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QZqOEt89;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=LBejSKKG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE4B480E51;
	Sat, 28 Nov 2026 13:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dbYNAx7qvop5; Sat, 28 Nov 2026 13:11:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6BA880E67
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871507;
	b=clFXGjuEdmYc35W1poChgsHePWfKdMvuKfY4fsNjN5cQ4O8eUXCep2XeD+KGvXaZkoG8
	 Aa8RjwWUU6gt1J88AvZvgWdttf7kGThAS3+aEn8pcER09diOTP0w25ecJllAht/8H1ym0
	 ZgN5F9S7u0WeCte/wukdIuPAMAZ3GImFb1N4GIGpInkofWfX5MotM+zi22km4oJWHHhpv
	 EJjEO59yDSHprTW1/z3yhVAScdP7NVH7cZJLljj0XO9uQDTmLhbUm8tUNvF8F9pLyq+qF
	 dqSg83tda+rx+8Vf3YvLs4lV5kIVBiulX6fipQyL9t7Qc/7e86RRArADqGjLMpLzsNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F2ze2ot8cRSvrm5WWA34Au2DJvYTzJ8+Wxq5XPd9CCc=;
	b=IjkOUUvo3H5H1CItrxzth4BXcMLUElru+xSqJtVF4vPQa2RA9XLlL7EKDkIREAaGR542
	 +rn2foMtC/HLzRN8jhk56td+JIYsIdYBHmXmdYibGncr3yTYUF1zeuLUvrNI68Via5qgm
	 0MKIOqk2lCztvRSElzyDXDiB1Qr/3RR0opHVGM67IG1ESP8lEYv83B+TM8Z2mcAf3jQnt
	 +ssssmX/bqNZbuSWpMUBzuUysECHMP9MrRxs82Bf7gF5tiLCR7RFcf6lRPahg1LQOzZqo
	 UMCLTtExSOyK+w1q2C9eqfcsO9ka1s36k4omU5XDYLLO3rmbIe/Jii7SZDYRNlujKLw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871507;
	bh=F2ze2ot8cRSvrm5WWA34Au2DJvYTzJ8+Wxq5XPd9CCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QZqOEt89TksIMX0dbpuSOiM8WrkyxkDYqJrFNHs96F7iNsjQlWvze4M7/Ts+HFXWO
	 0hCxp6cKL8HzPr8isdtPgU6S5yGsGLehaaZofdG+/Qtr3laOLEEZ2OchIHaC86CSI8
	 5ZfWfrd6ChBc4Um36JLoKlT7ruqjsyhfMHgNC9A1nGTtH+MQWE1zFlbRGe/jDrOGoW
	 JaKHb9X7LgGjB/I/bNiMvYiNJSGalCRIyWUMDqvJp7BSo9tUhMf9Y0GSAs+tXlrAqb
	 9InAv1dg8Na7XEEoCZ3IEQ+vbYzIq0Ols8HRRsUhY4Xyb9VLC3VrTR2s7fY5TIhQlt
	 ByP3TMjiIUcAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6BA880E67;
	Sat, 28 Nov 2026 13:11:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ADDB726D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9FC9760621
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MWrr2lCJ6x5G for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A34860623
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=LBejSKKG
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A34860623
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:39 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so73335005e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871497; x=1796476297;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F2ze2ot8cRSvrm5WWA34Au2DJvYTzJ8+Wxq5XPd9CCc=;
 b=LBejSKKGLPfLpCjIA8TtoeKY3ZRcDzFI+UFLgR0kXPb0Xo/jkyKQCHSZd9pr8L83iE
 pBhQ5NpzO/H9p5wFaW94q36YzAXRb6dhn4rZT8DO/ZcTVgeoQSyvNPl5wU5STpRnq75l
 Ug9vEr0yTN475Hq+uT1dO3v+LY44hggSOOV+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871497; x=1796476297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F2ze2ot8cRSvrm5WWA34Au2DJvYTzJ8+Wxq5XPd9CCc=;
 b=l9aTu+k/jaX/SEiEh31q+CPST8in04NnTlv3WACnqtL6OiETIud9KHR7jqOM6tjyRx
 eycvUqKQ6umeqT4oDrOuhs3fWyZoEnNvvQf2vDyr648hddB2WFvGNYgPiEHYm7DgHTHW
 Z0r3My1yqMX5wplVm7yJGnSVR0Z06yp2RHN690JHE4zyWkIRh+BNWuadehl/YQpNWOo9
 PS26aEgzkr2CtZNBJ9Sur0WWKhE/QY/WF7gZrUKJmK+aNr5Ythe+N7kCd6i/+pUcoE/C
 My14vKrnC+5HOADO604XeTT0JIbmj+lvgxHDfP4nizlP6FSomXYWBaLEaCv7MV6CTygw
 PJqg==
X-Forwarded-Encrypted: i=1;
 AL+hErExOheziuQK+DqGz1IfJCOWjFZH3ddnwaOW2wGDFvooIxEFQBtu3V7Fx3GPGFiDfVM9tCsnGws=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/EiKL67yu8rvzYY4ycHMXO/EsUac48zD2cjz9THJJeeH9vVRSM
 uLesESrUGToRkcwe7T7hMpLTlm2kJJp5vpZqwnMzoKaDyRcagE/zrtu0nxx7JEm+NuM=
X-Gm-Gg: AZFdTZcWUjurGKSIHIrbmPw4Dqf1YXc8fTOo0akmW9M7khVe538AMmGt7Up3ZZEt+8h
 OEzskvJ6G9J5tqD1bAFd+aSfqz0WJ1z53EIAkOYA+qiTZyL5huyhqfVJfbnFEPUsOtuGRF+4FHi
 ON9kkqhIOHr8kxwCMvgR5EVJ04VvmsqnMeJkrekIV/P1YcBLpk883xNRnWNBpi00geyvtNXCvs4
 JLu3JnpvqNfaOpj5Hx4xY1zA6+i0aURyuQ9UGWDXol66sM1TlY0PeroQKZOetqDTj2V3WwIdkmk
 YtMW0sbT1HKm53mbtYegugRKJ+uxcdTbcgmnNCtMdlrUnnhP9zeO4s7dgcjSHIj5qwaisMe5VJa
 G3z9D4if6YPjlOnDxRMEqBx/F6ddQp9dqu3fsrxW4/QxW7Y1JGxzEdAPZamqzc9OJJp/yQZgISS
 JYs77krBujs7bctvC2KFwvCpLfukVoKmcm76k4T7CCumzPCXHMfc1nS8/CGGuKF7CFkF0//kipp
 miosUP3e3iMpwLwb1lOi55Ux6rbR3anwO94glWTWvDGTOhcs492T0HIzsXIo207Dc1GzzCD6dPs
 s2/Cy4LPF/fR/oxwbcV2fjjKZiobRt89w64O6eEILFaG7fv4KkEIRAEa63hOEEm5h0dqdCPtdO7
 ysOfSh6enROA13nFZk1TjH4CHHgx45H+FSVhMb2n93BuVDSg5bZBx2+NTtUnQ7vp+A1842bs5hT
 eRP4Rv0Pohj+jtb4VBo3/sPv76kQ==
X-Received: by 2002:a05:600c:3b98:b0:4bb:7033:c92f with SMTP id
 5b1f17b1804b1-4bb88826810mr547955565e9.11.1795871497253; 
 Sat, 28 Nov 2026 05:11:37 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:36 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 03/29] arm64: dts: st: add power-domains to sdmmc1 on
 stm32mp251
Date: Sat, 28 Nov 2026 14:10:20 +0100
Message-ID: <20261128131125.2141352-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
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

The sdmmc1 node was introduced early in the SoC bring-up before power
domains were systematically mapped. Add the missing power-domains
property to align it with the rest of the peripheral nodes.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-4-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 4f454e51290d072fef58eca653c65dc1fa8c7d70 ]

(cherry picked from commit 188b75b85a9f6dd4dc25cc4d6b7298d01ebf5efa)
---

(no changes since v1)

 dts/upstream/src/arm64/st/stm32mp251.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp251.dtsi b/dts/upstream/src/arm64/st/stm32mp251.dtsi
index 9c63fdb5a885..ae36d703532c 100644
--- a/dts/upstream/src/arm64/st/stm32mp251.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp251.dtsi
@@ -1664,6 +1664,7 @@
 				cap-mmc-highspeed;
 				max-frequency = <120000000>;
 				access-controllers = <&rifsc 76>;
+				power-domains = <&CLUSTER_PD>;
 				status = "disabled";
 			};
 
-- 
2.43.0

