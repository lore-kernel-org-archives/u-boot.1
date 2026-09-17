Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7122DC982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D11C60B6C;
	Thu, 17 Sep 2026 14:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NKsxmb5kT43g; Thu, 17 Sep 2026 14:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8207D60B67
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653802;
	b=iCPyQITfwz9S4PaRcD5BIBLYBSNTAM/RabM0U0EE+i2CeRSV1YSPKc7getThKuHlZJqz
	 yDBcJl5o+qdXYMKiYycxBv2HfR5LVShF/J5Ir5EiexONrh3zEqkQj67vZ9C+fHHoK7IMZ
	 FlQIAWXNThLr28nhfapJuplvSrnpIdBIk0os+6KhZumaIYveNTXN307q0zgDGJYx+Pgef
	 sjVoX0LqiiaSbObSWKo/ReeM0ClSrrbDaf4Z25n2vMKP8BxjxUqYpPyfF5wfhMtR/BgJw
	 IxVigPLfWFChz4hhB+0iYkPO2IzQ3qt3MCnIjyEzru2qVkJ/1zWUc+bpFTBJ94bo+Hg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/Vcr59Cf8dP5Quj1LmEfLGbpf9ReZlAKoHPm0ma9AEc=;
	b=VKzqi9Nt0Y52cCcufzUFGSKy70n5Je8vTqKfXy4c9VB2VzsQR62uDz4KG9McYuoQz2iu
	 IuHTIzG1n1Jl8y8AgSiOAWvPZuNQ6A8wvTPnEiChM5cUZIFH7NvekPgG3gH/rlzEp0yu9
	 YjeUvpgi6Lg+dToyzy6MqamcRReIZzzT4cZ978s3AXfJGXRe0VH3l/Myx1O3hKbPNHK/E
	 ad29ZrbU7enHqND4nQ25pqMX35VxkVq2EsJuVPWjbTys6quSPogGwwp7VXD5mV+uLxReE
	 9R8Zkfg4I+vC27AkakFEcmMdFehqBCTBVxmjlFoppjRU+pKT3fw0FV0dHOPzxT4T0Yw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=rkLqqSvL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653802;
	bh=/Vcr59Cf8dP5Quj1LmEfLGbpf9ReZlAKoHPm0ma9AEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mYHRSXYvatWltaSopjNmzMd18Z6VF8EWmAJjq0wZ4BfUV66Pp0RCPvTLsFTEbRwtc
	 IIaq2q1ewZ3O3Iz1qByWmY6vgTKF70uJtFSW5TNqeVogMWlAr4NtZlA+hyFfiPGm/B
	 TDkq+n/C6xx7LCoHy8pdyTFybsJklWJHhCj5UQ1nUV+/K+CecGNYIOGrp/Kz4jRf4N
	 yN2MGOLX72gQi05ReEn1u5pK0A+E0dSA+TsVpfACUW0LDkHZhaWqQOPEOS2mLURsVM
	 IH2hswlX60sdZoSDUqA99J0zOM7WSI0UfCYxggT47CS6FWD2mlUEptannljZN+r+yr
	 pF/FYEISe23+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8207D60B67;
	Thu, 17 Sep 2026 14:03:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EB954362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC20C60B2D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MK4esLbh1yiq for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:03:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C53B260B57
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653799;
 b=lM2W3AgXFLRyucIVT88X4IGZKTxpmwpBlq9TbM9RGUgW1O9WA0MgInnbL9eIRhxNUZG5
 Bi+Vuzd6mO0OFhIKzS78VmDxGKwlsLKr/nigKIsA8vjcnD4LyoCFnmfYV93Unyz5m5zaG
 OQJHDjkNUTSOsPRcMMrQFXeLJHrIvkolagKPvoxFh/LN2J3UlgdpdKnNA4noXdtxC849N
 DrJLz6SVhLGOY7HEme3jQG3zGJqih/pZ0UCKbX4KY2OdW6qNfINJUMtntRRVTb5SYFqlp
 +2ljpnNiCoBB1t5ME/65FomeQtglQK129qOTw7Ax91L+eBssBvyjT4pNucIvdblcHXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653799;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=/Vcr59Cf8dP5Quj1LmEfLGbpf9ReZlAKoHPm0ma9AEc=;
 b=G1JsWWD/xCvvngqHYL8SBgEonJZZdr5uswrA/t/cl85womrv5N4MprS0Rz++5TTgyQBU
 Evt0+7hamdxFzuCQ8cnKq5SFiH5qN2n+h6HxjQCMyKjwwfxHi0VtnUJD20t2EhqbgsMZV
 xlWSh2XyXu+49Ko1NKvc+qdimRXLKp3Af7uS3HyjpRZJkgqqbfVCkYA8lT+P07zLG1MhN
 nkgIiQrF7Ef4qVxCgNjYgcL4dViFKTG6VpUGqJ15R6ATZGBIkOzIHGU88VQgeUlDkh0xH
 50jdQSrRsksJdUxHCI699p94leZgDN7XKt85sBVlMLV3i782K1ztpJaz7xa9ugbgevg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=rkLqqSvL; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=rkLqqSvL
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C53B260B57
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:18 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so528062f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653797; x=1790258597;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Vcr59Cf8dP5Quj1LmEfLGbpf9ReZlAKoHPm0ma9AEc=;
 b=rkLqqSvLbu8opA14sQiO7ItMJiqWBC+cgVetJ6d8vWOmdjIxzug0gOINm4LY1vuOvK
 gdIQLnDtLIiCk5x2sdAZKtYopqq6AbbCUhfrrOHJ1MB0Ypwpp6bmrEPSVBNA0FiT3qME
 HcZQ3j286dAeVtEDbSSP+LxnZqw706wZP8uXH8TN6SIUuXVOihpybEByZK43w0GrbHXu
 aRUUjvaddVxF00P3Pc82YVyHmcg8J6tf31vhjeFbl1zQHKBwZ4tSiRBoeMkTyHfnHOgk
 nJGvKWf7V2/pbIqwOr7Zk6Hla7u3U0qboFV/F6LjIvCV6nkdnM7XxsAfjR/E1PzIeOxD
 zMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653797; x=1790258597;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Vcr59Cf8dP5Quj1LmEfLGbpf9ReZlAKoHPm0ma9AEc=;
 b=tGoUh3Z2kSi2uxr4aFP3pMfqfr1m/+6ONJ+n4tyU1+KudXZrXqNXVJoJGnTSB2dxBz
 RHfa0LITOsCHgnKgMaf5DVNNSZ0WC8h/anKDsEghHP/YyhCbEPfirvYui/e842wrvDRx
 C9TdBvAOXuFJA4KXCpKB0N7Zx2e5JcXVm4+mE+qcyma5z79I5HE2x3D2Rr2aQgbQ6oDH
 /USG47qQkKJ7e4vpPcJqt4mphl1tmpPHW9O5cJ2GiVPENzfyv24el9FUlLyxE32Ux6gR
 z9nbRxvwln7xEGG9r1So547BmiJo1Bsgvumqr8UI7GK7QHKHMbi7Nhsk5jB5HNd4H63K
 GTuQ==
