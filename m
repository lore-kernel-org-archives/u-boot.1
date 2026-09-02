Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0682EC624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 21:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D81860648;
	Wed,  2 Sep 2026 21:58:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AY8wziWtViID; Wed,  2 Sep 2026 21:58:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B2D7D6067E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788386335;
	b=ZTLm2CtVLJ1RMDUi2tIVy35vwHoP4d/Kk9ahPsI8DZR+3CzfOuqlhpCuNH4GbRU2IVxo
	 DIMbAvOb+W0GpSANoaFjdgR1hJBTApuXzBGZd4+Q6UTtQg6XBIxd1h4gXXy9OoXE4S1ae
	 RQ+2FGzzuvci366YLZt0gXyy28Y85wha/j2+BkLcWX5h/2yOSYZNkMb72AA22ErPqSpYj
	 qvvYoK2jJmsF65ERaBi2PaF6Pj8DZhWCUswt57caMNJyEh4IVDZy1qXPuI6mu4wwCb18T
	 IUxsQyRVxrwzT1zXC5t50NedRYeLG6AdnVxvDBWXFA8fuRiryQb5adf1PD6m6+aojdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788386335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q4zjcQFVj1VAr0gdvOmHUg8drUtFGAPWM4bPn0Ame1o=;
	b=EnOnVcXskltZ6Vutt8MIEVOLxk2MHsqriut4n2tr74Zv7BCTtR/dg12xQbao3l87wH5G
	 C7SWPzsmYMqDR6nulwZtX0eqA+lXgjEB2gLvFI3EfMydkWaYXWH5lAl07ITlPHjZAcj8g
	 EpKzfhFsD0paen2v/MnD8FXaL9iKahLyIHu/Mk33TevM0vxpSSVDBGmr/2ZqXEiekCFzW
	 wwaq/iD3VVxmuTt45MJTTFp87UMnX1/+SBp20FJDdiwxQ7N/7XOUU18XumIuT1j9aX+47
	 Fz0pl3EjxkXf9oa2hBg59jCiVWq06bDCAb5kxnE/E4tI6nVpyjcdaWGgXhlQpW3/M7g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=binarly.io;
	dkim=pass header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256 header.s=google header.b=crPu8xnd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788386335;
	bh=q4zjcQFVj1VAr0gdvOmHUg8drUtFGAPWM4bPn0Ame1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SEPsNf5TxXrnH2jlSQgwN91R0MIyHSV6+ifvwGrtzekfVFmp9RvXecWUlNJSm2XzT
	 bTRWahArMziVHOBNFLThYnkPZTb0GH+juZZAWcnvU6aqj6hbkvEPZcnb9Xh9GuBIpr
	 gBa/D9wbdnI9jpo4pm4JCkOHo+93iH0U1Zl877lB01fQPLezwXTVNuOykkgakD8xo1
	 MeBIYheR7V9rbmrXzprg29o6yMmy7yD6UNprBFen6+CTU7Z6Rj1lH8gAmtN1WSnAq/
	 x+aXphYUqaDrK8UO0L7IZpf7rBitGl5Qx7J7FPwnfjvcJm6kcubiw7AJg5d6x62nHJ
	 vqgMgaz420edA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2D7D6067E;
	Wed,  2 Sep 2026 21:58:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BF902FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E0436069C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1Zh-aVeAA_x for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 21:23:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 22F1160679
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788384231;
 b=nHPjJeulkFaRK/eHNIXn1S/ONk8fC9gQ9+/1Gy8yi2dZbS8Zgyb2l/NvbRzeTz0yRbOT
 c57ryt+Q/EURNlDjAMjX7+Kl6RwEiiuwOWROC61xnMGi2QKXUxONPZC5rwngMKUQzKZs/
 pENr2ME1NpbCr1F/Tqi8EsDNlW8EIblhElEPN0vrcEoCnsS9mtxjayLo3FInecECqvRAL
 NLJFKOyZL2IRJ8fTXzVAEpDut3oVXC+I3cj0fyT2eVmRKXcjR/ClJUPwClqoSc4O9YfkV
 8l6+ofGCTbrz2eg3GCjZPUn1godxaKs2+nbiQAcDQM8m7deHLGyrDx7ALNzzBU3hmmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788384231;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=q4zjcQFVj1VAr0gdvOmHUg8drUtFGAPWM4bPn0Ame1o=;
 b=CE8kEzJP+Ow+/rBp4GVO7wh4q35/WOf7SYqz1HFRA3rDWR0nQyOOppYjElsTaIA0sPMJ
 P7yfwGOxbT3JJh1ogBixeAx0G4HlipPiJZBY9dOQHrhnxRvtE+hkIN2SZ9/ZVauyyvL9K
 CA9X0ooxEAuFOTrLJEpqOZI8zK+T9wB/ikaDAnIRy9QKeMPBnzdJdHSMh8zFaQOO7tff1
 3yWb0MwIwwD91TlR19WPTUjSC4owdtbbJc0idxV5p18XyEFO5j4DuoYuyuRfo17eNG4xT
 aX6R2txot5Z3x44IA4caFcrFIOY0qqznp32pES7Qnys/A11d2X2vr63zHYfbAtNf2AQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=binarly.io; 
 dkim=pass header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=crPu8xnd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=crPu8xnd
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22F1160679
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:50 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-90cdebdfe63so9816276d6.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1788384229; x=1788989029;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q4zjcQFVj1VAr0gdvOmHUg8drUtFGAPWM4bPn0Ame1o=;
 b=crPu8xnd+lTde3jiN7c5F2Y8GDQB9t2GfJb4ATVHQJlmgX5jLXDAHt6l828RV6PqbG
 33cZtXu0LCTcQTnNNU2kgGXaDVHdCyHlx4DVjE+14krgR/ZldKmYricIVH9WoKAqZqaf
 dBolfUCVY9yY9bdh56hU8l8qjRMMTlWKZl5m/Nrb6XKZf6CsPLgjPpfaSOwaWX4XJUt7
 IgZWICVTKJTufmAuQx3k+YNAXlyxCF+Li5oSU4xTF411VlguZEke/KKAMUmBc8w9Kk8/
 zoQ/ukDIiUcj6Vxi8SsYIn+DqThMQeZf/ehmHD2AG0863V1XKwVD3qC/lYeJG4FJLeod
 fxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788384229; x=1788989029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q4zjcQFVj1VAr0gdvOmHUg8drUtFGAPWM4bPn0Ame1o=;
 b=LCj/uof4xFMmRX7edIZE1QE+7RR7OgEIQ/Ek/P51ldkkJRWE782TMtc0iuJ5jPTPC/
 K7CI6eJsOA1QDd9tjbwhVPR7olgEHT2pwqp+6DdY6Jn3XmlB4ViZWSDrj8/WmX0k/xje
 Cnl4aT/wMpjhaDxBUUv3lqeM5Mw83TZN8eOC1ZxJCkduH4RCGO8XYCM3GWhDVoZZnmhW
 bLIrBIpKJcqnq/p3Vo7TYrQZu41u0W96d8u7OaAZwJcbAO/gq3QIBmcxI27XhQRxqCZB
 FnvuUrEro+SZyDl9c8iOZY6fxCheNxwGcDL25Bj8VIboxnKmpGv31NglvXfnbjBxlGrN
 H6iA==
