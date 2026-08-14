Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ECBC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A2BD80B9C;
	Fri, 14 Aug 2026 18:39:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HJo8aTBjp0N3; Fri, 14 Aug 2026 18:39:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 045488096C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732750;
	bh=MMqeHZEjvxh8hl8zgBw4hNlo90pBjca6Ht62kxDNFLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y1x0seBf3glXRuOTHuwK2dvUhHAUqa+G4vZlprMxGL0r4/N0h2lLRaPQkic443m+u
	 VA5T80LsYbWrTYRhnlB70e9yqM9Q9UGUhV5JwwnvcgEKR/KVR0fyxpZHWAunf8o3Sk
	 xYVDA0BxIMT3YlNCFgYJuB60uSxN2yRYr3Z3TNqvewMyR/MM/BoZZD69fcNEsxAuek
	 GNDP+llCeX7SZd5A/TnFqDoHBrmlqMhtFEUbhVTXsKiMstzqwMOhayA1SmnXzPq9Zx
	 afcYU0jlIYlzt6/XmczhADcttSxOlil0vlu3Xy2K7PePbHDQ3ubHidHDRE7ETef0JC
	 mByK08813xd5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 045488096C;
	Fri, 14 Aug 2026 18:39:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2DAF194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4B7D40C9A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A7x3U6lI7XsH for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:39:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EBB3440C7A
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBB3440C7A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=wEDi0rPY
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EBB3440C7A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:04 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-51c04bf4711so14305351cf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732744; x=1787337544;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MMqeHZEjvxh8hl8zgBw4hNlo90pBjca6Ht62kxDNFLc=;
 b=wEDi0rPYCxolauI9BUE2ZSZjBh4HHhqkadzJpiXvLPKySnKE6gMv7zOPSPOqfyeX6S
 PZHPZR8TZXw2xFBIfD9gtWbx1Rrj6I6g2e28bwtFjqTiaB/RchnhN4WK3c/axXMDIpDF
 c4mSfOqY7/k9wjPgaUkOD8Rxl8defSOFUFSWFzRGiQg4eYDF/KNexkivaTYgEDIRdtyp
 8+HWb2a2IE8LQ4cmjAkcA353k+biz48uYrcdTBn5llYERmM4kDF+p2BHbvcoCfCULSf+
 ExK8k20ZO8Jb100EzPmJYzCZS9Q5CPyoTe2sUC0ql4Nplfj+VFWZ7rJroNrbe1LNDfBT
 GJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732744; x=1787337544;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MMqeHZEjvxh8hl8zgBw4hNlo90pBjca6Ht62kxDNFLc=;
 b=HCVglo7TlZCLHUby6Iz/WPBhXQfoWBbSFsFZsFGaCfYHS0nbii/xtVXDMO3LVc3pUI
 IeeH1e4AZlSVdWskxZUXbTLOD0iaIk06HcexeWWGVR4QlBZVPqNYpdNd8HOuuxZEmCTb
 0zuTvm7SfinYQSm/E79y3r0zyQUwRRB2WHJhYtmqeaa2npl5yVgJbz/8nsKiAyvPoBs7
 pUQKtUmteHghcp/iOpsXauwumwHSwZ3hQhGTyaIWTfgtDuT1mQnQE86InX2kU9u3uQ1T
 Evap5Pm+7GmXjraS7Wk1qc4e1pVnu+vcgrDaYfl4E8vuA4vpF+PZ7QU5JMAj5IMHfvN0
 eurw==
X-Gm-Message-State: AOJu0YyqWRELkkQbEquCJTVHrRs/STduYXBihg3/MSmQjsw1aoimg2mX
 Kt6jdwCaElZnFPFKrccrTU7fke34Y60EV+0KIsb93DbYE/4tVawYqWrRlVjS+jy61Ihz8im8Ci3
 7YOdBUrg=
X-Gm-Gg: AR+sD12Eotc9pUg/yiygdUyxIt/dzDXdBfBrsF3YuZi4YB3vP7IV4Lu81/WNK2QR6u8
 2iYwrz0BxT9drItNAucf8oCAlOZPUH8Pc38frT1prQ25cGTPZjW1HlMXY+Dm3R0ddNpLFZMXgE7
 blStlzDTGr1e/VtMj2h33Ycyapkgm7bRV9SOWYHqU0jQL0BSosqBMNpXh7d6b9fOPQPqjqfM31x
 W3/vw89mapD8qW/O0q9zzBMW8218BUMLjlk9DG1iaMbKOl4sTtZM76d/nnTpqQTg7Z+FkwYd4oY
 CYsr4GeWHDfuZn7PpwkoUDOcmzpqa2U0ssRyFUTwQaQx46qqCNGm7Qq/aDBHBSccno6oQb3FWLy
 zZ+ZXg/UojlsPHR5is+UQE3K2+1vIbXwAuVHyDys+kkEh5eH574GRFRf8dwAXdixpzS4P2DThl7
 nXP5RB+5QXgqpH8AOOyz5G3JWkefHtrRnVCbT84ViWelibdgIBZjlNnA1CyiSRBhqcQ8p1zm55e
 yRjLCwk7rESSz6nQ4xKQCQ+1tw2JqHOjVqlOsDeWAt2Gf/L6Xu1eSw4lElDy0C0u3w=
X-Received: by 2002:a05:622a:2446:b0:51c:1a11:75cf with SMTP id
 d75a77b69052e-52d852fda64mr92696241cf.7.1786732743662; 
 Fri, 14 Aug 2026 11:39:03 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d83f00024sm27617031cf.11.2026.08.14.11.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:39:03 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:38:55 -0400
Subject: [PATCH v2 3/8] board: schneider: rzn1-snarc: update MAINTAINERS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-v2-3-56b6acef0439@linaro.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732739; l=797;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=/xYAHR+TjpImFvIqrlqjftL/3RA3mqRSUw1CsbTIwcg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIR48BWsAxljc84+nE4Rgo4igG27k8xAW5Oyy2YLKzgMN1v7WGgw0FIU+vHgT9f7cKrdczT6s0S
 WBJ91KxsZSw4=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add NAND, ethernet switch and media converters.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 board/schneider/rzn1-snarc/MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/schneider/rzn1-snarc/MAINTAINERS b/board/schneider/rzn1-snarc/MAINTAINERS
index a39b96c1163..f8ae9e1cb6c 100644
--- a/board/schneider/rzn1-snarc/MAINTAINERS
+++ b/board/schneider/rzn1-snarc/MAINTAINERS
@@ -2,6 +2,9 @@ RZN1 SNARC
 M:	Ralph Siemsen <ralph.siemsen@linaro.org>
 S:	Maintained
 F:	board/schneider/rzn1-snarc/
+F:	drivers/mtd/nand/raw/evatronix_nand.[ch]
+F:	drivers/net/rzn1_a5psw.c
+F:	drivers/net/rzn1_miic.c
 F:	arch/arm/dts/r9a06g032-ddr.dtsi
 F:	arch/arm/dts/r9a06g032-rzn1-snarc-u-boot.dtsi
 F:	arch/arm/dts/r9a06g032-rzn1-snarc.dts

-- 
2.55.0

