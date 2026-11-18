Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1B606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VqANUkBt;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bMxGD0A6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6194F812C3;
	Wed, 18 Nov 2026 17:47:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q-IIyvrGjKlP; Wed, 18 Nov 2026 17:47:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A016180F4E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795024047;
	b=Q7G/qk7QDrCWffkx+LvaqVVgscP0pNdov0IXiIOw621kAVZ/6Bb1BfF2hwgen1YSCaB5
	 oOI2oqJqzYzLd4Xo2EPf3sqWI3EObKeXeXAG1/tRoY5J5UZdRrsv+rFlgOrECGaote8eC
	 MNx/PhBo/MbpXdeDGIU+QiYkfQkvWcx1na2R09sE9X0jbS1ewAszHcam8Ph7E64Icp52c
	 YQZ3xv/N8oZgcnky4OrAz3Lt1vJYbWJZFtMqxYIXFZCyImZHbV4UrrA/e/TkFiovDndHJ
	 NwsaV4LQVJXX+gMQDQucuA+cNXd3IRY///XZswfFfoo2KgQujhhzEDslvRF6+5sCkxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795024047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ndzf7mX1PekrUdCFSGB0hPQ6saFFqCuAEvnt2K6DUSg=;
	b=G+khK9mwmUyjvWFk6BJ67/irL4/xNOoY1dZaY2dY9gSpKHl29oD3/XG1EMVihEOVbKHm
	 dMFLfZXvD4ax4LnLCnJ6/LAPqD2wZuX/Yr2qlCDqo3zWhZc/0AsU0jKKPYveAea4TJEQp
	 A6w/CHIdCKl8NzqUOnRT3HYKQ4BGEzjUZDZoerzrOYIQ+62JT8G/W/ISglmBcC39Qllwu
	 BhMERmHsGGTWXXCEHqaQXTtrQJh484EEXK8WfXQQnICu9VjdSNa2AQnjIieIA2W6cnLRm
	 DltS1/5db8sDK79ucI8ZBVtAQlP9aGQAPZmHK9PIkDbIypuy/hqR21tApL1HVoiZ2TA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795024047;
	bh=ndzf7mX1PekrUdCFSGB0hPQ6saFFqCuAEvnt2K6DUSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VqANUkBt/hePp4cziSYmT/U3zX3t1MywSE+5gnF6+mUI25a0iqixR04MRKPj3x3Gm
	 Tnxs6xw0l049AZSpvZHvm6OjbPtSFGAQAFVRQaTBci8NpE0gQRP455oCnimGm+Krx5
	 G+2W1si9LJqM9GBeXSgLFCpRuoPhB2SmsC2YdHXDniUoUM6/B3VEnpSW4fAPCx4z9P
	 GaXHbi21Fk9fCpM8ZkOU22ynJjN8Yi0GvjfiDHY+9OfQMgF51MOZqFVvHvEtbYFbfp
	 OQt3Cv5ZmDZG4m2lhSJNFBYnOWS7w3xrBlWyn8qfsfQSSpGBc9ULU5WbOG8VB3iSjh
	 tSoYRXkWTCK4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A016180F4E;
	Wed, 18 Nov 2026 17:47:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4220A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0E0340A39
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z_xL48aXWq5d for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:47:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ACA8440A2F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=bMxGD0A6
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACA8440A2F
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:19 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so14282815e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795024038; x=1795628838;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ndzf7mX1PekrUdCFSGB0hPQ6saFFqCuAEvnt2K6DUSg=;
 b=bMxGD0A6FQct5GrCNbIM6yVCvl7FE2+6oQIjQROgOK8Mk7+ZnXdLbtVMEatCso8lFr
 PDOvaarb42ItpYbU1ggf/Il3GMaXo36w6g90bOcvxLaBMgrfvFdh8r3cNCMfierCFk2+
 WqFkbVAyQ78dwrBANzXI4/xxmqm4FoqQWeMYZWsDaD0fYBE9rUqMPCr+kLACTG6GE0Il
 Terg35052GihEXyuQ5RtyDcQFHSYhJFFxqsZZMHkL0H53Kvj6+xto6G7VU/RAe5/5+AN
 6uAusTQIfVFKg9yBSatesHeKVwwuLVoCAl1wskCHg8a10eEHflCtS96APAql/1v6XWt8
 w28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795024038; x=1795628838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ndzf7mX1PekrUdCFSGB0hPQ6saFFqCuAEvnt2K6DUSg=;
 b=ESTw4EXqIxvMJ9gVlL//6oiTeOHKg+9zLRAcjSutjcIbEb3AUT0KJ63gACyGl4l2DY
 fdECQm3MncnKkPtETEwsfmRDWb6uFNGy7M44jX6njwCY5Z/fqgK1Tyaxet6ZVdatqLys
 4FjDDG0PYsK9fdIye9W8KibeAa3mRMElFS8zPN1tYDahMFJfTpwT9S29pTmIn+okfPUl
 BnEc4KtQlIg2MUyT+g3yI2qyUS0hGQmT+KMHvkzGXddoGHYVI+66fjJKbiW9ms/wxyEN
 ZORecfuIeG/8usIqPsykXReVWA8Ex23AmEMKWMznBTodJ49q1hxkDspRxkYLla9kSeL1
 /Rcg==