X-Gm-Message-State: AFuF++my4AwV9K/CcO4rWVGnwr2gvc4+T9zxWde08rNGnoOoJWZ/tytw
 5AIs9AIf30BRS2NSESIuDH40FIEhrnBOBjkLMGaK6Ow9yn0rcm4bVblQGe1P1I/Bucs=
X-Gm-Gg: AYBFou0/q2wRhbPhJJZ2jFTR0+5e3NEJNE2P8CYaCvLrygR7npD6G9CXIU5BpMywf5r
 /s7Go65JlC7+tCx4MgbBoND3yW2Tdmy9pErQOGCzprhG5EaXFLfXEuL/1sQL3kydvS/q374GB60
 gwFP75pa0s1mNpRwgRdQHUCg3vduHnAsrgdGrbxGule889x+sah1Z37uDz/f9FxXyU1mEUXimui
 1b0B+VNWa3tYmW/I1mYawzaAo8VKxpSSUNB7a90NW5McpLZl+1K2UrUXwoZzv70sOY3GUD+DEmV
 1bDAq4+oa6Aqsj99T3WQsUdZzCY8t7Me5ngJe+kH4ihtSHATXlz9WspYXEsi9btAH5ffCmXqz+2
 YI2uN3I1cbvDl5R8WKjUjtHztdd/s33kfQYdnh95DWDErOQSXiIZpKTEluXDBb173V/kzMZAlAb
 ntTf1RB5xYeg3P1dTGbouHfqbLplr8wc0yA9veJAgNqESllAUJcfsUHzxsC8wKpdvhNEfFmfw+c
 7fg93KeOPE/hULOpHR+2W9j/pdj
