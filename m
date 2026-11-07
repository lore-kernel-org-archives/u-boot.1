Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3047606A332
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pkzgrg2n;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=IMyRI9al
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16B3E815C3;
	Sat,  7 Nov 2026 14:32:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X8Hn_pZAG1AX; Sat,  7 Nov 2026 14:32:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28AAE8149C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061978;
	b=mNQnZOBKhFcmJVlxvH65zOYLowh1bNZg6HGrKzMxB7AV6tq78OqVotgMvukdr11pR1L2
	 pQB4+zr+y/EJjHanp1ePWMnCjhCcgfl+EIai5QF7Sskte44+td7oSo7z17Uiiq8xkDtSY
	 OYuAde8R0ijmvNAQbWGUgjDF4fF+NexvUM1r7zEsOX9nhiiiXot0DXccUO1LAV1ZWQTbG
	 lqm4/kfLoPKBSxskheEijDDnIfvr8WfVALJbONarVqJCEJrpIAcwK6GBPx5oRDl5lwEyE
	 G4Ssvo1oZKW23oa4hzpnNE9EFaZXlR5h/KMSEfLcpZhWXGVFN3S5hLbc/OECY4lXGuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061978;
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
	b=DKbcqJf/j9j928Cwkwn6xKwuz2GtOsoJISdM/F0tx5cHqhrWIKkI8C8MpSM2D73msjVa
	 srt5GqwrwGPtm1ikYElFvhO9ev52MOQ5j9lGhRmlRgmNnYpQZvb1VLYChFOFtBxluMSTG
	 XkRBT7kYzIXSd/idGL+CXheSJp9ITAd/HaBylFLyVvbgxldsDBzQUAfI9+atzLOoxghX2
	 e6YzXZEeyB4RGypuO5+p8d6K57oIAMENOt2FBO3p9ncNkIX2bQ/Ydyu6GId2q56z3huaX
	 6ZVAGkcOIjGgGqqs6xN+suhLz86ry+8SboC/hWYShdrmHojnDQv9QfVHSEe2Khap0Dg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=IMyRI9al;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061978;
	bh=F2ze2ot8cRSvrm5WWA34Au2DJvYTzJ8+Wxq5XPd9CCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pkzgrg2nfKhmMDY8H/bAHrcCb21CqfXPU9toklz0Wx9D1xK5RCmvvc/taIV7N6Vqt
	 fQHvbg/cQsqeqE+8/hGOyff805GrMfTMfQh9StJynnYGAIXHPR130ckMgDJ2Wm1XXb
	 BROYzBNaeCJA2TZItASQdC6SBnwsc3fva/6PNpMJJ9Wnhmws75PiEr/ONjk8fv9mkY
	 Km/KFYtg8mqw09m3Hy9CMcTG0oCyRdgGLYQsw0oaD2JpCHFTqh3DivVu+GK7oJCYKc
	 dD1V/QCQpcmGjq/ejMMRoNMet0e7rp0rNTHRAg7ywC5R8x+5Zft0828svTkyITD3jf
	 8bdEXLAq8MzSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28AAE8149C;
	Sat,  7 Nov 2026 14:32:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 451F8211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 417ED8151E
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0N1Nfu2uPrvx for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:32:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9A868813EE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=IMyRI9al
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A868813EE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:52 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4919a880834so834546f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061971; x=1794666771;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F2ze2ot8cRSvrm5WWA34Au2DJvYTzJ8+Wxq5XPd9CCc=;
 b=IMyRI9alTZfaRA9m+6YyCDaMw8GiXAkAs/fi1XU8hLD+zAP+/0gd8I/aNUzEWsvMNW
 L1OtR1P59s5fs/w/iiDVn3Nii/5LUVNQyMJGL5ASBOZHfsnRPlwMO6mbtJdQUZZzIDa2
 eARaiHwT1JR7mvlSzNGHzdEsqAqjK/XhbReY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061971; x=1794666771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F2ze2ot8cRSvrm5WWA34Au2DJvYTzJ8+Wxq5XPd9CCc=;
 b=dt/xp7YVAIU+Ux4HLSXqdvtnTmVCP7YPnc/hLGAKInRtwl+psX2EjNp/zdCqXnBiNE
 c1X2XnZ5+HqSkQ3ft3C+m70eD86EeKEnDRYhI/FtgLrB/Y2BRJLQMwPFxm3Nimd1wxdt
 sUVOubN2n31VLbCBcb5KWKpjIoNkYuCP6AT2iuGBFoFhFCitXRVvexyoW1vW4LzmmZlG
 wgfNzRsfPl0pJZwoY73QDXzn8l7yPr8h/r0kf98nevZEkEDoe9O9B06UbiNdb40qicZD
 1ouwGLg6FdY6e+0AgcsSLzfkix+qE4JkM02S2Skbmr2v66sasWT+cXWI1Z0NkH4P6sWG
 BLdA==
