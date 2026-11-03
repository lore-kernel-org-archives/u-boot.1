Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB9606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n0MsntyQ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=i++Guk4H
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0AA3407FB;
	Tue,  3 Nov 2026 13:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mWkmiuicEDZ1; Tue,  3 Nov 2026 13:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 263444071F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711118;
	b=iznrsJFz2x+vDnDN7VMI88lgsWcxPYXMGgkS1R1w2fMS0MtQVuwEA/vBRee48AWzC1RO
	 T+SKp5y+JMX64SsyrCyBDGVKVgk5Jaj5cFhD1Zxqcg9dlXfRIrrAlREC/ZWF97O55TY1N
	 wGy0O7iQd16elQNUOI67U/bLbxwGyddc+5P0Uy/vb0+sj6oU5Dv6Vz/pxuHLYHeSKZZ+l
	 CRgJbRi3GyKYvCPTuTd9Gy7e8GZgciba61PwwcPOTWFYqzECBFOtM9Hhdukx0UJVGLEXK
	 cgEPfMLt5aU+zoogksZuJTqpSivrndLaBMxa08Qg5daJoVpgxqzVjbUDvPmwIW/itfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711118;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UV9v+Y9yweOKthUBbTlH/nL7th+3SQLiOJdZaL541Hg=;
	b=qd/egRloObsC0ZVXGJAmDUYoRQfeUYhelB0LcBHej9XE3Wa/wyTAE+IekCYiYyTRmCau
	 xt2J+nS7yHLXxDJDleke4pMwFUUbrpWZviE0fzx8QJAs07wVh45n8i83sd4uugHxqWlN2
	 bXi8aDC5dsjCNAJeUuB3zwF2/O6sr5EjQcu0nXje+Vur0sppQjEdhLX7dH7qp06m0jCJm
	 7ErqT9UK1H9VzOv0v0CUQeC8oPRqiQzyqucRfIjtJ48VlD13T71HEFzI08/B3K0f1RmJN
	 f0B6N669obBhOFUbJyVqR1GXAyLNNeDGvhSRYGbiWYCpuSrvW0Of2n3peVzvWPzu1Tg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=i++Guk4H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711118;
	bh=UV9v+Y9yweOKthUBbTlH/nL7th+3SQLiOJdZaL541Hg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n0MsntyQvbx6T/hVtiP/+Omo/EX5igbkjkRD1pRM/k6WP7azZz6u1Rf0AKBtlPDk/
	 6dCexRSka8dA0GbnOkqI1dEPd03LCp4tkKWQQyiJ6UzM4SrMZJ/T37gX3tWP+PnskO
	 5xcHof9TSPre9XbkWfBuyjQBHM+TSd7/qrPhGYrj01oadvW0Y5jphXKilLSQkdYJcs
	 w/rQ88aVzkQq7X430sM7FDz3vh4v83wpYPQAogfvM5XjBvSZ/oZNOZn25s18hPSg0K
	 hv3hRaYBVwdJE2CyKdNUFN4EKY4DJpF4OGL509ZaULFXQV4p7X4qIbq/D5RwxjcawQ
	 1YN0S9uUzChew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 263444071F;
	Tue,  3 Nov 2026 13:05:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F372E435
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E536A405CD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 12gsNjExxoA6 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04219405A7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699925;
 b=HdafAmjb0Fm3v/qtYeGJcCds5Nf6X7YnwHNP6Newt0PWm/255PT+oln07JOLfVMT0SN3
 ZWR0s0iT4gGLS26XSB1pK7koNLD/YhMBCDCC93BNm7oOM1Ghjcj2SQGH8jAQBmzNo3iQg
 2Mn3fOg1b6SBd6UY4kRqIcwKpPDxdBpUud3GoKs5XMZFq3MUlndOFwCL/FDbRPfiXAxg8
 iYwTV5TSUNc1r/AOeoMAf8JFkN2KOeRbIq2Yeya56BwdZ+v8RMEb3hnsyCawwR8DZtCUX
 SEKyLUOP0XcDIJqJGl4/nwzh/MfuH0v3GmQuoTmvDEIMqyPbK2zKt0sZQRdKeDaO2xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699925;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=UV9v+Y9yweOKthUBbTlH/nL7th+3SQLiOJdZaL541Hg=;
 b=eoTVLDMClgACx9wUf5kUZju/VW4SA6Zqd9sTDNsPVZ9mtAdKAISoo0yhmregVSpk7/WU
 0DKka001Atv/EhXZC6U+3yc2O36NUeZvluJ0vPl3gGz2+D+6agK0Ps88ulutnefE2cWu7
 /CXNc9dcgLKpzSyCPcDVS6B6tRQY/ofWjx6XVdC+M5Qo5hb2vYQ2XJBPBRRHYMvnkvjSM
 oGPrtOL6hd8GK6c0wSLV4CjGCtt6na6I91JWyEq0kMbL24AqfqZilDPqyoHCavft225vE
 pazEic4BzlYURQ9/lvb8WirTvwWpMV0q4DX89H3yDAJbyDKrXCL9YX4a9HoYXralL5w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=i++Guk4H; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=i++Guk4H
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04219405A7
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:44 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso26193825e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699922; x=1794304722;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UV9v+Y9yweOKthUBbTlH/nL7th+3SQLiOJdZaL541Hg=;
 b=i++Guk4HWvp1kRjS6XGAyDiMhxtXedWkaiKmC5nl0W8fyjwNWyEOBwcbYH4cabr22+
 gKa8fLMMRQs4ICM/mg6JsU5HjqeNZrVhox+cGwYsjelB3VLk6wk45b3sq0SFfucN3yvk
 zV9eJgVwHrkrl413+LsD7b0EQa5j8S6nmWjEn4vEB3lsTDvGAIrqXRvDwFrWxbtFW3kn
 LAZCFPXLONZV0HCtqqF+d0KNeunMwhxK7KR7mPP5bYTMB/6wwyvOrms+D2t7jzZ2bsDc
 rTqCJGbg8fZ17T6iOV+wVV+4H5W3cpUgZcFWEwuufWp31R3BBDe8TP5siMuvmz/Bq3N4
 /B/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699922; x=1794304722;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UV9v+Y9yweOKthUBbTlH/nL7th+3SQLiOJdZaL541Hg=;
 b=TG+Ie4wtm3Fpxr83L4oUYPIgmDz64DACKqj9lJF85+s8xN4rlt2T+MUnvssfO87xBL
 h0xs2rbjRwIIgKDIZ+n21kg7t2mopgtEjS2wF9KLLINEobh62Ug2MnUa5tsaQGMfCDeE
 2ZDJm5QsYNnBQ6WHasamU3Ah3ABaMHV/v+dCyp+ntcPEZRNtOQwYYun6MoAFssfx6sJe
 UGHKMnwByGX91RHFEBQL5r7zJEQu2XteplbLb6QKEfueOcNFqHbZAOuxdho0KJoUl1Et
 lpXBKYstgbm4RBlJ8AJDFGL4fsK2xYT3NHut0EeHBevzL/R/X5SJPtzvUAVO6b/R+4hX
 /ASQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx76sJz3ayIUCHVK6hNZ8y7IFUMkoAhghlZRNEs29CpzxsroB5Yqg+hlXF1D1IVDQcllv55dQo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/qHlMebh2Umu1o1XmMtwPTdxdz6Lxxfvhf3U35dV1abLtnQ4FR
 KADw1xIGQy/1w5mtIJGlo3r1GuasVGPA44SxMdkO1jRAFlqEB/+lMw0n8f1h/lZSyGE=