X-Received: by 2002:a05:620a:172b:b0:939:ca8:21c8 with SMTP id
 af79cd13be357-93960f57ed5mr933037185a.29.1788384229154; 
 Wed, 02 Sep 2026 14:23:49 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm19948755e9.13.2026.09.02.14.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 14:23:48 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
Date: Wed, 02 Sep 2026 22:23:23 +0100
Subject: [PATCH v4 1/4] image-fit: Use unsigned types for external data
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-b4-fit-ext-data-hardening-v4-1-a884a5de96ea@binarly.io>
References: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
In-Reply-To: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1788384226; l=7910;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=gZuz5FUB42c3MDvivj2Yu/LO/l6xkLuTW7Qeb1CFs5c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLayXccjp15xN3IcRnvyVs0zU8+Yjh44T1eQMwWv01yTie1BxG2+NyKew/GdnrRZNiz7TQ54Ep9
 mNpPuZekTmAY=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Wed, 02 Sep 2026 21:58:52 +0000
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

The data-offset, data-position and data-size FIT properties are
stored as 32-bit unsigned values (fdt32_t), but the accessors
fit_image_get_data_offset(), fit_image_get_data_position() and
fit_image_get_data_size() return them through a signed int.

Switch the accessors and their callers to u32. This removes the
special processing of "negative" values in fit_image_get_data().

