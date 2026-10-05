Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AE2CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 21:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FDEA80A47;
	Mon,  5 Oct 2026 21:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BeRNwUbIC50R; Mon,  5 Oct 2026 21:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DA4BE809CE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791236752;
	b=OJ4L6gTaHf7E4C2mVg77S/QUNhKn6LA0Wuzk7ZbPot2aizJ0Xtx/wHzeMFgql5nzgwpl
	 tOlc7aC1auKyeyDBA/8vcCYV2ov7yL5azZn27k8iZ2p0tuPamIQ+27QX1OKhkhU+VP5dP
	 bl7N0T2TLcK6hNFAiwrq6OxLlf2zdKcZhZKgirdlAzhaqDCbtH1q1lp3GuPZMKHaFjDNJ
	 QqCrt9bHll/L4LEHWMNdv3FNyPYncwY6q0OgMzm2kQTnVdVa+rvYXdLT1tJd+FOqTavdo
	 Ut7Ko9Xs+Ya9cPXC/Da/0DA5Q7E8uFbWf1F/LjsEC4P+LnOtIkcrLSPzp6l0AkKLzFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791236752;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2/Uz9TVYofZ9ijN/BLxLEIxG8X3tDWk/4+OCVnZb93o=;
	b=A5/R5BuCZsRbtDhZ9MX5S2hmbQumJwBO5OZBaQ+N6eGFgfUMnPdYFA7HWIxnyiRLyq2p
	 HpuhyMZfc0DWXplUM5nxgbRYTjyz7r7xFetaRhdil/uBPkCdeBIHLXGpVEF23PaIx0ok0
	 KlvwtrbiuGXZJG65LzAxddUCJB3gNaBK7xCAOOj0mnrcUakSEpEXMAAvFfP/mgneveCd7
	 iiMofvH+vqaYREv/rq3UgMeuBqizv9d0agd0s9s1G/ymKM8K7xtb8R0l5BObmpCtLTBBL
	 2s2zgg66ywH14hkM5AmYES3HWNr8WkAZOufx+/goP+WATwO+hfrMKHRAC79v15jyMTA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791236752;
	bh=2/Uz9TVYofZ9ijN/BLxLEIxG8X3tDWk/4+OCVnZb93o=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fN5rBT4GlB7Gt2Pn2zpkKT2/n5itlUx0yuhdiE5HCWEu1ENUeE/VrjVIoJa4rUoCE
	 Vwqt9Q3J9FxXXkdi9y/vDtyiTRZN1tnJkdfBYpz7YKBDyQMymDXEF/FP+ENJSgBOn/
	 tSos2CWHi3VmMQ5u7uemGcYthSFxM6Gf9F8FGth2Yd7aSCZC2KIZCIXiK0RuONYM6r
	 e1fidO5+Qs1JsA3cLE8rTiXsTVbSRi889EZ2hvwnNkxt6zzcQflDKFlk7BmkSom6X9
	 xGIHsnJlFX2dKql7OPwfjY6JIX+DCh0QJ92J2V9fRWbNSORb/hXLOXXymhRofRnuJR
	 ov/gpFnYpNVUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA4BE809CE;
	Mon,  5 Oct 2026 21:45:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 422C5338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3335760709
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:33:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5shmdIv7tej for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 21:33:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1416E6069E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791236015;
 b=Fsaf11LjQ2yWXB8QCxSBKy7R1KTNqnCgj1XV7SpFoCQXQGtIvcEswQ/oIHMHQ/ELgri/
 tPAKB5Nw3fbt678E9UdeaZHP8Kkaq20WPDULEjBeDf1uBv4I0RXsMrRxi/DxZbGzL7yIe
 wNPuh7V4tp+Zz9cGnPLdswYWIqfj7bAU2Ps5ml7OeIugg4uNVhprdKeOaQDkmTeanHMOB
 atI5gKFWZRhg1ebdA8u+TnqxcDKUj/Y7eviGxQrOc99wbNxIQijlQauFMT2is8LEd1yjC
 9rGtWmTwdbC0kplH5DeE6qe/tPu3P3DGyjdt2esjGiI4TsbOZ8c4gRLB4PzHWMCtXgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791236015;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=2/Uz9TVYofZ9ijN/BLxLEIxG8X3tDWk/4+OCVnZb93o=;
 b=pnUUgdbhYCJdCLDdjJhpMPwifW0N2OwAV6UPZv6p9cD1u9d4HxcS63LAQdKvdfMo2wkj
 RGvMSMi+XlM5VF0Omnv0xa06eS/+OL42lCH/MprsDmqbnq06rnY1B0XnqITZobeVGyPpA
 m9C6Bl6+bkfsWWZElRYhC7BQPSLv/eRCKjqV0eFSs0xWwf99RGdLwUIG53xRIl5WZeHpj
 PYoXElUJ1CG/T6DZvvK2wEnrQ2qNegYQ57JnT1SJc4/j16T64KeE0JwWKhidvxRj/FHNO
 RkcA1AwgOseRNGshAvnTg2F3aaROmx3XwfmrvrtvQlrRkTEo1hdwTFvUxPYqdVS4kRA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=e9rGPBth; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=e9rGPBth
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1416E6069E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:33:33 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 46e09a7af769-8238df7d78dso1375438a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791236012; x=1791840812;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2/Uz9TVYofZ9ijN/BLxLEIxG8X3tDWk/4+OCVnZb93o=;
 b=e9rGPBth7s+Uc8oXI+0IjoLRDyFms3//qxrNWymbLVU2p1ohTa2hi+xKZCAqw7b+8g
 3Bh271F0dvoRWHu591UwIyldxI6sC2fWZJoKq5d4U2hB0qGyXKh70nRnSZn+OFiywxxD
 2xNVYNHYcjplg71PPN42cwL3yN0nBnX/ig2FcVMRRBI+5rjFuhO7YOEQ9KQKT7Ceb0NG
 ZPX3CtZjSqFH2mWX4E8s3fUiD0IxS4AkQ2e14mZiIEiuXVJtMGHUQXjSyG+FD3Op508t
 Z2pEEJVetysGSKeLLaKns1UV5QQUtKPLKaf7St7qLphyp8TXLaVVG1P8x7QlA6Q7B+3P
 YApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791236012; x=1791840812;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2/Uz9TVYofZ9ijN/BLxLEIxG8X3tDWk/4+OCVnZb93o=;
 b=JMcWrtCY7oQFdo6c5JQF4GnpO691ggAclmUUVukfIFxMxHyIXfOBsbppeaJQYqqt5n
 n1aInBkR8k2u2LRgMVOBrZTvO2hIg95QE6ocWGMK82wPw78O8qJ2XIX2XTd6rQ7g+cFi
 z9Cwqf1eYrvVqcfacrGG8goX7ZaCV4BpSPPY0Lpp+jLoJYjkTwK88Cm2FckHcs8GsQr0
 RW4Ul6czuPdJX7Z0IEyYBMGB4pT8c8tfd/z89PMFbQVTRuSq/rXLomUepVUKA25FNW+i
 k1fhVGpyRY7p31u1UaWvMoEXOkAriY+TeTZ1Bm0P6ETbbVy1TdbvS+olJfVeSc5PMu2o
 Q2lw==