X-Gm-Gg: AYBFou1f+QToYMtr18eVUlVTRBlF5sxc99fxSf2VgF2cNIo7uCwByrlreZOR4M8MsyG
 UQaQlZpQ8Fs1RGLYTzMlbHAd5Dsy5JvMOK2wDkfVOIXBRxYKAT8S3JpgRWL885vIZUjenH2d76u
 EfSP1eQeCzacSuj4kqu3jP4UpRUQ2AMjf9eJ/yRgxzFIM+/GiXE0BtbieYxziPnUFbc56v09Kb/
 h1gqRktZvj0D7jbhlZwrAB2Ije1HoE5xmAinX1pkNUQo9ukEaGYDLp4SV/I7xDoThxep5cyS1+p
 qTOz4hov4wSAMuySCqrVqKrCI9tgRu2y+9lVGzqe0O1VGV4R8yBGIZi9fr8f2kEalODfX4cDctJ
 CmRXtaawiZNhdn5Uk90x78N+3dhe/g4rAUFevz3MPs+9auN8DthWnZh0Dv/168aGSaFDWePE9wr
 YTzpO+jwck+ZEV9cS5vyrX8qXC2p7NwVZEj88g4gmcjk1YQfXgGXZBg1osuoGOY6tOMgcnYrb4J
 WHdd7HYTBYdaS+dHBL4jPoNEVHd5XvhVmmhR85h58rw2uY2EpzU9QAc+lLng4JIvDZsmimBHVlr
 nrv3gVB/ReBlZBNOmb9T7nW08Q==
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id
 5b1f17b1804b1-4ac187a6960mr285228635e9.27.1793699922442; 
 Tue, 03 Nov 2026 01:58:42 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a93232f0sm46645755e9.10.2026.11.03.01.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:42 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:56 +0100
Subject: [PATCH v10 10/24] arm: mach-k3: Kconfig: Add symbol for IO+DDR Low
 Power Mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-10-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=msp@baylibre.com;
 h=from:subject:message-id; bh=D113kGVQ82O01TziiGpvy3w0tt63EO1tL+AFqBpfxrg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX679bBD26fzlDvFRk1q8XJ1kKbisJbFo2xc3g0LLlE
 asDZovt6yhlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJzJZj+J/IrcvudnWNVo3C
 Xm+nVU+tljn6mF1mWnvz21Jt3ri7jvqMDG0aL8OPJ1rPV/obt1Fcq/9P/rZWUxfTa2vc/Ju/ugj
 M4QYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Symbol to enable support to resume from IO+DDR where the SoC is turned
off and DDR is in self-refresh. Disable support for K3_INLINE_ECC for
now.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-k3/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683f..72660864126b 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -165,6 +165,15 @@ config K3_DM_FW
 	  bootloader, it makes RM and PM services not being available
 	  during R5 SPL execution time.
 
+config K3_IODDR
+	bool "Enable IO+DDR Low Power Mode support"
+	depends on SPL && K3_AM62A_DDRSS && !K3_INLINE_ECC
+	depends on SOC_K3_AM62A7 || SOC_K3_AM62P5
+	help
+	  Enable support for IO+DDR Low Power Mode. If this is enabled and a
+	  resume from IO+DDR is detected, metadata in the DDR is used to
+	  restore TIFS and resume DM.
+
 config K3_X509_SWRV
 	int "SWRV for X509 certificate used for boot images"
 	default 1

-- 
2.55.0

