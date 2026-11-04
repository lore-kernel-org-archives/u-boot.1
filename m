Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1339A606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JjjfyKDQ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sw+1Or1V
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D83F34076B;
	Wed,  4 Nov 2026 10:38:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jTAvblqKronU; Wed,  4 Nov 2026 10:38:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E1ECA40726
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793788721;
	b=jfSPsAURyoN+EAAHbOqit/gHN4mHZPJe7VNTyHr0HyxFvZ7f18Aa12Q6iggcL0kwUipe
	 nto5txpUYNoKdY0hBc3EHzCmo+YbgSLHwOZ6JUX9ZYwZhVbMgwmrow5Al6yjIgjxFh2rL
	 PNAXLXJkZLIvKjSqp74OqupZ6UquvjTpqT+70Al2lD2HST+ddY83iRZx3pIYoUPNnADG9
	 dHPxCAXcr2F8UgljCayGbzyqWitCfqte9uFKfY0uiercuiJq3uot8cdLehPPloMvmJBk6
	 1KnB+hCzdHPvcrQ3QAJsoOOe1bCAwQ0INBwqtmH9II9rFosgxwFwLKEtUosuxU3lvUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793788721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UsYIVmLlAEddd6XXATHnxWcBoYZKDXYpBcwSnJCWNUw=;
	b=rBlQWc0DzvR3MsWm+08v9EOTU1R1XKoT5EsnQVtgb0AtvdavDVylfOSK6TjPFM8RInOW
	 of3VIcZGfRJ6d1/fmavsAB2Guv69nwpSRc6w4pEpyzM/ThRlW2Tgu/dFmxy9/+vJqpQAB
	 LLP6lWvXDU7gmT1g+9OgHKTQ4Sq/T6Nq5jUjcK1pD3dHqv++4GAHUklWSH2Na/S89C1Pu
	 KqPfPjxM2J6j2xcFBiN7332AQj6i1HkLveRpmlPQimx07CrNMLd4p+Kv5W5/7Zs3PgGFk
	 Se1R3fxWlEZ1wnYdbFi1nAnZAKRTgTWYgTebyZ5Z/j6ekOfXxm3mKV8pTjUg3orgIEg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793788721;
	bh=UsYIVmLlAEddd6XXATHnxWcBoYZKDXYpBcwSnJCWNUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JjjfyKDQ8gv+Ukkz/7/6A0u5WhSewuA3HMxXQ5itDgabyS1rAtsPaN8y6cirZ21eJ
	 N9iLBBQfFR70+TWVVWQQ3W8T4W0nPDt+JkQvnG1V4q2FoSh3oJ3RnNzKSXO1P9WVdh
	 kBNA3Z76die9X8kRSnefuzjE64vOJfxFdPiDVAZf3ltoHl9XFpfaZr2zPFWcn9BH9u
	 s3n470uJsiaGgLDNrs4RZk9OyWTVbL4FHdL1ECKQBUclXpVSm2+MybYzO3m2khWInS
	 en4wjQMcQwpUCRRVuWWfRtHmWABhXUys2MfVKdyEPsa0Bnd7GUUhDrP+Byu/C6ExnR
	 pCALGdYHfMn5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1ECA40726;
	Wed,  4 Nov 2026 10:38:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DFB86411
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C58FB60755
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:38:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2G9cANh3hdoa for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:38:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8FA3606D3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793788719;
 b=JEpsRy638srbxiskfscEEQuy1iW+71yJAhTrDZb3YArpPpts685j9di8IZHx/MXg+30D
 JzIvGzcvZMhDA6gn7u4WY4kQM3OzKlEkeX/pwn7+8MuoAasGgi8ITXurnoQD/nmsXlgvt
 65qhkCu/JhmKYtRFpcOg9C8N9QcHPl5JbbchhGocX9RF7DmZZiTl22t0k1iTzp4eAmEL5
 N8rz9QUWDQ5QtfwuQzFI0MTLFeU7/dI/PADMwW8Pg1I1cWOnxhxlcgkBUhoZTKslRosiE
 hNZZfeZwHo16lUizhhWWYIG1H7qGcgVJg5g4e9cEtaRssZzCrWGGWNlEngCEZfThMuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793788719;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=UsYIVmLlAEddd6XXATHnxWcBoYZKDXYpBcwSnJCWNUw=;
 b=lAqrB37iIesMIye7ppZ3u+IresQnA53T4uLSNLK846RVL2rYL11VL2sC5SCuf7v2HbJh
 JJBAGgfZSXtnJECYwAb/WgbZW9XM//QlHnfFUJmc+hscv+IsgfN8nkvwDIFGTIjxK6tDh
 W7oZ9EkK6PHrEs4Z2DHS4cQf7k5vBQdopeilALfc3KabDuKuaEBDAf7wnyw1LMM3gTf4+
 Tm4NFc8TAX0Wc1WkKXMU8JtWFi/D1eqLUes/gw57hCb6qFCZYgy51d7/tYSRlqyVTw5n+
 EVUujZpWRIygop5hoYfS82IZ3bQF0GvsmNp6KII+KCII1dQBDY+bIzKGAaFLQ8ZO6nQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Sw+1Or1V; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=vinicius.eduardo.pedrosa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Sw+1Or1V
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8FA3606D3
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:38:38 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8ac9d666d4eso5685527b3.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 02:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793788717; x=1794393517;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UsYIVmLlAEddd6XXATHnxWcBoYZKDXYpBcwSnJCWNUw=;
 b=Sw+1Or1VKkgpNyvZUFTZsbCUIRGcivMduDtSoGAQyqVoz3XfTFJJX5zAiAY8MLVHZN
 ThzDSemKrFbWqaFvXgWJBVlqzqszmdKGgL5d0HdcotG6oUihPMyhq7f/VbkH1OsNo7z6
 bZBnzNzos/QUcpHPXFydpqhYY+nKTycJtmjb4Mx7NFTWTaEYhpEWcJB/ZbBCS/1S6aHz
 ylHJUfnq6r3bSU4laEE0sk0WcmKnxbagJ6MAek5p9dDEY3ZYcV7EyKEv/sSRt6xy/tsA
 AzBWl0dZVFkpp1g1iT/it7t7qGGZv9lSjcQcek21vO/tDM4eypKuTLA1GgHpiO7wloac
 0rWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793788717; x=1794393517;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UsYIVmLlAEddd6XXATHnxWcBoYZKDXYpBcwSnJCWNUw=;
 b=f8/6iODGDS720wYVB7ek80xkLmZDmDIwtdpbCuDNkHEbZ+4OheDQ8snR273PP/hqgB
 QYUlyH1XMjItoC/wPiK4lc3671Kkh/10HWSTo37VdBHPJ/eEpf3UHItfXDw9zNWZIL0v
 Ie2iZgD/wiyPUBGHZREjqVAVKqFqfYuP4DoPDtJJG/OR76F/uU+sX2sfkPbD60Y3v8O4
 JtFiEtb9aBXz+BWxShHTwvZNHkbL58fuFSf9654xKUymzz16CRjNPEpXtI1jY1NHhi4+
 6vUL6MdQPs17O45w+MynYMPiu63jJvUBvvHWJKUyGSD48DqBOqYk2Ue+7UgrVHSHP1k2
 J7mw==