X-Forwarded-Encrypted: i=1;
 AL+hErHvK+UVcP4wRNqAW3FkUKG1ydVNSOsaYXr1tVSVaxMcpgg/Trt064j55IbTejmTH7f+YwjBF8I=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/qGkHr3xA52H3JeGLAWhEEcWi7kLZeMHqppU0svwIez0SEjeq1
 Eh/ExWirwVxQF1QsepObSzyeQZJ+01vANTWQRTjBFizYBZ0rfOU7RO4SsX/lKa08Q4I=
X-Gm-Gg: AYBFou2f2mxHl/BPcnbP+1deAeXL+PPS4u/JY+SDM38N7UdhgMU4bOvgdNObnCD6MWs
 xB34mFvWgsAIYZFby6gpPRcAIUzebq9NxUwq6a0pqGxdFvIR8LnZkDOqh/QUYL44JuSXtgZPcS3
 ndbYRbiw7JmADnwlITVwXBcvxcEK1H0Ob0XvpluzUy6sIwKdBcJ9qajnKXmV/TpTtETfLQ17c8C
 DTQeyKt8rx4f3RHPcN5IlvYi8MeZM6GA4k/8bX/AxtIpmT/5JKkIPcJ/XUVCrI8Kz1IYoug1Z4d
 OjHssTv/a/6lZFdG1JxowKB2yDLEn/JR0T1soO9tMqNtVTZXTVeGAoDPtZjpCyZ0sxXBr0zvx6o
 ngCl5wggYg0TZ3ofMEWss7+yLIJjrlkTwNm0tUAYlyYU9aY0vjhnMDHNbgKyilJD3q4HwYJxRlv
 4q7CkTEaEHMbYIomw7PnWOCETZfmDT0t3rK4I6hcJt4AumPNK+/KQZmTHu439vOb12EvbgAOIyq
 mvljXSA9YQwYWQnDbkdn2QLx4Kz6ovtKv5VoMnmcjUqIZmxRI8FNyHCd691HozCCCFZWQFm8DwQ
 lqMqpCtuQ9cY2HL8p8Q93PuwDvAnVW3LrdT6OSUWof4DesfAm0Z4lr/xL8GuSJBfCWv16a8+bqH
 wV3QVkA+1K2x+j47zYcDbSpdEk8lYXS5UtRQ7O9nct9YxHesTpRq6JWKzBUreKJGrkEXLwf1SAk
 p7v/Ww44mNihw7EFoLqr9gQ/ki+QJDz9VIcPyAccKvK31TNp4=
X-Received: by 2002:a05:6000:4a13:b0:48e:932:aefa with SMTP id
 ffacd0b85a97d-4927527d861mr9882974f8f.26.1794061970970; 
 Sat, 07 Nov 2026 06:32:50 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:32:50 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 03/35] arm64: dts: st: add power-domains to sdmmc1 on
 stm32mp251
Date: Sat,  7 Nov 2026 15:31:53 +0100
Message-ID: <20261107143241.2236511-4-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