X-Gm-Message-State: AFuF++njrlOcwzUVfdFLNm/KPk934ugwc8fHdIBVjf9moU5ivIDXJRkO
 qiVEpq2gpT6/v8y5NlK0nUnuJT2puvcMNkUWReboCpGUVVv+L8chb+FQDV5bxrwsQts=
X-Gm-Gg: AYBFou0ZlR65UOqpL0mxBuLzq4ncaUrmnue0jPaG6cWzHk7Vo/WMBynKC5nIrhnzvcC
 zBlim9XUXD7QtrGdssi//PebpX3F919wvyrNulJBlhK5qMkn5o80jmnktFUdByLQIeigR85LVIM
 +FeYbuTJzzBY5aBdurymhDRsEbHBmbemfnstJ+O05BYifgRSTnBDr1ya0E6bFkpsTCNgWnjurxe
 eq2adZjpBl9Pg8pEzdvWAnt9WfCdXsNBN8QV1V5fKT1dJBDb/jnl7iMCEE/aWmSaQPnoIBxREZ8
 ENJRXaB3qCgCjlfL5orLKVMY2EW/sACk3ZiX6HaSEUl7roUaobKioRNI7RBWs3Z0TVk5vaVPClK
 nPa1QalAEQMcGgbp3shZmZTa16tkWKq2QB8vzmnfphXoOs3E+/ol0OlE4oWPP+7ams23/Y44ZeP
 WqR4vUBFfQxjvdrDIvB7Qm3B82noP1oedyOXY2e5J2ZLsOx5K8L3fXAGadfHNJl9bDmYS4bvOcI
 2s=