X-Gm-Message-State: APuU4Z+ytp3X3xvC4rbTorNC1G8FUirlfDru4NZ13aq5iDjX7nlCaCK6
 heuUJA6xo3tizPHR9aCCAacBjVHzdvXIUpwHolPuyua7w9yNNvYDx5Q4bNVsLaJwmHw=
X-Gm-Gg: AYBFou1gQx2Khl2Gw96ujpWijb0/y6WHFS5tC8YDnkEag6vYhtyACnemdJIsdsyJuqr
 1Am7Zl4ngucrOC5ysg9RW7tajvGwAQWWHVvspK+q2mBL2zI/3ZSwblRsRdEieIwTSPTSC3Dn2m7
 p0uK4e9Dt08HvvS/D/74jV05d/zXJ7spghMvx6RJq9ktDZ9byMknIeQbsHus+aWEdAnoPQBRWu3
 1QwKLyDYyy9XFIPEby0oWbk2BxSSz6vWaEPP8Rpcc4JNDxDvvv15Oe6lXmioZao+HP3/4jG9GB2
 nYHH88nUEhnMS32FNlNhlxXTVz/w518c33UUn1NVsbQhqx34ke9g95ZFC7/+ZePIQ7YneNwJBVR
 6EazCKeJ+LVs8J95TgocKoSrxyoLxUqplL4AYh4Z0Ad6Ro0MQuoJ9x1mUvxEmo+JWol8ZIVqH5K
 ioODDlpGtb/Si1wzaiy5i6qcGHXDwfGk2afUlc6bewfRxXhwaI/4fLoQY/D5FsME6K1NGpUneJI
 nkdNhgB6dJRAr5eW1e9UfkA1CAY8w89AIMqxyQ/HRh9z2R2IIa3c6062TkTHjsLo2MuruNNdOLE
 lOu+F8qGZWdsOZRieNExpgAatCYNmDeWjvtNczPkHZLGv1bT6+xVnNuwsHO/Ouuh1ozFvOGKyRO
 Y0By2fT35NCRjHCe3KQMrgZ/SiTQVJqOneX0G
X-Received: by 2002:a05:690c:e254:20b0:8a8:6fac:217d with SMTP id
 00721157ae682-8b2b67ca9bfmr68433317b3.95.1793788717057; 
 Wed, 04 Nov 2026 02:38:37 -0800 (PST)