Signed-off-by: Anton Ivanov <anton@binarly.io>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 boot/image-fit.c               | 29 ++++++++++-------------------
 common/spl/spl_fit.c           |  4 ++--
 common/splash_source.c         |  2 +-
 drivers/fpga/socfpga_arria10.c |  3 ++-
 include/image.h                |  6 +++---
 test/py/tests/test_vboot.py    | 10 +++++-----
 6 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index ef90c5abd18..26e9323da06 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -963,7 +963,7 @@ int fit_image_get_emb_data(const void *fit, int noffset, const void **data,
  *     0, on success
  *     -ENOENT if the property could not be found
  */
-int fit_image_get_data_offset(const void *fit, int noffset, int *data_offset)
+int fit_image_get_data_offset(const void *fit, int noffset, u32 *data_offset)
 {
 	const fdt32_t *val;
 
@@ -988,7 +988,7 @@ int fit_image_get_data_offset(const void *fit, int noffset, int *data_offset)
  *     -ENOENT if the property could not be found
  */
 int fit_image_get_data_position(const void *fit, int noffset,
-				int *data_position)
+				u32 *data_position)
 {
 	const fdt32_t *val;
 
@@ -1012,7 +1012,7 @@ int fit_image_get_data_position(const void *fit, int noffset,
  *     0, on success
  *     -ENOENT if the property could not be found
  */
-int fit_image_get_data_size(const void *fit, int noffset, int *data_size)
+int fit_image_get_data_size(const void *fit, int noffset, u32 *data_size)
 {
 	const fdt32_t *val;
 
@@ -1070,18 +1070,13 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 		       size_t *size)
 {
 	bool external_data = false;
-	int offset;
-	int len;
 	int ret;
 	size_t fdt_total_size_aligned;
+	u32 offset;
+	u32 len;
 	uintptr_t max_offset;
 
 	if (!fit_image_get_data_position(fit, noffset, &offset)) {
-		if (offset < 0) {
-			printf("Invalid external data position: %d\n", offset);
-			return -EINVAL;
-		}
-
 		external_data = true;
 	} else if (!fit_image_get_data_offset(fit, noffset, &offset)) {
 		/*
@@ -1090,9 +1085,9 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 		 * for the data-offset properties in each image.
 		 */
 		fdt_total_size_aligned = ((fdt_totalsize(fit) + 3) & ~3);
-		/* The resulting offset cannot exceed INT_MAX */
-		if (offset < 0 || fdt_total_size_aligned > INT_MAX - offset) {
-			printf("Invalid external data offset: %d\n", offset);
+		/* The resulting offset cannot exceed UINT32_MAX */
+		if (fdt_total_size_aligned > UINT32_MAX - offset) {
+			printf("Invalid external data offset: %u\n", offset);
 			return -EINVAL;
 		}
 		offset += fdt_total_size_aligned;
@@ -1106,16 +1101,12 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 		max_offset = UINTPTR_MAX - (uintptr_t)fit;
 		/* Check that external data offset is within the addressable range */
 		if (offset > max_offset) {
-			printf("Invalid external data offset: %d\n", offset);
+			printf("Invalid external data offset: %u\n", offset);
 			return -EINVAL;
 		}
 
 		ret = fit_image_get_data_size(fit, noffset, &len);
 		if (!ret) {
-			if (len < 0) {
-				printf("Invalid external data size: %d\n", len);
-				return -EINVAL;
-			}
 			/*
 			 * For non-signed FIT images, we can only check that
 			 * (offset + len) doesn't exceed the addressable range.
@@ -1135,7 +1126,7 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 			    len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset
 #endif
 			) {
-				printf("FIT external data is out of bounds (offset=%d, size=%d)\n",
+				printf("FIT external data is out of bounds (offset=%u, size=%u)\n",
 				       offset, len);
 				return -EINVAL;
 			}
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 18bff7b8d4a..9b16f91cc6f 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -216,9 +216,9 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			   const struct spl_fit_info *ctx, int node,
 			   struct spl_image_info *image_info, ulong max_size)
 {
-	int offset;
+	u32 offset;
+	u32 len;
 	size_t length;
-	int len;
 	ulong size;
 	ulong load_addr;
 	void *load_ptr;
diff --git a/common/splash_source.c b/common/splash_source.c
index e02f9be05e4..a5ed7431b8e 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -351,7 +351,7 @@ static int splash_load_fit(struct splash_location *location, ulong bmp_load_addr
 	const void *internal_splash_data;
 	size_t internal_splash_size;
 	int external_splash_addr;
-	int external_splash_size;
+	u32 external_splash_size;
 	bool is_splash_external = false;
 	struct legacy_img_hdr *img_header;
 	const u32 *fit_header;
diff --git a/drivers/fpga/socfpga_arria10.c b/drivers/fpga/socfpga_arria10.c
index e9822b2bb0e..e397b37adf0 100644
--- a/drivers/fpga/socfpga_arria10.c
+++ b/drivers/fpga/socfpga_arria10.c
@@ -547,7 +547,8 @@ static int first_loading_rbf_to_buffer(struct udevice *dev,
 	u32 *loadable = buffer_p;
 	size_t buffer_size = *buffer_bsize;
 	size_t fit_size;
-	int ret, i, count, confs_noffset, images_noffset, rbf_offset, rbf_size;
+	int ret, i, count, confs_noffset, images_noffset;
+	u32 rbf_offset, rbf_size;
 	const char *fpga_node_name = NULL;
 	const char *uname = NULL;
 
diff --git a/include/image.h b/include/image.h
index 4149ebbcce9..d082dac5035 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1263,10 +1263,10 @@ int fit_image_get_load(const void *fit, int noffset, ulong *load);
 int fit_image_get_entry(const void *fit, int noffset, ulong *entry);
 int fit_image_get_emb_data(const void *fit, int noffset, const void **data,
 			   size_t *size);
-int fit_image_get_data_offset(const void *fit, int noffset, int *data_offset);
+int fit_image_get_data_offset(const void *fit, int noffset, u32 *data_offset);
 int fit_image_get_data_position(const void *fit, int noffset,
-				int *data_position);
-int fit_image_get_data_size(const void *fit, int noffset, int *data_size);
+				u32 *data_position);
+int fit_image_get_data_size(const void *fit, int noffset, u32 *data_size);
 int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 				       size_t *data_size);
 int fit_image_get_data(const void *fit, int noffset, const void **data,
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 4b6707caf70..fd91b3f10a2 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -700,12 +700,12 @@ def test_vboot_ext_data_bounds(ubman):
         fd.write(500 * b'\0')
 
     testcases = [
-        ('negative data-position',
-         {'data-position': 0xffffffff}, 'Invalid external data position'),
-        ('negative data-offset',
+        ('invalid data-position',
+         {'data-position': 0xffffffff}, 'FIT external data is out of bounds'),
+        ('invalid data-offset',
          {'data-offset': 0xffffffff}, 'Invalid external data offset'),
-        ('negative data-size',
-         {'data-size': 0xffffffff}, 'Invalid external data size'),
+        ('invalid data-size',
+         {'data-size': 0xffffffff}, 'FIT external data is out of bounds'),
         ('off-bounds data-position',
          {'data-position': 0x7fffffff}, 'FIT external data is out of bounds'),
         ('off-bounds data-offset',

-- 
2.55.0

