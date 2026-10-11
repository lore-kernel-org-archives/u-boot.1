Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65736CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 17:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7CAF60629;
	Sun, 11 Oct 2026 17:23:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ovsWtnwt60O; Sun, 11 Oct 2026 17:23:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DEDE4605FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791739389;
	b=HhH7eGWY3pjIIDkIZQPW+i17Eqp02Srr0az6l7I26Pdz9JyWpr+Aob+i1OVCgApVOY+A
	 iEXc7JbFXpaCsjFmxyysF4quWMUkDAgTedlU6PVP46JtmkTG570qktSiPGRxrGSBLblSs
	 h0WFa6gktlYmQwgGqkofN5Bxdjrzs2s0aq9U6hGcLJH0aMoETZC2DSR0m26mujCx9VfEe
	 sMHpLcfB2HoxDGk1GhNaQrqnwAhpGcMpdO0JktFNXSTl4o/VbCgCrxHMiiVPzAQ1TG9SL
	 9EKof5KabzxiC9ttR25Zzactqim27ULUClYlkMZ6aXif0nI8cbNGBHuHZAf5LSxSVEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791739389;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2pCn07C9QDMVUml8Zpf9VhvilmaKXP6BEI1VHhFQs48=;
	b=O7kTJBJnPGpXDFU7n6sAXtMFrCS1QttdLJ5oWqQ0a0TiM+iG+AjJWLCvWG6alR49dStH
	 YA8HpcwlBIPyZEQNbnVBEo0lYkPsbmIhKGUkfTEuFmXEjimkx4uyOW15PS0DRjFKJ+ILZ
	 gOdRxoTt4bCOOK3A/i3Y43CRrLIfbxC4DBgPEyGCLt16d1IbNU6dOSE5AYwYjU1bUepi4
	 16RonQkuhKOux8F7tZDKhZGpCHwgVaEBLG5GdlPiTaSRz4gAdIkKFDxJBRR3StAZiGi8n
	 mmXOx155Pc5mqnZL/AhawOlOJhLXOz/D6RzjMdkR2JboZBbNxweysL113IUPPb+3NnA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791739389;
	bh=2pCn07C9QDMVUml8Zpf9VhvilmaKXP6BEI1VHhFQs48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D468fSSTPDYQGC0VHynNTNTu77AX+t/N4ePsbBTW4vp6HYAXLUftmtwzGgKqM6rsS
	 +OrAWkTvecvH1QNFAsTGDz127tszUhg9hhHM3uYL5qDMfLgww1JC5jTEnnF0EGBXUn
	 9SZswv2C/c+DQ4gLKzJNJwFXH6ViHoeLqulpm2WOEvDHgVS8KKJU+YUAL2nliwEhf8
	 AbVU38pm8g2zC4s8DbwtHJFJ7MfKgwD5geVIGAwES0LKscGPXDh0d2kScF2DFelNYr
	 pkYo8tBuz70Gy2yymQzDyoHw6U+Dp/OHa1tp+7+jDXp+r/5ZhcXreLveI652Q66kqm
	 m5mYElVbDrbUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEDE4605FD;
	Sun, 11 Oct 2026 17:23:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E2CB194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FF4D80CDF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w17PHehdR-Mm for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 15:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 477BF80CDC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791732185;
 b=mwKrWFM38G89PLz08oxqDkK5qzhKfgUwtcohOB8JRuOR+AxxC7RCPMD48Drdjysxp4Fx
 mVyJmyL9ACCmHXpDSR1BjxMcV/zWy3H6oP20lB7/O5a4jp1ekqUnqu+tt+HcnLP9NtHGS
 EOXQLEgF9X2Atx3yjbBlZjM5iIuFIMucosWt1SyLjh/mRWEilOTHDTSfDZ2py++dcwvF6
 DvNu8aAlGAlTNPYI7os5DC1G88u8aFMMu6kgx3yMB4g8hHdUGfBg7w9ZDKq9Oke0NIsCR
 LnwpucYSSj5pTje1ZrzVMXNK9WiZ+xV68BwqiN1HvFFk4hij/wfKvBUQhqeQSNarxsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791732185;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=2pCn07C9QDMVUml8Zpf9VhvilmaKXP6BEI1VHhFQs48=;
 b=IJoadAGHbMz4gTgjaPG/05NXu/lb0/NMlpXS0pvBZfOKuuwafpIM5NBJWIQfirH30jgM
 gDEz+uCN04KLpStEZo8JPKS40F2Q4oMbU0SnWP65TN2fNvZXFAEyGcYhH0zBcgUnEi4Vb
 AneDrisqDmPgjsKlKLKhMcceH/+Ou5TEL3mDFY6hjF3Tmg4bh1ZcJpo6J8ZbsUa2Vd0lr
 pY39JJvkNVRrifFLmM9Lp2VckBiPgaTWbKReicnhIwy1gI6xBM0NhBClqTOA1WKCNS4mq
 BfAEUI/HJwWDtcr3Kf9Mq7idTuT12EqT2xh+c1wv1k/PSMDxn0jFTLAN74ltOF2POdw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=Jak4ir6M; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Jak4ir6M
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 477BF80CDC
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:04 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 24D403F197
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791732183;
 bh=2pCn07C9QDMVUml8Zpf9VhvilmaKXP6BEI1VHhFQs48=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Jak4ir6MszA2t9pfIczcZwAWfFJ3DYjMyCl6snESb6adpHF21KqKyNvt3mHVt0jxW
 pVQNQBbVvaReW3ml8WAbDrNBLmiQ26Lm9lPx59C4YBpyI7N3QnrOa82Q6TMv3Y18v/
 0b9SvZa0vN3aglSMxdCisbPaPnYh1lze7M0ANKmIBa8lvh6n0aGmga5k0oJx/YGfmi
 MR3nc3AWxvHgc/GpKFaYGYEwJ3GJ+PTE4WYh3C+jAKGlUmmyYOJ5G6gkMnadSx+9N/
 G9HEZ1LQcejFTXjNhkGXklFv9vUuKNBG990i1nQg4nmBAuMkeC1VSTLcXYOn4cLzL5
 9vUjADpJUdI8nCj91/rCT8PxVhf6t78vRPoJDvsA09he3fibHqf8/LZzhBbrIL9wKN
 eKi+/1TKy1DDtbYUKdHvd4lqBVN2m2uh0bgot+6FXCB2JubnAwYGbgjuky1FjsW2iQ
 NChKGhIy6dhOrnTKP8gUgxNc4plXFROSS395RdMBlUygdjC/yjK/u0LDFgsugiC8Oc
 psqpRwu1qllAyh6iNPDhO4JEe9aJU3UHx27I1fJdfvkpeF+HJ6/Em9ZokF+RpRpUG3
 mx+y8vzQCEg8jrzJNwcenjQ0oHyYDTifUMrEJDnhDIH3FSqo0AtoPwwVH4SYccR3jn
 yTVt1NtPk5yAZY4r/lSzY9do=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d9057fab9eso17421385ad.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791732181; x=1792336981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2pCn07C9QDMVUml8Zpf9VhvilmaKXP6BEI1VHhFQs48=;
 b=Xzk8ctuj1+d8VtZdeHtIRlFQURC09h2ncO0pD9SSQ4wa+dut3nCafO4oduvHe+6ohh
 sZMtE8NzdYubtVRqLXUtFkBsrUrzR2Lqo8+DlTqCQ7Tt7EIDx0PlFSRUXHq1UheRWnvb
 08I+XRWQbv+sMRUxwLYoQKbqGrn9QPpMYblL1QfKexNx2zfgLe5aFuPrt63YGCdY1bEU
 7V0IZiIy1thAocneLzmKv6uHvF0kjc/i1EAyGyUX9s/OKbQuQ3j4D+PpS9HSbgoaDLeb
 wX/L/1erddK1s6S97IBo1oN76tqXO6JOaTmQnlMPtFAj1uaUizcfsXv8W9ADOiebzVMB
 mlXw==
