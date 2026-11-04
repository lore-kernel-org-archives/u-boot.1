Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B9606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rzhTJhaI;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ey0WeoRk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 403756075B;
	Wed,  4 Nov 2026 10:59:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nDhV8DAu_XH9; Wed,  4 Nov 2026 10:59:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 56AC060865
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793789970;
	b=czf0Oo9uP0Bszs3qqEk4iMHRaNoOTZKgy9sXKQOmKWf2WKULQPZMK9qtw0hR7iikbFuV
	 HfyNMRJDeHX9Pwsl9mdiUfRzMQD9VS9dF+/29ddNMrjGQnziFj2WKcjjYD3LMKaqF6MWV
	 8gQrtRd86F6cB/DFc1IwsXCGnckpM2jr5OYmHc+1qi7ALU6JpzdJag0ABgWfCZ6mB4Nnq
	 GsoxhIUFYLlCg5CdomXMJjNYpfcKG1qzCGt4S91Purt3vEH8Y+GIPF77h0n80muIFo+HC
	 Ag5Ngs4ukTxeBpUnPitEr/UAckVf1JFapXvHoJsYdVENPpF59BzFbd5PkPiQ6F4akZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793789970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KfMP93wq5QMMYIIoQ3sPPkMR/QMm4rjB6L/4XQJfyNI=;
	b=mV9fHkltZZgHI4/mB8YswTYL7UH0cxaOf68lJvmxkIEceX8BrNO09SL7t5/m5h9af3hp
	 YdFakEBeIlp4fFnwvC2AmFzC4I2x1Uy/daRgHLcFouAP6tXKyIfTtYi20TClrWSLHwIB5
	 ODNQXOGYj181OL9tBZHlRATQkTZeMLDs2fzsKHH9JpYPHyCpZW/6xx+MXo3ZyWHKG24wT
	 Jn8Gg7HEe54Ky2lINC7kc1tsTWSfjDE4SrALGO6PdiTc0oTQoacJ3yWDrLxq0aN44Os/1
	 cvXnbUivuQIn+oFaI5z4YbiVtftZla8su5WODgoMc3Ni2rLX99/RuaRYFGKx/oU5LGg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793789970;
	bh=KfMP93wq5QMMYIIoQ3sPPkMR/QMm4rjB6L/4XQJfyNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rzhTJhaIAqIjsuqvKUq3IPJnVM4XCA5ael30ihtX0R01rRKkD+uE5VONkjsO/aLLM
	 7h14a0o763+XMYv9Wdph3CUCYxmdQtnjELQX2zDXR+Ef5NAlcjrjnW770SJWBeY84/
	 /WcdRh0m4C0DabEFaBAZfjgJ1bvd99MklasH3NUOwxxRKJQfIWQYU5jI0s5DpTy0ka
	 GCp8vRG/x0UPnF35yE5d4avgtfGuo0qDYHV7Zsr8kRCgYaxRCaHtoFPrBuxGlwevsG
	 NVqQF+zPKZu8s3r2cicraTeFoRcGkK/eDtyJwQsJlZjmDc0pef64epIFnBcUDftLWq
	 MCj9j7eWsK/DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56AC060865;
	Wed,  4 Nov 2026 10:59:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E93D8341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEDF780F6B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Je5wdhV9sPb5 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:59:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E1C0480F61
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793789963;
 b=ngV5MSK5TD0TErCcw5+c4CBLqEUCWr8KP13SIFxHF/pOeO55RtP0HfN7DGxFDOzehoPG
 TfDVWmPFACjasy5qBjdb2isA/aYidBre8JuZDDuJheQrSM6QcPPfTLDmskJCV/sEWiIJv
 bHHEE7a6wf0T1Ro8pGtdYnp5XdUd1DPnmW37GgBGxgvi69kjmrLHzNbq05AmUIebtsxwG
 syQhFAkXVcX3kjAJpSlSd9j09Jr6iqJNZIFT3KhPFQawDuei+aJVjXRsk13UNnBWuU4XP
 eFqKWcgG/D9ot7kGLNO1a2+0uPzcjFenSoX7wc/05RSphHIq/qZjh6dKj+ViEJgcjWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793789963;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=KfMP93wq5QMMYIIoQ3sPPkMR/QMm4rjB6L/4XQJfyNI=;
 b=fwd8VntrCk144nx/vlM+oo6JYdJpxJ+Lczi0Cklio2MOuS94L66hs1bjly0eOaINke32
 o+a8oG9m1NFWOWBKFrn8vFj96NCMNwyzawZ5Pjy9Z3J2qtoyKGlvCB5ES6L0iUHw+z/BI
 T3n8dXTuYrVr/KTVVzARvZ1uO/z9cYyKPLfEmQXaDL7Hi/EXOklwyzYiBrGkLoKyTluOV
 OJKYmAUWCK+V2/Zhut3r1NeltZVBtVXr/bD9CKN/+xvRhcSbCj1o+N1lB+F2+6kq6posF
 Id0NSzcPUFwkHuTPyVTGUWG24jJGJlSZNIj5cTxTZgVQb5WjyhDaunXws7aswRNcjSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ey0WeoRk; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ey0WeoRk
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E1C0480F61
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:21 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso3390845e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 02:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793789960; x=1794394760;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KfMP93wq5QMMYIIoQ3sPPkMR/QMm4rjB6L/4XQJfyNI=;
 b=ey0WeoRkMxEj34F6N4RgBNpqblKhgQqzfJTmGkwcCIh7zyJqa8iYwfNzbdu/toZ7WB
 GbZEjqv5HN8AZni4CB3nBzrPb4XwP4y3QhTfyIqS4165Sr6CBnSFFrECcs9T6ST1qHik
 /WrVk9G512OW0PKG+awL8UvViq4v/v3Ojn4iBmCPQDymC/tdfaFrmj0P0zVheBviFaQu
 nWWJ3pjl+oQy+hghzamHyQt+YNGIN8sDctRvJvRw503Jxig1H9xGjDEY/ehDYDv5EJT2
 qkFtmH3bAPrrtFmBP2JLmPy2sWqBkcHisI1HdczVJDLjbTsskXtpFxe3dPuawLzj96bj
 IcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789960; x=1794394760;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KfMP93wq5QMMYIIoQ3sPPkMR/QMm4rjB6L/4XQJfyNI=;
 b=IdwL4xT5nL3SQUXZPSYARlVuYHaAJe55kDQuNVql/AC3KV6hthHBK/8BDqNk/tMihd
 XpsGRBkmoUfPITHlqNN9/vEUPJVqypx4MnEd6sBxxJUbLNq83jc2zCE+DOXaa7n6c1qn
 g+Q9OYJOPrTbadS/Cj9Gb+ix3aB/g+JVz6f0Frps3zejVVPhXxsAw6chhmksYY77r4Yj
 7JvaoYDqDs/lCAnVn6fbaHeZn54q9EA7K2obx33MWR/d7kX9b46W+Dx8FiPbUc20eqNm
 ZEVY84zFpvas2XaaLLh+9S/OZadILPwudaOFlPdUx0SDN8i465IAAxZQUsMXeQ0K5jtf
 PEHA==
