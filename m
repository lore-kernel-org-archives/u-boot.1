Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48487606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y0V8OkIW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LQ9uzKwY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 242C240FD0;
	Sun, 25 Oct 2026 14:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AXe0NZoUB89q; Sun, 25 Oct 2026 14:30:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7207B40FCD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792938639;
	b=iNGsLT8YfRbfNnbVxnUvcprFZ3ub8vTnnjr3qGuNgI5oL9kGX+A2HYuBau1Hbp24Mcxf
	 WB190zaO1Mym9w3mNRXpPWcZwm22BnbVBrIG/85JMN15NuQyyGLPR5Bl0yU6sC9k3uUld
	 QAkMzTAunafsMiD+TL6Fd22A3ZwS6cAftvoSA4xFZVbpBb4+MCAdjVbDUYT4K8IK22Bsm
	 uQnzUNowtMOS03b5guSwER9q1dLRvMvl4rrGe0ruwko+8TB/Uj+A7gIhDGqVGqd3jfaGt
	 8pE2CLK97DMW/F36JJahLSXGKqvfmuIKBb85J/pe6L3iILaJ0CdiemLr0hJpKFZo2sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792938639;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JMUq60y9/b9x0gXy8tKMU1n2kFD63aS5HJ44DuZMbAc=;
	b=ilB0Q84bLKCDK4pwJ+sK6+O+BRiFmCTcZqrQZZ1zCzGCS9IvnnFP2Bpjk2kl2Y61bLot
	 vxPjzds1XYeNJWOrc+hwLEeCu0NC3GphmkHgJYjyfDy8+ShKvY0QSn28fGfvoE062yZxi
	 MCBWxL1KmRg9FyOumkX2Dvbvwg2bPPGDLwNlRaxNIscYn3MRVTKTy79Fl7ykfFkYmWqh3
	 kvEfUxl8qvrc6zovv7ryKHwFeairQHNuy+fMtqqFZB3H/ijdZXma+RlJkVIeXgA31aMTK
	 X4+GtpwQqKf3vzK8lhU+zNy5nt4wc7Uc8iCmS9m2NfNSQAYmWoHo5jBF92nOppI+yaQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792938639;
	bh=JMUq60y9/b9x0gXy8tKMU1n2kFD63aS5HJ44DuZMbAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y0V8OkIWMfqkaGE7YQ+DklEg1NITWxUG/ssjlJEeZUWm0CVcVfaKM/Ezp/wbu9e8o
	 6IJv8LDfHiNuAgkRegU/r5LODeq2zu+Is54Qkiu5PXnXLCaNbqwL2mjS+034qXP+9X
	 I3+a1+HxqUKoOs8X/wQ5NeE06E9jScD0ToXB9Fl9P/01GoTqsqoMtV4PLcGLmC6fTm
	 F5VkdPJ15p8DH2vo6bJ0EdBzZoEZ8o+HL/5/VZ9o7oORphZEBdTcu4V6j+crwogqpJ
	 UpWAWcKv25/BXWUgotuEw/730VmB6NSek5jg66Blsq96TiT7Xt1PApkmlXW1xDQRhE
	 ftG0CarneESfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7207B40FCD;
	Sun, 25 Oct 2026 14:30:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D4884356
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9F11608BE
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gtNtXTo43PIo for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 14:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DFEEB60890
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792938638;
 b=TqYbtuSdvZFLrHM0zir2TjiUBAzFKlpKvZAI0t9WyyNJvdERejyjrsXguwUR2drk7Du8
 XeXYRNgFdwzGpPuHBgPfvhtYvplO3xriccDsz+2StP3h2EngDgOzOItkQH+mVOgmx0Wc/
 HXYra43L19deJV981pYWe/6w3QPf7sZHQ9h75v52pGDp0uNxEVlDjKy8RDyYTO+Z5jV4D
 sYCm80M5c3a5kALkd2TcQqDac/2FX109bj1Tr7x+4o3ihQu4Ei4Jxl5paBi2zhSdnsov1
 4xF6ey/qIzpKgG/Vyu0csPwlTpPOReMLGL372kG41fy2csgrFRiKPwRxyMR0uIxN+Ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792938638;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=JMUq60y9/b9x0gXy8tKMU1n2kFD63aS5HJ44DuZMbAc=;
 b=ZbGb/9Aqga9P5QPAe6ze9OjYca6XREMbCYc+NXs0SylbOab31f4wXrBlJD3Ft5Bl/Nyu
 H9vlG/01cOKjYdcSqVvIzadq3hm+eupl57TRnNbFrKlWoJiNLR3L/b8Fr+QpmSe7H8+sN
 TFJq6ULpO9McvN8pzNNAdzmtGJIXPU8RD2+QEh8YdhkZdXryEKaS0WtQ2sQ4jmUPabkEz
 iiMmPaK7eG1XHBxvC4JosDf7D1B1CXxzYm3hF+ZF7bcrWzDp5hJooe/Lrsh9wve5YWtVo
 TfKao8qi4HNPa0qNF6dxIwhTce+ySjjXyRVo9q8CP2y26K1YCk7QhMjKBAAatjSu7bw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LQ9uzKwY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a30; helo=mail-vk1-xa30.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LQ9uzKwY
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFEEB60890
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:30:37 +0000 (UTC)
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5eafaeb8684so795311e0c.3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 07:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792938636; x=1793543436;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JMUq60y9/b9x0gXy8tKMU1n2kFD63aS5HJ44DuZMbAc=;
 b=LQ9uzKwY+FCNsO2tHG4mREkpxUPXwYO89Vf9RbLUMHFRJZUNifCszoNWPg0dmlvfT1
 V2Lh7mOjWiz/G8gqQmElbu2Jc0IbNkB/EFecbU8N255F9IX1CZjUNLfEHhxQ4Kwiv9tm
 ClrNZnoLFmC52ZC7fujE1QStj843Y9Pg/Og+1I9jiKGQiJ3019X9duUiHcfXidq82r2k
 F7t/i+rFrgmxf7WP86exHpZF8d8QrBZVFetL1Zkoc+RHw7XuUsXcF2BsOggIgXG0nQsm
 gdoj41rgyri3NCdro3/fDIfqwXwymeqTA7puAwALD13YzMgd0TRkRUY75YzO1QtPzsxV
 hPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792938636; x=1793543436;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JMUq60y9/b9x0gXy8tKMU1n2kFD63aS5HJ44DuZMbAc=;
 b=27Sr41AoJB02pyhgB1H/LUhaup1wk3EW9dI5jwZ4eNdqxIESR7/WSzKwyYhNtNCxAZ
 +shdtBkPTRWuYGB8MbOPdgUOyzsh8SRqDYq5Mt+gsAe53HKwqWnXdV9umuX5vVa7qnx4
 WTa+/4daVPr+LQktaxuECbPlDsB4OHND5q3p6fnIXteFwpSN2UsPUnOACahLU+u5+sJ+
 yXIE1MYznBu7hpef9UPUPIqSBxQq420qWUkIuYHqDrp51U4x2RUx+zc8vl8mQFvhuX+/
 /DwrSr3Z/B/obHwCb9rMn/hnpX2Y3MVG9he/ggWxq3Q+MCxRI9flEQXKGLZGUhfKn1WV
 WMEA==