X-Gm-Message-State: APuU4Z+BctKTzNwxBz+WTucpHwETqI2TFdztLB5nw0vuo73G1LXkXdyj
 EiHB/C8FsdP1VNMjYP6jQHZySe6IOKzcZXrVFJLQLxiaQZDxpz8Jt4yO
X-Gm-Gg: AYBFou3DsNr+YKuNCKLwBBi3gkZepkZB1BRzSdOx9Ap0TIs1S3ddZ+k/RiJqGVvCqea
 DK+puRrVV1zEcSVl2iA9ctX8Ug0qnSJwoYidUXcosdCpxjTstvuF9NiR568jVeWlkKrwZyTTnvA
 0jLVv9K3SxZPEBVnWn9oJEnRqC/gDA4O4jWFRyDkP4dhZlsS3B5wu2ZezwHo5ZkceRHX0l1Wcqp
 XR9vgUuHfaQF6gpM32c3LwWsuhjlbvkbt6qlQpBHX6cngurgKAbL8SibNlvMJvQcjzDH1otQAC5
 wefJNjW0C31NWF/oDPhUJY6S0kRdeC11uKKvxYfJvBBfj8vlzclcEJYTwWHZUfLYgivbBuUi3wP
 50IZFC++iKEnTMowYXg3W+Crru6kWGE51FaZNt7lBhHp12Ru9NQRwkxuO5jZM3X+Qa1hA1DwA/F
 S0nAzSAEtq3HfzLoVeHXcDNWJSAEruyJj6i8GIgZ9I7M6QhRaY8gDaEWijpo0zK+8xOenBQ6p2m
 +vbMVqbiZgWS1VmX9MVEnt74IlXNn/rL45FpayQoE94fGi5zDRYTz0eSw64EYwhDaSQLnC527JR
 nntMc274N73PZ0tySlsP54fmveSfn4OJMzyH1+Zr
X-Received: by 2002:a05:600c:4e11:b0:4bb:6c71:b269 with SMTP id
 5b1f17b1804b1-4bb7da42cf5mr67336695e9.28.1795024037833; 
 Wed, 18 Nov 2026 09:47:17 -0800 (PST)
Received: from [127.0.1.1] ([151.51.238.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65683d5a2sm6302789f8f.43.2026.11.18.09.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:47:17 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 18 Nov 2026 18:47:00 +0100
Subject: [PATCH 4/4] mach-sc5xx: Generate LDR artifacts only if ldr is
 available
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ldr3-v1-4-6ffe43aa8c6c@gmail.com>
References: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
In-Reply-To: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
To: u-boot@lists.u-boot-project.org, linux@analog.com
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Yao Zi <me@ziyao.cc>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ldr tool, used to package artifacts in LDR format, is neither part
of toolchains nor available as a utility in common host distributions.
When missing, all of the builds of Analog Devices SC5XX SoC defconfigs
fail, including buildman ones when testing these platforms. Indeed, the
LDR format artifacts (u-boot.ldr and spl/u-boot-spl.ldr) are final ones
and not prerequisites for other targets. Therefore, consider them
optional and generate only if the ldr tool is available, silently
skipping if it is not, without raising any error.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-sc5xx/config.mk | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-sc5xx/config.mk b/arch/arm/mach-sc5xx/config.mk
index 85889f54e89..1af21835404 100644
--- a/arch/arm/mach-sc5xx/config.mk
+++ b/arch/arm/mach-sc5xx/config.mk
@@ -5,6 +5,13 @@
 # Written by Timesys Corporation
 #
 
+# Note: '2>/dev/null' is here to force Make to invoke a shell instead of
+# trying to directly execute any utility named 'command' - following the
+# fast path - which will cause it to fail with 'command: Command not found'.
+# This workaround should be kept until support for GNU Make 4.2.1 and
+# previous versions is dropped.
+ifneq ($(shell command -v -- $(LDR) 2>/dev/null),)
+
 ifdef CONFIG_XPL_BUILD
 INPUTS-y += $(obj)/u-boot-spl.ldr
 endif
@@ -13,3 +20,5 @@ INPUTS-y += u-boot.ldr
 
 LDR_FLAGS += --bcode=$(CONFIG_SC_BCODE)
 LDR_FLAGS += --use-vmas
+
+endif

-- 
2.34.1