X-Gm-Message-State: AFq9FYIQaFBsUb44hD8/vZPvgEOLnjJc9+PVm/TGxVi28THkLL3IifPg
 2xpANcDVZTOjQlqrtAM2xlud08152Pz19itCf0LA8DsjZg+UcI7iaPxozx8xNwgACfCRP2+01UX
 nWaG3AKBlPFX+nSj4W9hGjQUfiacDO2SkWUmS1yUrjQoXtkTpmk8aDobANhojVFWU6EdFEHj0br
 KfU67CxGoeiUutvNsSsA==
X-Gm-Gg: AYBFou2z5EYfgRqc6S8reArUoi3Y5CyWMGpYfV9RVrNSLNC0Ukw0fEGoqlM748Jy3ar
 Udl+wX3qJDNQXlqM/JuAsEqBIBFNNB25RulEikzazt8pECAeb/wYphpXP2H0BnMmDgcvnMdCNSj
 niIGTjQBzar+VhwXUKSyFcSJsrVZW+OkZO1i4QQmjB9aFwvnUmvpbM1ZKGu2do2bg/9NnWEoxJY
 EOBe1uFQ4IF2yGksOKBez31G07mwvP06+KfFJXFCI3O89lJBOqRYhuYyvJDDgtRUjxeIMluvVqZ
 Pn/wbG3fHOXLbXuWLToRz3QTbW2W3jOC1LeIXztY1lhwNrax5HL0rFqZdSjf5A8IfoDLlEjYqQq
 P2Rph/As/rP8aMlOlF++GopBbEYSSaZJRGxcEzaZ/QdyUSs17QSLlIFvrEYVaMoqTb5dcQw==