X-Gm-Message-State: AFq9FYIAuCHYMGkD5VTr5zFZXF7mTteavwYs7pMPwqneq3vvpserMA6n
 4rQOVBjxQy32lR6si23D9YFb5+W/prU+WoKTXrOlxVY6BERxS04jP5nt
X-Gm-Gg: AYBFou1uYvWJT65892/46DU1qXfuLoz1NxN4DAw0bUHEA1h/C12SAnZicsvJF5oNsWQ
 MVh4BsU+YX8VbXrjjv3gbMmUnT7WDDFsIHLgHKfmjFhBLgbuLFylyEd8K2SFz+A7dKZfOhgQnqc
 0PWRo7xkFUIvFcZ6bCBlek8W5kdtyGHg9EG/Hcbp7/VerDCAaw2UG7hOoAJ5+6A/21q7mjlx+WV
 +Y9QiN+hF6vlsOXqTdZHDXXVLSNFsDGJ9Ob06UtLkMIoFEv0ZLX1Qj0JohSjg3dXTnHh8f7sTy8
 rpCH4/hVMhB15l3npmVXnvnw/kyBZT1MWJRDqPyORD1W0g45tXGgSstKp67jnVbDtNpdWy8HDz9
 Dg36vG2sDizOx3JqPq4iCEbvMOPjQL1LRfxmP/Ta2Y+3ojS6+3DByqByVNB9xgp9zB6l41TlrEJ
 dHBSZV0BKlWL+/91nj2hAFAiPpjIeCJuE86Koxz9ODmi+1G1V/1BwTfdicitnJLaPRwbRO8DwoF
 2VexeIP1nrQC3pywZeY59jxGqCSID1FOoNzighdidsJF+ViprsAVhaQ6hl4ZoKJFkQtPHok
X-Received: by 2002:a05:6102:f86:b0:7b4:bdf5:9307 with SMTP id
 ada2fe7eead31-7ce5ce24986mr1001197137.30.1792938636414; 
 Sun, 25 Oct 2026 07:30:36 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ce5df73970sm4848621137.1.2026.10.25.07.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 07:30:36 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Sun, 25 Oct 2026 11:30:23 -0300
Subject: [PATCH v2 1/2] clk: sophgo: cv1800b: Add SG2000 compatible string
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261025-upstream-v1-milk-duo-s-v2-1-192b68915c92@gmail.com>
References: <20261025-upstream-v1-milk-duo-s-v2-0-192b68915c92@gmail.com>
In-Reply-To: <20261025-upstream-v1-milk-duo-s-v2-0-192b68915c92@gmail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 E Shattow <e@freeshell.de>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
X-Mailer: b4 0.14.3
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The upstream SG2000 devicetree (sg2000.dtsi) uses "sophgo,sg2000-clk" as
the clock controller compatible string. The clocks needed by U-Boot are
the same as on the CV1800, so the existing driver can be reused.

Add "sophgo,sg2000-clk" to the driver match table.

Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
---
 drivers/clk/sophgo/clk-cv1800b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index 248a69321fc1..93d71ad1c314 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -744,6 +744,7 @@ const struct clk_ops cv1800b_clk_ops = {
 
 static const struct udevice_id cv1800b_clk_of_match[] = {
 	{ .compatible = "sophgo,cv1800-clk" },
+	{ .compatible = "sophgo,sg2000-clk" },
 	{ },
 };
 

-- 
2.53.0