X-Gm-Message-State: AFuF++lKx/cB1qS1BQ+t85dtTRfmq8BE6m++0aJiujN25wTM4ukYItWq
 OTj1wBnbzNQDSLiNm35EKieot06lEBboj/l3RS3IMkPssJY11rSkAapF4HQu5EHB1ZE=
X-Gm-Gg: AYBFou3VGppxH6Y7wr1agD4A1LgaSfv6NswvqMI7BO4tTsecLJACp74OAGXbAuDlEOg
 T9l8eMHKg6FuheHUnagEBHXPy/xUWt4ewlmmFAeqhzK/fJLyR4PGs4fuSyMpwMD/uH2K0nNRdyk
 NkjodXAupOvJkM0M2VRpPMfrp0Z2RnZzxXilp7pg5bmI9U1PSfbuDBZDgDCKIrBoq3dpi3vV9OC
 TZbSBjiv854E4YG05D7xJt2+nM2jmaqxMQp+mvF/KJjZ2rKH+wZEWmGDRDSw9tnyvw5CIukeh3E
 OC2CI4ZQM8fOqG19Ti7ujfHaeZbk+iDgOUkcUdZtrp3BcRfisgXGhe89Dvz/X6IJflQtl1LN7dE
 euXtM8C4k/ppwaR80H6DPZ7mSb8Ciuo2bC1rSpP2MrpnGn+cDtB7wHpsg6LJ1oiWr9vdsJ2eszV
 J9ePoPytZSIO7NTZwhC22xVpF9iwt7wzFb/vOt/mHblrc1lIgHyqn9rzT8r6z2no3hMhxno2DcS
 pONtLiKsIMU31tNBuZwuCeVqA34/zOy3KuRTlxkit8FYKYQWXxR
X-Received: by 2002:a05:6000:2902:b0:487:1100:48d0 with SMTP id
 ffacd0b85a97d-487110049a3mr12011723f8f.7.1789653796784; 
 Thu, 17 Sep 2026 07:03:16 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:03:16 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 18:02:30 +0400
Subject: [PATCH 09/11] sandbox: spl: Enable zstd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-fit-compression-v1-9-7985ac56ee9e@flipper.net>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
In-Reply-To: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=688; i=alchark@flipper.net;
 h=from:subject:message-id; bh=sDUqwK+w6nEsd1ey+CV80G3RQLE2J+Uwfzuh2f9qZAo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vR71i+PnDzP46b1k/9XXOlXzFxU+fH7FNcPnROrI
 mZ7FZtwd0xkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDV9W4M/1NeLjgrd09Ye2VpylWnGZEtT6VO10xcwdgSpb0h9mHhh2RGhm8uGY9
 rNDfOu1/jFRjxYbf++mte7jUn2j4+u1F2Yp1pORsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Nothing in the tree had SPL_ZSTD set, so nothing noticed that it could
not link. Turn it on where the SPL FIT loader is exercised, so a build
says so next time.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/sandbox_spl_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index bec02ce7bb1b..135edd41835c 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -230,6 +230,7 @@ CONFIG_RSA_VERIFY_WITH_PKEY=y
 CONFIG_TPM=y
 CONFIG_ZSTD=y
 CONFIG_SPL_LZMA=y
+CONFIG_SPL_ZSTD=y
 CONFIG_ERRNO_STR=y
 CONFIG_SPL_HEXDUMP=y
 CONFIG_SPL_LMB=y

-- 
2.55.0