X-Received: by 2002:a05:6820:c8e:b0:6dd:d8be:118f with SMTP id
 006d021491bc7-6df34e699e2mr9381151eaf.64.1791236012472; 
 Mon, 05 Oct 2026 14:33:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e4c366ad5bsm483838eaf.10.2026.10.05.14.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 14:33:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Oct 2026 16:33:20 -0500
Subject: [PATCH] power: pmic: mtk-pwrap: add mt8366 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-mtk-pwrap-mt8366-v1-1-db6b3d29ce17@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwNT3dySbN2C8qLEAiDLwtjMTNck1SzFPNHC0izR0EQJqK2gKDUtswJ
 sZHQshF9cmpSVmlwCMkepthYAesGuX3QAAAA=
X-Change-ID: 20261005-mtk-pwrap-mt8366-4e6d7a896a14
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=jg2qQx4syFzCEWtDWod8tE5ulaZQPgp4ScLRMCSA0Uc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxBehmL1LYRvkZQVDMDZseJZUcmj5mPcrV6oG1
 ojZcbrNVnyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasQXoRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiUMH/0HmfpV6KWYvZJdo61SATOHhvp0cPi9h4LQi3zr
 iP7XqZFGvZzTapLs02M+Pdr5vJdefRrG7aPox4CQ55YfjquJ1goxtxiyAx6kR1Pnz+Fa+cxr6TS
 0Lq73SwgwvSOAk1HLpy1oBHuMwwJoKM04Te9IBySL6zigf4Lm+7hhFKMH+k9TVwv1+YNagsmgXH
 RZr1NOlct9gXS4/Wp6/U2nSLnX6Yv54zJxuWu/XOCUw8/JXuoJc0Wemgt6JoDUm9JTpF+G8r0PX
 lr8eL3+o0xQhe1HcaWy9xqVyavO6MLrRkfX32ENSeSTomFGM6XB/+FKWaltWIF0DKOZ9pE5sg15
 4zIc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a match for the MT8366 pwrap. It shares the MT8195 register map
for everything this driver uses; only the interrupt enable register
differs (INT_EN is at 0x450 and there is no INT1 block), and U-Boot
does not program the pwrap interrupts. Reuse the MT8195 data rather
than give the device tree an mt8195 fallback compatible that would be
wrong for an OS that does enable them.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
The Genio 360 EVK series (v6) drops the mediatek,mt8195-pwrap fallback
from the MT8366 devicetree and depends on this patch for the pwrap to
keep binding.
---
 drivers/power/pmic/mtk-pwrap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index f23061de386..468af1fba04 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -887,6 +887,7 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
 static const struct udevice_id mtk_pwrap_ids[] = {
 	{ .compatible = "mediatek,mt8195-pwrap", .data = (ulong)&pwrap_mt8195 },
 	{ .compatible = "mediatek,mt8365-pwrap", .data = (ulong)&pwrap_mt8365 },
+	{ .compatible = "mediatek,mt8366-pwrap", .data = (ulong)&pwrap_mt8195 },
 	{ }
 };
 

---
base-commit: bd2f5794b7e24c62042abb1921f9c2039b920e02
change-id: 20261005-mtk-pwrap-mt8366-4e6d7a896a14

Best regards,
--  
David Lechner <dlechner@baylibre.com>