X-Gm-Message-State: APuU4Z+5UmhtbhXjdv7NhaWQ5IaHXZra0eD2fMDiaU11fl/nZnRGE76C
 cFbEVxd9i0sY8iufIFHI1Z4A09K+eWvrvmai/C61lhL2rCFY0ZhfC7H6tN4e4L5mgQo=
X-Gm-Gg: AYBFou0O8tXX+X7c6poyOozOQquOSSCrabtxVlWIsC2ysb5pwPfDPcxv4JJwDRSbSEo
 ezFI2FXNNuIXv6jWEZpv431kWTPLP2D49DgqVMgpHKE/hFawYgkGghEAPpfNyHzhv0APZSHQspN
 uEqbIrviTuobaN1XxU9pAWIvdfh+YUfhxbsKAlzY3Xvvi2WgfV5+Rgf6b0lpZomIjB2WU2jmQdQ
 VV//hMFv8pAJ+IOs5KQYl0yusBl06ajaEaAG4RPcs3Z6TVrUYGm/LeY6+WXuNl9KDEa3RGecB9Q
 mbmjmx6A4TuxD9uXplW6Fy3GjxaU8uNFcnttIej5Ek765oLlFg7ExNxCIAJ+mn0FZW7uCCpX21a
 SSx4lTAFZp6ns0VBNIFeFh5bI0PEP88i+oMNVaCx3GJZ23qgQE6AE/FXAAYYVq/dXCoHcfk2sL2
 Loio/by4o0c5vORtQOjvEenCMwIx/9p/o6zFQAHEbbTvJSycKEdvwkVoDpKz/vmYWrvZbvn180Y
 aKDTR7bpj+Ugf8iK1VIcPBaeZSMuMvQvOPRffrkZmJYn/wIySRBqeCpOV2KXxvINT3NLWGik/TM
 GCnkXW/IB4Y5KnVZRVUu5oEuaA6isJxtkQ==
