Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF05C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 19:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F2BB87650;
	Sat, 16 Dec 2023 20:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GDXyRyvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83C1875A0; Sat, 16 Dec 2023 20:38:53 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23DFC87BF2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 20:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67f29d1dafbso5412166d6.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 11:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702755529; x=1703360329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJuLH9/Pzu1jzTH8HrbCZsbf9HfEEiUe8HBBscN3m3I=;
 b=GDXyRyvfGITNxelx05nwvDXs1Q74LF9QfGro+ZRiwobcB3CpnSk/Bszf0evxbJGyLq
 +6bTLuMuAYE3UFRR3xyyYPPxCASW15Pd+q78Q4gY9ZG57QOOGEyoBIAoWldx2U5/jOWQ
 Hz5w0HL9+RcYpaYb0c+cstIlhZXr2+VWpeVJkw2di75MC4BtHsTTqY23zrngu7iKM8rP
 +4yLmy2WAWTLNMGjh6aIzHSInwOuoK/Nl7PM95mmxB9lA1eBOzRi7ovynqUyFEARbHQ8
 bd84s9icfJuHA4UUP8cZCSCf2tj86Jioin5fIZjsU/F+iFig0i6dm3CnLQP32EP3FGvI
 uQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702755529; x=1703360329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJuLH9/Pzu1jzTH8HrbCZsbf9HfEEiUe8HBBscN3m3I=;
 b=k5mDveHyMZbMKdmKfy49h0VAJNk9V1uTzKXXaB3NMAMf8aoHGiujnCWuVrFPqbsiHw
 DKKRmAwglDsqMTXGdZqgAWrXs+B4BX653E3YYaf+ap49L3o+iO1xXfiVZWB55LVCI1q4
 4oBUvh2XPEkkJFc9RRTgwT5vOLZmpJL149vKqUmBAyt4NS1Mj7Cgc5tM6/5/S6rS6fmZ
 cNrRrvQEeTe2CBy/3POW1rYOlDBJnWC09634VFv/RF75X9jsQNNJQMtByZTKhc6aK4pT
 QFqqwmOOtWjfX1KX6oDw3TlXJtHPpTUs6l0tgFRx1B0qX5GmNYJjdqzN28bmcof5RzvQ
 rVnw==
X-Gm-Message-State: AOJu0YwEp+hVa85g1hB2/j40wYdDCHY8d/oyXlEMehtB/ZTVl6wACm02
 MmPwwTyOlhAP/W/cCN+be8BaTIY8h2tkjQ==
X-Google-Smtp-Source: AGHT+IGGAhgdT+oX130/pltJKShDc3XxlNFs0up+Enmki+CIXqk6wCXKHpFBTdIGrxzkAV1xciQ90A==
X-Received: by 2002:a05:620a:46a0:b0:77f:76f2:1b with SMTP id
 bq32-20020a05620a46a000b0077f76f2001bmr14383315qkb.150.1702755528801; 
 Sat, 16 Dec 2023 11:38:48 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 qc10-20020a05620a654a00b0077dcd4a0e04sm7020713qkn.7.2023.12.16.11.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 11:38:48 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 3/3] clk: Document clk_ops return codes and behavior
Date: Sat, 16 Dec 2023 14:38:43 -0500
Message-Id: <20231216193843.2463779-4-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231216193843.2463779-1-seanga2@gmail.com>
References: <20231216193843.2463779-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Currently, clock consumers cannot take any programmatic action based on the
return code of a clock function. This is because there is no
standardization, and generally no way of separating e.g. "there was a major
problem setting the rate for this clock" which usually should not be
recovered from, from "this clock doesn't support setting its rate" or "this
clock doesn't support *this* rate" which could be absolutely fine depending
on the driver.

This commit aims to standardize the acceptable codes which may be returned
from clock operations. In general,

- ENOSYS should be returned when an operation is not supported for a
  particular clock.
- ENOENT may be returned if the clock ID is invalid. However, it is
  encouraged to move any checks to request() to reduce code duplication.
