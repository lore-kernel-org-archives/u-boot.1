Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EAEC55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EF39606DB;
	Mon,  3 Aug 2026 19:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W3MKoh3pX9m3; Mon,  3 Aug 2026 19:01:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 363976069D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785783683;
	bh=eIZM+ta8VifzvY2czaoKjN7nx8vbzUfMPaHpSrRHyJM=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=T55c7HYANF8NsLa/w2sNoMpa+dDHnJ9an9SGtnfGxYoLP2rjATqk4DtU604DAWty5
	 IpTZyNKTxtxyc6ouwDaxHpsfBUQSWvHEdo0rGd2MXZLKHmBqDIa/Vof/9rKR3JdaTZ
	 aAMiATafSp3MVehWlT+Gho6Uv2Q2L1svZM7WMoRIztDxvdBV/3CHOvTzNJhC6yvTf2
	 pbQzFXZCBBcRU7QZo57vWhAxQ1FF8zdBCVeZICcK9U5PNzPYkG6qmdN/gUV22DFYeM
	 NFK70FShuUgKOhn0EDuUdA6UzUHUQkYcUX7TtoIJLjZr9DIswf4qTgFtmkmd2VcmbC
	 oPOcayYncIf1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 363976069D;
	Mon,  3 Aug 2026 19:01:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 38231282
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29E674009A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5iehSogQa20D for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:01:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 57C7F4005A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57C7F4005A
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57C7F4005A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:01:20 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6acad9fa466so1833233eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785783679; x=1786388479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eIZM+ta8VifzvY2czaoKjN7nx8vbzUfMPaHpSrRHyJM=;
 b=TkNEhESxDVBtJ3SgEMk11gvBqIsXDvr/fmL0RszQtEJnwQw+dB6LqRPD14E1wsAnwS
 YGhDIkWTWWGJXBlIUsIh1kllnuhxv1uof7s9lChV2SReJgS8frqiviUgOR4zXBjTnd7R
 +Tz0xCLVZn7C761iuEDKlJMdylGjIpEu2td2Z9YlpLDAMGnC0OKUOKePNvlsx7vdAEjy
 U+5NpE5Yqx0SNt1Fqi+0FsMj2abs+bkcIAum2RBxcUIdbXhqK9xiwrXw1lxuhRqPh4SF
 UMYKX/HEe/5HfZK8FXskszYD3pdwiwB5llXjo9AS166JFbMw2yKO3qzsCQGmtvMKsDbQ
 pVqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpW5GgaKC21M6MWvEhuz3VVFYXQDxl0oZU9qoNh6feG79rlncRHuwkKM6QmAFAFjuSnSiY2vE4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx1LG95fg25Nf8I9JAkPRHU45GLgxT6LbRObGSofryvcBZjqisR
 4UpfiLnpWVCFaGNOmTfH+EJsYP07KBqXDfERPRhw1r6UXfEyNewoXyTkrVQFpzbebK4=
X-Gm-Gg: AR+sD11XL/PDSX7tFYP4FhELmKrW4OUpH3bip1oQLosIxAmFTrpwbcNje389jvcR9nF
 ts7sRBVIkU8bJ8vRqMhGCZzE6mV8QPXDxNrp03xYpTA1cnFrOZbVvcA2sSSgKiFeimvoKXmw66t
 eNRgk3QLoFjh6jMUAyAEm6o5f32babrD8txLsbeZC+VIFkL1wf8D2l80idRyrd+4BP+xsQhwZvg
 t0092HK/hUIj2UgevJFYetsDL5s7Ba9qXA4zY5Fqsz/DGqhKKLGmC2q/E8YYGKbyJtM/FIXYwf0
 AxLxD8vVL8HL6cFlIFPBAo9ALNUqkN6UiRiuzu+ApMhNj+Tr/hPKEIu2UDBrmfHZxk3PD17GH8M
 pEYW27/9g1GbT+e8csxSgcNwx74gZy4rwAw82HV5jFigkeHfDhS7xYJQxrMPkniWrf2GD5m8Y9k
 LjTk6JsHhTK0d5I9rOfUK3T5KJYMg11q96zcGI7LPyC0wTq9LG8Ggf/AdqOPZXRRFo2baWSzyjp
 1cvxZQjoIlc13f3x9p8CWatz17Lu4lNdSQZ0nQ=
X-Received: by 2002:a05:6820:7082:10b0:6ac:b1ae:6ce2 with SMTP id
 006d021491bc7-6ae433386bemr12014751eaf.24.1785783679125; 
 Mon, 03 Aug 2026 12:01:19 -0700 (PDT)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae39db1c5bsm7034401eaf.5.2026.08.03.12.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 12:01:18 -0700 (PDT)
Date: Mon, 03 Aug 2026 14:00:35 -0500
Subject: [PATCH 2/2] spi: dw: Add supports_op function to reject
 unsupported transfer modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-spi_fixes-v1-2-33f36e764104@oss.tenstorrent.com>
References: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
In-Reply-To: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Ssunk <ssunkkan@gmail.com>, Jeffrey Yu <jeyu@issi.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1785783679; x=1786388479;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eIZM+ta8VifzvY2czaoKjN7nx8vbzUfMPaHpSrRHyJM=;
 b=MUPy4oCs2bNrYln0GQgWlpyfvqFilzdaiQFmwvbLrQilUVGTe6xQLBi1rkpY8+8Gzy
 pL7re0qXkrdCXAy6odVvE5wKCdDSMv8Y7PPLOtO0fVJqRE1/sx84psQy83L1/sT0Poz6
 WALo81PSGCpF2PsBB6vuKR2F1ic4DOKMTAhJCa7qZn+EC4Wc/G+YzoZkLUtHYAxWRhCv
 eRXTXZSPmA29BzeQrrYB9ofnwkyqZVHnuyqkPjK8UD693quK5b0X9eRf84CwBrRgwhtv
 SVLNQjhUB/ItHGjXE/8bSO2Cewc8t91sNh1VvJT+Ax5pBwfFWIosekizURRUsKqi/g8M
 PM8g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=MUPy4oCs
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
From: Anirudh Srinivasan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The designware spi driver doesn't support dual/quad/octal modes, but
the driver still tries using these modes when it sees a capable flash
chip in the devicetree. Add a supports_op function to this driver to
prevent this from happening and force single lane operation.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/spi/designware_spi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index 0df9a4f5abd..2f6dbeb1d94 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -694,8 +694,22 @@ static int dw_spi_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op)
 	return 0;
 }
 
+/*
+ * This driver only supports 1-1-1 transfers. Reject all other modes.
+ */
+static bool dw_spi_supports_op(struct spi_slave *slave,
+			       const struct spi_mem_op *op)
+{
+	if (op->cmd.buswidth > 1 || op->addr.buswidth > 1 ||
+	    op->dummy.buswidth > 1 || op->data.buswidth > 1)
+		return false;
+
+	return spi_mem_default_supports_op(slave, op);
+}
+
 static const struct spi_controller_mem_ops dw_spi_mem_ops = {
 	.exec_op = dw_spi_exec_op,
+	.supports_op = dw_spi_supports_op,
 	.adjust_op_size = dw_spi_adjust_op_size,
 };
 

-- 
2.43.0