X-Received: by 2002:a05:600c:8709:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4ac181e75b7mr377728635e9.31.1793789959727; 
 Wed, 04 Nov 2026 02:59:19 -0800 (PST)
Received: from hermes.fritz.box ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20567sm3503492f8f.51.2026.11.04.02.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:59:19 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 04 Nov 2026 11:58:20 +0100
Subject: [PATCH v4 2/7] arm: mach-k3: common: add helper to wait for TIFS
 initialization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-2-e211cba9f3ea@baylibre.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Jacob Parker <jparker@basepowercompany.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=msp@baylibre.com;
 h=from:subject:message-id; bh=7w2J3os+dPG6ipeUX+2twHICEC5o17kYVkvO87lJ4Vw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqzX/C/+v5RK7mbecHLy5YLHvBudElvX5V/55tO3ccf+l
 8pFDxb+7JjIwiDGxWAppsjSmRia9l9+57HkRcs2w8xhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjhEDF6cATPXKn4wMK4Jsik5eMT3tNkNRK/NIUa3UHuYv3/+85F/elTvLVEJEkOF/zoxLKvG
 5avZ3wvLO72Szf7kw3fGGkseSx5V3U5S8lhqwAwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Add a helper to wait for TIFS initialization to be finished. Effectively
this is just a call to get_ti_sci_handle() but I think a separate
function makes the purpose of this call better visible.

get_ti_sci_handle() internally leads to fetching the TIFS version with a
message and response. TIFS only responds once initialization finished.
If a response is not received get_ti_sci_handle() returns after a
timeout.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Tested-by: Richard Genoud <richard.genoud@bootlin.com> # on j722s HS-FS
---
 arch/arm/mach-k3/common.c | 10 ++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 6e382efdb3be..480c90cfa65f 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -54,6 +54,16 @@ struct ti_sci_handle *get_ti_sci_handle(void)
 	return (struct ti_sci_handle *)ti_sci_get_handle_from_sysfw(dev);
 }
 
+void k3_sysfw_wait_ready(void)
+{
+	/*
+	 * Wait for TIFS initialization to finish. This helper is used to make
+	 * sure TIFS removed the firewall before U-Boot tries to unlock CTRL_MMR
+	 * registers and continues the boot.
+	 */
+	get_ti_sci_handle();
+}
+
 void k3_sysfw_print_ver(void)
 {
 	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 37ff98d89924..146b986febc6 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -38,6 +38,7 @@ void disable_linefill_optimization(void);
 int remove_fwl_region(struct fwl_data *fwl);
 void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
 int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
+void k3_sysfw_wait_ready(void);
 void k3_sysfw_print_ver(void);
 void k3_dm_print_ver(void);
 void spl_enable_cache(void);

-- 
2.56.0