X-Received: by 2002:a17:902:f789:b0:2e2:e61d:85ec with SMTP id
 d9443c01a7336-2e842f34e0cmr58282485ad.54.1791732181592; 
 Sun, 11 Oct 2026 08:23:01 -0700 (PDT)
X-Received: by 2002:a17:902:f789:b0:2e2:e61d:85ec with SMTP id
 d9443c01a7336-2e842f34e0cmr58282305ad.54.1791732181199; 
 Sun, 11 Oct 2026 08:23:01 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b5fd2sm33300445ad.50.2026.10.11.08.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 08:23:00 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Igor Grinberg <grinberg@compulab.co.il>,
 "tomas.melin@vaisala.com" <tomas.melin@vaisala.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v1 2/5] image-fit: check the length of the external data
 properties
Date: Sun, 11 Oct 2026 15:21:14 +0000
Message-ID: <20261011152235.8842-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011152235.8842-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 Oct 2026 17:23:03 +0000
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

fit_image_get_data_offset(), fit_image_get_data_position() and
fit_image_get_data_size() pass NULL as fdt_getprop()'s length argument,
so they accept a property of any size and then dereference the first
four bytes of it. A property shorter than that is read past its end, and
the bytes that follow it in the FIT are returned to the caller. An empty
data-size, for example, is read as the structure tag that follows it, a
small number such as 2 or 3, and selects a few bytes of the external
data instead of failing.

Ask for the length and require it to be exactly one fdt32_t, as
commit c2b8eefd4e10 ("image-fit: check the length of the
data-size-unciphered property") does for data-size-unciphered. Every
caller already checks the return value and handles a failure like a
missing property.

Fixes: db1b79b886f0 ("splash: add support for loading splash from a FIT image")
Fixes: a1be94b65410 ("SPL: Add FIT data-position property support")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/image-fit.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index e173108033b..0dc4d7840eb 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -963,15 +963,20 @@ int fit_image_get_emb_data(const void *fit, int noffset, const void **data,
  * returns:
  *     0, on success
  *     -ENOENT if the property could not be found
+ *     -EINVAL if the property is not exactly one fdt32_t long
  */
 int fit_image_get_data_offset(const void *fit, int noffset, u32 *data_offset)
 {
 	const fdt32_t *val;
+	int len;
 
-	val = fdt_getprop(fit, noffset, FIT_DATA_OFFSET_PROP, NULL);
+	val = fdt_getprop(fit, noffset, FIT_DATA_OFFSET_PROP, &len);
 	if (!val)
 		return -ENOENT;
 
+	if (len != sizeof(*val))
+		return -EINVAL;
+
 	*data_offset = fdt32_to_cpu(*val);
 
 	return 0;
@@ -987,16 +992,21 @@ int fit_image_get_data_offset(const void *fit, int noffset, u32 *data_offset)
  * returns:
  *     0, on success
  *     -ENOENT if the property could not be found
+ *     -EINVAL if the property is not exactly one fdt32_t long
  */
 int fit_image_get_data_position(const void *fit, int noffset,
 				u32 *data_position)
 {
 	const fdt32_t *val;
+	int len;
 
-	val = fdt_getprop(fit, noffset, FIT_DATA_POSITION_PROP, NULL);
+	val = fdt_getprop(fit, noffset, FIT_DATA_POSITION_PROP, &len);
 	if (!val)
 		return -ENOENT;
 
+	if (len != sizeof(*val))
+		return -EINVAL;
+
 	*data_position = fdt32_to_cpu(*val);
 
 	return 0;
@@ -1012,15 +1022,20 @@ int fit_image_get_data_position(const void *fit, int noffset,
  * returns:
  *     0, on success
  *     -ENOENT if the property could not be found
+ *     -EINVAL if the property is not exactly one fdt32_t long
  */
 int fit_image_get_data_size(const void *fit, int noffset, u32 *data_size)
 {
 	const fdt32_t *val;
+	int len;
 
-	val = fdt_getprop(fit, noffset, FIT_DATA_SIZE_PROP, NULL);
+	val = fdt_getprop(fit, noffset, FIT_DATA_SIZE_PROP, &len);
 	if (!val)
 		return -ENOENT;
 
+	if (len != sizeof(*val))
+		return -EINVAL;
+
 	*data_size = fdt32_to_cpu(*val);
 
 	return 0;
-- 
2.43.0