Received: from MaquinaLab.. ([179.179.238.247])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b309bb4406sm15210057b3.40.2026.11.04.02.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:38:36 -0800 (PST)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Subject: [PATCH v2] sunxi: a523: set up the PIO withstand voltage mode
Date: Wed,  4 Nov 2026 07:38:14 -0300
Message-ID: <20261104103814.8838-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <bae86d13-eaea-4dea-a67d-64b166fb3ddd@arm.com>
References: <bae86d13-eaea-4dea-a67d-64b166fb3ddd@arm.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the A523 the main PIO has the power mode registers at 0x380/0x388,
the R_PIO at 0x340/0x348 like the H6. The select encoding is inverted:
1 means 3.3V, while the value register still reads 1 for 1.8V, so a
plain copy at the new offsets would select the wrong mode. Linux fixed
the same in commit ef56085dfd1d ("pinctrl: sunxi: A523: fix voltage
withstand encoding").

Set the select bits from the inverted value bits. Only the per-port
bits are written; the VCC-IO bit and GPIO_POW_MS_CTL keep their reset
values. Also drop the misspelled NCAT2 guard, which never matched.

Link: https://lore.kernel.org/u-boot/20260723105705.3338923-1-fugininsane@googlemail.com/
Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
---
Changes in v2:
- Set up the A523 instead of enabling the copy on the R528 (Andre)
- Merge the two H6 blocks

Sören Hantel found the misspelled guard and posted the patch linked
above. This replaces it, at his request.

The offsets and the encoding are from the A523 user manual V1.4, the A527
manual V0.97 says the same.

Changing only the offsets is not enough because of the inverted select
bits, so the A523 gets its own branch.

Build-tested only, I don't have A523 hardware. In reproducible builds on
main ab4dc5aacf only the SPLs of the four A523 boards change (avaota-a1,
orangepi_4a, radxa-cubie-a5e, x96q_pro_plus). All other H6 and NCAT2
SPLs are byte-identical.

If someone with an A523 board can test it: at the U-Boot prompt,
"md.l 0x02000380 3" and "md.l 0x07022340 3". Within 0x77e (main PIO) and
0x3 (R_PIO), the first word (SEL) should be the inverse of the third (VAL).

 arch/arm/mach-sunxi/board.c | 19 ++++++++++++++-----
 include/sunxi_gpio.h        |  5 +++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 432b1c10f9..f517014873 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -198,15 +198,24 @@ static int gpio_init(void)
 	 * Update PIO power bias configuration by copying the hardware
 	 * detected value.
 	 */
-	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
-	    IS_ENABLED(CONFIG_SUN50I_GEN_NCAT2)) {
+	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6)) {
 		val = readl(SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_VAL);
-		/* TODO: A523: keep only the lower two bits? */
 		writel(val, SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_SEL);
-	}
-	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6)) {
 		val = readl(SUNXI_R_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_VAL);
 		writel(val, SUNXI_R_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_SEL);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN55I_A523)) {
+		/*
+		 * The main PIO has the registers at other offsets, and the
+		 * select encoding is inverted: a SEL bit of 1 means 3.3V.
+		 */
+		val = readl(SUNXI_PIO_BASE + SUN55I_A523_GPIO_POW_MOD_VAL);
+		clrsetbits_le32(SUNXI_PIO_BASE + SUN55I_A523_GPIO_POW_MOD_SEL,
+				SUN55I_A523_GPIO_POW_MOD_MASK,
+				~val & SUN55I_A523_GPIO_POW_MOD_MASK);
+		val = readl(SUNXI_R_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_VAL);
+		clrsetbits_le32(SUNXI_R_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_SEL,
+				SUN55I_A523_R_GPIO_POW_MOD_MASK,
+				~val & SUN55I_A523_R_GPIO_POW_MOD_MASK);
 	}
 
 	return 0;
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index 12b54c8dda..66aa2f1b32 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -63,6 +63,11 @@
 
 #define SUN50I_H6_GPIO_POW_MOD_SEL	0x340
 #define SUN50I_H6_GPIO_POW_MOD_VAL	0x348
+#define SUN55I_A523_GPIO_POW_MOD_SEL	0x380
+#define SUN55I_A523_GPIO_POW_MOD_VAL	0x388
+/* PB-PG and PI-PK in the main PIO, PL and PM in the R_PIO */
+#define SUN55I_A523_GPIO_POW_MOD_MASK	(GENMASK(10, 8) | GENMASK(6, 1))
+#define SUN55I_A523_R_GPIO_POW_MOD_MASK	GENMASK(1, 0)
 
 #define SUNXI_GPIOS_PER_BANK	32
 
-- 
2.43.0