- EINVAL should be returned for logical errors only (such as requesting an
  invalid rate).

Each function has had specific guidance added for when to return each error
code. This is just guidance for now; most of the clock subsystem does not
yet conform to this standard. However, it is expected that new clock
drivers return these error codes.

Additionally, this commit adds expected behavior for each of the clock
operations. I believe these should be mostly straightforward and correspond
to existing behavior. I remember not understanding what the expected
invariants were for several clock functions, so hopefully this should help
out new driver authors. In the future, some of these invariants could be
checked via an optional config option.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 include/clk-uclass.h | 113 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 103 insertions(+), 10 deletions(-)

diff --git a/include/clk-uclass.h b/include/clk-uclass.h
index 4353b664800..8c07e723cff 100644
--- a/include/clk-uclass.h
+++ b/include/clk-uclass.h
@@ -56,11 +56,20 @@ struct clk_ops {
  * default implementation, which assumes #clock-cells = <1>, and that
  * the DT cell contains a simple integer clock ID.
  *
+ * This function should be a simple translation of @args into @clock->id and
+ * (optionally) @clock->data. All other processing, allocation, or error
+ * checking should take place in request().
+ *
  * At present, the clock API solely supports device-tree. If this
  * changes, other xxx_xlate() functions may be added to support those
  * other mechanisms.
  *
- * Return: 0 if OK, or a negative error code.
+ * Return:
+ * * 0 on success
+ * * -%EINVAL if @args does not have the correct format. For example, it could
+ *   have too many/few arguments.
+ * * -%ENOENT if @args has the correct format but cannot be translated. This can
+ *   happen if translation involves a table lookup and @args is not present.
  */
 int of_xlate(struct clk *clock, struct ofnode_phandle_args *args);
 
@@ -75,16 +84,36 @@ int of_xlate(struct clk *clock, struct ofnode_phandle_args *args);
  * xxx_xlate() call, or as the only step in implementing a client's
  * clk_request() call.
  *
- * Return: 0 if OK, or a negative error code.
+ * This is the right place to do bounds checking (rejecting invalid or
+ * unimplemented clocks), allocate resources, or perform other setup not done
+ * during driver probe(). Most clock drivers should allocate resources in their
+ * probe() function, but it is possible to lazily initialize something here.
+ *
+ * Return:
+ * * 0 on success
+ * * -%ENOENT, if there is no clock corresponding to @clock->id and
+ *   @clock->data.
  */
 int request(struct clk *clock);
 
 /**
  * round_rate() - Adjust a rate to the exact rate a clock can provide.
- * @clk:	The clock to manipulate.
- * @rate:	Desidered clock rate in Hz.
+ * @clk:	The clock to query.
+ * @rate:	Desired clock rate in Hz.
  *
- * Return: rounded rate in Hz, or -ve error code.
+ * This function returns a new rate which can be provided to set_rate(). This
+ * new rate should be the closest rate to @rate which can be set without
+ * rounding. The following pseudo-code should hold::
+ *
+ *   for all rate in range(ULONG_MAX):
+ *     rounded = round_rate(clk, rate)
+ *     new_rate = set_rate(clk, rate)
+ *     assert(IS_ERR_VALUE(new_rate) || new_rate == rounded)
+ *
+ * Return:
+ * * The rounded rate in Hz on success
+ * * A negative error value from another API (such as clk_get_rate()). This
+ *   function must not return an error for any other reason.
  */
 ulong round_rate(struct clk *clk, ulong rate);
 
@@ -92,7 +121,22 @@ ulong round_rate(struct clk *clk, ulong rate);
  * get_rate() - Get current clock rate.
  * @clk:	The clock to query.
  *
- * Return: clock rate in Hz, or -ve error code
+ * This returns the current rate of a clock. If the clock is disabled, it
+ * returns the rate at which the clock would run if it was enabled. The
+ * following pseudo-code should hold::
+ *
+ *   disable(clk)
+ *   rate = get_rate(clk)
+ *   enable(clk)
+ *   assert(get_rate(clk) == rate)
+ *
+ * Return:
+ * * The rate of @clk
+ * * -%ENOSYS if this function is not implemented for @clk
+ * * -%ENOENT if @clk->id is invalid. Prefer using an assert instead, and doing
+ *   this check in request().
+ * * Another negative error value (such as %EIO or %ECOMM) if the rate could
+ *   not be determined due to a bus error.
  */
 ulong get_rate(struct clk *clk);
 
@@ -101,7 +145,27 @@ ulong get_rate(struct clk *clk);
  * @clk:	The clock to manipulate.
  * @rate:	New clock rate in Hz.
  *
- * Return: new rate, or -ve error code.
+ * Set the rate of @clk to @rate. The actual rate may be rounded. However,
+ * excessive rounding should be avoided. It is left to the driver author's
+ * discretion when this function should attempt to round and when it should
+ * return an error. For example, a dividing clock might use the following
+ * pseudo-logic when implemening this function::
+ *
+ *   divisor = parent_rate / rate
+ *   if divisor < min || divisor > max:
+ *     return -EINVAL
+ *
+ * If there is any concern about rounding, prefer to let consumers make the
+ * decision by calling round_rate().
+ *
+ * Return:
+ * * The new rate on success
+ * * -%ENOSYS if this function is not implemented for @clk
+ * * -%ENOENT if @clk->id is invalid. Prefer using an assert instead, and doing
+ *   this check in request().
+ * * -%EINVAL if @rate is not valid for @clk.
+ * * Another negative error value (such as %EIO or %ECOMM) if the rate could
+ *   not be set due to a bus error.
  */
 ulong set_rate(struct clk *clk, ulong rate);
 
@@ -110,7 +174,19 @@ ulong set_rate(struct clk *clk, ulong rate);
  * @clk:        The clock to manipulate.
  * @parent:     New clock parent.
  *
- * Return: zero on success, or -ve error code.
+ * Set the current parent of @clk to @parent. The rate of the clock may be
+ * modified by this call. If @clk was enabled before this function, it should
+ * remain enabled after this function, although it may be temporarily disabled
+ * if necessary.
+ *
+ * Return:
+ * * 0 on success
+ * * -%ENOSYS if this function is not implemented for @clk
+ * * -%ENOENT if @clk->id or @parent->id is invalid. Prefer using an assert
+ *   instead, and doing this check in request().
+ * * -%EINVAL if @parent is not a valid parent for @clk.
+ * * Another negative error value (such as %EIO or %ECOMM) if the parent could
+ *   not be set due to a bus error.
  */
 int set_parent(struct clk *clk, struct clk *parent);
 
@@ -118,7 +194,16 @@ int set_parent(struct clk *clk, struct clk *parent);
  * enable() - Enable a clock.
  * @clk:	The clock to manipulate.
  *
- * Return: zero on success, or -ve error code.
+ * Enable (un-gate) the clock. This function should not modify the rate of the
+ * clock (see get_rate() for details).
+ *
+ * Return:
+ * * 0 on success
+ * * -%ENOSYS if this function is not implemented for @clk
+ * * -%ENOENT if @clk->id is invalid. Prefer using an assert instead, and doing
+ *   this check in request().
+ * * Another negative error value (such as %EIO or %ECOMM) if the clock could
+ *   not be enabled due to a bus error.
  */
 int enable(struct clk *clk);
 
@@ -126,7 +211,15 @@ int enable(struct clk *clk);
  * disable() - Disable a clock.
  * @clk:	The clock to manipulate.
  *
- * Return: zero on success, or -ve error code.
+ * Disable (gate) the clock. This function should not modify the rate of the
+ * clock (see get_rate() for details).
+ *
+ * * 0 on success
+ * * -%ENOSYS if this function is not implemented for @clk
+ * * -%ENOENT if @clk->id is invalid. Prefer using an assert instead, and doing
+ *   this check in request().
+ * * Another negative error value (such as %EIO or %ECOMM) if the clock could
+ *   not be disabled due to a bus error.
  */
 int disable(struct clk *clk);
 
-- 
2.37.1

